local var_0_0 = class("ClassLayer", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "ClassUI"
end

function var_0_0.SetStudents(arg_2_0, arg_2_1)
	arg_2_0.shipGroups = arg_2_1

	return
end

function var_0_0.SetCourse(arg_3_0, arg_3_1)
	arg_3_0.course = arg_3_1

	return
end

function var_0_0.SetClass(arg_4_0, arg_4_1)
	arg_4_0.resClass = arg_4_1

	return
end

function var_0_0.OnUpdateResField(arg_5_0, arg_5_1)
	if not isa(arg_5_1, ClassResourceField) then
		return
	end

	arg_5_0:SetClass(arg_5_1)
	arg_5_0:InitClassInfo()

	if arg_5_0.resFieldPage:GetLoaded() and arg_5_0.resFieldPage:isShowing() then
		arg_5_0.resFieldPage:Update(arg_5_1)
	end

	return
end

function var_0_0.init(arg_6_0)
	arg_6_0.backBtn = arg_6_0._tf:Find("blur_panel/adapt/top/back")
	arg_6_0.lessonTxt = arg_6_0._tf:Find("blur_panel/adapt/bottom/lesson/mask/Text"):GetComponent("ScrollText")
	arg_6_0.tranSpeedTxt = arg_6_0._tf:Find("blur_panel/adapt/bottom/progress/proficiency/value"):GetComponent(typeof(Text))
	arg_6_0.proficiencyProgressTxt = arg_6_0._tf:Find("blur_panel/adapt/bottom/progress/proficiency/Text"):GetComponent(typeof(Text))
	arg_6_0.proficiencyProgress = arg_6_0._tf:Find("blur_panel/adapt/bottom/progress/proficiency/slider/Image")
	arg_6_0.tranProgressTxt = arg_6_0._tf:Find("blur_panel/adapt/bottom/progress/book/Text/value"):GetComponent(typeof(Text))
	arg_6_0.tranProgress = arg_6_0._tf:Find("blur_panel/adapt/bottom/progress/book/slider/Image")
	arg_6_0.exp2ProficiencyRatioTxt = arg_6_0._tf:Find("blur_panel/adapt/top/proficiency/Text"):GetComponent(typeof(Text))
	arg_6_0.exp2ProficiencyRatio = arg_6_0._tf:Find("blur_panel/adapt/top/proficiency")
	arg_6_0.chatProficiency = arg_6_0._tf:Find("blur_panel/adapt/top/proficiency/chat")
	arg_6_0.chatProficiencyTxt = arg_6_0.chatProficiency:Find("Text"):GetComponent(typeof(Text))
	arg_6_0.helpBtn = arg_6_0._tf:Find("blur_panel/adapt/top/btn_help")
	arg_6_0.upgradeBtn = arg_6_0._tf:Find("blur_panel/adapt/bottom/upgarde")
	arg_6_0.teacherSeat = arg_6_0._tf:Find("scene/desk0")
	arg_6_0.studentSeats = {
		arg_6_0._tf:Find("scene/desk1"),
		arg_6_0._tf:Find("scene/desk2"),
		arg_6_0._tf:Find("scene/desk3"),
		arg_6_0._tf:Find("scene/desk4"),
		arg_6_0._tf:Find("scene/desk5")
	}

	setText(arg_6_0._tf:Find("blur_panel/adapt/bottom/progress/book/Text/label"), i18n("class_label_gen"))
	setText(arg_6_0._tf:Find("blur_panel/adapt/bottom/progress/proficiency/label"), i18n("class_label_tran"))
	setText(arg_6_0._tf:Find("blur_panel/adapt/bottom/upgarde/Text"), i18n("word_levelup"))

	arg_6_0.chars = {}
	arg_6_0.resFieldPage = ClassResourcePage.New(arg_6_0._tf, arg_6_0.event)

	return
end

function var_0_0.didEnter(arg_7_0)
	onButton(arg_7_0, arg_7_0.backBtn, function()
		arg_7_0:emit(BaseUI.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(arg_7_0, arg_7_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("course_class_help")
		})

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.upgradeBtn, function()
		arg_7_0.resFieldPage:ExecuteAction("Flush", arg_7_0.resClass)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.exp2ProficiencyRatio, function()
		arg_7_0.chatProficiencyTxt.text = i18n("course_proficiency_tip", pg.gameset.level_get_proficency.key_value, arg_7_0.resClass:GetExp2ProficiencyRatio() * arg_7_0.course:getExtraRate())

		arg_7_0:DisplayChatContent()

		return
	end, SFX_PANEL)

	arg_7_0.students = arg_7_0:FilterStudents()

	arg_7_0:InitClassInfo()
	arg_7_0:LoadClassRoom()

	return
end

function var_0_0.DisplayChatContent(arg_12_0)
	setActive(arg_12_0.chatProficiency, true)
	setButtonEnabled(arg_12_0.exp2ProficiencyRatio, false)
	LeanTween.scale(rtf(arg_12_0.chatProficiency), Vector3(1.5, 1.5, 1), 0.3):setFrom(Vector3.zero):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(arg_12_0.chatProficiency), Vector3(0, 0, 0), 0.2):setDelay(2):setOnComplete(System.Action(function()
			if not IsNil(arg_12_0.exp2ProficiencyRatio) then
				setButtonEnabled(arg_12_0.exp2ProficiencyRatio, true)
				setActive(arg_12_0.chatProficiency, false)
			end

			return
		end))

		return
	end))

	return
end

function var_0_0.FilterStudents(arg_15_0)
	local var_15_0 = arg_15_0.course:getConfig("type")

	for iter_15_0, iter_15_1 in pairs(arg_15_0.shipGroups) do
		if table.contains(var_15_0, iter_15_1.shipConfig.type) then
			table.insert({}, iter_15_1)
		end
	end

	if #{} > #arg_15_0.studentSeats then
		shuffle({})
	end

	return {}
end

function var_0_0.InitClassInfo(arg_16_0)
	arg_16_0.lessonTxt:SetText(i18n("course_class_name", arg_16_0.course:getConfig("name_show")))

	arg_16_0.tranSpeedTxt.text = "-" .. arg_16_0.resClass:GetTranValuePreHour() .. "/h"

	local var_16_0 = arg_16_0.course:GetProficiency()
	local var_16_1 = arg_16_0.resClass:GetMaxProficiency()

	arg_16_0.proficiencyProgressTxt.text = var_16_0 .. "/" .. var_16_1

	setFillAmount(arg_16_0.proficiencyProgress, var_16_0 / var_16_1)

	local var_16_2 = arg_16_0.resClass:GetTarget()
	local var_16_3 = arg_16_0.resClass:GetPlayerRes() % var_16_2

	arg_16_0.tranProgressTxt.text = " <color=#92FC63FF>" .. var_16_3 .. "</color>/" .. var_16_2

	setFillAmount(arg_16_0.tranProgress, var_16_3 / var_16_2)

	arg_16_0.exp2ProficiencyRatioTxt.text = arg_16_0.resClass:GetExp2ProficiencyRatio() * arg_16_0.course:getExtraRate() .. "%"

	return
end

function var_0_0.LoadClassRoom(arg_17_0)
	for iter_17_0 = 1, math.min(#arg_17_0.students, #arg_17_0.studentSeats) do
		table.insert({}, function(arg_18_0)
			arg_17_0:LoadChar(arg_17_0.students[iter_17_0]:GetSkin().prefab, function(arg_19_0)
				arg_17_0:AddStudent(arg_19_0, arg_17_0.studentSeats[iter_17_0])
				arg_18_0()

				return
			end)

			return
		end)
	end

	table.insert({}, function(arg_20_0)
		arg_17_0:LoadChar(Ship.New({
			configId = arg_17_0.course:getConfig("id")
		}):getPrefab(), function(arg_21_0)
			arg_17_0:AddTeacher(arg_21_0, arg_17_0.teacherSeat)
			arg_20_0()

			return
		end)

		return
	end)
	pg.UIMgr.GetInstance():LoadingOn()
	seriesAsync({}, function()
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	return
end

function var_0_0.AddStudent(arg_23_0, arg_23_1, arg_23_2)
	arg_23_1:SetLocalScale(Vector3(-0.9, 0.9, 1))
	arg_23_1:SetLocalPosition(Vector3(37, 62, 0))
	arg_23_1:SetParent(arg_23_2)
	setActive(arg_23_2:Find("icon"), true)
	arg_23_1:SetAction("sit", 0)
	arg_23_1:SetSiblingIndex(0)

	return
end

function var_0_0.AddTeacher(arg_24_0, arg_24_1, arg_24_2)
	arg_24_1:SetLocalScale(Vector3(0.9, 0.9, 1))
	arg_24_1:SetLocalPosition(Vector3(0, 0, 0))
	arg_24_1:SetParent(arg_24_2)
	arg_24_1:SetAction("stand2", 0)

	return
end

function var_0_0.willExit(arg_25_0)
	arg_25_0:ClearChars()
	arg_25_0.resFieldPage:Destroy()

	arg_25_0.resFieldPage = nil

	return
end

function var_0_0.LoadChar(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = SpineAnimChar.New()

	var_26_0:SetPaint(arg_26_1)
	var_26_0:Load(true, function(arg_27_0)
		if arg_26_0.exited then
			arg_27_0:Dispose()

			return
		end

		arg_27_0:SetLayer(Layer.UI)

		arg_26_0.chars[arg_26_1] = arg_27_0

		arg_26_2(arg_27_0)

		return
	end)

	return
end

function var_0_0.ClearChars(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.chars) do
		iter_28_1:Dispose()
	end

	arg_28_0.chars = {}

	return
end

function var_0_0.onBackPressed(arg_29_0)
	if arg_29_0.resFieldPage and arg_29_0.resFieldPage:GetLoaded() and arg_29_0.resFieldPage:isShowing() then
		arg_29_0.resFieldPage:Hide()

		return
	end

	var_0_0.super.onBackPressed(arg_29_0)

	return
end

return var_0_0
