local var_0_0 = class("HodurRankItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.commonPortrait = CommonHeadPortrait.New(arg_2_0.headItem_)

	arg_2_0:AddUIListeners()

	arg_2_0.rankController = arg_2_0.conExCollection_:GetController("rank")
	arg_2_0.viewController = arg_2_0.conExCollection_:GetController("viewBtn")
end

function var_0_0.AddUIListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.viewBtn_, nil, function()
		JumpTools.OpenPageByJump("hodurRankSquadsView", {
			list = arg_3_0.heroList,
			affix_list = arg_3_0.data.extraInfo
		})
	end)
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.commonPortrait:Dispose()
	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.GetRankActivityID(arg_6_0)
	return ActivityConst.ACTIVITY_HODUR_RANK
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.data = arg_7_1
	arg_7_0.rankText_.text = GetI18NText(arg_7_1.rank)
	arg_7_0.scoreText_.text = GetI18NText(arg_7_1.score)
	arg_7_0.heroList = arg_7_1:GetSingleSelectHeroList()

	if arg_7_1.rank <= 3 then
		arg_7_0.rankController:SetSelectedIndex(arg_7_1.rank)
	else
		arg_7_0.rankController:SetSelectedIndex(0)
	end

	arg_7_0.nickText_.text = GetI18NText(arg_7_1.nick)

	arg_7_0.commonPortrait:RenderHead(arg_7_1.portrait)
	arg_7_0.commonPortrait:RenderFrame(arg_7_1.frame)
end

return var_0_0
