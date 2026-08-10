local var_0_0 = class("MaterialPreview", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/ReturnmaterialpopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.itemListGo_, CommonItemView)
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.indexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = clone(ItemTemplateData)
	local var_5_1 = arg_5_0.itemList_[arg_5_1]

	var_5_0.id = var_5_1.id
	var_5_0.number = var_5_1.number

	function var_5_0.clickFun(arg_6_0)
		ShowPopItem(POP_ITEM, {
			arg_6_0.id
		})
	end

	arg_5_2:SetData(var_5_0)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.textText_.text = GetI18NText(arg_7_0.params_.content)

	arg_7_0:UpdateData()
	arg_7_0.scrollHelper_:StartScroll(#arg_7_0.itemList_)
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.UpdateData(arg_9_0)
	local var_9_0 = arg_9_0.params_.itemList

	arg_9_0.itemList_ = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		table.insert(arg_9_0.itemList_, {
			id = iter_9_1[1],
			number = iter_9_1[2]
		})
	end
end

function var_0_0.AddUIListener(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_10_0:AddBtnListener(arg_10_0.cancelbtnBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_10_0:AddBtnListener(arg_10_0.okbtnBtn_, nil, function()
		arg_10_0.params_.OkCallback()
		arg_10_0:Back()
	end)
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.scrollHelper_:Dispose()
	arg_14_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
