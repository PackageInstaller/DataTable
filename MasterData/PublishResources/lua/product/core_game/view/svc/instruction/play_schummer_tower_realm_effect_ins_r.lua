require("base_ins_r")
_class("PlaySchummerTowerRealmEffectInstruction", BaseInstruction)
PlaySchummerTowerRealmEffectInstruction = PlaySchummerTowerRealmEffectInstruction
local PositionalData = {
  LT = {
    v2GridPos = Vector2.New(2, 8),
    v2Dir = Vector2.up
  },
  LB = {
    v2GridPos = Vector2.New(2, 2),
    v2Dir = Vector2.left
  },
  RT = {
    v2GridPos = Vector2.New(8, 8),
    v2Dir = Vector2.right
  },
  RB = {
    v2GridPos = Vector2.New(8, 2),
    v2Dir = Vector2.down
  }
}

function PlaySchummerTowerRealmEffectInstruction:Constructor(paramList)
  self._effectID = 2771
end

function PlaySchummerTowerRealmEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local fxsvc = world:GetService("Effect")
  local curseTowerGroupEntities = world:GetGroupEntities(world.BW_WEMatchers.CurseTower)
  if not curseTowerGroupEntities or #curseTowerGroupEntities <= 0 then
    return
  end
  local utilDataSvc = world:GetService("UtilData")
  for _, eTower in ipairs(curseTowerGroupEntities) do
    if utilDataSvc:GetTrapCurseTowerState(eTower) ~= CurseTowerState.Deactive then
      local v2GridPos = eTower:GetGridPosition()
      local v2Relative = v2GridPos - BattleConst.BoardCenterPos
      local tPosData
      if 0 > v2Relative.x and 0 < v2Relative.y then
        tPosData = PositionalData.LT
      elseif 0 < v2Relative.x and 0 < v2Relative.y then
        tPosData = PositionalData.RT
      elseif 0 > v2Relative.x and 0 > v2Relative.y then
        tPosData = PositionalData.LB
      elseif 0 < v2Relative.x and 0 > v2Relative.y then
        tPosData = PositionalData.RB
      end
      fxsvc:CreateWorldPositionDirectionEffect(self._effectID, tPosData.v2GridPos, tPosData.v2Dir)
    end
  end
end

function PlaySchummerTowerRealmEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
