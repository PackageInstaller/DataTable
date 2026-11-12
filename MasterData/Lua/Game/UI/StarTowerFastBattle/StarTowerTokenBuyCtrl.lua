local StarTowerTokenBuyCtrl = class("StarTowerTokenBuyCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
StarTowerTokenBuyCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  MainRoot = {
    sNodeName = "---Main---",
    sCtrlName = "Game.UI.StarTowerFastBattle.StarTowerTokenBuyMainCtrl"
  },
  ConfirmRoot = {
    sNodeName = "---Confirm---",
    sCtrlName = "Game.UI.StarTowerFastBattle.StarTowerTokenBuyConfirmCtrl"
  },
  ItemUseRoot = {
    sNodeName = "---ItemUse---",
    sCtrlName = "Game.UI.StarTowerFastBattle.StarTowerTokenBuyItemUseCtrl"
  },
  goToken = {},
  animToken = {sNodeName = "goToken", sComponentName = "Animator"},
  goResBarAnimRoot = {},
  animResBar = {
    sNodeName = "goResBarAnimRoot",
    sComponentName = "Animator"
  },
  txtUpperTokenCount = {sComponentName = "TMP_Text"},
  imgTokenFiller = {sComponentName = "Image"},
  btnBg = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  }
}
StarTowerTokenBuyCtrl._mapEventConfig = {
  CloseTokenBuyPanel = "OnEvent_CloseTokenBuyPanel",
  ChangeTokenBuyPanel = "OnEvent_ChangeTokenBuyPanel",
  ShowTokenTopRes = "OnEvent_ShowTokenTopResBar",
  [EventId.IsNewDay] = "OnEvent_NewDay",
  RefreshTokenItemList = "RefreshTopFiller"
}
local nMaxFillerWidth = 290

function StarTowerTokenBuyCtrl:Awake()
  self.tbWindowStack = {}
  if self._panel.nPanelType ~= AllEnum.TokenBuyPanelType.Main then
    self.nDirectPanelType = self._panel.nPanelType
  end
  self._panel.nMaxToken = ConfigTable.GetConfigNumber("TowerVitaEnergyMax")
end

function StarTowerTokenBuyCtrl:OnEnable()
  if PanelManager.CheckPanelOpen(PanelId.StarTowerFastBattle) then
    local canvas = self.gameObject:GetComponent("Canvas")
    NovaAPI.SetCanvasSortingOrder(canvas, AllEnum.UI_SORTING_ORDER.StarTowerAutoDecisionTokenBuy)
  end
  GamepadUIManager.EnableGamepadUI("StarTowerTokenBuyCtrl", {}, nil, true, false, self._panel._nIndex)
  self.animRoot = self.gameObject:GetComponent("Animator")
  self._mapNode.safeAreaRoot.gameObject:SetActive(false)
  self._mapNode.btnBg.gameObject:SetActive(false)
  self._mapNode.imgBlurredBg.gameObject:SetActive(true)
  self._mapNode.goResBarAnimRoot.gameObject:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.safeAreaRoot.gameObject:SetActive(true)
    self._mapNode.btnBg.gameObject:SetActive(true)
    table.insert(self.tbWindowStack, self._panel.nPanelType)
    self:ChangePanelType()
  end
  
  cs_coroutine.start(wait)
  self:RefreshTopFiller()
end

function StarTowerTokenBuyCtrl:RefreshTopFiller()
  local nCurToken = PlayerData.StarTowerAutoPlan:GetTokenCount()
  local nRatio = nCurToken / self._panel.nMaxToken
  if nRatio < 0.01 and 0 < nRatio then
    nRatio = 0.01
  end
  NovaAPI.SetImageFillAmount(self._mapNode.imgTokenFiller, nRatio)
  local nPercent = math.floor(nCurToken * 100 / self._panel.nMaxToken)
  if 0 < nCurToken then
    nPercent = math.max(1, nPercent)
  end
  NovaAPI.SetTMPText(self._mapNode.txtUpperTokenCount, nPercent .. "%")
end

function StarTowerTokenBuyCtrl:ChangePanelType()
  self._mapNode.MainRoot.gameObject:SetActive(self._panel.nPanelType == AllEnum.TokenBuyPanelType.Main)
  self._mapNode.ConfirmRoot.gameObject:SetActive(self._panel.nPanelType == AllEnum.TokenBuyPanelType.BuyConfirm)
  self._mapNode.ItemUseRoot.gameObject:SetActive(self._panel.nPanelType == AllEnum.TokenBuyPanelType.ItemUse)
  if self.nDirectPanelType ~= nil then
    local bShowToken = self.nDirectPanelType == AllEnum.TokenBuyPanelType.BuyConfirm
    self._mapNode.goToken.gameObject:SetActive(not bShowToken)
    self._mapNode.goResBarAnimRoot.gameObject:SetActive(bShowToken)
    local sAnim = bShowToken and "tc_top_bar_02_t_in" or "tc_top_bar_01_t_in"
    self._mapNode.animResBar:Play(sAnim)
    self.nDirectPanelType = nil
  else
    local bShowRecover = self._panel.nPanelType ~= AllEnum.TokenBuyPanelType.BuyConfirm
    local sRecoverAnim = bShowRecover and "EnergyBuy_Time_in" or "EnergyBuy_Time_out"
    local sTokenAnim = bShowRecover and "tc_top_bar_02_t_in" or "tc_top_bar_02_t_out"
    local sResBarAnim = not bShowRecover and "tc_top_bar_01_t_in" or "tc_top_bar_01_t_out"
    self._mapNode.goResBarAnimRoot.gameObject:SetActive(not bShowRecover)
    self._mapNode.goToken.gameObject:SetActive(bShowRecover)
    self._mapNode.animToken:Play(sTokenAnim)
    self.animRoot:Play(sRecoverAnim)
    self._mapNode.animResBar:Play(sResBarAnim)
  end
  if self._panel.nPanelType == AllEnum.TokenBuyPanelType.Main then
    self._mapNode.MainRoot:ShowPanel()
  elseif self._panel.nPanelType == AllEnum.TokenBuyPanelType.BuyConfirm then
    self._mapNode.ConfirmRoot:ShowPanel()
  elseif self._panel.nPanelType == AllEnum.TokenBuyPanelType.ItemUse then
    self._mapNode.ItemUseRoot:ShowPanel()
  end
end

function StarTowerTokenBuyCtrl:ClosePanel(nPanelType)
  self._mapNode.animToken:Play("tc_top_bar_02_t_out")
  self._mapNode.animResBar:Play("tc_top_bar_01_t_out")
  self.animRoot:Play("EnergyBuy_Time_out")
  if nPanelType == AllEnum.TokenBuyPanelType.Main then
    self._mapNode.MainRoot:Close()
  elseif nPanelType == AllEnum.TokenBuyPanelType.BuyConfirm then
    self._mapNode.ConfirmRoot:Close()
  elseif nPanelType == AllEnum.TokenBuyPanelType.ItemUse then
    self._mapNode.ItemUseRoot:Close()
  end
end

function StarTowerTokenBuyCtrl:OnDisable()
  GamepadUIManager.DisableGamepadUI("StarTowerTokenBuyCtrl")
end

function StarTowerTokenBuyCtrl:OnDestroy()
end

function StarTowerTokenBuyCtrl:OnEvent_ChangeTokenBuyPanel(nPanelType)
  self:ClosePanel(self._panel.nPanelType)
  self._panel.nPanelType = nPanelType
  table.insert(self.tbWindowStack, self._panel.nPanelType)
  self:AddTimer(1, 0.3, function()
    self:ChangePanelType()
  end, true, true, true)
end

function StarTowerTokenBuyCtrl:OnEvent_CloseTokenBuyPanel(bCloseAll)
  local nPanelType = table.remove(self.tbWindowStack, #self.tbWindowStack)
  if nPanelType ~= self._panel.nPanelType or bCloseAll then
    EventManager.Hit(EventId.ClosePanel, PanelId.StarTowerTokenBuyPanel)
  else
    self:ClosePanel(self._panel.nPanelType)
    self:AddTimer(1, 0.3, function()
      if #self.tbWindowStack > 0 then
        self._panel.nPanelType = self.tbWindowStack[#self.tbWindowStack]
        self:ChangePanelType()
      else
        EventManager.Hit(EventId.ClosePanel, PanelId.StarTowerTokenBuyPanel)
      end
    end, true, true, true)
  end
end

function StarTowerTokenBuyCtrl:OnBtnClick_Close()
  self:OnEvent_CloseTokenBuyPanel(true)
end

function StarTowerTokenBuyCtrl:OnEvent_ShowTokenTopResBar(bShow)
  self._mapNode.goResBarAnimRoot.gameObject:SetActive(bShow)
  self:RefreshTopFiller()
end

function StarTowerTokenBuyCtrl:OnEvent_NewDay()
  if PanelManager.GetCurPanelId() == PanelId.MainView then
    EventManager.Hit("NewDay_Clear_Guide")
    local msg = {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Alert_NextDay"),
      callbackConfirm = function()
        PanelManager.Home()
      end
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
end

return StarTowerTokenBuyCtrl
