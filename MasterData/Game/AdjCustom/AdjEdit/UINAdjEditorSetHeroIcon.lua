local UINAdjEditorSetHeroIcon = class("UINAdjEditorSetHeroIcon", UIBaseNode)
local base = UIBaseNode

function UINAdjEditorSetHeroIcon:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickHeroIcon)
end

function UINAdjEditorSetHeroIcon:InitAdjSetHeroIcon(heroId, callback)
  self._heroId = heroId
  self._callback = callback
  self.ui.img_UserHead.sprite = CRH:GetHeroSkinSprite(self._heroId)
  self.ui.isSelect:SetActive(false)
end

function UINAdjEditorSetHeroIcon:SetAdjHeroIconUsedState(flag)
  self.ui.isSelect:SetActive(flag)
end

function UINAdjEditorSetHeroIcon:OnClickHeroIcon()
  if self._callback ~= nil then
    self._callback(self._heroId)
  end
end

function UINAdjEditorSetHeroIcon:GetAdjHeroIconId()
  return self._heroId
end

return UINAdjEditorSetHeroIcon
