class = var_0_10000

local var_0_0 = "GuildEventInfoPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuildEventBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "GuildEventInfoPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "frame/close")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "frame/icon")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.icon = var_2_3(var_2_2, var_4(var_1_10006))

	local var_2_4 = arg_2_0._tf

	arg_2_0.goBtn = var_1.Find(var_2_4, "frame/go_btn")

	local var_2_5 = arg_2_0._tf

	arg_2_0.joinBtn = var_1.Find(var_2_5, "frame/join_btn")

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "frame/desc")
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.descTxt = var_2_8(var_2_7, var_4(var_1_10006))

	local var_2_9 = arg_2_0._tf

	arg_2_0.consumeTF = var_1.Find(var_2_9, "frame/consume")

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.Find(var_2_10, "frame/consume/Text")
	local var_2_12 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.consumeTxt = var_2_12(var_2_11, var_4(var_1_10006))

	local var_2_13 = arg_2_0._tf

	arg_2_0.cntTF = var_1.Find(var_2_13, "frame/cnt")

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_1.Find(var_2_14, "frame/cnt/Text")
	local var_2_16 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.cntTxt = var_2_16(var_2_15, var_4(var_1_10006))

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_1.Find(var_2_17, "frame/title/Text")
	local var_2_19 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.nameTxt = var_2_19(var_2_18, var_4(var_1_10006))

	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_1.Find(var_2_20, "frame/title/scale")
	local var_2_22 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.scaleTxt = var_2_22(var_2_21, var_4(var_1_10006))

	local var_2_23 = arg_2_0._tf
	local var_2_24 = var_1.Find(var_2_23, "frame/title/scale/Text")
	local var_2_25 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.scaleCntTxt = var_2_25(var_2_24, var_4(var_1_10006))

	local var_2_26 = arg_2_0._tf

	arg_2_0.progressTF = var_1.Find(var_2_26, "frame/cnt/progress")

	local var_2_27 = arg_2_0._tf
	local var_2_28 = var_1.Find(var_2_27, "frame/cnt/progress/Text")
	local var_2_29 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.progressTxt = var_2_29(var_2_28, var_4(var_1_10006))
	UIItemList = var_1

	local var_2_30 = var_1.New
	local var_2_31 = arg_2_0._tf
	local var_2_32 = var_3.Find(var_2_31, "frame/events/icons")
	local var_2_33 = arg_2_0._tf

	arg_2_0.missionList = var_2_30(var_2_32, var_4.Find(var_2_33, "frame/events/icons/tpl"))
	UIItemList = var_1

	local var_2_34 = var_1.New
	local var_2_35 = arg_2_0._tf
	local var_2_36 = var_3.Find(var_2_35, "frame/award/displays")
	local var_2_37 = arg_2_0._tf

	arg_2_0.awardList = var_2_34(var_2_36, var_4.Find(var_2_37, "frame/award/displays/item"))
	setText = var_1

	local var_2_38 = arg_2_0._tf
	local var_2_39 = var_3.Find(var_2_38, "frame/events/Text")

	i18n = var_4

	var_1(var_2_39, var_4("guild_word_may_happen_event"))

	setText = var_1

	local var_2_40 = arg_2_0._tf
	local var_2_41 = var_3.Find(var_2_40, "frame/award/Text")

	i18n = var_4

	var_1(var_2_41, var_4("guild_battle_award"))

	setText = var_1

	local var_2_42 = arg_2_0._tf
	local var_2_43 = var_3.Find(var_2_42, "frame/consume/label")

	i18n = var_4

	var_1(var_2_43, var_4("guild_word_consume"))

	setText = var_1

	local var_2_44 = arg_2_0._tf
	local var_2_45 = var_3.Find(var_2_44, "frame/cnt/label")

	i18n = var_4

	var_1(var_2_45, var_4("guild_join_event_cnt_label"))

	setText = var_1

	local var_2_46 = arg_2_0._tf
	local var_2_47 = var_3.Find(var_2_46, "frame/cnt/progress/label")

	i18n = var_4

	var_1(var_2_47, var_4("guild_join_event_progress_label"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.goBtn

	local function var_3_8()
		GuildMember = var_2_10000

		local var_6_0 = var_2_10000.IsAdministrator
		local var_6_1 = arg_3_0.guild

		if not var_6_0(var_2.getSelfDuty(var_6_1)) then
			pg = var_2_10001

			local var_6_2 = var_2_10001.TipsMgr.GetInstance()
			local var_6_3 = var_1.ShowTips

			i18n = var_6_1

			var_6_3(var_6_2, var_6_1("guild_commander_and_sub_op"))

			return
		end

		local var_6_4 = arg_3_0.gevent
		local var_6_5 = var_1.GetName(var_6_4)
		local var_6_6 = arg_3_0.gevent
		local var_6_7 = var_2.GetConsume(var_6_6)
		local var_6_8 = arg_3_0.guild

		if var_3.ShouldTipActiveEvent(var_6_8) then
			i18n = var_6_13

			local var_6_13

			if not var_6_13("guild_start_event_consume_tip", var_6_7, var_6_5) then
				i18n = var_6_13

				local var_6_9 = "guild_start_event_consume_tip_extra"
				local var_6_10 = var_6_7
				local var_6_11 = var_6_5
				local var_6_12 = arg_3_0.guild

				var_6_13 = var_6_13(var_6_9, var_6_10, var_6_11, var_8.GetActiveEventCnt(var_6_12))
			end

			pg = var_6_6

			local var_6_14 = var_6_6.MsgboxMgr.GetInstance()

			var_4.ShowMsgBox(var_6_14, {
				content = var_6_13,
				onYes = function()
					local var_7_0 = arg_3_0
					local var_7_1 = var_0.emit

					GuildEventMediator = var_3_10003

					var_7_1(var_7_0, var_3_10003.ON_ACTIVE_EVENT, arg_3_0.gevent.id)

					return
				end
			})

			return
		end
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.joinBtn

	local function var_3_11()
		if not arg_3_0.activeEvent then
			return
		end

		local var_8_0 = arg_3_0.activeEvent

		if var_0.IsLimitedJoin(var_8_0) then
			pg = var_0

			local var_8_1 = var_0.TipsMgr.GetInstance()
			local var_8_2 = var_0.ShowTips

			i18n = var_2_10003

			var_8_2(var_8_1, var_2_10003("guild_join_event_max_cnt_tip"))

			return
		end

		local var_8_3 = arg_3_0

		var_0.JoinEvent(var_8_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10006)

	return
end

function var_0_1.JoinEvent(arg_9_0)
	local function var_9_0()
		local var_10_0 = arg_9_0.activeEvent
		local var_10_1, var_10_2 = var_0.GetMainMissionCntAndFinishCnt(var_10_0)

		if var_10_2 ~= 0 then
			pg = var_10_0

			local var_10_3 = var_10_0.MsgboxMgr.GetInstance()
			local var_10_4 = var_2.ShowMsgBox

			var_2_10005 = {}
			i18n = var_2_10006
			var_2_10005.content = var_2_10006("guild_join_event_exist_finished_mission_tip")

			function var_2_10005.onYes()
				local var_11_0 = arg_9_0
				local var_11_1 = var_0.emit

				GuildEventMediator = var_3_10003

				var_11_1(var_11_0, var_3_10003.ON_JOIN_EVENT)

				return
			end

			var_10_4(var_10_3, var_2_10005)
		else
			local var_10_5 = arg_9_0
			local var_10_6 = var_2.emit

			GuildEventMediator = var_2_10005

			var_10_6(var_10_5, var_2_10005.ON_JOIN_EVENT)
		end

		return
	end

	local var_9_1 = arg_9_0.activeEvent

	if var_2.GetLeftTime(var_9_1) <= 0 then
		pg = var_3

		local var_9_2 = var_3.MsgboxMgr.GetInstance()
		local var_9_3 = var_3.ShowMsgBox
		local var_9_4 = {}

		i18n = var_1_10007
		var_9_4.content = var_1_10007("guild_tip_operation_time_is_not_ample")
		var_9_4.onYes = var_9_0

		var_9_3(var_9_2, var_9_4)
	else
		var_9_0()
	end

	return
end

function var_0_1.Refresh(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:UpdateData(arg_12_1, arg_12_2, arg_12_0.extraData)
	arg_12_0:UpdateBtnState()

	return
end

function var_0_1.OnShow(arg_13_0)
	arg_13_0.gevent = arg_13_0.extraData.gevent

	local var_13_0 = arg_13_0.gevent
	local var_13_1 = arg_13_0.icon

	GetSpriteFromAtlas = var_1_10003
	var_13_1.sprite = var_1_10003("guildevent/i_" .. var_13_0.id, "")
	setActive = var_13_1

	var_13_1(arg_13_0.icon.gameObject, true)

	arg_13_0.descTxt.text = var_13_0:GetDesc()

	local var_13_2 = arg_13_0.guild

	if var_2.getCapital(var_13_2) < var_13_0:GetConsume() then
		COLOR_RED = var_13_2

		if not var_13_2 then
			COLOR_GREEN = var_13_2
		end

		arg_13_0.consumeTxt.text = "<color=" .. var_13_2 .. ">" .. var_2 .. "</color>/" .. var_3
		arg_13_0.nameTxt.text = var_13_0:GetName()
		arg_13_0.scaleTxt.text = var_13_0:GetScaleDesc()
		arg_13_0.scaleCntTxt.text = ""

		arg_13_0:UpdateMissions(var_13_0)
		arg_13_0:UpdateAwards(var_13_0)
		arg_13_0:UpdateBtnState()

		return
	end
end

function var_0_1.UpdateBtnState(arg_14_0)
	local var_14_0 = arg_14_0.guild

	arg_14_0.activeEvent = var_1.GetActiveEvent(var_14_0)
	setActive = var_1

	var_1(arg_14_0.goBtn, not arg_14_0.activeEvent)

	setActive = var_1

	var_1(arg_14_0.consumeTF, not arg_14_0.activeEvent)

	setActive = var_1

	var_1(arg_14_0.joinBtn, arg_14_0.activeEvent)

	setActive = var_1

	var_1(arg_14_0.cntTF, arg_14_0.activeEvent)

	setActive = var_1

	var_1(arg_14_0.progressTF, arg_14_0.activeEvent)

	if arg_14_0.activeEvent then
		local var_14_1 = arg_14_0.activeEvent
		local var_14_2 = var_1.GetJoinCnt(var_14_1)
		local var_14_3 = arg_14_0.activeEvent
		local var_14_4 = var_2.GetMaxJoinCnt(var_14_3) - var_14_2
		local var_14_5 = arg_14_0.activeEvent

		if var_14_4 + var_4.GetExtraJoinCnt(var_14_5) <= 0 then
			COLOR_RED = var_4

			if not var_4 then
				COLOR_WHITE = var_4
			end

			string = var_1_10005

			local var_14_6 = var_1_10005.format("<color=%s>%d</color>/%d", var_4, var_3, var_2)

			arg_14_0.cntTxt.text = var_14_6

			local var_14_7 = arg_14_0.activeEvent
			local var_14_8, var_14_9 = var_6.GetMainMissionCntAndFinishCnt(var_14_7)

			arg_14_0.progressTxt.text = var_14_9 .. "/" .. var_14_8 + 1

			return
		end
	end
end

function var_0_1.UpdateAwards(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1:GetDisplayAward()
	local var_15_1 = arg_15_0.awardList

	var_3.make(var_15_1, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			local var_16_0 = var_15_0[arg_16_1 + 1]
			local var_16_1 = {
				id = var_16_0[2],
				type = var_16_0[1],
				count = var_16_0[3]
			}

			updateDrop = var_5

			var_5(arg_16_2, var_16_1)

			onButton = var_5

			local var_16_2 = arg_15_0
			local var_16_3 = arg_16_2

			local function var_16_4()
				local var_17_0 = arg_15_0
				local var_17_1 = var_0.emit

				BaseUI = var_3_10003

				var_17_1(var_17_0, var_3_10003.ON_DROP, var_16_1)

				return
			end

			SFX_PANEL = var_2_10010

			var_5(var_16_2, var_16_3, var_16_4, var_2_10010)
		end

		return
	end)

	local var_15_2 = arg_15_0.awardList

	var_3.align(var_15_2, #var_15_0)

	return
end

function var_0_1.UpdateMissions(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:GetDisplayMission()
	local var_18_1 = arg_18_0.missionList

	var_3.make(var_18_1, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			local var_19_0 = var_18_0[arg_19_1 + 1]
			local var_19_1 = arg_19_2
			local var_19_2 = arg_19_2.GetComponent

			typeof = var_2_10007
			Image = var_2_10009

			local var_19_3 = var_19_2(var_19_1, var_2_10007(var_2_10009))

			GetSpriteFromAtlas = var_2_10005
			var_19_3.sprite = var_2_10005("GuildEventIcon", var_19_0)
		end

		return
	end)

	local var_18_2 = arg_18_0.missionList

	var_3.align(var_18_2, #var_18_0)

	return
end

return var_0_1
