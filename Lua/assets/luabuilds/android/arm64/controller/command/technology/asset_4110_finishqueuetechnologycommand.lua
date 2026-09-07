local FinishQueueTechnologyCommand = class("FinishQueueTechnologyCommand", pm.SimpleCommand)

function FinishQueueTechnologyCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(TechnologyProxy)

	if #var_1_1.queue == 0 or not var_1_1.queue[1]:isCompleted() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(63015, {
		id = 0
	}, 63016, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(ActivityProxy)
			local var_2_1 = {}

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.drops) do
				local var_2_2 = {
					items = PlayerConst.addTranDrop(iter_2_1.common_list),
					commons = PlayerConst.addTranDrop(iter_2_1.drop_list),
					catchupItems = PlayerConst.addTranDrop(iter_2_1.catchup_list),
					catchupActItems = PlayerConst.addTranDrop(iter_2_1.catchupact_list)
				}

				underscore.each(var_2_2.catchupItems, function(arg_3_0)
					var_1_1:addCatupPrintsNum(arg_3_0.count)

					return
				end)

				local var_2_3 = var_2_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_BLUEPRINT_CATCHUP)

				if var_2_3 and not var_2_3:isEnd() then
					underscore.each(var_2_2.catchupActItems, function(arg_4_0)
						var_2_3.data1 = var_2_3.data1 + arg_4_0.count

						return
					end)
				end

				table.insert(var_2_1, PlayerConst.MergeTechnologyAward(var_2_2))
				var_1_1:removeFirstQueueTechnology()
			end

			self:sendNotification(GAME.FINISH_QUEUE_TECHNOLOGY_DONE, {
				dropInfos = var_2_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("blueprint_stop_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

return FinishQueueTechnologyCommand
