local var_0_0 = class("MetaCharacterEnergyLayer", import("...base.BaseUI"))
local var_0_1 = pg.ship_meta_breakout

function var_0_0.getUIName(arg_1_0)
	return "MetaCharacterEnergyUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initUITipText()
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:addListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:updateShipImg()
	arg_3_0:updateNamePanel()
	arg_3_0:updateChar()
	arg_3_0:updateAttrPanel()
	arg_3_0:updateMaterialPanel()
	arg_3_0:initPreviewPanel()
	arg_3_0:enablePartialBlur()

	if arg_3_0.contextData.isMainOpen then
		arg_3_0.contextData.isMainOpen = nil

		arg_3_0:moveShipImg(true)
	end

	arg_3_0:moveRightPanel()
	arg_3_0:TryPlayGuide()

	return
end

function var_0_0.willExit(arg_4_0)
	arg_4_0:moveShipImg(false)
	arg_4_0:recycleChar()

	if arg_4_0.previewer then
		arg_4_0.previewer:clear()

		arg_4_0.previewer = nil
	end

	arg_4_0:disablePartialBlur()

	return
end

function var_0_0.onBackPressed(arg_5_0)
	if isActive(arg_5_0.previewTF) then
		arg_5_0:closePreviewPanel()

		return
	else
		arg_5_0:emit(var_0_0.ON_BACK_PRESSED)
	end

	return
end

function var_0_0.initUITipText(arg_6_0)
	setText(arg_6_0._tf:Find("Preview/FinalAttrPanel/TitleText"), i18n("meta_energy_preview_title"))
	setText(arg_6_0._tf:Find("Preview/FinalAttrPanel/TipText"), i18n("meta_energy_preview_tip"))
	setText(arg_6_0._tf:Find("RightPanel/MaterialPanel/StarMax/Text"), i18n("word_level_upperLimit"))
	setText(arg_6_0._tf:Find("RightPanel/MaterialPanel/TipText"), i18n("meta_break"))

	return
end

function var_0_0.initData(arg_7_0)
	arg_7_0.shipPrefab = nil
	arg_7_0.shipModel = nil
	arg_7_0.metaCharacterProxy = getProxy(MetaCharacterProxy)
	arg_7_0.bayProxy = getProxy(BayProxy)
	arg_7_0.curMetaShipID = arg_7_0.contextData.shipID
	arg_7_0.curShipVO = nil
	arg_7_0.curMetaCharacterVO = nil

	arg_7_0:updateData()

	return
end

function var_0_0.initUI(arg_8_0)
	arg_8_0.shipImg = arg_8_0._tf:Find("ShipImg")
	arg_8_0.nameTF = arg_8_0._tf:Find("NamePanel")
	arg_8_0.nameScrollText = arg_8_0.nameTF:Find("NameMask/NameText")
	arg_8_0.shipTypeImg = arg_8_0.nameTF:Find("TypeImg")
	arg_8_0.enNameText = arg_8_0.nameTF:Find("NameENText")
	arg_8_0.nameTFStarUIList = UIItemList.New(arg_8_0.nameTF:Find("StarContainer"), (arg_8_0.nameTF:Find("StarTpl")))
	arg_8_0.previewBtn = arg_8_0._tf:Find("PreviewBtn")
	arg_8_0.rightPanel = arg_8_0._tf:Find("RightPanel")
	arg_8_0.qCharContain = arg_8_0.rightPanel:Find("DetailPanel/QChar")
	arg_8_0.starTpl = arg_8_0.rightPanel:Find("DetailPanel/RarePanel/StarTpl")

	setActive(arg_8_0.starTpl, false)

	arg_8_0.starsFrom = arg_8_0.rightPanel:Find("DetailPanel/RarePanel/StarsFrom")
	arg_8_0.starsTo = arg_8_0.rightPanel:Find("DetailPanel/RarePanel/StarsTo")
	arg_8_0.starOpera = arg_8_0.rightPanel:Find("DetailPanel/RarePanel/OpImg")
	arg_8_0.starFromList = UIItemList.New(arg_8_0.starsFrom, arg_8_0.starTpl)
	arg_8_0.starToList = UIItemList.New(arg_8_0.starsTo, arg_8_0.starTpl)
	arg_8_0.attrTpl = arg_8_0.rightPanel:Find("DetailPanel/AttrTpl")

	setActive(arg_8_0.attrTpl, false)

	arg_8_0.attrsContainer = arg_8_0.rightPanel:Find("DetailPanel/AttrsContainer")
	arg_8_0.attrsList = UIItemList.New(arg_8_0.attrsContainer, arg_8_0.attrTpl)
	arg_8_0.materialPanel = arg_8_0.rightPanel:Find("MaterialPanel")
	arg_8_0.levelNumText = arg_8_0.materialPanel:Find("Info/LevelTipText")
	arg_8_0.infoTF = arg_8_0.materialPanel:Find("Info")
	arg_8_0.repairRateText = arg_8_0.materialPanel:Find("Info/ProgressTipText")
	arg_8_0.materialTF = arg_8_0.materialPanel:Find("Info/Material")
	arg_8_0.breakOutTipImg = arg_8_0.materialPanel:Find("TipText")
	arg_8_0.goldTF = arg_8_0.materialPanel:Find("Gold")
	arg_8_0.goldNumText = arg_8_0.goldTF:Find("NumText")
	arg_8_0.starMaxTF = arg_8_0.materialPanel:Find("StarMax")
	arg_8_0.activeBtn = arg_8_0.materialPanel:Find("ActiveBtn")
	arg_8_0.activeBtnDisable = arg_8_0.materialPanel:Find("ActiveBtnDisable")
	arg_8_0.previewTF = arg_8_0._tf:Find("Preview")
	arg_8_0.previewBG = arg_8_0.previewTF:Find("BG")
	arg_8_0.previewPanel = arg_8_0.previewTF:Find("PreviewPanel")
	arg_8_0.stages = arg_8_0.previewPanel:Find("StageScrollRect/Stages")
	arg_8_0.stagesSnap = arg_8_0.previewPanel:Find("StageScrollRect"):GetComponent("HorizontalScrollSnap")
	arg_8_0.breakView = arg_8_0.previewPanel:Find("Content/Text")
	arg_8_0.sea = arg_8_0.previewPanel:Find("Sea")
	arg_8_0.rawImage = arg_8_0.sea:GetComponent("RawImage")

	setActive(arg_8_0.rawImage, false)

	arg_8_0.healTF = arg_8_0._tf:Find("Resources/Heal")
	arg_8_0.healTF.transform.localPosition = Vector3(-360, 50, 40)

	setActive(arg_8_0.healTF, false)

	arg_8_0.seaLoading = arg_8_0.previewPanel:Find("BG/Loading")
	arg_8_0.previewAttrTpl = arg_8_0.previewTF:Find("FinalAttrPanel/AttrTpl")
	arg_8_0.previewAttrContainer = arg_8_0.previewTF:Find("FinalAttrPanel/AttrsContainer")
	arg_8_0.previewAttrUIItemList = UIItemList.New(arg_8_0.previewAttrContainer, arg_8_0.previewAttrTpl)

	return
end

function var_0_0.addListener(arg_9_0)
	onButton(arg_9_0, arg_9_0.previewBtn, function()
		arg_9_0:openPreviewPanel()

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.previewBG, function()
		arg_9_0:closePreviewPanel()

		return
	end, SFX_CANCEL)
	onButton(arg_9_0, arg_9_0.activeBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("meta_energy_active_box_tip"),
			onYes = function()
				pg.m02:sendNotification(GAME.ENERGY_META_ACTIVATION, {
					shipId = arg_9_0.curMetaShipID
				})

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateData(arg_14_0)
	arg_14_0.curShipVO = arg_14_0.bayProxy:getShipById(arg_14_0.curMetaShipID)
	arg_14_0.curMetaCharacterVO = arg_14_0.curShipVO:getMetaCharacter()

	return
end

function var_0_0.TryPlayGuide(arg_15_0)
	pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0026")

	return
end

function var_0_0.updateShipImg(arg_16_0)
	local var_16_0, var_16_1 = MetaCharacterConst.GetMetaCharacterPaintPath(arg_16_0.curMetaCharacterVO.id, true)

	setImageSprite(arg_16_0.shipImg, LoadSprite(var_16_0, var_16_1), true)
	setLocalPosition(arg_16_0.shipImg, {
		x = MetaCharacterConst.UIConfig[arg_16_0.curMetaCharacterVO.id][5],
		y = MetaCharacterConst.UIConfig[arg_16_0.curMetaCharacterVO.id][6]
	})
	setLocalScale(arg_16_0.shipImg, {
		x = MetaCharacterConst.UIConfig[arg_16_0.curMetaCharacterVO.id][3],
		y = MetaCharacterConst.UIConfig[arg_16_0.curMetaCharacterVO.id][4]
	})

	return
end

function var_0_0.updateNamePanel(arg_17_0)
	setScrollText(arg_17_0.nameScrollText, (arg_17_0.curShipVO:getName()))
	setImageSprite(arg_17_0.shipTypeImg, LoadSprite("shiptype", (arg_17_0.curShipVO:getShipType())))
	setText(arg_17_0.enNameText, (arg_17_0.curShipVO:getConfig("english_name")))

	local var_17_1 = arg_17_0.curShipVO:getStar()

	arg_17_0.nameTFStarUIList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			local var_18_0 = arg_18_2:Find("empty")

			arg_18_1 = arg_18_1 + 1

			setActive(arg_18_2:Find("on"), arg_18_1 <= var_17_1)
		end

		return
	end)
	arg_17_0.nameTFStarUIList:align((arg_17_0.curShipVO:getMaxStar()))

	return
end

function var_0_0.updateChar(arg_19_0)
	return
end

function var_0_0.recycleChar(arg_20_0)
	if arg_20_0.shipPrefab and arg_20_0.shipModel then
		PoolMgr.GetInstance():ReturnSpineChar(arg_20_0.shipPrefab, arg_20_0.shipModel)

		arg_20_0.shipPrefab = nil
		arg_20_0.shipModel = nil
	end

	return
end

function var_0_0.updateAttrPanel(arg_21_0)
	local var_21_0 = arg_21_0.curShipVO
	local var_21_1 = arg_21_0.curMetaCharacterVO:getBreakOutInfo()

	local function var_21_2(arg_22_0, arg_22_1)
		local var_22_0 = Clone(var_21_0)

		var_22_0.configId = var_21_1:getNextInfo().id

		local var_22_1 = MetaCharacterConst.ENERGY_ATTRS[arg_22_0 + 1]
		local var_22_2 = 0
		local var_22_3 = 0

		if AttributeType.Expend ~= MetaCharacterConst.ENERGY_ATTRS[arg_22_0 + 1] then
			var_22_2 = math.floor(var_21_0:getShipProperties()[var_22_1])
			var_22_3 = math.floor(var_22_0:getShipProperties()[var_22_1])
		else
			var_22_2 = math.floor(var_21_0:getBattleTotalExpend())
			var_22_3 = math.floor(var_22_0:getBattleTotalExpend())
		end

		setText(arg_22_1:Find("NameText"), AttributeType.Type2Name(var_22_1))
		setText(arg_22_1:Find("CurValueText"), var_22_2)
		setActive(arg_22_1:Find("AddValueText"), true)
		setText(arg_22_1:Find("AddValueText"), "+" .. var_22_3 - var_22_2)
		setText(arg_22_1:Find("NextValueText"), var_22_3)
		arg_21_0.starFromList:align(var_21_0:getStar())
		arg_21_0.starToList:align(var_22_0:getStar())

		return
	end

	local function var_21_3(arg_23_0, arg_23_1)
		local var_23_0 = var_21_0:getShipProperties()
		local var_23_1 = MetaCharacterConst.ENERGY_ATTRS[arg_23_0 + 1]
		local var_23_2 = 0

		var_23_2 = AttributeType.Expend ~= MetaCharacterConst.ENERGY_ATTRS[arg_23_0 + 1] and math.floor(var_21_0:getShipProperties()[var_23_1]) or math.floor(var_21_0:getBattleTotalExpend())

		setText(arg_23_1:Find("NameText"), AttributeType.Type2Name(var_23_1))
		setText(arg_23_1:Find("CurValueText"), var_23_2)
		setText(arg_23_1:Find("NextValueText"), setColorStr(var_23_2, COLOR_GREEN))
		setText(arg_23_1:Find("AddValueText"), "+0")
		setActive(arg_23_1:Find("AddValueText"), false)
		arg_21_0.starFromList:align(var_21_0:getStar())
		arg_21_0.starToList:align(0)

		return
	end

	arg_21_0.attrsList:make(function(arg_24_0, arg_24_1, arg_24_2)
		if arg_24_0 == UIItemList.EventUpdate then
			if var_21_1:hasNextInfo() then
				var_21_2(arg_24_1, arg_24_2)
				setActive(arg_21_0.starOpera, true)
			else
				var_21_3(arg_24_1, arg_24_2)
				setActive(arg_21_0.starOpera, false)
			end
		end

		return
	end)
	arg_21_0.attrsList:align(#MetaCharacterConst.ENERGY_ATTRS)

	return
end

function var_0_0.updateMaterialPanel(arg_25_0, arg_25_1)
	local var_25_1 = arg_25_0.curMetaCharacterVO:getBreakOutInfo()

	if not var_25_1:hasNextInfo() then
		setActive(arg_25_0.infoTF, false)
		setActive(arg_25_0.breakOutTipImg, false)
		setActive(arg_25_0.goldTF, false)
		setActive(arg_25_0.starMaxTF, true)
		setActive(arg_25_0.activeBtn, false)
		setActive(arg_25_0.activeBtnDisable, true)

		return
	else
		setActive(arg_25_0.infoTF, true)
		setActive(arg_25_0.breakOutTipImg, true)
		setActive(arg_25_0.goldTF, true)
		setActive(arg_25_0.starMaxTF, false)
		setActive(arg_25_0.activeBtn, true)
		setActive(arg_25_0.activeBtnDisable, false)
	end

	local var_25_2 = true
	local var_25_5, var_25_6 = var_25_1:getConsume()
	local var_25_7 = var_25_5
	local var_25_12 = getProxy(BagProxy):getItemCountById(var_25_6[1].itemId)
	local var_25_13 = arg_25_0.materialTF:Find("Item")
	local var_25_14 = {
		type = DROP_TYPE_ITEM,
		id = var_25_6[1].itemId
	}

	;({
		type = DROP_TYPE_ITEM,
		id = var_25_6[1].itemId
	}).count = nil

	updateDrop(var_25_13, {
		type = DROP_TYPE_ITEM,
		id = var_25_6[1].itemId
	}, {
		hideName = true
	})
	onButton(arg_25_0, var_25_13, function()
		arg_25_0:emit(BaseUI.ON_DROP, var_25_14)

		return
	end, SFX_PANEL)

	local var_25_16 = var_25_13:Find("icon_bg/count")
	local var_25_18 = var_25_12

	if var_25_12 < var_25_10 then
		local var_25_19 = COLOR_RED or COLOR_GREEN
		local var_25_20 = var_25_17(var_25_18, var_25_19)

		var_25_15(var_25_16, var_25_20 .. "/" .. var_25_10)

		if var_25_12 < var_25_10 then
			var_25_2 = false
		end

		local var_25_21 = getProxy(PlayerProxy)
		local var_25_22 = var_25_21:getData().gold
		local var_25_23 = var_25_22 < var_25_7 and setColorStr(var_25_7, COLOR_RED) or var_25_7

		setText(arg_25_0.goldNumText, var_25_23)

		if var_25_22 < var_25_7 then
			var_25_2 = false

			onButton(arg_25_0, arg_25_0.activeBtnDisable, function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("switch_to_shop_tip_2", i18n("word_gold")) .. "\n" .. i18n("text_noRes_tip", (i18n("text_noRes_info_tip", Item.getConfigData(59001).name, var_25_7 - var_25_22))),
					onYes = function()
						local var_28_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(MetaCharacterMediator)

						if var_28_0 then
							var_28_0.data.autoOpenShipConfigID = arg_25_0.curShipVO.configId
							var_28_0.data.autoOpenEnergy = true
						end

						arg_25_0:closeView()
						gotoChargeScene(ChargeScene.TYPE_ITEM)

						return
					end
				})

				return
			end, SFX_PANEL)
		end

		local var_25_24 = arg_25_0.levelNumText
		local var_25_25 = arg_25_0.repairRateText
		local var_25_28, var_25_29 = var_25_1:getLimited()
		local var_25_30 = arg_25_0.curShipVO.level

		var_25_30 = var_25_28 > arg_25_0.curShipVO.level and setColorStr(var_25_30, COLOR_RED) or setColorStr(var_25_30, COLOR_GREEN)

		setText(var_25_24, i18n("meta_energy_ship_level_need", var_25_30, var_25_28))

		local var_25_31 = var_25_0:getRepairRate() * 100 .. "%%"

		var_25_31 = var_25_0:getRepairRate() < var_25_29 / 100 and setColorStr(var_25_31, COLOR_RED) or setColorStr(var_25_31, COLOR_GREEN)

		setText(var_25_25, i18n("meta_energy_ship_repairrate_need", var_25_31, var_25_29 .. "%%"))

		if var_25_28 > arg_25_0.curShipVO.level then
			var_25_2 = false
		end

		if var_25_0:getRepairRate() < var_25_29 / 100 then
			var_25_2 = false
		end

		setActive(arg_25_0.activeBtn, var_25_2)
		setActive(arg_25_0.activeBtnDisable, not var_25_2)

		return
	end
end

function var_0_0.moveShipImg(arg_29_0, arg_29_1)
	local var_29_0 = MetaCharacterConst.UIConfig[arg_29_0.curMetaCharacterVO.id]
	local var_29_1 = arg_29_1 and -2000 or var_29_0[5]

	if arg_29_1 then
		arg_29_0:managedTween(LeanTween.moveX, nil, rtf(arg_29_0.shipImg), var_29_2, 0.2):setFrom(var_29_1)

		return
	end
end

function var_0_0.moveRightPanel(arg_30_0)
	arg_30_0:managedTween(LeanTween.moveX, nil, rtf(arg_30_0.rightPanel), 577.64, 0.2):setFrom(2000)

	return
end

function var_0_0.updatePreviewAttrListPanel(arg_31_0)
	local var_31_1 = {
		AttributeType.Durability,
		AttributeType.Cannon,
		AttributeType.Torpedo,
		AttributeType.AntiAircraft,
		AttributeType.Air,
		AttributeType.Reload,
		AttributeType.ArmorType,
		AttributeType.Dodge
	}
	local var_31_2 = Clone(arg_31_0.curShipVO)

	var_31_2.level = 125

	local var_31_3 = intProperties(var_31_2:getMetaCharacter():getFinalAddition(var_31_2))

	arg_31_0.previewAttrUIItemList:make(function(arg_32_0, arg_32_1, arg_32_2)
		if arg_32_0 == UIItemList.EventUpdate then
			local var_32_0 = arg_32_2:Find("AddValueText")

			setImageSprite(arg_32_2:Find("AttrIcon"), LoadSprite("attricon", var_31_1[arg_32_1 + 1]))
			setText(arg_32_2:Find("NameText"), AttributeType.Type2Name(var_31_1[arg_32_1 + 1]))

			if var_31_1[arg_32_1 + 1] == AttributeType.ArmorType then
				setText(var_32_0, var_31_2:getShipArmorName())
			else
				local var_32_2 = var_31_3[var_31_1[arg_32_1 + 1]] or 0

				var_32_1(var_32_0, var_32_2)
			end
		end

		return
	end)
	arg_31_0.previewAttrUIItemList:align(#{
		AttributeType.Durability,
		AttributeType.Cannon,
		AttributeType.Torpedo,
		AttributeType.AntiAircraft,
		AttributeType.Air,
		AttributeType.Reload,
		AttributeType.ArmorType,
		AttributeType.Dodge
	})

	return
end

function var_0_0.initPreviewPanel(arg_33_0, arg_33_1)
	arg_33_0.breakIds = arg_33_0:getAllBreakIDs(arg_33_0.curMetaCharacterVO.id)

	for iter_33_0 = 1, 3 do
		local var_33_1 = var_0_1[arg_33_0.breakIds[iter_33_0]]
		local var_33_2 = arg_33_0.stages:Find("Stage" .. iter_33_0)

		onToggle(arg_33_0, var_33_2, function(arg_34_0)
			if arg_34_0 then
				local var_34_0 = var_33_1.breakout_view
				local var_34_1 = checkExist(pg.ship_data_template[var_33_1.breakout_id], {
					"specific_type"
				}) or {}

				for iter_34_0, iter_34_1 in ipairs(var_34_1) do
					var_34_0 = var_34_0 .. "/" .. i18n(ShipType.SpecificTableTips[iter_34_1])
				end

				changeToScrollText(arg_33_0.breakView, var_34_0)
				arg_33_0:switchStage(var_0)
			end

			return
		end, SFX_PANEL)

		if iter_33_0 == 1 then
			triggerToggle(var_33_2, true)
		end
	end

	onButton(arg_33_0, arg_33_0.seaLoading, function()
		if not arg_33_0.previewer then
			arg_33_0:showBarrage()
		end

		return
	end)
	arg_33_0:updatePreviewAttrListPanel()

	return
end

function var_0_0.closePreviewPanel(arg_36_0)
	if arg_36_0.previewer then
		arg_36_0.previewer:clear()

		arg_36_0.previewer = nil
	end

	setActive(arg_36_0.previewTF, false)
	setActive(arg_36_0.rawImage, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_36_0.previewTF, arg_36_0._tf)

	return
end

function var_0_0.openPreviewPanel(arg_37_0)
	setActive(arg_37_0.previewTF, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_37_0.previewTF)
	arg_37_0:playLoadingAni()

	return
end

function var_0_0.playLoadingAni(arg_38_0)
	setActive(arg_38_0.seaLoading, true)

	return
end

function var_0_0.stopLoadingAni(arg_39_0)
	setActive(arg_39_0.seaLoading, false)

	return
end

function var_0_0.getAllBreakIDs(arg_40_0, arg_40_1)
	for iter_40_0, iter_40_1 in ipairs(var_0_1.all) do
		if math.floor(iter_40_1 / 10) == arg_40_1 then
			table.insert({}, iter_40_1)
		end
	end

	return {}
end

function var_0_0.getWaponIdsById(arg_41_0, arg_41_1)
	return var_0_1[arg_41_1].weapon_ids
end

function var_0_0.getAllWeaponIds(arg_42_0)
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in ipairs(arg_42_0.breakIds) do
		local var_42_1 = Clone(var_0_1[iter_42_1].weapon_ids)

		setmetatable(var_42_0, {
			__add = function(arg_43_0, arg_43_1)
				for iter_43_0, iter_43_1 in ipairs(arg_43_0) do
					if not table.contains(arg_43_1, iter_43_1) then
						table.insert(arg_43_1, iter_43_1)
					end
				end

				return arg_43_1
			end
		})

		var_42_0 = var_42_0 + var_42_1
	end

	return var_42_0
end

function var_0_0.showBarrage(arg_44_0)
	local var_44_0 = arg_44_0.bayProxy:getShipById(arg_44_0.curMetaShipID)
	local var_44_1 = var_44_0:getMetaCharacter()

	arg_44_0.previewer = WeaponPreviewer.New(arg_44_0.rawImage)

	arg_44_0.previewer:configUI(arg_44_0.healTF)
	arg_44_0.previewer:setDisplayWeapon(arg_44_0:getWaponIdsById(arg_44_0.breakOutId))
	arg_44_0.previewer:load(40000, var_44_0, arg_44_0:getAllWeaponIds(), function()
		arg_44_0:stopLoadingAni()

		return
	end)

	return
end

function var_0_0.switchStage(arg_46_0, arg_46_1)
	if arg_46_0.breakOutId == arg_46_1 then
		return
	end

	arg_46_0.breakOutId = arg_46_1

	if arg_46_0.previewer then
		arg_46_0.previewer:setDisplayWeapon(arg_46_0:getWaponIdsById(arg_46_0.breakOutId))
	end

	return
end

function var_0_0.enablePartialBlur(arg_47_0)
	if arg_47_0._tf then
		table.insert({}, arg_47_0.previewBtn)
		table.insert({}, arg_47_0.rightPanel)
		arg_47_0:OverlayPanel(arg_47_0._tf, {
			groupDelta = -1,
			pbList = {}
		})
	end

	return
end

function var_0_0.disablePartialBlur(arg_48_0)
	if arg_48_0._tf then
		arg_48_0:UnOverlayPanel(arg_48_0._tf)
	end

	return
end

return var_0_0
