local var_0_0 = class("ClueMapScene", import("view.base.BaseUI"))
local var_0_1 = pg.activity_single_enemy
local var_0_2 = pg.activity_clue

function var_0_0.getUIName(arg_1_0)
	return "ClueMapUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.ui = arg_2_0._tf:Find("ui")
	arg_2_0.closeBtn = arg_2_0._tf:Find("ui/top/back_button")
	arg_2_0.homeBtn = arg_2_0._tf:Find("ui/top/home_button")
	arg_2_0.bgs = {
		arg_2_0._tf:Find("bgs/bg1"),
		arg_2_0._tf:Find("bgs/bg2"),
		arg_2_0._tf:Find("bgs/bg3")
	}
	arg_2_0.mapsSwitch = {
		arg_2_0._tf:Find("ui/mapsSwitch/map1"),
		arg_2_0._tf:Find("ui/mapsSwitch/map2"),
		arg_2_0._tf:Find("ui/mapsSwitch/map3")
	}
	arg_2_0.chapters = {
		arg_2_0._tf:Find("ui/chapters/t1"),
		arg_2_0._tf:Find("ui/chapters/t2"),
		arg_2_0._tf:Find("ui/chapters/t3"),
		arg_2_0._tf:Find("ui/chapters/t4")
	}
	arg_2_0.chapterSp = arg_2_0._tf:Find("ui/chapterSp")
	arg_2_0.pt = arg_2_0._tf:Find("ui/pt")
	arg_2_0.explore = arg_2_0._tf:Find("ui/exploreTarget")
	arg_2_0.taskBtn = arg_2_0._tf:Find("ui/taskBtn")
	arg_2_0.bookBtn = arg_2_0._tf:Find("ui/bookBtn")

	setText(arg_2_0.pt:Find("total"), i18n("clue_pt_tip"))

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:InitData()
	arg_3_0:ShowResUI()
	arg_3_0:InitMapsSwitch()
	arg_3_0:UpdateCluePanel()
	setText(arg_3_0.pt:Find("Text"), arg_3_0.ptData.count)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:StopBgm()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.homeBtn, function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_CANCEL)
	setActive(arg_3_0.taskBtn:Find("tip"), ClueTasksLayer.ShouldShowTip())
	onButton(arg_3_0, arg_3_0.taskBtn, function()
		arg_3_0:emit(ClueMapMediator.OPEN_CLUE_TASk, function()
			if arg_3_0._tf then
				setActive(arg_3_0.taskBtn:Find("tip"), ClueTasksLayer.ShouldShowTip())

				arg_3_0.ptActivity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_PT_ACT_ID)
				arg_3_0.ptData = ActivityPtData.New(arg_3_0.ptActivity)

				setText(arg_3_0.pt:Find("Text"), arg_3_0.ptData.count)

				arg_3_0.activity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_ACT_ID)

				setText(arg_3_0.chapterSp:Find("ticket/count"), "X " .. arg_3_0.activity.data1)
			end

			return
		end)

		return
	end, SFX_PANEL)
	setActive(arg_3_0.bookBtn:Find("tip"), ClueBookLayer.ShouldShowTip())
	onButton(arg_3_0, arg_3_0.bookBtn, function()
		arg_3_0:emit(ClueMapMediator.OPEN_CLUE_BOOK, function()
			if arg_3_0._tf then
				arg_3_0:UpdateCluePanel()
				setActive(arg_3_0.bookBtn:Find("tip"), ClueBookLayer.ShouldShowTip())

				arg_3_0.ptActivity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_PT_ACT_ID)
				arg_3_0.ptData = ActivityPtData.New(arg_3_0.ptActivity)

				setText(arg_3_0.pt:Find("Text"), arg_3_0.ptData.count)

				arg_3_0.activity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_ACT_ID)

				setText(arg_3_0.chapterSp:Find("ticket/count"), "X " .. arg_3_0.activity.data1)
			end

			return
		end)

		return
	end, SFX_PANEL)
	pg.NewStoryMgr.GetInstance():Play(arg_3_0.enterStory)
	arg_3_0:SubmitClueTask()

	if getProxy(ContextProxy):getContextByMediator(ClueMapMediator).cleanChild and arg_3_0.contextData.bookOpen then
		triggerButton(arg_3_0.bookBtn)
	end

	return
end

function var_0_0.InitData(arg_10_0)
	arg_10_0.easyChapters = {}
	arg_10_0.normalChapters = {}
	arg_10_0.hardChapters = {}
	arg_10_0.spChapter = nil

	for iter_10_0, iter_10_1 in ipairs(var_0_1.all) do
		if var_0_1[iter_10_1].activity_type == 2 then
			if var_0_1[iter_10_1].type == 1 then
				table.insert(arg_10_0.easyChapters, var_0_1[iter_10_1])
			elseif var_0_1[iter_10_1].type == 2 then
				table.insert(arg_10_0.normalChapters, var_0_1[iter_10_1])
			elseif var_0_1[iter_10_1].type == 3 then
				table.insert(arg_10_0.hardChapters, var_0_1[iter_10_1])
			elseif var_0_1[iter_10_1].type == 4 then
				arg_10_0.spChapter = var_0_1[iter_10_1]
			end
		end
	end

	arg_10_0.activity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_ACT_ID)
	arg_10_0.ptActivity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_PT_ACT_ID)
	arg_10_0.ptData = ActivityPtData.New(arg_10_0.ptActivity)
	arg_10_0.contextData.mapIndex = defaultValue(arg_10_0.contextData.mapIndex, 1)
	arg_10_0.submitGroupIds = {}
	arg_10_0.canSubmitTaskIds = {}
	arg_10_0.submitClueIds = {}

	for iter_10_2, iter_10_3 in pairs(var_0_2.get_id_list_by_group) do
		local var_10_0 = false

		for iter_10_4, iter_10_5 in ipairs(iter_10_3) do
			local var_10_1 = tonumber(var_0_2[iter_10_5].task_id)
			local var_10_2 = getProxy(TaskProxy):getTaskVO(var_10_1)

			if var_10_2:getTaskStatus() == 1 then
				if not arg_10_0.canSubmitTaskIds[iter_10_2] then
					arg_10_0.canSubmitTaskIds[iter_10_2] = {}
					arg_10_0.submitClueIds[iter_10_2] = {}
				end

				table.insert(arg_10_0.canSubmitTaskIds[iter_10_2], var_10_1)
				table.insert(arg_10_0.submitClueIds[iter_10_2], iter_10_5)

				var_10_0 = true
			end
		end

		if var_10_0 then
			table.insert(arg_10_0.submitGroupIds, iter_10_2)
		end
	end

	local var_10_3 = arg_10_0.activity:getConfig("config_client")

	arg_10_0.enterStory = var_10_3.enterStory
	arg_10_0.bgms = var_10_3.bgm1

	return
end

function var_0_0.RefreshPtAndTicket(arg_11_0)
	arg_11_0.ptActivity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_PT_ACT_ID)
	arg_11_0.ptData = ActivityPtData.New(arg_11_0.ptActivity)

	setText(arg_11_0.pt:Find("Text"), arg_11_0.ptData.count)

	arg_11_0.activity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_ACT_ID)

	setText(arg_11_0.chapterSp:Find("ticket/count"), "X " .. arg_11_0.activity.data1)

	return
end

function var_0_0.ShowResUI(arg_12_0)
	arg_12_0.goldMax = findTF(arg_12_0._tf, "ui/top/res/gold/max"):GetComponent(typeof(Text))
	arg_12_0.goldValue = findTF(arg_12_0._tf, "ui/top/res/gold/Text"):GetComponent(typeof(Text))
	arg_12_0.oilMax = findTF(arg_12_0._tf, "ui/top/res/oil/max"):GetComponent(typeof(Text))
	arg_12_0.oilValue = findTF(arg_12_0._tf, "ui/top/res/oil/Text"):GetComponent(typeof(Text))
	arg_12_0.gemValue = findTF(arg_12_0._tf, "ui/top/res/gem/Text"):GetComponent(typeof(Text))

	PlayerResUI.StaticFlush(getProxy(PlayerProxy):getRawData(), arg_12_0.goldMax, arg_12_0.goldValue, arg_12_0.oilMax, arg_12_0.oilValue, arg_12_0.gemValue)
	onButton(arg_12_0, findTF(arg_12_0._tf, "ui/top/res/gold"), function()
		pg.playerResUI:ClickGold()

		return
	end, SFX_PANEL)
	onButton(arg_12_0, findTF(arg_12_0._tf, "ui/top/res/oil"), function()
		pg.playerResUI:ClickOil()

		return
	end, SFX_PANEL)
	onButton(arg_12_0, findTF(arg_12_0._tf, "ui/top/res/gem"), function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateCluePanel(arg_16_0)
	local var_16_0 = PlayerPrefs.GetInt("investigatingGroupId_" .. ActivityConst.Valleyhospital_ACT_ID .. "_" .. getProxy(PlayerProxy):getRawData().id, 0)
	local var_16_1 = true
	local var_16_2
	local var_16_3 = 0

	if var_16_0 ~= 0 then
		var_16_2 = {
			var_0_2[var_0_2.get_id_list_by_group[var_16_0][1]],
			var_0_2[var_0_2.get_id_list_by_group[var_16_0][2]],
			var_0_2[var_0_2.get_id_list_by_group[var_16_0][3]]
		}
		var_16_3 = getProxy(TaskProxy):getTaskVO(tonumber(({
			var_0_2[var_0_2.get_id_list_by_group[var_16_0][1]],
			var_0_2[var_0_2.get_id_list_by_group[var_16_0][2]],
			var_0_2[var_0_2.get_id_list_by_group[var_16_0][3]]
		})[3].task_id)):getProgress()

		for iter_16_0 = 1, 3 do
			local var_16_4 = getProxy(TaskProxy)

			if not var_16_4:getFinishTaskById(tonumber(var_16_2[iter_16_0].task_id)) then
				var_16_1 = false

				break
			end
		end
	end

	if var_16_1 then
		setText(arg_16_0.explore:Find("target/Text"), i18n("clue_unselect_tip"))
	else
		setText(arg_16_0.explore:Find("target/Text"), var_16_2[1].unlock_desc .. var_16_2[1].unlock_num .. "/" .. var_16_2[2].unlock_num .. "/" .. var_16_2[3].unlock_num .. i18n("clue_task_tip", var_16_3))
	end

	return
end

function var_0_0.InitMapsSwitch(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.mapsSwitch) do
		onToggle(arg_17_0, iter_17_1, function(arg_18_0)
			if arg_18_0 then
				arg_17_0.contextData.mapIndex = iter_17_0

				for iter_18_0 = 1, 3 do
					setActive(arg_17_0.bgs[iter_18_0], iter_18_0 == iter_17_0)

					arg_17_0.mapsSwitch[iter_18_0]:GetComponent(typeof(CanvasGroup)).alpha = iter_18_0 == iter_17_0 and 1 or 0.4
				end

				if iter_17_0 == 1 then
					for iter_18_1, iter_18_2 in ipairs(arg_17_0.chapters) do
						setActive(iter_18_2:Find("dusk"), iter_17_0 == 2)
						setActive(iter_18_2:Find("night"), iter_17_0 == 3)
						setActive(iter_18_2:Find("title"), true)
						setActive(iter_18_2:Find("title2"), false)
						onButton(arg_17_0, iter_18_2, function()
							arg_17_0:OpenChapterLayer(arg_17_0.easyChapters[iter_18_1].id)

							return
						end, SFX_PANEL)
					end
				elseif iter_17_0 == 2 then
					for iter_18_3, iter_18_4 in ipairs(arg_17_0.chapters) do
						setActive(iter_18_4:Find("dusk"), iter_17_0 == 2)
						setActive(iter_18_4:Find("night"), iter_17_0 == 3)
						setActive(iter_18_4:Find("title"), true)
						setActive(iter_18_4:Find("title2"), false)
						onButton(arg_17_0, iter_18_4, function()
							arg_17_0:OpenChapterLayer(arg_17_0.normalChapters[iter_18_3].id)

							return
						end, SFX_PANEL)
					end
				else
					for iter_18_5, iter_18_6 in ipairs(arg_17_0.chapters) do
						setActive(iter_18_6:Find("dusk"), iter_17_0 == 2)
						setActive(iter_18_6:Find("night"), iter_17_0 == 3)
						setActive(iter_18_6:Find("title"), false)
						setActive(iter_18_6:Find("title2"), true)
						onButton(arg_17_0, iter_18_6, function()
							arg_17_0:OpenChapterLayer(arg_17_0.hardChapters[iter_18_5].id)

							return
						end, SFX_PANEL)
					end
				end

				setActive(arg_17_0.chapterSp:Find("dusk"), iter_17_0 == 2)
				setActive(arg_17_0.chapterSp:Find("night"), iter_17_0 == 3)
				GetImageSpriteFromAtlasAsync(pg.item_virtual_data_statistics[arg_17_0.spChapter.enter_cost].icon, "", arg_17_0.chapterSp:Find("ticket/icon"), false)

				arg_17_0.activity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_ACT_ID)

				setText(arg_17_0.chapterSp:Find("ticket/count"), "X " .. arg_17_0.activity.data1)
				onButton(arg_17_0, arg_17_0.chapterSp, function()
					arg_17_0:OpenChapterLayer(arg_17_0.spChapter.id)

					return
				end, SFX_PANEL)
				pg.BgmMgr.GetInstance():Push(arg_17_0.__cname, arg_17_0.bgms[arg_17_0.contextData.mapIndex])
			end

			return
		end, SFX_PANEL)

		if arg_17_0.contextData.mapIndex == iter_17_0 then
			triggerToggle(iter_17_1, true)
		end
	end

	return
end

function var_0_0.OpenChapterLayer(arg_23_0, arg_23_1)
	arg_23_0:emit(ClueMapMediator.OPEN_STAGE, arg_23_1)

	return
end

function var_0_0.SubmitClueTask(arg_24_0)
	if #arg_24_0.submitGroupIds > 0 then
		arg_24_0:emit(ClueMapMediator.ON_TASK_SUBMIT_ONESTEP, ActivityConst.Valleyhospital_TASK_ID, arg_24_0.canSubmitTaskIds[arg_24_0.submitGroupIds[1]], function(arg_25_0)
			if arg_25_0 then
				arg_24_0:UpdateCluePanel()
				arg_24_0:OpenSingleClueGroupPanel()
			end

			return
		end)

		arg_24_0.showClueGroupId = table.remove(arg_24_0.submitGroupIds, 1)
	end

	return
end

function var_0_0.OpenSingleClueGroupPanel(arg_26_0)
	arg_26_0:emit(ClueMapMediator.OPEN_SINGLE_CLUE_GROUP, arg_26_0.showClueGroupId, arg_26_0.submitClueIds[arg_26_0.showClueGroupId], function()
		arg_26_0:SubmitClueTask()
		arg_26_0:UpdateCluePanel()
		setActive(arg_26_0.bookBtn:Find("tip"), ClueBookLayer.ShouldShowTip())

		return
	end)

	return
end

function var_0_0.willExit(arg_28_0)
	return
end

function var_0_0.onBackPressed(arg_29_0)
	arg_29_0:StopBgm()
	arg_29_0:closeView()

	return
end

return var_0_0
