local var_0_0 = g.core.config.peakarena_new_odds_info
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.PeakArenaConst.HonorTitleType
local var_0_3 = g.core.config.peakarena_new_odds_info.get(1)
local var_0_4 = var_0_3.rand_1
local var_0_5 = var_0_3.rand_2
local var_0_6 = g.core.model.User.snapShotCacheData
local PeakStageUserStruct = class("PeakStageUserStruct")

function PeakStageUserStruct:ctor(arg_1_1)
	self._userId = arg_1_1.user_id or 0
	self._powerOdds = arg_1_1.odds or 0
	self._supportNum = arg_1_1.support or 0
	self._rank = arg_1_1.rank or 0
	self._cheerCount = arg_1_1.cheer_count or 0
	self._fightValue = arg_1_1.fight_value or 0
	self._championOdds = self:calcBetOdds(var_0_2.FIRST)
	self._honorTitleType = var_0_2.NONE
end

function PeakStageUserStruct:setHonorTitleType(arg_2_1)
	self._honorTitleType = arg_2_1
end

function PeakStageUserStruct:getHonorTitleType()
	return self._honorTitleType
end

function PeakStageUserStruct:getUserId()
	return self._userId
end

function PeakStageUserStruct:getUserSnapshot()
	return var_0_6:getSnapShot(var_0_1.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._userId)
end

function PeakStageUserStruct:getChampionOdds()
	return self._championOdds
end

function PeakStageUserStruct:getSupportNum()
	return self._supportNum
end

function PeakStageUserStruct:addSupportNum(arg_8_1)
	self._supportNum = self._supportNum + arg_8_1
end

function PeakStageUserStruct:getPowerOdds()
	return self._powerOdds
end

function PeakStageUserStruct:setCheerCount(arg_10_1)
	self._cheerCount = arg_10_1
end

function PeakStageUserStruct:getCheerCount()
	return self._cheerCount
end

function PeakStageUserStruct:getFightValue()
	return self._fightValue
end

function PeakStageUserStruct:calcBetOdds(arg_13_1)
	if not arg_13_1 or arg_13_1 == var_0_2.NONE then
		arg_13_1 = var_0_2.FIRST
	end

	local var_13_0 = 0

	if self._powerOdds > 0 and self._rank > 0 then
		local var_13_1 = var_0_0.get(self._rank)

		if var_13_1 and var_0_0.hasKey("odds_" .. arg_13_1) then
			var_13_0 = var_13_1["odds_" .. arg_13_1] * self._powerOdds / 1000
			var_13_0 = math.floor(var_13_1["odds_" .. arg_13_1] * self._powerOdds / 1000)
		end
	end

	return (math.min(var_0_5, (math.max(var_0_4, var_13_0))))
end

return PeakStageUserStruct
