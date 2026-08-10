local var_0_0 = class("QWorldMainMenuItemBase", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.mainView = arg_1_2
	arg_1_0.systemId = arg_1_3

	arg_1_0:Init()
	arg_1_0:AddListeners()
end

function var_0_0.BindRed(arg_2_0)
	return
end

function var_0_0.UnBindRed(arg_3_0)
	return
end

function var_0_0.GetIcon(arg_4_0)
	return getSpriteWithoutAtlas("TextureConfig/SandPlay/MainIcon/" .. SandPlaySystemCfg[arg_4_0.systemId].icon)
end

function var_0_0.OnBtnClick(arg_5_0)
	return
end

function var_0_0.Init(arg_6_0)
	arg_6_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.m_clickBtn, nil, function()
		arg_7_0:OnBtnClick()
	end)
end

function var_0_0.Render(arg_9_0)
	arg_9_0:UnBindRed()
	arg_9_0:BindRed()

	arg_9_0.icon_.sprite = arg_9_0:GetIcon()
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:UnBindRed()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
