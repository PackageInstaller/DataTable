class = var_0_10000

local var_0_0 = "AuctionGameActivity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.Activity"))

function var_0_1.readyToAchieve(arg_1_0)
	if arg_1_0:isEnd() then
		return false
	end

	local var_1_0

	if not arg_1_0:GetPreorderTip() and not arg_1_0:GetOpenPreorderTip() and not arg_1_0:GetTaskTip() and not arg_1_0:GetAllLocationTip() then
		var_1_0 = arg_1_0:GetReliefTip()
	end

	return var_1_0
end

function var_0_1.GetPreorderTip(arg_2_0)
	getProxy = var_1_10001
	AuctionGameBaseProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
	local var_2_1 = var_1.GetPreorderState(var_2_0)
	local var_2_2 = var_1
	local var_2_3 = var_1.GetPreorderTimestamp(var_2_2)

	pg = var_2_2

	local var_2_4 = var_2_2.TimeMgr.GetInstance()
	local var_2_5 = var_4.GetServerTime(var_2_4)

	if var_2_1 == 1 then
		return false
	end

	pg = var_2_4

	local var_2_6 = var_2_4.TimeMgr.GetInstance()

	if var_5.IsSameDay(var_2_6, var_2_5, arg_2_0.stopTime) then
		return false
	end

	getProxy = var_2_6
	PlayerProxy = var_7

	local var_2_7 = var_2_6(var_7)
	local var_2_8 = var_6.getRawData(var_2_7).id

	pg = var_2_7

	local var_2_9 = var_2_7.TimeMgr.GetInstance()
	local var_2_10 = var_7.STimeDescC

	pg = var_1_10009

	local var_2_11 = var_1_10009.TimeMgr.GetInstance()
	local var_2_12 = var_2_10(var_2_9, var_9.GetServerTime(var_2_11), "%Y/%m/%d")

	PlayerPrefs = var_2_9

	local var_2_13 = var_2_9.GetString

	string = var_9

	return var_2_13(var_9.format("AUCTION_GAME_PREORDER_%s_%s", var_2_8, arg_2_0.id)) ~= var_2_12
end

function var_0_1.SetPreorderTip(arg_3_0)
	getProxy = var_1_10001
	AuctionGameBaseProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)

	if var_1.GetPreorderState(var_3_0) == 1 then
		return
	end

	getProxy = var_3_0
	PlayerProxy = var_1_10004

	local var_3_1 = var_3_0(var_1_10004)
	local var_3_2 = var_3.getRawData(var_3_1).id

	pg = var_3_1

	local var_3_3 = var_3_1.TimeMgr.GetInstance()
	local var_3_4 = var_4.STimeDescC

	pg = var_1_10006

	local var_3_5 = var_1_10006.TimeMgr.GetInstance()
	local var_3_6 = var_3_4(var_3_3, var_6.GetServerTime(var_3_5), "%Y/%m/%d")

	PlayerPrefs = var_3_3

	local var_3_7 = var_3_3.SetString

	string = var_6

	var_3_7(var_6.format("AUCTION_GAME_PREORDER_%s_%s", var_3_2, arg_3_0.id), var_3_6)

	return
end

function var_0_1.GetOpenPreorderTip(arg_4_0)
	getProxy = var_1_10001
	AuctionGameBaseProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)
	local var_4_1 = var_1.GetPreorderState(var_4_0)
	local var_4_2 = var_1
	local var_4_3 = var_1.GetPreorderTimestamp(var_4_2)

	pg = var_4_2

	local var_4_4 = var_4_2.TimeMgr.GetInstance()
	local var_4_5 = var_4.GetServerTime(var_4_4)

	if var_4_1 == 1 and var_4_3 <= var_4_5 then
		return true
	end

	return false
end

function var_0_1.GetTaskTip(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.getConfig(var_5_0, "config_client").taskActID

	getProxy = var_5_0
	ActivityProxy = var_3

	local var_5_2 = var_5_0(var_3)
	local var_5_3

	var_5_3 = var_2.getActivityById(var_5_2, var_5_1) and var_2:readyToAchieve()

	return var_5_3
end

function var_0_1.GetAllLocationTip(arg_6_0)
	ipairs = var_1_10001
	pg = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10001(var_1_10002.auction_session.all) do
		pg = var_1_10006

		if var_1_10006.auction_session[iter_6_1].game_type ~= 0 and arg_6_0:GetLocationTip(iter_6_1) then
			return true
		end
	end

	return false
end

function var_0_1.GetLocationTip(arg_7_0, arg_7_1)
	pg = var_1_10002

	local var_7_0 = var_1_10002.auction_session[arg_7_1]

	getProxy = var_1_10003
	PlayerProxy = var_1_10004

	local var_7_1 = var_1_10003(var_1_10004)
	local var_7_2 = var_3.getRawData(var_7_1).id

	PlayerPrefs = var_7_1

	local var_7_3 = var_7_1.GetInt

	string = var_1_10005

	if var_7_3(var_1_10005.format("AUCTION_GAME_LOCATION_%s_%s_%s", var_7_2, arg_7_0.id, arg_7_1), 0) == 0 then
		AuctionGameTools = var_4

		local var_7_4

		if not (var_4.GetCurrencyCnt() >= var_7_0.threshold) then
			var_7_4 = false
		else
			var_7_4 = true
		end

		return var_7_4
	end
end

function var_0_1.SetLocationTip(arg_8_0, arg_8_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_8_0 = var_1_10002(var_1_10003)
	local var_8_1 = var_2.getRawData(var_8_0).id

	PlayerPrefs = var_8_0

	local var_8_2 = var_8_0.SetInt

	string = var_1_10004

	var_8_2(var_1_10004.format("AUCTION_GAME_LOCATION_%s_%s_%s", var_8_1, arg_8_0.id, arg_8_1), 1)

	return
end

function var_0_1.GetReliefTip(arg_9_0)
	getProxy = var_1_10001
	AuctionGameBaseProxy = var_1_10002

	local var_9_0 = var_1_10001(var_1_10002).gold

	pg = var_1_10003

	if var_9_0 < var_1_10003.gameset.auction_relief_payment_limit.key_value then
		local var_9_1 = var_1.reliefCnt

		pg = var_3

		if var_9_1 < var_3.gameset.auction_relief_payment_count.key_value then
			return true
		end
	end

	return false
end

return var_0_1
