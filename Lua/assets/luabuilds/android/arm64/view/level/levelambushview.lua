local var_0_0 = class("LevelAmbushView", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "LevelAmbushView"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:InitData()
	arg_2_0:InitUI()
	setActive(arg_2_0._tf, true)

	return
end

function var_0_0.InitData(arg_3_0)
	arg_3_0.chapter = arg_3_0.contextData.chapterVO
	arg_3_0.fleet = arg_3_0.chapter.fleet
	arg_3_0.template = pg.expedition_data_template[arg_3_0.chapter:getChapterCell(arg_3_0.fleet.line.row, arg_3_0.fleet.line.column).attachmentId]

	return
end

function var_0_0.InitUI(arg_4_0)
	local var_4_0 = findTF(arg_4_0._tf, "window")

	GetImageSpriteFromAtlasAsync("enemies/" .. arg_4_0.template.icon, "", (findTF(arg_4_0._tf, "window/ship/icon")))
	setText(findTF(arg_4_0._tf, "window/ship/lv/Text"), arg_4_0.template.level)
	setText(findTF(arg_4_0._tf, "window/evade/rate"), math.floor(arg_4_0.chapter:getAmbushDodge(arg_4_0.fleet) * 100) .. "%")
	onButton(arg_4_0, findTF(arg_4_0._tf, "window/fight_button"), function()
		arg_4_0:emit(LevelMediator2.ON_OP, {
			arg1 = 0,
			type = ChapterConst.OpAmbush,
			id = arg_4_0.fleet.id
		})
		arg_4_0:Destroy()

		return
	end, SFX_UI_WEIGHANCHOR_ATTACK)
	onButton(arg_4_0, findTF(arg_4_0._tf, "window/dodge_button"), function()
		arg_4_0:emit(LevelMediator2.ON_OP, {
			arg1 = 1,
			type = ChapterConst.OpAmbush,
			id = arg_4_0.fleet.id
		})
		arg_4_0:Destroy()

		return
	end, SFX_UI_WEIGHANCHOR_AVOID)

	var_4_0.localScale = Vector3(1, 0, 1)

	LeanTween.scaleY(var_4_0.gameObject, 1, 0.3):setOnComplete(System.Action(arg_4_0.onComplete))

	return
end

function var_0_0.OnDestroy(arg_7_0)
	return
end

function var_0_0.SetFuncOnComplete(arg_8_0, arg_8_1)
	arg_8_0.onComplete = arg_8_1

	return
end

return var_0_0
