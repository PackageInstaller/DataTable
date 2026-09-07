local LevelFleetView = class("LevelFleetView", import("..base.BaseSubView"))
local var_0_1 = {
	vanguard = 1,
	submarine = 3,
	main = 2
}

LevelFleetView.TabIndex = {
	Adjustment = 4,
	Commander = 2,
	Formation = 1,
	Duty = 3
}

local var_0_2 = {
	EDIT = 2,
	SELECT = 1
}
local var_0_3 = {
	NORMAL = 1,
	ADDITION_SUPPORT = 2
}

function LevelFleetView:getUIName()
	return "LevelFleetSelectView"
end

function LevelFleetView:OnInit()
	self:InitUI()
	self:bind(LevelUIConst.CONTINUOUS_OPERATION, function(arg_3_0, arg_3_1)
		getProxy(ChapterProxy):InitContinuousTime(SYSTEM_SCENARIO, arg_3_1.battleTimes)
		LoadContextCommand.RemoveLayerByMediator(LevelContinuousOperationWindowMediator)
		PlayerPrefs.SetInt("chapter_autofight_flag_" .. self.chapter.id, 1)
		triggerButton(self.btnGo)

		return
	end)
	self:bind(LevelMediator2.ON_SPITEM_CHANGED, function(arg_4_0, arg_4_1)
		setActive(self.spCheckMark, not arg_4_1)
		triggerButton(self.btnSp)

		return
	end)

	return
end

function LevelFleetView:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

function LevelFleetView:Show()
	local var_6_0 = noEmptyStr(self.chapter:getConfig("special_operation_list"))

	self:initSPOPView()

	if var_6_0 and #var_6_0 > 0 and not self.chapter:GetDailyBonusQuota() then
		setActive(self.btnSp, true)
	else
		setActive(self.btnSp, false)
	end

	setActive(self._tf, true)

	local var_6_1 = {
		self.formationToggle,
		self.commanderToggle,
		self.dutyToggle,
		self.adjustmentToggle
	}

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if isActive(iter_6_1) then
			triggerToggle(iter_6_1, iter_6_1 == ((not isActive(var_6_1[self.contextData.tabIndex or LevelFleetView.TabIndex.Formation]) or nil) and var_6_1[LevelFleetView.TabIndex.Formation]))
		end
	end

	self:BlurPanel(self._tf)
	self:TryPlaySupportGuide()
	self:CheckGuideElement()

	return
end

function LevelFleetView:CheckGuideElement()
	if not IsUnityEditor then
		return
	end

	_.each({
		"panel/Fixed/start_button",
		"panel/ShipList/support/1/main"
	}, function(arg_8_0)
		assert(self._tf:Find(arg_8_0), "Missing Guide Need GameObject Path: " .. arg_8_0)

		return
	end)

	return
end

function LevelFleetView:TryPlaySupportGuide()
	if self:getLimitNums(FleetType.Support) == 0 then
		return
	end

	if not pg.NewStoryMgr.GetInstance():IsPlayed("NG0041") then
		pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0041")
	end

	return
end

function LevelFleetView:Hide()
	setActive(self.dropDown, false)
	setActive(self.btnSp, false)
	setActive(self._tf, false)

	self.spItemID = nil

	self:UnOverlayPanel(self._tf, self._parentTf)

	return
end

function LevelFleetView:setOpenCommanderTag(arg_11_1)
	self.openedCommanerSystem = arg_11_1

	return
end

function LevelFleetView:SetDutyTabEnabled(arg_12_1)
	self.dutyTabEnabled = arg_12_1

	return
end

function LevelFleetView:onConfirm()
	local var_13_0 = self.chapter
	local var_13_1 = self:getSelectIds()
	local var_13_2 = self.chapter:getNpcShipByType(2)

	if #var_13_2 > 0 then
		local var_13_3 = {}

		var_13_3[TeamType.Vanguard] = #self:getFleetById(var_13_1[1]):getTeamByName(TeamType.Vanguard)
		var_13_3[TeamType.Main] = #self:getFleetById(var_13_1[1]):getTeamByName(TeamType.Main)

		local var_13_4 = {
			[TeamType.Vanguard] = 0,
			[TeamType.Main] = 0
		}
		local var_13_5

		for iter_13_0, iter_13_1 in ipairs(var_13_2) do
			var_13_5 = iter_13_1

			local var_13_6 = iter_13_1:getTeamType()

			var_13_4[var_13_6] = var_13_4[var_13_6] + 1

			if var_13_3[var_13_6] + var_13_4[var_13_6] > 3 then
				break
			end
		end

		for iter_13_2, iter_13_3 in pairs(var_13_3) do
			if iter_13_3 + var_13_4[iter_13_2] > 3 then
				self:emit(LevelUIConst.HANDLE_SHOW_MSG_BOX, {
					modal = true,
					hideNo = true,
					content = i18n("chapter_tip_with_npc", var_13_5.name)
				})

				return
			end
		end
	end

	local var_13_7 = "chapter_autofight_flag_" .. self.chapter.id
	local var_13_8
	local var_13_9

	seriesAsync({
		function(arg_14_0)
			if PlayerPrefs.GetInt(var_13_7, 1) ~= 1 or PlayerPrefs.GetInt("autoFight_firstUse_sp", 0) == 1 or not self:getSPItem() then
				return arg_14_0()
			end

			PlayerPrefs.SetInt("autoFight_firstUse_sp", 1)
			PlayerPrefs.Save()

			local function var_14_0()
				self:clearSPBuff()

				return
			end

			self:emit(LevelUIConst.HANDLE_SHOW_MSG_BOX, {
				hideNo = true,
				content = i18n("autofight_special_operation_tip"),
				onYes = var_14_0,
				onNo = var_14_0
			})

			return
		end,
		function(arg_16_0)
			var_13_9 = var_13_0:GetActiveSPItemID()
			var_13_8 = var_13_0:isLoop() and self:GetOrderedDuties() or nil

			self:onCancel()
			arg_16_0()

			return
		end,
		function(arg_17_0)
			getProxy(ChapterProxy):SetLastFleetIndex(var_13_1)

			local var_17_0 = LevelMediator2.ON_TRACKING
			local var_17_1 = packEx(var_13_0.id, var_13_0.loopFlag, var_13_9, var_13_8, PlayerPrefs.GetInt(var_13_7, 1) == 1)

			if pg.m02:retrieveMediator(LevelMediator2.__cname) then
				pg.m02:sendNotification(var_17_0, var_17_1)

				return
			end

			local var_17_2 = getProxy(ContextProxy):getContextByMediator(LevelMediator2)

			if var_17_2 then
				var_17_2:extendData({
					ToTrackingData = {
						var_17_0,
						var_17_1
					}
				})
			end

			return
		end
	})

	return
end

function LevelFleetView:onCancel()
	self:clear()
	self:emit(LevelUIConst.HIDE_FLEET_SELECT)

	return
end

function LevelFleetView:InitUI()
	self.tfShipTpl = self._tf:Find("panel/Fixed/shiptpl")
	self.tfEmptyTpl = self._tf:Find("panel/Fixed/emptytpl")
	self.tfFleets = {
		[FleetType.Normal] = {
			self._tf:Find("panel/ShipList/fleet/1"),
			self._tf:Find("panel/ShipList/fleet/2")
		},
		[FleetType.Submarine] = {
			self._tf:Find("panel/ShipList/sub/1")
		},
		[FleetType.Support] = {
			self._tf:Find("panel/ShipList/support/1")
		}
	}

	local var_19_0 = self._tf:Find("panel/Fixed/RightTabs")
	local var_19_1

	if PLATFORM_CODE == PLATFORM_US then
		var_19_1 = self._tf:Find("panel/Fixed/RightTabs/hTplBtn") or self._tf:Find("panel/Fixed/RightTabs/vTplBtn")
	end

	local var_19_2 = {
		"formation_btn",
		"commander_btn",
		"duty_btn",
		"adjustment_btn"
	}

	for iter_19_0 = 1, #var_19_2 do
		local var_19_3 = Instantiate(var_19_1)

		var_19_3.name = var_19_2[iter_19_0]

		SetParent(tf(var_19_3), var_19_0)
		setActive(var_19_3, false)
	end

	self.tfLimit = self._tf:Find("panel/Fixed/limit_list/limit")
	self.tfLimitTips = self._tf:Find("panel/Fixed/limit_list/limit_tip")
	self.tfLimitElite = self._tf:Find("panel/Fixed/limit_list/limit_elite")
	self.tfLimitSubTip = self._tf:Find("panel/Fixed/limit_list/limit_sub_tip")
	self.tfLimitContainer = self._tf:Find("panel/Fixed/limit_list/limit_elite/limit_list")
	self.rtCostLimit = self._tf:Find("panel/Fixed/limit_list/cost_limit")
	self.btnBack = self._tf:Find("panel/Fixed/btnBack")
	self.btnGo = self._tf:Find("panel/Fixed/start_button")
	self.btnMultiple = self._tf:Find("panel/Fixed/multiple")
	self.formationToggle = self._tf:Find("panel/Fixed/RightTabs/formation_btn")
	self.commanderToggle = self._tf:Find("panel/Fixed/RightTabs/commander_btn")
	self.dutyToggle = self._tf:Find("panel/Fixed/RightTabs/duty_btn")
	self.adjustmentToggle = self._tf:Find("panel/Fixed/RightTabs/adjustment_btn")
	self.toggleMask = self._tf:Find("mask")
	self.toggleList = self._tf:Find("mask/list")
	self.toggles = {}

	setText(findTF(self.tfLimit, "text"), i18n("level_fleet_ship_desc"))
	setText(findTF(self.tfLimit, "text_sub"), i18n("level_fleet_sub_desc"))

	for iter_19_1 = 0, self.toggleList.childCount - 1 do
		table.insert(self.toggles, self.toggleList:Find("item" .. iter_19_1 + 1))
	end

	self.btnSp = self._tf:Find("panel/Fixed/sp")
	self.spMask = self._tf:Find("mask_sp")
	self.dutyItems = {}

	for iter_19_2 = 1, 2 do
		local var_19_4 = self._tf:Find(string.format("panel/ShipList/fleet/%d/DutySelect", iter_19_2))

		self.dutyItems[iter_19_2] = {}

		for iter_19_3 = 1, 4 do
			local var_19_5 = var_19_4:Find("Item" .. iter_19_3)

			self.dutyItems[iter_19_2][iter_19_3] = var_19_5

			setText(var_19_5:Find("Text"), i18n("autofight_function" .. iter_19_3))
		end
	end

	local var_19_6 = self._tf:Find("panel/ShipList/sub/1/DutySelect")

	self.dutyItems[3] = {}

	for iter_19_4 = 1, 2 do
		local var_19_7 = var_19_6:Find("Item" .. iter_19_4)

		self.dutyItems[3][iter_19_4] = var_19_7

		setText(var_19_7:Find("Text"), i18n("autofight_function" .. 6 - iter_19_4))
	end

	setActive(self.tfShipTpl, false)
	setActive(self.tfEmptyTpl, false)
	setActive(self.toggleMask, false)
	setActive(self.btnSp, false)
	setActive(self.spMask, false)
	setText(self._tf:Find("panel/Fixed/RightTabs/formation_btn/text"), i18n("autofight_formation"))
	setText(self._tf:Find("panel/Fixed/RightTabs/commander_btn/text"), i18n("autofight_cat"))
	setText(self._tf:Find("panel/Fixed/RightTabs/duty_btn/text"), i18n("autofight_function"))
	setText(self.adjustmentToggle:Find("text"), i18n("word_adjustFleet"))

	self.dropDown = self._tf:Find("panel/FixedTop/Dropdown")

	setActive(self.dropDown, false)

	self.dropDownSide = self._tf:Find("panel/Fixed/title/DropSide")

	onButton(self, self.dropDownSide:Find("Click"), function()
		setActive(self.dropDown, not isActive(self.dropDown))

		return
	end, SFX_UI_CLICK)
	onButton(self, self.dropDown, function()
		setActive(self.dropDown, not isActive(self.dropDown))

		return
	end, SFX_UI_CLICK)
	onButton(self, self.dropDownSide:Find("Layout/Item3"), function()
		self:emit(LevelUIConst.HANDLE_SHOW_MSG_BOX, {
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.fleet_antisub_range_tip.tip
		})

		return
	end, SFX_PANEL)
	assert(OPEN_AIR_DOMINANCE, "Not Prepare for BANNED OPEN_AIR_DOMINANCE")

	self.btnASHelp = self.dropDownSide:Find("help")

	setText(self.dropDownSide:Find("Layout/Item1/Text"), i18n("word_investigate"))
	setText(self.dropDownSide:Find("Layout/Item2/Text"), i18n("word_attr_ac"))
	setText(self.dropDownSide:Find("Layout/Item3/Text"), i18n("fleet_antisub_range"))
	setText(self.dropDown:Find("Investigation/Text"), i18n("level_scene_title_word_1"))
	setText(self.dropDown:Find("Airsupport/Text"), i18n("level_scene_title_word_3"))

	self.supportFleetHelp = self._tf:Find("panel/Fixed/title/Image/Help")

	onButton(self, self.supportFleetHelp, function()
		local var_23_0 = self.chapter:IsSupportSubmarineStage() and "help_supportfleet_16_submarine" or self.chapter:IsFogStage() and "help_supportfleet_16" or "help_supportfleet"

		self:emit(LevelUIConst.HANDLE_SHOW_MSG_BOX, {
			type = MSGBOX_TYPE_HELP,
			helps = i18n(var_23_0)
		})

		return
	end, SFX_PANEL)

	for iter_19_5 = 1, 2 do
		for iter_19_6 = 1, 4 do
			onButton(self, self.dutyItems[iter_19_5][iter_19_6], function()
				self:SetDuty(iter_19_5, iter_19_6)

				return
			end)
		end
	end

	for iter_19_7 = 1, 2 do
		onButton(self, self.dutyItems[3][iter_19_7], function()
			self:SetAutoSub(iter_19_7 == 1)

			return
		end)
	end

	return
end

function LevelFleetView:onCancelSupport(arg_26_1)
	if arg_26_1 then
		self:emit(LevelMediator2.ON_UPDATE_CUSTOM_FLEET, self.chapter)
	end

	return
end

function LevelFleetView:set(arg_27_1, arg_27_2, arg_27_3)
	self.chapter = arg_27_1
	self.mode = var_0_2.SELECT
	self.selects = arg_27_3
	self.chapterASValue = self.chapter:getConfig("air_dominance")
	self.suggestionValue = self.chapter:getConfig("best_air_dominance")

	self:SetDutyTabEnabled(arg_27_1:isLoop())

	self.supportFleet = self.chapter:getSupportFleet()

	local var_27_0 = self:getLimitNums(FleetType.Support) > 0

	setActive(self.supportFleetHelp, var_27_0)

	if var_27_0 then
		self.displayMode = var_0_3.ADDITION_SUPPORT or var_0_3.NORMAL
	end

	self:SwitchDisplayMode()

	self.fleets = underscore(arg_27_2):chain():values():filter(function(arg_28_0)
		return arg_28_0:isRegularFleet()
	end):sort(CompareFuncs({
		function(arg_29_0)
			return arg_29_0.id
		end
	})):value()
	self.selectIds = {
		[FleetType.Normal] = {},
		[FleetType.Submarine] = {}
	}

	for iter_27_0, iter_27_1 in ipairs(arg_27_3 or {}) do
		local var_27_1 = self:getFleetById(iter_27_1)

		if var_27_1 then
			local var_27_2 = var_27_1:getFleetType()

			if #self.selectIds[var_27_2] < self:getLimitNums(var_27_2) then
				table.insert(self.selectIds[var_27_2], iter_27_1)
			end
		end
	end

	self.duties = {}

	local var_27_3 = PlayerPrefs.GetInt("lastFleetDuty_" .. (self.chapter.id or 0), 0)

	if var_27_3 > 0 then
		local var_27_4 = bit.band(var_27_3, 255)
		local var_27_5 = bit.band(bit.rshift(var_27_3, 8), 255)

		if var_27_4 > 0 and var_27_5 > 0 then
			self.duties[var_27_4] = var_27_5
		end
	end

	setActive(self.tfLimitElite, false)
	setActive(self.tfLimitSubTip, false)
	setActive(self.tfLimitTips, false)
	setActive(self.tfLimit, true)

	local var_27_6 = self.chapter:isLoop() and self.chapter:getConfig("use_oil_limit") or {}

	setActive(self.rtCostLimit, #var_27_6 > 0)
	setText(self.rtCostLimit:Find("text"), i18n("formationScene_use_oil_limit_tip"))

	if #var_27_6 > 0 then
		setActive(self.rtCostLimit:Find("cost_noraml"), var_27_6[1] > 0)
		setText(self.rtCostLimit:Find("cost_noraml/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_enemy"), var_27_6[1]))
		setActive(self.rtCostLimit:Find("cost_boss"), var_27_6[2] > 0)
		setText(self.rtCostLimit:Find("cost_boss/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_flagship"), var_27_6[2]))
		setActive(self.rtCostLimit:Find("cost_sub"), var_27_6[3] > 0)
		setText(self.rtCostLimit:Find("cost_sub/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_submarine"), var_27_6[3]))
	end

	onButton(self, self.btnGo, function()
		local function var_30_0()
			self:onConfirm()

			return
		end

		local var_30_1 = self:getSPItem()

		if var_30_1 and var_30_1 ~= 0 then
			if PlayerPrefs.GetInt("SPOPItemReminder") ~= 1 then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_SINGLE_ITEM,
					drop = {
						count = 1,
						type = DROP_TYPE_ITEM,
						id = var_30_1
					},
					intro = i18n("levelScene_select_SP_OP_reminder", Item.getConfigData(var_30_1).name, pg.benefit_buff_template[Chapter.GetSPBuffByItem(var_30_1)].desc),
					onYes = function()
						PlayerPrefs.SetInt("SPOPItemReminder", 1)
						PlayerPrefs.Save()
						var_30_0()

						return
					end
				})
			else
				var_30_0()
			end
		else
			var_30_0()
		end

		return
	end, SFX_UI_WEIGHANCHOR_GO)
	setActive(self.btnMultiple, AutoBotCommand.autoBotSatisfied() and self.chapter:isLoop())
	onButton(self, self.btnMultiple, function()
		self:emit(LevelUIConst.OPEN_NORMAL_CONTINUOUS_WINDOW, self.chapter, self:getSelectIds(), self:getSPItem(), (self:GetOrderedDuties()))

		return
	end, SFX_PANEL)
	onButton(self, self.btnASHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("help_battle_ac")
		})

		return
	end, SFX_UI_CLICK)
	onButton(self, self.btnBack, function()
		self:onCancel()
		self:onCancelSupport(true)

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("bg"), function()
		self:onCancel()
		self:onCancelSupport(true)

		return
	end, SFX_CANCEL)
	onButton(self, self.toggleMask, function()
		self:hideToggleMask()

		return
	end, SFX_CANCEL)
	onToggle(self, self.formationToggle, function(arg_38_0)
		if arg_38_0 then
			self.contextData.tabIndex = LevelFleetView.TabIndex.Formation

			self:updateFleets()
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.commanderToggle, function(arg_39_0)
		if arg_39_0 then
			self.contextData.tabIndex = LevelFleetView.TabIndex.Commander

			self:updateFleets()
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.dutyToggle, function(arg_40_0)
		if arg_40_0 then
			self.contextData.tabIndex = LevelFleetView.TabIndex.Duty

			self:updateFleets()
		end

		return
	end, SFX_PANEL)
	setActive(self.formationToggle, true)
	setActive(self.commanderToggle, self.openedCommanerSystem)
	setActive(self.dutyToggle, self.dutyTabEnabled)
	setActive(self.adjustmentToggle, false)
	self:clearFleets()
	self:updateFleets()
	self:updateLimit()
	self:updateASValue()
	self:UpdateSonarRange()
	self:UpdateInvestigation()

	return
end

function LevelFleetView:getFleetById(arg_41_1)
	return _.detect(self.fleets, function(arg_42_0)
		return arg_42_0.id == arg_41_1
	end)
end

function LevelFleetView:getLimitNums(arg_43_1)
	local var_43_0 = 0

	if arg_43_1 == FleetType.Normal then
		var_43_0 = self.chapter:getConfig("group_num")
	elseif arg_43_1 == FleetType.Submarine then
		var_43_0 = self.chapter:getConfig("submarine_num")
	elseif arg_43_1 == FleetType.Support then
		var_43_0 = self.chapter:getConfig("support_group_num")
	end

	return var_43_0
end

function LevelFleetView:getSelectIds()
	local var_44_0 = {}

	for iter_44_0, iter_44_1 in ipairs({
		FleetType.Normal,
		FleetType.Submarine
	}) do
		for iter_44_2, iter_44_3 in ipairs(self.selectIds[iter_44_1]) do
			if iter_44_3 > 0 then
				table.insert(var_44_0, iter_44_3)
			end
		end
	end

	return var_44_0
end

function LevelFleetView:updateFleets()
	for iter_45_0, iter_45_1 in pairs(self.tfFleets) do
		for iter_45_2 = 1, #iter_45_1 do
			if iter_45_0 == FleetType.Support then
				self:UpdateEliteFleet(iter_45_0, iter_45_2)
			else
				self:updateFleet(iter_45_0, iter_45_2)
			end
		end
	end

	self:RefreshDutyBar()

	return
end

function LevelFleetView:updateLimit()
	setText(self.tfLimit:Find("number"), string.format("%d/%d", #_.filter(self.selectIds[FleetType.Normal], function(arg_47_0)
		return arg_47_0 > 0
	end), (self:getLimitNums(FleetType.Normal))))
	setText(self.tfLimit:Find("number_sub"), string.format("%d/%d", #_.filter(self.selectIds[FleetType.Submarine], function(arg_48_0)
		return arg_48_0 > 0
	end), (self:getLimitNums(FleetType.Submarine))))

	return
end

function LevelFleetView:selectFleet(arg_49_1, arg_49_2, arg_49_3)
	local var_49_0 = self.selectIds[arg_49_1]

	if arg_49_3 > 0 and table.contains(var_49_0, arg_49_3) then
		return
	end

	if arg_49_1 == FleetType.Normal and self:getLimitNums(arg_49_1) > 0 and arg_49_3 == 0 and #_.filter(var_49_0, function(arg_50_0)
		return arg_50_0 > 0
	end) == 1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("level_fleet_lease_one_ship"))

		return
	end

	local var_49_1 = self:getFleetById(arg_49_3)

	if var_49_1 then
		if not var_49_1:isUnlock() then
			return
		end

		if var_49_1:isLegalToFight() ~= true then
			pg.TipsMgr.GetInstance():ShowTips(i18n("level_fleet_not_enough"))

			return
		end
	end

	local var_49_2 = {
		not self:IsListOfFleetEmpty(1) or nil,
		not self:IsListOfFleetEmpty(2) or nil
	}

	var_49_0[arg_49_2] = arg_49_3

	self:updateFleet(arg_49_1, arg_49_2)
	self:updateLimit()
	self:updateASValue()
	self:UpdateSonarRange()
	self:RefreshDutyBar()

	if self.dutyTabEnabled and table.getCount(var_49_2) == 2 and table.getCount({
		not self:IsListOfFleetEmpty(1) or nil,
		not self:IsListOfFleetEmpty(2) or nil
	}) == 1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("autofight_change_tip"))
	end

	self:UpdateInvestigation()

	return
end

function LevelFleetView:updateFleet(arg_51_1, arg_51_2)
	local var_51_0 = self.contextData.tabIndex == LevelFleetView.TabIndex.Formation
	local var_51_1 = self.contextData.tabIndex == LevelFleetView.TabIndex.Commander
	local var_51_2 = self.contextData.tabIndex == LevelFleetView.TabIndex.Duty
	local var_51_3 = self.contextData.tabIndex == LevelFleetView.TabIndex.Adjustment
	local var_51_4 = self:getFleetById(self.selectIds[arg_51_1][arg_51_2])
	local var_51_5 = arg_51_2 <= self:getLimitNums(arg_51_1)
	local var_51_6 = self.tfFleets[arg_51_1][arg_51_2]
	local var_51_7 = findTF(self.tfFleets[arg_51_1][arg_51_2], "bg/name")
	local var_51_8 = self.tfFleets[arg_51_1][arg_51_2]:Find("btn_select")
	local var_51_9 = self.tfFleets[arg_51_1][arg_51_2]:Find("btn_clear")
	local var_51_10 = self.tfFleets[arg_51_1][arg_51_2]:Find("blank")
	local var_51_11 = self.tfFleets[arg_51_1][arg_51_2]:Find("commander")
	local var_51_12 = self.tfFleets[arg_51_1][arg_51_2]:Find("adjustment_flag")

	setActive(self.tfFleets[arg_51_1][arg_51_2]:Find("btn_recom"), false)
	setActive(self.tfFleets[arg_51_1][arg_51_2]:Find("selected"), false)
	setText(var_51_7, "")

	local var_51_13 = var_51_6:Find(TeamType.Main)
	local var_51_14 = var_51_6:Find(TeamType.Vanguard)

	if not var_51_5 then
		setActive(var_51_9, false)
		setActive(var_51_8, false)
		setActive(var_51_11, false)
		setActive(var_51_12, false)
		setActive(var_51_10, true)
		setActive(var_51_13, false)

		if arg_51_1 == FleetType.Normal then
			setActive(var_51_14, false)
		end

		return
	end

	setActive(var_51_9, var_51_0)
	setActive(var_51_8, var_51_0)
	setActive(var_51_11, var_51_1 and var_51_4)
	setActive(var_51_12, var_51_3)
	setActive(var_51_10, var_51_2 or var_51_3 or var_51_1 and not var_51_4)
	setText(var_51_7, var_51_4 and var_51_4:GetName() or "")
	setActive(var_51_13, var_51_4)

	if arg_51_1 == FleetType.Normal then
		setActive(var_51_14, var_51_4)
	end

	if var_51_4 then
		if arg_51_1 == FleetType.Submarine then
			self:updateShips(var_51_13, var_51_4.subShips)
		else
			self:updateShips(var_51_13, var_51_4.mainShips)
			self:updateShips(var_51_14, var_51_4.vanguardShips)
		end

		self:updateCommanders(var_51_11, var_51_4)
	end

	onButton(self, var_51_8, function()
		self.toggleList.position = (var_51_8.position + var_51_9.position) / 2
		self.toggleList.anchoredPosition = self.toggleList.anchoredPosition + Vector2(-self.toggleList.rect.width / 2, -var_51_8.rect.height / 2)

		self:showToggleMask(arg_51_1, function(arg_53_0)
			self:hideToggleMask()
			self:selectFleet(arg_51_1, arg_51_2, arg_53_0)

			return
		end)

		return
	end, SFX_UI_CLICK)
	onButton(self, var_51_9, function()
		self:selectFleet(arg_51_1, arg_51_2, 0)

		return
	end, SFX_UI_CLICK)

	return
end

function LevelFleetView:updateCommanders(arg_55_1, arg_55_2)
	for iter_55_0 = 1, 2 do
		local var_55_0 = arg_55_2:getCommanderByPos(iter_55_0)
		local var_55_1 = arg_55_1:Find("pos" .. iter_55_0)
		local var_55_2 = var_55_1:Find("add")
		local var_55_3 = var_55_1:Find("info")

		setActive(var_55_2, not var_55_0)
		setActive(var_55_3, var_55_0)

		if var_55_0 then
			setImageSprite(var_55_3:Find("frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(var_55_0:getRarity())))
			GetImageSpriteFromAtlasAsync("CommanderHrz/" .. var_55_0:getPainting(), "", var_55_3:Find("mask/icon"))
		end

		onButton(self, var_55_2, function()
			self:emit(LevelUIConst.OPEN_COMMANDER_PANEL, arg_55_2, self.chapter)

			return
		end, SFX_PANEL)
		onButton(self, var_55_3, function()
			self:emit(LevelUIConst.OPEN_COMMANDER_PANEL, arg_55_2, self.chapter)

			return
		end, SFX_PANEL)
	end

	return
end

function LevelFleetView:updateShips(arg_58_1, arg_58_2)
	local var_58_0 = UIItemList.New(arg_58_1, self.tfShipTpl)

	var_58_0:make(function(arg_59_0, arg_59_1, arg_59_2)
		if arg_59_0 == UIItemList.EventUpdate then
			local var_59_0 = getProxy(BayProxy):getShipById(arg_58_2[arg_59_1 + 1])

			updateShip(arg_59_2, var_59_0)
			setActive(findTF(arg_59_2, "ship_type"), false)

			local var_59_1 = arg_59_2:Find("icon_bg/energy")
			local var_59_2 = var_59_0:getEnergeConfig()

			if var_59_2 and var_59_2.id <= 2 then
				setActive(var_59_1, true)
				GetImageSpriteFromAtlasAsync("energy", var_59_2.icon, var_59_1)
			else
				setActive(var_59_1, false)
			end
		end

		return
	end)
	var_58_0:align(#arg_58_2)

	for iter_58_0, iter_58_1 in ipairs(arg_58_2) do
		local var_58_1 = GetOrAddComponent(arg_58_1:GetChild(iter_58_0 - 1), "UILongPressTrigger").onLongPressed

		pg.DelegateInfo.Add(self, var_58_1)
		var_58_1:RemoveAllListeners()
		var_58_1:AddListener(function()
			self:emit(LevelMediator2.ON_SHIP_DETAIL, {
				id = iter_58_1,
				chapter = self.chapter
			})

			return
		end)
	end

	return
end

function LevelFleetView:showToggleMask(arg_61_1, arg_61_2)
	setActive(self.toggleMask, true)

	local var_61_0 = _.filter(self.fleets, function(arg_62_0)
		return arg_62_0:getFleetType() == arg_61_1
	end)

	for iter_61_0, iter_61_1 in ipairs(self.toggles) do
		local var_61_1 = var_61_0[iter_61_0]

		setActive(iter_61_1, var_61_0[iter_61_0])

		if var_61_0[iter_61_0] then
			local var_61_2 = iter_61_1:GetComponent(typeof(Toggle))
			local var_61_3 = iter_61_1:Find("lock")
			local var_61_4, var_61_5 = var_61_0[iter_61_0]:isUnlock()

			setToggleEnabled(iter_61_1, var_61_4)
			setActive(var_61_3, not var_61_4)

			local var_61_6 = table.contains(self.selectIds[arg_61_1], var_61_0[iter_61_0].id)

			setActive(iter_61_1:Find("on"), var_61_6)
			setActive(iter_61_1:Find("off"), not var_61_6)

			if var_61_4 then
				var_61_2.isOn = false

				onToggle(self, iter_61_1, function(arg_63_0)
					if arg_63_0 then
						setActive(self.toggleMask, false)
						arg_61_2(var_61_1.id)
					end

					return
				end, SFX_UI_TAG)
			else
				onButton(self, var_61_3, function()
					pg.TipsMgr.GetInstance():ShowTips(var_61_5)

					return
				end, SFX_UI_CLICK)
			end
		end
	end

	return
end

function LevelFleetView:hideToggleMask()
	setActive(self.toggleMask, false)

	return
end

function LevelFleetView:clearFleets()
	for iter_66_0, iter_66_1 in pairs(self.tfFleets) do
		_.each(iter_66_1, function(arg_67_0)
			self:clearFleet(arg_67_0)

			return
		end)
	end

	return
end

function LevelFleetView:UpdateInvestigation()
	if not self.chapter:existAmbush() then
		self:UpdateLoopInvestigation()

		return
	end

	local var_68_0 = 0

	for iter_68_0 = 1, 2 do
		local var_68_2 = self:getFleetById(self.selectIds[FleetType.Normal][iter_68_0] or 0)

		var_68_0 = math.max(var_68_0, var_68_2 and math.floor(var_68_2:getInvestSums(true)) or 0)
	end

	self:UpdateInvestigationComparision(var_68_0, (self.chapter:getConfig("avoid_require")))

	return
end

function LevelFleetView:UpdateEliteInvestigation()
	if not self.chapter:existAmbush() then
		self:UpdateLoopInvestigation()

		return
	end

	local var_69_0 = 0

	for iter_69_0 = 1, 2 do
		local var_69_1 = 0

		if iter_69_0 <= self.chapter:GetNomralFleetMaxCount() then
			local var_69_2 = {}

			for iter_69_1, iter_69_2 in pairs(self.eliteCommanderList[iter_69_0]) do
				table.insert(var_69_2, {
					pos = iter_69_1,
					id = iter_69_2
				})
			end

			var_69_1 = math.floor(TypedFleet.New({
				ship_list = self.eliteFleetList[iter_69_0],
				commanders = var_69_2,
				fleetType = FleetType.Normal
			}):getInvestSums())
		end

		var_69_0 = math.max(var_69_0, var_69_1)
	end

	self:UpdateInvestigationComparision(var_69_0, (self.chapter:getConfig("avoid_require")))

	return
end

function LevelFleetView:UpdateLoopInvestigation()
	local var_70_0 = self.dropDown:Find("Investigation")

	setText(var_70_0:Find("Value1"), "-")
	setText(var_70_0:Find("Value2"), "-")
	triggerToggle(self.dropDownSide:Find("Layout/Item1/Dot"), true)

	return
end

function LevelFleetView:UpdateInvestigationComparision(arg_71_1, arg_71_2)
	arg_71_1 = math.floor(arg_71_1)

	local var_71_0 = self.dropDown:Find("Investigation")
	local var_71_1 = arg_71_2 <= arg_71_1

	setText(var_71_0:Find("Value1"), setColorStr(arg_71_1, arg_71_2 <= arg_71_1 and "#51FF55" or COLOR_WHITE))
	setText(var_71_0:Find("Value2"), arg_71_2)
	triggerToggle(self.dropDownSide:Find("Layout/Item1/Dot"), var_71_1)

	return
end

function LevelFleetView:updateASValue()
	if self.chapterASValue <= 0 then
		self:UpdateBannedAS()

		return
	end

	local var_72_0 = 0

	for iter_72_0 = 1, 2 do
		local var_72_2 = self:getFleetById(self.selectIds[FleetType.Normal][iter_72_0] or 0)

		var_72_0 = var_72_0 + (var_72_2 and var_72_2:getFleetAirDominanceValue() or 0)
	end

	for iter_72_1 = 1, 1 do
		local var_72_4 = self:getFleetById(self.selectIds[FleetType.Submarine][iter_72_1] or 0)

		var_72_0 = var_72_0 + (var_72_4 and var_72_4:getFleetAirDominanceValue() or 0)
	end

	self:UpdateASComparision(var_72_0, self.suggestionValue)

	return
end

function LevelFleetView:updateEliteASValue()
	if self.chapterASValue <= 0 then
		self:UpdateBannedAS()

		return
	end

	local var_73_0 = getProxy(BayProxy)
	local var_73_1 = 0

	for iter_73_0, iter_73_1 in ipairs(self.eliteFleetList) do
		local var_73_2 = {}

		for iter_73_2, iter_73_3 in pairs(self.eliteCommanderList[iter_73_0]) do
			var_73_2[iter_73_2] = getProxy(CommanderProxy):RawGetCommanderById(iter_73_3)
		end

		for iter_73_4, iter_73_5 in ipairs(iter_73_1) do
			var_73_1 = var_73_1 + calcAirDominanceValue(var_73_0:RawGetShipById(iter_73_5), var_73_2)
		end
	end

	self:UpdateASComparision(var_73_1, self.suggestionValue)

	return
end

function LevelFleetView:UpdateBannedAS()
	local var_74_0 = self.dropDown:Find("Airsupport")

	setText(var_74_0:Find("Value1"), "-")
	setText(var_74_0:Find("Value2"), "-")
	triggerToggle(self.dropDownSide:Find("Layout/Item2/Dot"), true)

	return
end

function LevelFleetView:UpdateASComparision(arg_75_1, arg_75_2)
	arg_75_1 = math.floor(arg_75_1)

	local var_75_0 = self.dropDown:Find("Airsupport")

	setText(var_75_0:Find("Text"), i18n("level_scene_title_word_3"))

	local var_75_1 = arg_75_2 < arg_75_1

	setText(var_75_0:Find("Value1"), setColorStr(arg_75_1, arg_75_2 < arg_75_1 and "#51FF55" or COLOR_WHITE))
	setText(var_75_0:Find("Value2"), arg_75_2)
	triggerToggle(self.dropDownSide:Find("Layout/Item2/Dot"), var_75_1)

	return
end

function LevelFleetView:UpdateSonarRange()
	for iter_76_0 = 1, 2 do
		local var_76_1 = self:getFleetById(self.selectIds[FleetType.Normal][iter_76_0] or 0)

		self:UpdateSonarRangeValues(iter_76_0, var_76_1 and math.floor(var_76_1:GetFleetSonarRange()) or 0)
	end

	return
end

function LevelFleetView:UpdateEliteSonarRange()
	for iter_77_0 = 1, 2 do
		if not self.eliteFleetList[iter_77_0] then
			self:UpdateSonarRangeValues(iter_77_0, 0)
		else
			local var_77_0 = self.eliteFleetList[iter_77_0]
			local var_77_1 = {}

			for iter_77_1, iter_77_2 in pairs(self.eliteCommanderList[iter_77_0]) do
				table.insert(var_77_1, {
					pos = iter_77_1,
					id = iter_77_2
				})
			end

			local var_77_2 = TypedFleet.New({
				ship_list = var_77_0,
				commanders = var_77_1,
				fleetType = FleetType.Normal
			})

			self:UpdateSonarRangeValues(iter_77_0, var_77_2 and math.floor(var_77_2:GetFleetSonarRange()) or 0)
		end
	end

	return
end

function LevelFleetView:UpdateSonarRangeValues(arg_78_1, arg_78_2)
	setText(self.dropDownSide:Find("Layout/Item3/Values"):GetChild(arg_78_1 - 1), arg_78_2)

	return
end

function LevelFleetView:clearFleet(arg_79_1)
	local var_79_0 = arg_79_1:Find(TeamType.Main)
	local var_79_1 = arg_79_1:Find(TeamType.Vanguard)

	if var_79_0 then
		removeAllChildren(var_79_0)
	end

	if var_79_1 then
		removeAllChildren(var_79_1)
	end

	return
end

function LevelFleetView:clear()
	self.contextData.tabIndex = nil
	self.duties = nil

	return
end

function LevelFleetView:onCancelHard(arg_81_1)
	if arg_81_1 then
		self:emit(LevelMediator2.ON_UPDATE_CUSTOM_FLEET, self.chapter)
	end

	self:emit(LevelUIConst.HIDE_FLEET_EDIT)

	return
end

function LevelFleetView:setHardShipVOs(arg_82_1)
	self.shipVOs = arg_82_1

	return
end

function LevelFleetView:setOnHard(arg_83_1)
	self.chapter = arg_83_1
	self.mode = var_0_2.EDIT
	self.eliteFleetList = self.chapter:getEliteFleetList()
	self.eliteCommanderList = self.chapter:getEliteFleetCommanders()
	self.propetyLimitation = self.chapter:getConfig("property_limitation")
	self.chapterASValue = self.chapter:getConfig("air_dominance")
	self.suggestionValue = self.chapter:getConfig("best_air_dominance")
	self.typeLimitations = self.chapter:getConfig("limitation")

	self:SetDutyTabEnabled(arg_83_1:isLoop())

	local var_83_0 = self:getLimitNums(FleetType.Support) > 0

	setActive(self.supportFleetHelp, var_83_0)

	if var_83_0 then
		self.displayMode = var_0_3.ADDITION_SUPPORT or var_0_3.NORMAL
	end

	self:SwitchDisplayMode()

	self.duties = {}

	local var_83_1 = PlayerPrefs.GetInt("lastFleetDuty_" .. (self.chapter.id or 0), 0)

	if var_83_1 > 0 then
		local var_83_2 = bit.band(var_83_1, 255)
		local var_83_3 = bit.band(bit.rshift(var_83_1, 8), 255)

		if var_83_2 > 0 and var_83_3 > 0 then
			self.duties[var_83_2] = var_83_3
		end
	end

	onButton(self, self.btnGo, function()
		local var_84_0 = "chapter_autofight_flag_" .. self.chapter.id
		local var_84_1 = self.chapter
		local var_84_2
		local var_84_3

		seriesAsync({
			function(arg_85_0)
				if PlayerPrefs.GetInt(var_84_0, 1) ~= 1 or not self:getSPItem() or PlayerPrefs.GetInt("autoFight_firstUse_sp", 0) == 1 then
					return arg_85_0()
				end

				PlayerPrefs.SetInt("autoFight_firstUse_sp", 1)
				PlayerPrefs.Save()

				local function var_85_0()
					self:clearSPBuff()

					return
				end

				self:emit(LevelUIConst.HANDLE_SHOW_MSG_BOX, {
					hideNo = true,
					content = i18n("autofight_special_operation_tip"),
					onYes = var_85_0,
					onNo = var_85_0
				})

				return
			end,
			function(arg_87_0)
				var_84_2 = self.chapter:GetActiveSPItemID()
				var_84_3 = self.chapter:isLoop() and self:GetOrderedDuties() or nil

				self:clear()
				self:onCancelHard()
				arg_87_0()

				return
			end,
			function(arg_88_0)
				local var_88_0 = LevelMediator2.ON_ELITE_TRACKING
				local var_88_1 = packEx(var_84_1.id, var_84_1.loopFlag, var_84_2, var_84_3, PlayerPrefs.GetInt(var_84_0, 1) == 1)

				if pg.m02:retrieveMediator(LevelMediator2.__cname) then
					pg.m02:sendNotification(var_88_0, var_88_1)

					return
				end

				local var_88_2 = getProxy(ContextProxy):getContextByMediator(LevelMediator2)

				if var_88_2 then
					var_88_2:extendData({
						ToTrackingData = {
							var_88_0,
							var_88_1
						}
					})
				end

				return
			end
		})

		return
	end, SFX_UI_WEIGHANCHOR_GO)
	setActive(self.btnMultiple, AutoBotCommand.autoBotSatisfied() and self.chapter:isLoop())
	onButton(self, self.btnMultiple, function()
		self:emit(LevelUIConst.OPEN_ELITE_CONTINUOUS_WINDOW, self.chapter, self:getSPItem(), (self:GetOrderedDuties()))

		return
	end, SFX_PANEL)
	onButton(self, self.btnASHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("help_battle_ac")
		})

		return
	end, SFX_UI_CLICK)
	onButton(self, self.btnBack, function()
		self:clear()
		self:onCancelHard(true)

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("bg"), function()
		self:clear()
		self:onCancelHard(true)

		return
	end, SFX_CANCEL)
	onToggle(self, self.commanderToggle, function(arg_93_0)
		if arg_93_0 then
			self.contextData.tabIndex = LevelFleetView.TabIndex.Commander

			self:flush()
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.formationToggle, function(arg_94_0)
		if arg_94_0 then
			self.contextData.tabIndex = LevelFleetView.TabIndex.Formation

			self:flush()
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.dutyToggle, function(arg_95_0)
		if arg_95_0 then
			self.contextData.tabIndex = LevelFleetView.TabIndex.Duty

			self:flush()
		end

		return
	end, SFX_UI_TAG)
	onToggle(self, self.adjustmentToggle, function(arg_96_0)
		if arg_96_0 then
			self.contextData.tabIndex = LevelFleetView.TabIndex.Adjustment

			self:flush()
		end

		return
	end, SFX_PANEL)
	setActive(self.formationToggle, true)
	setActive(self.commanderToggle, self.openedCommanerSystem)
	setActive(self.dutyToggle, self.dutyTabEnabled)
	setActive(self.adjustmentToggle, true)
	self:flush()

	return
end

function LevelFleetView:flush()
	self:updateEliteLimit()
	self:updateEliteASValue()

	self.lastFleetValidStatus = self.lastFleetValidStatus or {}

	local var_97_0 = {
		not self:IsListOfFleetEmpty(1) or nil,
		not self:IsListOfFleetEmpty(2) or nil
	}

	if self.dutyTabEnabled and table.getCount(self.lastFleetValidStatus) == 2 and table.getCount(var_97_0) == 1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("autofight_change_tip"))
	end

	self.lastFleetValidStatus = var_97_0

	self:updateEliteFleets()
	self:UpdateEliteSonarRange()
	self:UpdateEliteInvestigation()

	return
end

function LevelFleetView:updateEliteLimit()
	setActive(self.toggleMask, false)
	setActive(self.tfLimit, false)
	setActive(self.tfLimitTips, #self.propetyLimitation == 0)
	setActive(self.tfLimitElite, #self.propetyLimitation > 0)
	setActive(self.tfLimitSubTip, #self.propetyLimitation > 0)

	if #self.propetyLimitation > 0 then
		local var_98_0, var_98_1 = self.chapter:IsPropertyLimitationSatisfy()
		local var_98_2 = UIItemList.New(self.tfLimitContainer, self.tfLimitContainer:GetChild(0))

		var_98_2:make(function(arg_99_0, arg_99_1, arg_99_2)
			arg_99_1 = arg_99_1 + 1

			if arg_99_0 == UIItemList.EventUpdate then
				local var_99_0, var_99_1, var_99_2, var_99_3 = unpack(self.propetyLimitation[arg_99_1])

				arg_99_2:Find("Text"):GetComponent(typeof(Text)).color = var_98_0[arg_99_1] == 1 and Color.New(1, 0.9607843137254902, 0.5019607843137255) or Color.New(0.9568627450980393, 0.30196078431372547, 0.30196078431372547)

				setActive(arg_99_2, true)
				setText(arg_99_2:Find("Text"), (AttributeType.EliteCondition2Name(var_99_0, var_99_3) .. AttributeType.eliteConditionCompareTip(var_99_1) .. var_99_2) .. "（" .. var_98_1[var_99_0] .. "）")
			end

			return
		end)
		var_98_2:align(#self.propetyLimitation)
		setActive(self.tfLimitSubTip, self.chapter:getConfig("submarine_num") > 0)
	end

	local var_98_3 = self.chapter:isLoop() and self.chapter:getConfig("use_oil_limit") or {}

	setActive(self.rtCostLimit, #var_98_3 > 0)
	setText(self.rtCostLimit:Find("text"), i18n("formationScene_use_oil_limit_tip"))

	if #var_98_3 > 0 then
		setActive(self.rtCostLimit:Find("cost_noraml"), var_98_3[1] > 0)
		setText(self.rtCostLimit:Find("cost_noraml/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_enemy"), var_98_3[1]))
		setActive(self.rtCostLimit:Find("cost_boss"), var_98_3[2] > 0)
		setText(self.rtCostLimit:Find("cost_boss/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_flagship"), var_98_3[2]))
		setActive(self.rtCostLimit:Find("cost_sub"), var_98_3[3] > 0)
		setText(self.rtCostLimit:Find("cost_sub/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_submarine"), var_98_3[3]))
	end

	return
end

function LevelFleetView:initAddButton(arg_100_1, arg_100_2, arg_100_3, arg_100_4)
	local var_100_0 = self.eliteFleetList[arg_100_4]
	local var_100_1 = {}
	local var_100_2 = {}

	for iter_100_0, iter_100_1 in ipairs(self.eliteFleetList[arg_100_4]) do
		var_100_1[self.shipVOs[iter_100_1]] = true

		if not arg_100_2 or arg_100_2 == self.shipVOs[iter_100_1]:getTeamType() then
			table.insert(var_100_2, iter_100_1)
		end
	end

	removeAllChildren(arg_100_1)

	local var_100_3 = 0
	local var_100_4 = false
	local var_100_5 = 0

	arg_100_3 = LevelFleetView.sortTeamLimitation(arg_100_3)

	local var_100_6 = arg_100_1:GetComponent("ContentSizeFitter")
	local var_100_7 = arg_100_1:GetComponent("HorizontalLayoutGroup")

	var_100_6.enabled = true
	var_100_7.enabled = true
	self.isDraging = false

	for iter_100_2 = 1, 3 do
		local var_100_9
		local var_100_10

		if var_100_2[iter_100_2] then
			local var_100_11 = self.shipVOs[var_100_2[iter_100_2]] or nil

			if var_100_11 then
				for iter_100_3, iter_100_4 in ipairs(arg_100_3) do
					if ShipType.ContainInLimitBundle(iter_100_4, var_100_11:getShipType()) then
						var_100_9 = var_100_11
						var_100_10 = iter_100_4

						table.remove(arg_100_3, iter_100_3)

						var_100_4 = var_100_4 or iter_100_4 ~= 0

						break
					end
				end

				goto label_100_0
			end
		end

		var_100_10 = arg_100_3[1]

		table.remove(arg_100_3, 1)

		::label_100_0::

		if var_100_10 == 0 then
			var_100_5 = var_100_5 + 1
		end

		local var_100_12 = var_100_9 and cloneTplTo(self.tfShipTpl, arg_100_1) or cloneTplTo(self.tfEmptyTpl, arg_100_1)

		setActive(var_100_12, true)

		if var_100_9 then
			updateShip(var_100_12, var_100_9)
			setActive(var_100_12:Find("event_block"), var_100_9:getFlag("inEvent"))

			var_100_1[var_100_9] = true
		else
			var_100_3 = var_100_3 + 1
		end

		setActive(var_100_12:Find("ship_type"), var_100_10 and var_100_10 ~= 0)

		if var_100_10 and var_100_10 ~= 0 then
			if type(var_100_10) == "number" then
				setImageSprite(var_100_12:Find("ship_type"), GetSpriteFromAtlas("shiptype", ShipType.Type2CNLabel(var_100_10)), true)
			elseif type(var_100_10) == "string" then
				setImageSprite(var_100_12:Find("ship_type"), GetSpriteFromAtlas("shiptype", ShipType.BundleType2CNLabel(var_100_10)), true)
			end
		end

		local var_100_13 = _.map(var_100_0, function(arg_101_0)
			return self.shipVOs[arg_101_0]
		end)

		table.sort(var_100_13, function(arg_102_0, arg_102_1)
			return var_0_1[arg_102_0:getTeamType()] < var_0_1[arg_102_1:getTeamType()] or var_0_1[arg_102_0:getTeamType()] == var_0_1[arg_102_1:getTeamType()] and table.indexof(var_100_0, arg_102_0.id) < table.indexof(var_100_0, arg_102_1.id)
		end)

		local var_100_14 = GetOrAddComponent(var_100_12, typeof(UILongPressTrigger))

		var_100_14.onLongPressed:RemoveAllListeners()

		if var_100_9 and self.contextData.tabIndex ~= LevelFleetView.TabIndex.Adjustment then
			var_100_14.onLongPressed:AddListener(function()
				self:onCancelHard(true)
				self:emit(LevelMediator2.ON_FLEET_SHIPINFO, {
					shipId = var_100_9.id,
					shipVOs = var_100_13,
					chapter = self.chapter
				})

				return
			end)
		end

		local var_100_15 = GetOrAddComponent(var_100_12, "EventTriggerListener")

		var_100_15:RemovePointClickFunc()
		var_100_15:AddPointClickFunc(function(arg_104_0, arg_104_1)
			if arg_104_0 ~= var_100_12.gameObject then
				return
			end

			if self.isDraging then
				return
			end

			self:onCancelHard()
			self:emit(LevelMediator2.ON_ELITE_OEPN_DECK, {
				shipType = var_100_10,
				fleet = var_100_1,
				chapter = self.chapter,
				shipVO = var_100_9,
				fleetIndex = arg_100_4,
				teamType = arg_100_2
			})

			return
		end)
		var_100_15:RemoveBeginDragFunc()
		var_100_15:RemoveDragFunc()
		var_100_15:RemoveDragEndFunc()

		if var_100_9 and self.contextData.tabIndex == LevelFleetView.TabIndex.Adjustment then
			local var_100_16 = var_100_12.rect.width * 0.5
			local var_100_17 = {}
			local var_100_18 = {}

			var_100_15:AddBeginDragFunc(function(arg_105_0, arg_105_1)
				if arg_105_0 ~= var_100_12.gameObject then
					return
				end

				if self.isDraging then
					return
				end

				self.isDraging = true
				var_100_6.enabled = false
				var_100_7.enabled = false

				for iter_105_0 = 1, 3 do
					local var_105_0 = arg_100_1:GetChild(iter_105_0 - 1)

					if var_100_12 == var_105_0 then
						self.dragIndex = iter_105_0
					end

					var_100_17[iter_105_0] = var_105_0.anchoredPosition
					var_100_18[iter_105_0] = var_105_0
				end

				return
			end)
			var_100_15:AddDragFunc(function(arg_106_0, arg_106_1)
				if arg_106_0 ~= var_100_12.gameObject then
					return
				end

				if not self.isDraging then
					return
				end

				local var_106_0 = var_100_12.localPosition

				var_106_0.x = self:change2ScrPos(var_100_12.parent, arg_106_1.position).x
				var_106_0.x = math.clamp(var_106_0.x, var_100_17[1].x, var_100_17[3].x)
				var_100_12.localPosition = var_106_0

				local var_106_1 = 1

				for iter_106_0 = 1, 3 do
					if var_100_12 ~= var_100_18[iter_106_0] and var_100_12.localPosition.x > var_100_18[iter_106_0].localPosition.x + (var_106_1 < self.dragIndex and 1.1 or -1.1) * var_100_16 then
						var_106_1 = var_106_1 + 1
					end
				end

				if self.dragIndex ~= var_106_1 then
					local var_106_2 = var_106_1 < self.dragIndex and -1 or 1

					while self.dragIndex ~= var_106_1 do
						var_100_2[self.dragIndex + var_106_2] = var_100_2[self.dragIndex]
						var_100_2[self.dragIndex] = var_100_2[self.dragIndex + var_106_2]
						var_100_18[self.dragIndex], var_100_18[self.dragIndex + var_106_2] = var_100_18[self.dragIndex + var_106_2], var_100_18[self.dragIndex]
						self.dragIndex = self.dragIndex + var_106_2
					end

					for iter_106_1 = 1, 3 do
						if var_100_12 ~= var_100_18[iter_106_1] then
							var_100_18[iter_106_1].anchoredPosition = var_100_17[iter_106_1]
						end
					end
				end

				return
			end)
			var_100_15:AddDragEndFunc(function(arg_107_0, arg_107_1)
				if arg_107_0 ~= var_100_12.gameObject then
					return
				end

				if not self.isDraging then
					return
				end

				self.isDraging = false

				for iter_107_0 = 1, 3 do
					if not var_100_2[iter_107_0] then
						for iter_107_1 = iter_107_0 + 1, 3 do
							if var_100_2[iter_107_1] then
								var_100_2[iter_107_0], var_100_2[iter_107_1] = var_100_2[iter_107_1], var_100_2[iter_107_0]
								var_100_18[iter_107_0], var_100_18[iter_107_1] = var_100_18[iter_107_1], var_100_18[iter_107_0]
							end
						end
					end

					if var_100_2[iter_107_0] then
						table.removebyvalue(var_100_0, var_100_2[iter_107_0])
						table.insert(var_100_0, var_100_2[iter_107_0])
					else
						break
					end
				end

				for iter_107_2 = 1, 3 do
					var_100_18[iter_107_2]:SetSiblingIndex(iter_107_2 - 1)
				end

				var_100_6.enabled = true
				var_100_7.enabled = true
				self.dragIndex = nil

				self.chapter:setEliteFleetByIndex(arg_100_4, {
					{
						TeamType.FormShips,
						underscore.to_array(var_100_0)
					}
				})
				self:emit(LevelMediator2.ON_ELITE_ADJUSTMENT, self.chapter)

				return
			end)
		end
	end

	if (var_100_4 == true or var_100_5 == 3) and var_100_3 ~= 3 then
		return true
	else
		return false
	end

	return
end

function LevelFleetView:change2ScrPos(arg_108_1, arg_108_2)
	return (LuaHelper.ScreenToLocal(arg_108_1, arg_108_2, pg.UIMgr.GetInstance().overlayCameraComp))
end

function LevelFleetView:updateEliteFleets()
	for iter_109_0, iter_109_1 in pairs(self.tfFleets) do
		for iter_109_2 = 1, #iter_109_1 do
			self:UpdateEliteFleet(iter_109_0, iter_109_2)
		end
	end

	self:RefreshDutyBar()

	return
end

function LevelFleetView:UpdateEliteFleet(arg_110_1, arg_110_2)
	local var_110_0 = self.contextData.tabIndex == LevelFleetView.TabIndex.Formation
	local var_110_1 = self.contextData.tabIndex == LevelFleetView.TabIndex.Commander
	local var_110_2 = self.contextData.tabIndex == LevelFleetView.TabIndex.Duty
	local var_110_3 = self.contextData.tabIndex == LevelFleetView.TabIndex.Adjustment
	local var_110_4 = arg_110_2 <= self:getLimitNums(arg_110_1)
	local var_110_5 = self.tfFleets[arg_110_1][arg_110_2]
	local var_110_6 = findTF(self.tfFleets[arg_110_1][arg_110_2], "bg/name")
	local var_110_7 = self.tfFleets[arg_110_1][arg_110_2]:Find("btn_recom")
	local var_110_8 = self.tfFleets[arg_110_1][arg_110_2]:Find("btn_clear")
	local var_110_9 = self.tfFleets[arg_110_1][arg_110_2]:Find("blank")
	local var_110_10 = self.tfFleets[arg_110_1][arg_110_2]:Find("selected")
	local var_110_11 = self.tfFleets[arg_110_1][arg_110_2]:Find("commander")
	local var_110_12 = self.tfFleets[arg_110_1][arg_110_2]:Find("adjustment_flag")

	setActive(self.tfFleets[arg_110_1][arg_110_2]:Find("btn_select"), false)

	local var_110_13 = var_110_5:Find(TeamType.Main)
	local var_110_14 = var_110_5:Find(TeamType.Vanguard)

	if not var_110_4 then
		setActive(var_110_8, false)
		setActive(var_110_7, false)
		setActive(var_110_11, false)
		setActive(var_110_12, false)
		setActive(var_110_9, true)
		setActive(var_110_10, false)
		setText(var_110_6, "")
		setActive(var_110_13, false)

		if arg_110_1 == FleetType.Normal then
			setActive(var_110_14, false)
		end

		return
	end

	local var_110_15 = arg_110_1 == FleetType.Support

	setActive(var_110_8, var_110_0)
	setActive(var_110_7, var_110_0)
	setActive(var_110_11, var_110_1 and not var_110_15)
	setActive(var_110_12, var_110_3)
	setActive(var_110_9, var_110_2 or var_110_3 or var_110_1 and var_110_15)

	local var_110_16 = arg_110_2

	if arg_110_1 == FleetType.Normal then
		setText(var_110_6, Fleet.DEFAULT_NAME[arg_110_2])
		setActive(var_110_13, true)
		setActive(var_110_14, true)
	elseif arg_110_1 == FleetType.Submarine then
		var_110_16 = 3

		setText(var_110_6, Fleet.DEFAULT_NAME[Fleet.SUBMARINE_FLEET_ID + arg_110_2 - 1])
		setActive(var_110_13, true)
	elseif arg_110_1 == FleetType.Support then
		var_110_16 = 4

		setText(var_110_6, i18n("ship_formationUI_fleetName13"))
		setActive(var_110_13, true)
	end

	local var_110_17 = 6

	if arg_110_1 == FleetType.Normal then
		setActive(var_110_10, self:initAddButton(var_110_5:Find(TeamType.Main), TeamType.Main, self.typeLimitations[arg_110_2][1], var_110_16) and self:initAddButton(var_110_5:Find(TeamType.Vanguard), TeamType.Vanguard, self.typeLimitations[arg_110_2][2], var_110_16))
	elseif arg_110_1 == FleetType.Submarine then
		var_110_17 = 3

		setActive(var_110_10, (self:initAddButton(var_110_5:Find(TeamType.Main), TeamType.Submarine, {
			0,
			0,
			0
		}, var_110_16)))
	elseif arg_110_1 == FleetType.Support then
		var_110_17 = 3

		setActive(var_110_10, self.mode == var_0_2.EDIT and self:initSupportAddButton(var_110_5:Find(TeamType.Main), nil, self.chapter:getConfigMiscArg("submarine_support") and {
			"qian",
			"qian",
			"qian"
		} or {
			"hang",
			"hang",
			"hang"
		}, var_110_16))
	end

	if not var_110_15 then
		self:initCommander(var_110_16, var_110_11, self.chapter)
	end

	onButton(self, var_110_8, function()
		if not var_110_15 then
			if #(self.eliteFleetList[var_110_16] or self.supportFleet) == 0 then
				return
			end
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("battle_preCombatLayer_clear_confirm"),
			onYes = function()
				self:emit(LevelMediator2.ON_ELITE_CLEAR, {
					index = var_110_16,
					chapterVO = self.chapter
				})

				return
			end
		})

		return
	end)
	onButton(self, var_110_7, function()
		local var_113_0 = #((not var_110_15 or nil) and (self.eliteFleetList[var_110_16] or self.supportFleet))

		if #((not var_110_15 or nil) and (self.eliteFleetList[var_110_16] or self.supportFleet)) == var_110_17 then
			return
		end

		seriesAsync({
			function(arg_114_0)
				if var_113_0 == 0 then
					return arg_114_0()
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("battle_preCombatLayer_auto_confirm"),
					onYes = arg_114_0
				})

				return
			end,
			function()
				self:emit(LevelMediator2.ON_ELITE_RECOMMEND, {
					index = var_110_16,
					chapterVO = self.chapter
				})

				return
			end
		})

		return
	end)

	return
end

function LevelFleetView:initCommander(arg_116_1, arg_116_2, arg_116_3)
	local var_116_0 = arg_116_3:getEliteFleetCommanders()[arg_116_1]

	for iter_116_0 = 1, 2 do
		local var_116_1 = var_116_0[iter_116_0] and getProxy(CommanderProxy):getCommanderById(var_116_0[iter_116_0])
		local var_116_2 = arg_116_2:Find("pos" .. iter_116_0)
		local var_116_3 = var_116_2:Find("add")
		local var_116_4 = var_116_2:Find("info")

		setActive(var_116_3, not var_116_1)
		setActive(var_116_4, var_116_1)

		if var_116_1 then
			setImageSprite(var_116_4:Find("frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(var_116_1:getRarity())))
			GetImageSpriteFromAtlasAsync("CommanderHrz/" .. var_116_1:getPainting(), "", var_116_4:Find("mask/icon"))
		end

		local var_116_5 = arg_116_3:wrapEliteFleet(arg_116_1)

		onButton(self, var_116_3, function()
			self:emit(LevelUIConst.OPEN_COMMANDER_PANEL, var_116_5, arg_116_3, arg_116_1)

			return
		end, SFX_PANEL)
		onButton(self, var_116_4, function()
			self:emit(LevelUIConst.OPEN_COMMANDER_PANEL, var_116_5, arg_116_3, arg_116_1)

			return
		end, SFX_PANEL)
	end

	return
end

function LevelFleetView:initSupportAddButton(arg_119_1, arg_119_2, arg_119_3, arg_119_4)
	local var_119_0 = {}
	local var_119_1 = {}

	for iter_119_0, iter_119_1 in ipairs(self.supportFleet) do
		var_119_0[self.shipVOs[iter_119_1]] = true

		if not arg_119_2 or arg_119_2 == self.shipVOs[iter_119_1]:getTeamType() then
			table.insert(var_119_1, iter_119_1)
		end
	end

	removeAllChildren(arg_119_1)

	local var_119_2 = 0
	local var_119_3 = false
	local var_119_4 = 0

	arg_119_3 = LevelFleetView.sortTeamLimitation(arg_119_3)

	for iter_119_2 = 1, 3 do
		local var_119_5
		local var_119_6

		if var_119_1[iter_119_2] then
			local var_119_7 = self.shipVOs[var_119_1[iter_119_2]] or nil

			if var_119_7 then
				for iter_119_3, iter_119_4 in ipairs(arg_119_3) do
					if ShipType.ContainInLimitBundle(iter_119_4, var_119_7:getShipType()) then
						var_119_5 = var_119_7
						var_119_6 = iter_119_4

						table.remove(arg_119_3, iter_119_3)

						var_119_3 = var_119_3 or iter_119_4 ~= 0

						break
					end
				end

				goto label_119_0
			end
		end

		var_119_6 = arg_119_3[1]

		table.remove(arg_119_3, 1)

		::label_119_0::

		if var_119_6 == 0 then
			var_119_4 = var_119_4 + 1
		end

		local var_119_8 = var_119_5 and cloneTplTo(self.tfShipTpl, arg_119_1) or cloneTplTo(self.tfEmptyTpl, arg_119_1)

		setActive(var_119_8, true)

		if var_119_5 then
			updateShip(var_119_8, var_119_5)
			setActive(var_119_8:Find("event_block"), var_119_5:getFlag("inEvent"))

			var_119_0[var_119_5] = true
		else
			var_119_2 = var_119_2 + 1
		end

		setActive(var_119_8:Find("ship_type"), var_119_6 and var_119_6 ~= 0)

		if var_119_6 and var_119_6 ~= 0 then
			if type(var_119_6) == "number" then
				setImageSprite(var_119_8:Find("ship_type"), GetSpriteFromAtlas("shiptype", ShipType.Type2CNLabel(var_119_6)), true)
			elseif type(var_119_6) == "string" then
				setImageSprite(var_119_8:Find("ship_type"), GetSpriteFromAtlas("shiptype", ShipType.BundleType2CNLabel(var_119_6)), true)
			end
		end

		local var_119_9 = _.map(self.supportFleet, function(arg_120_0)
			return self.shipVOs[arg_120_0]
		end)
		local var_119_10 = GetOrAddComponent(var_119_8, typeof(UILongPressTrigger))

		var_119_10.onLongPressed:RemoveAllListeners()

		if var_119_5 and self.contextData.tabIndex ~= LevelFleetView.TabIndex.Adjustment then
			var_119_10.onLongPressed:AddListener(function()
				self:onCancelSupport(true)
				self:emit(LevelMediator2.ON_SUPPORT_SHIPINFO, {
					shipId = var_119_5.id,
					shipVOs = var_119_9,
					chapter = self.chapter
				})

				return
			end)
		end

		local var_119_11 = GetOrAddComponent(var_119_8, "EventTriggerListener")

		var_119_11:RemovePointClickFunc()
		var_119_11:AddPointClickFunc(function(arg_122_0, arg_122_1)
			if arg_122_0 ~= var_119_8.gameObject then
				return
			end

			if self.isDraging then
				return
			end

			self:onCancelSupport()
			self:emit(LevelMediator2.ON_SUPPORT_OPEN_DECK, {
				shipType = var_119_6,
				fleet = var_119_0,
				chapter = self.chapter,
				shipVO = var_119_5
			})

			return
		end)
		var_119_11:RemoveBeginDragFunc()
		var_119_11:RemoveDragFunc()
		var_119_11:RemoveDragEndFunc()
	end

	if (var_119_3 == true or var_119_4 == 3) and var_119_2 ~= 3 then
		return true
	else
		return false
	end

	return
end

function LevelFleetView:updateSpecialOperationTickets(arg_123_1)
	self.spOPTicketItems = arg_123_1 or {}

	return
end

function LevelFleetView:getLegalSPBuffList()
	return _.map(self.chapter:GetSpItems(), function(arg_125_0)
		return Chapter.GetSPBuffByItem(arg_125_0:GetConfigID())
	end)
end

function LevelFleetView:initSPOPView()
	self.spPanel = self.btnSp:Find("sp_panel")
	self.spItem = self.btnSp:Find("item")
	self.spDesc = self.btnSp:Find("desc")
	self.spCheckBox = self.btnSp:Find("checkbox")
	self.spCheckMark = self.spCheckBox:Find("mark")
	self.spTpl = self.spPanel:Find("sp_tpl")
	self.spContainer = self.spPanel:Find("sp_container")
	self.spItemEmptyBlock = self.btnSp:Find("empty_block")

	setText(self.spItemEmptyBlock, i18n("levelScene_select_noitem"))
	removeAllChildren(self.spContainer)

	local var_126_0 = self:getLegalSPBuffList()
	local var_126_1 = self.chapter:GetActiveSPItemID()

	self:setSPBtnFormByBuffCount()

	if #var_126_0 == 0 then
		self:clearSPBuff()
	elseif #var_126_0 == 1 then
		local var_126_2 = pg.benefit_buff_template[var_126_0[1]]
		local var_126_3 = ActivityBuff.GetBenefitCondition(pg.benefit_buff_template[var_126_0[1]].benefit_condition)

		assert(var_126_3[1] == "item")

		local var_126_4 = var_126_3[2]

		self:setTicketInfo(self.btnSp, var_126_3[2])
		setText(self.spDesc, var_126_2.desc)
		onButton(self, self.btnSp:Find("item"), function()
			self:emit(BaseUI.ON_ITEM, var_126_4)

			return
		end)
		onButton(self, self.btnSp, function()
			local var_128_0 = Chapter.GetSPOperationItemCacheKey(self.chapter.id)

			if self.spCheckMark.gameObject.activeSelf then
				PlayerPrefs.SetInt(var_128_0, 0)
				self:clearSPBuff()
			else
				self.spItemID = var_126_4

				PlayerPrefs.SetInt(var_128_0, self.spItemID)
				pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_select_sp"))
				setActive(self.spCheckMark, true)
			end

			return
		end)
		setActive(self.spCheckMark, var_126_1 == 0)
		triggerButton(self.btnSp)
	elseif #var_126_0 > 1 then
		setText(self.spDesc, i18n("levelScene_select_SP_OP"))

		for iter_126_0, iter_126_1 in ipairs(var_126_0) do
			local var_126_5 = ActivityBuff.GetBenefitCondition(iter_126_1.benefit_condition)

			assert(var_126_5[1] == "item")

			local var_126_6 = cloneTplTo(self.spTpl, self.spContainer)

			setText(var_126_6:Find("desc"), iter_126_1.desc)
			self:setTicketInfo(var_126_6, var_126_5[2])
			setActive(var_126_6:Find("block"), false)
			onButton(self, var_126_6, function()
				self:setSPBuffSelected(iter_126_1.id)
				setActive(self.spPanel, false)

				return
			end)
		end

		onButton(self, self.btnSp, function()
			if self.spPanel.gameObject.activeSelf then
				self:clearSPBuff()
				PlayerPrefs.SetInt(Chapter.GetSPOperationItemCacheKey(self.chapter.id), 0)
				setActive(self.spPanel, false)
			else
				setActive(self.spPanel, true)
				setActive(self.btnSp:Find("item"), false)
				setText(self.spDesc, i18n("levelScene_unselect_SP_OP"))
			end

			return
		end)

		if var_126_1 ~= 0 then
			local var_126_7

			for iter_126_2, iter_126_3 in ipairs(var_126_0) do
				if iter_126_3.id == Chapter.GetSPBuffByItem(var_126_1) then
					var_126_7 = true

					break
				end
			end

			if var_126_7 then
				self:setSPBuffSelected((Chapter.GetSPBuffByItem(var_126_1)))
			else
				self:clearSPBuff()
			end
		else
			self:clearSPBuff()
		end
	end

	setActive(self.spPanel, false)

	return
end

function LevelFleetView:setSPBuffSelected(arg_131_1)
	local var_131_0 = pg.benefit_buff_template[arg_131_1]
	local var_131_1 = ActivityBuff.GetBenefitCondition(pg.benefit_buff_template[arg_131_1].benefit_condition)

	assert(var_131_1[1] == "item")

	self.spItemID = var_131_1[2]

	self:setTicketInfo(self.btnSp, self.spItemID)
	setText(self.spDesc, var_131_0.desc)
	PlayerPrefs.SetInt(Chapter.GetSPOperationItemCacheKey(self.chapter.id), self.spItemID)

	return
end

function LevelFleetView:clearSPBuff()
	local var_132_0 = self:getLegalSPBuffList()

	self.spItemID = nil

	self:setSPBtnFormByBuffCount()

	if #var_132_0 == 0 then
		setActive(self.btnSp:Find("item"), false)
	elseif #var_132_0 == 1 then
		setActive(self.btnSp:Find("item"), true)
		setActive(self.spCheckMark, false)
	elseif #var_132_0 > 1 then
		setActive(self.btnSp:Find("item"), false)
		setText(self.spDesc, i18n("levelScene_select_SP_OP"))
	end

	return
end

function LevelFleetView:setSPBtnFormByBuffCount()
	local var_133_0 = self:getLegalSPBuffList()

	if #var_133_0 == 0 then
		setActive(self.spItemEmptyBlock, true)
		setActive(self.spDesc, false)
		setActive(self.spCheckBox, false)
		setActive(self.btnSp:Find("add"), false)
	elseif #var_133_0 == 1 then
		setActive(self.spItemEmptyBlock, false)
		setActive(self.spDesc, true)
		setActive(self.spCheckBox, true)
		setActive(self.btnSp:Find("add"), false)
	elseif #var_133_0 > 1 then
		setActive(self.spItemEmptyBlock, false)
		setActive(self.spDesc, true)
		setActive(self.spCheckBox, false)
		setActive(self.btnSp:Find("add"), true)
	end

	return
end

function LevelFleetView:setTicketInfo(arg_134_1, arg_134_2)
	local var_134_0

	arg_134_2 = tonumber(arg_134_2)

	for iter_134_0, iter_134_1 in ipairs(self.spOPTicketItems) do
		if arg_134_2 == iter_134_1.configId then
			var_134_0 = iter_134_1

			break
		end
	end

	if var_134_0 then
		setText(arg_134_1:Find("item/count"), var_134_0.count)
		GetImageSpriteFromAtlasAsync(var_134_0:getConfig("icon"), "", arg_134_1:Find("item/icon"))
	else
		setText(arg_134_1:Find("item/count"), 0)
		GetImageSpriteFromAtlasAsync(Drop.New({
			type = DROP_TYPE_ITEM,
			id = arg_134_2
		}):getIcon(), "", arg_134_1:Find("item/icon"))
	end

	setActive(arg_134_1:Find("item"), true)

	return
end

function LevelFleetView:getSPItem()
	return self.spItemID
end

function LevelFleetView:SetDuty(arg_136_1, arg_136_2)
	if not arg_136_2 or not self.duties then
		return
	end

	if self.duties[arg_136_1] == arg_136_2 then
		return
	end

	self.duties[arg_136_1] = arg_136_2
	self.duties[3 - arg_136_1] = nil

	self:RefreshDutyBar()

	return
end

function LevelFleetView:UpdateDuties()
	if not self.dutyTabEnabled then
		return
	end

	local var_137_0 = 0
	local var_137_1 = 0

	for iter_137_0 = 1, 2 do
		if not self:IsListOfFleetEmpty(iter_137_0) then
			var_137_0 = var_137_0 + 1
			var_137_1 = iter_137_0
		end
	end

	if var_137_0 == 0 then
		table.clear(self.duties)
	elseif var_137_0 == 1 then
		self.duties[var_137_1] = ChapterFleet.DUTY_KILLALL
		self.duties[3 - var_137_1] = nil
	elseif var_137_0 == 2 then
		if self.duties[1] then
			if self.duties[1] < 3 then
				self.duties[2] = 3 - self.duties[1] or 7 - self.duties[1]
			end
		elseif self.duties[2] then
			if self.duties[2] < 3 then
				self.duties[1] = 3 - self.duties[2] or 7 - self.duties[2]
			end
		else
			self.duties[1] = ChapterFleet.DUTY_CLEANPATH
			self.duties[2] = ChapterFleet.DUTY_KILLBOSS
		end
	end

	if var_137_1 ~= 0 then
		local var_137_3 = "lastFleetDuty_" .. (self.chapter.id or 0)
		local var_137_4 = 0

		for iter_137_1, iter_137_2 in ipairs({
			var_137_1,
			self.duties[var_137_1]
		}) do
			var_137_4 = var_137_4 + bit.lshift(iter_137_2, 8 * (iter_137_1 - 1))
		end

		PlayerPrefs.SetInt(var_137_3, var_137_4)
		PlayerPrefs.Save()
	end

	return
end

function LevelFleetView:RefreshDutyBar()
	self:UpdateDuties()
	self:UpdateDutyBar()

	return
end

function LevelFleetView:UpdateDutyBar()
	local var_139_0 = self.contextData.tabIndex == LevelFleetView.TabIndex.Duty

	for iter_139_0 = 1, 2 do
		setActive(self._tf:Find(string.format("panel/ShipList/fleet/%d/DutySelect", iter_139_0)), var_139_0 and self.duties[iter_139_0] ~= nil)
	end

	setActive(self._tf:Find("panel/ShipList/sub/1/DutySelect"), var_139_0 and not self:IsListOfFleetEmpty(3))

	if not var_139_0 then
		return
	end

	for iter_139_1, iter_139_2 in pairs(self.duties) do
		for iter_139_3 = 1, 4 do
			setActive(self.dutyItems[iter_139_1][iter_139_3]:Find("Checkmark"), iter_139_3 == iter_139_2)
		end
	end

	local var_139_1 = ys.Battle.BattleState.IsAutoSubActive()

	for iter_139_4 = 1, 2 do
		setActive(self.dutyItems[3][iter_139_4]:Find("Checkmark"), iter_139_4 == 1 == var_139_1)
	end

	return
end

function LevelFleetView:GetOrderedDuties()
	if not self.duties then
		return
	end

	self:UpdateDuties()

	local var_140_0 = {}

	for iter_140_0 = 1, 2 do
		if self.duties[iter_140_0] then
			var_140_0[1] = self.duties[iter_140_0]
		end
	end

	return var_140_0
end

function LevelFleetView:SetAutoSub(arg_141_1)
	arg_141_1 = tobool(arg_141_1)

	if arg_141_1 == ys.Battle.BattleState.IsAutoSubActive() then
		return
	end

	if not AutoBotCommand.autoBotSatisfied() then
		return
	end

	pg.m02:sendNotification(GAME.AUTO_SUB, {
		isActiveSub = not arg_141_1
	})
	self:UpdateDutyBar()

	return
end

function LevelFleetView:GetValidFleets(arg_142_1)
	if self.mode == var_0_2.SELECT then
		local var_142_0 = {}

		for iter_142_0, iter_142_1 in ipairs(arg_142_1 and {
			arg_142_1
		} or {
			FleetType.Normal,
			FleetType.Submarine
		}) do
			for iter_142_2, iter_142_3 in ipairs(self.selectIds[iter_142_1]) do
				if iter_142_3 > 0 then
					table.insert(var_142_0, self.fleets[iter_142_3])
				end
			end
		end

		return var_142_0
	elseif self.mode == var_0_2.EDIT then
		local var_142_1 = {}
		local var_142_2
		local var_142_3

		if arg_142_1 == FleetType.Normal then
			var_142_2 = 1
			var_142_3 = 2
		elseif arg_142_1 == FleetType.Submarine then
			var_142_2 = 3
			var_142_3 = 3
		elseif not arg_142_1 then
			var_142_2 = 1
			var_142_3 = 3
		end

		for iter_142_4 = var_142_2, var_142_3 do
			if #self.eliteFleetList[iter_142_4] > 0 then
				local var_142_4 = {}

				for iter_142_5, iter_142_6 in pairs(self.eliteCommanderList[iter_142_4]) do
					table.insert(var_142_4, {
						pos = iter_142_5,
						id = iter_142_6
					})
				end

				table.insert(var_142_1, (TypedFleet.New({
					ship_list = self.eliteFleetList[iter_142_4],
					commanders = var_142_4,
					fleetType = FleetType.Normal
				})))
			end
		end

		return var_142_1
	end

	return
end

function LevelFleetView:IsListOfFleetEmpty(arg_143_1)
	if arg_143_1 > 0 and arg_143_1 < 3 and arg_143_1 > self:getLimitNums(FleetType.Normal) then
		return true
	elseif arg_143_1 == 3 and arg_143_1 - 2 > self:getLimitNums(FleetType.Submarine) then
		return true
	end

	if self.mode == var_0_2.SELECT then
		local var_143_0

		if arg_143_1 > 0 and arg_143_1 < 3 then
			var_143_0 = self.selectIds[FleetType.Normal][arg_143_1] or 0
		elseif arg_143_1 == 3 then
			var_143_0 = self.selectIds[FleetType.Submarine][arg_143_1 - 2] or 0
		end

		return var_143_0 == 0
	elseif self.mode == var_0_2.EDIT then
		return #self.eliteFleetList[arg_143_1] == 0
	end

	return
end

function LevelFleetView:GetListFleets()
	local var_144_0 = {}
	local var_144_1 = self:getLimitNums(FleetType.Normal)
	local var_144_2 = self:getLimitNums(FleetType.Submarine)

	if self.mode == var_0_2.SELECT then
		for iter_144_0 = 1, var_144_1 do
			local var_144_3 = self.selectIds[FleetType.Normal][iter_144_0] or 0

			if var_144_3 > 0 then
				var_144_0[iter_144_0] = self.fleets[var_144_3] or nil
			end
		end

		for iter_144_1 = 1, var_144_2 do
			local var_144_4 = self.selectIds[FleetType.Submarine][iter_144_1] or 0

			if var_144_4 > 0 then
				var_144_0[iter_144_1 + var_144_1] = self.fleets[var_144_4] or nil
			end
		end
	elseif self.mode == var_0_2.EDIT then
		local var_144_5 = {}

		for iter_144_2 = 1, var_144_1 do
			table.insert(var_144_5, iter_144_2)
		end

		for iter_144_3 = 1, var_144_2 do
			table.insert(var_144_5, iter_144_3 + 2)
		end

		for iter_144_4 = 1, #var_144_5 do
			local var_144_6 = var_144_5[iter_144_4]
			local var_144_7
			local var_144_8 = self.eliteFleetList[var_144_5[iter_144_4]]

			if #self.eliteFleetList[var_144_5[iter_144_4]] > 0 then
				local var_144_9

				if var_144_6 > 2 then
					var_144_9 = FleetType.Submarine or FleetType.Normal
				end

				local var_144_10 = {}

				for iter_144_5, iter_144_6 in pairs(self.eliteCommanderList[var_144_6]) do
					table.insert(var_144_10, {
						pos = iter_144_5,
						id = iter_144_6
					})
				end

				var_144_7 = TypedFleet.New({
					ship_list = var_144_8,
					commanders = var_144_10,
					fleetType = var_144_9
				})
			end

			var_144_0[iter_144_4] = var_144_7
		end
	end

	return var_144_0
end

function LevelFleetView:IsSelectMode()
	return self.mode == var_0_2.SELECT
end

function LevelFleetView:SwitchDisplayMode()
	local var_146_0 = self.displayMode == var_0_3.ADDITION_SUPPORT

	setActive(self._tf:Find("panel/ShipList/Line"), not (self.displayMode == var_0_3.ADDITION_SUPPORT))
	setActive(self._tf:Find("panel/ShipList/support"), var_146_0)

	local var_146_1 = self._tf:Find("panel/ShipList"):GetComponent(typeof(VerticalLayoutGroup))
	local var_146_2 = var_146_1.padding

	var_146_2.top = var_146_0 and 9 or 20
	var_146_2.bottom = var_146_0 and 14 or 25
	var_146_1.padding = var_146_2
	var_146_1.spacing = var_146_0 and 13 or 20

	return
end

function LevelFleetView:sortTeamLimitation()
	self = Clone(self)

	table.sort(self, function(arg_148_0, arg_148_1)
		local var_148_0 = type(arg_148_0)
		local var_148_1 = type(arg_148_1)

		if var_148_0 == var_148_1 then
			return var_148_1 < var_148_0
		elseif arg_148_1 == 0 or var_148_1 == "string" and arg_148_0 ~= 0 then
			return true
		else
			return false
		end

		return
	end)

	return self
end

return LevelFleetView
