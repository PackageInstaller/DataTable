local ReserveAdvanceTestTemplate = class("ReserveAdvanceTestTemplate", (import("game.reserve.template.ReserveBaseTemplate")))

function ReserveAdvanceTestTemplate:GetCharChipBaseID(arg_1_1)
	if arg_1_1.stageType ~= BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST then
		return ReserveAdvanceTestTemplate.super.GetCharChipBaseID(self, arg_1_1)
	end

	local var_1_0 = self:GetContDataTemplateById(arg_1_1.contID):GetCharChipBaseID(arg_1_1.teamIndex)
	local var_1_1 = self:GetAdvanceTestStageCfg(arg_1_1.customData.activityID, arg_1_1.customData.stageID)

	if var_1_1 then
		if (var_1_1.admin_chip_level or -1) == 0 then
			return 0
		end
	end

	return var_1_0
end

function ReserveAdvanceTestTemplate:SetCharChipBaseID(arg_2_1, arg_2_2)
	if arg_2_1.stageType ~= BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST then
		return ReserveAdvanceTestTemplate.super.GetCharChipBaseID(self, arg_2_1)
	end

	return self:GetContDataTemplateById(arg_2_1.contID):SetCharChipBaseID(arg_2_2, arg_2_1.teamIndex)
end

function ReserveAdvanceTestTemplate:GetCharChipExtraIDList(arg_3_1, arg_3_2)
	if arg_3_1.stageType ~= BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST then
		return ReserveAdvanceTestTemplate.super.GetCharChipExtraIDList(self, arg_3_1)
	end

	local var_3_0 = self:GetAdvanceTestStageCfg(arg_3_1.customData.activityID, arg_3_1.customData.stageID)
	local var_3_1

	if var_3_0 then
		var_3_1 = var_3_0.admin_chip_level or -1

		if var_3_1 == -1 then
			return nil
		end
	end

	local var_3_2 = {}

	for iter_3_0, iter_3_1 in ipairs(ChipTools.GetCharChipExtraIDList(arg_3_2)) do
		if iter_3_0 <= var_3_1 - 1 then
			table.insert(var_3_2, iter_3_1)
		end
	end

	return var_3_2
end

function ReserveAdvanceTestTemplate:GetAdvanceTestStageCfg(arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(AdvanceTestCfg.all) do
		if AdvanceTestCfg[iter_4_1].activity_id == arg_4_1 and AdvanceTestCfg[iter_4_1].stage_id == arg_4_2 then
			return AdvanceTestCfg[iter_4_1]
		end
	end

	return nil
end

return ReserveAdvanceTestTemplate
