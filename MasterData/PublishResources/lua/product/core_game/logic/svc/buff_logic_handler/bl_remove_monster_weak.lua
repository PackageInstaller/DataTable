require("buff_logic_base")
_class("BuffLogicRemoveMonsterWeak", BuffLogicBase)
BuffLogicRemoveMonsterWeak = BuffLogicRemoveMonsterWeak

function BuffLogicRemoveMonsterWeak:DoLogic(notify)
  local ownerEntity = self:GetEntity()
  if not ownerEntity:HasMonsterWeak() then
    return
  end
  ownerEntity:RemoveMonsterWeak()
  return true
end
