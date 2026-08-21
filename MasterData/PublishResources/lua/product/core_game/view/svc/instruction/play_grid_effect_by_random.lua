require("base_ins_r")
_class("PlayGridEffectByRandomInstruction", BaseInstruction)
PlayGridEffectByRandomInstruction = PlayGridEffectByRandomInstruction

function PlayGridEffectByRandomInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._intervalTime = tonumber(paramList.intervalTime)
  self._randomCount = tonumber(paramList.randomCount)
end

function PlayGridEffectByRandomInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end

function PlayGridEffectByRandomInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local gridRange = phaseContext:GetScopeGridRange()
  if not (gridRange and gridRange[1]) or not gridRange[1][1] then
    return
  end
  local scopeRange = gridRange[1][1]
  self._world = casterEntity:GetOwnerWorld()
  while 0 < #scopeRange do
    if #scopeRange < self._randomCount then
      self:_PlayEffectAtGridList(scopeRange)
      break
    else
      local playRange = {}
      for i = 1, self._randomCount do
        local index = math.random(1, #scopeRange)
        local gridPos = scopeRange[index]
        table.remove(scopeRange, index)
        table.insert(playRange, gridPos)
      end
      self:_PlayEffectAtGridList(playRange)
      if 0 < self._intervalTime then
        YIELD(TT, self._intervalTime)
      end
    end
  end
end

function PlayGridEffectByRandomInstruction:_PlayEffectAtGridList(gridList)
  local effectService = self._world:GetService("Effect")
  for _, grid in ipairs(gridList) do
    effectService:CreateCommonGridEffect(self._effectID, grid)
  end
end
