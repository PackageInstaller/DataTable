local CraftingTipCtrl = class("CraftingTipCtrl", BaseCtrl)
CraftingTipCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  goWindow = {},
  animWindow = {sNodeName = "goWindow", sComponentName = "Animator"},
  txtTitle = {
    sNodeName = "txtWindowTitle",
    sComponentName = "TMP_Text",
    sLanguageId = "UITitle_Crafting"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnBg = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  bgRing = {},
  goMatProduction = {
    sNodeName = "---MatProduction---",
    sCtrlName = "Game.UI.Crafting.MatCraftingCtrl"
  }
}
CraftingTipCtrl._mapEventConfig = {
  CloseCraftingTipPanel = "Close",
  PlayCraftingAnim = "OnEvent_PlayCraftingAnim",
  [EventId.JumpToSuccess] = "OnEvent_JumpTo",
  SetCraftingEmpty = "OnEvent_SetCraftingEmpty"
}

function CraftingTipCtrl:RefreshContent()
  local tbCfg = ConfigTable.GetData("Production", self.nProductionId)
  local nGroupId = tbCfg.Group
  local tbProductionList = PlayerData.Crafting:GetProductionListByGroup(nGroupId)
  if nil ~= tbProductionList then
    self._mapNode.goMatProduction:RefreshProductionList(tbProductionList, self.nProductionId)
  end
end

function CraftingTipCtrl:Close(callback)
  self.closeCallback = callback
  self._mapNode.animWindow:Play("t_window_04_t_out")
  self._mapNode.imgBlurredBg:SetActive(false)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self:AddTimer(1, 0.3, "OnCloseAnimFinish", true, true, true)
end

function CraftingTipCtrl:OnCloseAnimFinish()
  EventManager.Hit(EventId.ClosePanel, PanelId.CraftingTip)
  if nil ~= self.closeCallback then
    self.closeCallback()
  end
end

function CraftingTipCtrl:Awake()
  local tbParams = self:GetPanelParam()
  if type(tbParams) == "table" then
    self.nProductionId = tbParams[1]
  end
end

function CraftingTipCtrl:OnEnable()
  self._mapNode.safeAreaRoot.gameObject:SetActive(false)
  self._mapNode.imgBlurredBg.gameObject:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.safeAreaRoot.gameObject:SetActive(true)
    self._mapNode.animWindow:Play("t_window_04_t_in")
  end
  
  cs_coroutine.start(wait)
  self:RefreshContent()
end

function CraftingTipCtrl:OnDisable()
end

function CraftingTipCtrl:OnDestroy()
end

function CraftingTipCtrl:OnBtnClick_Close()
  self:Close()
end

function CraftingTipCtrl:OnEvent_PlayCraftingAnim(callback)
  self._mapNode.animRoot:Play("CraftingPanel_make", 0, 0)
  CS.WwiseAudioManager.Instance:PostEvent("ui_craft_effect")
  local nAnimLength = 0.5
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLength)
  if nil ~= callback then
    self:AddTimer(1, nAnimLength, callback, true, true, true)
  end
end

function CraftingTipCtrl:OnEvent_JumpTo(nType)
  if nType ~= GameEnum.jumpType.Crafting then
    self:Close()
  end
end

function CraftingTipCtrl:OnEvent_SetCraftingEmpty(bEmpty)
  self._mapNode.bgRing:SetActive(not bEmpty)
end

return CraftingTipCtrl
