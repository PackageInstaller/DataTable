local var_0_0 = class("LimitedCalculationRankItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.heroCountController_ = ControllerUtil.GetController(arg_3_0.transform_, "heroCount")
	arg_3_0.rankController_ = ControllerUtil.GetController(arg_3_0.transform_, "rank")
end

function var_0_0.AddUIListeners(arg_4_0)
	return
end

function var_0_0.OnEner(arg_5_0)
	return
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	arg_6_0.userID_ = arg_6_1.user_id
	arg_6_0.name_.text = GetI18NText(arg_6_1.nick)
	arg_6_0.icon_.sprite = ItemTools.getItemSprite(arg_6_1.portrait)
	arg_6_0.frame_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. arg_6_1.frame)
	arg_6_0.rank_.text = GetI18NText(arg_6_1.rank)
	arg_6_0.score_.text = GetI18NText(arg_6_1.score)
	arg_6_0.difficulty_.text = GetI18NText(arg_6_1.difficulty)

	local var_6_0 = arg_6_1:GetSingleSelectHeroList()
	local var_6_1 = math.min(table.length(var_6_0), 3)

	arg_6_0.heroCountController_:SetSelectedState(var_6_1)

	for iter_6_0 = 1, var_6_1 do
		local var_6_2 = var_6_0[iter_6_0]
		local var_6_3 = var_6_2.skin_id

		if var_6_3 == 0 then
			var_6_3 = var_6_2.hero_id
		end

		arg_6_0["m_heroIcon_" .. iter_6_0].sprite = getSpriteViaConfig("HeroLittleIcon", var_6_3)
	end

	if arg_6_1.rank <= 3 then
		arg_6_0.rankController_:SetSelectedState(arg_6_1.rank)
	else
		arg_6_0.rankController_:SetSelectedState(0)
	end
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
