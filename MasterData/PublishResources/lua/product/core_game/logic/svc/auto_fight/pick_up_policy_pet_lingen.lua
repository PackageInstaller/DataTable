require("pick_up_policy_base")
_class("PickUpPolicy_PetLingEn", PickUpPolicy_Base)
PickUpPolicy_PetLingEn = PickUpPolicy_PetLingEn

function PickUpPolicy_PetLingEn:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local pickPosList = {}
  local attackPosList = {}
  local targetIdList = {}
  local layerType = policyParam.layerType
  local cfgLayerCount = policyParam.layerCountDamageOrBuff
  local cfgCanCastLayerCount = policyParam.layerCountDamage
  local svc = self._world:GetService("BuffLogic")
  local curLayerCount = svc:GetBuffLayer(petEntity, layerType)
  if cfgLayerCount and cfgLayerCount > curLayerCount then
    pickPosList[1] = petEntity:GetGridPosition():Clone()
    attackPosList = pickPosList
    targetIdList[1] = petEntity:GetID()
    return pickPosList, attackPosList, targetIdList
  end
  if cfgCanCastLayerCount and cfgCanCastLayerCount > curLayerCount then
    return pickPosList, attackPosList, targetIdList
  end
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local validResults = self:_CalcValidResultByPickUpType_PickUpPolicy(petEntity, activeSkillID, validPosList)
  if 0 < #validResults then
    table.sort(validResults, function(a, b)
      return #a[2] > #b[2]
    end)
    local t = validResults[1]
    if t then
      pickPosList[1] = t[1]
      table.appendArray(targetIdList, t[2])
      table.appendArray(attackPosList, t[3])
    end
  end
  return pickPosList, attackPosList, targetIdList
end
