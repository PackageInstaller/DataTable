SpringPreheatPrayBranchView = import("game.views.activity.Submodule.springFestival.springPreheat.SpringPreheatPrayBranchView")

local var_0_0 = class("SpringWelfarePrayBranchView", SpringPreheatPrayBranchView)

function var_0_0.Init(arg_1_0)
	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.branch_ = SpringWelfarePrayBubbleView.New(arg_1_0.branchGo_)
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.day_ = arg_2_0.params_.day or SpringWelfareData:GetCurPrayDay()

	arg_2_0.branch_:SetData(arg_2_0.day_)
	arg_2_0.branch_:SetClickHandler(function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		arg_2_0:OnClickBubble(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	end)
	arg_2_0.branch_:OnEnter()
	arg_2_0:RefreshUI()
end

function var_0_0.OnClickBubble(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_4 then
		local var_4_0 = arg_4_3:GetItemId()

		ShowPopItem(POP_ITEM, {
			var_4_0
		})
	end
end

return var_0_0
