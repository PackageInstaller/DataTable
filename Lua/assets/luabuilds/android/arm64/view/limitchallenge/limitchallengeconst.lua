LimitChallengeConst = {}

local var_0_0 = LimitChallengeConst

LimitChallengeConst.OPEN_PRE_COMBAT_LAYER = "OPEN_PRE_COMBAT_LAYER"
LimitChallengeConst.REQ_CHALLENGE_INFO = "LimitChallengeConst.REQ_CHALLENGE_INFO"
LimitChallengeConst.REQ_CHALLENGE_INFO_DONE = "LimitChallengeConst.REQ_CHALLENGE_INFO_DONE"
LimitChallengeConst.GET_CHALLENGE_AWARD = "LimitChallengeConst.GET_CHALLENGE_AWARD"
LimitChallengeConst.GET_CHALLENGE_AWARD_DONE = "LimitChallengeConst.GET_CHALLENGE_AWARD_DONE"
LimitChallengeConst.UPDATE_PASS_TIME = "LimitChallengeConst.UPDATE_PASS_TIME"

function LimitChallengeConst.RequestInfo()
	if pg.constellation_challenge_month and #pg.constellation_challenge_month.all > 0 and LimitChallengeConst.GetCurMonthConfig() then
		pg.m02:sendNotification(LimitChallengeConst.REQ_CHALLENGE_INFO)
	end

	return
end

function LimitChallengeConst.GetNextMonthTS()
	local var_2_9000
	local var_2_0 = pg.TimeMgr.GetInstance().GetServerTime(var_2_9000)
	local var_2_1 = tonumber((pg.TimeMgr.GetInstance():STimeDescS(var_2_0, "%Y")))
	local var_2_2 = tonumber((pg.TimeMgr.GetInstance():STimeDescS(var_2_0, "%m"))) + 1

	if var_2_2 > 12 then
		var_2_2 = 1
		var_2_1 = var_2_1 + 1
	end

	return pg.TimeMgr.GetInstance():Table2ServerTime({
		hour = 0,
		min = 0,
		sec = 0,
		day = 1,
		year = var_2_1,
		month = var_2_2
	})
end

function LimitChallengeConst.GetCurMonth()
	return (tonumber((pg.TimeMgr.GetInstance():STimeDescS(pg.TimeMgr.GetInstance():GetServerTime(), "%m"))))
end

function LimitChallengeConst.GetCurMonthConfig()
	return pg.constellation_challenge_month[var_0_0.GetCurMonth()]
end

function LimitChallengeConst.GetChallengeIDByLevel(arg_5_0)
	return LimitChallengeConst.GetCurMonthConfig().stage[arg_5_0]
end

function LimitChallengeConst.GetStageIDByLevel(arg_6_0)
	return pg.expedition_constellation_challenge_template[var_0_0.GetChallengeIDByLevel(arg_6_0)].dungeon_id
end

function LimitChallengeConst.GetChallengeIDByStageID(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(pg.expedition_constellation_challenge_template.all) do
		if arg_7_0 == pg.expedition_constellation_challenge_template[iter_7_1].dungeon_id then
			return pg.expedition_constellation_challenge_template[iter_7_1].id
		end
	end

	return
end

function LimitChallengeConst.IsOpen()
	local var_8_9000
	local var_8_0 = getProxy(PlayerProxy)
	local var_8_1 = var_8_0.getRawData(var_8_9000).level

	return pg.SystemOpenMgr.GetInstance():isOpenSystem(var_8_1, "LimitChallengeMediator") and pg.SystemOpenMgr.GetInstance().isOpenSystem(var_8_0, var_8_1, "ChallengeMainMediator")
end

function LimitChallengeConst.IsInAct()
	local var_9_0 = pg.constellation_challenge_month and (#pg.constellation_challenge_month.all > 0 and LimitChallengeConst.GetCurMonthConfig() or false)

	if false then
		var_9_0 = true
	end

	local var_9_1 = checkExist(getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE), {
		"isEnd"
	}) == false

	return LOCK_LIMIT_CHALLENGE and var_9_1 or var_9_0
end

LimitChallengeConst.RedPointKey = "LimitChallengeMonth"

function LimitChallengeConst.SetRedPointMonth()
	PlayerPrefs.SetInt(var_0_0.RedPointKey, var_0_0.GetCurMonth())

	return
end

function LimitChallengeConst.GetRedPointMonth()
	return PlayerPrefs.GetInt(var_0_0.RedPointKey, 0)
end

function LimitChallengeConst.IsShowRedPoint()
	if LOCK_LIMIT_CHALLENGE then
		return false
	end

	if not var_0_0.IsOpen() then
		return false
	end

	if not var_0_0.IsInAct() then
		return false
	end

	if var_0_0.GetRedPointMonth() == var_0_0.GetCurMonth() then
		return false
	else
		local var_12_0 = getProxy(LimitChallengeProxy)

		for iter_12_0, iter_12_1 in ipairs(var_0_0.GetCurMonthConfig().stage) do
			if not var_12_0:isAwardedByChallengeID(iter_12_1) then
				return true
			end
		end

		return false
	end

	return
end

return LimitChallengeConst
