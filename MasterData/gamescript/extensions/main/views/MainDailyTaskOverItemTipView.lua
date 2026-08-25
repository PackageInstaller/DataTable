local MainDailyTaskOverItemTipView, Super = NewClass("MainDailyTaskOverItemTipView", BaseView)
MainDailyTaskOverItemTipView.uiResCls = UI_Main_Daily_OverItemTipResource

function MainDailyTaskOverItemTipView:ctor(data)
  Super.ctor(self)
  self.data = data
end

function MainDailyTaskOverItemTipView:RegisterNotifications()
end

function MainDailyTaskOverItemTipView:RegisterEvents()
end

function MainDailyTaskOverItemTipView:OnEnterView()
  Super.OnEnterView(self)
  self:_OnInitConfirmTipsComp()
end

function MainDailyTaskOverItemTipView:OnExitView()
  Super.OnExitView(self)
end

function MainDailyTaskOverItemTipView:_OnInitConfirmTipsComp()
  local confirmBtnTipsData = {}
  local cancelBtnTipsData = {}
  local viewData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Popup_Tips_Confirm_S, CompPublicPopupConfirmTips, viewData)
end

return MainDailyTaskOverItemTipView
