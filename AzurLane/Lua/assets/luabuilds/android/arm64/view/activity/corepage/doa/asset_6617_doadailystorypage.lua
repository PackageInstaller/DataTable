class = var_0_10000

local var_0_0 = "DOADailyStoryPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))
local var_0_2 = "event_icon"

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.AD = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.AD

	arg_1_0.Image = var_1.Find(var_1_1, "Image")

	local var_1_2 = arg_1_0.Image

	arg_1_0.pageLock = var_1.Find(var_1_2, "lock")

	local var_1_3 = arg_1_0.pageLock
	local var_1_4 = var_1.Find(var_1_3, "Text")

	arg_1_0.lockTxt = var_1.GetComponent(var_1_4, "RichText")

	local var_1_5 = arg_1_0.AD

	arg_1_0.playCombo = var_1.Find(var_1_5, "playCombo")

	local var_1_6 = arg_1_0.playCombo

	arg_1_0.playShow = var_1.Find(var_1_6, "line_on")

	local var_1_7 = arg_1_0.playShow

	arg_1_0.playShowBtn = var_1.Find(var_1_7, "play")

	local var_1_8 = arg_1_0.playShow

	arg_1_0.playShowTxt = var_1.Find(var_1_8, "Text")

	local var_1_9 = arg_1_0.playCombo

	arg_1_0.playClose = var_1.Find(var_1_9, "line_off")

	local var_1_10 = arg_1_0.playClose

	arg_1_0.playCloseTxt1 = var_1.Find(var_1_10, "Text")

	local var_1_11 = arg_1_0.playClose

	arg_1_0.playCloseTxt2 = var_1.Find(var_1_11, "tip/rule")

	local var_1_12 = arg_1_0.playCombo

	arg_1_0.award = var_1.Find(var_1_12, "award")

	local var_1_13 = arg_1_0.award

	arg_1_0.gotAward = var_1.Find(var_1_13, "got")

	local var_1_14 = arg_1_0.award

	arg_1_0.lockAward = var_1.Find(var_1_14, "lock")

	local var_1_15 = arg_1_0.AD

	arg_1_0.tabTitle = var_1.Find(var_1_15, "tabTitle")

	local var_1_16 = arg_1_0.tabTitle

	arg_1_0.titleTxt1 = var_1.Find(var_1_16, "title")

	local var_1_17 = arg_1_0.tabTitle

	arg_1_0.titleTxt2 = var_1.Find(var_1_17, "normalTitle")

	local var_1_18 = arg_1_0.AD

	arg_1_0.tabs = var_1.Find(var_1_18, "tabs")
	arg_1_0.tabsListCount = arg_1_0.tabs.transform.childCount

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003
	arg_2_0.taskProxy = var_1_10001(var_1_10003)

	local var_2_0 = arg_2_0.activity

	arg_2_0.config_data = var_1.getConfig(var_2_0, "config_data")

	local var_2_1 = arg_2_0.activity

	arg_2_0.config_client = var_1.getConfig(var_2_1, "config_client").story

	arg_2_0:InitLocalText()
	arg_2_0:OnUpdateFlush()
	arg_2_0:OnShowFlush()

	return
end

function var_0_1.InitLocalText(arg_3_0)
	setText = var_1_10001

	local var_3_0 = arg_3_0.playCloseTxt2

	i18n = var_1_10004

	var_1_10001(var_3_0, var_1_10004("doa3_activityPageUI_2"))

	setText = var_1_10001

	local var_3_1 = arg_3_0.playCloseTxt1

	i18n = var_4

	var_1_10001(var_3_1, var_4("doa3_activityPageUI_3"))

	setText = var_1_10001

	local var_3_2 = arg_3_0.titleTxt2

	i18n = var_4

	var_1_10001(var_3_2, var_4("doa3_activityPageUI_4"))

	setText = var_1_10001

	local var_3_3 = arg_3_0.playShowTxt

	i18n = var_4

	var_1_10001(var_3_3, var_4("doa3_activityPageUI_5"))

	GetSpriteFromAtlas = var_1_10001

	local var_3_4 = var_1_10001("ui/DOADailyStoryPage_atlas", "icon")
	local var_3_5 = arg_3_0.lockTxt

	var_2.AddSprite(var_3_5, var_0_2, var_3_4)

	return
end

function var_0_1.OnShowFlush(arg_4_0)
	if arg_4_0.tabs and arg_4_0.config_data then
		triggerToggle = var_1

		local var_4_0 = arg_4_0.tabs

		var_1(var_3.Find(var_4_0, "1"), true)
		arg_4_0:OnUpdata(1)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	local var_5_0 = -1

	for iter_5_0 = 1, #arg_5_0.config_data do
		local var_5_1 = arg_5_0.taskProxy
		local var_5_2 = var_1_10006.getTaskVO(var_5_1, arg_5_0.config_data[iter_5_0])
		local var_5_3 = var_1_10006.getTaskStatus(var_5_2)

		arg_5_0:SetRedPoint(iter_5_0, var_5_3)

		local var_5_4 = iter_5_0

		if var_5_3 == 2 then
			pg = var_8

			local var_5_5 = var_8.NewStoryMgr.GetInstance()

			if not var_8.IsPlayed(var_5_5, arg_5_0.config_client[iter_5_0][1]) then
				pg = var_5_2

				local var_5_6 = var_5_2.NewStoryMgr.GetInstance()
				local var_5_7, var_5_8 = var_9.StoryName2StoryId(var_5_6, arg_5_0.config_client[iter_5_0][1])

				pg = var_5_6

				local var_5_9 = var_5_6.m02
				local var_5_10 = var_11.sendNotification

				GAME = var_1_10014
				var_1_10014 = var_1_10014.STORY_UPDATE_LIST

				local var_5_11 = {
					storyIds = {
						var_5_7
					}
				}

				callback = var_16
				var_5_11.callback = var_16

				var_5_10(var_5_9, var_1_10014, var_5_11)
			end
		end
	end

	local var_5_12 = -1

	for iter_5_1 = 0, arg_5_0.tabsListCount - 1 do
		onToggle = var_1_10006

		local var_5_13 = arg_5_0
		local var_5_14 = arg_5_0.tabs
		local var_5_15 = var_9.GetChild(var_5_14, iter_5_1)

		local function var_5_16(arg_6_0)
			if arg_6_0 then
				if var_5_12 ~= iter_5_1 then
					local var_6_0 = arg_5_0

					var_1.OnUpdata(var_6_0, iter_5_1 + 1)
				end

				var_5_12 = iter_5_1
			end

			return
		end

		SFX_PANEL = var_5_14

		var_1_10006(var_5_13, var_5_15, var_5_16, var_5_14)
	end

	return
end

function var_0_1.SetRedPoint(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.AD
	local var_7_1 = var_3.Find(var_7_0, "tabs/" .. arg_7_1 .. "/red")

	setActive = var_1_10004

	var_1_10004(var_7_1, arg_7_2 == 1)

	return
end

function var_0_1.OnUpdata(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.taskProxy
	local var_8_1 = var_2.getTaskVO(var_8_0, arg_8_0.config_data[arg_8_1])

	arg_8_0:UpdataAward(var_8_1)
	arg_8_0:UpdateUI(arg_8_1, var_8_1)
	arg_8_0:UpdataBtnInv(arg_8_1, var_8_1)

	return
end

function var_0_1.UpdataAward(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getConfig("award_display")[1]
	local var_9_1 = {
		type = var_9_0[1],
		id = var_9_0[2],
		count = var_9_0[3]
	}

	onButton = var_4

	local var_9_2 = arg_9_0
	local var_9_3 = arg_9_0.award

	local function var_9_4()
		local var_10_0 = arg_9_0
		local var_10_1 = var_0.emit

		BaseUI = var_2_10003

		var_10_1(var_10_0, var_2_10003.ON_DROP, var_9_1)

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_9_2, var_9_3, var_9_4, var_1_10009)

	updateDrop = var_4

	var_4(arg_9_0.award, var_9_1)

	return
end

function var_0_1.UpdataBtnInv(arg_11_0, arg_11_1, arg_11_2)
	onButton = var_1_10003

	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.playShowBtn

	local function var_11_2()
		pg = var_2_10000

		local var_12_0 = var_2_10000.NewStoryMgr.GetInstance()

		var_0.Play(var_12_0, arg_11_0.config_client[arg_11_1][1], function()
			local var_13_0 = arg_11_0
			local var_13_1 = var_0.emit

			ActivityMediator = var_3_10003

			var_13_1(var_13_0, var_3_10003.ON_TASK_SUBMIT, arg_11_2, function(arg_14_0)
				if arg_14_0 then
					local var_14_0 = arg_11_0

					var_1.OnUpdata(var_14_0, arg_11_1)
				end

				return
			end)

			return
		end, true)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_11_0, var_11_1, var_11_2, var_1_10008)

	onButton = var_1_10003

	local var_11_3 = arg_11_0
	local var_11_4 = arg_11_0.playClose

	local function var_11_5()
		local var_15_0 = arg_11_0
		local var_15_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_15_1(var_15_0, var_2_10003.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_11_3, var_11_4, var_11_5, var_1_10008)

	return
end

function var_0_1.UpdateUI(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2:getTaskStatus()
	local var_16_1 = 0
	local var_16_2 = 0
	local var_16_3 = arg_16_2:getProgress()
	local var_16_4 = arg_16_2:getConfig("target_num")

	setImageSprite = var_6

	local var_16_5 = arg_16_0.Image

	LoadSprite = var_9

	var_6(var_16_5, var_9("ui/DOADailyStoryPage_atlas", "page_img" .. arg_16_1), true)

	setActive = var_6

	var_6(arg_16_0.pageLock, var_16_0 == 0)

	local var_16_6 = arg_16_0.lockTxt

	string = var_1_10007

	local var_16_7 = var_1_10007.format
	local var_16_8 = "%s<icon name=%s /> %d/%d"

	i18n = var_10
	var_16_6.text = var_16_7(var_16_8, var_10("doa3_activityPageUI_1"), var_0_2, var_16_3, var_16_4)
	setActive = var_16_6

	var_16_6(arg_16_0.playShow, var_16_0 ~= 0)

	pg = var_16_6

	local var_16_9 = var_16_6.NewStoryMgr.GetInstance()
	local var_16_10 = var_6.IsPlayed(var_16_9, arg_16_0.config_client[arg_16_1][1])

	setActive = var_7

	var_7(arg_16_0.playShowBtn, var_16_0 == 1)

	setActive = var_7

	var_7(arg_16_0.playClose, var_16_0 == 0)

	setText = var_7

	var_7(arg_16_0.titleTxt1, "0" .. arg_16_1 .. arg_16_2:getConfig("name"))

	setActive = var_7

	var_7(arg_16_0.gotAward, var_16_0 == 2 or var_16_10)

	setActive = var_7

	var_7(arg_16_0.lockAward, var_16_0 == 0)

	return
end

return var_0_1
