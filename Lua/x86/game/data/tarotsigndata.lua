local var_0_0 = singletonClass("TarotSignData")

function var_0_0.Init(arg_1_0)
	arg_1_0.singedAllNum = -1
	arg_1_0.signedMonthNum = -1
	arg_1_0.activityID = -1
	arg_1_0.signedAccNum = -1
	arg_1_0.luckyDayList = {}
	arg_1_0.cardList = {}
	arg_1_0.lastSignTime = -1
	arg_1_0.isShowCard = false
end

function var_0_0.InitTarotData(arg_2_0, arg_2_1)
	arg_2_0.singedAllNum = arg_2_1.divine_sign_info.acc_sign_cnt or 0
	arg_2_0.signedMonthNum = arg_2_1.divine_sign_info.monthly_sign_cnt or 0
	arg_2_0.activityID = arg_2_1.divine_sign_info.activity_id
	arg_2_0.signedAccNum = arg_2_1.divine_sign_info.cycle_sign_cnt or 0
	arg_2_0.luckyDayList = arg_2_1.divine_sign_info.lucky_index_list

	table.sort(arg_2_0.luckyDayList)
	Debug.Log("sqjcLucky" .. arg_2_0.luckyDayList[1] .. arg_2_0.luckyDayList[2])

	arg_2_0.cardList = arg_2_1.divine_sign_info.card_id_list
	arg_2_0.lastSignTime = arg_2_1.divine_sign_info.last_sign_sec or 0
	arg_2_0.isShowCard = arg_2_1.divine_sign_info.is_show_card
	arg_2_0.auto = arg_2_1.divine_sign_info.auto_flag
end

function var_0_0.IsAutoSign(arg_3_0)
	return arg_3_0.auto or false
end

function var_0_0.UpdateAutoSign(arg_4_0, arg_4_1)
	arg_4_0.auto = arg_4_1
end

function var_0_0.GetActivityID(arg_5_0)
	return arg_5_0.activityID
end

function var_0_0.GetCardList(arg_6_0)
	return arg_6_0.cardList
end

function var_0_0.GetLastSignTime(arg_7_0)
	return arg_7_0.lastSignTime
end

function var_0_0.GetSignedNum(arg_8_0)
	return arg_8_0.singedAllNum, arg_8_0.signedMonthNum, arg_8_0.signedAccNum
end

function var_0_0.GetIsShowCard(arg_9_0)
	return arg_9_0.isShowCard
end

function var_0_0.GetLuckyDayList(arg_10_0)
	return arg_10_0.luckyDayList
end

function var_0_0.GetIsFirstSign(arg_11_0)
	return arg_11_0.lastSignTime == 0
end

function var_0_0.GetIsFirstDay(arg_12_0)
	return arg_12_0.lastSignTime == 0 or arg_12_0.singedAllNum == 1 and not TarotSignTools.CanSignToday()
end

function var_0_0.AddSingedNum(arg_13_0)
	arg_13_0.singedAllNum = arg_13_0.singedAllNum + 1
	arg_13_0.signedMonthNum = arg_13_0.signedMonthNum + 1
	arg_13_0.signedAccNum = arg_13_0.signedAccNum + 1
end

function var_0_0.UpdateLastSignTime(arg_14_0, arg_14_1)
	arg_14_0.lastSignTime = arg_14_1
end

function var_0_0.UpdateIsShowCard(arg_15_0, arg_15_1)
	arg_15_0.isShowCard = arg_15_1
end

return var_0_0
