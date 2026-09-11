local ReserveProposalTemplate = class("ReserveProposalTemplate", (import("game.reserve.template.ReserveBaseTemplate")))

function ReserveProposalTemplate:UpdateServerData(arg_1_1)
	ReserveProposalTemplate.super.UpdateServerData(self, arg_1_1)

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.data) do
		if self.cont_dic[iter_1_1.cont_id] then
			local var_1_0 = self:GetContDataTemplateById(iter_1_1.cont_id)

			var_1_0:SetName(iter_1_1.name)
			var_1_0:SetAttributeTagList(iter_1_1.tags)
		end
	end
end

function ReserveProposalTemplate:GetProposalContIDList()
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(self.cont_teams) do
		if not iter_2_1.isTemp and iter_2_1:GetName() ~= "" then
			var_2_0[#var_2_0 + 1] = iter_2_1.cont_id
		end
	end

	table.sort(var_2_0, function(arg_3_0, arg_3_1)
		return arg_3_0 < arg_3_1
	end)

	return var_2_0
end

function ReserveProposalTemplate:GetTempContID()
	for iter_4_0 = 1, GameSetting.default_formation_num_max.value[1] + 1 do
		if self.cont_dic[iter_4_0].isTemp then
			return iter_4_0
		end
	end

	return nil
end

function ReserveProposalTemplate:GreateTempContID()
	for iter_5_0 = 1, GameSetting.default_formation_num_max.value[1] + 1 do
		local var_5_0 = self.cont_dic[iter_5_0]

		if not self.cont_dic[iter_5_0] then
			var_5_0 = self:GetContDataTemplateById(iter_5_0)

			var_5_0:SetIsTemp(true)

			return iter_5_0
		elseif var_5_0.isTemp then
			return iter_5_0
		elseif var_5_0:GetName() == "" then
			var_5_0:SetIsTemp(true)

			return iter_5_0
		end
	end

	return GameSetting.default_formation_num_max.value[1] + 1
end

function ReserveProposalTemplate:ConverToValidTempProposalContID(arg_6_1)
	if arg_6_1 <= GameSetting.default_formation_num_max.value[1] then
		return
	end

	local var_6_0 = self:GreateTempContID()

	if var_6_0 ~= arg_6_1 then
		self:CopyContData(var_6_0, self.cont_dic[arg_6_1])
		self.cont_dic[arg_6_1]:SetIsTemp(false)
		self.cont_dic[arg_6_1]:Reset()
	end

	return var_6_0
end

function ReserveProposalTemplate:DeleteProposal(arg_7_1)
	table.remove(self.cont_teams, (table.indexof(self.cont_teams, self.cont_dic[arg_7_1])))

	self.cont_teams[#self.cont_teams + 1] = self.cont_dic[arg_7_1]
end

function ReserveProposalTemplate:GetAttributeTagList(arg_8_1)
	return self:GetContDataTemplateById(arg_8_1):GetAttributeTagList()
end

return ReserveProposalTemplate
