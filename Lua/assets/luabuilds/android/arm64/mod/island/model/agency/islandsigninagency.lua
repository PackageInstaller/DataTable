local var_0_0 = class("IslandSignInAgency", import(".IslandBaseAgency"))

var_0_0.GIFT_CNT_UPDATE = "IslandSignInAgency:GIFT_CNT_UPDATE"
var_0_0.SIGN_CNT_UPDATE = "IslandSignInAgency:SIGN_CNT_UPDATE"
var_0_0.OTHER_FETCH_CNT_UPDATE = "IslandSignInAgency:OTHER_FETCH_CNT_UPDATE"

function var_0_0.OnInit(arg_1_0, arg_1_1)
	arg_1_0.defaultGiftCnt = pg.island_set.daily_gift_drop_num.key_value_int
	arg_1_0.maxFetchCnt = pg.island_set.daily_gift_get_max.key_value_int
	arg_1_0.giftEndTime = arg_1_1.tree_gift_timestamp or 0
	arg_1_0.giftCnt = arg_1_1.tree_gift_count or 0
	arg_1_0.inviteList = {}

	local var_1_0 = arg_1_1.tree_gift_invited or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		table.insert(arg_1_0.inviteList, iter_1_1)
	end

	arg_1_0.fetchedList = {}

	local var_1_1 = arg_1_1.tree_gift_visitor or {}

	arg_1_0:UpdateFetchedList(var_1_1)

	arg_1_0.fetchCnt = 0
	arg_1_0.otherFetchCnt = 0
	arg_1_0.signInCnt = 0

	return
end

function var_0_0.UpdateGiftEndTime(arg_2_0, arg_2_1)
	arg_2_0.giftEndTime = arg_2_1

	return
end

function var_0_0.IsMaxFetchCnt(arg_3_0)
	return arg_3_0.otherFetchCnt >= arg_3_0:GetMaxOtheFetchcnt()
end

function var_0_0.InInInviteList(arg_4_0, arg_4_1)
	return table.contains(arg_4_0.inviteList, arg_4_1)
end

function var_0_0.InitPrivateData(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1.daily_list) do
		if iter_5_1.key == IslandConst.DL_SIGNINSYS_FETCH_CNT then
			arg_5_0.fetchCnt = iter_5_1.value
		elseif iter_5_1.key == IslandConst.DL_SIGNINSYS_OTHER_FETCH_CNT then
			arg_5_0.otherFetchCnt = iter_5_1.value
		elseif iter_5_1.key == IslandConst.DL_SIGNINSYS_CNT then
			arg_5_0.signInCnt = iter_5_1.value
		end
	end

	return
end

function var_0_0.UpdateFetchedList(arg_6_0, arg_6_1)
	arg_6_0.fetchedList = {}

	for iter_6_0 = 1, arg_6_0.defaultGiftCnt do
		arg_6_0.fetchedList[iter_6_0] = arg_6_1[iter_6_0] or -1
	end

	return
end

function var_0_0.SetGiftCnt(arg_7_0, arg_7_1)
	arg_7_0.giftCnt = arg_7_1

	arg_7_0:DispatchEvent(var_0_0.GIFT_CNT_UPDATE, arg_7_0.giftCnt)

	return
end

function var_0_0.GetGiftCnt(arg_8_0)
	return arg_8_0.giftCnt
end

function var_0_0.GetGiftModel(arg_9_0)
	return pg.island_unit_item[var_0_0.AGORA_GIFT_ID].model
end

function var_0_0.CanSignIn(arg_10_0)
	return arg_10_0.signInCnt == 0
end

function var_0_0.MarkSignIn(arg_11_0)
	arg_11_0:UpdateSignInCnt(1)
	arg_11_0:UpdateFetchedList({})
	arg_11_0:SetGiftCnt(arg_11_0.defaultGiftCnt)

	return
end

function var_0_0.UpdateSignInCnt(arg_12_0, arg_12_1)
	arg_12_0.signInCnt = arg_12_1

	arg_12_0:DispatchEvent(var_0_0.SIGN_CNT_UPDATE, arg_12_0.signInCnt)

	return
end

function var_0_0.SetFetchCnt(arg_13_0)
	arg_13_0.fetchCnt = 1

	return
end

function var_0_0.SetOtherFetchCnt(arg_14_0)
	arg_14_0:UpdateOtherFetchCnt(arg_14_0.otherFetchCnt + 1)

	return
end

function var_0_0.UpdateOtherFetchCnt(arg_15_0, arg_15_1)
	arg_15_0.otherFetchCnt = arg_15_1

	arg_15_0:DispatchEvent(var_0_0.OTHER_FETCH_CNT_UPDATE)

	return
end

function var_0_0.GetLeftOtherFetchCnt(arg_16_0)
	return arg_16_0:GetMaxOtheFetchcnt() - arg_16_0.otherFetchCnt
end

function var_0_0.GetMaxOtheFetchcnt(arg_17_0)
	return arg_17_0.maxFetchCnt + arg_17_0:GetHost():GetAblityAgency():GetSignInGiftAddition()
end

function var_0_0.CanInvite(arg_18_0)
	return arg_18_0.fetchCnt > 0
end

function var_0_0.IsSigned(arg_19_0)
	return arg_19_0.signInCnt > 0
end

function var_0_0.CanSelectGift(arg_20_0)
	return not arg_20_0:CanSignIn() and arg_20_0.fetchCnt == 0
end

function var_0_0.IsExpiration(arg_21_0)
	local var_21_0 = pg.TimeMgr.GetInstance()

	return arg_21_0.giftEndTime <= var_21_0:GetServerTime()
end

function var_0_0.CanSelectGiftInPos(arg_22_0, arg_22_1)
	if not arg_22_0:CanSelectGift() then
		return false
	end

	if arg_22_1 <= 0 or arg_22_1 > arg_22_0.defaultGiftCnt then
		return false
	end

	return arg_22_0.fetchedList[arg_22_1] == 0
end

function var_0_0.Visible(arg_23_0, arg_23_1)
	if arg_23_1 <= 0 or arg_23_1 > arg_23_0.defaultGiftCnt then
		return false
	end

	return arg_23_0.fetchedList[arg_23_1] == 0
end

function var_0_0.IsOutRange(arg_24_0, arg_24_1)
	return arg_24_1 <= 0 or arg_24_1 > arg_24_0.defaultGiftCnt
end

function var_0_0.IsFetched(arg_25_0, arg_25_1)
	return table.contains(arg_25_0.fetchedList, arg_25_1)
end

function var_0_0.GetNextCanSignInTime(arg_26_0)
	if arg_26_0:CanSignIn() then
		return 0
	else
		return GetZeroTime()
	end

	return
end

function var_0_0.IsInvited(arg_27_0, arg_27_1)
	return table.contains(arg_27_0.inviteList, arg_27_1)
end

function var_0_0.AddInviter(arg_28_0, arg_28_1)
	if not arg_28_0:IsInvited(arg_28_1) then
		table.insert(arg_28_0.inviteList, arg_28_1)
	end

	return
end

function var_0_0.ResetSignInCnt(arg_29_0)
	arg_29_0:UpdateSignInCnt(0)

	arg_29_0.fetchCnt = 0

	arg_29_0:UpdateOtherFetchCnt(0)

	arg_29_0.inviteList = {}

	arg_29_0:DispatchEvent(var_0_0.SIGN_CNT_UPDATE, arg_29_0.signInCnt)

	return
end

return var_0_0
