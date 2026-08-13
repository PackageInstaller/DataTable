local var_0_0 = {}

LimitChallengeConst = LimitChallengeConst
var_0.OPEN_PRE_COMBAT_LAYER = "OPEN_PRE_COMBAT_LAYER"
var_0.REQ_CHALLENGE_INFO = "LimitChallengeConst.REQ_CHALLENGE_INFO"
var_0.REQ_CHALLENGE_INFO_DONE = "LimitChallengeConst.REQ_CHALLENGE_INFO_DONE"
var_0.GET_CHALLENGE_AWARD = "LimitChallengeConst.GET_CHALLENGE_AWARD"
var_0.GET_CHALLENGE_AWARD_DONE = "LimitChallengeConst.GET_CHALLENGE_AWARD_DONE"
var_0.UPDATE_PASS_TIME = "LimitChallengeConst.UPDATE_PASS_TIME"

function var_0.RequestInfo()
	pg = var_1_10000

	if var_1_10000.constellation_challenge_month then
		pg = var_0

		if #var_0.constellation_challenge_month.all > 0 then
			LimitChallengeConst = var_0

			if var_0.GetCurMonthConfig() then
				pg = var_0

				local var_1_0 = var_0.m02
				local var_1_1 = var_0.sendNotification

				LimitChallengeConst = var_1_10002

				var_1_1(var_1_0, var_1_10002.REQ_CHALLENGE_INFO)
			end
		end
	end

	return
end

function var_0.GetNextMonthTS()
	pg = var_1_10000

	local var_2_0 = var_1_10000.TimeMgr.GetInstance()
	local var_2_1 = var_0.GetServerTime(var_2_0)

	pg = var_2_0

	local var_2_2 = var_2_0.TimeMgr.GetInstance()
	local var_2_3 = var_1.STimeDescS(var_2_2, var_2_1, "%Y")

	pg = var_2_2

	local var_2_4 = var_2_2.TimeMgr.GetInstance()
	local var_2_5 = var_2.STimeDescS(var_2_4, var_2_1, "%m")

	tonumber = var_2_4

	local var_2_6 = var_2_4(var_2_3)

	tonumber = var_3

	local var_2_7 = var_3(var_2_5) + 1

	if 12 < var_2_7 then
		var_2_7 = 1
		var_2_6 = var_2_6 + 1
	end

	pg = var_3

	local var_2_8 = var_3.TimeMgr.GetInstance()

	return var_3.Table2ServerTime(var_2_8, {
		hour = 0,
		min = 0,
		sec = 0,
		day = 1,
		year = var_2_6,
		month = var_2_7
	})
end

function var_0.GetCurMonth()
	pg = var_1_10000

	local var_3_0 = var_1_10000.TimeMgr.GetInstance()
	local var_3_1 = var_0.GetServerTime(var_3_0)

	pg = var_3_0

	local var_3_2 = var_3_0.TimeMgr.GetInstance()
	local var_3_3 = var_1.STimeDescS(var_3_2, var_3_1, "%m")

	tonumber = var_3_2

	return (var_3_2(var_3_3))
end

function var_0.GetCurMonthConfig()
	local var_4_0 = var_0.GetCurMonth()

	pg = var_1_10001

	return var_1_10001.constellation_challenge_month[var_4_0]
end

function var_0.GetChallengeIDByLevel(arg_5_0)
	LimitChallengeConst = var_1_10001

	return var_1_10001.GetCurMonthConfig().stage[arg_5_0]
end

function var_0.GetStageIDByLevel(arg_6_0)
	local var_6_0 = var_0.GetChallengeIDByLevel(arg_6_0)

	pg = var_2

	return var_2.expedition_constellation_challenge_template[var_6_0].dungeon_id
end

function var_0.GetChallengeIDByStageID(arg_7_0)
	ipairs = var_1_10001
	pg = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10001(var_1_10002.expedition_constellation_challenge_template.all) do
		pg = var_1_10006

		if arg_7_0 == var_1_10006.expedition_constellation_challenge_template[iter_7_1].dungeon_id then
			return var_1_10006.id
		end
	end

	return
end

function var_0.IsOpen()
	getProxy = var_1_10000
	PlayerProxy = var_1_10001

	local var_8_0 = var_1_10000(var_1_10001)
	local var_8_1 = var_0.getRawData(var_8_0).level

	pg = var_8_0

	local var_8_2 = var_8_0.SystemOpenMgr.GetInstance()
	local var_8_3 = var_1.isOpenSystem(var_8_2, var_8_1, "LimitChallengeMediator")

	pg = var_8_2

	local var_8_4 = var_8_2.SystemOpenMgr.GetInstance()
	local var_8_5 = var_2.isOpenSystem(var_8_4, var_8_1, "ChallengeMainMediator")

	return var_8_3 and var_8_5
end

function var_0.IsInAct()
	pg = var_1_10000

	if var_1_10000.constellation_challenge_month then
		pg = var_9_0

		local var_9_0 = #var_9_0.constellation_challenge_month.all

		if 0 < var_9_0 then
			LimitChallengeConst = var_9_0
			var_9_0 = var_9_0.GetCurMonthConfig()
		else
			var_9_0 = false
		end
	end

	if false then
		var_9_0 = true
	end

	checkExist = var_1_10001
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_9_1 = var_1_10002(var_1_10003)
	local var_9_2 = var_2.getActivityByType

	ActivityConst = var_1_10004

	local var_9_3 = var_1_10001(var_9_2(var_9_1, var_1_10004.ACTIVITY_TYPE_CHALLENGE), {
		"isEnd"
	}) == false

	LOCK_LIMIT_CHALLENGE = var_2

	return var_2 and var_9_3 or var_9_0
end

var_0.RedPointKey = "LimitChallengeMonth"

function var_0.SetRedPointMonth()
	PlayerPrefs = var_1_10000

	var_1_10000.SetInt(var_0.RedPointKey, var_0.GetCurMonth())

	return
end

function var_0.GetRedPointMonth()
	PlayerPrefs = var_1_10000

	return var_1_10000.GetInt(var_0.RedPointKey, 0)
end

function var_0.IsShowRedPoint()
	LOCK_LIMIT_CHALLENGE = var_1_10000

	if var_1_10000 then
		return false
	end

	if not var_0.IsOpen() then
		return false
	end

	if not var_0.IsInAct() then
		return false
	end

	if var_0.GetRedPointMonth() == var_0.GetCurMonth() then
		return false
	else
		getProxy = var_1_10002
		LimitChallengeProxy = var_1_10003

		local var_12_0 = var_1_10002(var_1_10003)
		local var_12_1 = var_0.GetCurMonthConfig().stage

		ipairs = var_1_10004

		for iter_12_0, iter_12_1 in var_1_10004(var_12_1) do
			if not var_12_0:isAwardedByChallengeID(iter_12_1) then
				return true
			end
		end

		return false
	end

	return
end

return var_0
