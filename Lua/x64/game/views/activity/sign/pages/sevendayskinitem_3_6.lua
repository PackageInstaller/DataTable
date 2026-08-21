local var_0_0 = class("SevenDaySkinItem_3_6", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.id = arg_1_2
	arg_1_0.index = arg_1_3

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateCon_ = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("receive")
	arg_3_0.poCon_ = arg_3_0.pointCon_:GetController("default0")
	arg_3_0.itemGo = CommonItemView.New(arg_3_0.item_, true)
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.state_ == 1 or arg_4_0.isResign_ then
			if arg_4_0.receiveFunc_ then
				arg_4_0.receiveFunc_(arg_4_0.id, arg_4_0.isResign_)
			end
		else
			ShowPopItem(POP_ITEM, arg_4_0.itemdata_)
		end
	end)
end

function var_0_0.RefreshView(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.stateCon_:SetSelectedIndex(arg_6_2)

	arg_6_0.state_ = arg_6_2

	if arg_6_4 >= arg_6_0.index then
		arg_6_0.poCon_:SetSelectedIndex(1)
	else
		arg_6_0.poCon_:SetSelectedIndex(0)
	end

	arg_6_0.isResign_ = arg_6_3

	SetActive(arg_6_0.redGo_, arg_6_0.state_ == 1 and not arg_6_0.isResign_)

	if arg_6_3 then
		arg_6_0.stateCon_:SetSelectedIndex(4)
	end

	arg_6_0.itemdata_ = arg_6_1

	local var_6_0 = clone(ItemTemplateData)

	var_6_0.id = arg_6_1[1]
	var_6_0.number = arg_6_1[2]

	arg_6_0.itemGo:SetData(var_6_0)
end

function var_0_0.RefreshGet(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if iter_7_1 == arg_7_0.id then
			arg_7_0.stateCon_:SetSelectedIndex(2)

			arg_7_0.state_ = 2

			SetActive(arg_7_0.redGo_, arg_7_0.state_ == 1 and not arg_7_0.isResign_)
		end
	end
end

function var_0_0.RegisterClickFunc(arg_8_0, arg_8_1)
	arg_8_0.receiveFunc_ = arg_8_1
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
