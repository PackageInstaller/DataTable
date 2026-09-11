local ArtifactSettingToggle = class("ArtifactSettingToggle", BaseSettingToggle)

function ArtifactSettingToggle:Ctor(arg_1_1)
	self.params_ = arg_1_1
end

function ArtifactSettingToggle:GetName()
	return "Artifact"
end

function ArtifactSettingToggle:UIClass()
	if self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		return MatrixArtifactSettingView
	elseif self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX then
		return MatrixArtifactSettingView
	elseif self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX then
		return MatrixArtifactSettingView
	elseif self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		return WarChessArtifactSettingView
	end
end

function ArtifactSettingToggle:GetPath()
	return "Widget/System/Setting/InformationSettingUI"
end

function ArtifactSettingToggle:Order()
	return 7
end

function ArtifactSettingToggle:RedPointKey()
	return nil
end

function ArtifactSettingToggle:Image()
	return getSprite("Atlas/SettingAtlas", "icon_setting08")
end

function ArtifactSettingToggle:GetParams()
	if self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		return MatrixData:GetArtifactList()
	elseif self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX then
		return ActivityMatrixData:GetArtifactList(self.params_.stageData:GetActivityID())
	elseif self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX then
		return StrategyMatrixData:GetArtifactList(self.params_.stageData:GetActivityID())
	elseif self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs((WarChessData:GetArtifactData())) do
			table.insert(var_8_0, {
				id = iter_8_0
			})
		end

		return var_8_0
	end
end

function ArtifactSettingToggle:IsSetting()
	return false
end

return ArtifactSettingToggle
