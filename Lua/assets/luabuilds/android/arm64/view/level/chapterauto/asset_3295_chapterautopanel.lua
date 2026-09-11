local ChapterAutoPanel = class("ChapterAutoPanel", import("view.base.BaseSubView"))

ChapterAutoPanel.TIP_KEY = "CHAPTER_AUTO_HELP_TIP"

function ChapterAutoPanel:getUIName()
	return "ChapterAutoPanel"
end

function ChapterAutoPanel:OnLoaded()
	setText(self.uiTitleText, i18n("auto_battle_headline"))
	setText(self.uiTitleEnText, i18n("auto_battle_headline_en"))
	setText(self.uiStartBtn:Find("Text"), i18n("auto_battle_confirm_button"))
	setText(self.uiTipText, i18n("auto_battle_info_tips"))
	setText(self.uiLeftDescText, i18n("auto_battle_cnt"))
	setText(self.uiRightDescText, i18n("auto_battle_cnt_book"))
	setText(self.uiLeftContentTF:Find("conmuse_time/header"), i18n("auto_battle_time_left"))
	setText(self.uiLeftContentTF:Find("remain_time/header"), i18n("auto_battle_cost_time"))
	setText(self.uiRightContentTF:Find("oil/header"), i18n("auto_battle_cost_extra"))
	setText(self.uiRightContentTF:Find("ticket/header"), i18n("auto_battle_cost_extra"))
	setText(self.uiLeftAddBtn:Find("Text"), i18n("auto_battle_add_time"))
	setText(self.uiLeftProficiencyHeaderText, i18n("auto_battle_class_exp_head"))
	setText(self.uiLeftAwardHeaderText, i18n("auto_battle_base_loot"))
	setText(self.uiRightAwardHeaderText, i18n("auto_battle_extra_loot"))

	self.oilCostTF = self.uiRightContentTF:Find("oil")
	self.ticketCostTF = self.uiRightContentTF:Find("ticket")
	self.awardEmptyTF = self._tf:Find("bottom/drops/frame/empty")

	setText(self.awardEmptyTF:Find("Text"), i18n("auto_battle_extra_loot_lock"))

	self.ticketUIList = UIItemList.New(self.uiTicketTF, self.uiTicketTF:Find("tpl"))
	self.awardUIList = UIItemList.New(self.uiRightAwardContentTF, self.uiRightAwardContentTF:Find("item"))
	self.leftPageUtil = ChapterAutoPageUtil.New(self.uiLeftContentTF:Find("value_bg/left"), self.uiLeftContentTF:Find("value_bg/right"), self.uiLeftContentTF:Find("max"), self.uiLeftContentTF:Find("value_bg/value"))
	self.rightPageUtil = ChapterAutoPageUtil.New(self.uiRightContentTF:Find("value_bg/left"), self.uiRightContentTF:Find("value_bg/right"), self.uiRightContentTF:Find("max"), self.uiRightContentTF:Find("value_bg/value"))
	self.addTimePanel = ChapterAutoAddTimePanel.New(self._tf, self.event, self.contextData)
	self.playerId = getProxy(PlayerProxy):getRawData().id

	return
end

function ChapterAutoPanel:OnInit()
	self.ticketUIList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			setText(arg_4_2:Find("Text"), self.ticketList[arg_4_1 + 1]:GetCount())

			local var_4_0 = self.ticketList[arg_4_1 + 1]:IsForever()

			setActive(arg_4_2:Find("time"), not var_4_0)

			if not var_4_0 then
				local var_4_1 = self.ticketList[arg_4_1 + 1]:GetRemainTime()

				setText(arg_4_2:Find("time/Text"), i18n(var_4_1 > 0 and "auto_battle_book_day" or "auto_battle_book_hour", (math.floor(var_4_1 / (var_4_1 > 0 and 0 or 3600)))))
			end
		end

		return
	end)
	self.awardUIList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			self:UpdateAwardTpl(arg_5_1, arg_5_2)
		end

		return
	end)
	self.leftPageUtil:setNumUpdate(function(arg_6_0)
		self.count = arg_6_0

		self:UpdateLeftContent()

		return
	end)
	self.rightPageUtil:setNumUpdate(function(arg_7_0)
		self.ticketCnt = arg_7_0

		self:UpdateRightContent()

		return
	end)
	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.uiCloseBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.uiLeftAddBtn, function()
		self.addTimePanel:ExecuteAction("Show")

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("auto_battle_help")
		})

		return
	end, SFX_PANEL)

	self.remasterTicketCost = getProxy(ChapterProxy):getRemasterTicketCost()

	return
end

function ChapterAutoPanel:Show()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	ChapterAutoPanel.super.Show(self)

	return
end

function ChapterAutoPanel:Hide()
	ChapterAutoPanel.super.Hide(self)

	if self.addTimePanel and self.addTimePanel:isShowing() then
		self.addTimePanel:Hide()
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function ChapterAutoPanel:Enter(arg_14_1)
	self.chapter = arg_14_1
	self.config = pg.chapter_auto_statistics[arg_14_1.id]
	self.oilCostOnce = self.config.oil_limit
	self.proficiencyOnce = self.config.base_class_exp

	local var_14_0 = getProxy(ChapterAutoProxy)

	self.timeCostOnce = var_14_0:GetRecord(ChapterAutoProxy.TYPE.SLG, arg_14_1.id)
	self.remainTime = var_14_0:GetRemainTime()
	self.storeOil = var_14_0:GetOil()

	setActive(self.uiStoreOilTF, self.storeOil > 0)
	setText(self.uiStoreOilTF:Find("Text"), i18n("auto_battle_oil_store_tip", self.storeOil))

	self.count = self.remainTime >= self.timeCostOnce and 1 or 0
	self.ticketCnt = 0

	self:RefreshTickets()
	self.leftPageUtil:setDefaultNum(self.count)
	self:RefreshLeftPageUtil()
	self:UpdateLeftContent()
	self.rightPageUtil:setDefaultNum(0)
	self:RefreshRightPageUtil()
	self:UpdateRightContent()

	self.awards = ChapterAutoPanel.GetAwards(self.chapter)

	self.awardUIList:align(#self.awards)
	self:Show()

	if self:NeedHelpPop() then
		self:PopHelpTip()
	end

	return
end

function ChapterAutoPanel:RefreshView()
	self:Enter(self.chapter)

	return
end

function ChapterAutoPanel:RefreshLeftPageUtil()
	self.maxCnt = self.remainTime > 0 and math.ceil(self.remainTime / self.timeCostOnce) or 0

	self.leftPageUtil:setMaxNum(self.maxCnt)
	self.leftPageUtil:SetTipInfo({
		self.maxCnt
	}, {
		i18n("auto_battle_time_limit_reached")
	})

	return
end

function ChapterAutoPanel:UpdateLeftContent()
	local var_17_0 = pg.TimeMgr.GetInstance()
	local var_17_1 = var_17_0:DescCDTime(self.remainTime)

	setText(self.uiLeftRemainText, self.remainTime < 0 and setColorStr(var_17_1, COLOR_RED) or var_17_1)
	setText(self.uiLeftConsumeText, var_17_0:DescCDTime(self.timeCostOnce * self.count))
	setText(self.uiLeftProficiencyText, self.proficiencyOnce * self.count)
	self:RefreshRightPageUtil()

	return
end

function ChapterAutoPanel:RefreshRightPageUtil()
	self.maxTicketCnt = math.min(self.ownTicketCnt, self.count)

	self.rightPageUtil:setMaxNum(self.maxTicketCnt)
	self.rightPageUtil:SetTipInfo({
		self.count,
		self.ownTicketCnt
	}, {
		i18n("auto_battle_book_times_reached"),
		i18n("auto_battle_book_max_reached")
	})
	self.rightPageUtil:setCurNum(math.min(self.ticketCnt, self.maxTicketCnt))

	return
end

function ChapterAutoPanel:RefreshTickets()
	local var_19_0 = getProxy(ChapterAutoProxy)

	self.ticketList = var_19_0:GetTicketListByType(ChapterAutoTicket.TYPE.MAIN)

	table.sort(self.ticketList, CompareFuncs({
		function(arg_20_0)
			return arg_20_0.id
		end
	}))
	self.ticketUIList:align(#self.ticketList)

	self.ownTicketCnt = var_19_0:GetValidTicketCntByType(ChapterAutoTicket.TYPE.MAIN)

	return
end

function ChapterAutoPanel:UpdateRightContent()
	local var_21_0 = self.ticketCnt <= 0
	local var_21_1 = i18n("auto_battle_cost_oil", self.oilCostOnce * self.ticketCnt)
	local var_21_2 = self.oilCostOnce * self.ticketCnt - self.storeOil > getProxy(PlayerProxy):getRawData().oil

	if var_21_2 then
		var_21_1 = string.gsub(var_21_1, "#92fc63", COLOR_RED)
	end

	setText(self.uiRightCostOilText, var_21_0 and "" or var_21_1)

	local var_21_3 = i18n("auto_battle_cost_book", self.ticketCnt)
	local var_21_4 = self.ticketCnt > self.ownTicketCnt

	if self.ticketCnt > self.ownTicketCnt then
		var_21_3 = string.gsub(var_21_3, "#92fc63", COLOR_RED)
	end

	setText(self.uiRightCostTicketText, var_21_0 and "" or var_21_3)
	setActive(self.awardEmptyTF, var_21_0)
	setActive(self.oilCostTF:Find("empty"), var_21_0)
	setActive(self.ticketCostTF:Find("empty"), var_21_0)

	GetOrAddComponent(self.oilCostTF, typeof(CanvasGroup)).alpha = var_21_0 and 0.5 or 1
	GetOrAddComponent(self.ticketCostTF, typeof(CanvasGroup)).alpha = var_21_0 and 0.5 or 1

	onButton(self, self.uiStartBtn, function()
		if self.count <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auto_battle_times_zero"))

			return
		end

		if var_21_2 or var_21_4 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auto_battle_not_enough_resource"))

			return
		end

		local var_22_0 = getProxy(ChapterProxy)
		local var_22_1 = var_22_0:getMapById(self.chapter:getConfig("map")):isRemaster()

		if var_22_1 and var_22_0.remasterTickets < self.ticketCnt * self.remasterTicketCost then
			pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_remaster_tickets_not_enough"))

			return
		end

		self:OnStart(var_22_1)

		return
	end, SFX_PANEL)

	return
end

function ChapterAutoPanel:OnStart(arg_23_1)
	seriesAsync({
		function(arg_24_0)
			if arg_23_1 and self.ticketCnt > 0 then
				if PlayerPrefs.GetString("remaster_tip") ~= pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d") then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						showStopRemind = true,
						content = i18n("levelScene_activate_remaster_auto", self.ticketCnt * self.remasterTicketCost),
						onYes = function()
							if pg.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
								PlayerPrefs.SetString("remaster_tip", pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d"))
							end

							arg_24_0()

							return
						end
					})

					return
				end
			end

			arg_24_0()

			return
		end
	}, function()
		pg.m02:sendNotification(GAME.START_CHAPTER_AUTO, {
			type = ChapterAutoProxy.TYPE.SLG,
			id = self.chapter.id,
			num = self.count,
			ticketNum = self.ticketCnt
		})

		return
	end)

	return
end

function ChapterAutoPanel:UpdateAwardTpl(arg_27_1, arg_27_2)
	local var_27_0 = Drop.Create(self.awards[arg_27_1 + 1])

	updateDrop(arg_27_2, var_27_0)
	onButton(self, arg_27_2, function()
		if ({
			[99] = true
		})[var_27_0:getConfig("type")] then
			self:emit(LevelMediator2.GET_CHAPTER_DROP_SHIP_LIST, self.chapter.id, function(arg_29_0)
				local var_29_0 = {}

				for iter_29_0, iter_29_1 in ipairs((var_27_0:getConfig("display_icon"))) do
					local var_29_1 = iter_29_1[2]

					var_29_0[#var_29_0 + 1] = {
						type = iter_29_1[1],
						id = iter_29_1[2],
						anonymous = iter_29_1[1] == DROP_TYPE_SHIP and not table.contains(arg_29_0, var_29_1)
					}
				end

				self:emit(BaseUI.ON_DROP_LIST, {
					item2Row = true,
					itemList = var_29_0,
					content = var_27_0:getConfig("display")
				})

				return
			end)
		else
			self:emit(BaseUI.ON_DROP, var_27_0)
		end

		return
	end, SFX_PANEL)

	return
end

function ChapterAutoPanel:OnDestroy()
	if self.addTimePanel ~= nil then
		self.addTimePanel:Destroy()

		self.addTimePanel = nil
	end

	self.leftPageUtil:Dispose()
	self.rightPageUtil:Dispose()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function ChapterAutoPanel:NeedHelpPop()
	return PlayerPrefs.GetInt(ChapterAutoPanel.TIP_KEY .. "_" .. self.playerId, 0) == 0
end

function ChapterAutoPanel:PopHelpTip()
	PlayerPrefs.SetInt(ChapterAutoPanel.TIP_KEY .. "_" .. self.playerId, 1)
	PlayerPrefs.Save()
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		type = MSGBOX_TYPE_HELP,
		helps = i18n("auto_battle_help")
	})

	return
end

function ChapterAutoPanel:GetAwards()
	local var_33_0 = LevelInfoView.getChapterAwards(self)

	if type(pg.chapter_auto_statistics[self.id].drop_display_extra) == "table" then
		for iter_33_0, iter_33_1 in ipairs(pg.chapter_auto_statistics[self.id].drop_display_extra) do
			table.insert(var_33_0, {
				iter_33_1[1],
				iter_33_1[2]
			})
		end
	end

	return var_33_0
end

return ChapterAutoPanel
