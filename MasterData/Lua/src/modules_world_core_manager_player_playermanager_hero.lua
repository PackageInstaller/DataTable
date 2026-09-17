local this = {}

function this:getIsInWater()
  local mainHero = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  if mainHero and mainHero.state:GetCurrentStateType() == L_Const.fsmType.swim then
    return true
  end
  return false
end

function this:stopIdleAnim()
  AzurWorld.playerMgr.myPlayerData.playerEntity.entity:StopIdleBehavior(false)
end

function this:initIdleAnim()
  AzurWorld.playerMgr.myPlayerData.playerEntity.entity:StopIdleBehavior(false)
end

return this
