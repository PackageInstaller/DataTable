local UINChristmasBtn = class("UINChristmasBtn", UIBaseNode)
local base = UIBaseNode

function UINChristmasBtn:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickRootBtn)
end

function UINChristmasBtn:InitChristmasBtn(callback)
  self._callback = callback
end

function UINChristmasBtn:OnClickRootBtn()
  if self._callback ~= nil then
    self._callback()
  end
end

function UINChristmasBtn:SetChristmasBtnRed(flag)
  if IsNull(self.ui.redDot) then
    if isGameDev then
      error(" redDot Miss ")
    end
    return
  end
  self.ui.redDot:SetActive(flag)
end

function UINChristmasBtn:SetChristmasBtnBlue(flag)
  if IsNull(self.ui.blueDot) then
    if isGameDev then
      error(" redDot Miss ")
    end
    return
  end
  self.ui.blueDot:SetActive(flag)
end

return UINChristmasBtn
