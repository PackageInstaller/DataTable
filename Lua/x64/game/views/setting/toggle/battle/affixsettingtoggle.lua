local var_0_0 = class("AffixSettingToggle", BaseSettingToggle)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.params_ = arg_1_1
end

function var_0_0.GetName(arg_2_0)
	return "Affix"
end

function var_0_0.UIClass(arg_3_0)
	local var_3_0 = arg_3_0.params_.stageData

	if var_3_0:GetType() == BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE then
		return SoloChallengeAffixDescriptionView
	elseif var_3_0:GetType() == BattleConst.STAGE_TYPE_NEW.RACE_TRIAL then
		return RaceTrialAffixDescriptionView
	else
		return AffixDescriptionView
	end
end

function var_0_0.GetPath(arg_4_0)
	local var_4_0 = arg_4_0.params_.stageData

	return "Widget/System/Setting/AffixDescriptionUI"
end

function var_0_0.Order(arg_5_0)
	return 16
end

function var_0_0.RedPointKey(arg_6_0)
	return nil
end

function var_0_0.Image(arg_7_0)
	local var_7_0 = arg_7_0.params_.stageData

	return getSprite("Atlas/SettingAtlas", "icon_setting08")
end

function var_0_0.GetParams(arg_8_0)
	return arg_8_0.params_.affixData
end

function var_0_0.IsSetting(arg_9_0)
	return false
end

return var_0_0
