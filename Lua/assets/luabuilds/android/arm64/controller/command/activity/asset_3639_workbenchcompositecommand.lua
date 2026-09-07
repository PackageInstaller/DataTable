local WorkBenchCompositeCommand = class("WorkBenchCompositeCommand", pm.SimpleCommand)

function WorkBenchCompositeCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1.body
	local var_1_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_WORKBENCH)

	if not var_1_1 or var_1_1:isEnd() then
		return
	end

	local var_1_2 = var_1_1.id
	local var_1_3 = arg_1_1.body.formulaId
	local var_1_4 = arg_1_1.body.repeats
	local var_1_5 = WorkBenchFormula.New({
		configId = arg_1_1.body.formulaId
	})

	var_1_5:BuildFromActivity()

	local var_1_6 = var_1_5:GetMaterials()

	if not (function()
		if not var_1_5:IsUnlock() then
			return
		end

		local var_2_0 = var_1_5:GetMaxLimit()

		if var_1_4 <= 0 then
			return
		end

		if var_2_0 > 0 and var_1_4 > var_2_0 - var_1_5:GetUsedCount() then
			return
		end

		local var_2_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)

		if not _.all(var_1_6, function(arg_3_0)
			assert(arg_3_0[1] > DROP_TYPE_USE_ACTIVITY_DROP)

			return arg_3_0[3] * var_1_4 <= var_2_1:getVitemNumber(arg_3_0[2])
		end) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("workbench_tips2"))

			return
		end

		return true
	end)() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 1,
		activity_id = var_1_2,
		arg1 = arg_1_1.body.formulaId,
		arg2 = arg_1_1.body.repeats,
		arg_list = {}
	}, 11203, function(arg_4_0)
		if arg_4_0.result == 0 then
			local var_4_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)

			_.each(var_1_6, function(arg_5_0)
				var_4_0:subVitemNumber(arg_5_0[2], arg_5_0[3] * var_1_4)

				return
			end)
			getProxy(ActivityProxy):updateActivity(var_4_0)

			local var_4_1 = getProxy(ActivityProxy):getActivityById(var_1_2)

			var_4_1:AddFormulaUseCount(var_1_3, var_1_4)
			getProxy(ActivityProxy):updateActivity(var_4_1)
			self:sendNotification(GAME.WORKBENCH_COMPOSITE_DONE, (PlayerConst.GetTranAwards(var_1_0, arg_4_0)))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_4_0.result))
		end

		return
	end)

	return
end

return WorkBenchCompositeCommand
