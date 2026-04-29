require("buff_logic_base")
_class("BuffLogicTransferBuffLayer", BuffLogicBase)
BuffLogicTransferBuffLayer = BuffLogicTransferBuffLayer

function BuffLogicTransferBuffLayer:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._percent = logicParam.percent or 1
end

function BuffLogicTransferBuffLayer:DoLogic(notify)
  local curLayer = self._buffLogicService:GetBuffLayer(self._entity, self._layerType)
  if curLayer <= 0 then
    return
  end
  local transferLayer = math.floor(curLayer * self._percent)
  if transferLayer == 0 then
    return
  end
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local tarSelector = self._world:GetSkillScopeTargetSelector()
  local utilSvc = self._world:GetService("UtilData")
  local posList = utilSvc:GetCloneBoardGridPos()
  local skillScopeResult = SkillScopeResult:New(SkillScopeType.None, self._entity, posList, posList)
  local nearstTargetIDs = tarSelector:DoSelectSkillTarget(self._entity, SkillTargetType.NearestMonster, skillScopeResult)
  if #nearstTargetIDs < 1 then
    return
  end
  local targetID = nearstTargetIDs[1]
  local targetEntity = self._world:GetEntityByID(targetID)
  if targetEntity == nil then
    return
  end
  local newLayer, buffinst = self._buffLogicService:AddBuffLayer(targetEntity, self._layerType, transferLayer)
  if not buffinst then
    return
  end
  local buffResult = BuffResultLayer:New(newLayer, buffinst:BuffSeq(), transferLayer, self._layerType)
  buffResult:SetEntityID(targetID)
  return buffResult
end
