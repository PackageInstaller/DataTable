local var_0_0 = class("ClueBookLayer", import("view.base.BaseUI"))
local var_0_1 = pg.activity_clue
local var_0_2 = pg.activity_clue_group
local var_0_3 = pg.activity_clue_ending

function var_0_0.getUIName(arg_1_0)
	return "ClueBookUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close")
	arg_2_0.pageTgs = {
		arg_2_0._tf:Find("frame/toggles/sitePageTg"),
		arg_2_0._tf:Find("frame/toggles/charaPageTg"),
		arg_2_0._tf:Find("frame/toggles/endingPageTg"),
		arg_2_0._tf:Find("frame/toggles/storyPageTg")
	}
	arg_2_0.pages = arg_2_0._tf:Find("frame/pages")
	arg_2_0.sitePage = arg_2_0.pages:Find("sitePage")
	arg_2_0.charaPage = arg_2_0.pages:Find("charaPage")
	arg_2_0.endingPage = arg_2_0.pages:Find("endingPage")
	arg_2_0.storyPage = arg_2_0.pages:Find("storyPage")
	arg_2_0.award = arg_2_0._tf:Find("frame/award")

	setText(arg_2_0.pageTgs[1]:Find("Text"), i18n("clue_title_1"))
	setText(arg_2_0.pageTgs[1]:Find("selected/Text"), i18n("clue_title_1"))
	setText(arg_2_0.pageTgs[2]:Find("Text"), i18n("clue_title_2"))
	setText(arg_2_0.pageTgs[2]:Find("selected/Text"), i18n("clue_title_2"))
	setText(arg_2_0.pageTgs[3]:Find("Text"), i18n("clue_title_3"))
	setText(arg_2_0.pageTgs[3]:Find("selected/Text"), i18n("clue_title_3"))
	setText(arg_2_0.pageTgs[4]:Find("Text"), i18n("clue_title_4"))
	setText(arg_2_0.pageTgs[4]:Find("selected/Text"), i18n("clue_title_4"))

	for iter_2_0 = 1, 3 do
		setText(arg_2_0.sitePage:Find("right/Viewport/Content/siteGroup" .. iter_2_0 .. "/goBtn/Text"), i18n("clue_task_goto"))
	end

	setText(arg_2_0.charaPage:Find("right/goBtn/Text"), i18n("clue_task_goto"))
	setText(arg_2_0.award:Find("doing/Text"), i18n("clue_get"))
	setText(arg_2_0.award:Find("get/Text"), i18n("clue_get"))
	setText(arg_2_0.award:Find("got/Text"), i18n("clue_got"))

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:InitData()
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:StopBgm()
		arg_3_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("mask"), function()
		arg_3_0:StopBgm()
		arg_3_0:closeView()

		return
	end, SFX_PANEL)
	arg_3_0:InitView()
	arg_3_0:UpdateView()
	pg.BgmMgr.GetInstance():Push(arg_3_0.__cname, arg_3_0.bgm)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)

	return
end

function var_0_0.InitData(arg_6_0)
	arg_6_0.activityId = ActivityConst.Valleyhospital_ACT_ID
	arg_6_0.taskActivityId = ActivityConst.Valleyhospital_TASK_ID
	arg_6_0.activity = getProxy(ActivityProxy):getActivityById(arg_6_0.activityId)
	arg_6_0.taskProxy = getProxy(TaskProxy)

	local var_6_0 = arg_6_0.activity:getConfig("config_client")

	arg_6_0.clueSite = var_6_0.clue_site
	arg_6_0.clueChara = var_6_0.clue_chara
	arg_6_0.clueEnding = var_6_0.clue_ending
	arg_6_0.story = var_6_0.story
	arg_6_0.storyTaskId = var_6_0.storyTaskId
	arg_6_0.afterStory = var_6_0.afterStory
	arg_6_0.bgm = var_6_0.bgm2
	arg_6_0.contextData.indexInfo.pageIndex = arg_6_0.contextData.indexInfo.pageIndex or 1
	arg_6_0.contextData.indexInfo.subPageSiteIndex = arg_6_0.contextData.indexInfo.subPageSiteIndex or 1
	arg_6_0.contextData.indexInfo.subPageCharaIndex = arg_6_0.contextData.indexInfo.subPageCharaIndex or 1
	arg_6_0.contextData.indexInfo.subPageEndingIndex = arg_6_0.contextData.indexInfo.subPageEndingIndex or 1
	arg_6_0.endingIndex = 1
	arg_6_0.storyIndex = 1
	arg_6_0.playerId = getProxy(PlayerProxy):getRawData().id
	arg_6_0.investigatingGroupId = PlayerPrefs.GetInt("investigatingGroupId_" .. arg_6_0.activityId .. "_" .. arg_6_0.playerId)

	return
end

function var_0_0.InitView(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.pageTgs) do
		setActive(iter_7_1:Find("selected"), arg_7_0.contextData.indexInfo.pageIndex == iter_7_0)
		onToggle(arg_7_0, iter_7_1, function(arg_8_0)
			if arg_8_0 then
				arg_7_0.contextData.indexInfo.pageIndex = iter_7_0

				for iter_8_0 = 0, arg_7_0.pages.childCount - 1 do
					setActive(arg_7_0.pages:GetChild(iter_8_0), iter_8_0 == iter_7_0 - 1)
					setActive(arg_7_0.pageTgs[iter_8_0 + 1]:Find("tip"), var_0_0.ShouldShowTip(iter_8_0 + 1))
					setActive(arg_7_0.pageTgs[iter_8_0 + 1]:Find("selected"), arg_7_0.contextData.indexInfo.pageIndex == iter_8_0 + 1)
				end

				if iter_7_0 == 1 then
					arg_7_0:ShowSitePage()
				elseif iter_7_0 == 2 then
					arg_7_0:ShowCharaPage()
				elseif iter_7_0 == 3 then
					arg_7_0:ShowEndingPage()
				elseif iter_7_0 == 4 then
					arg_7_0:ShowStoryPage()
				end
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.UpdateView(arg_9_0)
	triggerToggle(arg_9_0.pageTgs[arg_9_0.contextData.indexInfo.pageIndex], true)

	return
end

function var_0_0.SetClueGroup(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = var_0_2[arg_10_1]
	local var_10_1 = {
		var_0_1[var_0_1.get_id_list_by_group[arg_10_1][1]],
		var_0_1[var_0_1.get_id_list_by_group[arg_10_1][2]],
		var_0_1[var_0_1.get_id_list_by_group[arg_10_1][3]]
	}
	local var_10_2 = {}
	local var_10_3 = arg_10_0.taskProxy:getTaskVO(tonumber(({
		var_0_1[var_0_1.get_id_list_by_group[arg_10_1][1]],
		var_0_1[var_0_1.get_id_list_by_group[arg_10_1][2]],
		var_0_1[var_0_1.get_id_list_by_group[arg_10_1][3]]
	})[3].task_id)):getProgress()

	for iter_10_0 = 1, 3 do
		var_10_2[iter_10_0] = arg_10_0.taskProxy:getFinishTaskById(tonumber(var_10_1[iter_10_0].task_id))
	end

	setText(arg_10_2:Find("title/Text"), var_10_0.title)

	local var_10_4 = var_10_2[1] or var_10_2[2] or var_10_2[3]

	setActive(arg_10_2:Find("title/Text"), var_10_4)
	setActive(arg_10_2:Find("title/lock"), not var_10_2[1] and not var_10_2[2] and not var_10_2[3])
	LoadImageSpriteAsync("cluepictures/" .. var_10_0.pic, arg_10_2:Find("picture"), false)
	setActive(arg_10_2:Find("picture/lock"), not var_10_2[1] and not var_10_2[2] and not var_10_2[3])

	for iter_10_1 = 1, 3 do
		local var_10_5

		if var_10_2[iter_10_1] then
			setText(arg_10_2:Find("clue" .. iter_10_1), var_10_1[iter_10_1].desc)
		elseif arg_10_0.investigatingGroupId == arg_10_1 then
			setText(arg_10_2:Find("clue" .. iter_10_1), "<color=#858593>" .. var_10_1[iter_10_1].unlock_desc .. var_10_1[iter_10_1].unlock_num .. i18n("clue_task_tip", var_10_3) .. "</color>")
		elseif not false then
			var_10_5 = true

			setText(arg_10_2:Find("clue" .. iter_10_1), "<color=#858593>" .. var_10_1[iter_10_1].unlock_desc .. var_10_1[iter_10_1].unlock_num .. i18n("clue_task_tip", var_10_3) .. "</color>")
		else
			setText(arg_10_2:Find("clue" .. iter_10_1), "<color=#858593>？？？</color>")
		end
	end

	setActive(arg_10_2:Find("goBtn"), not var_10_2[1] or not var_10_2[2] or not var_10_2[3])
	setActive(arg_10_2:Find("goBtn/selected"), arg_10_0.investigatingGroupId == arg_10_1)
	onButton(arg_10_0, arg_10_2:Find("goBtn"), function()
		arg_10_0.investigatingGroupId = arg_10_1

		PlayerPrefs.SetInt("investigatingGroupId_" .. arg_10_0.activityId .. "_" .. arg_10_0.playerId, arg_10_1)
		setActive(arg_10_2:Find("goBtn/selected"), true)

		if arg_10_0.contextData.indexInfo.pageIndex == 1 then
			arg_10_0:ShowSitePage()
		elseif arg_10_0.contextData.indexInfo.pageIndex == 2 then
			arg_10_0:ShowCharaPage()
		end

		arg_10_0:OpenChapter(arg_10_1)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetAward(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.taskProxy:getTaskVO(arg_12_1)
	local var_12_1 = var_12_0:getConfig("award_display")[1]

	updateDrop(arg_12_0.award:Find("mask/IconTpl"), {
		type = var_12_1[1],
		id = var_12_1[2],
		count = var_12_1[3]
	})
	onButton(arg_12_0, arg_12_0.award:Find("mask"), function()
		arg_12_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_12_2 = var_12_0:getTaskStatus()

	setText(arg_12_0.award:Find("Text"), var_12_0:getConfig("desc"))
	setActive(arg_12_0.award:Find("mask/IconTpl/mask"), var_12_2 == 2)
	setActive(arg_12_0.award:Find("doing"), var_12_2 == 0)
	setActive(arg_12_0.award:Find("get"), var_12_2 == 1)
	setActive(arg_12_0.award:Find("got"), var_12_2 == 2)

	if arg_12_2 then
		onButton(arg_12_0, arg_12_0.award:Find("get"), function()
			arg_12_0:emit(ClueBookMediator.ON_TASK_SUBMIT_ONESTEP, arg_12_0.taskActivityId, {
				arg_12_1
			}, function(arg_15_0)
				if arg_15_0 then
					arg_12_2()
				end

				return
			end)

			return
		end, SFX_PANEL)
	else
		onButton(arg_12_0, arg_12_0.award:Find("get"), function()
			local var_16_0 = var_12_0:getConfig("award_display")
			local var_16_1 = getProxy(PlayerProxy):getRawData()
			local var_16_2 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
			local var_16_3, var_16_4 = Task.StaticJudgeOverflow(var_16_1.gold, var_16_1.oil, var_16_2, true, true, var_16_0)

			if var_16_3 then
				table.insert({}, function(arg_17_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_ITEM_BOX,
						content = i18n("award_max_warning"),
						items = var_16_4,
						onYes = arg_17_0
					})

					return
				end)
			end

			seriesAsync({}, function()
				arg_12_0:emit(ClueBookMediator.ON_TASK_SUBMIT_ONESTEP, arg_12_0.taskActivityId, {
					arg_12_1
				})

				return
			end)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.ShowSitePage(arg_19_0)
	local var_19_0 = UIItemList.New(arg_19_0.sitePage:Find("left/Viewport/Content"), arg_19_0.sitePage:Find("left/Viewport/Content/pageTg"))

	var_19_0:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventUpdate then
			local var_20_0 = arg_19_0.taskProxy:getTaskVO((tonumber(var_0_2[arg_19_0.clueSite[arg_20_1 + 1][1]].task_id))):getTaskStatus()

			setText(arg_20_2:Find("Text"), "PAGE  " .. string.format("%02d", arg_20_1 + 1))
			setText(arg_20_2:Find("selected/Text"), "PAGE  " .. string.format("%02d", arg_20_1 + 1))
			setActive(arg_20_2:Find("Text"), arg_19_0.contextData.indexInfo.subPageSiteIndex ~= arg_20_1 + 1)
			setActive(arg_20_2:Find("selected"), arg_19_0.contextData.indexInfo.subPageSiteIndex == arg_20_1 + 1)
			setActive(arg_20_2:Find("completed"), var_20_0 == 2)
			setActive(arg_20_2:Find("tip"), var_20_0 == 1)
			onToggle(arg_19_0, arg_20_2, function(arg_21_0)
				if arg_21_0 then
					arg_19_0.contextData.indexInfo.subPageSiteIndex = arg_20_1 + 1

					for iter_21_0 = 1, #arg_19_0.clueSite do
						local var_21_0 = arg_19_0.sitePage:Find("left/Viewport/Content"):GetChild(iter_21_0 - 1)

						setActive(var_21_0:Find("Text"), arg_19_0.contextData.indexInfo.subPageSiteIndex ~= iter_21_0)

						local var_21_1 = arg_19_0.sitePage:Find("left/Viewport/Content"):GetChild(iter_21_0 - 1)

						setActive(var_21_1:Find("selected"), arg_19_0.contextData.indexInfo.subPageSiteIndex == iter_21_0)
					end

					for iter_21_1 = 1, 3 do
						arg_19_0:SetClueGroup(var_0[iter_21_1], arg_19_0.sitePage:Find("right/Viewport/Content/siteGroup" .. iter_21_1))
					end

					arg_19_0:SetAward(var_0)
				end

				return
			end, SFX_PANEL)

			if arg_19_0.contextData.indexInfo.subPageSiteIndex == arg_20_1 + 1 then
				triggerToggle(arg_20_2, true)
			end
		end

		return
	end)
	var_19_0:align(#arg_19_0.clueSite)

	return
end

function var_0_0.ShowCharaPage(arg_22_0)
	local var_22_0 = UIItemList.New(arg_22_0.charaPage:Find("left/Viewport/Content"), arg_22_0.charaPage:Find("left/Viewport/Content/pageTg"))

	var_22_0:make(function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 == UIItemList.EventUpdate then
			local var_23_0 = arg_22_0.clueChara[arg_23_1 + 1][1]
			local var_23_1 = arg_22_0.taskProxy:getTaskVO((tonumber(var_0_2[arg_22_0.clueChara[arg_23_1 + 1][1]].task_id))):getTaskStatus()

			if arg_22_0:GetGroupClueCompleteCount(arg_22_0.clueChara[arg_23_1 + 1][1]) == 0 then
				setText(arg_23_2:Find("Text"), "？？？")
				setText(arg_23_2:Find("selected/Text"), "？？？")
			else
				setText(arg_23_2:Find("Text"), var_0_2[arg_22_0.clueChara[arg_23_1 + 1][1]].title)
				setText(arg_23_2:Find("selected/Text"), var_0_2[arg_22_0.clueChara[arg_23_1 + 1][1]].title)
			end

			setActive(arg_23_2:Find("Text"), arg_22_0.contextData.indexInfo.subPageCharaIndex ~= arg_23_1 + 1)
			setActive(arg_23_2:Find("selected"), arg_22_0.contextData.indexInfo.subPageCharaIndex == arg_23_1 + 1)
			setActive(arg_23_2:Find("Text/completed"), var_23_1 == 2)
			setActive(arg_23_2:Find("selected/Text/completed"), var_23_1 == 2)
			setActive(arg_23_2:Find("tip"), var_23_1 == 1)
			onToggle(arg_22_0, arg_23_2, function(arg_24_0)
				if arg_24_0 then
					arg_22_0.contextData.indexInfo.subPageCharaIndex = arg_23_1 + 1

					for iter_24_0 = 1, #arg_22_0.clueChara do
						local var_24_0 = arg_22_0.charaPage:Find("left/Viewport/Content"):GetChild(iter_24_0 - 1)

						setActive(var_24_0:Find("Text"), arg_22_0.contextData.indexInfo.subPageCharaIndex ~= iter_24_0)

						local var_24_1 = arg_22_0.charaPage:Find("left/Viewport/Content"):GetChild(iter_24_0 - 1)

						setActive(var_24_1:Find("selected"), arg_22_0.contextData.indexInfo.subPageCharaIndex == iter_24_0)
					end

					arg_22_0:SetClueGroup(var_23_0, arg_22_0.charaPage:Find("right"))
					arg_22_0:SetAward(var_0)
				end

				return
			end, SFX_PANEL)

			if arg_22_0.contextData.indexInfo.subPageCharaIndex == arg_23_1 + 1 then
				triggerToggle(arg_23_2, true)
			end
		end

		return
	end)
	var_22_0:align(#arg_22_0.clueChara)
	onScroll(arg_22_0, arg_22_0.charaPage:Find("left"), function(arg_25_0)
		setActive(arg_22_0.charaPage:Find("triangle"), arg_25_0.y > 0.01)

		return
	end)

	return
end

function var_0_0.GetGroupClueCompleteCount(arg_26_0, arg_26_1)
	local var_26_0 = 0

	for iter_26_0 = 1, 3 do
		if arg_26_0.taskProxy:getFinishTaskById(tonumber(({
			var_0_1[var_0_1.get_id_list_by_group[arg_26_1][1]],
			var_0_1[var_0_1.get_id_list_by_group[arg_26_1][2]],
			var_0_1[var_0_1.get_id_list_by_group[arg_26_1][3]]
		})[iter_26_0].task_id)) then
			var_26_0 = var_26_0 + 1
		end
	end

	return var_26_0
end

function var_0_0.ShowEndingPage(arg_27_0)
	local var_27_0 = UIItemList.New(arg_27_0.endingPage:Find("left/Viewport/Content"), arg_27_0.endingPage:Find("left/Viewport/Content/pageTg"))

	var_27_0:make(function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 == UIItemList.EventUpdate then
			local var_28_0 = arg_27_0.clueEnding[arg_28_1 + 1][1]
			local var_28_1 = arg_27_0.taskProxy:getTaskVO(arg_27_0.clueEnding[arg_28_1 + 1][2]):getTaskStatus()

			setText(arg_28_2:Find("Text"), var_0_3[arg_27_0.clueEnding[arg_28_1 + 1][1][#arg_27_0.clueEnding[arg_28_1 + 1][1]]].title2)
			setText(arg_28_2:Find("selected/Text"), var_0_3[var_28_0[#var_28_0]].title2)
			setActive(arg_28_2:Find("Text"), arg_27_0.contextData.indexInfo.subPageEndingIndex ~= arg_28_1 + 1)
			setActive(arg_28_2:Find("selected"), arg_27_0.contextData.indexInfo.subPageEndingIndex == arg_28_1 + 1)
			setActive(arg_28_2:Find("Text/completed"), var_28_1 == 2)
			setActive(arg_28_2:Find("selected/Text/completed"), var_28_1 == 2)

			local var_28_2 = false

			if var_28_1 == 1 then
				var_28_2 = true
			else
				local var_28_3 = true

				for iter_28_0 = 1, #var_28_0 do
					local var_28_4 = arg_27_0.taskProxy:getTaskVO(tonumber(var_0_3[var_28_0[iter_28_0]].task_id)):getTaskStatus()

					if var_28_4 == 1 and var_28_3 then
						var_28_2 = true
					end

					if var_28_4 ~= 2 then
						var_28_3 = false
					end
				end
			end

			setActive(arg_28_2:Find("tip"), var_28_2)
			onToggle(arg_27_0, arg_28_2, function(arg_29_0)
				if arg_29_0 then
					arg_27_0.contextData.indexInfo.subPageEndingIndex = arg_28_1 + 1

					for iter_29_0 = 1, #arg_27_0.clueEnding do
						local var_29_0 = arg_27_0.endingPage:Find("left/Viewport/Content"):GetChild(iter_29_0 - 1)

						setActive(var_29_0:Find("Text"), arg_27_0.contextData.indexInfo.subPageEndingIndex ~= iter_29_0)

						local var_29_1 = arg_27_0.endingPage:Find("left/Viewport/Content"):GetChild(iter_29_0 - 1)

						setActive(var_29_1:Find("selected"), arg_27_0.contextData.indexInfo.subPageEndingIndex == iter_29_0)
					end

					table.sort(var_28_0, function(arg_30_0, arg_30_1)
						return var_0_3[arg_30_0].unlock_pre < var_0_3[arg_30_1].unlock_pre
					end)

					local var_29_2 = true

					for iter_29_1 = 1, #var_28_0 do
						local var_29_3 = var_0_3[var_28_0[iter_29_1]]
						local var_29_4 = arg_27_0.taskProxy:getTaskVO(tonumber(var_0_3[var_28_0[iter_29_1]].task_id)):getTaskStatus()

						setActive(arg_27_0.endingPage:Find("right/ending" .. iter_29_1 .. "/icon"), var_29_2)
						setActive(arg_27_0.endingPage:Find("right/ending" .. iter_29_1 .. "/selected"), arg_27_0.endingIndex == iter_29_1)
						setActive(arg_27_0.endingPage:Find("right/ending" .. iter_29_1 .. "/lock"), not var_29_2)
						setActive(arg_27_0.endingPage:Find("right/ending" .. iter_29_1 .. "/tip"), var_29_4 == 1 and var_29_2)

						local var_29_5 = arg_27_0.endingPage:Find("right/ending" .. iter_29_1)

						var_29_5:GetComponent(typeof(CanvasGroup)).alpha = var_29_2 and 1 or 0.8

						if var_29_2 then
							setText(arg_27_0.endingPage:Find("right/ending" .. iter_29_1 .. "/title"), var_29_3.title)
							onToggle(arg_27_0, arg_27_0.endingPage:Find("right/ending" .. iter_29_1), function(arg_31_0)
								if arg_31_0 then
									arg_27_0.endingIndex = iter_29_1

									for iter_31_0 = 1, #var_28_0 do
										setActive(arg_27_0.endingPage:Find("right/ending" .. iter_31_0 .. "/selected"), iter_31_0 == arg_27_0.endingIndex)
									end

									local var_31_0 = var_29_3.clue
									local var_31_1 = var_29_3.locate

									setText(arg_27_0.endingPage:Find("middle/titleBg/Text"), var_29_3.title2)
									setText(arg_27_0.endingPage:Find("middle/endingDetail/Viewport/Content/detail"), var_29_3.desc)
									onScroll(arg_27_0, arg_27_0.endingPage:Find("middle/endingDetail"), function(arg_32_0)
										setActive(arg_27_0.endingPage:Find("middle/triangle"), arg_32_0.y > 0.01)

										return
									end)
									setActive(arg_27_0.endingPage:Find("right/combine"), var_29_4 == 1)
									onButton(arg_27_0, arg_27_0.endingPage:Find("right/combine"), function()
										arg_27_0:emit(ClueBookMediator.ON_TASK_SUBMIT_ONESTEP, arg_27_0.taskActivityId, {
											tonumber(var_29_3.task_id)
										})

										return
									end, SFX_PANEL)
									setActive(arg_27_0.endingPage:Find("middle/cluePanel"), var_29_4 ~= 2)

									if var_29_4 ~= 2 then
										local var_31_2 = UIItemList.New(arg_27_0.endingPage:Find("middle/cluePanel"), arg_27_0.endingPage:Find("middle/cluePanel/clueGroup"))

										var_31_2:make(function(arg_34_0, arg_34_1, arg_34_2)
											if arg_34_0 == UIItemList.EventUpdate then
												local var_34_0 = var_31_0[arg_34_1 + 1]
												local var_34_1 = var_31_1[arg_34_1 + 1][1]
												local var_34_2 = var_31_1[arg_34_1 + 1][2]
												local var_34_3 = var_31_1[arg_34_1 + 1][3]

												if var_29_3.type == 1 then
													local var_34_4 = var_0_2[var_31_0[arg_34_1 + 1]]

													for iter_34_0 = 1, 4 do
														setActive(arg_34_2:Find("" .. iter_34_0), var_34_1 == iter_34_0)
													end

													setActive(arg_34_2:Find("ending"), false)

													local var_34_5 = arg_34_2:GetChild(var_34_1 - 1)
													local var_34_6 = arg_27_0:GetGroupClueCompleteCount(var_31_0[arg_34_1 + 1])

													var_34_5:GetComponent(typeof(CanvasGroup)).alpha = var_34_6 == 0 and 0.4 or 1

													if var_34_6 == 0 then
														setText(var_34_5:Find("name/Text"), "？？？")
													else
														setText(var_34_5:Find("name/Text"), var_34_4.title)
													end

													setText(var_34_5:Find("progress"), var_34_6 .. "/3")
													setActive(var_34_5:Find("progress"), var_34_6 == 1 or var_34_6 == 2)
													setActive(var_34_5:Find("complete"), var_34_6 == 3)
													onButton(arg_27_0, arg_34_2, function()
														arg_27_0:emit(ClueBookMediator.OPEN_SINGLE_CLUE_GROUP, var_34_0)

														return
													end, SFX_PANEL)
												else
													setText(arg_34_2:Find("ending/name"), var_0_3[var_31_0[arg_34_1 + 1]].title2)

													for iter_34_1 = 1, 4 do
														setActive(arg_34_2:Find("" .. iter_34_1), false)
													end

													setActive(arg_34_2:Find("ending"), true)

													for iter_34_2 = 1, 3 do
														setActive(arg_34_2:Find("ending/icon" .. iter_34_2), arg_34_1 + 1 == iter_34_2)
													end

													onButton(arg_27_0, arg_34_2, function()
														triggerToggle(arg_27_0.endingPage:Find("right/ending" .. arg_34_1 + 1), true)

														return
													end, SFX_PANEL)
												end

												arg_34_2.anchoredPosition = Vector2(var_34_2[1], var_34_2[2])
												arg_34_2.localScale = Vector3(var_34_3, var_34_3, 1)
											end

											return
										end)
										var_31_2:align(#var_31_0)
									end
								end

								return
							end, SFX_PANEL)
						else
							local var_29_6 = "64646a"

							if iter_29_1 == #var_28_0 then
								var_29_6 = "6683cf"
							end

							setText(arg_27_0.endingPage:Find("right/ending" .. iter_29_1 .. "/title"), "<color=#" .. var_29_6 .. ">" .. var_29_3.title .. "</color>")
							removeOnToggle(arg_27_0.endingPage:Find("right/ending" .. iter_29_1))
						end

						if var_29_4 ~= 2 then
							var_29_2 = false
						end
					end

					triggerToggle(arg_27_0.endingPage:Find("right/ending" .. arg_27_0.endingIndex), true)
					arg_27_0:SetAward(var_0)
				end

				return
			end, SFX_PANEL)

			if arg_27_0.contextData.indexInfo.subPageEndingIndex == arg_28_1 + 1 then
				triggerToggle(arg_28_2, true)
			end
		end

		return
	end)
	var_27_0:align(#arg_27_0.clueEnding)

	return
end

function var_0_0.ShowStoryPage(arg_37_0)
	(function()
		setText(arg_37_0.storyPage:Find("pageIndex/Text"), arg_37_0.storyIndex .. "/2")
		setActive(arg_37_0.storyPage:Find("leftBtn"), arg_37_0.storyIndex == 2)
		setActive(arg_37_0.storyPage:Find("rightBtn"), arg_37_0.storyIndex == 1)
		setActive(arg_37_0.storyPage:Find("subPages/page1"), arg_37_0.storyIndex == 1)
		setActive(arg_37_0.storyPage:Find("subPages/page2"), arg_37_0.storyIndex == 2)

		return
	end)()
	onButton(arg_37_0, arg_37_0.storyPage:Find("leftBtn"), function()
		arg_37_0.storyIndex = 1

		var_0()

		return
	end, SFX_PANEL)
	onButton(arg_37_0, arg_37_0.storyPage:Find("rightBtn"), function()
		arg_37_0.storyIndex = 2

		var_0()

		return
	end, SFX_PANEL)

	for iter_37_0 = 1, #arg_37_0.story do
		local var_37_0
		local var_37_1

		if iter_37_0 <= 5 then
			var_37_0 = arg_37_0.storyPage:Find("subPages/page1"):GetChild(iter_37_0 - 1)
		else
			var_37_0 = arg_37_0.storyPage:Find("subPages/page2"):GetChild(iter_37_0 - 6)
			var_37_1 = arg_37_0.story[iter_37_0][3]
		end

		local var_37_2 = arg_37_0.story[iter_37_0][4]
		local var_37_3 = arg_37_0.taskProxy:getTaskVO(arg_37_0.story[iter_37_0][3]):getTaskStatus()

		if arg_37_0.story[iter_37_0][1] == 1 then
			setText(var_37_0:Find("lock/Text"), i18n("clue_lock_tip1"))
		else
			setText(var_37_0:Find("lock/Text"), i18n("clue_lock_tip2", var_0_3[arg_37_0.story[iter_37_0][2]].title))
		end

		setActive(var_37_0:Find("lock"), var_37_3 == 0)
		setActive(var_37_0:Find("canGet"), var_37_3 == 1)

		var_37_0:GetComponent(typeof(CanvasGroup)).alpha = var_37_3 == 0 and 0.4 or 1

		if var_37_3 == 1 then
			onButton(arg_37_0, var_37_0, function()
				arg_37_0:emit(ClueBookMediator.ON_TASK_SUBMIT_ONESTEP, arg_37_0.taskActivityId, {
					var_37_1
				}, function(arg_42_0)
					if arg_42_0 then
						pg.NewStoryMgr.GetInstance():Play(var_37_2)
					end

					return
				end)

				return
			end, SFX_PANEL)
		elseif var_37_3 == 2 then
			onButton(arg_37_0, var_37_0, function()
				pg.NewStoryMgr.GetInstance():Play(var_37_2, nil, true)

				return
			end, SFX_PANEL)
		else
			removeOnButton(var_37_0)
		end
	end

	arg_37_0:SetAward(arg_37_0.storyTaskId, function()
		pg.NewStoryMgr.GetInstance():Play(arg_37_0.afterStory)

		return
	end)

	return
end

function var_0_0.OpenChapter(arg_45_0, arg_45_1)
	arg_45_0:emit(ClueBookMediator.OPEN_CLUE_JUMP, arg_45_1)

	return
end

function var_0_0.willExit(arg_46_0)
	return
end

function var_0_0.onBackPressed(arg_47_0)
	arg_47_0:StopBgm()
	arg_47_0:closeView()

	return
end

function var_0_0.ShouldShowTip(arg_48_0)
	local var_48_9000
	local var_48_0 = getProxy(ActivityProxy)
	local var_48_1 = getProxy(TaskProxy)
	local var_48_2 = var_48_0.getActivityById(var_48_9000, ActivityConst.Valleyhospital_ACT_ID):getConfig("config_client")
	local var_48_3 = var_48_2.clue_chara
	local var_48_4 = var_48_2.clue_ending
	local var_48_5 = var_48_2.story
	local var_48_6 = var_48_2.storyTaskId

	if not arg_48_0 or arg_48_0 == 1 then
		for iter_48_0 = 1, #var_48_0.clue_site do
			local var_48_7 = var_48_1:getTaskVO((tonumber(var_0_2[var_48_0.clue_site[iter_48_0][1]].task_id)))

			if var_48_7:getTaskStatus() == 1 then
				return true
			end
		end
	end

	if not arg_48_0 or arg_48_0 == 2 then
		for iter_48_1 = 1, #var_48_3 do
			local var_48_8 = var_48_1:getTaskVO((tonumber(var_0_2[var_48_3[iter_48_1][1]].task_id)))

			if var_48_8:getTaskStatus() == 1 then
				return true
			end
		end
	end

	if not arg_48_0 or arg_48_0 == 3 then
		for iter_48_2 = 1, #var_48_4 do
			local var_48_9 = var_48_1:getTaskVO(var_48_4[iter_48_2][2])

			if var_48_9:getTaskStatus() == 1 then
				return true
			end

			local var_48_10 = true

			for iter_48_3 = 1, #var_48_4[iter_48_2][1] do
				local var_48_11 = var_48_1:getTaskVO(tonumber(var_0_3[var_48_4[iter_48_2][1][iter_48_3]].task_id)):getTaskStatus()

				if var_48_11 == 1 and var_48_10 then
					return true
				end

				if var_48_11 ~= 2 then
					var_48_10 = false
				end
			end
		end
	end

	if not arg_48_0 or arg_48_0 == 4 then
		local var_48_12 = var_48_1:getTaskVO(var_48_6)

		if var_48_12:getTaskStatus() == 1 then
			return true
		end

		for iter_48_4 = 1, #var_48_5 do
			local var_48_13 = var_48_1:getTaskVO(var_48_5[iter_48_4][3])

			if var_48_13:getTaskStatus() == 1 then
				return true
			end
		end
	end

	return false
end

return var_0_0
