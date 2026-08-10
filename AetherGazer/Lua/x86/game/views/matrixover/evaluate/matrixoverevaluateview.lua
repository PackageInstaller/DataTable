local var_0_0 = class("MatrixOverEvaluateView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/PopUp/MatrixAssessPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.evaluateItemList_ = {}
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.closeBtn_, nil, function()
		arg_4_0:Back()
	end)
	arg_4_0:AddBtnListener(arg_4_0.sureBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	local var_7_0 = MatrixData:GetEvaluateList()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if not arg_7_0.evaluateItemList_[iter_7_0] then
			arg_7_0.evaluateItemList_[iter_7_0] = MatrixOverEvaluateItem.New(arg_7_0.evaluateItem_, arg_7_0.evaluateParent_)
		end

		arg_7_0.evaluateItemList_[iter_7_0]:SetEvaluateID(iter_7_1)
	end

	for iter_7_2 = #var_7_0 + 1, #arg_7_0.evaluateItemList_ do
		arg_7_0.evaluateItemList_[iter_7_2]:Show(false)
	end
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.evaluateItemList_) do
		iter_9_1:Dispose()
	end

	arg_9_0.evaluateItemList_ = nil
end

return var_0_0
