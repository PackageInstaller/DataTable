local var_0_0 = class("HeroPreviewReCommendItemItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.haveController_ = arg_2_0.controller_:GetController("have")
	arg_2_0.colorController_ = arg_2_0.controller_:GetController("color")
end

function var_0_0.RefreshData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.curHeroID_ = arg_3_3

	for iter_3_0 = 1, 3 do
		if arg_3_2 == iter_3_0 then
			arg_3_0:RefreshColor(arg_3_1.hero_id[iter_3_0])
			arg_3_0:RefreshHave(arg_3_1.hero_id[iter_3_0])

			arg_3_0.posTxt_.text = GetI18NText(arg_3_1.hero_desc[iter_3_0])
			arg_3_0.roleHead_.sprite = SpritePathCfg.HeroMediumIcon.path .. arg_3_1.hero_id[iter_3_0]

			break
		end
	end
end

function var_0_0.RefreshColor(arg_4_0, arg_4_1)
	if arg_4_0.curHeroID_ == arg_4_1 then
		arg_4_0.colorController_:SetSelectedState("true")
	else
		arg_4_0.colorController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshHave(arg_5_0, arg_5_1)
	if HeroTools.GetHeroIsUnlock(arg_5_1) then
		arg_5_0.haveController_:SetSelectedState("true")
	else
		arg_5_0.haveController_:SetSelectedState("false")
	end

	if arg_5_0.curHeroID_ == arg_5_1 then
		arg_5_0.haveController_:SetSelectedState("true")
	end
end

return var_0_0
