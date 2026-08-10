local var_0_0 = class("IntelligenceSettingToggle", BaseSettingToggle)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.params_ = arg_1_1
end

function var_0_0.GetName(arg_2_0)
	return "Intelligence"
end

function var_0_0.UIClass(arg_3_0)
	local var_3_0 = arg_3_0.params_.stageData

	if var_3_0 and var_3_0:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		return MatrixStageSettingView
	elseif var_3_0 and (var_3_0:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or var_3_0:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX) then
		return MatrixStageSettingView
	else
		return IntelligenceView
	end
end

function var_0_0.GetPath(arg_4_0)
	local var_4_0 = arg_4_0.params_.stageData

	if var_4_0 and var_4_0:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		return "Widget/System/Setting/VariableSettingUI"
	elseif var_4_0 and (var_4_0:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or var_4_0:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX) then
		return "Widget/System/Setting/VariableSettingUI"
	else
		return "Widget/System/Setting/IntelligenceUI"
	end
end

function var_0_0.Order(arg_5_0)
	return 2
end

function var_0_0.RedPointKey(arg_6_0)
	return nil
end

function var_0_0.Image(arg_7_0)
	return getSprite("Atlas/SettingAtlas", "icon_setting09")
end

function var_0_0.GetParams(arg_8_0)
	return arg_8_0.params_
end

function var_0_0.IsSetting(arg_9_0)
	return false
end

return var_0_0
