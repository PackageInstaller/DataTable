local ReserveProposalContDataTemplate = class("ReserveProposalContDataTemplate", (import("game.reserve.ReserveContDataTemplate")))

function ReserveProposalContDataTemplate:Ctor(arg_1_1, arg_1_2)
	ReserveProposalContDataTemplate.super.Ctor(self, arg_1_1, arg_1_2)

	self.isTemp = false
	self.name = ""
	self.tags = {}
end

function ReserveProposalContDataTemplate:SetName(arg_2_1)
	self.name = arg_2_1
end

function ReserveProposalContDataTemplate:GetName()
	return self.name
end

function ReserveProposalContDataTemplate:GetIsTemp()
	return self.isTemp
end

function ReserveProposalContDataTemplate:SetIsTemp(arg_5_1)
	self.isTemp = arg_5_1
end

function ReserveProposalContDataTemplate:GetAttributeTagList()
	return self.tags
end

function ReserveProposalContDataTemplate:SetAttributeTagList(arg_7_1)
	self.tags = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		self.tags[#self.tags + 1] = iter_7_1
	end
end

function ReserveProposalContDataTemplate:Reset()
	ReserveProposalContDataTemplate.super.Reset(self)

	self.isTemp = false
	self.name = ""
end

return ReserveProposalContDataTemplate
