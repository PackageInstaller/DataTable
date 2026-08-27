local UINAdjCareerFilterItem = class("UINAdjCareerFilterItem", UIBaseNode)
local base = UIBaseNode
local COLOR_UNSELECT = Color.New(0.10980392156862745, 0.10980392156862745, 0.10980392156862745, 1)

function UINAdjCareerFilterItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_kindItem, self, self.OnClickFilter)
end

function UINAdjCareerFilterItem:InitAdjCareerFilterItem(career, callback)
  self._callback = callback
  self._career = career
  self._isSelect = false
  local campCfg = ConfigData.career[self._career]
  self.ui.tex_KindName.text = LanguageUtil.GetLocaleText(campCfg.name)
  self.ui.img_Career.sprite = CRH:GetSprite(campCfg.icon, CommonAtlasType.CareerCamp)
  self:__RefreshSelectState()
end

function UINAdjCareerFilterItem:ResetAdjCareerFilterItem()
  self._isSelect = false
  self:__RefreshSelectState()
end

function UINAdjCareerFilterItem:OnClickFilter()
  self._isSelect = not self._isSelect
  self:__RefreshSelectState()
  if self._callback ~= nil then
    self._callback(self._career, self._isSelect)
  end
end

function UINAdjCareerFilterItem:__RefreshSelectState()
  self.ui.obj_OnSelect:SetActive(self._isSelect)
  if self._isSelect then
    self.ui.img_Career.color = COLOR_UNSELECT
    self.ui.tex_KindName.color = COLOR_UNSELECT
  else
    self.ui.img_Career.color = Color.white
    self.ui.tex_KindName.color = Color.white
  end
end

return UINAdjCareerFilterItem
