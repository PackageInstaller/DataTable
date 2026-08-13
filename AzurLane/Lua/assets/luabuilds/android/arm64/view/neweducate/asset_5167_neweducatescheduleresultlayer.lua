class = var_0_10000

local var_0_0 = "NewEducateScheduleResultLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.newEducate.base.NewEducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "NewEducateScheduleResultUI"
end

function var_0_1.SetData(arg_2_0)
	local var_2_0 = arg_2_0.contextData.char

	arg_2_0.attrIds = var_1.GetAttrIds(var_2_0)

	local var_2_1 = arg_2_0.contextData.char
	local var_2_2 = var_1.GetResIdByType

	NewEducateChar = var_1_10004
	arg_2_0.moneyResId = var_2_2(var_2_1, var_1_10004.RES_TYPE.MONEY)

	local var_2_3 = arg_2_0.contextData.char
	local var_2_4 = var_1.GetResIdByType

	NewEducateChar = var_4
	arg_2_0.moodResId = var_2_4(var_2_3, var_4.RES_TYPE.MOOD)
	arg_2_0.resIds = {
		arg_2_0.moneyResId,
		arg_2_0.moodResId
	}

	local var_2_5 = arg_2_0.contextData.char
	local var_2_6 = var_1.GetRoundData(var_2_5)

	arg_2_0.unlockPlanNum = var_1.getConfig(var_2_6, "plan_num")

	local var_2_7 = arg_2_0.contextData.char
	local var_2_8 = var_1.GetFSM(var_2_7)
	local var_2_9 = var_1.GetState

	NewEducateFSM = var_4

	local var_2_10 = var_2_9(var_2_8, var_4.SYSTEM.PLAN)

	arg_2_0.planIds = var_1.GetPlans(var_2_10)

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.rootTF = var_1.Find(var_3_0, "root")

	local var_3_1 = arg_3_0.rootTF
	local var_3_2 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_3_0.anim = var_3_2(var_3_1, var_4(var_1_10006))

	local var_3_3 = arg_3_0.rootTF
	local var_3_4 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_3_0.animEvent = var_3_4(var_3_3, var_4(var_1_10006))

	local var_3_5 = arg_3_0.animEvent

	var_1.SetEndEvent(var_3_5, function()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_CLOSE)

		return
	end)

	local var_3_6 = arg_3_0.rootTF

	arg_3_0.plansTF = var_1.Find(var_3_6, "window/plans/content")
	UIItemList = var_1

	local var_3_7 = var_1.New
	local var_3_8 = arg_3_0.plansTF
	local var_3_9 = arg_3_0.plansTF

	arg_3_0.planUIList = var_3_7(var_3_8, var_4.Find(var_3_9, "tpl"))

	local var_3_10 = arg_3_0.rootTF

	arg_3_0.attrsTF = var_1.Find(var_3_10, "window/attr")
	UIItemList = var_1

	local var_3_11 = var_1.New
	local var_3_12 = arg_3_0.attrsTF
	local var_3_13 = arg_3_0.attrsTF

	arg_3_0.attrUIList = var_3_11(var_3_12, var_4.Find(var_3_13, "tpl"))

	local var_3_14 = arg_3_0.rootTF

	arg_3_0.resTF = var_1.Find(var_3_14, "window/res/content")
	UIItemList = var_1

	local var_3_15 = var_1.New
	local var_3_16 = arg_3_0.resTF
	local var_3_17 = arg_3_0.resTF

	arg_3_0.resUIList = var_3_15(var_3_16, var_4.Find(var_3_17, "tpl"))
	setText = var_1

	local var_3_18 = arg_3_0.rootTF
	local var_3_19 = var_3.Find(var_3_18, "window/tip")

	i18n = var_4

	var_1(var_3_19, var_4("child_close_tip"))

	local var_3_20 = arg_3_0.rootTF

	arg_3_0.moodTF = var_1.Find(var_3_20, "window/benefit/mood")

	local var_3_21 = arg_3_0.moodTF

	arg_3_0.moodStageTF = var_1.Find(var_3_21, "left/Text")

	local var_3_22 = arg_3_0.moodTF

	arg_3_0.moodEffectTF = var_1.Find(var_3_22, "right/value")
	setText = var_1

	local var_3_23 = arg_3_0.moodTF
	local var_3_24 = var_3.Find(var_3_23, "right/Text")

	i18n = var_4

	var_1(var_3_24, var_4("child2_mood_benefit"))
	arg_3_0:BlurPanel(arg_3_0._tf, {
		groupDelta = 1
	})

	return
end

function var_0_1.didEnter(arg_5_0)
	arg_5_0:SetData()

	onButton = var_1

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0._close(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_5_0, var_5_1, var_5_2, var_1_10006)

	arg_5_0.result = {}
	arg_5_0.benefit = {}
	underscore = var_1

	var_1.each(arg_5_0.contextData.drops, function(arg_7_0)
		if not arg_5_0.result[arg_7_0.id] then
			arg_5_0.result[arg_7_0.id] = 0
		end

		arg_5_0.result[arg_7_0.id] = arg_5_0.result[arg_7_0.id] + arg_7_0.number

		if arg_7_0.isBenefit then
			if not arg_5_0.benefit[arg_7_0.type] then
				arg_5_0.benefit[arg_7_0.type] = {}
			end

			if not arg_5_0.benefit[arg_7_0.type][arg_7_0.id] then
				arg_5_0.benefit[arg_7_0.type][arg_7_0.id] = 0
			end

			arg_5_0.benefit[arg_7_0.type][arg_7_0.id] = arg_5_0.benefit[arg_7_0.type][arg_7_0.id] + arg_7_0.number
		end

		return
	end)

	local var_5_3 = arg_5_0.contextData.char
	local var_5_4 = var_1.GetFSM(var_5_3)
	local var_5_5 = var_1.GetState

	NewEducateFSM = var_4

	local var_5_6 = var_5_5(var_5_4, var_4.SYSTEM.PLAN)
	local var_5_7

	if not var_1.GetResources(var_5_6) then
		var_5_7 = {}
	end

	arg_5_0.oldRes = var_5_7

	local var_5_8

	if not var_1:GetAttrs() then
		var_5_8 = {}
	end

	arg_5_0.oldAttrs = var_5_8

	arg_5_0:UpdataMood()

	local var_5_9 = arg_5_0.attrUIList

	var_2.make(var_5_9, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = arg_5_0

			var_3.UpdateAttr(var_8_0, arg_8_1, arg_8_2)
		end

		return
	end)

	local var_5_10 = arg_5_0.attrUIList

	var_2.align(var_5_10, #arg_5_0.attrIds)

	local var_5_11 = arg_5_0.resUIList

	var_2.make(var_5_11, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = arg_5_0

			var_3.UpdateRes(var_9_0, arg_9_1, arg_9_2)
		end

		return
	end)

	local var_5_12 = arg_5_0.resUIList

	var_2.align(var_5_12, #arg_5_0.resIds)

	local var_5_13 = arg_5_0.planUIList

	var_2.make(var_5_13, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = arg_5_0

			var_3.UpdatePlan(var_10_0, arg_10_1, arg_10_2)
		end

		return
	end)

	local var_5_14 = arg_5_0.planUIList

	var_2.align(var_5_14, arg_5_0.unlockPlanNum)

	return
end

function var_0_1.UpdataMood(arg_11_0)
	local var_11_0 = arg_11_0.contextData.char
	local var_11_1, var_11_2 = var_1.GetMoodStage(var_11_0)

	setText = var_11_0

	local var_11_3 = arg_11_0.moodStageTF

	i18n = var_1_10006

	var_11_0(var_11_3, var_1_10006("child2_mood_stage" .. var_11_1))

	setText = var_11_0

	var_11_0(arg_11_0.moodEffectTF, var_11_2 / 100 .. "%")

	setActive = var_11_0

	local var_11_4 = arg_11_0.moodTF

	var_11_0(var_5.Find(var_11_4, "buff"), var_11_2 >= 0)

	setActive = var_11_0

	local var_11_5 = arg_11_0.moodTF

	var_11_0(var_5.Find(var_11_5, "debuff"), var_11_2 < 0)

	return
end

function var_0_1.GetExtraStr(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = ""

	if arg_12_3 ~= 0 then
		local var_12_1 = arg_12_3 > 0 and "#22AFFF" or "#FF6767"

		setColorStr = var_1_10006
		var_1_10008 = 0 < arg_12_3 and "+" or ""
		var_12_0 = var_1_10006(var_1_10008 .. arg_12_3, var_12_1)
	end

	local var_12_2 = ""

	if arg_12_2 - arg_12_3 - arg_12_1 ~= 0 then
		local var_12_3 = var_6 > 0 and "#393A3C" or "#FF6767"

		setColorStr = var_1_10008
		var_12_2 = var_1_10008((var_6 > 0 and "+" or "") .. var_6, var_12_3)
	end

	return var_12_2 .. var_12_0
end

function var_0_1.UpdateAttr(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.attrIds[arg_13_1 + 1]

	pg = var_4

	local var_13_1 = var_4.child2_attr[var_13_0]

	LoadImageSpriteAsync = var_1_10005

	var_1_10005("neweducateicon/" .. var_13_1.icon, arg_13_2:Find("icon_bg/icon"))

	setScrollText = var_1_10005

	var_1_10005(arg_13_2:Find("name_mask/name"), var_13_1.name)

	local var_13_2 = arg_13_0.attrIds[arg_13_1 + 1]
	local var_13_3 = arg_13_0.contextData.char
	local var_13_4 = var_6.GetAttr(var_13_3, var_13_2)

	NewEducateInfoPanel = var_7

	local var_13_5 = var_7.GetArrtInfo

	pg = var_9

	local var_13_6, var_13_7 = var_13_5(var_9.child2_attr[var_13_2].rank, var_13_4)

	setText = var_9

	var_9(arg_13_2:Find("rank/Text"), var_13_6)

	setText = var_9

	var_9(arg_13_2:Find("value_new"), var_13_4)

	EducateConst = var_9

	local var_13_8 = var_9.GRADE_2_COLOR[var_13_6][1]

	EducateConst = var_10

	local var_13_9 = var_10.GRADE_2_COLOR[var_13_6][2]

	setImageColor = var_11

	local var_13_10 = arg_13_2:Find("gradient")

	Color = var_14

	var_11(var_13_10, var_14.NewHex(var_13_8))

	setImageColor = var_11

	local var_13_11 = arg_13_2
	local var_13_12 = arg_13_2.Find(var_13_11, "rank")

	Color = var_14

	var_11(var_13_12, var_14.NewHex(var_13_9))

	local var_13_13

	if not arg_13_0.oldAttrs[var_13_2] then
		var_13_13 = var_13_4
	end

	local var_13_14 = var_13_4 - var_13_13 > 0 and "16CF99" or "FF6767"

	if var_12 == 0 then
		var_13_14 = "393A3C"
	end

	setImageColor = var_14

	local var_13_15 = arg_13_2:Find("arrow")

	Color = var_1_10017

	var_14(var_13_15, var_1_10017.NewHex(var_13_14))

	setTextColor = var_14

	local var_13_16 = arg_13_2:Find("value_new")

	Color = var_17

	var_14(var_13_16, var_17.NewHex(var_13_14))

	local var_13_17 = arg_13_0.benefit

	NewEducateConst = var_13_11

	local var_13_18

	if not var_13_17[var_13_11.DROP_TYPE.ATTR] or not var_14[var_13_2] then
		var_13_18 = 0
	end

	local var_13_19 = arg_13_0:GetExtraStr(var_13_13, var_13_4, var_13_18)

	setText = var_17

	local var_13_20 = arg_13_2:Find("value_old")

	math = var_20

	var_17(var_13_20, var_20.max(var_13_13, 0) .. var_13_19)

	setActive = var_17

	var_17(arg_13_2:Find("VX"), var_13_13 ~= var_13_4)

	return
end

function var_0_1.UpdateRes(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.resIds[arg_14_1 + 1]

	LoadImageSpriteAsync = var_4

	local var_14_1 = "neweducateicon/"

	pg = var_1_10007

	var_4(var_14_1 .. var_1_10007.child2_resource[var_14_0].icon, arg_14_2:Find("icon"))

	setText = var_4

	local var_14_2 = arg_14_2
	local var_14_3 = arg_14_2.Find(var_14_2, "name")

	pg = var_7

	var_4(var_14_3, var_7.child2_resource[var_14_0].name)

	local var_14_4 = arg_14_0.contextData.char
	local var_14_5 = var_4.GetRes(var_14_4, var_14_0)
	local var_14_6

	if not arg_14_0.oldRes[var_14_0] then
		var_14_6 = var_14_5
	end

	local var_14_7 = var_14_5 - var_14_6 > 0 and "16CF99" or "FF6767"

	if var_6 == 0 then
		var_14_7 = "393A3C"
	end

	setText = var_14_2

	var_14_2(arg_14_2:Find("value_new"), var_14_5)

	setImageColor = var_14_2

	local var_14_8 = arg_14_2:Find("arrow")

	Color = var_11

	var_14_2(var_14_8, var_11.NewHex(var_14_7))

	setTextColor = var_14_2

	local var_14_9 = arg_14_2:Find("value_new")

	Color = var_11

	var_14_2(var_14_9, var_11.NewHex(var_14_7))

	local var_14_10 = arg_14_0.benefit

	NewEducateConst = var_9

	local var_14_11

	if not var_14_10[var_9.DROP_TYPE.RES] or not var_8[var_14_0] then
		var_14_11 = 0
	end

	local var_14_12 = arg_14_0:GetExtraStr(var_14_6, var_14_5, var_14_11)

	setText = var_11

	local var_14_13 = arg_14_2:Find("value_old")

	math = var_14

	var_11(var_14_13, var_14.max(var_14_6, 0) .. var_14_12)

	return
end

function var_0_1.UpdatePlan(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.planIds[arg_15_1 + 1]

	setActive = var_15_1

	var_15_1(arg_15_2:Find("bg/icon"), var_15_0)

	setActive = var_15_1

	var_15_1(arg_15_2:Find("bg/empty"), not var_15_0)

	local var_15_1

	if var_15_0 then
		var_15_1 = "plan_type"
		pg = var_1_10005
		var_15_1 = var_15_1 .. var_1_10005.child2_plan[var_15_0].replace_type_show
		LoadImageSpriteAtlasAsync = var_5

		var_5("ui/neweducatecommonui_atlas", var_15_1, arg_15_2:Find("bg/icon"))
	end

	setActive = var_15_1

	var_15_1(arg_15_2:Find("dot"), arg_15_1 + 1 ~= arg_15_0.unlockPlanNum)

	return
end

function var_0_1._close(arg_16_0)
	local var_16_0 = arg_16_0.anim

	var_1.Play(var_16_0, "anim_educate_result_out")

	return
end

function var_0_1.onBackPressed(arg_17_0)
	arg_17_0:_close()

	return
end

function var_0_1.willExit(arg_18_0)
	arg_18_0:UnOverlayPanel(arg_18_0._tf)

	existCall = var_1

	var_1(arg_18_0.contextData.onExit)

	local var_18_0 = arg_18_0.animEvent

	var_1.SetEndEvent(var_18_0, nil)

	return
end

return var_0_1
