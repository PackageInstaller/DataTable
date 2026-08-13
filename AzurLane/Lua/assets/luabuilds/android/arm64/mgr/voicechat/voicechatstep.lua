class = var_0_10000

local var_0_0 = var_0_10000("VoiceChatStep")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0

	if not arg_1_1.say then
		var_1_0 = ""
	end

	arg_1_0.say = var_1_0
	arg_1_0.voice = arg_1_1.voice
	arg_1_0.options = arg_1_1.options

	local var_1_1

	if not arg_1_1.wait then
		var_1_1 = 0
	end

	arg_1_0.waitForClick = var_1_1
	arg_1_0.optionFlag = arg_1_1.optionFlag
	arg_1_0.dispatcher = arg_1_1.dispatcher
	arg_1_0.shipGroup = arg_1_2

	return
end

function var_0_0.IsSameBranch(arg_2_0, arg_2_1)
	return not arg_2_0.optionFlag or arg_2_0.optionFlag == arg_2_1
end

function var_0_0.GetSay(arg_3_0)
	HXSet = var_1_10001

	local var_3_0 = var_1_10001.hxLan(arg_3_0.say)

	getProxy = var_1_10002
	ApartmentProxy = var_1_10004

	local var_3_1 = var_1_10002(var_1_10004)
	local var_3_2

	if not var_2.getApartment(var_3_1, arg_3_0.shipGroup) or not var_2:GetCallName() then
		var_3_2 = arg_3_0.shipGroup
	end

	string = var_3_1

	return (var_3_1.gsub(var_3_0, "{dorm3d}", var_3_2))
end

function var_0_0.GetVoice(arg_4_0)
	return arg_4_0.voice
end

function var_0_0.ExistOption(arg_5_0)
	return arg_5_0.options ~= nil and #arg_5_0.options > 0
end

function var_0_0.GetOptions(arg_6_0)
	_ = var_1_10001

	local var_6_0 = var_1_10001.map
	local var_6_1

	if not arg_6_0.options then
		var_6_1 = {}
	end

	return var_6_0(var_6_1, function(arg_7_0)
		local var_7_0 = arg_7_0.content

		HXSet = var_2_10002

		local var_7_1 = var_2_10002.hxLan(var_7_0)

		return {
			var_7_1,
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

	return arg_10_0:GetDispatcher().callbackData ~= nil and var_1.callbackData.name ~= nil
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
