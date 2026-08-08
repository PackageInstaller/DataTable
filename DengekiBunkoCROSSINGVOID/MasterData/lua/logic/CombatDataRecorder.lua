local CombatDataRecorder = {}
local hurtData = {}

function CombatDataRecorder.reset()
  hurtData = {}
end

function CombatDataRecorder.setHurtData(attackId, targetId, hurtValue, attackTeam)
  if hurtData[attackId] ~= nil then
    local totalHurtValue = 0
    if hurtData[attackId][targetId] ~= nil then
      hurtData[attackId][targetId].totalHurtValue = hurtData[attackId][targetId].totalHurtValue + hurtValue
      hurtData[attackId][targetId].curRoundHurtValue = hurtData[attackId][targetId].curRoundHurtValue + hurtValue
    else
      hurtData[attackId][targetId] = {totalHurtValue = hurtValue, curRoundHurtValue = hurtValue}
    end
  else
    hurtData[attackId] = {
      [targetId] = {totalHurtValue = hurtValue, curRoundHurtValue = hurtValue},
      team = attackTeam
    }
  end
end

function CombatDataRecorder.getHurtData(attackId, targetId)
  local result = {totalHurtValue = 0, curRoundHurtValue = 0}
  if hurtData[attackId] ~= nil and hurtData[attackId][targetId] ~= nil then
    result = hurtData[attackId][targetId]
  end
  print("GamePlay", "getHurtData. attackId: " .. attackId .. ", targetId: " .. targetId .. ", hurtData: " .. tostring(result))
  return result
end

function CombatDataRecorder.getBeHurtData(targetId)
  local result = {totalHurtValue = 0, curRoundHurtValue = 0}
  for k, v in pairs(hurtData) do
    for _targetId, targetHurtData in pairs(v) do
      if _targetId == targetId then
        result.totalHurtValue = result.totalHurtValue + targetHurtData.totalHurtValue
        result.curRoundHurtValue = result.curRoundHurtValue + targetHurtData.curRoundHurtValue
      end
    end
  end
  return result
end

function CombatDataRecorder.clearCurRoundHurtValue(team)
  for k, v in pairs(hurtData) do
    if v.team == team then
      for targetId, targetHurtData in pairs(v) do
        if type(targetHurtData) == "table" then
          targetHurtData.curRoundHurtValue = 0
        end
      end
    end
  end
end

function CombatDataRecorder.print()
  for attackId, v in pairs(hurtData) do
    for targetId, targetHurtData in pairs(v) do
      if type(targetHurtData) == "table" then
        print("GamePlay", "CombatDataRecorder.print(). attackId: " .. attackId .. ", targetId: " .. targetId .. ", totalHurtValue: " .. targetHurtData.totalHurtValue .. ", curRoundHurtValue: " .. targetHurtData.curRoundHurtValue)
      end
    end
  end
end

return CombatDataRecorder
