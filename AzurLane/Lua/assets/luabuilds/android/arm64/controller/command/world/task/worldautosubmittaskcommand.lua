local var_0_0 = class("WorldSubmitTaskCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = nowWorld()
	local var_1_1 = var_1_0:GetInventoryProxy()
	local var_1_2 = var_1_0:GetTaskProxy()
	local var_1_3 = var_1_0:GetTaskProxy():getTaskById(arg_1_1:getBody().taskId)

	if not var_1_3 then
		return
	end

	local var_1_4 = {}

	table.insert({}, function(arg_2_0)
		local var_2_0, var_2_1 = var_1_3:canSubmit()

		if var_2_0 then
			arg_2_0()
		else
			pg.TipsMgr.GetInstance():ShowTips(var_2_1)
		end

		return
	end)

	local var_1_5 = var_1_3.config.complete_condition == WorldConst.TaskTypeSubmitItem and var_1_3.config.item_retrieve == 1

	assert(var_1_3:IsAutoSubmit(), "auto submit error")
	seriesAsync(var_1_4, function()
		pg.ConnectionMgr.GetInstance():Send(33207, {
			taskId = var_0
		}, 33208, function(arg_4_0)
			if arg_4_0.result == 0 then
				for iter_4_0, iter_4_1 in pairs((var_1_0:GetFleets())) do
					local var_4_0 = (function(arg_5_0, arg_5_1, arg_5_2)
						local var_5_0 = getProxy(BayProxy)

						for iter_5_0, iter_5_1 in ipairs((arg_5_0:GetShipVOs())) do
							table.insert({}, iter_5_1)

							local var_5_1 = var_5_0:getShipById(iter_5_1.id)

							var_5_1:setIntimacy(var_5_1:getIntimacy() + arg_5_2)
							var_5_1:addExp(arg_5_1)
							var_5_0:updateShip(var_5_1)
							table.insert({}, (WorldConst.FetchShipVO(iter_5_1.id)))
						end

						return {
							oldships = {},
							newships = {}
						}
					end)(iter_4_1, arg_4_0.exp, arg_4_0.intimacy)

					if arg_4_0.exp > 0 then
						table.insert({}, var_4_0)
					end
				end

				var_1_3:commited()
				var_1_2:updateTask(var_1_3)
				var_1_2:riseTaskFinishCount()
				var_1_0:UpdateProgress(var_1_3.config.complete_stage)

				if var_1_5 then
					var_1_1:RemoveItem(var_1_3.config.complete_parameter[1], var_1_3:getMaxProgress())
				end

				arg_1_0:sendNotification(GAME.WORLD_AUTO_SUMBMIT_TASK_DONE, {
					task = var_1_3,
					drops = PlayerConst.addTranDrop(arg_4_0.drops),
					expfleets = {}
				})
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("task_submitTask", arg_4_0.result))
			end

			return
		end)

		return
	end)

	return
end

return var_0_0
