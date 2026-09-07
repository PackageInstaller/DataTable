local DestroyConfirmView = class("DestroyConfirmView", import("..base.BaseSubView"))

function DestroyConfirmView:getUIName()
	return "StoreHouseDestroyConfirmView"
end

function DestroyConfirmView:OnInit()
	self.destroyBonusList = self._tf:Find("frame/bg/scrollview/list")
	self.destroyBonusItem = self.destroyBonusList:Find("equipment_tpl")
	self.destroyNoGotTip = self._tf:Find("frame/bg/tip")

	setText(self._tf:Find("frame/title_text/Text"), i18n("equipment_select_device_destroy_bonus_tip"))
	setText(self.destroyNoGotTip, i18n("equipment_select_device_destroy_nobonus_tip"))
	onButton(self, self._tf:Find("frame/actions/cancel_btn"), function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("frame/top/btnBack"), function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("frame/actions/confirm_btn"), function()
		self:emit(EquipmentMediator.ON_DESTROY, self.selectedIds)
		self.confirmBtnCB()
		self:Hide()

		return
	end, SFX_UI_EQUIPMENT_RESOLVE)

	return
end

function DestroyConfirmView:Show()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setActive(self._tf, true)

	return
end

function DestroyConfirmView:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	setActive(self._tf, false)

	return
end

function DestroyConfirmView:SetConfirmBtnCB(arg_9_1)
	self.confirmBtnCB = arg_9_1

	return
end

function DestroyConfirmView:DisplayDestroyBonus(arg_10_1)
	self.selectedIds = arg_10_1

	local var_10_0 = {}
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in ipairs(self.selectedIds) do
		if Equipment.CanInBag(iter_10_1[1]) then
			local var_10_2 = Equipment.getConfigData(iter_10_1[1])

			var_10_1 = var_10_1 + (var_10_2.destory_gold or 0) * iter_10_1[2]

			for iter_10_2, iter_10_3 in ipairs(var_10_2.destory_item or {}) do
				local var_10_3 = false

				for iter_10_4, iter_10_5 in ipairs(var_10_0) do
					if iter_10_3[1] == var_10_0[iter_10_4].id then
						var_10_0[iter_10_4].count = var_10_0[iter_10_4].count + iter_10_3[2] * iter_10_1[2]
						var_10_3 = true

						break
					end
				end

				if not var_10_3 then
					table.insert(var_10_0, {
						type = DROP_TYPE_ITEM,
						id = iter_10_3[1],
						count = iter_10_3[2] * iter_10_1[2]
					})
				end
			end
		end
	end

	if var_10_1 > 0 then
		table.insert(var_10_0, {
			id = 1,
			type = DROP_TYPE_RESOURCE,
			count = var_10_1
		})
	end

	setActive(self.destroyNoGotTip, #var_10_0 <= 0)

	self.destroyList = self.destroyList or UIItemList.New(self.destroyBonusList, self.destroyBonusItem)

	self.destroyList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = var_10_0[arg_11_1 + 1]

			if var_10_0[arg_11_1 + 1].type == DROP_TYPE_SHIP then
				self.hasShip = true
			end

			updateDrop(arg_11_2, var_10_0[arg_11_1 + 1])

			local var_11_1, var_11_2 = contentWrap(var_10_0[arg_11_1 + 1]:getConfig("name"), 10, 2)

			if var_11_1 then
				var_11_2 = var_11_2 .. "..."
			end

			setText(arg_11_2:Find("name"), var_11_2)
			onButton(self, arg_11_2, function()
				if var_11_0.type == DROP_TYPE_RESOURCE or var_11_0.type == DROP_TYPE_ITEM then
					self:emit(BaseUI.ON_ITEM, var_11_0:getConfig("id"))
				elseif var_11_0.type == DROP_TYPE_EQUIP then
					self:emit(BaseUI.ON_EQUIPMENT, {
						equipmentId = var_11_0:getConfig("id"),
						type = EquipmentInfoMediator.TYPE_DISPLAY
					})
				end

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.destroyList:align(#var_10_0)

	return
end

return DestroyConfirmView
