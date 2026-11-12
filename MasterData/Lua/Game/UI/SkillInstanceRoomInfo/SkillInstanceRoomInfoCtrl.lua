local SkillInstanceRoomInfoCtrl = class("SkillInstanceRoomInfoCtrl", BaseCtrl)
SkillInstanceRoomInfoCtrl._mapNodeConfig = {
  Shelock = {
    sCtrlName = "Game.UI.SkillInstanceRoomInfo.SkillInstanceShelock.SkillInstanceShelock"
  },
  Slime = {
    sCtrlName = "Game.UI.SkillInstanceRoomInfo.SkillInstanceSlime.SkillInstanceSlimeCtrl"
  },
  BossChallenge = {
    sCtrlName = "Game.UI.SkillInstanceRoomInfo.SkillInstanceExp.SkillInstanceExp"
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
SkillInstanceRoomInfoCtrl._mapEventConfig = {
  OpenSkillInstanceRoomInfo = "OnEvent_OpenUI",
  SkillInstanceLevelEnd = "OnEvent_CloseUI",
  InputEnable = "OnEvent_InputEnable",
  SkillInstanceBattleEnd = "OnEvent_BattleEnd"
}

function SkillInstanceRoomInfoCtrl:Awake()
end

function SkillInstanceRoomInfoCtrl:FadeIn()
end

function SkillInstanceRoomInfoCtrl:FadeOut()
end

function SkillInstanceRoomInfoCtrl:OnEnable()
  self._mapNode.Title:SetActive(false)
  self._mapNode.EdgeMask:SetActive(false)
  self._mapNode.Shelock.gameObject:SetActive(false)
  self._mapNode.Slime.gameObject:SetActive(false)
  self.bBattleEnd = true
end

function SkillInstanceRoomInfoCtrl:OnDisable()
end

function SkillInstanceRoomInfoCtrl:OnDestroy()
end

function SkillInstanceRoomInfoCtrl:OnRelease()
end

function SkillInstanceRoomInfoCtrl:OnEvent_OpenUI(nFloorId, nLevelId)
  local mapFloorCfgData = ConfigTable.GetData("SkillInstanceFloor", nFloorId)
  local mapLevelCfgData = ConfigTable.GetData("SkillInstance", nLevelId)
  if mapLevelCfgData.Type == 1 then
    self:SetAtlasSprite(self._mapNode.imgTitle, "05_language", "zs_vestige_title_15")
    self:SetAtlasSprite(self._mapNode.imgTitle1, "05_language", "zs_vestige_title_15")
  elseif mapLevelCfgData.Type == 2 then
    self:SetAtlasSprite(self._mapNode.imgTitle, "05_language", "zs_vestige_title_16")
    self:SetAtlasSprite(self._mapNode.imgTitle1, "05_language", "zs_vestige_title_16")
  elseif mapLevelCfgData.Type == 3 then
    self:SetAtlasSprite(self._mapNode.imgTitle, "05_language", "zs_vestige_title_17")
    self:SetAtlasSprite(self._mapNode.imgTitle1, "05_language", "zs_vestige_title_17")
  end
  if mapFloorCfgData.StarConditionType == 1 then
    self._mapNode.Shelock.gameObject:SetActive(true)
    self._mapNode.Shelock:StartEvent(nFloorId, 2, nLevelId)
  elseif mapFloorCfgData.StarConditionType == 2 then
    self._mapNode.Slime.gameObject:SetActive(true)
    self._mapNode.Slime:StartEvent(nFloorId, 2, nLevelId)
  elseif mapFloorCfgData.StarConditionType == 3 then
    self._mapNode.BossChallenge.gameObject:SetActive(true)
    self._mapNode.BossChallenge:StartEvent(nFloorId, 2, nLevelId)
  end
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

function SkillInstanceRoomInfoCtrl:OnEvent_CloseUI()
  self._mapNode.Shelock:LevelEnd()
  self._mapNode.Slime:LevelEnd()
  self._mapNode.BossChallenge:LevelEnd()
end

function SkillInstanceRoomInfoCtrl:OnEvent_InputEnable(bEnable)
  if self.bBattleEnd == true then
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, bEnable == true and 1 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroup, bEnable == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroup, bEnable == true)
end

function SkillInstanceRoomInfoCtrl:OnEvent_BattleEnd()
  self.bBattleEnd = true
end

return SkillInstanceRoomInfoCtrl
