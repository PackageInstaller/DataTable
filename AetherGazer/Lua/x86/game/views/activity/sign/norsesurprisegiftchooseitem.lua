local var_0_0 = class("NorseSurpriseGiftChooseItem", ReduxView)

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

	arg_3_0.stateCtrl = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("state")
	arg_3_0.heartCtrl = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("heart")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btnLook_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = arg_4_0.heroId
		})
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0:UpdateView(arg_6_1)
end

function var_0_0.UpdateView(arg_7_0, arg_7_1)
	arg_7_0.heroId = arg_7_1

	local var_7_0 = HeroCfg[arg_7_0.heroId]
	local var_7_1 = arg_7_0.heroViewProxy_:GetHeroUsingSkinInfo(arg_7_0.heroId).id

	arg_7_0.headIcon_.sprite = HeroTools.GetHeadSprite(arg_7_0.heroId)
	arg_7_0.atkImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_7_0.heroId)
	arg_7_0.raceImg_.sprite = HeroTools.GetHeroRaceIcon(arg_7_0.heroId)

	arg_7_0.stateCtrl:SetSelectedIndex(0)
	arg_7_0.heartCtrl:SetSelectedIndex(0)
end

function var_0_0.SetHeart(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		if arg_8_0.heroId == iter_8_1 then
			arg_8_0.heartCtrl:SetSelectedIndex(1)

			break
		end
	end
end

function var_0_0.SetDelete(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if arg_9_0.heroId == iter_9_1 then
			arg_9_0.stateCtrl:SetSelectedIndex(1)

			break
		end
	end
end

function var_0_0.SetDraw(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		if arg_10_0.heroId == iter_10_1 then
			arg_10_0.stateCtrl:SetSelectedIndex(2)

			break
		end
	end
end

function var_0_0.SetResultRoleId(arg_11_0, arg_11_1)
	if arg_11_0.heroId == arg_11_1 then
		arg_11_0.stateCtrl:SetSelectedIndex(3)
	end
end

function var_0_0.OnEnter(arg_12_0)
	return
end

function var_0_0.OnExit(arg_13_0)
	var_0_0.super.OnExit(arg_13_0)
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
