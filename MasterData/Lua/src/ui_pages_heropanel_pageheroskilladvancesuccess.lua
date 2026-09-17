local this = class("pageHeroSkillAdvanceSuccess", G_UIPageBase)
local heroTpl = L_GameTpl:getHeroTpl()
local skillTpl = L_GameTpl.getSkillTpl()
local elementTypeTpl = L_GameTpl.getElementTypeTpl()

function this.bind()
  return {
    img_skill = "",
    img_skillColorBg = C_Color.white,
    txt_skillLevel = "",
    list_property = {
      moduleName = "pages/HeroPanel/hero/heroProperty"
    }
  }
end

function this.methods()
  return {
    onClick_mask = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(option)
  this.super.preOpen(self, option)
  self:initSkillPreview(option.heroId, option.skillId)
  self:initProperty(option.propertyData)
end

function this:initSkillPreview(heroId, skillId)
  local elementId = 1
  local tpl_skill = skillTpl:getTplById(skillId)
  local elementList = skillTpl:getSkillElement(tpl_skill)
  if not table.isEmpty(elementList) and 0 < #elementList then
    elementId = elementList[1]
    elementId = self:translationElementId(elementId)
  end
  local tpl_element = elementTypeTpl:getTplById(elementId)
  local professionColorHtml = elementTypeTpl:getProfessionRectangleColor(tpl_element)
  local _, professionColor = C_ColorUtility.TryParseHtmlString(professionColorHtml)
  self.bind.img_skill = skillTpl:getIcon(tpl_skill)
  self.bind.img_skillColorBg = professionColor
  local hero = L_HeroStore:getHero(heroId)
  local skillList = L_HeroManager:getHeroSystemSkillList(hero)
  for _, v in ipairs(skillList) do
    if v.skillId == skillId then
      self.bind.txt_skillLevel = string.format("Lv.%s", v.skillLevel)
    end
  end
end

function this:initProperty(propertyData)
  local tmp = {}
  for k, v in ipairs(propertyData) do
    local isBgShow = math.floor(k % 2) > 0
    table.insert(tmp, {
      toggle_state = not isBgShow,
      name = v.name,
      active_icon = false,
      curAttr = v.curAttr,
      nextAttr = v.nextAttr,
      id = k
    })
  end
  self.bind.list_property:clear()
  self.bind.list_property:insert_array(tmp)
end

function this:translationElementId(skillElementId)
  local elementId = skillElementId
  if skillElementId == 2 then
    elementId = 6
  elseif skillElementId == 3 then
    elementId = 5
  elseif skillElementId == 4 then
    elementId = 7
  elseif skillElementId == 5 then
    elementId = 4
  elseif skillElementId == 6 then
    elementId = 2
  elseif skillElementId == 7 then
    elementId = 3
  elseif skillElementId == 10 then
    elementId = 0
  end
  return elementId
end

return this
