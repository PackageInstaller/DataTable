local ShipModLayer = class("ShipModLayer", import("..base.BaseUI"))
local var_0_1 = 12

ShipModLayer.IGNORE_ID = 4

function ShipModLayer:getUIName()
	return "ShipModUI"
end

function ShipModLayer:getGroupName()
	return "ShipMainScene"
end

function ShipModLayer:setShipVOs(arg_3_1)
	self.shipVOs = arg_3_1

	return
end

function ShipModLayer:init()
	self.blurPanelTF = self._tf:Find("blur_panel")
	self.mainPanel = self._tf:Find("blur_panel/main")
	self.shipContainer = self.mainPanel:Find("bg/add_ship_panel/ships")
	self.attrsPanel = self.mainPanel:Find("bg/property_panel/attrs")

	setText(self.mainPanel:Find("bg/add_ship_panel/title/tip"), i18n("ship_mod_exp_to_attr_tip"))

	return
end

function ShipModLayer:didEnter()
	onButton(self, self.mainPanel:Find("ok_btn"), function()
		local function var_6_0()
			local var_7_0, var_7_1 = ShipStatus.ShipStatusCheck("onModify", self.shipVO)

			if not var_7_0 then
				pg.TipsMgr.GetInstance():ShowTips(var_7_1)

				return
			end

			if not self.contextData.materialShipIds or #self.contextData.materialShipIds == 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_materal_no_enough"))

				return
			else
				self:startModShip()
			end

			return
		end

		if self.shipVO:isActivityNpc() then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("npc_strength_tip"),
				onYes = var_6_0
			})
		else
			var_6_0()
		end

		return
	end, SFX_CONFIRM)
	onButton(self, self.mainPanel:Find("cancel_btn"), function()
		if not self.contextData.materialShipIds or table.getCount(self.contextData.materialShipIds) == 0 then
			return
		end

		self:clearAllShip()

		return
	end, SFX_CANCEL)
	onButton(self, self.mainPanel:Find("select_btn"), function()
		self:emit(ShipModMediator.ON_AUTO_SELECT_SHIP)

		return
	end, SFX_CANCEL)
	self:initAttrs()

	self.inited = true

	self:emit(ShipModMediator.LOADEND, self.mainPanel)
	self:blurPanel(true)

	return
end

function ShipModLayer:blurPanel(arg_10_1)
	if arg_10_1 then
		self:OverlayPanel(self.blurPanelTF, {
			pbList = {
				self.mainPanel:Find("bg")
			},
			overlayType = LayerWeightConst.OVERLAY_UI_ADAPT
		})
	else
		self:UnOverlayPanel(self.blurPanelTF, self._tf)
	end

	return
end

function ShipModLayer:startModShip()
	if not self.hasAddition then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("ship_mod_no_addition_tip"),
			onYes = function()
				self:emit(ShipModMediator.MOD_SHIP, self.shipVO.id)

				return
			end
		})
	else
		self:emit(ShipModMediator.MOD_SHIP, self.shipVO.id)
	end

	return
end

function ShipModLayer:setShip(arg_13_1)
	self.shipVO = arg_13_1

	self:initSelectedShips()

	if self.inited then
		self:initAttrs()
	end

	return
end

function ShipModLayer:clearAllShip()
	for iter_14_0 = 1, var_0_1 do
		local var_14_0 = self.shipContainer:GetChild(iter_14_0 - 1)

		setActive(var_14_0:Find("IconTpl"), false)
		onButton(self, var_14_0:Find("add"), function()
			self:emit(ShipModMediator.ON_SELECT_MATERIAL_SHIPS)

			return
		end, SFX_PANEL)
	end

	self.contextData.materialShipIds = nil

	self:updateAttrs()

	return
end

function ShipModLayer:initSelectedShips()
	local var_16_0 = self.contextData.materialShipIds or {}
	local var_16_1 = table.getCount(var_16_0)

	for iter_16_0 = 1, var_0_1 do
		local var_16_2 = self.shipContainer:GetChild(iter_16_0 - 1)

		if iter_16_0 <= var_16_1 then
			self:updateShip(var_16_2, var_16_0[iter_16_0])
		else
			onButton(self, var_16_2:Find("add"), function()
				self:emit(ShipModMediator.ON_SELECT_MATERIAL_SHIPS)

				return
			end, SFX_PANEL)
		end

		setActive(var_16_2:Find("IconTpl"), iter_16_0 <= var_16_1)
	end

	return
end

function ShipModLayer:updateShip(arg_18_1, arg_18_2)
	onButton(self, arg_18_1, function()
		for iter_19_0, iter_19_1 in ipairs(self.contextData.materialShipIds) do
			if arg_18_2 == iter_19_1 then
				local var_19_0 = arg_18_1:Find("add")

				setActive(arg_18_1:Find("IconTpl"), false)
				onButton(self, var_19_0, function()
					self:emit(ShipModMediator.ON_SELECT_MATERIAL_SHIPS)

					return
				end, SFX_PANEL)
				table.remove(self.contextData.materialShipIds, iter_19_0)
				self:updateAttrs()

				break
			end
		end

		return
	end, SFX_PANEL)
	updateShip(arg_18_1:Find("IconTpl"), self.shipVOs[arg_18_2], {
		initStar = true
	})
	setText(arg_18_1:Find("IconTpl/icon_bg/lv/Text"), self.shipVOs[arg_18_2].level)

	return
end

function ShipModLayer:initAttrs()
	self.attrTFs = {}

	for iter_21_0, iter_21_1 in pairs(ShipModAttr.ID_TO_ATTR) do
		if self.IGNORE_ID ~= iter_21_0 then
			self.attrTFs[iter_21_0] = self.attrsPanel:Find("attr_" .. iter_21_0)
		end
	end

	self:updateAttrs()

	return
end

function ShipModLayer:updateAttrs()
	self.hasAddition = nil

	for iter_22_0, iter_22_1 in pairs(self.attrTFs) do
		self:updateAttr(iter_22_0)
	end

	return
end

function ShipModLayer:updateAttr(arg_23_1)
	local var_23_0 = self.attrTFs[arg_23_1]
	local var_23_1 = self.attrTFs[arg_23_1]:Find("info")
	local var_23_2 = self.attrTFs[arg_23_1]:GetComponent(typeof(CanvasGroup))
	local var_23_3 = ShipModAttr.ID_TO_ATTR[arg_23_1]
	local var_23_4 = self.shipVO:getModAttrTopLimit(ShipModAttr.ID_TO_ATTR[arg_23_1])
	local var_23_5 = intProperties(self.shipVO:getShipProperties())
	local var_23_6 = ShipModLayer.getExpAddition(self.shipVO, self:getMaterialShips(self.contextData.materialShipIds), ShipModAttr.ID_TO_ATTR[arg_23_1])
	local var_23_7 = self.shipVO:getModExpRatio(ShipModAttr.ID_TO_ATTR[arg_23_1])
	local var_23_8 = math.max(self.shipVO:getModExpRatio(ShipModAttr.ID_TO_ATTR[arg_23_1]), 1)

	if var_23_6 ~= 0 then
		self.hasAddition = true
	end

	local var_23_9 = self.shipVO:getModAttrBaseMax(var_23_3)
	local var_23_10 = self.getRemainExp(self.shipVO, var_23_3)

	setText(var_23_1:Find("info_container/addition"), "+" .. math.max(math.min(math.floor((var_23_10 + var_23_6) / var_23_8), var_23_9 - var_23_5[var_23_3]), 0))
	setText(var_23_1:Find("info_container/name"), AttributeType.Type2Name(var_23_3))
	setText(var_23_1:Find("max_container/Text"), var_23_9)
	setText(var_23_1:Find("info_container/value"), var_23_5[var_23_3])

	var_23_2.alpha = var_23_5[var_23_3] == 0 and 0.3 or 1

	self:setSliderValue(var_23_1:Find("prev_slider"):GetComponent(typeof(Slider)), (var_23_6 + var_23_10) / var_23_8)

	local var_23_11 = var_23_10 / var_23_8
	local var_23_12 = var_23_10 + var_23_6 .. "/" .. var_23_7

	if var_23_9 == var_23_5[var_23_3] and var_23_5[var_23_3] ~= 0 then
		var_23_11 = 1
		var_23_12 = "MAX"
	end

	self:setSliderValue(var_23_1:Find("cur_slider"):GetComponent(typeof(Slider)), var_23_11)
	setText(var_23_0:Find("exp_container/Text"), var_23_12)

	return
end

function ShipModLayer:modAttrAnim(arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_3 or 0.3
	local var_24_1 = intProperties(arg_24_1:getShipProperties())
	local var_24_2 = intProperties(arg_24_2:getShipProperties())

	self.tweens = {}

	for iter_24_0, iter_24_1 in pairs(self.attrTFs) do
		local var_24_3 = ShipModAttr.ID_TO_ATTR[iter_24_0]
		local var_24_4 = self.shipVO:getModAttrBaseMax(ShipModAttr.ID_TO_ATTR[iter_24_0])

		if arg_24_1:getModAttrTopLimit(ShipModAttr.ID_TO_ATTR[iter_24_0]) == 0 then
			self:updateAttr(iter_24_0)
		else
			local var_24_5 = self.attrTFs[iter_24_0]
			local var_24_6 = self.attrTFs[iter_24_0]:Find("info")
			local var_24_7 = var_24_6:Find("info_container/value")
			local var_24_8 = var_24_1[ShipModAttr.ID_TO_ATTR[iter_24_0]] - var_24_2[ShipModAttr.ID_TO_ATTR[iter_24_0]]
			local var_24_9 = math.max(arg_24_1:getModExpRatio(ShipModAttr.ID_TO_ATTR[iter_24_0]), 1)
			local var_24_10 = var_24_6:Find("cur_slider")
			local var_24_11 = var_24_6:Find("prev_slider")
			local var_24_12 = var_24_10:GetComponent(typeof(Slider))
			local var_24_13 = self.getRemainExp(arg_24_1, ShipModAttr.ID_TO_ATTR[iter_24_0])
			local var_24_14 = var_24_6:Find("info_container/addition")
			local var_24_15 = self.attrTFs[iter_24_0]:Find("exp_container/Text")

			self:setSliderValue(var_24_11:GetComponent(typeof(Slider)), 0)
			setText(var_24_5:Find("exp_container/Text"), var_24_13 .. "/" .. var_24_9)

			local function var_24_16(arg_25_0, arg_25_1)
				setText(var_24_7, arg_25_0)
				setText(var_24_14, "+" .. arg_25_1)

				return
			end

			if var_24_8 >= 1 then
				local var_24_17 = var_24_2[ShipModAttr.ID_TO_ATTR[iter_24_0]]

				self:tweenValue(var_24_12, var_24_12.value, 1, var_24_0, nil, function(arg_26_0)
					self:setSliderValue(var_24_12, arg_26_0)

					return
				end, function()
					pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_BREAK_OUT_FULL)

					var_24_17 = var_24_17 + 1

					var_24_16(var_24_17, var_24_1[var_24_3] - var_24_17)

					if var_24_1[var_24_3] - var_24_17 > 0 then
						self:tweenValue(var_24_12, 0, 1, var_24_0, nil, function(arg_28_0)
							self:setSliderValue(var_24_12, arg_28_0)

							return
						end, function()
							pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_BREAK_OUT_FULL)

							var_24_17 = var_24_17 + 1

							var_24_16(var_24_17, var_24_1[var_24_3] - var_24_17)

							if var_24_17 == var_24_1[var_24_3] then
								self:tweenValue(var_24_12, 0, var_24_13 / var_24_9, var_24_0, nil, function(arg_30_0)
									self:setSliderValue(var_24_12, arg_30_0)

									return
								end, function()
									if var_24_4 == var_24_1[var_24_3] then
										self:setSliderValue(var_24_12, 1)
										setText(var_24_15, "MAX")
									end

									return
								end)
							end

							return
						end, var_24_1[var_24_3] - var_24_17)
					else
						self:tweenValue(var_24_12, 0, var_24_13 / var_24_9, var_24_0, nil, function(arg_32_0)
							self:setSliderValue(var_24_12, arg_32_0)

							return
						end, function()
							if var_24_4 == var_24_1[var_24_3] then
								self:setSliderValue(var_24_12, 1)
								setText(var_24_15, "MAX")
							end

							return
						end)
					end

					return
				end)
			else
				self:tweenValue(var_24_12, var_24_12.value, var_24_13 / var_24_9, var_24_0, nil, function(arg_34_0)
					self:setSliderValue(var_24_12, arg_34_0)

					return
				end, function()
					if var_24_4 == var_24_1[var_24_3] then
						self:setSliderValue(var_24_12, 1)
						setText(var_24_15, "MAX")
					end

					return
				end)
			end
		end
	end

	return
end

function ShipModLayer:tweenValue(arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5, arg_36_6, arg_36_7, arg_36_8)
	assert(not self.exited, "tween after ui exited")

	if not self.tweens then
		return
	end

	self.tweens[arg_36_1] = arg_36_1

	LeanTween.cancel(go(arg_36_1))

	if arg_36_8 and arg_36_8 > 0 then
		LeanTween.value(go(arg_36_1), arg_36_2, arg_36_3, arg_36_4):setOnUpdate(System.Action_float(function(arg_37_0)
			if arg_36_6 then
				arg_36_6(arg_37_0)
			end

			return
		end)):setDelay(arg_36_5 or 0):setOnComplete(System.Action(function()
			if arg_36_7 then
				arg_36_7()
			end

			return
		end)):setRepeat(arg_36_8)
	end

	return
end

function ShipModLayer.getBuffExp()
	local var_39_0 = 0

	for iter_39_0, iter_39_1 in ipairs((BuffHelper.GetShipModExpBuff())) do
		var_39_0 = math.max(iter_39_1 and iter_39_1:getConfig("benefit_effect") / 100 or 0, var_39_0)
	end

	return var_39_0
end

function ShipModLayer:getModExpAdditions(arg_40_1)
	local var_40_0 = {}
	local var_40_1 = ShipModLayer.getBuffExp()

	for iter_40_0, iter_40_1 in pairs(ShipModAttr.ID_TO_ATTR) do
		local var_40_2 = 0

		if iter_40_0 ~= ShipModLayer.IGNORE_ID then
			for iter_40_2, iter_40_3 in pairs(arg_40_1) do
				assert(pg.ship_data_strengthen[pg.ship_data_template[iter_40_3.configId].strengthen_id], "ship_data_strengthen>>" .. pg.ship_data_template[iter_40_3.configId].strengthen_id)

				local var_40_3 = pg.ship_data_strengthen[pg.ship_data_template[iter_40_3.configId].strengthen_id].attr_exp[iter_40_0 - 1]

				if pg.ship_data_template[iter_40_3.configId].group_type == pg.ship_data_template[self.configId].group_type then
					var_40_3 = var_40_3 * 2
				end

				var_40_2 = var_40_2 + var_40_3
			end
		end

		var_40_0[iter_40_1] = math.floor(var_40_2 * (1 + var_40_1))
	end

	return var_40_0
end

function ShipModLayer:getMaterialShips(arg_41_1)
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in ipairs(arg_41_1 or {}) do
		table.insert(var_41_0, self.shipVOs[iter_41_1])
	end

	return var_41_0
end

function ShipModLayer:getExpAddition(arg_42_1, arg_42_2)
	if self:getModAttrTopLimit(arg_42_2) == 0 then
		return 0, 0
	else
		local var_42_0 = Clone(self)

		var_42_0:addModAttrExp(arg_42_2, ShipModLayer.getModExpAdditions(self, arg_42_1)[arg_42_2])

		return var_42_0:getModProperties(arg_42_2) - self:getModProperties(arg_42_2)
	end

	return
end

function ShipModLayer:getRemainExp(arg_43_1)
	return self:getModProperties(arg_43_1) % math.max(self:getModExpRatio(arg_43_1), 1)
end

function ShipModLayer:setSliderValue(arg_44_1, arg_44_2)
	arg_44_1.value = arg_44_2 == 0 and arg_44_2 or math.max(arg_44_2, 0.08)

	return
end

function ShipModLayer:willExit()
	self:blurPanel(false)

	for iter_45_0, iter_45_1 in pairs(self.tweens or {}) do
		LeanTween.cancel(go(iter_45_1))
	end

	self.tweens = nil

	return
end

function ShipModLayer:onBackPressed()
	self:emit(BaseUI.ON_BACK_PRESSED, true)

	return
end

return ShipModLayer
