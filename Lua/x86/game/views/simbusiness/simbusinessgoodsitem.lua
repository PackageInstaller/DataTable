local var_0_0 = class("SimBusinessGoodsItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.emptyController = arg_2_0.controllerExCollection_:GetController("empty")
	arg_2_0.typeController = arg_2_0.controllerExCollection_:GetController("category")
	arg_2_0.selectController = arg_2_0.controllerExCollection_:GetController("select")
	arg_2_0.lockController = arg_2_0.controllerExCollection_:GetController("UnlockCondition")

	arg_2_0:AddUIListener()
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.clickBtn_, nil, function()
		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.id)
		end
	end)
end

function var_0_0.RefreshData(arg_6_0, arg_6_1)
	arg_6_0.id = arg_6_1

	local var_6_0 = nullable(SimBusinessGoodsCfg, arg_6_1)

	if var_6_0 then
		arg_6_0.emptyController:SetSelectedState("off")

		arg_6_0.iconImage_.sprite = SimBusinessTools.GetGoodsIcon(arg_6_1)

		local var_6_1, var_6_2 = SimBusinessTools.GetGoodLockState(arg_6_1)

		if var_6_1 and var_6_2 ~= SimBusinessTools.State.LOCK_BY_LEVEL then
			arg_6_0.lockController:SetSelectedState("canUnlock")
		else
			arg_6_0.lockController:SetSelectedState("normal")
		end

		arg_6_0.typeController:SetSelectedState(tostring(var_6_0.type))
	else
		arg_6_0.emptyController:SetSelectedState("on")
		arg_6_0.typeController:SetSelectedState("0")
	end
end

function var_0_0.RefreshSelect(arg_7_0, arg_7_1)
	arg_7_0.selectController:SetSelectedState(arg_7_1 and "true" or "false")
end

function var_0_0.RegisterClick(arg_8_0, arg_8_1)
	arg_8_0.clickFunc = arg_8_1
end

function var_0_0.DefaultClickFunc(arg_9_0)
	manager.notify:CallFirstUpdateFunc("OnGoodsItemClick", arg_9_0.id)
end

function var_0_0.UseDefaultClick(arg_10_0)
	if arg_10_0.clickFunc == nil then
		arg_10_0:RegisterClick(handler(arg_10_0, arg_10_0.DefaultClickFunc))
	end
end

return var_0_0
