local ChapterAutoAddTimePanel = class("ChapterAutoAddTimePanel", import("view.base.BaseSubView"))

ChapterAutoAddTimePanel.GET_SHOW_ID = {
	[ChapterAutoTicket.TYPE.MAIN] = 68710,
	[ChapterAutoTicket.TYPE.TIME] = 68711
}

function ChapterAutoAddTimePanel:getUIName()
	return "ChapterAutoAddTimePanel"
end

function ChapterAutoAddTimePanel:OnLoaded()
	setText(self.uiTitleText, i18n("auto_battle_time_add_headline"))
	setText(self.uiTitleEnText, i18n("auto_battle_time_add_headline_en"))
	setText(self.uiSureBtn:Find("Text"), i18n("auto_battle_time_add_confirm"))
	setText(self.uiCancelBtn:Find("Text"), i18n("auto_battle_time_add_cancel"))

	self.uiList = UIItemList.New(self.uiContent, self.uiContent:Find("tpl"))
	self.type2Second = {}
	self.type2Second[ChapterAutoTicket.TYPE.TIME] = pg.gameset.auto_battle_tickect_to_second_type3.key_value
	self.type2Second[ChapterAutoTicket.TYPE.MAIN] = pg.gameset.auto_battle_tickect_to_second_type1.key_value

	return
end

function ChapterAutoAddTimePanel:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.uiCancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.uiCloseBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.uiSureBtn, function()
		local var_7_0 = self.selectedCntByType[ChapterAutoTicket.TYPE.MAIN] or 0
		local var_7_1 = self.selectedCntByType[ChapterAutoTicket.TYPE.TIME] or 0

		if var_7_0 == 0 and var_7_1 == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auto_battle_time_add_zero_item"))

			return
		end

		pg.m02:sendNotification(GAME.ADD_CHAPTER_AUTO_TIME, {
			type1Num = var_7_0,
			type3Num = var_7_1,
			callback = function()
				self:UpdateData()

				return
			end
		})

		return
	end, SFX_PANEL)
	self.uiList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventInit then
			self:InitTpl(arg_9_1, arg_9_2)
		elseif arg_9_0 == UIItemList.EventUpdate then
			self:UpdateTpl(arg_9_1, arg_9_2)
		end

		return
	end)

	return
end

function ChapterAutoAddTimePanel:Show()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	ChapterAutoAddTimePanel.super.Show(self)
	self:UpdateData()

	return
end

function ChapterAutoAddTimePanel:UpdateData()
	local var_11_0 = getProxy(ChapterAutoProxy)

	self.remainTime = var_11_0:GetRemainTime()
	self.allCntByType = {}
	self.allCntByType[ChapterAutoTicket.TYPE.TIME] = underscore.reduce(var_11_0:GetTicketListByType(ChapterAutoTicket.TYPE.TIME), 0, function(arg_12_0, arg_12_1)
		return arg_12_0 + arg_12_1:GetCount()
	end)
	self.allCntByType[ChapterAutoTicket.TYPE.MAIN] = underscore.reduce(var_11_0:GetTicketListByType(ChapterAutoTicket.TYPE.MAIN), 0, function(arg_13_0, arg_13_1)
		return arg_13_0 + arg_13_1:GetCount()
	end)
	self.showTypes = {
		ChapterAutoTicket.TYPE.MAIN
	}

	if pg.gameset.auto_battle_time_add_item_show_type3.key_value == 1 then
		table.insert(self.showTypes, ChapterAutoTicket.TYPE.TIME)
	end

	self.selectedCntByType = {}

	for iter_11_0, iter_11_1 in pairs(self.showTypes) do
		self.selectedCntByType[iter_11_1] = 0
	end

	self.uiList:align(#self.showTypes)
	self:OnSelCntUpdate()

	return
end

function ChapterAutoAddTimePanel:OnSelCntUpdate()
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(self.showTypes) do
		var_14_0 = var_14_0 + self.type2Second[iter_14_1] * self.selectedCntByType[iter_14_1]
	end

	local var_14_1 = pg.TimeMgr.GetInstance()
	local var_14_2 = i18n("auto_battle_time_add_info", var_14_1:DescCDTime(self.remainTime), var_14_1:DescCDTime(var_14_0))

	if self.remainTime < 0 then
		var_14_2 = string.gsub(var_14_2, "#ffffff", COLOR_RED)
	end

	setText(self.uiTimeText, var_14_2)
	self.uiList:align(#self.showTypes)

	return
end

function ChapterAutoAddTimePanel:InitTpl(arg_15_1, arg_15_2)
	local var_15_0 = self.showTypes[arg_15_1 + 1]
	local var_15_1 = Drop.New({
		type = DROP_TYPE_VITEM,
		id = ChapterAutoAddTimePanel.GET_SHOW_ID[self.showTypes[arg_15_1 + 1]],
		count = self.allCntByType[self.showTypes[arg_15_1 + 1]]
	})

	updateDrop(arg_15_2:Find("IconTpl"), var_15_1, {
		count = self.allCntByType[self.showTypes[arg_15_1 + 1]]
	})
	setScrollText(arg_15_2:Find("name/Text"), var_15_1:getName())
	onButton(self, arg_15_2, function()
		if self.allCntByType[var_15_0] <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auto_battle_time_add_item_lack"))

			return
		end

		if self.selectedCntByType[var_15_0] == self.allCntByType[var_15_0] then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auto_battle_time_add_item_lack"))

			return
		end

		self.selectedCntByType[var_15_0] = self.selectedCntByType[var_15_0] + 1

		self:OnSelCntUpdate()

		return
	end, SFX_PANEL)
	onButton(self, arg_15_2:Find("cnt/reduce"), function()
		if self.selectedCntByType[var_15_0] == 0 then
			return
		end

		self.selectedCntByType[var_15_0] = self.selectedCntByType[var_15_0] - 1

		self:OnSelCntUpdate()

		return
	end, SFX_PANEL)

	return
end

function ChapterAutoAddTimePanel:UpdateTpl(arg_18_1, arg_18_2)
	local var_18_0 = self.selectedCntByType[self.showTypes[arg_18_1 + 1]]
	local var_18_1 = self.allCntByType[self.showTypes[arg_18_1 + 1]]

	setActive(arg_18_2:Find("select"), self.selectedCntByType[self.showTypes[arg_18_1 + 1]] > 0)
	setActive(arg_18_2:Find("cnt"), var_18_0 > 0)
	setText(arg_18_2:Find("cnt/Text"), var_18_0)
	setText(arg_18_2:Find("IconTpl/icon_bg/count"), var_18_1)

	return
end

function ChapterAutoAddTimePanel:Hide()
	ChapterAutoAddTimePanel.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function ChapterAutoAddTimePanel:OnDestroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

return ChapterAutoAddTimePanel
