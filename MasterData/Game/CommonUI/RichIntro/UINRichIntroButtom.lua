local UINRichIntroButtom = class("UINRichIntroButtom", UIBaseNode)
local base = UIBaseNode

function UINRichIntroButtom:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_RichIntro, self, self.OnBtnClick)
end

function UINRichIntroButtom:InitRichIntroButtom(onClickCallBack, isTog)
  self._onClickCallBack = onClickCallBack
  self._isTog = isTog
  self:SwitchUIState(false)
end

function UINRichIntroButtom:SwitchUIState(isOn)
  self._isOn = isOn
  local idx = not (not self._isTog or isOn) and 1 or 0
  self.ui.img_RichIntro:SetIndex(idx)
  local iconCol = not (not self._isTog or isOn) and self.ui.col_IconWhite or self.ui.col_IconBlack
  self.ui.img_Icon.color = iconCol
end

function UINRichIntroButtom:SetIntroBtnActive(active)
  if IsNull(self.gameObject) then
    return
  end
  self.gameObject:SetActive(active)
end

function UINRichIntroButtom:OnBtnClick()
  if self._onClickCallBack ~= nil then
    self._onClickCallBack()
  end
end

function UINRichIntroButtom:OnDelete()
  base.OnDelete(self)
end

return UINRichIntroButtom
