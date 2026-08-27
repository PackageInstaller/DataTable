local UINCampFetterTog = class("UINCampFetterTog", UIBaseNode)
local base = UIBaseNode

function UINCampFetterTog:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.singleWidth = self.ui.img_TakeEff.sizeDelta.x
  local oringinalSize = self.transform.sizeDelta
  local target = Vector2.New(1.0666666666666667 * oringinalSize.x, oringinalSize.y)
  self.extendTween = self.transform:DOSizeDelta(target, 0.25):SetAutoKill(false):Pause()
  UIUtil.AddValueChangedListener(self.ui.tog_CampItem, self, self.__OnValueChage)
end

function UINCampFetterTog:InitCampFetterTog(campId, count, triggerNum, clickEvent)
  self.gameObject.name = tostring(campId)
  self.campId = campId
  self.count = count
  self.clickEvent = clickEvent
  self:__RefreshTogNameAndNum(campId, count)
  self:__RefreshTriggerNum(triggerNum)
end

function UINCampFetterTog:__RefreshTogNameAndNum(campId, count)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(ConfigData.camp[campId].name)
  self.ui.texInfo_HeroCount:SetIndex(0, tostring(count))
end

function UINCampFetterTog:__RefreshTriggerNum(triggerNum)
  local width = self.singleWidth * triggerNum
  self.ui.img_TakeEff.sizeDelta = Vector3.New(width, self.ui.img_TakeEff.sizeDelta.y)
end

function UINCampFetterTog:__OnValueChage(bool)
  if bool then
    if self.clickEvent ~= nil then
      self.clickEvent(self.campId, self.count)
    end
    self.extendTween:PlayForward()
    self.ui.img_Select:SetIndex(1)
    self.ui.tex_Name.color = self.ui.color_selected
    self.ui.tex_HeroCount.color = self.ui.color_selected
  else
    self.extendTween:PlayBackwards()
    self.ui.img_Select:SetIndex(0)
    self.ui.tex_Name.color = self.ui.color_notSelected
    self.ui.tex_HeroCount.color = self.ui.color_notSelected
  end
end

function UINCampFetterTog:OnDelete()
  self.extendTween:Kill()
  base.OnDelete(self)
end

return UINCampFetterTog
