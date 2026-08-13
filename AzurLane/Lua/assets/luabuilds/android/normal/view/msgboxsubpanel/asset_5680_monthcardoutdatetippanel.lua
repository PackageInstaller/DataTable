class = var_0_10000

local var_0_0 = "MonthCardOutDateTipPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MsgboxSubPanel"))

function var_0_1.SetMonthCardEndDateLocal()
	getProxy = var_1_10000
	PlayerProxy = var_1_10001

	local var_1_0 = var_1_10000(var_1_10001)

	if not var_0.getRawData(var_1_0) or not var_0.id then
		return
	end

	local var_1_1 = var_0
	local var_1_2 = var_0.getCardById

	VipCard = var_1_10003

	if not var_1_2(var_1_1, var_1_10003.MONTH) or var_1.leftDate == 0 then
		return
	end

	PlayerPrefs = var_1_1

	var_1_1.SetInt("MonthCardEndDate" .. var_0.id, var_1:getLeftDate())

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_1.GetMonthCardEndDate()
	getProxy = var_1_10000
	PlayerProxy = var_1_10001

	local var_2_0 = var_1_10000(var_1_10001)

	if not var_0.getRawData(var_2_0) or not var_0.id then
		return 0
	end

	PlayerPrefs = var_2_0

	return var_2_0.GetInt("MonthCardEndDate" .. var_0.id, 0)
end

function var_0_1.SetMonthCardTipDate(arg_3_0)
	if not arg_3_0 then
		return
	end

	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)

	if not var_1.getRawData(var_3_0) or not var_1.id then
		return
	end

	PlayerPrefs = var_3_0

	var_3_0.SetInt("MonthCardTipDate" .. var_1.id, arg_3_0)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_1.GetMonthCardTipDate()
	getProxy = var_1_10000
	PlayerProxy = var_1_10001

	local var_4_0 = var_1_10000(var_1_10001)

	if not var_0.getRawData(var_4_0) or not var_0.id then
		return 0
	end

	PlayerPrefs = var_4_0

	return var_4_0.GetInt("MonthCardTipDate" .. var_0.id, 0)
end

function var_0_1.SetMonthCardTagDate()
	getProxy = var_1_10000
	PlayerProxy = var_1_10001

	local var_5_0 = var_1_10000(var_1_10001)

	if not var_0.getRawData(var_5_0) or not var_0.id then
		return
	end

	pg = var_5_0

	local var_5_1 = var_5_0.TimeMgr.GetInstance()
	local var_5_2 = var_1.GetNextTime(var_5_1, 0, 0, 0)

	PlayerPrefs = var_5_1

	var_5_1.SetInt("MonthCardTagDate" .. var_0.id, var_5_2)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_1.GetShowMonthCardTag()
	getProxy = var_1_10000
	PlayerProxy = var_1_10001

	local var_6_0 = var_1_10000(var_1_10001)

	if not var_0.getRawData(var_6_0) or not var_0.id then
		return false
	end

	local var_6_1 = var_0
	local var_6_2 = var_0.getCardById

	VipCard = var_1_10003

	if not var_6_2(var_6_1, var_1_10003.MONTH) or var_1.leftDate == 0 then
		return false
	end

	pg = var_6_1

	local var_6_3 = var_6_1.TimeMgr.GetInstance()

	if var_2.GetServerTime(var_6_3) < var_1:getLeftDate() - 0 or var_3 < var_2 then
		return false
	end

	PlayerPrefs = var_4

	return var_2 > var_4.GetInt("MonthCardTagDate" .. var_0.id, 0)
end

function var_0_1.TryShowMonthCardTipPanel(arg_7_0)
	local function var_7_0()
		if arg_7_0 then
			arg_7_0()
		end

		return
	end

	if var_0_1.GetMonthCardEndDate() == 0 then
		var_7_0()

		return
	end

	pg = var_1_10003

	local var_7_1 = var_1_10003.TimeMgr.GetInstance()
	local var_7_2 = var_3.GetServerTime(var_7_1)
	local var_7_3 = var_0_1.GetMonthCardTipDate()

	if var_7_2 >= var_2 - 0 and var_7_3 < var_2 - 0 then
		var_0_1.SetMonthCardTipDate(var_7_2)

		pg = var_5

		local var_7_4 = var_5.TimeMgr.GetInstance()
		local var_7_5 = var_5.STimeDescS

		math = var_1_10007

		local var_7_6 = var_7_5(var_7_4, var_1_10007.min(var_7_2, var_2), "*t")

		i18n = var_7_4

		local var_7_7 = var_7_4("trade_card_tips4", var_7_6.year, var_7_6.month, var_7_6.day)

		pg = var_7

		local var_7_8 = var_7.TimeMgr.GetInstance()
		local var_7_9 = var_7.STimeDescS(var_7_8, var_2, "*t")

		i18n = var_7_8

		local var_7_10 = var_7_8("trade_card_tips4", var_7_9.year, var_7_9.month, var_7_9.day)
		local var_7_11 = var_2 <= var_7_2

		pg = var_10

		local var_7_12 = var_10.MsgboxMgr.GetInstance()
		local var_7_13 = var_10.ShowMsgBox
		local var_7_14 = {
			hideNo = true
		}

		MSGBOX_TYPE_MONTH_CARD_TIP = var_1_10013
		var_7_14.type = var_1_10013
		pg = var_1_10013
		var_7_14.title = var_1_10013.MsgboxMgr.TITLE_INFORMATION
		i18n = var_13
		var_7_14.content = var_13(var_7_11 and "trade_card_tips2" or "trade_card_tips3", var_7_10)
		var_7_14.dateText = var_7_7
		i18n = var_13
		var_7_14.yesText = var_13("trade_card_tips1")
		var_7_14.onClose = var_7_0

		function var_7_14.onYes()
			pg = var_2_10000

			local var_9_0 = var_2_10000.m02
			local var_9_1 = var_0.sendNotification

			GAME = var_2_10002

			local var_9_2 = var_2_10002.GO_SCENE

			SCENE = var_2_10003

			local var_9_3 = var_2_10003.CHARGE
			local var_9_4 = {
				confirmMonthCard = true
			}

			ChargeScene = var_2_10005
			var_9_4.wrap = var_2_10005.TYPE_DIAMOND

			var_9_1(var_9_0, var_9_2, var_9_3, var_9_4)

			return
		end

		var_7_13(var_7_12, var_7_14)

		return
	end

	var_7_0()

	return
end

function var_0_1.getUIName(arg_10_0)
	return "Msgbox4MonthCardTip"
end

function var_0_1.Init(arg_11_0)
	var_0_1.super.Init(arg_11_0)

	setText = var_1

	local var_11_0 = arg_11_0._tf
	local var_11_1 = var_2.Find(var_11_0, "NameText")

	pg = var_11_0

	var_1(var_11_1, var_11_0.ship_data_statistics[312011].name)

	return
end

function var_0_1.UpdateView(arg_12_0, arg_12_1)
	arg_12_0:PreRefresh(arg_12_1)

	rtf = var_2

	local var_12_0 = var_2(arg_12_0.viewParent._window)

	Vector2 = var_3
	var_12_0.sizeDelta = var_3.New(960, 685)
	setText = var_12_0

	local var_12_1 = arg_12_0._tf

	var_12_0(var_3.Find(var_12_1, "Desc"), arg_12_1.content)

	setText = var_12_0

	local var_12_2 = arg_12_0._tf

	var_12_0(var_3.Find(var_12_2, "Date"), arg_12_1.dateText)
	arg_12_0:PostRefresh(arg_12_1)

	return
end

return var_0_1
