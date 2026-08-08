local PB = require("Common/PbHelper")
local FH = require("Logic/HelpLogic")
local DEFINE = require("Logic/Define")

function requestCard(param, activeData)
  if FH.isGameOver(activeData) then
    for i = 1, #activeData.teamList do
      local teamInfo = activeData.teamList[i]
      teamInfo.cardsInHand = {}
    end
    return activeData
  end
  info("GamePlay", "lua - requestCard Team : " .. param.team)
  local fightData = activeData
  local teamInfo = FH.getTeamInfo(fightData.teamList, param.team)
  if teamInfo == nil then
    warning("GamePlay", "lua - no Team : " .. param.team)
    return fightData
  end
  FH.refreshDeadAndLockCard(teamInfo)
  FH.removeDeadCard(teamInfo)
  table.copy(teamInfo.cardsInStack, teamInfo.cardsInHand)
  local defineParams = DEFINE.GetDefineParams(fightData.stageID)
  local delay = 1
  if param.team ~= fightData.activeTeam then
    delay = -1
  end
  teamInfo.cardShowDelay = delay
  teamInfo.cardCountDown = defineParams.time
  teamInfo.cardCurIndex = fightData.roundIndex
  teamInfo.activeList = fightData.activeActorList
  if fightData.guideType == 21 and teamInfo.cardCurIndex == 5 then
    FH.setTeamEnergy(2, teamInfo, defineParams.maxSp, -1)
  end
  if fightData.guideType == 22 and teamInfo.cardCurIndex == 2 then
    FH.setTeamEnergy(2, teamInfo, defineParams.maxSp, -1)
  end
  if fightData.guideType == 27 and teamInfo.cardCurIndex == 1 then
    FH.setTeamEnergy(1, teamInfo, 8, -1)
  end
  if fightData.guideType == 100 then
    if teamInfo.cardCurIndex == 3 then
      FH.setWeaponEnergy(teamInfo, 2, 5)
    end
    if teamInfo.cardCurIndex == 7 then
      FH.setWeaponEnergy(teamInfo, 1, 5)
    end
    if teamInfo.cardCurIndex == 1 then
      FH.setTeamEnergy(1, teamInfo, defineParams.maxMp, -1)
      FH.setTeamEnergy(2, teamInfo, defineParams.maxSp, -1)
    end
  end
  if param.debugMode == 1 then
    FH.setTeamEnergy(1, teamInfo, defineParams.maxMp, -1)
    FH.setTeamEnergy(2, teamInfo, defineParams.maxSp, -1)
    local weapons = FH.getTeamWeapons({teamInfo}, teamInfo.team)
    for i = 1, #weapons do
      local weapon = weapons[i]
      local weaponDetail = weapon.actorInfo
      if weaponDetail.id and weaponDetail.id > 0 then
        local uniqueWeaponSkill = PB.get("UniqueWeaponSkill", weaponDetail.id, weaponDetail.uniqueWeaponPhase or 1)
        if uniqueWeaponSkill then
          weapon.energyWP = uniqueWeaponSkill.limitWP
        else
          warning("GamePlay", "missing UniqueWeaponSkill id : " .. tostring(weaponDetail.id) .. ", phase : " .. tostring(weaponDetail.uniqueWeaponPhase))
        end
      end
    end
  end
  return fightData
end

return requestCard
