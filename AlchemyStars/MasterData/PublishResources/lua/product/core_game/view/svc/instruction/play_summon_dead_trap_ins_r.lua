require("base_ins_r")
_class("PlaySummonDeadTrapInstruction", BaseInstruction)
PlaySummonDeadTrapInstruction = PlaySummonDeadTrapInstruction

function PlaySummonDeadTrapInstruction:Constructor(paramList)
  self._trapID = tonumber(paramList.trapID)
  self._effectID = tonumber(paramList.effectID)
  self._interval = tonumber(paramList.interval)
  self._materialAnim = tonumber(paramList.materialAnim)
end

function PlaySummonDeadTrapInstruction:GetCacheResource()
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

function PlaySummonDeadTrapInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  if not skillEffectResultContainer then
    return
  end
  local trapResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonTrap)
  if trapResultArray then
    for i = 1, #trapResultArray do
      local result = trapResultArray[i]
      local summonTrapID = result:GetTrapID()
      if summonTrapID == self._trapID then
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
  end
end

function PlaySummonDeadTrapInstruction:_ShowTrapFromSummonTrap(TT, world, result)
  local posSummon = result:GetPos()
  local dirSummon = result:GetDir()
  local trapID = result:GetTrapID()
  local entityIDList = result:GetTrapIDList()
  if #entityIDList == 0 then
    return
  end
  local trapEntity
  for _, entityID in ipairs(entityIDList) do
    local eTrap = world:GetEntityByID(entityID)
    local cTrap = eTrap:TrapID()
    if cTrap and cTrap:GetTrapID() == trapID then
      self:_ShowTrap(TT, world, eTrap, posSummon, dirSummon)
    end
  end
end

function PlaySummonDeadTrapInstruction:_ShowTrap(TT, world, trapEntity, posSummon, dirSummon)
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
  if self._materialAnim then
    trapEntity:PlayMaterialAnim(self._materialAnim)
  end
end
