BattleDungeonManager = {}
local BattleDungeonController = require("Game.BattleDungeon.BattleDungeonController")
local BattleDungeonAutoCtrl = require("Game.BattleDungeon.Ctrl.BattleDungeonAutoCtrl")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")

function BattleDungeonManager:__Init()
  self.__inDungeon = false
  self.autoCtrl = BattleDungeonAutoCtrl.New()
end

function BattleDungeonManager:IsInTDDungeon()
  if not self:InBattleDungeon() then
    return false
  end
  local ctrl = self:GetDungeonCtrl()
  if ctrl == nil then
    return false
  end
  local dungeonCfg = ctrl.dungeonCfg
  if dungeonCfg == nil then
    return false
  end
  if dungeonCfg.dungeon_type == proto_csmsg_DungeonType.DungeonType_TD then
    return true
  end
  return false
end

function BattleDungeonManager:IsInBrotatoDungeon()
  if not self:InBattleDungeon() then
    return false
  end
  local ctrl = self:GetDungeonCtrl()
  if ctrl == nil then
    return false
  end
  local dungeonCfg = ctrl.dungeonCfg
  if dungeonCfg == nil then
    return false
  end
  if dungeonCfg.dungeon_type == proto_csmsg_DungeonType.DungeonType_Brotato then
    return true
  end
  return false
end

function BattleDungeonManager:IsInGuardDungeon()
  if not self:InBattleDungeon() then
    return false
  end
  local ctrl = self:GetDungeonCtrl()
  if ctrl == nil then
    return false
  end
  local dungeonCfg = ctrl.dungeonCfg
  if dungeonCfg == nil then
    return false
  end
  if dungeonCfg.dungeon_type == proto_csmsg_DungeonType.DungeonType_GuardianProfessor then
    return true
  end
  return false
end

function BattleDungeonManager:InBattleDungeon()
  return self.__inDungeon
end

function BattleDungeonManager:RequestEnterDungeon(stageId, formationData, interfaceData, callBack, firstPower, benchPower)
  if self.__dungeonNetworkCtrl == nil then
    self.__dungeonNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)
  end
  local activateDrop = interfaceData:GetDIDExtraDrop()
  local activateDecompose = interfaceData:GetAutoDecompose()
  self.__dungeonNetworkCtrl:CS_BATTLE_DungeonEnter(stageId, formationData, activateDrop, function(dataList)
    if dataList.Count == 0 then
      return
    elseif dataList.Count ~= 2 then
      error("CS_BATTLE_DungeonEnter callback data error")
      return
    end
    local EnterMsgData = dataList[0]
    local NtfEnterMsgData = dataList[1]
    self:RealEnterDungeon(NtfEnterMsgData, EnterMsgData, interfaceData)
    NetworkManager:HandleDiff(NtfEnterMsgData.syncUpdateDiff)
    if callBack ~= nil then
      callBack()
    end
  end, firstPower, benchPower, activateDecompose, interfaceData)
end

function BattleDungeonManager:RequestEnterDungeonGroup(actLongId, dungeonId, moduleId, formationData, interfaceData, callBack)
  if self.__dungeonNetworkCtrl == nil then
    self.__dungeonNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)
  end
  self.__dungeonNetworkCtrl:CS_Activity_DungeonGroup_Enter(actLongId, dungeonId, moduleId, formationData, function(dataList)
    if dataList.Count == 0 then
      return
    elseif dataList.Count ~= 2 then
      error("CS_Activity_DungeonGroup_Enter callback data error")
      return
    end
    local EnterMsgData = dataList[0]
    local NtfEnterMsgData = dataList[1]
    self:RealEnterDungeon(NtfEnterMsgData, nil, interfaceData)
    NetworkManager:HandleDiff(NtfEnterMsgData.syncUpdateDiff)
    if callBack ~= nil then
      callBack()
    end
  end)
end

function BattleDungeonManager:RealEnterDungeon(NtfEnterMsgData, EnterMsgData, interfaceData)
  if self:InBattleDungeon() then
    self:ClearBattleDungeon()
  end
  if interfaceData == nil then
    interfaceData = DungeonInterfaceData.CreateDefaultBattleInterface()
  end
  self:BindDungeonInterface(interfaceData)
  return self:__EnterDungeon(NtfEnterMsgData, EnterMsgData)
end

function BattleDungeonManager:BindDungeonInterface(interfaceData)
  self.dunInterfaceData = interfaceData
end

function BattleDungeonManager:__EnterDungeon(dungeonData, EnterMsgData)
  if self.__formationData == nil then
    error("formation Data is null,can't to start battle dungeon")
    return nil
  end
  self.__inDungeon = true
  self.__dungeonId = dungeonData.dungeonId
  local dungeonCtrl = BattleDungeonController.New(dungeonData, EnterMsgData, self.__formationData)
  self.dungeonCtrl = dungeonCtrl
  UIManager:DeleteAllWindow()
  dungeonCtrl:Start()
  return dungeonCtrl
end

function BattleDungeonManager:GetDungeonCtrl()
  return self.dungeonCtrl
end

function BattleDungeonManager:GetDungeonDynPlayer()
  if self.dungeonCtrl == nil then
    return
  end
  return self.dungeonCtrl.dynPlayer
end

function BattleDungeonManager:GetIsGuide()
  return self.dungeonCtrl.isGuide
end

function BattleDungeonManager:GetFixedCSTInfo()
  if not BattleDungeonManager:InBattleDungeon() then
    return
  end
  return ConfigData:GetFixedCstSkillsDun(self.__dungeonId)
end

function BattleDungeonManager:AddDungeonLogic(logicType, msgData)
  if not self:InBattleDungeon() then
    return
  end
  self.dungeonCtrl:AddDungeonLogic(logicType, msgData)
end

function BattleDungeonManager:SaveFormation(formationData)
  self.__formationData = formationData
end

function BattleDungeonManager:GetFormation()
  if self.__formationData ~= nil then
    return self.__formationData
  end
end

function BattleDungeonManager:InjectBattleWinEvent(winEvent)
  self.battleWinEvent = winEvent
end

function BattleDungeonManager:GetBattleWinEvent()
  return self.battleWinEvent
end

function BattleDungeonManager:ClearBattleWinEvent()
  self.battleWinEvent = nil
end

function BattleDungeonManager:InjectBattleExitEvent(exitEvent)
  self.battleExitEvent = exitEvent
end

function BattleDungeonManager:ClearBattleDungeon(isLogout)
  self.__inDungeon = false
  self.dunInterfaceData = nil
  if self.dungeonCtrl ~= nil then
    self.dungeonCtrl:OnDelete()
    self.dungeonCtrl = nil
  end
  if isLogout then
    self.battleExitEvent = nil
    self.autoCtrl:DungeonAutoReset()
  end
end

function BattleDungeonManager:RestartDungeon()
  local battleController = CS.BattleManager.Instance.CurBattleController
  if battleController ~= nil then
    battleController.LuaBattleCtrl:ReqRestartBattle(battleController)
  end
end

function BattleDungeonManager:RetreatDungeon()
  local battleController = CS.BattleManager.Instance.CurBattleController
  if battleController ~= nil then
    battleController.LuaBattleCtrl:ReqGiveUpBattle(battleController)
  end
end

function BattleDungeonManager:RetreatDungeonNoReq()
  local battleController = CS.BattleManager.Instance.CurBattleController
  if battleController ~= nil then
    battleController.fsm:ChangeState(CS.eBattleState.End)
    battleController.fsm.currentState:EndBattleAndClear()
  end
  self:ExitDungeon()
end

function BattleDungeonManager:TryExitDungeonAfterActEnd(interfaceType)
  if BattleDungeonManager:InBattleDungeon() then
    local dunInterfaceType = BattleDungeonManager.dunInterfaceData:GetInterfaceType()
    if dunInterfaceType == interfaceType then
      local dungeonCtrl = BattleDungeonManager:GetDungeonCtrl()
      if dungeonCtrl ~= nil and dungeonCtrl:DungeonIsInWaitFirstLoadScene() then
        dungeonCtrl:SetDungeonAfterEnterSceneExit()
      else
        BattleDungeonManager:RetreatDungeonNoReq()
        if Time.unity_time.timeScale ~= 1 then
          Time.unity_time.timeScale = 1
        end
      end
    end
  end
end

function BattleDungeonManager:ExitDungeon(isBatlleWin, withLoginVoice)
  self.autoCtrl:ExitDungeonAutoModel()
  self._lastMvpVoiceHeroId = nil
  self._lastVoiceId = nil
  if not self:InBattleDungeon() then
    return
  end
  AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_Character)
  AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_Monster)
  AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_SupSkill)
  AudioManager:RemoveCueSheet(eAuCueSheet.Battle_Buff)
  AudioManager:RemoveCueSheet(eAuCueSheet.CommonSkill)
  AudioManager:RemoveCueSheet(eAuCueSheet.Ambience)
  AudioManager:RemoveAllVoice()
  self:ClearBattleDungeon()
  BattleDungeonManager:ClearBattleWinEvent()
  UIManager:DeleteAllWindow()
  CS.UIManager.Instance:DeleteAllWindow()
  if self.battleExitEvent == nil then
    UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
    CS.GSceneManager.Instance:LoadSceneAsyncByAB(Consts.SceneName.Main, function(ok)
      ControllerManager:GetController(ControllerTypeId.HomeController, true):OnEnterHome()
      UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
        if window == nil then
          return
        end
        window:SetFrom2Home(AreaConst.Sector)
        if withLoginVoice then
          window.homeController:PlayLoginHeroGreeting()
        end
        local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
        if aftertTeatmentCtrl ~= nil then
          aftertTeatmentCtrl:TeatmentBengin()
        end
      end)
    end)
  else
    self.battleExitEvent(isBatlleWin)
    self.battleExitEvent = nil
  end
end

function BattleDungeonManager:GetLastDungeonDeploy()
  if self.dunInterfaceData == nil or not self.dunInterfaceData:IsNeedRecordFormation() then
    self.__lastDeployData = nil
    return
  end
  local lastDeployData, dungeonStageData
  dungeonStageData = self.dunInterfaceData:GetIDungeonStageData()
  if dungeonStageData ~= nil then
    local dungeonId, isFrageDungeon = dungeonStageData.dungeonData.dungeonId, dungeonStageData.dungeonData.isFrageDungeon
    local fileName
    if isFrageDungeon then
      fileName = tostring(dungeonId) .. "_" .. tostring(dungeonStageData.dungeonData.itemId)
    else
      fileName = tostring(dungeonId)
    end
    lastDeployData = PersistentManager:LoadAndDecodeData(PersistentConfig.ePackage.DeploySaveData, fileName)
  elseif self.dunInterfaceData:GetIDungeonLevelData() ~= nil then
    local dungeonLevelData = self.dunInterfaceData:GetIDungeonLevelData()
    local dungeonId = dungeonLevelData:GetDungeonLevelStageId()
    if dungeonId ~= nil then
      local fileName = tostring(dungeonId)
      lastDeployData = PersistentManager:LoadAndDecodeData(PersistentConfig.ePackage.DeploySaveData, fileName)
    end
  end
  self.__lastDeployData = lastDeployData
  return self.__lastDeployData
end

function BattleDungeonManager:SaveDungeonDeploy(dynPlayer)
  if self.__lastDeployData == nil then
    return
  end
  local equal = true
  for _, dynHero in pairs(dynPlayer.heroList) do
    if not dynHero.onBench and self.__lastDeployData.hero_pos[dynHero.dataId] ~= dynHero.coord then
      equal = false
      break
    end
  end
  if equal then
    return
  end
  local hero_pos = {}
  for _, dynHero in pairs(dynPlayer.heroList) do
    if not dynHero.onBench then
      hero_pos[dynHero.dataId] = dynHero.coord
    end
  end
  self.__lastDeployData.hero_pos = hero_pos
  PersistentManager:SaveModelData(PersistentConfig.ePackage.DeploySaveData, self.__lastDeployData)
end

function BattleDungeonManager:PlayMVPVoice(heroId)
  local voiceId = 0
  if heroId == self._lastMvpVoiceHeroId then
    voiceId = ConfigData:GetVoicePointRandom(eVoicePointType.MVP, self._lastVoiceId, heroId)
  else
    voiceId = ConfigData:GetVoicePointRandom(eVoicePointType.MVP, nil, heroId)
  end
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  cvCtr:PlayCv(heroId, voiceId)
  self._lastMvpVoiceHeroId = heroId
  self._lastVoiceId = voiceId
end

function BattleDungeonManager:TryGetCurBattleDungeonId()
  if self.dungeonCtrl == nil then
    return
  end
  return self.dungeonCtrl.dungeonId
end

BattleDungeonManager:__Init()
