local UINActSum22ShopPage = class("UINActSum22ShopPage", UIBaseNode)
local base = UIBaseNode

function UINActSum22ShopPage:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.pageItem, self, self.OnClickPage)
end

function UINActSum22ShopPage:InitSum22ShopPage(shopId, callback)
  self._shopId = shopId
  self._callback = callback
  local shopCfg = ConfigData.shop[shopId]
  self.ui.tex_PageName.text = LanguageUtil.GetLocaleText(shopCfg.name)
end

function UINActSum22ShopPage:RefreshSum22ShopPageState(shopId)
  local flag = self._shopId == shopId
  self.ui.selected:SetActive(flag)
  if flag then
    self.ui.tex_PageName.color = self.ui.color_tex_selected
  else
    self.ui.tex_PageName.color = self.ui.color_tex_unselect
  end
end

function UINActSum22ShopPage:OnClickPage()
  if self._callback ~= nil then
    self._callback(self._shopId, self)
  end
end

return UINActSum22ShopPage
