local var_0_0 = class("RechargeSpringFestivalTitleItem", ReduxView)

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

	arg_3_0.selectController_ = arg_3_0.tabCon_:GetController("select")
	arg_3_0.lockController_ = arg_3_0.tabCon_:GetController("lock")
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
		if arg_6_0.callback and not arg_6_0.selectStatus_ then
			arg_6_0.callback(arg_6_0.index)
		end
	end)
end

function var_0_0.UpdateView(arg_8_0)
	arg_8_0.nameTxt1_.text = arg_8_0.data.remark
	arg_8_0.nameTxt2_.text = arg_8_0.data.remark

	local var_8_0 = ShopTools.IsPC() and ShopConst.PC_LOCK_SHOP[arg_8_0.shopId] or not ShopTools.CheckShopIsUnLock(arg_8_0.shopId)

	arg_8_0.lockController_:SetSelectedState(tostring(var_8_0))
end

function var_0_0.ShowSelect(arg_9_0, arg_9_1)
	arg_9_0.selectStatus_ = arg_9_1

	arg_9_0.selectController_:SetSelectedState(arg_9_1 and "select" or "normal")
end

return var_0_0
