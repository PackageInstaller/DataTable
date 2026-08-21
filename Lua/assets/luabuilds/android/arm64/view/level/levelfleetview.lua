local var_0_0 = class("LevelFleetView", import("..base.BaseSubView"))
local var_0_1 = {
	vanguard = 1,
	submarine = 3,
	main = 2
}

var_0_0.TabIndex = {
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

function var_0_0.getUIName(arg_1_0)
	return "LevelFleetSelectView"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:bind(LevelUIConst.CONTINUOUS_OPERATION, function(arg_3_0, arg_3_1)
		getProxy(ChapterProxy):InitContinuousTime(SYSTEM_SCENARIO, arg_3_1.battleTimes)
		LoadContextCommand.RemoveLayerByMediator(LevelContinuousOperationWindowMediator)
		PlayerPrefs.SetInt("chapter_autofight_flag_" .. arg_2_0.chapter.id, 1)
		triggerButton(arg_2_0.btnGo)

		return
	end)
	arg_2_0:bind(LevelMediator2.ON_SPITEM_CHANGED, function(arg_4_0, arg_4_1)
		setActive(arg_2_0.spCheckMark, not arg_4_1)
		triggerButton(arg_2_0.btnSp)

		return
	end)

	return
end

function var_0_0.OnDestroy(arg_5_0)
	if arg_5_0:isShowing() then
		arg_5_0:Hide()
	end

	return
end

function var_0_0.Show(arg_6_0)
	local var_6_0 = noEmptyStr(arg_6_0.chapter:getConfig("special_operation_list"))

	arg_6_0:initSPOPView()

	if var_6_0 and #var_6_0 > 0 and not arg_6_0.chapter:GetDailyBonusQuota() then
		setActive(arg_6_0.btnSp, true)
	else
		setActive(arg_6_0.btnSp, false)
	end

	setActive(arg_6_0._tf, true)

	local var_6_1 = arg_6_0.contextData.tabIndex or var_0_0.TabIndex.Formation
	local var_6_2 = ({
		arg_6_0.formationToggle,
		arg_6_0.commanderToggle,
		arg_6_0.dutyToggle,
		arg_6_0.adjustmentToggle
	})[var_6_1]

	if not isActive(({
		arg_6_0.formationToggle,
		arg_6_0.commanderToggle,
		arg_6_0.dutyToggle,
		arg_6_0.adjustmentToggle
	})[var_6_1]) then
		var_6_2 = ({
			arg_6_0.formationToggle,
			arg_6_0.commanderToggle,
			arg_6_0.dutyToggle,
			arg_6_0.adjustmentToggle
		})[var_0_0.TabIndex.Formation]
	end

	for iter_6_0, iter_6_1 in ipairs({
		arg_6_0.formationToggle,
		arg_6_0.commanderToggle,
		arg_6_0.dutyToggle,
		arg_6_0.adjustmentToggle
	}) do
		if isActive(iter_6_1) then
			triggerToggle(iter_6_1, iter_6_1 == var_6_2)
		end
	end

	arg_6_0:BlurPanel(arg_6_0._tf)
	arg_6_0:TryPlaySupportGuide()
	arg_6_0:CheckGuideElement()

	return
end

function var_0_0.CheckGuideElement(arg_7_0)
	if not IsUnityEditor then
		return
	end

	_.each({
		"panel/Fixed/start_button",
		"panel/ShipList/support/1/main"
	}, function(arg_8_0)
		assert(arg_7_0._tf:Find(arg_8_0), "Missing Guide Need GameObject Path: " .. arg_8_0)

		return
	end)

	return
end

function var_0_0.TryPlaySupportGuide(arg_9_0)
	if arg_9_0:getLimitNums(FleetType.Support) == 0 then
		return
	end

	local var_9_0 = pg.NewStoryMgr.GetInstance()

	if not var_9_0:IsPlayed("NG0041") then
		pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0041")
	end

	return
end

function var_0_0.Hide(arg_10_0)
	setActive(arg_10_0.dropDown, false)
	setActive(arg_10_0.btnSp, false)
	setActive(arg_10_0._tf, false)

	arg_10_0.spItemID = nil

	arg_10_0:UnOverlayPanel(arg_10_0._tf, arg_10_0._parentTf)

	return
end

function var_0_0.setOpenCommanderTag(arg_11_0, arg_11_1)
	arg_11_0.openedCommanerSystem = arg_11_1

	return
end

function var_0_0.SetDutyTabEnabled(arg_12_0, arg_12_1)
	arg_12_0.dutyTabEnabled = arg_12_1

	return
end

function var_0_0.onConfirm(arg_13_0)
	local var_13_0 = arg_13_0.chapter
	local var_13_1 = arg_13_0:getSelectIds()
	local var_13_2 = arg_13_0.chapter:getNpcShipByType(2)

	if #var_13_2 > 0 then
		({})[TeamType.Vanguard] = #arg_13_0:getFleetById(var_13_1[1]):getTeamByName(TeamType.Vanguard)
		;({})[TeamType.Main] = #arg_13_0:getFleetById(var_13_1[1]):getTeamByName(TeamType.Main)

		local var_13_3

		for iter_13_0, iter_13_1 in ipairs(var_13_2) do
			var_13_3 = iter_13_1

			local var_13_4 = iter_13_1:getTeamType()

			;({
				[TeamType.Vanguard] = 0,
				[TeamType.Main] = 0
			})[var_13_4] = ({
				[TeamType.Vanguard] = 0,
				[TeamType.Main] = 0
			})[var_13_4] + 1

			if ({})[var_13_4] + ({
				[TeamType.Vanguard] = 0,
				[TeamType.Main] = 0
			})[var_13_4] > 3 then
				break
			end
		end

		for iter_13_2, iter_13_3 in pairs({}) do
			if iter_13_3 + ({
				[TeamType.Vanguard] = 0,
				[TeamType.Main] = 0
			})[iter_13_2] > 3 then
				arg_13_0:emit(LevelUIConst.HANDLE_SHOW_MSG_BOX, {
					modal = true,
					hideNo = true,
					content = i18n("chapter_tip_with_npc", var_13_3.name)
				})

				return
			end
		end
	end

	local var_13_5 = "chapter_autofight_flag_" .. arg_13_0.chapter.id
	local var_13_6
	local var_13_7

	seriesAsync({
		function(arg_14_0)
			local var_14_0 = PlayerPrefs.GetInt("autoFight_firstUse_sp", 0) == 1

			if PlayerPrefs.GetInt(var_13_5, 1) ~= 1 or var_14_0 or not arg_13_0:getSPItem() then
				return arg_14_0()
			end

			PlayerPrefs.SetInt("autoFight_firstUse_sp", 1)
			PlayerPrefs.Save()
			arg_13_0:emit(LevelUIConst.HANDLE_SHOW_MSG_BOX, {
				hideNo = true,
				content = i18n("autofight_special_operation_tip"),
				onYes = function()
					arg_13_0:clearSPBuff()

					return
				end,
				onNo = function()
					arg_13_0:clearSPBuff()

					return
				end
			})

			return
		end,
		function(arg_16_0)
			var_13_7 = var_13_0:GetActiveSPItemID()
			var_13_6 = var_13_0:isLoop() and arg_13_0:GetOrderedDuties() or nil

			arg_13_0:onCancel()
			arg_16_0()

			return
		end,
		function(arg_17_0)
			getProxy(ChapterProxy):SetLastFleetIndex(var_13_1)

			local var_17_0 = LevelMediator2.ON_TRACKING
			local var_17_1 = packEx(var_13_0.id, var_13_0.loopFlag, var_13_7, var_13_6, PlayerPrefs.GetInt(var_13_5, 1) == 1)

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

function var_0_0.onCancel(arg_18_0)
	arg_18_0:clear()
	arg_18_0:emit(LevelUIConst.HIDE_FLEET_SELECT)

	return
end

function var_0_0.InitUI(arg_19_0)
	arg_19_0.tfShipTpl = arg_19_0._tf:Find("panel/Fixed/shiptpl")
	arg_19_0.tfEmptyTpl = arg_19_0._tf:Find("panel/Fixed/emptytpl")
	arg_19_0.tfFleets = {
		[FleetType.Normal] = {
			arg_19_0._tf:Find("panel/ShipList/fleet/1"),
			arg_19_0._tf:Find("panel/ShipList/fleet/2")
		},
		[FleetType.Submarine] = {
			arg_19_0._tf:Find("panel/ShipList/sub/1")
		},
		[FleetType.Support] = {
			arg_19_0._tf:Find("panel/ShipList/support/1")
		}
	}

	local var_19_0 = arg_19_0._tf:Find("panel/Fixed/RightTabs")

	if PLATFORM_CODE == PLATFORM_US then
		local var_19_1 = arg_19_0._tf:Find("panel/Fixed/RightTabs/hTplBtn") or arg_19_0._tf:Find("panel/Fixed/RightTabs/vTplBtn")
		local var_19_2 = {
			"formation_btn",
			"commander_btn",
			"duty_btn",
			"adjustment_btn"
		}

		for iter_19_0 = 1, #{
			"formation_btn",
			"commander_btn",
			"duty_btn",
			"adjustment_btn"
		} do
			local var_19_3 = Instantiate(var_19_1)

			var_19_3.name = var_19_2[iter_19_0]

			SetParent(tf(var_19_3), var_19_0)
			setActive(var_19_3, false)
		end

		arg_19_0.tfLimit = arg_19_0._tf:Find("panel/Fixed/limit_list/limit")
		arg_19_0.tfLimitTips = arg_19_0._tf:Find("panel/Fixed/limit_list/limit_tip")
		arg_19_0.tfLimitElite = arg_19_0._tf:Find("panel/Fixed/limit_list/limit_elite")
		arg_19_0.tfLimitSubTip = arg_19_0._tf:Find("panel/Fixed/limit_list/limit_sub_tip")
		arg_19_0.tfLimitContainer = arg_19_0._tf:Find("panel/Fixed/limit_list/limit_elite/limit_list")
		arg_19_0.rtCostLimit = arg_19_0._tf:Find("panel/Fixed/limit_list/cost_limit")
		arg_19_0.btnBack = arg_19_0._tf:Find("panel/Fixed/btnBack")
		arg_19_0.btnGo = arg_19_0._tf:Find("panel/Fixed/start_button")
		arg_19_0.btnMultiple = arg_19_0._tf:Find("panel/Fixed/multiple")
		arg_19_0.formationToggle = arg_19_0._tf:Find("panel/Fixed/RightTabs/formation_btn")
		arg_19_0.commanderToggle = arg_19_0._tf:Find("panel/Fixed/RightTabs/commander_btn")
		arg_19_0.dutyToggle = arg_19_0._tf:Find("panel/Fixed/RightTabs/duty_btn")
		arg_19_0.adjustmentToggle = arg_19_0._tf:Find("panel/Fixed/RightTabs/adjustment_btn")
		arg_19_0.toggleMask = arg_19_0._tf:Find("mask")
		arg_19_0.toggleList = arg_19_0._tf:Find("mask/list")
		arg_19_0.toggles = {}

		setText(findTF(arg_19_0.tfLimit, "text"), i18n("level_fleet_ship_desc"))
		setText(findTF(arg_19_0.tfLimit, "text_sub"), i18n("level_fleet_sub_desc"))

		for iter_19_1 = 0, arg_19_0.toggleList.childCount - 1 do
			table.insert(arg_19_0.toggles, arg_19_0.toggleList:Find("item" .. iter_19_1 + 1))
		end

		arg_19_0.btnSp = arg_19_0._tf:Find("panel/Fixed/sp")
		arg_19_0.spMask = arg_19_0._tf:Find("mask_sp")
		arg_19_0.dutyItems = {}

		for iter_19_2 = 1, 2 do
			local var_19_4 = arg_19_0._tf:Find(string.format("panel/ShipList/fleet/%d/DutySelect", iter_19_2))

			arg_19_0.dutyItems[iter_19_2] = {}

			for iter_19_3 = 1, 4 do
				local var_19_5 = var_19_4:Find("Item" .. iter_19_3)

				arg_19_0.dutyItems[iter_19_2][iter_19_3] = var_19_5

				setText(var_19_5:Find("Text"), i18n("autofight_function" .. iter_19_3))
			end
		end

		local var_19_6 = arg_19_0._tf:Find("panel/ShipList/sub/1/DutySelect")

		arg_19_0.dutyItems[3] = {}

		for iter_19_4 = 1, 2 do
			local var_19_7 = var_19_6:Find("Item" .. iter_19_4)

			arg_19_0.dutyItems[3][iter_19_4] = var_19_7

			setText(var_19_7:Find("Text"), i18n("autofight_function" .. 6 - iter_19_4))
		end

		setActive(arg_19_0.tfShipTpl, false)
		setActive(arg_19_0.tfEmptyTpl, false)
		setActive(arg_19_0.toggleMask, false)
		setActive(arg_19_0.btnSp, false)
		setActive(arg_19_0.spMask, false)
		setText(arg_19_0._tf:Find("panel/Fixed/RightTabs/formation_btn/text"), i18n("autofight_formation"))
		setText(arg_19_0._tf:Find("panel/Fixed/RightTabs/commander_btn/text"), i18n("autofight_cat"))
		setText(arg_19_0._tf:Find("panel/Fixed/RightTabs/duty_btn/text"), i18n("autofight_function"))
		setText(arg_19_0.adjustmentToggle:Find("text"), i18n("word_adjustFleet"))

		arg_19_0.dropDown = arg_19_0._tf:Find("panel/FixedTop/Dropdown")

		setActive(arg_19_0.dropDown, false)

		arg_19_0.dropDownSide = arg_19_0._tf:Find("panel/Fixed/title/DropSide")

		onButton(arg_19_0, arg_19_0.dropDownSide:Find("Click"), function()
			setActive(arg_19_0.dropDown, not isActive(arg_19_0.dropDown))

			return
		end, SFX_UI_CLICK)
		onButton(arg_19_0, arg_19_0.dropDown, function()
			setActive(arg_19_0.dropDown, not isActive(arg_19_0.dropDown))

			return
		end, SFX_UI_CLICK)
		onButton(arg_19_0, arg_19_0.dropDownSide:Find("Layout/Item3"), function()
			arg_19_0:emit(LevelUIConst.HANDLE_SHOW_MSG_BOX, {
				type = MSGBOX_TYPE_HELP,
				helps = pg.gametip.fleet_antisub_range_tip.tip
			})

			return
		end, SFX_PANEL)
		assert(OPEN_AIR_DOMINANCE, "Not Prepare for BANNED OPEN_AIR_DOMINANCE")

		arg_19_0.btnASHelp = arg_19_0.dropDownSide:Find("help")

		setText(arg_19_0.dropDownSide:Find("Layout/Item1/Text"), i18n("word_investigate"))
		setText(arg_19_0.dropDownSide:Find("Layout/Item2/Text"), i18n("word_attr_ac"))
		setText(arg_19_0.dropDownSide:Find("Layout/Item3/Text"), i18n("fleet_antisub_range"))
		setText(arg_19_0.dropDown:Find("Investigation/Text"), i18n("level_scene_title_word_1"))
		setText(arg_19_0.dropDown:Find("Airsupport/Text"), i18n("level_scene_title_word_3"))

		arg_19_0.supportFleetHelp = arg_19_0._tf:Find("panel/Fixed/title/Image/Help")

		onButton(arg_19_0, arg_19_0.supportFleetHelp, function()
			local var_23_0 = arg_19_0.chapter:IsSupportSubmarineStage() and "help_supportfleet_16_submarine" or arg_19_0.chapter:IsFogStage() and "help_supportfleet_16" or "help_supportfleet"

			arg_19_0:emit(LevelUIConst.HANDLE_SHOW_MSG_BOX, {
				type = MSGBOX_TYPE_HELP,
				helps = i18n(var_23_0)
			})

			return
		end, SFX_PANEL)

		for iter_19_5 = 1, 2 do
			for iter_19_6 = 1, 4 do
				onButton(arg_19_0, arg_19_0.dutyItems[iter_19_5][iter_19_6], function()
					arg_19_0:SetDuty(iter_19_5, iter_19_6)

					return
				end)
			end
		end

		for iter_19_7 = 1, 2 do
			onButton(arg_19_0, arg_19_0.dutyItems[3][iter_19_7], function()
				arg_19_0:SetAutoSub(iter_19_7 == 1)

				return
			end)
		end

		return
	end
end

function var_0_0.onCancelSupport(arg_26_0, arg_26_1)
	if arg_26_1 then
		arg_26_0:emit(LevelMediator2.ON_UPDATE_CUSTOM_FLEET, arg_26_0.chapter)
	end

	return
end

function var_0_0.set(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	arg_27_0.chapter = arg_27_1
	arg_27_0.mode = var_0_2.SELECT
	arg_27_0.selects = arg_27_3
	arg_27_0.chapterASValue = arg_27_0.chapter:getConfig("air_dominance")
	arg_27_0.suggestionValue = arg_27_0.chapter:getConfig("best_air_dominance")

	arg_27_0:SetDutyTabEnabled(arg_27_1:isLoop())

	arg_27_0.supportFleet = arg_27_0.chapter:getSupportFleet()

	local var_27_0 = arg_27_0:getLimitNums(FleetType.Support) > 0

	setActive(arg_27_0.supportFleetHelp, var_27_0)

	if var_27_0 then
		arg_27_0.displayMode = var_0_3.ADDITION_SUPPORT or var_0_3.NORMAL

		arg_27_0:SwitchDisplayMode()

		arg_27_0.fleets = underscore(arg_27_2):chain():values():filter(function(arg_28_0)
			return arg_28_0:isRegularFleet()
		end):sort(CompareFuncs({
			function(arg_29_0)
				return arg_29_0.id
			end
		})):value()
		arg_27_0.selectIds = {
			[FleetType.Normal] = {},
			[FleetType.Submarine] = {}
		}

		for iter_27_0, iter_27_1 in ipairs(arg_27_3 or {}) do
			local var_27_1 = arg_27_0:getFleetById(iter_27_1)

			if var_27_1 then
				local var_27_2 = var_27_1:getFleetType()

				if #arg_27_0.selectIds[var_27_2] < arg_27_0:getLimitNums(var_27_2) then
					table.insert(arg_27_0.selectIds[var_27_2], iter_27_1)
				end
			end
		end

		arg_27_0.duties = {}

		local var_27_3 = arg_27_0.chapter.id or 0
		local var_27_4 = "lastFleetDuty_" .. var_27_3
		local var_27_5 = PlayerPrefs.GetInt(var_27_4, 0)

		if var_27_5 > 0 then
			local var_27_6 = bit.band(var_27_5, 255)
			local var_27_7 = bit.band(bit.rshift(var_27_5, 8), 255)

			if var_27_6 > 0 and var_27_7 > 0 then
				arg_27_0.duties[var_27_6] = var_27_7
			end
		end

		setActive(arg_27_0.tfLimitElite, false)
		setActive(arg_27_0.tfLimitSubTip, false)
		setActive(arg_27_0.tfLimitTips, false)
		setActive(arg_27_0.tfLimit, true)

		local var_27_8 = arg_27_0.chapter:isLoop() and arg_27_0.chapter:getConfig("use_oil_limit") or {}

		setActive(arg_27_0.rtCostLimit, #var_27_8 > 0)
		setText(arg_27_0.rtCostLimit:Find("text"), i18n("formationScene_use_oil_limit_tip"))

		if #var_27_8 > 0 then
			setActive(arg_27_0.rtCostLimit:Find("cost_noraml"), var_27_8[1] > 0)
			setText(arg_27_0.rtCostLimit:Find("cost_noraml/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_enemy"), var_27_8[1]))
			setActive(arg_27_0.rtCostLimit:Find("cost_boss"), var_27_8[2] > 0)
			setText(arg_27_0.rtCostLimit:Find("cost_boss/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_flagship"), var_27_8[2]))
			setActive(arg_27_0.rtCostLimit:Find("cost_sub"), var_27_8[3] > 0)
			setText(arg_27_0.rtCostLimit:Find("cost_sub/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_submarine"), var_27_8[3]))
		end

		onButton(arg_27_0, arg_27_0.btnGo, function()
			local function var_30_0()
				arg_27_0:onConfirm()

				return
			end

			local var_30_1 = arg_27_0:getSPItem()

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
					(function()
						arg_27_0:onConfirm()

						return
					end)()
				end
			else
				(function()
					arg_27_0:onConfirm()

					return
				end)()
			end

			return
		end, SFX_UI_WEIGHANCHOR_GO)

		local var_27_9 = AutoBotCommand.autoBotSatisfied() and arg_27_0.chapter:isLoop()

		setActive(arg_27_0.btnMultiple, var_27_9)
		onButton(arg_27_0, arg_27_0.btnMultiple, function()
			arg_27_0:emit(LevelUIConst.OPEN_NORMAL_CONTINUOUS_WINDOW, arg_27_0.chapter, arg_27_0:getSelectIds(), arg_27_0:getSPItem(), (arg_27_0:GetOrderedDuties()))

			return
		end, SFX_PANEL)
		onButton(arg_27_0, arg_27_0.btnASHelp, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = i18n("help_battle_ac")
			})

			return
		end, SFX_UI_CLICK)
		onButton(arg_27_0, arg_27_0.btnBack, function()
			arg_27_0:onCancel()
			arg_27_0:onCancelSupport(true)

			return
		end, SFX_CANCEL)
		onButton(arg_27_0, arg_27_0._tf:Find("bg"), function()
			arg_27_0:onCancel()
			arg_27_0:onCancelSupport(true)

			return
		end, SFX_CANCEL)
		onButton(arg_27_0, arg_27_0.toggleMask, function()
			arg_27_0:hideToggleMask()

			return
		end, SFX_CANCEL)
		onToggle(arg_27_0, arg_27_0.formationToggle, function(arg_38_0)
			if arg_38_0 then
				arg_27_0.contextData.tabIndex = var_0_0.TabIndex.Formation

				arg_27_0:updateFleets()
			end

			return
		end, SFX_PANEL)
		onToggle(arg_27_0, arg_27_0.commanderToggle, function(arg_39_0)
			if arg_39_0 then
				arg_27_0.contextData.tabIndex = var_0_0.TabIndex.Commander

				arg_27_0:updateFleets()
			end

			return
		end, SFX_PANEL)
		onToggle(arg_27_0, arg_27_0.dutyToggle, function(arg_40_0)
			if arg_40_0 then
				arg_27_0.contextData.tabIndex = var_0_0.TabIndex.Duty

				arg_27_0:updateFleets()
			end

			return
		end, SFX_PANEL)
		setActive(arg_27_0.formationToggle, true)
		setActive(arg_27_0.commanderToggle, arg_27_0.openedCommanerSystem)
		setActive(arg_27_0.dutyToggle, arg_27_0.dutyTabEnabled)
		setActive(arg_27_0.adjustmentToggle, false)
		arg_27_0:clearFleets()
		arg_27_0:updateFleets()
		arg_27_0:updateLimit()
		arg_27_0:updateASValue()
		arg_27_0:UpdateSonarRange()
		arg_27_0:UpdateInvestigation()

		return
	end
end

function var_0_0.getFleetById(arg_41_0, arg_41_1)
	return _.detect(arg_41_0.fleets, function(arg_42_0)
		return arg_42_0.id == arg_41_1
	end)
end

function var_0_0.getLimitNums(arg_43_0, arg_43_1)
	local var_43_0 = 0

	if arg_43_1 == FleetType.Normal then
		var_43_0 = arg_43_0.chapter:getConfig("group_num")
	elseif arg_43_1 == FleetType.Submarine then
		var_43_0 = arg_43_0.chapter:getConfig("submarine_num")
	elseif arg_43_1 == FleetType.Support then
		var_43_0 = arg_43_0.chapter:getConfig("support_group_num")
	end

	return var_43_0
end

function var_0_0.getSelectIds(arg_44_0)
	for iter_44_0, iter_44_1 in ipairs({
		FleetType.Normal,
		FleetType.Submarine
	}) do
		for iter_44_2, iter_44_3 in ipairs(arg_44_0.selectIds[iter_44_1]) do
			if iter_44_3 > 0 then
				table.insert({}, iter_44_3)
			end
		end
	end

	return {}
end

function var_0_0.updateFleets(arg_45_0)
	for iter_45_0, iter_45_1 in pairs(arg_45_0.tfFleets) do
		for iter_45_2 = 1, #iter_45_1 do
			if iter_45_0 == FleetType.Support then
				arg_45_0:UpdateEliteFleet(iter_45_0, iter_45_2)
			else
				arg_45_0:updateFleet(iter_45_0, iter_45_2)
			end
		end
	end

	arg_45_0:RefreshDutyBar()

	return
end

function var_0_0.updateLimit(arg_46_0)
	setText(arg_46_0.tfLimit:Find("number"), string.format("%d/%d", #_.filter(arg_46_0.selectIds[FleetType.Normal], function(arg_47_0)
		return arg_47_0 > 0
	end), (arg_46_0:getLimitNums(FleetType.Normal))))
	setText(arg_46_0.tfLimit:Find("number_sub"), string.format("%d/%d", #_.filter(arg_46_0.selectIds[FleetType.Submarine], function(arg_48_0)
		return arg_48_0 > 0
	end), (arg_46_0:getLimitNums(FleetType.Submarine))))

	return
end

function var_0_0.selectFleet(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	local var_49_0 = arg_49_0.selectIds[arg_49_1]

	if arg_49_3 > 0 and table.contains(var_49_0, arg_49_3) then
		return
	end

	if arg_49_1 == FleetType.Normal and arg_49_0:getLimitNums(arg_49_1) > 0 and arg_49_3 == 0 and #_.filter(var_49_0, function(arg_50_0)
		return arg_50_0 > 0
	end) == 1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("level_fleet_lease_one_ship"))

		return
	end

	local var_49_1 = arg_49_0:getFleetById(arg_49_3)

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
		not arg_49_0:IsListOfFleetEmpty(1) or nil,
		not arg_49_0:IsListOfFleetEmpty(2) or nil
	}

	var_49_0[arg_49_2] = arg_49_3

	arg_49_0:updateFleet(arg_49_1, arg_49_2)
	arg_49_0:updateLimit()
	arg_49_0:updateASValue()
	arg_49_0:UpdateSonarRange()
	arg_49_0:RefreshDutyBar()

	local var_49_4 = {
		not arg_49_0:IsListOfFleetEmpty(1) or nil,
		not arg_49_0:IsListOfFleetEmpty(2) or nil
	}

	if arg_49_0.dutyTabEnabled and table.getCount(var_49_2) == 2 and table.getCount(var_49_4) == 1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("autofight_change_tip"))
	end

	arg_49_0:UpdateInvestigation()

	return
end

function var_0_0.updateFleet(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = arg_51_0.contextData.tabIndex == var_0_0.TabIndex.Formation
	local var_51_1 = arg_51_0.contextData.tabIndex == var_0_0.TabIndex.Commander
	local var_51_2 = arg_51_0.contextData.tabIndex == var_0_0.TabIndex.Duty
	local var_51_3 = arg_51_0.contextData.tabIndex == var_0_0.TabIndex.Adjustment
	local var_51_4 = arg_51_0:getFleetById(arg_51_0.selectIds[arg_51_1][arg_51_2])
	local var_51_5 = arg_51_2 <= arg_51_0:getLimitNums(arg_51_1)
	local var_51_7 = findTF(arg_51_0.tfFleets[arg_51_1][arg_51_2], "bg/name")
	local var_51_8 = arg_51_0.tfFleets[arg_51_1][arg_51_2]:Find("btn_select")
	local var_51_9 = arg_51_0.tfFleets[arg_51_1][arg_51_2]:Find("btn_clear")
	local var_51_10 = arg_51_0.tfFleets[arg_51_1][arg_51_2]:Find("blank")
	local var_51_11 = arg_51_0.tfFleets[arg_51_1][arg_51_2]:Find("commander")
	local var_51_12 = arg_51_0.tfFleets[arg_51_1][arg_51_2]:Find("adjustment_flag")

	setActive(arg_51_0.tfFleets[arg_51_1][arg_51_2]:Find("btn_recom"), false)
	setActive(arg_51_0.tfFleets[arg_51_1][arg_51_2]:Find("selected"), false)
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

	local var_51_15 = var_51_4 and var_51_4:GetName() or ""

	setText(var_51_7, var_51_15)
	setActive(var_51_13, var_51_4)

	if arg_51_1 == FleetType.Normal then
		setActive(var_51_14, var_51_4)
	end

	if var_51_4 then
		if arg_51_1 == FleetType.Submarine then
			arg_51_0:updateShips(var_51_13, var_51_4.subShips)
		else
			arg_51_0:updateShips(var_51_13, var_51_4.mainShips)
			arg_51_0:updateShips(var_51_14, var_51_4.vanguardShips)
		end

		arg_51_0:updateCommanders(var_51_11, var_51_4)
	end

	onButton(arg_51_0, var_51_8, function()
		arg_51_0.toggleList.position = (var_51_8.position + var_51_9.position) / 2
		arg_51_0.toggleList.anchoredPosition = arg_51_0.toggleList.anchoredPosition + Vector2(-arg_51_0.toggleList.rect.width / 2, -var_51_8.rect.height / 2)

		arg_51_0:showToggleMask(arg_51_1, function(arg_53_0)
			arg_51_0:hideToggleMask()
			arg_51_0:selectFleet(arg_51_1, arg_51_2, arg_53_0)

			return
		end)

		return
	end, SFX_UI_CLICK)
	onButton(arg_51_0, var_51_9, function()
		arg_51_0:selectFleet(arg_51_1, arg_51_2, 0)

		return
	end, SFX_UI_CLICK)

	return
end

function var_0_0.updateCommanders(arg_55_0, arg_55_1, arg_55_2)
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

		onButton(arg_55_0, var_55_2, function()
			arg_55_0:emit(LevelUIConst.OPEN_COMMANDER_PANEL, arg_55_2, arg_55_0.chapter)

			return
		end, SFX_PANEL)
		onButton(arg_55_0, var_55_3, function()
			arg_55_0:emit(LevelUIConst.OPEN_COMMANDER_PANEL, arg_55_2, arg_55_0.chapter)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.updateShips(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = UIItemList.New(arg_58_1, arg_58_0.tfShipTpl)

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

		pg.DelegateInfo.Add(arg_58_0, var_58_1)
		var_58_1:RemoveAllListeners()
		var_58_1:AddListener(function()
			arg_58_0:emit(LevelMediator2.ON_SHIP_DETAIL, {
				id = iter_58_1,
				chapter = arg_58_0.chapter
			})

			return
		end)
	end

	return
end

function var_0_0.showToggleMask(arg_61_0, arg_61_1, arg_61_2)
	setActive(arg_61_0.toggleMask, true)

	local var_61_0 = _.filter(arg_61_0.fleets, function(arg_62_0)
		return arg_62_0:getFleetType() == arg_61_1
	end)

	for iter_61_0, iter_61_1 in ipairs(arg_61_0.toggles) do
		local var_61_1 = var_61_0[iter_61_0]

		setActive(iter_61_1, var_61_0[iter_61_0])

		if var_61_0[iter_61_0] then
			local var_61_2 = iter_61_1:GetComponent(typeof(Toggle))
			local var_61_3 = iter_61_1:Find("lock")
			local var_61_4, var_61_5 = var_61_0[iter_61_0]:isUnlock()

			setToggleEnabled(iter_61_1, var_61_4)
			setActive(var_61_3, not var_61_4)

			local var_61_6 = table.contains(arg_61_0.selectIds[arg_61_1], var_61_0[iter_61_0].id)

			setActive(iter_61_1:Find("on"), var_61_6)
			setActive(iter_61_1:Find("off"), not var_61_6)

			if var_61_4 then
				var_61_2.isOn = false

				onToggle(arg_61_0, iter_61_1, function(arg_63_0)
					if arg_63_0 then
						setActive(arg_61_0.toggleMask, false)
						arg_61_2(var_61_1.id)
					end

					return
				end, SFX_UI_TAG)
			else
				onButton(arg_61_0, var_61_3, function()
					pg.TipsMgr.GetInstance():ShowTips(var_61_5)

					return
				end, SFX_UI_CLICK)
			end
		end
	end

	return
end

function var_0_0.hideToggleMask(arg_65_0)
	setActive(arg_65_0.toggleMask, false)

	return
end

function var_0_0.clearFleets(arg_66_0)
	for iter_66_0, iter_66_1 in pairs(arg_66_0.tfFleets) do
		_.each(iter_66_1, function(arg_67_0)
			arg_66_0:clearFleet(arg_67_0)

			return
		end)
	end

	return
end

function var_0_0.UpdateInvestigation(arg_68_0)
	if not arg_68_0.chapter:existAmbush() then
		arg_68_0:UpdateLoopInvestigation()

		return
	end

	local var_68_0 = 0

	for iter_68_0 = 1, 2 do
		local var_68_1 = arg_68_0.selectIds[FleetType.Normal][iter_68_0] or 0
		local var_68_2 = arg_68_0:getFleetById(var_68_1)
		local var_68_3 = var_68_2 and math.floor(var_68_2:getInvestSums(true)) or 0

		var_68_0 = math.max(var_68_0, var_68_3)
	end

	arg_68_0:UpdateInvestigationComparision(var_68_0, (arg_68_0.chapter:getConfig("avoid_require")))

	return
end

function var_0_0.UpdateEliteInvestigation(arg_69_0)
	if not arg_69_0.chapter:existAmbush() then
		arg_69_0:UpdateLoopInvestigation()

		return
	end

	local var_69_0 = 0

	for iter_69_0 = 1, 2 do
		local var_69_1 = 0

		if iter_69_0 <= arg_69_0.chapter:GetNomralFleetMaxCount() then
			for iter_69_1, iter_69_2 in pairs(arg_69_0.eliteCommanderList[iter_69_0]) do
				table.insert({}, {
					pos = iter_69_1,
					id = iter_69_2
				})
			end

			local var_69_2 = TypedFleet.New({
				ship_list = arg_69_0.eliteFleetList[iter_69_0],
				commanders = {},
				fleetType = FleetType.Normal
			})

			var_69_1 = math.floor(var_69_2:getInvestSums())
		end

		var_69_0 = math.max(var_69_0, var_69_1)
	end

	arg_69_0:UpdateInvestigationComparision(var_69_0, (arg_69_0.chapter:getConfig("avoid_require")))

	return
end

function var_0_0.UpdateLoopInvestigation(arg_70_0)
	local var_70_0 = arg_70_0.dropDown:Find("Investigation")

	setText(var_70_0:Find("Value1"), "-")
	setText(var_70_0:Find("Value2"), "-")
	triggerToggle(arg_70_0.dropDownSide:Find("Layout/Item1/Dot"), true)

	return
end

function var_0_0.UpdateInvestigationComparision(arg_71_0, arg_71_1, arg_71_2)
	arg_71_1 = math.floor(arg_71_1)

	local var_71_0 = arg_71_0.dropDown:Find("Investigation")
	local var_71_1 = arg_71_2 <= arg_71_1

	setText(var_71_0:Find("Value1"), setColorStr(arg_71_1, arg_71_2 <= arg_71_1 and "#51FF55" or COLOR_WHITE))
	setText(var_71_0:Find("Value2"), arg_71_2)
	triggerToggle(arg_71_0.dropDownSide:Find("Layout/Item1/Dot"), var_71_1)

	return
end

function var_0_0.updateASValue(arg_72_0)
	if arg_72_0.chapterASValue <= 0 then
		arg_72_0:UpdateBannedAS()

		return
	end

	local var_72_0 = 0

	for iter_72_0 = 1, 2 do
		local var_72_1 = arg_72_0.selectIds[FleetType.Normal][iter_72_0] or 0
		local var_72_2 = arg_72_0:getFleetById(var_72_1)
		local var_72_3 = var_72_2 and var_72_2:getFleetAirDominanceValue() or 0

		var_72_0 = var_72_0 + var_72_3
	end

	for iter_72_1 = 1, 1 do
		local var_72_4 = arg_72_0.selectIds[FleetType.Submarine][iter_72_1] or 0
		local var_72_5 = arg_72_0:getFleetById(var_72_4)
		local var_72_6 = var_72_5 and var_72_5:getFleetAirDominanceValue() or 0

		var_72_0 = var_72_0 + var_72_6
	end

	arg_72_0:UpdateASComparision(var_72_0, arg_72_0.suggestionValue)

	return
end

function var_0_0.updateEliteASValue(arg_73_0)
	if arg_73_0.chapterASValue <= 0 then
		arg_73_0:UpdateBannedAS()

		return
	end

	local var_73_0 = getProxy(BayProxy)
	local var_73_1 = 0

	for iter_73_0, iter_73_1 in ipairs(arg_73_0.eliteFleetList) do
		for iter_73_2, iter_73_3 in pairs(arg_73_0.eliteCommanderList[iter_73_0]) do
			({})[iter_73_2] = getProxy(CommanderProxy):RawGetCommanderById(iter_73_3)
		end

		for iter_73_4, iter_73_5 in ipairs(iter_73_1) do
			var_73_1 = var_73_1 + calcAirDominanceValue(var_73_0:RawGetShipById(iter_73_5), {})
		end
	end

	arg_73_0:UpdateASComparision(var_73_1, arg_73_0.suggestionValue)

	return
end

function var_0_0.UpdateBannedAS(arg_74_0)
	local var_74_0 = arg_74_0.dropDown:Find("Airsupport")

	setText(var_74_0:Find("Value1"), "-")
	setText(var_74_0:Find("Value2"), "-")
	triggerToggle(arg_74_0.dropDownSide:Find("Layout/Item2/Dot"), true)

	return
end

function var_0_0.UpdateASComparision(arg_75_0, arg_75_1, arg_75_2)
	arg_75_1 = math.floor(arg_75_1)

	local var_75_0 = arg_75_0.dropDown:Find("Airsupport")

	setText(var_75_0:Find("Text"), i18n("level_scene_title_word_3"))

	local var_75_1 = arg_75_2 < arg_75_1

	setText(var_75_0:Find("Value1"), setColorStr(arg_75_1, arg_75_2 < arg_75_1 and "#51FF55" or COLOR_WHITE))
	setText(var_75_0:Find("Value2"), arg_75_2)
	triggerToggle(arg_75_0.dropDownSide:Find("Layout/Item2/Dot"), var_75_1)

	return
end

function var_0_0.UpdateSonarRange(arg_76_0)
	for iter_76_0 = 1, 2 do
		local var_76_0 = arg_76_0.selectIds[FleetType.Normal][iter_76_0] or 0
		local var_76_1 = arg_76_0:getFleetById(var_76_0)
		local var_76_2 = var_76_1 and math.floor(var_76_1:GetFleetSonarRange()) or 0

		arg_76_0:UpdateSonarRangeValues(iter_76_0, var_76_2)
	end

	return
end

function var_0_0.UpdateEliteSonarRange(arg_77_0)
	for iter_77_0 = 1, 2 do
		if not arg_77_0.eliteFleetList[iter_77_0] then
			arg_77_0:UpdateSonarRangeValues(iter_77_0, 0)
		else
			local var_77_0 = arg_77_0.eliteFleetList[iter_77_0]

			for iter_77_1, iter_77_2 in pairs(arg_77_0.eliteCommanderList[iter_77_0]) do
				table.insert({}, {
					pos = iter_77_1,
					id = iter_77_2
				})
			end

			local var_77_1 = TypedFleet.New({
				ship_list = var_77_0,
				commanders = {},
				fleetType = FleetType.Normal
			})
			local var_77_2 = var_77_1 and math.floor(var_77_1:GetFleetSonarRange()) or 0

			arg_77_0:UpdateSonarRangeValues(iter_77_0, var_77_2)
		end
	end

	return
end

function var_0_0.UpdateSonarRangeValues(arg_78_0, arg_78_1, arg_78_2)
	setText(arg_78_0.dropDownSide:Find("Layout/Item3/Values"):GetChild(arg_78_1 - 1), arg_78_2)

	return
end

function var_0_0.clearFleet(arg_79_0, arg_79_1)
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

function var_0_0.clear(arg_80_0)
	arg_80_0.contextData.tabIndex = nil
	arg_80_0.duties = nil

	return
end

function var_0_0.onCancelHard(arg_81_0, arg_81_1)
	if arg_81_1 then
		arg_81_0:emit(LevelMediator2.ON_UPDATE_CUSTOM_FLEET, arg_81_0.chapter)
	end

	arg_81_0:emit(LevelUIConst.HIDE_FLEET_EDIT)

	return
end

function var_0_0.setHardShipVOs(arg_82_0, arg_82_1)
	arg_82_0.shipVOs = arg_82_1

	return
end

function var_0_0.setOnHard(arg_83_0, arg_83_1)
	arg_83_0.chapter = arg_83_1
	arg_83_0.mode = var_0_2.EDIT
	arg_83_0.eliteFleetList = arg_83_0.chapter:getEliteFleetList()
	arg_83_0.eliteCommanderList = arg_83_0.chapter:getEliteFleetCommanders()
	arg_83_0.propetyLimitation = arg_83_0.chapter:getConfig("property_limitation")
	arg_83_0.chapterASValue = arg_83_0.chapter:getConfig("air_dominance")
	arg_83_0.suggestionValue = arg_83_0.chapter:getConfig("best_air_dominance")
	arg_83_0.typeLimitations = arg_83_0.chapter:getConfig("limitation")

	arg_83_0:SetDutyTabEnabled(arg_83_1:isLoop())

	local var_83_0 = arg_83_0:getLimitNums(FleetType.Support) > 0

	setActive(arg_83_0.supportFleetHelp, var_83_0)

	if var_83_0 then
		arg_83_0.displayMode = var_0_3.ADDITION_SUPPORT or var_0_3.NORMAL

		arg_83_0:SwitchDisplayMode()

		arg_83_0.duties = {}

		local var_83_1 = arg_83_0.chapter.id or 0
		local var_83_2 = "lastFleetDuty_" .. var_83_1
		local var_83_3 = PlayerPrefs.GetInt(var_83_2, 0)

		if var_83_3 > 0 then
			local var_83_4 = bit.band(var_83_3, 255)
			local var_83_5 = bit.band(bit.rshift(var_83_3, 8), 255)

			if var_83_4 > 0 and var_83_5 > 0 then
				arg_83_0.duties[var_83_4] = var_83_5
			end
		end

		onButton(arg_83_0, arg_83_0.btnGo, function()
			local var_84_0 = "chapter_autofight_flag_" .. arg_83_0.chapter.id
			local var_84_1 = arg_83_0.chapter
			local var_84_2
			local var_84_3

			seriesAsync({
				function(arg_85_0)
					local var_85_0 = PlayerPrefs.GetInt("autoFight_firstUse_sp", 0) == 1

					if PlayerPrefs.GetInt(var_84_0, 1) ~= 1 or not arg_83_0:getSPItem() or var_85_0 then
						return arg_85_0()
					end

					PlayerPrefs.SetInt("autoFight_firstUse_sp", 1)
					PlayerPrefs.Save()
					arg_83_0:emit(LevelUIConst.HANDLE_SHOW_MSG_BOX, {
						hideNo = true,
						content = i18n("autofight_special_operation_tip"),
						onYes = function()
							arg_83_0:clearSPBuff()

							return
						end,
						onNo = function()
							arg_83_0:clearSPBuff()

							return
						end
					})

					return
				end,
				function(arg_87_0)
					var_84_2 = arg_83_0.chapter:GetActiveSPItemID()
					var_84_3 = arg_83_0.chapter:isLoop() and arg_83_0:GetOrderedDuties() or nil

					arg_83_0:clear()
					arg_83_0:onCancelHard()
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

		local var_83_6 = AutoBotCommand.autoBotSatisfied() and arg_83_0.chapter:isLoop()

		setActive(arg_83_0.btnMultiple, var_83_6)
		onButton(arg_83_0, arg_83_0.btnMultiple, function()
			arg_83_0:emit(LevelUIConst.OPEN_ELITE_CONTINUOUS_WINDOW, arg_83_0.chapter, arg_83_0:getSPItem(), (arg_83_0:GetOrderedDuties()))

			return
		end, SFX_PANEL)
		onButton(arg_83_0, arg_83_0.btnASHelp, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = i18n("help_battle_ac")
			})

			return
		end, SFX_UI_CLICK)
		onButton(arg_83_0, arg_83_0.btnBack, function()
			arg_83_0:clear()
			arg_83_0:onCancelHard(true)

			return
		end, SFX_CANCEL)
		onButton(arg_83_0, arg_83_0._tf:Find("bg"), function()
			arg_83_0:clear()
			arg_83_0:onCancelHard(true)

			return
		end, SFX_CANCEL)
		onToggle(arg_83_0, arg_83_0.commanderToggle, function(arg_93_0)
			if arg_93_0 then
				arg_83_0.contextData.tabIndex = var_0_0.TabIndex.Commander

				arg_83_0:flush()
			end

			return
		end, SFX_PANEL)
		onToggle(arg_83_0, arg_83_0.formationToggle, function(arg_94_0)
			if arg_94_0 then
				arg_83_0.contextData.tabIndex = var_0_0.TabIndex.Formation

				arg_83_0:flush()
			end

			return
		end, SFX_PANEL)
		onToggle(arg_83_0, arg_83_0.dutyToggle, function(arg_95_0)
			if arg_95_0 then
				arg_83_0.contextData.tabIndex = var_0_0.TabIndex.Duty

				arg_83_0:flush()
			end

			return
		end, SFX_UI_TAG)
		onToggle(arg_83_0, arg_83_0.adjustmentToggle, function(arg_96_0)
			if arg_96_0 then
				arg_83_0.contextData.tabIndex = var_0_0.TabIndex.Adjustment

				arg_83_0:flush()
			end

			return
		end, SFX_PANEL)
		setActive(arg_83_0.formationToggle, true)
		setActive(arg_83_0.commanderToggle, arg_83_0.openedCommanerSystem)
		setActive(arg_83_0.dutyToggle, arg_83_0.dutyTabEnabled)
		setActive(arg_83_0.adjustmentToggle, true)
		arg_83_0:flush()

		return
	end
end

function var_0_0.flush(arg_97_0)
	arg_97_0:updateEliteLimit()
	arg_97_0:updateEliteASValue()

	arg_97_0.lastFleetValidStatus = arg_97_0.lastFleetValidStatus or {}

	local var_97_0 = {
		not arg_97_0:IsListOfFleetEmpty(1) or nil,
		not arg_97_0:IsListOfFleetEmpty(2) or nil
	}

	if arg_97_0.dutyTabEnabled and table.getCount(arg_97_0.lastFleetValidStatus) == 2 and table.getCount(var_97_0) == 1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("autofight_change_tip"))
	end

	arg_97_0.lastFleetValidStatus = var_97_0

	arg_97_0:updateEliteFleets()
	arg_97_0:UpdateEliteSonarRange()
	arg_97_0:UpdateEliteInvestigation()

	return
end

function var_0_0.updateEliteLimit(arg_98_0)
	setActive(arg_98_0.toggleMask, false)
	setActive(arg_98_0.tfLimit, false)
	setActive(arg_98_0.tfLimitTips, #arg_98_0.propetyLimitation == 0)
	setActive(arg_98_0.tfLimitElite, #arg_98_0.propetyLimitation > 0)
	setActive(arg_98_0.tfLimitSubTip, #arg_98_0.propetyLimitation > 0)

	if #arg_98_0.propetyLimitation > 0 then
		local var_98_0, var_98_1 = arg_98_0.chapter:IsPropertyLimitationSatisfy()
		local var_98_2 = UIItemList.New(arg_98_0.tfLimitContainer, arg_98_0.tfLimitContainer:GetChild(0))

		var_98_2:make(function(arg_99_0, arg_99_1, arg_99_2)
			arg_99_1 = arg_99_1 + 1

			if arg_99_0 == UIItemList.EventUpdate then
				local var_99_0, var_99_1, var_99_2, var_99_3 = unpack(arg_98_0.propetyLimitation[arg_99_1])

				if var_98_0[arg_99_1] == 1 then
					arg_99_2:Find("Text"):GetComponent(typeof(Text)).color = Color.New(1, 0.9607843137254902, 0.5019607843137255)
				else
					local var_99_4 = arg_99_2:Find("Text")

					var_99_4:GetComponent(typeof(Text)).color = Color.New(0.9568627450980393, 0.30196078431372547, 0.30196078431372547)
				end

				setActive(arg_99_2, true)
				setText(arg_99_2:Find("Text"), (AttributeType.EliteCondition2Name(var_99_0, var_99_3) .. AttributeType.eliteConditionCompareTip(var_99_1) .. var_99_2) .. "（" .. var_98_1[var_99_0] .. "）")
			end

			return
		end)
		var_98_2:align(#arg_98_0.propetyLimitation)
		setActive(arg_98_0.tfLimitSubTip, arg_98_0.chapter:getConfig("submarine_num") > 0)
	end

	local var_98_3 = arg_98_0.chapter:isLoop() and arg_98_0.chapter:getConfig("use_oil_limit") or {}

	setActive(arg_98_0.rtCostLimit, #var_98_3 > 0)
	setText(arg_98_0.rtCostLimit:Find("text"), i18n("formationScene_use_oil_limit_tip"))

	if #var_98_3 > 0 then
		setActive(arg_98_0.rtCostLimit:Find("cost_noraml"), var_98_3[1] > 0)
		setText(arg_98_0.rtCostLimit:Find("cost_noraml/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_enemy"), var_98_3[1]))
		setActive(arg_98_0.rtCostLimit:Find("cost_boss"), var_98_3[2] > 0)
		setText(arg_98_0.rtCostLimit:Find("cost_boss/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_flagship"), var_98_3[2]))
		setActive(arg_98_0.rtCostLimit:Find("cost_sub"), var_98_3[3] > 0)
		setText(arg_98_0.rtCostLimit:Find("cost_sub/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_submarine"), var_98_3[3]))
	end

	return
end

function var_0_0.initAddButton(arg_100_0, arg_100_1, arg_100_2, arg_100_3, arg_100_4)
	local var_100_0 = arg_100_0.eliteFleetList[arg_100_4]
	local var_100_1 = {}
	local var_100_2 = {}

	for iter_100_0, iter_100_1 in ipairs(arg_100_0.eliteFleetList[arg_100_4]) do
		var_100_1[arg_100_0.shipVOs[iter_100_1]] = true

		if not arg_100_2 or arg_100_2 == arg_100_0.shipVOs[iter_100_1]:getTeamType() then
			table.insert({}, iter_100_1)
		end
	end

	removeAllChildren(arg_100_1)

	local var_100_3 = 0
	local var_100_4 = false
	local var_100_5 = 0

	arg_100_3 = var_0_0.sortTeamLimitation(arg_100_3)

	local var_100_6 = arg_100_1:GetComponent("ContentSizeFitter")
	local var_100_7 = arg_100_1:GetComponent("HorizontalLayoutGroup")

	arg_100_1:GetComponent("ContentSizeFitter").enabled = true
	arg_100_1:GetComponent("HorizontalLayoutGroup").enabled = true
	arg_100_0.isDraging = false

	for iter_100_2 = 1, 3 do
		local var_100_9
		local var_100_10

		if ({})[iter_100_2] then
			local var_100_11 = arg_100_0.shipVOs[({})[iter_100_2]]

			if not arg_100_0.shipVOs[({})[iter_100_2]] then
				var_100_11 = nil
			end

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
			else
				var_100_10 = arg_100_3[1]

				table.remove(arg_100_3, 1)
			end

			if var_100_10 == 0 then
				var_100_5 = var_100_5 + 1
			end

			local var_100_12 = var_100_9 and cloneTplTo(arg_100_0.tfShipTpl, arg_100_1) or cloneTplTo(arg_100_0.tfEmptyTpl, arg_100_1)

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

			table.sort(_.map(var_100_0, function(arg_101_0)
				return arg_100_0.shipVOs[arg_101_0]
			end), function(arg_102_0, arg_102_1)
				return var_0_1[arg_102_0:getTeamType()] < var_0_1[arg_102_1:getTeamType()] or var_0_1[arg_102_0:getTeamType()] == var_0_1[arg_102_1:getTeamType()] and table.indexof(var_100_0, arg_102_0.id) < table.indexof(var_100_0, arg_102_1.id)
			end)

			local var_100_13 = GetOrAddComponent(var_100_12, typeof(UILongPressTrigger))

			var_100_13.onLongPressed:RemoveAllListeners()

			if var_100_9 and arg_100_0.contextData.tabIndex ~= var_0_0.TabIndex.Adjustment then
				var_100_13.onLongPressed:AddListener(function()
					arg_100_0:onCancelHard(true)
					arg_100_0:emit(LevelMediator2.ON_FLEET_SHIPINFO, {
						shipId = var_100_9.id,
						shipVOs = var_0,
						chapter = arg_100_0.chapter
					})

					return
				end)
			end

			local var_100_14 = GetOrAddComponent(var_100_12, "EventTriggerListener")

			var_100_14:RemovePointClickFunc()
			var_100_14:AddPointClickFunc(function(arg_104_0, arg_104_1)
				if arg_104_0 ~= var_100_12.gameObject then
					return
				end

				if arg_100_0.isDraging then
					return
				end

				arg_100_0:onCancelHard()
				arg_100_0:emit(LevelMediator2.ON_ELITE_OEPN_DECK, {
					shipType = var_100_10,
					fleet = var_100_1,
					chapter = arg_100_0.chapter,
					shipVO = var_100_9,
					fleetIndex = arg_100_4,
					teamType = arg_100_2
				})

				return
			end)
			var_100_14:RemoveBeginDragFunc()
			var_100_14:RemoveDragFunc()
			var_100_14:RemoveDragEndFunc()

			if var_100_9 and arg_100_0.contextData.tabIndex == var_0_0.TabIndex.Adjustment then
				local var_100_15 = var_100_12.rect.width * 0.5
				local var_100_16 = {}
				local var_100_17 = {}

				var_100_14:AddBeginDragFunc(function(arg_105_0, arg_105_1)
					if arg_105_0 ~= var_100_12.gameObject then
						return
					end

					if arg_100_0.isDraging then
						return
					end

					arg_100_0.isDraging = true
					var_100_6.enabled = false
					var_100_7.enabled = false

					for iter_105_0 = 1, 3 do
						local var_105_0 = arg_100_1:GetChild(iter_105_0 - 1)

						if var_100_12 == var_105_0 then
							arg_100_0.dragIndex = iter_105_0
						end

						var_100_16[iter_105_0] = var_105_0.anchoredPosition
						var_100_17[iter_105_0] = var_105_0
					end

					return
				end)
				var_100_14:AddDragFunc(function(arg_106_0, arg_106_1)
					if arg_106_0 ~= var_100_12.gameObject then
						return
					end

					if not arg_100_0.isDraging then
						return
					end

					local var_106_0 = var_100_12.localPosition

					var_106_0.x = arg_100_0:change2ScrPos(var_100_12.parent, arg_106_1.position).x
					var_106_0.x = math.clamp(var_106_0.x, var_100_16[1].x, var_100_16[3].x)
					var_100_12.localPosition = var_106_0

					local var_106_1 = 1

					for iter_106_0 = 1, 3 do
						if var_100_12 ~= var_100_17[iter_106_0] and var_100_12.localPosition.x > var_100_17[iter_106_0].localPosition.x + (var_106_1 < arg_100_0.dragIndex and 1.1 or -1.1) * var_100_15 then
							var_106_1 = var_106_1 + 1
						end
					end

					if arg_100_0.dragIndex ~= var_106_1 then
						local var_106_2 = var_106_1 < arg_100_0.dragIndex and -1 or 1

						while arg_100_0.dragIndex ~= var_106_1 do
							local var_106_3 = arg_100_0.dragIndex
							local var_106_4 = arg_100_0.dragIndex + var_106_2

							var_100_2[arg_100_0.dragIndex + var_106_2] = var_100_2[arg_100_0.dragIndex]
							var_100_2[arg_100_0.dragIndex] = var_100_2[arg_100_0.dragIndex + var_106_2]
							var_100_17[var_106_3], var_100_17[var_106_4] = var_100_17[arg_100_0.dragIndex + var_106_2], var_100_17[arg_100_0.dragIndex]
							arg_100_0.dragIndex = arg_100_0.dragIndex + var_106_2
						end

						for iter_106_1 = 1, 3 do
							if var_100_12 ~= var_100_17[iter_106_1] then
								var_100_17[iter_106_1].anchoredPosition = var_100_16[iter_106_1]
							end
						end
					end

					return
				end)
				var_100_14:AddDragEndFunc(function(arg_107_0, arg_107_1)
					if arg_107_0 ~= var_100_12.gameObject then
						return
					end

					if not arg_100_0.isDraging then
						return
					end

					arg_100_0.isDraging = false

					for iter_107_0 = 1, 3 do
						if not var_100_2[iter_107_0] then
							for iter_107_1 = iter_107_0 + 1, 3 do
								if var_100_2[iter_107_1] then
									var_100_2[iter_107_0], var_100_2[iter_107_1] = var_100_2[iter_107_1], var_100_2[iter_107_0]
									var_100_17[iter_107_0], var_100_17[iter_107_1] = var_100_17[iter_107_1], var_100_17[iter_107_0]
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
						var_100_17[iter_107_2]:SetSiblingIndex(iter_107_2 - 1)
					end

					var_100_6.enabled = true
					var_100_7.enabled = true
					arg_100_0.dragIndex = nil

					arg_100_0.chapter:setEliteFleetByIndex(arg_100_4, {
						{
							TeamType.FormShips,
							underscore.to_array(var_100_0)
						}
					})
					arg_100_0:emit(LevelMediator2.ON_ELITE_ADJUSTMENT, arg_100_0.chapter)

					return
				end)
			end
		end
	end

	if (var_100_4 == true or var_100_5 == 3) and var_100_3 ~= 3 then
		return true
	else
		return false
	end

	return
end

function var_0_0.change2ScrPos(arg_108_0, arg_108_1, arg_108_2)
	return (LuaHelper.ScreenToLocal(arg_108_1, arg_108_2, pg.UIMgr.GetInstance().overlayCameraComp))
end

function var_0_0.updateEliteFleets(arg_109_0)
	for iter_109_0, iter_109_1 in pairs(arg_109_0.tfFleets) do
		for iter_109_2 = 1, #iter_109_1 do
			arg_109_0:UpdateEliteFleet(iter_109_0, iter_109_2)
		end
	end

	arg_109_0:RefreshDutyBar()

	return
end

function var_0_0.UpdateEliteFleet(arg_110_0, arg_110_1, arg_110_2)
	local var_110_0 = arg_110_0.contextData.tabIndex == var_0_0.TabIndex.Formation
	local var_110_1 = arg_110_0.contextData.tabIndex == var_0_0.TabIndex.Commander
	local var_110_2 = arg_110_0.contextData.tabIndex == var_0_0.TabIndex.Duty
	local var_110_3 = arg_110_0.contextData.tabIndex == var_0_0.TabIndex.Adjustment
	local var_110_4 = arg_110_2 <= arg_110_0:getLimitNums(arg_110_1)
	local var_110_6 = findTF(arg_110_0.tfFleets[arg_110_1][arg_110_2], "bg/name")
	local var_110_7 = arg_110_0.tfFleets[arg_110_1][arg_110_2]:Find("btn_recom")
	local var_110_8 = arg_110_0.tfFleets[arg_110_1][arg_110_2]:Find("btn_clear")
	local var_110_9 = arg_110_0.tfFleets[arg_110_1][arg_110_2]:Find("blank")
	local var_110_10 = arg_110_0.tfFleets[arg_110_1][arg_110_2]:Find("selected")
	local var_110_11 = arg_110_0.tfFleets[arg_110_1][arg_110_2]:Find("commander")
	local var_110_12 = arg_110_0.tfFleets[arg_110_1][arg_110_2]:Find("adjustment_flag")

	setActive(arg_110_0.tfFleets[arg_110_1][arg_110_2]:Find("btn_select"), false)

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
		setActive(var_110_10, arg_110_0:initAddButton(var_110_5:Find(TeamType.Main), TeamType.Main, arg_110_0.typeLimitations[arg_110_2][1], var_110_16) and arg_110_0:initAddButton(var_110_5:Find(TeamType.Vanguard), TeamType.Vanguard, arg_110_0.typeLimitations[arg_110_2][2], var_110_16))

		goto label_110_0
	end

	if arg_110_1 == FleetType.Submarine then
		var_110_17 = 3

		setActive(var_110_10, (arg_110_0:initAddButton(var_110_5:Find(TeamType.Main), TeamType.Submarine, {
			0,
			0,
			0
		}, var_110_16)))

		goto label_110_0
	end

	::label_110_0::

	if arg_110_1 == FleetType.Support then
		var_110_17 = 3

		if arg_110_0.chapter:getConfigMiscArg("submarine_support") then
			do
				local var_110_18 = {
					"qian",
					"qian",
					"qian"
				}

				if not {
					"qian",
					"qian",
					"qian"
				} then
					var_110_18 = {
						"hang",
						"hang",
						"hang"
					}
				end

				local var_110_19 = arg_110_0:initSupportAddButton(var_110_5:Find(TeamType.Main), nil, var_110_18, var_110_16)

				setActive(var_110_10, arg_110_0.mode == var_0_2.EDIT and var_110_19)
			end

			if not var_110_15 then
				arg_110_0:initCommander(var_110_16, var_110_11, arg_110_0.chapter)
			end

			onButton(arg_110_0, var_110_8, function()
				if not var_110_15 then
					local var_111_0 = arg_110_0.eliteFleetList[var_110_16] or arg_110_0.supportFleet

					if #var_111_0 == 0 then
						return
					end

					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("battle_preCombatLayer_clear_confirm"),
						onYes = function()
							arg_110_0:emit(LevelMediator2.ON_ELITE_CLEAR, {
								index = var_110_16,
								chapterVO = arg_110_0.chapter
							})

							return
						end
					})

					return
				end
			end)
			onButton(arg_110_0, var_110_7, function()
				if not var_110_15 then
					local var_113_0 = arg_110_0.eliteFleetList[var_110_16] or arg_110_0.supportFleet

					if #var_113_0 == var_110_17 then
						return
					end

					seriesAsync({
						function(arg_114_0)
							if var_0 == 0 then
								return arg_114_0()
							end

							pg.MsgboxMgr.GetInstance():ShowMsgBox({
								content = i18n("battle_preCombatLayer_auto_confirm"),
								onYes = arg_114_0
							})

							return
						end,
						function()
							arg_110_0:emit(LevelMediator2.ON_ELITE_RECOMMEND, {
								index = var_110_16,
								chapterVO = arg_110_0.chapter
							})

							return
						end
					})

					return
				end
			end)

			return
		end
	end
end

function var_0_0.initCommander(arg_116_0, arg_116_1, arg_116_2, arg_116_3)
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

		onButton(arg_116_0, var_116_3, function()
			arg_116_0:emit(LevelUIConst.OPEN_COMMANDER_PANEL, var_116_5, arg_116_3, arg_116_1)

			return
		end, SFX_PANEL)
		onButton(arg_116_0, var_116_4, function()
			arg_116_0:emit(LevelUIConst.OPEN_COMMANDER_PANEL, var_116_5, arg_116_3, arg_116_1)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.initSupportAddButton(arg_119_0, arg_119_1, arg_119_2, arg_119_3, arg_119_4)
	local var_119_0 = {}

	for iter_119_0, iter_119_1 in ipairs(arg_119_0.supportFleet) do
		({})[arg_119_0.shipVOs[iter_119_1]] = true

		if not arg_119_2 or arg_119_2 == arg_119_0.shipVOs[iter_119_1]:getTeamType() then
			table.insert({}, iter_119_1)
		end
	end

	removeAllChildren(arg_119_1)

	local var_119_1 = 0
	local var_119_2 = false
	local var_119_3 = 0

	arg_119_3 = var_0_0.sortTeamLimitation(arg_119_3)

	for iter_119_2 = 1, 3 do
		local var_119_4
		local var_119_5

		if ({})[iter_119_2] then
			local var_119_6 = arg_119_0.shipVOs[({})[iter_119_2]]

			if not arg_119_0.shipVOs[({})[iter_119_2]] then
				var_119_6 = nil
			end

			if var_119_6 then
				for iter_119_3, iter_119_4 in ipairs(arg_119_3) do
					if ShipType.ContainInLimitBundle(iter_119_4, var_119_6:getShipType()) then
						var_119_4 = var_119_6
						var_119_5 = iter_119_4

						table.remove(arg_119_3, iter_119_3)

						var_119_2 = var_119_2 or iter_119_4 ~= 0

						break
					end
				end
			else
				var_119_5 = arg_119_3[1]

				table.remove(arg_119_3, 1)
			end

			if var_119_5 == 0 then
				var_119_3 = var_119_3 + 1
			end

			local var_119_7 = var_119_4 and cloneTplTo(arg_119_0.tfShipTpl, arg_119_1) or cloneTplTo(arg_119_0.tfEmptyTpl, arg_119_1)

			setActive(var_119_7, true)

			if var_119_4 then
				updateShip(var_119_7, var_119_4)
				setActive(var_119_7:Find("event_block"), var_119_4:getFlag("inEvent"))

				;({})[var_119_4] = true
			else
				var_119_1 = var_119_1 + 1
			end

			setActive(var_119_7:Find("ship_type"), var_119_5 and var_119_5 ~= 0)

			if var_119_5 and var_119_5 ~= 0 then
				if type(var_119_5) == "number" then
					setImageSprite(var_119_7:Find("ship_type"), GetSpriteFromAtlas("shiptype", ShipType.Type2CNLabel(var_119_5)), true)
				elseif type(var_119_5) == "string" then
					setImageSprite(var_119_7:Find("ship_type"), GetSpriteFromAtlas("shiptype", ShipType.BundleType2CNLabel(var_119_5)), true)
				end
			end

			local var_119_8 = _.map(arg_119_0.supportFleet, function(arg_120_0)
				return arg_119_0.shipVOs[arg_120_0]
			end)
			local var_119_9 = GetOrAddComponent(var_119_7, typeof(UILongPressTrigger))

			var_119_9.onLongPressed:RemoveAllListeners()

			if var_119_4 and arg_119_0.contextData.tabIndex ~= var_0_0.TabIndex.Adjustment then
				var_119_9.onLongPressed:AddListener(function()
					arg_119_0:onCancelSupport(true)
					arg_119_0:emit(LevelMediator2.ON_SUPPORT_SHIPINFO, {
						shipId = var_119_4.id,
						shipVOs = var_119_8,
						chapter = arg_119_0.chapter
					})

					return
				end)
			end

			local var_119_10 = GetOrAddComponent(var_119_7, "EventTriggerListener")

			var_119_10:RemovePointClickFunc()
			var_119_10:AddPointClickFunc(function(arg_122_0, arg_122_1)
				if arg_122_0 ~= var_119_7.gameObject then
					return
				end

				if arg_119_0.isDraging then
					return
				end

				arg_119_0:onCancelSupport()
				arg_119_0:emit(LevelMediator2.ON_SUPPORT_OPEN_DECK, {
					shipType = var_119_5,
					fleet = var_119_0,
					chapter = arg_119_0.chapter,
					shipVO = var_119_4
				})

				return
			end)
			var_119_10:RemoveBeginDragFunc()
			var_119_10:RemoveDragFunc()
			var_119_10:RemoveDragEndFunc()
		end
	end

	if (var_119_2 == true or var_119_3 == 3) and var_119_1 ~= 3 then
		return true
	else
		return false
	end

	return
end

function var_0_0.updateSpecialOperationTickets(arg_123_0, arg_123_1)
	arg_123_0.spOPTicketItems = arg_123_1 or {}

	return
end

function var_0_0.getLegalSPBuffList(arg_124_0)
	return _.map(arg_124_0.chapter:GetSpItems(), function(arg_125_0)
		return Chapter.GetSPBuffByItem(arg_125_0:GetConfigID())
	end)
end

function var_0_0.initSPOPView(arg_126_0)
	arg_126_0.spPanel = arg_126_0.btnSp:Find("sp_panel")
	arg_126_0.spItem = arg_126_0.btnSp:Find("item")
	arg_126_0.spDesc = arg_126_0.btnSp:Find("desc")
	arg_126_0.spCheckBox = arg_126_0.btnSp:Find("checkbox")
	arg_126_0.spCheckMark = arg_126_0.spCheckBox:Find("mark")
	arg_126_0.spTpl = arg_126_0.spPanel:Find("sp_tpl")
	arg_126_0.spContainer = arg_126_0.spPanel:Find("sp_container")
	arg_126_0.spItemEmptyBlock = arg_126_0.btnSp:Find("empty_block")

	setText(arg_126_0.spItemEmptyBlock, i18n("levelScene_select_noitem"))
	removeAllChildren(arg_126_0.spContainer)

	local var_126_0 = arg_126_0:getLegalSPBuffList()
	local var_126_1 = arg_126_0.chapter:GetActiveSPItemID()

	arg_126_0:setSPBtnFormByBuffCount()

	if #var_126_0 == 0 then
		arg_126_0:clearSPBuff()
	elseif #var_126_0 == 1 then
		local var_126_2 = pg.benefit_buff_template[var_126_0[1]]
		local var_126_3 = ActivityBuff.GetBenefitCondition(pg.benefit_buff_template[var_126_0[1]].benefit_condition)

		assert(var_126_3[1] == "item")
		arg_126_0:setTicketInfo(arg_126_0.btnSp, var_126_3[2])
		setText(arg_126_0.spDesc, var_126_2.desc)
		onButton(arg_126_0, arg_126_0.btnSp:Find("item"), function()
			arg_126_0:emit(BaseUI.ON_ITEM, var_0)

			return
		end)
		onButton(arg_126_0, arg_126_0.btnSp, function()
			local var_128_0 = Chapter.GetSPOperationItemCacheKey(arg_126_0.chapter.id)

			if arg_126_0.spCheckMark.gameObject.activeSelf then
				PlayerPrefs.SetInt(var_128_0, 0)
				arg_126_0:clearSPBuff()
			else
				arg_126_0.spItemID = var_0

				PlayerPrefs.SetInt(var_128_0, arg_126_0.spItemID)
				pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_select_sp"))
				setActive(arg_126_0.spCheckMark, true)
			end

			return
		end)
		setActive(arg_126_0.spCheckMark, var_126_1 == 0)
		triggerButton(arg_126_0.btnSp)
	elseif #var_126_0 > 1 then
		setText(arg_126_0.spDesc, i18n("levelScene_select_SP_OP"))

		for iter_126_0, iter_126_1 in ipairs(var_126_0) do
			local var_126_4 = ActivityBuff.GetBenefitCondition(iter_126_1.benefit_condition)

			assert(var_126_4[1] == "item")

			local var_126_5 = cloneTplTo(arg_126_0.spTpl, arg_126_0.spContainer)

			setText(var_126_5:Find("desc"), iter_126_1.desc)
			arg_126_0:setTicketInfo(var_126_5, var_126_4[2])
			setActive(var_126_5:Find("block"), false)
			onButton(arg_126_0, var_126_5, function()
				arg_126_0:setSPBuffSelected(iter_126_1.id)
				setActive(arg_126_0.spPanel, false)

				return
			end)
		end

		onButton(arg_126_0, arg_126_0.btnSp, function()
			if arg_126_0.spPanel.gameObject.activeSelf then
				arg_126_0:clearSPBuff()
				PlayerPrefs.SetInt(Chapter.GetSPOperationItemCacheKey(arg_126_0.chapter.id), 0)
				setActive(arg_126_0.spPanel, false)
			else
				setActive(arg_126_0.spPanel, true)
				setActive(arg_126_0.btnSp:Find("item"), false)
				setText(arg_126_0.spDesc, i18n("levelScene_unselect_SP_OP"))
			end

			return
		end)

		if var_126_1 ~= 0 then
			local var_126_6

			for iter_126_2, iter_126_3 in ipairs(var_126_0) do
				if iter_126_3.id == Chapter.GetSPBuffByItem(var_126_1) then
					var_126_6 = true

					break
				end
			end

			if var_126_6 then
				arg_126_0:setSPBuffSelected((Chapter.GetSPBuffByItem(var_126_1)))
			else
				arg_126_0:clearSPBuff()
			end
		else
			arg_126_0:clearSPBuff()
		end
	end

	setActive(arg_126_0.spPanel, false)

	return
end

function var_0_0.setSPBuffSelected(arg_131_0, arg_131_1)
	local var_131_0 = pg.benefit_buff_template[arg_131_1]
	local var_131_1 = ActivityBuff.GetBenefitCondition(pg.benefit_buff_template[arg_131_1].benefit_condition)

	assert(var_131_1[1] == "item")

	arg_131_0.spItemID = var_131_1[2]

	arg_131_0:setTicketInfo(arg_131_0.btnSp, arg_131_0.spItemID)
	setText(arg_131_0.spDesc, var_131_0.desc)
	PlayerPrefs.SetInt(Chapter.GetSPOperationItemCacheKey(arg_131_0.chapter.id), arg_131_0.spItemID)

	return
end

function var_0_0.clearSPBuff(arg_132_0)
	local var_132_0 = arg_132_0:getLegalSPBuffList()

	arg_132_0.spItemID = nil

	arg_132_0:setSPBtnFormByBuffCount()

	if #var_132_0 == 0 then
		setActive(arg_132_0.btnSp:Find("item"), false)
	elseif #var_132_0 == 1 then
		setActive(arg_132_0.btnSp:Find("item"), true)
		setActive(arg_132_0.spCheckMark, false)
	elseif #var_132_0 > 1 then
		setActive(arg_132_0.btnSp:Find("item"), false)
		setText(arg_132_0.spDesc, i18n("levelScene_select_SP_OP"))
	end

	return
end

function var_0_0.setSPBtnFormByBuffCount(arg_133_0)
	local var_133_0 = arg_133_0:getLegalSPBuffList()

	if #var_133_0 == 0 then
		setActive(arg_133_0.spItemEmptyBlock, true)
		setActive(arg_133_0.spDesc, false)
		setActive(arg_133_0.spCheckBox, false)
		setActive(arg_133_0.btnSp:Find("add"), false)
	elseif #var_133_0 == 1 then
		setActive(arg_133_0.spItemEmptyBlock, false)
		setActive(arg_133_0.spDesc, true)
		setActive(arg_133_0.spCheckBox, true)
		setActive(arg_133_0.btnSp:Find("add"), false)
	elseif #var_133_0 > 1 then
		setActive(arg_133_0.spItemEmptyBlock, false)
		setActive(arg_133_0.spDesc, true)
		setActive(arg_133_0.spCheckBox, false)
		setActive(arg_133_0.btnSp:Find("add"), true)
	end

	return
end

function var_0_0.setTicketInfo(arg_134_0, arg_134_1, arg_134_2)
	local var_134_0

	arg_134_2 = tonumber(arg_134_2)

	for iter_134_0, iter_134_1 in ipairs(arg_134_0.spOPTicketItems) do
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

function var_0_0.getSPItem(arg_135_0)
	return arg_135_0.spItemID
end

function var_0_0.SetDuty(arg_136_0, arg_136_1, arg_136_2)
	if not arg_136_2 or not arg_136_0.duties then
		return
	end

	if arg_136_0.duties[arg_136_1] == arg_136_2 then
		return
	end

	arg_136_0.duties[arg_136_1] = arg_136_2
	arg_136_0.duties[3 - arg_136_1] = nil

	arg_136_0:RefreshDutyBar()

	return
end

function var_0_0.UpdateDuties(arg_137_0)
	if not arg_137_0.dutyTabEnabled then
		return
	end

	local var_137_0 = 0
	local var_137_1 = 0

	for iter_137_0 = 1, 2 do
		if not arg_137_0:IsListOfFleetEmpty(iter_137_0) then
			var_137_0 = var_137_0 + 1
			var_137_1 = iter_137_0
		end
	end

	if var_137_0 == 0 then
		table.clear(arg_137_0.duties)

		goto label_137_0
	end

	if var_137_0 == 1 then
		arg_137_0.duties[var_137_1] = ChapterFleet.DUTY_KILLALL
		arg_137_0.duties[3 - var_137_1] = nil

		goto label_137_0
	end

	::label_137_0::

	if var_137_0 == 2 then
		if arg_137_0.duties[1] then
			if arg_137_0.duties[1] < 3 then
				arg_137_0.duties[2] = 3 - arg_137_0.duties[1] or 7 - arg_137_0.duties[1]

				goto label_137_0

				if arg_137_0.duties[2] then
					if arg_137_0.duties[2] < 3 then
						arg_137_0.duties[1] = 3 - arg_137_0.duties[2] or 7 - arg_137_0.duties[2]

						if false then
							arg_137_0.duties[1] = ChapterFleet.DUTY_CLEANPATH
							arg_137_0.duties[2] = ChapterFleet.DUTY_KILLBOSS
						end

						if var_137_1 ~= 0 then
							local var_137_2 = arg_137_0.chapter.id or 0
							local var_137_3 = "lastFleetDuty_" .. var_137_2
							local var_137_4 = 0

							for iter_137_1, iter_137_2 in ipairs({
								var_137_1,
								arg_137_0.duties[var_137_1]
							}) do
								var_137_4 = var_137_4 + bit.lshift(iter_137_2, 8 * (iter_137_1 - 1))
							end

							PlayerPrefs.SetInt(var_137_3, var_137_4)
							PlayerPrefs.Save()
						end

						return
					end
				end
			end
		end
	end
end

function var_0_0.RefreshDutyBar(arg_138_0)
	arg_138_0:UpdateDuties()
	arg_138_0:UpdateDutyBar()

	return
end

function var_0_0.UpdateDutyBar(arg_139_0)
	local var_139_0 = arg_139_0.contextData.tabIndex == var_0_0.TabIndex.Duty

	for iter_139_0 = 1, 2 do
		setActive(arg_139_0._tf:Find(string.format("panel/ShipList/fleet/%d/DutySelect", iter_139_0)), var_139_0 and arg_139_0.duties[iter_139_0] ~= nil)
	end

	setActive(arg_139_0._tf:Find("panel/ShipList/sub/1/DutySelect"), var_139_0 and not arg_139_0:IsListOfFleetEmpty(3))

	if not var_139_0 then
		return
	end

	for iter_139_1, iter_139_2 in pairs(arg_139_0.duties) do
		for iter_139_3 = 1, 4 do
			setActive(arg_139_0.dutyItems[iter_139_1][iter_139_3]:Find("Checkmark"), iter_139_3 == iter_139_2)
		end
	end

	local var_139_1 = ys.Battle.BattleState.IsAutoSubActive()

	for iter_139_4 = 1, 2 do
		setActive(arg_139_0.dutyItems[3][iter_139_4]:Find("Checkmark"), iter_139_4 == 1 == var_139_1)
	end

	return
end

function var_0_0.GetOrderedDuties(arg_140_0)
	if not arg_140_0.duties then
		return
	end

	arg_140_0:UpdateDuties()

	for iter_140_0 = 1, 2 do
		local var_140_0

		if arg_140_0.duties[iter_140_0] then
			({})[1] = arg_140_0.duties[iter_140_0]
			var_140_0 = 1 + 1
		end
	end

	return {}
end

function var_0_0.SetAutoSub(arg_141_0, arg_141_1)
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
	arg_141_0:UpdateDutyBar()

	return
end

function var_0_0.GetValidFleets(arg_142_0, arg_142_1)
	if arg_142_0.mode == var_0_2.SELECT then
		local var_142_0 = {}

		if arg_142_1 then
			local var_142_1 = {
				arg_142_1
			}

			if not {
				arg_142_1
			} then
				var_142_1 = {
					FleetType.Normal,
					FleetType.Submarine
				}
			end

			for iter_142_0, iter_142_1 in ipairs(var_142_1) do
				for iter_142_2, iter_142_3 in ipairs(arg_142_0.selectIds[iter_142_1]) do
					if iter_142_3 > 0 then
						table.insert(var_142_0, arg_142_0.fleets[iter_142_3])
					end
				end
			end

			do return var_142_0 end

			if false then
				if arg_142_0.mode == var_0_2.EDIT then
					local var_142_2 = {}
					local var_142_3
					local var_142_4

					if arg_142_1 == FleetType.Normal then
						var_142_3 = 1
						var_142_4 = 2
					elseif arg_142_1 == FleetType.Submarine then
						var_142_3 = 3
						var_142_4 = 3
					elseif not arg_142_1 then
						var_142_3 = 1
						var_142_4 = 3
					end

					for iter_142_4 = var_142_3, var_142_4 do
						if #arg_142_0.eliteFleetList[iter_142_4] > 0 then
							for iter_142_5, iter_142_6 in pairs(arg_142_0.eliteCommanderList[iter_142_4]) do
								table.insert({}, {
									pos = iter_142_5,
									id = iter_142_6
								})
							end

							table.insert(var_142_2, (TypedFleet.New({
								ship_list = arg_142_0.eliteFleetList[iter_142_4],
								commanders = {},
								fleetType = FleetType.Normal
							})))
						end
					end

					return var_142_2
				end
			end

			return
		end
	end
end

function var_0_0.IsListOfFleetEmpty(arg_143_0, arg_143_1)
	if arg_143_1 > 0 and arg_143_1 < 3 and arg_143_1 > arg_143_0:getLimitNums(FleetType.Normal) then
		return true
	elseif arg_143_1 == 3 and arg_143_1 - 2 > arg_143_0:getLimitNums(FleetType.Submarine) then
		return true
	end

	if arg_143_0.mode == var_0_2.SELECT then
		local var_143_0

		if arg_143_1 > 0 and arg_143_1 < 3 then
			var_143_0 = arg_143_0.selectIds[FleetType.Normal][arg_143_1] or 0
		elseif arg_143_1 == 3 then
			var_143_0 = arg_143_0.selectIds[FleetType.Submarine][arg_143_1 - 2] or 0
		end

		return var_143_0 == 0
	elseif arg_143_0.mode == var_0_2.EDIT then
		return #arg_143_0.eliteFleetList[arg_143_1] == 0
	end

	return
end

function var_0_0.GetListFleets(arg_144_0)
	local var_144_0 = arg_144_0:getLimitNums(FleetType.Normal)
	local var_144_1 = arg_144_0:getLimitNums(FleetType.Submarine)

	if arg_144_0.mode == var_0_2.SELECT then
		for iter_144_0 = 1, var_144_0 do
			local var_144_2 = arg_144_0.selectIds[FleetType.Normal][iter_144_0] or 0

			if var_144_2 > 0 then
				({})[iter_144_0] = arg_144_0.fleets[var_144_2] or nil
			end
		end

		for iter_144_1 = 1, var_144_1 do
			local var_144_3 = arg_144_0.selectIds[FleetType.Submarine][iter_144_1] or 0
			local var_144_4 = iter_144_1 + var_144_0

			if var_144_3 > 0 then
				({})[var_144_4] = arg_144_0.fleets[var_144_3] or nil
			end
		end
	elseif arg_144_0.mode == var_0_2.EDIT then
		for iter_144_2 = 1, var_144_0 do
			table.insert({}, iter_144_2)
		end

		for iter_144_3 = 1, var_144_1 do
			table.insert({}, iter_144_3 + 2)
		end

		for iter_144_4 = 1, #{} do
			local var_144_5 = ({})[iter_144_4]
			local var_144_7 = arg_144_0.eliteFleetList[({})[iter_144_4]]

			if #arg_144_0.eliteFleetList[({})[iter_144_4]] > 0 then
				if var_144_5 > 2 then
					local var_144_8 = FleetType.Submarine or FleetType.Normal
					local var_144_9 = {}

					for iter_144_5, iter_144_6 in pairs(arg_144_0.eliteCommanderList[var_144_5]) do
						table.insert(var_144_9, {
							pos = iter_144_5,
							id = iter_144_6
						})
					end

					;({})[iter_144_4] = TypedFleet.New({
						ship_list = var_144_7,
						commanders = var_144_9,
						fleetType = var_144_8
					})
				end
			end
		end
	end

	return {}
end

function var_0_0.IsSelectMode(arg_145_0)
	return arg_145_0.mode == var_0_2.SELECT
end

function var_0_0.SwitchDisplayMode(arg_146_0)
	local var_146_0 = arg_146_0.displayMode == var_0_3.ADDITION_SUPPORT

	setActive(arg_146_0._tf:Find("panel/ShipList/Line"), not (arg_146_0.displayMode == var_0_3.ADDITION_SUPPORT))
	setActive(arg_146_0._tf:Find("panel/ShipList/support"), var_146_0)

	local var_146_1 = arg_146_0._tf:Find("panel/ShipList"):GetComponent(typeof(VerticalLayoutGroup))
	local var_146_2 = var_146_1.padding

	var_146_2.top = var_146_0 and 9 or 20
	var_146_2.bottom = var_146_0 and 14 or 25
	var_146_1.padding = var_146_2
	var_146_1.spacing = var_146_0 and 13 or 20

	return
end

function var_0_0.sortTeamLimitation(arg_147_0)
	arg_147_0 = Clone(arg_147_0)

	table.sort(arg_147_0, function(arg_148_0, arg_148_1)
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

	return arg_147_0
end

return var_0_0
