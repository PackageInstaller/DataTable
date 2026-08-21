local var_0_0 = class("AttachmentBombEnemyCell", import("view.level.cell.StaticCellView"))

var_0_0.StateLive = 1
var_0_0.StateDead = 2

function var_0_0.GetOrder(arg_1_0)
	return ChapterConst.CellPriorityAttachment
end

function var_0_0.Update(arg_2_0)
	if IsNil(arg_2_0.go) then
		arg_2_0:PrepareBase("bomb_enemy_" .. arg_2_0.info.attachmentId)
	end

	local var_2_0 = arg_2_0.state

	if arg_2_0.info.flag == ChapterConst.CellFlagActive and arg_2_0.state ~= var_0_0.StateLive then
		arg_2_0.state = var_0_0.StateLive
		arg_2_0.dead = nil

		arg_2_0:ClearLoader()
		assert(pg.specialunit_template[arg_2_0.info.attachmentId], "specialunit_template not exist: " .. arg_2_0.info.attachmentId)
		arg_2_0:GetLoader():GetPrefab("leveluiview/Tpl_Enemy", "Tpl_Enemy", function(arg_3_0)
			setParent(arg_3_0, arg_2_0.tf)

			tf(arg_3_0).anchoredPosition = Vector2(0, 10)

			arg_2_0:GetLoader():GetSprite("enemies/" .. var_0.prefab, "", findTF(arg_3_0, "icon"))
			setActive(findTF(arg_3_0, "titleContain/bg_s"), var_0.enemy_point == 5)
			setActive(findTF(arg_3_0, "titleContain/bg_m"), var_0.enemy_point == 8)
			setActive(findTF(arg_3_0, "titleContain/bg_h"), var_0.enemy_point == 10)

			arg_2_0.enemy = arg_3_0

			arg_2_0:ResetCanvasOrder()
			arg_2_0:Update()

			return
		end)
	elseif arg_2_0.info.flag == ChapterConst.CellFlagDisabled and arg_2_0.state ~= var_0_0.StateDead then
		arg_2_0.state = var_0_0.StateDead
		arg_2_0.enemy = nil

		arg_2_0:ClearLoader()
		assert(pg.land_based_template[arg_2_0.info.attachmentId], "land_based_template not exist: " .. arg_2_0.info.attachmentId)
		arg_2_0:GetLoader():GetPrefab("leveluiview/Tpl_Dead", "Tpl_Dead", function(arg_4_0)
			setParent(arg_4_0, arg_2_0.tf)

			tf(arg_4_0).anchoredPosition = Vector2(0, 10)

			arg_2_0:GetLoader():GetSprite("enemies/" .. var_0.prefab .. "_d_blue", "", findTF(arg_4_0, "icon"))
			setActive(findTF(arg_4_0, "effect_not_open"), false)
			setActive(findTF(arg_4_0, "effect_open"), false)
			setActive(findTF(arg_4_0, "huoqiubaozha"), var_2_0 == var_0_0.StateLive)

			arg_2_0.dead = arg_4_0

			arg_2_0:ResetCanvasOrder()
			arg_2_0:Update()

			return
		end)
	end

	if arg_2_0.info.flag == ChapterConst.CellFlagActive and arg_2_0.enemy then
		setActive(findTF(arg_2_0.enemy, "effect_found"), arg_2_0.info.trait == ChapterConst.TraitVirgin)

		if arg_2_0.info.trait == ChapterConst.TraitVirgin then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WEIGHANCHOR_ENEMY)
		end
	end

	return
end

return var_0_0
