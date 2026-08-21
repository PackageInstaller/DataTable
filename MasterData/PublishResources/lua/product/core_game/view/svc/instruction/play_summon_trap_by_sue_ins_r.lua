require("base_ins_r")
_class("PlaySummonTrapBySummonEveryThingInstruction", BaseInstruction)
PlaySummonTrapBySummonEveryThingInstruction = PlaySummonTrapBySummonEveryThingInstruction

function PlaySummonTrapBySummonEveryThingInstruction:Constructor(paramList)
  self._trapID = tonumber(paramList.trapID)
  self._effectID = tonumber(paramList.effectID)
  self._interval = tonumber(paramList.interval)
end

function PlaySummonTrapBySummonEveryThingInstruction:GetCacheResource()
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

function PlaySummonTrapBySummonEveryThingInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local summonResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonEverything)
  if summonResultArray then
    for i = 1, #summonResultArray do
      local summonRes = summonResultArray[i]
      local summonType = summonRes:GetSummonType()
      local summonTrapID = summonRes:GetSummonID()
      if summonType == SkillEffectEnum_SummonType.Trap and self._trapID == summonTrapID then
        self:_ShowTrapFromSummonEverything(TT, world, summonRes)
      end
    end
  end
end

function PlaySummonTrapBySummonEveryThingInstruction:_ShowTrapFromSummonEverything(TT, world, summonRes)
  local summonMonsterData = summonRes:GetTrapData()
  local posSummon = summonRes:GetSummonPos()
  local summonTrapID = summonRes:GetSummonID()
  local trapEntity = world:GetEntityByID(summonMonsterData.m_entityWorkID)
  if not trapEntity then
    Log.error(self._className, "trap not found: ", tostring(posSummon), " id=", summonTrapID)
    return
  end
  self:_ShowTrap(TT, world, trapEntity, posSummon)
end

function PlaySummonTrapBySummonEveryThingInstruction:_ShowTrap(TT, world, trapEntity, posSummon)
  trapEntity:SetPosition(posSummon)
  local trapServiceRender = world:GetService("TrapRender")
  trapServiceRender:CreateSingleTrapRender(TT, trapEntity, true)
  if self._effectID and self._effectID > 0 then
    local effectService = world:GetService("Effect")
    effectService:CreateWorldPositionDirectionEffect(self._effectID, posSummon)
  end
end
