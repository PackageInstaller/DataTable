class = var_0_10000

local var_0_0 = "SubmitTaskOneStepCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1 = var_2.dontSendMsg
	local var_1_2 = var_2.resultList
	local var_1_3 = {}
	local var_1_4 = {}

	getProxy = var_1_10008
	TaskProxy = var_1_10009

	local var_1_5 = var_1_10008(var_1_10009)

	ipairs = var_1_10009

	for iter_1_0, iter_1_1 in var_1_10009(var_1_2) do
		local var_1_6 = iter_1_1.id
		local var_1_7 = {}

		if iter_1_1.choiceItemList then
			ipairs = var_16

			for iter_1_2, iter_1_3 in var_16(iter_1_1.choiceItemList) do
				table = var_1_10021

				var_1_10021.insert(var_1_7, iter_1_3)
			end
		end

		local var_1_8 = var_1_5

		if not var_1_5.getTaskById(var_1_8, var_1_6) then
			pg = var_1_8

			local var_1_9 = var_1_8.TipsMgr.GetInstance()
			local var_1_10 = var_17.ShowTips

			i18n = iter_1_2

			var_1_10(var_1_9, iter_1_2("task_is_not_existence", var_1_6))

			return
		end

		local var_1_12

		if not var_16:isFinish() then
			pg = var_1_12

			local var_1_11 = var_1_12.TipsMgr.GetInstance()

			var_1_12 = var_1_12.ShowTips
			i18n = iter_1_2

			var_1_12(var_1_11, iter_1_2("task_submitTask_error_notFinish"))

			return
		end

		table = var_1_12

		var_1_12.insert(var_1_3, var_1_6)
	end

	pg = var_9

	local var_1_13 = var_9.ConnectionMgr.GetInstance()

	var_9.Send(var_1_13, 20011, {
		id_list = var_1_3
	}, 20012, function(arg_2_0)
		local var_2_0 = arg_2_0.id_list

		ipairs = var_2_10002

		for iter_2_0, iter_2_1 in var_2_10002(var_2_0) do
			local var_2_1 = var_1_5
			local var_2_2 = var_7.getTaskById(var_2_1, iter_2_1)
			local var_2_3 = var_7.getConfig(var_2_2, "sub_type")

			TASK_SUB_TYPE_GIVE_ITEM = var_2_2

			if var_2_3 == var_2_2 then
				tonumber = var_2_3
				var_2_3 = var_2_3(var_7:getConfig("target_id"))

				local var_2_4 = var_7
				local var_2_5 = var_7.getConfig(var_2_4, "target_num")

				getProxy = var_2_4
				BagProxy = var_2_10011

				local var_2_6 = var_2_4(var_2_10011)

				var_2_10011 = var_10.removeItemById
				tonumber = var_2_10013
				var_2_10013 = var_2_10013(var_2_3)
				tonumber = var_14

				var_2_10011(var_2_6, var_2_10013, var_14(var_2_5))
			else
				local var_2_7 = var_7

				var_2_3 = var_7.getConfig(var_2_7, "sub_type")
				TASK_SUB_TYPE_GIVE_VIRTUAL_ITEM = var_2_7

				if var_2_3 == var_2_7 then
					tonumber = var_2_3
					var_2_3 = var_2_3(var_7:getConfig("target_id"))

					local var_2_8 = var_7
					local var_2_9 = var_7.getConfig(var_2_8, "target_num")

					getProxy = var_2_8
					ActivityProxy = var_2_10011

					local var_2_10 = var_2_8(var_2_10011)

					var_10.removeVitemById(var_2_10, var_2_3, var_2_9)
				else
					local var_2_11 = var_7

					var_2_3 = var_7.getConfig(var_2_11, "sub_type")
					TASK_SUB_TYPE_PLAYER_RES = var_2_11

					if var_2_3 == var_2_11 then
						tonumber = var_2_3
						var_2_3 = var_2_3(var_7:getConfig("target_id"))

						local var_2_12 = var_7
						local var_2_13 = var_7.getConfig(var_2_12, "target_num")

						getProxy = var_2_12
						PlayerProxy = var_2_10011

						local var_2_14 = var_2_12(var_2_10011)

						var_2_10013 = var_10.getData(var_2_14)

						local var_2_15 = var_2_10011.consume
						local var_2_16 = {}

						id2res = var_2_10015
						var_2_16[var_2_10015(var_2_3)] = var_2_13

						var_2_15(var_2_10013, var_2_16)

						var_2_10013 = var_10

						var_10.updatePlayer(var_2_10013, var_2_10011)
					end
				end
			end

			SubmitTaskCommand = var_2_3

			var_2_3.AddGuildLivness(var_7)

			SubmitTaskCommand = var_8

			var_8.CheckTaskType(var_7)

			getProxy = var_8
			ActivityProxy = var_9

			local var_2_17 = var_8(var_9)
			local var_2_18 = var_8.getActivityByType

			ActivityConst = var_2_10011

			if var_2_18(var_2_17, var_2_10011.ACTIVITY_TYPE_TASK_LIST_MONITOR) then
				var_2_10011 = var_9

				if not var_9.isEnd(var_2_10011) then
					var_2_10011 = var_9

					local var_2_19

					if not var_9.getConfig(var_2_10011, "config_data")[1] then
						var_2_19 = {}
					end

					table = var_2_10011

					if var_2_10011.contains(var_2_19, var_7.id) then
						var_8:monitorTaskList(var_9)
					end
				end
			end
		end

		PlayerConst = var_2
		var_1_4 = var_2.addTranDrop(arg_2_0.award_list)

		if not var_1_1 then
			local var_2_20 = arg_1_0
			local var_2_21 = var_2.sendNotification

			GAME = var_4

			local var_2_22 = var_4.SUBMIT_TASK_DONE
			local var_2_23 = var_1_4

			_ = iter_2_1

			var_2_21(var_2_20, var_2_22, var_2_23, iter_2_1.map(var_1_2, function(arg_3_0)
				return arg_3_0.id
			end))
		end

		if var_1_0 then
			var_1_0(var_1_4)
		end

		return
	end)

	return
end

return var_0_1
