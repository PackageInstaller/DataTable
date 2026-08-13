class = var_0_10000

local var_0_0 = "GuildMissionFormationPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuildEventBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "GuildMissionFormationPage"
end

function var_0_1.OnRefreshMission(arg_2_0, arg_2_1)
	if not arg_2_0.mission or arg_2_0.mission.id ~= arg_2_1.id then
		return
	end

	arg_2_0:Flush(arg_2_1)

	return
end

function var_0_1.OnFormationDone(arg_3_0)
	local var_3_0 = {}

	arg_3_0.loading = true
	pairs = var_2

	for iter_3_0, iter_3_1 in var_2(arg_3_0.shipGos) do
		table = var_1_10007

		var_1_10007.insert(var_3_0, function(arg_4_0)
			local var_4_0 = iter_3_1

			var_1.SetAction(var_4_0, "victory", 0)

			local var_4_1 = iter_3_1

			var_1.SetActionCallBack(var_4_1, function(arg_5_0)
				if arg_5_0 == "finish" then
					local var_5_0 = iter_3_1

					var_1.SetActionCallBack(var_5_0, nil)

					local var_5_1 = iter_3_1

					var_1.SetAction(var_5_1, "stand", 0)
					arg_4_0()
				end

				return
			end)

			return
		end)
	end

	parallelAsync = var_2

	var_2(var_3_0, function()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		arg_3_0.loading = false

		return
	end)

	local var_3_1

	if not arg_3_0.canFormationIndex then
		var_3_1 = 1
	end

	ipairs = var_3

	for iter_3_2, iter_3_3 in var_3(arg_3_0.pageFooter) do
		setActive = var_1_10008

		var_1_10008(iter_3_3, iter_3_2 <= var_3_1)
	end

	setActive = var_3

	var_3(arg_3_0.pageFooterAdd, false)

	return
end

function var_0_1.OnLoaded(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.closeBtn = var_1.Find(var_7_0, "frame/close")

	local var_7_1 = arg_7_0._tf
	local var_7_2 = var_1.Find(var_7_1, "frame/title")
	local var_7_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_7_0.titleTxt = var_7_3(var_7_2, var_4(var_1_10006))

	local var_7_4 = arg_7_0._tf

	arg_7_0.recomBtn = var_1.Find(var_7_4, "frame/recom")

	local var_7_5 = arg_7_0._tf

	arg_7_0.clearBtn = var_1.Find(var_7_5, "frame/clear")

	local var_7_6 = arg_7_0._tf

	arg_7_0.goBtn = var_1.Find(var_7_6, "frame/bottom/go")

	local var_7_7 = arg_7_0._tf

	arg_7_0.inProgressBtn = var_1.Find(var_7_7, "frame/bottom/doingBtn")

	local var_7_8 = arg_7_0._tf
	local var_7_9 = var_1.Find(var_7_8, "frame/bottom/desc/area/Text")
	local var_7_10 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_7_0.battleAreaTxt = var_7_10(var_7_9, var_4(var_1_10006))

	local var_7_11 = arg_7_0._tf
	local var_7_12 = var_1.Find(var_7_11, "frame/bottom/desc/type/Text")
	local var_7_13 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_7_0.battleTypeTxt = var_7_13(var_7_12, var_4(var_1_10006))
	UIItemList = var_1

	local var_7_14 = var_1.New
	local var_7_15 = arg_7_0._tf
	local var_7_16 = var_3.Find(var_7_15, "frame/bottom/award/list")
	local var_7_17 = arg_7_0._tf

	arg_7_0.awardList = var_7_14(var_7_16, var_4.Find(var_7_17, "frame/bottom/award/list/item"))

	local var_7_18 = arg_7_0._tf
	local var_7_19 = var_1.Find(var_7_18, "frame/bottom/desc/target/content/Text")
	local var_7_20 = var_1.GetComponent

	typeof = var_4
	Text = var_7_17
	arg_7_0.target1Text = var_7_20(var_7_19, var_4(var_7_17))

	local var_7_21 = arg_7_0._tf
	local var_7_22 = var_1.Find(var_7_21, "frame/bottom/desc/target/content/Text2")
	local var_7_23 = var_1.GetComponent

	typeof = var_4
	Text = var_7_17
	arg_7_0.target2Text = var_7_23(var_7_22, var_4(var_7_17))

	local var_7_24 = arg_7_0._tf
	local var_7_25 = var_1.Find(var_7_24, "frame/bottom/desc/target/content1/Text")
	local var_7_26 = var_1.GetComponent

	typeof = var_4
	Text = var_7_17
	arg_7_0.target1Text4Effect = var_7_26(var_7_25, var_4(var_7_17))

	local var_7_27 = arg_7_0._tf
	local var_7_28 = var_1.Find(var_7_27, "frame/bottom/desc/target/content1/Text2")
	local var_7_29 = var_1.GetComponent

	typeof = var_4
	Text = var_7_17
	arg_7_0.target2Text4Effect = var_7_29(var_7_28, var_4(var_7_17))

	local var_7_30 = arg_7_0._tf
	local var_7_31 = var_1.Find(var_7_30, "frame/bottom/score_addition/Text")
	local var_7_32 = var_1.GetComponent

	typeof = var_4
	Text = var_7_17
	arg_7_0.scoreAdditionTxt = var_7_32(var_7_31, var_4(var_7_17))

	local var_7_33 = arg_7_0._tf
	local var_7_34 = var_1.Find(var_7_33, "frame/bottom/effect_addition/Text")
	local var_7_35 = var_1.GetComponent

	typeof = var_4
	Text = var_7_17
	arg_7_0.effectAdditionTxt = var_7_35(var_7_34, var_4(var_7_17))

	local var_7_36 = arg_7_0._tf
	local var_7_37 = var_1.Find(var_7_36, "frame/bottom/effect/Text")
	local var_7_38 = var_1.GetComponent

	typeof = var_4
	Text = var_7_17
	arg_7_0.effectTxt = var_7_38(var_7_37, var_4(var_7_17))

	local var_7_39 = arg_7_0._tf
	local var_7_40 = var_1.Find(var_7_39, "frame/bottom/bg")
	local var_7_41 = var_1.GetComponent

	typeof = var_4
	Image = var_7_17
	arg_7_0.bg = var_7_41(var_7_40, var_4(var_7_17))

	local var_7_42 = {}
	local var_7_43 = arg_7_0._tf

	var_7_42[1] = var_2.Find(var_7_43, "frame/single/dot/1")

	local var_7_44 = arg_7_0._tf

	var_7_42[2] = var_2.Find(var_7_44, "frame/single/dot/2")

	local var_7_45 = arg_7_0._tf

	var_7_42[3] = var_2.Find(var_7_45, "frame/single/dot/3")

	local var_7_46 = arg_7_0._tf

	var_7_42[4] = var_2.Find(var_7_46, "frame/single/dot/4")
	arg_7_0.pageFooter = var_7_42

	local var_7_47 = arg_7_0._tf

	arg_7_0.pageFooterAdd = var_1.Find(var_7_47, "frame/single/dot/add")

	local var_7_48 = arg_7_0._tf

	arg_7_0.nextBtn = var_1.Find(var_7_48, "frame/single/next")

	local var_7_49 = arg_7_0._tf

	arg_7_0.prevBtn = var_1.Find(var_7_49, "frame/single/prev")
	setText = var_1

	local var_7_50 = arg_7_0._tf
	local var_7_51 = var_3.Find(var_7_50, "frame/bottom/desc/area")

	i18n = var_4

	var_1(var_7_51, var_4("guild_word_battle_area"))

	setText = var_1

	local var_7_52 = arg_7_0._tf
	local var_7_53 = var_3.Find(var_7_52, "frame/bottom/desc/type")

	i18n = var_4

	var_1(var_7_53, var_4("guild_word_battle_type"))

	return
end

function var_0_1.OnInit(arg_8_0)
	local function var_8_0()
		if arg_8_0.contextData.index > 1 then
			triggerToggle = var_0

			var_0(arg_8_0.pageFooter[arg_8_0.contextData.index - 1], true)
		end

		return
	end

	local function var_8_1()
		local var_10_0 = arg_8_0.contextData.index
		local var_10_1 = arg_8_0.mission

		if var_10_0 < var_1.GetMaxFleet(var_10_1) then
			local var_10_2 = arg_8_0.contextData.index + 1
			local var_10_3 = arg_8_0.mission

			if var_1.GetFleetCnt(var_10_3) < var_10_2 then
				triggerToggle = var_1

				var_1(arg_8_0.pageFooterAdd, true)
			else
				triggerToggle = var_1

				var_1(arg_8_0.pageFooter[var_10_2], true)
			end
		end

		return
	end

	addSlip = var_1_10003
	SLIP_TYPE_HRZ = var_1_10005

	local var_8_2 = arg_8_0._tf

	var_1_10003(var_1_10005, var_6.Find(var_8_2, "frame"), var_8_0, var_8_1)

	onButton = var_1_10003

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.nextBtn
	local var_8_5 = var_8_1

	SFX_PANEL = var_8

	var_1_10003(var_8_3, var_8_4, var_8_5, var_8)

	onButton = var_1_10003

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.prevBtn
	local var_8_8 = var_8_0

	SFX_PANEL = var_8

	var_1_10003(var_8_6, var_8_7, var_8_8, var_8)

	onButton = var_1_10003

	local var_8_9 = arg_8_0
	local var_8_10 = arg_8_0.closeBtn

	local function var_8_11()
		arg_8_0.contextData.missionShips = nil

		local var_11_0 = arg_8_0

		var_0.Hide(var_11_0)

		return
	end

	SFX_PANEL = var_8

	var_1_10003(var_8_9, var_8_10, var_8_11, var_8)

	onButton = var_1_10003

	local var_8_12 = arg_8_0
	local var_8_13 = arg_8_0.recomBtn

	local function var_8_14()
		local var_12_0 = arg_8_0

		if not var_0.CheckFormation(var_12_0) then
			return
		end

		local var_12_1 = arg_8_0
		local var_12_2 = var_0.emit

		GuildEventMediator = var_2_10003

		var_12_2(var_12_1, var_2_10003.ON_GET_FORMATION, function()
			getProxy = var_3_10000
			GuildProxy = var_3_10002

			local var_13_0 = var_3_10000(var_3_10002)

			if #var_0.GetRecommendShipsForMission(var_13_0, arg_8_0.mission) == 0 then
				pg = var_1

				local var_13_1 = var_1.TipsMgr.GetInstance()
				local var_13_2 = var_1.ShowTips

				i18n = var_3_10004

				var_13_2(var_13_1, var_3_10004("guild_event_recomm_ship_failed"))

				return
			end

			arg_8_0.contextData.missionShips = var_0

			local var_13_3 = arg_8_0

			var_1.UpdateFleet(var_13_3, arg_8_0.contextData.index)

			return
		end)

		return
	end

	SFX_PANEL = var_8

	var_1_10003(var_8_12, var_8_13, var_8_14, var_8)

	onButton = var_1_10003

	local var_8_15 = arg_8_0
	local var_8_16 = arg_8_0.clearBtn

	local function var_8_17()
		local var_14_0 = arg_8_0

		if not var_0.CheckFormation(var_14_0) then
			return
		end

		arg_8_0.contextData.missionShips = {}

		local var_14_1 = arg_8_0

		var_0.UpdateFleet(var_14_1, arg_8_0.contextData.index)

		return
	end

	SFX_PANEL = var_8

	var_1_10003(var_8_15, var_8_16, var_8_17, var_8)

	onButton = var_1_10003

	local var_8_18 = arg_8_0
	local var_8_19 = arg_8_0.goBtn

	local function var_8_20()
		local var_15_0 = arg_8_0.mission

		if var_0.IsFinish(var_15_0) then
			pg = var_0

			local var_15_1 = var_0.TipsMgr.GetInstance()
			local var_15_2 = var_0.ShowTips

			i18n = var_2_10003

			var_15_2(var_15_1, var_2_10003("guild_event_is_finish"))

			return
		end

		local var_15_3 = arg_8_0

		if not var_0.CheckFormation(var_15_3) then
			return
		end

		if not arg_8_0.contextData.missionShips or #arg_8_0.contextData.missionShips == 0 then
			return
		end

		pg = var_0

		local var_15_4 = var_0.MsgboxMgr.GetInstance()
		local var_15_5 = var_0.ShowMsgBox
		local var_15_6 = {}

		i18n = var_2_10004
		var_15_6.content = var_2_10004("guild_event_start_event_tip")

		function var_15_6.onYes()
			local var_16_0 = arg_8_0
			local var_16_1 = var_0.emit

			GuildEventMediator = var_3_10003

			var_16_1(var_16_0, var_3_10003.JOIN_MISSION, arg_8_0.mission.id, arg_8_0.contextData.missionShips)

			return
		end

		var_15_5(var_15_4, var_15_6)

		return
	end

	SFX_PANEL = var_8

	var_1_10003(var_8_18, var_8_19, var_8_20, var_8)

	arg_8_0.shipGos = {}

	return
end

function var_0_1.OnShow(arg_17_0)
	arg_17_0.loading = nil
	arg_17_0.maxShipCnt = arg_17_0.extraData.shipCnt

	local var_17_0 = arg_17_0.extraData.mission

	arg_17_0:UpdateLayout()
	arg_17_0:Flush(var_17_0)
	arg_17_0:UpdatePageFooter()
	arg_17_0:AddNextFormationTimer()

	return
end

function var_0_1.UpdatePageFooter(arg_18_0)
	local var_18_0 = arg_18_0.mission
	local var_18_1 = var_1.CanFormation(var_18_0)
	local var_18_2 = var_1:GetFleetCnt()

	ipairs = var_18_0

	for iter_18_0, iter_18_1 in var_18_0(arg_18_0.pageFooter) do
		setActive = var_1_10009

		var_1_10009(iter_18_1, iter_18_0 <= var_18_2)

		onToggle = var_1_10009

		local var_18_3 = arg_18_0
		local var_18_4 = iter_18_1

		local function var_18_5(arg_19_0)
			if arg_19_0 then
				local var_19_0 = arg_18_0

				var_1.UpdateFleet(var_19_0, iter_18_0)

				local var_19_1 = arg_18_0

				var_1.UpdateSwitchBtns(var_19_1)
			end

			return
		end

		SFX_PANEL = var_1_10014

		var_1_10009(var_18_3, var_18_4, var_18_5, var_1_10014)
	end

	setActive = var_4

	var_4(arg_18_0.pageFooterAdd, var_18_1)

	onToggle = var_4

	local var_18_6 = arg_18_0
	local var_18_7 = arg_18_0.pageFooterAdd

	local function var_18_8(arg_20_0)
		if arg_20_0 then
			local var_20_0 = arg_18_0

			var_1.UpdateFleet(var_20_0, var_18_2 + 1)
		end

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_18_6, var_18_7, var_18_8, var_1_10009)

	local var_18_9

	if not arg_18_0.contextData.index then
		var_18_9 = 1
	end

	if var_18_2 < var_18_9 then
		triggerToggle = var_5

		var_5(arg_18_0.pageFooterAdd, true)
	else
		triggerToggle = var_5

		var_5(arg_18_0.pageFooter[var_18_9], true)
	end

	return
end

function var_0_1.UpdateSwitchBtns(arg_21_0)
	local var_21_0 = arg_21_0.mission
	local var_21_1 = var_1.GetMaxFleet(var_21_0)
	local var_21_2 = arg_21_0.contextData.index

	setActive = var_21_0

	var_21_0(arg_21_0.prevBtn, var_21_2 ~= 1)

	setActive = var_21_0

	var_21_0(arg_21_0.nextBtn, var_21_2 < var_21_1)

	return
end

function var_0_1.AddNextFormationTimer(arg_22_0)
	local var_22_0 = arg_22_0.mission

	if var_1.IsMaxFleetCnt(var_22_0) then
		return
	end

	local function var_22_1(arg_23_0)
		local var_23_0 = arg_22_0
		local var_23_1 = var_0

		var_23_0.canFormationIndex = var_2.GetCanFormationIndex(var_23_1)
		setActive = var_23_0

		var_23_0(arg_22_0.pageFooterAdd, true)

		if arg_23_0 then
			triggerToggle = var_23_0

			var_23_0(arg_22_0.pageFooterAdd, false)
		end

		local var_23_2 = var_0

		var_1.RecordFormationTip(var_23_2)

		setActive = var_1

		local var_23_3 = arg_22_0.pageFooterAdd
		local var_23_4 = var_3.Find(var_23_3, "tip")
		local var_23_5 = var_0

		var_1(var_23_4, var_4.ShouldShowFormationTip(var_23_5))

		local var_23_6 = arg_22_0

		var_1.UpdateSwitchBtns(var_23_6)

		return
	end

	if not var_1:CanFormation() then
		local var_22_2 = var_1:GetNextFormationTime()

		pg = var_22_0

		local var_22_3 = var_22_0.TimeMgr.GetInstance()
		local var_22_4 = var_22_2 - var_4.GetServerTime(var_22_3)

		Timer = var_22_3
		arg_22_0.timer = var_22_3.New(function()
			local var_24_0 = arg_22_0.timer

			var_0.Stop(var_24_0)

			arg_22_0.timer = nil

			var_22_1(true)

			return
		end, var_22_4, 1)

		local var_22_5 = arg_22_0.timer

		var_6.Start(var_22_5)
	else
		var_22_1()
	end

	return
end

function var_0_1.Flush(arg_25_0, arg_25_1)
	arg_25_0.mission = arg_25_1
	arg_25_0.canFormationIndex = arg_25_1:GetCanFormationIndex()

	arg_25_0:InitView()

	return
end

function var_0_1.UpdateLayout(arg_26_0)
	local var_26_0 = arg_26_0.bg

	GetSpriteFromAtlas = var_1_10002
	var_26_0.sprite = var_1_10002("ui/GuildFormationUI_atlas", "bg3")

	local var_26_1 = arg_26_0._tf

	arg_26_0.shipContainer = var_1.Find(var_26_1, "frame/single")

	local var_26_2 = arg_26_0.bg.gameObject.transform

	Vector2 = var_26_1
	var_26_2.sizeDelta = var_26_1(arg_26_0.bg.gameObject.transform.sizeDelta.x, 212)
	setActive = var_26_2

	var_26_2(var_1, true)

	return
end

function var_0_1.InitView(arg_27_0)
	local var_27_0 = arg_27_0.mission

	if arg_27_0.initId ~= var_27_0.id then
		local var_27_1 = var_27_0:GetAwards()
		local var_27_2 = arg_27_0.awardList

		var_3.make(var_27_2, function(arg_28_0, arg_28_1, arg_28_2)
			UIItemList = var_2_10003

			if arg_28_0 == var_2_10003.EventUpdate then
				local var_28_0 = var_27_1[arg_28_1 + 1]
				local var_28_1 = {
					type = var_28_0[1],
					id = var_28_0[2],
					count = var_28_0[3]
				}

				updateDrop = var_5

				var_5(arg_28_2, var_28_1)

				onButton = var_5

				local var_28_2 = arg_27_0
				local var_28_3 = arg_28_2

				local function var_28_4()
					local var_29_0 = arg_27_0
					local var_29_1 = var_0.send

					BaseUI = var_3_10003

					var_29_1(var_29_0, var_3_10003.ON_DROP, var_28_1)

					return
				end

				SFX_PANEL = var_2_10010

				var_5(var_28_2, var_28_3, var_28_4, var_2_10010)
			end

			return
		end)

		local var_27_3 = arg_27_0.awardList

		var_3.align(var_27_3, #var_27_1)

		arg_27_0.battleAreaTxt.text = var_27_0:getConfig("ship_camp_display")
		arg_27_0.battleTypeTxt.text = var_27_0:getConfig("ship_type_display")
		arg_27_0.titleTxt.text = var_27_0:GetName()
		arg_27_0.initId = var_27_0.id
	end

	return
end

function var_0_1.UpdateFleet(arg_30_0, arg_30_1)
	arg_30_0:ClearSlots()

	local var_30_0 = arg_30_0.mission
	local var_30_1 = arg_30_0.maxShipCnt
	local var_30_2

	if arg_30_1 == arg_30_0.canFormationIndex then
		var_30_2 = arg_30_0.contextData.missionShips or var_30_0:GetFleetByIndex(arg_30_1)
	else
		var_30_2 = var_30_0:GetFleetByIndex(arg_30_1)
	end

	local var_30_3 = {}

	var_30_2 = var_30_2 or {}

	for iter_30_0 = 1, var_30_1 do
		var_1_10012 = arg_30_0.shipContainer
		var_1_10010 = var_1_10010.GetChild(var_1_10012, iter_30_0 - 1)
		table = var_1_10011

		var_1_10011.insert(var_30_3, function(arg_31_0)
			local var_31_0 = arg_30_0

			var_1.UpdateShipSlot(var_31_0, iter_30_0, var_1_10010, var_30_2, arg_31_0)

			return
		end)
	end

	pg = var_6

	local var_30_4 = var_6.UIMgr.GetInstance()

	var_6.LoadingOn(var_30_4, false)

	parallelAsync = var_6

	var_6(var_30_3, function()
		pg = var_2_10000

		local var_32_0 = var_2_10000.UIMgr.GetInstance()

		var_0.LoadingOff(var_32_0)

		return
	end)

	if var_30_0:IsEliteType() then
		local var_30_5 = arg_30_0
		local var_30_6 = arg_30_0.GetTagShipCnt(var_30_5, var_30_2)

		if var_30_0:GetSquadronTargetCnt() <= var_30_6 then
			COLOR_GREEN = var_30_5

			if not var_30_5 then
				COLOR_RED = var_30_5
			end

			local var_30_7 = var_30_0:GetSquadronDisplay()

			string = var_1_10010

			local var_30_8 = var_1_10010.format("%s : (<color=%s>%d/%d</color>)", var_30_7, var_30_5, var_30_6, var_7)
			local var_30_9 = arg_30_0.target2Text

			HXSet = var_1_10012
			var_30_9.text = var_1_10012.hxLan(var_30_8)

			local var_30_10 = arg_30_0.target2Text4Effect

			HXSet = var_1_10012
			var_30_10.text = var_1_10012.hxLan(var_30_8)

			if false then
				var_30_6 = arg_30_0.target2Text
				var_30_6.text = ""
				var_30_6 = arg_30_0.target2Text4Effect
				var_30_6.text = ""
			end

			GuildMission = var_30_6

			local var_30_11 = var_30_6.CalcMyEffect(var_30_2)

			arg_30_0.effectTxt.text = var_30_11

			local var_30_12 = arg_30_0:CalcEffectAddition(var_30_2)
			local var_30_13, var_30_14, var_30_15 = arg_30_0:CalcScoreAddition(var_30_2)
			local var_30_16 = arg_30_0.scoreAdditionTxt

			i18n = var_1_10012
			var_30_16.text = var_1_10012("guild_word_score_addition") .. var_30_13

			local var_30_17 = arg_30_0.effectAdditionTxt

			i18n = var_12
			var_30_17.text = var_12("guild_word_effect_addition") .. var_30_12

			local var_30_18 = arg_30_0
			local var_30_19 = arg_30_0.GetBattleTarget(var_30_18, var_30_14, var_30_15)
			local var_30_20 = arg_30_0.target1Text

			table = var_30_18
			var_30_20.text = var_30_18.concat(var_30_19, " 、")

			local var_30_21 = arg_30_0.target1Text4Effect

			var_30_21.text = arg_30_0.target1Text.text
			setButtonEnabled = var_30_21

			var_30_21(arg_30_0.goBtn, #var_30_2 > 0)

			local var_30_22 = var_30_0
			local var_30_23 = var_30_0.GetFleetCnt(var_30_22)
			local var_30_24 = not var_30_0:CanFormation() or arg_30_1 <= var_30_23

			setActive = var_30_22

			var_30_22(arg_30_0.inProgressBtn, var_30_24)

			setActive = var_30_22

			var_30_22(arg_30_0.goBtn, not var_30_24)

			arg_30_0.contextData.index = arg_30_1

			if arg_30_0.target2Text.text ~= "" and arg_30_0.target1Text.text ~= "" then
				setText = var_14

				local var_30_25 = arg_30_0._tf
				local var_30_26 = var_16.Find(var_30_25, "frame/bottom/desc/target/content/title")

				i18n = var_17

				var_14(var_30_26, var_17("guild_wrod_battle_target"))
			else
				setText = var_14

				local var_30_27 = arg_30_0._tf

				var_14(var_16.Find(var_30_27, "frame/bottom/desc/target/content/title"), "")
			end

			return
		end
	end
end

function var_0_1.UpdateShipSlot(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = arg_33_0.mission
	local var_33_1 = arg_33_3[arg_33_1]
	local var_33_2 = arg_33_2:Find("Image")
	local var_33_3 = arg_33_2
	local var_33_4 = arg_33_2.Find(var_33_3, "effect")
	local var_33_5 = arg_33_2:Find("score")

	if var_33_1 then
		getProxy = var_33_3
		BayProxy = var_12

		local var_33_6 = var_33_3(var_12)

		if var_33_3.getShipById(var_33_6, var_33_1) then
			local var_33_7 = var_33_3:getPrefab()

			SpineAnimChar = var_33_6
			arg_33_0.spineChar = var_33_6.New()

			local var_33_8 = arg_33_0.spineChar

			var_12.SetPaint(var_33_8, var_33_7)

			local var_33_9 = arg_33_0.spineChar

			var_12.Load(var_33_9, true, function(arg_34_0)
				arg_34_0:SetName(var_33_7)

				local var_34_0 = arg_34_0
				local var_34_1 = arg_34_0.SetPivot

				Vector2 = var_4

				var_34_1(var_34_0, var_4(0.5, 0))

				local var_34_2 = arg_34_0
				local var_34_3 = arg_34_0.SetSizeDelta

				Vector2 = var_4

				var_34_3(var_34_2, var_4(200, 300))
				arg_34_0:SetParent(arg_33_2)

				local var_34_4 = arg_34_0
				local var_34_5 = arg_34_0.SetLocalPosition

				Vector3 = var_4

				var_34_5(var_34_4, var_4(0, 0, 0))

				local var_34_6 = arg_34_0
				local var_34_7 = arg_34_0.SetLocalScale

				Vector3 = var_4

				var_34_7(var_34_6, var_4(0.6, 0.6, 0.6))
				arg_34_0:SetAction("stand")

				GetOrAddComponent = var_1

				local var_34_8 = var_1(arg_34_0:GetModel(), "EventTriggerListener")

				var_1.AddPointClickFunc(var_34_8, function(arg_35_0, arg_35_1)
					local var_35_0 = arg_33_0
					local var_35_1 = var_2.emit

					GuildEventMediator = var_3_10005

					var_35_1(var_35_0, var_3_10005.ON_SELECT_MISSION_SHIP, var_33_0.id, arg_33_1, arg_33_3)

					return
				end)

				arg_33_0.shipGos[var_33_1] = arg_34_0

				if arg_33_4 then
					arg_33_4()
				end

				return
			end)

			setActive = var_12

			var_12(var_33_4, arg_33_0:HasEffectAddition(var_33_3))

			setActive = var_12

			var_12(var_33_5, arg_33_0:HasScoreAddition(var_33_3))
		elseif arg_33_4 then
			arg_33_4()
		end
	else
		onButton = var_33_3

		local var_33_10 = arg_33_0
		local var_33_11 = var_33_2

		local function var_33_12()
			local var_36_0 = arg_33_0
			local var_36_1 = var_0.emit

			GuildEventMediator = var_2_10003

			var_36_1(var_36_0, var_2_10003.ON_SELECT_MISSION_SHIP, var_33_0.id, arg_33_1, arg_33_3)

			return
		end

		SFX_PANEL = var_1_10015

		var_33_3(var_33_10, var_33_11, var_33_12, var_1_10015)

		setActive = var_33_3

		var_33_3(var_33_4, false)

		setActive = var_33_3

		var_33_3(var_33_5, false)

		if arg_33_4 then
			arg_33_4()
		end
	end

	setActive = var_33_3

	var_33_3(var_33_2, not var_33_1)

	return
end

function var_0_1.CheckFormation(arg_37_0)
	local var_37_0 = arg_37_0.mission

	if arg_37_0.contextData.index ~= arg_37_0.canFormationIndex then
		pg = var_2

		local var_37_1 = var_2.TipsMgr.GetInstance()
		local var_37_2 = var_2.ShowTips

		i18n = var_1_10005

		var_37_2(var_37_1, var_1_10005("guild_curr_fleet_can_not_edit"))

		return false
	end

	local var_37_3 = arg_37_0.mission
	local var_37_4, var_37_5 = var_2.CanFormation(var_37_3)

	if not var_37_4 then
		if var_37_5 then
			pg = var_37_3

			local var_37_6 = var_37_3.TipsMgr.GetInstance()
			local var_37_7 = var_4.ShowTips

			i18n = var_1_10007

			var_37_7(var_37_6, var_1_10007("guild_next_edit_fleet_time", var_37_5))
		end

		return false
	end

	return true
end

function var_0_1.emit(arg_38_0, ...)
	if arg_38_0.loading then
		return
	end

	if not arg_38_0:CheckFormation() then
		return
	end

	var_0_1.super.emit(arg_38_0, ...)

	return
end

function var_0_1.send(arg_39_0, ...)
	var_0_1.super.emit(arg_39_0, ...)

	return
end

function var_0_1.GetBattleTarget(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0.mission
	local var_40_1 = var_3.GetAttrCntAcc(var_40_0)
	local var_40_2 = var_3
	local var_40_3 = var_3.GetAttrAcc(var_40_2)
	local var_40_4 = {}

	pairs = var_40_2

	for iter_40_0, iter_40_1 in var_40_2(var_40_1) do
		local var_40_5

		if not arg_40_1[iter_40_0] then
			var_40_5 = 0
		end

		table = var_1_10013
		var_1_10013 = var_1_10013.insert

		local var_40_6 = var_40_4

		GuildMissionInfoPage = var_1_10016

		var_1_10013(var_40_6, var_1_10016.AttrCnt2Desc(iter_40_0, {
			value = iter_40_1.value + var_40_5,
			total = iter_40_1.total,
			goal = iter_40_1.goal,
			score = iter_40_1.score
		}))
	end

	pairs = var_7

	for iter_40_2, iter_40_3 in var_7(var_40_3) do
		local var_40_7

		if not arg_40_2[iter_40_2] then
			var_40_7 = 0
		end

		table = var_1_10013
		var_1_10013 = var_1_10013.insert

		local var_40_8 = var_40_4

		GuildMissionInfoPage = var_1_10016

		var_1_10013(var_40_8, var_1_10016.AttrAcc2Desc(iter_40_2, {
			value = iter_40_3.value + var_40_7,
			op = iter_40_3.op,
			goal = iter_40_3.goal,
			score = iter_40_3.score
		}))
	end

	return var_40_4
end

function var_0_1.GetTagShipCnt(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0.mission
	local var_41_1 = var_2.GetSquadron(var_41_0)
	local var_41_2 = 0

	getProxy = var_41_0
	BayProxy = var_1_10007

	local var_41_3 = var_41_0(var_1_10007)

	ipairs = var_1_10006

	for iter_41_0, iter_41_1 in var_1_10006(arg_41_1) do
		if var_41_3:getShipById(iter_41_1) and var_11:IsTagShip(var_41_1) then
			var_41_2 = var_41_2 + 1
		end
	end

	return var_41_2
end

function var_0_1.CalcScoreAddition(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0.mission
	local var_42_1 = var_2.GetAttrCntAcc(var_42_0)
	local var_42_2 = var_2:GetAttrAcc()

	pg = var_42_0

	local var_42_3 = var_42_0.attribute_info_by_type
	local var_42_4 = 0
	local var_42_5 = {}
	local var_42_6 = {}

	getProxy = var_1_10009
	BayProxy = var_1_10011

	local var_42_7 = var_1_10009(var_1_10011)

	ipairs = var_1_10010

	for iter_42_0, iter_42_1 in var_1_10010(arg_42_1) do
		local var_42_8 = var_42_7
		local var_42_9 = var_42_7.getShipById(var_42_8, iter_42_1)
		local var_42_10

		if var_42_9 then
			_ = var_42_8
			var_42_10 = var_42_8.detect(var_2:getConfig("ship_camp_effect"), function(arg_43_0)
				local var_43_0 = arg_43_0[1]
				local var_43_1 = var_42_9

				return var_43_0 == var_2.getNation(var_43_1)
			end)
		end

		if var_42_10 then
			var_42_4 = var_42_4 + var_42_10[2]
		end

		local var_42_11

		if not var_42_9 or not var_42_9:getProperties() then
			var_42_11 = {}
		end

		pairs = var_18

		for iter_42_2, iter_42_3 in var_18(var_42_1) do
			local var_42_12

			if not var_42_11[var_42_3[iter_42_2].name] then
				var_42_12 = 0
			end

			if var_42_12 >= iter_42_3.total then
				local var_42_13

				if not var_42_5[iter_42_2] then
					var_42_13 = 0
				end

				var_42_5[iter_42_2] = var_42_13 + 1
			end
		end

		pairs = var_18

		for iter_42_4, iter_42_5 in var_18(var_42_2) do
			local var_42_14 = var_42_3[iter_42_4].name
			local var_42_15

			if not var_42_6[iter_42_4] then
				var_42_15 = 0
			end

			local var_42_16

			if not var_42_11[var_42_14] then
				var_42_16 = 0
			end

			var_42_6[iter_42_4] = var_42_15 + var_42_16
		end
	end

	pairs = var_10

	for iter_42_6, iter_42_7 in var_10(var_42_1) do
		local var_42_17

		if not var_42_5[iter_42_6] then
			var_42_17 = 0
		end

		if var_42_17 + iter_42_7.value >= iter_42_7.goal then
			var_42_4 = var_42_4 + iter_42_7.score
		end
	end

	pairs = var_10

	for iter_42_8, iter_42_9 in var_10(var_42_2) do
		local var_42_18 = iter_42_9.value
		local var_42_19

		if not var_42_6[iter_42_8] then
			var_42_19 = 0
		end

		local var_42_20 = var_42_18 + var_42_19
		local var_42_21

		if iter_42_9.op == 1 then
			var_42_21 = var_42_20 >= iter_42_9.goal
		elseif iter_42_9.op == 2 then
			var_42_21 = var_42_20 <= iter_42_9.goal
		end

		if var_42_21 then
			var_42_4 = var_42_4 + iter_42_9.score
		end
	end

	return var_42_4, var_42_5, var_42_6
end

function var_0_1.CalcEffectAddition(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0.mission

	GuildMission = var_1_10003

	local var_44_1 = var_1_10003.CalcMyEffect(arg_44_1)

	getProxy = var_1_10004
	BayProxy = var_1_10006

	local var_44_2 = var_1_10004(var_1_10006)

	ipairs = var_5

	for iter_44_0, iter_44_1 in var_5(arg_44_1) do
		local var_44_3 = var_44_2
		local var_44_4 = var_44_2.getShipById(var_44_3, iter_44_1)
		local var_44_5

		if var_44_4 then
			_ = var_44_3
			var_44_5 = var_44_3.detect(var_44_0:getConfig("ship_type_effect"), function(arg_45_0)
				local var_45_0 = arg_45_0[1]
				local var_45_1 = var_44_4

				return var_45_0 == var_2.getShipType(var_45_1)
			end)
		end

		if var_44_5 then
			var_44_1 = var_44_1 + var_44_5[2]
		end
	end

	local var_44_6 = arg_44_0:GetTagShipCnt(arg_44_1)
	local var_44_7 = var_44_0:GetSquadronTargetCnt()
	local var_44_8 = 1

	if var_44_7 <= var_44_6 and var_44_0:IsEliteType() then
		var_44_8 = var_44_0:GetSquadronRatio()
	end

	return var_44_1 * var_44_8
end

function var_0_1.HasScoreAddition(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0.mission
	local var_46_1 = var_2.GetRecommendShipNation(var_46_0)
	local var_46_2 = var_2:GetAttrCntAcc()
	local var_46_3 = var_2
	local var_46_4 = var_2.GetAttrAcc(var_46_3)

	local function var_46_5()
		local var_47_0 = arg_46_1
		local var_47_1 = var_0.getProperties(var_47_0)

		pg = var_2_10001

		local var_47_2 = var_2_10001.attribute_info_by_type

		pairs = var_47_0

		for iter_47_0, iter_47_1 in var_47_0(var_46_2) do
			local var_47_3 = var_47_2[iter_47_0].name

			assert = var_2_10008

			var_2_10008(var_47_1[var_47_3], var_47_3)

			if not var_47_1[var_47_3] then
				var_2_10008 = 0
			end

			if var_2_10008 >= iter_47_1.total then
				return true
			end
		end

		pairs = var_2

		for iter_47_2, iter_47_3 in var_2(var_46_4) do
			local var_47_4 = var_47_2[iter_47_2].name

			assert = var_2_10008

			var_2_10008(var_47_1[var_47_4], var_47_4)

			if iter_47_3.op == 1 then
				if not var_47_1[var_47_4] then
					var_2_10008 = 0
				end

				var_2_10008 = var_2_10008 > 0

				return var_2_10008
			elseif iter_47_3.op == 2 then
				if not var_47_1[var_47_4] then
					var_2_10008 = 0
				end

				var_2_10008 = var_2_10008 == 0

				return var_2_10008
			end
		end

		return false
	end

	table = var_46_3

	local var_46_6

	if not var_46_3.contains(var_46_1, arg_46_1:getNation()) then
		var_46_6 = var_46_5()
	end

	return var_46_6
end

function var_0_1.HasEffectAddition(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0.mission
	local var_48_1 = var_2.GetRecommendShipTypes(var_48_0)
	local var_48_2 = var_2:GetSquadron()

	table = var_48_0

	local var_48_3

	if not var_48_0.contains(var_48_1, arg_48_1:getShipType()) then
		var_48_3 = arg_48_1:IsTagShip(var_48_2)
	end

	return var_48_3
end

function var_0_1.ClearSlots(arg_49_0)
	pairs = var_1_10001

	for iter_49_0, iter_49_1 in var_1_10001(arg_49_0.shipGos) do
		local var_49_0 = iter_49_1
		local var_49_1 = iter_49_1.SetPivot

		Vector2 = var_1_10009

		var_49_1(var_49_0, var_1_10009(0.5, 0.5))

		GetOrAddComponent = var_49_1
		var_1_10009 = var_49_1(iter_49_1:GetModel(), "EventTriggerListener")

		var_6.RemovePointClickFunc(var_1_10009)

		var_1_10009 = iter_49_1

		iter_49_1.SetActionCallBack(var_1_10009, nil)

		var_1_10009 = iter_49_1

		iter_49_1.Dispose(var_1_10009)
	end

	arg_49_0.shipGos = {}

	return
end

function var_0_1.Hide(arg_50_0)
	var_0_1.super.Hide(arg_50_0)
	arg_50_0:ClearSlots()

	if arg_50_0.timer then
		local var_50_0 = arg_50_0.timer

		var_1.Stop(var_50_0)

		arg_50_0.timer = nil
	end

	return
end

return var_0_1
