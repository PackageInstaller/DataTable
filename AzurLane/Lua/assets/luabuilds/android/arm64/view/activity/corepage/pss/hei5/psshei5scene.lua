class = var_0_10000

local var_0_0 = "PSSHei5Scene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

var_0_1.optionsPath = {
	"top/home"
}
var_0_1.PAGE_AWARD = "award"
var_0_1.PAGE_TASK = "task"

local var_0_2 = var_0_1.PAGE_AWARD

function var_0_1.getUIName(arg_1_0)
	return "PSSHei5UI"
end

function var_0_1.setActivity(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1
	pairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(arg_2_1:GetHei5Info()) do
		arg_2_0[iter_2_0] = iter_2_1
	end

	arg_2_0.contextData.phase = arg_2_0.phase

	return
end

function var_0_1.initTplVar(arg_3_0)
	local var_3_0 = "blackfriday_battlepass_main_help_"

	pg = var_1_10002
	arg_3_0.helpBtnTip = var_3_0 .. var_1_10002.black_friday_battlepass_event_pt[arg_3_0.activity.id].map_name
	PSSHei5AwardPage = var_1
	arg_3_0.awardPageCls = var_1
	PSSHei5TaskPage = var_1
	arg_3_0.taskPageCls = var_1
	PSSCruiseChargePage = var_1
	arg_3_0.chargePageCls = var_1
	arg_3_0.dayTextTip = "blackfriday_battlepass_main_time_title"
	arg_3_0.titleTextTip = "activity_ninjia_main_title"
	arg_3_0.rewardTip = "blackfriday_battlepass_rewards"
	arg_3_0.missionTip = "blackfriday_battlepass_mission"

	return
end

function var_0_1.init(arg_4_0)
	arg_4_0:initTplVar()

	local var_4_0 = arg_4_0._tf

	arg_4_0.topUI = var_1.Find(var_4_0, "top")

	local var_4_1 = arg_4_0.topUI

	arg_4_0.titleTF = var_1.Find(var_4_1, "title/Text")

	local var_4_2 = arg_4_0.topUI

	arg_4_0.helpBtn = var_1.Find(var_4_2, "help")

	local var_4_3 = arg_4_0.topUI
	local var_4_4 = var_1.Find(var_4_3, "day/Text")
	local var_4_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_4_0.dayTxt = var_4_5(var_4_4, var_4(var_1_10006))

	local var_4_6 = arg_4_0._tf

	arg_4_0.phaseTF = var_1.Find(var_4_6, "frame/phase")

	local var_4_7 = arg_4_0._tf

	arg_4_0.frame = var_1.Find(var_4_7, "frame")

	local var_4_8 = arg_4_0._tf

	arg_4_0.btnPay = var_1.Find(var_4_8, "frame/phase/btn_pay")

	local var_4_9 = arg_4_0.frame

	arg_4_0.item = var_1.Find(var_4_9, "phase/award/tpl")

	local var_4_10 = arg_4_0.frame

	arg_4_0.items = var_1.Find(var_4_10, "phase/award")
	UIItemList = var_1
	arg_4_0.itemList = var_1.New(arg_4_0.items, arg_4_0.item)
	setActive = var_1

	var_1(arg_4_0.item, false)

	setText = var_1

	local var_4_11 = arg_4_0.frame
	local var_4_12 = var_3.Find(var_4_11, "toggles/award/selected/Text")

	i18n = var_4

	var_1(var_4_12, var_4(arg_4_0.rewardTip))

	setText = var_1

	local var_4_13 = arg_4_0.frame
	local var_4_14 = var_3.Find(var_4_13, "toggles/award/unselected/Text")

	i18n = var_4

	var_1(var_4_14, var_4(arg_4_0.rewardTip))

	setText = var_1

	local var_4_15 = arg_4_0.frame
	local var_4_16 = var_3.Find(var_4_15, "toggles/task/selected/Text")

	i18n = var_4

	var_1(var_4_16, var_4(arg_4_0.missionTip))

	setText = var_1

	local var_4_17 = arg_4_0.frame
	local var_4_18 = var_3.Find(var_4_17, "toggles/task/unselected/Text")

	i18n = var_4

	var_1(var_4_18, var_4(arg_4_0.missionTip))

	local var_4_19 = {}
	local var_4_20 = var_0_1.PAGE_AWARD
	local var_4_21 = arg_4_0.awardPageCls.New
	local var_4_22 = arg_4_0._tf

	var_4_19[var_4_20] = var_4_21(var_5.Find(var_4_22, "frame/award_container"), arg_4_0.event, arg_4_0.contextData)

	local var_4_23 = var_0_1.PAGE_TASK
	local var_4_24 = arg_4_0.taskPageCls.New
	local var_4_25 = arg_4_0._tf

	var_4_19[var_4_23] = var_4_24(var_5.Find(var_4_25, "frame/task_container"), arg_4_0.event, arg_4_0.contextData)
	arg_4_0.pages = var_4_19

	local var_4_26 = arg_4_0._tf

	arg_4_0.togglesTF = var_1.Find(var_4_26, "frame/toggles")
	eachChild = var_1

	var_1(arg_4_0.togglesTF, function(arg_5_0)
		onButton = var_2_10001

		local var_5_0 = arg_4_0
		local var_5_1 = arg_5_0

		local function var_5_2()
			arg_4_0.contextData.page = arg_5_0.name

			local var_6_0 = arg_4_0

			var_0.SwitchPage(var_6_0)

			return
		end

		SFX_PANEL = var_2_10006

		var_2_10001(var_5_0, var_5_1, var_5_2, var_2_10006)

		return
	end)

	arg_4_0.contextData.windowForCharge = arg_4_0.chargePageCls.New(arg_4_0._tf, arg_4_0.event)

	return
end

function var_0_1.didEnter(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.topUI
	local var_7_2 = var_4.Find(var_7_1, "title/back")

	local function var_7_3()
		local var_8_0 = arg_7_0

		var_0.closeView(var_8_0)

		return
	end

	SFX_CANCEL = var_7_1

	var_1_10001(var_7_0, var_7_2, var_7_3, var_7_1)

	onButton = var_1_10001

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_0.helpBtn

	local function var_7_6()
		pg = var_2_10000

		local var_9_0 = var_2_10000.NewStyleMsgboxMgr.GetInstance()
		local var_9_1 = var_0.Show

		pg = var_2_10003

		local var_9_2 = var_2_10003.NewStyleMsgboxMgr.TYPE_COMMON_HELP
		local var_9_3 = {}

		i18n = var_2_10005
		var_9_3.helps = var_2_10005(arg_7_0.helpBtnTip)

		var_9_1(var_9_0, var_9_2, var_9_3)

		return
	end

	SFX_PANEL = var_7_1

	var_1_10001(var_7_4, var_7_5, var_7_6, var_7_1)

	onButton = var_1_10001

	local var_7_7 = arg_7_0
	local var_7_8 = arg_7_0.btnPay

	local function var_7_9()
		local var_10_0 = arg_7_0.contextData.windowForCharge

		var_0.ExecuteAction(var_10_0, "ShowBuyWindow")

		return
	end

	SFX_CONFIRM = var_7_1

	var_1_10001(var_7_7, var_7_8, var_7_9, var_7_1)

	local var_7_10 = arg_7_0.activity.stopTime

	pg = var_1_10002

	local var_7_11 = var_1_10002.TimeMgr.GetInstance()
	local var_7_12 = var_7_10 - var_2.GetServerTime(var_7_11)
	local var_7_13 = arg_7_0.dayTxt

	i18n = var_7_7

	local var_7_14 = var_7_7(arg_7_0.dayTextTip)

	i18n = var_7_11

	local var_7_15 = "battlepass_main_time"

	math = var_7

	local var_7_16 = var_7.floor(var_7_12 / 0)

	math = var_1_10008
	var_7_13.text = var_7_14 .. var_7_11(var_7_15, var_7_16, var_1_10008.floor(var_7_12 % 0 / 16))

	arg_7_0:UpdatePhase()
	arg_7_0:UpdateAwardTip()

	triggerButton = var_2

	local var_7_17 = arg_7_0.togglesTF
	local var_7_18 = var_4.Find
	local var_7_19

	if not arg_7_0.contextData.page then
		var_7_19 = var_0_2
	end

	var_2(var_7_18(var_7_17, var_7_19))
	arg_7_0:SetAward()

	return
end

function var_0_1.SetAward(arg_11_0)
	local var_11_0 = arg_11_0.activity

	arg_11_0.config_client = var_1.getConfig(var_11_0, "config_client")[2]
	getProxy = var_1
	TaskProxy = var_11_0
	arg_11_0.taskProxy = var_1(var_11_0)

	local var_11_1 = arg_11_0.itemList

	var_1.make(var_11_1, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventInit then
			local var_12_0 = arg_12_2
			local var_12_1 = arg_12_2.Find(var_12_0, "item")

			Drop = var_2_10004

			local var_12_2 = var_2_10004.Create({
				arg_11_0.config_client[arg_12_1 + 1][1],
				arg_11_0.config_client[arg_12_1 + 1][2],
				arg_11_0.config_client[arg_12_1 + 1][3]
			})

			updateDrop = var_12_0

			var_12_0(var_12_1, var_12_2)

			onButton = var_12_0

			local var_12_3 = arg_11_0
			local var_12_4 = arg_12_2

			local function var_12_5()
				local var_13_0 = arg_11_0
				local var_13_1 = var_0.emit

				BaseUI = var_3_10003

				var_13_1(var_13_0, var_3_10003.ON_NEW_STYLE_DROP, {
					drop = var_12_2
				})

				return
			end

			SFX_PANEL = var_2_10010

			var_12_0(var_12_3, var_12_4, var_12_5, var_2_10010)
		end

		return
	end)

	local var_11_2 = arg_11_0.itemList

	var_1.align(var_11_2, #arg_11_0.config_client)

	return
end

function var_0_1.UpdatePhase(arg_14_0)
	setText = var_1_10001

	local var_14_0 = arg_14_0.phaseTF

	var_1_10001(var_3.Find(var_14_0, "Text"), arg_14_0.phase)

	local var_14_4

	if arg_14_0.phase < #arg_14_0.awardList then
		local var_14_1 = arg_14_0.phase == 0 and 0 or arg_14_0.awardList[arg_14_0.phase].pt
		local var_14_2 = arg_14_0.pt - var_14_1
		local var_14_3 = arg_14_0.awardList[arg_14_0.phase + 1].pt - var_14_1

		var_14_4 = arg_14_0.phaseTF
		var_14_4 = var_4.Find(var_14_4, "slider")

		local var_14_5 = var_4.GetComponent

		typeof = var_7
		Image = var_1_10009

		local var_14_6 = var_14_5(var_14_4, var_7(var_1_10009))

		var_14_6.fillAmount = var_14_2 / var_14_3
		setText = var_14_6

		local var_14_7 = arg_14_0.phaseTF

		var_14_6(var_14_4.Find(var_14_7, "progress/progress1"), var_14_2)

		setText = var_14_6

		local var_14_8 = arg_14_0.phaseTF

		var_14_6(var_14_4.Find(var_14_8, "progress/progress2"), "/" .. var_14_3)
	else
		local var_14_9 = arg_14_0.phaseTF
		local var_14_10 = var_1.Find(var_14_9, "slider")
		local var_14_11 = var_1.GetComponent

		typeof = var_4
		Image = var_14_4

		local var_14_12 = var_14_11(var_14_10, var_4(var_14_4))

		var_14_12.fillAmount = 1
		setText = var_14_12
		var_14_0 = arg_14_0.phaseTF

		var_14_12(var_3.Find(var_14_0, "progress/progress1"), "MAX")

		setActive = var_14_12
		var_14_0 = arg_14_0.phaseTF

		var_14_12(var_3.Find(var_14_0, "progress/progress2"), false)
	end

	local var_14_13 = arg_14_0.contextData

	var_14_13.phase = arg_14_0.phase
	setActive = var_14_13

	var_14_13(arg_14_0.btnPay, not arg_14_0.isPay)

	local var_14_14, var_14_15

	if not arg_14_0.isPay then
		var_14_14 = arg_14_0.chargePageCls.GetPassID()
		pg = var_2
		var_14_15 = var_2.TimeMgr.GetInstance()

		local var_14_16 = var_2.inTime

		pg = var_14_0

		if not var_14_16(var_14_15, var_14_0.pay_data_display[var_14_14].time) then
			setActive = var_3

			var_3(arg_14_0.btnPay, false)
		end
	end

	setText = var_14_14

	local var_14_17 = arg_14_0.titleTF

	i18n = var_14_15

	var_14_14(var_14_17, var_14_15(arg_14_0.titleTextTip))

	return
end

function var_0_1.OnChargeSuccess(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.contextData.windowForCharge

	var_2.ExecuteAction(var_15_0, "ShowUnlockWindow", arg_15_1)

	return
end

function var_0_1.UpdateAwardTip(arg_16_0)
	setActive = var_1_10001

	local var_16_0 = arg_16_0.togglesTF
	local var_16_1 = var_3.Find(var_16_0, "award/tip")
	local var_16_2 = arg_16_0.activity

	var_1_10001(var_16_1, #var_4.GetHei5UnreceiveAward(var_16_2) > 0)

	return
end

function var_0_1.SwitchPage(arg_17_0)
	pairs = var_1_10001

	for iter_17_0, iter_17_1 in var_1_10001(arg_17_0.pages) do
		if iter_17_0 == arg_17_0.contextData.page then
			iter_17_1:ExecuteAction("Flush")
		else
			iter_17_1:ExecuteAction("Hide")
		end
	end

	eachChild = var_1

	var_1(arg_17_0.togglesTF, function(arg_18_0)
		setActive = var_2_10001

		var_2_10001(arg_18_0:Find("unselected"), arg_18_0.name ~= arg_17_0.contextData.page)

		setActive = var_2_10001

		var_2_10001(arg_18_0:Find("selected"), arg_18_0.name == arg_17_0.contextData.page)

		return
	end)

	local var_17_0

	var_17_0 = arg_17_0.contextData.page == var_0_1.PAGE_SHOP

	return
end

function var_0_1.UpdateView(arg_19_0)
	local var_19_0 = arg_19_0.pages[arg_19_0.contextData.page]

	var_1.ExecuteAction(var_19_0, "Flush")

	return
end

function var_0_1.UpdateAwardPage(arg_20_0)
	arg_20_0:UpdateAwardTip()

	local var_20_0 = arg_20_0.pages[var_0_1.PAGE_AWARD]

	var_1.ExecuteAction(var_20_0, "UpdateActivity", arg_20_0.activity)

	return
end

function var_0_1.UpdateTaskPage(arg_21_0)
	local var_21_0 = arg_21_0.pages[var_0_1.PAGE_TASK]

	var_1.ExecuteAction(var_21_0, "UpdateActivity", arg_21_0.activity)

	return
end

function var_0_1.onBackPressed(arg_22_0)
	if arg_22_0.contextData.windowForCharge then
		local var_22_0 = arg_22_0.contextData.windowForCharge

		if var_1.GetLoaded(var_22_0) then
			local var_22_1 = arg_22_0.contextData.windowForCharge

			if var_1.isShowing(var_22_1) then
				local var_22_2 = arg_22_0.contextData.windowForCharge

				var_1.Hide(var_22_2)

				return
			end
		end
	end

	var_0_1.super.onBackPressed(arg_22_0)

	return
end

function var_0_1.willExit(arg_23_0)
	return
end

return var_0_1
