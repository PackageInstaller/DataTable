class = var_0_10000

local var_0_0 = "FinishQueueTechnologyCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	TechnologyProxy = var_1_10004

	if #var_1_0(var_1_10004).queue ~= 0 then
		local var_1_2 = var_3.queue[1]

		if not var_4.isCompleted(var_1_2) then
			return
		end

		pg = var_4

		local var_1_3 = var_4.ConnectionMgr.GetInstance()

		var_4.Send(var_1_3, 63015, {
			id = 0
		}, 63016, function(arg_2_0)
			local var_2_0

			if arg_2_0.result == 0 then
				getProxy = var_2_0
				ActivityProxy = var_2_10002
				var_2_0 = var_2_0(var_2_10002)

				local var_2_1 = {}

				ipairs = var_2_10003

				for iter_2_0, iter_2_1 in var_2_10003(arg_2_0.drops) do
					local var_2_2 = {}

					PlayerConst = var_2_10009
					var_2_2.items = var_2_10009.addTranDrop(iter_2_1.common_list)
					PlayerConst = var_2_10009
					var_2_2.commons = var_2_10009.addTranDrop(iter_2_1.drop_list)
					PlayerConst = var_2_10009
					var_2_2.catchupItems = var_2_10009.addTranDrop(iter_2_1.catchup_list)
					PlayerConst = var_2_10009
					var_2_2.catchupActItems = var_2_10009.addTranDrop(iter_2_1.catchupact_list)
					underscore = var_2_10009

					var_2_10009.each(var_2_2.catchupItems, function(arg_3_0)
						local var_3_0 = var_0

						var_1.addCatupPrintsNum(var_3_0, arg_3_0.count)

						return
					end)

					local var_2_3 = var_2_0

					var_2_10009 = var_2_0.getActivityByType
					ActivityConst = var_11

					if var_2_10009(var_2_3, var_11.ACTIVITY_TYPE_BLUEPRINT_CATCHUP) and not var_2_10009:isEnd() then
						underscore = var_2_3

						var_2_3.each(var_2_2.catchupActItems, function(arg_4_0)
							var_2_10009.data1 = var_2_10009.data1 + arg_4_0.count

							return
						end)
					end

					table = var_2_3

					local var_2_4 = var_2_3.insert
					local var_2_5 = var_2_1

					PlayerConst = var_2_10012

					var_2_4(var_2_5, var_2_10012.MergeTechnologyAward(var_2_2))

					local var_2_6 = var_0

					var_10.removeFirstQueueTechnology(var_2_6)
				end

				local var_2_7 = arg_1_0

				var_2_10003 = var_2_10003.sendNotification
				GAME = var_5

				var_2_10003(var_2_7, var_5.FINISH_QUEUE_TECHNOLOGY_DONE, {
					dropInfos = var_2_1
				})
			else
				pg = var_2_0

				local var_2_8 = var_2_0.TipsMgr.GetInstance()
				local var_2_9 = var_1.ShowTips

				i18n = var_2_10003

				var_2_9(var_2_8, var_2_10003("blueprint_stop_erro") .. arg_2_0.result)
			end

			return
		end)

		return
	end
end

return var_0_1
