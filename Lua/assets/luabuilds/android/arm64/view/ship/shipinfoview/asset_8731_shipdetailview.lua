local ShipDetailView = class("ShipDetailView", import("...base.BaseSubView"))
local EquipmentSortCfg = require("view.equipment.EquipmentSortCfg")

function ShipDetailView:getUIName()
	return "ShipDetailView"
end

function ShipDetailView:OnInit()
	self:InitDetail()
	self:InitEvent()
	setParent(self.randomFlagToggle, self._tf.parent)
	triggerToggle(self.showQuickBtn, false)
	triggerToggle(self.showRecordBtn, false)

	return
end

function ShipDetailView:InitDetail()
	self.mainPanel = self._parentTf.parent
	self.detailPanel = self._tf
	self.attrs = self.detailPanel:Find("attrs")

	setActive(self.attrs, false)

	self.shipDetailLogicPanel = ShipDetailLogicPanel.New(self.attrs)

	self.shipDetailLogicPanel:attach(self)

	self.equipments = self.detailPanel:Find("equipments")
	self.equipmentsGrid = self.equipments:Find("equipments")
	self.detailEquipmentTpl = self.equipments:Find("equipment_tpl")
	self.emptyGridTpl = self.equipments:Find("empty_tpl")
	self.showRecordBtn = self.equipments:Find("unload_all")
	self.showQuickBtn = self.equipments:Find("quickButton")
	self.showECodeShareBtn = self.equipments:Find("shareButton")
	self.equipCodeBtn = self.equipments:Find("equip_code")
	self.lockBtn = self.detailPanel:Find("lock_btn")
	self.unlockBtn = self.detailPanel:Find("unlock_btn")
	self.viewBtn = self.detailPanel:Find("view_btn")
	self.evaluationBtn = self.detailPanel:Find("evaluation_btn")
	self.profileBtn = self.detailPanel:Find("profile_btn")
	self.fashionToggle = self.detailPanel:Find("fashion_toggle")
	self.randomFlagToggle = self.detailPanel:Find("random_flag_toggle")
	self.fashionTag = self.fashionToggle:Find("Tag")
	self.commonTagToggle = self.detailPanel:Find("common_toggle")
	self.spWeaponSlot = self.equipments:Find("SpSlot")
	self.propertyIcons = self.detailPanel:Find("attrs/attrs/property/icons")
	self.intimacyTF = self._tf:Find("intimacy")
	self.updateItemTick = 0
	self.quickPanel = self.detailPanel:Find("quick_panel")
	self.equiping = self.quickPanel:Find("equiping")
	self.fillter = self.quickPanel:Find("fillter")
	self.selectTitle = self.quickPanel:Find("frame/selectTitle")
	self.emptyTitle = self.quickPanel:Find("frame/emptyTitle")
	self.list = self.quickPanel:Find("frame/container/Content"):GetComponent("LScrollRect")
	self.indexData = {}

	self:CloseQuickPanel()
	setText(self.quickPanel:Find("fillter/on/text2"), i18n("quick_equip_tip2"))
	setText(self.quickPanel:Find("fillter/off/text2"), i18n("quick_equip_tip2"))
	setText(self.quickPanel:Find("equiping/on/text2"), i18n("quick_equip_tip1"))
	setText(self.quickPanel:Find("equiping/off/text2"), i18n("quick_equip_tip1"))
	setText(self.quickPanel:Find("title/text"), i18n("quick_equip_tip3"))
	setText(self.quickPanel:Find("frame/emptyTitle/text"), i18n("quick_equip_tip4"))
	setText(self.quickPanel:Find("frame/selectTitle/text"), i18n("quick_equip_tip5"))
	setText(self.randomFlagToggle:Find("bg/Text"), i18n("ship_random_secretary_tag"))

	self.equipmentProxy = getProxy(EquipmentProxy)
	self.recordPanel = self.detailPanel:Find("record_panel")
	self.unloadAllBtn = self.recordPanel:Find("frame/unload_all")
	self.recordBars = _.map({
		1,
		2,
		3
	}, function(arg_4_0)
		return self.recordPanel:Find("frame/container"):GetChild(arg_4_0 - 1)
	end)
	self.recordBtns = {
		self.recordPanel:Find("frame/container/record_1/record_btn"),
		self.recordPanel:Find("frame/container/record_2/record_btn"),
		self.recordPanel:Find("frame/container/record_3/record_btn")
	}
	self.recordEquipmentsTFs = {
		self.recordPanel:Find("frame/container/record_1/equipments"),
		self.recordPanel:Find("frame/container/record_2/equipments"),
		self.recordPanel:Find("frame/container/record_3/equipments")
	}
	self.equipRecordBtns = {
		self.recordPanel:Find("frame/container/record_1/equip_btn"),
		self.recordPanel:Find("frame/container/record_2/equip_btn"),
		self.recordPanel:Find("frame/container/record_3/equip_btn")
	}
	self.searchBar = RecordableSearchBar.New(RecordableSearchBar.CreateData({
		uiName = "RecordableSearchBarUI4ShipDetailView",
		holder = i18n("search_equipment"),
		onInputChanged = function()
			self:updateQuickPanel(true)

			return
		end,
		key = self.__cname,
		parent = self.quickPanel,
		anchoredPosition = Vector3(-623, -34, 0)
	}))

	setActive(self.detailPanel, true)
	setActive(self.attrs, true)
	setActive(self.recordPanel, false)
	setActive(self.detailEquipmentTpl, false)
	setActive(self.emptyGridTpl, false)
	setActive(self.detailPanel, true)

	self.onSelected = false

	if PLATFORM_CODE == PLATFORM_CHT and LOCK_SP_WEAPON then
		setActive(self.showRecordBtn, false)
		setActive(self.showQuickBtn, false)
		setActive(self.spWeaponSlot, false)

		self.showRecordBtn = self.equipments:Find("unload_all_2")
		self.showQuickBtn = self.equipments:Find("quickButton_2")

		setActive(self.showRecordBtn, true)
		setActive(self.showQuickBtn, true)
	end

	return
end

function ShipDetailView:InitEvent()
	onButton(self, self.fashionToggle, function()
		self:emit(ShipViewConst.SWITCH_TO_PAGE, ShipViewConst.PAGE.FASHION)

		return
	end, SFX_PANEL)
	onButton(self, self.propertyIcons, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_shipinfo_attr.tip,
			onClose = function()
				return
			end
		})

		return
	end)
	onToggle(self, self.commonTagToggle, function(arg_10_0)
		local var_10_0 = self:GetShipVO().preferenceTag

		if var_10_0 == Ship.PREFERENCE_TAG_COMMON ~= arg_10_0 then
			self:emit(ShipMainMediator.ON_TAG, self:GetShipVO().id, var_10_0 == Ship.PREFERENCE_TAG_COMMON and Ship.PREFERENCE_TAG_NONE or Ship.PREFERENCE_TAG_COMMON)
		end

		return
	end, SFX_CONFIRM)
	onToggle(self, self.randomFlagToggle, function(arg_11_0)
		if self:GetShipVO():getRandomFlag() ~= arg_11_0 then
			self:emit(ShipMainMediator.CHANGE_RANDOM_FLAG, self:GetShipVO():GetShipPhantomMark(), arg_11_0)
		end

		return
	end, SFX_CONFIRM)
	onButton(self, self.lockBtn, function()
		self:emit(ShipMainMediator.ON_LOCK, {
			self:GetShipVO().id
		}, self:GetShipVO().LOCK_STATE_LOCK)

		return
	end, SFX_PANEL)
	onButton(self, self.unlockBtn, function()
		self:emit(ShipMainMediator.ON_LOCK, {
			self:GetShipVO().id
		}, self:GetShipVO().LOCK_STATE_UNLOCK)

		return
	end, SFX_PANEL)
	onButton(self, self.viewBtn, function()
		Input.multiTouchEnabled = true

		self:emit(ShipViewConst.PAINT_VIEW, true)

		return
	end, SFX_PANEL)
	onButton(self, self.evaluationBtn, function()
		self:emit(ShipMainMediator.OPEN_EVALUATION, self:GetShipVO():getGroupId(), self:GetShipVO():isActivityNpc())

		return
	end, SFX_PANEL)
	onButton(self, self.profileBtn, function()
		self:emit(ShipMainMediator.OPEN_SHIPPROFILE, self:GetShipVO():getGroupId(), self:GetShipVO():isRemoulded())

		return
	end, SFX_PANEL)
	onButton(self, self.intimacyTF, function()
		if self:GetShipVO():isActivityNpc() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("npc_propse_tip"))

			return
		end

		if LOCK_PROPOSE then
			return
		end

		self:emit(ShipMainMediator.PROPOSE, self:GetShipVO().id, function()
			return
		end)

		return
	end)
	onToggle(self, self.showRecordBtn, function(arg_19_0)
		local var_19_0, var_19_1 = ShipStatus.ShipStatusCheck("onModify", self:GetShipVO())

		if not var_19_0 then
			if arg_19_0 then
				pg.TipsMgr.GetInstance():ShowTips(var_19_1)
				onNextTick(function()
					triggerToggle(self.showRecordBtn, false)

					return
				end)
			end

			return
		end

		if arg_19_0 then
			self:displayRecordPanel()

			if self.isShowQuick then
				triggerToggle(self.showQuickBtn, false)
			end
		else
			self:CloseRecordPanel(true)
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.showQuickBtn, function(arg_21_0)
		local var_21_0, var_21_1 = ShipStatus.ShipStatusCheck("onModify", self:GetShipVO())

		if not var_21_0 then
			if arg_21_0 then
				pg.TipsMgr.GetInstance():ShowTips(var_21_1)
				onNextTick(function()
					triggerToggle(self.showQuickBtn, false)

					return
				end)
			end

			self:CloseRecordPanel(true)
			self:CloseQuickPanel()

			return
		end

		if arg_21_0 then
			self:displayQuickPanel()

			if self.selectedEquip then
				self:selectedEquipItem(self.selectedEquip.index)
			else
				self:quickSelectEmpty()
			end

			if self.isShowRecord then
				triggerToggle(self.showRecordBtn, false)
			end
		else
			self:CloseQuickPanel()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.equipCodeBtn, function()
		self:emit(ShipMainMediator.OPEN_EQUIP_CODE, {})

		return
	end, SFX_PANEL)
	onButton(self, self.showECodeShareBtn, function()
		local var_24_0 = self:GetShipVO()

		self:emit(ShipMainMediator.OPEN_EQUIP_CODE_SHARE, var_24_0.id, var_24_0:getGroupId())

		return
	end, SFX_PANEL)
	onButton(self, self.unloadAllBtn, function()
		local var_25_0, var_25_1 = ShipStatus.ShipStatusCheck("onModify", self:GetShipVO())

		if not var_25_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_25_1)
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("ship_unequip_all_tip"),
				onYes = function()
					self:emit(ShipMainMediator.UNEQUIP_FROM_SHIP_ALL, self:GetShipVO().id)

					return
				end
			})
		end

		return
	end, SFX_PANEL)

	function self.list.onInitItem(arg_27_0)
		ClearTweenItemAlphaAndWhite(arg_27_0)

		return
	end

	function self.list.onReturnItem(arg_28_0, arg_28_1)
		ClearTweenItemAlphaAndWhite(arg_28_1)

		return
	end

	function self.list.onUpdateItem(arg_29_0, arg_29_1)
		setActive(findTF(tf(arg_29_1), "IconTpl/icon_bg/icon"), false)
		TweenItemAlphaAndWhite(arg_29_1)

		if arg_29_0 == 0 and not self.selectedEquip.empty then
			setActive(findTF(tf(arg_29_1), "unEquip"), true)
			setActive(findTF(tf(arg_29_1), "bg"), false)
			setActive(findTF(tf(arg_29_1), "IconTpl"), false)
			onButton(self, tf(arg_29_1), function()
				local var_30_0 = self:GetShipVO()
				local var_30_1 = var_30_0:getEquip(self.selectedEquip.index):getConfig("name")
				local var_30_2 = var_30_0:getName()

				self:emit(ShipMainMediator.UNEQUIP_FROM_SHIP, {
					shipId = var_30_0.id,
					pos = self.selectedEquip.index
				})

				return
			end, SFX_PANEL)
		else
			setActive(findTF(tf(arg_29_1), "unEquip"), false)
			setActive(findTF(tf(arg_29_1), "bg"), true)
			setActive(findTF(tf(arg_29_1), "IconTpl"), true)

			local var_29_0 = self.fillterEquipments[(self.selectedEquip.empty or nil) and (arg_29_0 + 1 or arg_29_0)]

			if not self.fillterEquipments[(self.selectedEquip.empty or nil) and (arg_29_0 + 1 or arg_29_0)] then
				return
			end

			setActive(findTF(tf(arg_29_1), "IconTpl/icon_bg/icon"), true)
			updateEquipment(findTF(tf(arg_29_1), "IconTpl"), var_29_0)

			if var_29_0.shipId then
				setImageSprite(findTF(tf(arg_29_1), "IconTpl/icon_bg/equip_flag/Image"), LoadSprite("qicon/" .. getProxy(BayProxy):getShipById(var_29_0.shipId):getPainting()))
			end

			setActive(findTF(tf(arg_29_1), "IconTpl/icon_bg/equip_flag"), var_29_0.shipId and var_29_0.shipId > 0)
			setActive(findTF(tf(arg_29_1), "IconTpl/mask"), var_29_0.mask)
			onButton(self, tf(arg_29_1), function()
				if var_29_0.mask then
					return
				end

				self:changeEquip(var_29_0)

				return
			end, SFX_PANEL)
		end

		return
	end

	onToggle(self, self.equiping, function(arg_32_0)
		self.equipingFlag = arg_32_0

		if self.selectedEquip then
			self:updateQuickPanel(true)
		end

		return
	end, SFX_PANEL)
	triggerToggle(self.equiping, true)
	onButton(self, self.fillter, function()
		self.indexData = self.indexData or {}

		if not ShipDetailView.EQUIPMENT_INDEX then
			ShipDetailView.EQUIPMENT_INDEX = Clone(StoreHouseConst.EQUIPMENT_INDEX_COMMON)

			table.removebyvalue(ShipDetailView.EQUIPMENT_INDEX.customPanels.extraIndex.options, IndexConst.EquipmentExtraEquiping)
			table.removebyvalue(ShipDetailView.EQUIPMENT_INDEX.customPanels.extraIndex.names, "index_equip")
		end

		self:emit(ShipMainMediator.OPEN_EQUIPMENT_INDEX, (setmetatable({
			indexDatas = Clone(self.indexData),
			callback = function(self)
				self.indexData.typeIndex = self.typeIndex
				self.indexData.equipPropertyIndex = self.equipPropertyIndex
				self.indexData.equipPropertyIndex2 = self.equipPropertyIndex2
				self.indexData.equipAmmoIndex1 = self.equipAmmoIndex1
				self.indexData.equipAmmoIndex2 = self.equipAmmoIndex2
				self.indexData.equipCampIndex = self.equipCampIndex
				self.indexData.rarityIndex = self.rarityIndex
				self.indexData.extraIndex = self.extraIndex

				local var_34_0 = underscore(self.indexData):chain():keys():all(function(arg_35_0)
					return self.indexData[arg_35_0] == ShipDetailView.EQUIPMENT_INDEX.customPanels[arg_35_0].options[1]
				end):value()

				setActive(findTF(self.fillter, "on"), not var_34_0)
				setActive(findTF(self.fillter, "off"), var_34_0)
				self:updateQuickPanel(true)

				return
			end
		}, {
			__index = ShipDetailView.EQUIPMENT_INDEX
		})))

		return
	end, SFX_PANEL)

	return
end

function ShipDetailView:changeEquip(arg_36_1)
	local var_36_0 = self:GetShipVO()
	local var_36_1 = {
		quickFlag = true,
		type = EquipmentInfoMediator.TYPE_REPLACE,
		equipmentId = arg_36_1.id,
		shipId = var_36_0.id,
		pos = self.selectedEquip.index,
		oldShipId = arg_36_1.shipId,
		oldPos = arg_36_1.shipPos
	}

	if var_36_1 then
		if PlayerPrefs.GetInt("QUICK_CHANGE_EQUIP", 1) == 1 then
			self:emit(BaseUI.ON_EQUIPMENT, var_36_1)
		else
			local var_36_2, var_36_3 = var_36_0:canEquipAtPos(arg_36_1, self.selectedEquip.index)

			if not var_36_2 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_equipmentInfoLayer_error_canNotEquip", var_36_3))

				return
			end

			if arg_36_1.shipId then
				local var_36_4, var_36_5 = ShipStatus.ShipStatusCheck("onModify", (getProxy(BayProxy):getShipById(arg_36_1.shipId)))

				if not var_36_4 then
					pg.TipsMgr.GetInstance():ShowTips(var_36_5)
				else
					self:emit(ShipMainMediator.EQUIP_CHANGE_NOTICE, {
						notice = GAME.EQUIP_FROM_SHIP,
						data = var_36_1
					})
				end
			else
				self:emit(ShipMainMediator.EQUIP_CHANGE_NOTICE, {
					notice = GAME.EQUIP_TO_SHIP,
					data = var_36_1
				})
			end
		end
	end

	return
end

function ShipDetailView:SetShareData(arg_37_1)
	self.shareData = arg_37_1

	return
end

function ShipDetailView:GetShipVO()
	if self.shareData and self.shareData.shipVO then
		return self.shareData.shipVO
	end

	return nil
end

function ShipDetailView:OnSelected(arg_39_1)
	if arg_39_1 then
		self:OverlayPanel(self._parentTf, {
			pbList = {
				self.detailPanel:Find("attrs"),
				self.detailPanel:Find("equipments"),
				self.detailPanel:Find("quick_panel")
			},
			overlayType = LayerWeightConst.OVERLAY_UI_ADAPT
		})
	else
		self:UnOverlayPanel(self._parentTf, self.mainPanel)
	end

	self.onSelected = arg_39_1

	if self.onSelected and self.selectedEquip then
		self:selectedEquipItem(nil)
		self:selectedEquipItem(self.selectedEquip.index)
	end

	return
end

function ShipDetailView:UpdateUI()
	self.searchBar:ClearInputText()

	local var_40_0 = self:GetShipVO()

	self:UpdateIntimacy(var_40_0)
	self:UpdateDetail(var_40_0)
	self:UpdateEquipments(var_40_0)
	self:UpdateLock()
	self:UpdatePreferenceTag()

	self.activeRandomFlag = not var_40_0:isActivityNpc()

	setActive(self.randomFlagToggle, self.activeRandomFlag)
	triggerToggle(self.randomFlagToggle, var_40_0:getRandomFlag())

	return
end

function ShipDetailView:UpdateIntimacy(arg_41_1)
	setActive(self.intimacyTF, not LOCK_PROPOSE)
	setIntimacyIcon(self.intimacyTF, arg_41_1:getIntimacyIcon())

	return
end

function ShipDetailView:UpdateDetail(arg_42_1)
	self.shipDetailLogicPanel:flush(arg_42_1)

	local var_42_0 = self.shipDetailLogicPanel.attrs:Find("icons/hunting_range/bg")

	removeOnButton(var_42_0)

	if table.contains(ShipType.SubShipType, arg_42_1:getShipType()) then
		onButton(self, var_42_0, function()
			self:emit(ShipViewConst.DISPLAY_HUNTING_RANGE, true)

			return
		end, SFX_PANEL)
	end

	if not HXSet.isHxSkin() then
		setActive(self.fashionToggle, self.shareData:HasFashion())
	else
		setActive(self.fashionToggle, false)
	end

	self:UpdateFashionTag()
	setActive(self.profileBtn, not arg_42_1:isActivityNpc())

	return
end

function ShipDetailView:UpdateFashionTag()
	setActive(self.fashionTag, #PaintingGroupConst.GetPaintingNameListByShipVO((self:GetShipVO())) > 0)

	return
end

function ShipDetailView:UpdateEquipments(arg_45_1)
	self:clearListener()
	removeAllChildren(self.equipmentsGrid)

	local var_45_0 = arg_45_1:getActiveEquipments()

	self.equipItems = {}

	for iter_45_0, iter_45_1 in ipairs(arg_45_1.equipments) do
		local var_45_2
		local var_45_3 = iter_45_0
		local var_45_4

		if iter_45_1 then
			var_45_2 = cloneTplTo(self.detailEquipmentTpl, self.equipmentsGrid)
			var_45_4 = {
				empty = false,
				tf = var_45_2,
				index = iter_45_0
			}

			table.insert(self.equipItems, var_45_4)
			updateEquipment(var_45_2:Find("IconTpl"), iter_45_1)
			onButton(self, var_45_2, function()
				if self.isShowQuick then
					self:selectedEquipItem(var_45_3)
				else
					self:emit(BaseUI.ON_EQUIPMENT, {
						type = EquipmentInfoMediator.TYPE_SHIP,
						shipId = self:GetShipVO().id,
						pos = iter_45_0
					})
				end

				return
			end, SFX_UI_DOCKYARD_EQUIPADD)
		else
			var_45_2 = cloneTplTo(self.emptyGridTpl, self.equipmentsGrid)
			var_45_4 = {
				empty = true,
				tf = var_45_2,
				index = iter_45_0
			}

			table.insert(self.equipItems, var_45_4)
			onButton(self, var_45_2, function()
				if self.isShowQuick then
					self:selectedEquipItem(var_45_3)
				else
					self:emit(ShipViewConst.SWITCH_TO_PAGE, ShipViewConst.PAGE.EQUIPMENT)
				end

				return
			end, SFX_UI_DOCKYARD_EQUIPADD)
		end

		local var_45_5 = GetOrAddComponent(var_45_2, typeof(EventTriggerListener))

		var_45_5:AddPointDownFunc(function()
			if var_45_2 and not self.isShowQuick then
				LeanTween.delayedCall(go(var_45_2), 1, System.Action(function()
					self.selectedEquip = var_45_4

					triggerToggle(self.showQuickBtn, true)

					return
				end))
			end

			return
		end)
		var_45_5:AddPointUpFunc(function()
			if var_45_2 and LeanTween.isTweening(go(var_45_2)) then
				LeanTween.cancel(go(var_45_2))
			end

			return
		end)
	end

	local var_45_6, var_45_7 = ShipStatus.ShipStatusCheck("onModify", self:GetShipVO())

	if not var_45_6 then
		triggerToggle(self.showQuickBtn, false)
	elseif arg_45_1.id ~= self.lastShipVo and self.isShowQuick then
		onNextTick(function()
			triggerToggle(self.showQuickBtn, false)
			triggerToggle(self.showQuickBtn, true)

			return
		end)
	elseif self.selectedEquip and self.isShowQuick then
		self:selectedEquipItem(nil)
		self:selectedEquipItem(self.selectedEquip.index)
	end

	self.lastShipVo = arg_45_1.id

	local var_45_8, var_45_9 = arg_45_1:IsSpweaponUnlock()

	setActive(self.spWeaponSlot:Find("Lock"), not var_45_8)

	local var_45_10 = arg_45_1:GetSpWeapon()

	setActive(self.spWeaponSlot:Find("Icon"), var_45_10)
	setActive(self.spWeaponSlot:Find("IconShadow"), var_45_10)

	if var_45_10 then
		UpdateSpWeaponSlot(self.spWeaponSlot, var_45_10)
	end

	onButton(self, self.spWeaponSlot, function()
		if not var_45_8 then
			pg.TipsMgr.GetInstance():ShowTips(i18n(var_45_9))

			return
		elseif var_45_10 then
			self:emit(BaseUI.ON_SPWEAPON, {
				type = EquipmentInfoMediator.TYPE_SHIP,
				shipId = self:GetShipVO().id
			})
		else
			self:emit(ShipViewConst.SWITCH_TO_PAGE, ShipViewConst.PAGE.EQUIPMENT)
		end

		return
	end, SFX_PANEL)

	return
end

function ShipDetailView:selectedEquipItem(arg_53_1)
	if not arg_53_1 then
		if self.selectedEquip then
			self.selectedEquip = nil
			self.showEquipItem = nil
		end
	else
		self.selectedEquip = self.equipItems[arg_53_1]
	end

	if self.isShowQuick then
		self:updateQuickPanel()
	end

	return
end

function ShipDetailView:updateQuickPanel(arg_54_1)
	setActive(self.selectTitle, not self.selectedEquip)

	if self.isShowQuick and self.selectedEquip then
		if self.selectedEquip ~= self.showEquipItem or arg_54_1 then
			self.showEquipItem = self.selectedEquip

			self:updateQuickEquipments()
		end
	else
		self:setListCount(0, 0)
		setActive(self.emptyTitle, false)
	end

	if self.equipItems then
		for iter_54_0 = 1, #self.equipItems do
			if self.selectedEquip and self.selectedEquip.index == iter_54_0 then
				setActive(findTF(self.equipItems[iter_54_0].tf, "selected"), true)
			else
				setActive(findTF(self.equipItems[iter_54_0].tf, "selected"), false)
			end
		end
	end

	return
end

function ShipDetailView:updateQuickEquipments()
	self:setListCount(0, 0)

	self.fillterEquipments = self:getEquipments()

	setActive(self.emptyTitle, false)

	if self.selectedEquip and self.selectedEquip.empty then
		setActive(self.emptyTitle, #self.fillterEquipments == 0)
	end

	self:setListCount(#self.fillterEquipments + (self.selectedEquip.empty and 0 or 1), 0)

	return
end

function ShipDetailView:setListCount(arg_56_1, arg_56_2)
	if self.onSelected and isActive(self._tf) then
		self.list:SetTotalCount(arg_56_1, arg_56_2)
	end

	return
end

function ShipDetailView:getEquipments()
	local var_57_0 = self:GetShipVO()
	local var_57_1 = getProxy(EquipmentProxy):getEquipmentsByFillter(var_57_0:getShipType(), pg.ship_data_template[var_57_0.configId]["equip_" .. self.selectedEquip.index])
	local var_57_2 = self.searchBar:GetInputText()

	if self.equipingFlag then
		for iter_57_0, iter_57_1 in ipairs(getProxy(BayProxy):getEquipsInShips(function(arg_58_0, arg_58_1)
			return var_57_0.id ~= arg_58_1 and not var_57_0:isForbiddenAtPos(arg_58_0, self.selectedEquip.index)
		end)) do
			if var_57_2 == "" or iter_57_1:IsMatchKey(var_57_2) then
				table.insert(var_57_1, iter_57_1)
			end
		end
	end

	local var_57_3 = {}
	local var_57_4 = {
		self.indexData.equipPropertyIndex,
		self.indexData.equipPropertyIndex2
	}

	for iter_57_2, iter_57_3 in pairs(var_57_1) do
		if self:checkFillter(iter_57_3, var_57_4) and (var_57_2 == "" or iter_57_3:IsMatchKey(var_57_2)) then
			table.insert(var_57_3, iter_57_3)
		end
	end

	_.each(var_57_3, function(arg_59_0)
		if not var_57_0:canEquipAtPos(arg_59_0, self.selectedEquip.index) then
			arg_59_0.mask = true
		end

		return
	end)
	table.sort(var_57_3, CompareFuncs(EquipmentSortCfg.sortFunc(EquipmentSortCfg.sort[1], false)))

	return var_57_3
end

function ShipDetailView:checkFillter(arg_60_1, arg_60_2)
	local var_60_0

	if arg_60_1.count <= 0 then
		var_60_0 = arg_60_1.shipId

		if arg_60_1.shipId then
			var_60_0 = self.equipingFlag

			if self.equipingFlag then
				var_60_0 = IndexConst.filterEquipByType(arg_60_1, self.indexData.typeIndex)

				if var_60_0 then
					var_60_0 = IndexConst.filterEquipByProperty(arg_60_1, arg_60_2)

					if var_60_0 then
						var_60_0 = IndexConst.filterEquipAmmo1(arg_60_1, self.indexData.equipAmmoIndex1)

						if var_60_0 then
							var_60_0 = IndexConst.filterEquipAmmo2(arg_60_1, self.indexData.equipAmmoIndex2)

							if var_60_0 then
								var_60_0 = IndexConst.filterEquipByCamp(arg_60_1, self.indexData.equipCampIndex)

								if var_60_0 then
									var_60_0 = IndexConst.filterEquipByRarity(arg_60_1, self.indexData.rarityIndex)
									var_60_0 = var_60_0 and IndexConst.filterEquipByExtra(arg_60_1, self.indexData.extraIndex)
								end
							end
						end
					end
				end
			end
		end
	end

	return var_60_0
end

function ShipDetailView:UpdateLock()
	local var_61_0 = self:GetShipVO():GetLockState()

	if var_61_0 == self:GetShipVO().LOCK_STATE_UNLOCK then
		setActive(self.lockBtn, true)
		setActive(self.unlockBtn, false)
	elseif var_61_0 == self:GetShipVO().LOCK_STATE_LOCK then
		setActive(self.lockBtn, false)
		setActive(self.unlockBtn, true)
	end

	return
end

function ShipDetailView:displayQuickPanel()
	if not self:GetShipVO() then
		return
	end

	self.isShowQuick = true

	setActive(self.attrs, false)
	setActive(self.quickPanel, true)
	self:updateQuickPanel()

	return
end

function ShipDetailView:quickSelectEmpty()
	if not self.selectedEquip and self.equipItems then
		for iter_63_0 = 1, #self.equipItems do
			if self.equipItems[iter_63_0].empty then
				self:selectedEquipItem(self.equipItems[iter_63_0].index)

				return
			end
		end
	end

	return
end

function ShipDetailView:Show()
	ShipDetailView.super.Show(self)
	setActive(self.randomFlagToggle, self.activeRandomFlag)

	return
end

function ShipDetailView:Hide()
	ShipDetailView.super.Hide(self)
	setActive(self.randomFlagToggle, false)

	return
end

function ShipDetailView:displayRecordPanel()
	if not self:GetShipVO() then
		return
	end

	self.isShowRecord = true

	setActive(self.recordPanel, true)
	setActive(self.attrs, false)

	for iter_66_0, iter_66_1 in ipairs(self.recordBtns) do
		onButton(self, iter_66_1, function()
			self:emit(ShipMainMediator.ON_RECORD_EQUIPMENT, self:GetShipVO().id, iter_66_0, 1)

			return
		end, SFX_PANEL)
	end

	for iter_66_2, iter_66_3 in ipairs(self.equipRecordBtns) do
		onButton(self, iter_66_3, function()
			self:emit(ShipMainMediator.ON_RECORD_EQUIPMENT, self:GetShipVO().id, iter_66_2, 2)

			return
		end, SFX_PANEL)
	end

	for iter_66_4, iter_66_5 in ipairs(self.recordEquipmentsTFs) do
		self:UpdateRecordEquipments(iter_66_4)
	end

	self:UpdateRecordSpWeapons()

	return
end

function ShipDetailView:CloseRecordPanel(arg_69_1)
	if arg_69_1 then
		self.isShowRecord = nil

		setActive(self.recordPanel, false)

		if not self.isShowRecord and not self.isShowQuick then
			setActive(self.attrs, true)
		end
	else
		triggerToggle(self.showRecordBtn, false)
	end

	return
end

function ShipDetailView:CloseQuickPanel()
	self.isShowQuick = nil

	self:selectedEquipItem(nil)

	self.showEquipItem = nil

	if self.list then
		self:setListCount(0, 0)
	end

	setActive(self.quickPanel, false)

	if not self.isShowRecord and not self.isShowQuick then
		setActive(self.attrs, true)
	end

	self:updateQuickPanel()

	return
end

function ShipDetailView:UpdateRecordEquipments(arg_71_1)
	local var_71_0 = self:GetShipVO():getEquipmentRecord(self.shareData.player.id)[arg_71_1] or {}

	for iter_71_0 = 1, 5 do
		local var_71_1 = tonumber(var_71_0[iter_71_0])
		local var_71_2 = var_71_1 and var_71_1 ~= -1
		local var_71_3 = self.recordEquipmentsTFs[arg_71_1]:Find("equipment_" .. iter_71_0)
		local var_71_4 = var_71_3:Find("empty")
		local var_71_5 = var_71_3:Find("info")

		setActive(var_71_5, var_71_1 and var_71_1 ~= -1)
		setActive(var_71_4, not var_71_2)

		if var_71_2 then
			local var_71_6 = self.equipmentProxy:getEquipmentById(var_71_1)
			local var_71_7 = self:GetShipVO().equipments[iter_71_0]
			local var_71_8 = not (var_71_7 and var_71_7.id == var_71_1 or false) and (not var_71_6 or var_71_6.count <= 0)

			setActive(var_71_5:Find("tip"), not (var_71_7 and var_71_7.id == var_71_1 or false) and (not var_71_6 or var_71_6.count <= 0))
			updateEquipment(var_71_5:Find("IconTpl"), Equipment.New({
				id = var_71_1
			}))

			if var_71_8 then
				onButton(self, var_71_5, function()
					pg.TipsMgr.GetInstance():ShowTips(i18n("ship_quick_change_nofreeequip"))

					return
				end, SFX_PANEL)
			end
		else
			removeOnButton(var_71_5)
		end
	end

	return
end

function ShipDetailView:UpdateRecordSpWeapons(arg_73_1)
	if LOCK_SP_WEAPON then
		return
	end

	local var_73_0 = self:GetShipVO():GetSpWeaponRecord(self.shareData.player.id)

	table.Foreach(self.recordBars, function(arg_74_0, arg_74_1)
		if arg_73_1 and arg_74_0 ~= arg_73_1 then
			return
		end

		local var_74_0 = var_73_0[arg_74_0]
		local var_74_1 = arg_74_1:Find("SpSlot")

		setActive(var_74_1:Find("Lock"), not self:GetShipVO():IsSpweaponUnlock())
		setActive(var_74_1:Find("Icon"), var_74_0)
		setActive(var_74_1:Find("IconShadow"), var_74_0)

		if var_74_0 then
			UpdateSpWeaponSlot(var_74_1, var_74_0)

			local var_74_2 = self:GetShipVO()
			local var_74_3 = var_74_2:GetSpWeapon()
			local var_74_4 = var_74_0:GetConfigID() ~= (var_74_3 and var_74_3:GetConfigID() or 0)

			if var_74_2 then
				local var_74_5 = getProxy(EquipmentProxy):GetSameTypeSpWeapon(var_74_0)

				if var_74_5 and var_74_5:GetConfigID() == var_74_0:GetConfigID() then
					var_74_4 = false
				end
			end

			setActive(var_74_1:Find("Icon/tip"), var_74_4)

			if var_74_4 then
				onButton(self, var_74_1, function()
					pg.TipsMgr.GetInstance():ShowTips(i18n("ship_quick_change_nofreeequip"))

					return
				end, SFX_PANEL)
			else
				removeOnButton(var_74_1)
			end
		else
			removeOnButton(var_74_1)
		end

		return
	end)

	return
end

function ShipDetailView:UpdatePreferenceTag()
	triggerToggle(self.commonTagToggle, self:GetShipVO().preferenceTag == Ship.PREFERENCE_TAG_COMMON)

	return
end

function ShipDetailView:DoLeveUpAnim(arg_77_1, arg_77_2, arg_77_3)
	self.shipDetailLogicPanel:doLeveUpAnim(arg_77_1, arg_77_2, arg_77_3)

	return
end

function ShipDetailView:clearListener()
	if self.equipItems then
		for iter_78_0 = 1, #self.equipItems do
			if self.equipItems[iter_78_0].tf then
				ClearEventTrigger(GetOrAddComponent(go(self.equipItems[iter_78_0].tf), typeof(EventTriggerListener)))
				removeOnButton(go(self.equipItems[iter_78_0].tf))
			end
		end
	end

	return
end

function ShipDetailView:OnDestroy()
	setParent(self.randomFlagToggle, self._tf)
	self:clearListener()
	removeAllChildren(self.equipmentsGrid)

	if self.list then
		self.list:SetTotalCount(0)

		function self.list.onUpdateItem()
			return
		end
	end

	self.destroy = true

	if self.recordPanel then
		if LeanTween.isTweening(go(self.recordPanel)) then
			LeanTween.cancel(go(self.recordPanel))
		end

		self.recordPanel = nil
	end

	self.shipDetailLogicPanel:clear()
	self.shipDetailLogicPanel:detach()

	self.shareData = nil

	if self.searchBar then
		self.searchBar:Dispose()

		self.searchBar = nil
	end

	return
end

return ShipDetailView
