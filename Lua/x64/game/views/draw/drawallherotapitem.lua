local var_0_0 = class("DrawAllHeroTapItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = arg_3_0.controllerEx_:GetController("select")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		arg_4_0.clickCallback_(arg_4_0.tapID_)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.tapID_ = arg_6_1

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0

	if arg_7_0.tapID_ ~= -1 then
		var_7_0 = HeroTools.GetSkillAttributeIcon(arg_7_0.tapID_)
	else
		var_7_0 = getSprite("Atlas/BagAtlas", "com_equip_icon_all")
	end

	arg_7_0.icon_1.sprite = var_7_0

	arg_7_0.icon_1:SetNativeSize()

	arg_7_0.icon_2.sprite = var_7_0

	arg_7_0.icon_2:SetNativeSize()
end

function var_0_0.SetSelect(arg_8_0, arg_8_1)
	arg_8_0.selectController_:SetSelectedState(arg_8_1 and "on" or "off")
end

function var_0_0.Show(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.SetClickCallback(arg_10_0, arg_10_1)
	arg_10_0.clickCallback_ = arg_10_1
end

function var_0_0.GetTapID(arg_11_0)
	return arg_11_0.tapID_
end

return var_0_0
