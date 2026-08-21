local var_0_0 = class("ShipDetailView", import("...base.BaseSubView"))
local var_0_1 = require("view.equipment.EquipmentSortCfg")

function var_0_0.getUIName(arg_1_0)
	return "ShipDetailView"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:InitDetail()
	arg_2_0:InitEvent()
	setParent(arg_2_0.randomFlagToggle, arg_2_0._tf.parent)
	triggerToggle(arg_2_0.showQuickBtn, false)
	triggerToggle(arg_2_0.showRecordBtn, false)

	return
end

function var_0_0.InitDetail(arg_3_0)
	arg_3_0.mainPanel = arg_3_0._parentTf.parent
	arg_3_0.detailPanel = arg_3_0._tf
	arg_3_0.attrs = arg_3_0.detailPanel:Find("attrs")

	setActive(arg_3_0.attrs, false)

	arg_3_0.shipDetailLogicPanel = ShipDetailLogicPanel.New(arg_3_0.attrs)

	arg_3_0.shipDetailLogicPanel:attach(arg_3_0)

	arg_3_0.equipments = arg_3_0.detailPanel:Find("equipments")
	arg_3_0.equipmentsGrid = arg_3_0.equipments:Find("equipments")
	arg_3_0.detailEquipmentTpl = arg_3_0.equipments:Find("equipment_tpl")
	arg_3_0.emptyGridTpl = arg_3_0.equipments:Find("empty_tpl")
	arg_3_0.showRecordBtn = arg_3_0.equipments:Find("unload_all")
	arg_3_0.showQuickBtn = arg_3_0.equipments:Find("quickButton")
	arg_3_0.showECodeShareBtn = arg_3_0.equipments:Find("shareButton")
	arg_3_0.equipCodeBtn = arg_3_0.equipments:Find("equip_code")
	arg_3_0.lockBtn = arg_3_0.detailPanel:Find("lock_btn")
	arg_3_0.unlockBtn = arg_3_0.detailPanel:Find("unlock_btn")
	arg_3_0.viewBtn = arg_3_0.detailPanel:Find("view_btn")
	arg_3_0.evaluationBtn = arg_3_0.detailPanel:Find("evaluation_btn")
	arg_3_0.profileBtn = arg_3_0.detailPanel:Find("profile_btn")
	arg_3_0.fashionToggle = arg_3_0.detailPanel:Find("fashion_toggle")
	arg_3_0.randomFlagToggle = arg_3_0.detailPanel:Find("random_flag_toggle")
	arg_3_0.fashionTag = arg_3_0.fashionToggle:Find("Tag")
	arg_3_0.commonTagToggle = arg_3_0.detailPanel:Find("common_toggle")
	arg_3_0.spWeaponSlot = arg_3_0.equipments:Find("SpSlot")
	arg_3_0.propertyIcons = arg_3_0.detailPanel:Find("attrs/attrs/property/icons")
	arg_3_0.intimacyTF = arg_3_0._tf:Find("intimacy")
	arg_3_0.updateItemTick = 0
	arg_3_0.quickPanel = arg_3_0.detailPanel:Find("quick_panel")
	arg_3_0.equiping = arg_3_0.quickPanel:Find("equiping")
	arg_3_0.fillter = arg_3_0.quickPanel:Find("fillter")
	arg_3_0.selectTitle = arg_3_0.quickPanel:Find("frame/selectTitle")
	arg_3_0.emptyTitle = arg_3_0.quickPanel:Find("frame/emptyTitle")
	arg_3_0.list = arg_3_0.quickPanel:Find("frame/container/Content"):GetComponent("LScrollRect")
	arg_3_0.indexData = {}

	arg_3_0:CloseQuickPanel()
	setText(arg_3_0.quickPanel:Find("fillter/on/text2"), i18n("quick_equip_tip2"))
	setText(arg_3_0.quickPanel:Find("fillter/off/text2"), i18n("quick_equip_tip2"))
	setText(arg_3_0.quickPanel:Find("equiping/on/text2"), i18n("quick_equip_tip1"))
	setText(arg_3_0.quickPanel:Find("equiping/off/text2"), i18n("quick_equip_tip1"))
	setText(arg_3_0.quickPanel:Find("title/text"), i18n("quick_equip_tip3"))
	setText(arg_3_0.quickPanel:Find("frame/emptyTitle/text"), i18n("quick_equip_tip4"))
	setText(arg_3_0.quickPanel:Find("frame/selectTitle/text"), i18n("quick_equip_tip5"))
	setText(arg_3_0.randomFlagToggle:Find("bg/Text"), i18n("ship_random_secretary_tag"))

	arg_3_0.equipmentProxy = getProxy(EquipmentProxy)
	arg_3_0.recordPanel = arg_3_0.detailPanel:Find("record_panel")
	arg_3_0.unloadAllBtn = arg_3_0.recordPanel:Find("frame/unload_all")
	arg_3_0.recordBars = _.map({
		1,
		2,
		3
	}, function(arg_4_0)
		return arg_3_0.recordPanel:Find("frame/container"):GetChild(arg_4_0 - 1)
	end)
	arg_3_0.recordBtns = {
		arg_3_0.recordPanel:Find("frame/container/record_1/record_btn"),
		arg_3_0.recordPanel:Find("frame/container/record_2/record_btn"),
		arg_3_0.recordPanel:Find("frame/container/record_3/record_btn")
	}
	arg_3_0.recordEquipmentsTFs = {
		arg_3_0.recordPanel:Find("frame/container/record_1/equipments"),
		arg_3_0.recordPanel:Find("frame/container/record_2/equipments"),
		arg_3_0.recordPanel:Find("frame/container/record_3/equipments")
	}
	arg_3_0.equipRecordBtns = {
		arg_3_0.recordPanel:Find("frame/container/record_1/equip_btn"),
		arg_3_0.recordPanel:Find("frame/container/record_2/equip_btn"),
		arg_3_0.recordPanel:Find("frame/container/record_3/equip_btn")
	}
	arg_3_0.searchBar = RecordableSearchBar.New(RecordableSearchBar.CreateData({
		uiName = "RecordableSearchBarUI4ShipDetailView",
		holder = i18n("search_equipment"),
		onInputChanged = function()
			arg_3_0:updateQuickPanel(true)

			return
		end,
		key = arg_3_0.__cname,
		parent = arg_3_0.quickPanel,
		anchoredPosition = Vector3(-623, -34, 0)
	}))

	setActive(arg_3_0.detailPanel, true)
	setActive(arg_3_0.attrs, true)
	setActive(arg_3_0.recordPanel, false)
	setActive(arg_3_0.detailEquipmentTpl, false)
	setActive(arg_3_0.emptyGridTpl, false)
	setActive(arg_3_0.detailPanel, true)

	arg_3_0.onSelected = false

	if PLATFORM_CODE == PLATFORM_CHT and LOCK_SP_WEAPON then
		setActive(arg_3_0.showRecordBtn, false)
		setActive(arg_3_0.showQuickBtn, false)
		setActive(arg_3_0.spWeaponSlot, false)

		arg_3_0.showRecordBtn = arg_3_0.equipments:Find("unload_all_2")
		arg_3_0.showQuickBtn = arg_3_0.equipments:Find("quickButton_2")

		setActive(arg_3_0.showRecordBtn, true)
		setActive(arg_3_0.showQuickBtn, true)
	end

	return
end

function var_0_0.InitEvent(arg_6_0)
	onButton(arg_6_0, arg_6_0.fashionToggle, function()
		arg_6_0:emit(ShipViewConst.SWITCH_TO_PAGE, ShipViewConst.PAGE.FASHION)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.propertyIcons, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_shipinfo_attr.tip,
			onClose = function()
				return
			end
		})

		return
	end)
	onToggle(arg_6_0, arg_6_0.commonTagToggle, function(arg_10_0)
		local var_10_0 = arg_6_0:GetShipVO().preferenceTag
		local var_10_1 = var_10_0 == Ship.PREFERENCE_TAG_COMMON

		if var_10_0 == Ship.PREFERENCE_TAG_COMMON ~= arg_10_0 then
			var_10_1 = var_10_0 == Ship.PREFERENCE_TAG_COMMON and Ship.PREFERENCE_TAG_NONE or Ship.PREFERENCE_TAG_COMMON

			arg_6_0:emit(ShipMainMediator.ON_TAG, arg_6_0:GetShipVO().id, var_10_1)
		end

		return
	end, SFX_CONFIRM)
	onToggle(arg_6_0, arg_6_0.randomFlagToggle, function(arg_11_0)
		if arg_6_0:GetShipVO():getRandomFlag() ~= arg_11_0 then
			arg_6_0:emit(ShipMainMediator.CHANGE_RANDOM_FLAG, arg_6_0:GetShipVO():GetShipPhantomMark(), arg_11_0)
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_6_0, arg_6_0.lockBtn, function()
		arg_6_0:emit(ShipMainMediator.ON_LOCK, {
			arg_6_0:GetShipVO().id
		}, arg_6_0:GetShipVO().LOCK_STATE_LOCK)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.unlockBtn, function()
		arg_6_0:emit(ShipMainMediator.ON_LOCK, {
			arg_6_0:GetShipVO().id
		}, arg_6_0:GetShipVO().LOCK_STATE_UNLOCK)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.viewBtn, function()
		Input.multiTouchEnabled = true

		arg_6_0:emit(ShipViewConst.PAINT_VIEW, true)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.evaluationBtn, function()
		arg_6_0:emit(ShipMainMediator.OPEN_EVALUATION, arg_6_0:GetShipVO():getGroupId(), arg_6_0:GetShipVO():isActivityNpc())

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.profileBtn, function()
		arg_6_0:emit(ShipMainMediator.OPEN_SHIPPROFILE, arg_6_0:GetShipVO():getGroupId(), arg_6_0:GetShipVO():isRemoulded())

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.intimacyTF, function()
		if arg_6_0:GetShipVO():isActivityNpc() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("npc_propse_tip"))

			return
		end

		if LOCK_PROPOSE then
			return
		end

		arg_6_0:emit(ShipMainMediator.PROPOSE, arg_6_0:GetShipVO().id, function()
			return
		end)

		return
	end)
	onToggle(arg_6_0, arg_6_0.showRecordBtn, function(arg_19_0)
		local var_19_0, var_19_1 = ShipStatus.ShipStatusCheck("onModify", arg_6_0:GetShipVO())

		if not var_19_0 then
			if arg_19_0 then
				pg.TipsMgr.GetInstance():ShowTips(var_19_1)
				onNextTick(function()
					triggerToggle(arg_6_0.showRecordBtn, false)

					return
				end)
			end

			return
		end

		if arg_19_0 then
			arg_6_0:displayRecordPanel()

			if arg_6_0.isShowQuick then
				triggerToggle(arg_6_0.showQuickBtn, false)
			end
		else
			arg_6_0:CloseRecordPanel(true)
		end

		return
	end, SFX_PANEL)
	onToggle(arg_6_0, arg_6_0.showQuickBtn, function(arg_21_0)
		local var_21_0, var_21_1 = ShipStatus.ShipStatusCheck("onModify", arg_6_0:GetShipVO())

		if not var_21_0 then
			if arg_21_0 then
				pg.TipsMgr.GetInstance():ShowTips(var_21_1)
				onNextTick(function()
					triggerToggle(arg_6_0.showQuickBtn, false)

					return
				end)
			end

			arg_6_0:CloseRecordPanel(true)
			arg_6_0:CloseQuickPanel()

			return
		end

		if arg_21_0 then
			arg_6_0:displayQuickPanel()

			if arg_6_0.selectedEquip then
				arg_6_0:selectedEquipItem(arg_6_0.selectedEquip.index)
			else
				arg_6_0:quickSelectEmpty()
			end

			if arg_6_0.isShowRecord then
				triggerToggle(arg_6_0.showRecordBtn, false)
			end
		else
			arg_6_0:CloseQuickPanel()
		end

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.equipCodeBtn, function()
		arg_6_0:emit(ShipMainMediator.OPEN_EQUIP_CODE, {})

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.showECodeShareBtn, function()
		local var_24_0 = arg_6_0:GetShipVO()

		arg_6_0:emit(ShipMainMediator.OPEN_EQUIP_CODE_SHARE, var_24_0.id, var_24_0:getGroupId())

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.unloadAllBtn, function()
		local var_25_0, var_25_1 = ShipStatus.ShipStatusCheck("onModify", arg_6_0:GetShipVO())

		if not var_25_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_25_1)
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("ship_unequip_all_tip"),
				onYes = function()
					arg_6_0:emit(ShipMainMediator.UNEQUIP_FROM_SHIP_ALL, arg_6_0:GetShipVO().id)

					return
				end
			})
		end

		return
	end, SFX_PANEL)

	function arg_6_0.list.onInitItem(arg_27_0)
		ClearTweenItemAlphaAndWhite(arg_27_0)

		return
	end

	function arg_6_0.list.onReturnItem(arg_28_0, arg_28_1)
		ClearTweenItemAlphaAndWhite(arg_28_1)

		return
	end

	function arg_6_0.list.onUpdateItem(arg_29_0, arg_29_1)
		setActive(findTF(tf(arg_29_1), "IconTpl/icon_bg/icon"), false)
		TweenItemAlphaAndWhite(arg_29_1)

		if arg_29_0 == 0 and not arg_6_0.selectedEquip.empty then
			setActive(findTF(tf(arg_29_1), "unEquip"), true)
			setActive(findTF(tf(arg_29_1), "bg"), false)
			setActive(findTF(tf(arg_29_1), "IconTpl"), false)
			onButton(arg_6_0, tf(arg_29_1), function()
				local var_30_0 = arg_6_0:GetShipVO()
				local var_30_1 = var_30_0:getEquip(arg_6_0.selectedEquip.index):getConfig("name")
				local var_30_2 = var_30_0:getName()

				arg_6_0:emit(ShipMainMediator.UNEQUIP_FROM_SHIP, {
					shipId = var_30_0.id,
					pos = arg_6_0.selectedEquip.index
				})

				return
			end, SFX_PANEL)

			goto label_29_0
		end

		setActive(findTF(tf(arg_29_1), "unEquip"), false)
		setActive(findTF(tf(arg_29_1), "bg"), true)
		setActive(findTF(tf(arg_29_1), "IconTpl"), true)

		::label_29_0::

		if arg_6_0.selectedEquip.empty then
			do
				local var_29_0 = arg_29_0 + 1 or arg_29_0
				local var_29_1 = arg_6_0.fillterEquipments[var_29_0]

				if not arg_6_0.fillterEquipments[var_29_0] then
					return
				end

				setActive(findTF(tf(arg_29_1), "IconTpl/icon_bg/icon"), true)
				updateEquipment(findTF(tf(arg_29_1), "IconTpl"), var_29_1)

				if var_29_1.shipId then
					setImageSprite(findTF(tf(arg_29_1), "IconTpl/icon_bg/equip_flag/Image"), LoadSprite("qicon/" .. getProxy(BayProxy):getShipById(var_29_1.shipId):getPainting()))
				end

				local var_29_3 = var_29_1.shipId and var_29_1.shipId > 0

				var_29_2(findTF(tf(arg_29_1), "IconTpl/icon_bg/equip_flag"), var_29_3)
				setActive(findTF(tf(arg_29_1), "IconTpl/mask"), var_29_1.mask)
				onButton(arg_6_0, tf(arg_29_1), function()
					if var_29_1.mask then
						return
					end

					arg_6_0:changeEquip(var_29_1)

					return
				end, SFX_PANEL)
			end

			return
		end
	end

	onToggle(arg_6_0, arg_6_0.equiping, function(arg_32_0)
		arg_6_0.equipingFlag = arg_32_0

		if arg_6_0.selectedEquip then
			arg_6_0:updateQuickPanel(true)
		end

		return
	end, SFX_PANEL)
	triggerToggle(arg_6_0.equiping, true)
	onButton(arg_6_0, arg_6_0.fillter, function()
		arg_6_0.indexData = arg_6_0.indexData or {}

		if not var_0_0.EQUIPMENT_INDEX then
			var_0_0.EQUIPMENT_INDEX = Clone(StoreHouseConst.EQUIPMENT_INDEX_COMMON)

			table.removebyvalue(var_0_0.EQUIPMENT_INDEX.customPanels.extraIndex.options, IndexConst.EquipmentExtraEquiping)
			table.removebyvalue(var_0_0.EQUIPMENT_INDEX.customPanels.extraIndex.names, "index_equip")
		end

		arg_6_0:emit(ShipMainMediator.OPEN_EQUIPMENT_INDEX, (setmetatable({
			indexDatas = Clone(arg_6_0.indexData),
			callback = function(arg_34_0)
				arg_6_0.indexData.typeIndex = arg_34_0.typeIndex
				arg_6_0.indexData.equipPropertyIndex = arg_34_0.equipPropertyIndex
				arg_6_0.indexData.equipPropertyIndex2 = arg_34_0.equipPropertyIndex2
				arg_6_0.indexData.equipAmmoIndex1 = arg_34_0.equipAmmoIndex1
				arg_6_0.indexData.equipAmmoIndex2 = arg_34_0.equipAmmoIndex2
				arg_6_0.indexData.equipCampIndex = arg_34_0.equipCampIndex
				arg_6_0.indexData.rarityIndex = arg_34_0.rarityIndex
				arg_6_0.indexData.extraIndex = arg_34_0.extraIndex

				local var_34_0 = underscore(arg_6_0.indexData):chain():keys():all(function(arg_35_0)
					return arg_6_0.indexData[arg_35_0] == var_0_0.EQUIPMENT_INDEX.customPanels[arg_35_0].options[1]
				end):value()

				setActive(findTF(arg_6_0.fillter, "on"), not var_34_0)
				setActive(findTF(arg_6_0.fillter, "off"), var_34_0)
				arg_6_0:updateQuickPanel(true)

				return
			end
		}, {
			__index = var_0_0.EQUIPMENT_INDEX
		})))

		return
	end, SFX_PANEL)

	return
end

function var_0_0.changeEquip(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:GetShipVO()

	if {
		quickFlag = true,
		type = EquipmentInfoMediator.TYPE_REPLACE,
		equipmentId = arg_36_1.id,
		shipId = var_36_0.id,
		pos = arg_36_0.selectedEquip.index,
		oldShipId = arg_36_1.shipId,
		oldPos = arg_36_1.shipPos
	} then
		if PlayerPrefs.GetInt("QUICK_CHANGE_EQUIP", 1) == 1 then
			arg_36_0:emit(BaseUI.ON_EQUIPMENT, {
				quickFlag = true,
				type = EquipmentInfoMediator.TYPE_REPLACE,
				equipmentId = arg_36_1.id,
				shipId = var_36_0.id,
				pos = arg_36_0.selectedEquip.index,
				oldShipId = arg_36_1.shipId,
				oldPos = arg_36_1.shipPos
			})
		else
			local var_36_1, var_36_2 = var_36_0:canEquipAtPos(arg_36_1, arg_36_0.selectedEquip.index)

			if not var_36_1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_equipmentInfoLayer_error_canNotEquip", var_36_2))

				return
			end

			if arg_36_1.shipId then
				local var_36_3, var_36_4 = ShipStatus.ShipStatusCheck("onModify", (getProxy(BayProxy):getShipById(arg_36_1.shipId)))

				if not var_36_3 then
					pg.TipsMgr.GetInstance():ShowTips(var_36_4)
				else
					arg_36_0:emit(ShipMainMediator.EQUIP_CHANGE_NOTICE, {
						notice = GAME.EQUIP_FROM_SHIP,
						data = {
							quickFlag = true,
							type = EquipmentInfoMediator.TYPE_REPLACE,
							equipmentId = arg_36_1.id,
							shipId = var_36_0.id,
							pos = arg_36_0.selectedEquip.index,
							oldShipId = arg_36_1.shipId,
							oldPos = arg_36_1.shipPos
						}
					})
				end
			else
				arg_36_0:emit(ShipMainMediator.EQUIP_CHANGE_NOTICE, {
					notice = GAME.EQUIP_TO_SHIP,
					data = {
						quickFlag = true,
						type = EquipmentInfoMediator.TYPE_REPLACE,
						equipmentId = arg_36_1.id,
						shipId = var_36_0.id,
						pos = arg_36_0.selectedEquip.index,
						oldShipId = arg_36_1.shipId,
						oldPos = arg_36_1.shipPos
					}
				})
			end
		end
	end

	return
end

function var_0_0.SetShareData(arg_37_0, arg_37_1)
	arg_37_0.shareData = arg_37_1

	return
end

function var_0_0.GetShipVO(arg_38_0)
	if arg_38_0.shareData and arg_38_0.shareData.shipVO then
		return arg_38_0.shareData.shipVO
	end

	return nil
end

function var_0_0.OnSelected(arg_39_0, arg_39_1)
	if arg_39_1 then
		arg_39_0:OverlayPanel(arg_39_0._parentTf, {
			pbList = {
				arg_39_0.detailPanel:Find("attrs"),
				arg_39_0.detailPanel:Find("equipments"),
				arg_39_0.detailPanel:Find("quick_panel")
			},
			overlayType = LayerWeightConst.OVERLAY_UI_ADAPT
		})
	else
		arg_39_0:UnOverlayPanel(arg_39_0._parentTf, arg_39_0.mainPanel)
	end

	arg_39_0.onSelected = arg_39_1

	if arg_39_0.onSelected and arg_39_0.selectedEquip then
		arg_39_0:selectedEquipItem(nil)
		arg_39_0:selectedEquipItem(arg_39_0.selectedEquip.index)
	end

	return
end

function var_0_0.UpdateUI(arg_40_0)
	arg_40_0.searchBar:ClearInputText()

	local var_40_0 = arg_40_0:GetShipVO()

	arg_40_0:UpdateIntimacy(var_40_0)
	arg_40_0:UpdateDetail(var_40_0)
	arg_40_0:UpdateEquipments(var_40_0)
	arg_40_0:UpdateLock()
	arg_40_0:UpdatePreferenceTag()

	arg_40_0.activeRandomFlag = not var_40_0:isActivityNpc()

	setActive(arg_40_0.randomFlagToggle, arg_40_0.activeRandomFlag)
	triggerToggle(arg_40_0.randomFlagToggle, var_40_0:getRandomFlag())

	return
end

function var_0_0.UpdateIntimacy(arg_41_0, arg_41_1)
	setActive(arg_41_0.intimacyTF, not LOCK_PROPOSE)
	setIntimacyIcon(arg_41_0.intimacyTF, arg_41_1:getIntimacyIcon())

	return
end

function var_0_0.UpdateDetail(arg_42_0, arg_42_1)
	arg_42_0.shipDetailLogicPanel:flush(arg_42_1)

	local var_42_0 = arg_42_0.shipDetailLogicPanel.attrs:Find("icons/hunting_range/bg")

	removeOnButton(var_42_0)

	if table.contains(ShipType.SubShipType, arg_42_1:getShipType()) then
		onButton(arg_42_0, var_42_0, function()
			arg_42_0:emit(ShipViewConst.DISPLAY_HUNTING_RANGE, true)

			return
		end, SFX_PANEL)
	end

	if not HXSet.isHxSkin() then
		setActive(arg_42_0.fashionToggle, arg_42_0.shareData:HasFashion())
	else
		setActive(arg_42_0.fashionToggle, false)
	end

	arg_42_0:UpdateFashionTag()
	setActive(arg_42_0.profileBtn, not arg_42_1:isActivityNpc())

	return
end

function var_0_0.UpdateFashionTag(arg_44_0)
	setActive(arg_44_0.fashionTag, #PaintingGroupConst.GetPaintingNameListByShipVO((arg_44_0:GetShipVO())) > 0)

	return
end

function var_0_0.UpdateEquipments(arg_45_0, arg_45_1)
	arg_45_0:clearListener()
	removeAllChildren(arg_45_0.equipmentsGrid)

	local var_45_0 = arg_45_1:getActiveEquipments()

	arg_45_0.equipItems = {}

	for iter_45_0, iter_45_1 in ipairs(arg_45_1.equipments) do
		local var_45_2
		local var_45_3 = iter_45_0
		local var_45_4

		if iter_45_1 then
			var_45_2 = cloneTplTo(arg_45_0.detailEquipmentTpl, arg_45_0.equipmentsGrid)
			var_45_4 = {
				empty = false,
				tf = var_45_2,
				index = iter_45_0
			}

			table.insert(arg_45_0.equipItems, {
				empty = false,
				tf = var_45_2,
				index = iter_45_0
			})
			updateEquipment(var_45_2:Find("IconTpl"), iter_45_1)
			onButton(arg_45_0, var_45_2, function()
				if arg_45_0.isShowQuick then
					arg_45_0:selectedEquipItem(var_45_3)
				else
					arg_45_0:emit(BaseUI.ON_EQUIPMENT, {
						type = EquipmentInfoMediator.TYPE_SHIP,
						shipId = arg_45_0:GetShipVO().id,
						pos = iter_45_0
					})
				end

				return
			end, SFX_UI_DOCKYARD_EQUIPADD)
		else
			var_45_2 = cloneTplTo(arg_45_0.emptyGridTpl, arg_45_0.equipmentsGrid)

			table.insert(arg_45_0.equipItems, {
				empty = true,
				tf = var_45_2,
				index = iter_45_0
			})
			onButton(arg_45_0, var_45_2, function()
				if arg_45_0.isShowQuick then
					arg_45_0:selectedEquipItem(var_45_3)
				else
					arg_45_0:emit(ShipViewConst.SWITCH_TO_PAGE, ShipViewConst.PAGE.EQUIPMENT)
				end

				return
			end, SFX_UI_DOCKYARD_EQUIPADD)
		end

		local var_45_5 = GetOrAddComponent(var_45_2, typeof(EventTriggerListener))

		var_45_5:AddPointDownFunc(function()
			if var_45_2 and not arg_45_0.isShowQuick then
				LeanTween.delayedCall(go(var_45_2), 1, System.Action(function()
					arg_45_0.selectedEquip = var_45_4

					triggerToggle(arg_45_0.showQuickBtn, true)

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

	local var_45_6, var_45_7 = ShipStatus.ShipStatusCheck("onModify", arg_45_0:GetShipVO())

	if not var_45_6 then
		triggerToggle(arg_45_0.showQuickBtn, false)
	elseif arg_45_1.id ~= arg_45_0.lastShipVo and arg_45_0.isShowQuick then
		onNextTick(function()
			triggerToggle(arg_45_0.showQuickBtn, false)
			triggerToggle(arg_45_0.showQuickBtn, true)

			return
		end)
	elseif arg_45_0.selectedEquip and arg_45_0.isShowQuick then
		arg_45_0:selectedEquipItem(nil)
		arg_45_0:selectedEquipItem(arg_45_0.selectedEquip.index)
	end

	arg_45_0.lastShipVo = arg_45_1.id

	local var_45_8, var_45_9 = arg_45_1:IsSpweaponUnlock()

	setActive(arg_45_0.spWeaponSlot:Find("Lock"), not var_45_8)

	local var_45_10 = arg_45_1:GetSpWeapon()

	setActive(arg_45_0.spWeaponSlot:Find("Icon"), var_45_10)
	setActive(arg_45_0.spWeaponSlot:Find("IconShadow"), var_45_10)

	if var_45_10 then
		UpdateSpWeaponSlot(arg_45_0.spWeaponSlot, var_45_10)
	end

	onButton(arg_45_0, arg_45_0.spWeaponSlot, function()
		if not var_45_8 then
			pg.TipsMgr.GetInstance():ShowTips(i18n(var_45_9))

			return
		elseif var_45_10 then
			arg_45_0:emit(BaseUI.ON_SPWEAPON, {
				type = EquipmentInfoMediator.TYPE_SHIP,
				shipId = arg_45_0:GetShipVO().id
			})
		else
			arg_45_0:emit(ShipViewConst.SWITCH_TO_PAGE, ShipViewConst.PAGE.EQUIPMENT)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.selectedEquipItem(arg_53_0, arg_53_1)
	if not arg_53_1 then
		if arg_53_0.selectedEquip then
			arg_53_0.selectedEquip = nil
			arg_53_0.showEquipItem = nil
		end
	else
		arg_53_0.selectedEquip = arg_53_0.equipItems[arg_53_1]
	end

	if arg_53_0.isShowQuick then
		arg_53_0:updateQuickPanel()
	end

	return
end

function var_0_0.updateQuickPanel(arg_54_0, arg_54_1)
	setActive(arg_54_0.selectTitle, not arg_54_0.selectedEquip)

	if arg_54_0.isShowQuick and arg_54_0.selectedEquip then
		if arg_54_0.selectedEquip ~= arg_54_0.showEquipItem or arg_54_1 then
			arg_54_0.showEquipItem = arg_54_0.selectedEquip

			arg_54_0:updateQuickEquipments()
		end
	else
		arg_54_0:setListCount(0, 0)
		setActive(arg_54_0.emptyTitle, false)
	end

	if arg_54_0.equipItems then
		for iter_54_0 = 1, #arg_54_0.equipItems do
			if arg_54_0.selectedEquip and arg_54_0.selectedEquip.index == iter_54_0 then
				setActive(findTF(arg_54_0.equipItems[iter_54_0].tf, "selected"), true)
			else
				setActive(findTF(arg_54_0.equipItems[iter_54_0].tf, "selected"), false)
			end
		end
	end

	return
end

function var_0_0.updateQuickEquipments(arg_55_0)
	arg_55_0:setListCount(0, 0)

	arg_55_0.fillterEquipments = arg_55_0:getEquipments()

	setActive(arg_55_0.emptyTitle, false)

	if arg_55_0.selectedEquip and arg_55_0.selectedEquip.empty then
		setActive(arg_55_0.emptyTitle, #arg_55_0.fillterEquipments == 0)
	end

	arg_55_0:setListCount(#arg_55_0.fillterEquipments + (arg_55_0.selectedEquip.empty and 0 or 1), 0)

	return
end

function var_0_0.setListCount(arg_56_0, arg_56_1, arg_56_2)
	if arg_56_0.onSelected and isActive(arg_56_0._tf) then
		arg_56_0.list:SetTotalCount(arg_56_1, arg_56_2)
	end

	return
end

function var_0_0.getEquipments(arg_57_0)
	local var_57_0 = arg_57_0:GetShipVO()
	local var_57_1 = getProxy(EquipmentProxy):getEquipmentsByFillter(var_57_0:getShipType(), pg.ship_data_template[var_57_0.configId]["equip_" .. arg_57_0.selectedEquip.index])
	local var_57_2 = arg_57_0.searchBar:GetInputText()

	if arg_57_0.equipingFlag then
		for iter_57_0, iter_57_1 in ipairs(getProxy(BayProxy):getEquipsInShips(function(arg_58_0, arg_58_1)
			return var_57_0.id ~= arg_58_1 and not var_57_0:isForbiddenAtPos(arg_58_0, arg_57_0.selectedEquip.index)
		end)) do
			if var_57_2 == "" or iter_57_1:IsMatchKey(var_57_2) then
				table.insert(var_57_1, iter_57_1)
			end
		end
	end

	local var_57_3 = {}

	for iter_57_2, iter_57_3 in pairs(var_57_1) do
		if arg_57_0:checkFillter(iter_57_3, {
			arg_57_0.indexData.equipPropertyIndex,
			arg_57_0.indexData.equipPropertyIndex2
		}) and (var_57_2 == "" or iter_57_3:IsMatchKey(var_57_2)) then
			table.insert(var_57_3, iter_57_3)
		end
	end

	_.each(var_57_3, function(arg_59_0)
		if not var_57_0:canEquipAtPos(arg_59_0, arg_57_0.selectedEquip.index) then
			arg_59_0.mask = true
		end

		return
	end)
	table.sort(var_57_3, CompareFuncs(var_0_1.sortFunc(var_0_1.sort[1], false)))

	return var_57_3
end

function var_0_0.checkFillter(arg_60_0, arg_60_1, arg_60_2)
	if arg_60_1.count <= 0 then
		local var_60_0 = arg_60_1.shipId

		if arg_60_1.shipId then
			var_60_0 = arg_60_0.equipingFlag

			if arg_60_0.equipingFlag then
				var_60_0 = IndexConst.filterEquipByType(arg_60_1, arg_60_0.indexData.typeIndex)

				if var_60_0 then
					var_60_0 = IndexConst.filterEquipByProperty(arg_60_1, arg_60_2)

					if var_60_0 then
						var_60_0 = IndexConst.filterEquipAmmo1(arg_60_1, arg_60_0.indexData.equipAmmoIndex1)

						if var_60_0 then
							var_60_0 = IndexConst.filterEquipAmmo2(arg_60_1, arg_60_0.indexData.equipAmmoIndex2)

							if var_60_0 then
								var_60_0 = IndexConst.filterEquipByCamp(arg_60_1, arg_60_0.indexData.equipCampIndex)

								if var_60_0 then
									var_60_0 = IndexConst.filterEquipByRarity(arg_60_1, arg_60_0.indexData.rarityIndex)
									var_60_0 = var_60_0 and IndexConst.filterEquipByExtra(arg_60_1, arg_60_0.indexData.extraIndex)
								end
							end
						end
					end
				end
			end
		end

		return var_60_0
	end
end

function var_0_0.UpdateLock(arg_61_0)
	local var_61_0 = arg_61_0:GetShipVO():GetLockState()

	if var_61_0 == arg_61_0:GetShipVO().LOCK_STATE_UNLOCK then
		setActive(arg_61_0.lockBtn, true)
		setActive(arg_61_0.unlockBtn, false)
	elseif var_61_0 == arg_61_0:GetShipVO().LOCK_STATE_LOCK then
		setActive(arg_61_0.lockBtn, false)
		setActive(arg_61_0.unlockBtn, true)
	end

	return
end

function var_0_0.displayQuickPanel(arg_62_0)
	if not arg_62_0:GetShipVO() then
		return
	end

	arg_62_0.isShowQuick = true

	setActive(arg_62_0.attrs, false)
	setActive(arg_62_0.quickPanel, true)
	arg_62_0:updateQuickPanel()

	return
end

function var_0_0.quickSelectEmpty(arg_63_0)
	if not arg_63_0.selectedEquip and arg_63_0.equipItems then
		for iter_63_0 = 1, #arg_63_0.equipItems do
			if arg_63_0.equipItems[iter_63_0].empty then
				arg_63_0:selectedEquipItem(arg_63_0.equipItems[iter_63_0].index)

				return
			end
		end
	end

	return
end

function var_0_0.Show(arg_64_0)
	var_0_0.super.Show(arg_64_0)
	setActive(arg_64_0.randomFlagToggle, arg_64_0.activeRandomFlag)

	return
end

function var_0_0.Hide(arg_65_0)
	var_0_0.super.Hide(arg_65_0)
	setActive(arg_65_0.randomFlagToggle, false)

	return
end

function var_0_0.displayRecordPanel(arg_66_0)
	if not arg_66_0:GetShipVO() then
		return
	end

	arg_66_0.isShowRecord = true

	setActive(arg_66_0.recordPanel, true)
	setActive(arg_66_0.attrs, false)

	for iter_66_0, iter_66_1 in ipairs(arg_66_0.recordBtns) do
		onButton(arg_66_0, iter_66_1, function()
			arg_66_0:emit(ShipMainMediator.ON_RECORD_EQUIPMENT, arg_66_0:GetShipVO().id, iter_66_0, 1)

			return
		end, SFX_PANEL)
	end

	for iter_66_2, iter_66_3 in ipairs(arg_66_0.equipRecordBtns) do
		onButton(arg_66_0, iter_66_3, function()
			arg_66_0:emit(ShipMainMediator.ON_RECORD_EQUIPMENT, arg_66_0:GetShipVO().id, iter_66_2, 2)

			return
		end, SFX_PANEL)
	end

	for iter_66_4, iter_66_5 in ipairs(arg_66_0.recordEquipmentsTFs) do
		arg_66_0:UpdateRecordEquipments(iter_66_4)
	end

	arg_66_0:UpdateRecordSpWeapons()

	return
end

function var_0_0.CloseRecordPanel(arg_69_0, arg_69_1)
	if arg_69_1 then
		arg_69_0.isShowRecord = nil

		setActive(arg_69_0.recordPanel, false)

		if not arg_69_0.isShowRecord and not arg_69_0.isShowQuick then
			setActive(arg_69_0.attrs, true)
		end
	else
		triggerToggle(arg_69_0.showRecordBtn, false)
	end

	return
end

function var_0_0.CloseQuickPanel(arg_70_0)
	arg_70_0.isShowQuick = nil

	arg_70_0:selectedEquipItem(nil)

	arg_70_0.showEquipItem = nil

	if arg_70_0.list then
		arg_70_0:setListCount(0, 0)
	end

	setActive(arg_70_0.quickPanel, false)

	if not arg_70_0.isShowRecord and not arg_70_0.isShowQuick then
		setActive(arg_70_0.attrs, true)
	end

	arg_70_0:updateQuickPanel()

	return
end

function var_0_0.UpdateRecordEquipments(arg_71_0, arg_71_1)
	local var_71_0 = arg_71_0:GetShipVO():getEquipmentRecord(arg_71_0.shareData.player.id)[arg_71_1] or {}

	for iter_71_0 = 1, 5 do
		local var_71_1 = tonumber(var_71_0[iter_71_0])
		local var_71_2 = var_71_1 and var_71_1 ~= -1
		local var_71_3 = arg_71_0.recordEquipmentsTFs[arg_71_1]:Find("equipment_" .. iter_71_0)
		local var_71_4 = var_71_3:Find("empty")
		local var_71_5 = var_71_3:Find("info")

		setActive(var_71_5, var_71_1 and var_71_1 ~= -1)
		setActive(var_71_4, not var_71_2)

		if var_71_2 then
			local var_71_6 = arg_71_0.equipmentProxy:getEquipmentById(var_71_1)
			local var_71_7 = arg_71_0:GetShipVO().equipments[iter_71_0]
			local var_71_8 = not (var_71_7 and var_71_7.id == var_71_1 or false) and (not var_71_6 or var_71_6.count <= 0)

			setActive(var_71_5:Find("tip"), not (var_71_7 and var_71_7.id == var_71_1 or false) and (not var_71_6 or var_71_6.count <= 0))
			updateEquipment(var_71_5:Find("IconTpl"), Equipment.New({
				id = var_71_1
			}))

			if var_71_8 then
				onButton(arg_71_0, var_71_5, function()
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

function var_0_0.UpdateRecordSpWeapons(arg_73_0, arg_73_1)
	if LOCK_SP_WEAPON then
		return
	end

	local var_73_0 = arg_73_0:GetShipVO():GetSpWeaponRecord(arg_73_0.shareData.player.id)

	table.Foreach(arg_73_0.recordBars, function(arg_74_0, arg_74_1)
		local var_74_9000

		if arg_73_1 and arg_74_0 ~= arg_73_1 then
			return
		end

		local var_74_0 = var_73_0[arg_74_0]
		local var_74_1 = arg_74_1:Find("SpSlot")

		setActive(var_74_1:Find("Lock"), not arg_73_0:GetShipVO():IsSpweaponUnlock())
		setActive(var_74_1:Find("Icon"), var_74_0)
		setActive(var_74_1:Find("IconShadow"), var_74_0)

		if var_74_0 then
			UpdateSpWeaponSlot(var_74_1, var_74_0)

			local var_74_2 = arg_73_0:GetShipVO()
			local var_74_3 = var_74_2.GetSpWeapon(var_74_9000)
			local var_74_4 = var_74_3 and var_74_3:GetConfigID() or 0
			local var_74_5 = var_74_0:GetConfigID() ~= var_74_4

			if var_74_2 then
				local var_74_6 = getProxy(EquipmentProxy):GetSameTypeSpWeapon(var_74_0)

				if var_74_6 and var_74_6:GetConfigID() == var_74_0:GetConfigID() then
					var_74_5 = false
				end
			end

			setActive(var_74_1:Find("Icon/tip"), var_74_5)

			if var_74_5 then
				onButton(arg_73_0, var_74_1, function()
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

function var_0_0.UpdatePreferenceTag(arg_76_0)
	triggerToggle(arg_76_0.commonTagToggle, arg_76_0:GetShipVO().preferenceTag == Ship.PREFERENCE_TAG_COMMON)

	return
end

function var_0_0.DoLeveUpAnim(arg_77_0, arg_77_1, arg_77_2, arg_77_3)
	arg_77_0.shipDetailLogicPanel:doLeveUpAnim(arg_77_1, arg_77_2, arg_77_3)

	return
end

function var_0_0.clearListener(arg_78_0)
	if arg_78_0.equipItems then
		for iter_78_0 = 1, #arg_78_0.equipItems do
			if arg_78_0.equipItems[iter_78_0].tf then
				ClearEventTrigger(GetOrAddComponent(go(arg_78_0.equipItems[iter_78_0].tf), typeof(EventTriggerListener)))
				removeOnButton(go(arg_78_0.equipItems[iter_78_0].tf))
			end
		end
	end

	return
end

function var_0_0.OnDestroy(arg_79_0)
	setParent(arg_79_0.randomFlagToggle, arg_79_0._tf)
	arg_79_0:clearListener()
	removeAllChildren(arg_79_0.equipmentsGrid)

	if arg_79_0.list then
		arg_79_0.list:SetTotalCount(0)

		function arg_79_0.list.onUpdateItem()
			return
		end
	end

	arg_79_0.destroy = true

	if arg_79_0.recordPanel then
		if LeanTween.isTweening(go(arg_79_0.recordPanel)) then
			LeanTween.cancel(go(arg_79_0.recordPanel))
		end

		arg_79_0.recordPanel = nil
	end

	arg_79_0.shipDetailLogicPanel:clear()
	arg_79_0.shipDetailLogicPanel:detach()

	arg_79_0.shareData = nil

	if arg_79_0.searchBar then
		arg_79_0.searchBar:Dispose()

		arg_79_0.searchBar = nil
	end

	return
end

return var_0_0
