require("play_skill_phase_base_r")
_class("PlaySkillMultiStageDamagePhase", PlaySkillPhaseBase)
PlaySkillMultiStageDamagePhase = PlaySkillMultiStageDamagePhase

function PlaySkillMultiStageDamagePhase:PlayFlight(TT, casterEntity, phaseParam)
  local effectParam = phaseParam
  local turnToTarget = effectParam:GetTurnToTarget()
  local hitAnimName = effectParam:GetHitAnimName()
  local hitEffectID = effectParam:GetHitEffectID()
  local stageCount = effectParam:GetStageCount()
  local intervalTime = effectParam:GetIntervalTime()
  local random = effectParam:GetRandom()
  local randomPercent = effectParam:GetRandomPercent()
  local castPos = casterEntity:GridLocation().Position
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
  if isFinalAttack then
    local targetEntityID = self:_SortDistanceForFinalAttack(castPos, damageResultArray)
    skillEffectResultContainer:SetFinalAttackEntityID(targetEntityID)
  end
  if damageResultArray == nil then
    return
  end
  local hasTargetDamageResultArray = {}
  for _, v in ipairs(damageResultArray) do
    local damageResult = v
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    if targetEntity then
      table.insert(hasTargetDamageResultArray, damageResult)
    end
  end
  if table.count(hasTargetDamageResultArray) == 0 then
    return
  end
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local playSkillService = self._world:GetService("PlaySkill")
  local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
  local listTask = {}
  for i = 1, table.count(hasTargetDamageResultArray) do
    local damageResult = hasTargetDamageResultArray[i]
    local damageInfo = damageResult:GetDamageInfo(1)
    local nTargetID = damageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(nTargetID)
    local damageGridPos = damageResult:GetGridPos()
    local damageInfoList, damageStageValueList = utilCalcSvc:DamageInfoSplitMultiStage(damageInfo, stageCount, random, randomPercent)
    local nTask = GameGlobal.TaskManager():CoreGameStartTask(playSkillService.HandleBeHitMultiStage, playSkillService, casterEntity, targetEntity, hitAnimName, hitEffectID, damageInfoList, damageGridPos, turnToTarget, isFinalAttack, skillID, damageStageValueList, intervalTime)
    table.insert(listTask, nTask)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(listTask) do
    YIELD(TT)
  end
end

function PlaySkillMultiStageDamagePhase:_SortDistanceForFinalAttack(castPos, damageResultArray)
  local function CmpDistancefunc(res1, res2)
    local dis1 = math.abs(castPos.x - res1:GetGridPos().x) + math.abs(castPos.y - res1:GetGridPos().y)
    
    local dis2 = math.abs(castPos.x - res2:GetGridPos().x) + math.abs(castPos.y - res2:GetGridPos().y)
    return dis1 > dis2
  end
  
  table.sort(damageResultArray, CmpDistancefunc)
  for _, v in ipairs(damageResultArray) do
    local result = v
    local targetEntityID = result:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    if targetEntity:HasDeadFlag() then
      return targetEntityID
    end
  end
end
