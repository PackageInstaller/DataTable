local var_0_0 = class("BossChallengeRewardPreviewView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Boss/BossIntegralGoPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiListGo_, CommonItemView)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.rewardList_ = arg_4_0.params_.rewardList
	arg_4_0.subTitleNameText_.text = GetI18NText(arg_4_0.params_.titleText) or ""
	arg_4_0.targetText_.text = GetI18NText(arg_4_0.params_.targetText) or ""

	arg_4_0.uiList_:StartScroll(#arg_4_0.rewardList_)
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.uiList_:Dispose()

	arg_6_0.uiList_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.closeBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.rewardList_[arg_9_1]

	CommonTools.SetCommonData(arg_9_2, {
		id = var_9_0.id,
		number = var_9_0.num,
		clickFun = function(arg_10_0)
			ShowPopItem(POP_ITEM, {
				arg_10_0.id,
				arg_10_0.number,
				0,
				arg_10_0.time_valid
			})
		end
	})
end

function var_0_0.Cacheable(arg_11_0)
	return false
end

return var_0_0
