require("sp_base_inst")
_class("SkillPreviewPlayPickTrapBuffDamageOrSummonInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayPickTrapBuffDamageOrSummonInstruction = SkillPreviewPlayPickTrapBuffDamageOrSummonInstruction

function SkillPreviewPlayPickTrapBuffDamageOrSummonInstruction:Constructor(params)
  self._trapIDList = {}
  local trapList = params.trapIDList
  if trapList then
    local strIDs = string.split(trapList, "|")
    for i, v in ipairs(strIDs) do
      table.insert(self._trapIDList, tonumber(v))
    end
  end
  self._effectIDDic = {}
  if params.effectIDDic then
    local strIDs = string.split(params.effectIDDic, "|")
    for k, effectID in ipairs(strIDs) do
      self._effectIDDic[k] = tonumber(effectID)
    end
  end
  self._summonEffectID = tonumber(params.summonEffectID)
  self._checkBuffEffectType = tonumber(params.checkBuffEffectType)
end

function SkillPreviewPlayPickTrapBuffDamageOrSummonInstruction:GetCacheResource()
  local res = {}
  for i, effectID in pairs(self._effectIDDic) do
    local effRes = {
      Cfg.cfg_effect[effectID].ResPath,
      1
    }
    table.insert(res, effRes)
  end
  local effRes = {
    Cfg.cfg_effect[self._summonEffectID].ResPath,
    1
  }
  table.insert(res, effRes)
  return res
end

function SkillPreviewPlayPickTrapBuffDamageOrSummonInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local entitySvc = world:GetService("RenderEntity")
  local pickUpPos = previewContext:GetPickUpPos()
  local boardCmpt = world:GetBoardEntity():Board()
  local traps = boardCmpt:GetPieceEntities(pickUpPos, function(e)
    local isOwner = false
    local casterEntityID = casterEntity:GetID()
    if e:HasSummoner() then
      local summonEntityID = e:Summoner():GetSummonerEntityID()
      local summonEntity = e:GetSummonerEntity()
      if summonEntity and summonEntity:HasSuperEntity() and summonEntity:GetSuperEntity() then
        summonEntityID = summonEntity:GetSuperEntity():GetID()
      end
      if summonEntityID == casterEntityID then
        isOwner = true
      end
    else
      isOwner = true
    end
    return isOwner and e:HasTrapRender() and table.icontains(self._trapIDList, e:TrapRender():GetTrapID()) and not e:HasDeadMark()
  end)
  if 0 < #traps then
    local scopeResult, buffState = self:_GetScopeResultAndBuffState(previewContext, pickUpPos, traps[1], casterEntity)
    previewContext:SetScopeResult(scopeResult:GetAttackRange())
    local utilScopeSvc = world:GetService("UtilScopeCalc")
    local targetIDList = scopeResult:GetTargetIDs()
    previewContext:SetTargetEntityIDList(targetIDList)
    local effectID = self._effectIDDic[buffState]
    if effectID and 0 < effectID then
      local effectEntity = world:GetService("Effect"):CreateWorldPositionEffect(effectID, previewContext:GetPickUpPos())
      local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
      previewPickUpComponent:AddPickUpEffectEntityID(effectEntity:GetID())
    end
  else
    local effectEntity = world:GetService("Effect"):CreateWorldPositionEffect(self._summonEffectID, pickUpPos)
    local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
    previewPickUpComponent:AddPickUpEffectEntityID(effectEntity:GetID())
    previewContext:SetScopeResult(nil)
    local targetList = {}
    previewContext:SetTargetEntityIDList(targetList)
  end
end

function SkillPreviewPlayPickTrapBuffDamageOrSummonInstruction:_GetScopeResultAndBuffState(previewContext, pickUpPos, trap, casterEntity)
  local world = casterEntity:GetOwnerWorld()
  local previewEffectCalcService = world:GetService("PreviewCalcEffect")
  local effect = previewContext:GetEffect(SkillEffectType.PickUpTrapAndBuffDamage)
  local skillEffectParam = previewEffectCalcService:CreateSkillEffectParam(SkillEffectType.PickUpTrapAndBuffDamage, effect)
  local skillList = skillEffectParam:GetSkillList()
  local attackPos = pickUpPos
  local state = 0
  local utilSvc = world:GetService("UtilData")
  local buffLogicService = world:GetService("BuffLogic")
  local buffLayer = buffLogicService:GetBuffLayer(trap, self._checkBuffEffectType)
  state = buffLayer
  if state == 0 then
    return {}, state
  end
  if state > table.count(skillList) then
    state = table.count(skillList)
  end
  local skillID = skillList[state]
  local configService = world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, casterEntity)
  local scopeType = skillConfigData:GetSkillScopeType()
  local scopeParam = skillConfigData:GetSkillScopeParam()
  local centerType = skillConfigData:GetSkillScopeCenterType()
  local targetType = skillConfigData:GetSkillTargetType()
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local casterBodyArea = casterEntity:BodyArea():GetArea()
  local casterDirection = casterEntity:GetGridDirection()
  local scopeResult = scopeCalculator:ComputeScopeRange(scopeType, scopeParam, attackPos, casterBodyArea, casterDirection, targetType, attackPos, casterEntity)
  return scopeResult, state
end
