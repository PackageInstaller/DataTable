local var_0_0 = class("PopFukubukuroSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/UIInquirepopup14"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uiList_, CommonItemView)
	arg_4_0.okBtnController_ = arg_4_0.controllerEx_:GetController("btn")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		if arg_5_0.selectIndex_ == 0 then
			ShowTips("LUCKILYBAG_NOT_SELECT")
		else
			arg_5_0:Back()
			FukubukuroAction.QuseryUseItem(arg_5_0.instance_id, arg_5_0.selectIndex_)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.instance_id = arg_9_0.params_.instance_id

	arg_9_0:SetSelectIndex(0)

	local var_9_0 = FukubukuroData:GetFukubukuroByInstanceId(arg_9_0.instance_id)

	if var_9_0 then
		arg_9_0.select_list = var_9_0.select_list

		arg_9_0.scrollHelper_:StartScroll(#arg_9_0.select_list)
	else
		arg_9_0.scrollHelper_:StartScroll(0)
	end
end

function var_0_0.SetSelectIndex(arg_10_0, arg_10_1)
	arg_10_0.selectIndex_ = arg_10_1

	if arg_10_0.selectIndex_ ~= 0 then
		arg_10_0.tipText_.text = string.format(GetTips("TIP_SELECT"), ItemTools.getItemName(arg_10_0.select_list[arg_10_1].id))

		arg_10_0.okBtnController_:SetSelectedState("state1")
	else
		arg_10_0.tipText_.text = GetTips("SELECT_CURRENT")

		arg_10_0.okBtnController_:SetSelectedState("state0")
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.indexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.select_list[arg_12_1].id
	local var_12_1 = arg_12_0.select_list[arg_12_1].number
	local var_12_2 = clone(ItemTemplateData)

	var_12_2.id = var_12_0
	var_12_2.number = var_12_1
	var_12_2.selectStyle = arg_12_1 == arg_12_0.selectIndex_

	function var_12_2.clickFun()
		arg_12_0:ItemClick(arg_12_1)
	end

	arg_12_2:SetData(var_12_2)
end

function var_0_0.ItemClick(arg_14_0, arg_14_1)
	arg_14_0:SetSelectIndex(arg_14_1)
	arg_14_0.scrollHelper_:Refresh()
end

return var_0_0
