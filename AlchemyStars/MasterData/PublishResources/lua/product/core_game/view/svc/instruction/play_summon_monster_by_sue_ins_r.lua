require("base_ins_r")
_class("PlaySummonMonsterBySummonEveryThingInstruction", BaseInstruction)
PlaySummonMonsterBySummonEveryThingInstruction = PlaySummonMonsterBySummonEveryThingInstruction

function PlaySummonMonsterBySummonEveryThingInstruction:Constructor(paramList)
  self._monsterID = tonumber(paramList.monsterID)
  self._fromCage = tonumber(paramList.fromCage)
  self._cageSummonDelayTime = tonumber(paramList.cageSummonDelayTime)
  self._cageSummonMoveTime = tonumber(paramList.cageSummonMoveTime)
  self._cageSummonUnderDis = tonumber(paramList.cageSummonUnderDis)
  self._cageSummonMatAnim = paramList.cageSummonMatAnim
end

function PlaySummonMonsterBySummonEveryThingInstruction:GetCacheResource()
  local t = {}
  return t
end

function PlaySummonMonsterBySummonEveryThingInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local sPlaySkillInstruction = world:GetService("PlaySkillInstruction")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local summonResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonEverything)
  if not summonResultArray then
    return
  end
  local isFromCage = false
  if self._fromCage and self._fromCage == 1 then
    isFromCage = true
  end
  local listWaitTask = {}
  for i = 1, #summonResultArray do
    local summonRes = summonResultArray[i]
    summonRes:SetRenderIsFromCage(isFromCage)
    if isFromCage then
      local renderParam = RenderSummonFromCageParam:New()
      renderParam.cageSummonDelayTime = self._cageSummonDelayTime
      renderParam.cageSummonMoveTime = self._cageSummonMoveTime
      renderParam.cageSummonUnderDis = self._cageSummonUnderDis
      renderParam.cageSummonMatAnim = self._cageSummonMatAnim
      summonRes:SetRenderFromCageParam(renderParam)
    end
    local summonType = summonRes:GetSummonType()
    local summonMonsterID = summonRes:GetSummonID()
    local checkIDPass = false
    if self._monsterID then
      if self._monsterID == summonMonsterID then
        checkIDPass = true
      end
    else
      checkIDPass = true
    end
    if summonType == SkillEffectEnum_SummonType.Monster and checkIDPass then
      local nTaskID = GameGlobal.TaskManager():CoreGameStartTask(sPlaySkillInstruction.ShowSummonAction, sPlaySkillInstruction, world, summonRes)
      table.insert(listWaitTask, nTaskID)
    end
  end
  if table.count(listWaitTask) > 0 then
    while not TaskHelper:GetInstance():IsAllTaskFinished(listWaitTask) do
      YIELD(TT)
    end
  end
end
