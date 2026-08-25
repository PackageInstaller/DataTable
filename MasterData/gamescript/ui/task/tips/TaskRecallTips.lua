local TaskRecallTips, Super = System.NewClass("TaskRecallTips", UIBasePanel)
TaskRecallTips.uiResCls = UI_Task_Popup_Recall_TipsResource

function TaskRecallTips:ctor(clickCb, awakerList)
  Super.ctor(self)
  self.clickCb = clickCb
  self.awakerList = awakerList
end

function TaskRecallTips:OnBind(binder)
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.OnConfirmClick),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end,
    text = LT.Text("Task_Dispatch_Callback_ConfirmBtn")
  }
  local cancelBtnTipsData = {
    clickFunc = function()
      self:Close()
    end,
    stateFunc = function()
      return CommonDefine.BtnType.High
    end,
    text = LT.Text("Task_Dispatch_Callback_CancelBtn")
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    textTitleCN = LT.Text("Task_Dispatch_Callback_Title")
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_S, commonPopupConfirmTipsData))
  binder:BindToText(self.ui.Text_Tips, function()
    do return LT.Text end
    return LT.Text, "Task_Dispatch_Callback_Desc1"
  end)
  binder:BindToText(self.ui.Text_Tips2, function()
    do return LT.Text end
    return LT.Text, "Task_Dispatch_Callback_Desc2"
  end)
  binder:BindToText(self.ui.Text_Tips3, function()
    do return LT.Text end
    return LT.Text, "Task_Dispatch_Callback_Desc3"
  end)
  
  local function inValidAwakerTid(awakerTid)
    return nil == awakerTid or 0 == awakerTid
  end
  
  for i = 1, 6 do
    local obj = self.ui["Awaker" .. i]
    local awakerTid = self.awakerList[i]
    binder:BindToVisible(obj, function()
      return not inValidAwakerTid(awakerTid)
    end)
    binder:BindToVisible(self.ui["Image_Bg" .. i], function()
      return not inValidAwakerTid(awakerTid)
    end)
    if not inValidAwakerTid(awakerTid) then
      local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
      local level = awakerData.level or 1
      local itemData = {
        awakerId = awakerTid,
        itemCount = string.format("LV.%s", level)
      }
      binder:BindComponent(CommonIconItemType2(obj, itemData))
    end
  end
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
end

function TaskRecallTips:OnConfirmClick()
  if self.clickCb then
    self.clickCb()
  end
  self:Close()
end

return TaskRecallTips
