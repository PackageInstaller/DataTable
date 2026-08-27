local UINHeroTalentBranch = class("UINHeroTalentBranch", UIBaseNode)
local base = UIBaseNode

function UINHeroTalentBranch:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.__OnClickSelect)
  self.defalutUnActiveAlpha = self.ui.canvasGroup_root.alpha
  self.defalutUnActiveColor = self.ui.tex_Att.color
end

function UINHeroTalentBranch:InitHeroTalentBranch(branchId, attridId, curVal, nextVal, clickCallback)
  self._branchId = branchId
  self._clickCallback = clickCallback
  if curVal == nil then
    curVal = 0
  end
  local name, curValStr, icon = ConfigData:GetAttribute(attridId, curVal)
  self.ui.img_Icon.sprite = CRH:GetSprite(icon)
  self.ui.tex_Att.text = LanguageUtil.GetLocaleText(name)
  if nextVal ~= nil then
    local _, nextValStr, _ = ConfigData:GetAttribute(attridId, nextVal)
    self.ui.tex_Addition:SetIndex(0, curValStr, nextValStr)
  else
    self.ui.tex_Addition:SetIndex(1, curValStr)
  end
end

function UINHeroTalentBranch:SetTalentBranckSelectState(selectBranchId)
  self.ui.img_root:SetIndex(self._branchId == selectBranchId and 1 or 0)
end

function UINHeroTalentBranch:SetTalentBranckActiveState(flag)
  self.ui.canvasGroup_root.alpha = flag and 1 or self.defalutUnActiveAlpha
  self.ui.tex_Att.color = flag and self.ui.activeColor or self.defalutUnActiveColor
  self.ui.tex_Addition.text.color = flag and self.ui.activeColor or self.defalutUnActiveColor
  self.ui.img_Icon.color = flag and self.ui.activeColor or self.defalutUnActiveColor
end

function UINHeroTalentBranch:__OnClickSelect()
  if self._clickCallback ~= nil then
    self._clickCallback(self._branchId)
  end
end

return UINHeroTalentBranch
