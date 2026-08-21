local var_0_0 = class("RechargeTitleItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
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

	arg_3_0.controller = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "select")
	arg_3_0.selectLock = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "select_lock")
	arg_3_0.upSelectLock = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "upselect_lock")
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0.data = arg_4_1
	arg_4_0.index = arg_4_2
	arg_4_0.callback = arg_4_3
	arg_4_0.shopId = arg_4_4

	arg_4_0:UpdateView()
end

function var_0_0.UpdateView(arg_5_0)
	return
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.clickBtn_, nil, function()
		if arg_6_0.callback then
			arg_6_0.callback(arg_6_0.index)
		end
	end)
end

function var_0_0.UpdateView(arg_8_0)
	arg_8_0.nameTxt1_.text = arg_8_0.data.remark
	arg_8_0.nameTxt2_.text = arg_8_0.data.remark

	local var_8_0 = ShopTools.IsPC() and ShopConst.PC_LOCK_SHOP[arg_8_0.shopId] and ShopTools.IsLimitRecharge() or not ShopTools.CheckShopIsUnLock(arg_8_0.shopId)

	arg_8_0.selectLock:SetSelectedState(var_8_0 and "on" or "off")
	arg_8_0.upSelectLock:SetSelectedState(var_8_0 and "on" or "off")
end

return var_0_0
