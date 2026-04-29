require("base_ins_r")
_class("PlayTrainAttackInstruction", BaseInstruction)
PlayTrainAttackInstruction = PlayTrainAttackInstruction

function PlayTrainAttackInstruction:Constructor(paramList)
  self._attackCount = tonumber(paramList.AttackCount)
  self._oneDamageTime = tonumber(paramList.OneDamageTime)
  self._randomPercent = tonumber(paramList.RandomPercent)
end

function PlayTrainAttackInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local castPos = casterEntity:GridLocation().Position
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if damageResultArray == nil then
    return
  end
  self._formatList = {}
  local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  for _, v in ipairs(damageResultArray) do
    local format = {}
    local damageResult = v
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    local damageInfo = damageResult:GetDamageInfo(1)
    local damagePos = damageResult:GetGridPos()
    if targetEntity then
      format.damageResult = damageResult
      format.attackCount = self._attackCount
      format.playDamage = false
      local damageInfoList, damageStageValueList = utilCalcSvc:DamageInfoSplitMultiStage(damageInfo, self._attackCount, 1, self._randomPercent)
      format.damageInfoList = damageInfoList
      format.damageStageValueList = damageStageValueList
      table.insert(self._formatList, format)
    end
  end
  if table.count(self._formatList) == 0 then
    return
  end
  local listTask = {}
  for i, format in ipairs(self._formatList) do
    local nTask, nTaskDamage = self:PlayDamage(casterEntity, format)
    table.insert(listTask, nTask)
    table.insert(listTask, nTaskDamage)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(listTask) do
    YIELD(TT)
  end
end

function PlayTrainAttackInstruction:PlayDamage(casterEntity, curFormat)
  local damageResult = curFormat.damageResult
  local damageInfo = damageResult:GetDamageInfo(1)
  local damageInfoList = curFormat.damageInfoList
  local damageStageValueList = curFormat.damageStageValueList
  for i = 1, #damageInfoList do
    damageInfoList[i]:SetShowType(DamageShowType.Grid)
  end
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageGridPos = damageResult:GetGridPos()
  local targetId = damageResult:GetTargetID()
  local targetEntity = self._world:GetEntityByID(targetId)
  local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
  local playSkillService = self._world:GetService("PlaySkill")
  local playDamageSvc = self._world:GetService("PlayDamage")
  local nTask = GameGlobal.TaskManager():CoreGameStartTask(playSkillService.HandleBeHitMultiStage, playSkillService, casterEntity, targetEntity, "Hit", nil, damageInfoList, damageGridPos, 0, isFinalAttack, skillID, damageStageValueList, self._oneDamageTime)
  local nTaskDamage = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    local intervalCount = table.count(damageStageValueList) - 1
    YIELD(TT, self._oneDamageTime * intervalCount)
    playDamageSvc:UpdateTargetHPBar(TT, targetEntity, damageInfo)
    playDamageSvc:_OnHpChangeNotifyBuff(TT, targetEntity, damageInfo:GetChangeHP(), damageInfo)
  end)
  return nTask, nTaskDamage
end
