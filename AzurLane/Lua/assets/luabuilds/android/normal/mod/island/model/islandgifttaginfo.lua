class = var_0_10000

local var_0_0 = var_0_10000("IslandGiftTagInfo")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.playerId = arg_1_1.key
	arg_1_0.endTime = arg_1_1.value1
	arg_1_0.giftCnt = arg_1_1.value2

	return
end

function var_0_0.Flush(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.endTime = arg_2_2
	arg_2_0.giftCnt = arg_2_1

	return
end

function var_0_0.ExistGift(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.TimeMgr.GetInstance()
	local var_3_1 = var_1.GetServerTime(var_3_0)

	return arg_3_0.giftCnt > 0 and var_3_1 < arg_3_0.endTime
end

return var_0_0
