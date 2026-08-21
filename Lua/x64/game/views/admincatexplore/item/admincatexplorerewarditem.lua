local var_0_0 = class("AdminCatExploreRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.nameController = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "name")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.bgBtn_, nil, function()
		ShowPopItem(POP_OTHER_ITEM, {
			arg_4_0.data[1],
			arg_4_0.data[2]
		})
	end)
end

function var_0_0.SetItemData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.data = arg_6_1
	arg_6_0.index = arg_6_2

	arg_6_0:UpdateView()
end

function var_0_0.UpdateText(arg_7_0, arg_7_1)
	arg_7_0.numTxt_.text = arg_7_1
end

function var_0_0.UpdateView(arg_8_0)
	arg_8_0.numTxt_.text = arg_8_0.data[2]
	arg_8_0.iconImage_.sprite = ItemTools.getItemSprite(arg_8_0.data[1])
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:UpdateView()
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
	Object.Destroy(arg_11_0.gameObject_)
end

return var_0_0
