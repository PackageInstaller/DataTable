require("base_ins_r")
_class("PlayGridEffectAttackRangeInstruction", BaseInstruction)
PlayGridEffectAttackRangeInstruction = PlayGridEffectAttackRangeInstruction

function PlayGridEffectAttackRangeInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  local dirParam = tonumber(paramList.effectDir)
  self._effectDir = Vector2(0, 1)
  if dirParam == EffectDirectionType.Up then
    self._effectDir = Vector2(0, 1)
  elseif dirParam == EffectDirectionType.Right then
    self._effectDir = Vector2(1, 0)
  elseif dirParam == EffectDirectionType.Down then
    self._effectDir = Vector2(0, -1)
  elseif dirParam == EffectDirectionType.Left then
    self._effectDir = Vector2(-1, 0)
  end
end

function PlayGridEffectAttackRangeInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end

function PlayGridEffectAttackRangeInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local utilDataSvc = world:GetService("UtilData")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local gridArray = scopeResult:GetAttackRange()
  for i, pos in ipairs(gridArray) do
    if utilDataSvc:IsValidPiecePos(pos) and not utilDataSvc:IsPosBlock(pos, BlockFlag.Skill | BlockFlag.SkillSkip) then
      effectService:CreateWorldPositionDirectionEffect(self._effectID, pos, self._effectDir)
    end
  end
end
