class = var_0_10000

local var_0_0 = "IslandSignInAgency"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseAgency"))

var_0_1.GIFT_CNT_UPDATE = "IslandSignInAgency:GIFT_CNT_UPDATE"
var_0_1.SIGN_CNT_UPDATE = "IslandSignInAgency:SIGN_CNT_UPDATE"
var_0_1.OTHER_FETCH_CNT_UPDATE = "IslandSignInAgency:OTHER_FETCH_CNT_UPDATE"

function var_0_1.OnInit(arg_1_0, arg_1_1)
	pg = var_1_10002
	arg_1_0.defaultGiftCnt = var_1_10002.island_set.daily_gift_drop_num.key_value_int
	pg = var_2
	arg_1_0.maxFetchCnt = var_2.island_set.daily_gift_get_max.key_value_int

	local var_1_0

	if not arg_1_1.tree_gift_timestamp then
		var_1_0 = 0
	end

	arg_1_0.giftEndTime = var_1_0

	local var_1_1

	if not arg_1_1.tree_gift_count then
		var_1_1 = 0
	end

	arg_1_0.giftCnt = var_1_1
	arg_1_0.inviteList = {}
	ipairs = var_2

	local var_1_2

	if not arg_1_1.tree_gift_invited then
		var_1_2 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_2) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.inviteList, iter_1_1)
	end

	arg_1_0.fetchedList = {}

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.UpdateFetchedList
	local var_1_5

	if not arg_1_1.tree_gift_visitor then
		var_1_5 = {}
	end

	var_1_4(var_1_3, var_1_5)

	arg_1_0.fetchCnt = 0
	arg_1_0.otherFetchCnt = 0
	arg_1_0.signInCnt = 0

	return
end

function var_0_1.UpdateGiftEndTime(arg_2_0, arg_2_1)
	arg_2_0.giftEndTime = arg_2_1

	return
end

function var_0_1.IsMaxFetchCnt(arg_3_0)
	return arg_3_0.otherFetchCnt >= arg_3_0:GetMaxOtheFetchcnt()
end

function var_0_1.InInInviteList(arg_4_0, arg_4_1)
	table = var_1_10002

	return var_1_10002.contains(arg_4_0.inviteList, arg_4_1)
end

function var_0_1.InitPrivateData(arg_5_0, arg_5_1)
	ipairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_1.daily_list) do
		local var_5_0 = iter_5_1.key

		IslandConst = var_1_10008

		if var_5_0 == var_1_10008.DL_SIGNINSYS_FETCH_CNT then
			arg_5_0.fetchCnt = iter_5_1.value
		else
			local var_5_1 = iter_5_1.key

			IslandConst = var_1_10008

			if var_5_1 == var_1_10008.DL_SIGNINSYS_OTHER_FETCH_CNT then
				arg_5_0.otherFetchCnt = iter_5_1.value
			else
				local var_5_2 = iter_5_1.key

				IslandConst = var_1_10008

				if var_5_2 == var_1_10008.DL_SIGNINSYS_CNT then
					arg_5_0.signInCnt = iter_5_1.value
				end
			end
		end
	end

	return
end

function var_0_1.UpdateFetchedList(arg_6_0, arg_6_1)
	arg_6_0.fetchedList = {}

	for iter_6_0 = 1, arg_6_0.defaultGiftCnt do
		local var_6_0 = arg_6_0.fetchedList
		local var_6_1

		if not arg_6_1[iter_6_0] then
			var_6_1 = -1
		end

		var_6_0[iter_6_0] = var_6_1
	end

	return
end

function var_0_1.SetGiftCnt(arg_7_0, arg_7_1)
	arg_7_0.giftCnt = arg_7_1

	arg_7_0:DispatchEvent(var_0_1.GIFT_CNT_UPDATE, arg_7_0.giftCnt)

	return
end

function var_0_1.GetGiftCnt(arg_8_0)
	return arg_8_0.giftCnt
end

function var_0_1.GetGiftModel(arg_9_0)
	pg = var_1_10001

	return var_1_10001.island_unit_item[var_0_1.AGORA_GIFT_ID].model
end

function var_0_1.CanSignIn(arg_10_0)
	return arg_10_0.signInCnt == 0
end

function var_0_1.MarkSignIn(arg_11_0)
	arg_11_0:UpdateSignInCnt(1)
	arg_11_0:UpdateFetchedList({})
	arg_11_0:SetGiftCnt(arg_11_0.defaultGiftCnt)

	return
end

function var_0_1.UpdateSignInCnt(arg_12_0, arg_12_1)
	arg_12_0.signInCnt = arg_12_1

	arg_12_0:DispatchEvent(var_0_1.SIGN_CNT_UPDATE, arg_12_0.signInCnt)

	return
end

function var_0_1.SetFetchCnt(arg_13_0)
	arg_13_0.fetchCnt = 1

	return
end

function var_0_1.SetOtherFetchCnt(arg_14_0)
	local var_14_0 = arg_14_0.otherFetchCnt + 1

	arg_14_0:UpdateOtherFetchCnt(var_14_0)

	return
end

function var_0_1.UpdateOtherFetchCnt(arg_15_0, arg_15_1)
	arg_15_0.otherFetchCnt = arg_15_1

	arg_15_0:DispatchEvent(var_0_1.OTHER_FETCH_CNT_UPDATE)

	return
end

function var_0_1.GetLeftOtherFetchCnt(arg_16_0)
	return arg_16_0:GetMaxOtheFetchcnt() - arg_16_0.otherFetchCnt
end

function var_0_1.GetMaxOtheFetchcnt(arg_17_0)
	local var_17_0 = arg_17_0:GetHost()
	local var_17_1 = var_1.GetAblityAgency(var_17_0)
	local var_17_2 = var_1.GetSignInGiftAddition(var_17_1)

	return arg_17_0.maxFetchCnt + var_17_2
end

function var_0_1.CanInvite(arg_18_0)
	return arg_18_0.fetchCnt > 0
end

function var_0_1.IsSigned(arg_19_0)
	return arg_19_0.signInCnt > 0
end

function var_0_1.CanSelectGift(arg_20_0)
	return not arg_20_0:CanSignIn() and arg_20_0.fetchCnt == 0
end

function var_0_1.IsExpiration(arg_21_0)
	local var_21_0 = arg_21_0.giftEndTime

	pg = var_1_10002

	local var_21_1 = var_1_10002.TimeMgr.GetInstance()

	return var_21_0 <= var_2.GetServerTime(var_21_1)
end

function var_0_1.CanSelectGiftInPos(arg_22_0, arg_22_1)
	if not arg_22_0:CanSelectGift() then
		return false
	end

	if arg_22_1 <= 0 or arg_22_1 > arg_22_0.defaultGiftCnt then
		return false
	end

	return arg_22_0.fetchedList[arg_22_1] == 0
end

function var_0_1.Visible(arg_23_0, arg_23_1)
	if arg_23_1 <= 0 or arg_23_1 > arg_23_0.defaultGiftCnt then
		return false
	end

	return arg_23_0.fetchedList[arg_23_1] == 0
end

function var_0_1.IsOutRange(arg_24_0, arg_24_1)
	return arg_24_1 <= 0 or arg_24_1 > arg_24_0.defaultGiftCnt
end

function var_0_1.IsFetched(arg_25_0, arg_25_1)
	table = var_1_10002

	return var_1_10002.contains(arg_25_0.fetchedList, arg_25_1)
end

function var_0_1.GetNextCanSignInTime(arg_26_0)
	if arg_26_0:CanSignIn() then
		return 0
	else
		GetZeroTime = var_1

		return var_1()
	end

	return
end

function var_0_1.IsInvited(arg_27_0, arg_27_1)
	table = var_1_10002

	return var_1_10002.contains(arg_27_0.inviteList, arg_27_1)
end

function var_0_1.AddInviter(arg_28_0, arg_28_1)
	if not arg_28_0:IsInvited(arg_28_1) then
		table = var_2

		var_2.insert(arg_28_0.inviteList, arg_28_1)
	end

	return
end

function var_0_1.ResetSignInCnt(arg_29_0)
	arg_29_0:UpdateSignInCnt(0)

	arg_29_0.fetchCnt = 0

	arg_29_0:UpdateOtherFetchCnt(0)

	arg_29_0.inviteList = {}

	arg_29_0:DispatchEvent(var_0_1.SIGN_CNT_UPDATE, arg_29_0.signInCnt)

	return
end

return var_0_1
