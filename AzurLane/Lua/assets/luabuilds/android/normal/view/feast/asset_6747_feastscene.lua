class = var_0_10000

local var_0_0 = "FeastScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.PAGE_INVITATION = 1
var_0_1.ON_TASK_UPDATE = "FeastScene:ON_TASK_UPDATE"
var_0_1.ON_ACT_UPDATE = "FeastScene:ON_ACT_UPDATE"
var_0_1.ON_SKIP_GIVE_GIFT = "FeastScene:ON_SKIP_GIVE_GIFT"
var_0_1.ON_BACK_FEAST = "FeastScene:ON_BACK_FEAST"
var_0_1.ON_MAKE_TICKET = "FeastScene:ON_MAKE_TICKET"
var_0_1.ON_GOT_TICKET = "FeastScene:ON_GOT_TICKET"
var_0_1.ON_GOT_GIFT = "FeastScene:ON_GOT_GIFT"
var_0_1.GO_INTERACTION = "FeastScene:GO_INTERACTION"
var_0_1.GO_INVITATION = "FeastScene:GO_INVITATION"

function var_0_1.getUIName(arg_1_0)
	return "FeastUI"
end

function var_0_1.forceGC(arg_2_0)
	return true
end

function var_0_1.PlayBGM(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.CriMgr.GetInstance()

	var_1.StopBGM(var_3_0)

	return
end

function var_0_1.init(arg_4_0)
	GetOrAddComponent = var_1_10001

	local var_4_0 = arg_4_0._tf

	typeof = var_1_10003
	CanvasGroup = var_1_10004
	arg_4_0.mainCG = var_1_10001(var_4_0, var_1_10003(var_1_10004))

	local var_4_1 = arg_4_0._tf

	arg_4_0.backBtn = var_1.Find(var_4_1, "main/return")

	local var_4_2 = arg_4_0._tf

	arg_4_0.invitationBtn = var_1.Find(var_4_2, "btns/invitation")

	local var_4_3 = arg_4_0.invitationBtn

	arg_4_0.invitationBtnTip = var_1.Find(var_4_3, "tip")

	local var_4_4 = arg_4_0._tf

	arg_4_0.taskBtn = var_1.Find(var_4_4, "btns/task")

	local var_4_5 = arg_4_0.taskBtn

	arg_4_0.taskBtnTip = var_1.Find(var_4_5, "tip")
	FeastInvitationPage = var_1
	arg_4_0.invitationPage = var_1.New(arg_4_0._tf, arg_4_0.event)
	FeastTaskPage = var_1
	arg_4_0.taskPage = var_1.New(arg_4_0._tf, arg_4_0.event)

	local var_4_6 = arg_4_0._tf

	arg_4_0.helpBtn = var_1.Find(var_4_6, "main/help")

	local var_4_7 = arg_4_0._tf

	arg_4_0.homeBtn = var_1.Find(var_4_7, "main/home")
	UIItemList = var_1

	local var_4_8 = var_1.New
	local var_4_9 = arg_4_0._tf
	local var_4_10 = var_2.Find(var_4_9, "main/buffs")
	local var_4_11 = arg_4_0._tf

	arg_4_0.buffUIlist = var_4_8(var_4_10, var_3.Find(var_4_11, "main/buffs/tpl"))
	setText = var_1

	local var_4_12 = arg_4_0.invitationBtn
	local var_4_13 = var_2.Find(var_4_12, "Text")

	i18n = var_4_12

	var_1(var_4_13, var_4_12("feast_invitation_btn_label"))

	setText = var_1

	local var_4_14 = arg_4_0.taskBtn
	local var_4_15 = var_2.Find(var_4_14, "Text")

	i18n = var_4_14

	var_1(var_4_15, var_4_14("feast_task_btn_label"))

	return
end

function var_0_1.didEnter(arg_5_0)
	arg_5_0:BlockEvents()
	arg_5_0:SetUpCourtYard()

	return
end

function var_0_1.OnCourtYardLoaded(arg_6_0)
	arg_6_0:UnBlockEvents()

	onButton = var_1

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.backBtn

	local function var_6_2()
		local var_7_0 = arg_6_0

		var_0.emit(var_7_0, var_0_1.ON_BACK)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_6_0, var_6_1, var_6_2, var_1_10005)

	onButton = var_1

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.invitationBtn

	local function var_6_5()
		local var_8_0 = arg_6_0.invitationPage

		var_0.ExecuteAction(var_8_0, "Show")

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_6_3, var_6_4, var_6_5, var_1_10005)

	onButton = var_1

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.taskBtn

	local function var_6_8()
		local var_9_0 = arg_6_0.taskPage

		var_0.ExecuteAction(var_9_0, "Show")

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_6_6, var_6_7, var_6_8, var_1_10005)

	onButton = var_1

	local var_6_9 = arg_6_0
	local var_6_10 = arg_6_0.helpBtn

	local function var_6_11()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_10_2.type = var_2_10003
		pg = var_2_10003
		var_10_2.helps = var_2_10003.gametip.feast_tip.tip

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_6_9, var_6_10, var_6_11, var_1_10005)

	onButton = var_1

	local var_6_12 = arg_6_0
	local var_6_13 = arg_6_0.homeBtn

	local function var_6_14()
		local var_11_0 = arg_6_0
		local var_11_1 = var_0.emit

		BaseUI = var_2_10002

		var_11_1(var_11_0, var_2_10002.ON_HOME)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_6_12, var_6_13, var_6_14, var_1_10005)

	local var_6_15 = arg_6_0
	local var_6_16 = arg_6_0.bind

	FeastScene = var_6_13

	var_6_16(var_6_15, var_6_13.ON_TASK_UPDATE, function()
		local var_12_0 = arg_6_0

		var_0.UpdateTips(var_12_0)

		return
	end)

	local var_6_17 = arg_6_0
	local var_6_18 = arg_6_0.bind

	FeastScene = var_3

	var_6_18(var_6_17, var_3.ON_ACT_UPDATE, function()
		local var_13_0 = arg_6_0

		var_0.UpdateTips(var_13_0)

		return
	end)

	local var_6_19 = arg_6_0
	local var_6_20 = arg_6_0.bind

	FeastScene = var_3

	var_6_20(var_6_19, var_3.ON_GOT_GIFT, function()
		local var_14_0 = arg_6_0

		var_0.UpdateTips(var_14_0)

		return
	end)

	local var_6_21 = arg_6_0
	local var_6_22 = arg_6_0.bind

	FeastScene = var_3

	var_6_22(var_6_21, var_3.ON_GOT_TICKET, function()
		local var_15_0 = arg_6_0

		var_0.UpdateTips(var_15_0)

		return
	end)

	local var_6_23 = arg_6_0
	local var_6_24 = arg_6_0.bind

	FeastScene = var_3

	var_6_24(var_6_23, var_3.GO_INTERACTION, function()
		if arg_6_0.taskPage then
			local var_16_0 = arg_6_0.taskPage

			if var_0.GetLoaded(var_16_0) then
				local var_16_1 = arg_6_0.taskPage

				if var_0.isShowing(var_16_1) then
					local var_16_2 = arg_6_0.taskPage

					var_0.Hide(var_16_2)
				end
			end
		end

		return
	end)

	local var_6_25 = arg_6_0
	local var_6_26 = arg_6_0.bind

	FeastScene = var_3

	var_6_26(var_6_25, var_3.GO_INVITATION, function()
		if arg_6_0.taskPage then
			local var_17_0 = arg_6_0.taskPage

			if var_0.GetLoaded(var_17_0) then
				local var_17_1 = arg_6_0.taskPage

				if var_0.isShowing(var_17_1) then
					local var_17_2 = arg_6_0.taskPage

					var_0.Hide(var_17_2)
				end
			end
		end

		local var_17_3 = arg_6_0.invitationPage

		var_0.ExecuteAction(var_17_3, "Show")

		return
	end)

	local var_6_27 = arg_6_0
	local var_6_28 = arg_6_0.bind

	FeastScene = var_3

	var_6_28(var_6_27, var_3.ON_ACT_UPDATE, function()
		local var_18_0 = arg_6_0

		var_0.UpdateBuffs(var_18_0)

		return
	end)

	local var_6_29 = arg_6_0
	local var_6_30 = arg_6_0.bind

	FeastScene = var_3

	var_6_30(var_6_29, var_3.ON_BACK_FEAST, function()
		if arg_6_0.invitationPage then
			local var_19_0 = arg_6_0.invitationPage

			if var_0.GetLoaded(var_19_0) then
				local var_19_1 = arg_6_0.invitationPage

				if var_0.isShowing(var_19_1) then
					local var_19_2 = arg_6_0.invitationPage

					var_0.Hide(var_19_2)
				end
			end
		end

		return
	end)
	arg_6_0:PlayEnterStory()
	arg_6_0:UpdateTips()
	arg_6_0:UpdateBuffs()

	if arg_6_0.contextData.page and arg_6_0.contextData.page == var_0_1.PAGE_INVITATION then
		triggerButton = var_1

		var_1(arg_6_0.invitationBtn)
	end

	return
end

function var_0_1.UpdateBuffs(arg_20_0)
	getProxy = var_1_10001
	FeastProxy = var_1_10002

	local var_20_0 = var_1_10001(var_1_10002)
	local var_20_1 = var_1.GetBuffList(var_20_0)
	local var_20_2 = arg_20_0.buffUIlist

	var_2.make(var_20_2, function(arg_21_0, arg_21_1, arg_21_2)
		UIItemList = var_2_10003

		if arg_21_0 == var_2_10003.EventUpdate then
			local var_21_0 = var_20_1[arg_21_1 + 1]

			onButton = var_4

			local var_21_1 = arg_20_0
			local var_21_2 = arg_21_2

			local function var_21_3()
				local var_22_0 = arg_20_0
				local var_22_1 = var_0.emit

				BaseUI = var_3_10002

				local var_22_2 = var_3_10002.ON_DROP
				local var_22_3 = {}

				DROP_TYPE_BUFF = var_3_10004
				var_22_3.type = var_3_10004
				var_22_3.id = var_21_0.id

				var_22_1(var_22_0, var_22_2, var_22_3)

				return
			end

			SFX_PANEL = var_2_10008

			var_4(var_21_1, var_21_2, var_21_3, var_2_10008)
		end

		return
	end)

	local var_20_3 = arg_20_0.buffUIlist

	var_2.align(var_20_3, #var_20_1)

	return
end

function var_0_1.PlayEnterStory(arg_23_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_23_0 = var_1_10001(var_1_10002)
	local var_23_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_23_2 = var_23_1(var_23_0, var_1_10003.ACTIVITY_TYPE_FEAST)

	if var_1.getConfig(var_23_2, "config_client")[6] and var_3 ~= "" then
		pg = var_4

		local var_23_3 = var_4.NewStoryMgr.GetInstance()

		if not var_4.IsPlayed(var_23_3, var_3) then
			pg = var_4

			local var_23_4 = var_4.NewStoryMgr.GetInstance()

			var_4.Play(var_23_4, var_3)
		end
	end

	return
end

function var_0_1.UpdateTips(arg_24_0)
	setActive = var_1_10001

	local var_24_0 = arg_24_0.invitationBtnTip

	getProxy = var_1_10003
	FeastProxy = var_1_10004

	local var_24_1 = var_1_10003(var_1_10004)

	var_1_10001(var_24_0, var_3.ShouldTipInvitation(var_24_1))

	setActive = var_1_10001

	local var_24_2 = arg_24_0.taskBtnTip

	getProxy = var_3
	FeastProxy = var_24_1

	local var_24_3 = var_3(var_24_1)

	var_1_10001(var_24_2, var_3.ShouldTipTask(var_24_3))

	return
end

function var_0_1.SetUpCourtYard(arg_25_0)
	local var_25_0 = arg_25_0.contextData

	CourtYardConst = var_1_10002
	var_25_0.mode = var_1_10002.SYSTEM_FEAST

	local var_25_1 = arg_25_0
	local var_25_2 = arg_25_0.emit

	FeastMediator = var_1_10003

	var_25_2(var_25_1, var_1_10003.SET_UP, 1)

	return
end

function var_0_1.BlockEvents(arg_26_0)
	arg_26_0.mainCG.blocksRaycasts = false

	return
end

function var_0_1.UnBlockEvents(arg_27_0)
	arg_27_0.mainCG.blocksRaycasts = true

	return
end

function var_0_1.onBackPressed(arg_28_0)
	if arg_28_0.invitationPage then
		local var_28_0 = arg_28_0.invitationPage

		if var_1.GetLoaded(var_28_0) then
			local var_28_1 = arg_28_0.invitationPage

			if var_1.isShowing(var_28_1) then
				local var_28_2 = arg_28_0.invitationPage

				var_1.onBackPressed(var_28_2)

				return
			end
		end
	end

	if arg_28_0.taskPage then
		local var_28_3 = arg_28_0.taskPage

		if var_1.GetLoaded(var_28_3) then
			local var_28_4 = arg_28_0.taskPage

			if var_1.isShowing(var_28_4) then
				local var_28_5 = arg_28_0.taskPage

				var_1.Hide(var_28_5)

				return
			end
		end
	end

	arg_28_0:emit(var_0_1.ON_BACK_PRESSED)

	return
end

function var_0_1.willExit(arg_29_0)
	if arg_29_0.invitationPage then
		local var_29_0 = arg_29_0.invitationPage

		var_1.Destroy(var_29_0)

		arg_29_0.invitationPage = nil
	end

	if arg_29_0.taskPage then
		local var_29_1 = arg_29_0.taskPage

		var_1.Destroy(var_29_1)

		arg_29_0.taskPage = nil
	end

	return
end

return var_0_1
