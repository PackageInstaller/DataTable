class = var_0_10000

local var_0_0 = "NewNavalTacticsShipCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NewNavalTacticsBaseCard"))

function var_0_1.OnInit(arg_1_0)
	findTF = var_1_10001

	local var_1_0 = var_1_10001(arg_1_0._tf, "skill/name_Text")
	local var_1_1 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.skillNameTxt = var_1_1(var_1_0, var_3(var_1_10004))
	findTF = var_1

	local var_1_2 = var_1(arg_1_0._tf, "skill/icon")
	local var_1_3 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_1_0.skillIcon = var_1_3(var_1_2, var_3(var_1_10004))
	findTF = var_1

	local var_1_4 = var_1(arg_1_0._tf, "skill/exp")
	local var_1_5 = var_1.GetComponent

	typeof = var_3
	Slider = var_1_10004
	arg_1_0.skillExpSlider = var_1_5(var_1_4, var_3(var_1_10004))
	findTF = var_1

	local var_1_6 = var_1(arg_1_0._tf, "skill/level")
	local var_1_7 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.skillLevelTxt = var_1_7(var_1_6, var_3(var_1_10004))
	findTF = var_1

	local var_1_8 = var_1(arg_1_0._tf, "skill/next")
	local var_1_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.skillNextExp = var_1_9(var_1_8, var_3(var_1_10004))
	findTF = var_1

	local var_1_10 = var_1(arg_1_0._tf, "timer_Text")
	local var_1_11 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.timeTxt = var_1_11(var_1_10, var_3(var_1_10004))
	findTF = var_1
	arg_1_0.cancelBtn = var_1(arg_1_0._tf, "cancel_btn")
	findTF = var_1
	arg_1_0.quickFinishBtn = var_1(arg_1_0._tf, "quick_finish_btn")
	onButton = var_1

	local var_1_12 = arg_1_0
	local var_1_13 = arg_1_0.cancelBtn

	local function var_1_14()
		pg = var_2_10000

		local var_2_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_2_1 = var_0.ShowMsgBox
		local var_2_2 = {}

		i18n = var_2_10003
		var_2_2.content = var_2_10003("tactics_lesson_cancel")

		function var_2_2.onYes()
			local var_3_0 = arg_1_0

			var_0.OnCancel(var_3_0)

			return
		end

		var_2_1(var_2_0, var_2_2)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_1_12, var_1_13, var_1_14, var_1_10005)

	onButton = var_1

	local var_1_15 = arg_1_0

	findTF = var_1_13

	local var_1_16 = var_1_13(arg_1_0._tf, "skill")

	local function var_1_17()
		local var_4_0 = arg_1_0
		local var_4_1 = var_0.emit

		NewNavalTacticsMediator = var_2_10002

		local var_4_2 = var_2_10002.ON_SKILL
		local var_4_3 = arg_1_0.skillVO

		var_4_1(var_4_0, var_4_2, var_3.GetDisplayId(var_4_3), arg_1_0.skillVO)

		return
	end

	SFX_PANEL = var_5

	var_1(var_1_15, var_1_16, var_1_17, var_5)

	onButton = var_1

	local var_1_18 = arg_1_0
	local var_1_19 = arg_1_0.quickFinishBtn

	local function var_1_20()
		local var_5_0 = arg_1_0
		local var_5_1 = var_0.emit

		NewNavalTacticsMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.ON_QUICK_FINISH, arg_1_0.student.id)

		return
	end

	SFX_PANEL = var_5

	var_1(var_1_18, var_1_19, var_1_20, var_5)

	return
end

function var_0_1.LoadShipCard(arg_6_0)
	ResourceMgr = var_1_10001

	local var_6_0 = var_1_10001.Inst
	local var_6_1 = var_1.getAssetAsync
	local var_6_2 = "template/shipcardtpl"
	local var_6_3 = ""

	UnityEngine = var_1_10005

	var_6_1(var_6_0, var_6_2, var_6_3, var_1_10005.Events.UnityAction_UnityEngine_Object(function(arg_7_0)
		Object = var_2_10001

		local var_7_0 = var_2_10001.Instantiate(arg_7_0, arg_6_0._tf).transform

		Vector3 = var_3
		var_7_0.localScale = var_3(1.28, 1.28, 1)

		local var_7_1 = var_1.transform

		Vector3 = var_3
		var_7_1.localPosition = var_3(0, 251, 0)

		local var_7_2 = arg_6_0

		DockyardShipItem = var_3

		local var_7_3 = var_3.New
		local var_7_4 = var_1

		ShipStatus = var_5
		var_7_2.shipCard = var_7_3(var_7_4, var_5.TAG_HIDE_ALL)

		local var_7_5 = arg_6_0

		var_2.UpdateShipCard(var_7_5)

		return
	end), true, true)

	return
end

function var_0_1.OnUpdate(arg_8_0, arg_8_1)
	arg_8_0.student = arg_8_1
	getProxy = var_1_10002
	BayProxy = var_1_10003

	local var_8_0 = var_1_10002(var_1_10003)

	arg_8_0.ship = var_2.RawGetShipById(var_8_0, arg_8_0.student.shipId)

	local var_8_1 = arg_8_0.student
	local var_8_2 = var_2.getSkillId(var_8_1, arg_8_0.ship)

	ShipSkill = var_8_1
	arg_8_0.skillVO = var_8_1.New(arg_8_0.ship.skills[var_8_2], arg_8_0.ship.id)

	arg_8_0:UpdateSkill()

	if not arg_8_0.shipCard then
		arg_8_0:LoadShipCard()
	else
		arg_8_0:UpdateShipCard()
	end

	arg_8_0:AddTimer()

	setActive = var_3

	local var_8_3 = arg_8_0.quickFinishBtn

	getProxy = var_5
	NavalAcademyProxy = var_1_10006

	local var_8_4 = var_5(var_1_10006)

	var_3(var_8_3, var_5.getDailyFinishCnt(var_8_4) > 0)

	return
end

function var_0_1.UpdateSkill(arg_9_0)
	local var_9_0 = arg_9_0.ship
	local var_9_1 = arg_9_0.student
	local var_9_2 = arg_9_0.skillVO
	local var_9_3 = arg_9_0.skillNameTxt

	shortenString = var_1_10005
	var_9_3.text = var_1_10005(var_9_2:GetName(), 8)

	local var_9_4 = arg_9_0.skillLevelTxt

	var_9_4.text = var_9_2.level
	LoadSpriteAsync = var_9_4

	var_9_4("skillicon/" .. var_9_2:GetIcon(), function(arg_10_0)
		arg_9_0.skillIcon.sprite = arg_10_0

		return
	end)

	if var_9_2:IsMaxLevel() then
		arg_9_0.skillNextExp.text = "MAX"
		arg_9_0.skillExpSlider.value = 1
	else
		local var_9_5 = var_9_2:GetNextLevelExp()

		arg_9_0.skillNextExp.text = var_9_2.exp .. "/" .. var_9_5
		arg_9_0.skillExpSlider.value = var_9_2.exp / var_9_5
	end

	return
end

function var_0_1.AddTimer(arg_11_0)
	arg_11_0:RemoveTimer()

	local var_11_0 = arg_11_0.student
	local var_11_1 = var_1.getFinishTime(var_11_0)

	Timer = var_11_0
	arg_11_0.timer = var_11_0.New(function()
		local var_12_0 = var_11_1

		pg = var_2_10001

		local var_12_1 = var_2_10001.TimeMgr.GetInstance()

		if var_12_0 - var_1.GetServerTime(var_12_1) < 0 then
			var_12_1 = arg_11_0

			var_1.OnFinish(var_12_1)
		else
			local var_12_2 = arg_11_0.timeTxt

			pg = var_12_1

			local var_12_3 = var_12_1.TimeMgr.GetInstance()

			var_12_2.text = var_2.DescCDTime(var_12_3, var_0)
		end

		return
	end, 1, -1)

	local var_11_2 = arg_11_0.timer

	var_3.Start(var_11_2)
	arg_11_0.timer.func()

	return
end

function var_0_1.OnFinish(arg_13_0)
	arg_13_0:RemoveTimer()

	arg_13_0.timeTxt.text = ""

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.emit

	NewNavalTacticsMediator = var_1_10003

	local var_13_2 = var_1_10003.ON_CANCEL
	local var_13_3 = arg_13_0.student.id

	Student = var_1_10005

	var_13_1(var_13_0, var_13_2, var_13_3, var_1_10005.CANCEL_TYPE_AUTO)

	return
end

function var_0_1.OnCancel(arg_14_0)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.emit

	NewNavalTacticsMediator = var_1_10003

	local var_14_2 = var_1_10003.ON_CANCEL
	local var_14_3 = arg_14_0.student.id

	Student = var_1_10005

	var_14_1(var_14_0, var_14_2, var_14_3, var_1_10005.CANCEL_TYPE_MANUAL)

	return
end

function var_0_1.RemoveTimer(arg_15_0)
	if arg_15_0.timer then
		local var_15_0 = arg_15_0.timer

		var_1.Stop(var_15_0)

		arg_15_0.timer = nil
	end

	return
end

function var_0_1.UpdateShipCard(arg_16_0)
	if arg_16_0.ship.id == arg_16_0.shipID then
		return
	end

	local var_16_0 = arg_16_0.shipCard

	var_1.update(var_16_0, arg_16_0.ship)

	arg_16_0.shipID = arg_16_0.ship.id

	return
end

function var_0_1.OnDispose(arg_17_0)
	arg_17_0:RemoveTimer()

	LeanTween = var_1

	if var_1.isTweening(arg_17_0.skillExpSlider.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_17_0.skillExpSlider.gameObject)
	end

	LeanTween = var_1

	if var_1.isTweening(arg_17_0.skillNextExp.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_17_0.skillNextExp.gameObject)
	end

	return
end

function var_0_1.DoAddExpAnim(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_2.level - arg_18_1.level > 0 then
		arg_18_0:DoLevelUpAnim(arg_18_1, arg_18_2, arg_18_3)
	else
		arg_18_0:DoUnLevelUpAnim(arg_18_1, arg_18_2, arg_18_3)
	end

	return
end

function var_0_1.DoLevelUpAnim(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_20_0)
			local var_20_0 = arg_19_0

			var_1.Curr2One(var_20_0, arg_19_1, arg_20_0)

			return
		end,
		function(arg_21_0)
			local var_21_0 = arg_19_0

			var_1.Zero2One(var_21_0, arg_19_1, arg_19_2, arg_21_0)

			return
		end,
		function(arg_22_0)
			local var_22_0 = arg_19_0

			var_1.Zero2New(var_22_0, arg_19_2, arg_22_0)

			return
		end
	}, arg_19_3)

	return
end

function var_0_1.Curr2One(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1:GetNextLevelExp()
	local var_23_1 = 1 - arg_23_1.exp / var_23_0

	LeanTween = var_1_10006

	local var_23_2 = var_1_10006.value(arg_23_0.skillExpSlider.gameObject, var_4, 1, var_23_1)
	local var_23_3 = var_6.setOnUpdate

	System = var_8

	var_23_3(var_23_2, var_8.Action_float(function(arg_24_0)
		arg_23_0.skillExpSlider.value = arg_24_0

		return
	end))

	LeanTween = var_23_3

	local var_23_4 = var_23_3.value(arg_23_0.skillNextExp.gameObject, arg_23_1.exp, var_23_0, var_23_1 + 0.001)
	local var_23_5 = var_6.setOnUpdate

	System = var_8

	local var_23_6 = var_23_5(var_23_4, var_8.Action_float(function(arg_25_0)
		local var_25_0 = arg_23_0.skillNextExp

		math = var_2_10002
		var_25_0.text = var_2_10002.ceil(arg_25_0) .. "/" .. var_23_0

		return
	end))
	local var_23_7 = var_6.setOnComplete

	System = var_8

	var_23_7(var_23_6, var_8.Action(function()
		arg_23_0.skillLevelTxt.text = arg_23_1.level + 1

		arg_23_2()

		return
	end))

	return
end

function var_0_1.Zero2One(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if arg_27_1.level + 1 == arg_27_2.level then
		arg_27_3()

		return
	end

	local function var_27_0(arg_28_0)
		local var_28_0 = 0.3

		LeanTween = var_2_10002

		local var_28_1 = var_2_10002.value(arg_27_0.skillExpSlider.gameObject, 0, 1, var_28_0)
		local var_28_2 = var_2.setOnUpdate

		System = var_4

		var_28_2(var_28_1, var_4.Action_float(function(arg_29_0)
			arg_27_0.skillExpSlider.value = arg_29_0

			return
		end))

		ShipSkill = var_28_2

		local var_28_3 = var_28_2.StaticGetNextLevelExp(var_0)

		LeanTween = var_3

		local var_28_4 = var_3.value(arg_27_0.skillNextExp.gameObject, 0, var_28_3, var_28_0 + 0.001)
		local var_28_5 = var_3.setOnUpdate

		System = var_5

		local var_28_6 = var_28_5(var_28_4, var_5.Action_float(function(arg_30_0)
			local var_30_0 = arg_27_0.skillNextExp

			math = var_3_10002
			var_30_0.text = var_3_10002.ceil(arg_30_0) .. "/" .. var_28_3

			return
		end))
		local var_28_7 = var_3.setOnComplete

		System = var_5

		var_28_7(var_28_6, var_5.Action(function()
			arg_27_0.skillLevelTxt.text = var_0 + 1
			var_0 = var_0 + 1

			arg_28_0()

			return
		end))

		return
	end

	local var_27_1 = {}

	for iter_27_0 = 1, arg_27_2.level - arg_27_1.level - 1 do
		table = var_1_10011

		var_1_10011.insert(var_27_1, var_27_0)
	end

	seriesAsync = var_7

	var_7(var_27_1, arg_27_3)

	return
end

function var_0_1.Zero2New(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_1:GetNextLevelExp()

	if arg_32_1.exp / var_32_0 == 0 or arg_32_1:IsMaxLevel() then
		arg_32_2()

		return
	end

	LeanTween = var_1_10005

	local var_32_1 = var_1_10005.value(arg_32_0.skillExpSlider.gameObject, 0, var_4, var_4)
	local var_32_2 = var_5.setOnUpdate

	System = var_7

	var_32_2(var_32_1, var_7.Action_float(function(arg_33_0)
		arg_32_0.skillExpSlider.value = arg_33_0

		return
	end))

	LeanTween = var_32_2

	local var_32_3 = var_32_2.value(arg_32_0.skillNextExp.gameObject, 0, var_32_0, var_4 + 0.001)
	local var_32_4 = var_5.setOnUpdate

	System = var_7

	local var_32_5 = var_32_4(var_32_3, var_7.Action_float(function(arg_34_0)
		local var_34_0 = arg_32_0.skillNextExp

		math = var_2_10002
		var_34_0.text = var_2_10002.ceil(arg_34_0) .. "/" .. var_32_0

		return
	end))
	local var_32_6 = var_5.setOnComplete

	System = var_7

	var_32_6(var_32_5, var_7.Action(arg_32_2))

	return
end

function var_0_1.DoUnLevelUpAnim(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = arg_35_2:GetNextLevelExp()
	local var_35_1 = arg_35_1.exp / var_35_0
	local var_35_2 = arg_35_2.exp / var_35_0

	LeanTween = var_1_10007

	local var_35_3 = var_1_10007.value(arg_35_0.skillExpSlider.gameObject, var_35_1, var_35_2, 1)
	local var_35_4 = var_7.setOnUpdate

	System = var_9

	var_35_4(var_35_3, var_9.Action_float(function(arg_36_0)
		arg_35_0.skillExpSlider.value = arg_36_0

		return
	end))

	LeanTween = var_35_4

	local var_35_5 = var_35_4.value(arg_35_0.skillNextExp.gameObject, arg_35_1.exp, arg_35_2.exp, 1.001)
	local var_35_6 = var_7.setOnUpdate

	System = var_9

	local var_35_7 = var_35_6(var_35_5, var_9.Action_float(function(arg_37_0)
		local var_37_0 = arg_35_0.skillNextExp

		math = var_2_10002
		var_37_0.text = var_2_10002.ceil(arg_37_0) .. "/" .. var_35_0

		return
	end))
	local var_35_8 = var_7.setOnComplete

	System = var_9

	var_35_8(var_35_7, var_9.Action(arg_35_3))

	return
end

return var_0_1
