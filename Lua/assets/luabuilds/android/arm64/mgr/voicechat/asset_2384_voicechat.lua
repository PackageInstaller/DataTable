local VoiceChat = class("VoiceChat")

function VoiceChat:Ctor(arg_1_1)
	self.bgName = arg_1_1.bgName
	self.shipGroup = arg_1_1.shipGroup
	self.stopBgm = arg_1_1.stopBgm or false
	self.label = arg_1_1.label
	self.steps = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.scripts or {}) do
		table.insert(self.steps, (VoiceChatStep.New(iter_1_1, self.shipGroup)))
	end

	self.branchCode = nil
	self.skipAll = false

	return
end

function VoiceChat:GetBgName()
	return self.bgName
end

function VoiceChat:GetShipName()
	local var_3_0 = ShipGroup.getDefaultShipConfig(self.shipGroup)

	assert(var_3_0, "shipGroup not found:" .. self.shipGroup)

	return var_3_0.name
end

function VoiceChat:MarkSkip()
	self.skipAll = true

	return
end

function VoiceChat:IsSkipAll()
	return self.skipAll == true
end

function VoiceChat:SetBranchCode(arg_6_1)
	self.branchCode = arg_6_1

	return
end

function VoiceChat:GetStepByIndex(arg_7_1)
	if self:IsSkipAll() then
		return nil
	end

	local var_7_0 = self.steps[arg_7_1]

	if not self.steps[arg_7_1] or self.branchCode and not var_7_0:IsSameBranch(self.branchCode) then
		return nil
	end

	return var_7_0
end

function VoiceChat:HasBg()
	return self.bgName ~= nil and self.bgName ~= ""
end

function VoiceChat:ShouldStopBgm()
	return self.stopBgm
end

function VoiceChat:GetLabel()
	return self.label
end

return VoiceChat
