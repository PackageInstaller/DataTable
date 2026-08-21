local var_0_0 = import("game.reserve.template.ReserveBaseTemplate")
local var_0_1 = class("ReserveAdvanceTestTemplate", var_0_0)

function var_0_1.GetCharChipBaseID(arg_1_0, arg_1_1)
	if arg_1_1.stageType ~= BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST then
		return var_0_1.super.GetCharChipBaseID(arg_1_0, arg_1_1)
	end

	local var_1_0 = arg_1_0:GetContDataTemplateById(arg_1_1.contID):GetCharChipBaseID(arg_1_1.teamIndex)
	local var_1_1 = arg_1_1.customData.stageID
	local var_1_2 = arg_1_1.customData.activityID
	local var_1_3 = arg_1_0:GetAdvanceTestStageCfg(var_1_2, var_1_1)

	if (var_1_3 and var_1_3.admin_chip_level or -1) == 0 then
		return 0
	end

	return var_1_0
end

function var_0_1.SetCharChipBaseID(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1.stageType ~= BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST then
		return var_0_1.super.GetCharChipBaseID(arg_2_0, arg_2_1)
	end

	return arg_2_0:GetContDataTemplateById(arg_2_1.contID):SetCharChipBaseID(arg_2_2, arg_2_1.teamIndex)
end

function var_0_1.GetCharChipExtraIDList(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1.stageType ~= BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST then
		return var_0_1.super.GetCharChipExtraIDList(arg_3_0, arg_3_1)
	end

	local var_3_0 = arg_3_1.customData.stageID
	local var_3_1 = arg_3_1.customData.activityID
	local var_3_2 = arg_3_0:GetAdvanceTestStageCfg(var_3_1, var_3_0)
	local var_3_3 = var_3_2 and var_3_2.admin_chip_level or -1

	if var_3_3 == -1 then
		return nil
	end

	local var_3_4 = {}

	for iter_3_0, iter_3_1 in ipairs(ChipTools.GetCharChipExtraIDList(arg_3_2)) do
		if iter_3_0 <= var_3_3 - 1 then
			table.insert(var_3_4, iter_3_1)
		end
	end

	return var_3_4
end

function var_0_1.GetAdvanceTestStageCfg(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(AdvanceTestCfg.all) do
		local var_4_0 = AdvanceTestCfg[iter_4_1]

		if var_4_0.activity_id == arg_4_1 and var_4_0.stage_id == arg_4_2 then
			return var_4_0
		end
	end

	return nil
end

return var_0_1
