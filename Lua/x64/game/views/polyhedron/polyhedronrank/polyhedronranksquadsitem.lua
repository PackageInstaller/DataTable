local var_0_0 = class("PolyhedronRankSquadsItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.typeController_ = ControllerUtil.GetController(arg_2_0.transform_, "type")
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	if HeroStandardSystemCfg[arg_3_1.id] ~= nil then
		arg_3_0.heroID_ = HeroStandardSystemCfg[arg_3_1.id].hero_id
		arg_3_0.portraitImg_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. arg_3_1.skin_id)
	else
		arg_3_0.heroID_ = arg_3_1.hero_id

		if not arg_3_1.skin_id or arg_3_1.skin_id == 0 then
			arg_3_0.portraitImg_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. arg_3_0.heroID_)
		else
			arg_3_0.portraitImg_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. arg_3_1.skin_id)
		end
	end

	arg_3_0.typeController_:SetSelectedIndex(arg_3_2 and 1 or 0)

	local var_3_0 = HeroCfg[arg_3_0.heroID_]

	arg_3_0.nameText_.text = GetI18NText(var_3_0.name)
	arg_3_0.rangeTypeText_.text = CharactorParamCfg[arg_3_0.heroID_].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
end

return var_0_0
