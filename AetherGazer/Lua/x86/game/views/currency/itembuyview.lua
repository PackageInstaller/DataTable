local var_0_0 = class("ItemBuyView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Pool/ItemExchangeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.itemCon_ = ControllerUtil.GetController(arg_3_0.transform_, "itemNum")
	arg_3_0.textCon_ = ControllerUtil.GetController(arg_3_0.transform_, "text")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.selectNum_ = 1

	if arg_4_0.params_.item3.id then
		arg_4_0.itemCon_:SetSelectedState("2")
	else
		arg_4_0.itemCon_:SetSelectedState("1")
	end

	arg_4_0:RefreshUI()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.okBtn_, nil, function()
		if arg_6_0.params_.OkCallback then
			arg_6_0.params_.OkCallback()
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.cancelBtn_, nil, function()
		if arg_6_0.params_.CancelCallback then
			arg_6_0.params_.CancelCallback()

			arg_6_0.params_.CancelCallback = nil

			arg_6_0:Back()
		else
			arg_6_0:Back()
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		if arg_6_0.params_.CancelCallback then
			arg_6_0.params_.CancelCallback()

			arg_6_0.params_.CancelCallback = nil

			arg_6_0:Back()
		else
			arg_6_0:Back()
		end
	end)
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.item1nameText_.text = ItemTools.getItemName(arg_10_0.params_.item1.id)
	arg_10_0.item1iconImg_.sprite = ItemTools.getItemLittleSprite(arg_10_0.params_.item1.id)
	arg_10_0.item1numText_.text = arg_10_0.params_.item1.num
	arg_10_0.titleTxt_.text = arg_10_0.params_.title
	arg_10_0.item2nameText_.text = ItemTools.getItemName(arg_10_0.params_.item2.id)
	arg_10_0.item2iconImg_.sprite = ItemTools.getItemLittleSprite(arg_10_0.params_.item2.id)
	arg_10_0.item2numText_.text = arg_10_0.params_.item2.num

	if arg_10_0.params_.item3.id then
		arg_10_0.item3nameText_.text = ItemTools.getItemName(arg_10_0.params_.item3.id)
		arg_10_0.item3iconImg_.sprite = ItemTools.getItemLittleSprite(arg_10_0.params_.item3.id)
		arg_10_0.item3numText_.text = arg_10_0.params_.item3.num
		arg_10_0.textText_.text = System.String.Format(GetTips("RECHARGE_DIAMOND_AND_DIAMOND_EXCHANGE_DRAWCARD"), tonumber(arg_10_0.params_.item3.num), tonumber(arg_10_0.params_.item2.num), tonumber(arg_10_0.params_.item1.num), ItemTools.getItemName(arg_10_0.params_.item1.id))
	else
		arg_10_0.textText_.text = System.String.Format(GetTips("RECHARGE_DIAMOND_OR_DIAMOND_EXCHANGE_DRAWCARD"), tonumber(arg_10_0.params_.item2.num), ItemTools.getItemName(arg_10_0.params_.item2.id), tonumber(arg_10_0.params_.item1.num), ItemTools.getItemName(arg_10_0.params_.item1.id))
	end
end

return var_0_0
