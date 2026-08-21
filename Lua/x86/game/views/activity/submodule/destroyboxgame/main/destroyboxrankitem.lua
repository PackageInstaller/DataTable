local var_0_0 = class("DestroyBoxRankItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.commonPortrait_ = CommonHeadPortrait.New(arg_2_0.headItem_)

	arg_2_0:AddListeners()

	arg_2_0.rankController_ = arg_2_0.conExCollection_:GetController("rank")
	arg_2_0.heroCountController_ = arg_2_0.conExCollection_:GetController("heroCount")
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.Refresh(arg_4_0, arg_4_1)
	arg_4_0.user_id = arg_4_1.user_id
	arg_4_0.rankText_.text = GetI18NText(arg_4_1.rank)
	arg_4_0.scoreText_.text = GetI18NText(arg_4_1.score)
	arg_4_0.heroList_ = arg_4_1:GetSingleSelectHeroList()

	arg_4_0.heroCountController_:SetSelectedState(tostring(#arg_4_0.heroList_))

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.heroList_) do
		if HeroStandardSystemCfg[iter_4_1.id] ~= nil then
			arg_4_0.heroID_ = HeroStandardSystemCfg[davta.id].hero_id
			arg_4_0[string.format("heroImg_%s", iter_4_0)].sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroItemshead.path .. iter_4_1.skin_id)
		else
			arg_4_0.heroID_ = iter_4_1.hero_id

			if not iter_4_1.skin_id or iter_4_1.skin_id == 0 then
				arg_4_0[string.format("heroImg_%s", iter_4_0)].sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroItemshead.path .. arg_4_0.heroID_)
			else
				arg_4_0[string.format("heroImg_%s", iter_4_0)].sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroItemshead.path .. iter_4_1.skin_id)
			end
		end
	end

	if arg_4_1.rank <= 3 then
		arg_4_0.rankController_:SetSelectedIndex(arg_4_1.rank)
	else
		arg_4_0.rankController_:SetSelectedIndex(0)
	end

	arg_4_0.nickText_.text = GetI18NText(arg_4_1.nick)

	arg_4_0.commonPortrait_:RenderHead(arg_4_1.portrait)
	arg_4_0.commonPortrait_:RenderFrame(arg_4_1.frame)
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
