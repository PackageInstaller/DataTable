local var_0_0 = class("MilitaryExerciseScene", import("..base.BaseUI"))

var_0_0.TYPE_SHOP = 1

function var_0_0.getUIName(arg_1_0)
	return "MilitaryExerciseUI"
end

function var_0_0.ResUISettings(arg_2_0)
	return true
end

function var_0_0.setShips(arg_3_0, arg_3_1)
	arg_3_0.ships = arg_3_1

	return
end

function var_0_0.setFleet(arg_4_0, arg_4_1)
	arg_4_0.fleet = arg_4_1

	return
end

function var_0_0.setRivals(arg_5_0, arg_5_1)
	table.sort(arg_5_1, function(arg_6_0, arg_6_1)
		return arg_6_0.rank < arg_6_1.rank
	end)

	arg_5_0.rivalVOs = arg_5_1

	return
end

function var_0_0.setExerciseCount(arg_7_0, arg_7_1)
	arg_7_0.exerciseCount = arg_7_1

	return
end

function var_0_0.setSeasonTime(arg_8_0, arg_8_1)
	arg_8_0.seasonTime = arg_8_1

	return
end

function var_0_0.setRecoverTime(arg_9_0, arg_9_1)
	arg_9_0.recoverTime = arg_9_1

	return
end

function var_0_0.setActivity(arg_10_0, arg_10_1)
	arg_10_0.activity = arg_10_1

	arg_10_0:setSeasonTime(arg_10_1.stopTime)

	return
end

function var_0_0.updateSeaInfoVO(arg_11_0, arg_11_1)
	arg_11_0.seasonInfo = arg_11_1

	arg_11_0:setFleet(arg_11_1.fleet)
	arg_11_0:setRivals(arg_11_1.rivals)
	arg_11_0:setExerciseCount(arg_11_1.fightCount)
	arg_11_0:setRecoverTime(arg_11_1.resetTime)

	return
end

function var_0_0.setSeasonInfo(arg_12_0, arg_12_1)
	arg_12_0:updateSeaInfoVO(arg_12_1)
	arg_12_0:setFleet(arg_12_1.fleet)
	arg_12_0:setRivals(arg_12_1.rivals)
	arg_12_0:setExerciseCount(arg_12_1.fightCount)
	arg_12_0:setRecoverTime(arg_12_1.resetTime)
	arg_12_0:updateSeasonTime()
	arg_12_0:initPlayerFleet()
	arg_12_0:initPlayerInfo()
	arg_12_0:updateRivals()

	return
end

function var_0_0.init(arg_13_0)
	arg_13_0.backBtn = arg_13_0._tf:Find("blur_panel/adapt/top/backBtn")
	arg_13_0._normalUIMain = pg.UIMgr.GetInstance().UIMain
	arg_13_0._overlayUIMain = pg.UIMgr.GetInstance().OverlayMain
	arg_13_0.top = findTF(arg_13_0._tf, "blur_panel/adapt/top")
	arg_13_0.awardPanel = arg_13_0._tf:Find("award_info_panel")

	setActive(arg_13_0.awardPanel, false)

	arg_13_0.rivalList = arg_13_0._tf:Find("center/rival_list")
	arg_13_0.bottomPanel = arg_13_0._tf:Find("bottom")
	arg_13_0.shipTpl = arg_13_0:getTpl("fleet_info/shiptpl", arg_13_0.bottomPanel)
	arg_13_0.emptyTpl = arg_13_0:getTpl("fleet_info/emptytpl", arg_13_0.bottomPanel)
	arg_13_0.mainContainer = arg_13_0.bottomPanel:Find("fleet_info/main")
	arg_13_0.vanguardContainer = arg_13_0.bottomPanel:Find("fleet_info/vanguard")
	arg_13_0.rankCfg = pg.arena_data_rank

	arg_13_0:uiStartAnimating()

	return
end

function var_0_0.updatePlayer(arg_14_0, arg_14_1)
	arg_14_0.player = arg_14_1

	setText(findTF(arg_14_0._tf:Find("bottom/player_info"), "statistics_panel/exploit_bg/score"), arg_14_1.exploit)

	return
end

function var_0_0.uiStartAnimating(arg_15_0)
	setAnchoredPosition(arg_15_0.bottomPanel, {
		y = arg_15_0.bottomPanel.localPosition.y - 308
	})
	shiftPanel(arg_15_0.bottomPanel, nil, arg_15_0.bottomPanel.localPosition.y, 0.3, 0, true, true)

	return
end

function var_0_0.uiExitAnimating(arg_16_0)
	shiftPanel(arg_16_0.bottomPanel, nil, arg_16_0.bottomPanel.localPosition.y - 308, 0.3, 0, true, true)

	return
end

function var_0_0.didEnter(arg_17_0)
	onButton(arg_17_0, arg_17_0.backBtn, function()
		if arg_17_0.isOpenRivalInfoPanel then
			arg_17_0:closeRivalInfoPanel()
		else
			arg_17_0:emit(var_0_0.ON_BACK)
		end

		return
	end, SFX_CANCEL)
	setActive(arg_17_0._tf:Find("stamp"), getProxy(TaskProxy):mingshiTouchFlagEnabled())

	if LOCK_CLICK_MINGSHI then
		setActive(arg_17_0._tf:Find("stamp"), false)
	end

	onButton(arg_17_0, arg_17_0._tf:Find("stamp"), function()
		getProxy(TaskProxy):dealMingshiTouchFlag(10)

		return
	end, SFX_CONFIRM)
	onButton(arg_17_0, arg_17_0._tf:Find("bottom/buttons/rank_btn"), function()
		arg_17_0:emit(MilitaryExerciseMediator.OPEN_RANK)

		return
	end, SFX_PANEL)
	onButton(arg_17_0, arg_17_0._tf:Find("bottom/buttons/shop_btn"), function()
		arg_17_0:emit(MilitaryExerciseMediator.OPEN_SHOP)

		return
	end, SFX_PANEL)
	onButton(arg_17_0, arg_17_0._tf:Find("bottom/buttons/award_btn"), function()
		arg_17_0.isOpenAwards = true

		pg.UIMgr.GetInstance():BlurPanel(arg_17_0.awardPanel)

		if not arg_17_0.isInitAward then
			arg_17_0:initAwards()

			arg_17_0.isInitAward = true
		else
			setActive(arg_17_0.awardPanel, true)
		end

		return
	end, SFX_PANEL)
	onButton(arg_17_0, findTF(arg_17_0._tf, "center/replace_rival_btn"), function()
		arg_17_0:emit(MilitaryExerciseMediator.REPLACE_RIVALS)

		return
	end, SFX_PANEL)

	if arg_17_0.contextData.mode == var_0_0.TYPE_SHOP then
		triggerToggle(arg_17_0.shopBtn, true)
	end

	return
end

function var_0_0.updateSeasonTime(arg_24_0)
	arg_24_0.seasonInfoPanel = arg_24_0._tf:Find("center/season_info")

	arg_24_0:updateSeasonLeftTime(arg_24_0.seasonTime)
	arg_24_0:updateRecoverTime(arg_24_0.recoverTime)
	arg_24_0:updateExerciseCount()

	return
end

function var_0_0.updateExerciseCount(arg_25_0)
	local var_25_0 = arg_25_0.exerciseCount or 0
	local var_25_1 = math.max(var_25_0, 0)

	setText(findTF(arg_25_0.seasonInfoPanel, "count"), var_25_1 .. "/" .. SeasonInfo.MAX_FIGHTCOUNT)

	return
end

function var_0_0.updateSeasonLeftTime(arg_26_0, arg_26_1)
	if arg_26_0.leftTimeTimer then
		arg_26_0.leftTimeTimer:Stop()

		arg_26_0.leftTimeTimer = nil
	end

	local var_26_0 = findTF(arg_26_0.seasonInfoPanel, "left_time_container/day")
	local var_26_1 = findTF(arg_26_0.seasonInfoPanel, "left_time_container/time")

	arg_26_0.leftTimeTimer = Timer.New(function()
		local var_27_0 = arg_26_1 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_27_0 > 0 then
			local var_27_1, var_27_2, var_27_3, var_27_4 = pg.TimeMgr.GetInstance():parseTimeFrom(var_27_0)

			setText(var_26_0, var_27_1)
			setText(var_26_1, string.format("%02d:%02d:%02d", var_27_2, var_27_3, var_27_4))
		else
			setText(var_26_0, 0)
			setText(var_26_1, string.format("%02d:%02d:%02d", 0, 0, 0))
			arg_26_0.leftTimeTimer:Stop()

			arg_26_0.leftTimeTimer = nil
		end

		return
	end, 1, -1)

	arg_26_0.leftTimeTimer:Start()
	arg_26_0.leftTimeTimer.func()

	return
end

function var_0_0.updateRecoverTime(arg_28_0, arg_28_1)
	if arg_28_0.recoverTimer then
		arg_28_0.recoverTimer:Stop()

		arg_28_0.recoverTimer = nil
	end

	local var_28_0 = findTF(arg_28_0.seasonInfoPanel, "recover_container/time")

	if arg_28_1 == 0 then
		setText(var_28_0, "")

		return
	end

	arg_28_0.recoverTimer = Timer.New(function()
		local var_29_0 = arg_28_1 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_29_0 > 0 then
			setText(var_28_0, i18n("exercise_count_recover_tip", pg.TimeMgr.GetInstance():DescCDTime(var_29_0)))
		else
			arg_28_0.recoverTimer:Stop()

			arg_28_0.recoverTimer = nil
		end

		return
	end, 1, -1)

	arg_28_0.recoverTimer:Start()
	arg_28_0.recoverTimer.func()

	return
end

function var_0_0.initPlayerFleet(arg_30_0)
	removeAllChildren(arg_30_0.mainContainer)
	removeAllChildren(arg_30_0.vanguardContainer)

	for iter_30_0 = 1, 3 do
		local var_30_0

		if arg_30_0.fleet.mainShips[iter_30_0] then
			if arg_30_0.ships[arg_30_0.fleet.mainShips[iter_30_0]] then
				(function(arg_31_0, arg_31_1, arg_31_2)
					local var_31_0 = cloneTplTo(arg_30_0.shipTpl, arg_31_1)

					updateShip(var_31_0, arg_31_0, {
						initStar = true
					})
					setText(findTF(var_31_0, "icon_bg/lv/Text"), arg_31_0.level)
					onButton(arg_30_0, var_31_0, function()
						arg_30_0:emit(MilitaryExerciseMediator.OPEN_DOCKYARD, arg_31_2, arg_31_0.id)

						return
					end, SFX_PANEL)

					return
				end)(arg_30_0.ships[arg_30_0.fleet.mainShips[iter_30_0]], arg_30_0.mainContainer, TeamType.Main)
			end

			goto label_30_0

			var_30_0 = arg_30_0
		end

		onButton(arg_30_0, findTF(cloneTplTo(arg_30_0.emptyTpl, arg_30_0.mainContainer), "icon_bg"), function()
			arg_30_0:emit(MilitaryExerciseMediator.OPEN_DOCKYARD, TeamType.Main, 0)

			return
		end, SFX_PANEL)

		::label_30_0::
	end

	for iter_30_1 = 1, 3 do
		local var_30_1

		if arg_30_0.fleet.vanguardShips[iter_30_1] then
			if arg_30_0.ships[arg_30_0.fleet.vanguardShips[iter_30_1]] then
				(function(arg_31_0, arg_31_1, arg_31_2)
					local var_31_0 = cloneTplTo(arg_30_0.shipTpl, arg_31_1)

					updateShip(var_31_0, arg_31_0, {
						initStar = true
					})
					setText(findTF(var_31_0, "icon_bg/lv/Text"), arg_31_0.level)
					onButton(arg_30_0, var_31_0, function()
						arg_30_0:emit(MilitaryExerciseMediator.OPEN_DOCKYARD, arg_31_2, arg_31_0.id)

						return
					end, SFX_PANEL)

					return
				end)(arg_30_0.ships[arg_30_0.fleet.vanguardShips[iter_30_1]], arg_30_0.vanguardContainer, TeamType.Vanguard)
			end

			goto label_30_1

			var_30_1 = arg_30_0
		end

		onButton(arg_30_0, findTF(cloneTplTo(arg_30_0.emptyTpl, arg_30_0.vanguardContainer), "icon_bg"), function()
			arg_30_0:emit(MilitaryExerciseMediator.OPEN_DOCKYARD, TeamType.Vanguard, 0)

			return
		end, SFX_PANEL)

		::label_30_1::
	end

	return
end

function var_0_0.initPlayerInfo(arg_35_0)
	local var_35_0 = arg_35_0._tf:Find("bottom/player_info")

	setText(findTF(var_35_0, "statistics_panel/score_bg/score"), arg_35_0.seasonInfo.score)
	setText(findTF(var_35_0, "statistics_panel/rank_bg/score"), arg_35_0.seasonInfo.rank)

	local var_35_1 = findTF(var_35_0, "upgrade_rank_tip/level")

	assert(SeasonInfo.getMilitaryRank(arg_35_0.seasonInfo.score, arg_35_0.seasonInfo.rank), ">>>" .. arg_35_0.seasonInfo.score .. "--" .. arg_35_0.seasonInfo.rank)

	local var_35_2 = SeasonInfo.getEmblem(arg_35_0.seasonInfo.score, arg_35_0.seasonInfo.rank)

	LoadImageSpriteAsync("emblem/" .. var_35_2, findTF(var_35_0, "medal_bg/medal"), true)
	LoadImageSpriteAsync("emblem/n_" .. var_35_2, findTF(var_35_0, "medal_bg/Text"), true)

	local var_35_3 = findTF(var_35_0, "exp_slider"):GetComponent("Slider")
	local var_35_4, var_35_5, var_35_6 = SeasonInfo.getNextMilitaryRank(arg_35_0.seasonInfo.score, arg_35_0.seasonInfo.rank)
	local var_35_7 = math.min(var_35_5, arg_35_0.seasonInfo.score)

	setText(findTF(var_35_0, "upgrade_tip/level"), var_35_4)
	setText(findTF(var_35_0, "upgrade_score_tip/level"), var_35_5)
	setText(var_35_1, var_35_6 > 0 and var_35_6 or "-")

	var_35_3.value = var_35_7 / var_35_5

	return
end

function var_0_0.updateRivals(arg_36_0)
	arg_36_0.rivalTFs = {}

	for iter_36_0 = 1, 4 do
		table.insert(arg_36_0.rivalTFs, arg_36_0.rivalList:GetChild(iter_36_0 - 1))
	end

	for iter_36_1 = 1, 4 do
		setActive(arg_36_0.rivalTFs[iter_36_1], iter_36_1 <= #arg_36_0.rivalVOs)

		if iter_36_1 <= #arg_36_0.rivalVOs then
			arg_36_0:updateRival(iter_36_1)
		end
	end

	return
end

function var_0_0.updateRival(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0.rivalVOs[arg_37_1]

	assert(SeasonInfo.getMilitaryRank(arg_37_0.rivalVOs[arg_37_1].score, arg_37_0.rivalVOs[arg_37_1].rank), ">>>" .. arg_37_0.rivalVOs[arg_37_1].score .. "--" .. arg_37_0.rivalVOs[arg_37_1].rank)

	local var_37_1 = findTF(arg_37_0.rivalTFs[arg_37_1], "shiptpl")
	local var_37_2 = SeasonInfo.getEmblem(arg_37_0.rivalVOs[arg_37_1].score, arg_37_0.rivalVOs[arg_37_1].rank)

	LoadImageSpriteAsync("emblem/" .. var_37_2, findTF(arg_37_0.rivalTFs[arg_37_1], "medal"), true)
	LoadImageSpriteAsync("emblem/n_" .. var_37_2, findTF(arg_37_0.rivalTFs[arg_37_1], "Text"), true)
	updateDrop(var_37_1, {
		type = DROP_TYPE_SHIP,
		id = arg_37_0.rivalVOs[arg_37_1].icon,
		skinId = arg_37_0.rivalVOs[arg_37_1].skinId,
		propose = arg_37_0.rivalVOs[arg_37_1].proposeTime,
		remoulded = arg_37_0.rivalVOs[arg_37_1].remoulded
	}, {
		initStar = true
	})
	setActive(findTF(var_37_1, "icon_bg/lv"), false)
	setText(findTF(arg_37_0.rivalTFs[arg_37_1], "rank_bg/rank_container/name"), arg_37_0.rivalVOs[arg_37_1].rank)
	setText(findTF(arg_37_0.rivalTFs[arg_37_1], "name_container/name"), arg_37_0.rivalVOs[arg_37_1].name)
	setText(findTF(arg_37_0.rivalTFs[arg_37_1], "name_container/lv"), "Lv." .. arg_37_0.rivalVOs[arg_37_1].level)
	setText(findTF(arg_37_0.rivalTFs[arg_37_1], "comprehensive_panel/comprehensive/main_fleet/value"), arg_37_0.rivalVOs[arg_37_1]:GetGearScoreSum(TeamType.Main))
	setText(findTF(arg_37_0.rivalTFs[arg_37_1], "comprehensive_panel/comprehensive/vanguard_fleet/value"), arg_37_0.rivalVOs[arg_37_1]:GetGearScoreSum(TeamType.Vanguard))
	onButton(arg_37_0, arg_37_0.rivalTFs[arg_37_1], function()
		arg_37_0:emit(MilitaryExerciseMediator.OPEN_RIVAL_INFO, var_37_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.initAwards(arg_39_0)
	assert(not arg_39_0.isInitAward, "已经初始化奖励列表")
	setActive(arg_39_0.awardPanel, true)
	onButton(arg_39_0, arg_39_0.awardPanel:Find("top/btnBack"), function()
		arg_39_0:closeAwards()

		return
	end, SFX_CANCEL)
	setText(arg_39_0.awardPanel:Find("bg/frame/content/time_panel/Text"), i18n("exercise_time_tip", "   " .. os.date("%Y.%m.%d", arg_39_0.activity.data1) .. " — " .. os.date("%Y.%m.%d", arg_39_0.activity.stopTime)))
	setText(arg_39_0.awardPanel:Find("bg/frame/content/desc_panel/Text"), i18n("exercise_rule_tip"))

	local var_39_0 = arg_39_0.awardPanel:Find("bg/frame/content/award_panel/award_list")
	local var_39_1 = arg_39_0:getTpl("awardtpl", var_39_0)
	local var_39_2 = arg_39_0:getTpl("awards/equipmenttpl", var_39_1)
	local var_39_3 = var_39_0:Find("linetpl")

	setText(arg_39_0.awardPanel:Find("bg/frame/content/award_panel/Text"), i18n("exercise_award_tip"))

	for iter_39_0 = #arg_39_0.rankCfg.all, 1, -1 do
		if #arg_39_0.rankCfg[arg_39_0.rankCfg.all[iter_39_0]].award_list > 0 then
			(function(arg_41_0, arg_41_1)
				local var_41_0 = arg_41_0:Find("awards")

				setText(findTF(arg_41_0, "Text"), arg_39_0.rankCfg[arg_41_1].name .. ":")

				for iter_41_0, iter_41_1 in ipairs(arg_39_0.rankCfg[arg_41_1].award_list) do
					local var_41_1 = cloneTplTo(var_39_2, var_41_0)

					updateDrop(var_41_1, {
						type = iter_41_1[1],
						id = iter_41_1[2],
						count = iter_41_1[3]
					})
					onButton(arg_39_0, var_41_1:Find("icon_bg"), function()
						local var_42_0 = iter_41_1[1] == 1 and id2ItemId(iter_41_1[2]) or iter_41_1[2]

						arg_39_0:emit(BaseUI.ON_ITEM, var_42_0)

						return
					end, SFX_PANEL)
				end

				setText(findTF(arg_41_0, "upgrade_score_tip/level"), arg_39_0.rankCfg[arg_41_1].point)

				local var_41_3 = findTF(arg_41_0, "upgrade_rank_tip/level")

				if arg_39_0.rankCfg[arg_41_1].order > 0 then
					local var_41_4 = arg_39_0.rankCfg[arg_41_1].order or "-"

					var_41_2(var_41_3, var_41_4)

					return
				end
			end)(cloneTplTo(var_39_1, var_39_0), arg_39_0.rankCfg.all[iter_39_0])
			cloneTplTo(var_39_3, var_39_0)
		end
	end

	return
end

function var_0_0.closeAwards(arg_43_0)
	if arg_43_0.isOpenAwards then
		setActive(arg_43_0.awardPanel, false)

		arg_43_0.isOpenAwards = false

		pg.UIMgr.GetInstance():UnOverlayPanel(arg_43_0.awardPanel, arg_43_0._tf)
	end

	return
end

function var_0_0.onBackPressed(arg_44_0)
	if arg_44_0.isOpenAwards then
		arg_44_0:closeAwards()
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		arg_44_0:emit(var_0_0.ON_BACK)
	end

	return
end

function var_0_0.willExit(arg_45_0)
	if arg_45_0.tweens then
		cancelTweens(arg_45_0.tweens)
	end

	if arg_45_0.leftTimeTimer then
		arg_45_0.leftTimeTimer:Stop()

		arg_45_0.leftTimeTimer = nil
	end

	if arg_45_0.recoverTimer then
		arg_45_0.recoverTimer:Stop()

		arg_45_0.recoverTimer = nil
	end

	arg_45_0:closeAwards()

	return
end

return var_0_0
