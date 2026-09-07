local VoiceChatStep = class("VoiceChatStep")

function VoiceChatStep:Ctor(arg_1_1, arg_1_2)
	self.say = arg_1_1.say or ""
	self.voice = arg_1_1.voice
	self.options = arg_1_1.options
	self.waitForClick = arg_1_1.wait or 0
	self.optionFlag = arg_1_1.optionFlag
	self.dispatcher = arg_1_1.dispatcher
	self.shipGroup = arg_1_2

	return
end

function VoiceChatStep:IsSameBranch(arg_2_1)
	return not self.optionFlag or self.optionFlag == arg_2_1
end

function VoiceChatStep:GetSay()
	local var_3_0 = getProxy(ApartmentProxy):getApartment(self.shipGroup)

	return (string.gsub(HXSet.hxLan(self.say), "{dorm3d}", var_3_0 and var_3_0:GetCallName() or self.shipGroup))
end

function VoiceChatStep:GetVoice()
	return self.voice
end

function VoiceChatStep:ExistOption()
	return self.options ~= nil and #self.options > 0
end

function VoiceChatStep:GetOptions()
	return _.map(self.options or {}, function(arg_7_0)
		return {
			HXSet.hxLan(arg_7_0.content),
			arg_7_0.flag
		}
	end)
end

function VoiceChatStep:ExistDispatcher()
	return self.dispatcher ~= nil
end

function VoiceChatStep:GetDispatcher()
	return self.dispatcher
end

function VoiceChatStep:IsRecallDispatcher()
	if not self:ExistDispatcher() then
		return false
	end

	local var_10_0 = self:GetDispatcher()

	return var_10_0.callbackData ~= nil and var_10_0.callbackData.name ~= nil
end

function VoiceChatStep:GetDispatcherRecallName()
	if not self:IsRecallDispatcher() then
		return nil
	end

	return self:GetDispatcher().callbackData.name
end

function VoiceChatStep:ShouldHideUI()
	if not self:IsRecallDispatcher() then
		return false
	end

	return self:GetDispatcher().callbackData.hideUI == true
end

function VoiceChatStep:GetWaitForClickTime()
	return self.waitForClick
end

return VoiceChatStep
