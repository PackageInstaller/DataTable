class = var_0_10000

local var_0_0 = "FinishTechnologyCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.pool_id

	getProxy = var_1_10005
	TechnologyProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	if not var_5.getTechnologyById(var_1_2, var_1_0) then
		return
	end

	if not var_6:isCompleted() then
		return
	end

	pg = var_7

	local var_1_3 = var_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_3, 27, {
		tech_id = var_1_0,
		refresh_id = var_1_1
	}, 28, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_2.reset(var_2_0)

			local var_2_1 = var_0

			var_2_2.updateTechnology(var_2_1, var_0)

			var_2_2 = {}
			PlayerConst = var_2_1
			var_2_2.items = var_2_1.addTranDrop(arg_2_0.common_list)
			PlayerConst = var_2
			var_2_2.commons = var_2.addTranDrop(arg_2_0.drop_list)
			PlayerConst = var_2
			var_2_2.catchupItems = var_2.addTranDrop(arg_2_0.catchup_list)
			PlayerConst = var_2
			var_2_2.catchupActItems = var_2.addTranDrop(arg_2_0.catchupact_list)
			underscore = var_2

			var_2.each(var_2_2.catchupItems, function(arg_3_0)
				local var_3_0 = var_0

				var_1.addCatupPrintsNum(var_3_0, arg_3_0.count)

				return
			end)

			getProxy = var_2
			ActivityProxy = var_2_10003

			local var_2_3 = var_2(var_2_10003)

			var_2_10003 = var_2.getActivityByType
			ActivityConst = var_2_10005

			if var_2_10003(var_2_3, var_2_10005.ACTIVITY_TYPE_BLUEPRINT_CATCHUP) and not var_2_10003:isEnd() then
				underscore = var_4

				var_4.each(var_2_2.catchupActItems, function(arg_4_0)
					var_2_10003.data1 = var_2_10003.data1 + arg_4_0.count

					return
				end)
			end

			local var_2_4 = var_0

			var_4.updateTechnologys(var_2_4, arg_2_0.refresh_list)

			local var_2_5 = arg_1_0
			local var_2_6 = var_4.sendNotification

			GAME = var_6

			local var_2_7 = var_6.FINISH_TECHNOLOGY_DONE
			local var_2_8 = {}

			PlayerConst = var_2_10008
			var_2_8.items = var_2_10008.MergeTechnologyAward(var_2_2)

			var_2_6(var_2_5, var_2_7, var_2_8)
		else
			pg = var_2_2

			local var_2_9 = var_2_2.TipsMgr.GetInstance()
			local var_2_10 = var_1.ShowTips

			i18n = var_2_10003

			var_2_10(var_2_9, var_2_10003("technology_finish_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
