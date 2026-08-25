local WorldStageRemoveCardConfirm, Super = System.NewClass("WorldStageRemoveCardConfirm", UIBasePanel)
WorldStageRemoveCardConfirm.uiResCls = UI_Dbgcopy_Popup_Remove_CardResource

function WorldStageRemoveCardConfirm:ctor(showData, callback)
  Super.ctor(self)
  self.callback = callback
  self.showData = showData
end

function WorldStageRemoveCardConfirm:OnBind(binder)
  binder:BindZ1Button(self.ui.Btn_Comfirm, function()
    if self.callback then
      self.callback(true)
    end
    Super.Close(self)
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Common_Button_Confirm"
  end, nil, nil, nil)
  binder:BindZ1Button(self.ui.Btn_Cancel, function()
    self:Close()
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Common_Button_Cancel"
  end, nil, nil, nil)
  for i = 1, 3 do
    local uiNode = self.ui["Item_Card_Base_" .. i]
    if self.showData[i] then
      binder:SetActive(uiNode, true)
      local uid = self.showData[i]
      local configId = CardDataUtils.GetCardInfo(uid).configId
      binder:BindComponent(CardBaseComponent(uiNode, uid, configId))
    else
      binder:SetActive(uiNode, false)
    end
  end
end

function WorldStageRemoveCardConfirm:Close()
  if self.callback then
    self.callback(false)
  end
  Super.Close(self)
end

return WorldStageRemoveCardConfirm
