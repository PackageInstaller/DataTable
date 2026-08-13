pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.SeriesGuideMgr = var_0_10001("SeriesGuideMgr")
pg = var_0

local var_0_1 = var_0.SeriesGuideMgr
local var_0_2 = false

local function var_0_3(...)
	if var_0_2 then
		originalPrint = var_0

		var_0(...)
	end

	return
end

local var_0_4 = log
local var_0_5 = {
	IDLE = 1,
	BUSY = 2
}

var_0_1.CODES = {
	GUIDER = 1,
	CONDITION = 4,
	MAINUI = 2
}

function var_0_1.isRunning(arg_2_0)
	return arg_2_0.state == var_0_5.BUSY
end

function var_0_1.IsInit(arg_3_0)
	local var_3_0

	if arg_3_0.state then
		var_3_0 = arg_3_0.state >= var_0_5.IDLE
	end

	return var_3_0
end

function var_0_1.isNotFinish(arg_4_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	if var_1_10001(var_1_10002) then
		local var_4_0 = var_1:getRawData()

		return var_2.GetGuideIndex(var_4_0, arg_4_0:IsNewVersion()) < arg_4_0.lastIndex - 1
	end

	return
end

function var_0_1.IsNewVersion(arg_5_0)
	return arg_5_0.isNewVersion
end

function var_0_1.loadGuide(arg_6_0, arg_6_1)
	print = var_1_10002

	var_1_10002("load guide script:", arg_6_1)

	require = var_1_10002

	return var_1_10002("GameCfg.guide.newguide." .. arg_6_1)
end

function var_0_1.getStepConfig(arg_7_0, arg_7_1)
	return arg_7_0.guideCfgs[arg_7_1]
end

function var_0_1.CheckNewVersion(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 then
		return true
	end

	local var_8_0 = arg_8_2:GetGuideIndex(true)
	local var_8_1 = arg_8_2
	local var_8_2 = arg_8_2.GetGuideIndex(var_8_1, false)

	print = var_8_1

	var_8_1("guild index:", var_8_0, var_8_2)

	return var_8_2 <= var_8_0
end

function var_0_1.Init(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.state = var_0_5.IDLE
	arg_9_0.isNewVersion = arg_9_0:CheckNewVersion(arg_9_1, arg_9_2)

	local var_9_0 = arg_9_0.isNewVersion and "SG002" or "SG001"

	arg_9_0.guideCfgs = arg_9_0:loadGuide(var_9_0)
	arg_9_0.lastIndex = #arg_9_0.guideCfgs + 1
	pg = var_4
	arg_9_0.guideMgr = var_4.NewGuideMgr.GetInstance()
	arg_9_0.protocols = {}
	arg_9_0.onReceiceProtocol = nil

	arg_9_0:setPlayer(arg_9_2)

	return
end

function var_0_1.dispatch(arg_10_0, arg_10_1)
	if arg_10_0:canPlay(arg_10_1) then
		local var_10_0 = arg_10_0.guideMgr

		var_2.PlayNothing(var_10_0)
	end

	return
end

function var_0_1.start(arg_11_0, arg_11_1)
	if arg_11_0:canPlay(arg_11_1) then
		arg_11_0.state = var_0_5.BUSY

		local var_11_0 = arg_11_0.guideMgr

		var_2.StopNothing(var_11_0)

		arg_11_0.stepConfig = arg_11_0:getStepConfig(arg_11_0.currIndex)

		local function var_11_1(arg_12_0)
			arg_11_0.state = var_0_5.IDLE
			arg_11_0.protocols = {}

			if not arg_11_0.stepConfig.interrupt then
				local var_12_0 = arg_11_0

				var_1.doNextStep(var_12_0, arg_11_0.currIndex, arg_12_0)
			end

			return
		end

		arg_11_0:doGuideStep(arg_11_1, function(arg_13_0, arg_13_1)
			if arg_11_0.stepConfig.end_segment and arg_13_1 then
				local var_13_0 = arg_11_0.guideMgr

				var_2.Play(var_13_0, arg_11_0.stepConfig.end_segment, arg_11_1.code, function()
					var_11_1(arg_13_0)

					return
				end, nil, function(arg_15_0, arg_15_1)
					local var_15_0 = arg_11_0

					var_2.Record(var_15_0, arg_11_0.currIndex - 1, arg_15_0, arg_15_1, arg_11_0.stepConfig.end_segment)

					return
				end)
			else
				var_11_1(arg_13_0)
			end

			return
		end)
	end

	return
end

function var_0_1.doGuideStep(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.stepConfig.condition then
		local var_16_0, var_16_1, var_16_2 = arg_16_0:checkCondition(arg_16_1)

		var_1_10006 = var_16_2 and arg_16_0.currIndex < var_16_1

		arg_16_0:updateIndex(var_16_1, function()
			arg_16_2({
				var_16_0
			}, var_1_10006)

			return
		end)
	else
		local var_16_3 = arg_16_0.stepConfig.segment[arg_16_0:getSegmentIndex()][1]
		local var_16_4 = var_3[2]

		assert = var_1_10006

		var_1_10006(var_16_4, "protocol can not be nil")

		local var_16_5 = {
			function(arg_18_0)
				local var_18_0 = arg_16_0.guideMgr

				var_1.Play(var_18_0, var_16_3, arg_16_1.code, arg_18_0, function()
					local var_19_0 = arg_16_0

					var_0.updateIndex(var_19_0, arg_16_0.lastIndex)

					return
				end, function(arg_20_0, arg_20_1)
					local var_20_0 = arg_16_0

					var_2.Record(var_20_0, arg_16_0.currIndex, arg_20_0, arg_20_1, var_16_3)

					return
				end)

				local var_18_1 = arg_16_0.guideMgr

				var_1.PlayNothing(var_18_1)

				return
			end,
			function(arg_21_0)
				_ = var_2_10001

				if var_2_10001.any(arg_16_0.protocols, function(arg_22_0)
					return arg_22_0.protocol == var_16_4
				end) then
					arg_21_0()

					return
				end

				function arg_16_0.onReceiceProtocol(arg_23_0)
					if arg_23_0 == var_16_4 then
						arg_16_0.onReceiceProtocol = nil

						arg_21_0()
					end

					return
				end

				return
			end,
			function(arg_24_0)
				local var_24_0 = arg_16_0.guideMgr

				var_1.StopNothing(var_24_0)

				local var_24_1 = arg_16_0

				var_1.increaseIndex(var_24_1, arg_24_0)

				return
			end
		}

		seriesAsync = var_7

		var_7(var_16_5, function()
			arg_16_2({
				var_0_1.CODES.GUIDER
			}, true)

			return
		end)
	end

	return
end

function var_0_1.Record(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	pg = var_1_10005

	local var_26_0 = var_1_10005.TimeMgr.GetInstance()
	local var_26_1 = var_5.GetServerTime(var_26_0) - arg_26_3

	pg = var_1_10007

	local var_26_2 = var_1_10007.GameTrackerMgr.GetInstance()
	local var_26_3 = var_7.Record

	GameTrackerBuilder = var_1_10009

	var_26_3(var_26_2, var_1_10009.BuildGuide(arg_26_0:IsNewVersion(), arg_26_1, arg_26_2, var_26_1, arg_26_4))

	return
end

function var_0_1.getSegmentIndex(arg_27_0)
	local var_27_0 = 1

	if arg_27_0.stepConfig.getSegment then
		var_27_0 = arg_27_0.stepConfig.getSegment()
	end

	return var_27_0
end

local var_0_6 = 1
local var_0_7 = 2
local var_0_8 = 3

function var_0_1.checkCondition(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.stepConfig
	local var_28_1
	local var_28_2
	local var_28_3 = true
	local var_28_4

	if var_28_0.condition.arg[1] == var_0_6 then
		var_28_4 = {
			protocol = var_6[2],
			func = var_28_0.condition.func
		}
		var_1_10009 = arg_28_0

		local var_28_5

		var_28_5, var_1_10009 = arg_28_0.checkPtotocol(var_1_10009, var_28_4, arg_28_1)
		var_28_1 = var_1_10009
		var_28_2 = var_28_5
	elseif var_6[1] == var_0_7 then
		getProxy = var_28_4
		PlayerProxy = var_8

		local var_28_6 = var_28_4(var_8)

		var_28_4 = var_28_4.getRawData(var_28_6)
		getProxy = var_28_6
		BayProxy = var_1_10009

		local var_28_7 = var_28_6(var_1_10009)
		local var_28_8 = var_8.getShipById(var_28_7, var_28_4.character)

		var_28_2, var_28_1 = var_28_0.condition.func(var_28_8)
		arg_28_0.stepConfig.condition = nil
	elseif var_6[1] == var_0_8 then
		var_28_4 = var_28_0.condition.func
		NewServerCarnivalScene = var_8

		local var_28_9

		var_28_4, var_28_9 = var_28_4(var_8.isShow())
		var_28_1 = var_28_9
		var_28_2 = var_28_4
		var_28_4 = arg_28_0.stepConfig
		var_28_4.condition = nil
		var_28_3 = false
	end

	assert = var_28_4

	var_28_4(var_28_1, "index can not be nil")

	return var_28_2, var_28_1, var_28_3
end

function var_0_1.checkPtotocol(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_1.protocol

	_ = var_1_10004

	local var_29_1

	if not var_1_10004.select(arg_29_0.protocols, function(arg_30_0)
		return arg_30_0.protocol == var_29_0
	end)[1] then
		var_29_1 = {}
	end

	return arg_29_1.func(arg_29_2.view, var_29_1.args)
end

function var_0_1.increaseIndex(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.currIndex + 1

	arg_31_0:updateIndex(var_31_0, arg_31_1)

	return
end

function var_0_1.updateIndex(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0
	local var_32_1 = arg_32_0.IsNewVersion(var_32_0)

	pg = var_32_0

	local var_32_2 = var_32_0.m02
	local var_32_3 = var_4.sendNotification

	GAME = var_1_10006

	var_32_3(var_32_2, var_1_10006.UPDATE_GUIDE_INDEX, {
		isNewVersion = var_32_1,
		index = arg_32_1,
		callback = arg_32_2
	})

	return
end

function var_0_1.doNextStep(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0.stepConfig = nil

	if arg_33_0:isEnd() then
		return
	end

	local var_33_0 = arg_33_0.guideCfgs[arg_33_1]
	local var_33_1 = {
		view = var_33_0.view[#var_33_0.view],
		code = arg_33_2
	}

	if arg_33_0:canPlay(var_33_1) then
		arg_33_0:start(var_33_1)
	end

	return
end

function var_0_1.isEnd(arg_34_0)
	local var_34_0

	if not (arg_34_0.currIndex > #arg_34_0.guideCfgs) then
		ENABLE_GUIDE = var_1
		var_34_0 = not var_1

		if false then
			var_34_0 = false
		end
	else
		var_34_0 = true
	end

	return var_34_0
end

function var_0_1.receiceProtocol(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	if not arg_35_0:IsInit() then
		return
	end

	table = var_4

	var_4.insert(arg_35_0.protocols, {
		protocol = arg_35_1,
		args = arg_35_2,
		data = arg_35_3
	})

	if arg_35_0.onReceiceProtocol then
		arg_35_0.onReceiceProtocol(arg_35_1)
	end

	return
end

function var_0_1.canPlay(arg_36_0, arg_36_1)
	if arg_36_0.state ~= var_0_5.IDLE then
		log = var_2

		var_2("guider is busy")

		return false
	end

	ENABLE_GUIDE = var_2

	if not var_2 then
		log = var_2

		var_2("ENABLE is false")

		return false
	end

	if not arg_36_0.guideMgr then
		log = var_2

		var_2("guideMgr is nil")

		return false
	end

	if not arg_36_0.playerLevel then
		log = var_2

		var_2("player is nil")

		return false
	end

	if arg_36_0:isEnd() then
		log = var_2

		var_2("guider is end")

		return false
	end

	local var_36_0 = arg_36_0
	local var_36_1 = arg_36_0.getStepConfig(var_36_0, arg_36_0.currIndex)

	table = var_36_0

	if not var_36_0.contains(var_36_1.view, arg_36_1.view) then
		log = var_3

		var_3("view is erro", arg_36_0.currIndex, arg_36_1.view, var_36_1.view[1], var_36_1.view[2])

		return false
	end

	return true
end

function var_0_1.setPlayer(arg_37_0, arg_37_1)
	arg_37_0.playerLevel = arg_37_1.level
	arg_37_0.playerIndex = arg_37_1:GetGuideIndex(arg_37_0:IsNewVersion())
	arg_37_0.currIndex = var_2

	arg_37_0:compatibleOldPlayer()

	return
end

function var_0_1.dispose(arg_38_0)
	arg_38_0.playerLevel = nil
	arg_38_0.protocols = {}
	arg_38_0.state = var_0_5.IDLE

	return
end

function var_0_1.compatibleOldPlayer(arg_39_0)
	if not arg_39_0.playerLevel then
		return
	end

	local function var_39_0()
		local var_40_0 = arg_39_0

		var_0.updateIndex(var_40_0, arg_39_0.lastIndex)

		return
	end

	if arg_39_0.playerLevel >= 5 and arg_39_0.playerIndex < arg_39_0.lastIndex then
		var_39_0()

		return
	end

	if arg_39_0.playerIndex ~= arg_39_0.lastIndex then
		pg = var_2

		local var_39_1 = var_2.SystemGuideMgr.GetInstance()

		var_2.FixGuide(var_39_1, function()
			if arg_39_0.playerIndex > 1 and arg_39_0.playerIndex < 101 then
				var_39_0()
			end

			return
		end)
	end

	return
end

return
