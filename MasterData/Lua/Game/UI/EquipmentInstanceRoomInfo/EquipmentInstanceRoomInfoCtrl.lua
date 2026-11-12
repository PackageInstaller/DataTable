local EquipmentInstanceRoomInfoCtrl = class("EquipmentInstanceRoomInfoCtrl", BaseCtrl)
EquipmentInstanceRoomInfoCtrl._mapNodeConfig = {
  Shelock = {
    sCtrlName = "Game.UI.EquipmentInstanceRoomInfo.EquipmentInstanceShelock.EquipmentInstanceShelock"
  },
  Slime = {
    sCtrlName = "Game.UI.EquipmentInstanceRoomInfo.EquipmentInstanceSlime.EquipmentInstanceSlimeCtrl"
  },
  BossChallenge = {
    sCtrlName = "Game.UI.EquipmentInstanceRoomInfo.EquipmentInstanceExp.EquipmentInstanceExp"
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
EquipmentInstanceRoomInfoCtrl._mapEventConfig = {
  OpenEquipmentInstanceRoomInfo = "OnEvent_OpenUI",
  EquipmentInstanceLevelEnd = "OnEvent_CloseUI",
  InputEnable = "OnEvent_InputEnable",
  EquipmentInstanceBattleEnd = "OnEvent_BattleEnd"
}

function EquipmentInstanceRoomInfoCtrl:Awake()
end

function EquipmentInstanceRoomInfoCtrl:FadeIn()
end

function EquipmentInstanceRoomInfoCtrl:FadeOut()
end

function EquipmentInstanceRoomInfoCtrl:OnEnable()
  self._mapNode.Title:SetActive(false)
  self._mapNode.EdgeMask:SetActive(false)
  self._mapNode.Shelock.gameObject:SetActive(false)
  self._mapNode.Slime.gameObject:SetActive(false)
  self.bBattleEnd = false
end

function EquipmentInstanceRoomInfoCtrl:OnDisable()
end

function EquipmentInstanceRoomInfoCtrl:OnDestroy()
end

function EquipmentInstanceRoomInfoCtrl:OnRelease()
end

function EquipmentInstanceRoomInfoCtrl:OnEvent_OpenUI(nFloorId, nLevelId)
  local mapFloorCfgData = ConfigTable.GetData("CharGemInstanceFloor", nFloorId)
  local mapLevelCfgData = ConfigTable.GetData("CharGemInstance", nLevelId)
  if mapLevelCfgData.Type == 1 then
    self:SetAtlasSprite(self._mapNode.imgTitle, "15_battle", "zs_vestige_title_12")
    self:SetAtlasSprite(self._mapNode.imgTitle1, "15_battle", "zs_vestige_title_12")
  elseif mapLevelCfgData.Type == 2 then
    self:SetAtlasSprite(self._mapNode.imgTitle, "15_battle", "zs_vestige_title_13")
    self:SetAtlasSprite(self._mapNode.imgTitle1, "15_battle", "zs_vestige_title_13")
  elseif mapLevelCfgData.Type == 3 then
    self:SetAtlasSprite(self._mapNode.imgTitle, "15_battle", "zs_vestige_title_11")
    self:SetAtlasSprite(self._mapNode.imgTitle1, "15_battle", "zs_vestige_title_11")
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
    self._mapNode.Title:SetActive(false)
    self._mapNode.EdgeMask:SetActive(false)
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.Title:SetActive(true)
    self._mapNode.EdgeMask:SetActive(true)
    self:AddTimer(1, 2, ShowTitleCallback, true, true, true)
  end
  
  cs_coroutine.start(wait)
end

function EquipmentInstanceRoomInfoCtrl:OnEvent_CloseUI()
  self._mapNode.Shelock:LevelEnd()
  self._mapNode.Slime:LevelEnd()
  self._mapNode.BossChallenge:LevelEnd()
end

function EquipmentInstanceRoomInfoCtrl:OnEvent_InputEnable(bEnable)
  if self.bBattleEnd == true then
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, bEnable == true and 1 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroup, bEnable == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroup, bEnable == true)
end

function EquipmentInstanceRoomInfoCtrl:OnEvent_BattleEnd()
  self.bBattleEnd = true
end

return EquipmentInstanceRoomInfoCtrl
