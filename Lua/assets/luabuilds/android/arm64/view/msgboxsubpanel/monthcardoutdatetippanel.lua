local var_0_0 = class("MonthCardOutDateTipPanel", import(".MsgboxSubPanel"))

function var_0_0.SetMonthCardEndDateLocal()
	local var_1_0 = getProxy(PlayerProxy):getRawData()

	if not var_1_0 or not var_1_0.id then
		return
	end

	local var_1_1 = var_1_0:getCardById(VipCard.MONTH)

	if not var_1_1 or var_1_1.leftDate == 0 then
		return
	end

	PlayerPrefs.SetInt("MonthCardEndDate" .. var_1_0.id, var_1_1:getLeftDate())
	PlayerPrefs.Save()

	return
end

function var_0_0.GetMonthCardEndDate()
	local var_2_0 = getProxy(PlayerProxy):getRawData()

	if not var_2_0 or not var_2_0.id then
		return 0
	end

	return PlayerPrefs.GetInt("MonthCardEndDate" .. var_2_0.id, 0)
end

function var_0_0.SetMonthCardTipDate(arg_3_0)
	if not arg_3_0 then
		return
	end

	local var_3_0 = getProxy(PlayerProxy):getRawData()

	if not var_3_0 or not var_3_0.id then
		return
	end

	PlayerPrefs.SetInt("MonthCardTipDate" .. var_3_0.id, arg_3_0)
	PlayerPrefs.Save()

	return
end

function var_0_0.GetMonthCardTipDate()
	local var_4_0 = getProxy(PlayerProxy):getRawData()

	if not var_4_0 or not var_4_0.id then
		return 0
	end

	return PlayerPrefs.GetInt("MonthCardTipDate" .. var_4_0.id, 0)
end

function var_0_0.SetMonthCardTagDate()
	local var_5_0 = getProxy(PlayerProxy):getRawData()

	if not var_5_0 or not var_5_0.id then
		return
	end

	local var_5_1 = pg.TimeMgr.GetInstance()

	PlayerPrefs.SetInt("MonthCardTagDate" .. var_5_0.id, (var_5_1:GetNextTime(0, 0, 0)))
	PlayerPrefs.Save()

	return
end

function var_0_0.GetShowMonthCardTag()
	local var_6_0 = getProxy(PlayerProxy):getRawData()

	if not var_6_0 or not var_6_0.id then
		return false
	end

	local var_6_1 = var_6_0:getCardById(VipCard.MONTH)

	if not var_6_1 or var_6_1.leftDate == 0 then
		return false
	end

	local var_6_2 = pg.TimeMgr.GetInstance():GetServerTime()
	local var_6_3 = var_6_1:getLeftDate()

	if var_6_2 < var_6_3 - 0 or var_6_3 < var_6_2 then
		return false
	end

	return var_6_2 > PlayerPrefs.GetInt("MonthCardTagDate" .. var_6_0.id, 0)
end

function var_0_0.TryShowMonthCardTipPanel(arg_7_0)
	local var_7_9000
	local var_7_0 = var_0_0.GetMonthCardEndDate()

	if var_7_0 == 0 then
		(function()
			if arg_7_0 then
				arg_7_0()
			end

			return
		end)()

		return
	end

	local var_7_1 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_7_1 >= var_7_0 - 0 and var_0_0.GetMonthCardTipDate() < var_7_0 - 0 then
		var_0_0.SetMonthCardTipDate(var_7_1)

		local var_7_2 = pg.TimeMgr.GetInstance().STimeDescS(var_7_9000, math.min(var_7_1, var_7_0), "*t")
		local var_7_3 = pg.TimeMgr.GetInstance():STimeDescS(var_7_0, "*t")

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			type = MSGBOX_TYPE_MONTH_CARD_TIP,
			title = pg.MsgboxMgr.TITLE_INFORMATION,
			content = i18n(var_7_0 <= var_7_1 and "trade_card_tips2" or "trade_card_tips3", (i18n("trade_card_tips4", var_7_3.year, var_7_3.month, var_7_3.day))),
			dateText = i18n("trade_card_tips4", var_7_2.year, var_7_2.month, var_7_2.day),
			yesText = i18n("trade_card_tips1"),
			onClose = function()
				if arg_7_0 then
					arg_7_0()
				end

				return
			end,
			onYes = function()
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
					confirmMonthCard = true,
					wrap = ChargeScene.TYPE_DIAMOND
				})

				return
			end
		})

		return
	end

	;(function()
		if arg_7_0 then
			arg_7_0()
		end

		return
	end)()

	return
end

function var_0_0.getUIName(arg_10_0)
	return "Msgbox4MonthCardTip"
end

function var_0_0.Init(arg_11_0)
	var_0_0.super.Init(arg_11_0)
	setText(arg_11_0._tf:Find("NameText"), pg.ship_data_statistics[312011].name)

	return
end

function var_0_0.UpdateView(arg_12_0, arg_12_1)
	arg_12_0:PreRefresh(arg_12_1)

	rtf(arg_12_0.viewParent._window).sizeDelta = Vector2.New(960, 685)

	setText(arg_12_0._tf:Find("Desc"), arg_12_1.content)
	setText(arg_12_0._tf:Find("Date"), arg_12_1.dateText)
	arg_12_0:PostRefresh(arg_12_1)

	return
end

return var_0_0
