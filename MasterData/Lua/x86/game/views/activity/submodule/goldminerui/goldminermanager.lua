local var_0_0 = singletonClass("GoldMinerManager")

function var_0_0.Init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.things_ = {}
	arg_1_0.thiefs_ = {}
	arg_1_0.noDataGos_ = {}
	arg_1_0.hook_ = nil
	arg_1_0.frameTimer_ = nil
	arg_1_0.score_ = 0
	arg_1_0.propList_ = {}
	arg_1_0.startServerTime_ = 0
	arg_1_0.isEnd_ = true
	arg_1_0.remainTime_ = 0
	arg_1_0.pausing_ = false
	arg_1_0.thiefThing_ = {}
	arg_1_0.returnThiefThing_ = {}
	arg_1_0.gameView_ = arg_1_1
	arg_1_0.gameRootContainer_ = arg_1_2
	arg_1_0.hook_ = arg_1_3
end

function var_0_0:StartGame(arg_2_1)
	self.score_ = 0
	self.isEnd_ = false
	self.fullTime_ = arg_2_1
	self.remainTime_ = arg_2_1
	self.propList_ = {}
	self.startServerTime_ = manager.time:GetServerTime()
	self.pausing_ = false
	self.thiefThing_ = {}
	self.returnThiefThing_ = {}
	self.frameTimer_ = self.frameTimer_ or FrameTimer.New(handler(self, self.Update), 1, -1)

	self.frameTimer_:Start()
end

function var_0_0:GetUseSeconds()
	return self.fullTime_ - math.floor(self.remainTime_)
end

function var_0_0:AddThing(arg_4_1)
	table.insert(self.things_, arg_4_1)
end

function var_0_0:RemoveThing(arg_5_1)
	local var_5_0 = table.indexof(self.things_, arg_5_1)

	if var_5_0 then
		table.remove(self.things_, var_5_0)
	end
end

function var_0_0:GetThing()
	return self.things_
end

function var_0_0:ThingIsActive(arg_7_1)
	for iter_7_0, iter_7_1 in pairs(self.things_) do
		if iter_7_1:GetID() == arg_7_1 then
			return true
		end
	end

	return false
end

function var_0_0:DisposeAllThing()
	for iter_8_0, iter_8_1 in pairs(self.things_) do
		iter_8_1:Dispose()
	end

	self.things_ = {}
end

function var_0_0:AddThief(arg_9_1)
	table.insert(self.thiefs_, arg_9_1)
end

function var_0_0:RemoveThief(arg_10_1)
	local var_10_0 = table.indexof(self.thiefs_, arg_10_1)

	if var_10_0 then
		table.remove(self.thiefs_, var_10_0)
	end
end

function var_0_0:GetThief()
	return self.thiefs_
end

function var_0_0:DisposeAllThief()
	for iter_12_0, iter_12_1 in pairs(self.thiefs_) do
		iter_12_1:Dispose()
	end

	self.thiefs_ = {}
end

function var_0_0:AddNoDataGo(arg_13_1)
	table.insert(self.noDataGos_, arg_13_1)
end

function var_0_0:DestoryNoDataGos(arg_14_1)
	for iter_14_0, iter_14_1 in pairs(self.noDataGos_) do
		Object.Destroy(iter_14_1)
	end

	self.noDataGos_ = {}
end

function var_0_0:GetGameRoot()
	return self.gameRootContainer_
end

function var_0_0:CheckEnd()
	if self.remainTime_ <= 0 then
		self:GameEnd()
	end
end

function var_0_0:Update()
	if self.pausing_ then
		return
	end

	local var_17_0 = Time.deltaTime

	self.remainTime_ = self.remainTime_ - Time.deltaTime

	self:CheckEnd()
	self.gameView_:Update(var_17_0, self.remainTime_)

	for iter_17_0, iter_17_1 in ipairs(self.things_) do
		iter_17_1:Update(var_17_0)
	end

	for iter_17_2, iter_17_3 in ipairs(self.thiefs_) do
		iter_17_3:Update(var_17_0)
	end

	if self.hook_ ~= nil then
		self.hook_:Update(var_17_0)
	end
end

function var_0_0.Pause(arg_18_0)
	arg_18_0.pausing_ = true
end

function var_0_0.ReStart(arg_19_0)
	arg_19_0.pausing_ = false
end

function var_0_0:AddProp(arg_20_1)
	table.insert(self.propList_, arg_20_1)
end

function var_0_0:GetPropList()
	return self.propList_
end

function var_0_0:AddScore(arg_22_1)
	self.score_ = self.score_ + arg_22_1

	self.gameView_:UpdateScore(self.score_, arg_22_1)
end

function var_0_0:GetScore()
	return self.score_
end

function var_0_0:GameEnd()
	self.isEnd_ = true

	self:StopTimer()
end

function var_0_0:GetIsEnd()
	return self.isEnd_
end

function var_0_0:StopTimer()
	if self.frameTimer_ then
		self.frameTimer_:Stop()

		self.frameTimer_ = nil
	end
end

function var_0_0:AddThiefThing(arg_27_1)
	table.insert(self.thiefThing_, arg_27_1)
end

function var_0_0:AddReturnThiefThing(arg_28_1)
	table.insert(self.returnThiefThing_, arg_28_1)
end

function var_0_0:GetThiefThing()
	return self.thiefThing_
end

function var_0_0:GetReturnThiefThing()
	return self.returnThiefThing_
end

function var_0_0:SendMessageToSDK(arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5)
	local var_31_0 = self.score_
	local var_31_1 = 0

	for iter_31_0, iter_31_1 in pairs(ActivityGodEaterGoldminerStageCfg[arg_31_1].score) do
		if iter_31_1 < var_31_0 then
			var_31_1 = iter_31_0
		end
	end

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = ActivityConst.ACTIVITY_GOLDMINER,
		stage_id = arg_31_1,
		result = var_31_1 > 0 and 1 or 2,
		hero_id = arg_31_2,
		score = var_31_0,
		use_seconds = var_0_0._singletonInstance:GetUseSeconds(),
		combat_star = var_31_1,
		hit_num = arg_31_3,
		skill_num = arg_31_5,
		cell_num = arg_31_4,
		params_list = string.format("[%s]", table.concat(self.propList_, ",")),
		other_data = string.format("[[%s],[%s]]", table.concat(self.thiefThing_, ","), table.concat(self.returnThiefThing_, ","))
	})
end

function var_0_0:ClearStage()
	self:DisposeAllThing()
	self:DisposeAllThief()
	self:DestoryNoDataGos()
end

function var_0_0:Dispose()
	self:StopTimer()

	if self.hook_ then
		self.hook_:Dispose()

		self.hook_ = nil
	end

	self.gameView_ = nil
	self.gameRootContainer_ = nil

	self:ClearStage()
end

return var_0_0
