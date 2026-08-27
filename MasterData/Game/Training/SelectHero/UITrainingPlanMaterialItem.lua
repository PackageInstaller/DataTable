local UITrainingPlanMaterialItem = class("UITrainingPlanMaterialItem", UIBaseNode)
local base = UIBaseNode

function UITrainingPlanMaterialItem:OnInit()
  self.OnClickEvent = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.rootBtn, self, self.__OnClickRootButton)
  self:Select(false)
end

function UITrainingPlanMaterialItem:InitMatItem(resloader, id, time)
  self.id = id
  self.resloader = resloader
  if time < 2 then
    self.ui.img_framePic.color = HeroRareColor[eHeroCardRareType.R]
  elseif time == 2 then
    self.ui.img_framePic.color = HeroRareColor[eHeroCardRareType.SR]
  else
    self.ui.img_framePic.color = HeroRareColor[eHeroCardRareType.SSR]
  end
  local minutes = time
  local hours = math.floor(time / 60)
  local remainSeconds = time - hours * 60
  if hours == 0 then
    self.ui.tex_Time:SetIndex(1, tostring(minutes))
  elseif remainSeconds == 0 then
    self.ui.tex_Time:SetIndex(0, tostring(hours))
  else
    self.ui.tex_Time:SetIndex(2, tostring(hours), tostring(remainSeconds))
  end
end

function UITrainingPlanMaterialItem:Select(select)
  self.ui.img_OnClick:SetActive(select)
end

function UITrainingPlanMaterialItem:__OnClickRootButton()
  if self.OnClickEvent ~= nil then
    self.OnClickEvent(self.id)
  end
end

function UITrainingPlanMaterialItem:OnDelete()
  self.resloader = nil
  base.OnDelete(self)
end

return UITrainingPlanMaterialItem
