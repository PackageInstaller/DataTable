local var_0_0 = class("SevenDaySkinItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InjectUI()
	arg_1_0:AddListeners()
end

function var_0_0.InjectUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.ctrl = ControllerUtil.GetController(arg_2_0.transform_, "receive")
end

function var_0_0.RefreshView(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.item = arg_3_1

	local var_3_0 = arg_3_1[1]
	local var_3_1 = arg_3_1[2]

	arg_3_0.group:SetActive(var_3_1 > 1)
	arg_3_0.ctrl:SetSelectedIndex(arg_3_2)

	arg_3_0.txt.text = var_3_1
	arg_3_0.icon.sprite = ItemTools.getItemSprite(var_3_0)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn, nil, handler(arg_4_0, arg_4_0.OnItemClick))
end

function var_0_0.OnItemClick(arg_5_0)
	ShowPopItem(POP_ITEM, arg_5_0.item)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
