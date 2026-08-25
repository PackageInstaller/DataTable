local SummonSelectLimitPanel, Super = System.NewClass("SummonSelectLimitPanel", UIBasePanel)
SummonSelectLimitPanel.uiResCls = UI_Summon_Popup_SelectLimitResource

function SummonSelectLimitPanel:ctor(viewData)
  Super.ctor(self)
  self.viewData = viewData
  self.poolTid = viewData.poolTid
  self.confirmFunc = viewData.confirmFunc
  self.maxSelect = viewData.maxSelect or 1
  self.miniSelect = viewData.miniSelect or 1
  self.awakerItemTidList = viewData.awakerItemTidList or {}
end

function SummonSelectLimitPanel:OnBind(binder)
  self.binder = binder
  self:_BindEvent()
  self:_RefreshView()
  CameraManager:SetUICameraModel(true)
end

function SummonSelectLimitPanel:OnUnbind()
  CameraManager:SetUICameraModel(false)
end

function SummonSelectLimitPanel:_RefreshView()
  self:_RefreshDesc()
end

function SummonSelectLimitPanel:_RefreshDesc()
  local poolCfg = SummonDataUtils.GetSummonConfig(self.poolTid)
  local poolType = poolCfg and poolCfg.Type
  local descKey = "SummonType_" .. poolType .. "SelectPanelDesc"
  local descText = LT.Text(descKey)
  self.binder:SetText(self.ui.Text_Desc, descText)
end

function SummonSelectLimitPanel:_BindEvent()
  self.binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  self.binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self.binder:BindButtonClick(self.ui.Btn_Choose_1, System.fn(self, self._OnClickChooseSlot, 1))
  self.binder:BindButtonClick(self.ui.Btn_Choose_2, System.fn(self, self._OnClickChooseSlot, 2))
  self.binder:BindButtonClick(self.ui.Btn_Choose_3, System.fn(self, self._OnClickChooseSlot, 3))
  self.binder:BindButtonClick(self.ui.Btn_Choose_4, System.fn(self, self._OnClickChooseSlot, 4))
  self.binder:BindZ1Button(self.ui.Btn_Confirm, System.fn(self, self._OnClickConfirm), function()
    return CommonDefine.BtnType.High
  end)
  self.binder:BindEvent(EventMgr.Instance.OnChooseWishAwaker, System.fn(self, self._OnChooseWishAwaker))
end

function SummonSelectLimitPanel:_OnChooseWishAwaker()
  self:Close()
end

function SummonSelectLimitPanel:_OnClickChooseSlot(_)
  UIManager.Instance:Reopen(Urls.SummonOptionalLimitPanel, self.viewData)
end

function SummonSelectLimitPanel:_OnClickConfirm()
  UIManager.Instance:Reopen(Urls.SummonOptionalLimitPanel, self.viewData)
end

return SummonSelectLimitPanel
