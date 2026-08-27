local BattleDungeonController = class("BattleDungeonController")
local ChipData = require("Game.PlayerData.Item.ChipData")
local Messenger = require("Framework.Common.Messenger")
local BattleDungeonSceneCtrl = require("Game.BattleDungeon.Ctrl.BattleDungeonSceneCtrl")
local BattleDungeonBattleCtrl = require("Game.BattleDungeon.Ctrl.BattleDungeonBattleCtrl")
local BattleDungeonObjectCtrl = require("Game.BattleDungeon.Ctrl.BattleDungeonObjectCtrl")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function BattleDungeonController:ctor(dungeonData, enterMsgData, formationData)
  self.ctrls = {}
  self.isGuide = false
  self.__dungeonLogicMessage = Messenger.New()
  self.__cacheDungeonLogic = {}
  if dungeonData.dungeonId == GuideManager.firstBattleGuideCtrl.guideDungeonId then
    self.battleGuideType = GuideManager.firstBattleGuideCtrl.battleGuideType
    local BattleDungeonGuideBatteCtrl = require("Game.BattleDungeon.Guide.BattleDungeonGuideBatteCtrl")
    self.battleCtrl = BattleDungeonGuideBatteCtrl.New(self, self.battleGuideType)
    local BattleDungeonGuideObjectCtrl = require("Game.BattleDungeon.Guide.BattleDungeonGuideObjectCtrl")
    self.objectCtrl = BattleDungeonGuideObjectCtrl.New(self, self.battleGuideType)
    self.isGuide = true
  else
    self.battleCtrl = BattleDungeonBattleCtrl.New(self)
    self.objectCtrl = BattleDungeonObjectCtrl.New(self)
  end
  self.sceneCtrl = BattleDungeonSceneCtrl.New(self)
  self.battleNetwork = NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)
  self:__InitDungeonCtrl(dungeonData, enterMsgData, formationData)
end

function BattleDungeonController:__InitDungeonCtrl(dungeonData, enterMsgData, formationData)
  self.dungeonData = dungeonData
  self.enterMsgData = enterMsgData
  self.dungeonId = dungeonData.dungeonId
  self.dungeonCfg = ConfigData.battle_dungeon[self.dungeonId]
  if self.dungeonCfg == nil then
    error("battle dungeon cfg is null,id:" .. tostring(self.dungeonId))
  end
  local lastDeployData = BattleDungeonManager:GetLastDungeonDeploy()
  if enterMsgData ~= nil then
    for index, battleRole in pairs(dungeonData.role) do
      if battleRole.stc.dataId == enterMsgData.astHeroId then
        battleRole.roleType = proto_object_EplBattleRoleType.BattleRoleFriendAssist
        break
      end
    end
  end
  if self.dungeonCfg.dungeon_type == proto_csmsg_DungeonType.DungeonType_TD then
    local TowerDefenceDynPlayer = require("Game.BattleDungeon.Data.TdDungeonDynPlayer")
    self.dynPlayer = TowerDefenceDynPlayer.CreateTdDungeonPlayer(dungeonData.role, dungeonData.player, self.dungeonCfg, lastDeployData, dungeonData.treeId)
  elseif self.dungeonCfg.dungeon_type == proto_csmsg_DungeonType.DungeonType_GuardianProfessor then
    local GuardDungeonDynPlayer = require("Game.BattleDungeon.Data.GuardDungeonDynPlayer")
    self.dynPlayer = GuardDungeonDynPlayer.CreateGuardDungeonPlayer(dungeonData.role, dungeonData.player, self.dungeonCfg, lastDeployData, dungeonData.treeId)
  else
    local DungeonDynPlayer = require("Game.BattleDungeon.Data.DungeonDynPlayer")
    self.dynPlayer = DungeonDynPlayer.CreateDungeonPlayer(lastDeployData, BattleDungeonManager.dunInterfaceData:GetDunFormationRuleCfg())
    self.dynPlayer:InitDunDynPlayer(dungeonData.role, self.dungeonCfg, dungeonData.player, dungeonData.treeId)
  end
  self.dynPlayer:InitDynPlayerChip(dungeonData.algData)
  self.dynPlayer:UpdateDungeonBuff(dungeonData.buffGroup)
  self.dynPlayer:UpdataDynFairyData(dungeonData.fairy)
  self.dynPlayer:InitDynSpecEffect(dungeonData.epEffect)
  if self.dungeonId == GuideManager.firstBattleGuideCtrl.guideDungeonId then
    self.dynPlayer:InitPlayerSkillCustom(formationData.userSkill, formationData.cstId)
  end
  if dungeonData.player ~= nil then
    self.dynPlayer:InitDynPlayerAttr(dungeonData.player.stc)
  end
end

function BattleDungeonController:Start()
  self._waitFirstLoadScene = true
  self.sceneCtrl:EnterDungeonScene(self.dungeonData.wave, function()
    if self._afterEnterSceneExit then
      BattleDungeonManager:RetreatDungeonNoReq()
      return
    end
    local epWindow = UIManager:ShowWindow(UIWindowTypeID.DungeonStateInfo)
    epWindow:InitHeroAndChip(self.dynPlayer)
    local unlockChipSuit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TagSuit)
    if unlockChipSuit then
      local epSuitWindow = UIManager:ShowWindow(UIWindowTypeID.EpChipSuit)
      epSuitWindow:InitEpChipSuit(self.dynPlayer)
      epSuitWindow:RefreshChipSuitSimpleUI()
      self.__onChipSuitUpdate = BindCallback(self, self._RefreshChipSuitItemPreview)
      MsgCenter:AddListener(eMsgEventId.OnEpChipSuitUpdate, self.__onChipSuitUpdate)
    end
    self:StartRunNextLogic()
    self:ShowDungeonBuffAndChip()
    self._waitFirstLoadScene = false
  end)
end

function BattleDungeonController:DungeonIsInWaitFirstLoadScene()
  return self._waitFirstLoadScene
end

function BattleDungeonController:SetDungeonAfterEnterSceneExit()
  self._afterEnterSceneExit = true
end

function BattleDungeonController:ExitBattleDungeon(battleWin, notNeedWinEvent)
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local param1 = battleWin and 2 or 3
  avgPlayCtrl:TryPlayTaskAvg(param1, function()
    if self.battleGuideType ~= 1 then
      BattleDungeonManager:ExitDungeon(battleWin, true)
    end
  end)
  if battleWin and not notNeedWinEvent then
    local winEvent = BattleDungeonManager:GetBattleWinEvent()
    if winEvent ~= nil then
      winEvent()
    end
  end
end

function BattleDungeonController:StartRunNextLogic()
  if self:__TryRunTopLogic() then
    return
  end
  self.__runLogicTimerId = TimerManager:StartTimer(1, self.__TryRunTopLogic, self, false, true)
end

function BattleDungeonController:__TryRunTopLogic()
  if #self.__cacheDungeonLogic > 0 then
    TimerManager:StopTimer(self.__runLogicTimerId)
    local logicData = table.remove(self.__cacheDungeonLogic, 1)
    self.__dungeonLogicMessage:Broadcast(logicData.logicType, logicData.logicContent)
    if logicData.logicFunc ~= nil then
      logicData.logicFunc()
    end
    return true
  end
  return false
end

function BattleDungeonController:AddDungeonLogic(logicType, msgData, func)
  local logicCacheData = {
    logicType = logicType,
    logicContent = msgData,
    logicFunc = func
  }
  table.insert(self.__cacheDungeonLogic, logicCacheData)
end

function BattleDungeonController:RegisterDungeonLogic(logicId, action)
  self.__dungeonLogicMessage:AddListener(logicId, action)
end

function BattleDungeonController:UnRegisterDungeonLogic(logicId, action)
  self.__dungeonLogicMessage:RemoveListener(logicId, action)
end

function BattleDungeonController:CalculateBloodGrid(monsterList)
  local heroDic = self.dynPlayer.heroDic
  local maxHp, minHp
  for id, dyHero in pairs(heroDic) do
    local hp = dyHero:GetRealAttr(eHeroAttr.maxHp)
    maxHp = maxHp == nil and hp or math.max(maxHp, hp)
    minHp = minHp == nil and hp or math.min(minHp, hp)
  end
  for id, monsterRole in ipairs(monsterList) do
    local hp = monsterRole:GetRealAttr(eHeroAttr.maxHp)
    maxHp = maxHp == nil and hp or math.max(maxHp, hp)
    minHp = minHp == nil and hp or math.min(minHp, hp)
  end
  self.unitBlood, self.bossUnitBlood, self.bloodGridMax = BattleUtil.CalculateBloodGrid(maxHp, minHp)
end

function BattleDungeonController:_RefreshChipSuitItemPreview()
  local win = UIManager:GetWindow(UIWindowTypeID.EpChipSuit)
  win:RefreshChipSuitSimpleUI()
end

function BattleDungeonController:ShowDungeonBuffAndChip()
  self._firstChipEvent = nil
  if #self.dungeonCfg.enter_chip_select > 0 then
    self._firstChipIndex = 1
    self._firstChipEvent = BindCallback(self, self.DungeonFirstSelectChip)
  end
  local isAuto = BattleDungeonManager.autoCtrl:IsEnbaleDungeonAutoMode()
  local buffList, buffCfgList = self.dynPlayer:GetDungeonBuff()
  if not isAuto and buffList ~= nil and 0 < #buffList then
    local showBuffList = {}
    for _, buffCfg in ipairs(buffCfgList) do
      if not buffCfg.is_hide then
        table.insert(showBuffList, buffCfg)
      end
    end
    if 0 < #showBuffList then
      UIManager:ShowWindowAsync(UIWindowTypeID.EpBuffDesc, function(win)
        win:InitDunBuffDesc(showBuffList, self._firstChipEvent)
      end)
      do
        local stateInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
        if stateInfoWin ~= nil then
          stateInfoWin.buffList:InitBuffList(self.dynPlayer:GetDungeonBuffDataList())
          stateInfoWin:SetBuffListActive(true)
        end
        return
      end
    end
  end
  if self._firstChipEvent ~= nil then
    self._firstChipEvent()
  end
end

function BattleDungeonController:DungeonAbleSelectChip()
  return #self.dungeonCfg.enter_chip_select > 0
end

function BattleDungeonController:DungeonRestartSelectChip()
  self.battleNetwork:CS_BATTLE_OpeningAlgSelect(0, function(dataList)
    self._firstChipIndex = 1
    self:DungeonFirstSelectChip()
  end)
end

function BattleDungeonController:DungeonFirstSelectChip()
  if self.dungeonCfg == nil then
    return
  end
  if self._firstChipIndex > #self.dungeonCfg.enter_chip_select then
    return
  end
  local chipGroup = self.dungeonCfg.enter_chip_select[self._firstChipIndex]
  local rewardChipList = {}
  for k, chipId in ipairs(chipGroup.chip_ids) do
    local chipCount = chipGroup.chip_lvs[k]
    local chipData = ChipData.NewChipForLocal(chipId, chipCount)
    rewardChipList[k] = chipData
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.SelectChip, function(window)
    if window == nil then
      return
    end
    MsgCenter:Broadcast(eMsgEventId.OnSettleMentTimeLinePlayToEnd)
    window:InitSelectChip(false, rewardChipList, self.dynPlayer, BindCallback(self, self.__SelectChipComplete), nil, false, nil)
  end)
end

function BattleDungeonController:GetBattleRoom()
  if self.battleCtrl ~= nil then
    return self.battleCtrl.battleRoomData
  end
  return nil
end

function BattleDungeonController:__SelectChipComplete(index, selectComplete)
  if self.dungeonCfg == nil then
    return
  end
  local chipGroup = self.dungeonCfg.enter_chip_select[self._firstChipIndex]
  local chipId = chipGroup.chip_ids[index]
  self.battleNetwork:CS_BATTLE_OpeningAlgSelect(chipId, function(dataList)
    if selectComplete ~= nil then
      selectComplete()
    end
    self._firstChipIndex = self._firstChipIndex + 1
    self:DungeonFirstSelectChip()
  end)
end

function BattleDungeonController:OnDelete()
  TimerManager:StopTimer(self.__runLogicTimerId)
  if self.__onChipSuitUpdate ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.OnEpChipSuitUpdate, self.__onChipSuitUpdate)
    self.__onChipSuitUpdate = nil
  end
  for k, v in pairs(self.ctrls) do
    v:OnDelete()
  end
  self.ctrls = nil
end

return BattleDungeonController
