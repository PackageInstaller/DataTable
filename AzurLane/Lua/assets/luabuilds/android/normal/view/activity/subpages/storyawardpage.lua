class = var_0_10000

local var_0_0 = "StoryAwardPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0._tf

	arg_1_0.itemTpl = var_1.Find(var_1_1, "Item")

	local var_1_2 = arg_1_0._tf

	arg_1_0.taskItemTpl = var_1.Find(var_1_2, "TaskItem")

	local var_1_3 = arg_1_0._tf

	arg_1_0.scrollTF = var_1.Find(var_1_3, "Mask/ScrollView")

	local var_1_4 = arg_1_0._tf

	arg_1_0.container = var_1.Find(var_1_4, "Mask/ScrollView/Content")

	local var_1_5 = arg_1_0._tf

	arg_1_0.arrow = var_1.Find(var_1_5, "Mask/Arrow")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.activity_event_chapter_award
	local var_2_1 = arg_2_0.activity

	arg_2_0.config = var_2_0[var_2.getConfig(var_2_1, "config_id")]
	arg_2_0.chapterIDList = arg_2_0.config.chapter

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	for iter_3_0 = 1, #arg_3_0.chapterIDList do
		local var_3_0 = arg_3_0.chapterIDList[iter_3_0]

		pg = var_1_10006
		var_1_10006 = var_1_10006.chapter_template[var_3_0].chapter_name
		cloneTplTo = var_1_10007

		local var_3_1 = arg_3_0.taskItemTpl
		local var_3_2 = arg_3_0.container
		local var_3_3 = "TaskItem"

		tostring = var_1_10011

		local var_3_4 = var_1_10007(var_3_1, var_3_2, var_3_3 .. var_1_10011(iter_3_0))
		local var_3_5 = var_1_10007.Find(var_3_4, "TaskTitle/LevelBum")
		local var_3_6 = var_1_10007:Find("ItemListContainer")

		var_1_10011 = var_1_10007

		local var_3_7 = var_1_10007.Find(var_1_10011, "GotTag")
		local var_3_8 = var_1_10007

		var_1_10011 = var_1_10007.Find(var_3_8, "GetBtn")
		setText = var_3_8

		var_3_8(var_3_5, var_1_10006)

		for iter_3_1 = 1, #arg_3_0.config.award_display[iter_3_0] do
			cloneTplTo = var_1_10016
			var_1_10016 = var_1_10016(arg_3_0.itemTpl, var_3_6)

			local var_3_9 = arg_3_0.config.award_display[iter_3_0][iter_3_1]
			local var_3_10 = {
				type = var_3_9[1],
				id = var_3_9[2],
				count = var_3_9[3]
			}

			updateDrop = var_19

			var_19(var_1_10016, var_3_10)

			onButton = var_19

			local var_3_11 = arg_3_0
			local var_3_12 = var_1_10016

			local function var_3_13()
				local var_4_0 = arg_3_0
				local var_4_1 = var_0.emit

				BaseUI = var_2_10002

				var_4_1(var_4_0, var_2_10002.ON_DROP, var_3_10)

				return
			end

			SFX_PANEL = var_1_10023

			var_19(var_3_11, var_3_12, var_3_13, var_1_10023)
		end

		onButton = var_12

		local var_3_14 = arg_3_0
		local var_3_15 = var_1_10011

		local function var_3_16()
			local var_5_0 = arg_3_0
			local var_5_1 = var_0.emit

			ActivityMediator = var_2_10002

			var_5_1(var_5_0, var_2_10002.EVENT_OPERATION, {
				cmd = 1,
				activity_id = arg_3_0.activity.id,
				arg1 = var_3_0
			})

			return
		end

		SFX_PANEL = var_1_10016

		var_12(var_3_14, var_3_15, var_3_16, var_1_10016)
	end

	onScroll = var_1

	var_1(arg_3_0, arg_3_0.scrollTF, function(arg_6_0)
		setActive = var_2_10001

		var_2_10001(arg_3_0.arrow, arg_6_0.y >= 0.01)

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	for iter_7_0 = 1, #arg_7_0.chapterIDList do
		local var_7_0 = arg_7_0.chapterIDList[iter_7_0]
		local var_7_1 = arg_7_0.container
		local var_7_2 = var_6.Find
		local var_7_3 = "TaskItem"

		tostring = var_1_10009

		local var_7_4 = var_7_2(var_7_1, var_7_3 .. var_1_10009(iter_7_0))
		local var_7_5 = var_6.Find(var_7_4, "GotTag")

		var_1_10009 = var_6

		local var_7_6 = var_6.Find(var_1_10009, "GetBtn")

		_ = var_1_10009

		if var_1_10009.include(arg_7_0.activity.data1_list, var_7_0) then
			local var_7_7 = var_6.transform

			var_10.SetAsLastSibling(var_7_7)
		end

		local var_7_8 = var_6:Find("TaskTitle")
		local var_7_9 = var_6
		local var_7_10 = var_6.Find(var_7_9, "ItemListContainer")

		setGray = var_7_9

		var_7_9(var_7_8, var_1_10009)

		setGray = var_7_9

		var_7_9(var_7_10, var_1_10009)

		setActive = var_7_9

		var_7_9(var_7_5, var_1_10009)

		setActive = var_7_9

		local var_7_11 = var_7_6

		getProxy = var_14
		ChapterProxy = var_1_10015
		var_1_10015 = var_14(var_1_10015)

		local var_7_12

		if var_14.isClear(var_1_10015, var_7_0) then
			var_7_12 = not var_1_10009
		end

		var_7_9(var_7_11, var_7_12)
	end

	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

return var_0_1
