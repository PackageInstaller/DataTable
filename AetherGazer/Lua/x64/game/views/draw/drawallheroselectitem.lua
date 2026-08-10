local var_0_0 = class("DrawAllHeroSelectItem", ReduxView)

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

	arg_3_0.selectCon_ = arg_3_0.controller_:GetController("selected")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.selfBtn_, nil, function()
		if arg_4_0.clickFunc_ and arg_4_0.heroCfg_ then
			arg_4_0.clickFunc_(arg_4_0.heroCfg_.id)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.lookBtn_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = arg_4_0.heroID_
		})
	end)
end

function var_0_0.SetHeroID(arg_7_0, arg_7_1)
	arg_7_0.heroID_ = arg_7_1
	arg_7_0.heroCfg_ = HeroCfg[arg_7_1]
	arg_7_0.headIcon_.sprite = HeroTools.GetHeadSprite(arg_7_1)

	arg_7_0.headIcon_:SetNativeSize()

	arg_7_0.campLogo_.sprite = HeroTools.GetRaceIcon(arg_7_0.heroCfg_.race)
	arg_7_0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_7_0.heroID_)
	arg_7_0.rareImg_.sprite = HeroTools.GetRareSprite(arg_7_0.heroCfg_.rare)
	arg_7_0.name_.text = GetI18NText(arg_7_0.heroCfg_.name) .. "·" .. GetI18NText(arg_7_0.heroCfg_.suffix)
end

function var_0_0.SetSelected(arg_8_0, arg_8_1)
	arg_8_0.selectCon_:SetSelectedState(tostring(arg_8_1))
end

function var_0_0.RegisterClickListener(arg_9_0, arg_9_1)
	arg_9_0.clickFunc_ = arg_9_1
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllEventListener()

	arg_10_0.clickListener_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
