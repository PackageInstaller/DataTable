class = var_0_10000

local var_0_0 = "SubmitActiveTaskCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)
local var_0_2 = {
	59599
}

function var_0_1.GetSubmitActivityTaskDone(arg_1_0)
	GAME = var_1_10001

	return var_1_10001.SUBMIT_ACTIVITY_TASK_DONE
end

function var_0_1.GetSubMitActivityAwardDown(arg_2_0)
	GAME = var_1_10001

	return var_1_10001.SUBMIT_TASK_AWARD_DOWN
end

function var_0_1.execute(arg_3_0, arg_3_1)
	local var_3_0

	if not arg_3_1:getBody() then
		var_3_0 = {}
	end

	local var_3_1 = var_3_0.callback

	pg = var_1_10004

	local var_3_2 = var_1_10004.activity_template[var_3_0.act_id].type
	local var_3_3 = {}

	table = var_1_10006

	local var_3_4 = var_1_10006.contains

	TotalTaskProxy = var_1_10007

	if var_3_4(var_1_10007.avatar_task_type, var_3_2) then
		-- block empty
	else
		table = var_6

		local var_3_5 = var_6.contains

		TotalTaskProxy = var_7

		if var_3_5(var_7.activity_task_type, var_3_2) then
			ipairs = var_6

			for iter_3_0, iter_3_1 in var_6(var_3_0.task_ids) do
				getProxy = var_1_10011
				ActivityTaskProxy = var_1_10012
				var_1_10012 = var_1_10011(var_1_10012)

				if var_1_10011.getTaskVo(var_1_10012, var_3_0.act_id, iter_3_1) then
					table = var_1_10012

					var_1_10012.insert(var_3_3, var_1_10011)
				end
			end
		else
			table = var_6

			local var_3_6 = var_6.contains

			TotalTaskProxy = var_7

			if var_3_6(var_7.normal_task_type, var_3_2) then
				ipairs = var_6

				for iter_3_2, iter_3_3 in var_6(var_3_0.task_ids) do
					getProxy = var_1_10011
					TaskProxy = var_1_10012
					var_1_10012 = var_1_10011(var_1_10012)
					var_1_10011 = var_1_10011.getTaskById(var_1_10012, iter_3_3)
					getProxy = var_1_10012
					TaskProxy = var_13

					local var_3_7 = var_1_10012(var_13)

					if var_1_10012.isSubmitting(var_3_7, iter_3_3) then
						-- block empty
					else
						getProxy = var_1_10012
						TaskProxy = var_3_7

						local var_3_8 = var_1_10012(var_3_7)

						var_1_10012.addSubmittingTask(var_3_8, iter_3_3)

						table = var_1_10012

						var_1_10012.insert(var_3_3, var_1_10011)
					end
				end
			end
		end
	end

	if not arg_3_0:InTaskScene() then
		local var_3_9, var_3_10 = arg_3_0:filterOverflowTaskVOList(var_3_3)

		if var_3_10 then
			pg = var_8

			local var_3_11 = var_8.MsgboxMgr.GetInstance()
			local var_3_12 = var_8.ShowMsgBox
			local var_3_13 = {}

			i18n = var_1_10011
			var_3_13.content = var_1_10011("player_expResource_mail_fullBag")

			function var_3_13.onYes()
				local var_4_0 = arg_3_0

				var_0.submitActivity(var_4_0, var_3_0, var_3_3, var_3_2, var_3_1)

				return
			end

			function var_3_13.onNo()
				if var_3_1 then
					var_3_1(false)
				end

				return
			end

			var_3_12(var_3_11, var_3_13)

			return
		end
	end

	arg_3_0:submitActivity(var_3_0, var_3_3, var_3_2, var_3_1)

	return
end

function var_0_1.submitActivity(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	pg = var_1_10005

	local var_6_0 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_6_0, 20205, {
		act_id = arg_6_1.act_id,
		task_ids = arg_6_1.task_ids
	}, 20206, function(arg_7_0)
		if arg_7_0.result == 0 then
			local var_7_0 = {}

			table = var_2_10002

			local var_7_1 = var_2_10002.contains

			TotalTaskProxy = var_2_10003

			local var_7_2

			if var_7_1(var_2_10003.avatar_task_type, arg_6_3) then
				pg = var_7_2
				var_7_2 = var_7_2.activity_template[arg_6_1.act_id].config_id
				pg = var_2_10003
				var_2_10003 = var_2_10003.activity_event_avatarframe[var_7_2]
				Clone = var_4

				local var_7_3 = var_4(var_2_10003.award_display)[1]
				local var_7_4 = 0

				ipairs = iter_7_3

				for iter_7_0, iter_7_1 in iter_7_3(arg_6_1.task_ids) do
					local var_7_5 = arg_6_0

					var_7_4 = var_7_4 + var_11.getAwardNum(var_7_5, var_2_10003, iter_7_1)
				end

				getProxy = iter_7_3
				ActivityProxy = var_7

				local var_7_6 = iter_7_3(var_7)

				if iter_7_3.RawGetActivityById(var_7_6, arg_6_1.act_id) then
					iter_7_3.data1 = iter_7_3.data1 + var_7_4
				end

				var_7_3[3] = var_7_4
				Drop = var_7_6

				local var_7_7 = var_7_6.Create(var_7_3)

				table = var_8

				var_8.insert(var_7_0, var_7_7)

				local var_7_8 = arg_6_0
				local var_7_9 = var_8.sendNotification

				GAME = var_10

				var_7_9(var_7_8, var_10.SUBMIT_AVATAR_TASK_DONE, {
					awards = var_7_0
				})
			else
				table = var_7_2

				local var_7_10 = var_7_2.contains

				TotalTaskProxy = var_2_10003

				local var_7_13

				if var_7_10(var_2_10003.activity_task_type, arg_6_3) then
					ipairs = var_7_13

					for iter_7_2, iter_7_3 in var_7_13(arg_6_2) do
						local var_7_11 = arg_6_0

						var_7.updateTaskActivityData(var_7_11, iter_7_3.id, arg_6_1.act_id)

						local var_7_12 = arg_6_0

						var_7.updateTaskBagData(var_7_12, iter_7_3.id, arg_6_1.act_id)

						SubmitTaskCommand = var_7

						var_7.OnSubmitSuccess(iter_7_3)
					end

					if arg_6_1.inIsland then
						IslandDropHelper = var_7_13
						var_7_13 = var_7_13.AddItems({
							drop_list = arg_7_0.award_list
						})

						local var_7_14 = arg_6_0

						var_2_10003 = var_2_10003.sendNotification
						GAME = iter_7_2

						var_2_10003(var_7_14, iter_7_2.SUBMIT_ACTIVITY_TASK_IN_ISLAND_DONE, {
							dropData = var_7_13,
							actId = arg_6_1.act_id
						})
					else
						PlayerConst = var_7_13
						var_7_0 = var_7_13.addTranDrop(arg_7_0.award_list, {})
						var_2_10003 = arg_6_0
						var_7_13 = var_7_13.sendNotification

						local var_7_15 = arg_6_0

						var_7_13(var_2_10003, var_4.GetSubmitActivityTaskDone(var_7_15), {
							awards = var_7_0
						}, arg_6_1.task_ids)
					end
				else
					table = var_7_13

					local var_7_16 = var_7_13.contains

					TotalTaskProxy = var_2_10003

					if var_7_16(var_2_10003.normal_task_type, arg_6_3) then
						PlayerConst = var_2

						for iter_7_4 = #var_2.addTranDrop(arg_7_0.award_list, {}), 1, -1 do
							table = iter_7_3

							if iter_7_3.contains(var_0_2, var_7_0[iter_7_4].id) then
								table = iter_7_3

								iter_7_3.remove(var_7_0, iter_7_4)
							end
						end

						ipairs = var_2

						for iter_7_5, iter_7_6 in var_2(arg_6_2) do
							local var_7_17 = arg_6_0

							var_7.updateTaskBagData(var_7_17, iter_7_6.id, arg_6_1.act_id)

							SubmitTaskCommand = var_7

							var_7.OnSubmitSuccess(iter_7_6)

							getProxy = var_7
							TaskProxy = var_8

							local var_7_18 = var_7(var_8)

							var_7.removeSubmittingTask(var_7_18, iter_7_6.id)
						end

						var_2_10003 = arg_6_0

						local var_7_19 = var_2.sendNotification
						local var_7_20 = arg_6_0

						var_7_19(var_2_10003, var_4.GetSubmitActivityTaskDone(var_7_20), {
							awards = var_7_0
						}, arg_6_1.task_ids)
					end
				end
			end

			var_2_10003 = arg_6_0

			local var_7_21 = var_2.sendNotification
			local var_7_22 = arg_6_0

			var_7_21(var_2_10003, var_4.GetSubMitActivityAwardDown(var_7_22), {
				awards = var_7_0
			}, arg_6_1.task_ids)

			if arg_6_4 then
				arg_6_4(true)
			end
		else
			if arg_6_4 then
				arg_6_4(false)
			end

			pg = var_1

			local var_7_23 = var_1.TipsMgr.GetInstance()
			local var_7_24 = var_1.ShowTips

			errorTip = var_2_10003

			var_7_24(var_7_23, var_2_10003("", arg_7_0.result))
		end

		return
	end)

	return
end

function var_0_1.updateTaskActivityData(arg_8_0, arg_8_1, arg_8_2)
	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_8_0 = var_1_10003(var_1_10004)

	if var_3.getActivityById(var_8_0, arg_8_2) then
		getProxy = var_8_0
		ActivityTaskProxy = var_5

		local var_8_1 = var_8_0(var_5)

		var_4.finishActTask(var_8_1, arg_8_2, arg_8_1)

		local var_8_2 = arg_8_0
		local var_8_3 = arg_8_0.sendNotification

		ActivityProxy = var_6

		var_8_3(var_8_2, var_6.ACTIVITY_UPDATED, var_3)
	end

	return
end

local var_0_3 = {
	{
		6,
		1006
	},
	{
		16,
		1006
	}
}
local var_0_4 = {
	{
		6,
		1007
	},
	{
		16,
		1007
	}
}

function var_0_1.updateTaskBagData(arg_9_0, arg_9_1, arg_9_2)
	pg = var_1_10003

	local var_9_0 = var_1_10003.task_data_template[arg_9_1]

	tonumber = var_1_10004

	local var_9_1 = var_1_10004(var_9_0.target_id)
	local var_9_2 = var_9_0.type
	local var_9_3 = var_9_0.sub_type

	pg = var_1_10007

	if var_1_10007.activity_drop_type[var_9_1] then
		ipairs = var_7

		for iter_9_0, iter_9_1 in var_7(var_0_3) do
			if var_9_2 == iter_9_1[1] and var_9_3 == iter_9_1[2] then
				tonumber = var_12

				local var_9_4 = var_12(var_9_0.target_id_2)

				var_1_10013 = var_9_0.target_num
				pg = var_1_10014
				var_1_10014 = var_1_10014.activity_drop_type[var_9_1].activity_id
				getProxy = var_1_10015
				ActivityProxy = var_1_10016
				var_1_10016 = var_1_10015(var_1_10016)

				if var_1_10015.getActivityById(var_1_10016, var_1_10014) then
					local var_9_5 = var_1_10015

					var_1_10015.subVitemNumber(var_9_5, var_9_4, var_1_10013)

					getProxy = var_1_10016
					ActivityProxy = var_9_5

					local var_9_6 = var_1_10016(var_9_5)

					var_1_10016.updateActivity(var_9_6, var_1_10015)
				end
			end
		end

		ipairs = var_7

		for iter_9_2, iter_9_3 in var_7(var_0_4) do
			if var_9_2 == iter_9_3[1] and var_9_3 == iter_9_3[2] then
				pg = var_12

				local var_9_7 = var_12.activity_drop_type[var_9_1].activity_id

				getProxy = var_1_10013
				ActivityProxy = var_1_10014
				var_1_10014 = var_1_10013(var_1_10014)

				if var_1_10013.getActivityById(var_1_10014, var_9_7) then
					var_1_10014 = var_9_0.target_id_2
					ipairs = var_15

					for iter_9_4, iter_9_5 in var_15(var_1_10014) do
						local var_9_8 = iter_9_5[1]
						local var_9_9 = iter_9_5[2]

						var_1_10013:subVitemNumber(var_9_8, var_9_9)
					end

					getProxy = var_15
					ActivityProxy = var_16

					local var_9_10 = var_15(var_16)

					var_15.updateActivity(var_9_10, var_1_10013)
				end
			end
		end
	end

	return
end

function var_0_1.filterOverflowTaskVOList(arg_10_0, arg_10_1)
	local var_10_0 = {}

	getProxy = var_1_10003
	PlayerProxy = var_1_10004

	local var_10_1 = var_1_10003(var_1_10004)
	local var_10_2 = var_3.getData(var_10_1)

	pg = var_10_1

	local var_10_3 = var_10_1.gameset.urpt_chapter_max.description[1]
	local var_10_4 = var_10_2.gold
	local var_10_5 = var_10_2.oil

	LOCK_UR_SHIP = var_1_10007

	if not var_1_10007 then
		getProxy = var_1_10007
		BagProxy = var_1_10008
		var_1_10008 = var_1_10007(var_1_10008)

		local var_10_6

		if not var_7.GetLimitCntById(var_1_10008, var_10_3) then
			var_10_6 = 0
		end

		pg = var_1_10008

		local var_10_7 = var_1_10008.gameset.max_gold.key_value

		pg = var_1_10009

		local var_10_8 = var_1_10009.gameset.max_oil.key_value

		LOCK_UR_SHIP = var_1_10010

		if not var_1_10010 then
			pg = var_1_10010

			if not var_1_10010.gameset.urpt_chapter_max.description[2] then
				local var_10_9 = 0
			end

			local var_10_10 = false

			pairs = var_1_10012

			for iter_10_0, iter_10_1 in var_1_10012(arg_10_1) do
				local var_10_11 = iter_10_1

				if not iter_10_1.judgeOverflow(var_10_11, var_10_4, var_10_5, var_10_6) then
					table = var_10_11

					var_10_11.insert(var_10_0, iter_10_1)
				end

				if var_17 then
					var_10_10 = true
				end
			end

			return var_10_0, var_10_10
		end
	end
end

function var_0_1.getAwardNum(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = 1

	AvatarFrameTask = var_1_10004

	for iter_11_0 = var_11_0, #var_1_10004.fillter_task_type do
		AvatarFrameTask = var_1_10007

		local var_11_1 = arg_11_1[var_1_10007.fillter_task_type[iter_11_0]]

		ipairs = var_1_10009

		for iter_11_1, iter_11_2 in var_1_10009(var_11_1) do
			if arg_11_2 == iter_11_2[1] then
				AvatarFrameTask = var_14

				if var_1_10007 == var_14.type_task_level then
					return iter_11_2[6]
				else
					AvatarFrameTask = var_14

					if var_1_10007 == var_14.type_task_ship then
						return iter_11_2[4]
					end
				end
			end
		end
	end

	print = var_11_0

	var_11_0("找不到taskId:" .. arg_11_2)

	return 0
end

function var_0_1.InTaskScene(arg_12_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10002

	local var_12_0 = var_1_10001(var_1_10002)
	local var_12_1 = var_1.getCurrentContext(var_12_0).mediator

	TaskMediator = var_1_10003

	return var_12_1 == var_1_10003
end

return var_0_1
