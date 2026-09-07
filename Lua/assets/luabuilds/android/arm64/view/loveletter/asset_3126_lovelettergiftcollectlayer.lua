local LoveLetterGiftCollectLayer = class("LoveLetterGiftCollectLayer", import("view.base.BaseUI"))

function LoveLetterGiftCollectLayer:getUIName()
	return "LoveLetterGiftCollectUI"
end

LoveLetterGiftCollectLayer.optionsPath = {}

function LoveLetterGiftCollectLayer:init()
	setText(self.textTitle, i18n("loveactivity_ui_5"))
	setText(self.textHelp, i18n("loveactivity_ui_7"))
	setText(self.btnConfirm:Find("Text"), i18n("loveactivity_ui_8"))
	setText(self.btnSelectConfirm:Find("Text"), i18n("loveactivity_ui_8"))

	self.itemList = UIItemList.New(self.rtScrollContent, self.rtScrollTpl)

	self.itemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1

		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = self.tempList[arg_3_1]

			setText(arg_3_2:Find("year"), tostring(self.tempList[arg_3_1]))
			setActive(arg_3_2:Find("icon/mask/IconTpl"), self.confirmDic[self.tempList[arg_3_1]])
			setActive(arg_3_2:Find("icon/on"), self.confirmDic[self.tempList[arg_3_1]])
			setActive(arg_3_2:Find("now"), self.confirmDic[self.tempList[arg_3_1]])

			if self.confirmDic[self.tempList[arg_3_1]] then
				local var_3_1, var_3_2 = unpack(self.giftItemList[self.confirmDic[self.tempList[arg_3_1]]])

				updateDrop(arg_3_2:Find("icon/mask/IconTpl"), Drop.New({
					count = 1,
					type = DROP_TYPE_ITEM,
					id = var_3_1,
					extra = var_3_2
				}))
				setLoveLetterMedal(arg_3_2:Find("now/medal"), (getProxy(LoveLetterProxy):GetGroupData(self.giftGroupList[self.confirmDic[self.tempList[arg_3_1]]])))
			end

			setActive(arg_3_2:Find("active/active_off"), not self.confirmDic[self.tempList[arg_3_1]])
			setActive(arg_3_2:Find("active/active_on"), self.confirmDic[self.tempList[arg_3_1]])
			setText(arg_3_2:Find("active/Text"), i18n("loveactivity_ui_6"))

			local var_3_3 = not self.confirmDic[self.tempList[arg_3_1]] and self.heap:GetLength() > 0 and self.tempList[arg_3_1] == self.heap:GetTop().element

			setActive(arg_3_2:Find("icon/tip"), var_3_3)
			setButtonEnabled(arg_3_2:Find("icon"), var_3_3)

			if var_3_3 then
				onButton(self, arg_3_2:Find("icon"), function()
					self:OpenSelectWindow(var_3_0)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)
	setActive(self.rtPanel, true)
	setActive(self.rtSelectWindow, false)
	self:BlurPanel(self._tf)

	return
end

function LoveLetterGiftCollectLayer:didEnter()
	onButton(self, self.rtBg, function()
		if isActive(self.rtSelectWindow) then
			self:CloseSelectWindow()
		else
			self:closeView()
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.btnClose, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.btnConfirm, function()
		if self.heap:GetLength() > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("loveactivity_ui_19"))

			return
		end

		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(self.confirmDic) do
			local var_8_1, var_8_2 = unpack(self.giftItemList[iter_8_1])

			table.insert(var_8_0, {
				year = iter_8_0,
				group_id = var_8_2 or self.giftGroupList[iter_8_1],
				item_id = var_8_1
			})
		end

		self:emit(LoveLetterGiftCollectMediator.ON_RECORD_GIFT, var_8_0)

		return
	end, SFX_PANEL)
	onButton(self, self.btnSelectClose, function()
		self:CloseSelectWindow()

		return
	end, SFX_CANCEL)
	self:InitGift()
	self:DropHump()
	self:UpdateDisplay()

	return
end

function LoveLetterGiftCollectLayer:InitGift()
	self.giftItemList = underscore.to_array(self.contextData.items)
	self.giftGroupList = {}

	local var_10_0 = getProxy(LoveLetterProxy):GetLoveLetterItemDic()
	local var_10_1 = {}

	for iter_10_0, iter_10_1 in ipairs(self.giftItemList) do
		local var_10_2, var_10_3 = unpack(iter_10_1)

		assert(tobool(var_10_3) == (pg.item_data_statistics[var_10_2].type == Item.LOVE_LETTER_TYPE))

		for iter_10_2, iter_10_3 in pairs(var_10_0[var_10_2 .. "_" .. (var_10_3 or 0)]) do
			assert(not self.giftGroupList[iter_10_0] or self.giftGroupList[iter_10_0] == iter_10_3)

			self.giftGroupList[iter_10_0] = iter_10_3
			var_10_1[iter_10_2] = var_10_1[iter_10_2] or {}

			table.insert(var_10_1[iter_10_2], iter_10_0)
		end
	end

	self.itemDic = var_10_0
	self.yearDic = var_10_1
	self.confirmDic = {}
	self.heap = Heap.New(underscore.keys(var_10_1), function(arg_11_0)
		return #var_10_1[arg_11_0]
	end)
	self.tempList = underscore(self.yearDic):chain():keys():sort():value()

	assert(#self.giftItemList <= #self.tempList)

	return
end

function LoveLetterGiftCollectLayer:ConfirmItem(arg_12_1, arg_12_2)
	self.confirmDic[arg_12_1] = arg_12_2

	for iter_12_0, iter_12_1 in pairs(self.yearDic) do
		if table.removebyvalue(self.yearDic[iter_12_0], arg_12_2) > 0 then
			self.heap:UpdateValue(iter_12_0)
		end
	end

	return
end

function LoveLetterGiftCollectLayer:DropHump()
	while self.heap:GetLength() > 0 and self.heap:GetTop().value == 1 do
		local var_13_0, var_13_1 = self.heap:POP()

		self:ConfirmItem(var_13_0, self.yearDic[var_13_0][1])
	end

	return
end

function LoveLetterGiftCollectLayer:UpdateDisplay()
	self.itemList:align(#self.tempList)

	return
end

function LoveLetterGiftCollectLayer:OpenSelectWindow(arg_15_1)
	setText(self.textSelectTitile, i18n("loveactivity_ui_9", arg_15_1))
	setActive(self.rtPanel, false)
	setActive(self.rtSelectWindow, true)

	local var_15_0

	UIItemList.StaticAlign(self.rtSelectScrollContent, self.rtSelectScrollTpl, #self.yearDic[arg_15_1], function(arg_16_0, arg_16_1, arg_16_2)
		arg_16_1 = arg_16_1 + 1

		if arg_16_0 == UIItemList.EventUpdate then
			local var_16_0 = self.yearDic[arg_15_1][arg_16_1]
			local var_16_1, var_16_2 = unpack(self.giftItemList[self.yearDic[arg_15_1][arg_16_1]])

			updateDrop(arg_16_2:Find("mask/IconTpl"), Drop.New({
				count = 1,
				type = DROP_TYPE_ITEM,
				id = var_16_1,
				extra = var_16_2
			}))
			onToggle(self, arg_16_2, function(arg_17_0)
				if arg_17_0 then
					var_15_0 = var_16_0
				end

				return
			end, SFX_PANEL)
		end

		return
	end)
	triggerToggle(self.rtSelectScrollContent:GetChild(0), true)
	onButton(self, self.btnSelectConfirm, function()
		self.heap:POP(arg_15_1)
		self:ConfirmItem(arg_15_1, var_15_0)
		self:DropHump()
		self:UpdateDisplay()
		self:CloseSelectWindow()

		return
	end, SFX_CONFIRM)

	return
end

function LoveLetterGiftCollectLayer:CloseSelectWindow()
	setActive(self.rtPanel, true)
	setActive(self.rtSelectWindow, false)

	return
end

function LoveLetterGiftCollectLayer:willExit()
	self:UnOverlayPanel(self._tf)
	self.itemList:each(function(arg_21_0, arg_21_1)
		arg_21_0 = arg_21_0 + 1

		eachChild(arg_21_1:Find("now/medal"), function(arg_22_0, arg_22_1)
			returnLoveLetterMedal(arg_22_0)

			return
		end)

		return
	end)

	return
end

return LoveLetterGiftCollectLayer
