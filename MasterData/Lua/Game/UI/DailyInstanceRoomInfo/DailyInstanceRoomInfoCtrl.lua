local DailyInstanceRoomInfoCtrl = class("DailyInstanceRoomInfoCtrl", BaseCtrl)
DailyInstanceRoomInfoCtrl._mapNodeConfig = {
  Shelock = {
    sCtrlName = "Game.UI.DailyInstanceRoomInfo.DailyInstanceShelock.DailyInstanceShelock"
  },
  Slime = {
    sCtrlName = "Game.UI.DailyInstanceRoomInfo.DailyInstanceSlime.DailyInstanceSlimeCtrl"
  },
  BossChallenge = {
    sCtrlName = "Game.UI.DailyInstanceRoomInfo.DailyInstanceExp.DailyInstanceExp"
  },
  rootAnim = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  Title = {},
  imgTitle = {sComponentName = "Image"},
  imgTitle1 = {sComponentName = "Image"},
  TMPSubTitle = {sComponentName = "TMP_Text"},
  EdgeMask = {},
  canvasGroup = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  }
}
DailyInstanceRoomInfoCtrl._mapEventConfig = {
  OpenDailyInstanceRoomInfo = "OnEvent_OpenUI",
  DailyInstanceLevelEnd = "OnEvent_CloseUI",
  InputEnable = "OnEvent_InputEnable",
  DailyInstanceBattleEnd = "OnEvent_BattleEnd"
}

function DailyInstanceRoomInfoCtrl:Awake()
end

function DailyInstanceRoomInfoCtrl:FadeIn()
end

function DailyInstanceRoomInfoCtrl:FadeOut()
end

function DailyInstanceRoomInfoCtrl:OnEnable()
  self._mapNode.Title:SetActive(false)
  self._mapNode.EdgeMask:SetActive(false)
  self._mapNode.Shelock.gameObject:SetActive(false)
  self._mapNode.Slime.gameObject:SetActive(false)
  self.bBattleEnd = false
end

function DailyInstanceRoomInfoCtrl:OnDisable()
end

function DailyInstanceRoomInfoCtrl:OnDestroy()
end

function DailyInstanceRoomInfoCtrl:OnRelease()
end

function DailyInstanceRoomInfoCtrl:OnEvent_OpenUI(nFloorId, nLevelId)
  local mapFloorCfgData = ConfigTable.GetData("DailyInstanceFloor", nFloorId)
  local mapLevelCfgData = ConfigTable.GetData("DailyInstance", nLevelId)
  self:SetAtlasSprite(self._mapNode.imgTitle, "15_battle", "zs_vestige_title_14")
  self:SetAtlasSprite(self._mapNode.imgTitle1, "15_battle", "zs_vestige_title_14")
  self._mapNode.BossChallenge.gameObject:SetActive(true)
  self._mapNode.BossChallenge:StartEvent(nFloorId, 2, nLevelId)
  self._mapNode.rootAnim:Play("FRRoomInfo_in")
  NovaAPI.SetTMPText(self._mapNode.TMPSubTitle, mapLevelCfgData.Desc)
  NovaAPI.SetImageNativeSize(self._mapNode.imgTitle)
  NovaAPI.SetImageNativeSize(self._mapNode.imgTitle1)
  
  local function ShowTitleCallback()
    CS.AdventureModuleHelper.ResumeLogic()
    self.bBattleEnd = false
    EventManager.Hit("ShowOrHideBattleDash", true)
    self._mapNode.Title:SetActive(false)
    self._mapNode.EdgeMask:SetActive(false)
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self.bBattleEnd = true
    EventManager.Hit("ShowOrHideBattleDash", false)
    EventManager.Hit(EventId.TemporaryBlockInput, 2)
    CS.AdventureModuleHelper.PauseLogic()
    self._mapNode.Title:SetActive(true)
    self._mapNode.EdgeMask:SetActive(true)
    self:AddTimer(1, 2, ShowTitleCallback, true, true, true)
  end
  
  cs_coroutine.start(wait)
end

function DailyInstanceRoomInfoCtrl:OnEvent_CloseUI()
  self._mapNode.BossChallenge:LevelEnd()
end

function DailyInstanceRoomInfoCtrl:OnEvent_InputEnable(bEnable)
  if self.bBattleEnd == true then
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, bEnable == true and 1 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroup, bEnable == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroup, bEnable == true)
end

function DailyInstanceRoomInfoCtrl:OnEvent_BattleEnd()
  self.bBattleEnd = true
end

return DailyInstanceRoomInfoCtrl
