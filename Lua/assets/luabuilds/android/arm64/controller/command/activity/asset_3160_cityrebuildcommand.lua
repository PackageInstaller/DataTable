local CityRebuildCommand = class("CityRebuildCommand", pm.SimpleCommand)

function CityRebuildCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(CityRebuildProxy)

	if var_1_0.operation == CityRebuildProxy.GET_DATA then
		pg.ConnectionMgr.GetInstance():Send(26060, {
			act_id = var_1_0.activityId
		}, 26061, function(arg_2_0)
			if arg_2_0.result == 0 then
				var_1_1:SetData(var_1_0.activityId, arg_2_0.info)
				self:sendNotification(GAME.CITY_REBUILD_DONE, {
					operation = var_1_0.operation
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
			end

			return
		end)
	elseif var_1_0.operation == CityRebuildProxy.REBUILD_OR_START_RECRUIT then
		pg.ConnectionMgr.GetInstance():Send(26064, {
			act_id = var_1_0.activityId,
			building_id = var_1_0.buildingId
		}, 26065, function(arg_3_0)
			if arg_3_0.result == 0 then
				var_1_1:RebuildOrStartRecruit(var_1_0.activityId, var_1_0.buildingId)
				var_1_1:Adjust(var_1_0.activityId, arg_3_0.adjust)
				var_1_1:ComsumePt(var_1_0.activityId, var_1_0.ptCost[3])
				getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CITY_REBUILD):subVitemNumber(var_1_0.cost[2], var_1_0.cost[3])
				self:sendNotification(GAME.CITY_REBUILD_DONE, {
					operation = var_1_0.operation
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
			end

			return
		end)
	elseif var_1_0.operation == CityRebuildProxy.END_RECRUIT then
		pg.ConnectionMgr.GetInstance():Send(26062, {
			act_id = var_1_0.activityId,
			roles = var_1_0.roles
		}, 26063, function(arg_4_0)
			if arg_4_0.result == 0 then
				var_1_1:RecruitDone(var_1_0.activityId, var_1_0.roles)
				var_1_1:Adjust(var_1_0.activityId, arg_4_0.adjust)
				self:sendNotification(GAME.CITY_REBUILD_DONE, {
					operation = var_1_0.operation
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_4_0.result] .. arg_4_0.result)
			end

			return
		end)
	elseif var_1_0.operation == CityRebuildProxy.UPGRADE_BUFF then
		pg.ConnectionMgr.GetInstance():Send(26066, {
			act_id = var_1_0.activityId,
			group = var_1_0.group,
			count = var_1_0.count
		}, 26067, function(arg_5_0)
			if arg_5_0.result == 0 then
				var_1_1:UpgradeBuff(var_1_0.activityId, var_1_0.group, var_1_0.count)
				var_1_1:Adjust(var_1_0.activityId, arg_5_0.adjust)
				var_1_1:ComsumePt(var_1_0.activityId, var_1_0.ptCost)
				self:sendNotification(GAME.CITY_REBUILD_DONE, {
					operation = var_1_0.operation
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_5_0.result] .. arg_5_0.result)
			end

			return
		end)
	elseif var_1_0.operation == CityRebuildProxy.RESULT then
		pg.ConnectionMgr.GetInstance():Send(26068, {
			act_id = var_1_0.activityId
		}, 26069, function(arg_6_0)
			if arg_6_0.result == 0 then
				var_1_1:Result(var_1_0.activityId, arg_6_0.summary)
				self:sendNotification(GAME.CITY_REBUILD_DONE, {
					operation = var_1_0.operation,
					awards = PlayerConst.addTranDrop(arg_6_0.summary.award_list),
					pt = arg_6_0.summary.summary_pt
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_6_0.result] .. arg_6_0.result)
			end

			return
		end)
	elseif var_1_0.operation == CityRebuildProxy.CHOOSE_LEVEL then
		pg.ConnectionMgr.GetInstance():Send(26070, {
			act_id = var_1_0.activityId,
			level = var_1_0.level
		}, 26071, function(arg_7_0)
			if arg_7_0.result == 0 then
				var_1_1:UpdateChooseLevel(var_1_0.activityId, var_1_0.level)
				var_1_1:Adjust(var_1_0.activityId, arg_7_0.adjust)
				self:sendNotification(GAME.CITY_REBUILD_DONE, {
					operation = var_1_0.operation
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_7_0.result] .. arg_7_0.result)
			end

			return
		end)
	elseif var_1_0.operation == CityRebuildProxy.INIT_TIME then
		pg.ConnectionMgr.GetInstance():Send(26072, {
			act_id = var_1_0.activityId
		}, 26073, function(arg_8_0)
			if arg_8_0.result == 0 then
				var_1_1:Adjust(var_1_0.activityId, arg_8_0.adjust)
				self:sendNotification(GAME.CITY_REBUILD_DONE, {
					operation = var_1_0.operation
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_8_0.result] .. arg_8_0.result)
			end

			return
		end)
	end

	return
end

return CityRebuildCommand
