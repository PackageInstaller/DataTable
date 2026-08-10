local var_0_0 = class("NorseSurpriseGiftReceiveItem", ReduxView)
local var_0_1 = {
	"第一抽",
	"第二抽",
	"第三抽",
	"第四抽",
	"第五抽"
}

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
	arg_4_0:AddBtnListener(arg_4_0.btn_look, nil, function()
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

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:UpdateView(arg_7_1, arg_7_2)
end

function var_0_0.UpdateView(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.heroId = arg_8_1

	local var_8_0 = HeroCfg[arg_8_0.heroId]
	local var_8_1 = var_8_0.ATK_attribute[1]

	arg_8_0.icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_8_0.heroId)
	arg_8_0.numTxt_.text = var_0_1[arg_8_2]
	arg_8_0.atkImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_8_0.heroId)
	arg_8_0.raceImg_.sprite = HeroTools.GetHeroRaceIcon(arg_8_0.heroId)
	arg_8_0.suffixTxt_.text = GetI18NText(var_8_0.suffix)
	arg_8_0.nameTxt_.text = GetI18NText(var_8_0.name)

	arg_8_0.stateCtrl:SetSelectedIndex(0)
	arg_8_0.heartCtrl:SetSelectedIndex(0)
end

function var_0_0.SetHeart(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if arg_9_0.heroId == iter_9_1 then
			arg_9_0.heartCtrl:SetSelectedIndex(1)

			break
		end
	end
end

function var_0_0.SetSelect(arg_10_0, arg_10_1)
	if arg_10_1.id == arg_10_0.heroId then
		arg_10_0.stateCtrl:SetSelectedIndex(2)
	else
		arg_10_0.stateCtrl:SetSelectedIndex(0)
	end
end

function var_0_0.RegistCallBack(arg_11_0, arg_11_1)
	arg_11_0.clickFunc = arg_11_1
end

function var_0_0.OnEnter(arg_12_0)
	return
end

function var_0_0.OnExit(arg_13_0)
	var_0_0.super.OnExit(arg_13_0)
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)

	arg_14_0.clickFunc = nil
end

return var_0_0
