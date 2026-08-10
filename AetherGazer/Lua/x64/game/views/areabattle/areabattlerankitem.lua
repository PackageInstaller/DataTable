local var_0_0 = class("AreaBattleRankItem", ReduxView)

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
	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)

	arg_3_0:AddBtnListener(arg_3_0.viewBtn_, nil, function()
		JumpTools.OpenPageByJump("AreaBattleRankSquadsView", {
			list = arg_3_0.heroList
		})
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.index = arg_5_2
	arg_5_0.data = arg_5_1
	arg_5_0.type = arg_5_3
	arg_5_0.heroList = arg_5_1:GetSingleSelectHeroList()

	arg_5_0:UpdateView()
end

function var_0_0.UpdateView(arg_6_0)
	if arg_6_0.data == nil then
		arg_6_0.rankController_:SetSelectedState("5")

		arg_6_0.rankText_.text = ""

		return
	end

	arg_6_0.nickText_.text = arg_6_0.data.nick
	arg_6_0.rankText_.text = arg_6_0.data.rank

	arg_6_0.rankController_:SetSelectedState(tostring(arg_6_0.data.rank > 3 and 0 or arg_6_0.data.rank))
	arg_6_0.commonPortrait_:RenderHead(arg_6_0.data.portrait)
	arg_6_0.commonPortrait_:RenderFrame(arg_6_0.data.frame)

	arg_6_0.scoreText_.text = arg_6_0.data.score
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:UpdateView()
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_8_0)
	Object.Destroy(arg_8_0.gameObject_)
end

return var_0_0
