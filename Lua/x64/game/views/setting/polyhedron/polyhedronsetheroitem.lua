local var_0_0 = class("PolyhedronSetHeroItem", ReduxView)

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

	arg_3_0.leaderController = ControllerUtil.GetController(arg_3_0.transform_, "leader")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_btn, nil, function()
		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.id)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.id = arg_6_2

	local var_6_0 = HeroCfg[arg_6_2]

	arg_6_0.n_name.text = var_6_0.name
	arg_6_0.m_suffix.text = var_6_0.suffix

	local var_6_1 = PolyhedronData:GetHeroUsingSkinInfo(arg_6_2).id

	if arg_6_2 == arg_6_1:GetLeaderHeroId() then
		arg_6_0.leaderController:SetSelectedIndex(1)
	else
		arg_6_0.leaderController:SetSelectedIndex(0)
	end

	arg_6_0.m_icon.sprite = HeroTools.GetHeadSprite(var_6_1)

	local var_6_2 = RaceEffectCfg[var_6_0.race]

	arg_6_0.m_campImg.sprite = getSprite("Atlas/CampItemAtlas", var_6_2.icon)
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickFunc = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
