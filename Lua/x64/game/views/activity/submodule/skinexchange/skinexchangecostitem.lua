local var_0_0 = class("SkinExchangeCostItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			arg_4_0.id_
		})
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1)
	arg_7_0.info_ = arg_7_1
	arg_7_0.id_ = arg_7_0.info_[1]
	arg_7_0.need_ = arg_7_0.info_[2]
	arg_7_0.icon_.sprite = ItemTools.getItemLittleSprite(arg_7_0.id_)
	arg_7_0.text_.text = CItemTools.getItemNum(arg_7_0.id_) .. "/" .. arg_7_0.need_
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	return
end

return var_0_0
