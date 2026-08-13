class = var_0_10000

local var_0_0 = "BRSStagePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "panel")
	setText = var_1

	local var_1_1 = arg_1_0.bg
	local var_1_2 = var_3.Find(var_1_1, "hint")

	i18n = var_4

	var_1(var_1_2, var_4("brs_expedition_tip"))

	arg_1_0.chainTFList = {}
	arg_1_0.stageTFList = {}

	local var_1_3 = arg_1_0.bg
	local var_1_4 = var_1.Find(var_1_3, "stages")
	local var_1_5 = arg_1_0.bg
	local var_1_6 = var_2.Find(var_1_5, "progress_chain")

	for iter_1_0 = 1, 3 do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.stageTFList, var_1_4:Find("stage_" .. iter_1_0))

		table = var_1_10007

		var_1_10007.insert(arg_1_0.chainTFList, var_1_6:Find("chain_mark_" .. iter_1_0))
	end

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	return
end

function var_0_1.flushTaskData(arg_3_0)
	arg_3_0._taskList = {}

	local var_3_0 = arg_3_0.activity
	local var_3_1 = var_1.getConfig(var_3_0, "config_client").task

	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(var_3_1) do
		getProxy = var_1_10007
		TaskProxy = var_1_10009
		var_1_10009 = var_1_10007(var_1_10009)

		if not var_1_10007.getTaskById(var_1_10009, iter_3_1) then
			getProxy = var_1_10008
			TaskProxy = var_10

			local var_3_2 = var_1_10008(var_10)

			var_1_10007 = var_1_10008.getFinishTaskById(var_3_2, iter_3_1)
		end

		table = var_1_10008

		var_1_10008.insert(arg_3_0._taskList, var_1_10007)
	end

	return
end

function var_0_1.OnFirstFlush(arg_4_0)
	local var_4_0 = arg_4_0.activity
	local var_4_1 = var_1.getConfig(var_4_0, "config_data")
	local var_4_2 = {}

	ipairs = var_4_0

	for iter_4_0, iter_4_1 in var_4_0(arg_4_0.activity.data2_list) do
		table = var_1_10008
		var_1_10008 = var_1_10008.insert
		var_1_10010 = var_4_2

		local var_4_3 = arg_4_0.activity

		var_1_10008(var_1_10010, var_11.GetEnemyDataByStageId(var_4_3, iter_4_1).id)
	end

	arg_4_0:flushTaskData()

	local var_4_4 = 1

	ipairs = var_4

	for iter_4_2, iter_4_3 in var_4(arg_4_0.stageTFList) do
		local var_4_5 = arg_4_0.activity
		local var_4_6 = var_9.GetEnemyDataById(var_4_5, var_4_1[iter_4_2])

		setText = var_1_10010

		var_1_10010(iter_4_3:Find("name/text"), var_4_6:getConfig("name"))

		setText = var_1_10010

		var_1_10010(iter_4_3:Find("level"), var_4_6:getConfig("level"))

		var_1_10010 = iter_4_3:Find("award")

		local var_4_7 = arg_4_0._taskList[iter_4_2]
		local var_4_8 = var_11.getConfig(var_4_7, "award_display")[1]
		local var_4_9 = {
			type = var_4_8[1],
			id = var_4_8[2],
			count = var_4_8[3]
		}

		updateDrop = var_14
		findTF = var_16

		var_14(var_16(var_1_10010, "mask"), var_4_9)

		local var_4_10 = var_11
		local var_4_11 = var_11.getTaskStatus(var_4_10)

		setActive = var_15

		var_15(var_1_10010:Find("claimed"), var_11:getTaskStatus() == 2)

		onButton = var_15

		var_15(arg_4_0, var_1_10010, function()
			local var_5_0 = arg_4_0
			local var_5_1 = var_0.emit

			BaseUI = var_2_10003

			var_5_1(var_5_0, var_2_10003.ON_DROP, var_4_9)

			return
		end)

		if var_4_6:GetPreChapterId() ~= 0 then
			table = var_4_15

			local var_4_15

			if var_4_15.contains(var_4_2, var_4_6:GetPreChapterId()) then
				setActive = var_4_15

				var_4_15(iter_4_3:Find("lock"), false)

				onButton = var_4_15

				var_4_15(arg_4_0, iter_4_3, function()
					local var_6_0 = arg_4_0
					local var_6_1 = arg_4_0

					var_6_0.fleetEditPanel = var_1.GetFleetEditPanel(var_6_1)
					getProxy = var_6_0
					FleetProxy = var_2_10002

					local var_6_2 = var_6_0(var_2_10002)
					local var_6_3 = var_0.GetRegularFleets(var_6_2)
					local var_6_4 = arg_4_0.fleetEditPanel.buffer

					var_2.SetFleets(var_6_4, var_6_3)

					local var_6_5 = arg_4_0.fleetEditPanel.buffer
					local var_6_6 = var_2.SetSettings
					local var_6_7 = 1
					local var_6_8 = 0
					local var_6_9 = var_4_6
					local var_6_10 = var_7.GetExpeditionId(var_6_9)

					SYSTEM_REWARD_PERFORM = var_2_10008

					var_6_6(var_6_5, var_6_7, var_6_8, var_6_10, var_2_10008, arg_4_0.activity.configId)

					local var_6_11 = arg_4_0.fleetEditPanel.buffer

					var_2.UpdateView(var_6_11)

					local var_6_12 = arg_4_0.fleetEditPanel.buffer

					var_2.Show(var_6_12)

					return
				end)

				setActive = var_4_15

				local var_4_12 = arg_4_0.chainTFList[iter_4_2]

				var_4_15(var_17.Find(var_4_12, "finish"), true)

				setActive = var_4_15

				local var_4_13 = arg_4_0.chainTFList[iter_4_2]

				var_4_15(var_17.Find(var_4_13, "unfinish"), false)

				local var_4_14 = iter_4_3:Find("name/text")

				var_4_15 = var_4_15.GetComponent
				typeof = var_18
				Text = var_20
				var_4_15 = var_4_15(var_4_14, var_18(var_20))
				Color = var_4_10
				var_4_15.color = var_4_10.white
				var_4_4 = iter_4_2
			else
				setActive = var_4_15

				local var_4_16 = arg_4_0.chainTFList[iter_4_2]

				var_4_15(var_17.Find(var_4_16, "finish"), false)

				setActive = var_4_15

				local var_4_17 = arg_4_0.chainTFList[iter_4_2]

				var_4_15(var_17.Find(var_4_17, "unfinish"), true)

				setActive = var_4_15

				var_4_15(iter_4_3:Find("lock"), true)
			end
		end
	end

	triggerToggle = var_4

	local var_4_18 = arg_4_0.stageTFList[var_4_4]

	var_4(var_6.Find(var_4_18, "bg"), true)

	pg = var_4

	local var_4_19 = var_4.NewStoryMgr.GetInstance()

	if #arg_4_0.activity.data2_list == 0 then
		local var_4_20 = var_4_19
		local var_4_21 = var_4_19.Play
		local var_4_22 = arg_4_0.activity

		var_4_21(var_4_20, var_9.getConfig(var_4_22, "config_client").story[1][1])
	end

	return
end

function var_0_1.GetFleetEditPanel(arg_7_0)
	if not arg_7_0.fleetEditPanel then
		BossSingleBattleFleetSelectSubPanelLite = var_1
		arg_7_0.fleetEditPanel = var_1.New(arg_7_0)

		local var_7_0 = arg_7_0.fleetEditPanel

		var_1.Load(var_7_0)
	end

	return arg_7_0.fleetEditPanel
end

function var_0_1.OnUpdateFlush(arg_8_0)
	arg_8_0:flushTaskData()

	ipairs = var_1

	for iter_8_0, iter_8_1 in var_1(arg_8_0._taskList) do
		local var_8_0 = iter_8_1:getTaskStatus()

		setActive = var_1_10007

		local var_8_1 = arg_8_0.stageTFList[iter_8_0]

		var_1_10007(var_9.Find(var_8_1, "award/claimed"), var_8_0 == 2)

		local var_8_2

		if iter_8_0 == 3 then
			if var_8_0 == 1 then
				pg = var_1_10007
				var_1_10007 = var_1_10007.NewStoryMgr.GetInstance()
				var_8_2 = arg_8_0.activity

				local var_8_3 = var_8.getConfig(var_8_2, "config_client").story[2][1]
				local var_8_4 = arg_8_0.activity
				local var_8_5 = var_9.getConfig(var_8_4, "config_client").story[3][1]

				var_8_2 = var_1_10007:StoryName2StoryId(var_8_3)

				local var_8_6 = var_1_10007:StoryName2StoryId(var_8_5)

				if not var_1_10007:IsPlayed(var_8_3) then
					local var_8_7 = arg_8_0
					local var_8_8 = arg_8_0.emit

					ActivityMediator = var_15

					var_8_8(var_8_7, var_15.GO_PERFORM_COMBAT, {
						stageId = var_8_2
					})
				elseif not var_1_10007:IsPlayed(var_8_5) then
					local var_8_9 = arg_8_0
					local var_8_10 = arg_8_0.emit

					ActivityMediator = var_15

					var_8_10(var_8_9, var_15.GO_PERFORM_COMBAT, {
						stageId = var_8_6
					})
				else
					local var_8_11 = arg_8_0
					local var_8_12 = arg_8_0.emit

					ActivityMediator = var_15

					var_8_12(var_8_11, var_15.ON_TASK_SUBMIT, iter_8_1)
				end
			end
		elseif var_8_0 == 1 then
			local var_8_13 = arg_8_0

			var_1_10007 = arg_8_0.emit
			ActivityMediator = var_8_2

			var_1_10007(var_8_13, var_8_2.ON_TASK_SUBMIT, iter_8_1)
		end
	end

	return
end

function var_0_1.OnDestroy(arg_9_0)
	if arg_9_0.fleetEditPanel then
		local var_9_0 = arg_9_0.fleetEditPanel

		var_1.OnHide(var_9_0)
	end

	return
end

return var_0_1
