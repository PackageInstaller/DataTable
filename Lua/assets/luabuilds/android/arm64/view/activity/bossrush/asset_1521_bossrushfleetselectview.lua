local BossRushFleetSelectView = class("BossRushFleetSelectView", import("view.base.BaseUI"))

BossRushFleetSelectView.fleetNames = {
	vanguard = 1,
	submarine = 3,
	main = 2
}

function BossRushFleetSelectView:GetTextColor()
	local var_1_1 = Color.New(1, 1, 1, 0.5)
end

function BossRushFleetSelectView:getUIName()
	return "BossRushFleetSelectUI"
end

function BossRushFleetSelectView:init()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:InitUI()

	return
end

function BossRushFleetSelectView:InitUI()
	local var_4_0 = self._tf:Find("Panel")

	self.tfFleets = {
		[FleetType.Normal] = self._tf:Find("Panel/Fleet/Normal"),
		[FleetType.Submarine] = self._tf:Find("Panel/Fleet/Submarine")
	}
	self.btnRecommend = var_4_0:Find("Fleet/BtnRecommend")
	self.btnClear = var_4_0:Find("Fleet/BtnClear")
	self.rtCostLimit = var_4_0:Find("Fleet/CostLimit")
	self.commanderList = var_4_0:Find("Fleet/Commander")
	self.modeToggles = {
		var_4_0:Find("Info/Modes/Single"),
		var_4_0:Find("Info/Modes/Multiple")
	}
	self.extraAwardTF = self._tf:Find("Panel/Reward/Normal/Mode")
	self.sonarRangeContainer = self._tf:Find("Panel/Fleet/SonarRange")

	local var_4_1 = {}

	var_4_1[1] = self._tf:Find("Panel/Fleet/SonarRange/Values"):GetChild(0)
	var_4_1[2] = self._tf:Find("Panel/Fleet/SonarRange/Values"):GetChild(1)
	self.sonarRangeTexts = var_4_1

	setText(self.sonarRangeTexts[2], "")

	self.btnBack = var_4_0:Find("Info/Title/BtnClose")
	self.btnGo = var_4_0:Find("Info/Start")

	setText(self._tf:Find("Panel/Fleet/SonarRange/Text"), i18n("fleet_antisub_range") .. ":")
	setText(self._tf:Find("Panel/Fleet/CostLimit/Title"), i18n("formationScene_use_oil_limit_tip_worldboss"))
	setText(self._tf:Find("Panel/Reward/Normal/Base/Text"), i18n("series_enemy_reward_tip1"))
	setText(self._tf:Find("Panel/Reward/Normal/Mode/Text"), i18n("series_enemy_reward_tip2"))
	setText(self._tf:Find("Panel/Reward/EX/Title"), i18n("series_enemy_reward_tip4"))
	setText(self._tf:Find("Panel/Reward/Tip"), i18n("limit_team_character_tips"))
	setText(self._tf:Find("Panel/Info/Modes/Single/On/Text"), i18n("series_enemy_mode_1"))
	setText(self._tf:Find("Panel/Info/Modes/Single/Off/Text"), i18n("series_enemy_mode_1"))
	setText(self._tf:Find("Panel/Info/Modes/Multiple/On/Text"), i18n("series_enemy_mode_2"))
	setText(self._tf:Find("Panel/Info/Modes/Multiple/Off/Text"), i18n("series_enemy_mode_2"))
	setText(self._tf:Find("Panel/Fleet/Normal/main/Item/Ship/EnergyWarn/Text"), i18n("series_enemy_mood"))
	setText(self._tf:Find("Panel/Fleet/Normal/vanguard/Item/Ship/EnergyWarn/Text"), i18n("series_enemy_mood"))
	setText(self._tf:Find("Panel/Fleet/Submarine/main/Item/Ship/EnergyWarn/Text"), i18n("series_enemy_mood"))

	return
end

function BossRushFleetSelectView:didEnter()
	local var_5_0 = self.contextData.seriesData

	onButton(self, self.btnGo, function()
		if StartChapterAutoCommand.CheckOccupied() then
			return
		end

		for iter_6_0 = 1, #self.contextData.fleets - 1 do
			if self.contextData.fleets[iter_6_0]:isLegalToFight() ~= true then
				pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_team_notenough"))

				return
			end
		end

		if _.any(self.contextData.fleets, function(arg_7_0)
			local var_7_0, var_7_1 = arg_7_0:HaveShipsInEvent()

			if var_7_0 then
				pg.TipsMgr.GetInstance():ShowTips(var_7_1)

				return true
			end

			return
		end) then
			return
		end

		if var_5_0:GetType() == BossRushSeriesData.TYPE.SP then
			local var_6_1 = getProxy(ActivityProxy):getActivityById(var_5_0.actId)

			if var_5_0:GetMaxBonusCount() - (var_6_1:GetUsedBonus()[table.getIndex(var_6_1:GetActiveSeriesIds(), function(arg_8_0)
				return arg_8_0 == var_5_0.id
			end)] or 0) <= 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_SP_error"))

				return
			end
		end

		self:emit(BossRushFleetSelectMediator.ON_PRECOMBAT)

		return
	end, SFX_UI_WEIGHANCHOR_GO)
	onButton(self, self.sonarRangeContainer, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.fleet_antisub_range_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.btnBack, function()
		self:onCancelHard()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("BG"), function()
		self:onCancelHard()

		return
	end, SFX_CANCEL)

	local var_5_1 = var_5_0:IsSingleFight()

	setActive(self.modeToggles[1].parent, var_5_1)

	if var_5_1 then
		table.Foreach(self.modeToggles, function(arg_12_0, arg_12_1)
			triggerToggle(arg_12_1, arg_12_0 == self.contextData.mode)

			return
		end)
		table.Foreach(self.modeToggles, function(arg_13_0, arg_13_1)
			onToggle(self, arg_13_1, function(arg_14_0)
				if not arg_14_0 then
					return
				end

				self:emit(BossRushFleetSelectMediator.ON_SWITCH_MODE, arg_13_0)
				self:updateToggles()
				triggerToggle(self.fleetIndexToggles[self.contextData.fleetIndex], true)

				return
			end, SFX_PANEL)

			return
		end)
	end

	local var_5_2 = self._tf:Find("Panel/Fleet/Indexes")
	local var_5_3 = var_5_2.childCount

	UIItemList.StaticAlign(var_5_2, var_5_2:GetChild(0), var_5_2.childCount, function(arg_15_0, arg_15_1, arg_15_2)
		arg_15_1 = arg_15_1 + 1

		if arg_15_0 == UIItemList.EventUpdate then
			if arg_15_1 < var_5_3 then
				setText(arg_15_2:Find("Text"), i18n("series_enemy_fleet_prefix", GetRomanDigit(arg_15_1)))
			else
				setText(arg_15_2:Find("Text"), i18n("formationScene_use_oil_limit_submarine"))
			end

			onToggle(self, arg_15_2, function(arg_16_0)
				setActive(arg_15_2:Find("Selected"), arg_16_0)

				local var_16_0, var_16_1 = self:GetTextColor()

				setTextColor(arg_15_2:Find("Text"), arg_16_0 and var_16_0 or var_16_1)

				if arg_16_0 then
					if self.contextData.fleets[arg_15_1] then
						self.contextData.fleetIndex = arg_15_1 or #self.contextData.fleets
					end

					self:updateEliteFleets()
				end

				return
			end, SFX_PANEL)
		end

		return
	end)
	setText(self._tf:Find("Panel/Info/Title/Text"), var_5_0:GetName())
	setText(self._tf:Find("Panel/Info/Title/Text/EN"), var_5_0:GetSeriesCode())
	setText(self._tf:Find("Panel/Info/Description/Text"), var_5_0:GetDescription())

	local var_5_4 = var_5_0:GetExpeditionIds()
	local var_5_5 = var_5_0:GetBossIcons()
	local var_5_6 = self._tf:Find("Panel/Info/Boss")

	UIItemList.StaticAlign(var_5_6, var_5_6:GetChild(0), #var_5_4, function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_17_1 = arg_17_2:Find("shiptpl")

		SetCompomentEnabled(findTF(var_17_1, "icon_bg"), "Image", false)
		SetCompomentEnabled(findTF(var_17_1, "icon_bg/frame"), "Image", false)
		setActive(arg_17_2:Find("shiptpl/icon_bg/lv"), false)
		GetImageSpriteFromAtlasAsync("SquareIcon/" .. var_5_5[arg_17_1 + 1][1], "", (arg_17_2:Find("shiptpl/icon_bg/icon")))

		local var_17_2 = findTF(var_17_1, "ship_type")

		if var_17_2 then
			setActive(var_17_2, true)
			setImageSprite(var_17_2, GetSpriteFromAtlas("shiptype", shipType2print(var_5_5[arg_17_1 + 1][2])))
		end

		return
	end)

	local function var_5_7(arg_18_0)
		if type(arg_18_0) ~= "table" then
			return {}
		end

		return arg_18_0
	end

	local var_5_8 = var_5_0:GetType() == BossRushSeriesData.TYPE.EXTRA

	setActive(self._tf:Find("Panel/Reward/Normal"), not var_5_8)
	setActive(self._tf:Find("Panel/Reward/EX"), var_5_8)

	if not var_5_8 then
		local var_5_9 = self._tf:Find("Panel/Reward/Normal/Base/Items")
		local var_5_10 = var_5_7(var_5_0:GetPassAwards())

		UIItemList.StaticAlign(var_5_9, var_5_9:GetChild(0), #var_5_10, function(arg_19_0, arg_19_1, arg_19_2)
			if arg_19_0 ~= UIItemList.EventUpdate then
				return
			end

			local var_19_0 = Drop.Create(var_5_10[arg_19_1 + 1])

			updateDrop(arg_19_2, var_19_0)
			onButton(self, arg_19_2, function()
				self:ShowDropDetail(var_19_0)

				return
			end, SFX_PANEL)

			return
		end)

		local var_5_11 = self.extraAwardTF:Find("Items")
		local var_5_12 = var_5_7(var_5_0:GetAdditionalAwards())

		UIItemList.StaticAlign(var_5_11, var_5_11:GetChild(0), #var_5_12, function(arg_21_0, arg_21_1, arg_21_2)
			if arg_21_0 ~= UIItemList.EventUpdate then
				return
			end

			local var_21_0 = Drop.Create(var_5_12[arg_21_1 + 1])

			updateDrop(arg_21_2, var_21_0)
			onButton(self, arg_21_2, function()
				self:ShowDropDetail(var_21_0)

				return
			end, SFX_PANEL)

			return
		end)
	else
		setText(self._tf:Find("Panel/Reward/EX/Title/Text"), math.floor((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_EXTRA_BOSSRUSH_RANK):GetScore())))
	end

	self:updateToggles()
	triggerToggle(self.fleetIndexToggles[self.contextData.fleetIndex], true)

	return
end

local var_0_1 = {
	[99] = true
}

function BossRushFleetSelectView:ShowDropDetail(arg_23_1)
	local var_23_0 = Item.getConfigData(arg_23_1.id)

	if var_23_0 and var_0_1[var_23_0.type] then
		local var_23_1 = {}

		for iter_23_0, iter_23_1 in ipairs(var_23_0.display_icon) do
			var_23_1[#var_23_1 + 1] = {
				hideName = true,
				type = iter_23_1[1],
				id = iter_23_1[2]
			}
		end

		self:emit(BossRushFleetSelectView.ON_DROP_LIST, {
			item2Row = true,
			itemList = var_23_1,
			content = var_23_0.display
		})
	else
		self:emit(BossRushFleetSelectView.ON_DROP, arg_23_1)
	end

	return
end

function BossRushFleetSelectView:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function BossRushFleetSelectView:onCancelHard()
	self:emit(BossRushFleetSelectMediator.ON_UPDATE_CUSTOM_FLEET)
	self:closeView()

	return
end

function BossRushFleetSelectView:onBackPressed()
	self:onCancelHard()
	BossRushFleetSelectView.super.onBackPressed(self)

	return
end

function BossRushFleetSelectView:setHardShipVOs(arg_27_1)
	self.shipVOs = arg_27_1

	return
end

function BossRushFleetSelectView:initAddButton(arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = self.contextData.fleets[arg_28_3]:getShipIds()
	local var_28_1 = {}
	local var_28_2 = {}

	for iter_28_0, iter_28_1 in ipairs(var_28_0) do
		var_28_1[self.shipVOs[iter_28_1]] = true

		if arg_28_2 == self.shipVOs[iter_28_1]:getTeamType() then
			table.insert(var_28_2, iter_28_1)
		end
	end

	local var_28_3 = _.map(var_28_0, function(arg_29_0)
		return self.shipVOs[arg_29_0]
	end)

	table.sort(var_28_3, function(arg_30_0, arg_30_1)
		return BossRushFleetSelectView.fleetNames[arg_30_0:getTeamType()] < BossRushFleetSelectView.fleetNames[arg_30_1:getTeamType()] or BossRushFleetSelectView.fleetNames[arg_30_0:getTeamType()] == BossRushFleetSelectView.fleetNames[arg_30_1:getTeamType()] and table.indexof(var_28_0, arg_30_0.id) < table.indexof(var_28_0, arg_30_1.id)
	end)

	arg_28_1:GetComponent("ContentSizeFitter").enabled = true
	arg_28_1:GetComponent("HorizontalLayoutGroup").enabled = true
	self.isDraging = false

	UIItemList.StaticAlign(arg_28_1, arg_28_1:GetChild(0), 3, function(arg_31_0, arg_31_1, arg_31_2)
		if arg_31_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_31_1 = arg_31_1 + 1

		local var_31_0

		if var_28_2[arg_31_1] then
			var_31_0 = self.shipVOs[var_28_2[arg_31_1]] or nil
		end

		setActive(arg_31_2:Find("Ship"), var_31_0)
		setActive(arg_31_2:Find("Empty"), not var_31_0)

		local var_31_1 = var_31_0 and arg_31_2:Find("Ship") or arg_31_2:Find("Empty")

		if var_31_0 then
			updateShip(var_31_1, var_31_0)
			setActive(var_31_1:Find("EnergyWarn"), self.contextData.mode == BossRushSeriesData.MODE.SINGLE and var_31_0:getEnergy() <= pg.gameset.series_enemy_mood_limit.key_value)
			setActive(var_31_1:Find("event_block"), var_31_0:getFlag("inEvent"))
		end

		setActive(var_31_1:Find("ship_type"), false)

		local var_31_2 = GetOrAddComponent(var_31_1, typeof(UILongPressTrigger))

		var_31_2.onLongPressed:RemoveAllListeners()

		if var_31_0 then
			var_31_2.onLongPressed:AddListener(function()
				self:emit(BossRushFleetSelectMediator.ON_FLEET_SHIPINFO, {
					shipId = var_31_0.id,
					shipVOs = var_28_3
				})

				return
			end)
		end

		local var_31_3 = GetOrAddComponent(var_31_1, "EventTriggerListener")

		var_31_3:RemovePointClickFunc()
		var_31_3:AddPointClickFunc(function(arg_33_0, arg_33_1)
			if self.isDraging then
				return
			end

			self:emit(BossRushFleetSelectMediator.ON_OPEN_DECK, {
				fleet = var_28_1,
				chapter = self.chapter,
				shipVO = var_31_0,
				fleetIndex = arg_28_3,
				teamType = arg_28_2
			})

			return
		end)
		var_31_3:RemoveBeginDragFunc()
		var_31_3:RemoveDragFunc()
		var_31_3:RemoveDragEndFunc()

		return
	end)

	return
end

function BossRushFleetSelectView:updateToggles()
	local var_34_0 = #self.contextData.fleets
	local var_34_1 = self._tf:Find("Panel/Fleet/Indexes")
	local var_34_2 = var_34_1.childCount

	self.fleetIndexToggles = {}

	eachChild(var_34_1, function(arg_35_0, arg_35_1)
		arg_35_1 = arg_35_1 + 1

		setActive(arg_35_0, arg_35_1 == var_34_2 or arg_35_1 < var_34_0)

		if arg_35_1 == var_34_2 then
			self.fleetIndexToggles[var_34_0] = arg_35_0
		elseif arg_35_1 < var_34_0 then
			self.fleetIndexToggles[arg_35_1] = arg_35_0
		end

		return
	end)

	return
end

function BossRushFleetSelectView:updateEliteFleets()
	local var_36_0 = self.contextData.seriesData
	local var_36_1 = self.contextData.fleetIndex
	local var_36_2 = self.contextData.fleets[self.contextData.fleetIndex]
	local var_36_3 = self.contextData.fleetIndex == #self.contextData.fleets

	setActive(self._tf:Find("Panel/Fleet/Normal"), not (self.contextData.fleetIndex == #self.contextData.fleets))
	setActive(self._tf:Find("Panel/Fleet/Submarine"), var_36_3)

	local var_36_4 = self.btnClear
	local var_36_5 = self.btnRecommend
	local var_36_6 = self.commanderList

	if not var_36_3 then
		setText(self.tfFleets[FleetType.Normal]:Find("bg/name"), Fleet.DEFAULT_NAME[var_36_1])
		self:initAddButton(self.tfFleets[FleetType.Normal]:Find(TeamType.Main), TeamType.Main, var_36_1)
		self:initAddButton(self.tfFleets[FleetType.Normal]:Find(TeamType.Vanguard), TeamType.Vanguard, var_36_1)
	else
		local var_36_7 = self.tfFleets[FleetType.Submarine]

		setText(self.tfFleets[FleetType.Submarine]:Find("bg/name"), Fleet.DEFAULT_NAME[Fleet.SUBMARINE_FLEET_ID])
		self:initAddButton(var_36_7:Find(TeamType.Main), TeamType.Submarine, #self.contextData.fleets)
	end

	self:initCommander(var_36_2, var_36_6)
	setText(self.sonarRangeTexts[1], math.floor(var_36_2:GetFleetSonarRange()))

	local var_36_8 = #var_36_2:GetRawShipIds()
	local var_36_9 = var_36_8 == (var_36_3 and 3 or 6)

	onButton(self, var_36_4, function()
		if var_36_8 == 0 then
			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("battle_preCombatLayer_clear_confirm"),
			onYes = function()
				self:emit(BossRushFleetSelectMediator.ON_ELITE_CLEAR, {
					index = var_36_1
				})

				return
			end
		})

		return
	end)
	onButton(self, var_36_5, function()
		if var_36_9 then
			return
		end

		seriesAsync({
			function(arg_40_0)
				if var_36_8 == 0 then
					return arg_40_0()
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("battle_preCombatLayer_auto_confirm"),
					onYes = arg_40_0
				})

				return
			end,
			function(arg_41_0)
				self:emit(BossRushFleetSelectMediator.ON_ELITE_RECOMMEND, {
					index = var_36_1
				})

				return
			end
		})

		return
	end)

	local var_36_10 = var_36_0:GetOilLimit()

	setActive(self.rtCostLimit, _.any(var_36_10, function(arg_42_0)
		return arg_42_0 > 0
	end))

	if #var_36_10 > 0 then
		setText(self.rtCostLimit:Find("Text"), string.format("%s(%d)", i18n(var_36_3 and "formationScene_use_oil_limit_submarine" or "formationScene_use_oil_limit_surface"), (var_36_3 or nil) and (var_36_10[2] or var_36_10[1])))
	end

	setActive(self.extraAwardTF, self.contextData.mode == BossRushSeriesData.MODE.MULTIPLE and #(function(arg_43_0)
		if type(arg_43_0) ~= "table" then
			return {}
		end

		return arg_43_0
	end)(var_36_0:GetAdditionalAwards()) > 0)

	local var_36_12 = var_36_0:GetExpeditionIds()
	local var_36_13 = self._tf:Find("Panel/Info/Boss")

	UIItemList.StaticAlign(var_36_13, var_36_13:GetChild(0), #var_36_12, function(arg_44_0, arg_44_1, arg_44_2)
		if arg_44_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_44_0 = arg_44_1 + 1 == var_36_1 or var_36_1 > #var_36_12 or self.contextData.mode == BossRushSeriesData.MODE.SINGLE

		setActive(arg_44_2:Find("Select"), arg_44_1 + 1 == var_36_1 or var_36_1 > #var_36_12 or self.contextData.mode == BossRushSeriesData.MODE.SINGLE)
		setActive(arg_44_2:Find("Image"), var_44_0)

		return
	end)

	return
end

function BossRushFleetSelectView:initCommander(arg_45_1, arg_45_2)
	local var_45_0 = arg_45_1:GetRawCommanderIds()

	for iter_45_0 = 1, 2 do
		local var_45_1

		if var_45_0[iter_45_0] then
			var_45_1 = getProxy(CommanderProxy):getCommanderById(var_45_0[iter_45_0])
		end

		local var_45_2 = arg_45_2:Find(iter_45_0)
		local var_45_3 = var_45_2:Find("add")
		local var_45_4 = var_45_2:Find("info")

		setActive(var_45_3, not var_45_1)
		setActive(var_45_4, var_45_1)

		if var_45_1 then
			setImageSprite(var_45_4:Find("frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(var_45_1:getRarity())))
			GetImageSpriteFromAtlasAsync("CommanderHrz/" .. var_45_1:getPainting(), "", var_45_4:Find("mask/icon"))
		end

		onButton(self, var_45_3, function()
			self:emit(BossRushFleetSelectMediator.OPEN_COMMANDER_PANEL, arg_45_1)

			return
		end, SFX_PANEL)
		onButton(self, var_45_4, function()
			self:emit(BossRushFleetSelectMediator.OPEN_COMMANDER_PANEL, arg_45_1)

			return
		end, SFX_PANEL)
	end

	return
end

return BossRushFleetSelectView
