class = var_0_10000

local var_0_0 = "WorkBenchCompositeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.body

	getProxy = var_1_10003
	ActivityProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_2 = var_3.getActivityByType

	ActivityConst = var_1_10006

	if not var_1_2(var_1_1, var_1_10006.ACTIVITY_TYPE_WORKBENCH) or var_3:isEnd() then
		return
	end

	local var_1_3 = var_3.id
	local var_1_4 = var_1_0.formulaId
	local var_1_5 = var_1_0.repeats

	WorkBenchFormula = var_1_10007

	local var_1_6 = var_1_10007.New({
		configId = var_1_4
	})

	var_7.BuildFromActivity(var_1_6)

	local var_1_7 = var_7:GetMaterials()

	if not (function()
		local var_2_0 = var_0

		if not var_0.IsUnlock(var_2_0) then
			return
		end

		local var_2_1 = var_0
		local var_2_2 = var_1.GetMaxLimit(var_2_1)
		local var_2_3 = var_0
		local var_2_4 = var_2.GetUsedCount(var_2_3)

		if var_1_5 <= 0 then
			return
		end

		local var_2_5

		if 0 < var_2_2 then
			var_2_5 = var_1_5

			if var_2_2 - var_2_4 < var_2_5 then
				return
			end
		end

		getProxy = var_2_5
		ActivityProxy = var_2_10005

		local var_2_6 = var_2_5(var_2_10005)
		local var_2_7 = var_3.getActivityByType

		ActivityConst = var_2_10006

		local var_2_8 = var_2_7(var_2_6, var_2_10006.ACTIVITY_TYPE_VIRTUAL_BAG)

		_ = var_4

		if not var_4.all(var_1_7, function(arg_3_0)
			assert = var_3_10001

			local var_3_0 = arg_3_0[1]

			DROP_TYPE_USE_ACTIVITY_DROP = var_3_10004

			var_3_10001(var_3_10004 < var_3_0)

			local var_3_1 = arg_3_0[2]
			local var_3_2 = arg_3_0[3] * var_1_5
			local var_3_3 = var_2_8

			return var_3_2 <= var_3.getVitemNumber(var_3_3, var_3_1)
		end) then
			pg = var_4

			local var_2_9 = var_4.TipsMgr.GetInstance()
			local var_2_10 = var_4.ShowTips

			i18n = var_7

			var_2_10(var_2_9, var_7("workbench_tips2"))

			return
		end

		return true
	end)() then
		return
	end

	pg = var_10

	local var_1_8 = var_10.ConnectionMgr.GetInstance()

	var_10.Send(var_1_8, 11202, {
		cmd = 1,
		activity_id = var_1_3,
		arg1 = var_1_4,
		arg2 = var_1_5,
		arg_list = {}
	}, 11203, function(arg_4_0)
		local var_4_1

		if arg_4_0.result == 0 then
			getProxy = var_4_1
			ActivityProxy = var_2_10003

			local var_4_0 = var_4_1(var_2_10003)

			var_4_1 = var_4_1.getActivityByType
			ActivityConst = var_2_10004
			var_4_1 = var_4_1(var_4_0, var_2_10004.ACTIVITY_TYPE_VIRTUAL_BAG)
			_ = var_2_10002

			var_2_10002.each(var_1_7, function(arg_5_0)
				local var_5_0 = arg_5_0[2]
				local var_5_1 = arg_5_0[3] * var_1_5
				local var_5_2 = var_4_1

				var_3.subVitemNumber(var_5_2, var_5_0, var_5_1)

				return
			end)

			getProxy = var_2
			ActivityProxy = var_2_10004
			var_2_10004 = var_2(var_2_10004)

			var_2.updateActivity(var_2_10004, var_4_1)

			PlayerConst = var_2

			local var_4_2 = var_2.GetTranAwards(var_1_0, arg_4_0)

			getProxy = var_4_0
			ActivityProxy = var_5

			local var_4_3 = var_4_0(var_5)
			local var_4_4 = var_3.getActivityById(var_4_3, var_1_3)

			var_3.AddFormulaUseCount(var_4_4, var_1_4, var_1_5)

			getProxy = var_2_10004
			ActivityProxy = var_4_4

			local var_4_5 = var_2_10004(var_4_4)

			var_2_10004.updateActivity(var_4_5, var_3)

			local var_4_6 = arg_1_0

			var_2_10004 = var_2_10004.sendNotification
			GAME = var_7

			var_2_10004(var_4_6, var_7.WORKBENCH_COMPOSITE_DONE, var_4_2)
		else
			pg = var_4_1

			local var_4_7 = var_4_1.TipsMgr.GetInstance()
			local var_4_8 = var_1.ShowTips

			errorTip = var_2_10004

			var_4_8(var_4_7, var_2_10004("", arg_4_0.result))
		end

		return
	end)

	return
end

return var_0_1
