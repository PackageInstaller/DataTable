local var_0_0 = class("ActivitySkinDrawPoolItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectCon_ = arg_3_0.controllerEx_:GetController("select")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickFunc_ then
			arg_4_0.clickFunc_(arg_4_0, arg_4_0.poolId_, arg_4_0.index_)
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.info_ = arg_7_1
	arg_7_0.poolId_ = arg_7_1.pool_id
	arg_7_0.index_ = arg_7_2

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.textPoolName_.text = arg_8_0.info_.pool_name

	if arg_8_0.textPoolNameSelect_ then
		arg_8_0.textPoolNameSelect_.text = arg_8_0.info_.pool_name
	end

	if arg_8_0.imgSign_ and arg_8_0.info_.pool_sign ~= "" then
		arg_8_0.imgSign_.sprite = pureGetSpriteWithoutAtlas(arg_8_0.info_.pool_sign)
	end

	if arg_8_0.info_.poll_picture_select ~= "" then
		arg_8_0.imgSelect_.sprite = pureGetSpriteWithoutAtlas(arg_8_0.info_.poll_picture_select)
	end

	if arg_8_0.info_.poll_picture ~= "" then
		arg_8_0.imgUnselect_.sprite = pureGetSpriteWithoutAtlas(arg_8_0.info_.poll_picture)
	end
end

function var_0_0.RegisterClickFunc(arg_9_0, arg_9_1)
	arg_9_0.clickFunc_ = arg_9_1
end

function var_0_0.SelectItem(arg_10_0, arg_10_1)
	arg_10_0.selectCon_:SetSelectedState(arg_10_1 and "select" or "unselect")
end

function var_0_0.GetItemIndex(arg_11_0)
	return arg_11_0.index_
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()
	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
