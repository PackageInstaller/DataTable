local var_0_0 = class("AffixBoxView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Common/MessageBox4"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMessage.transform
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0.itemView_ = {}
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddListeners()
end

function var_0_0.OnEnter(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.params_.affixList) do
		arg_5_0.itemView_[iter_5_0] = arg_5_0.itemView_[iter_5_0] or AffixBoxItem.New(arg_5_0.item_, arg_5_0.itemParent_)

		arg_5_0.itemView_[iter_5_0]:SetData(iter_5_1)
	end

	for iter_5_2 = #arg_5_0.params_.affixList + 1, #arg_5_0.itemView_ do
		arg_5_0.itemView_[iter_5_2]:SetActive(false)
	end

	arg_5_0.listScrollRect_.verticalNormalizedPosition = 1
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:RemoveListeners()

	for iter_7_0, iter_7_1 in pairs(arg_7_0.itemView_) do
		iter_7_1:Dispose()
	end

	arg_7_0.itemView_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.InitUI(arg_8_0)
	arg_8_0.backBtn_ = arg_8_0:FindCom(typeof(Button), "mask")
	arg_8_0.item_ = arg_8_0:FindGo("panel/bg/affixList/Viewport/Content/Item")
	arg_8_0.itemParent_ = arg_8_0:FindGo("panel/bg/affixList/Viewport/Content")
	arg_8_0.listScrollRect_ = arg_8_0:FindCom(typeof(ScrollRect), "panel/bg/affixList")
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.backBtn_, nil, function()
		arg_9_0:Back()
	end)
end

function var_0_0.RemoveListeners(arg_11_0)
	arg_11_0.backBtn_.onClick:RemoveAllListeners()
end

return var_0_0
