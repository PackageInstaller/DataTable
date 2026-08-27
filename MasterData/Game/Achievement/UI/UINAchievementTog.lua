local UINAchievementTog = class("UINAchievementTog", UIBaseNode)
local base = UIBaseNode

function UINAchievementTog:OnInit()
  local oringinalSize = self.transform.sizeDelta
  local target = Vector2.New(1.0666666666666667 * oringinalSize.x, oringinalSize.y)
  self.extendTween = self.transform:DOSizeDelta(target, 0.25):SetAutoKill(false):Pause()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_achieveTypeItem, self, self.OnValueChage)
end

function UINAchievementTog:InitAchieveTog(achieveTypeCfg, openPageCallback)
  self.type = achieveTypeCfg.type
  self.task_type = achieveTypeCfg.task_type
  self.openPageCallback = openPageCallback
  self.ui.tex_TypeName.text = LanguageUtil.GetLocaleText(achieveTypeCfg.name)
  self.ui.tex_TypeEN.text = tostring(achieveTypeCfg.english_name)
end

function UINAchievementTog:OnValueChage(bool)
  if bool then
    self.ui.tex_TypeName.color = self.ui.color_black
    self.ui.tex_TypeEN.color = self.ui.color_black
    self.extendTween:PlayForward()
    self.ui.img_Select:SetIndex(1)
    if self.openPageCallback ~= nil then
      self.openPageCallback(self.type)
    end
  else
    self.ui.tex_TypeName.color = self.ui.color_gray
    self.ui.tex_TypeEN.color = self.ui.color_gray
    self.extendTween:PlayBackwards()
    self.ui.img_Select:SetIndex(0)
  end
end

function UINAchievementTog:SetSelected(bool)
  self.ui.tog_achieveTypeItem.isOn = bool
end

function UINAchievementTog:SetRedDot(bool)
  self.ui.obj_RedDot:SetActive(bool)
end

function UINAchievementTog:OnDelete()
  base.OnDelete(self)
end

return UINAchievementTog
