_class("BuffLogicRemoveMoveScopeRecordCmpt", BuffLogicBase)
BuffLogicRemoveMoveScopeRecordCmpt = BuffLogicRemoveMoveScopeRecordCmpt

function BuffLogicRemoveMoveScopeRecordCmpt:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveMoveScopeRecordCmpt:DoLogic()
  local e = self._buffInstance:Entity()
  if e:HasMoveScopeRecord() then
    e:RemoveMoveScopeRecord()
    Log.debug("BuffLogicRemoveMoveScopeRecordCmpt remove moveScopeRecord cmpt , entity=", e:GetID())
  end
end
