ChangePetChainSkillCondition = {
  None = 0,
  TargetInScope = 1,
  BySkillID = 2,
  San = 3
}
_class("BuffLogicChangePetChainSkill", BuffLogicBase)
BuffLogicChangePetChainSkill = BuffLogicChangePetChainSkill

function BuffLogicChangePetChainSkill:Constructor(buffInstance, logicParam)
  self._skillId = logicParam.skillId
  self._type = logicParam.type
  self._param = logicParam.param
  self._key = logicParam.key
  self._light = logicParam.light or 0
end

function BuffLogicChangePetChainSkill:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local cSkillInfo = e:SkillInfo()
  if not cSkillInfo then
    return
  end
  local chainSkillIDSelector = cSkillInfo:GetChainSkillIDSelector()
  if self._type == ChangePetChainSkillCondition.TargetInScope then
    local rule = chainSkillIDSelector:GetRule()
    local newRule = table_to_class(rule)
    if not self:IsConditionSatisfyTargetInScope(e, notify:GetChainCount()) then
      newRule[1].Skill = self._skillId
    end
    chainSkillIDSelector:AddRule(self._key, newRule)
  elseif self._type == ChangePetChainSkillCondition.BySkillID then
    local configService = self._world:GetService("Config")
    local rule = chainSkillIDSelector:GetRule()
    local newRule = table_to_class(rule)
    for i, v in ipairs(newRule) do
      local newSkillID = self._param[v.Skill]
      if newSkillID then
        v.Skill = newSkillID
        local skillConfigData = configService:GetSkillConfigData(newSkillID)
        v.Chain = skillConfigData:GetSkillTriggerParam()
      end
    end
    chainSkillIDSelector:AddRule(self._key, newRule)
  elseif self._type == ChangePetChainSkillCondition.San then
    local featureLogicSvc = self._world:GetService("FeatureLogic")
    if not featureLogicSvc then
      return
    end
    if not featureLogicSvc:HasFeatureType(FeatureType.Sanity) then
      return
    end
    local skillList = {}
    for k, v in pairs(self._param) do
      local skill = {}
      skill.chainCount = k
      skill.skill = v
      table.insert(skillList, skill)
    end
    table.sort(skillList, function(e1, e2)
      return e1.chainCount < e2.chainCount
    end)
    local curSanValue = featureLogicSvc:GetSanValue()
    local newSkillList = {}
    for i, v in pairs(skillList) do
      if curSanValue < v.chainCount then
        newSkillList = v.skill
        break
      end
    end
    local rule = chainSkillIDSelector:GetRule()
    local newRule = table_to_class(rule)
    for i, v in ipairs(newRule) do
      local newSkillID = newSkillList[i]
      if newSkillID then
        v.Skill = newSkillID
      end
    end
    chainSkillIDSelector:AddRule(self._key, newRule)
  end
  local ret = BuffResultChangePetChainSkill:New(self._light)
  return ret
end

function BuffLogicChangePetChainSkill:IsConditionSatisfyTargetInScope(e, chainCount)
  local teamEntiy = e:Pet():GetOwnerTeamEntity()
  local logicChainPathCmpt = teamEntiy:LogicChainPath()
  local chainPosList = logicChainPathCmpt:GetLogicChainPath()
  local cSkillInfo = e:SkillInfo()
  local utilData = self._world:GetService("UtilData")
  local chainExtraFix = utilData:GetEntityBuffValue(e, "ChangeExtraChainSkillReleaseFixForSkill")
  local chainSkillIdConfig = utilData:GetChainSkillByChainCount(e, chainCount, chainExtraFix)
  if chainSkillIdConfig <= 0 then
    return false
  end
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local sConfig = self._world:GetService("Config")
  local skillConfigData = sConfig:GetSkillConfigData(chainSkillIdConfig)
  local targetType = skillConfigData:GetSkillTargetType()
  local scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, chainPosList[#chainPosList], e, Vector2(0, 1))
  local targetIDList = utilScopeSvc:SelectSkillTarget(e, targetType, scopeResult)
  if targetIDList and 0 < table.count(targetIDList) then
    return true
  end
  return false
end

_class("BuffLogicChangePetChainSkillUndo", BuffLogicBase)
BuffLogicChangePetChainSkillUndo = BuffLogicChangePetChainSkillUndo

function BuffLogicChangePetChainSkillUndo:Constructor(buffInstance, logicParam)
  self._key = logicParam.key
  self._black = logicParam.black or 0
end

function BuffLogicChangePetChainSkillUndo:DoLogic()
  local e = self._buffInstance:Entity()
  local cSkillInfo = e:SkillInfo()
  local chainSkillIDSelector = cSkillInfo:GetChainSkillIDSelector()
  chainSkillIDSelector:RemoveRule(self._key)
  local ret = BuffResultChangePetChainSkillUndo:New(self._black)
  return ret
end
