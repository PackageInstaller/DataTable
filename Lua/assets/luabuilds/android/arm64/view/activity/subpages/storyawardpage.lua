local var_0_0 = class("StoryAwardPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("bg")
	arg_1_0.itemTpl = arg_1_0._tf:Find("Item")
	arg_1_0.taskItemTpl = arg_1_0._tf:Find("TaskItem")
	arg_1_0.scrollTF = arg_1_0._tf:Find("Mask/ScrollView")
	arg_1_0.container = arg_1_0._tf:Find("Mask/ScrollView/Content")
	arg_1_0.arrow = arg_1_0._tf:Find("Mask/Arrow")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.config = pg.activity_event_chapter_award[arg_2_0.activity:getConfig("config_id")]
	arg_2_0.chapterIDList = arg_2_0.config.chapter

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	for iter_3_0 = 1, #arg_3_0.chapterIDList do
		local var_3_0 = cloneTplTo(arg_3_0.taskItemTpl, arg_3_0.container, "TaskItem" .. tostring(iter_3_0))
		local var_3_1 = var_3_0:Find("ItemListContainer")
		local var_3_2 = var_3_0:Find("GotTag")
		local var_3_3 = var_3_0:Find("GetBtn")

		setText(var_3_0:Find("TaskTitle/LevelBum"), pg.chapter_template[arg_3_0.chapterIDList[iter_3_0]].chapter_name)

		for iter_3_1 = 1, #arg_3_0.config.award_display[iter_3_0] do
			local var_3_4 = cloneTplTo(arg_3_0.itemTpl, var_3_1)

			updateDrop(var_3_4, {
				type = arg_3_0.config.award_display[iter_3_0][iter_3_1][1],
				id = arg_3_0.config.award_display[iter_3_0][iter_3_1][2],
				count = arg_3_0.config.award_display[iter_3_0][iter_3_1][3]
			})
			onButton(arg_3_0, var_3_4, function()
				arg_3_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end

		onButton(arg_3_0, var_3_3, function()
			arg_3_0:emit(ActivityMediator.EVENT_OPERATION, {
				cmd = 1,
				activity_id = arg_3_0.activity.id,
				arg1 = var_0
			})

			return
		end, SFX_PANEL)
	end

	onScroll(arg_3_0, arg_3_0.scrollTF, function(arg_6_0)
		setActive(arg_3_0.arrow, arg_6_0.y >= 0.01)

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_7_0)
	for iter_7_0 = 1, #arg_7_0.chapterIDList do
		local var_7_0 = arg_7_0.container:Find("TaskItem" .. tostring(iter_7_0))
		local var_7_1 = var_7_0:Find("GotTag")
		local var_7_2 = var_7_0:Find("GetBtn")
		local var_7_3 = _.include(arg_7_0.activity.data1_list, arg_7_0.chapterIDList[iter_7_0])
		local var_7_4

		if var_7_3 then
			var_7_0.transform:SetAsLastSibling()

			var_7_4 = var_7_0:Find("ItemListContainer")
		end

		setGray(var_7_0:Find("TaskTitle"), var_7_3)
		setGray(var_7_4, var_7_3)
		setActive(var_7_1, var_7_3)

		local var_7_6 = getProxy(ChapterProxy):isClear(arg_7_0.chapterIDList[iter_7_0])

		var_7_6 = var_7_6 and not var_7_3

		setActive(var_7_2, var_7_6)
	end

	return
end

function var_0_0.OnDestroy(arg_8_0)
	return
end

return var_0_0
