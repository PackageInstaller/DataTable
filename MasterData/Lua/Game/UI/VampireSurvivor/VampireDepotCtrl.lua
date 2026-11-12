local VampireDepotCtrl = class("VampireDepotCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
VampireDepotCtrl._mapNodeConfig = {
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
    sCtrlName = "Game.UI.VampireSurvivor.Depot.DepotFateCardCtrl"
  },
  CharInfo = {
    sNodeName = "---CharInfo---",
    sCtrlName = "Game.UI.VampireSurvivor.Depot.DepotCharInfoCtrl"
  },
  tog = {
    nCount = 5,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeTab"
  },
  ctrlTog = {
    nCount = 5,
    sNodeName = "tog",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  btnBack = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_CloseDepot"
  },
  btnHelp = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Dictionary"
  },
  txtTitle = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Vampire_Depot_Title"
  },
  txt_EmptyTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Vampire_Depot_FateCardEmpty"
  }
}
VampireDepotCtrl._mapEventConfig = {
  VampireDepotOpen = "OnEvent_OpenVampireDepot",
  RefreshActor2D_Depot = "OnEvent_RefreshActor2D"
}
VampireDepotCtrl._mapRedDotConfig = {}

function VampireDepotCtrl:RefreshTogText()
  self._mapNode.ctrlTog[1]:SetText(ConfigTable.GetUIText("StarTower_Depot_Char"))
  self._mapNode.ctrlTog[5]:SetText(ConfigTable.GetUIText("Vampire_Depot_FateCardTog"))
end

function VampireDepotCtrl:SetDefaultTog()
  if nil == self.nCurTog then
    self.nCurTog = AllEnum.StarTowerDepotTog.CharInfo
  end
  for i = 1, 4 do
    self._mapNode.ctrlTog[i]:SetDefault(i == self.nCurTog)
  end
  self:SwitchTog()
end

function VampireDepotCtrl:SwitchTog()
  self:RefreshList()
end

function VampireDepotCtrl:RefreshList()
  self._mapNode.CharInfo.gameObject:SetActive(self.nCurTog == 1)
  self._mapNode.ItemList.gameObject:SetActive(self.nCurTog == 5)
  self._mapNode.trActor2D_PNG.gameObject:SetActive(self.nCurTog == 1)
  self._mapNode.imgActorBg.gameObject:SetActive(self.nCurTog == 1)
  self._mapNode.imgNoteTogBg.gameObject:SetActive(self.nCurTog == AllEnum.StarTowerDepotTog.Note)
  if self.nCurTog == 1 then
    self._mapNode.CharInfo:RefreshCharInfo(self._panel.tbTeam, self._panel.mapCharData)
  elseif self.nCurTog == 5 then
    self._mapNode.ItemList:RefreshFateCard(self.mapFateCard)
  end
end

function VampireDepotCtrl:Awake()
  self.canvas = self.gameObject:GetComponent("Canvas")
  self.nInitSortingOrder = NovaAPI.GetCanvasSortingOrder(self.canvas)
  self:RefreshTogText()
  self.nCurTog = nil
  self.tbCharPotential = {}
  self._mapNode.goRoot:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function VampireDepotCtrl:FadeOut()
end

function VampireDepotCtrl:OnEnable()
  self._mapNode.ItemList:InitPackage(self._panel.nLevelId)
end

function VampireDepotCtrl:OnDisable()
end

function VampireDepotCtrl:OnDestroy()
end

function VampireDepotCtrl:OnRelease()
end

function VampireDepotCtrl:OnBtnClick_ChangeTab(btn, nIndex)
  if nIndex == self.nCurTog then
    return
  end
  self._mapNode.ctrlTog[nIndex]:SetTrigger(true)
  self._mapNode.ctrlTog[self.nCurTog]:SetTrigger(false)
  self.nCurTog = nIndex
  self:SwitchTog()
end

function VampireDepotCtrl:OnBtnClick_CloseDepot()
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
  self._mapNode.CharInfo:Clear()
  EventManager.Hit("CloseStarTowerDepot")
  GamepadUIManager.DisableGamepadUI("VampireDepotCtrl")
end

function VampireDepotCtrl:OnEvent_OpenVampireDepot(mapFateCard, nTog, nParam, callback)
  self._panel:SetTop(self.canvas)
  PanelManager.InputDisable()
  EventManager.Hit("StarTowerSetButtonEnable", false, false)
  self.callbackClose = callback
  self.mapFateCard = mapFateCard
  self.nParam = nParam
  if nil ~= nTog then
    self.nCurTog = nTog
  end
  self._mapNode.tog[4].gameObject:SetActive(false)
  self._mapNode.goBlur:SetActive(true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.33)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    local bSuccess, sError = xpcall(function()
      CS.GameCameraStackManager.Instance:CloseMainCamera(0.1)
      self:SetDefaultTog()
      self._mapNode.goRoot:SetActive(true)
      self._mapNode.aniRoot:Play("depot_t_in")
      if self.nCurTog == AllEnum.StarTowerDepotTog.CharInfo then
        self._mapNode.animActor2D:Play("Actor2D_PNG_down_in", 0, 0)
        self._mapNode.animActorBg:Play("imgActorBg_in", 0, 0)
      end
    end, debug.traceback)
    if not bSuccess then
      self:OnBtnClick_CloseDepot()
      printError(sError)
    end
  end
  
  cs_coroutine.start(wait)
  GamepadUIManager.EnableGamepadUI("VampireDepotCtrl", self.tbGamepadUINode, nil, true)
end

function VampireDepotCtrl:OnEvent_RefreshActor2D(nCharId)
  local mapChar = self._panel.mapCharData[nCharId]
  Actor2DManager.SetActor2D_PNG(self._mapNode.trActor2D_PNG, PanelId.MainView, nCharId, mapChar and mapChar.nSkinId)
end

function VampireDepotCtrl:OnBtnClick_Dictionary()
  EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryFR, self:GetPanelId() == PanelId.StarTowerFastBattle)
end

return VampireDepotCtrl
