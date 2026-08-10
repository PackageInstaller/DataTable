local var_0_0 = class("EquipBreakThroughResultInfoView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0.stageData_ = arg_2_1

	arg_2_0:RefreshUI()
end

function var_0_0.OnExit(arg_3_0)
	return
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

	arg_5_0.timeText_.text = manager.time:DescCdTime2(var_5_0)
	arg_5_0.titleText_.text = BattleEquipBreakThroughMaterialStageCfg[arg_5_0.stageData_:GetStageId()].name

	local var_5_1 = arg_5_0.stageData_:GetServerExtant()
	local var_5_2 = EquipBreakThroughMaterialMapCfg[var_5_1]

	arg_5_0.pointText_.text = EquipBreakThroughMaterialPointCfg[var_5_2.stage_type].stage_point[var_5_2.col]

	local var_5_3 = BattleFieldData:GetBattleResultData().buffID

	if var_5_3 == 0 then
		arg_5_0.buffText_.text = ""
	else
		local var_5_4 = EquipBreakThroughMaterialData:GetAttributeList()[var_5_3] or 1
		local var_5_5
		local var_5_6

		if var_5_4 == 1 then
			var_5_5 = 0
			var_5_6 = getAttributeAffixValue(var_5_3, 1)
		else
			var_5_5 = getAttributeAffixValue(var_5_3, var_5_4 - 1)
			var_5_6 = getAttributeAffixValue(var_5_3, var_5_4)
		end

		local var_5_7 = EquipBreakThroughMaterialItemCfg[var_5_3]

		arg_5_0.buffText_.text = string.format(GetI18NText(var_5_7.desc), (var_5_6 - var_5_5) / 10)
	end
end

return var_0_0
