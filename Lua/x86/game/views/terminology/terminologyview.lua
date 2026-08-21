local var_0_0 = class("TerminologyView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Terminology/TerminologyPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.items_ = {}
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.closeBtn_, nil, function()
		arg_4_0:Back()
	end)
end

local function var_0_1(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0) do
		if not table.indexof(var_6_0, iter_6_1) then
			table.insert(var_6_0, iter_6_1)
		end
	end

	return var_6_0
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.idList_ = var_0_1(arg_7_0.params_.terminologyIdList)

	arg_7_0:RefreshUI()
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.items_) do
		iter_8_1:Dispose()
	end

	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.idList_[arg_9_1]

	arg_9_2:SetData(var_9_0)
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = #arg_10_0.idList_

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.items_) do
		SetActive(iter_10_1.gameObject_, iter_10_0 <= var_10_0)
	end

	for iter_10_2 = 1, var_10_0 do
		local var_10_1 = arg_10_0.items_[iter_10_2]

		if not var_10_1 then
			local var_10_2 = Object.Instantiate(arg_10_0.templateGo_, arg_10_0.contentTrans_)

			SetActive(var_10_2, true)

			var_10_1 = TerminologyItem.New(var_10_2)
			arg_10_0.items_[iter_10_2] = var_10_1
		end

		arg_10_0:IndexItem(iter_10_2, var_10_1)
	end
end

return var_0_0
