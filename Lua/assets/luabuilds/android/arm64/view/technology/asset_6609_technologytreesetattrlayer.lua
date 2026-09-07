local TechnologyTreeSetAttrLayer = class("TechnologyTreeSetAttrLayer", import("..base.BaseUI"))

function TechnologyTreeSetAttrLayer:getUIName()
	return "TechnologyTreeSetAttrUI"
end

function TechnologyTreeSetAttrLayer:init()
	self:initData()
	self:initUITips()
	self:findUI()
	self:addListener()

	return
end

function TechnologyTreeSetAttrLayer:didEnter()
	self:BlurPanel(self._tf)
	self:updateTypeList()
	triggerToggle(self.typeContainer:GetChild(0), true)

	return
end

function TechnologyTreeSetAttrLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self.resLoader:Clear()

	return
end

function TechnologyTreeSetAttrLayer:onBackPressed()
	triggerButton(self.closeBtn)

	return
end

function TechnologyTreeSetAttrLayer:initData()
	self.tecNationProxy = getProxy(TechnologyNationProxy)
	self.cacheAdditionMap = {}
	self.curAdditionMap = self.tecNationProxy:getSetableAttrAddition()
	self.maxAdditionMap = nil
	self.typeOrderList = nil
	self.typeAttrOrderListTable = nil
	self.maxAdditionMap, self.typeOrderList, self.typeAttrOrderListTable = self.tecNationProxy:getTecBuff()
	self.typeOrderList = ShipType.FilterOverQuZhuType(self.typeOrderList)
	self.resLoader = AutoLoader.New()
	self.curType = 0
	self.typeToggleTable = {}
	self.typeAttrTFTable = {}

	return
end

function TechnologyTreeSetAttrLayer:initUITips()
	setText(self._tf:Find("Adapt/Content/ResetBtn/Text"), i18n("attrset_reset"))
	setText(self._tf:Find("Adapt/Content/SaveBtn/Text"), i18n("attrset_save"))

	return
end

function TechnologyTreeSetAttrLayer:findUI()
	self.typeTpl = self._tf:Find("TypeTpl")
	self.attrTpl = self._tf:Find("AttrTpl")
	self.backBGTF = self._tf:Find("Adapt/BackBG")

	local var_8_0 = self._tf:Find("Adapt/Content")

	self.closeBtn = var_8_0:Find("CloseBtn")
	self.arrowTF = var_8_0:Find("Arrow")
	self.typeContainer = var_8_0:Find("TypeScrollView/Content")
	self.attrContainer = var_8_0:Find("AttrPanel")
	self.resetBtn = var_8_0:Find("ResetBtn")
	self.saveBtn = var_8_0:Find("SaveBtn")
	self.typeUIItemList = UIItemList.New(self.typeContainer, self.typeTpl)
	self.attrUIItemList = UIItemList.New(self.attrContainer, self.attrTpl)

	return
end

function TechnologyTreeSetAttrLayer:addListener()
	onButton(self, self.closeBtn, function()
		if self:isChanged() then
			self:openSaveBox(function()
				self:save(function()
					self:closeView()

					return
				end)

				return
			end, function()
				self:closeView()

				return
			end, function()
				return
			end)
		else
			self:closeView()
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.backBGTF, function()
		if self:isChanged() then
			self:openSaveBox(function()
				self:save(function()
					self:closeView()

					return
				end)

				return
			end, function()
				self:closeView()

				return
			end, function()
				return
			end)
		else
			self:closeView()
		end

		return
	end, SFX_CANCEL)
	self.typeUIItemList:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventUpdate then
			arg_20_1 = arg_20_1 + 1

			self:updateTypeTF(arg_20_1, arg_20_2)
		end

		return
	end)
	self.attrUIItemList:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventUpdate then
			arg_21_1 = arg_21_1 + 1

			self:updateAttrTF(arg_21_1, arg_21_2)
		end

		return
	end)
	onButton(self, self.resetBtn, function()
		for iter_22_0, iter_22_1 in ipairs(self.typeAttrOrderListTable[self.curType]) do
			self:setAttrValue(self.curType, iter_22_1, self.maxAdditionMap[self.curType][iter_22_1])
			self:setAttrTFValue(self.typeAttrTFTable[self.curType][iter_22_1], self.maxAdditionMap[self.curType][iter_22_1])
		end

		return
	end, SFX_PANEL)
	onButton(self, self.saveBtn, function()
		if self:isChanged() then
			self:save(function()
				self:clearCacheMap()

				self.curAdditionMap = self.tecNationProxy:getSetableAttrAddition()

				return
			end)
		end

		return
	end, SFX_PANEL)

	return
end

function TechnologyTreeSetAttrLayer:updateTypeTF(arg_25_1, arg_25_2)
	local var_25_0 = self.typeOrderList[arg_25_1]
	local var_25_1 = ShipType.Type2Name(self.typeOrderList[arg_25_1])

	setText(arg_25_2:Find("TypeNameUnSelect"), var_25_1)
	setText(arg_25_2:Find("TypeNameSelected"), var_25_1)
	self.resLoader:GetSprite("ShipType", "buffitem_tec_" .. self.typeOrderList[arg_25_1], arg_25_2:Find("TypeImg"), false)
	onToggle(self, arg_25_2, function(arg_26_0)
		if arg_26_0 and self.curType ~= var_25_0 then
			if self:isChanged() then
				self:openSaveBox(function()
					self:save(function()
						self:clearCacheMap()

						self.curAdditionMap = self.tecNationProxy:getSetableAttrAddition()
						self.curType = var_25_0

						self:updateAttrList(self.curType)

						return
					end)

					return
				end, function()
					self:clearCacheMap()

					self.curType = var_25_0

					self:updateAttrList(self.curType)

					return
				end, function()
					triggerToggle(self.typeToggleTable[self.curType], true)

					return
				end)
			else
				self:clearCacheMap()

				self.curType = var_25_0

				self:updateAttrList(self.curType)
			end
		end

		return
	end, SFX_PANEL)

	self.typeToggleTable[self.typeOrderList[arg_25_1]] = arg_25_2

	return
end

function TechnologyTreeSetAttrLayer:updateTypeList()
	self.typeUIItemList:align(#self.typeOrderList)

	return
end

function TechnologyTreeSetAttrLayer:updateAttrTF(arg_32_1, arg_32_2)
	local var_32_0 = arg_32_2:Find("Attr/Value/CurValue")
	local var_32_1 = arg_32_2:Find("Attr/InputField")
	local var_32_2 = arg_32_2:Find("Attr/InputField")
	local var_32_3 = self.typeAttrOrderListTable[self.curType][arg_32_1]
	local var_32_4 = self.maxAdditionMap[self.curType][self.typeAttrOrderListTable[self.curType][arg_32_1]]

	setText(arg_32_2:Find("AttrName"), (AttributeType.Type2Name(pg.attribute_info_by_type[self.typeAttrOrderListTable[self.curType][arg_32_1]].name)))
	setText(var_32_0, (self:getAddValueForShow(self.curType, self.typeAttrOrderListTable[self.curType][arg_32_1])))
	setText(arg_32_2:Find("Attr/Value/MaxValue"), self.maxAdditionMap[self.curType][self.typeAttrOrderListTable[self.curType][arg_32_1]])
	onButton(self, arg_32_2:Find("Buttons/MinusBtn"), function()
		local var_33_0 = self:getAddValueForShow(self.curType, var_32_3)

		if var_33_0 > 0 then
			self:setAttrValue(self.curType, var_32_3, var_33_0 - 1)
			setText(var_32_0, var_33_0 - 1)
		end

		return
	end, SFX_PANEL)
	onButton(self, arg_32_2:Find("Buttons/AddBtn"), function()
		local var_34_0 = self:getAddValueForShow(self.curType, var_32_3)

		if var_34_0 < var_32_4 then
			self:setAttrValue(self.curType, var_32_3, var_34_0 + 1)
			setText(var_32_0, var_34_0 + 1)
		end

		return
	end, SFX_PANEL)
	onButton(self, arg_32_2:Find("Buttons/MaxBtn"), function()
		local var_35_0 = self:getAddValueForShow(self.curType, var_32_3)

		self:setAttrValue(self.curType, var_32_3, var_32_4)
		setText(var_32_0, var_32_4)

		return
	end, SFX_PANEL)
	onInputEndEdit(self, var_32_2, function(arg_36_0)
		local var_36_0 = tonumber(arg_36_0)

		if var_36_0 then
			if var_36_0 < 0 then
				var_36_0 = nil
			else
				local var_36_1 = math.floor(var_36_0)

				var_36_0 = var_36_1 == var_36_0 and var_36_1 or nil
			end
		end

		if var_36_0 then
			var_36_0 = math.min(var_36_0, var_32_4)

			self:setAttrValue(self.curType, var_32_3, var_36_0)
			setText(var_32_0, var_36_0)
		elseif not var_36_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("attrset_input_ill"))
		end

		setInputText(var_32_2, "")

		return
	end)

	self.typeAttrTFTable[self.curType][self.typeAttrOrderListTable[self.curType][arg_32_1]] = arg_32_2

	return
end

function TechnologyTreeSetAttrLayer:updateAttrList(arg_37_1)
	self.typeAttrTFTable = {}
	self.typeAttrTFTable[arg_37_1] = {}

	self.attrUIItemList:align(#self.typeAttrOrderListTable[arg_37_1])

	return
end

function TechnologyTreeSetAttrLayer:setAttrTFValue(arg_38_1, arg_38_2)
	setText(arg_38_1:Find("Attr/Value/CurValue"), arg_38_2)

	return
end

function TechnologyTreeSetAttrLayer:openSaveBox(arg_39_1, arg_39_2, arg_39_3)
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("attrset_ask_save"),
		onYes = arg_39_1,
		onNo = arg_39_2,
		onClose = arg_39_3
	})

	return
end

function TechnologyTreeSetAttrLayer:getAddValueForShow(arg_40_1, arg_40_2)
	if self.cacheAdditionMap[arg_40_1] and self.cacheAdditionMap[arg_40_1][arg_40_2] then
		return self.cacheAdditionMap[arg_40_1][arg_40_2]
	elseif self.curAdditionMap[self.curType] and self.curAdditionMap[self.curType][arg_40_2] then
		return self.curAdditionMap[arg_40_1][arg_40_2]
	else
		return self.maxAdditionMap[arg_40_1][arg_40_2]
	end

	return
end

function TechnologyTreeSetAttrLayer:setAttrValue(arg_41_1, arg_41_2, arg_41_3)
	self.cacheAdditionMap[arg_41_1] = self.cacheAdditionMap[arg_41_1] or {}
	self.cacheAdditionMap[arg_41_1][arg_41_2] = arg_41_3

	return
end

function TechnologyTreeSetAttrLayer:clearCacheMap()
	self.cacheAdditionMap = {}

	return
end

function TechnologyTreeSetAttrLayer:isChanged()
	for iter_43_0, iter_43_1 in pairs(self.cacheAdditionMap) do
		for iter_43_2, iter_43_3 in pairs(iter_43_1) do
			if iter_43_3 ~= self.tecNationProxy:getSetableAttrAdditionValueByTypeAttr(iter_43_0, iter_43_2) then
				return true
			end
		end
	end

	return false
end

function TechnologyTreeSetAttrLayer:save(arg_44_1)
	local var_44_0 = {}

	for iter_44_0, iter_44_1 in pairs(self.curAdditionMap) do
		var_44_0[iter_44_0] = var_44_0[iter_44_0] or {}

		for iter_44_2, iter_44_3 in pairs(iter_44_1) do
			var_44_0[iter_44_0][iter_44_2] = iter_44_3
		end
	end

	for iter_44_4, iter_44_5 in pairs(self.cacheAdditionMap) do
		var_44_0[iter_44_4] = var_44_0[iter_44_4] or {}

		for iter_44_6, iter_44_7 in pairs(iter_44_5) do
			var_44_0[iter_44_4][iter_44_6] = iter_44_7
		end
	end

	local var_44_1 = {}

	for iter_44_8, iter_44_9 in pairs(var_44_0) do
		for iter_44_10, iter_44_11 in pairs(iter_44_9) do
			if iter_44_11 ~= self.maxAdditionMap[iter_44_8][iter_44_10] then
				table.insert(var_44_1, {
					ship_type = iter_44_8,
					attr_type = iter_44_10,
					set_value = iter_44_11
				})
			end
		end
	end

	pg.m02:sendNotification(GAME.SET_TEC_ATTR_ADDITION, {
		sendList = var_44_1,
		onSuccess = arg_44_1
	})

	return
end

function TechnologyTreeSetAttrLayer:reset()
	local var_45_0 = {}

	for iter_45_0, iter_45_1 in pairs(self.curAdditionMap) do
		if iter_45_0 ~= self.curType then
			var_45_0[iter_45_0] = var_45_0[iter_45_0] or {}

			for iter_45_2, iter_45_3 in pairs(iter_45_1) do
				var_45_0[iter_45_0][iter_45_2] = iter_45_3
			end
		end
	end

	for iter_45_4, iter_45_5 in pairs(self.cacheAdditionMap) do
		if iter_45_4 ~= self.curType then
			var_45_0[iter_45_4] = var_45_0[iter_45_4] or {}

			for iter_45_6, iter_45_7 in pairs(iter_45_5) do
				var_45_0[iter_45_4][iter_45_6] = iter_45_7
			end
		end
	end

	local var_45_1 = {}

	for iter_45_8, iter_45_9 in pairs(var_45_0) do
		for iter_45_10, iter_45_11 in pairs(iter_45_9) do
			if iter_45_11 ~= self.maxAdditionMap[iter_45_8][iter_45_10] then
				table.insert(var_45_1, {
					ship_type = iter_45_8,
					attr_type = iter_45_10,
					set_value = iter_45_11
				})
			end
		end
	end

	pg.m02:sendNotification(GAME.SET_TEC_ATTR_ADDITION, {
		sendList = var_45_1
	})

	return
end

return TechnologyTreeSetAttrLayer
