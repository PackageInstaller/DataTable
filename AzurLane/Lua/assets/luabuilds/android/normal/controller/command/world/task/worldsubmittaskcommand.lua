class = var_0_10000

local var_0_0 = "WorldSubmitTaskCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().taskId

	nowWorld = var_1_10004

	local var_1_1 = var_1_10004()
	local var_1_2 = var_4.GetInventoryProxy(var_1_1)
	local var_1_3 = var_4:GetTaskProxy()

	if not var_6.getTaskById(var_1_3, var_1_0) then
		return
	end

	local var_1_4 = {}

	table = var_9

	var_9.insert(var_1_4, function(arg_2_0)
		local var_2_0 = var_0
		local var_2_1, var_2_2 = var_1.canSubmit(var_2_0)

		if var_2_1 then
			arg_2_0()
		else
			pg = var_2_10003

			local var_2_3 = var_2_10003.TipsMgr.GetInstance()

			var_3.ShowTips(var_2_3, var_2_2)
		end

		return
	end)

	local var_1_5 = var_7.config.complete_condition

	WorldConst = var_10

	local var_1_6 = var_1_5 == var_10.TaskTypeSubmitItem and var_7.config.item_retrieve == 1

	if not var_7:IsAutoSubmit() and var_1_6 then
		table = var_10

		var_10.insert(var_1_4, function(arg_3_0)
			pg = var_2_10001

			local var_3_0 = var_2_10001.MsgboxMgr.GetInstance()
			local var_3_1 = var_1.ShowMsgBox
			local var_3_2 = {}

			MSGBOX_TYPE_ITEM_BOX = var_2_10004
			var_3_2.type = var_2_10004
			i18n = var_2_10004
			var_3_2.content = var_2_10004("sub_item_warning")

			local var_3_3 = {}
			local var_3_4 = {}

			DROP_TYPE_WORLD_ITEM = var_2_10006
			var_3_4.type = var_2_10006
			var_3_4.id = var_0.config.complete_parameter[1]

			local var_3_5 = var_0

			var_3_4.count = var_6.getMaxProgress(var_3_5)
			var_3_3[1] = var_3_4
			var_3_2.items = var_3_3
			var_3_2.onYes = arg_3_0

			var_3_1(var_3_0, var_3_2)

			return
		end)
	end

	seriesAsync = var_10

	var_10(var_1_4, function()
		pg = var_2_10000

		local var_4_0 = var_2_10000.ConnectionMgr.GetInstance()

		var_0.Send(var_4_0, 33207, {
			taskId = var_1_0
		}, 33208, function(arg_5_0)
			local var_5_0

			if arg_5_0.result == 0 then
				function var_5_0(arg_6_0, arg_6_1, arg_6_2)
					getProxy = var_4_10003
					BayProxy = var_4_10004

					local var_6_0 = var_4_10003(var_4_10004)
					local var_6_1 = {}
					local var_6_2 = {}
					local var_6_3 = arg_6_0
					local var_6_4 = arg_6_0.GetShipVOs(var_6_3)

					ipairs = var_6_3

					for iter_6_0, iter_6_1 in var_6_3(var_6_4) do
						table = var_4_10012

						var_4_10012.insert(var_6_1, iter_6_1)

						local var_6_5 = var_6_0:getShipById(iter_6_1.id)

						var_4_10012.setIntimacy(var_6_5, var_4_10012:getIntimacy() + arg_6_2)
						var_4_10012:addExp(arg_6_1)
						var_6_0:updateShip(var_4_10012)

						WorldConst = var_13

						local var_6_6 = var_13.FetchShipVO(iter_6_1.id)

						table = var_14

						var_14.insert(var_6_2, var_6_6)
					end

					return {
						oldships = var_6_1,
						newships = var_6_2
					}
				end

				local var_5_1 = {}

				var_3_10003 = arg_5_0.exp

				local var_5_2 = arg_5_0.intimacy
				local var_5_3 = var_0
				local var_5_4 = var_5.GetFleets(var_5_3)

				pairs = var_5_3

				for iter_5_0, iter_5_1 in var_5_3(var_5_4) do
					local var_5_5 = var_5_0(iter_5_1, var_3_10003, var_5_2)

					if 0 < var_3_10003 then
						table = var_12

						var_12.insert(var_5_1, var_5_5)
					end
				end

				PlayerConst = var_6

				local var_5_6 = var_6.addTranDrop(arg_5_0.drops)
				local var_5_7 = var_0

				var_7.commited(var_5_7)

				local var_5_8 = var_0

				var_7.updateTask(var_5_8, var_0)

				local var_5_9 = var_0

				var_7.riseTaskFinishCount(var_5_9)

				local var_5_10 = var_0

				var_7.UpdateProgress(var_5_10, var_0.config.complete_stage)

				local var_5_13

				if var_1_6 then
					local var_5_11 = var_1_2
					local var_5_12 = var_7.RemoveItem

					var_5_13 = var_0.config.complete_parameter[1]

					local var_5_14 = var_0

					var_5_12(var_5_11, var_5_13, var_10.getMaxProgress(var_5_14))
				end

				local var_5_15 = arg_1_0
				local var_5_16 = var_7.sendNotification

				GAME = var_5_13

				var_5_16(var_5_15, var_5_13.WORLD_SUMBMIT_TASK_DONE, {
					task = var_0,
					drops = var_5_6,
					expfleets = var_5_1
				})
			else
				pg = var_5_0

				local var_5_17 = var_5_0.TipsMgr.GetInstance()
				local var_5_18 = var_1.ShowTips

				errorTip = var_3_10003

				var_5_18(var_5_17, var_3_10003("task_submitTask", arg_5_0.result))
			end

			return
		end)

		return
	end)

	return
end

return var_0_1
