local TrinketSuitPlaneSavedView, Super = NewClass("TrinketSuitPlaneSavedView", BaseView)
TrinketSuitPlaneSavedView.uiResCls = UI_Team_Popup_Tip_ChangeNameResource

function TrinketSuitPlaneSavedView:ctor(data)
  Super.ctor(self)
  self.suitPlanId = data.suitPlanId or 0
  self.trinkets = data.trinkets
  self.suitPlanName = data.suitPlanName
  self.onlyChangeName = data.onlyChangeName
end

function TrinketSuitPlaneSavedView:OnBuildView()
  self.confirmBtnState = Vue.ref(CommonDefine.BtnType.Unclickable)
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.OnConfirmClick),
    stateFunc = function()
      return self.confirmBtnState.value
    end
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.Close),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    textTitleCN = LT.Text("TrinketSuitSavedTitle")
  }
  self.binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_S, commonPopupConfirmTipsData))
  self:SetText(self.ui.Placeholder, self.suitPlanName or LT.Text("TrinketSuitSavedTips"))
  self.ui.Text_Old_Name:SetActive(false)
end

function TrinketSuitPlaneSavedView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnAwakerTrinketSuitPlanUpdate, self.Close, self)
  self:RegisterLocalNotify(NotifyId.OnAwakerTrinketSuitPlanUpdateFailed, self.Close, self)
end

function TrinketSuitPlaneSavedView:RegisterEvents()
  self:AddInputValueChangeListener(self.ui.InputField_Name, System.fn(self, self._OnInputValueChanged))
end

function TrinketSuitPlaneSavedView:OnEnterView()
  self:_UpdateBtnState()
end

function TrinketSuitPlaneSavedView:OnConfirmClick()
  local existId = AwakerTrinketExtModel.Instance:GetPlanIdByTrinkets(self.trinkets)
  if existId > 0 then
    local planData = AwakerTrinketExtModel.Instance:GetTrinketPlanData(existId)
    if planData.name == self.suitPlanName then
      self:Close()
      return
    end
  end
  if self.onlyChangeName then
    AwakerTrinketController.Instance:ReqChangeSuiPlanName(self.suitPlanId, self.suitPlanName, self.trinkets)
    return
  end
  AwakerTrinketController.Instance:UpdateAwakerTrinketSuitPlan(self.suitPlanId, self.suitPlanName, self.trinkets)
end

function TrinketSuitPlaneSavedView:_OnInputValueChanged(text)
  local lenMaxLimit = AwakerTrinketExtModel.Instance:GetPlanNameLenghtMax()
  local subStr = StrUtils.SubStr(text, lenMaxLimit)
  if subStr ~= text then
    self:SetInputText(self.ui.InputField_Name, subStr)
  end
  self.suitPlanName = subStr
  self:_UpdateBtnState()
end

function TrinketSuitPlaneSavedView:_UpdateBtnState()
  local isValid = AwakerTrinketExtModel.Instance:IsPlanNameLenValid(self.suitPlanName)
  if isValid then
    self.confirmBtnState.value = CommonDefine.BtnType.High
  else
    self.confirmBtnState.value = CommonDefine.BtnType.Unclickable
  end
end

return TrinketSuitPlaneSavedView
