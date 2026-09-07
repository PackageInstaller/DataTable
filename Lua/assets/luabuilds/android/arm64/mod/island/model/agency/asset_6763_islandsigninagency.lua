local IslandSignInAgency = class("IslandSignInAgency", import(".IslandBaseAgency"))

IslandSignInAgency.GIFT_CNT_UPDATE = "IslandSignInAgency:GIFT_CNT_UPDATE"
IslandSignInAgency.SIGN_CNT_UPDATE = "IslandSignInAgency:SIGN_CNT_UPDATE"
IslandSignInAgency.OTHER_FETCH_CNT_UPDATE = "IslandSignInAgency:OTHER_FETCH_CNT_UPDATE"

function IslandSignInAgency:OnInit(arg_1_1)
	self.defaultGiftCnt = pg.island_set.daily_gift_drop_num.key_value_int
	self.maxFetchCnt = pg.island_set.daily_gift_get_max.key_value_int
	self.giftEndTime = arg_1_1.tree_gift_timestamp or 0
	self.giftCnt = arg_1_1.tree_gift_count or 0
	self.inviteList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.tree_gift_invited or {}) do
		table.insert(self.inviteList, iter_1_1)
	end

	self.fetchedList = {}

	self:UpdateFetchedList(arg_1_1.tree_gift_visitor or {})

	self.fetchCnt = 0
	self.otherFetchCnt = 0
	self.signInCnt = 0

	return
end

function IslandSignInAgency:UpdateGiftEndTime(arg_2_1)
	self.giftEndTime = arg_2_1

	return
end

function IslandSignInAgency:IsMaxFetchCnt()
	return self.otherFetchCnt >= self:GetMaxOtheFetchcnt()
end

function IslandSignInAgency:InInInviteList(arg_4_1)
	return table.contains(self.inviteList, arg_4_1)
end

function IslandSignInAgency:InitPrivateData(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1.daily_list) do
		if iter_5_1.key == IslandConst.DL_SIGNINSYS_FETCH_CNT then
			self.fetchCnt = iter_5_1.value
		elseif iter_5_1.key == IslandConst.DL_SIGNINSYS_OTHER_FETCH_CNT then
			self.otherFetchCnt = iter_5_1.value
		elseif iter_5_1.key == IslandConst.DL_SIGNINSYS_CNT then
			self.signInCnt = iter_5_1.value
		end
	end

	return
end

function IslandSignInAgency:UpdateFetchedList(arg_6_1)
	self.fetchedList = {}

	for iter_6_0 = 1, self.defaultGiftCnt do
		self.fetchedList[iter_6_0] = arg_6_1[iter_6_0] or -1
	end

	return
end

function IslandSignInAgency:SetGiftCnt(arg_7_1)
	self.giftCnt = arg_7_1

	self:DispatchEvent(IslandSignInAgency.GIFT_CNT_UPDATE, self.giftCnt)

	return
end

function IslandSignInAgency:GetGiftCnt()
	return self.giftCnt
end

function IslandSignInAgency:GetGiftModel()
	return pg.island_unit_item[IslandSignInAgency.AGORA_GIFT_ID].model
end

function IslandSignInAgency:CanSignIn()
	return self.signInCnt == 0
end

function IslandSignInAgency:MarkSignIn()
	self:UpdateSignInCnt(1)
	self:UpdateFetchedList({})
	self:SetGiftCnt(self.defaultGiftCnt)

	return
end

function IslandSignInAgency:UpdateSignInCnt(arg_12_1)
	self.signInCnt = arg_12_1

	self:DispatchEvent(IslandSignInAgency.SIGN_CNT_UPDATE, self.signInCnt)

	return
end

function IslandSignInAgency:SetFetchCnt()
	self.fetchCnt = 1

	return
end

function IslandSignInAgency:SetOtherFetchCnt()
	self:UpdateOtherFetchCnt(self.otherFetchCnt + 1)

	return
end

function IslandSignInAgency:UpdateOtherFetchCnt(arg_15_1)
	self.otherFetchCnt = arg_15_1

	self:DispatchEvent(IslandSignInAgency.OTHER_FETCH_CNT_UPDATE)

	return
end

function IslandSignInAgency:GetLeftOtherFetchCnt()
	return self:GetMaxOtheFetchcnt() - self.otherFetchCnt
end

function IslandSignInAgency:GetMaxOtheFetchcnt()
	return self.maxFetchCnt + self:GetHost():GetAblityAgency():GetSignInGiftAddition()
end

function IslandSignInAgency:CanInvite()
	return self.fetchCnt > 0
end

function IslandSignInAgency:IsSigned()
	return self.signInCnt > 0
end

function IslandSignInAgency:CanSelectGift()
	return not self:CanSignIn() and self.fetchCnt == 0
end

function IslandSignInAgency:IsExpiration()
	return self.giftEndTime <= pg.TimeMgr.GetInstance():GetServerTime()
end

function IslandSignInAgency:CanSelectGiftInPos(arg_22_1)
	if not self:CanSelectGift() then
		return false
	end

	if arg_22_1 <= 0 or arg_22_1 > self.defaultGiftCnt then
		return false
	end

	return self.fetchedList[arg_22_1] == 0
end

function IslandSignInAgency:Visible(arg_23_1)
	if arg_23_1 <= 0 or arg_23_1 > self.defaultGiftCnt then
		return false
	end

	return self.fetchedList[arg_23_1] == 0
end

function IslandSignInAgency:IsOutRange(arg_24_1)
	return arg_24_1 <= 0 or arg_24_1 > self.defaultGiftCnt
end

function IslandSignInAgency:IsFetched(arg_25_1)
	return table.contains(self.fetchedList, arg_25_1)
end

function IslandSignInAgency:GetNextCanSignInTime()
	if self:CanSignIn() then
		return 0
	else
		return GetZeroTime()
	end

	return
end

function IslandSignInAgency:IsInvited(arg_27_1)
	return table.contains(self.inviteList, arg_27_1)
end

function IslandSignInAgency:AddInviter(arg_28_1)
	if not self:IsInvited(arg_28_1) then
		table.insert(self.inviteList, arg_28_1)
	end

	return
end

function IslandSignInAgency:ResetSignInCnt()
	self:UpdateSignInCnt(0)

	self.fetchCnt = 0

	self:UpdateOtherFetchCnt(0)

	self.inviteList = {}

	self:DispatchEvent(IslandSignInAgency.SIGN_CNT_UPDATE, self.signInCnt)

	return
end

return IslandSignInAgency
