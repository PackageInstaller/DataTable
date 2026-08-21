local var_0_0 = class("MedalItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.usedController_ = ControllerUtil.GetController(arg_3_0.transform_, "used")
	arg_3_0.lockController_ = ControllerUtil.GetController(arg_3_0.transform_, "lock")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.Btn_, nil, function()
		ShowPopItem(POP_SOURCE_DES_ITEM, {
			arg_4_0.info_.id
		})
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshItem(arg_7_0, arg_7_1)
	arg_7_0.info_ = arg_7_1
	arg_7_0.icon_.sprite = ItemTools.getItemSprite(arg_7_0.info_.id)
	arg_7_0.unlock_ = arg_7_0.info_.unlock
	arg_7_0.text_.text = ItemTools.getItemName(arg_7_0.info_.id)

	arg_7_0:RefreshState()
	manager.redPoint:unbindUIandKey(arg_7_0.redPoint_)
end

function var_0_0.RegisterClickListener(arg_8_0, arg_8_1)
	arg_8_0.onClickFunc_ = arg_8_1
end

function var_0_0.RefreshState(arg_9_0)
	arg_9_0.lockController_:SetSelectedState(arg_9_0.unlock_ == 0 and "lock" or "default")
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()
	manager.redPoint:unbindUIandKey(arg_11_0.redPoint_)

	arg_11_0.onClickFunc_ = nil

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
