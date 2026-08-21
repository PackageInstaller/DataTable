local aiFunctions = {}
aiFunctions[1] = function(player)
  return player.hpPercent < 80
end
aiFunctions[2] = function(player)
  if player.attackTimes == 5 then
    player.attackTimes = 0
    return true
  end
  return false
end
aiFunctions[3] = function(player)
  if player.attackedTimes == 30 then
    player.attackedTimes = 0
    return true
  end
  return false
end
return aiFunctions
