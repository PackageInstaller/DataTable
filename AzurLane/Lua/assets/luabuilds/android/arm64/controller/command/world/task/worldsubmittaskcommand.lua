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

	if not var_1_3:IsAutoSubmit() and var_1_5 then
		table.insert(var_1_4, function(arg_3_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_ITEM_BOX,
				content = i18n("sub_item_warning"),
				items = {
					{
						type = DROP_TYPE_WORLD_ITEM,
						id = var_1_3.config.complete_parameter[1],
						count = var_1_3:getMaxProgress()
					}
				},
				onYes = arg_3_0
			})

			return
		end)
	end

	seriesAsync(var_1_4, function()
		pg.ConnectionMgr.GetInstance():Send(33207, {
			taskId = var_0
		}, 33208, function(arg_5_0)
			if arg_5_0.result == 0 then
				for iter_5_0, iter_5_1 in pairs((var_1_0:GetFleets())) do
					local var_5_0 = (function(arg_6_0, arg_6_1, arg_6_2)
						local var_6_0 = getProxy(BayProxy)

						for iter_6_0, iter_6_1 in ipairs((arg_6_0:GetShipVOs())) do
							table.insert({}, iter_6_1)

							local var_6_1 = var_6_0:getShipById(iter_6_1.id)

							var_6_1:setIntimacy(var_6_1:getIntimacy() + arg_6_2)
							var_6_1:addExp(arg_6_1)
							var_6_0:updateShip(var_6_1)
							table.insert({}, (WorldConst.FetchShipVO(iter_6_1.id)))
						end

						return {
							oldships = {},
							newships = {}
						}
					end)(iter_5_1, arg_5_0.exp, arg_5_0.intimacy)

					if arg_5_0.exp > 0 then
						table.insert({}, var_5_0)
					end
				end

				var_1_3:commited()
				var_1_2:updateTask(var_1_3)
				var_1_2:riseTaskFinishCount()
				var_1_0:UpdateProgress(var_1_3.config.complete_stage)

				if var_1_5 then
					var_1_1:RemoveItem(var_1_3.config.complete_parameter[1], var_1_3:getMaxProgress())
				end

				arg_1_0:sendNotification(GAME.WORLD_SUMBMIT_TASK_DONE, {
					task = var_1_3,
					drops = PlayerConst.addTranDrop(arg_5_0.drops),
					expfleets = {}
				})
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("task_submitTask", arg_5_0.result))
			end

			return
		end)

		return
	end)

	return
end

return var_0_0
