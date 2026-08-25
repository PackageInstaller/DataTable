local CostComponent, Super = System.NewComponent("CostComponent")

function CostComponent:ctor(res, itemTid, countExpOrFun, txtColorExpOrFn, clickCb)
  Super.ctor(self)
  self.ui = Com_CostResource(res)
  self.itemTid = itemTid
  self.countExpOrFun = countExpOrFun
  self.txtColorExpOrFn = txtColorExpOrFn
  self.callback = clickCb
end

function CostComponent:OnBind(binder)
  self.binder = binder
  if type(self.countExpOrFun) == "function" then
    binder:BindToText(self.ui.Text_Num, function()
      do return end
      return self.countExpOrFun, nil
    end)
  else
    binder:SetText(self.ui.Text_Num, self.countExpOrFun)
  end
  if self.txtColorExpOrFn then
    if "function" == type(self.txtColorExpOrFn) then
      binder:BindToTextColorOld(self.ui.Text_Num, self.txtColorExpOrFn)
    else
      binder:SetTextColorByHtml(self.ui.Text_Num, self.txtColorExpOrFn)
    end
  end
  if self.itemTid then
    binder:SetImage(self.ui.Image_Icon, ItemDataUtils.GetSmallIcon(self.itemTid), true)
  end
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick))
end

function CostComponent:OnClick()
  if self.callback then
    self.callback(self.itemTid)
  end
end

function CostComponent:ResetIcon(icon)
  if icon then
    self.binder:SetImage(self.ui.Image_Icon, function()
      return icon
    end)
  end
end

function CostComponent:ResetCount(count)
  self.binder:SetText(self.ui.Text_Num, function()
    return count
  end)
end

function CostComponent:ResetTextColor(colorHtml)
  self.binder:SetTextColorByHtml(self.ui.Text_Num, colorHtml)
end

return CostComponent
