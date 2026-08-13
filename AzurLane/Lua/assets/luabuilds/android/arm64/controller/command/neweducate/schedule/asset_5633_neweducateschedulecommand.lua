class = var_0_10000

local var_0_0 = "NewEducateScheduleCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.planKVs
	local var_1_2 = var_2.isSkip

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 29040, {
		id = var_1_0,
		plans = var_1_1
	}, 29041, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)
			local var_2_1 = var_1.GetCurChar(var_2_0)
			local var_2_2 = var_1.GetFSM(var_2_1)
			local var_2_3 = var_2.SetSystemNo

			NewEducateFSM = var_2_10006

			var_2_3(var_2_2, var_2_10006.SYSTEM.PLAN)

			local var_2_4 = var_2
			local var_2_5 = var_2.GetState

			NewEducateFSM = var_6

			local var_2_6 = var_2_5(var_2_4, var_6.SYSTEM.PLAN)
			local var_2_7

			if not arg_2_0.plans then
				var_2_7 = var_1_1
			end

			local var_2_8 = arg_1_0

			var_5.TrackPlan(var_2_8, var_1, var_1_1, var_2_7)
			var_2_6:SetPlans(var_2_7)
			var_2_6:SetResources(var_1:GetResources())

			local var_2_9 = var_2_6

			var_2_6.SetAttrs(var_2_9, var_1:GetAttrs())

			getProxy = var_5
			NewEducateProxy = var_2_9

			local var_2_10 = var_5(var_2_9)
			local var_2_11 = var_5.GetCurChar(var_2_10)
			local var_2_12 = var_5.GetPlanDiscountInfos(var_2_11)

			ipairs = var_6

			for iter_2_0, iter_2_1 in var_6(var_1_1) do
				NewEducatePlan = var_2_10011

				local var_2_13 = var_2_10011.New(iter_2_1.value)
				local var_2_14 = var_2_10011.GetCostWithBenefit(var_2_13, var_2_12)

				getProxy = var_13
				NewEducateProxy = var_15

				local var_2_15 = var_13(var_15)

				var_13.Costs(var_2_15, var_2_14)
			end

			local function var_2_16()
				if #var_2_7 > 0 then
					if not var_1_2 then
						local var_3_0 = arg_1_0
						local var_3_1 = var_0.sendNotification

						GAME = var_3_10003

						var_3_1(var_3_0, var_3_10003.NEW_EDUCATE_NEXT_PLAN, {
							id = var_1_0
						})
					else
						local var_3_2 = arg_1_0
						local var_3_3 = var_0.sendNotification

						GAME = var_3_10003

						var_3_3(var_3_2, var_3_10003.NEW_EDUCATE_SCHEDULE_SKIP, {
							id = var_1_0
						})
					end
				else
					local var_3_4 = arg_1_0
					local var_3_5 = var_0.sendNotification

					GAME = var_3_10003

					var_3_5(var_3_4, var_3_10003.NEW_EDUCATE_GET_EXTRA_DROP, {
						id = var_1_0,
						scheduleDrops = {}
					})
				end

				return
			end

			NewEducateDropHelper = var_7

			local var_2_17 = var_7.HandleDrops(arg_2_0.drop)
			local var_2_18 = arg_1_0
			local var_2_19 = var_8.sendNotification

			GAME = var_2_10011

			var_2_19(var_2_18, var_2_10011.NEW_EDUCATE_SCHEDULE_DONE, {
				drops = var_2_17,
				callback = var_2_16
			})
		else
			pg = var_1

			local var_2_20 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_20, "NewEducate_Schedule: " .. arg_2_0.result)
		end

		return
	end)

	return
end

function var_0_1.TrackPlan(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	underscore = var_1_10004

	local var_4_0 = var_1_10004.map(arg_4_2, function(arg_5_0)
		return arg_5_0.value
	end)

	table = var_1_10005

	local var_4_1 = var_1_10005.sort
	local var_4_2 = arg_4_3

	CompareFuncs = var_1_10008

	var_4_1(var_4_2, var_1_10008({
		function(arg_6_0)
			return arg_6_0.key
		end
	}))

	underscore = var_4_1

	local var_4_3 = var_4_1.map(arg_4_3, function(arg_7_0)
		return arg_7_0.value
	end)

	pg = var_6

	local var_4_4 = var_6.m02
	local var_4_5 = var_6.sendNotification

	GAME = var_1_10009

	local var_4_6 = var_1_10009.NEW_EDUCATE_TRACK

	NewEducateTrackCommand = var_10

	local var_4_7 = var_10.BuildDataPlan
	local var_4_8 = arg_4_1.id
	local var_4_9 = arg_4_1
	local var_4_10 = arg_4_1.GetGameCnt(var_4_9)
	local var_4_11 = arg_4_1
	local var_4_12 = arg_4_1.GetRoundData(var_4_11).round

	table = var_4_9

	local var_4_13 = var_4_9.concat(var_4_0, ",")

	table = var_4_11

	var_4_5(var_4_4, var_4_6, var_4_7(var_4_8, var_4_10, var_4_12, var_4_13, var_4_11.concat(var_4_3, ",")))

	return
end

return var_0_1
