local var_0_0 = class("MoleItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		arg_3_0.clickCallback_(arg_3_0.index_)
	end)
end

function var_0_0.RegisterClick(arg_5_0, arg_5_1)
	arg_5_0.clickCallback_ = arg_5_1
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.index_ = arg_6_1
	arg_6_0.whackMoleID_ = arg_6_2

	local var_6_0 = arg_6_0:GetSprite()

	if var_6_0 then
		arg_6_0.icon_.sprite = var_6_0
	end
end

function var_0_0.GetSprite(arg_7_0)
	return pureGetSpriteWithoutAtlas(ActivityMoleCfg[arg_7_0.whackMoleID_].pitcture_path)
end

return var_0_0
