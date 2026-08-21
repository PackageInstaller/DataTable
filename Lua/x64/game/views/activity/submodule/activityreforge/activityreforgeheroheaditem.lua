local var_0_0 = class("ActivityReforgeHeroHeadItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.callBack_ then
			arg_4_0.callBack_(arg_4_0.standardHeroID_)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.standardHeroID_ = arg_6_1

	local var_6_0 = HeroStandardSystemCfg[arg_6_0.standardHeroID_]

	arg_6_0.heroImage_.sprite = HeroTools.GetHeadSprite(var_6_0.skin_id)
	arg_6_0.promoteImage_.sprite = getSprite("Atlas/Common", "star_" .. math.floor(var_6_0.star_lv / 100))
end

function var_0_0.SetClickCallBack(arg_7_0, arg_7_1)
	arg_7_0.callBack_ = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.callBack_ = nil

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
