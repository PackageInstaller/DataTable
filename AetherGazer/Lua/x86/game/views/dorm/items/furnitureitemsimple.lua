local var_0_0 = class("FurnitureItemSimple", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.startController = ControllerUtil.GetController(arg_1_0.transform_, "itembglevel")
	arg_1_0.selectController = ControllerUtil.GetController(arg_1_0.transform_, "select")
	arg_1_0.interactController = ControllerUtil.GetController(arg_1_0.transform_, "interact")
	arg_1_0.stateController = ControllerUtil.GetController(arg_1_0.transform_, "state")
	arg_1_0.limitController = ControllerUtil.GetController(arg_1_0.transform_, "upperlimit")
	arg_1_0.furNumController = ControllerUtil.GetController(arg_1_0.transform_, "furNum")
	arg_1_0.screenController = ControllerUtil.GetController(arg_1_0.transform_, "screening")
	arg_1_0.infoController = ControllerUtil.GetController(arg_1_0.transform_, "info")

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1)
	arg_3_0.id = arg_3_1
	arg_3_0.cfg = ItemCfg[arg_3_0.id]

	if arg_3_0.cfg then
		arg_3_0.furName.text = ItemTools.getItemName(arg_3_0.id)
		arg_3_0.level = ItemCfg[arg_3_0.id].rare
		arg_3_0.iconImg_.sprite = ItemTools.getItemSprite(arg_3_0.id)

		arg_3_0.startController:SetSelectedState(0)
	else
		print("家具" .. arg_3_0.id .. "在item表内未找到")

		return
	end
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
