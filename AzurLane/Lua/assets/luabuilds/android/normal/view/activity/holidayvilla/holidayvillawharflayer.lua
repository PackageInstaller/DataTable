class = var_0_10000

local var_0_0 = "HolidayVillaWharfLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

pg = var_0_0

local var_0_2 = var_0_0.activity_holiday_trans

function var_0_1.getUIName(arg_1_0)
	return "HolidayVillaWharfUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_0, "bg")

	local var_2_1 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_1, "closeBtn")

	local var_2_2 = arg_2_0._tf

	arg_2_0.res = var_1.Find(var_2_2, "res")

	local var_2_3 = arg_2_0._tf

	arg_2_0.wharfResCount = var_1.Find(var_2_3, "frame/resNum")

	local var_2_4 = arg_2_0._tf

	arg_2_0.transportList = var_1.Find(var_2_4, "frame/transportList")

	local var_2_5 = arg_2_0._tf

	arg_2_0.transportCompletePage = var_1.Find(var_2_5, "transportCompletePage")
	setText = var_1

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_2.Find(var_2_6, "frame/nameBg/name")

	i18n = var_2_6

	var_1(var_2_7, var_2_6("holiday_tip_trans_tip"))

	setText = var_1

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_2.Find(var_2_8, "frame/resDesc")

	i18n = var_2_8

	var_1(var_2_9, var_2_8("holiday_tip_trans_get"))

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:InitData()
	arg_3_0:RefreshData()

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.bg

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_3, var_3_4, var_3_5, var_1_10005)
	arg_3_0:Show()

	setActive = var_1

	var_1(arg_3_0.transportCompletePage, false)

	pg = var_1

	local var_3_6 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_6, arg_3_0._tf)

	return
end

function var_0_1.InitData(arg_6_0)
	ActivityConst = var_1_10001
	arg_6_0.activityId = var_1_10001.HOLIDAY_ACT_ID
	ActivityConst = var_1
	arg_6_0.taskActivityId = var_1.HOLIDAY_TASK_ID
	getProxy = var_1
	ActivityProxy = var_1_10002
	arg_6_0.activityProxy = var_1(var_1_10002)
	getProxy = var_1
	TaskProxy = var_1_10002
	arg_6_0.taskProxy = var_1(var_1_10002)

	local var_6_0 = arg_6_0.activityProxy

	arg_6_0.activity = var_1.getActivityById(var_6_0, arg_6_0.activityId)

	local var_6_1 = arg_6_0.activity

	arg_6_0.transTaskIds = var_1.getConfig(var_6_1, "config_client").task_trans

	return
end

function var_0_1.RefreshData(arg_7_0)
	local var_7_0 = arg_7_0.activityProxy

	arg_7_0.activity = var_1.getActivityById(var_7_0, arg_7_0.activityId)

	return
end

function var_0_1.Show(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = {
		66001
	}
	local var_8_2 = arg_8_0.activity

	var_8_1[2] = var_3.getVitemNumber(var_8_2, 66001)
	var_8_0[1] = var_8_1

	local var_8_3 = {
		66002
	}
	local var_8_4 = arg_8_0.activity

	var_8_3[2] = var_3.getVitemNumber(var_8_4, 66002)
	var_8_0[2] = var_8_3

	local var_8_5 = {
		66003
	}
	local var_8_6 = arg_8_0.activity

	var_8_5[2] = var_3.getVitemNumber(var_8_6, 66003)
	var_8_0[3] = var_8_5

	local var_8_7 = {
		66004
	}
	local var_8_8 = arg_8_0.activity

	var_8_7[2] = var_3.getVitemNumber(var_8_8, 66004)
	var_8_0[4] = var_8_7

	arg_8_0:SetRes(arg_8_0.res, var_8_0)

	setText = var_2

	local var_8_9 = arg_8_0.wharfResCount
	local var_8_10 = arg_8_0.activity

	var_2(var_8_9, var_4.getVitemNumber(var_8_10, 66006))

	local var_8_11 = true

	ipairs = var_8_9

	for iter_8_0, iter_8_1 in var_8_9(arg_8_0.transTaskIds) do
		local var_8_12 = arg_8_0.taskProxy

		if not var_8.getFinishTaskById(var_8_12, iter_8_1) then
			var_8_11 = false

			break
		end
	end

	if not var_8_11 then
		setText = var_3

		local var_8_13 = arg_8_0._tf
		local var_8_14 = var_4.Find(var_8_13, "frame/desc")

		i18n = var_8_13

		var_3(var_8_14, var_8_13("holiday_tip_trans_desc1"))
		arg_8_0:SetTransList(1)
	else
		setText = var_3

		local var_8_15 = arg_8_0._tf
		local var_8_16 = var_4.Find(var_8_15, "frame/desc")

		i18n = var_8_15

		var_3(var_8_16, var_8_15("holiday_tip_trans_desc2"))
		arg_8_0:SetTransList(2)
	end

	return
end

function var_0_1.SetTransList(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.transportList
	local var_9_1 = var_2.Find(var_9_0, "smallTransport")
	local var_9_2 = arg_9_0.transportList
	local var_9_3 = var_3.Find(var_9_2, "middleTransport")
	local var_9_4 = arg_9_0.transportList
	local var_9_5 = var_4.Find(var_9_4, "bigTransport")
	local var_9_6 = arg_9_0.transportList
	local var_9_7 = var_5.Find(var_9_6, "touristTransport")

	setActive = var_9_6

	var_9_6(var_9_1, arg_9_1 == 1)

	setActive = var_9_6

	var_9_6(var_9_3, arg_9_1 == 1)

	setActive = var_9_6

	var_9_6(var_9_5, arg_9_1 == 1)

	setActive = var_9_6

	var_9_6(var_9_7, arg_9_1 == 2)

	if arg_9_1 == 1 then
		arg_9_0:SetTransport(var_9_1, var_0_2[1])
		arg_9_0:SetTransport(var_9_3, var_0_2[2])
		arg_9_0:SetTransport(var_9_5, var_0_2[3])
	elseif arg_9_1 == 2 then
		arg_9_0:SetTransport(var_9_7, var_0_2[4])
	end

	return
end

function var_0_1.SetTransport(arg_10_0, arg_10_1, arg_10_2)
	setText = var_1_10003

	var_1_10003(arg_10_1:Find("name"), arg_10_2.name)

	LoadImageSpriteAsync = var_1_10003

	var_1_10003(arg_10_2.icon, arg_10_1:Find("picture"))

	local var_10_0 = arg_10_0.taskProxy
	local var_10_1 = var_3.getTaskById(var_10_0, arg_10_2.cost_task_id)
	local var_10_2 = var_3.getConfig(var_10_1, "target_id_2")[1][2]

	setText = var_10_1

	var_10_1(arg_10_1:Find("resConsume"), var_10_2)

	Clone = var_10_1

	local var_10_3 = var_10_1(arg_10_2.award)

	ipairs = var_6

	for iter_10_0, iter_10_1 in var_6(var_10_3) do
		table = var_1_10011

		var_1_10011.remove(iter_10_1, 1)
	end

	arg_10_0:SetRes(arg_10_1:Find("awards"), var_10_3)

	onButton = var_6

	local var_10_4 = arg_10_0
	local var_10_5 = arg_10_1

	local function var_10_6()
		local var_11_0 = arg_10_0.activity

		if var_0.getVitemNumber(var_11_0, 66006) < var_10_2 then
			pg = var_1

			local var_11_1 = var_1.TipsMgr.GetInstance()
			local var_11_2 = var_1.ShowTips

			i18n = var_2_10003

			var_11_2(var_11_1, var_2_10003("holiday_tip_trans_not"))

			return
		end

		arg_10_0.doingTransCfg = arg_10_2

		local var_11_3 = arg_10_0
		local var_11_4 = var_1.emit

		HolidayVillaWharfMediator = var_2_10003

		var_11_4(var_11_3, var_2_10003.ON_TASK_SUBMIT_ONESTEP, arg_10_0.taskActivityId, {
			arg_10_2.cost_task_id
		})

		return
	end

	SFX_PANEL = var_10

	var_6(var_10_4, var_10_5, var_10_6, var_10)

	return
end

function var_0_1.SetRes(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0 = 0, arg_12_1.childCount - 1 do
		setActive = var_1_10007

		var_1_10007(arg_12_1:GetChild(iter_12_0), false)
	end

	ipairs = var_3

	for iter_12_1, iter_12_2 in var_3(arg_12_2) do
		local var_12_0 = iter_12_2[1]
		local var_12_1 = iter_12_2[2]

		for iter_12_3 = 0, arg_12_1.childCount - 1 do
			local var_12_2 = arg_12_1:GetChild(iter_12_3).name

			tostring = var_16

			if var_12_2 == var_16(var_12_0) then
				setActive = var_12_2

				var_12_2(var_14, true)

				setText = var_12_2

				var_12_2(var_14:Find("Text"), var_12_1)
			end
		end
	end

	return
end

function var_0_1.ShowCompletePage(arg_13_0)
	setActive = var_1_10001

	var_1_10001(arg_13_0.transportCompletePage, true)

	pg = var_1_10001

	local var_13_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_13_0, arg_13_0.transportCompletePage)

	SetAction = var_1

	local var_13_1 = arg_13_0.transportCompletePage

	var_1(var_2.Find(var_13_1, "ani"), "normal" .. arg_13_0.doingTransCfg.id, false)

	setText = var_1

	local var_13_2 = arg_13_0.transportCompletePage

	var_1(var_2.Find(var_13_2, "desc/Text"), arg_13_0.doingTransCfg.result_desc)

	setActive = var_1

	local var_13_3 = arg_13_0.transportCompletePage

	var_1(var_2.Find(var_13_3, "desc/triangle"), false)

	GetOrAddComponent = var_1

	local var_13_4 = arg_13_0.transportCompletePage
	local var_13_5 = var_2.Find(var_13_4, "desc/Text")

	typeof = var_13_4
	Typewriter = var_4

	local var_13_6 = var_1(var_13_5, var_13_4(var_4))

	var_1.setSpeed(var_13_6, 0.05)

	function var_1.endFunc()
		setActive = var_2_10000

		local var_14_0 = arg_13_0.transportCompletePage

		var_2_10000(var_1.Find(var_14_0, "desc/triangle"), true)

		return
	end

	var_1:Play()

	onButton = var_2

	local var_13_7 = arg_13_0
	local var_13_8 = arg_13_0.transportCompletePage
	local var_13_9 = var_4.Find(var_13_8, "bg")

	local function var_13_10()
		setActive = var_2_10000

		var_2_10000(arg_13_0.transportCompletePage, false)

		pg = var_2_10000

		local var_15_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_15_0, arg_13_0.transportCompletePage, arg_13_0._tf)

		if not arg_13_0.hasShowedAwards and #arg_13_0.awards > 0 then
			arg_13_0.hasShowedAwards = true

			local var_15_1 = arg_13_0
			local var_15_2 = var_0.emit

			BaseUI = var_2

			var_15_2(var_15_1, var_2.ON_ACHIEVE, arg_13_0.awards)
		end

		return
	end

	SFX_CANCEL = var_6

	var_2(var_13_7, var_13_9, var_13_10, var_6)

	onButton = var_2

	local var_13_11 = arg_13_0
	local var_13_12 = arg_13_0.transportCompletePage
	local var_13_13 = var_4.Find(var_13_12, "desc")

	local function var_13_14()
		setActive = var_2_10000

		var_2_10000(arg_13_0.transportCompletePage, false)

		pg = var_2_10000

		local var_16_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_16_0, arg_13_0.transportCompletePage, arg_13_0._tf)

		if not arg_13_0.hasShowedAwards and #arg_13_0.awards > 0 then
			arg_13_0.hasShowedAwards = true

			local var_16_1 = arg_13_0
			local var_16_2 = var_0.emit

			BaseUI = var_2

			var_16_2(var_16_1, var_2.ON_ACHIEVE, arg_13_0.awards)
		end

		return
	end

	SFX_CANCEL = var_6

	var_2(var_13_11, var_13_13, var_13_14, var_6)

	return
end

function var_0_1.SetAwardsShow(arg_17_0, arg_17_1)
	arg_17_0.awards = arg_17_1
	arg_17_0.hasShowedAwards = false

	return
end

function var_0_1.willExit(arg_18_0)
	pg = var_1_10001

	local var_18_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_18_0, arg_18_0._tf, arg_18_0._parentTf)

	return
end

function var_0_1.onBackPressed(arg_19_0)
	isActive = var_1_10001

	if var_1_10001(arg_19_0.transportCompletePage) then
		setActive = var_1

		var_1(arg_19_0.transportCompletePage, false)

		pg = var_1

		local var_19_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_19_0, arg_19_0.transportCompletePage, arg_19_0._tf)

		if not arg_19_0.hasShowedAwards and #arg_19_0.awards > 0 then
			arg_19_0.hasShowedAwards = true

			local var_19_1 = arg_19_0
			local var_19_2 = arg_19_0.emit

			BaseUI = var_3

			var_19_2(var_19_1, var_3.ON_ACHIEVE, arg_19_0.awards)
		end

		return
	end

	arg_19_0:closeView()

	return
end

return var_0_1
