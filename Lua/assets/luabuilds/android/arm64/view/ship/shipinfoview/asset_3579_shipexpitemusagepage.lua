local ShipExpItemUsagePage = class("ShipExpItemUsagePage", import("...base.BaseSubView"))

function ShipExpItemUsagePage:getUIName()
	return "ShipExpItemUsagePage"
end

function ShipExpItemUsagePage:OnLoaded()
	self.backBtn = self._tf:Find("frame/top/btnBack")
	self.confirmBtn = self._tf:Find("frame/buttons/confirm")
	self.recomBtn = self._tf:Find("frame/buttons/recom")
	self.clearBtn = self._tf:Find("frame/buttons/clear")
	self.levelTxt = self._tf:Find("frame/content/level/Text"):GetComponent(typeof(Text))
	self.expTxt = self._tf:Find("frame/content/level/exp"):GetComponent(typeof(Text))
	self.currentProgress = self._tf:Find("frame/content/level/y"):GetComponent(typeof(Slider))
	self.tipProgress = self._tf:Find("frame/content/level/w"):GetComponent(typeof(Slider))
	self.previewProgress = self._tf:Find("frame/content/level/g"):GetComponent(typeof(Slider))
	self.itemIds = self:GetAllItemIDs()

	local var_2_0 = #self.itemIds <= 3

	self.uiItemList = #self.itemIds <= 3 and UIItemList.New(self._tf:Find("frame/content/items"), self._tf:Find("frame/content/items/tpl")) or UIItemList.New(self._tf:Find("frame/content/scrollrect/content"), self._tf:Find("frame/content/items/tpl"))

	setActive(self._tf:Find("frame/content/items"), var_2_0)
	setActive(self._tf:Find("frame/content/scrollrect"), not var_2_0)
	setText(self._tf:Find("frame/top/bg/infomation/title"), i18n("ship_exp_item_title"))
	setText(self._tf:Find("frame/content/label"), i18n("coures_level_tip"))
	setText(self.confirmBtn:Find("pic"), i18n("ship_exp_item_label_confirm"))
	setText(self.recomBtn:Find("pic"), i18n("ship_exp_item_label_recom"))
	setText(self.clearBtn:Find("pic"), i18n("ship_exp_item_label_clear"))

	return
end

function ShipExpItemUsagePage:OnInit()
	self.cards = {}

	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self.backBtn, function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self.recomBtn, function()
		triggerButton(self.clearBtn)

		local var_6_0 = self:Recommand()

		for iter_6_0, iter_6_1 in pairs(self.cards) do
			iter_6_1.value = var_6_0[iter_6_1.item.id] or 0

			iter_6_1:UpdateValue()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.clearBtn, function()
		for iter_7_0, iter_7_1 in pairs(self.cards) do
			iter_7_1.value = 0

			iter_7_1:UpdateValue()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if _.all(_.values(self.itemCnts), function(arg_9_0)
			return arg_9_0 == 0
		end) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_remould_no_material"))

			return
		end

		local function var_8_0(arg_10_0)
			self:emit(ShipMainMediator.ON_ADD_SHIP_EXP, self.shipVO.id, self.itemCnts)

			if arg_10_0 then
				self:Hide()
			else
				self:Flush(self.shipVO)
			end

			return
		end

		local var_8_1 = Clone(self.shipVO)
		local var_8_2 = var_8_1:getMaxLevel()

		var_8_1.exp = var_8_1.exp + self:GetAdditionExp()

		local var_8_3 = false

		while var_8_1:canLevelUp() do
			var_8_1.exp = var_8_1.exp - var_8_1:getLevelExpConfig().exp_interval
			var_8_1.level = math.min(var_8_1.level + 1, var_8_2)
			var_8_3 = true
		end

		local var_8_4 = var_8_1.maxLevel <= var_8_1.level

		if var_8_3 and (var_8_1.maxLevel == var_8_1.level and var_8_1.exp > 0 or var_8_1.maxLevel < var_8_1.level) then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("coures_exp_overflow_tip", var_8_1.exp),
				onYes = function()
					var_8_0(var_8_4)

					return
				end
			})
		else
			var_8_0(var_8_4)
		end

		return
	end, SFX_PANEL)
	self.uiItemList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			self:UpdateItemPanel(self.itemIds[arg_12_1 + 1], arg_12_2)
		end

		return
	end)

	return
end

function ShipExpItemUsagePage:GetItem(arg_13_1)
	local var_13_0 = getProxy(BagProxy):getItemById(arg_13_1)

	var_13_0 = var_13_0 or Drop.New({
		count = 0,
		type = DROP_TYPE_ITEM,
		id = arg_13_1
	})

	return var_13_0
end

function ShipExpItemUsagePage:Recommand()
	local var_14_0 = {}
	local var_14_1 = Clone(self.shipVO)
	local var_14_2 = underscore.map(self:GetAllItemIDs(), function(arg_15_0)
		return self:GetItem(arg_15_0)
	end)

	table.sort(var_14_2, CompareFuncs({
		function(arg_16_0)
			return -arg_16_0.id
		end
	}))

	for iter_14_0, iter_14_1 in ipairs(var_14_2) do
		var_14_0[iter_14_1.id] = 0

		local var_14_3 = iter_14_1:getConfig("usage_arg")
		local var_14_4 = iter_14_0 < #var_14_2 and var_14_2[iter_14_0 + 1]:getConfig("usage_arg") or 0

		for iter_14_2 = 1, iter_14_1.count do
			if iter_14_0 ~= #var_14_2 and self:PreCalcExpOverFlow(var_14_1, tonumber(var_14_3), tonumber(var_14_4)) then
				break
			else
				var_14_1:addExp(tonumber(var_14_3))

				var_14_0[iter_14_1.id] = var_14_0[iter_14_1.id] + 1

				if var_14_1.maxLevel == var_14_1.level then
					return var_14_0
				end
			end
		end
	end

	return var_14_0
end

function ShipExpItemUsagePage:PreCalcExpOverFlow(arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_1.level

	arg_17_1.exp = arg_17_1.exp + arg_17_2

	local var_17_1 = arg_17_1:getMaxLevel()

	while arg_17_1:canLevelUp() do
		arg_17_1.exp = arg_17_1.exp - arg_17_1:getLevelExpConfig().exp_interval
		arg_17_1.level = math.min(arg_17_1.level + 1, var_17_1)
	end

	arg_17_1.exp = arg_17_1.exp
	arg_17_1.level = var_17_0

	return var_17_1 <= arg_17_1.level and arg_17_3 < arg_17_1.exp
end

function ShipExpItemUsagePage:GetAllItemIDs()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(pg.gameset.ship_exp_books.description) do
		if Item.getConfigData(iter_18_1) then
			table.insert(var_18_0, iter_18_1)
		end
	end

	return var_18_0
end

function ShipExpItemUsagePage:Show(arg_19_1)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	ShipExpItemUsagePage.super.Show(self)
	self:Flush(arg_19_1)

	return
end

function ShipExpItemUsagePage:Flush(arg_20_1)
	self.itemCnts = {}
	self.shipVO = arg_20_1

	self:InitItems()
	self:UpdateLevelInfo()

	return
end

function ShipExpItemUsagePage:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	ShipExpItemUsagePage.super.Hide(self)

	return
end

function ShipExpItemUsagePage:InitItems()
	table.sort(self.itemIds, function(arg_23_0, arg_23_1)
		return arg_23_0 < arg_23_1
	end)
	self.uiItemList:align(#self.itemIds)

	return
end

function ShipExpItemUsagePage:UpdateItemPanel(arg_24_1, arg_24_2)
	local var_24_0 = self.cards[arg_24_2]

	if not self.cards[arg_24_2] then
		var_24_0 = ShipExpItemUsageCard.New(arg_24_2)

		var_24_0:SetCallBack(function(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
			self:OnAddItem(arg_25_0, arg_25_1, arg_25_2, arg_25_3)

			return
		end)

		self.cards[arg_24_2] = var_24_0
	end

	var_24_0:Update(arg_24_1)

	return
end

function ShipExpItemUsagePage:OnAddItem(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	if self.shipVO.maxLevel == self.shipVO.level then
		arg_26_1:ForceUpdateValue(self.itemCnts[arg_26_2])
		pg.TipsMgr.GetInstance():ShowTips(i18n("coures_tip_exceeded_lv"))

		return
	end

	local var_26_0 = Clone(self.shipVO)
	local var_26_1 = 0

	for iter_26_0, iter_26_1 in pairs(self.itemCnts) do
		if iter_26_0 ~= arg_26_2 then
			var_26_1 = var_26_1 + tonumber(Item.getConfigData(iter_26_0).usage_arg) * iter_26_1
		end
	end

	var_26_0:addExp(var_26_1)

	local var_26_2 = Item.getConfigData(arg_26_2).usage_arg
	local var_26_3 = 0

	if arg_26_4 then
		var_26_3 = arg_26_3
	elseif var_26_0.level ~= var_26_0.maxLevel then
		for iter_26_2 = 1, arg_26_3 do
			var_26_0:addExp(tonumber(var_26_2))

			var_26_3 = var_26_3 + 1

			if var_26_0.maxLevel == var_26_0.level then
				break
			end
		end
	end

	if (self.itemCnts[arg_26_2] or 0) < arg_26_3 then
		var_26_3 = math.max(self.itemCnts[arg_26_2] or 0, var_26_3)
	end

	if arg_26_3 ~= var_26_3 then
		arg_26_1:ForceUpdateValue(var_26_3)

		arg_26_3 = var_26_3
	end

	self.itemCnts[arg_26_2] = arg_26_3

	self:UpdateLevelInfo()

	return
end

function ShipExpItemUsagePage:GetTempShipVO(arg_27_1, arg_27_2)
	if arg_27_2 > 0 then
		local var_27_0 = Clone(arg_27_1)

		var_27_0:addExp(arg_27_2)

		return var_27_0
	end

	return arg_27_1
end

function ShipExpItemUsagePage:GetAdditionExp()
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in pairs(self.itemCnts) do
		var_28_0 = var_28_0 + tonumber(Item.getConfigData(iter_28_0).usage_arg) * iter_28_1
	end

	return var_28_0
end

function ShipExpItemUsagePage:UpdateLevelInfo()
	local var_29_0 = self:GetAdditionExp()
	local var_29_1 = self:GetTempShipVO(self.shipVO, var_29_0)
	local var_29_2 = var_29_1.level - self.shipVO.level

	self.levelTxt.text = self.shipVO.level .. (var_29_1.level - self.shipVO.level <= 0 and (var_29_0 > 0 and "+0" or "") or "<color=" .. COLOR_GREEN .. ">+" .. var_29_2 .. "</color>")

	local var_29_3 = self.shipVO:getLevelExpConfig().exp_interval

	self.expTxt.text = string.format("%d<color=%s>(+%d)</color>/%d", self.shipVO.exp, COLOR_GREEN, var_29_0, var_29_3)

	local var_29_4 = self.shipVO.exp / var_29_3

	self.currentProgress.value = self.shipVO.exp / var_29_3
	self.tipProgress.value = var_29_0 <= 0 and var_29_4 or var_29_4 + 0.003
	self.previewProgress.value = var_29_0 <= 0 and 0 or var_29_2 >= 1 and 1 or var_29_1.exp / var_29_3

	return
end

function ShipExpItemUsagePage:OnDestroy()
	for iter_30_0, iter_30_1 in pairs(self.cards) do
		iter_30_1:Dispose()
	end

	self.cards = nil

	return
end

return ShipExpItemUsagePage
