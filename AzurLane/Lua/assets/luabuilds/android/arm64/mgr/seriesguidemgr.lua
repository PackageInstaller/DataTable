pg = pg or {}
pg.SeriesGuideMgr = singletonClass("SeriesGuideMgr")

local var_0_0 = pg.SeriesGuideMgr
local var_0_1 = false

function log(...)
	if var_0_1 then
		originalPrint(...)
	end

	return
end

local var_0_2 = {
	IDLE = 1,
	BUSY = 2
}

pg.SeriesGuideMgr.CODES = {
	GUIDER = 1,
	CONDITION = 4,
	MAINUI = 2
}

function pg.SeriesGuideMgr.isRunning(arg_2_0)
	return arg_2_0.state == var_0_2.BUSY
end

function pg.SeriesGuideMgr.IsInit(arg_3_0)
	return arg_3_0.state and arg_3_0.state >= var_0_2.IDLE
end

function pg.SeriesGuideMgr.isNotFinish(arg_4_0)
	local var_4_0 = getProxy(PlayerProxy)

	if var_4_0 then
		local var_4_1 = var_4_0:getRawData()

		return var_4_1:GetGuideIndex(arg_4_0:IsNewVersion()) < arg_4_0.lastIndex - 1
	end

	return
end

function pg.SeriesGuideMgr.IsNewVersion(arg_5_0)
	return arg_5_0.isNewVersion
end

function pg.SeriesGuideMgr.loadGuide(arg_6_0, arg_6_1)
	print("load guide script:", arg_6_1)

	return require("GameCfg.guide.newguide." .. arg_6_1)
end

function pg.SeriesGuideMgr.getStepConfig(arg_7_0, arg_7_1)
	return arg_7_0.guideCfgs[arg_7_1]
end

function pg.SeriesGuideMgr.CheckNewVersion(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 then
		return true
	end

	local var_8_0 = arg_8_2:GetGuideIndex(true)
	local var_8_1 = arg_8_2:GetGuideIndex(false)

	print("guild index:", var_8_0, var_8_1)

	return var_8_1 <= var_8_0
end

function pg.SeriesGuideMgr.Init(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.state = var_0_2.IDLE
	arg_9_0.isNewVersion = arg_9_0:CheckNewVersion(arg_9_1, arg_9_2)
	arg_9_0.guideCfgs = arg_9_0:loadGuide(arg_9_0.isNewVersion and "SG002" or "SG001")
	arg_9_0.lastIndex = #arg_9_0.guideCfgs + 1
	arg_9_0.guideMgr = pg.NewGuideMgr.GetInstance()
	arg_9_0.protocols = {}
	arg_9_0.onReceiceProtocol = nil

	arg_9_0:setPlayer(arg_9_2)

	return
end

function pg.SeriesGuideMgr.dispatch(arg_10_0, arg_10_1)
	if arg_10_0:canPlay(arg_10_1) then
		arg_10_0.guideMgr:PlayNothing()
	end

	return
end

function pg.SeriesGuideMgr.start(arg_11_0, arg_11_1)
	if arg_11_0:canPlay(arg_11_1) then
		arg_11_0.state = var_0_2.BUSY

		arg_11_0.guideMgr:StopNothing()

		arg_11_0.stepConfig = arg_11_0:getStepConfig(arg_11_0.currIndex)

		local function var_11_0(arg_12_0)
			arg_11_0.state = var_0_2.IDLE
			arg_11_0.protocols = {}

			if not arg_11_0.stepConfig.interrupt then
				arg_11_0:doNextStep(arg_11_0.currIndex, arg_12_0)
			end

			return
		end

		arg_11_0:doGuideStep(arg_11_1, function(arg_13_0, arg_13_1)
			if arg_11_0.stepConfig.end_segment and arg_13_1 then
				arg_11_0.guideMgr:Play(arg_11_0.stepConfig.end_segment, arg_11_1.code, function()
					var_11_0(arg_13_0)

					return
				end, nil, function(arg_15_0, arg_15_1)
					arg_11_0:Record(arg_11_0.currIndex - 1, arg_15_0, arg_15_1, arg_11_0.stepConfig.end_segment)

					return
				end)
			else
				var_11_0(arg_13_0)
			end

			return
		end)
	end

	return
end

function pg.SeriesGuideMgr.doGuideStep(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.stepConfig.condition then
		local var_16_0, var_16_1, var_16_2 = arg_16_0:checkCondition(arg_16_1)
		local var_16_3 = var_16_2 and var_16_1 > arg_16_0.currIndex

		arg_16_0:updateIndex(var_16_1, function()
			arg_16_2({
				var_16_0
			}, var_16_3)

			return
		end)
	else
		local var_16_4 = arg_16_0.stepConfig.segment[arg_16_0:getSegmentIndex()]
		local var_16_5 = var_16_4[1]

		assert(var_16_4[2], "protocol can not be nil")
		seriesAsync({
			function(arg_18_0)
				arg_16_0.guideMgr:Play(var_16_5, arg_16_1.code, arg_18_0, function()
					arg_16_0:updateIndex(arg_16_0.lastIndex)

					return
				end, function(arg_20_0, arg_20_1)
					arg_16_0:Record(arg_16_0.currIndex, arg_20_0, arg_20_1, var_16_5)

					return
				end)
				arg_16_0.guideMgr:PlayNothing()

				return
			end,
			function(arg_21_0)
				if _.any(arg_16_0.protocols, function(arg_22_0)
					return arg_22_0.protocol == var_0
				end) then
					arg_21_0()

					return
				end

				function arg_16_0.onReceiceProtocol(arg_23_0)
					if arg_23_0 == var_0 then
						arg_16_0.onReceiceProtocol = nil

						arg_21_0()
					end

					return
				end

				return
			end,
			function(arg_24_0)
				arg_16_0.guideMgr:StopNothing()
				arg_16_0:increaseIndex(arg_24_0)

				return
			end
		}, function()
			arg_16_2({
				var_0_0.CODES.GUIDER
			}, true)

			return
		end)
	end

	return
end

function pg.SeriesGuideMgr.Record(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_9000
	local var_26_0 = pg.TimeMgr.GetInstance()

	pg.GameTrackerMgr.GetInstance().Record(var_26_0, GameTrackerBuilder.BuildGuide(arg_26_0:IsNewVersion(), arg_26_1, arg_26_2, var_26_0.GetServerTime(var_26_9000) - arg_26_3, arg_26_4))

	return
end

function pg.SeriesGuideMgr.getSegmentIndex(arg_27_0)
	local var_27_0 = 1

	if arg_27_0.stepConfig.getSegment then
		var_27_0 = arg_27_0.stepConfig.getSegment()
	end

	return var_27_0
end

local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3

function pg.SeriesGuideMgr.checkCondition(arg_28_0, arg_28_1)
	local var_28_0
	local var_28_1
	local var_28_2 = true

	if arg_28_0.stepConfig.condition.arg[1] == var_0_3 then
		var_28_1, var_28_0 = arg_28_0:checkPtotocol({
			protocol = arg_28_0.stepConfig.condition.arg[2],
			func = arg_28_0.stepConfig.condition.func
		}, arg_28_1)
	elseif arg_28_0.stepConfig.condition.arg[1] == var_0_4 then
		var_28_1, var_28_0 = arg_28_0.stepConfig.condition.func((getProxy(BayProxy):getShipById(getProxy(PlayerProxy):getRawData().character)))
		arg_28_0.stepConfig.condition = nil
	elseif arg_28_0.stepConfig.condition.arg[1] == var_0_5 then
		var_28_1, var_28_0 = arg_28_0.stepConfig.condition.func(NewServerCarnivalScene.isShow())
		arg_28_0.stepConfig.condition = nil
		var_28_2 = false
	end

	assert(var_28_0, "index can not be nil")

	return var_28_1, var_28_0, var_28_2
end

function pg.SeriesGuideMgr.checkPtotocol(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_1.protocol
	local var_29_1 = _.select(arg_29_0.protocols, function(arg_30_0)
		return arg_30_0.protocol == var_29_0
	end)[1] or {}

	return arg_29_1.func(arg_29_2.view, var_29_1.args)
end

function pg.SeriesGuideMgr.increaseIndex(arg_31_0, arg_31_1)
	arg_31_0:updateIndex(arg_31_0.currIndex + 1, arg_31_1)

	return
end

function pg.SeriesGuideMgr.updateIndex(arg_32_0, arg_32_1, arg_32_2)
	pg.m02:sendNotification(GAME.UPDATE_GUIDE_INDEX, {
		isNewVersion = arg_32_0:IsNewVersion(),
		index = arg_32_1,
		callback = arg_32_2
	})

	return
end

function pg.SeriesGuideMgr.doNextStep(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0.stepConfig = nil

	if arg_33_0:isEnd() then
		return
	end

	;({}).view = arg_33_0.guideCfgs[arg_33_1].view[#arg_33_0.guideCfgs[arg_33_1].view]
	;({}).code = arg_33_2

	if arg_33_0:canPlay({}) then
		arg_33_0:start({})
	end

	return
end

function pg.SeriesGuideMgr.isEnd(arg_34_0)
	return arg_34_0.currIndex > #arg_34_0.guideCfgs or not ENABLE_GUIDE
end

function pg.SeriesGuideMgr.receiceProtocol(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	if not arg_35_0:IsInit() then
		return
	end

	table.insert(arg_35_0.protocols, {
		protocol = arg_35_1,
		args = arg_35_2,
		data = arg_35_3
	})

	if arg_35_0.onReceiceProtocol then
		arg_35_0.onReceiceProtocol(arg_35_1)
	end

	return
end

function pg.SeriesGuideMgr.canPlay(arg_36_0, arg_36_1)
	if arg_36_0.state ~= var_0_2.IDLE then
		log("guider is busy")

		return false
	end

	if not ENABLE_GUIDE then
		log("ENABLE is false")

		return false
	end

	if not arg_36_0.guideMgr then
		log("guideMgr is nil")

		return false
	end

	if not arg_36_0.playerLevel then
		log("player is nil")

		return false
	end

	if arg_36_0:isEnd() then
		log("guider is end")

		return false
	end

	local var_36_0 = arg_36_0:getStepConfig(arg_36_0.currIndex)

	if not table.contains(var_36_0.view, arg_36_1.view) then
		log("view is erro", arg_36_0.currIndex, arg_36_1.view, var_36_0.view[1], var_36_0.view[2])

		return false
	end

	return true
end

function pg.SeriesGuideMgr.setPlayer(arg_37_0, arg_37_1)
	arg_37_0.playerLevel = arg_37_1.level

	local var_37_0 = arg_37_1:GetGuideIndex(arg_37_0:IsNewVersion())

	arg_37_0.playerIndex = var_37_0
	arg_37_0.currIndex = var_37_0

	arg_37_0:compatibleOldPlayer()

	return
end

function pg.SeriesGuideMgr.dispose(arg_38_0)
	arg_38_0.playerLevel = nil
	arg_38_0.protocols = {}
	arg_38_0.state = var_0_2.IDLE

	return
end

function pg.SeriesGuideMgr.compatibleOldPlayer(arg_39_0)
	if not arg_39_0.playerLevel then
		return
	end

	local function var_39_0()
		arg_39_0:updateIndex(arg_39_0.lastIndex)

		return
	end

	if arg_39_0.playerLevel >= 5 and arg_39_0.playerIndex < arg_39_0.lastIndex then
		var_39_0()

		return
	end

	if arg_39_0.playerIndex ~= arg_39_0.lastIndex then
		pg.SystemGuideMgr.GetInstance():FixGuide(function()
			if arg_39_0.playerIndex > 1 and arg_39_0.playerIndex < 101 then
				var_39_0()
			end

			return
		end)
	end

	return
end

return
