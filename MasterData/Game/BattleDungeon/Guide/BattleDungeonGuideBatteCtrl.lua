local BattleDungeonBattleCtrl = require("Game.BattleDungeon.Ctrl.BattleDungeonBattleCtrl")
local BattleDungeonGuideBatteCtrl = class("BattleDungeonGuideBatteCtrl", BattleDungeonBattleCtrl)
local DungeonBattleRoom = require("Game.BattleDungeon.Data.DungeonBattleRoom")

function BattleDungeonGuideBatteCtrl:ctor(bdCtrl, guideType)
  self.guideType = guideType
  self.__OnBattleUpdateUltSkill = BindCallback(self, self.OnBattleUpdateUltSkill)
  MsgCenter:AddListener(eMsgEventId.OnBattleUpdateUltSkill, self.__OnBattleUpdateUltSkill)
end

function BattleDungeonGuideBatteCtrl:OnBattleStateChange(battleCtrl, stateId, isDeployRoom)
  self.curStateId = stateId
  if stateId == eBattleState.Init then
  elseif stateId == eBattleState.Deploy then
    if self.guideType == 1 then
      local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
      if window ~= nil then
        window:ShowUltSkillNode(false)
      end
    elseif self.guideType == 2 then
      self:StartNewClickRoleGuide(battleCtrl)
    end
  elseif stateId == eBattleState.Running then
    UIManager:HideWindow(UIWindowTypeID.BattleDPS)
    local window = UIManager:GetWindow(UIWindowTypeID.Battle)
    if window ~= nil then
      window:HidePauseButton()
    end
  elseif stateId == eBattleState.End then
  elseif stateId == eBattleState.Delete then
    self.curStateId = -1
  end
end

function BattleDungeonGuideBatteCtrl:DungeonBattleStepLogic(monsterGroup)
  local battleRoomData = DungeonBattleRoom.CreateBattleDungeonRoom(self.bdCtrl, monsterGroup, self.bdCtrl.dungeonCfg, self.bdCtrl.dynPlayer)
  self.battleRoomData = battleRoomData
  if self.guideType == 1 then
    local firstBattle1Config = GuideManager.firstBattleGuideCtrl:GetFirstBattleConfig()
    self.__guideConfig = firstBattle1Config
    local battleCtrl = CS.BattleManager.Instance:StartNewBattle(battleRoomData, self.bdCtrl.dynPlayer, self)
    battleCtrl:StartEnterDeployState()
    GuideManager:StartNewGuide(self.__guideConfig.guideList[1])
  elseif self.guideType == 2 then
    local firstBattle2Config = GuideManager.firstBattleGuideCtrl:GetFirstBattleConfig()
    self.__guideConfig = firstBattle2Config
    local dynPlayer = self.bdCtrl.dynPlayer
    for k, v in ipairs(firstBattle2Config.formHeroPos) do
      dynPlayer.heroList[k]:SetCoordXY(v[1], v[2])
    end
    local battleCtrl = CS.BattleManager.Instance:StartNewBattle(battleRoomData, self.bdCtrl.dynPlayer, self)
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
    avgCtrl:ShowAvg(firstBattle2Config.beforeDragAvg, function()
      battleCtrl:StartEnterDeployState()
    end, true)
  else
    error("error battle guideType:" .. tostring(self.guideType))
  end
end

function BattleDungeonGuideBatteCtrl:StartNewClickRoleGuide(battleCtrl)
  local deployState = battleCtrl.fsm:GetStateFromID(CS.eBattleState.Deploy)
  local firstBattle2Config = GuideManager.firstBattleGuideCtrl:GetFirstBattleConfig()
  local deployGuide = CS.BattleDeployGuideData()
  deployGuide.guideType = CS.BattleDeployGuideData.GuideType.ClickRole
  deployGuide.endAction = BindCallback(self, self.OnClickRoleGuideComplete, deployState)
  local dstCoord = {
    x = firstBattle2Config.clickHeroPos[1],
    y = firstBattle2Config.clickHeroPos[2]
  }
  deployGuide.endCoord = dstCoord
  deployState.guideData = deployGuide
  UIManager:GetWindow(UIWindowTypeID.Battle):SetBattleStartActive(false)
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    if window == nil then
      return window
    end
    local startPos = deployState.battleController.battleFieldData:GetGridUnityPos(dstCoord.x, dstCoord.y)
    local startUIPos = UIManager:World2UIPosition(startPos)
    window:PlayHandClickGuide(startUIPos)
    window:ShowHeroSmallTalk(ConfigData:GetTipContent(firstBattle2Config.introHeroGuideTextId), firstBattle2Config.introHeroGuideHeroId, firstBattle2Config.introHeroGuidePos)
  end)
end

function BattleDungeonGuideBatteCtrl:OnClickRoleGuideComplete(deployState)
  deployState.guideData = nil
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    if window == nil then
      return window
    end
    window:EndHandClickGuide()
    window:HideHeroTalkDialog()
  end)
  self.__OnHeroDetailActiveChange = BindCallback(self, self.OnHeroDetailActiveChange, deployState)
  MsgCenter:AddListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnHeroDetailActiveChange)
  GuideManager:StartNewGuide(self.__guideConfig.guideList[4])
end

function BattleDungeonGuideBatteCtrl:OnHeroDetailActiveChange(deployState, active)
  if not active then
    MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnHeroDetailActiveChange)
    self.__OnHeroDetailActiveChange = nil
    UIManager:GetWindow(UIWindowTypeID.Battle):SetBattleStartActive(true)
    GuideManager:StartNewGuide(self.__guideConfig.guideList[1])
  end
end

function BattleDungeonGuideBatteCtrl:StartNewDeployDragGuide(battleCtrl)
  local firstBattle2Config = GuideManager.firstBattleGuideCtrl:GetFirstBattleConfig()
  local deployGuide = CS.BattleDeployGuideData()
  deployGuide.endAction = BindCallback(self, self.OnDeployGuideEnd)
  deployGuide.startCoord = {
    x = self.battleRoomData.battleMap.BenchCoordX,
    y = firstBattle2Config.benchHeroOriginPos
  }
  deployGuide.endCoord = {
    x = firstBattle2Config.benchHeroPos[1],
    y = firstBattle2Config.benchHeroPos[2]
  }
  local deployState = battleCtrl.fsm:GetStateFromID(CS.eBattleState.Deploy)
  deployState.guideData = deployGuide
  self:OnDeployGuideStart(deployState)
end

function BattleDungeonGuideBatteCtrl:OnBattleStart(battleCtrl)
  if self.guideType == 1 then
    local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
    if window ~= nil then
      window:ShowPlayerSkillNode(false)
      window:ShowUltSkillNode(false)
    end
    LuaSkillCtrl:GetTimer(self.__guideConfig.csGuideDelay, BindCallback(self, self.StartGuideCommandSkill1, battleCtrl))
  elseif self.guideType == 2 then
    local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
    if window ~= nil then
      window.playerSkillNode:SetSkillItemActive(2, false)
    end
    LuaSkillCtrl:GetTimer(self.__guideConfig.csGuideDelay, BindCallback(self, self.StartGuideCommandSkill2, battleCtrl))
  end
  BattleDungeonBattleCtrl.OnBattleStart(self, battleCtrl)
end

function BattleDungeonGuideBatteCtrl:StartGuideCommandSkill1(battleCtrl)
  local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if window ~= nil then
    window:ShowPlayerSkillNode(true)
  end
  self.oldTimeScale = Time.unity_time.timeScale
  Time.unity_time.timeScale = 0
  GuideManager:StartNewGuide(self.__guideConfig.guideList[2], function()
    Time.unity_time.timeScale = self.oldTimeScale
  end)
end

function BattleDungeonGuideBatteCtrl:StartGuideCommandSkill2(battleCtrl)
  local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if window == nil then
    return
  end
  local skillItem = window.playerSkillNode:SetSkillItemActive(2, true)
  if skillItem == nil then
    return
  end
  skillItem:SetSkillBtnEnabled(false)
  if battleCtrl == nil then
    return
  end
  battleCtrl.PlayerController:ResetCurMpRatio(100)
  self.oldTimeScale = Time.unity_time.timeScale
  Time.unity_time.timeScale = 0
  local firstBattle2Config = GuideManager.firstBattleGuideCtrl:GetFirstBattleConfig()
  local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
  avgCtrl:ShowAvg(firstBattle2Config.dragSkillGuideAvg, function()
    skillItem:SetSkillBtnEnabled(true)
    self:StartGuideCommandSkillSelect(battleCtrl)
  end, true, true)
end

function BattleDungeonGuideBatteCtrl:StartGuideCommandSkillSelect(battleCtrl)
  local skillWindow = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if skillWindow == nil then
    return
  end
  local guideSkillIndex = 2
  local skillItem = skillWindow.playerSkillNode:GetSkillItem(guideSkillIndex)
  if skillItem == nil then
    return
  end
  local firstBattle2Config = GuideManager.firstBattleGuideCtrl:GetFirstBattleConfig()
  local startUIPos = skillWindow.transform:InverseTransformPoint(skillItem.transform.position)
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    if window == nil then
      return window
    end
    local endPos = battleCtrl.battleFieldData:GetGridUnityPos(firstBattle2Config.dragSkillGuidePos[1], firstBattle2Config.dragSkillGuidePos[2])
    local endUIPos = UIManager:World2UIPosition(endPos)
    endUIPos = Vector3.New(endUIPos.x, endUIPos.y, 0)
    window:PlaySlideGuide(startUIPos, endUIPos)
    window:ShowHeroSmallTalk(ConfigData:GetTipContent(firstBattle2Config.dragSkillGuideTextId), firstBattle2Config.dragSkillGuideHeroId, firstBattle2Config.dragSkillGuideTalkPos)
  end)
  local skillGuideData = CS.BattleSkillCastGuideData()
  skillGuideData.guideSkillId = firstBattle2Config.formCSList[guideSkillIndex]
  
  function skillGuideData.endAction(battleCtrl)
    Time.unity_time.timeScale = self.oldTimeScale
    local guideWindow = UIManager:GetWindow(UIWindowTypeID.Guide)
    if guideWindow ~= nil then
      guideWindow:EndSlideGuide()
      guideWindow:HideHeroTalkDialog()
    end
  end
  
  battleCtrl.PlayerController:StartSkillCastGuide(skillGuideData)
end

function BattleDungeonGuideBatteCtrl:OnDeployGuideStart(deployState)
  local firstBattle2Config = GuideManager.firstBattleGuideCtrl:GetFirstBattleConfig()
  UIManager:GetWindow(UIWindowTypeID.Battle):SetBattleStartActive(false)
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    if window == nil then
      return window
    end
    local startPos = deployState.battleController.battleFieldData:GetBenchUnityPos(firstBattle2Config.benchHeroOriginPos)
    local endPos = deployState.battleController.battleFieldData:GetGridUnityPos(firstBattle2Config.benchHeroPos[1], firstBattle2Config.benchHeroPos[2])
    local startUIPos = UIManager:World2UIPosition(startPos)
    local endUIPos = UIManager:World2UIPosition(endPos)
    startUIPos = Vector3.New(startUIPos.x, startUIPos.y, 0)
    endUIPos = Vector3.New(endUIPos.x, endUIPos.y, 0)
    window:PlaySlideGuide(startUIPos, endUIPos)
    window:ShowHeroSmallTalk(ConfigData:GetTipContent(firstBattle2Config.dragGuideTextId), firstBattle2Config.guideTalkHeroId, firstBattle2Config.guideTalkPos)
  end)
  self.__guideResloader = CS.ResLoader.Create()
  self.__guideResloader:LoadABAssetAsync("FX/Common/FX_UI/FXP_pickHexagonPlayer/FXUI_pickHexagonPlayer_go.prefab", function(go)
    if IsNull(go) then
      return
    end
    local floorTile = deployState.battleController.FloorTileController:GetFloorTile(firstBattle2Config.benchHeroPos[1], firstBattle2Config.benchHeroPos[2])
    if floorTile == nil then
      return
    end
    self.__deployHightlight = go:Instantiate(floorTile.transform)
    self.__deployHightlight.transform.localPosition = Vector3.zero
  end)
end

function BattleDungeonGuideBatteCtrl:OnDeployGuideEnd(deployState)
  deployState.guideData = nil
  DestroyUnityObject(self.__deployHightlight)
  if self.__guideResloader ~= nil then
    self.__guideResloader:Put2Pool()
    self.__guideResloader = nil
  end
  GuideManager:StartNewGuide(self.__guideConfig.guideList[1])
  UIManager:GetWindow(UIWindowTypeID.Battle):SetBattleStartActive(true)
  local guideWindow = UIManager:GetWindow(UIWindowTypeID.Guide)
  if guideWindow ~= nil then
    guideWindow:EndSlideGuide()
    guideWindow:HideHeroTalkDialog()
  end
end

function BattleDungeonGuideBatteCtrl:OnBattleUpdateUltSkill(useEnable, curRatio, factor)
  if useEnable and self.guideType == 2 then
    if self.__guideUltSkillOver then
      return
    end
    self.__guideUltSkillOver = true
    CS.BattleManager.Instance.CurBattleController.PlayerController:EndSelectInputByCancel()
    self.oldTimeScale = Time.unity_time.timeScale
    Time.unity_time.timeScale = 0
    GuideManager:StartNewGuide(self.__guideConfig.guideList[2], function()
      Time.unity_time.timeScale = self.oldTimeScale
    end)
  end
end

function BattleDungeonGuideBatteCtrl:ReqBattleSettle(battleEndState, requestData)
  battleEndState.win = true
  BattleDungeonBattleCtrl.ReqBattleSettle(self, battleEndState, requestData)
end

function BattleDungeonGuideBatteCtrl:OnDelete()
  if self.__OnHeroDetailActiveChange ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnHeroDetailActiveChange)
  end
  MsgCenter:RemoveListener(eMsgEventId.OnBattleUpdateUltSkill, self.__OnBattleUpdateUltSkill)
  BattleDungeonBattleCtrl.OnDelete(self)
  UIManager:DeleteWindow(UIWindowTypeID.Guide)
end

return BattleDungeonGuideBatteCtrl
