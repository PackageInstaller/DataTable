local IntelligenceSettingToggle = class("IntelligenceSettingToggle", BaseSettingToggle)

function IntelligenceSettingToggle:Ctor(arg_1_1)
	self.params_ = arg_1_1
end

function IntelligenceSettingToggle:GetName()
	return "Intelligence"
end

function IntelligenceSettingToggle:UIClass()
	if self.params_.stageData and self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		return MatrixStageSettingView
	elseif self.params_.stageData and (self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX) then
		return MatrixStageSettingView
	else
		return IntelligenceView
	end
end

function IntelligenceSettingToggle:GetPath()
	if self.params_.stageData and self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		return "Widget/System/Setting/VariableSettingUI"
	elseif self.params_.stageData and (self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX) then
		return "Widget/System/Setting/VariableSettingUI"
	else
		return "Widget/System/Setting/IntelligenceUI"
	end
end

function IntelligenceSettingToggle:Order()
	return 2
end

function IntelligenceSettingToggle:RedPointKey()
	return nil
end

function IntelligenceSettingToggle:Image()
	return getSprite("Atlas/SettingAtlas", "icon_setting09")
end

function IntelligenceSettingToggle:GetParams()
	return self.params_
end

function IntelligenceSettingToggle:IsSetting()
	return false
end

return IntelligenceSettingToggle
