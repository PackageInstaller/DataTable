_class("PlaySnakeBodyBornInstruction", BaseInstruction)
PlaySnakeBodyBornInstruction = PlaySnakeBodyBornInstruction

function PlaySnakeBodyBornInstruction:Constructor(paramList)
  self._bodyEffectID = tonumber(paramList.bodyEffectID)
end

function PlaySnakeBodyBornInstruction:GetCacheResource()
  local t = {}
  table.insert(t, {
    Cfg.cfg_effect[self._bodyEffectID].ResPath,
    1
  })
  return t
end

function PlaySnakeBodyBornInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local bodyArea = casterEntity:BodyArea():GetArea()
  local casterPos = casterEntity:GetRenderGridPosition()
  for i, v in ipairs(bodyArea) do
    if i ~= 1 then
      local bodyPos = casterPos + v
      local effectSvc = self._world:GetService("Effect")
      local entity = effectSvc:CreateGridEffectWithEffectHolder(self._bodyEffectID, bodyPos, casterEntity)
      local dir = Vector2(v.x * -1, v.y * -1)
      entity:SetDirection(dir)
    end
  end
end
