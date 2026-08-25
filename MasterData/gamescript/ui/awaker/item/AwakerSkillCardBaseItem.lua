local AwakerSkillCardBaseItem, Super = System.NewComponent("AwakerSkillCardBaseItem", CardBaseComponent)

function AwakerSkillCardBaseItem:OnBeginDrag(pointerData)
end

function AwakerSkillCardBaseItem:OnDrag(pointerData)
end

function AwakerSkillCardBaseItem:OnPointerLong(pointerData)
  if self.longPressedCallback then
    self.longPressedCallback()
  end
end

return AwakerSkillCardBaseItem
