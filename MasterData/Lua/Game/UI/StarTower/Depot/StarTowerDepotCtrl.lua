local StarTowerDepotCtrl = class("StarTowerDepotCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
StarTowerDepotCtrl._mapNodeConfig = {
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  animActor2D = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Animator"
  },
  imgActorBg = {},
  animActorBg = {sNodeName = "imgActorBg", sComponentName = "Animator"},
  goBlur = {
    sNodeName = "t_fullscreen_blur_01"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_01",
    sComponentName = "Animator"
  },
  goRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  aniRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  imgNoteTogBg = {},
  imgEmpty = {},
  ItemList = {
    sNodeName = "---ItemList---",
    sCtrlName = "Game.UI.StarTower.Depot.DepotItemListCtrl"
  },
  CharInfo = {
    sNodeName = "---CharInfo---",
    sCtrlName = "Game.UI.StarTower.Depot.DepotCharInfoCtrl"
  },
  Potential = {
    sNodeName = "---Potential---",
    sCtrlName = "Game.UI.StarTower.Depot.DepotPotentialCtrl"
  },
  DiscSkill = {
    sNodeName = "---DiscSkill---",
    sCtrlName = "Game.UI.StarTower.Depot.DepotDiscSkillCtrl"
  },
  tog = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeTab"
  },
  ctrlTog = {
    nCount = 4,
    sNodeName = "tog",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  btnBack = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_CloseStarTowerDepot"
  },
  btnHelp = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Dictionary"
  },
  txtTitle = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Depot"
  },
  txt_EmptyTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "FRDepot_EmptyItem"
  }
}
StarTowerDepotCtrl._mapEventConfig = {
  OpenStarTowerDepot = "OnEvent_OpenStarTowerDepot",
  RefreshActor2D_Depot = "OnEvent_RefreshActor2D",
  Guide_SelectDepotTog = "OnEvent_SelectDepotTog"
}
StarTowerDepotCtrl._mapRedDotConfig = {}

function StarTowerDepotCtrl:InitAllPotential()
  self.mapAllPotential = {}
  for k, nCharId in ipairs(self._panel.tbTeam) do
    local tbData = {
      nCharId = nCharId,
      tbPotential = {}
    }
    local charPotentialCfg = PlayerData.Char:GetCharPotentialList(nCharId)
    if charPotentialCfg ~= nil then
      if k == 1 then
        tbData.tbPotential = charPotentialCfg.master
      else
        tbData.tbPotential = charPotentialCfg.assist
      end
    end
    table.insert(self.mapAllPotential, tbData)
  end
end

function StarTowerDepotCtrl:RefreshTogText()
  self._mapNode.ctrlTog[1]:SetText(ConfigTable.GetUIText("StarTower_Depot_Potential"))
  self._mapNode.ctrlTog[2]:SetText(ConfigTable.GetUIText("StarTower_Depot_Note"))
  self._mapNode.ctrlTog[3]:SetText(ConfigTable.GetUIText("StarTower_Depot_Char"))
  self._mapNode.ctrlTog[4]:SetText(ConfigTable.GetUIText("StarTower_Depot_Bag"))
end

function StarTowerDepotCtrl:SetDefaultTog()
  if nil == self.nCurTog then
    self.nCurTog = AllEnum.StarTowerDepotTog.CharInfo
  end
  for i = 1, 4 do
    self._mapNode.ctrlTog[i]:SetDefault(i == self.nCurTog)
  end
  self:SwitchTog()
end

function StarTowerDepotCtrl:SwitchTog()
  self:RefreshList()
end

function StarTowerDepotCtrl:RefreshList()
  self._mapNode.CharInfo.gameObject:SetActive(self.nCurTog == AllEnum.StarTowerDepotTog.CharInfo)
  self._mapNode.Potential.gameObject:SetActive(self.nCurTog == AllEnum.StarTowerDepotTog.Potential)
  self._mapNode.DiscSkill.gameObject:SetActive(self.nCurTog == AllEnum.StarTowerDepotTog.DiscSkill)
  self._mapNode.ItemList.gameObject:SetActive(self.nCurTog == AllEnum.StarTowerDepotTog.ItemList)
  self._mapNode.trActor2D_PNG.gameObject:SetActive(self.nCurTog == AllEnum.StarTowerDepotTog.CharInfo)
  self._mapNode.imgActorBg.gameObject:SetActive(self.nCurTog == AllEnum.StarTowerDepotTog.CharInfo)
  self._mapNode.imgNoteTogBg.gameObject:SetActive(self.nCurTog == AllEnum.StarTowerDepotTog.DiscSkill)
  if self.nCurTog == AllEnum.StarTowerDepotTog.CharInfo then
    self._mapNode.CharInfo:RefreshCharInfo(self._panel.tbTeam, self._panel.mapCharData)
  elseif self.nCurTog == AllEnum.StarTowerDepotTog.Potential then
    self._mapNode.Potential:RefreshPotential(self.mapAllPotential, self.mapPotential)
  elseif self.nCurTog == AllEnum.StarTowerDepotTog.DiscSkill then
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_OpenStarTowerDepot")
    self._mapNode.DiscSkill:RefreshDiscSkill(self.mapNote, self.tbActiveSecondaryIds)
  elseif self.nCurTog == AllEnum.StarTowerDepotTog.ItemList then
    self._mapNode.ItemList:RefreshItemList(self.mapFateCard, self.mapItem, self.nParam)
    self.nParam = nil
  end
end

function StarTowerDepotCtrl:Awake()
  if self:GetPanelId() == PanelId.StarTowerFastBattle then
    self._mapNode.tog[3].gameObject:SetActive(false)
    self._mapNode.CharInfo.gameObject:SetActive(false)
  end
  self.canvas = self.gameObject:GetComponent("Canvas")
  self.nInitSortingOrder = NovaAPI.GetCanvasSortingOrder(self.canvas)
  self:RefreshTogText()
  self:InitAllPotential()
  self.nCurTog = nil
  self.tbCharPotential = {}
  self._mapNode.goRoot:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
  self._mapNode.Potential:ShieldPreselectionAnimator(false)
  self._mapNode.Potential:ShieldSpecialPontential(true)
end

function StarTowerDepotCtrl:FadeOut()
end

function StarTowerDepotCtrl:OnEnable()
end

function StarTowerDepotCtrl:OnDisable()
end

function StarTowerDepotCtrl:OnDestroy()
end

function StarTowerDepotCtrl:OnRelease()
end

function StarTowerDepotCtrl:OnBtnClick_ChangeTab(btn, nIndex)
  if nIndex == self.nCurTog then
    return
  end
  self._mapNode.ctrlTog[nIndex]:SetTrigger(true)
  self._mapNode.ctrlTog[self.nCurTog]:SetTrigger(false)
  self.nCurTog = nIndex
  self:SwitchTog()
end

function StarTowerDepotCtrl:OnBtnClick_CloseStarTowerDepot()
  PanelManager.InputEnable()
  EventManager.Hit("StarTowerSetButtonEnable", true, true)
  NovaAPI.SetCanvasSortingOrder(self.canvas, self.nInitSortingOrder)
  CS.GameCameraStackManager.Instance:OpenMainCamera()
  EventManager.Hit(EventId.BattleDashboardVisible, true)
  self.nCurTog = nil
  if self.callbackClose then
    self.callbackClose()
  end
  self._mapNode.goRoot:SetActive(false)
  self._mapNode.goBlur:SetActive(false)
  self._mapNode.trActor2D_PNG.gameObject:SetActive(false)
  self._mapNode.imgActorBg.gameObject:SetActive(false)
  self._mapNode.imgNoteTogBg.gameObject:SetActive(false)
  self._mapNode.Potential:Clear()
  self._mapNode.DiscSkill:Clear()
  self._mapNode.CharInfo:Clear()
  self._mapNode.ItemList:Clear()
  EventManager.Hit("CloseStarTowerDepot")
  GamepadUIManager.DisableGamepadUI("StarTowerDepotCtrl")
end

function StarTowerDepotCtrl:OnEvent_OpenStarTowerDepot(mapPotential, mapNote, mapFateCard, mapItem, tbActiveSecondaryIds, nTog, nParam, callback)
  self._panel:SetTop(self.canvas)
  PanelManager.InputDisable()
  EventManager.Hit("StarTowerSetButtonEnable", false, false)
  self.callbackClose = callback
  self.mapPotential = mapPotential
  self.mapNote = mapNote
  self.mapFateCard = mapFateCard
  self.mapItem = mapItem
  self.tbActiveSecondaryIds = tbActiveSecondaryIds
  self.nParam = nParam
  if nil ~= nTog then
    self.nCurTog = nTog
  end
  self._mapNode.goBlur:SetActive(true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.33)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    CS.GameCameraStackManager.Instance:CloseMainCamera(0.1)
    self:SetDefaultTog()
    self._mapNode.goRoot:SetActive(true)
    self._mapNode.aniRoot:Play("depot_t_in")
    if self.nCurTog == AllEnum.StarTowerDepotTog.CharInfo then
      self._mapNode.animActor2D:Play("Actor2D_PNG_down_in", 0, 0)
      self._mapNode.animActorBg:Play("imgActorBg_in", 0, 0)
    end
  end
  
  cs_coroutine.start(wait)
  GamepadUIManager.EnableGamepadUI("StarTowerDepotCtrl", self.tbGamepadUINode, nil, true)
end

function StarTowerDepotCtrl:OnEvent_RefreshActor2D(nCharId)
  Actor2DManager.SetActor2D_PNG(self._mapNode.trActor2D_PNG, PanelId.MainView, nCharId)
end

function StarTowerDepotCtrl:OnEvent_SelectDepotTog(nTog)
  if nTog == self.nCurTog then
    return
  end
  self._mapNode.ctrlTog[nTog]:SetTrigger(true)
  self._mapNode.ctrlTog[self.nCurTog]:SetTrigger(false)
  self.nCurTog = nTog
  self:SwitchTog()
end

function StarTowerDepotCtrl:OnBtnClick_Dictionary()
  if self:GetPanelId() == PanelId.StarTowerFastBattle then
    self._panel:OpenDepotDetailPanel(PanelId.DictionaryFR, true)
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryFR, false)
end

return StarTowerDepotCtrl
