local var_0_0 = class("NorseSurpriseGiftInStockItem", ReduxView)

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
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btnLook_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = arg_4_0.heroId
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.selfBtn_, nil, function()
		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.heroId)
		end
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0:UpdateView(arg_7_1)
end

function var_0_0.UpdateView(arg_8_0, arg_8_1)
	arg_8_0.heroId = arg_8_1

	local var_8_0 = HeroCfg[arg_8_0.heroId].ATK_attribute[1]
	local var_8_1 = arg_8_0.heroViewProxy_:GetHeroUsingSkinInfo(arg_8_0.heroId).id

	arg_8_0.headIcon_.sprite = HeroTools.GetHeadSprite(arg_8_0.heroId)
	arg_8_0.atkImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_8_0.heroId)
	arg_8_0.raceImg_.sprite = HeroTools.GetHeroRaceIcon(arg_8_0.heroId)
end

function var_0_0.SetChoose(arg_9_0, arg_9_1)
	local var_9_0 = 1

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if arg_9_0.heroId == iter_9_1.id then
			var_9_0 = 0
			arg_9_0.heroSortTxt_.text = iter_9_0

			break
		end
	end

	arg_9_0.stateCtrl:SetSelectedState(var_9_0)
end

function var_0_0.RegistCallBack(arg_10_0, arg_10_1)
	arg_10_0.clickFunc = arg_10_1
end

function var_0_0.OnEnter(arg_11_0)
	return
end

function var_0_0.OnExit(arg_12_0)
	var_0_0.super.OnExit(arg_12_0)
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)

	arg_13_0.clickFunc = nil
end

return var_0_0
