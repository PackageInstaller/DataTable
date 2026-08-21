local var_0_0 = class("SectionSelectHeroInfo")

function var_0_0.Ctor(arg_1_0)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.heroID = 0
	arg_2_0.trialID = 0
	arg_2_0.isPosLock = false
	arg_2_0.isHeroLock = false
	arg_2_0.heroDataType = HeroConst.HERO_DATA_TYPE.DEFAULT
	arg_2_0.heroViewProxy = HeroViewDataProxy.New(arg_2_0.heroDataType)
	arg_2_0.isAssistant = false
	arg_2_0.assistantInfo = {}
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.heroID = arg_3_1 or 0
	arg_3_0.trialID = arg_3_2 or 0

	arg_3_0:SetPosLock(arg_3_3)
	arg_3_0:SetHeroLock(arg_3_4)
end

function var_0_0.SetHeroDataType(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.heroDataType = arg_4_1 or HeroConst.HERO_DATA_TYPE.DEFAULT
	arg_4_0.heroViewProxy = arg_4_2 or HeroViewDataProxy.New(arg_4_0.heroDataType)
end

function var_0_0.SetAssistantInfo(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.isAssistant = arg_5_1 == true
	arg_5_0.assistantInfo = arg_5_2
end

function var_0_0.SetPosLock(arg_6_0, arg_6_1)
	arg_6_0.isPosLock = arg_6_1 or false
end

function var_0_0.SetHeroLock(arg_7_0, arg_7_1)
	arg_7_0.isHeroLock = arg_7_1 or false
end

function var_0_0.GetHeroPower(arg_8_0)
	return arg_8_0.heroViewProxy:GetBattlePower(arg_8_0.heroID)
end

function var_0_0.GetSkinCfg(arg_9_0)
	return arg_9_0.heroViewProxy:GetHeroUsingSkinInfo(arg_9_0.heroID, {
		arg_9_0.trialID
	})
end

function var_0_0.IsHeroOath(arg_10_0)
	return nullable(arg_10_0.assistantInfo, "hero_oath_display", "oath") or arg_10_0.heroViewProxy:IsHeroOath(arg_10_0.heroID)
end

function var_0_0.GetHeroHP(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = 1
	local var_11_1 = 100

	return var_11_0, var_11_1
end

return var_0_0
