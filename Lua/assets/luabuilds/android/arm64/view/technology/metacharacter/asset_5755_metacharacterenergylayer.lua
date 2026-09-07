local MetaCharacterEnergyLayer = class("MetaCharacterEnergyLayer", import("...base.BaseUI"))
local var_0_1 = pg.ship_meta_breakout

function MetaCharacterEnergyLayer:getUIName()
	return "MetaCharacterEnergyUI"
end

function MetaCharacterEnergyLayer:init()
	self:initUITipText()
	self:initData()
	self:initUI()
	self:addListener()

	return
end

function MetaCharacterEnergyLayer:didEnter()
	self:updateShipImg()
	self:updateNamePanel()
	self:updateChar()
	self:updateAttrPanel()
	self:updateMaterialPanel()
	self:initPreviewPanel()
	self:enablePartialBlur()

	if self.contextData.isMainOpen then
		self.contextData.isMainOpen = nil

		self:moveShipImg(true)
	end

	self:moveRightPanel()
	self:TryPlayGuide()

	return
end

function MetaCharacterEnergyLayer:willExit()
	self:moveShipImg(false)
	self:recycleChar()

	if self.previewer then
		self.previewer:clear()

		self.previewer = nil
	end

	self:disablePartialBlur()

	return
end

function MetaCharacterEnergyLayer:onBackPressed()
	if isActive(self.previewTF) then
		self:closePreviewPanel()

		return
	else
		self:emit(MetaCharacterEnergyLayer.ON_BACK_PRESSED)
	end

	return
end

function MetaCharacterEnergyLayer:initUITipText()
	setText(self._tf:Find("Preview/FinalAttrPanel/TitleText"), i18n("meta_energy_preview_title"))
	setText(self._tf:Find("Preview/FinalAttrPanel/TipText"), i18n("meta_energy_preview_tip"))
	setText(self._tf:Find("RightPanel/MaterialPanel/StarMax/Text"), i18n("word_level_upperLimit"))
	setText(self._tf:Find("RightPanel/MaterialPanel/TipText"), i18n("meta_break"))

	return
end

function MetaCharacterEnergyLayer:initData()
	self.shipPrefab = nil
	self.shipModel = nil
	self.metaCharacterProxy = getProxy(MetaCharacterProxy)
	self.bayProxy = getProxy(BayProxy)
	self.curMetaShipID = self.contextData.shipID
	self.curShipVO = nil
	self.curMetaCharacterVO = nil

	self:updateData()

	return
end

function MetaCharacterEnergyLayer:initUI()
	self.shipImg = self._tf:Find("ShipImg")
	self.nameTF = self._tf:Find("NamePanel")
	self.nameScrollText = self.nameTF:Find("NameMask/NameText")
	self.shipTypeImg = self.nameTF:Find("TypeImg")
	self.enNameText = self.nameTF:Find("NameENText")
	self.nameTFStarUIList = UIItemList.New(self.nameTF:Find("StarContainer"), (self.nameTF:Find("StarTpl")))
	self.previewBtn = self._tf:Find("PreviewBtn")
	self.rightPanel = self._tf:Find("RightPanel")
	self.qCharContain = self.rightPanel:Find("DetailPanel/QChar")
	self.starTpl = self.rightPanel:Find("DetailPanel/RarePanel/StarTpl")

	setActive(self.starTpl, false)

	self.starsFrom = self.rightPanel:Find("DetailPanel/RarePanel/StarsFrom")
	self.starsTo = self.rightPanel:Find("DetailPanel/RarePanel/StarsTo")
	self.starOpera = self.rightPanel:Find("DetailPanel/RarePanel/OpImg")
	self.starFromList = UIItemList.New(self.starsFrom, self.starTpl)
	self.starToList = UIItemList.New(self.starsTo, self.starTpl)
	self.attrTpl = self.rightPanel:Find("DetailPanel/AttrTpl")

	setActive(self.attrTpl, false)

	self.attrsContainer = self.rightPanel:Find("DetailPanel/AttrsContainer")
	self.attrsList = UIItemList.New(self.attrsContainer, self.attrTpl)
	self.materialPanel = self.rightPanel:Find("MaterialPanel")
	self.levelNumText = self.materialPanel:Find("Info/LevelTipText")
	self.infoTF = self.materialPanel:Find("Info")
	self.repairRateText = self.materialPanel:Find("Info/ProgressTipText")
	self.materialTF = self.materialPanel:Find("Info/Material")
	self.breakOutTipImg = self.materialPanel:Find("TipText")
	self.goldTF = self.materialPanel:Find("Gold")
	self.goldNumText = self.goldTF:Find("NumText")
	self.starMaxTF = self.materialPanel:Find("StarMax")
	self.activeBtn = self.materialPanel:Find("ActiveBtn")
	self.activeBtnDisable = self.materialPanel:Find("ActiveBtnDisable")
	self.previewTF = self._tf:Find("Preview")
	self.previewBG = self.previewTF:Find("BG")
	self.previewPanel = self.previewTF:Find("PreviewPanel")
	self.stages = self.previewPanel:Find("StageScrollRect/Stages")
	self.stagesSnap = self.previewPanel:Find("StageScrollRect"):GetComponent("HorizontalScrollSnap")
	self.breakView = self.previewPanel:Find("Content/Text")
	self.sea = self.previewPanel:Find("Sea")
	self.rawImage = self.sea:GetComponent("RawImage")

	setActive(self.rawImage, false)

	self.healTF = self._tf:Find("Resources/Heal")
	self.healTF.transform.localPosition = Vector3(-360, 50, 40)

	setActive(self.healTF, false)

	self.seaLoading = self.previewPanel:Find("BG/Loading")
	self.previewAttrTpl = self.previewTF:Find("FinalAttrPanel/AttrTpl")
	self.previewAttrContainer = self.previewTF:Find("FinalAttrPanel/AttrsContainer")
	self.previewAttrUIItemList = UIItemList.New(self.previewAttrContainer, self.previewAttrTpl)

	return
end

function MetaCharacterEnergyLayer:addListener()
	onButton(self, self.previewBtn, function()
		self:openPreviewPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.previewBG, function()
		self:closePreviewPanel()

		return
	end, SFX_CANCEL)
	onButton(self, self.activeBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("meta_energy_active_box_tip"),
			onYes = function()
				pg.m02:sendNotification(GAME.ENERGY_META_ACTIVATION, {
					shipId = self.curMetaShipID
				})

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function MetaCharacterEnergyLayer:updateData()
	self.curShipVO = self.bayProxy:getShipById(self.curMetaShipID)
	self.curMetaCharacterVO = self.curShipVO:getMetaCharacter()

	return
end

function MetaCharacterEnergyLayer:TryPlayGuide()
	pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0026")

	return
end

function MetaCharacterEnergyLayer:updateShipImg()
	local var_16_0, var_16_1 = MetaCharacterConst.GetMetaCharacterPaintPath(self.curMetaCharacterVO.id, true)

	setImageSprite(self.shipImg, LoadSprite(var_16_0, var_16_1), true)
	setLocalPosition(self.shipImg, {
		x = MetaCharacterConst.UIConfig[self.curMetaCharacterVO.id][5],
		y = MetaCharacterConst.UIConfig[self.curMetaCharacterVO.id][6]
	})
	setLocalScale(self.shipImg, {
		x = MetaCharacterConst.UIConfig[self.curMetaCharacterVO.id][3],
		y = MetaCharacterConst.UIConfig[self.curMetaCharacterVO.id][4]
	})

	return
end

function MetaCharacterEnergyLayer:updateNamePanel()
	setScrollText(self.nameScrollText, (self.curShipVO:getName()))
	setImageSprite(self.shipTypeImg, LoadSprite("shiptype", (self.curShipVO:getShipType())))
	setText(self.enNameText, (self.curShipVO:getConfig("english_name")))

	local var_17_1 = self.curShipVO:getStar()

	self.nameTFStarUIList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			local var_18_0 = arg_18_2:Find("empty")

			arg_18_1 = arg_18_1 + 1

			setActive(arg_18_2:Find("on"), arg_18_1 <= var_17_1)
		end

		return
	end)
	self.nameTFStarUIList:align((self.curShipVO:getMaxStar()))

	return
end

function MetaCharacterEnergyLayer:updateChar()
	return
end

function MetaCharacterEnergyLayer:recycleChar()
	if self.shipPrefab and self.shipModel then
		PoolMgr.GetInstance():ReturnSpineChar(self.shipPrefab, self.shipModel)

		self.shipPrefab = nil
		self.shipModel = nil
	end

	return
end

function MetaCharacterEnergyLayer:updateAttrPanel()
	local var_21_0 = self.curShipVO
	local var_21_1 = self.curMetaCharacterVO:getBreakOutInfo()

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
		self.starFromList:align(var_21_0:getStar())
		self.starToList:align(var_22_0:getStar())

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
		self.starFromList:align(var_21_0:getStar())
		self.starToList:align(0)

		return
	end

	self.attrsList:make(function(arg_24_0, arg_24_1, arg_24_2)
		if arg_24_0 == UIItemList.EventUpdate then
			if var_21_1:hasNextInfo() then
				var_21_2(arg_24_1, arg_24_2)
				setActive(self.starOpera, true)
			else
				var_21_3(arg_24_1, arg_24_2)
				setActive(self.starOpera, false)
			end
		end

		return
	end)
	self.attrsList:align(#MetaCharacterConst.ENERGY_ATTRS)

	return
end

function MetaCharacterEnergyLayer:updateMaterialPanel(arg_25_1)
	local var_25_0 = self.curMetaCharacterVO
	local var_25_1 = self.curMetaCharacterVO:getBreakOutInfo()

	if not var_25_1:hasNextInfo() then
		setActive(self.infoTF, false)
		setActive(self.breakOutTipImg, false)
		setActive(self.goldTF, false)
		setActive(self.starMaxTF, true)
		setActive(self.activeBtn, false)
		setActive(self.activeBtnDisable, true)

		return
	else
		setActive(self.infoTF, true)
		setActive(self.breakOutTipImg, true)
		setActive(self.goldTF, true)
		setActive(self.starMaxTF, false)
		setActive(self.activeBtn, true)
		setActive(self.activeBtnDisable, false)
	end

	local var_25_2 = true
	local var_25_5, var_25_6 = var_25_1:getConsume()
	local var_25_7 = var_25_5
	local var_25_12 = getProxy(BagProxy):getItemCountById(var_25_6[1].itemId)
	local var_25_13 = self.materialTF:Find("Item")
	local var_25_14 = {
		type = DROP_TYPE_ITEM,
		id = var_25_6[1].itemId
	}

	var_25_14.count = nil

	updateDrop(var_25_13, var_25_14, {
		hideName = true
	})
	onButton(self, var_25_13, function()
		self:emit(BaseUI.ON_DROP, var_25_14)

		return
	end, SFX_PANEL)
	setText(var_25_13:Find("icon_bg/count"), setColorStr(var_25_12, (var_25_12 < var_25_10 or nil) and (COLOR_RED or COLOR_GREEN)) .. "/" .. var_25_10)

	if var_25_12 < var_25_10 then
		var_25_2 = false
	end

	local var_25_17 = getProxy(PlayerProxy):getData().gold

	setText(self.goldNumText, var_25_17 < var_25_7 and setColorStr(var_25_7, COLOR_RED) or var_25_7)

	if var_25_17 < var_25_7 then
		var_25_2 = false

		onButton(self, self.activeBtnDisable, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("switch_to_shop_tip_2", i18n("word_gold")) .. "\n" .. i18n("text_noRes_tip", (i18n("text_noRes_info_tip", Item.getConfigData(59001).name, var_25_7 - var_25_17))),
				onYes = function()
					local var_28_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(MetaCharacterMediator)

					if var_28_0 then
						var_28_0.data.autoOpenShipConfigID = self.curShipVO.configId
						var_28_0.data.autoOpenEnergy = true
					end

					self:closeView()
					gotoChargeScene(ChargeScene.TYPE_ITEM)

					return
				end
			})

			return
		end, SFX_PANEL)
	end

	local var_25_18 = self.levelNumText
	local var_25_19 = self.repairRateText
	local var_25_22, var_25_23 = var_25_1:getLimited()
	local var_25_24 = self.curShipVO.level

	var_25_24 = var_25_22 > self.curShipVO.level and setColorStr(var_25_24, COLOR_RED) or setColorStr(var_25_24, COLOR_GREEN)

	setText(var_25_18, i18n("meta_energy_ship_level_need", var_25_24, var_25_22))

	local var_25_25 = var_25_0:getRepairRate() * 100 .. "%%"

	var_25_25 = var_25_0:getRepairRate() < var_25_23 / 100 and setColorStr(var_25_25, COLOR_RED) or setColorStr(var_25_25, COLOR_GREEN)

	setText(var_25_19, i18n("meta_energy_ship_repairrate_need", var_25_25, var_25_23 .. "%%"))

	if var_25_22 > self.curShipVO.level then
		var_25_2 = false
	end

	if var_25_0:getRepairRate() < var_25_23 / 100 then
		var_25_2 = false
	end

	setActive(self.activeBtn, var_25_2)
	setActive(self.activeBtnDisable, not var_25_2)

	return
end

function MetaCharacterEnergyLayer:moveShipImg(arg_29_1)
	local var_29_0 = MetaCharacterConst.UIConfig[self.curMetaCharacterVO.id]

	self:managedTween(LeanTween.moveX, nil, rtf(self.shipImg), (arg_29_1 or nil) and (var_29_0[5] or -2000), 0.2):setFrom(arg_29_1 and -2000 or var_29_0[5])

	return
end

function MetaCharacterEnergyLayer:moveRightPanel()
	self:managedTween(LeanTween.moveX, nil, rtf(self.rightPanel), 577.64, 0.2):setFrom(2000)

	return
end

function MetaCharacterEnergyLayer:updatePreviewAttrListPanel()
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
	local var_31_2 = Clone(self.curShipVO)

	var_31_2.level = 125

	local var_31_3 = intProperties(var_31_2:getMetaCharacter():getFinalAddition(var_31_2))

	self.previewAttrUIItemList:make(function(arg_32_0, arg_32_1, arg_32_2)
		if arg_32_0 == UIItemList.EventUpdate then
			local var_32_0 = arg_32_2:Find("AddValueText")

			setImageSprite(arg_32_2:Find("AttrIcon"), LoadSprite("attricon", var_31_1[arg_32_1 + 1]))
			setText(arg_32_2:Find("NameText"), AttributeType.Type2Name(var_31_1[arg_32_1 + 1]))

			if var_31_1[arg_32_1 + 1] == AttributeType.ArmorType then
				setText(var_32_0, var_31_2:getShipArmorName())
			else
				setText(var_32_0, (not var_31_3[var_31_1[arg_32_1 + 1]] or nil) and 0)
			end
		end

		return
	end)
	self.previewAttrUIItemList:align(#var_31_1)

	return
end

function MetaCharacterEnergyLayer:initPreviewPanel(arg_33_1)
	self.breakIds = self:getAllBreakIDs(self.curMetaCharacterVO.id)

	for iter_33_0 = 1, 3 do
		local var_33_1 = self.breakIds[iter_33_0]
		local var_33_2 = var_0_1[self.breakIds[iter_33_0]]
		local var_33_3 = self.stages:Find("Stage" .. iter_33_0)

		onToggle(self, var_33_3, function(arg_34_0)
			if arg_34_0 then
				local var_34_0 = var_33_2.breakout_view

				for iter_34_0, iter_34_1 in ipairs(checkExist(pg.ship_data_template[var_33_2.breakout_id], {
					"specific_type"
				}) or {}) do
					var_34_0 = var_34_0 .. "/" .. i18n(ShipType.SpecificTableTips[iter_34_1])
				end

				changeToScrollText(self.breakView, var_34_0)
				self:switchStage(var_33_1)
			end

			return
		end, SFX_PANEL)

		if iter_33_0 == 1 then
			triggerToggle(var_33_3, true)
		end
	end

	onButton(self, self.seaLoading, function()
		if not self.previewer then
			self:showBarrage()
		end

		return
	end)
	self:updatePreviewAttrListPanel()

	return
end

function MetaCharacterEnergyLayer:closePreviewPanel()
	if self.previewer then
		self.previewer:clear()

		self.previewer = nil
	end

	setActive(self.previewTF, false)
	setActive(self.rawImage, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.previewTF, self._tf)

	return
end

function MetaCharacterEnergyLayer:openPreviewPanel()
	setActive(self.previewTF, true)
	pg.UIMgr.GetInstance():BlurPanel(self.previewTF)
	self:playLoadingAni()

	return
end

function MetaCharacterEnergyLayer:playLoadingAni()
	setActive(self.seaLoading, true)

	return
end

function MetaCharacterEnergyLayer:stopLoadingAni()
	setActive(self.seaLoading, false)

	return
end

function MetaCharacterEnergyLayer:getAllBreakIDs(arg_40_1)
	local var_40_0 = {}

	for iter_40_0, iter_40_1 in ipairs(var_0_1.all) do
		if math.floor(iter_40_1 / 10) == arg_40_1 then
			table.insert(var_40_0, iter_40_1)
		end
	end

	return var_40_0
end

function MetaCharacterEnergyLayer:getWaponIdsById(arg_41_1)
	return var_0_1[arg_41_1].weapon_ids
end

function MetaCharacterEnergyLayer:getAllWeaponIds()
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in ipairs(self.breakIds) do
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

function MetaCharacterEnergyLayer:showBarrage()
	local var_44_0 = self.bayProxy:getShipById(self.curMetaShipID)
	local var_44_1 = var_44_0:getMetaCharacter()

	self.previewer = WeaponPreviewer.New(self.rawImage)

	self.previewer:configUI(self.healTF)
	self.previewer:setDisplayWeapon(self:getWaponIdsById(self.breakOutId))
	self.previewer:load(40000, var_44_0, self:getAllWeaponIds(), function()
		self:stopLoadingAni()

		return
	end)

	return
end

function MetaCharacterEnergyLayer:switchStage(arg_46_1)
	if self.breakOutId == arg_46_1 then
		return
	end

	self.breakOutId = arg_46_1

	if self.previewer then
		self.previewer:setDisplayWeapon(self:getWaponIdsById(self.breakOutId))
	end

	return
end

function MetaCharacterEnergyLayer:enablePartialBlur()
	if self._tf then
		local var_47_0 = {}

		table.insert(var_47_0, self.previewBtn)
		table.insert(var_47_0, self.rightPanel)
		self:OverlayPanel(self._tf, {
			groupDelta = -1,
			pbList = var_47_0
		})
	end

	return
end

function MetaCharacterEnergyLayer:disablePartialBlur()
	if self._tf then
		self:UnOverlayPanel(self._tf)
	end

	return
end

return MetaCharacterEnergyLayer
