local this = class("moduleElementalRestraint", G_UIModuleBase)
local elementTypeTpl = L_GameTpl:getElementTypeTpl()
local heroTpl = L_GameTpl:getHeroTpl()

function this.bind()
  return {
    elementActiveText = "",
    activeValueText = "",
    elementPassiveText = "",
    passiveValueText = "",
    tipsText = "",
    titleText = "",
    elementList = {
      moduleName = "pages/elementalRestraint/cellElementIcon"
    }
  }
end

function this:methods()
  return {}
end

function this:initUI(elements)
  self.selectedElements = elements
  if not self.selectedElements then
    self.selectedElements = {}
  end
  self.bind.titleText = L_WordsTpl:getValue("ui_elemental_restraint_title")
  self.bind.tipsText = L_WordsTpl:getValue("ui_elemental_restraint_tips")
  self.bind.activeValueText = L_WordsTpl:getValue("ui_elemental_restraint_active_value")
  self.bind.passiveValueText = L_WordsTpl:getValue("ui_elemental_restraint_passive_value")
  self.bind.elementActiveText = L_WordsTpl:getValue("ui_elemental_restraint_element_active")
  self.bind.elementPassiveText = L_WordsTpl:getValue("ui_elemental_restraint_element_passive")
  local elementListData = {}
  for i = 0, 9 do
    local tpl = elementTypeTpl:getTplById(i)
    local cell = self.bindComponents.elementText:GetChild(i)
    if cell then
      local elementName = cell:GetComponent(typeof(C_LTextMeshProUGUI))
      if cell then
        elementName.text = elementTypeTpl:getAbbrName(tpl)
      end
    end
    local _, color = C_ColorUtility.TryParseHtmlString(elementTypeTpl:getElementColor(tpl))
    table.insert(elementListData, {
      elementId = i,
      icon = elementTypeTpl:getPetPuzzleIcon(tpl, 2),
      iconColor = color,
      ringColor = color,
      iconBgActive = table.containsValue(self.selectedElements, i)
    })
  end
  self.bind.elementList:clear()
  self.bind.elementList:insert_array(elementListData)
end

function this:initModule(tplId)
  if tplId then
    local tpl = heroTpl:getTplById(tplId)
    self.selectedElements = {
      heroTpl:getElement(tpl)
    }
    local subElement = heroTpl:getSubElement(tpl)
    if subElement ~= nil and 0 < subElement then
      table.insert(self.selectedElements, subElement)
    end
  end
  self:initUI(self.selectedElements)
end

function this:playAnim()
  self.parent.bindComponents.anim:Play("anim_elementalrestraint_torestraint")
end

return this
