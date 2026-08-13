class = var_0_10000

local var_0_0 = "GuildMissionInfoPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuildEventBasePage"))
local var_0_2 = 10001

function var_0_1.AttrCnt2Desc(arg_1_0, arg_1_1)
	pg = var_1_10002

	local var_1_0 = var_1_10002.attribute_info_by_type[arg_1_0]
	local var_1_1 = arg_1_1.value

	if arg_1_1.goal <= var_1_1 then
		COLOR_GREEN = var_1_1

		if not var_1_1 then
			COLOR_RED = var_1_1
		end

		i18n = var_4

		return var_4("guild_event_info_desc1", var_1_0.condition, arg_1_1.total, var_1_1, arg_1_1.value, arg_1_1.goal)
	end
end

function var_0_1.AttrAcc2Desc(arg_2_0, arg_2_1)
	pg = var_1_10002

	local var_2_0 = var_1_10002.attribute_info_by_type[arg_2_0]

	assert = var_1_10003

	var_1_10003(var_2_0, arg_2_0)

	local var_2_1

	if arg_2_1.op == 1 then
		if arg_2_1.value >= arg_2_1.goal then
			COLOR_GREEN = var_4

			if not var_4 then
				::label_2_0::

				COLOR_RED = var_2_1
			end

			goto label_2_2

			if arg_2_1.op == 2 then
				if arg_2_1.value <= arg_2_1.goal then
					COLOR_GREEN = var_4

					if not var_4 then
						::label_2_1::

						COLOR_RED = var_2_1
					end

					::label_2_2::

					assert = var_4

					var_4(var_2_1)

					i18n = var_4

					return var_4("guild_event_info_desc2", var_2_0.condition, var_2_1, arg_2_1.value, arg_2_1.goal)
				end
			end
		end
	end
end

function var_0_1.getUIName(arg_3_0)
	return "GuildMissionInfoPage"
end

function var_0_1.OnLoaded(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.closeBtn = var_1.Find(var_4_0, "top/close")

	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_1.Find(var_4_1, "bg/sea")
	local var_4_3 = var_1.GetComponent

	typeof = var_4
	RawImage = var_1_10006
	arg_4_0.sea = var_4_3(var_4_2, var_4(var_1_10006))

	local var_4_4 = arg_4_0._tf
	local var_4_5 = var_1.Find(var_4_4, "top/title/Text")
	local var_4_6 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_4_0.titleTxt = var_4_6(var_4_5, var_4(var_1_10006))

	local var_4_7 = arg_4_0._tf

	arg_4_0.logBtn = var_1.Find(var_4_7, "bottom/log_btn")

	local var_4_8 = arg_4_0._tf

	arg_4_0.formationBtn = var_1.Find(var_4_8, "bottom/formationBtn")

	local var_4_9 = arg_4_0._tf

	arg_4_0.doingBtn = var_1.Find(var_4_9, "bottom/doing_btn")

	local var_4_10 = arg_4_0._tf

	arg_4_0.helpBtn = var_1.Find(var_4_10, "bottom/help")

	local var_4_11 = arg_4_0._tf

	arg_4_0.logPanel = var_1.Find(var_4_11, "log_panel")
	UIItemList = var_1

	local var_4_12 = var_1.New
	local var_4_13 = arg_4_0.logPanel
	local var_4_14 = var_3.Find(var_4_13, "scrollrect/content")
	local var_4_15 = arg_4_0.logPanel

	arg_4_0.logList = var_4_12(var_4_14, var_4.Find(var_4_15, "scrollrect/content/tpl"))

	local var_4_16 = arg_4_0._tf
	local var_4_17 = var_1.Find(var_4_16, "bottom/cnt/Text")
	local var_4_18 = var_1.GetComponent

	typeof = var_4
	Text = var_4_15
	arg_4_0.peopleCnt = var_4_18(var_4_17, var_4(var_4_15))

	local var_4_19 = arg_4_0._tf
	local var_4_20 = var_1.Find(var_4_19, "bottom/effect/Text")
	local var_4_21 = var_1.GetComponent

	typeof = var_4
	Text = var_4_15
	arg_4_0.effectCnt = var_4_21(var_4_20, var_4(var_4_15))
	setText = var_1

	local var_4_22 = arg_4_0._tf
	local var_4_23 = var_3.Find(var_4_22, "bottom/cnt")

	i18n = var_4

	var_1(var_4_23, var_4("guild_join_member_cnt"))

	setText = var_1

	local var_4_24 = arg_4_0._tf
	local var_4_25 = var_3.Find(var_4_24, "bottom/effect")

	i18n = var_4

	var_1(var_4_25, var_4("guild_total_effect"))

	local var_4_26 = arg_4_0._tf
	local var_4_27 = var_1.Find(var_4_26, "top/title/Text/target/area")
	local var_4_28 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_4_0.areaTxt = var_4_28(var_4_27, var_4(var_6))

	local var_4_29 = arg_4_0._tf
	local var_4_30 = var_1.Find(var_4_29, "top/title/Text/target/goal")
	local var_4_31 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_4_0.goalTxt = var_4_31(var_4_30, var_4(var_6))

	local var_4_32 = arg_4_0._tf
	local var_4_33 = var_1.Find(var_4_32, "bottom/progress/time/Text")
	local var_4_34 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_4_0.timeTxt = var_4_34(var_4_33, var_4(var_6))
	UIItemList = var_1

	local var_4_35 = var_1.New
	local var_4_36 = arg_4_0._tf
	local var_4_37 = var_3.Find(var_4_36, "bottom/progress/nodes")
	local var_4_38 = arg_4_0._tf

	arg_4_0.nodesUIlist = var_4_35(var_4_37, var_4.Find(var_4_38, "bottom/progress/nodes/tpl"))

	local var_4_39 = arg_4_0._tf

	arg_4_0.progress = var_1.Find(var_4_39, "bottom/progress")
	arg_4_0.nodeLength = arg_4_0.progress.rect.width

	local var_4_40 = arg_4_0._tf

	arg_4_0.healTF = var_1.Find(var_4_40, "resources/heal")

	local var_4_41 = arg_4_0._tf

	arg_4_0.nameTF = var_1.Find(var_4_41, "resources/name")

	return
end

function var_0_1.OnInit(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.closeBtn

	local function var_5_2()
		arg_5_0.contextData.mission = nil

		local var_6_0 = arg_5_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.helpBtn

	local function var_5_5()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_7_2.type = var_2_10004
		pg = var_2_10004
		var_7_2.helps = var_2_10004.gametip.guild_mission_info_tip.tip

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10006)

	onButton = var_1_10001

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.logBtn

	local function var_5_8()
		if arg_5_0.isShowLogPanel then
			local var_8_0 = arg_5_0

			var_0.ShowOrHideLogPanel(var_8_0, false)
		else
			local var_8_1 = arg_5_0

			var_0.ShowOrHideLogPanel(var_8_1, true)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_6, var_5_7, var_5_8, var_1_10006)

	onButton = var_1_10001

	local var_5_9 = arg_5_0
	local var_5_10 = arg_5_0.logPanel

	local function var_5_11()
		local var_9_0 = arg_5_0

		var_0.ShowOrHideLogPanel(var_9_0, false)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_9, var_5_10, var_5_11, var_1_10006)

	onButton = var_1_10001

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.formationBtn

	local function var_5_14()
		local var_10_0 = arg_5_0.mission

		if var_0.IsFinish(var_10_0) then
			pg = var_1

			local var_10_1 = var_1.TipsMgr.GetInstance()
			local var_10_2 = var_1.ShowTips

			i18n = var_2_10004

			var_10_2(var_10_1, var_2_10004("guild_event_is_finish"))

			return
		end

		local var_10_3 = arg_5_0
		local var_10_4 = var_1.emit

		GuildEventLayer = var_2_10004

		var_10_4(var_10_3, var_2_10004.OPEN_MISSION_FORAMTION, arg_5_0.mission)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_12, var_5_13, var_5_14, var_1_10006)

	onButton = var_1_10001

	local var_5_15 = arg_5_0
	local var_5_16 = arg_5_0.doingBtn

	local function var_5_17()
		triggerButton = var_2_10000

		var_2_10000(arg_5_0.formationBtn)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_15, var_5_16, var_5_17, var_1_10006)

	return
end

function var_0_1.OnRefreshMission(arg_12_0, arg_12_1)
	arg_12_0:Flush(arg_12_1)

	return
end

function var_0_1.OnShow(arg_13_0)
	local var_13_0 = arg_13_0.extraData.mission

	arg_13_0:Flush(var_13_0)
	arg_13_0:EnterFormation()
	arg_13_0:AddOtherShipMoveTimer()

	return
end

function var_0_1.Flush(arg_14_0, arg_14_1)
	arg_14_0.mission = arg_14_1

	arg_14_0:InitBattleSea()
	arg_14_0:InitView()
	arg_14_0:AddRefreshProgressTimer()

	return
end

function var_0_1.EnterFormation(arg_15_0)
	if arg_15_0.contextData.missionShips then
		triggerButton = var_1

		var_1(arg_15_0.formationBtn)
	end

	return
end

function var_0_1.InitView(arg_16_0)
	local var_16_0 = arg_16_0.mission
	local var_16_1 = arg_16_0.guild

	arg_16_0.titleTxt.text = var_16_0:GetName()

	local var_16_2 = arg_16_0.peopleCnt
	local var_16_3 = var_16_0:GetJoinMemberCnt()
	local var_16_4 = "/"
	local var_16_5 = var_16_1.memberCount

	i18n = var_1_10007
	var_16_2.text = var_16_3 .. var_16_4 .. var_16_5 .. var_1_10007("guild_word_people")
	arg_16_0.effectCnt.text = var_16_0:GetEfficiency() .. "(" .. var_16_0:GetMyEffect() .. ")"

	local var_16_6 = var_16_0:GetNations()

	_ = var_4

	local var_16_7 = var_4.map(var_16_6, function(arg_17_0)
		local var_17_0 = var_16_0
		local var_17_1 = var_1.GetShipsByNation(var_17_0, arg_17_0)

		Nation = var_2_10002

		local var_17_2 = var_2_10002.Nation2Name(arg_17_0)

		i18n = var_17_0

		return var_17_0("guild_event_info_desc3", var_17_2, #var_17_1)
	end)
	local var_16_8 = arg_16_0.areaTxt

	i18n = var_6

	local var_16_9 = var_6("guild_word_battle_area")

	table = var_7
	var_16_8.text = var_16_9 .. var_7.concat(var_16_7, " 、")

	local var_16_10 = var_0_1.GetBattleTarget(var_16_0)

	table = var_6

	local var_16_11

	if var_6.concat(var_16_10, " 、") ~= "" then
		var_16_11 = arg_16_0.goalTxt
		i18n = var_8
		var_16_11.text = var_8("guild_wrod_battle_target") .. var_6
	end

	setActive = var_16_11

	var_16_11(arg_16_0.goalTxt.gameObject, var_6 ~= "")
	arg_16_0:UpdateNodes()
	arg_16_0:UpdateFormationBtn()

	return
end

function var_0_1.UpdateFormationBtn(arg_18_0)
	local var_18_0 = arg_18_0.mission
	local var_18_1 = var_1.CanFormation(var_18_0)

	setActive = var_1_10003

	var_1_10003(arg_18_0.formationBtn, var_18_1)

	setActive = var_1_10003

	var_1_10003(arg_18_0.doingBtn, not var_18_1)

	return
end

function var_0_1.GetBattleTarget(arg_19_0)
	local var_19_0 = arg_19_0:GetAttrCntAcc()
	local var_19_1 = arg_19_0
	local var_19_2 = arg_19_0.GetAttrAcc(var_19_1)
	local var_19_3 = {}

	pairs = var_19_1

	for iter_19_0, iter_19_1 in var_19_1(var_19_0) do
		table = var_1_10009

		var_1_10009.insert(var_19_3, var_0_1.AttrCnt2Desc(iter_19_0, iter_19_1))
	end

	pairs = var_4

	for iter_19_2, iter_19_3 in var_4(var_19_2) do
		table = var_1_10009

		var_1_10009.insert(var_19_3, var_0_1.AttrAcc2Desc(iter_19_2, iter_19_3))
	end

	return var_19_3
end

function var_0_1.UpdateNodes(arg_20_0)
	arg_20_0.nodes = {}

	local var_20_0 = arg_20_0.mission
	local var_20_1 = var_1.GetNodes(var_20_0)
	local var_20_2 = 1

	if not var_1:IsFinish() then
		local var_20_3 = arg_20_0.nodesUIlist

		var_4.make(var_20_3, function(arg_21_0, arg_21_1, arg_21_2)
			UIItemList = var_2_10003

			if arg_21_0 == var_2_10003.EventUpdate then
				local var_21_0 = var_20_1[arg_21_1 + 1]
				local var_21_1 = var_3.GetPosition(var_21_0)
				local var_21_2 = arg_20_0.nodeLength * (var_21_1 / 100)
				local var_21_3 = arg_21_2
				local var_21_4 = arg_21_2.GetComponent

				typeof = var_2_10009
				Image = var_2_10011

				local var_21_5 = var_21_4(var_21_3, var_2_10009(var_2_10011))

				GetSpriteFromAtlas = var_2_10007
				var_21_5.sprite = var_2_10007("ui/GuildMissionInfoUI_atlas", var_21_1)
				setAnchoredPosition = var_21_5

				var_21_5(arg_21_2, {
					x = var_21_2
				})

				local var_21_6 = var_3
				local var_21_7 = var_3.GetIcon(var_21_6)
				local var_21_8 = arg_21_2:Find("item")
				local var_21_9 = var_7.GetComponent

				typeof = var_10
				Image = var_2_10012

				local var_21_10 = var_21_9(var_21_8, var_10(var_2_10012))

				LoadSprite = var_21_6
				var_21_10.sprite = var_21_6("GuildNode/" .. var_21_7)
				table = var_21_10

				var_21_10.insert(arg_20_0.nodes, arg_21_2)
			end

			return
		end)

		local var_20_4 = arg_20_0.nodesUIlist

		var_4.align(var_20_4, #var_20_1)

		var_20_2 = var_1:GetProgress()
	end

	setSlider = var_4

	var_4(arg_20_0.progress, 0, 100, var_20_2 * 100)

	return
end

function var_0_1.InitBattleSea(arg_22_0)
	if arg_22_0.loading then
		return
	end

	arg_22_0.loading = true

	local var_22_0 = {}

	if not arg_22_0.battleView then
		GuildMissionBattleView = var_2
		arg_22_0.battleView = var_2.New(arg_22_0.sea)

		local var_22_1 = arg_22_0.battleView

		var_2.configUI(var_22_1, arg_22_0.healTF, arg_22_0.nameTF)

		table = var_2

		var_2.insert(var_22_0, function(arg_23_0)
			local var_23_0 = arg_22_0.battleView

			var_1.load(var_23_0, var_0_2, arg_23_0)

			return
		end)
	end

	local var_22_2 = arg_22_0.mission
	local var_22_3 = var_2.GetMyFlagShip(var_22_2)
	local var_22_4
	local var_22_5 = {}
	local var_22_6 = ""

	if var_22_3 then
		getProxy = var_1_10007
		BayProxy = var_1_10009

		local var_22_7 = var_1_10007(var_1_10009)

		if not var_1_10007.getShipById(var_22_7, var_22_3) then
			::label_22_0::

			Ship = var_1_10007
			var_22_4 = var_1_10007.New({
				id = 9999,
				configId = 101171
			})
		end

		math = var_1_10007
		var_1_10007 = var_1_10007.floor(var_22_4.configId / 10)

		for iter_22_0 = 1, 4 do
			pg = var_1_10012
			var_1_10012 = var_1_10012.ship_data_breakout
			tonumber = var_1_10013

			if not var_1_10012[var_1_10013(var_1_10007 .. iter_22_0)] or not var_1_10012.weapon_ids then
				var_1_10013 = {}
			end

			ipairs = var_1_10014

			for iter_22_1, iter_22_2 in var_1_10014(var_1_10013) do
				table = var_1_10019

				if not var_1_10019.contains(var_22_5, iter_22_2) then
					table = var_1_10019

					var_1_10019.insert(var_22_5, iter_22_2)
				end
			end
		end

		getProxy = var_8
		PlayerProxy = var_10

		local var_22_8 = var_8(var_10)

		var_22_6 = var_8.getRawData(var_22_8).name
	end

	table = var_1_10007

	var_1_10007.insert(var_22_0, function(arg_24_0)
		local var_24_0 = arg_22_0.battleView

		var_1.LoadShip(var_24_0, var_22_4, var_22_5, var_22_6, function()
			if var_22_4 then
				local var_25_0 = arg_22_0

				var_0.CheckNodesState(var_25_0)
			end

			arg_24_0()

			return
		end)

		return
	end)

	seriesAsync = var_7

	var_7(var_22_0, function()
		arg_22_0.loading = false

		return
	end)

	return
end

function var_0_1.AddOtherShipMoveTimer(arg_27_0)
	local function var_27_0(arg_28_0)
		local var_28_0 = {}
		local var_28_1 = arg_27_0.mission

		if #var_2.GetOtherShips(var_28_1) == 0 then
			return var_28_0
		end

		if #var_3 <= arg_28_0 then
			return var_3
		end

		shuffle = var_4

		var_4(var_3)

		for iter_28_0 = 1, arg_28_0 do
			table = var_2_10008

			var_2_10008.insert(var_28_0, var_3[iter_28_0])
		end

		return var_28_0
	end

	local var_27_1

	;(function()
		local var_29_1

		if arg_27_0.timer then
			local var_29_0 = arg_27_0.timer

			var_29_1.Stop(var_29_0)

			var_29_1 = arg_27_0
			var_29_1.timer = nil
		end

		math = var_29_1

		local var_29_2 = var_29_1.random(30, 150)
		local var_29_3 = arg_27_0

		Timer = var_2
		var_29_3.timer = var_2.New(function()
			math = var_3_10000

			local var_30_0 = var_3_10000.random(1, 2)
			local var_30_1 = var_27_0(var_30_0)
			local var_30_2 = arg_27_0.battleView

			var_2.PlayOtherShipAnim(var_30_2, var_30_1, var_0)

			return
		end, var_29_2, 1)

		local var_29_4 = arg_27_0.timer

		var_1.Start(var_29_4)

		return
	end)()

	return
end

function var_0_1.CheckNodesState(arg_31_0)
	local function var_31_0(arg_32_0)
		if arg_32_0:IsItemType() then
			local var_32_0 = arg_31_0.battleView

			var_1.PlayItemAnim(var_32_0)
		elseif arg_32_0:IsBattleType() then
			local var_32_1 = arg_31_0.battleView

			var_1.PlayAttackAnim(var_32_1)
		end

		return
	end

	local var_31_1 = arg_31_0.mission

	if var_2.GetNewestSuccessNode(var_31_1) and var_2:GetNodeAnimPosistion() < var_3:GetPosition() then
		var_31_0(var_3)

		local var_31_2 = arg_31_0
		local var_31_3 = arg_31_0.emit

		GuildEventMediator = var_1_10009

		var_31_3(var_31_2, var_1_10009.ON_UPDATE_NODE_ANIM_FLAG, var_2.id, var_5)
	end

	return
end

function var_0_1.AddRefreshProgressTimer(arg_33_0)
	arg_33_0:RemoveCdTimer()
	arg_33_0:RemoveRefreshTimer()

	local var_33_0 = arg_33_0.mission
	local var_33_1 = var_1.GetTotalTimeCost(var_33_0)
	local var_33_2 = var_1

	if not var_1.IsFinish(var_33_2) and var_33_1 > 0 then
		assert = var_33_0

		var_33_0(var_33_1 > 900, var_33_1)

		var_33_0 = var_33_1 * 0.01
		Timer = var_33_2
		arg_33_0.refreshTimer = var_33_2.New(function()
			local var_34_0 = arg_33_0

			var_0.RemoveRefreshTimer(var_34_0)

			local var_34_1 = arg_33_0
			local var_34_2 = var_0.emit

			GuildEventMediator = var_2_10003

			var_34_2(var_34_1, var_2_10003.FORCE_REFRESH_MISSION, var_0.id)

			return
		end, var_33_0, 1)

		local var_33_3 = arg_33_0.refreshTimer

		var_5.Start(var_33_3)

		local var_33_4 = var_1:GetRemainingTime()

		if 0 < var_33_4 then
			Timer = var_6
			arg_33_0.cdTimer = var_6.New(function()
				var_33_4 = var_33_4 - 1

				if var_33_4 <= 0 then
					local var_35_0 = arg_33_0

					var_0.RemoveCdTimer(var_35_0)

					setActive = var_0

					var_0(arg_33_0.timeTxt.gameObject.transform.parent, false)
				else
					local var_35_1 = arg_33_0.timeTxt

					pg = var_1

					local var_35_2 = var_1.TimeMgr.GetInstance()

					var_35_1.text = var_1.DescCDTime(var_35_2, var_33_4)
				end

				return
			end, 1, -1)

			local var_33_5 = arg_33_0.cdTimer

			var_6.Start(var_33_5)
			arg_33_0.cdTimer.func()
		else
			setActive = var_6

			var_6(arg_33_0.timeTxt.gameObject.transform.parent, false)
		end
	end

	setActive = var_33_0

	var_33_0(arg_33_0.timeTxt.gameObject.transform.parent, var_3)

	return
end

function var_0_1.RemoveCdTimer(arg_36_0)
	if arg_36_0.cdTimer then
		local var_36_0 = arg_36_0.cdTimer

		var_1.Stop(var_36_0)

		arg_36_0.cdTimer = nil
	end

	return
end

function var_0_1.ShowOrHideLogPanel(arg_37_0, arg_37_1, arg_37_2)
	arg_37_2 = arg_37_2 or 0.3
	LeanTween = var_1_10003

	if var_1_10003.isTweening(arg_37_0.logPanel) then
		return
	end

	local var_37_0 = arg_37_0.logPanel.rect.width + 300
	local var_37_1 = arg_37_1 and var_37_0 or 0
	local var_37_2 = arg_37_1 and 0 or var_37_0

	LeanTween = var_1_10006

	local var_37_3 = var_1_10006.value(arg_37_0.logPanel.gameObject, var_37_1, var_37_2, arg_37_2)
	local var_37_4 = var_6.setOnUpdate

	System = var_9

	local var_37_5 = var_37_4(var_37_3, var_9.Action_float(function(arg_38_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_37_0.logPanel, {
			x = arg_38_0
		})

		return
	end))
	local var_37_6 = var_6.setOnComplete

	System = var_9

	var_37_6(var_37_5, var_9.Action(function()
		if not arg_37_1 then
			setActive = var_0

			var_0(arg_37_0.logPanel, false)
		end

		return
	end))

	arg_37_0.isShowLogPanel = arg_37_1

	if arg_37_1 then
		setActive = var_37_6

		var_37_6(arg_37_0.logPanel, true)
		arg_37_0:InitLogs()
	end

	return
end

function var_0_1.InitLogs(arg_40_0)
	local var_40_0 = arg_40_0.mission
	local var_40_1 = var_1.GetLogs(var_40_0)
	local var_40_2 = arg_40_0.logList

	var_3.make(var_40_2, function(arg_41_0, arg_41_1, arg_41_2)
		UIItemList = var_2_10003

		if arg_41_0 == var_2_10003.EventUpdate then
			setText = var_3

			var_3(arg_41_2, var_40_1[arg_41_1 + 1])
		end

		return
	end)

	local var_40_3 = arg_40_0.logList

	var_3.align(var_40_3, #var_40_1)

	return
end

function var_0_1.RemoveRefreshTimer(arg_42_0)
	if arg_42_0.refreshTimer then
		local var_42_0 = arg_42_0.refreshTimer

		var_1.Stop(var_42_0)

		local var_42_1
		local var_42_2 = refreshTimer
	end

	return
end

function var_0_1.Hide(arg_43_0)
	arg_43_0:ShowOrHideLogPanel(false, 0)
	var_0_1.super.Hide(arg_43_0)

	if arg_43_0.battleView then
		local var_43_0 = arg_43_0.battleView

		var_1.clear(var_43_0)

		arg_43_0.battleView = nil
	end

	if arg_43_0.timer then
		local var_43_1 = arg_43_0.timer

		var_1.Stop(var_43_1)

		arg_43_0.timer = nil
	end

	arg_43_0:RemoveRefreshTimer()
	arg_43_0:RemoveCdTimer()

	return
end

return var_0_1
