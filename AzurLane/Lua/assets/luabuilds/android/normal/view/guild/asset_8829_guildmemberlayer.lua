class = var_0_10000

local var_0_0 = "GuildMemberLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.setGuildVO(arg_1_0, arg_1_1)
	arg_1_0.guildVO = arg_1_1

	arg_1_0:setMemberVOs(arg_1_1:getSortMember())

	return
end

function var_0_1.setMemberVOs(arg_2_0, arg_2_1)
	arg_2_0.memberVOs = arg_2_1

	return
end

function var_0_1.setPlayerVO(arg_3_0, arg_3_1)
	arg_3_0.playerVO = arg_3_1

	return
end

function var_0_1.SetRanks(arg_4_0, arg_4_1)
	arg_4_0.ranks = arg_4_1

	return
end

function var_0_1.getUIName(arg_5_0)
	return "GuildMemberUI"
end

function var_0_1.init(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.buttonsPanel = var_1.Find(var_6_0, "buttons_panel")

	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_1.Find(var_6_1, "buttons_panel")
	local var_6_3 = var_1.GetComponent

	typeof = var_3
	ToggleGroup = var_1_10004
	arg_6_0.toggleGroup = var_6_3(var_6_2, var_3(var_1_10004))

	local var_6_4 = arg_6_0._tf

	arg_6_0.chatPanel = var_1.Find(var_6_4, "chat")
	setActive = var_1

	var_1(arg_6_0.chatPanel, false)

	setActive = var_1

	var_1(arg_6_0.buttonsPanel, false)

	local var_6_5 = {}
	local var_6_6 = arg_6_0._tf

	var_6_5[1] = var_2.Find(var_6_6, "buttons_panel/info_btn")

	local var_6_7 = arg_6_0._tf

	var_6_5[2] = var_2.Find(var_6_7, "buttons_panel/duty_btn")

	local var_6_8 = arg_6_0._tf

	var_6_5[3] = var_2.Find(var_6_8, "buttons_panel/fire_btn")

	local var_6_9 = arg_6_0._tf

	var_6_5[4] = var_2.Find(var_6_9, "buttons_panel/impeach_btn")
	arg_6_0.btns = var_6_5

	local var_6_10 = arg_6_0._tf

	arg_6_0.helpBtn = var_1.Find(var_6_10, "help")

	local var_6_11 = {}

	GuildMemberInfoPage = var_6_10
	var_6_11[1] = var_6_10.New(arg_6_0._tf, arg_6_0.event)
	GuildAppiontPage = var_2
	var_6_11[2] = var_2.New(arg_6_0._tf, arg_6_0.event)
	GuildFirePage = var_2
	var_6_11[3] = var_2.New(arg_6_0._tf, arg_6_0.event)
	GuildImpeachPage = var_2
	var_6_11[4] = var_2.New(arg_6_0._tf, arg_6_0.event)
	arg_6_0.pages = var_6_11

	local var_6_12 = arg_6_0.contextData

	GuildRankPage = var_2
	var_6_12.rankPage = var_2.New(arg_6_0._tf, arg_6_0.event)
	GuildMemberListPage = var_6_12
	arg_6_0.listPage = var_6_12.New(arg_6_0._tf, arg_6_0.event, arg_6_0.contextData)

	function arg_6_0.listPage.OnClickMember(arg_7_0)
		local var_7_0 = arg_6_0

		var_1.LoadPainting(var_7_0, arg_7_0)

		return
	end

	arg_6_0.buttonPos = arg_6_0.buttonsPanel.localPosition

	return
end

function var_0_1.didEnter(arg_8_0)
	local function var_8_0()
		if arg_8_0.page then
			table = var_0

			local var_9_0 = var_0.indexof(arg_8_0.pages, arg_8_0.page)
			local var_9_1 = arg_8_0.btns[var_9_0]

			setActive = var_2

			var_2(var_9_1:Find("sel"), false)
		end

		return
	end

	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.btns) do
		onButton = var_1_10007

		local var_8_1 = arg_8_0
		local var_8_2 = iter_8_1

		local function var_8_3()
			if iter_8_0 == 2 then
				local var_10_0 = arg_8_0.memberVO

				if var_0.IsRecruit(var_10_0) then
					pg = var_0

					local var_10_1 = var_0.TipsMgr.GetInstance()
					local var_10_2 = var_0.ShowTips

					i18n = var_2_10002

					var_10_2(var_10_1, var_2_10002("guild_trainee_duty_change_tip"))

					return
				end
			end

			if arg_8_0.page then
				local var_10_3 = arg_8_0.page

				if not var_0.GetLoaded(var_10_3) then
					return
				end
			end

			local var_10_4 = arg_8_0.pages[iter_8_0]

			pg = var_1

			local var_10_5 = var_1.UIMgr.GetInstance()

			var_1.LoadingOn(var_10_5)

			local function var_10_6()
				if arg_8_0.page then
					local var_11_0 = arg_8_0.page

					var_0.Hide(var_11_0)
				end

				var_8_0()

				setActive = var_0

				local var_11_1 = iter_8_1

				var_0(var_1.Find(var_11_1, "sel"), true)

				local var_11_2 = arg_8_0

				var_11_2.page = var_10_4
				pg = var_11_2

				local var_11_3 = var_11_2.UIMgr.GetInstance()

				var_0.LoadingOff(var_11_3)

				return
			end

			var_10_4:ExecuteAction("Show", arg_8_0.guildVO, arg_8_0.playerVO, arg_8_0.memberVO, var_10_6)

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10007(var_8_1, var_8_2, var_8_3, var_1_10011)

		local var_8_4 = arg_8_0.pages[iter_8_0]

		var_1_10007.SetCallBack(var_8_4, function(arg_12_0)
			local var_12_0 = arg_8_0.buttonsPanel

			var_12_0.localPosition = arg_12_0
			setParent = var_12_0

			local var_12_1 = arg_8_0.buttonsPanel

			pg = var_2_10003

			var_12_0(var_12_1, var_2_10003.UIMgr.GetInstance().OverlayMain)

			return
		end, function()
			var_8_0()

			setParent = var_0

			var_0(arg_8_0.buttonsPanel, arg_8_0._tf)

			arg_8_0.buttonsPanel.localPosition = arg_8_0.buttonPos

			return
		end)
	end

	onButton = var_2

	local var_8_5 = arg_8_0
	local var_8_6 = arg_8_0.helpBtn

	local function var_8_7()
		pg = var_2_10000

		local var_14_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_14_1 = var_0.ShowMsgBox
		local var_14_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_14_2.type = var_2_10003
		pg = var_2_10003
		var_14_2.helps = var_2_10003.gametip.guild_member_tip.tip

		var_14_1(var_14_0, var_14_2)

		return
	end

	SFX_PANEL = iter_8_1

	var_2(var_8_5, var_8_6, var_8_7, iter_8_1)

	local var_8_8 = arg_8_0.listPage

	var_2.ExecuteAction(var_8_8, "SetUp", arg_8_0.guildVO, arg_8_0.memberVOs, arg_8_0.ranks)

	return
end

function var_0_1.LoadPainting(arg_15_0, arg_15_1)
	arg_15_0.memberVO = arg_15_1

	local var_15_0 = arg_15_1.duty
	local var_15_1 = arg_15_0.guildVO
	local var_15_2 = var_3.getDutyByMemberId(var_15_1, arg_15_0.playerVO.id)

	setActive = var_15_1

	var_15_1(arg_15_0.buttonsPanel, true)

	local var_15_3 = arg_15_1
	local var_15_4 = arg_15_1.GetManifesto(var_15_3)

	HXSet = var_15_3

	if var_15_3.isHxPropose() then
		var_15_4 = ""
	end

	if not var_15_4 or var_15_4 == "" then
		setActive = var_5

		var_5(arg_15_0.chatPanel, false)
	else
		setActive = var_5

		var_5(arg_15_0.chatPanel, true)

		setText = var_5

		local var_15_5 = arg_15_0.chatPanel

		var_5(var_6.Find(var_15_5, "Text"), var_15_4)
	end

	local var_15_6

	HXSet = var_6

	local var_15_10

	if var_6.isHxPropose() then
		local var_15_7 = arg_15_0.guildVO
		local var_15_8 = var_15_10.GetOfficePainting(var_15_7)

		pg = var_15_10

		local var_15_9 = var_15_10.GuildPaintingMgr.GetInstance()

		var_15_10 = var_15_10.Update
		var_1_10008 = var_15_8
		Vector3 = var_1_10009

		var_15_10(var_15_9, var_1_10008, var_1_10009(-643, -160, 0))
	else
		Ship = var_15_10
		var_1_10008 = var_15_10.New({
			configId = arg_15_1.icon,
			skin_id = arg_15_1.skinId
		})

		local var_15_11 = var_15_10.getPainting(var_1_10008)

		pg = var_7
		var_1_10008 = var_7.GuildPaintingMgr.GetInstance()

		local var_15_12 = var_7.Update
		local var_15_13 = var_15_11

		Vector3 = var_1_10010

		var_15_12(var_1_10008, var_15_13, var_1_10010(-484, 0, 0), true)
	end

	setActive = var_15_10

	local var_15_14 = arg_15_0.btns[4]

	GuildConst = var_1_10008

	local var_15_15

	if var_15_2 == var_1_10008.DUTY_DEPUTY_COMMANDER then
		GuildConst = var_8

		if var_15_0 == var_8.DUTY_COMMANDER then
			var_15_15 = arg_15_1:isLongOffLine()

			goto label_15_0
		end
	end

	var_15_15 = false

	if false then
		var_15_15 = true
	end

	::label_15_0::

	var_15_10(var_15_14, var_15_15)

	GuildConst = var_15_10

	if var_15_2 ~= var_15_10.DUTY_DEPUTY_COMMANDER then
		GuildConst = var_6

		if var_15_2 == var_6.DUTY_COMMANDER then
			local var_15_16

			if not (var_15_2 < var_15_0) then
				var_15_16 = false
			else
				var_15_16 = true
			end

			setButtonEnabled = var_15_14

			var_15_14(arg_15_0.btns[2], var_15_16)

			setGray = var_15_14

			var_15_14(arg_15_0.btns[2], not var_15_16, true)

			GuildConst = var_15_14

			if var_15_2 ~= var_15_14.DUTY_DEPUTY_COMMANDER then
				GuildConst = var_7

				if var_15_2 == var_7.DUTY_COMMANDER then
					local var_15_17

					if not (var_15_2 < var_15_0) then
						var_15_17 = false
					else
						var_15_17 = true
					end

					setButtonEnabled = var_8

					var_8(arg_15_0.btns[3], var_15_17)

					setGray = var_8

					var_8(arg_15_0.btns[3], not var_15_17, true)

					return
				end
			end
		end
	end
end

function var_0_1.RefreshMembers(arg_16_0)
	local var_16_0 = arg_16_0.listPage

	if var_1.GetLoaded(var_16_0) then
		local var_16_1 = arg_16_0.listPage

		var_1.Flush(var_16_1, arg_16_0.guildVO, arg_16_0.memberVOs, arg_16_0.ranks)
	end

	return
end

function var_0_1.ActiveDefaultMenmber(arg_17_0)
	local var_17_0 = arg_17_0.listPage

	if var_1.GetLoaded(var_17_0) then
		local var_17_1 = arg_17_0.listPage

		var_1.TriggerFirstCard(var_17_1)
	end

	return
end

function var_0_1.UpdateRankList(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.ranks[arg_18_1] = arg_18_2

	if arg_18_0.contextData.rankPage then
		local var_18_0 = arg_18_0.contextData.rankPage

		if var_3.GetLoaded(var_18_0) then
			local var_18_1 = arg_18_0.contextData.rankPage

			var_3.ExecuteAction(var_18_1, "OnUpdateRankList", arg_18_1, arg_18_2)
		end
	end

	return
end

function var_0_1.ShowInfoPanel(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.pages[1]

	var_2.ExecuteAction(var_19_0, "Flush", arg_19_1)

	return
end

function var_0_1.onBackPressed(arg_20_0)
	ipairs = var_1_10001

	for iter_20_0, iter_20_1 in var_1_10001(arg_20_0.pages) do
		if iter_20_1:GetLoaded() and iter_20_1:isShowing() then
			iter_20_1:Hide()

			return
		end
	end

	pg = var_1

	local var_20_0 = var_1.CriMgr.GetInstance()
	local var_20_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_3

	var_20_1(var_20_0, var_3)
	arg_20_0:emit(var_0_1.ON_BACK)

	return
end

function var_0_1.willExit(arg_21_0)
	local var_21_0 = arg_21_0.contextData.rankPage

	var_1.Destroy(var_21_0)

	arg_21_0.listPage.OnClickMember = nil

	local var_21_1 = arg_21_0.listPage

	var_1.Destroy(var_21_1)

	ipairs = var_1

	for iter_21_0, iter_21_1 in var_1(arg_21_0.pages) do
		iter_21_1:Destroy()
	end

	isActive = var_1
	pg = var_2

	if var_1(var_2.MsgboxMgr.GetInstance()._go) then
		triggerButton = var_1
		pg = var_2

		var_1(var_2.MsgboxMgr.GetInstance()._closeBtn)
	end

	return
end

return var_0_1
