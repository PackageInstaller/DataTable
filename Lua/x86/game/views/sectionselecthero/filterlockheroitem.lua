local var_0_0 = class("ActivityTaskBaseItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0.headIcon_.sprite = HeroTools.GetHeadSprite(arg_2_1)

	arg_2_0.headIcon_:SetNativeSize()
end

return var_0_0
