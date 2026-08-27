local UINCampFetterItem = class("UINCampFetterItem", UIBaseNode)
local base = UIBaseNode

function UINCampFetterItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.heroIconWidth = self.ui.img_NeedHeroCount.sizeDelta.x
end

function UINCampFetterItem:InitCampFetterItem(campId, count, neededHeroCount, resloader)
  local cfg = ConfigData.camp_connection[campId][neededHeroCount]
  local isUnlock = count >= cfg.fetters_num
  local isActive = cfg.is_show_active ~= 0
  self.ui.img_Icon.sprite = AtlasUtil.GetSpriteFromAtlas(UIAtlasConsts.Atlas_CampFetterIcon, cfg.icon, resloader)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(cfg.name)
  self.ui.tex_Detail.text = LanguageUtil.GetLocaleText(cfg.text)
  if isActive then
    self.ui.tex_Attri:SetIndex(1)
    self.ui.img_attri.color = self.ui.color_orange
  else
    self.ui.tex_Attri:SetIndex(0)
    self.ui.img_attri.color = Color.black
  end
  self:__RefreshUnlock(isUnlock, neededHeroCount)
  self:__RefreshHeroIcon(neededHeroCount)
end

function UINCampFetterItem:__RefreshUnlock(isUnlock, neededHeroCount)
  self.ui.obj_IsEffective:SetActive(isUnlock)
  self.ui.obj_tex_Tips:SetActive(not isUnlock)
  if isUnlock then
    self.ui.img_bondEffDetailItem:SetIndex(0)
    self.ui.canvasGroup.alpha = 1
    self.ui.tex_Name.color = Color.black
    self.ui.tex_Detail.color = Color.black
  else
    self.ui.img_bondEffDetailItem:SetIndex(1)
    self.ui.tex_Tips:SetIndex(0, tostring(neededHeroCount))
    self.ui.canvasGroup.alpha = 0.3
    self.ui.tex_Name.color = Color.white
    self.ui.tex_Detail.color = Color.white
  end
end

function UINCampFetterItem:__RefreshHeroIcon(neededHeroCount)
  local width = self.heroIconWidth * neededHeroCount
  self.ui.img_NeedHeroCount.sizeDelta = Vector3.New(width, self.ui.img_NeedHeroCount.sizeDelta.y)
end

function UINCampFetterItem:OnDelete()
  base.OnDelete(self)
end

return UINCampFetterItem
