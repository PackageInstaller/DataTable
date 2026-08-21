require("base_ins_r")
_class("AbyssEffectInstruction", BaseInstruction)
AbyssEffectInstruction = AbyssEffectInstruction

function AbyssEffectInstruction:Constructor(paramList)
  self._effectMask = tonumber(paramList.effectMask)
  self._effectBottom = tonumber(paramList.effectBottom)
  self._effectSide = tonumber(paramList.effectSide)
end

function AbyssEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  self._casterEntity = casterEntity
  if not casterEntity:HasTrapID() then
    return
  end
  local cEffectHolder = casterEntity:EffectHolder()
  if not cEffectHolder then
    casterEntity:AddEffectHolder()
  end
  cEffectHolder = casterEntity:EffectHolder()
  local sEffect = self._world:GetService("Effect")
  local pieceSvc = self._world:GetService("Piece")
  local bodyArea = casterEntity:BodyArea():GetArea()
  local cGridLocation = casterEntity:GridLocation()
  local pos, dir = cGridLocation.Position, cGridLocation.Direction
  local len = table.count(bodyArea)
  local keyMask = "AbssyMask"
  local keyBottom = "AbssyBottom"
  local dir = Vector2(0, 1)
  local truePosList = {}
  for i = 1, len do
    local truePos = bodyArea[i] + pos
    local ePiece = pieceSvc:FindPieceEntity(truePos)
    ePiece:View():GetGameObject():SetActive(false)
    local effEntityMask = sEffect:CreateWorldPositionEffect(self._effectMask, truePos)
    local effEntityIdMask = effEntityMask:GetID()
    cEffectHolder:AttachEffect(keyMask, effEntityIdMask)
    local effEntityBottom = sEffect:CreateWorldPositionEffect(self._effectBottom, truePos)
    effEntityBottom:SetLocationHeight(effEntityBottom:Location():Height() + BattleConst.AbyssBottomDepth)
    local effEntityIdBottom = effEntityBottom:GetID()
    cEffectHolder:AttachEffect(keyBottom, effEntityIdBottom)
    table.insert(truePosList, truePos)
  end
  local ersvc = self._world:GetService("RenderEntity")
  ersvc:CreateSideEffects(truePosList, self._effectSide, Vector3(1, BattleConst.GridSideYScale, 1))
end

function AbyssEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectMask and self._effectMask > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectMask].ResPath,
      1
    })
  end
  if self._effectBottom and 0 < self._effectBottom then
    table.insert(t, {
      Cfg.cfg_effect[self._effectBottom].ResPath,
      1
    })
  end
  if self._effectSide and 0 < self._effectSide then
    table.insert(t, {
      Cfg.cfg_effect[self._effectSide].ResPath,
      1
    })
  end
  return t
end
