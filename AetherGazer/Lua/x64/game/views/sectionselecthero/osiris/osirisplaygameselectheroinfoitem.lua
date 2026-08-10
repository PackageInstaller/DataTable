local var_0_0 = import("game.views.sectionSelectHero.SectionSelectHeroInfoItem")
local var_0_1 = class("OsirisPlayGameSelectHeroInfoItem", var_0_0)

function var_0_1.InitController(arg_1_0)
	var_0_1.super.InitController(arg_1_0)

	arg_1_0.osirisController_ = arg_1_0.controllerExCollection_:GetController("Osiris")
end

function var_0_1.RefreshUI(arg_2_0)
	var_0_1.super.RefreshUI(arg_2_0)
	arg_2_0:RefreshOsiris()
end

function var_0_1.RefreshOsiris(arg_3_0)
	local var_3_0 = arg_3_0.sectionProxy_.stageID

	if arg_3_0.heroID_ and arg_3_0.heroID_ ~= 0 then
		local var_3_1 = ActivityGeneralityStageCfg.get_id_list_by_stage_id[var_3_0][1]
		local var_3_2 = ActivityGeneralityStageCfg[var_3_1].generality
		local var_3_3 = arg_3_0:GetValid(arg_3_0.heroID_, var_3_2)

		arg_3_0.osirisController_:SetSelectedState(tostring(var_3_3))
	end
end

function var_0_1.GetValid(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = ActivityGeneralityCharactorCfg[arg_4_1].generality

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if arg_4_2 == iter_4_1 then
			return true
		end
	end

	return false
end

function var_0_1.RefreshPost(arg_5_0)
	arg_5_0.postController_:SetSelectedState("true")
end

return var_0_1
