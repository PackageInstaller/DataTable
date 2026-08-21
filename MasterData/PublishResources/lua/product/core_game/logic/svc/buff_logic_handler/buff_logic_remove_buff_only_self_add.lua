_class("BuffLogicRemoveBuffOnlySelfAdd", BuffLogicBase)
BuffLogicRemoveBuffOnlySelfAdd = BuffLogicRemoveBuffOnlySelfAdd

function BuffLogicRemoveBuffOnlySelfAdd:Constructor(buffInstance, logicParam)
  self._buffEffectTypeList = logicParam.buffEffectTypeList
  self._targetType = logicParam.targetType
  self._targetParam = logicParam.targetParam
end

function BuffLogicRemoveBuffOnlySelfAdd:DoLogic(notify)
  local owner = self._buffInstance:Entity()
  local world = self._buffInstance:World()
  local buffSvc = world:GetService("BuffLogic")
  local es = buffSvc:CalcBuffTargetEntities(self._targetType, self._targetParam, owner)
  local result = BuffResultRemoveBuffOnlySelfAdd:New()
  for i, e in ipairs(es) do
    local buffComponent = e:BuffComponent()
    if buffComponent then
      local buffSeqIDs = {}
      local buffArray = buffComponent:GetBuffArray()
      local buffCopy = table.shallowcopy(buffArray)
      for _, buffInstance in ipairs(buffCopy) do
        local buffEffectType = buffInstance:GetBuffEffectType()
        if table.icontains(self._buffEffectTypeList, buffEffectType) then
          local context = buffInstance:Context()
          if context and context.casterEntity and context.casterEntity:GetID() == owner:GetID() then
            local buffSeqID = buffInstance:BuffSeq()
            table.insert(buffSeqIDs, buffSeqID)
          end
        end
      end
      for _, buffSeqID in ipairs(buffSeqIDs) do
        buffComponent:RemoveBuffBySeq(buffSeqID, NTBuffUnload:New())
      end
      result:AddRemovedInfo(e:GetID(), buffSeqIDs)
    end
  end
  local buffArray = result:GetBuffArray()
  if not buffArray or table.count(buffArray) == 0 then
    return
  end
  return result
end
