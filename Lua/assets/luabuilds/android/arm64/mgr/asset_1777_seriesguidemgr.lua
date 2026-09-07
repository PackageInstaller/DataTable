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

function pg.SeriesGuideMgr:isRunning()
	return self.state == var_0_2.BUSY
end

function pg.SeriesGuideMgr:IsInit()
	return self.state and self.state >= var_0_2.IDLE
end

function pg.SeriesGuideMgr:isNotFinish()
	local var_4_0 = getProxy(PlayerProxy)

	if var_4_0 then
		return var_4_0:getRawData():GetGuideIndex(self:IsNewVersion()) < self.lastIndex - 1
	end

	return
end

function pg.SeriesGuideMgr:IsNewVersion()
	return self.isNewVersion
end

function pg.SeriesGuideMgr.loadGuide(arg_6_0, arg_6_1)
	print("load guide script:", arg_6_1)

	return require("GameCfg.guide.newguide." .. arg_6_1)
end

function pg.SeriesGuideMgr:getStepConfig(arg_7_1)
	return self.guideCfgs[arg_7_1]
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

function pg.SeriesGuideMgr:Init(arg_9_1, arg_9_2)
	self.state = var_0_2.IDLE
	self.isNewVersion = self:CheckNewVersion(arg_9_1, arg_9_2)
	self.guideCfgs = self:loadGuide(self.isNewVersion and "SG002" or "SG001")
	self.lastIndex = #self.guideCfgs + 1
	self.guideMgr = pg.NewGuideMgr.GetInstance()
	self.protocols = {}
	self.onReceiceProtocol = nil

	self:setPlayer(arg_9_2)

	return
end

function pg.SeriesGuideMgr:dispatch(arg_10_1)
	if self:canPlay(arg_10_1) then
		self.guideMgr:PlayNothing()
	end

	return
end

function pg.SeriesGuideMgr:start(arg_11_1)
	if self:canPlay(arg_11_1) then
		self.state = var_0_2.BUSY

		self.guideMgr:StopNothing()

		self.stepConfig = self:getStepConfig(self.currIndex)

		local function var_11_0(arg_12_0)
			self.state = var_0_2.IDLE
			self.protocols = {}

			if not self.stepConfig.interrupt then
				self:doNextStep(self.currIndex, arg_12_0)
			end

			return
		end

		self:doGuideStep(arg_11_1, function(arg_13_0, arg_13_1)
			if self.stepConfig.end_segment and arg_13_1 then
				self.guideMgr:Play(self.stepConfig.end_segment, arg_11_1.code, function()
					var_11_0(arg_13_0)

					return
				end, nil, function(arg_15_0, arg_15_1)
					self:Record(self.currIndex - 1, arg_15_0, arg_15_1, self.stepConfig.end_segment)

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

function pg.SeriesGuideMgr:doGuideStep(arg_16_1, arg_16_2)
	if self.stepConfig.condition then
		local var_16_0, var_16_1, var_16_2 = self:checkCondition(arg_16_1)
		local var_16_3 = var_16_2 and var_16_1 > self.currIndex

		self:updateIndex(var_16_1, function()
			arg_16_2({
				var_16_0
			}, var_16_3)

			return
		end)
	else
		local var_16_4 = self.stepConfig.segment[self:getSegmentIndex()]
		local var_16_5 = var_16_4[1]
		local var_16_6 = var_16_4[2]

		assert(var_16_4[2], "protocol can not be nil")
		seriesAsync({
			function(arg_18_0)
				self.guideMgr:Play(var_16_5, arg_16_1.code, arg_18_0, function()
					self:updateIndex(self.lastIndex)

					return
				end, function(arg_20_0, arg_20_1)
					self:Record(self.currIndex, arg_20_0, arg_20_1, var_16_5)

					return
				end)
				self.guideMgr:PlayNothing()

				return
			end,
			function(arg_21_0)
				if _.any(self.protocols, function(arg_22_0)
					return arg_22_0.protocol == var_16_6
				end) then
					arg_21_0()

					return
				end

				function self.onReceiceProtocol(arg_23_0)
					if arg_23_0 == var_16_6 then
						self.onReceiceProtocol = nil

						arg_21_0()
					end

					return
				end

				return
			end,
			function(arg_24_0)
				self.guideMgr:StopNothing()
				self:increaseIndex(arg_24_0)

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

function pg.SeriesGuideMgr:Record(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_0 = pg.TimeMgr.GetInstance()

	pg.GameTrackerMgr.GetInstance().Record(var_26_0, GameTrackerBuilder.BuildGuide(self:IsNewVersion(), arg_26_1, arg_26_2, var_26_0:GetServerTime() - arg_26_3, arg_26_4))

	return
end

function pg.SeriesGuideMgr:getSegmentIndex()
	return (self.stepConfig.getSegment or nil) and self.stepConfig.getSegment()
end

local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3

function pg.SeriesGuideMgr:checkCondition(arg_28_1)
	local var_28_0
	local var_28_1
	local var_28_2 = true

	if self.stepConfig.condition.arg[1] == var_0_3 then
		var_28_1, var_28_0 = self:checkPtotocol({
			protocol = self.stepConfig.condition.arg[2],
			func = self.stepConfig.condition.func
		}, arg_28_1)
	elseif self.stepConfig.condition.arg[1] == var_0_4 then
		var_28_1, var_28_0 = self.stepConfig.condition.func((getProxy(BayProxy):getShipById(getProxy(PlayerProxy):getRawData().character)))
		self.stepConfig.condition = nil
	elseif self.stepConfig.condition.arg[1] == var_0_5 then
		var_28_1, var_28_0 = self.stepConfig.condition.func(NewServerCarnivalScene.isShow())
		self.stepConfig.condition = nil
		var_28_2 = false
	end

	assert(var_28_0, "index can not be nil")

	return var_28_1, var_28_0, var_28_2
end

function pg.SeriesGuideMgr:checkPtotocol(arg_29_1, arg_29_2)
	local var_29_0 = arg_29_1.protocol

	return arg_29_1.func(arg_29_2.view, (_.select(self.protocols, function(arg_30_0)
		return arg_30_0.protocol == var_29_0
	end)[1] or {}).args)
end

function pg.SeriesGuideMgr:increaseIndex(arg_31_1)
	self:updateIndex(self.currIndex + 1, arg_31_1)

	return
end

function pg.SeriesGuideMgr:updateIndex(arg_32_1, arg_32_2)
	pg.m02:sendNotification(GAME.UPDATE_GUIDE_INDEX, {
		isNewVersion = self:IsNewVersion(),
		index = arg_32_1,
		callback = arg_32_2
	})

	return
end

function pg.SeriesGuideMgr:doNextStep(arg_33_1, arg_33_2)
	self.stepConfig = nil

	local var_33_0

	if self:isEnd() then
		do return end

		var_33_0 = {}
	end

	var_33_0.view = self.guideCfgs[arg_33_1].view[#self.guideCfgs[arg_33_1].view]
	var_33_0.code = arg_33_2

	if self:canPlay(var_33_0) then
		self:start(var_33_0)
	end

	return
end

function pg.SeriesGuideMgr:isEnd()
	return self.currIndex > #self.guideCfgs or not ENABLE_GUIDE
end

function pg.SeriesGuideMgr:receiceProtocol(arg_35_1, arg_35_2, arg_35_3)
	if not self:IsInit() then
		return
	end

	table.insert(self.protocols, {
		protocol = arg_35_1,
		args = arg_35_2,
		data = arg_35_3
	})

	if self.onReceiceProtocol then
		self.onReceiceProtocol(arg_35_1)
	end

	return
end

function pg.SeriesGuideMgr:canPlay(arg_36_1)
	if self.state ~= var_0_2.IDLE then
		log("guider is busy")

		return false
	end

	if not ENABLE_GUIDE then
		log("ENABLE is false")

		return false
	end

	if not self.guideMgr then
		log("guideMgr is nil")

		return false
	end

	if not self.playerLevel then
		log("player is nil")

		return false
	end

	if self:isEnd() then
		log("guider is end")

		return false
	end

	local var_36_0 = self:getStepConfig(self.currIndex)

	if not table.contains(var_36_0.view, arg_36_1.view) then
		log("view is erro", self.currIndex, arg_36_1.view, var_36_0.view[1], var_36_0.view[2])

		return false
	end

	return true
end

function pg.SeriesGuideMgr:setPlayer(arg_37_1)
	self.playerLevel = arg_37_1.level

	local var_37_0 = arg_37_1:GetGuideIndex(self:IsNewVersion())

	self.playerIndex = var_37_0
	self.currIndex = var_37_0

	self:compatibleOldPlayer()

	return
end

function pg.SeriesGuideMgr.dispose(arg_38_0)
	arg_38_0.playerLevel = nil
	arg_38_0.protocols = {}
	arg_38_0.state = var_0_2.IDLE

	return
end

function pg.SeriesGuideMgr:compatibleOldPlayer()
	if not self.playerLevel then
		return
	end

	local function var_39_0()
		self:updateIndex(self.lastIndex)

		return
	end

	if self.playerLevel >= 5 and self.playerIndex < self.lastIndex then
		var_39_0()

		return
	end

	if self.playerIndex ~= self.lastIndex then
		pg.SystemGuideMgr.GetInstance():FixGuide(function()
			if self.playerIndex > 1 and self.playerIndex < 101 then
				var_39_0()
			end

			return
		end)
	end

	return
end

return
