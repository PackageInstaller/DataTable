local base = UIBaseNode
local UINActLbInteractItem = class("UINActLbInteractItem", base)

function UINActLbInteractItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Interact, self, self._OnInteractBtnClick)
end

function UINActLbInteractItem:InitActLbInteractItem(intrctAction, atlas)
  self._intrctAction = intrctAction
  self.ui.tex_Title.text = intrctAction:GetLbIntrctActionName()
  self.ui.tex_Des.text = intrctAction:GetLbIntrctActionSubName()
  local spriteName = intrctAction:GetLbIntrctActionIconName()
  self.ui.icon.sprite = AtlasUtil.GetResldSprite(atlas, spriteName)
  spriteName = intrctAction:GetLbIntrctActionSmallIconName()
  self.ui.interactIcon.sprite = AtlasUtil.GetResldSprite(atlas, spriteName)
  self.ui.img_Buttom.color = Color.white
  self.ui.info:SetActive(false)
  self.ui.obj_Progress:SetActive(false)
  self.ui.obj_Lock:SetActive(false)
  intrctAction:InvokeLbIntrctActionUIInit(self)
end

function UINActLbInteractItem:SetActLbIntrctItemHighlight()
  local colorTable = self._intrctAction:GetLbInterctActionHighLightColor()
  if colorTable and 0 < #colorTable then
    self.ui.img_Buttom.color = Color.Temp(colorTable[1] / 255, colorTable[2] / 255, colorTable[3] / 255, 1)
    return
  end
  self.ui.img_Buttom.color = self.ui.col_Highlight
end

function UINActLbInteractItem:_OnInteractBtnClick()
  if self._intrctAction ~= nil then
    self._intrctAction:InvokeLbIntrctAction()
  end
end

function UINActLbInteractItem:SetSetActLbIntrctItemProgress(progressStr)
  self.ui.info:SetActive(true)
  self.ui.obj_Progress:SetActive(true)
  self.ui.tex_Progress.text = progressStr
end

function UINActLbInteractItem:SetSetActLbIntrctItemLock()
  self.ui.info:SetActive(true)
  self.ui.obj_Lock:SetActive(true)
end

function UINActLbInteractItem:OnDelete()
  base.OnDelete(self)
end

return UINActLbInteractItem
