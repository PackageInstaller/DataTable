local ReMapTransformationScene = class("ReMapTransformationScene", import("view.base.BaseUI"))

function ReMapTransformationScene:getUIName()
	return "StoreHouseItemAssignedView"
end

function ReMapTransformationScene:init()
	local var_2_0 = self._tf:Find("operate")

	self.ulist = UIItemList.New(var_2_0:Find("got/bottom/list"), var_2_0:Find("got/bottom/list/tpl"))
	self.confirmBtn = var_2_0:Find("actions/confirm")

	setText(self.confirmBtn:Find("Image"), i18n("text_confirm"))

	self.cancelBtn = var_2_0:Find("actions/cancel")

	setText(self.cancelBtn:Find("Image"), i18n("text_cancel"))

	self.rightArr = var_2_0:Find("calc/value_bg/add")
	self.leftArr = var_2_0:Find("calc/value_bg/mius")
	self.maxBtn = var_2_0:Find("calc/max")
	self.valueText = var_2_0:Find("calc/value_bg/Text")
	self.itemTF = var_2_0:Find("item")
	self.nameTF = self.itemTF:Find("display_panel/name_container/name/Text")
	self.descTF = self.itemTF:Find("display_panel/desc/Text")

	onButton(self, self._tf:Find("bg"), function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:closeView()

		return
	end, SFX_PANEL)
	pressPersistTrigger(self.rightArr, 0.5, function(arg_5_0)
		if not self.itemVO then
			arg_5_0()

			return
		end

		self.count = math.min(self.count + 1, self.itemVO.count)

		self:updateValue()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(self.leftArr, 0.5, function(arg_6_0)
		if not self.itemVO then
			arg_6_0()

			return
		end

		self.count = math.max(self.count - 1, 1)

		self:updateValue()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(self, self.maxBtn, function()
		if not self.itemVO then
			return
		end

		self.count = self.itemVO.count

		self:updateValue()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if not self.selectedIndex or not self.itemVO or self.count <= 0 then
			return
		end

		local var_8_0 = {}

		if self.itemVO:IsDoaSelectCharItem() then
			table.insert(var_8_0, function(arg_9_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("doa_character_select_confirm", (HXSet.hxLan(pg.ship_data_statistics[self.displayDrops[self.selectedIndex].id].name))),
					onYes = arg_9_0
				})

				return
			end)
		end

		local var_8_1 = self.displayDrops[self.selectedIndex].type == DROP_TYPE_ITEM and self.displayDrops[self.selectedIndex]:getSubClass()

		if var_8_1 and var_8_1:getConfig("type") == Item.SKIN_ASSIGNED_TYPE and var_8_1:IsAllSkinOwner() then
			table.insert(var_8_0, function(arg_10_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("blackfriday_pack_select_skinall"),
					onYes = arg_10_0
				})

				return
			end)
		end

		seriesAsync(var_8_0, function()
			self:emit(ReMapTransformationMediator.ON_USE_ITEM, self.itemVO.id, self.count, self.itemVO:getConfig("usage_arg")[self.selectedIndex])

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function ReMapTransformationScene:didEnter()
	self:BlurPanel(self._tf)
	setActive(self._tf, true)

	self.selectedIndex = nil
	self.selectedItem = nil

	self:update(self.contextData.itemVO)

	return
end

function ReMapTransformationScene:update(arg_13_1)
	self.count = 1
	self.itemVO = arg_13_1
	self.displayDrops = underscore.map(arg_13_1:getConfig("display_icon"), function(arg_14_0)
		return Drop.Create({
			DROP_TYPE_VITEM,
			arg_14_0,
			1
		})
	end)

	local var_13_0 = arg_13_1:getConfig("time_limit") == 1

	self.ulist:make(function(arg_15_0, arg_15_1, arg_15_2)
		arg_15_1 = arg_15_1 + 1

		if arg_15_0 == UIItemList.EventUpdate then
			local var_15_0 = self.displayDrops[arg_15_1]

			updateDrop(arg_15_2:Find("item"), self.displayDrops[arg_15_1])
			onToggle(self, arg_15_2, function(arg_16_0)
				if arg_16_0 then
					self.selectedIndex = arg_15_1
					self.selectedItem = arg_15_2
				elseif self.selectedIndex == arg_15_1 then
					self.selectedIndex = nil
					self.selectedItem = nil
				end

				return
			end, SFX_PANEL)
			triggerToggle(arg_15_2, false)
			setScrollText(arg_15_2:Find("name_bg/Text"), var_15_0:getConfig("name"))

			local var_15_1 = var_13_0 and var_15_0.type == DROP_TYPE_SHIP and CheckShipExist(var_15_0.id)

			if var_15_1 then
				setText(arg_15_2:Find("item/tip/Text"), i18n("tech_character_get"))
			end

			setActive(arg_15_2:Find("item/tip"), var_15_1)
			onButton(self, arg_15_2:Find("block_mask"), function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("item_assigned_type_limit_error"))

				return
			end, SFX_CANCEL)

			if not self.selectedItem and not self:isOverLimit(arg_15_1, self.count) then
				self.selectedItem = arg_15_2
			end
		end

		return
	end)
	self.ulist:align(#self.displayDrops)

	if self.selectedItem then
		triggerToggle(self.selectedItem, true)
	end

	self:updateValue()

	local var_13_1 = Drop.New({
		type = DROP_TYPE_ITEM,
		id = arg_13_1.id,
		count = arg_13_1.count
	})

	updateDrop(self.itemTF:Find("left/IconTpl"), setmetatable({
		count = 0
	}, {
		__index = var_13_1
	}))
	UpdateOwnDisplay(self.itemTF:Find("left/own"), var_13_1)

	if underscore.any(self.displayDrops, function(arg_18_0)
		return arg_18_0.type == DROP_TYPE_ITEM and arg_18_0:getConfig("type") == Item.SKIN_ASSIGNED_TYPE
	end) or var_13_1.type == DROP_TYPE_ITEM and var_13_1:getConfig("type") == Item.ASSIGNED_TYPE then
		RegisterDetailButton(self, self.itemTF:Find("left/detail"), var_13_1)
	else
		removeOnButton(self.itemTF:Find("left/detail"))
	end

	setText(self.nameTF, arg_13_1:getConfig("name"))
	setText(self.descTF, arg_13_1:getConfig("display"))

	return
end

function ReMapTransformationScene:updateValue()
	setText(self.valueText, self.count)
	self.ulist:each(function(arg_20_0, arg_20_1)
		if not isActive(arg_20_1) then
			return
		end

		setText(arg_20_1:Find("item/icon_bg/count"), self.count * self.displayDrops[arg_20_0 + 1].count)

		local var_20_0 = self:isOverLimit(arg_20_0 + 1, self.count)

		setActive(arg_20_1:Find("block_mask"), var_20_0)

		if var_20_0 and self.selectedIndex == arg_20_0 + 1 then
			triggerToggle(arg_20_1, false)
		end

		return
	end)

	return
end

function ReMapTransformationScene:isOverLimit(arg_21_1, arg_21_2)
	local var_21_0 = self.displayDrops[arg_21_1]
	local var_21_1 = underscore.detect(self.itemVO:getConfig("limit"), function(arg_22_0)
		local var_22_0, var_22_1, var_22_2 = unpack(arg_22_0)

		return var_22_0 == var_21_0.type and var_22_1 == var_21_0.id
	end)
	local var_21_2

	var_21_2 = var_21_1 and var_21_1[3] or nil

	if not var_21_2 then
		return false
	else
		return var_21_2 < var_21_0:getOwnedCount() + var_21_0.count * self.count
	end

	return
end

function ReMapTransformationScene:willExit()
	self:UnOverlayPanel(self._tf)

	return
end

return ReMapTransformationScene
