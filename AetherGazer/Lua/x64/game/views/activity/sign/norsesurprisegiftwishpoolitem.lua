local var_0_0 = class("NorseSurpriseGiftWishPoolItem", ReduxView)

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
	arg_3_0.magnigierCtrl = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("magnigier")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btnLook_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = arg_4_0.heroId
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.btn_add, nil, function()
		JumpTools.OpenPageByJump("norseSurpriseGiftInStockPage")
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0:UpdateView(arg_7_1)
end

function var_0_0.SetDrawState(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		if arg_8_0.heroId == iter_8_1 then
			arg_8_0.stateCtrl:SetSelectedIndex(1)
			arg_8_0.magnigierCtrl:SetSelectedIndex(0)

			break
		end
	end
end

function var_0_0.SetGetState(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_0.heroId == arg_9_1 then
		arg_9_0.stateCtrl:SetSelectedIndex(3)
		arg_9_0.magnigierCtrl:SetSelectedIndex(0)
	end
end

function var_0_0.UpdateView(arg_10_0, arg_10_1)
	arg_10_0.heroId = arg_10_1

	local var_10_0 = HeroCfg[arg_10_0.heroId]
	local var_10_1 = var_10_0.ATK_attribute[1]

	arg_10_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_10_0.heroId)
	arg_10_0.atkImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_10_0.heroId)
	arg_10_0.raceImg_.sprite = HeroTools.GetHeroRaceIcon(arg_10_0.heroId)
	arg_10_0.suffixTxt_.text = GetI18NText(var_10_0.suffix)
	arg_10_0.nameTxt_.text = GetI18NText(var_10_0.name)

	arg_10_0.stateCtrl:SetSelectedIndex(0)
	arg_10_0.magnigierCtrl:SetSelectedIndex(0)
end

function var_0_0.OnEnter(arg_11_0)
	return
end

function var_0_0.OnExit(arg_12_0)
	var_0_0.super.OnExit(arg_12_0)
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
