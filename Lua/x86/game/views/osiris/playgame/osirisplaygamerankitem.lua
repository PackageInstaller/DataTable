local var_0_0 = class("OsirisPlayGameRankItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rankController_ = arg_3_0.conExCollection_:GetController("rank")
	arg_3_0.heroCountController_ = arg_3_0.conExCollection_:GetController("heroCount")
	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.index = arg_4_2
	arg_4_0.data = arg_4_1
	arg_4_0.heroList = arg_4_1:GetSingleSelectHeroList()

	arg_4_0:UpdateView()
end

function var_0_0.UpdateView(arg_5_0)
	arg_5_0.nickText_.text = arg_5_0.data.nick
	arg_5_0.rankText_.text = arg_5_0.data.rank

	arg_5_0.rankController_:SetSelectedState(tostring(arg_5_0.data.rank > 3 and 0 or arg_5_0.data.rank))
	arg_5_0.commonPortrait_:RenderHead(arg_5_0.data.portrait)
	arg_5_0.commonPortrait_:RenderFrame(arg_5_0.data.frame)

	arg_5_0.scoreText_.text = arg_5_0.data.score
	arg_5_0.team_list_ = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.data.stage_team_list[0]) do
		arg_5_0.team_list_[iter_5_0] = {}

		for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
			table.insert(arg_5_0.team_list_[iter_5_0], {
				hero_id = iter_5_3.hero_id,
				skin_id = iter_5_3.skin_id
			})
		end
	end

	local var_5_0 = math.min(table.length(arg_5_0.team_list_), 3)

	arg_5_0.heroCountController_:SetSelectedState(var_5_0)

	for iter_5_4 = 1, var_5_0 do
		local var_5_1 = arg_5_0.team_list_[iter_5_4][1].skin_id

		if var_5_1 == 0 then
			var_5_1 = arg_5_0.team_list_[iter_5_4][1].hero_id
		end

		arg_5_0["heroImg_" .. iter_5_4].sprite = getSpriteViaConfig("HeroItemshead", var_5_1)
	end
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:UpdateView()
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.gameObject_)
end

return var_0_0
