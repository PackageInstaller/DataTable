require("base_ins_r")
_class("AbyssEffectSpInstruction", BaseInstruction)
AbyssEffectSpInstruction = AbyssEffectSpInstruction
local AbyssEffectSpType = {
  Line = 1,
  Cross = 2,
  DoubleLine = 3,
  DoubleCross = 4
}
_enum("AbyssEffectSpType", AbyssEffectSpType)

function AbyssEffectSpInstruction:Constructor(paramList)
  self._effectMask = tonumber(paramList.effectMask)
  self._effectBottom = tonumber(paramList.effectBottom)
  self._effectSide = tonumber(paramList.effectSide)
  self._type = tonumber(paramList.type) or 1
  self._gridType = tonumber(paramList.gridType) or PieceType.None
end

function AbyssEffectSpInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  self._casterEntity = casterEntity
  local group = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local eTraps = group:GetEntities()
  local terrainAbyssEntity
  for k, entity in pairs(eTraps) do
    local trapRenderCmpt = entity:TrapRender()
    if trapRenderCmpt:GetTrapType() == TrapType.TerrainAbyss2 then
      terrainAbyssEntity = entity
    end
  end
  local cEffectHolder = terrainAbyssEntity:EffectHolder()
  if not cEffectHolder then
    terrainAbyssEntity:AddEffectHolder()
  end
  cEffectHolder = terrainAbyssEntity:EffectHolder()
  self:Destroy(cEffectHolder)
  local sEffect = self._world:GetService("Effect")
  local pieceSvc = self._world:GetService("Piece")
  local keyMask = "AbssyMask"
  local keyBottom = "AbssyBottom"
  local keySide = "AbyssSide"
  local truePosList = {}
  local posList = self:GetPosList(self._type)
  for i, pos in ipairs(posList) do
    local ePiece = pieceSvc:FindPieceEntity(pos)
    ePiece:View():GetGameObject():SetActive(false)
    local effEntityMask = sEffect:CreateWorldPositionEffect(self._effectMask, pos)
    local effEntityIdMask = effEntityMask:GetID()
    cEffectHolder:AttachEffect(keyMask, effEntityIdMask)
    local effEntityBottom = sEffect:CreateWorldPositionEffect(self._effectBottom, pos)
    effEntityBottom:SetLocationHeight(effEntityBottom:Location():Height() + BattleConst.SpAbyssBottomDepth)
    local effEntityIdBottom = effEntityBottom:GetID()
    cEffectHolder:AttachEffect(keyBottom, effEntityIdBottom)
    table.insert(truePosList, pos)
  end
  local playSkillSvc = self._world:GetService("PlaySkill")
  local ersvc = self._world:GetService("RenderEntity")
  local effectEntityList = ersvc:CreateSideEffects(truePosList, self._effectSide, Vector3(1, BattleConst.SpGridSideYScale, 1))
  for _, entity in ipairs(effectEntityList) do
    cEffectHolder:AttachEffect(keySide, entity:GetID())
  end
  local boardServiceR = self._world:GetService("BoardRender")
  local trapRender = self._world:GetService("TrapRender")
  trapRender:CreateSingleTrapRender(TT, terrainAbyssEntity)
  for i, pos in ipairs(truePosList) do
    boardServiceR:ReCreateGridEntity(self._gridType, pos, true)
    local ePiece = pieceSvc:FindPieceEntity(pos)
    ePiece:View():GetGameObject():SetActive(false)
  end
end

function AbyssEffectSpInstruction:GetPosList(type)
  local retPos = {}
  local utilData = self._world:GetService("UtilData")
  local maxLen = utilData:GetCurBoardMaxLen()
  if type == AbyssEffectSpType.Line then
    for i = 1, 9 do
      local pos = Vector2(i, 5)
      if utilData:IsValidPiecePos(pos) then
        table.insert(retPos, pos)
      end
    end
  elseif type == AbyssEffectSpType.Cross then
    for i = 1, 9 do
      local pos = Vector2(5, i)
      if utilData:IsValidPiecePos(pos) then
        table.insert(retPos, pos)
      end
    end
    for i = 1, 9 do
      local pos = Vector2(i, 5)
      if utilData:IsValidPiecePos(pos) and not table.Vector2Include(retPos, pos) then
        table.insert(retPos, pos)
      end
    end
  elseif type == AbyssEffectSpType.DoubleLine then
    for i = 1, maxLen do
      local pos = Vector2(i, 5)
      if utilData:IsValidPiecePos(pos) then
        table.insert(retPos, pos)
      end
    end
    for i = 1, maxLen do
      local pos = Vector2(i, 6)
      if utilData:IsValidPiecePos(pos) and not table.Vector2Include(retPos, pos) then
        table.insert(retPos, pos)
      end
    end
  elseif type == AbyssEffectSpType.DoubleCross then
    for i = 1, maxLen do
      local pos = Vector2(5, i)
      if utilData:IsValidPiecePos(pos) and not table.Vector2Include(retPos, pos) then
        table.insert(retPos, pos)
      end
    end
    for i = 1, maxLen do
      local pos = Vector2(6, i)
      if utilData:IsValidPiecePos(pos) and not table.Vector2Include(retPos, pos) then
        table.insert(retPos, pos)
      end
    end
    for i = 1, maxLen do
      local pos = Vector2(i, 5)
      if utilData:IsValidPiecePos(pos) and not table.Vector2Include(retPos, pos) then
        table.insert(retPos, pos)
      end
    end
    for i = 1, maxLen do
      local pos = Vector2(i, 6)
      if utilData:IsValidPiecePos(pos) and not table.Vector2Include(retPos, pos) then
        table.insert(retPos, pos)
      end
    end
  end
  return retPos
end

function AbyssEffectSpInstruction:Destroy(effectHolder)
  local dictEffectId = effectHolder:GetDictEffectId()
  if dictEffectId then
    for key, list in pairs(dictEffectId) do
      for index, id in ipairs(list) do
        local eEffect = self._world:GetEntityByID(id)
        if eEffect then
          self._world:DestroyEntity(eEffect)
        end
      end
    end
  end
end

function AbyssEffectSpInstruction:GetCacheResource()
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
