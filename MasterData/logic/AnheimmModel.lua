-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/model/AnheimmModel.lua

module("logic.extensions.timelimitedchallenge.model.AnheimmModel", package.seeall)

local AnheimmModel = class("AnheimmModel", TLCBaseGameModel)

function AnheimmModel:ctor()
	return
end

function AnheimmModel:onInit()
	self:onReset()
end

function AnheimmModel:onReset()
	self._isEverEvolve = false
	self._isHasGainDailyPrize = false
	self._worldZdl = 0
	self._hasChallengeTimes = 0
	self._hasBuyTimes = 0
	self._curModeId = nil
	self._curRuleId = nil
	self._curMonsterId = nil
	self._isWin = nil
	self._isPerfectWin = nil
	self._changeSetId = nil
end

function AnheimmModel:getIsEverEvolve()
	return self._isEverEvolve
end

function AnheimmModel:getIsHasGainDaily()
	return self._isHasGainDailyPrize
end

function AnheimmModel:getWorldZDL()
	return self._worldZdl
end

function AnheimmModel:getCurChallengeTimes()
	local dailyTimes = AnheimmConfig.instance:getChallengeDailyTimes()

	return dailyTimes + self._hasBuyTimes - self._hasChallengeTimes
end

function AnheimmModel:getCurHasBuyTimes()
	return self._hasBuyTimes
end

function AnheimmModel:getAbleToAddTimes()
	return AnheimmConfig.instance:getMaxAddTimes() - self._hasBuyTimes
end

function AnheimmModel:getCurModeId()
	return self._curModeId
end

function AnheimmModel:getCurRuleId()
	return self._curRuleId
end

function AnheimmModel:getCurMonsterId()
	return self._curMonsterId
end

function AnheimmModel:getShowZDL(modeId)
	local modeCfg = AnheimmConfig.instance:getModeCfgById(modeId)

	if modeCfg then
		local floorZDL = math.floor(self._worldZdl * modeCfg.showCoefficient / 10000)
		local floorCoefficient = modeCfg.floorCoefficient == 0 and 1 or modeCfg.floorCoefficient
		local floorZDLByCfg = floorZDL - floorZDL % floorCoefficient

		return math.max(floorZDLByCfg, modeCfg.fightMin)
	end
end

function AnheimmModel:updateGetInfo(msg)
	self._worldZdl = checkint(msg.worldZdl)
	self._isEverEvolve = checkbool(msg.everEvolvePet)
	self._isHasGainDailyPrize = checkbool(msg.todayPrizeGainBit)
	self._isEverEvolve = checkbool(msg.everEvolvePet)

	local timeInfo = msg.timesInfo

	if timeInfo then
		self._hasChallengeTimes = checkint(timeInfo.todayChallengeTimes)
		self._hasBuyTimes = checkint(timeInfo.todayBuyChallengeTimes)
	end

	local modeInfo = msg.modeInfo

	if modeInfo then
		self._curModeId = modeInfo.curChallengeModeId
		self._curMonsterId = modeInfo.curChallengeMonsterId
		self._curRuleId = modeInfo.curChallengeRuleId
	end
end

function AnheimmModel:updateGainDailyPrize(msg)
	self._isHasGainDailyPrize = true
end

function AnheimmModel:updateBuyTimes(msg)
	self._hasBuyTimes = checkint(msg.todayBuyChallengeTimes)
end

function AnheimmModel:updateModeInfo(msg)
	local modeInfo = msg.modeInfo

	if modeInfo then
		self._curModeId = modeInfo.curChallengeModeId
		self._curMonsterId = modeInfo.curChallengeMonsterId
		self._curRuleId = modeInfo.curChallengeRuleId
	end
end

function AnheimmModel:updateGiveUp(msg)
	self._hasChallengeTimes = msg.todayChallengeTimes
	self._curModeId = nil
	self._curMonsterId = nil
	self._curRuleId = nil
end

function AnheimmModel:setBtlResult(msg)
	if msg.todayChallengeTimes then
		self._hasChallengeTimes = msg.todayChallengeTimes
	end

	self:updateModeInfo(msg.modeInfo)

	self._isWin = msg.isWin
	self._isPerfectWin = msg.isPerfectWin
	self._changeSetId = msg.changeSetId

	if checknumber(msg.changeSetId) > 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end
end

function AnheimmModel:updateChallengeTimes(value)
	self._hasChallengeTimes = value
end

function AnheimmModel:getChangeSetId()
	return checknumber(self._changeSetId)
end

function AnheimmModel:setChangeSetId(value)
	print("setChangeSetId value = " .. tostring(value))

	self._changeSetId = value
end

function AnheimmModel:getIsWin()
	return self._isWin
end

function AnheimmModel:getIsPerfectWin()
	return self._isPerfectWin
end

function AnheimmModel:getModeIsOpen(modeId)
	local challengeId = AnheimmConfig.instance:getChallengeId()
	local challengeCfg = TimeLimitedConfig.instance:getCfgById(challengeId)
	local isOpen = false
	local openTime = 0
	local cfg = AnheimmConfig.instance:getModeCfgById(modeId)

	if challengeCfg.openTimeType == 1 then
		openTime = cfg.relativeOpenDay + challengeCfg.relativeOpenDays
		isOpen = GameUtil.isInOpenDaysByOpenDay(cfg.relativeOpenDay + challengeCfg.relativeOpenDays, challengeCfg.relativeEndDay)
		openTime = RoleModel.instance:getAreaOpenTimeSec() + (cfg.relativeOpenDay + challengeCfg.relativeOpenDays) * 86400
	elseif challengeCfg.openTimeType == 2 then
		openTime = GameUtil.string2time(challengeCfg.absoluteOpenDay) + cfg.relativeOpenDays * 86400
		isOpen = GameUtil.checkIsInTimePeriod(GameUtil.formatTimeStamp("%Y-%m-%d  %H:00:00", openTime), challengeCfg.absoluteEndDay)
	else
		printError("error OpenTime Type")
	end

	return isOpen, openTime
end

AnheimmModel.instance = AnheimmModel.New()

return AnheimmModel
