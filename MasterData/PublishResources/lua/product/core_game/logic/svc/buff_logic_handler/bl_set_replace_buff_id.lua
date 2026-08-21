_class("BuffLogicSetReplaceBuffID", BuffLogicBase)
BuffLogicSetReplaceBuffID = BuffLogicSetReplaceBuffID

function BuffLogicSetReplaceBuffID:Constructor(buffInstance, logicParam)
  self._buffEffectType = logicParam.buffEffectType
  self._replaceBuffID = logicParam.replaceBuffID
end

function BuffLogicSetReplaceBuffID:DoLogic()
  local ownerEntity = self:GetEntity()
  local buffComp = ownerEntity:BuffComponent()
  if not buffComp then
    return
  end
  local key = string.format(BattleConst.BVK_ReplaceBuffIDFormat, self._buffEffectType)
  buffComp:SetBuffValue(key, self._replaceBuffID)
end
