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

function var_0_0.StartGame(arg_2_0, arg_2_1)
	arg_2_0.score_ = 0
	arg_2_0.isEnd_ = false
	arg_2_0.fullTime_ = arg_2_1
	arg_2_0.remainTime_ = arg_2_1
	arg_2_0.propList_ = {}
	arg_2_0.startServerTime_ = manager.time:GetServerTime()
	arg_2_0.pausing_ = false
	arg_2_0.thiefThing_ = {}
	arg_2_0.returnThiefThing_ = {}

	if not arg_2_0.frameTimer_ then
		arg_2_0.frameTimer_ = FrameTimer.New(handler(arg_2_0, arg_2_0.Update), 1, -1)
	end

	arg_2_0.frameTimer_:Start()
end

function var_0_0.GetUseSeconds(arg_3_0)
	local var_3_0 = math.floor(arg_3_0.remainTime_)

	return arg_3_0.fullTime_ - var_3_0
end

function var_0_0.AddThing(arg_4_0, arg_4_1)
	table.insert(arg_4_0.things_, arg_4_1)
end

function var_0_0.RemoveThing(arg_5_0, arg_5_1)
	local var_5_0 = table.indexof(arg_5_0.things_, arg_5_1)

	if var_5_0 then
		table.remove(arg_5_0.things_, var_5_0)
	end
end

function var_0_0.GetThing(arg_6_0)
	return arg_6_0.things_
end

function var_0_0.ThingIsActive(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.things_) do
		if iter_7_1:GetID() == arg_7_1 then
			return true
		end
	end

	return false
end

function var_0_0.DisposeAllThing(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.things_) do
		iter_8_1:Dispose()
	end

	arg_8_0.things_ = {}
end

function var_0_0.AddThief(arg_9_0, arg_9_1)
	table.insert(arg_9_0.thiefs_, arg_9_1)
end

function var_0_0.RemoveThief(arg_10_0, arg_10_1)
	local var_10_0 = table.indexof(arg_10_0.thiefs_, arg_10_1)

	if var_10_0 then
		table.remove(arg_10_0.thiefs_, var_10_0)
	end
end

function var_0_0.GetThief(arg_11_0)
	return arg_11_0.thiefs_
end

function var_0_0.DisposeAllThief(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.thiefs_) do
		iter_12_1:Dispose()
	end

	arg_12_0.thiefs_ = {}
end

function var_0_0.AddNoDataGo(arg_13_0, arg_13_1)
	table.insert(arg_13_0.noDataGos_, arg_13_1)
end

function var_0_0.DestoryNoDataGos(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.noDataGos_) do
		Object.Destroy(iter_14_1)
	end

	arg_14_0.noDataGos_ = {}
end

function var_0_0.GetGameRoot(arg_15_0)
	return arg_15_0.gameRootContainer_
end

function var_0_0.CheckEnd(arg_16_0)
	if arg_16_0.remainTime_ <= 0 then
		arg_16_0:GameEnd()
	end
end

function var_0_0.Update(arg_17_0)
	if arg_17_0.pausing_ then
		return
	end

	local var_17_0 = Time.deltaTime

	arg_17_0.remainTime_ = arg_17_0.remainTime_ - var_17_0

	arg_17_0:CheckEnd()
	arg_17_0.gameView_:Update(var_17_0, arg_17_0.remainTime_)

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.things_) do
		iter_17_1:Update(var_17_0)
	end

	for iter_17_2, iter_17_3 in ipairs(arg_17_0.thiefs_) do
		iter_17_3:Update(var_17_0)
	end

	if arg_17_0.hook_ ~= nil then
		arg_17_0.hook_:Update(var_17_0)
	end
end

function var_0_0.Pause(arg_18_0)
	arg_18_0.pausing_ = true
end

function var_0_0.ReStart(arg_19_0)
	arg_19_0.pausing_ = false
end

function var_0_0.AddProp(arg_20_0, arg_20_1)
	table.insert(arg_20_0.propList_, arg_20_1)
end

function var_0_0.GetPropList(arg_21_0)
	return arg_21_0.propList_
end

function var_0_0.AddScore(arg_22_0, arg_22_1)
	arg_22_0.score_ = arg_22_0.score_ + arg_22_1

	arg_22_0.gameView_:UpdateScore(arg_22_0.score_, arg_22_1)
end

function var_0_0.GetScore(arg_23_0)
	return arg_23_0.score_
end

function var_0_0.GameEnd(arg_24_0)
	arg_24_0.isEnd_ = true

	arg_24_0:StopTimer()
end

function var_0_0.GetIsEnd(arg_25_0)
	return arg_25_0.isEnd_
end

function var_0_0.StopTimer(arg_26_0)
	if arg_26_0.frameTimer_ then
		arg_26_0.frameTimer_:Stop()

		arg_26_0.frameTimer_ = nil
	end
end

function var_0_0.AddThiefThing(arg_27_0, arg_27_1)
	table.insert(arg_27_0.thiefThing_, arg_27_1)
end

function var_0_0.AddReturnThiefThing(arg_28_0, arg_28_1)
	table.insert(arg_28_0.returnThiefThing_, arg_28_1)
end

function var_0_0.GetThiefThing(arg_29_0)
	return arg_29_0.thiefThing_
end

function var_0_0.GetReturnThiefThing(arg_30_0)
	return arg_30_0.returnThiefThing_
end

function var_0_0.SendMessageToSDK(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5)
	local var_31_0 = ActivityGodEaterGoldminerStageCfg[arg_31_1]
	local var_31_1 = arg_31_0.score_
	local var_31_2 = 0

	for iter_31_0, iter_31_1 in pairs(var_31_0.score) do
		if iter_31_1 < var_31_1 then
			var_31_2 = iter_31_0
		end
	end

	local var_31_3 = arg_31_0.propList_
	local var_31_4
	local var_31_5 = var_31_2 > 0 and 1 or 2
	local var_31_6 = var_0_0._singletonInstance:GetUseSeconds()
	local var_31_7 = string.format("[%s]", table.concat(var_31_3, ","))
	local var_31_8 = string.format("[[%s],[%s]]", table.concat(arg_31_0.thiefThing_, ","), table.concat(arg_31_0.returnThiefThing_, ","))

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = ActivityConst.ACTIVITY_GOLDMINER,
		stage_id = arg_31_1,
		result = var_31_5,
		hero_id = arg_31_2,
		score = var_31_1,
		use_seconds = var_31_6,
		combat_star = var_31_2,
		hit_num = arg_31_3,
		skill_num = arg_31_5,
		cell_num = arg_31_4,
		params_list = var_31_7,
		other_data = var_31_8
	})
end

function var_0_0.ClearStage(arg_32_0)
	arg_32_0:DisposeAllThing()
	arg_32_0:DisposeAllThief()
	arg_32_0:DestoryNoDataGos()
end

function var_0_0.Dispose(arg_33_0)
	arg_33_0:StopTimer()

	if arg_33_0.hook_ then
		arg_33_0.hook_:Dispose()

		arg_33_0.hook_ = nil
	end

	arg_33_0.gameView_ = nil
	arg_33_0.gameRootContainer_ = nil

	arg_33_0:ClearStage()
end

return var_0_0
