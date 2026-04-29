require("base_ins_r")
_class("PlaySelectGridEffectInstruction", BaseInstruction)
PlaySelectGridEffectInstruction = PlaySelectGridEffectInstruction

function PlaySelectGridEffectInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._intervalTime = tonumber(paramList.intervalTime)
end

function PlaySelectGridEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  if not scopeResult then
    return
  end
  local pieceSvc = world:GetService("Piece")
  local pieceArray = {}
  local pieceCount = 0
  local array = scopeResult:GetAttackRange()
  if array then
    pieceCount = table.count(array)
    for _, v in pairs(array) do
      local gridEntity = pieceSvc:FindPieceEntity(v)
      table.insert(pieceArray, gridEntity)
    end
  end
  if pieceCount == 0 then
    return
  end
  local effectService = world:GetService("Effect")
  for _, piece in pairs(pieceArray) do
    local renderPos = piece:Location().Position
    local effectEntity = effectService:CreatePositionEffect(self._effectID, renderPos)
    YIELD(TT, self._intervalTime)
  end
end

function PlaySelectGridEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
