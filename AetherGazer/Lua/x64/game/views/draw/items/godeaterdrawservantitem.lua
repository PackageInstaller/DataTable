local var_0_0 = class("GodEaterDrawServantItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.selectController_ = arg_2_0.controller_:GetController("select")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.button_, nil, function()
		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.id_)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.lookBtn_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = arg_4_0.id_
		})
	end)
end

function var_0_0.AddEventListeners(arg_7_0)
	return
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.index_ = arg_8_1
	arg_8_0.id_ = arg_8_2
	arg_8_0.cfg_ = HeroCfg[arg_8_0.id_]

	arg_8_0:UpdateView()
end

function var_0_0.RegistClickFunc(arg_9_0, arg_9_1)
	arg_9_0.clickFunc = arg_9_1
end

function var_0_0.UpdateView(arg_10_0)
	arg_10_0.roleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_10_0.id_)
	arg_10_0.campImg_.sprite = HeroTools.GetHeroRaceIcon(arg_10_0.id_)
	arg_10_0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_10_0.id_)
	arg_10_0.nameText_.text = arg_10_0.cfg_.name
	arg_10_0.suffixText_.text = arg_10_0.cfg_.suffix
end

function var_0_0.RefreshSelect(arg_11_0, arg_11_1)
	if arg_11_1 then
		arg_11_0.selectController_:SetSelectedState("true")
	else
		arg_11_0.selectController_:SetSelectedState("false")
	end
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:AddEventListeners()
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.data_ = nil

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
