local EquipUpgradeLayer = class("EquipUpgradeLayer", import("..base.BaseUI"))

EquipUpgradeLayer.CHAT_DURATION_TIME = 0.3

function EquipUpgradeLayer:getUIName()
	return "EquipUpgradeUI"
end

function EquipUpgradeLayer:init()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.mainPanel = self._tf:Find("main")
	self.finishPanel = self._tf:Find("finish_panel")

	setActive(self.mainPanel, true)
	setActive(self.finishPanel, false)

	self.equipmentList = self.mainPanel:Find("panel/equipment_list")
	self.equipmentContain = self.equipmentList:Find("equipments")
	self.equipmentTpl = self:getTpl("equiptpl", self.equipmentContain)

	setActive(self.equipmentList, false)

	self.equipmentPanel = self.mainPanel:Find("panel/equipment_panel")
	self.materialPanel = self.mainPanel:Find("panel/material_panel")
	self.startBtn = self.materialPanel:Find("start_btn")
	self.overLimit = self.materialPanel:Find("materials/limit")

	setText(self.overLimit:Find("text"), i18n("equipment_upgrade_overlimit"))

	self.materialsContain = self.materialPanel:Find("materials/materials")

	setText(self.rtTogglesEmpty:Find("Text"), i18n("equip_enhancement_finish"))
	setText(self.rtPanelTitle, i18n("equip_enhancement_required"))
	setText(self.rtTitle, i18n("equip_enhancement_title"))

	return
end

function EquipUpgradeLayer:didEnter()
	onButton(self, self._tf:Find("bg"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnCancel, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	self:updateAll()

	return
end

function EquipUpgradeLayer:updateAll()
	setActive(self.equipmentList, self.contextData.shipVO)

	if self.contextData.shipVO then
		self:displayEquipments()

		if self.contextData.pos then
			triggerButton(self.equipmentTFs[self.contextData.pos])
		else
			triggerButton(self.equipmentContain:GetChild(0))
		end
	else
		self:updateEquipment()
		self:updateMaterials()
	end

	return
end

function EquipUpgradeLayer:displayEquipments()
	self.equipmentTFs = {}

	removeAllChildren(self.equipmentContain)

	local var_7_0 = self.contextData.shipVO

	for iter_7_0, iter_7_1 in ipairs(self.contextData.shipVO.equipments) do
		if iter_7_1 then
			local var_7_1 = cloneTplTo(self.equipmentTpl, self.equipmentContain)

			updateEquipment(var_7_1, iter_7_1)

			local var_7_2 = var_7_1:Find("tip")

			setActive(var_7_2, false)

			if self:isMaterialEnough(iter_7_1) and iter_7_1:getConfig("next") ~= 0 then
				setActive(var_7_2, true)
				blinkAni(var_7_2, 0.5)
			end

			onButton(self, var_7_1, function()
				if self.contextData.pos then
					setActive(self.equipmentTFs[self.contextData.pos]:Find("selected"), false)

					local var_8_0 = self:isMaterialEnough(var_7_0:getEquip(self.contextData.pos))

					if var_8_0 then
						var_8_0 = var_7_0:getEquip(self.contextData.pos):getConfig("next") ~= 0
					end

					setActive(self.equipmentTFs[self.contextData.pos]:Find("tip"), var_8_0)
				end

				self.contextData.pos = iter_7_0
				self.contextData.equipmentId = iter_7_1.id
				self.contextData.equipmentVO = iter_7_1

				setActive(self.equipmentTFs[self.contextData.pos]:Find("selected"), true)
				setActive(self.equipmentTFs[self.contextData.pos]:Find("tip"), false)
				self:updateEquipment()
				self:updateMaterials()

				return
			end, SFX_PANEL)

			self.equipmentTFs[iter_7_0] = var_7_1
		end
	end

	return
end

function EquipUpgradeLayer:isMaterialEnough(arg_9_1)
	local var_9_0 = arg_9_1:getConfig("trans_use_item")

	if not var_9_0 then
		return false
	end

	for iter_9_0, iter_9_1 in ipairs(underscore.map(var_9_0, function(arg_10_0)
		local var_10_0, var_10_1 = unpack(arg_10_0)

		return Drop.New({
			type = DROP_TYPE_ITEM,
			id = var_10_0,
			count = var_10_1
		})
	end)) do
		if iter_9_1.count > iter_9_1:getOwnedCount() then
			return false
		end
	end

	return true
end

function EquipUpgradeLayer:updateEquipment()
	local var_11_0 = self.contextData.equipmentVO

	self.contextData.equipmentId = self.contextData.equipmentVO.id

	changeToScrollText(self.equipmentPanel:Find("name_container"), var_11_0:getConfig("name"))
	setActive(findTF(self.equipmentPanel, "unique"), var_11_0:isUnique())
	updateEquipment(self.equipmentPanel:Find("equiptpl"), var_11_0)

	self.nextEquips = {}

	while var_11_0:getConfig("next") > 0 do
		var_11_0 = var_11_0:MigrateTo(var_11_0:getConfig("next"))

		table.insert(self.nextEquips, var_11_0)
	end

	if #self.nextEquips == 0 then
		self.toggleEquips = nil
	else
		self.toggleEquips = {
			self.nextEquips[1]
		}

		if #self.nextEquips > 0 then
			local var_11_1 = self.nextEquips[#self.nextEquips]:getConfig("level")

			for iter_11_0, iter_11_1 in ipairs((switch(self.nextEquips[#self.nextEquips]:getConfig("level") - 1, {
				[13] = function()
					return {
						10,
						13
					}
				end,
				[11] = function()
					return {
						10,
						11
					}
				end,
				[10] = function()
					return {
						10
					}
				end,
				[7] = function()
					return {
						6,
						7
					}
				end,
				[6] = function()
					return {
						6
					}
				end,
				[3] = function()
					return {
						3
					}
				end
			}, function()
				return {}
			end))) do
				if #self.nextEquips > var_11_1 - 1 - iter_11_1 then
					table.insert(self.toggleEquips, self.nextEquips[#self.nextEquips - (var_11_1 - 1 - iter_11_1)])
				end
			end
		end
	end

	self:updateToggles()

	return
end

function EquipUpgradeLayer:updateToggles()
	setActive(self.rtToggles, tobool(self.toggleEquips))
	setActive(self.rtTogglesEmpty, not tobool(self.toggleEquips))

	if self.toggleEquips then
		UIItemList.StaticAlign(self.rtToggles, self.rtToggleTpl, #self.toggleEquips, function(arg_20_0, arg_20_1, arg_20_2)
			arg_20_1 = arg_20_1 + 1

			if arg_20_0 == UIItemList.EventUpdate then
				local var_20_0 = self.toggleEquips[arg_20_1]

				if arg_20_1 == 1 then
					setText(arg_20_2:Find("Text"), i18n("equip_enhancement_lv1"))
				else
					setText(arg_20_2:Find("Text"), i18n("equip_enhancement_lvx", self.toggleEquips[arg_20_1]:getConfig("level") - 1))
				end

				onToggle(self, arg_20_2, function(arg_21_0)
					if arg_21_0 then
						self.targetEquip = var_20_0

						self:updateMaterials()
					end

					return
				end, SFX_PANEL)
			end

			return
		end)
		triggerToggle(self.rtToggles:GetChild(0), true)
	else
		self.targetEquip = nil

		self:updateMaterials()
	end

	return
end

local function var_0_1(arg_22_0)
	arg_22_0.sub = {
		(_.detect(arg_22_0.sub, function(arg_23_0)
			return arg_23_0.type == AttributeType.Damage
		end))
	}

	return
end

local function var_0_2(arg_24_0)
	arg_24_0.sub = {
		(_.detect(arg_24_0.sub, function(arg_25_0)
			return arg_25_0.type == AttributeType.Corrected
		end))
	}

	return
end

function EquipUpgradeLayer:updateAttrs(arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_2:GetPropertiesInfo()

	for iter_26_0 = 1, #var_26_0.weapon.sub do
		var_0_1(var_26_0.weapon.sub[iter_26_0])
	end

	var_0_2(var_26_0.equipInfo)

	var_26_0.equipInfo.lock_open = true

	if arg_26_3 then
		local var_26_1 = arg_26_3:GetPropertiesInfo()

		Equipment.InsertAttrsUpgrade(var_26_0.attrs, var_26_1.attrs)

		local var_26_2 = arg_26_2:GetSkill()
		local var_26_3 = arg_26_3:GetSkill()

		if checkExist(var_26_2, {
			"name"
		}) ~= checkExist(var_26_3, {
			"name"
		}) then
			local var_26_4 = {
				lock_open = true,
				name = i18n("skill")
			}

			var_26_4.value = setColorStr(checkExist(var_26_2, {
				"name"
			}) or i18n("equip_info_25"), "#FFDE00FF")

			local var_26_5 = {}
			local var_26_6 = {
				name = i18n("equip_info_26")
			}

			var_26_6.value = setColorStr(checkExist(var_26_3, {
				"name"
			}) or i18n("equip_info_25"), "#FFDE00FF")
			var_26_5[1] = var_26_6
			var_26_4.sub = var_26_5

			table.insert(var_26_0.attrs, var_26_4)
		end

		if #var_26_1.weapon.sub > #var_26_0.weapon.sub then
			for iter_26_1 = #var_26_0.weapon.sub, #var_26_1.weapon.sub do
				table.insert(var_26_0.weapon.sub, {
					name = i18n("equip_info_25"),
					sub = {}
				})
			end
		end

		for iter_26_2 = #var_26_0.weapon.sub, 1, -1 do
			local var_26_7 = var_26_0.weapon.sub[iter_26_2]
			local var_26_8 = var_26_1.weapon.sub[iter_26_2]

			if var_26_1.weapon.sub[iter_26_2] then
				var_0_1(var_26_1.weapon.sub[iter_26_2])
			else
				var_26_8 = {
					name = i18n("equip_info_25"),
					sub = {}
				}
			end

			if var_26_7.name ~= var_26_8.name then
				var_26_7.sub = {
					{
						name = i18n("equip_info_27"),
						value = var_26_8.name
					}
				}
			else
				Equipment.InsertAttrsUpgrade(var_26_7.sub, var_26_8.sub)
			end

			if #var_26_7.sub == 0 then
				table.remove(var_26_0.weapon.sub, iter_26_2)

				if var_26_1.weapon.sub[iter_26_2] then
					table.remove(var_26_1.weapon.sub, iter_26_2)
				end
			end
		end

		var_0_2(var_26_1.equipInfo)
		Equipment.InsertAttrsUpgrade(var_26_0.equipInfo.sub, var_26_1.equipInfo.sub)
	end

	updateEquipUpgradeInfo(arg_26_1, var_26_0, self.contextData.shipVO)

	return
end

function EquipUpgradeLayer:updateMaterials()
	local var_27_0 = tobool(self.targetEquip)

	setActive(self.materialsContain, var_27_0)
	setActive(self.overLimit, not var_27_0)
	setButtonEnabled(self.startBtn, var_27_0)
	setTextAlpha(self.startBtn:Find("consume"), var_27_0 and 1 or 0.5)
	self:updateAttrs(self.equipmentPanel:Find("view/content"), self.contextData.equipmentVO, self.targetEquip)
	setText(self.rtLevel:Find("before"), i18n("equip_enhancement_lv"))
	setText(self.rtLevel:Find("before/number"), self.contextData.equipmentVO:getConfig("level") - 1)
	setText(self.rtLevel:Find("after"), i18n("equip_enhancement_lv"))
	setText(self.rtLevel:Find("after/number"), (self.targetEquip or self.contextData.equipmentVO):getConfig("level") - 1)
	setActive(self.rtLevel:Find("before"), var_27_0)
	setActive(self.rtLevel:Find("Image"), var_27_0)

	local var_27_1

	if not var_27_0 then
		setText(self.startBtn:Find("consume"), 0)

		do return end

		var_27_1 = self.contextData.equipmentVO:getConfig("trans_use_item") or {}
	end

	local var_27_2 = underscore.to_array(var_27_1)
	local var_27_3 = defaultValue(self.contextData.equipmentVO:getConfig("trans_use_gold"), 0)

	for iter_27_0, iter_27_1 in ipairs(self.nextEquips) do
		if iter_27_1 == self.targetEquip then
			break
		else
			table.insertto(var_27_2, iter_27_1:getConfig("trans_use_item") or {})

			var_27_3 = var_27_3 + defaultValue(iter_27_1:getConfig("trans_use_gold"), 0)
		end
	end

	local var_27_4 = PlayerConst.MergeSameDrops(underscore.map(var_27_2, function(arg_28_0)
		local var_28_0, var_28_1 = unpack(arg_28_0)

		return Drop.New({
			type = DROP_TYPE_ITEM,
			id = var_28_0,
			count = var_28_1
		})
	end))
	local var_27_5 = true
	local var_27_6
	local var_27_7 = 0

	for iter_27_2 = 1, 5 do
		local var_27_8 = self.materialsContain:GetChild(iter_27_2 - 1)
		local var_27_9 = var_27_4[iter_27_2]

		setActive(findTF(var_27_8, "off"), not var_27_4[iter_27_2])
		setActive(findTF(var_27_8, "equiptpl"), var_27_9)

		if var_27_9 then
			local var_27_10 = findTF(var_27_8, "equiptpl")

			updateItem(var_27_10, var_27_9:getSubClass())
			onButton(self, var_27_10, function()
				self:emit(BaseUI.ON_DROP, var_27_9)

				return
			end, SFX_PANEL)

			local var_27_11 = var_27_9:getOwnedCount()
			local var_27_12 = var_27_10:Find("icon_bg/count")

			if var_27_11 < var_27_9.count then
				setText(var_27_12, setColorStr(var_27_11, COLOR_RED) .. "/" .. var_27_9.count)

				var_27_5 = false
				var_27_6 = var_27_9.id
			else
				setText(var_27_12, var_27_11 .. "/" .. var_27_9.count)
			end

			setActive(var_27_12, true)
			onButton(self, var_27_10:Find("click"), function()
				setActive(var_27_10:Find("click"), false)

				var_27_7 = var_27_7 - 1

				return
			end, SFX_PANEL)

			local var_27_13 = var_27_9:getDropRarity() > 3

			setActive(var_27_10:Find("click"), var_27_13)

			var_27_7 = var_27_7 + (var_27_13 and 1 or 0)
		end
	end

	local var_27_14 = Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = PlayerConst.ResGold,
		count = var_27_3
	})
	local var_27_15 = var_27_14:getOwnedCount()

	if var_27_15 < var_27_14.count then
		setText(self.startBtn:Find("consume"), setColorStr(var_27_3, COLOR_RED))
	else
		setText(self.startBtn:Find("consume"), var_27_3)
	end

	onButton(self, self.startBtn, function()
		if not var_27_5 then
			if not ItemTipPanel.ShowItemTipbyID(var_27_6) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ship_shipUpgradeLayer2_noMaterail"))
			end

			return
		end

		if var_27_7 > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_upgrade_costcheck_error"))

			return
		end

		if var_27_15 < var_27_3 then
			GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
				{
					59001,
					var_27_3 - var_27_15,
					var_27_3
				}
			})

			return
		end

		self:emit(EquipUpgradeMediator.EQUIPMENT_UPGRDE, self.targetEquip, var_27_4, var_27_3)

		return
	end, SFX_UI_DOCKYARD_REINFORCE)

	return
end

function EquipUpgradeLayer:upgradeFinish(arg_32_1, arg_32_2)
	setActive(self.mainPanel, false)
	setActive(self.finishPanel, true)
	onButton(self, self.finishPanel:Find("bg"), function()
		setActive(self.mainPanel, true)
		setActive(self.finishPanel, false)

		return
	end, SFX_CANCEL)
	changeToScrollText(self.finishPanel:Find("frame/equipment_panel/name_container"), arg_32_2:getConfig("name"))
	setActive(findTF(self.finishPanel, "frame/equipment_panel/unique"), arg_32_2:isUnique())
	updateEquipment(self.finishPanel:Find("frame/equipment_panel/equiptpl"), arg_32_2)
	self:updateAttrs(self.finishPanel:Find("frame/equipment_panel/view/content"), arg_32_1, arg_32_2)

	return
end

function EquipUpgradeLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return EquipUpgradeLayer
