require("random")
_class("RandomServiceRender", BaseService)
RandomServiceRender = RandomServiceRender

function RandomServiceRender:Constructor(world)
  self._renderRandor = lcg(world.BW_WorldInfo.world_seed)
end

function RandomServiceRender:RenderRand(m, n)
  local randomNum = -1
  if m == nil and n == nil then
    randomNum = self._renderRandor:random()
  else
    randomNum = self:Rounding(self._renderRandor:random(m, n))
  end
  return randomNum
end

function RandomServiceRender:Rounding(value)
  local f = math.floor(value)
  if f == value then
    return f
  else
    return math.floor(value + 0.5)
  end
end

function RandomServiceRender:Shuffle(t)
  for i = 1, #t do
    local n = self:RenderRand(1, #t)
    t[i], t[n] = t[n], t[i]
  end
  return t
end
