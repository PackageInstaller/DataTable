local var_0_0 = class("RewardPreviewView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/RewardPreviewPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollList = LuaList.New(handler(arg_4_0, arg_4_0.indexAwardItem), arg_4_0.itemListGo_, CommonItemView)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.scrollList then
		arg_9_0.scrollList:Dispose()
	end

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.rewardList = formatRewardCfgList(arg_10_0.params_.rewardList)

	arg_10_0.scrollList:StartScroll(#arg_10_0.rewardList)
end

function var_0_0.indexAwardItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = rewardToItemTemplate(arg_11_0.rewardList[arg_11_1])

	if arg_11_0.params_.extraItemTemplateDataList and arg_11_0.params_.extraItemTemplateDataList[var_11_0.id] then
		local var_11_1 = arg_11_0.params_.extraItemTemplateDataList[var_11_0.id]

		for iter_11_0, iter_11_1 in pairs(var_11_1) do
			var_11_0[iter_11_0] = iter_11_1
		end
	end

	function var_11_0.clickFun(arg_12_0)
		ShowPopItem(POP_ITEM, arg_12_0)
	end

	arg_11_2:SetData(var_11_0)
end

function var_0_0.OnExitInput(arg_13_0)
	JumpTools.Back()

	return true
end

return var_0_0
