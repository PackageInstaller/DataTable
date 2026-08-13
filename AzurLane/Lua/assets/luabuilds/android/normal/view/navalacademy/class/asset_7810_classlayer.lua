class = var_0_10000

local var_0_0 = "ClassLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ClassUI"
end

function var_0_1.SetStudents(arg_2_0, arg_2_1)
	arg_2_0.shipGroups = arg_2_1

	return
end

function var_0_1.SetCourse(arg_3_0, arg_3_1)
	arg_3_0.course = arg_3_1

	return
end

function var_0_1.SetClass(arg_4_0, arg_4_1)
	arg_4_0.resClass = arg_4_1

	return
end

function var_0_1.OnUpdateResField(arg_5_0, arg_5_1)
	isa = var_1_10002

	local var_5_0 = arg_5_1

	ClassResourceField = var_1_10004

	if not var_1_10002(var_5_0, var_1_10004) then
		return
	end

	arg_5_0:SetClass(arg_5_1)
	arg_5_0:InitClassInfo()

	local var_5_1 = arg_5_0.resFieldPage

	if var_2.GetLoaded(var_5_1) then
		local var_5_2 = arg_5_0.resFieldPage

		if var_2.isShowing(var_5_2) then
			local var_5_3 = arg_5_0.resFieldPage

			var_2.Update(var_5_3, arg_5_1)
		end
	end

	return
end

function var_0_1.init(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.backBtn = var_1.Find(var_6_0, "blur_panel/adapt/top/back")

	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_1.Find(var_6_1, "blur_panel/adapt/bottom/lesson/mask/Text")

	arg_6_0.lessonTxt = var_1.GetComponent(var_6_2, "ScrollText")

	local var_6_3 = arg_6_0._tf
	local var_6_4 = var_1.Find(var_6_3, "blur_panel/adapt/bottom/progress/proficiency/value")
	local var_6_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.tranSpeedTxt = var_6_5(var_6_4, var_3(var_1_10004))

	local var_6_6 = arg_6_0._tf
	local var_6_7 = var_1.Find(var_6_6, "blur_panel/adapt/bottom/progress/proficiency/Text")
	local var_6_8 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.proficiencyProgressTxt = var_6_8(var_6_7, var_3(var_1_10004))

	local var_6_9 = arg_6_0._tf

	arg_6_0.proficiencyProgress = var_1.Find(var_6_9, "blur_panel/adapt/bottom/progress/proficiency/slider/Image")

	local var_6_10 = arg_6_0._tf
	local var_6_11 = var_1.Find(var_6_10, "blur_panel/adapt/bottom/progress/book/Text/value")
	local var_6_12 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.tranProgressTxt = var_6_12(var_6_11, var_3(var_1_10004))

	local var_6_13 = arg_6_0._tf

	arg_6_0.tranProgress = var_1.Find(var_6_13, "blur_panel/adapt/bottom/progress/book/slider/Image")

	local var_6_14 = arg_6_0._tf
	local var_6_15 = var_1.Find(var_6_14, "blur_panel/adapt/top/proficiency/Text")
	local var_6_16 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.exp2ProficiencyRatioTxt = var_6_16(var_6_15, var_3(var_1_10004))

	local var_6_17 = arg_6_0._tf

	arg_6_0.exp2ProficiencyRatio = var_1.Find(var_6_17, "blur_panel/adapt/top/proficiency")

	local var_6_18 = arg_6_0._tf

	arg_6_0.chatProficiency = var_1.Find(var_6_18, "blur_panel/adapt/top/proficiency/chat")

	local var_6_19 = arg_6_0.chatProficiency
	local var_6_20 = var_1.Find(var_6_19, "Text")
	local var_6_21 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.chatProficiencyTxt = var_6_21(var_6_20, var_3(var_1_10004))

	local var_6_22 = arg_6_0._tf

	arg_6_0.helpBtn = var_1.Find(var_6_22, "blur_panel/adapt/top/btn_help")

	local var_6_23 = arg_6_0._tf

	arg_6_0.upgradeBtn = var_1.Find(var_6_23, "blur_panel/adapt/bottom/upgarde")

	local var_6_24 = arg_6_0._tf

	arg_6_0.teacherSeat = var_1.Find(var_6_24, "scene/desk0")

	local var_6_25 = {}
	local var_6_26 = arg_6_0._tf

	var_6_25[1] = var_2.Find(var_6_26, "scene/desk1")

	local var_6_27 = arg_6_0._tf

	var_6_25[2] = var_2.Find(var_6_27, "scene/desk2")

	local var_6_28 = arg_6_0._tf

	var_6_25[3] = var_2.Find(var_6_28, "scene/desk3")

	local var_6_29 = arg_6_0._tf

	var_6_25[4] = var_2.Find(var_6_29, "scene/desk4")

	local var_6_30 = arg_6_0._tf

	var_6_25[5] = var_2.Find(var_6_30, "scene/desk5")
	arg_6_0.studentSeats = var_6_25
	setText = var_6_25

	local var_6_31 = arg_6_0._tf
	local var_6_32 = var_2.Find(var_6_31, "blur_panel/adapt/bottom/progress/book/Text/label")

	i18n = var_6_31

	var_6_25(var_6_32, var_6_31("class_label_gen"))

	setText = var_6_25

	local var_6_33 = arg_6_0._tf
	local var_6_34 = var_2.Find(var_6_33, "blur_panel/adapt/bottom/progress/proficiency/label")

	i18n = var_6_33

	var_6_25(var_6_34, var_6_33("class_label_tran"))

	setText = var_6_25

	local var_6_35 = arg_6_0._tf
	local var_6_36 = var_2.Find(var_6_35, "blur_panel/adapt/bottom/upgarde/Text")

	i18n = var_6_35

	var_6_25(var_6_36, var_6_35("word_levelup"))

	arg_6_0.chars = {}
	ClassResourcePage = var_1
	arg_6_0.resFieldPage = var_1.New(arg_6_0._tf, arg_6_0.event)

	return
end

function var_0_1.didEnter(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.backBtn

	local function var_7_2()
		local var_8_0 = arg_7_0
		local var_8_1 = var_0.emit

		BaseUI = var_2_10002

		var_8_1(var_8_0, var_2_10002.ON_BACK)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10005)

	onButton = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.helpBtn

	local function var_7_5()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_9_2.type = var_2_10003
		i18n = var_2_10003
		var_9_2.helps = var_2_10003("course_class_help")

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10005)

	onButton = var_1_10001

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.upgradeBtn

	local function var_7_8()
		local var_10_0 = arg_7_0.resFieldPage

		var_0.ExecuteAction(var_10_0, "Flush", arg_7_0.resClass)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_6, var_7_7, var_7_8, var_1_10005)

	onButton = var_1_10001

	local var_7_9 = arg_7_0
	local var_7_10 = arg_7_0.exp2ProficiencyRatio

	local function var_7_11()
		local var_11_0 = arg_7_0.chatProficiencyTxt

		i18n = var_2_10001

		local var_11_1 = "course_proficiency_tip"

		pg = var_2_10003

		local var_11_2 = var_2_10003.gameset.level_get_proficency.key_value
		local var_11_3 = arg_7_0.resClass
		local var_11_4 = var_4.GetExp2ProficiencyRatio(var_11_3)
		local var_11_5 = arg_7_0.course

		var_11_0.text = var_2_10001(var_11_1, var_11_2, var_11_4 * var_5.getExtraRate(var_11_5))

		local var_11_6 = arg_7_0

		var_0.DisplayChatContent(var_11_6)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_9, var_7_10, var_7_11, var_1_10005)

	arg_7_0.students = arg_7_0:FilterStudents()

	arg_7_0:InitClassInfo()
	arg_7_0:LoadClassRoom()

	return
end

function var_0_1.DisplayChatContent(arg_12_0)
	setActive = var_1_10001

	var_1_10001(arg_12_0.chatProficiency, true)

	setButtonEnabled = var_1_10001

	var_1_10001(arg_12_0.exp2ProficiencyRatio, false)

	LeanTween = var_1_10001

	local var_12_0 = var_1_10001.scale

	rtf = var_2

	local var_12_1 = var_2(arg_12_0.chatProficiency)

	Vector3 = var_3

	local var_12_2 = var_12_0(var_12_1, var_3(1.5, 1.5, 1), 0.3)
	local var_12_3 = var_1.setFrom

	Vector3 = var_3

	local var_12_4 = var_12_3(var_12_2, var_3.zero)
	local var_12_5 = var_1.setOnComplete

	System = var_3

	var_12_5(var_12_4, var_3.Action(function()
		LeanTween = var_2_10000

		local var_13_0 = var_2_10000.scale

		rtf = var_2_10001

		local var_13_1 = var_2_10001(arg_12_0.chatProficiency)

		Vector3 = var_2

		local var_13_2 = var_13_0(var_13_1, var_2(0, 0, 0), 0.2)
		local var_13_3 = var_0.setDelay(var_13_2, 2)
		local var_13_4 = var_0.setOnComplete

		System = var_2

		var_13_4(var_13_3, var_2.Action(function()
			IsNil = var_3_10000

			if not var_3_10000(arg_12_0.exp2ProficiencyRatio) then
				setButtonEnabled = var_0

				var_0(arg_12_0.exp2ProficiencyRatio, true)

				setActive = var_0

				var_0(arg_12_0.chatProficiency, false)
			end

			return
		end))

		return
	end))

	return
end

function var_0_1.FilterStudents(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = arg_15_0.course
	local var_15_2 = var_2.getConfig(var_15_1, "type")

	pairs = var_15_1

	for iter_15_0, iter_15_1 in var_15_1(arg_15_0.shipGroups) do
		table = var_1_10008

		if var_1_10008.contains(var_15_2, iter_15_1.shipConfig.type) then
			table = var_1_10008

			var_1_10008.insert(var_15_0, iter_15_1)
		end
	end

	if #var_15_0 > #arg_15_0.studentSeats then
		shuffle = var_3

		var_3(var_15_0)
	end

	return var_15_0
end

function var_0_1.InitClassInfo(arg_16_0)
	local var_16_0 = arg_16_0.resClass
	local var_16_1 = arg_16_0.course
	local var_16_2 = arg_16_0.lessonTxt
	local var_16_3 = var_3.SetText

	i18n = var_1_10005

	var_16_3(var_16_2, var_1_10005("course_class_name", var_16_1:getConfig("name_show")))

	arg_16_0.tranSpeedTxt.text = "-" .. var_16_0:GetTranValuePreHour() .. "/h"

	local var_16_4 = var_16_1:GetProficiency()
	local var_16_5 = var_16_0:GetMaxProficiency()
	local var_16_6 = arg_16_0.proficiencyProgressTxt

	var_16_6.text = var_16_4 .. "/" .. var_16_5
	setFillAmount = var_16_6

	var_16_6(arg_16_0.proficiencyProgress, var_16_4 / var_16_5)

	local var_16_7 = var_16_0:GetPlayerRes() % var_16_0:GetTarget()
	local var_16_8 = arg_16_0.tranProgressTxt

	var_16_8.text = " <color=#92FC63FF>" .. var_16_7 .. "</color>/" .. var_6
	setFillAmount = var_16_8

	var_16_8(arg_16_0.tranProgress, var_16_7 / var_6)

	local var_16_9 = var_16_0:GetExp2ProficiencyRatio() * var_16_1:getExtraRate()

	arg_16_0.exp2ProficiencyRatioTxt.text = var_16_9 .. "%"

	return
end

function var_0_1.LoadClassRoom(arg_17_0)
	local var_17_0 = {}
	local var_17_1 = 1

	math = var_1_10003

	for iter_17_0 = var_17_1, var_1_10003.min(#arg_17_0.students, #arg_17_0.studentSeats) do
		table = var_1_10006

		var_1_10006.insert(var_17_0, function(arg_18_0)
			local var_18_0 = arg_17_0.students[iter_17_0]
			local var_18_1 = var_1.GetSkin(var_18_0).prefab
			local var_18_2 = arg_17_0

			var_2.LoadChar(var_18_2, var_18_1, function(arg_19_0)
				local var_19_0 = arg_17_0

				var_1.AddStudent(var_19_0, arg_19_0, arg_17_0.studentSeats[iter_17_0])
				arg_18_0()

				return
			end)

			return
		end)
	end

	table = var_17_1

	var_17_1.insert(var_17_0, function(arg_20_0)
		Ship = var_2_10001

		local var_20_0 = var_2_10001.New
		local var_20_1 = {}
		local var_20_2 = arg_17_0.course

		var_20_1.configId = var_3.getConfig(var_20_2, "id")

		local var_20_3 = var_20_0(var_20_1)
		local var_20_4 = arg_17_0

		var_2.LoadChar(var_20_4, var_20_3:getPrefab(), function(arg_21_0)
			local var_21_0 = arg_17_0

			var_1.AddTeacher(var_21_0, arg_21_0, arg_17_0.teacherSeat)
			arg_20_0()

			return
		end)

		return
	end)

	pg = var_2

	local var_17_2 = var_2.UIMgr.GetInstance()

	var_2.LoadingOn(var_17_2)

	seriesAsync = var_2

	var_2(var_17_0, function()
		pg = var_2_10000

		local var_22_0 = var_2_10000.UIMgr.GetInstance()

		var_0.LoadingOff(var_22_0)

		return
	end)

	return
end

function var_0_1.AddStudent(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1
	local var_23_1 = arg_23_1.SetLocalScale

	Vector3 = var_1_10005

	var_23_1(var_23_0, var_1_10005(-0.9, 0.9, 1))

	local var_23_2 = arg_23_1
	local var_23_3 = arg_23_1.SetLocalPosition

	Vector3 = var_5

	var_23_3(var_23_2, var_5(37, 62, 0))
	arg_23_1:SetParent(arg_23_2)

	setActive = var_3

	var_3(arg_23_2:Find("icon"), true)
	arg_23_1:SetAction("sit", 0)
	arg_23_1:SetSiblingIndex(0)

	return
end

function var_0_1.AddTeacher(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_1
	local var_24_1 = arg_24_1.SetLocalScale

	Vector3 = var_1_10005

	var_24_1(var_24_0, var_1_10005(0.9, 0.9, 1))

	local var_24_2 = arg_24_1
	local var_24_3 = arg_24_1.SetLocalPosition

	Vector3 = var_5

	var_24_3(var_24_2, var_5(0, 0, 0))
	arg_24_1:SetParent(arg_24_2)
	arg_24_1:SetAction("stand2", 0)

	return
end

function var_0_1.willExit(arg_25_0)
	arg_25_0:ClearChars()

	local var_25_0 = arg_25_0.resFieldPage

	var_1.Destroy(var_25_0)

	arg_25_0.resFieldPage = nil

	return
end

function var_0_1.LoadChar(arg_26_0, arg_26_1, arg_26_2)
	SpineAnimChar = var_1_10003

	local var_26_0 = var_1_10003.New()

	var_3.SetPaint(var_26_0, arg_26_1)
	var_3:Load(true, function(arg_27_0)
		if arg_26_0.exited then
			arg_27_0:Dispose()

			return
		end

		local var_27_0 = arg_27_0
		local var_27_1 = arg_27_0.SetLayer

		Layer = var_2_10003

		var_27_1(var_27_0, var_2_10003.UI)

		arg_26_0.chars[arg_26_1] = arg_27_0

		arg_26_2(arg_27_0)

		return
	end)

	return
end

function var_0_1.ClearChars(arg_28_0)
	pairs = var_1_10001

	for iter_28_0, iter_28_1 in var_1_10001(arg_28_0.chars) do
		iter_28_1:Dispose()
	end

	arg_28_0.chars = {}

	return
end

function var_0_1.onBackPressed(arg_29_0)
	if arg_29_0.resFieldPage then
		local var_29_0 = arg_29_0.resFieldPage

		if var_1.GetLoaded(var_29_0) then
			local var_29_1 = arg_29_0.resFieldPage

			if var_1.isShowing(var_29_1) then
				local var_29_2 = arg_29_0.resFieldPage

				var_1.Hide(var_29_2)

				return
			end
		end
	end

	var_0_1.super.onBackPressed(arg_29_0)

	return
end

return var_0_1
