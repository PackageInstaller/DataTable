local var_0_0 = class("DOADailyStoryPage", import("view.activity.CorePage.CoreActivityPage"))
local var_0_1 = "event_icon"

function var_0_0.OnInit(arg_1_0)
	arg_1_0.AD = arg_1_0._tf:Find("AD")
	arg_1_0.Image = arg_1_0.AD:Find("Image")
	arg_1_0.pageLock = arg_1_0.Image:Find("lock")
	arg_1_0.lockTxt = arg_1_0.pageLock:Find("Text"):GetComponent("RichText")
	arg_1_0.playCombo = arg_1_0.AD:Find("playCombo")
	arg_1_0.playShow = arg_1_0.playCombo:Find("line_on")
	arg_1_0.playShowBtn = arg_1_0.playShow:Find("play")
	arg_1_0.playShowTxt = arg_1_0.playShow:Find("Text")
	arg_1_0.playClose = arg_1_0.playCombo:Find("line_off")
	arg_1_0.playCloseTxt1 = arg_1_0.playClose:Find("Text")
	arg_1_0.playCloseTxt2 = arg_1_0.playClose:Find("tip/rule")
	arg_1_0.award = arg_1_0.playCombo:Find("award")
	arg_1_0.gotAward = arg_1_0.award:Find("got")
	arg_1_0.lockAward = arg_1_0.award:Find("lock")
	arg_1_0.tabTitle = arg_1_0.AD:Find("tabTitle")
	arg_1_0.titleTxt1 = arg_1_0.tabTitle:Find("title")
	arg_1_0.titleTxt2 = arg_1_0.tabTitle:Find("normalTitle")
	arg_1_0.tabs = arg_1_0.AD:Find("tabs")
	arg_1_0.tabsListCount = arg_1_0.tabs.transform.childCount

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	arg_2_0.taskProxy = getProxy(TaskProxy)
	arg_2_0.config_data = arg_2_0.activity:getConfig("config_data")
	arg_2_0.config_client = arg_2_0.activity:getConfig("config_client").story

	arg_2_0:InitLocalText()
	arg_2_0:OnUpdateFlush()
	arg_2_0:OnShowFlush()

	return
end

function var_0_0.InitLocalText(arg_3_0)
	setText(arg_3_0.playCloseTxt2, i18n("doa3_activityPageUI_2"))
	setText(arg_3_0.playCloseTxt1, i18n("doa3_activityPageUI_3"))
	setText(arg_3_0.titleTxt2, i18n("doa3_activityPageUI_4"))
	setText(arg_3_0.playShowTxt, i18n("doa3_activityPageUI_5"))
	arg_3_0.lockTxt:AddSprite(var_0_1, (GetSpriteFromAtlas("ui/DOADailyStoryPage_atlas", "icon")))

	return
end

function var_0_0.OnShowFlush(arg_4_0)
	if arg_4_0.tabs and arg_4_0.config_data then
		triggerToggle(arg_4_0.tabs:Find("1"), true)
		arg_4_0:OnUpdata(1)
	end

	return
end

function var_0_0.OnUpdateFlush(arg_5_0)
	for iter_5_0 = 1, #arg_5_0.config_data do
		local var_5_1 = arg_5_0.taskProxy:getTaskVO(arg_5_0.config_data[iter_5_0]):getTaskStatus()

		arg_5_0:SetRedPoint(iter_5_0, var_5_1)

		if var_5_1 == 2 then
			local var_5_3 = pg.NewStoryMgr.GetInstance()

			if not var_5_3:IsPlayed(arg_5_0.config_client[iter_5_0][1]) then
				local var_5_4, var_5_5 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_5_0.config_client[iter_5_0][1])

				pg.m02:sendNotification(GAME.STORY_UPDATE_LIST, {
					storyIds = {
						var_5_4
					},
					callback = callback
				})
			end
		end
	end

	local var_5_6 = -1

	for iter_5_1 = 0, arg_5_0.tabsListCount - 1 do
		onToggle(arg_5_0, arg_5_0.tabs:GetChild(iter_5_1), function(arg_6_0)
			if arg_6_0 then
				if var_5_6 ~= iter_5_1 then
					arg_5_0:OnUpdata(iter_5_1 + 1)
				end

				var_5_6 = iter_5_1
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.SetRedPoint(arg_7_0, arg_7_1, arg_7_2)
	setActive(arg_7_0.AD:Find("tabs/" .. arg_7_1 .. "/red"), arg_7_2 == 1)

	return
end

function var_0_0.OnUpdata(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.taskProxy:getTaskVO(arg_8_0.config_data[arg_8_1])

	arg_8_0:UpdataAward(var_8_0)
	arg_8_0:UpdateUI(arg_8_1, var_8_0)
	arg_8_0:UpdataBtnInv(arg_8_1, var_8_0)

	return
end

function var_0_0.UpdataAward(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getConfig("award_display")[1]
	local var_9_1 = {
		type = var_9_0[1],
		id = var_9_0[2],
		count = var_9_0[3]
	}

	onButton(arg_9_0, arg_9_0.award, function()
		arg_9_0:emit(BaseUI.ON_DROP, var_9_1)

		return
	end, SFX_PANEL)
	updateDrop(arg_9_0.award, {
		type = var_9_0[1],
		id = var_9_0[2],
		count = var_9_0[3]
	})

	return
end

function var_0_0.UpdataBtnInv(arg_11_0, arg_11_1, arg_11_2)
	onButton(arg_11_0, arg_11_0.playShowBtn, function()
		pg.NewStoryMgr.GetInstance():Play(arg_11_0.config_client[arg_11_1][1], function()
			arg_11_0:emit(ActivityMediator.ON_TASK_SUBMIT, arg_11_2, function(arg_14_0)
				if arg_14_0 then
					arg_11_0:OnUpdata(arg_11_1)
				end

				return
			end)

			return
		end, true)

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.playClose, function()
		arg_11_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateUI(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2:getTaskStatus()
	local var_16_3 = arg_16_2:getProgress()
	local var_16_4 = arg_16_2:getConfig("target_num")

	setImageSprite(arg_16_0.Image, LoadSprite("ui/DOADailyStoryPage_atlas", "page_img" .. arg_16_1), true)
	setActive(arg_16_0.pageLock, var_16_0 == 0)

	arg_16_0.lockTxt.text = string.format("%s<icon name=%s /> %d/%d", i18n("doa3_activityPageUI_1"), var_0_1, var_16_3, var_16_4)

	setActive(arg_16_0.playShow, var_16_0 ~= 0)

	local var_16_5 = pg.NewStoryMgr.GetInstance():IsPlayed(arg_16_0.config_client[arg_16_1][1])

	setActive(arg_16_0.playShowBtn, var_16_0 == 1)
	setActive(arg_16_0.playClose, var_16_0 == 0)
	setText(arg_16_0.titleTxt1, "0" .. arg_16_1 .. arg_16_2:getConfig("name"))
	setActive(arg_16_0.gotAward, var_16_0 == 2 or var_16_5)
	setActive(arg_16_0.lockAward, var_16_0 == 0)

	return
end

return var_0_0
