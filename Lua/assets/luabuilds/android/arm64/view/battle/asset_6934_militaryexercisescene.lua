local MilitaryExerciseScene = class("MilitaryExerciseScene", import("..base.BaseUI"))

MilitaryExerciseScene.TYPE_SHOP = 1

function MilitaryExerciseScene:getUIName()
	return "MilitaryExerciseUI"
end

function MilitaryExerciseScene:ResUISettings()
	return true
end

function MilitaryExerciseScene:setShips(arg_3_1)
	self.ships = arg_3_1

	return
end

function MilitaryExerciseScene:setFleet(arg_4_1)
	self.fleet = arg_4_1

	return
end

function MilitaryExerciseScene:setRivals(arg_5_1)
	table.sort(arg_5_1, function(arg_6_0, arg_6_1)
		return arg_6_0.rank < arg_6_1.rank
	end)

	self.rivalVOs = arg_5_1

	return
end

function MilitaryExerciseScene:setExerciseCount(arg_7_1)
	self.exerciseCount = arg_7_1

	return
end

function MilitaryExerciseScene:setSeasonTime(arg_8_1)
	self.seasonTime = arg_8_1

	return
end

function MilitaryExerciseScene:setRecoverTime(arg_9_1)
	self.recoverTime = arg_9_1

	return
end

function MilitaryExerciseScene:setActivity(arg_10_1)
	self.activity = arg_10_1

	self:setSeasonTime(arg_10_1.stopTime)

	return
end

function MilitaryExerciseScene:updateSeaInfoVO(arg_11_1)
	self.seasonInfo = arg_11_1

	self:setFleet(arg_11_1.fleet)
	self:setRivals(arg_11_1.rivals)
	self:setExerciseCount(arg_11_1.fightCount)
	self:setRecoverTime(arg_11_1.resetTime)

	return
end

function MilitaryExerciseScene:setSeasonInfo(arg_12_1)
	self:updateSeaInfoVO(arg_12_1)
	self:setFleet(arg_12_1.fleet)
	self:setRivals(arg_12_1.rivals)
	self:setExerciseCount(arg_12_1.fightCount)
	self:setRecoverTime(arg_12_1.resetTime)
	self:updateSeasonTime()
	self:initPlayerFleet()
	self:initPlayerInfo()
	self:updateRivals()

	return
end

function MilitaryExerciseScene:init()
	self.backBtn = self._tf:Find("blur_panel/adapt/top/backBtn")
	self._normalUIMain = pg.UIMgr.GetInstance().UIMain
	self._overlayUIMain = pg.UIMgr.GetInstance().OverlayMain
	self.top = findTF(self._tf, "blur_panel/adapt/top")
	self.awardPanel = self._tf:Find("award_info_panel")

	setActive(self.awardPanel, false)

	self.rivalList = self._tf:Find("center/rival_list")
	self.bottomPanel = self._tf:Find("bottom")
	self.shipTpl = self:getTpl("fleet_info/shiptpl", self.bottomPanel)
	self.emptyTpl = self:getTpl("fleet_info/emptytpl", self.bottomPanel)
	self.mainContainer = self.bottomPanel:Find("fleet_info/main")
	self.vanguardContainer = self.bottomPanel:Find("fleet_info/vanguard")
	self.rankCfg = pg.arena_data_rank

	self:uiStartAnimating()

	return
end

function MilitaryExerciseScene:updatePlayer(arg_14_1)
	self.player = arg_14_1

	setText(findTF(self._tf:Find("bottom/player_info"), "statistics_panel/exploit_bg/score"), arg_14_1.exploit)

	return
end

function MilitaryExerciseScene:uiStartAnimating()
	setAnchoredPosition(self.bottomPanel, {
		y = self.bottomPanel.localPosition.y - 308
	})
	shiftPanel(self.bottomPanel, nil, self.bottomPanel.localPosition.y, 0.3, 0, true, true)

	return
end

function MilitaryExerciseScene:uiExitAnimating()
	shiftPanel(self.bottomPanel, nil, self.bottomPanel.localPosition.y - 308, 0.3, 0, true, true)

	return
end

function MilitaryExerciseScene:didEnter()
	onButton(self, self.backBtn, function()
		if self.isOpenRivalInfoPanel then
			self:closeRivalInfoPanel()
		else
			self:emit(MilitaryExerciseScene.ON_BACK)
		end

		return
	end, SFX_CANCEL)
	setActive(self._tf:Find("stamp"), getProxy(TaskProxy):mingshiTouchFlagEnabled())

	if LOCK_CLICK_MINGSHI then
		setActive(self._tf:Find("stamp"), false)
	end

	onButton(self, self._tf:Find("stamp"), function()
		getProxy(TaskProxy):dealMingshiTouchFlag(10)

		return
	end, SFX_CONFIRM)
	onButton(self, self._tf:Find("bottom/buttons/rank_btn"), function()
		self:emit(MilitaryExerciseMediator.OPEN_RANK)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("bottom/buttons/shop_btn"), function()
		self:emit(MilitaryExerciseMediator.OPEN_SHOP)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("bottom/buttons/award_btn"), function()
		self.isOpenAwards = true

		pg.UIMgr.GetInstance():BlurPanel(self.awardPanel)

		if not self.isInitAward then
			self:initAwards()

			self.isInitAward = true
		else
			setActive(self.awardPanel, true)
		end

		return
	end, SFX_PANEL)
	onButton(self, findTF(self._tf, "center/replace_rival_btn"), function()
		self:emit(MilitaryExerciseMediator.REPLACE_RIVALS)

		return
	end, SFX_PANEL)

	if self.contextData.mode == MilitaryExerciseScene.TYPE_SHOP then
		triggerToggle(self.shopBtn, true)
	end

	return
end

function MilitaryExerciseScene:updateSeasonTime()
	self.seasonInfoPanel = self._tf:Find("center/season_info")

	self:updateSeasonLeftTime(self.seasonTime)
	self:updateRecoverTime(self.recoverTime)
	self:updateExerciseCount()

	return
end

function MilitaryExerciseScene:updateExerciseCount()
	setText(findTF(self.seasonInfoPanel, "count"), math.max(self.exerciseCount or 0, 0) .. "/" .. SeasonInfo.MAX_FIGHTCOUNT)

	return
end

function MilitaryExerciseScene:updateSeasonLeftTime(arg_26_1)
	if self.leftTimeTimer then
		self.leftTimeTimer:Stop()

		self.leftTimeTimer = nil
	end

	local var_26_0 = findTF(self.seasonInfoPanel, "left_time_container/day")
	local var_26_1 = findTF(self.seasonInfoPanel, "left_time_container/time")

	self.leftTimeTimer = Timer.New(function()
		local var_27_0 = arg_26_1 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_27_0 > 0 then
			local var_27_1, var_27_2, var_27_3, var_27_4 = pg.TimeMgr.GetInstance():parseTimeFrom(var_27_0)

			setText(var_26_0, var_27_1)
			setText(var_26_1, string.format("%02d:%02d:%02d", var_27_2, var_27_3, var_27_4))
		else
			setText(var_26_0, 0)
			setText(var_26_1, string.format("%02d:%02d:%02d", 0, 0, 0))
			self.leftTimeTimer:Stop()

			self.leftTimeTimer = nil
		end

		return
	end, 1, -1)

	self.leftTimeTimer:Start()
	self.leftTimeTimer.func()

	return
end

function MilitaryExerciseScene:updateRecoverTime(arg_28_1)
	if self.recoverTimer then
		self.recoverTimer:Stop()

		self.recoverTimer = nil
	end

	local var_28_0 = findTF(self.seasonInfoPanel, "recover_container/time")

	if arg_28_1 == 0 then
		setText(var_28_0, "")

		return
	end

	self.recoverTimer = Timer.New(function()
		local var_29_0 = arg_28_1 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_29_0 > 0 then
			setText(var_28_0, i18n("exercise_count_recover_tip", pg.TimeMgr.GetInstance():DescCDTime(var_29_0)))
		else
			self.recoverTimer:Stop()

			self.recoverTimer = nil
		end

		return
	end, 1, -1)

	self.recoverTimer:Start()
	self.recoverTimer.func()

	return
end

function MilitaryExerciseScene:initPlayerFleet()
	local function var_30_0(arg_31_0, arg_31_1, arg_31_2)
		local var_31_0 = cloneTplTo(self.shipTpl, arg_31_1)

		updateShip(var_31_0, arg_31_0, {
			initStar = true
		})
		setText(findTF(var_31_0, "icon_bg/lv/Text"), arg_31_0.level)
		onButton(self, var_31_0, function()
			self:emit(MilitaryExerciseMediator.OPEN_DOCKYARD, arg_31_2, arg_31_0.id)

			return
		end, SFX_PANEL)

		return
	end

	removeAllChildren(self.mainContainer)
	removeAllChildren(self.vanguardContainer)

	for iter_30_0 = 1, 3 do
		if self.fleet.mainShips[iter_30_0] then
			if self.ships[self.fleet.mainShips[iter_30_0]] then
				var_30_0(self.ships[self.fleet.mainShips[iter_30_0]], self.mainContainer, TeamType.Main)
			end
		else
			onButton(self, findTF(cloneTplTo(self.emptyTpl, self.mainContainer), "icon_bg"), function()
				self:emit(MilitaryExerciseMediator.OPEN_DOCKYARD, TeamType.Main, 0)

				return
			end, SFX_PANEL)
		end
	end

	for iter_30_1 = 1, 3 do
		if self.fleet.vanguardShips[iter_30_1] then
			if self.ships[self.fleet.vanguardShips[iter_30_1]] then
				var_30_0(self.ships[self.fleet.vanguardShips[iter_30_1]], self.vanguardContainer, TeamType.Vanguard)
			end
		else
			onButton(self, findTF(cloneTplTo(self.emptyTpl, self.vanguardContainer), "icon_bg"), function()
				self:emit(MilitaryExerciseMediator.OPEN_DOCKYARD, TeamType.Vanguard, 0)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function MilitaryExerciseScene:initPlayerInfo()
	local var_35_0 = self._tf:Find("bottom/player_info")

	setText(findTF(var_35_0, "statistics_panel/score_bg/score"), self.seasonInfo.score)
	setText(findTF(var_35_0, "statistics_panel/rank_bg/score"), self.seasonInfo.rank)

	local var_35_1 = findTF(var_35_0, "upgrade_rank_tip/level")

	assert(SeasonInfo.getMilitaryRank(self.seasonInfo.score, self.seasonInfo.rank), ">>>" .. self.seasonInfo.score .. "--" .. self.seasonInfo.rank)

	local var_35_2 = SeasonInfo.getEmblem(self.seasonInfo.score, self.seasonInfo.rank)

	LoadImageSpriteAsync("emblem/" .. var_35_2, findTF(var_35_0, "medal_bg/medal"), true)
	LoadImageSpriteAsync("emblem/n_" .. var_35_2, findTF(var_35_0, "medal_bg/Text"), true)

	local var_35_3 = findTF(var_35_0, "exp_slider"):GetComponent("Slider")
	local var_35_4, var_35_5, var_35_6 = SeasonInfo.getNextMilitaryRank(self.seasonInfo.score, self.seasonInfo.rank)
	local var_35_7 = math.min(var_35_5, self.seasonInfo.score)

	setText(findTF(var_35_0, "upgrade_tip/level"), var_35_4)
	setText(findTF(var_35_0, "upgrade_score_tip/level"), var_35_5)
	setText(var_35_1, var_35_6 > 0 and var_35_6 or "-")

	var_35_3.value = var_35_7 / var_35_5

	return
end

function MilitaryExerciseScene:updateRivals()
	self.rivalTFs = {}

	for iter_36_0 = 1, 4 do
		table.insert(self.rivalTFs, self.rivalList:GetChild(iter_36_0 - 1))
	end

	for iter_36_1 = 1, 4 do
		setActive(self.rivalTFs[iter_36_1], iter_36_1 <= #self.rivalVOs)

		if iter_36_1 <= #self.rivalVOs then
			self:updateRival(iter_36_1)
		end
	end

	return
end

function MilitaryExerciseScene:updateRival(arg_37_1)
	local var_37_0 = self.rivalVOs[arg_37_1]

	assert(SeasonInfo.getMilitaryRank(self.rivalVOs[arg_37_1].score, self.rivalVOs[arg_37_1].rank), ">>>" .. self.rivalVOs[arg_37_1].score .. "--" .. self.rivalVOs[arg_37_1].rank)

	local var_37_1 = findTF(self.rivalTFs[arg_37_1], "shiptpl")
	local var_37_2 = SeasonInfo.getEmblem(self.rivalVOs[arg_37_1].score, self.rivalVOs[arg_37_1].rank)

	LoadImageSpriteAsync("emblem/" .. var_37_2, findTF(self.rivalTFs[arg_37_1], "medal"), true)
	LoadImageSpriteAsync("emblem/n_" .. var_37_2, findTF(self.rivalTFs[arg_37_1], "Text"), true)
	updateDrop(var_37_1, {
		type = DROP_TYPE_SHIP,
		id = self.rivalVOs[arg_37_1].icon,
		skinId = self.rivalVOs[arg_37_1].skinId,
		propose = self.rivalVOs[arg_37_1].proposeTime,
		remoulded = self.rivalVOs[arg_37_1].remoulded
	}, {
		initStar = true
	})
	setActive(findTF(var_37_1, "icon_bg/lv"), false)
	setText(findTF(self.rivalTFs[arg_37_1], "rank_bg/rank_container/name"), self.rivalVOs[arg_37_1].rank)
	setText(findTF(self.rivalTFs[arg_37_1], "name_container/name"), self.rivalVOs[arg_37_1].name)
	setText(findTF(self.rivalTFs[arg_37_1], "name_container/lv"), "Lv." .. self.rivalVOs[arg_37_1].level)
	setText(findTF(self.rivalTFs[arg_37_1], "comprehensive_panel/comprehensive/main_fleet/value"), self.rivalVOs[arg_37_1]:GetGearScoreSum(TeamType.Main))
	setText(findTF(self.rivalTFs[arg_37_1], "comprehensive_panel/comprehensive/vanguard_fleet/value"), self.rivalVOs[arg_37_1]:GetGearScoreSum(TeamType.Vanguard))
	onButton(self, self.rivalTFs[arg_37_1], function()
		self:emit(MilitaryExerciseMediator.OPEN_RIVAL_INFO, var_37_0)

		return
	end, SFX_PANEL)

	return
end

function MilitaryExerciseScene:initAwards()
	assert(not self.isInitAward, "已经初始化奖励列表")
	setActive(self.awardPanel, true)
	onButton(self, self.awardPanel:Find("top/btnBack"), function()
		self:closeAwards()

		return
	end, SFX_CANCEL)
	setText(self.awardPanel:Find("bg/frame/content/time_panel/Text"), i18n("exercise_time_tip", "   " .. os.date("%Y.%m.%d", self.activity.data1) .. " — " .. os.date("%Y.%m.%d", self.activity.stopTime)))
	setText(self.awardPanel:Find("bg/frame/content/desc_panel/Text"), i18n("exercise_rule_tip"))

	local var_39_0 = self.awardPanel:Find("bg/frame/content/award_panel/award_list")
	local var_39_1 = self:getTpl("awardtpl", var_39_0)
	local var_39_2 = self:getTpl("awards/equipmenttpl", var_39_1)
	local var_39_3 = var_39_0:Find("linetpl")

	setText(self.awardPanel:Find("bg/frame/content/award_panel/Text"), i18n("exercise_award_tip"))

	local function var_39_4(arg_41_0, arg_41_1)
		local var_41_0 = arg_41_0:Find("awards")

		setText(findTF(arg_41_0, "Text"), self.rankCfg[arg_41_1].name .. ":")

		for iter_41_0, iter_41_1 in ipairs(self.rankCfg[arg_41_1].award_list) do
			local var_41_1 = cloneTplTo(var_39_2, var_41_0)

			updateDrop(var_41_1, {
				type = iter_41_1[1],
				id = iter_41_1[2],
				count = iter_41_1[3]
			})
			onButton(self, var_41_1:Find("icon_bg"), function()
				self:emit(BaseUI.ON_ITEM, iter_41_1[1] == 1 and id2ItemId(iter_41_1[2]) or iter_41_1[2])

				return
			end, SFX_PANEL)
		end

		setText(findTF(arg_41_0, "upgrade_score_tip/level"), self.rankCfg[arg_41_1].point)
		setText(findTF(arg_41_0, "upgrade_rank_tip/level"), (self.rankCfg[arg_41_1].order > 0 or nil) and (self.rankCfg[arg_41_1].order or "-"))

		return
	end

	for iter_39_0 = #self.rankCfg.all, 1, -1 do
		if #self.rankCfg[self.rankCfg.all[iter_39_0]].award_list > 0 then
			var_39_4(cloneTplTo(var_39_1, var_39_0), self.rankCfg.all[iter_39_0])
			cloneTplTo(var_39_3, var_39_0)
		end
	end

	return
end

function MilitaryExerciseScene:closeAwards()
	if self.isOpenAwards then
		setActive(self.awardPanel, false)

		self.isOpenAwards = false

		pg.UIMgr.GetInstance():UnOverlayPanel(self.awardPanel, self._tf)
	end

	return
end

function MilitaryExerciseScene:onBackPressed()
	if self.isOpenAwards then
		self:closeAwards()
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		self:emit(MilitaryExerciseScene.ON_BACK)
	end

	return
end

function MilitaryExerciseScene:willExit()
	if self.tweens then
		cancelTweens(self.tweens)
	end

	if self.leftTimeTimer then
		self.leftTimeTimer:Stop()

		self.leftTimeTimer = nil
	end

	if self.recoverTimer then
		self.recoverTimer:Stop()

		self.recoverTimer = nil
	end

	self:closeAwards()

	return
end

return MilitaryExerciseScene
