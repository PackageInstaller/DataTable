local UINHalloweenBounsCycleItem = class("UINHalloweenBounsCycleItem", UIBaseNode)
local base = UIBaseNode

function UINHalloweenBounsCycleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.image, self, self.OnClickConfirm)
end

function UINHalloweenBounsCycleItem:InitBounsCycleItem(hallowmasData, callback)
  self._data = hallowmasData
  self._callback = callback
  self._cycleExpLimit = self._data:GetHallowmasCycleExpLimit()
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(self._data:GetHallowmasMainCfg().cir_des)
  self:RefreshBounsCycleItem()
end

function UINHalloweenBounsCycleItem:RefreshBounsCycleItem()
  local curLevel = self._data:GetHallowmasLv()
  local maxLevel = self._data:GetHallowmasLvLimit()
  if curLevel < maxLevel then
    self.ui.canvasGroup.alpha = 0.9
    self.ui.tex_Num.text = "0"
    self.ui.img_ExpProgress.fillAmount = 0
    self.ui.tex_ExpProgress:SetIndex(0, "0", tostring(self._cycleExpLimit))
    return
  end
  self.ui.canvasGroup.alpha = 1
  local exp = self._data:GetHallowmasCurExp()
  local count = exp // self._cycleExpLimit
  local curExp = exp % self._cycleExpLimit
  self.ui.tex_Num.text = tostring(count)
  self.ui.img_ExpProgress.fillAmount = curExp / self._cycleExpLimit
  self.ui.tex_ExpProgress:SetIndex(0, tostring(curExp), tostring(self._cycleExpLimit))
end

function UINHalloweenBounsCycleItem:OnClickConfirm()
  if self._callback ~= nil then
    self._callback()
  end
end

return UINHalloweenBounsCycleItem
