local var_0_0 = class("EquipExchangeItem", ShopItemBase)

function var_0_0.Init(arg_1_0)
	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.bgController = arg_2_0.controller_:GetController("bg")
	arg_2_0.starController = arg_2_0.controller_:GetController("star")
	arg_2_0.selectController = arg_2_0.controller_:GetController("sel")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		arg_3_0.callback(arg_3_0.data, arg_3_0.index, arg_3_0)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.data = arg_5_1
	arg_5_0.suitData = arg_5_1[1]

	if arg_5_0.suitData == nil then
		return
	end

	arg_5_0.shopCfg = getShopCfg(arg_5_0.suitData.id)
	arg_5_0.equipCfg = EquipCfg[arg_5_0.shopCfg.give_id]
	arg_5_0.equipData = arg_5_4
	arg_5_0.index = arg_5_2
	arg_5_0.callback = arg_5_3

	arg_5_0:UpdateView()
end

function var_0_0.UpdateView(arg_6_0)
	local var_6_0, var_6_1, var_6_2 = ShopTools.GetPrice(arg_6_0.suitData.id)

	arg_6_0.priceText_.text = var_6_0

	local var_6_3 = arg_6_0.shopCfg.cost_id

	if var_6_3 == 0 then
		var_6_3 = arg_6_0.shopCfg.cheap_cost_id
	end

	if arg_6_0.equipData ~= nil and arg_6_0.equipData[1].id == arg_6_0.data[1].id then
		arg_6_0.selectController:SetSelectedState("true")
	else
		arg_6_0.selectController:SetSelectedState("false")
	end

	arg_6_0.costIcon_.sprite = ItemTools.getItemLittleSprite(var_6_3)

	local var_6_4 = EquipSuitCfg[arg_6_0.equipCfg.suit]

	arg_6_0.nameText_.text = GetI18NText(var_6_4.name)
	arg_6_0.icon_.sprite = getSpriteViaConfig("EquipIcon_s", var_6_4.icon)

	arg_6_0.starController:SetSelectedState(arg_6_0.equipCfg.starlevel)
	arg_6_0.bgController:SetSelectedState(arg_6_0.equipCfg.starlevel)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:UpdateView()
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
	Object.Destroy(arg_9_0.gameObject_)
end

return var_0_0
