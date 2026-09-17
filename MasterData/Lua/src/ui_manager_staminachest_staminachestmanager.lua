local this = class("staminaChestManager")
local _staminaChestDropTpl = L_GameTpl:getStaminaChestDropTpl()

function this:getStaminaRewardTimes(chestId)
  local tpl = _staminaChestDropTpl:getTplById(chestId)
  local isDuringUp = _staminaChestDropTpl:isDuringUp(tpl)
  local serverData = AzurWorld.StaminaChestMgr:GetStaminaChestData(chestId)
  if isDuringUp then
    local canRewardTimes = _staminaChestDropTpl:getRewardChanceUp(tpl)
    local alreadyRewardTimes = 0
    if L_TimeUtil.isSameDay(L_TimeUtil.getServerTime(), serverData.upTime or 0) then
      alreadyRewardTimes = serverData.upCount
    end
    if 0 < canRewardTimes - alreadyRewardTimes then
      return canRewardTimes - alreadyRewardTimes, true
    end
  end
  local refreshType, canRewardTimes = table.unpack(_staminaChestDropTpl:getRewardChance(tpl))
  if refreshType == L_Const.StaminaBoxCountType.SBCT_INFINITE then
    return math.maxinteger, false
  elseif refreshType == L_Const.StaminaBoxCountType.SBCT_DAILY then
    local alreadyRewardTimes = 0
    if L_TimeUtil.isSameDay(L_TimeUtil.getServerTime(), serverData.boxCountTime or 0) then
      alreadyRewardTimes = serverData.upCount
    end
    return canRewardTimes - alreadyRewardTimes, false
  elseif refreshType == L_Const.StaminaBoxCountType.SBCT_WEEKLY then
    local alreadyRewardTimes = 0
    if L_TimeUtil.isSameWeek(L_TimeUtil.getServerTime(), serverData.boxCountTime or 0) then
      alreadyRewardTimes = serverData.upCount
    end
    return canRewardTimes - alreadyRewardTimes, false
  end
end

return this
