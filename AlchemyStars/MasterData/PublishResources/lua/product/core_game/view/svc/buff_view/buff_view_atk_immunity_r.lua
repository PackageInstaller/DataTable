_class("BuffViewAtkImmunity", BuffViewBase)
BuffViewAtkImmunity = BuffViewAtkImmunity

function BuffViewAtkImmunity:PlayView(TT)
  if not self:ViewParams() then
    return
  end
  local effectID = self:ViewParams().LoadEffectID
  if not effectID then
    return
  end
  local sEffect = self._world:GetService("Effect")
  local e = self:Entity()
  local cEffectHolder = e:EffectHolder()
  local eEffect = sEffect:CreateEffect(effectID, e)
  local effEntityId = eEffect:GetID()
  cEffectHolder:AttachEffect("AtkImmunity", effEntityId)
end

_class("BuffViewRemoveAtkImmunity", BuffViewBase)
BuffViewRemoveAtkImmunity = BuffViewRemoveAtkImmunity

function BuffViewRemoveAtkImmunity:PlayView(TT)
  local sEffect = self._world:GetService("Effect")
  local e = self:Entity()
  local cEffectHolder = e:EffectHolder()
  local effects = cEffectHolder:GetEffectList("AtkImmunity")
  if effects and table.count(effects) > 0 then
    for _, effId in ipairs(effects) do
      sEffect:DestroyEffectByID(effId)
    end
  end
end
