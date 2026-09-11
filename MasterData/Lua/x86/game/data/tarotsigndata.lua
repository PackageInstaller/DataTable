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

function var_0_0:InitTarotData(arg_2_1)
	self.singedAllNum = arg_2_1.divine_sign_info.acc_sign_cnt or 0
	self.signedMonthNum = arg_2_1.divine_sign_info.monthly_sign_cnt or 0
	self.activityID = arg_2_1.divine_sign_info.activity_id
	self.signedAccNum = arg_2_1.divine_sign_info.cycle_sign_cnt or 0
	self.luckyDayList = arg_2_1.divine_sign_info.lucky_index_list

	table.sort(self.luckyDayList)
	Debug.Log("sqjcLucky" .. self.luckyDayList[1] .. self.luckyDayList[2])

	self.cardList = arg_2_1.divine_sign_info.card_id_list
	self.lastSignTime = arg_2_1.divine_sign_info.last_sign_sec or 0
	self.isShowCard = arg_2_1.divine_sign_info.is_show_card
	self.auto = arg_2_1.divine_sign_info.auto_flag
end

function var_0_0:IsAutoSign()
	return self.auto or false
end

function var_0_0.UpdateAutoSign(arg_4_0, arg_4_1)
	arg_4_0.auto = arg_4_1
end

function var_0_0:GetActivityID()
	return self.activityID
end

function var_0_0:GetCardList()
	return self.cardList
end

function var_0_0:GetLastSignTime()
	return self.lastSignTime
end

function var_0_0:GetSignedNum()
	return self.singedAllNum, self.signedMonthNum, self.signedAccNum
end

function var_0_0:GetIsShowCard()
	return self.isShowCard
end

function var_0_0:GetLuckyDayList()
	return self.luckyDayList
end

function var_0_0:GetIsFirstSign()
	return self.lastSignTime == 0
end

function var_0_0:GetIsFirstDay()
	return self.lastSignTime == 0 or self.singedAllNum == 1 and not TarotSignTools.CanSignToday()
end

function var_0_0:AddSingedNum()
	self.singedAllNum = self.singedAllNum + 1
	self.signedMonthNum = self.signedMonthNum + 1
	self.signedAccNum = self.signedAccNum + 1
end

function var_0_0.UpdateLastSignTime(arg_14_0, arg_14_1)
	arg_14_0.lastSignTime = arg_14_1
end

function var_0_0.UpdateIsShowCard(arg_15_0, arg_15_1)
	arg_15_0.isShowCard = arg_15_1
end

return var_0_0
