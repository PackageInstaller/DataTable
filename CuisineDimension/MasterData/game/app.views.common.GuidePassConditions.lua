local conditions = {}
conditions[1] = function()
  return display.getRunningScene().name == "BattleScene"
end
conditions[2] = function()
  return display.getRunningScene().name == "MainScene"
end
conditions[3] = function()
  local formationData = game.role.formation[tostring(1)] or {
    list = {},
    pos = {}
  }
  local heroId = formationData.list[tostring(2)]
  return heroId ~= nil
end
conditions[4] = function()
  local formationData = game.role.formation[tostring(1)] or {
    list = {},
    pos = {}
  }
  local heroId = formationData.list[tostring(3)]
  return heroId ~= nil
end
conditions[5] = function()
  local formationData = game.role.formation[tostring(1)] or {
    list = {},
    pos = {}
  }
  local heroId = formationData.list[tostring(4)]
  return heroId ~= nil
end
conditions[6] = function()
  local formationData = game.role.formation[tostring(1)] or {
    list = {},
    pos = {}
  }
  local heroId = formationData.list[tostring(5)]
  return heroId ~= nil
end
conditions[7] = function()
  local formationData = game.role.formation[tostring(1)] or {
    list = {},
    pos = {}
  }
  local heroId = formationData.list[tostring(1)]
  return heroId == nil or next(formationData.lock)
end
conditions[8] = function()
  local formationData = game.role.formation[tostring(2)] or {
    list = {},
    pos = {}
  }
  local heroId = formationData.list[tostring(1)]
  return heroId == nil or next(formationData.lock)
end
conditions[9] = function()
  local formationData = game.role.formation[tostring(3)] or {
    list = {},
    pos = {}
  }
  local heroId = formationData.list[tostring(1)]
  return heroId == nil or next(formationData.lock)
end
conditions[10] = function()
  local formationData = game.role.formation[tostring(4)] or {
    list = {},
    pos = {}
  }
  local heroId = formationData.list[tostring(1)]
  return heroId == nil or next(formationData.lock)
end
conditions[11] = function()
  local formationData = game.role.formation[tostring(5)] or {
    list = {},
    pos = {}
  }
  local heroId = formationData.list[tostring(1)]
  return heroId == nil or next(formationData.lock)
end
return conditions
