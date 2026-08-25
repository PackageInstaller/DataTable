local EventMgr = require("Managers.EventManager.EventMgr")
local CopiesBagTapBtnComponent, Super = System.NewComponent("CopiesBagTapBtnComponent")

function CopiesBagTapBtnComponent:ctor(res, textCN, textEN)
  Super.ctor(self)
  self.ui = Item_Dungeons_Bag_CareerListResource(res)
  self.textCN = textCN or ""
  self.textEN = textEN or ""
  self.selected = Vue.ref(false)
  self.callback = nil
end

function CopiesBagTapBtnComponent:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Selected_CN, self.textCN)
  binder:SetText(self.ui.Text_Normal_CN, self.textCN)
  binder:SetText(self.ui.Text_Normal_EN, self.textEN)
  binder:BindToRaw(function(_, nowVal, _)
    binder:SetActive(self.ui.Group_Selected, nowVal)
    binder:SetActive(self.ui.Group_Normal, not nowVal)
  end, function()
    return self.selected.value
  end)
  binder:BindButtonClick(self.ui.Btn_CareerList_Click, System.fn(self, self.OnClickCallback))
end

function CopiesBagTapBtnComponent:SetCallback(callback)
  self.callback = callback
end

function CopiesBagTapBtnComponent:OnClickCallback()
  if self.callback then
    self.callback()
  end
end

function CopiesBagTapBtnComponent:SetSelect(bool)
  self.selected.value = bool
end

return CopiesBagTapBtnComponent
