local var_0_0 = class("ActivityAttributeArenaRankItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.commonPortrait_ = CommonHeadPortrait.New(arg_2_0.headItem_)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.heroCountController_ = arg_3_0.conExCollection_:GetController("heroCount")
	arg_3_0.rankController_ = arg_3_0.conExCollection_:GetController("rank")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	arg_4_0.userID_ = arg_4_1.user_id
	arg_4_0.nickText_.text = arg_4_1.nick

	arg_4_0.commonPortrait_:RenderHead(arg_4_1.portrait)
	arg_4_0.commonPortrait_:RenderFrame(arg_4_1.frame)

	arg_4_0.rankText_.text = arg_4_1.rank
	arg_4_0.scoreText_.text = arg_4_1.score

	local var_4_0 = arg_4_1:GetSingleSelectHeroList()
	local var_4_1 = math.min(table.length(var_4_0), 3)

	if arg_4_0.heroCountController_ then
		arg_4_0.heroCountController_:SetSelectedState(var_4_1)
	end

	for iter_4_0 = 1, var_4_1 do
		local var_4_2 = var_4_0[iter_4_0]
		local var_4_3 = var_4_2.skin_id

		if var_4_3 == 0 then
			var_4_3 = var_4_2.hero_id
		end

		arg_4_0["heroImg_" .. iter_4_0].sprite = getSpriteViaConfig("HeroItemshead", var_4_3)
	end

	if arg_4_1.rank <= 3 then
		arg_4_0.rankController_:SetSelectedState(arg_4_1.rank)
	else
		arg_4_0.rankController_:SetSelectedState(0)
	end
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
