local BdConvertCtrl = class("BdConvertCtrl", BaseCtrl)
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local PanelTab = {Content = 1, Build = 2}
BdConvertCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  Actor2D = {
    sNodeName = "----Actor2D----"
  },
  imgBgLevelSelect = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  ContentRoot = {
    sCtrlName = "Game.UI.Activity.BdConvert._500001.BdConvertContentCtrl"
  },
  BuildRoot = {
    sCtrlName = "Game.UI.Activity.BdConvert._500001.BdConvertBuildCtrl"
  }
}
BdConvertCtrl._mapEventConfig = {
  BdConvert_JumpToBuildPanel = "OnEvent_JumpTo",
  BdConvert_Return = "OnEvent_ReturnTo",
  [EventId.UIBackConfirm] = "OnEvent_BackHome",
  [EventId.UIHomeConfirm] = "OnEvent_Home"
}
BdConvertCtrl._mapRedDotConfig = {}

function BdConvertCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
  self.animator = self.gameObject:GetComponent("Animator")
  self._mapNode.ContentRoot:SetData(self.nActId)
  self._mapNode.BuildRoot:SetData(self.nActId)
end

function BdConvertCtrl:OnEnable()
  local bUseL2D = LocalSettingData.mapData.UseLive2D
  self._mapNode.imgBgLevelSelect.transform.localScale = bUseL2D == true and Vector3.one or Vector3.zero
  self._mapNode.trActor2D_PNG.localScale = bUseL2D == true and Vector3.zero or Vector3.one
  if bUseL2D == true then
    Actor2DManager.SetBoardNPC2D(self:GetPanelId(), self._mapNode.imgBgLevelSelect, 9102)
  else
    Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.trActor2D_PNG, self:GetPanelId(), 9102)
  end
  if self._panel.nTab == nil then
    EventManager.Hit(EventId.TemporaryBlockInput, 0.7)
    self._panel.nTab = PanelTab.Content
    self.animator:Play("BdConVertPanel_ConentRoot_in")
    self:SwitchTab(self._panel.nTab)
    self._mapNode.ContentRoot:Refresh()
  elseif self._panel.nTab == PanelTab.Content then
    self._mapNode.BuildRoot.gameObject:SetActive(false)
    self._mapNode.ContentRoot.gameObject:SetActive(true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.7)
    self.animator:Play("BdConVertPanel_ConentRoot_in")
    self._mapNode.ContentRoot:Refresh()
  elseif self._panel.nTab == PanelTab.Build then
    self._mapNode.BuildRoot.gameObject:SetActive(true)
    self._mapNode.ContentRoot.gameObject:SetActive(false)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.7)
    self.animator:Play("BdConVertPanel_BuildRoot_in")
    self._mapNode.BuildRoot:Refresh(self.nOptionId, false)
  end
end

function BdConvertCtrl:OnDisable()
  Actor2DManager.UnsetBoardNPC2D()
end

function BdConvertCtrl:SwitchTab(nTab)
  if self._panel.nTab == nTab then
    return
  end
  self._panel.nTab = nTab
  if self._panel.nTab == PanelTab.Build then
    self._mapNode.BuildRoot.gameObject:SetActive(true)
    self._mapNode.ContentRoot.gameObject:SetActive(false)
  elseif self._panel.nTab == PanelTab.Content then
    self._mapNode.BuildRoot.gameObject:SetActive(false)
    self._mapNode.ContentRoot.gameObject:SetActive(true)
  end
end

function BdConvertCtrl:OnEvent_JumpTo(nOptionId)
  self.nOptionId = nOptionId
  self.animator:Play("BdConVertPanel_BuildRoot_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.7)
  self:SwitchTab(PanelTab.Build)
  self._mapNode.BuildRoot:Refresh(nOptionId, true)
end

function BdConvertCtrl:OnEvent_ReturnTo()
  self.animator:Play("BdConVertPanel_BuildRoot_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.7)
  self:SwitchTab(PanelTab.Content)
  self._mapNode.ContentRoot:Refresh()
end

function BdConvertCtrl:OnEvent_BackHome(nPanelId)
  if nPanelId == PanelId.BdConvertPanel then
    if self._panel.nTab == PanelTab.Content then
      self.animator:Play("BdConVertPanel_ConentRoot_out")
      EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
      self:AddTimer(1, 0.2, function()
        EventManager.Hit(EventId.ClosePanel, PanelId.BdConvertPanel)
      end, true, true, true, nil)
    elseif self._panel.nTab == PanelTab.Build then
      self._mapNode.BuildRoot:ClearTempData()
      self.animator:Play("BdConVertPanel_BuildRoot_out")
      EventManager.Hit(EventId.TemporaryBlockInput, 0.7)
      self:SwitchTab(PanelTab.Content)
      self._mapNode.ContentRoot:Refresh()
    end
  end
end

function BdConvertCtrl:OnEvent_Home(nPanelId)
  if nPanelId == PanelId.BdConvertPanel then
    PanelManager.Home()
  end
end

return BdConvertCtrl
