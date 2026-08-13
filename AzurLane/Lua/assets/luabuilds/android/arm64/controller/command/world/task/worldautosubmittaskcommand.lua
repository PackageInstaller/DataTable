class = var_0_10000

local var_0_0 = "WorldSubmitTaskCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).taskId

	nowWorld = var_1_0

	local var_1_2 = var_1_0()
	local var_1_3 = var_4.GetInventoryProxy(var_1_2)
	local var_1_4 = var_4:GetTaskProxy()

	if not var_6.getTaskById(var_1_4, var_1_1) then
		return
	end

	local var_1_5 = {}

	table = var_1_4

	var_1_4.insert(var_1_5, function(arg_2_0)
		local var_2_0 = var_0
		local var_2_1, var_2_2 = var_1.canSubmit(var_2_0)

		if var_2_1 then
			arg_2_0()
		else
			pg = var_2_0

			local var_2_3 = var_2_0.TipsMgr.GetInstance()

			var_3.ShowTips(var_2_3, var_2_2)
		end

		return
	end)

	local var_1_6 = var_7.config.complete_condition

	WorldConst = var_10

	local var_1_7 = var_1_6 == var_10.TaskTypeSubmitItem and var_7.config.item_retrieve == 1

	assert = var_10

	var_10(var_7:IsAutoSubmit(), "auto submit error")

	seriesAsync = var_10

	var_10(var_1_5, function()
		pg = var_2_10000

		local var_3_0 = var_2_10000.ConnectionMgr.GetInstance()

		var_0.Send(var_3_0, 33207, {
			taskId = var_1_1
		}, 33208, function(arg_4_0)
			local var_4_0

			if arg_4_0.result == 0 then
				function var_4_0(arg_5_0, arg_5_1, arg_5_2)
					getProxy = var_4_10003
					BayProxy = var_4_10005

					local var_5_0 = var_4_10003(var_4_10005)
					local var_5_1 = {}
					local var_5_2 = {}
					local var_5_3 = arg_5_0:GetShipVOs()

					ipairs = var_4_10007

					for iter_5_0, iter_5_1 in var_4_10007(var_5_3) do
						table = var_4_10012

						var_4_10012.insert(var_5_1, iter_5_1)

						local var_5_4 = var_5_0
						local var_5_5 = var_5_0.getShipById(var_5_4, iter_5_1.id)

						var_4_10012.setIntimacy(var_5_5, var_4_10012:getIntimacy() + arg_5_2)
						var_4_10012:addExp(arg_5_1)
						var_5_0:updateShip(var_4_10012)

						WorldConst = var_13

						local var_5_6 = var_13.FetchShipVO(iter_5_1.id)

						table = var_5_4

						var_5_4.insert(var_5_2, var_5_6)
					end

					return {
						oldships = var_5_1,
						newships = var_5_2
					}
				end

				local var_4_1 = {}
				local var_4_2 = arg_4_0.exp

				var_3_10004 = arg_4_0.intimacy

				local var_4_3 = var_0
				local var_4_4 = var_5.GetFleets(var_4_3)

				pairs = var_3_10006

				for iter_4_0, iter_4_1 in var_3_10006(var_4_4) do
					local var_4_5 = var_4_0(iter_4_1, var_4_2, var_3_10004)

					if 0 < var_4_2 then
						table = var_12

						var_12.insert(var_4_1, var_4_5)
					end
				end

				PlayerConst = var_6

				local var_4_6 = var_6.addTranDrop(arg_4_0.drops)
				local var_4_7 = var_0

				var_7.commited(var_4_7)

				local var_4_8 = var_0

				var_7.updateTask(var_4_8, var_0)

				local var_4_9 = var_0

				var_7.riseTaskFinishCount(var_4_9)

				local var_4_10 = var_0

				var_7.UpdateProgress(var_4_10, var_0.config.complete_stage)

				local var_4_13

				if var_1_7 then
					local var_4_11 = var_1_3
					local var_4_12 = var_7.RemoveItem

					var_4_13 = var_0.config.complete_parameter[1]

					local var_4_14 = var_0

					var_4_12(var_4_11, var_4_13, var_11.getMaxProgress(var_4_14))
				end

				local var_4_15 = arg_1_0
				local var_4_16 = var_7.sendNotification

				GAME = var_4_13

				var_4_16(var_4_15, var_4_13.WORLD_AUTO_SUMBMIT_TASK_DONE, {
					task = var_0,
					drops = var_4_6,
					expfleets = var_4_1
				})
			else
				pg = var_4_0

				local var_4_17 = var_4_0.TipsMgr.GetInstance()
				local var_4_18 = var_1.ShowTips

				errorTip = var_3_10004

				var_4_18(var_4_17, var_3_10004("task_submitTask", arg_4_0.result))
			end

			return
		end)

		return
	end)

	return
end

return var_0_1
