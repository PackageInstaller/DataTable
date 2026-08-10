local var_0_0 = class("SummerPubPartnerItem", ReduxView)

PARTNER_PATH = "TextureConfig/Character/Icon/"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.index = arg_1_2
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.id = SummerPubHeroCfg.get_id_list_by_profile_position[arg_1_2][1]
	arg_1_0.cfg = SummerPubHeroCfg[arg_1_0.id]
	arg_1_0.clickFunc_ = arg_1_3

	arg_1_0:AddListeners()
	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.lockController_ = arg_2_0.controller_:GetController("lock")
	arg_2_0.heroName_.text = GetI18NText(arg_2_0.cfg.hero_name)
	arg_2_0.heroIcon_.sprite = pureGetSpriteWithoutAtlas(PARTNER_PATH .. arg_2_0.cfg.profile_icon_head)

	arg_2_0.lockController_:SetSelectedState("lock")
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.UpdateState(arg_4_0)
	if SummerPubData:isUnlockPartner(arg_4_0.id) then
		arg_4_0.lockController_:SetSelectedState("unlock")

		if (getData("summer_pub_partner", "hero_anim_" .. arg_4_0.index) or 0) == 0 then
			saveData("summer_pub_partner", "hero_anim_" .. arg_4_0.index, 1)
			arg_4_0.unlockAnim_:Play("UI_bigheroitem_cx", -1, 0)
		else
			arg_4_0.unlockAnim_:Play("UI_unlock_cx")
		end
	end
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.detailBtn, nil, function()
		if SummerPubData:isUnlockPartner(arg_5_0.id) then
			arg_5_0.clickFunc_()
			JumpTools.OpenPageByJump("summerPubPartnerDetailView", {
				id = arg_5_0.id
			})
		else
			ShowTips("NYA_TEAM_NOT_RECRUITED")
		end
	end)
end

return var_0_0
