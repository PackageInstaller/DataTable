local var_0_0 = {}

function var_0_0.AddProposal(arg_1_0, arg_1_1)
	manager.net:SendWithLoadingNew(13036, {
		hero_id = arg_1_0,
		proposal_name = arg_1_1
	}, 13037, var_0_0.OnAddProposal)
end

function var_0_0:OnAddProposal(arg_2_1)
	if isSuccess(self.result) then
		ProposalData:AddProposal(arg_2_1.hero_id, arg_2_1.proposal_name, self.proposal_id)
		manager.notify:CallUpdateFunc(ADD_PROPOSAL, self, arg_2_1)
	else
		ShowTips(self.result)
	end
end

function var_0_0.AddProposalCommon(arg_3_0, arg_3_1)
	manager.net:SendWithLoadingNew(13042, {
		equip = arg_3_0,
		proposal_name = arg_3_1
	}, 13043, var_0_0.OnAddProposalCommon)
end

function var_0_0:OnAddProposalCommon(arg_4_1)
	if isSuccess(self.result) then
		ProposalData:AddProposalCommon(arg_4_1.equip, arg_4_1.proposal_name, self.proposal_id)
		manager.notify:CallUpdateFunc(ADD_PROPOSAL, self, arg_4_1)
	else
		ShowTips(self.result)
	end
end

function var_0_0.DeleteProposal(arg_5_0)
	manager.net:SendWithLoadingNew(13040, {
		proposal_id = arg_5_0
	}, 13041, var_0_0.OnDeleteProposal)
end

function var_0_0:OnDeleteProposal(arg_6_1)
	if isSuccess(self.result) then
		ProposalData:DeleteProposal(arg_6_1.proposal_id)
		manager.notify:CallUpdateFunc(DELETE_PROPOSAL, self, arg_6_1)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ModifyProposal(arg_7_0, arg_7_1, arg_7_2)
	manager.net:SendWithLoadingNew(13038, {
		hero_id = 0,
		proposal_name = arg_7_1,
		proposal_id = arg_7_2
	}, 13039, var_0_0.OnModifyProposal)
end

function var_0_0:OnModifyProposal(arg_8_1)
	if isSuccess(self.result) then
		ProposalData:ModifyProposal(arg_8_1.hero_id, arg_8_1.proposal_name, arg_8_1.proposal_id)
		manager.notify:CallUpdateFunc(MODIFY_PROPOSAL, self, arg_8_1)
	else
		ShowTips(self.result)
	end
end

return var_0_0
