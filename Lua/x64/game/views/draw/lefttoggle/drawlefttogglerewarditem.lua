local var_0_0 = class("DrawLeftToggleRewardItem", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Pool/ExtractReturnMarkNew"
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.gameObject_ = Object.Instantiate(Asset.Load(arg_2_0:UIName()), arg_2_1.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.selectController_ = arg_2_0.controllerEx_:GetController("sel")
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.gameObject_ = nil
	arg_3_0.transfrom_ = nil
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	local var_5_0 = ActivityDrawBonusCfg[arg_5_1]

	arg_5_0.icon_.sprite = getSprite("Atlas/PoolAtlas", var_5_0.pool_tag_img)

	arg_5_0:Show(true)
end

function var_0_0.RefreshSelectState(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.selectController_:SetSelectedState("on")
	else
		arg_6_0.selectController_:SetSelectedState("off")
	end
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

return var_0_0
