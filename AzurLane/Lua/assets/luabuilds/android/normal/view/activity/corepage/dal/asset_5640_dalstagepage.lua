class = var_0_10000

local var_0_0 = "DALStagePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.AD = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.AD

	arg_1_0.tabs = var_1.Find(var_1_1, "tabs")
	arg_1_0.tabsList = arg_1_0.tabs.transform.childCount
	setText = var_1

	local var_1_2 = arg_1_0.AD
	local var_1_3 = var_2.Find(var_1_2, "headline_bg/Text (Legacy)")

	i18n = var_1_2

	var_1(var_1_3, var_1_2("DAL_story_tip"))

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002
	arg_2_0.taskProxy = var_1_10001(var_1_10002)

	local var_2_0 = arg_2_0.activity

	arg_2_0.config_data = var_1.getConfig(var_2_0, "config_data")

	local var_2_1 = arg_2_0.activity

	arg_2_0.config_client = var_1.getConfig(var_2_1, "config_client").story

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	for iter_3_0 = 1, #arg_3_0.config_data do
		var_1_10006 = arg_3_0.taskProxy

		local var_3_0 = var_5.getTaskVO(var_1_10006, arg_3_0.config_data[iter_3_0])

		var_1_10006 = var_5.getTaskStatus(var_3_0)
		SetActive = var_3_0

		local var_3_1 = arg_3_0.AD

		var_3_0(var_8.Find(var_3_1, "tabs/" .. iter_3_0 .. "/got_red"), var_1_10006 == 2)

		SetActive = var_3_0

		local var_3_2 = arg_3_0.AD

		var_3_0(var_8.Find(var_3_2, "tabs/" .. iter_3_0 .. "/red"), var_1_10006 == 1)

		if var_1_10006 == 2 then
			pg = var_3_0

			local var_3_3 = var_3_0.NewStoryMgr.GetInstance()

			if not var_7.IsPlayed(var_3_3, arg_3_0.config_client[iter_3_0][1]) then
				pg = var_3_3

				local var_3_4 = var_3_3.NewStoryMgr.GetInstance()
				local var_3_5, var_3_6 = var_8.StoryName2StoryId(var_3_4, arg_3_0.config_client[iter_3_0][1])

				pg = var_10

				local var_3_7 = var_10.m02
				local var_3_8 = var_10.sendNotification

				GAME = var_12

				local var_3_9 = var_12.STORY_UPDATE_LIST
				local var_3_10 = {
					storyIds = {
						var_3_5
					}
				}

				callback = var_14
				var_3_10.callback = var_14

				var_3_8(var_3_7, var_3_9, var_3_10)
			end
		end
	end

	local var_3_11 = -1

	for iter_3_1 = 0, arg_3_0.tabsList - 1 do
		onToggle = var_1_10006

		local var_3_12 = arg_3_0
		local var_3_13 = arg_3_0.tabs
		local var_3_14 = var_8.GetChild(var_3_13, iter_3_1)

		local function var_3_15(arg_4_0)
			if arg_4_0 then
				if var_3_11 ~= iter_3_1 then
					local var_4_0 = arg_3_0

					var_1.OnUpdata(var_4_0, iter_3_1 + 1)
				end

				var_3_11 = iter_3_1
			end

			return
		end

		SFX_PANEL = var_10

		var_1_10006(var_3_12, var_3_14, var_3_15, var_10)
	end

	triggerToggle = var_2

	local var_3_16 = arg_3_0.tabs

	var_2(var_3.Find(var_3_16, "1"), true)

	return
end

function var_0_1.OnUpdata(arg_5_0, arg_5_1)
	setText = var_1_10002

	local var_5_0 = arg_5_0.AD

	var_1_10002(var_3.Find(var_5_0, "id"), "0" .. arg_5_1)

	setText = var_1_10002

	local var_5_1 = arg_5_0.AD
	local var_5_2 = var_3.Find(var_5_1, "id/Text")

	i18n = var_5_1

	var_1_10002(var_5_2, var_5_1("dal_story_tip_name_en_" .. arg_5_1))

	setText = var_1_10002

	local var_5_3 = arg_5_0.AD
	local var_5_4 = var_3.Find(var_5_3, "go/name")

	i18n = var_5_3

	var_1_10002(var_5_4, var_5_3("text_goto"))

	setImageSprite = var_1_10002

	local var_5_5 = arg_5_0.AD
	local var_5_6 = var_3.Find(var_5_5, "Image")

	LoadSprite = var_5_5

	var_1_10002(var_5_6, var_5_5("ui/DALStagePage_atlas", arg_5_1), true)

	local var_5_7 = arg_5_0.taskProxy
	local var_5_8 = var_2.getTaskVO(var_5_7, arg_5_0.config_data[arg_5_1])

	setText = var_5_7

	local var_5_9 = arg_5_0.AD

	var_5_7(var_4.Find(var_5_9, "Image/lock/Text"), var_5_8:getConfig("desc"))

	setText = var_5_7

	local var_5_10 = arg_5_0.AD

	var_5_7(var_4.Find(var_5_10, "Text"), var_5_8:getConfig("name"))

	local var_5_11 = var_5_8:getConfig("award_display")[1]
	local var_5_12 = {
		type = var_5_11[1],
		id = var_5_11[2],
		count = var_5_11[3]
	}

	updateDrop = var_5

	local var_5_13 = arg_5_0.AD

	var_5(var_6.Find(var_5_13, "award"), var_5_12)

	onButton = var_5

	local var_5_14 = arg_5_0
	local var_5_15 = arg_5_0.AD
	local var_5_16 = var_7.Find(var_5_15, "award/icon_mask")

	local function var_5_17()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.emit

		BaseUI = var_2_10002

		var_6_1(var_6_0, var_2_10002.ON_DROP, var_5_12)

		return
	end

	SFX_PANEL = var_9

	var_5(var_5_14, var_5_16, var_5_17, var_9)

	local var_5_18 = var_5_8
	local var_5_19 = var_5_8.getTaskStatus(var_5_18)

	SetActive = var_5_18

	local var_5_20 = arg_5_0.AD

	var_5_18(var_7.Find(var_5_20, "award/lock"), var_5_19 == 2)

	SetActive = var_5_18

	local var_5_21 = arg_5_0.AD

	var_5_18(var_7.Find(var_5_21, "play"), var_5_19 == 1 and not arg_5_0.IsPlayeds)

	SetActive = var_5_18

	local var_5_22 = arg_5_0.AD

	var_5_18(var_7.Find(var_5_22, "go"), var_5_19 == 0)

	SetActive = var_5_18

	local var_5_23 = arg_5_0.AD

	var_5_18(var_7.Find(var_5_23, "Image/lock"), var_5_19 == 0)

	onButton = var_5_18

	local var_5_24 = arg_5_0
	local var_5_25 = arg_5_0.AD
	local var_5_26 = var_8.Find(var_5_25, "play")

	local function var_5_27()
		pg = var_2_10000

		local var_7_0 = var_2_10000.NewStoryMgr.GetInstance()

		var_0.Play(var_7_0, arg_5_0.config_client[arg_5_1][1], function()
			local var_8_0 = arg_5_0
			local var_8_1 = var_0.emit

			ActivityMediator = var_3_10002

			var_8_1(var_8_0, var_3_10002.ON_TASK_SUBMIT, var_5_8)

			return
		end, true)

		return
	end

	SFX_PANEL = var_10

	var_5_18(var_5_24, var_5_26, var_5_27, var_10)

	onButton = var_5_18

	local var_5_28 = arg_5_0
	local var_5_29 = arg_5_0.AD
	local var_5_30 = var_8.Find(var_5_29, "go")

	local function var_5_31()
		local var_9_0 = arg_5_0
		local var_9_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_9_1(var_9_0, var_2_10002.ON_TASK_GO, var_5_8)

		return
	end

	SFX_PANEL = var_10

	var_5_18(var_5_28, var_5_30, var_5_31, var_10)

	if var_5_19 == 0 then
		setText = var_5_18

		local var_5_32 = arg_5_0.AD
		local var_5_33 = var_7.Find(var_5_32, "rule")

		i18n = var_5_32

		var_5_18(var_5_33, var_5_32("dal_story_tip1"))
	elseif var_5_19 == 1 then
		setText = var_5_18

		local var_5_34 = arg_5_0.AD
		local var_5_35 = var_7.Find(var_5_34, "rule")

		i18n = var_5_34

		var_5_18(var_5_35, var_5_34("dal_story_tip2"))
	elseif var_5_19 == 2 then
		setText = var_5_18

		local var_5_36 = arg_5_0.AD
		local var_5_37 = var_7.Find(var_5_36, "rule")

		i18n = var_5_36

		var_5_18(var_5_37, var_5_36("dal_story_tip3"))
	end

	return
end

return var_0_1
