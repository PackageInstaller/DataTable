local var_0_0 = class("FinishTechnologyCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(TechnologyProxy)
	local var_1_2 = getProxy(TechnologyProxy):getTechnologyById(var_1_0.id)

	if not var_1_2 then
		return
	end

	if not var_1_2:isCompleted() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(27, {
		tech_id = var_1_0.id,
		refresh_id = var_1_0.pool_id
	}, 28, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2:reset()
			var_1_1:updateTechnology(var_1_2)

			local var_2_0 = {
				items = PlayerConst.addTranDrop(arg_2_0.common_list),
				commons = PlayerConst.addTranDrop(arg_2_0.drop_list),
				catchupItems = PlayerConst.addTranDrop(arg_2_0.catchup_list),
				catchupActItems = PlayerConst.addTranDrop(arg_2_0.catchupact_list)
			}

			underscore.each(var_2_0.catchupItems, function(arg_3_0)
				var_1_1:addCatupPrintsNum(arg_3_0.count)

				return
			end)

			local var_2_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BLUEPRINT_CATCHUP)

			if var_2_1 and not var_2_1:isEnd() then
				underscore.each(var_2_0.catchupActItems, function(arg_4_0)
					var_2_1.data1 = var_2_1.data1 + arg_4_0.count

					return
				end)
			end

			var_1_1:updateTechnologys(arg_2_0.refresh_list)
			arg_1_0:sendNotification(GAME.FINISH_TECHNOLOGY_DONE, {
				items = PlayerConst.MergeTechnologyAward(var_2_0)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("technology_finish_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
