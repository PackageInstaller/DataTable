require("buff_logic_base")
_class("BuffLogicSelectTargetByLayer", BuffLogicBase)
BuffLogicSelectTargetByLayer = BuffLogicSelectTargetByLayer

function BuffLogicSelectTargetByLayer:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType
  self._saveDataName = logicParam.saveDataName
end

function BuffLogicSelectTargetByLayer:DoLogic(notify)
  local resultIDs = {}
  if notify:GetScopeResult() ~= nil then
    local scopeResult = notify:GetScopeResult()
    local tmp = scopeResult:GetTargetIDs()
    local targetIDs = {}
    for i = 1, #tmp do
      targetIDs[i] = tmp[i]
    end
    local svc = self._world:GetService("BuffLogic")
    local count = svc:GetBuffLayer(self._entity, self._layerType)
    local randomSvc = self._world:GetService("RandomLogic")
    while 0 < count and targetIDs and 0 < #targetIDs do
      local index = randomSvc:LogicRand(1, #targetIDs)
      local targetID = targetIDs[index]
      table.insert(resultIDs, targetID)
      table.remove(targetIDs, index)
      count = count - 1
    end
  end
  self._buffComponent:SetBuffValue(self._saveDataName, resultIDs)
  return #resultIDs ~= 0
end

_class("BuffLogicRemoveSelectTargetByLayer", BuffLogicBase)
BuffLogicRemoveSelectTargetByLayer = BuffLogicRemoveSelectTargetByLayer

function BuffLogicRemoveSelectTargetByLayer:Constructor(buffInstance, logicParam)
  self._saveDataName = logicParam.saveDataName
end

function BuffLogicRemoveSelectTargetByLayer:DoLogic(notify)
  self._buffComponent:SetBuffValue(self._saveDataName, nil)
end
