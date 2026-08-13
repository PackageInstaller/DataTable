class = var_0_10000

local var_0_0 = "GuildModiftionPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.GuildBasePage"))

function var_0_1.getTargetUI(arg_1_0)
	return "GuildModiftionBluePage", "GuildModiftionRedPage"
end

function var_0_1.OnLoaded(arg_2_0)
	findTF = var_1_10001

	local var_2_0 = var_1_10001(arg_2_0._tf, "frame/name_bg/input")
	local var_2_1 = var_1.GetComponent

	typeof = var_3
	InputField = var_1_10004
	arg_2_0.nameInput = var_2_1(var_2_0, var_3(var_1_10004))
	findTF = var_1
	arg_2_0.factionBLHXToggle = var_1(arg_2_0._tf, "frame/policy_container/faction/blhx")
	findTF = var_1
	arg_2_0.factionCSZZToggle = var_1(arg_2_0._tf, "frame/policy_container/faction/cszz")
	findTF = var_1
	arg_2_0.policyRELAXToggle = var_1(arg_2_0._tf, "frame/policy_container/policy/relax")
	findTF = var_1
	arg_2_0.policyPOWERToggle = var_1(arg_2_0._tf, "frame/policy_container/policy/power")
	findTF = var_1

	local var_2_2 = var_1(arg_2_0._tf, "frame/policy_container/input_frame/input")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	InputField = var_1_10004
	arg_2_0.manifestoInput = var_2_3(var_2_2, var_3(var_1_10004))
	findTF = var_1
	arg_2_0.confirmBtn = var_1(arg_2_0._tf, "frame/confirm_btn")
	findTF = var_1
	arg_2_0.cancelBtn = var_1(arg_2_0._tf, "frame/cancel_btn")
	findTF = var_1
	arg_2_0.quitBtn = var_1(arg_2_0._tf, "frame/quit_btn")
	findTF = var_1
	arg_2_0.dissolveBtn = var_1(arg_2_0._tf, "frame/dissolve_btn")
	findTF = var_1
	arg_2_0.factionMask = var_1(arg_2_0._tf, "frame/policy_container/faction/mask")
	findTF = var_1

	local var_2_4 = var_1(arg_2_0._tf, "frame/confirm_btn/print_container/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.costTF = var_2_5(var_2_4, var_3(var_1_10004))

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0.costTF.text = 0

	local var_3_0 = arg_3_0._tf

	arg_3_0.modifyBackBG = var_1.Find(var_3_0, "bg_decorations")
	setActive = var_1

	var_1(arg_3_0._tf, false)

	onButton = var_1

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.cancelBtn

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_1, var_3_2, var_3_3, var_1_10005)

	onButton = var_1

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.dissolveBtn

	local function var_3_6()
		if arg_3_0.guildVO then
			pg = var_0

			local var_5_0 = var_0.MsgboxMgr.GetInstance()
			local var_5_1 = var_0.ShowMsgBox
			local var_5_2 = {}

			i18n = var_2_10003
			var_5_2.content = var_2_10003("guild_tip_dissolve")

			function var_5_2.onYes()
				local var_6_0 = arg_3_0
				local var_6_1 = var_0.emit

				GuildMainMediator = var_3_10002

				var_6_1(var_6_0, var_3_10002.DISSOLVE, arg_3_0.guildVO.id)

				return
			end

			var_5_1(var_5_0, var_5_2)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_4, var_3_5, var_3_6, var_1_10005)

	onButton = var_1

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.quitBtn

	local function var_3_9()
		seriesAsync = var_2_10000

		var_2_10000({
			function(arg_8_0)
				local var_8_0 = arg_3_0

				var_1.DealQuit(var_8_0, arg_8_0)

				return
			end
		}, function()
			local var_9_0 = arg_3_0
			local var_9_1 = var_0.emit

			GuildMainMediator = var_3_10002

			var_9_1(var_9_0, var_3_10002.QUIT, arg_3_0.guildVO.id)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_7, var_3_8, var_3_9, var_1_10005)

	onButton = var_1

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.modifyBackBG

	local function var_3_12()
		local var_10_0 = arg_3_0

		var_0.Hide(var_10_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_10, var_3_11, var_3_12, var_1_10005)

	onButton = var_1

	local var_3_13 = arg_3_0
	local var_3_14 = arg_3_0.confirmBtn

	local function var_3_15()
		Clone = var_2_10000

		local var_11_0 = var_2_10000(arg_3_0.guildVO)
		local var_11_1 = arg_3_0.nameInput.text
		local var_11_2 = arg_3_0.manifestoInput.text

		if not var_11_1 or var_11_1 == "" then
			pg = var_2_10003

			local var_11_3 = var_2_10003.TipsMgr.GetInstance()

			var_2_10003 = var_2_10003.ShowTips
			i18n = var_2_10005

			var_2_10003(var_11_3, var_2_10005("guild_create_error_noname"))

			return
		end

		nameValidityCheck = var_2_10003

		if not var_2_10003(var_11_1, 0, 20, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"err_name_existOtherChar"
		}) then
			return
		end

		local var_11_4 = arg_3_0.guildVO
		local var_11_5, var_11_6

		if var_11_1 ~= var_3.getName(var_11_4) then
			pg = var_11_5
			var_11_5 = var_11_5.gameset.modify_guild_cost.key_value
			getProxy = var_11_4
			PlayerProxy = var_11_6
			var_11_6 = var_11_4(var_11_6)
			var_11_6 = var_4.getData(var_11_6)

			if var_4.getTotalGem(var_11_6) < var_11_5 then
				pg = var_4
				var_11_6 = var_4.TipsMgr.GetInstance()

				local var_11_7 = var_4.ShowTips

				i18n = var_6

				var_11_7(var_11_6, var_6("common_no_rmb"))

				return
			end
		end

		if not var_11_2 or var_11_2 == "" then
			pg = var_11_5

			local var_11_8 = var_11_5.TipsMgr.GetInstance()
			local var_11_9 = var_3.ShowTips

			i18n = var_11_6

			var_11_9(var_11_8, var_11_6("guild_create_error_nomanifesto"))

			return
		end

		var_11_0:setName(var_11_1)
		var_11_0:setPolicy(arg_3_0.policy)
		var_11_0:setFaction(arg_3_0.faction)
		var_11_0:setManifesto(var_11_2)

		local function var_11_10()
			local var_12_0 = var_11_0
			local var_12_1 = var_0.getPolicy(var_12_0)
			local var_12_2 = arg_3_0.guildVO

			if var_12_1 ~= var_1.getPolicy(var_12_2) then
				local var_12_3 = arg_3_0
				local var_12_4 = var_0.emit

				GuildMainMediator = var_12_2

				local var_12_5 = var_12_2.MODIFY
				local var_12_6 = 3
				local var_12_7 = var_11_0

				var_12_4(var_12_3, var_12_5, var_12_6, var_4.getPolicy(var_12_7), "")
			end

			local var_12_8 = var_11_0
			local var_12_9 = var_0.getManifesto(var_12_8)
			local var_12_10 = arg_3_0.guildVO

			if var_12_9 ~= var_1.getManifesto(var_12_10) then
				local var_12_11 = arg_3_0
				local var_12_12 = var_0.emit

				GuildMainMediator = var_12_10

				local var_12_13 = var_12_10.MODIFY
				local var_12_14 = 4
				local var_12_15 = 0
				local var_12_16 = var_11_0

				var_12_12(var_12_11, var_12_13, var_12_14, var_12_15, var_5.getManifesto(var_12_16))
			end

			local var_12_17 = var_11_0
			local var_12_18 = var_0.getName(var_12_17)
			local var_12_19 = arg_3_0.guildVO

			if var_12_18 ~= var_1.getName(var_12_19) then
				local var_12_20 = arg_3_0
				local var_12_21 = var_0.emit

				GuildMainMediator = var_12_19

				local var_12_22 = var_12_19.MODIFY
				local var_12_23 = 1
				local var_12_24 = 0
				local var_12_25 = var_11_0

				var_12_21(var_12_20, var_12_22, var_12_23, var_12_24, var_5.getName(var_12_25))
			end

			local var_12_26 = arg_3_0

			var_0.Hide(var_12_26)

			return
		end

		local var_11_11 = var_11_0:getFaction()
		local var_11_12 = arg_3_0.guildVO

		if var_11_11 ~= var_5.getFaction(var_11_12) then
			pg = var_11_11

			local var_11_13 = var_11_11.MsgboxMgr.GetInstance()
			local var_11_14 = var_4.ShowMsgBox
			local var_11_15 = {}

			i18n = var_7
			var_11_15.content = var_7("guild_faction_change_tip")

			function var_11_15.onYes()
				var_11_10()

				local var_13_0 = arg_3_0
				local var_13_1 = var_0.emit

				GuildMainMediator = var_3_10002

				local var_13_2 = var_3_10002.MODIFY
				local var_13_3 = 2
				local var_13_4 = var_11_0

				var_13_1(var_13_0, var_13_2, var_13_3, var_4.getFaction(var_13_4), "")

				return
			end

			var_11_14(var_11_13, var_11_15)
		else
			var_11_10()
		end

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_3_13, var_3_14, var_3_15, var_1_10005)
	;(function(arg_14_0)
		onInputChanged = var_2_10001

		var_2_10001(arg_3_0, arg_14_0, function()
			getInputText = var_3_10000

			local var_15_0 = var_3_10000(arg_14_0)

			wordVer = var_1

			local var_15_1, var_15_2 = var_1(var_15_0, {
				isReplace = true
			})

			if 0 < var_15_1 then
				setInputText = var_3

				var_3(arg_14_0, var_15_2)
			end

			getInputText = var_3

			local var_15_3 = var_3(arg_3_0.nameInput)
			local var_15_4 = arg_3_0.guildVO

			if var_15_3 ~= var_4.getName(var_15_4) then
				pg = var_15_3
				var_15_3 = var_15_3.gameset.modify_guild_cost.key_value
				setText = var_4

				var_4(arg_3_0.costTF, var_15_3)
			else
				setText = var_15_3

				var_15_3(arg_3_0.costTF, 0)
			end

			return
		end)

		return
	end)(arg_3_0.nameInput)
	var_1(arg_3_0.manifestoInput)

	return
end

function var_0_1.DealQuit(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.guildVO

	if not var_2.GetActiveEvent(var_16_0) or var_2 and not var_2:IsParticipant() then
		pg = var_16_0

		local var_16_1 = var_16_0.MsgboxMgr.GetInstance()
		local var_16_2 = var_3.ShowMsgBox
		local var_16_3 = {}

		i18n = var_1_10006
		var_16_3.content = var_1_10006("guild_tip_quit")
		var_16_3.onYes = arg_16_1

		var_16_2(var_16_1, var_16_3)

		goto label_16_0
	end

	local var_16_4 = var_2:GetJoinCnt()
	local var_16_5 = var_2:GetMaxJoinCnt() - var_16_4
	local var_16_6 = var_2

	if var_16_5 + var_2.GetExtraJoinCnt(var_16_6) <= 0 then
		COLOR_RED = var_6

		if not var_6 then
			COLOR_WHITE = var_6
		end

		string = var_16_6

		do
			local var_16_7 = var_16_6.format("<color=%s>%d</color>/%d", var_6, var_5, var_4)

			pg = var_8

			local var_16_8 = var_8.MsgboxMgr.GetInstance()
			local var_16_9 = var_8.ShowMsgBox
			local var_16_10 = {}

			i18n = var_11
			var_16_10.content = var_11("guild_tip_quit_operation", var_16_7)
			var_16_10.onYes = arg_16_1

			var_16_9(var_16_8, var_16_10)
		end

		::label_16_0::

		return
	end
end

function var_0_1.DealBattleReportAward(arg_17_0, arg_17_1)
	getProxy = var_1_10002
	GuildProxy = var_1_10003

	local var_17_0 = var_1_10002(var_1_10003)

	if #var_2.GetCanGetReports(var_17_0) == 0 then
		arg_17_1()

		return
	end

	local function var_17_1()
		pg = var_2_10000

		local var_18_0 = var_2_10000.m02
		local var_18_1 = var_0.sendNotification

		GAME = var_2_10002

		var_18_1(var_18_0, var_2_10002.SUBMIT_GUILD_REPORT, {
			ids = var_0,
			callback = arg_17_1
		})

		return
	end

	pg = var_1_10004

	local var_17_2 = var_1_10004.MsgboxMgr.GetInstance()
	local var_17_3 = var_4.ShowMsgBox
	local var_17_4 = {}

	i18n = var_1_10007
	var_17_4.content = var_1_10007("guild_exist_report_award_when_exit")
	var_17_4.onYes = var_17_1

	function var_17_4.onNo()
		local var_19_0 = arg_17_0
		local var_19_1 = var_0.emit

		GuildMainMediator = var_2_10002

		var_19_1(var_19_0, var_2_10002.QUIT, arg_17_0.guildVO.id)

		return
	end

	var_17_3(var_17_2, var_17_4)

	return
end

function var_0_1.Show(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0.guildVO = arg_20_1
	arg_20_0.playerVO = arg_20_2
	setActive = var_1_10003

	var_1_10003(arg_20_0._tf, true)

	pg = var_1_10003

	local var_20_0 = var_1_10003.UIMgr.GetInstance()

	var_3.BlurPanel(var_20_0, arg_20_0._tf)

	local var_20_1 = arg_20_0._tf

	var_3.SetAsLastSibling(var_20_1)

	arg_20_0.isShowModify = true

	local var_20_2 = arg_20_0.nameInput
	local var_20_3 = arg_20_0.guildVO

	var_20_2.text = var_4.getName(var_20_3)
	arg_20_0.manifestoInput.text = arg_20_0.guildVO.manifesto

	local var_20_4 = arg_20_0.guildVO
	local var_20_5 = var_3.getDutyByMemberId(var_20_4, arg_20_0.playerVO.id)

	GuildConst = var_20_4

	local var_20_6 = var_20_5 == var_20_4.DUTY_COMMANDER

	arg_20_0.nameInput.interactable = var_20_6

	local var_20_7 = arg_20_0.manifestoInput

	var_20_7.interactable = var_20_6
	setActive = var_20_7

	var_20_7(arg_20_0.confirmBtn, var_20_6)

	setActive = var_20_7

	var_20_7(arg_20_0.cancelBtn, var_20_6)

	local var_20_8 = arg_20_0.guildVO
	local var_20_9 = var_4.inChangefactionTime(var_20_8)

	setActive = var_20_8

	local var_20_10 = arg_20_0.factionMask
	local var_20_11 = arg_20_0.guildVO

	var_20_8(var_20_10, var_7.inChangefactionTime(var_20_11))

	if var_20_9 then
		local var_20_12 = arg_20_0.guildVO
		local var_20_13 = var_5.changeFactionLeftTime(var_20_12)

		setText = var_20_12

		local var_20_14 = arg_20_0.factionMask

		var_20_12(var_7.Find(var_20_14, "timer_container/Text"), var_20_13)
	end

	local var_20_15 = arg_20_0.guildVO

	arg_20_0.faction = var_5.getFaction(var_20_15)
	onToggle = var_5

	local var_20_16 = arg_20_0
	local var_20_17 = arg_20_0.factionBLHXToggle

	local function var_20_18(arg_21_0)
		if arg_21_0 then
			local var_21_0 = arg_20_0

			GuildConst = var_2_10002
			var_21_0.faction = var_2_10002.FACTION_TYPE_BLHX
		end

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_20_16, var_20_17, var_20_18, var_1_10009)

	onToggle = var_5

	local var_20_19 = arg_20_0
	local var_20_20 = arg_20_0.factionCSZZToggle

	local function var_20_21(arg_22_0)
		if arg_22_0 then
			local var_22_0 = arg_20_0

			GuildConst = var_2_10002
			var_22_0.faction = var_2_10002.FACTION_TYPE_CSZZ
		end

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_20_19, var_20_20, var_20_21, var_1_10009)

	local var_20_22 = arg_20_0.guildVO

	arg_20_0.policy = var_5.getPolicy(var_20_22)
	onToggle = var_5

	local var_20_23 = arg_20_0
	local var_20_24 = arg_20_0.policyRELAXToggle

	local function var_20_25(arg_23_0)
		if arg_23_0 then
			local var_23_0 = arg_20_0

			GuildConst = var_2_10002
			var_23_0.policy = var_2_10002.POLICY_TYPE_RELAXATION
		end

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_20_23, var_20_24, var_20_25, var_1_10009)

	onToggle = var_5

	local var_20_26 = arg_20_0
	local var_20_27 = arg_20_0.policyPOWERToggle

	local function var_20_28(arg_24_0)
		if arg_24_0 then
			local var_24_0 = arg_20_0

			GuildConst = var_2_10002
			var_24_0.policy = var_2_10002.POLICY_TYPE_POWER
		end

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_20_26, var_20_27, var_20_28, var_1_10009)

	local var_20_29 = arg_20_0.faction

	GuildConst = var_20_26

	if var_20_29 == var_20_26.FACTION_TYPE_BLHX then
		triggerToggle = var_20_29

		var_20_29(arg_20_0.factionBLHXToggle, true)
	else
		local var_20_30 = arg_20_0.faction

		GuildConst = var_6

		if var_20_30 == var_6.FACTION_TYPE_CSZZ then
			triggerToggle = var_20_30

			var_20_30(arg_20_0.factionCSZZToggle, true)
		end
	end

	local var_20_31 = arg_20_0.policy

	GuildConst = var_6

	if var_20_31 == var_6.POLICY_TYPE_RELAXATION then
		triggerToggle = var_20_31

		var_20_31(arg_20_0.policyRELAXToggle, true)
	else
		local var_20_32 = arg_20_0.policy

		GuildConst = var_6

		if var_20_32 == var_6.POLICY_TYPE_POWER then
			triggerToggle = var_20_32

			var_20_32(arg_20_0.policyPOWERToggle, true)
		end
	end

	local var_20_33 = arg_20_0.policyPOWERToggle
	local var_20_34 = var_5.GetComponent

	typeof = var_20_27
	Toggle = var_20_28
	var_20_34(var_20_33, var_20_27(var_20_28)).interactable = var_20_6

	local var_20_35 = arg_20_0.policyRELAXToggle
	local var_20_36 = var_5.GetComponent

	typeof = var_7
	Toggle = var_20_28
	var_20_36(var_20_35, var_7(var_20_28)).interactable = var_20_6

	local var_20_37 = arg_20_0.factionCSZZToggle
	local var_20_38 = var_5.GetComponent

	typeof = var_7
	Toggle = var_20_28
	var_20_38(var_20_37, var_7(var_20_28)).interactable = var_20_6

	local var_20_39 = arg_20_0.factionBLHXToggle
	local var_20_40 = var_5.GetComponent

	typeof = var_7
	Toggle = var_20_28
	var_20_40(var_20_39, var_7(var_20_28)).interactable = var_20_6

	local var_20_41 = arg_20_0.guildVO
	local var_20_42 = var_5.getDutyByMemberId(var_20_41, arg_20_0.playerVO.id)

	setActive = var_20_41

	local var_20_43 = arg_20_0.quitBtn

	GuildConst = var_20_28

	var_20_41(var_20_43, var_20_42 ~= var_20_28.DUTY_COMMANDER)

	setActive = var_20_41

	local var_20_44 = arg_20_0.dissolveBtn

	GuildConst = var_8

	var_20_41(var_20_44, var_20_42 == var_8.DUTY_COMMANDER)

	return
end

function var_0_1.Hide(arg_25_0)
	pg = var_1_10001

	local var_25_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_25_0, arg_25_0._tf, arg_25_0._parentTf)

	setActive = var_1

	var_1(arg_25_0._tf, false)

	return
end

function var_0_1.OnDestroy(arg_26_0)
	arg_26_0:Hide()

	return
end

return var_0_1
