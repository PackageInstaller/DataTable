local var_0_0 = class("AtelierCompositeCommand", pm.SimpleCommand)

function var_0_0.SerialAsyncUnitl(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = 0

	;(function()
		var_1_0 = var_1_0 + 1

		if var_1_0 <= arg_1_1 then
			arg_1_0(var_1_0, var_0)
		else
			existCall(arg_1_2)
		end

		return
	end)()

	return
end

function var_0_0.execute(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.body.formulaId
	local var_3_1 = arg_3_1.body.items
	local var_3_2 = arg_3_1.body.repeats
	local var_3_3 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)

	assert(var_3_3)
	pg.ConnectionMgr.GetInstance():Send(26053, {
		act_id = var_3_3.id,
		recipe_id = arg_3_1.body.formulaId,
		items = arg_3_1.body.items,
		times = arg_3_1.body.repeats
	}, 26054, function(arg_4_0)
		if arg_4_0.result == 0 then
			var_3_3 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)

			local var_4_0 = var_3_3:GetItems()

			_.each(var_3_1, function(arg_5_0)
				if not var_4_0[arg_5_0.value] then
					return
				end

				var_4_0[arg_5_0.value].count = var_4_0[arg_5_0.value].count - var_3_2

				if var_4_0[arg_5_0.value].count <= 0 then
					var_4_0[arg_5_0.value] = nil
				end

				return
			end)
			var_3_3:AddFormulaUseCount(var_3_0, var_3_2)
			getProxy(ActivityProxy):updateActivity(var_3_3)
			arg_3_0:sendNotification(GAME.COMPOSITE_ATELIER_RECIPE_DONE, (PlayerConst.addTranDrop(arg_4_0.award_list)))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_4_0.result))
		end

		return
	end)

	return
end

return var_0_0
