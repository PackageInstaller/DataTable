require("base_ins_r")
_class("PlaySummonTrapInstruction", BaseInstruction)
PlaySummonTrapInstruction = PlaySummonTrapInstruction

function PlaySummonTrapInstruction:Constructor(paramList)
  self._trapID = tonumber(paramList.trapID)
  self._effectID = tonumber(paramList.effectID)
  self._interval = tonumber(paramList.interval)
  self._hackWait = tonumber(paramList.hackWait)
  self._waitFinish = tonumber(paramList.waitFinish)
  self._skipTrapIDMatch = tonumber(paramList.skipTrapIDMatch)
end

function PlaySummonTrapInstruction:GetCacheResource()
  local t = {}
  if self._trapID then
    local cfgTrap = Cfg.cfg_trap[self._trapID]
    if cfgTrap then
      for i, resPath in ipairs(cfgTrap.ResPath) do
        table.insert(t, {resPath, 1})
      end
    end
  end
  if self._effectID then
    local cfgfx = Cfg.cfg_effect[self._effectID]
    if cfgfx then
      table.insert(t, {
        cfgfx.ResPath,
        1
      })
    end
  end
  return t
end

function PlaySummonTrapInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  if not skillEffectResultContainer then
    Log.error("PlaySummonTrap: result container is nil")
    return
  end
  local summonResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonEverything)
  if summonResultArray then
    for i = 1, #summonResultArray do
      local summonRes = summonResultArray[i]
      local summonType = summonRes:GetSummonType()
      local summonTrapID = summonRes:GetSummonID()
      if summonType == SkillEffectEnum_SummonType.Trap and (self._trapID == summonTrapID or self._skipTrapIDMatch == 1) then
        self:_ShowTrapFromSummonEverything(TT, world, summonRes)
        break
      end
    end
  end
  local trapResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonTrap)
  local trapResultArrayCount = 0
  if trapResultArray then
    for i = 1, #trapResultArray do
      local result = trapResultArray[i]
      local summonTrapID = result:GetTrapID()
      if summonTrapID == self._trapID or self._skipTrapIDMatch == 1 then
        do
          local index = i
          GameGlobal.TaskManager():CoreGameStartTask(function()
            if self._interval then
              YIELD(TT, (index - 1) * self._interval)
            end
            self:_ShowTrapFromSummonTrap(TT, world, result)
          end)
        end
      end
    end
    trapResultArrayCount = #trapResultArray
  end
  if self._waitFinish == 1 and 0 < trapResultArrayCount and self._interval then
    YIELD(TT, trapResultArrayCount * self._interval)
  end
end

function PlaySummonTrapInstruction:_ShowTrapFromSummonEverything(TT, world, summonRes)
  local summonMonsterData = summonRes:GetTrapData()
  local posSummon = summonRes:GetSummonPos()
  local trapEntity = world:GetEntityByID(summonMonsterData.m_entityWorkID)
  if not trapEntity then
    return
  end
  self:_ShowTrap(TT, world, trapEntity, posSummon)
end

function PlaySummonTrapInstruction:_ShowTrapFromSummonTrap(TT, world, result)
  local posSummon = result:GetPos()
  local dirSummon = result:GetDir()
  local trapID = result:GetTrapID()
  local entityIDList = result:GetTrapIDList()
  if #entityIDList == 0 then
    return
  end
  for _, entityID in ipairs(entityIDList) do
    local eTrap = world:GetEntityByID(entityID)
    if eTrap then
      local cTrap = eTrap:TrapID()
      local trapIDMatch = cTrap and cTrap:GetTrapID() == trapID or self._skipTrapIDMatch == 1
      if cTrap and trapIDMatch and not eTrap:HasDeadMark() then
        self:_ShowTrap(TT, world, eTrap, posSummon, dirSummon)
      end
    end
  end
end

function PlaySummonTrapInstruction:_ShowTrap(TT, world, trapEntity, posSummon)
  if self._hackWait then
    YIELD(TT)
  end
  trapEntity:SetPosition(posSummon)
  local trapServiceRender = world:GetService("TrapRender")
  trapServiceRender:CreateSingleTrapRender(TT, trapEntity, true)
  if self._effectID and self._effectID > 0 then
    local effectService = world:GetService("Effect")
    effectService:CreateWorldPositionDirectionEffect(self._effectID, posSummon)
  end
end

function PlaySummonTrapInstruction:_ShowTrap(TT, world, trapEntity, posSummon, dirSummon)
  if self._hackWait then
    YIELD(TT)
  end
  trapEntity:SetPosition(posSummon)
  if dirSummon then
    trapEntity:SetDirection(dirSummon)
  end
  local trapServiceRender = world:GetService("TrapRender")
  trapServiceRender:CreateSingleTrapRender(TT, trapEntity, true)
  if self._effectID and self._effectID > 0 then
    local effectService = world:GetService("Effect")
    effectService:CreateWorldPositionDirectionEffect(self._effectID, posSummon, dirSummon)
  end
end
