local var_0_0 = class("RechargeGiftPopItem", ReduxView)

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

	arg_3_0.commonItem = CommonItemView.New(arg_3_0.iconGo_, true)
	arg_3_0.CommonData = clone(ItemTemplateData)
	arg_3_0.controller = arg_3_0.controller_:GetController("have")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.id = arg_5_1
	arg_5_0.number = arg_5_2
	arg_5_0.count = arg_5_3

	arg_5_0:UpdateView()
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	if arg_6_0.gameObject_ and not isNil(arg_6_0.gameObject_) then
		SetActive(arg_6_0.gameObject_, arg_6_1)
	end
end

function var_0_0.UpdateView(arg_7_0)
	CommonTools.SetCommonData(arg_7_0.commonItem, {
		id = arg_7_0.id,
		clickFun = function(arg_8_0)
			ShowPopItem(POP_ITEM, {
				arg_8_0.id
			})
		end
	}, arg_7_0.CommonData1)

	arg_7_0.limitLabel_.text = "X" .. arg_7_0.number
	arg_7_0.nameLabel_.text = ItemTools.getItemName(arg_7_0.id)

	local var_7_0 = ItemCfg[arg_7_0.id]

	if var_7_0.num_exchange_item then
		arg_7_0.controller:SetSelectedState(tostring(ItemTools.getItemNum(arg_7_0.id) >= var_7_0.limit))
	else
		arg_7_0.controller:SetSelectedState("false")
	end
end

function var_0_0.OnEnter(arg_9_0)
	return
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.commonItem then
		arg_11_0.commonItem:Dispose()

		arg_11_0.commonItem = nil
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
