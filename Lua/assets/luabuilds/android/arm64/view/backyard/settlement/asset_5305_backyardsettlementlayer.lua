local BackYardSettlementLayer = class("BackYardSettlementLayer", import("...base.BaseUI"))

function BackYardSettlementLayer:getUIName()
	return "BackYardStatisticsUI"
end

function BackYardSettlementLayer:setShipVOs(arg_2_1, arg_2_2)
	self.oldShipVOs = arg_2_1
	self.newShipVOs = arg_2_2

	return
end

function BackYardSettlementLayer:setDormVO(arg_3_1)
	self.dormVO = arg_3_1

	return
end

function BackYardSettlementLayer:init()
	self.frame = self._tf:Find("frame")
	self.painting = self._tf:Find("painting")
	self.confirmBtn = self._tf:Find("painting/confirm_btn")
	self.timeTF = self._tf:Find("ship_word/text_contain1")
	self.expTF = self._tf:Find("ship_word/text_contain2")
	self.emptyTF = self._tf:Find("ship_word/Text")
	self.uilist = UIItemList.New(self.frame:Find("container"), self.frame:Find("container/ship_tpl"))

	return
end

function BackYardSettlementLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	onButton(self, self.confirmBtn, function()
		self:emit(BackYardSettlementLayer.ON_CLOSE)

		return
	end, SOUND_BACK)

	self.cards = {}

	self.uilist:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			self.cards[arg_7_1] = BackYardSettlementCard.New(arg_7_2)
		end

		return
	end)

	local var_5_0, var_5_1 = self:UpdateShips()

	self:InitPainting(var_5_0, var_5_1)

	return
end

function BackYardSettlementLayer:InitPainting(arg_8_1, arg_8_2)
	setPaintingPrefabAsync(self.painting, arg_8_1:getPainting(), "jiesuan")
	setActive(self.timeTF, self.dormVO.food ~= 0)
	setActive(self.expTF, self.dormVO.food ~= 0)
	setActive(self.emptyTF, self.dormVO.food == 0)

	if self.dormVO.food == 0 then
		setText(self.emptyTF, i18n("backyard_backyardGranaryLayer_noFood"))
	else
		local var_8_1 = string.split(i18n("backyard_addExp_Info", pg.TimeMgr.GetInstance():DescCDTime(pg.TimeMgr.GetInstance():GetServerTime() - ((not self.contextData.time or nil) and 0)), self.contextData.food or 0, arg_8_2), "||")

		assert(#var_8_1 > 0, "gametip ==> backyard_addExp_Info 必须用||分开")

		local var_8_2 = self._tf:Find("ship_word/text_contain1")
		local var_8_3 = 0

		while var_8_3 < var_8_2.childCount do
			setText(var_8_2:GetChild(var_8_3), var_8_1[var_8_3 + 1])

			var_8_3 = var_8_3 + 1
		end

		local var_8_4 = self._tf:Find("ship_word/text_contain2")

		while 0 < var_8_4.childCount do
			setText(var_8_4:GetChild(0), var_8_1[var_8_3 + 1])

			var_8_3 = var_8_3 + 1
		end
	end

	return
end

function BackYardSettlementLayer:UpdateShips()
	local var_9_0 = {}
	local var_9_1 = 0

	for iter_9_0, iter_9_1 in pairs(self.newShipVOs) do
		table.insert(var_9_0, iter_9_0)

		if self.oldShipVOs[iter_9_0].level ~= self.oldShipVOs[iter_9_0]:getMaxLevel() then
			var_9_1 = var_9_1 + 1
		end
	end

	self.uilist:align(#var_9_0)

	local var_9_2 = self.contextData.exp or 0
	local var_9_3 = {}

	for iter_9_2, iter_9_3 in pairs(self.cards) do
		table.insert(var_9_3, function(arg_10_0)
			if self.exited then
				return
			end

			iter_9_3:Update(var_9_2, self.oldShipVOs[var_9_0[iter_9_2 + 1]], self.newShipVOs[var_9_0[iter_9_2 + 1]])
			onNextTick(arg_10_0)

			return
		end)
	end

	seriesAsync(var_9_3)

	return self.newShipVOs[var_9_0[1]], var_9_1 * var_9_2
end

function BackYardSettlementLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, pg.UIMgr.GetInstance().UIMain)

	for iter_11_0, iter_11_1 in ipairs(self.cards) do
		iter_11_1:Dispose()
	end

	return
end

return BackYardSettlementLayer
