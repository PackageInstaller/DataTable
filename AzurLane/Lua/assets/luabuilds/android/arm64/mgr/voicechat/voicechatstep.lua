local var_0_0 = class("VoiceChatStep")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.say = arg_1_1.say or ""
	arg_1_0.voice = arg_1_1.voice
	arg_1_0.options = arg_1_1.options
	arg_1_0.waitForClick = arg_1_1.wait or 0
	arg_1_0.optionFlag = arg_1_1.optionFlag
	arg_1_0.dispatcher = arg_1_1.dispatcher
	arg_1_0.shipGroup = arg_1_2

	return
end

function var_0_0.IsSameBranch(arg_2_0, arg_2_1)
	return not arg_2_0.optionFlag or arg_2_0.optionFlag == arg_2_1
end

function var_0_0.GetSay(arg_3_0)
	local var_3_0 = getProxy(ApartmentProxy):getApartment(arg_3_0.shipGroup)
	local var_3_1 = var_3_0 and var_3_0:GetCallName() or arg_3_0.shipGroup

	return (string.gsub(HXSet.hxLan(arg_3_0.say), "{dorm3d}", var_3_1))
end

function var_0_0.GetVoice(arg_4_0)
	return arg_4_0.voice
end

function var_0_0.ExistOption(arg_5_0)
	return arg_5_0.options ~= nil and #arg_5_0.options > 0
end

function var_0_0.GetOptions(arg_6_0)
	local var_6_0 = arg_6_0.options or {}

	return _.map(var_6_0, function(arg_7_0)
		return {
			HXSet.hxLan(arg_7_0.content),
			arg_7_0.flag
		}
	end)
end

function var_0_0.ExistDispatcher(arg_8_0)
	return arg_8_0.dispatcher ~= nil
end

function var_0_0.GetDispatcher(arg_9_0)
	return arg_9_0.dispatcher
end

function var_0_0.IsRecallDispatcher(arg_10_0)
	if not arg_10_0:ExistDispatcher() then
		return false
	end

	local var_10_0 = arg_10_0:GetDispatcher()

	return var_10_0.callbackData ~= nil and var_10_0.callbackData.name ~= nil
end

function var_0_0.GetDispatcherRecallName(arg_11_0)
	if not arg_11_0:IsRecallDispatcher() then
		return nil
	end

	return arg_11_0:GetDispatcher().callbackData.name
end

function var_0_0.ShouldHideUI(arg_12_0)
	if not arg_12_0:IsRecallDispatcher() then
		return false
	end

	return arg_12_0:GetDispatcher().callbackData.hideUI == true
end

function var_0_0.GetWaitForClickTime(arg_13_0)
	return arg_13_0.waitForClick
end

return var_0_0
