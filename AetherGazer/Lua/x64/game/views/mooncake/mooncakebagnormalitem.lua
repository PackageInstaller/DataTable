local var_0_0 = class("MoonCakeBagNormalItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.clickHandler_ then
			arg_3_0.clickHandler_(arg_3_0.info_, arg_3_0.index_)
		end
	end)
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.clickHandler_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.itemID_ = arg_6_1
	arg_6_0.index_ = arg_6_2
	arg_6_0.nameText_.text = ItemTools.getItemName(arg_6_1)

	local var_6_0 = ItemTools.getItemNum(arg_6_1)

	arg_6_0.numText_.text = var_6_0
	arg_6_0.icon_.sprite = ItemTools.getItemSprite(arg_6_1)
	arg_6_0.info_ = arg_6_0.info_ or {}
	arg_6_0.info_.id = arg_6_0.itemID_
	arg_6_0.info_.number = var_6_0
end

function var_0_0.SetClickHandler(arg_7_0, arg_7_1)
	arg_7_0.clickHandler_ = arg_7_1
end

return var_0_0
