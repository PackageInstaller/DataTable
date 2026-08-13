class = var_0_10000

local var_0_0 = "StoryAwardPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

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

		tostring = var_1_10012

		local var_3_4 = var_1_10007(var_3_1, var_3_2, var_3_3 .. var_1_10012(iter_3_0))
		local var_3_5 = var_1_10007.Find(var_3_4, "TaskTitle/LevelBum")
		local var_3_6 = var_1_10007:Find("ItemListContainer")

		var_1_10012 = var_1_10007

		local var_3_7 = var_1_10007.Find(var_1_10012, "GotTag")
		local var_3_8 = var_1_10007:Find("GetBtn")

		setText = var_1_10012

		var_1_10012(var_3_5, var_1_10006)

		for iter_3_1 = 1, #arg_3_0.config.award_display[iter_3_0] do
			cloneTplTo = var_1_10016
			var_1_10016 = var_1_10016(arg_3_0.itemTpl, var_3_6)
			var_1_10017 = arg_3_0.config.award_display[iter_3_0][iter_3_1]

			local var_3_9 = {
				type = var_1_10017[1],
				id = var_1_10017[2],
				count = var_1_10017[3]
			}

			updateDrop = var_19

			var_19(var_1_10016, var_3_9)

			onButton = var_19

			local var_3_10 = arg_3_0
			local var_3_11 = var_1_10016

			local function var_3_12()
				local var_4_0 = arg_3_0
				local var_4_1 = var_0.emit

				BaseUI = var_2_10003

				var_4_1(var_4_0, var_2_10003.ON_DROP, var_3_9)

				return
			end

			SFX_PANEL = var_1_10024

			var_19(var_3_10, var_3_11, var_3_12, var_1_10024)
		end

		onButton = var_1_10012

		local var_3_13 = arg_3_0
		local var_3_14 = var_3_8

		function var_1_10016()
			local var_5_0 = arg_3_0
			local var_5_1 = var_0.emit

			ActivityMediator = var_2_10003

			var_5_1(var_5_0, var_2_10003.EVENT_OPERATION, {
				cmd = 1,
				activity_id = arg_3_0.activity.id,
				arg1 = var_3_0
			})

			return
		end

		SFX_PANEL = var_1_10017

		var_1_10012(var_3_13, var_3_14, var_1_10016, var_1_10017)
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

		tostring = var_1_10010

		local var_7_4 = var_7_2(var_7_1, var_7_3 .. var_1_10010(iter_7_0))
		local var_7_5 = var_6.Find(var_7_4, "GotTag")

		var_1_10010 = var_6

		local var_7_6 = var_6.Find(var_1_10010, "GetBtn")

		_ = var_7_4

		if var_7_4.include(arg_7_0.activity.data1_list, var_7_0) then
			local var_7_7 = var_6.transform

			var_1_10010.SetAsLastSibling(var_7_7)
		end

		local var_7_8 = var_6

		var_1_10010 = var_6.Find(var_7_8, "TaskTitle")

		local var_7_9 = var_6:Find("ItemListContainer")

		setGray = var_7_8

		var_7_8(var_1_10010, var_9)

		setGray = var_7_8

		var_7_8(var_7_9, var_9)

		setActive = var_7_8

		var_7_8(var_7_5, var_9)

		setActive = var_7_8

		local var_7_10 = var_7_6

		getProxy = var_15
		ChapterProxy = var_1_10017
		var_1_10017 = var_15(var_1_10017)

		local var_7_11

		if var_15.isClear(var_1_10017, var_7_0) then
			var_7_11 = not var_9
		end

		var_7_8(var_7_10, var_7_11)
	end

	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

return var_0_1
