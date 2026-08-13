class = var_0_10000

local var_0_0 = "NewNavalTacticsSelLessonPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "NewNavalTacticsLessonPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.skillPanel = var_1.Find(var_2_0, "skill")

	local var_2_1 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_1, "cancel_btn")

	local var_2_2 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_2, "confirm_btn")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "items")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	ToggleGroup = var_1_10004
	arg_2_0.toggleGroup = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "introl/name")
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.lessonNameTxt = var_2_8(var_2_7, var_3(var_1_10004))

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "introl/desc")
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.lessonDescTxt = var_2_11(var_2_10, var_3(var_1_10004))

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_1.Find(var_2_12, "introl/exp_Text")
	local var_2_14 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.lessonExpTxt = var_2_14(var_2_13, var_3(var_1_10004))

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_1.Find(var_2_15, "introl/timer_Text")
	local var_2_17 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.lessonTimeTxt = var_2_17(var_2_16, var_3(var_1_10004))
	NewNavalTacticsAdditionSkillCard = var_1

	local var_2_18 = var_1.New
	local var_2_19 = arg_2_0._tf

	arg_2_0.skillCard = var_2_18(var_2.Find(var_2_19, "skill/info"))

	local var_2_20 = {}
	local var_2_21 = arg_2_0._tf

	var_2_20[1] = var_2.Find(var_2_21, "items/scorll/content/item")
	arg_2_0.itemTpls = var_2_20
	arg_2_0.startPos = arg_2_0.itemTpls[1].anchoredPosition
	Vector2 = var_1
	arg_2_0.space = var_1(60, 30)
	arg_2_0.cloumnCnt = 6
	setText = var_1

	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_2.Find(var_2_22, "introl/exp_label")

	i18n = var_2_22

	var_1(var_2_23, var_2_22("tactics_class_get_exp"))

	setText = var_1

	local var_2_24 = arg_2_0._tf
	local var_2_25 = var_2.Find(var_2_24, "introl/timer_label")

	i18n = var_2_24

	var_1(var_2_25, var_2_24("tactics_class_spend_time"))

	setText = var_1

	local var_2_26 = arg_2_0.confirmBtn
	local var_2_27 = var_2.Find(var_2_26, "Image")

	i18n = var_2_26

	var_1(var_2_27, var_2_26("tactics_class_start"))

	setText = var_1

	local var_2_28 = arg_2_0.cancelBtn
	local var_2_29 = var_2.Find(var_2_28, "Image")

	i18n = var_2_28

	var_1(var_2_29, var_2_28("tactics_class_cancel"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.cancelBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Cancel(var_4_0)

		local var_4_1 = arg_3_0

		var_0.Hide(var_4_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.confirmBtn

	local function var_3_5()
		if not arg_3_0.selLessonId or not arg_3_0.spendTime then
			return
		end

		local var_5_0 = arg_3_0.student

		var_0.setLesson(var_5_0, arg_3_0.selLessonId)

		local var_5_1 = arg_3_0.student

		var_0.setTime(var_5_1, arg_3_0.spendTime)

		local var_5_2 = arg_3_0
		local var_5_3 = var_0.emit

		NewNavalTacticsLayer = var_2

		var_5_3(var_5_2, var_2.ON_LESSON_SELECTED, arg_3_0.student)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.skillPanel

	local function var_3_8()
		if not arg_3_0.canBack then
			return
		end

		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		NewNavalTacticsLayer = var_2_10002

		var_6_1(var_6_0, var_2_10002.ON_RESEL_SKILL, arg_3_0.student)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.SetHideCallback(arg_7_0, arg_7_1)
	arg_7_0.hideCallback = arg_7_1

	return
end

function var_0_1.Show(arg_8_0, arg_8_1, arg_8_2)
	var_0_1.super.Show(arg_8_0)

	defaultValue = var_3
	arg_8_0.canBack = var_3(arg_8_2, true)
	pg = var_3

	local var_8_0 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_8_0, arg_8_0._tf)

	if arg_8_1 ~= arg_8_0.student then
		arg_8_0.selLessonId = nil
		arg_8_0.spendTime = nil
		arg_8_0.student = arg_8_1

		arg_8_0:Flush()
	else
		arg_8_0:Flush()
	end

	return
end

function var_0_1.Cancel(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.emit

	NewNavalTacticsMediator = var_1_10003

	var_9_1(var_9_0, var_1_10003.ON_CANCEL_ADD_STUDENT)

	return
end

function var_0_1.Hide(arg_10_0)
	var_0_1.super.Hide(arg_10_0)

	pg = var_1

	local var_10_0 = var_1.UIMgr.GetInstance()
	local var_10_1 = var_1.UnOverlayPanel
	local var_10_2 = arg_10_0._tf

	pg = var_1_10004

	var_10_1(var_10_0, var_10_2, var_1_10004.UIMgr.GetInstance().UIMain)

	if arg_10_0.hideCallback then
		arg_10_0.hideCallback()

		arg_10_0.hideCallback = nil
	end

	return
end

function var_0_1.Flush(arg_11_0)
	local var_11_0 = arg_11_0.student

	getProxy = var_1_10002
	BayProxy = var_1_10003

	local var_11_1 = var_1_10002(var_1_10003)
	local var_11_2 = var_2.RawGetShipById(var_11_1, var_11_0.shipId)
	local var_11_3 = var_11_0:getSkillId(var_11_2)

	arg_11_0:UpdateLessons(var_11_3, var_11_2)

	return
end

function var_0_1.GetLessons(arg_12_0)
	getProxy = var_1_10001
	BagProxy = var_1_10002

	local var_12_0 = var_1_10001(var_1_10002)
	local var_12_1 = var_1.getItemsByType

	Item = var_1_10003

	local var_12_2 = var_12_1(var_12_0, var_1_10003.LESSON_TYPE)

	table = var_12_0

	var_12_0.sort(var_12_2, function(arg_13_0, arg_13_1)
		if arg_13_0:getConfig("rarity") == arg_13_1:getConfig("rarity") then
			return arg_13_0.id < arg_13_1.id
		else
			return var_3 < var_2
		end

		return
	end)

	return var_12_2
end

function var_0_1.UpdateLessons(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:GetLessons()

	for iter_14_0 = 1, #var_14_0 do
		if not arg_14_0.itemTpls[iter_14_0] then
			var_1_10009 = arg_14_0.itemTpls[1]
			Object = var_1_10010
			var_1_10008 = var_1_10010.Instantiate(var_1_10009.gameObject, var_1_10009.parent).transform
			var_1_10010 = arg_14_0.itemTpls
			var_1_10010[iter_14_0] = var_1_10008
		end

		setActive = var_1_10009

		var_1_10009(var_1_10008, true)

		var_1_10010 = arg_14_0

		arg_14_0.UpdateLesson(var_1_10010, var_1_10008, var_14_0[iter_14_0], arg_14_1, arg_14_2)
	end

	for iter_14_1 = #arg_14_0.itemTpls, #var_14_0 + 1, -1 do
		setActive = var_1_10008

		var_1_10008(arg_14_0.itemTpls[iter_14_1], false)
	end

	if #var_14_0 > 0 then
		local var_14_1 = arg_14_0.toggleGroup

		var_4.SetAllTogglesOff(var_14_1)

		triggerToggle = var_4

		var_4(arg_14_0.itemTpls[1], true)
	end

	return
end

function var_0_1.UpdateLesson(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	updateItem = var_1_10005

	local var_15_0 = arg_15_1

	Item = var_1_10007

	var_1_10005(var_15_0, var_1_10007.New({
		id = arg_15_2.id,
		count = arg_15_2.count
	}))

	setText = var_1_10005

	var_1_10005(arg_15_1:Find("icon_bg/count"), arg_15_2.count)

	Item = var_1_10005

	local var_15_1 = var_1_10005.getConfigData(arg_15_2.id).usage_arg[1]
	local var_15_2 = 100

	pg = var_8

	if var_8.skill_data_template[arg_15_3].type == var_5.usage_arg[3] then
		var_15_2 = var_15_2 + var_5.usage_arg[4]
	end

	local var_15_3 = var_5.usage_arg[2] * (var_15_2 / 100)

	onToggle = var_10

	local var_15_4 = arg_15_0
	local var_15_5 = arg_15_1

	local function var_15_6(arg_16_0)
		if arg_16_0 then
			arg_15_0.selLessonId = arg_15_2.id
			arg_15_0.spendTime = var_15_1

			local var_16_0 = arg_15_0

			var_1.UpdateLessonDesc(var_16_0, arg_15_2.id, var_15_3, var_15_1)

			local var_16_1 = arg_15_0

			var_1.UpdateSkill(var_16_1, arg_15_3, var_15_3, arg_15_4)
		end

		return
	end

	SFX_PANEL = var_1_10014

	var_10(var_15_4, var_15_5, var_15_6, var_1_10014)

	local var_15_7 = var_15_2 == 100 and "" or "EXP" .. var_15_2 .. "%"

	setText = var_15_4

	var_15_4(arg_15_1:Find("addition"), var_15_7)

	return
end

function var_0_1.UpdatePosition(arg_17_0, arg_17_1, arg_17_2)
	math = var_1_10003

	local var_17_0 = var_1_10003.ceil(arg_17_2 / arg_17_0.cloumnCnt)
	local var_17_1

	if arg_17_2 % arg_17_0.cloumnCnt == 0 then
		var_17_1 = arg_17_0.cloumnCnt
	end

	local var_17_2 = arg_17_0.startPos.y - (var_17_0 - 1) * (arg_17_1.sizeDelta.y + arg_17_0.space.y)
	local var_17_3 = arg_17_0.startPos.x + (var_17_1 - 1) * (arg_17_1.sizeDelta.x + arg_17_0.space.x)

	Vector2 = var_7
	arg_17_1.anchoredPosition = var_7(var_17_3, var_17_2)

	return
end

function var_0_1.UpdateLessonDesc(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	Item = var_1_10004

	local var_18_0 = var_1_10004.getConfigData(arg_18_1)

	arg_18_0.lessonNameTxt.text = var_18_0.name .. "   -"
	arg_18_0.lessonDescTxt.text = var_18_0.display
	arg_18_0.lessonExpTxt.text = arg_18_2

	local var_18_1 = arg_18_0.lessonTimeTxt

	pg = var_6

	local var_18_2 = var_6.TimeMgr.GetInstance()

	var_18_1.text = var_6.DescCDTime(var_18_2, arg_18_3)

	return
end

function var_0_1.UpdateSkill(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	ShipSkill = var_1_10004

	local var_19_0 = var_1_10004.New(arg_19_3.skills[arg_19_1], arg_19_3.id)
	local var_19_1 = arg_19_0.skillCard

	var_5.Update(var_19_1, var_19_0, arg_19_2)

	return
end

function var_0_1.OnDestroy(arg_20_0)
	if arg_20_0:isShowing() then
		arg_20_0:Hide()
	end

	local var_20_0 = arg_20_0.skillCard

	var_1.Dispose(var_20_0)

	arg_20_0.skillCard = nil

	return
end

return var_0_1
