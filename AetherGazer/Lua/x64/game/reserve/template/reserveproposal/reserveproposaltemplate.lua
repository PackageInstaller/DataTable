local var_0_0 = import("game.reserve.template.ReserveBaseTemplate")
local var_0_1 = class("ReserveProposalTemplate", var_0_0)

function var_0_1.UpdateServerData(arg_1_0, arg_1_1)
	var_0_1.super.UpdateServerData(arg_1_0, arg_1_1)

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.data) do
		local var_1_0 = iter_1_1.cont_id

		if arg_1_0.cont_dic[var_1_0] then
			local var_1_1 = arg_1_0:GetContDataTemplateById(var_1_0)

			var_1_1:SetName(iter_1_1.name)
			var_1_1:SetAttributeTagList(iter_1_1.tags)
		end
	end
end

function var_0_1.GetProposalContIDList(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.cont_teams) do
		if not iter_2_1.isTemp and iter_2_1:GetName() ~= "" then
			var_2_0[#var_2_0 + 1] = iter_2_1.cont_id
		end
	end

	table.sort(var_2_0, function(arg_3_0, arg_3_1)
		return arg_3_0 < arg_3_1
	end)

	return var_2_0
end

function var_0_1.GetTempContID(arg_4_0)
	local var_4_0 = GameSetting.default_formation_num_max.value[1]

	for iter_4_0 = 1, var_4_0 + 1 do
		if arg_4_0.cont_dic[iter_4_0].isTemp then
			return iter_4_0
		end
	end

	return nil
end

function var_0_1.GreateTempContID(arg_5_0)
	local var_5_0 = GameSetting.default_formation_num_max.value[1]

	for iter_5_0 = 1, var_5_0 + 1 do
		local var_5_1 = arg_5_0.cont_dic[iter_5_0]

		if not var_5_1 then
			var_5_1 = arg_5_0:GetContDataTemplateById(iter_5_0)

			var_5_1:SetIsTemp(true)

			return iter_5_0
		elseif var_5_1.isTemp then
			return iter_5_0
		elseif var_5_1:GetName() == "" then
			var_5_1:SetIsTemp(true)

			return iter_5_0
		end
	end

	return var_5_0 + 1
end

function var_0_1.ConverToValidTempProposalContID(arg_6_0, arg_6_1)
	if arg_6_1 <= GameSetting.default_formation_num_max.value[1] then
		return
	end

	local var_6_0 = arg_6_0:GreateTempContID()

	if var_6_0 ~= arg_6_1 then
		arg_6_0:CopyContData(var_6_0, arg_6_0.cont_dic[arg_6_1])
		arg_6_0.cont_dic[arg_6_1]:SetIsTemp(false)
		arg_6_0.cont_dic[arg_6_1]:Reset()
	end

	return var_6_0
end

function var_0_1.DeleteProposal(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.cont_dic[arg_7_1]
	local var_7_1 = table.indexof(arg_7_0.cont_teams, var_7_0)

	table.remove(arg_7_0.cont_teams, var_7_1)

	arg_7_0.cont_teams[#arg_7_0.cont_teams + 1] = var_7_0
end

function var_0_1.GetAttributeTagList(arg_8_0, arg_8_1)
	return arg_8_0:GetContDataTemplateById(arg_8_1):GetAttributeTagList()
end

return var_0_1
