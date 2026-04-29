_class("SkillEffectCalc_ButterflySummon", SkillEffectCalc_Base)
SkillEffectCalc_ButterflySummon = SkillEffectCalc_ButterflySummon

function SkillEffectCalc_ButterflySummon:DoSkillEffectCalculator(skillEffectCalcParam)
  local effectParam = skillEffectCalcParam:GetSkillEffectParam()
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local casterPos = casterEntity:GetGridPosition()
  local effectCalcService = self._world:GetService("SkillEffectCalc")
  local summonPosArray = {}
  local resultArray = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local wishSummonPos
    local damageResult = skillEffectResultContainer:GetEffectResultByTargetID(SkillEffectType.Damage, targetID)
    local targetEntity = self._world:GetEntityByID(targetID)
    if damageResult and targetEntity then
      local targetPos = targetEntity:GetGridPosition()
      local dir = targetPos - casterPos
      if dir.x > 0 then
        dir.x = 1
      elseif dir.x < 0 then
        dir.x = -1
      end
      if 0 < dir.y then
        dir.y = 1
      elseif 0 > dir.y then
        dir.y = -1
      end
      wishSummonPos = targetPos - dir
      local summonValidPos = effectCalcService:_FindSummonPos(SkillEffectEnum_SummonType.Monster, {wishSummonPos}, effectParam:GetSummonID(), summonPosArray, nil, true)
      if summonValidPos then
        local result = SkillEffectResult_SummonEverything:New(SkillEffectEnum_SummonType.Monster, effectParam:GetSummonID(), casterPos, summonValidPos)
        table.insert(resultArray, result)
        table.insert(summonPosArray, summonValidPos)
      end
    else
      local calcInfo = {
        up = {
          distance = -1,
          grids = {}
        },
        down = {
          distance = -1,
          grids = {}
        },
        left = {
          distance = -1,
          grids = {}
        },
        right = {
          distance = -1,
          grids = {}
        }
      }
      for _, v2 in ipairs(skillEffectCalcParam.skillRange) do
        self:_ChallengeFarthestPos(calcInfo, casterPos, v2)
      end
      local t = {}
      for _, v2 in ipairs(calcInfo.up.grids) do
        if not table.Vector2Include(t, v2) then
          table.insert(t, v2)
        end
      end
      for _, v2 in ipairs(calcInfo.down.grids) do
        if not table.Vector2Include(t, v2) then
          table.insert(t, v2)
        end
      end
      for _, v2 in ipairs(calcInfo.left.grids) do
        if not table.Vector2Include(t, v2) then
          table.insert(t, v2)
        end
      end
      for _, v2 in ipairs(calcInfo.right.grids) do
        if not table.Vector2Include(t, v2) then
          table.insert(t, v2)
        end
      end
      for _, v2 in ipairs(t) do
        local summonValidPos = effectCalcService:_FindSummonPos(SkillEffectEnum_SummonType.Monster, {v2}, effectParam:GetSummonID(), summonPosArray, nil, true)
        if summonValidPos then
          local result = SkillEffectResult_SummonEverything:New(SkillEffectEnum_SummonType.Monster, effectParam:GetSummonID(), casterPos, summonValidPos)
          table.insert(resultArray, result)
          table.insert(summonPosArray, summonValidPos)
        end
      end
    end
  end
  return resultArray
end

local function isRangeDirMatch(v2, centerPos, dir)
  local sub = v2 - centerPos
  if sub.x > 0 then
    sub.x = 1
  elseif sub.x < 0 then
    sub.x = -1
  end
  if 0 < sub.y then
    sub.y = 1
  elseif 0 > sub.y then
    sub.y = -1
  end
  return sub == dir
end

function SkillEffectCalc_ButterflySummon:_ChallengeFarthestPos(info, centerPos, v2)
  local dirInfo
  if isRangeDirMatch(v2, centerPos, Vector2.up) then
    dirInfo = info.up
  elseif isRangeDirMatch(v2, centerPos, Vector2.down) then
    dirInfo = info.down
  elseif isRangeDirMatch(v2, centerPos, Vector2.left) then
    dirInfo = info.left
  elseif isRangeDirMatch(v2, centerPos, Vector2.right) then
    dirInfo = info.right
  end
  if not dirInfo then
    Log.fatal("SkillEffectCalc_ButterflySummon: unrecognized dir. pos=", v2, " centerPos=", centerPos)
    return
  end
  local dis = Vector2.Distance(centerPos, v2)
  if dis > dirInfo.distance then
    dirInfo.grids = {v2}
  elseif dirInfo.distance == dis then
    table.insert(dirInfo.grids, v2)
  end
end
