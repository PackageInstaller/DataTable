local var_0_0 = class("ArtifactSettingToggle", BaseSettingToggle)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.params_ = arg_1_1
end

function var_0_0.GetName(arg_2_0)
	return "Artifact"
end

function var_0_0.UIClass(arg_3_0)
	local var_3_0 = arg_3_0.params_.stageData

	if var_3_0:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		return MatrixArtifactSettingView
	elseif var_3_0:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX then
		return MatrixArtifactSettingView
	elseif var_3_0:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX then
		return MatrixArtifactSettingView
	elseif var_3_0:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		return WarChessArtifactSettingView
	end
end

function var_0_0.GetPath(arg_4_0)
	return "Widget/System/Setting/InformationSettingUI"
end

function var_0_0.Order(arg_5_0)
	return 7
end

function var_0_0.RedPointKey(arg_6_0)
	return nil
end

function var_0_0.Image(arg_7_0)
	return getSprite("Atlas/SettingAtlas", "icon_setting08")
end

function var_0_0.GetParams(arg_8_0)
	local var_8_0 = arg_8_0.params_.stageData

	if var_8_0:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		return MatrixData:GetArtifactList()
	elseif var_8_0:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX then
		return ActivityMatrixData:GetArtifactList(var_8_0:GetActivityID())
	elseif var_8_0:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX then
		return StrategyMatrixData:GetArtifactList(var_8_0:GetActivityID())
	elseif var_8_0:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		local var_8_1 = WarChessData:GetArtifactData()
		local var_8_2 = {}

		for iter_8_0, iter_8_1 in pairs(var_8_1) do
			table.insert(var_8_2, {
				id = iter_8_0
			})
		end

		return var_8_2
	end
end

function var_0_0.IsSetting(arg_9_0)
	return false
end

return var_0_0
