function math.randomSeed(seed)
  seed = seed or tonumber(tostring(os.time()):reverse():sub(1, 6))
  
  math.randomseed(seed)
end

function math.randomFloat(lower, greater)
  return math.min(lower, greater) + math.random() * math.abs(greater - lower)
end

function math.randomInt(lower, greater)
  return math.random(math.min(lower, greater), math.max(lower, greater))
end

function math.randWeight(dataset, field)
  if not dataset then
    return nil
  end
  field = field or "weight"
  local weightSum = 0
  for key, value in pairs(dataset) do
    weightSum = weightSum + tonumber(value[field])
  end
  local randWeight = math.randomFloat(0, weightSum)
  for key, value in pairs(dataset) do
    if 0 < tonumber(value[field]) then
      if randWeight > tonumber(value[field]) then
        randWeight = randWeight - tonumber(value[field])
      else
        return key
      end
    end
  end
  return nil
end
