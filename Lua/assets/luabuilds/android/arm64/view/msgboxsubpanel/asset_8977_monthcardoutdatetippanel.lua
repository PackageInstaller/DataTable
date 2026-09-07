local MonthCardOutDateTipPanel = class("MonthCardOutDateTipPanel", import(".MsgboxSubPanel"))

function MonthCardOutDateTipPanel.SetMonthCardEndDateLocal()
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

function MonthCardOutDateTipPanel.GetMonthCardEndDate()
	local var_2_0 = getProxy(PlayerProxy):getRawData()

	if not var_2_0 or not var_2_0.id then
		return 0
	end

	return PlayerPrefs.GetInt("MonthCardEndDate" .. var_2_0.id, 0)
end

function MonthCardOutDateTipPanel:SetMonthCardTipDate()
	if not self then
		return
	end

	local var_3_0 = getProxy(PlayerProxy):getRawData()

	if not var_3_0 or not var_3_0.id then
		return
	end

	PlayerPrefs.SetInt("MonthCardTipDate" .. var_3_0.id, self)
	PlayerPrefs.Save()

	return
end

function MonthCardOutDateTipPanel.GetMonthCardTipDate()
	local var_4_0 = getProxy(PlayerProxy):getRawData()

	if not var_4_0 or not var_4_0.id then
		return 0
	end

	return PlayerPrefs.GetInt("MonthCardTipDate" .. var_4_0.id, 0)
end

function MonthCardOutDateTipPanel.SetMonthCardTagDate()
	local var_5_0 = getProxy(PlayerProxy):getRawData()

	if not var_5_0 or not var_5_0.id then
		return
	end

	PlayerPrefs.SetInt("MonthCardTagDate" .. var_5_0.id, (pg.TimeMgr.GetInstance():GetNextTime(0, 0, 0)))
	PlayerPrefs.Save()

	return
end

function MonthCardOutDateTipPanel.GetShowMonthCardTag()
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

function MonthCardOutDateTipPanel:TryShowMonthCardTipPanel()
	local function var_7_0()
		if self then
			self()
		end

		return
	end

	local var_7_1 = MonthCardOutDateTipPanel.GetMonthCardEndDate()

	if var_7_1 == 0 then
		var_7_0()

		return
	end

	local var_7_2 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_7_2 >= var_7_1 - 0 and MonthCardOutDateTipPanel.GetMonthCardTipDate() < var_7_1 - 0 then
		MonthCardOutDateTipPanel.SetMonthCardTipDate(var_7_2)

		local var_7_3 = pg.TimeMgr.GetInstance():STimeDescS(math.min(var_7_2, var_7_1), "*t")
		local var_7_4 = pg.TimeMgr.GetInstance():STimeDescS(var_7_1, "*t")

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			type = MSGBOX_TYPE_MONTH_CARD_TIP,
			title = pg.MsgboxMgr.TITLE_INFORMATION,
			content = i18n(var_7_1 <= var_7_2 and "trade_card_tips2" or "trade_card_tips3", (i18n("trade_card_tips4", var_7_4.year, var_7_4.month, var_7_4.day))),
			dateText = i18n("trade_card_tips4", var_7_3.year, var_7_3.month, var_7_3.day),
			yesText = i18n("trade_card_tips1"),
			onClose = var_7_0,
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

	var_7_0()

	return
end

function MonthCardOutDateTipPanel:getUIName()
	return "Msgbox4MonthCardTip"
end

function MonthCardOutDateTipPanel:Init()
	MonthCardOutDateTipPanel.super.Init(self)
	setText(self._tf:Find("NameText"), pg.ship_data_statistics[312011].name)

	return
end

function MonthCardOutDateTipPanel:UpdateView(arg_12_1)
	self:PreRefresh(arg_12_1)

	rtf(self.viewParent._window).sizeDelta = Vector2.New(960, 685)

	setText(self._tf:Find("Desc"), arg_12_1.content)
	setText(self._tf:Find("Date"), arg_12_1.dateText)
	self:PostRefresh(arg_12_1)

	return
end

return MonthCardOutDateTipPanel
