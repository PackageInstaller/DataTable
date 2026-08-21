local var_0_0 = class("NorseSurpriseGiftResultsItem", ReduxView)

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

	arg_3_0.heartCtrl = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("heart")
	arg_3_0.stockCtrl = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("Outofstock")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0:UpdateView(arg_5_1)
end

function var_0_0.UpdateView(arg_6_0, arg_6_1)
	arg_6_0.heroId = arg_6_1

	local var_6_0 = HeroCfg[arg_6_1].race
	local var_6_1 = arg_6_0.heroViewProxy_:GetHeroUsingSkinInfo(arg_6_1).id

	arg_6_0.bottomAmountText_.text = 1
	arg_6_0.gradeImage_.sprite = getSprite("Atlas/SystemHeroGradeAtlas", "com_grade_" .. 3)
	arg_6_0.raceImage_.sprite = getSprite("Atlas/SystemGroupAtlas", RaceEffectCfg[var_6_0].icon2)
	arg_6_0.iconImage_.sprite = HeroTools.GetHeadSprite(arg_6_0.heroId)

	arg_6_0.heartCtrl:SetSelectedIndex(1)
	arg_6_0.stockCtrl:SetSelectedIndex(1)
end

function var_0_0.SetHeart(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if arg_7_0.heroId == iter_7_1 then
			arg_7_0.heartCtrl:SetSelectedIndex(0)

			break
		end
	end
end

function var_0_0.SetDelete(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		if arg_8_0.heroId == iter_8_1 then
			arg_8_0.stockCtrl:SetSelectedIndex(0)

			break
		end
	end
end

function var_0_0.OnEnter(arg_9_0)
	return
end

function var_0_0.OnExit(arg_10_0)
	var_0_0.super.OnExit(arg_10_0)
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
