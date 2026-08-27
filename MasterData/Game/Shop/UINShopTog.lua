local UINShopTog = class("UINShopTog", UIBaseNode)
local base = UIBaseNode

function UINShopTog:OnInit()
  local oringinalSize = self.transform.sizeDelta
  local target = Vector2.New(1.0666666666666667 * oringinalSize.x, oringinalSize.y)
  self.extendTween = self.transform:DOSizeDelta(target, 0.25):SetAutoKill(false):Pause()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_taskPageTog, self, self.OnValueChage)
end

function UINShopTog:InitShopTog(shopCfg, openPageCallback)
  self.shopId = shopCfg.id
  self.openPageCallback = openPageCallback
  self.ui.tex_TypeName.text = LanguageUtil.GetLocaleText(shopCfg.name)
  self.ui.tex_TypeEN.text = LanguageUtil.GetLocaleText(shopCfg.name_en)
end

function UINShopTog:OnValueChage(bool)
  if bool then
    self.ui.tex_TypeName.color = self.ui.color_black
    self.ui.tex_TypeEN.color = self.ui.color_black
    self.extendTween:PlayForward()
    self.ui.img_Select:SetIndex(1)
    if self.openPageCallback ~= nil then
      self.openPageCallback(self.shopId)
    end
  else
    self.ui.tex_TypeName.color = self.ui.color_gray
    self.ui.tex_TypeEN.color = self.ui.color_gray
    self.extendTween:PlayBackwards()
    self.ui.img_Select:SetIndex(0)
  end
end

function UINShopTog:SetSelected(bool)
  self.ui.tog_taskPageTog.isOn = bool
end

function UINShopTog:OnDelete()
  base.OnDelete(self)
end

return UINShopTog
