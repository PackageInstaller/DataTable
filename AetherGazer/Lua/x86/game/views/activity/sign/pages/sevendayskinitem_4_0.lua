local var_0_0 = class("SevenDaySkinItem_4_0", ReduxView)

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

	arg_3_0.stateCon_ = arg_3_0.controllerEx_:GetController("state")
	arg_3_0.hightValueCon_ = arg_3_0.controllerEx_:GetController("hightValue")
	arg_3_0.showNameCon_ = arg_3_0.controllerEx_:GetController("showName")
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
	arg_6_0.isResign_ = arg_6_3

	SetActive(arg_6_0.redGo_, arg_6_0.state_ == 1 and not arg_6_0.isResign_)

	if arg_6_3 then
		arg_6_0.stateCon_:SetSelectedIndex(4)
	end

	arg_6_0.itemdata_ = arg_6_1

	if arg_6_0.icon_ then
		arg_6_0.icon_.sprite = ItemTools.getItemSprite(arg_6_0.itemdata_[1])
	end

	if arg_6_0.numTxt_ then
		arg_6_0.numTxt_.text = arg_6_0.itemdata_[2]
	end
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
