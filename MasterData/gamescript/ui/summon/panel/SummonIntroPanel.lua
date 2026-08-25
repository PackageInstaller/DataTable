local SummonIntroPage = CommonDefine.SummonIntroPage
local UIAnimationController = CS.Z1Client.UIAnimationController
local SummonIntroPanel, Super = System.NewClass("SummonIntroPanel", UIBasePanel)
SummonIntroPanel.uiResCls = UI_Summon_Popup_Detail_TipResource

function SummonIntroPanel:ctor(model)
  Super.ctor(self)
  self.model = model
  self.model:InitCurrPage()
end

function SummonIntroPanel:OnBind(binder)
  binder:BindToVisible(self.ui.Btn_Up, function()
    do return self.model.GetUpPageActiveState end
    return self.model.GetUpPageActiveState, self.model
  end)
  binder:BindToZ1Toggle(self.ui.Btn_Up, nil, function(isOn)
    if isOn then
      self.model:SetCurrPage(SummonIntroPage.UP)
      self:_PlayToggleAnim(self.ui.Btn_Up)
    end
  end)
  binder:BindToZ1Toggle(self.ui.Btn_Detail, nil, function(isOn)
    if isOn then
      self.model:SetCurrPage(SummonIntroPage.DETAIL)
      self:_PlayToggleAnim(self.ui.Btn_Detail)
    end
  end)
  binder:BindToZ1Toggle(self.ui.Btn_Inventory, nil, function(isOn)
    if isOn then
      self.model:SetCurrPage(SummonIntroPage.INVENTORY)
      self:_PlayToggleAnim(self.ui.Btn_Inventory)
    end
  end)
  binder:BindToZ1Toggle(self.ui.Btn_Recording, nil, function(isOn)
    if isOn then
      SummonDataUtils.ReqSummonHistory(SummonDataUtils.GetLastSummonType(), 1, function()
        if not self.ui then
          return
        end
        self.model:SetCurrPage(SummonIntroPage.HISTORY)
        self:_PlayToggleAnim(self.ui.Btn_Recording)
      end)
    end
  end)
  binder:BindToRaw(function(_, page)
    binder:SetZ1Toggle(self.ui.Btn_Up, page == SummonIntroPage.UP)
    binder:SetZ1Toggle(self.ui.Btn_Detail, page == SummonIntroPage.DETAIL)
    binder:SetZ1Toggle(self.ui.Btn_Inventory, page == SummonIntroPage.INVENTORY)
    binder:SetZ1Toggle(self.ui.Btn_Recording, page == SummonIntroPage.HISTORY)
    self.ui.Group_Up:SetActive(page == SummonIntroPage.UP)
    self.ui.Group_Detail:SetActive(page == SummonIntroPage.DETAIL)
    self.ui.Group_Inventory:SetActive(page == SummonIntroPage.INVENTORY)
    self.ui.Group_Recording:SetActive(page == SummonIntroPage.HISTORY)
  end, function()
    do return self.model.GetCurrPage end
    return self.model.GetCurrPage, self.model
  end)
  binder:BindComponent(SummonIntroUpPage(self.ui.uiNode, self.model))
  binder:BindComponent(SummonIntroDetailPage(self.ui.uiNode, self.model))
  binder:BindComponent(SummonHistoryPage(self.ui.uiNode, self.model))
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function SummonIntroPanel:_PlayToggleAnim(toggleGO)
  local animController = toggleGO:GetComponent(typeof(UIAnimationController))
  animController:PlayState("UI_Summon_Popup_Detail_Tip_Btn_Select")
end

return SummonIntroPanel
