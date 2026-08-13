class = var_0_10000

local var_0_0 = "LevelAmbushView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "LevelAmbushView"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:InitData()
	arg_2_0:InitUI()

	setActive = var_1

	var_1(arg_2_0._tf, true)

	return
end

function var_0_1.InitData(arg_3_0)
	arg_3_0.chapter = arg_3_0.contextData.chapterVO
	arg_3_0.fleet = arg_3_0.chapter.fleet

	local var_3_0 = arg_3_0.chapter
	local var_3_1 = var_1.getChapterCell(var_3_0, arg_3_0.fleet.line.row, arg_3_0.fleet.line.column)

	pg = var_3_0
	arg_3_0.template = var_3_0.expedition_data_template[var_3_1.attachmentId]

	return
end

function var_0_1.InitUI(arg_4_0)
	findTF = var_1_10001

	local var_4_0 = var_1_10001(arg_4_0._tf, "window")

	findTF = var_2

	local var_4_1 = var_2(arg_4_0._tf, "window/ship/lv/Text")

	findTF = var_3

	local var_4_2 = var_3(arg_4_0._tf, "window/ship/icon")

	findTF = var_4

	local var_4_3 = var_4(arg_4_0._tf, "window/evade/rate")

	findTF = var_5

	local var_4_4 = var_5(arg_4_0._tf, "window/fight_button")

	findTF = var_6

	local var_4_5 = var_6(arg_4_0._tf, "window/dodge_button")

	GetImageSpriteFromAtlasAsync = var_7

	var_7("enemies/" .. arg_4_0.template.icon, "", var_4_2)

	setText = var_7

	var_7(var_4_1, arg_4_0.template.level)

	setText = var_7

	local var_4_6 = var_4_3

	math = var_9

	local var_4_7 = var_9.floor
	local var_4_8 = arg_4_0.chapter

	var_7(var_4_6, var_4_7(var_10.getAmbushDodge(var_4_8, arg_4_0.fleet) * 100) .. "%")

	onButton = var_7

	local var_4_9 = arg_4_0
	local var_4_10 = var_4_4

	local function var_4_11()
		local var_5_0 = arg_4_0
		local var_5_1 = var_0.emit

		LevelMediator2 = var_2_10002

		local var_5_2 = var_2_10002.ON_OP
		local var_5_3 = {
			arg1 = 0
		}

		ChapterConst = var_2_10004
		var_5_3.type = var_2_10004.OpAmbush
		var_5_3.id = arg_4_0.fleet.id

		var_5_1(var_5_0, var_5_2, var_5_3)

		local var_5_4 = arg_4_0

		var_0.Destroy(var_5_4)

		return
	end

	SFX_UI_WEIGHANCHOR_ATTACK = var_4_8

	var_7(var_4_9, var_4_10, var_4_11, var_4_8)

	onButton = var_7

	local var_4_12 = arg_4_0
	local var_4_13 = var_4_5

	local function var_4_14()
		local var_6_0 = arg_4_0
		local var_6_1 = var_0.emit

		LevelMediator2 = var_2_10002

		local var_6_2 = var_2_10002.ON_OP
		local var_6_3 = {
			arg1 = 1
		}

		ChapterConst = var_2_10004
		var_6_3.type = var_2_10004.OpAmbush
		var_6_3.id = arg_4_0.fleet.id

		var_6_1(var_6_0, var_6_2, var_6_3)

		local var_6_4 = arg_4_0

		var_0.Destroy(var_6_4)

		return
	end

	SFX_UI_WEIGHANCHOR_AVOID = var_4_8

	var_7(var_4_12, var_4_13, var_4_14, var_4_8)

	Vector3 = var_7
	var_4_0.localScale = var_7(1, 0, 1)
	LeanTween = var_7

	local var_4_15 = var_7.scaleY(var_4_0.gameObject, 1, 0.3)
	local var_4_16 = var_7.setOnComplete

	System = var_9

	var_4_16(var_4_15, var_9.Action(arg_4_0.onComplete))

	return
end

function var_0_1.OnDestroy(arg_7_0)
	return
end

function var_0_1.SetFuncOnComplete(arg_8_0, arg_8_1)
	arg_8_0.onComplete = arg_8_1

	return
end

return var_0_1
