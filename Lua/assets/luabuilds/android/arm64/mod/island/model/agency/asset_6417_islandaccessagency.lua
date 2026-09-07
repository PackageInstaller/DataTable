local IslandAccessAgency = class("IslandAccessAgency", import(".IslandBaseAgency"))

function IslandAccessAgency:OnInit(arg_1_1)
	self.whiteList = {}
	self.blackList = {}
	self.visitorList = {}
	self.inviteCode = ""
	self.freshInviteCodeFlag = 0
	self.openFlag = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.flag_list) do
		table.insert(self.openFlag, iter_1_1)
	end

	return
end

function IslandAccessAgency:InitPrivateData(arg_2_1)
	self.inviteCode = arg_2_1.invite_code

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.white_list or {}) do
		table.insert(self.whiteList, iter_2_1)
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.black_list or {}) do
		table.insert(self.blackList, iter_2_3)
	end

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.visitor_history or {}) do
		table.insert(self.visitorList, IslandVisitorLog.New(iter_2_5))
	end

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.daily_list) do
		if iter_2_7.key == IslandConst.DL_INVITE_CODE_FLAG then
			self.freshInviteCodeFlag = iter_2_7.value
		end
	end

	return
end

function IslandAccessAgency:GetVisitorLogList()
	return self.visitorList
end

function IslandAccessAgency:AddVisitorLog(arg_4_1)
	table.insert(self.visitorList, arg_4_1)

	return
end

function IslandAccessAgency:isFreshInviteCode()
	return self.freshInviteCodeFlag == 1
end

function IslandAccessAgency:MarkFreshInviteCodeFlag()
	self.freshInviteCodeFlag = 1

	return
end

function IslandAccessAgency:ResetFreshInviteCodeFlag()
	self.freshInviteCodeFlag = 0

	return
end

function IslandAccessAgency:GetInviteCode()
	return self.inviteCode
end

function IslandAccessAgency:SetInviteCode(arg_9_1)
	self.inviteCode = arg_9_1

	return
end

function IslandAccessAgency:GetOpenFlag()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(self.openFlag) do
		table.insert(var_10_0, iter_10_1)
	end

	return var_10_0
end

function IslandAccessAgency:HasOpenFlag(arg_11_1)
	return table.contains(self.openFlag, arg_11_1)
end

function IslandAccessAgency:AddOpenFlag(arg_12_1)
	if self:HasOpenFlag(arg_12_1) then
		return
	end

	table.insert(self.openFlag, arg_12_1)

	return
end

function IslandAccessAgency:RemoveOpenFlag(arg_13_1)
	if not self:HasOpenFlag(arg_13_1) then
		return
	end

	table.removebyvalue(self.openFlag, arg_13_1)

	return
end

function IslandAccessAgency:SetWhiteList(arg_14_1)
	self.whiteList = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		table.insert(self.whiteList, iter_14_1)
	end

	return
end

function IslandAccessAgency:GetWhiteList()
	return self.whiteList
end

function IslandAccessAgency:SetBlackList(arg_16_1)
	self.blackList = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		table.insert(self.blackList, iter_16_1)
	end

	return
end

function IslandAccessAgency:GetBlackList()
	return self.blackList
end

function IslandAccessAgency:AddBlackList(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		if not self:InBlackList(iter_18_1) then
			table.insert(self.blackList, iter_18_1)
		end
	end

	return
end

function IslandAccessAgency:InWhiteList(arg_19_1)
	return table.contains(self.whiteList, arg_19_1)
end

function IslandAccessAgency:InBlackList(arg_20_1)
	return table.contains(self.blackList, arg_20_1)
end

return IslandAccessAgency
