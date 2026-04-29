require("base_ins_r")
_class("PlayCasterLaserGunAndExtendInstruction", BaseInstruction)
PlayCasterLaserGunAndExtendInstruction = PlayCasterLaserGunAndExtendInstruction

function PlayCasterLaserGunAndExtendInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._extendEffectID = tonumber(paramList.extendEffectID)
  self._extendWaitTime = tonumber(paramList.extendWaitTime) or 0
  self._limitExtendCount = tonumber(paramList.limitExtendCount) or 99
end

function PlayCasterLaserGunAndExtendInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local effectService = world:GetService("Effect")
  local effect = effectService:CreateEffect(self._effectID, casterEntity)
  YIELD(TT, self._extendWaitTime)
  local casterDir = casterEntity:GridLocation():GetGridDir()
  local casterrPos = casterEntity:GridLocation().Position
  local dirCross = {}
  if casterDir.x == 0 and casterDir.y ~= 0 then
    table.insert(dirCross, Vector2(1, 0))
    table.insert(dirCross, Vector2(-1, 0))
  elseif casterDir.x ~= 0 and casterDir.y == 0 then
    table.insert(dirCross, Vector2(0, 1))
    table.insert(dirCross, Vector2(0, -1))
  end
  local dirDoubleCross = {}
  table.insert(dirDoubleCross, Vector2(1, 1))
  table.insert(dirDoubleCross, Vector2(1, -1))
  table.insert(dirDoubleCross, Vector2(-1, 1))
  table.insert(dirDoubleCross, Vector2(-1, -1))
  local utilSvc = world:GetService("UtilData")
  local attackRange = {}
  local hadExtendCount = 0
  for i = 1, 9 do
    local nextPos = Vector2(casterrPos.x + i * casterDir.x, casterrPos.y + i * casterDir.y)
    if utilSvc:IsValidPiecePos(nextPos) then
      table.insert(attackRange, nextPos)
    end
  end
  local trapExtend = {}
  for _, pos in ipairs(attackRange) do
    local array = utilSvc:GetTrapsAtPos(pos)
    for _, eTrap in ipairs(array) do
      if eTrap:TrapRender() and not eTrap:HasDeadMark() and eTrap:HasTrapExtendSkillScope() then
        local entityID = eTrap:GetID()
        table.insert(trapExtend, eTrap)
        hadExtendCount = hadExtendCount + 1
      end
    end
    if hadExtendCount >= self._limitExtendCount then
      break
    end
  end
  for _, trapEntity in ipairs(trapExtend) do
    local trapExtendSkillScope = trapEntity:TrapExtendSkillScope()
    local scopeType = trapExtendSkillScope:GetScopeType()
    local scopeParam = trapExtendSkillScope:GetScopeParam()
    local pos = trapEntity:GridLocation().Position
    for _, dir in ipairs(dirCross) do
      effectService:CreateWorldPositionDirectionEffect(self._extendEffectID, pos, dir)
    end
    if scopeType == SkillScopeType.DoubleCross then
      for _, dir in ipairs(dirDoubleCross) do
        effectService:CreateWorldPositionDirectionEffect(self._extendEffectID, pos, dir)
      end
    end
  end
end

function PlayCasterLaserGunAndExtendInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  if self._extendEffectID and 0 < self._extendEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._extendEffectID].ResPath,
      4
    })
  end
  return t
end
