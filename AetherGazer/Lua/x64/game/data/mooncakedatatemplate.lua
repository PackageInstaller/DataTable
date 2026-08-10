MoonDelegateDataTemplate = class("MoonDelegateDataTemplate")

function MoonDelegateDataTemplate.Ctor(arg_1_0, arg_1_1)
	arg_1_0:UpdateData(arg_1_1)
end

function MoonDelegateDataTemplate.UpdateData(arg_2_0, arg_2_1)
	arg_2_0.delegateID = arg_2_1.entrust_id
	arg_2_0.targetID = arg_2_1.item_id
	arg_2_0.timestamp = arg_2_1.timestamp
	arg_2_0.isReceived = arg_2_1.is_receive == 1
	arg_2_0.uid = arg_2_1.user_id
	arg_2_0.submiter_uid = arg_2_1.present_id
	arg_2_0.isCompleted = arg_2_0.submiter_uid and arg_2_0.submiter_uid ~= "0"
end

function MoonDelegateDataTemplate.UpdateUserInfo(arg_3_0, arg_3_1)
	arg_3_0.nick = arg_3_1.base_info.nick
	arg_3_0.portrait = arg_3_1.base_info.icon
	arg_3_0.frame = arg_3_1.base_info.icon_frame
	arg_3_0.level = arg_3_1.level
end

MoonPartyUserDataTemplate = class("MoonPartyUserDataTemplate")

function MoonPartyUserDataTemplate.Ctor(arg_4_0, arg_4_1)
	arg_4_0:UpdateData(arg_4_1)
end

function MoonPartyUserDataTemplate.UpdateData(arg_5_0, arg_5_1)
	arg_5_0.uid = arg_5_1.user_id
	arg_5_0.isVisited = arg_5_1.is_visit == 1
end

function MoonPartyUserDataTemplate.UpdateUserInfo(arg_6_0, arg_6_1)
	arg_6_0.nick = arg_6_1.base_info.nick
	arg_6_0.portrait = arg_6_1.base_info.icon
	arg_6_0.frame = arg_6_1.base_info.icon_frame
	arg_6_0.level = arg_6_1.level
end

MoonPartyDataTemplate = class("MoonPartyDataTemplate")

function MoonPartyDataTemplate.Ctor(arg_7_0, arg_7_1)
	arg_7_0:UpdateData(arg_7_1)
end

function MoonPartyDataTemplate.UpdateData(arg_8_0, arg_8_1)
	arg_8_0.partyType = arg_8_1.open_type
	arg_8_0.isOpened = arg_8_0.partyType ~= 0
	arg_8_0.visitNum = arg_8_1.visit_num
	arg_8_0.openTime = arg_8_1.open_time
end

function MoonPartyDataTemplate.Reset(arg_9_0)
	arg_9_0.partyType = 0
	arg_9_0.isOpened = false
	arg_9_0.visitNum = 0
	arg_9_0.closeTiem = 0
end
