local typeof = _ENV.typeof
local Z1Button = CS.Z1Client.Z1Button
local CommonFilterListItem, Super = System.NewComponent("CommonFilterListItem")

function CommonFilterListItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Common_Filter_List_ItemResource(uiNode)
  self.tid = data.tid
  self.name = data.name
  self.selectedFunc = data.selectedFunc
  self.callback = data.callback
end

function CommonFilterListItem:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick))
  binder:BindToText(self.ui.Text_Name, function()
    return self.name
  end)
  binder:BindToTextColor(self.ui.Text_Name, function()
    return self.selectedFunc(self.tid) and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark
  end)
  binder:BindToRaw(function(_, nVal, _)
    local z1BtnObj = self.ui.Btn_Click:GetComponent(typeof(Z1Button))
    z1BtnObj.BtnState = nVal and CommonDefine.Z1ButtonState.High or CommonDefine.Z1ButtonState.Normal
  end, function()
    do return self.selectedFunc end
    return self.selectedFunc, self.tid
  end)
end

function CommonFilterListItem:OnClick()
  if self.callback then
    self.callback(self.tid)
  end
end

return CommonFilterListItem
