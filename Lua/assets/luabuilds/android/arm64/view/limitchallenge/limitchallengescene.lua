local var_0_0 = class("LimitChallengeScene", import("..base.BaseUI"))
local var_0_1 = LimitChallengeConst

function var_0_0.getUIName(arg_1_0)
	return "LimitChallengeUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	var_0_1.SetRedPointMonth()
	arg_3_0:updateLeftTime()
	arg_3_0:updateToggleList()
	arg_3_0:trigeHigestUnlockLevel()

	return
end

function var_0_0.onBackPressed(arg_4_0)
	arg_4_0:closeView()

	return
end

function var_0_0.willExit(arg_5_0)
	if arg_5_0.leftTimer then
		arg_5_0.leftTimer:Stop()

		arg_5_0.leftTimer = nil
	end

	return
end

function var_0_0.initData(arg_6_0)
	arg_6_0.proxy = getProxy(LimitChallengeProxy)
	arg_6_0.levelList = {
		1,
		2,
		3
	}
	arg_6_0.curMonth = var_0_1.GetCurMonth()
	arg_6_0.descList = {}
	arg_6_0.nextMonthTS = LimitChallengeConst.GetNextMonthTS()
	arg_6_0.curLevel = 0

	return
end

function var_0_0.findUI(arg_7_0)
	arg_7_0.blurPanel = arg_7_0._tf:Find("blur_panel")
	arg_7_0.homeBtn = arg_7_0.blurPanel:Find("adapt/top/option")
	arg_7_0.backBtn = arg_7_0.blurPanel:Find("adapt/top/back_button")
	arg_7_0.helpBtn = arg_7_0.blurPanel:Find("adapt/top/HelpBtn")
	arg_7_0.shareBtn = arg_7_0.blurPanel:Find("adapt/top/ShareBtn")
	arg_7_0.levelPanel = arg_7_0._tf:Find("Adapt/LevelPanel")
	arg_7_0.levelToggleList = {}
	arg_7_0.levelToggleLockList = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.levelList) do
		local var_7_0 = arg_7_0.levelPanel:Find("Level_" .. iter_7_1)
		local var_7_1 = var_7_0:Find("Lock")

		arg_7_0.levelToggleList[iter_7_1] = var_7_0:Find("Toggle")
		arg_7_0.levelToggleLockList[iter_7_1] = var_7_1
	end

	arg_7_0.timePanel = arg_7_0._tf:Find("Adapt/TimePanel")

	local var_7_2 = arg_7_0.timePanel:Find("Left/LeftTime")

	arg_7_0.leftTipText = var_7_2:Find("LeftTip")
	arg_7_0.leftDayTipText = var_7_2:Find("DayTip")
	arg_7_0.leftDayValueText = var_7_2:Find("DayValue")
	arg_7_0.leftTimeValueText = var_7_2:Find("TimeValue")
	arg_7_0.passTimeValueText = arg_7_0.timePanel:Find("Challenge/Value")

	setText(arg_7_0.leftTipText, i18n("time_remaining_tip"))
	setText(arg_7_0.leftDayTipText, i18n("word_date"))

	arg_7_0.iconContainer = arg_7_0._tf:Find("Adapt/DescPanel/ScrollView/Viewport/Container")
	arg_7_0.iconTpl = arg_7_0._tf:Find("Adapt/DescPanel/IconTpl")

	local var_7_3 = arg_7_0._tf:Find("Adapt/Award")

	arg_7_0.awardIconTF = var_7_3:Find("IconTpl")
	arg_7_0.awardGotTF = var_7_3:Find("Got")
	arg_7_0.startBtn = arg_7_0._tf:Find("Adapt/StartBtn")
	arg_7_0.bgImg = arg_7_0._tf:Find("BG")
	arg_7_0.nameImg = arg_7_0.timePanel:Find("Left")
	arg_7_0.debugPanel = arg_7_0._tf:Find("Adapt/Debug")
	arg_7_0.debugText = arg_7_0.debugPanel:Find("Text")

	return
end

function var_0_0.addListener(arg_8_0)
	onButton(arg_8_0, arg_8_0.homeBtn, function()
		arg_8_0:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	print("-----------", tostring(arg_8_0.backBtn))
	onButton(arg_8_0, arg_8_0.backBtn, function()
		arg_8_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.challenge_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.shareBtn, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeChallenge)

		return
	end, SFX_PANEL)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.levelToggleList) do
		onToggle(arg_8_0, iter_8_1, function()
			arg_8_0.curLevel = iter_8_0

			arg_8_0:updatePassTime()
			arg_8_0:updateAward()
			arg_8_0:updateDescPanel()
			arg_8_0:updateBossImg()
			arg_8_0:updateDebug()

			return
		end, SFX_CONFIRM, SFX_CANCEL)
	end

	onButton(arg_8_0, arg_8_0.startBtn, function()
		arg_8_0:emit(var_0_1.OPEN_PRE_COMBAT_LAYER, {
			stageID = var_0_1.GetStageIDByLevel(arg_8_0.curLevel)
		})

		return
	end, SFX_PANEL)

	arg_8_0.iconUIItemList = UIItemList.New(arg_8_0.iconContainer, arg_8_0.iconTpl)

	arg_8_0.iconUIItemList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			local var_15_0 = arg_15_2:Find("Icon")

			arg_15_1 = arg_15_1 + 1

			if arg_8_0.descList[arg_15_1] ~= false then
				local var_15_1, var_15_2 = arg_8_0:getBuffIconPath(var_0_1.GetChallengeIDByLevel(arg_8_0.curLevel), arg_15_1)

				setImageSprite(var_15_0, LoadSprite(var_15_1, var_15_2))

				local var_15_3 = arg_8_0.descList[arg_15_1][2]

				table.insert({}, {
					info = arg_8_0.descList[arg_15_1][1]
				})
				table.insert({}, {
					info = arg_8_0.descList[arg_15_1][2]
				})
				onButton(arg_8_0, var_15_0, function()
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						hideNo = true,
						type = MSGBOX_TYPE_DROP_ITEM,
						name = var_0,
						content = var_15_3,
						iconPath = {
							var_15_1,
							var_15_2
						}
					})

					return
				end, SFX_PANEL)
			end
		end

		return
	end)

	return
end

function var_0_0.updateDebug(arg_17_0)
	local var_17_0 = string.format(" 月份: %s \n 选择难度: %s \n 选择挑战ID: %s \n 选择关卡ID: %s \n", tostring(arg_17_0.curMonth), tostring(arg_17_0.curLevel), tostring((var_0_1.GetChallengeIDByLevel(arg_17_0.curLevel))), tostring((var_0_1.GetStageIDByLevel(arg_17_0.curLevel))))

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.levelList) do
		var_17_0 = var_17_0 .. " 难度" .. iter_17_1 .. "奖励:" .. (arg_17_0.proxy:isAwardedByChallengeID((LimitChallengeConst.GetChallengeIDByLevel(iter_17_1))) and "已领取" or "未领取") .. "\n"
	end

	for iter_17_2, iter_17_3 in ipairs(arg_17_0.levelList) do
		local var_17_1 = arg_17_0.proxy:getPassTimeByChallengeID((LimitChallengeConst.GetChallengeIDByLevel(iter_17_3)))

		var_17_0 = var_17_0 .. " 难度" .. iter_17_3 .. "时间:" .. (var_17_1 and var_17_1 or "没有记录") .. "\n"
	end

	setText(arg_17_0.debugText, var_17_0)

	return
end

function var_0_0.updateToggleList(arg_18_0)
	local var_18_0 = arg_18_0:getHigestUnlockLevel()

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.levelToggleLockList) do
		local var_18_1 = var_18_0 < iter_18_0

		setActive(iter_18_1, var_18_0 < iter_18_0)
		setActive(arg_18_0.levelToggleList[iter_18_0], not var_18_1)
	end

	return
end

function var_0_0.updateLeftTime(arg_19_0)
	if arg_19_0.leftTimer then
		arg_19_0.leftTimer:Stop()

		arg_19_0.leftTimer = nil
	end

	local var_19_0 = pg.TimeMgr.GetInstance()

	if arg_19_0.nextMonthTS - var_19_0:GetServerTime() > 0 then
		if arg_19_0.leftTimer then
			arg_19_0.leftTimer:Stop()

			arg_19_0.leftTimer = nil
		end

		arg_19_0.leftTimer = Timer.New(function()
			if var_0 <= 0 and arg_19_0.leftTimer then
				arg_19_0.leftTimer:Stop()

				arg_19_0.leftTimer = nil
			end

			local var_20_0, var_20_1, var_20_2, var_20_3 = pg.TimeMgr.GetInstance():parseTimeFrom(var_0)

			setText(arg_19_0.leftDayValueText, var_20_0)
			setText(arg_19_0.leftTimeValueText, string.format("%02d:%02d:%02d", var_20_1, var_20_2, var_20_3))

			var_0 = var_0 - 1

			return
		end, 1, -1)

		arg_19_0.leftTimer:Start()
		var_19_1()
	end

	return
end

function var_0_0.updateBossImg(arg_21_0)
	local var_21_0 = pg.expedition_constellation_challenge_template[var_0_1.GetChallengeIDByLevel(arg_21_0.curLevel)]

	setImageSprite(arg_21_0.bgImg, LoadSprite("limitchallenge/boss/" .. var_21_0.painting, var_21_0.painting))
	setImageSprite(arg_21_0.nameImg, LoadSprite("limitchallenge/name/" .. var_21_0.information_icon, var_21_0.information_icon), true)
	setImageSprite(arg_21_0.startBtn, LoadSprite("limitchallenge/btn/" .. var_21_0.button_style .. "_btn_start", var_21_0.button_style .. "_btn_start"), true)

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.levelList) do
		local var_21_1 = string.format("%d_level_%d_selected", var_21_0.button_style, iter_21_1)

		setImageSprite(arg_21_0.levelToggleList[iter_21_1]:Find("Selected"), LoadSprite("limitchallenge/btn/" .. var_21_1, var_21_1), true)
	end

	return
end

function var_0_0.updateDescPanel(arg_22_0)
	arg_22_0.descList = {}
	arg_22_0.descList = pg.expedition_constellation_challenge_template[var_0_1.GetChallengeIDByLevel(arg_22_0.curLevel)].description

	if 3 - #arg_22_0.descList > 0 then
		for iter_22_0 = 1, 3 - #arg_22_0.descList do
			table.insert(arg_22_0.descList, false)
		end
	end

	arg_22_0.iconUIItemList:align(#arg_22_0.descList)

	return
end

function var_0_0.updatePassTime(arg_23_0)
	local var_23_0 = arg_23_0.proxy:getPassTimeByChallengeID((LimitChallengeConst.GetChallengeIDByLevel(arg_23_0.curLevel))) or 0

	setText(arg_23_0.passTimeValueText, (string.format("%02d:%02d", math.floor(var_23_0 / 60), (math.floor(var_23_0 % 60)))))

	return
end

function var_0_0.updateAward(arg_24_0)
	local var_24_0 = LimitChallengeConst.GetChallengeIDByLevel(arg_24_0.curLevel)

	setActive(arg_24_0.awardGotTF, (arg_24_0.proxy:isAwardedByChallengeID(var_24_0)))

	if pg.expedition_constellation_challenge_template[var_24_0].award_display[1] and #pg.expedition_constellation_challenge_template[var_24_0].award_display[1] > 0 then
		local var_24_1 = {
			type = pg.expedition_constellation_challenge_template[var_24_0].award_display[1][1],
			id = pg.expedition_constellation_challenge_template[var_24_0].award_display[1][2]
		}

		;({
			type = pg.expedition_constellation_challenge_template[var_24_0].award_display[1][1],
			id = pg.expedition_constellation_challenge_template[var_24_0].award_display[1][2]
		}).count = pg.expedition_constellation_challenge_template[var_24_0].award_display[1][3] or 1

		updateDrop(arg_24_0.awardIconTF, {
			type = pg.expedition_constellation_challenge_template[var_24_0].award_display[1][1],
			id = pg.expedition_constellation_challenge_template[var_24_0].award_display[1][2]
		})
		onButton(arg_24_0, arg_24_0.awardIconTF, function()
			arg_24_0:emit(BaseUI.ON_DROP, var_24_1)

			return
		end, SFX_PANEL)
		setActive(arg_24_0.awardIconTF, true)
	else
		setActive(arg_24_0.awardIconTF, false)
	end

	return
end

function var_0_0.trigeHigestUnlockLevel(arg_26_0)
	triggerToggle(arg_26_0.levelToggleList[arg_26_0:getHigestUnlockLevel()], true)

	return
end

function var_0_0.onReqInfo(arg_27_0)
	arg_27_0:initData()
	arg_27_0:updateLeftTime()
	arg_27_0:updateToggleList()
	arg_27_0:trigeHigestUnlockLevel()

	return
end

function var_0_0.getHigestUnlockLevel(arg_28_0)
	for iter_28_0 = #arg_28_0.levelList, 1, -1 do
		if arg_28_0.proxy:isLevelUnlock(arg_28_0.levelList[iter_28_0]) then
			return arg_28_0.levelList[iter_28_0]
		end
	end

	return
end

function var_0_0.getBuffIconPath(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = string.format("%s_%d", pg.expedition_constellation_challenge_template[arg_29_1].painting, arg_29_2)

	return "limitchallenge/icon/" .. var_29_0, var_29_0
end

return var_0_0
