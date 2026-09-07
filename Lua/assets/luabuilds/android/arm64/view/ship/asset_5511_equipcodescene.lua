local EquipCodeScene = class("EquipCodeScene", import("..base.BaseUI"))

EquipCodeScene.optionsPath = {
	"adpter/frame/option"
}

function EquipCodeScene:getUIName()
	return "EquipCodeUI"
end

function EquipCodeScene:setEquipments(arg_2_1, arg_2_2)
	self.equips = arg_2_1

	table.sort(self.equips, CompareFuncs(EquipmentSortCfg.sortFunc(EquipmentSortCfg.sort[1], false)))

	self.spWeapons = arg_2_2

	table.sort(self.spWeapons, CompareFuncs(SpWeaponSortCfg.sortFunc(SpWeaponSortCfg.sort[1], false)))

	return
end

function EquipCodeScene:setShip(arg_3_1)
	self.shipVO = getProxy(BayProxy):getShipById(arg_3_1)
	self.shipData = {}

	for iter_3_0, iter_3_1 in ipairs(self.shipVO:getAllEquipments()) do
		if not iter_3_1 then
			self.shipData[iter_3_0] = false
		else
			self.shipData[iter_3_0] = underscore.detect(self.equips, function(arg_4_0)
				return arg_4_0.configId == iter_3_1.configId and arg_4_0.shipId == self.shipVO.id and arg_4_0.shipPos == iter_3_0
			end) or false
		end
	end

	local var_3_1 = self.shipVO:GetSpWeapon()

	if not var_3_1 then
		self.shipData[6] = false
	else
		self.shipData[6] = underscore.detect(self.spWeapons, function(arg_5_0)
			return arg_5_0.configId == var_3_1.configId and arg_5_0:GetShipId() == self.shipVO.id
		end) or false
	end

	return
end

function EquipCodeScene:getEquipShipVO(arg_6_1)
	local var_6_0 = self.shipVO:clone()

	var_6_0.equipments = underscore.first(arg_6_1, 5)
	var_6_0.spWeapon = arg_6_1[6] or nil

	return var_6_0
end

local function var_0_1(arg_7_0, arg_7_1, arg_7_2)
	setActive(arg_7_0:Find("IconTpl"), tobool(arg_7_1))

	if arg_7_1 then
		updateEquipment(arg_7_0:Find("IconTpl"), arg_7_1)
	end

	if arg_7_0:Find("equip_flag") then
		setActive(arg_7_0:Find("equip_flag"), arg_7_2)

		if arg_7_2 then
			setImageSprite(arg_7_0:Find("equip_flag/Image"), LoadSprite("qicon/" .. arg_7_2:getPainting()))
		end
	end

	return
end

local function var_0_2(arg_8_0, arg_8_1, arg_8_2)
	setActive(arg_8_0:Find("IconTpl"), tobool(arg_8_1))

	if arg_8_1 then
		updateSpWeapon(arg_8_0:Find("IconTpl"), arg_8_1)
	end

	if arg_8_0:Find("equip_flag") then
		setActive(arg_8_0:Find("equip_flag"), arg_8_2)

		if arg_8_2 then
			setImageSprite(arg_8_0:Find("equip_flag/Image"), LoadSprite("qicon/" .. arg_8_2:getPainting()))
		end
	end

	return
end

local function var_0_3(arg_9_0, arg_9_1, arg_9_2)
	setActive(arg_9_0:Find("Icon"), arg_9_1)
	setActive(arg_9_0:Find("IconShadow"), arg_9_1)

	if arg_9_1 then
		UpdateSpWeaponSlot(arg_9_0, arg_9_1)
	end

	if arg_9_0:Find("equip_flag") then
		setActive(arg_9_0:Find("equip_flag"), arg_9_2)

		if arg_9_2 then
			setImageSprite(arg_9_0:Find("equip_flag/Image"), LoadSprite("qicon/" .. arg_9_2:getPainting()))
		end
	end

	return
end

local function var_0_4(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:Find("error")

	if not arg_10_1 or not arg_10_2 then
		setActive(var_10_0, false)
	elseif arg_10_1.configId == arg_10_2.configId then
		setActive(var_10_0, false)
	else
		local var_10_1 = false
		local var_10_2

		if instanceof(arg_10_1, SpWeapon) then
			var_10_2 = pg.spweapon_data_statistics or pg.equip_data_template
		end

		for iter_10_0, iter_10_1 in ipairs({
			"next",
			"prev"
		}) do
			local var_10_3 = arg_10_1.configId

			while var_10_2[var_10_3][iter_10_1] > 0 do
				var_10_3 = var_10_2[var_10_3][iter_10_1]

				if var_10_3 == arg_10_2.configId then
					var_10_1 = true

					break
				end
			end

			if var_10_1 then
				break
			end
		end

		setActive(var_10_0, true)
		setText(var_10_0:Find("Text"), i18n(var_10_1 and "equipcode_level_unmatched" or "equipcode_diff_selected"))
	end

	return
end

function EquipCodeScene:onBackPressed()
	local var_11_0 = {}

	for iter_11_0 = 1, #self.shipData do
		if self.shipData[iter_11_0] then
			if self.equipData[iter_11_0] then
				if (self.shipData[iter_11_0].configId or 0) ~= (self.equipData[iter_11_0].configId or 0) then
					table.insert(var_11_0, function(arg_12_0)
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							content = i18n("equipcode_unsaved_tips"),
							onYes = arg_12_0
						})

						return
					end)

					break
				end
			end
		end
	end

	seriesAsync(var_11_0, function()
		self:closeView()

		return
	end)

	return
end

local var_0_5

function EquipCodeScene:init()
	var_0_5 = var_0_5 or {
		customPanels = {
			labelIndex = {
				num = 2,
				mode = CustomIndexLayer.Mode.NUM,
				options = underscore.rest(IndexConst.ECodeLabelIndexs),
				names = underscore.rest(IndexConst.ECodeLabelNames)
			}
		},
		groupList = {
			{
				dropdown = false,
				titleENTxt = "indexsort_labeleng",
				titleTxt = "indexsort_label",
				tags = {
					"labelIndex"
				}
			}
		},
		tip = i18n("equipcode_share_ruletips")
	}
	self.btnBack = self._tf:Find("adpter/frame/btnBack")

	onButton(self, self.btnBack, function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)

	self.rtMainPanel = self._tf:Find("main_panel")

	onButton(self, self.rtMainPanel:Find("btns/btn_export"), function()
		UniPasteBoard.SetClipBoardString(buildEquipCode(self.shipVO))
		pg.TipsMgr.GetInstance():ShowTips(i18n("equipcode_export_success"))

		return
	end, SFX_CONFIRM)
	onButton(self, self.rtMainPanel:Find("share/btn_comments"), function()
		self:emit(EquipCodeMediator.OPEN_EQUIP_CODE_SHARE, self.shipVO:getGroupId())

		return
	end, SFX_PANEL)

	self.tagIndexData = {}

	onButton(self, self.rtMainPanel:Find("share/btn_share"), function()
		self:emit(EquipCodeMediator.OPEN_CUSTOM_INDEX, setmetatable({
			indexDatas = Clone(self.tagIndexData),
			callback = function(self)
				self.tagIndexData.labelIndex = self.labelIndex

				local var_19_0 = 0

				while self.labelIndex > 0 do
					var_19_0 = var_19_0 + 1

					local var_19_1 = bit.band(self.labelIndex, self.labelIndex - 1)
				end

				if var_19_0 == 2 then
					local var_19_2 = {}

					while self.tagIndexData.labelIndex > 0 do
						local var_19_3 = bit.band(self.tagIndexData.labelIndex, -self.tagIndexData.labelIndex)
						local var_19_5 = 0

						while var_19_3 > 0 do
							var_19_5 = var_19_5 + 1
							var_19_3 = math.floor(var_19_3 / 2)
						end

						table.insert(var_19_2, tostring(var_19_5))
					end

					local var_19_6 = self.shipVO:getGroupId()

					self:emit(EquipCodeMediator.SHARE_EQUIP_CODE, var_19_6, (table.concat({
						buildEquipCode(self.shipVO),
						ConversionBase(32, var_19_6),
						var_19_2[1],
						var_19_2[2]
					}, "&")))
				else
					pg.TipsMgr.GetInstance():ShowTips(i18n("equipcode_share_nolabel"))
				end

				return
			end
		}, {
			__index = var_0_5
		}))

		return
	end, SFX_PANEL)

	self.rtCodePanel = self._tf:Find("code_panel")

	onButton(self, self.rtCodePanel:Find("btns/btn_import"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("equipcode_confirm_doublecheck"),
			onYes = function()
				self:emit(EquipCodeMediator.IMPORT_SHIP_EQUIP, self.shipVO.id, self.equipData)

				return
			end
		})

		return
	end, SFX_CONFIRM)
	onButton(self, self.rtCodePanel:Find("btns/btn_withdrawn"), function()
		self.code = nil

		self:updateDispalyPanel(self.rtCodePanel, "code")

		return
	end, SFX_CANCEL)
	onButton(self, self.rtCodePanel:Find("btns/btn_cancel"), function()
		self:updateDispalyPanel(self.rtCodePanel, "code")
		self:initQuickPanel()

		return
	end, SFX_CANCEL)
	onToggle(self, self.rtCodePanel:Find("btns/toggle_quick"), function(arg_24_0)
		setInputText(self.nameSearchInput, "")
		setActive(self.rtMainPanel, false)
		setActive(self.rtBottomPanel, false)
		setActive(self.rtQuickPanel, false)
		setActive(self.rtCodePanel:Find("btns/btn_withdrawn"), not arg_24_0)
		setActive(self.rtCodePanel:Find("btns/btn_cancel"), arg_24_0)

		if self.quickIndex then
			triggerToggle(self.rtCodePanel:Find("equipments_quick"):GetChild(self.quickIndex - 1), false)
		end

		eachChild(self.rtCodePanel:Find("equipments_quick"), function(arg_25_0)
			SetCompomentEnabled(arg_25_0, typeof(Toggle), false)

			return
		end)

		self.ltID = LeanTween.moveY(self.rtCodePanel, arg_24_0 and 420 or 80, math.max(math.abs((arg_24_0 and 420 or 80) - self.rtCodePanel.anchoredPosition.y), 0.1) / 2000):setOnComplete(System.Action(function()
			self.ltID = nil

			setActive(self.rtMainPanel, not arg_24_0)
			setActive(self.rtBottomPanel, not arg_24_0)
			setActive(self.rtQuickPanel, arg_24_0)

			if arg_24_0 then
				self:initQuickPanel()
			end

			return
		end)).uniqueId

		return
	end)
	eachChild(self.rtCodePanel:Find("equipments_quick"), function(arg_27_0)
		onToggle(self, arg_27_0, function(arg_28_0)
			if arg_28_0 then
				self.quickIndex = arg_27_0:GetSiblingIndex() + 1

				self:updateQuickPanel()
			elseif self.quickIndex == arg_27_0:GetSiblingIndex() + 1 then
				self.quickIndex = nil

				self:updateQuickPanel()
			end

			return
		end, SFX_PANEL)
		SetCompomentEnabled(arg_27_0, typeof(Toggle), false)

		return
	end)

	self.rtQuickPanel = self._tf:Find("quick_panel")

	onToggle(self, self.rtQuickPanel:Find("title/equiping"), function(arg_29_0)
		self.equipingFlag = arg_29_0

		if isActive(self.rtQuickPanel) then
			self:updateQuickPanel(true)
		end

		return
	end, SFX_PANEL)

	self.nameSearchInput = self.rtQuickPanel:Find("title/serachPanel/search")
	self.nameSearchText = self.nameSearchInput:Find("holder")

	setText(self.nameSearchText, i18n("search_equipment"))
	setInputText(self.nameSearchInput, "")
	onInputChanged(self, self.nameSearchInput, function()
		self:updateQuickPanel(true)

		return
	end)

	self.indexData = self.indexData or {}
	self.spweaponIndexDatas = self.spweaponIndexDatas or {}

	local var_14_0 = self.rtQuickPanel:Find("title/filter")

	onButton(self, var_14_0, function()
		assert(self.quickIndex)
		self:emit(EquipCodeMediator.OPEN_CUSTOM_INDEX, (switch(self.quickIndex, {
			[6] = function()
				return setmetatable({
					indexDatas = Clone(self.spweaponIndexDatas),
					callback = function(self)
						self.spweaponIndexDatas.typeIndex = self.typeIndex
						self.spweaponIndexDatas.rarityIndex = self.rarityIndex

						local var_33_0 = underscore(self.spweaponIndexDatas):chain():keys():all(function(arg_34_0)
							return self.spweaponIndexDatas[arg_34_0] == StoreHouseConst.SPWEAPON_INDEX_COMMON.customPanels[arg_34_0].options[1]
						end):value()

						setActive(var_14_0:Find("on"), not var_33_0)
						setActive(var_14_0:Find("off"), var_33_0)
						self:updateQuickPanel()

						return
					end
				}, {
					__index = StoreHouseConst.SPWEAPON_INDEX_COMMON
				})
			end
		}, function()
			return setmetatable({
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

					local var_36_0 = underscore(self.indexData):chain():keys():all(function(arg_37_0)
						return self.indexData[arg_37_0] == StoreHouseConst.EQUIPMENT_INDEX_COMMON.customPanels[arg_37_0].options[1]
					end):value()

					setActive(var_14_0:Find("on"), not var_36_0)
					setActive(var_14_0:Find("off"), var_36_0)
					self:updateQuickPanel()

					return
				end
			}, {
				__index = StoreHouseConst.EQUIPMENT_INDEX_COMMON
			})
		end)))

		return
	end, SFX_PANEL)

	self.comList = self.rtQuickPanel:Find("frame/container"):GetComponent("LScrollRect")

	function self.comList.onInitItem(arg_38_0)
		ClearTweenItemAlphaAndWhite(arg_38_0)

		return
	end

	function self.comList.onReturnItem(arg_39_0, arg_39_1)
		ClearTweenItemAlphaAndWhite(arg_39_1)

		return
	end

	function self.comList.onUpdateItem(arg_40_0, arg_40_1)
		if not self.quickIndex then
			return
		end

		TweenItemAlphaAndWhite(arg_40_1)

		local var_40_0 = tf(arg_40_1)
		local var_40_1 = self.filterEquipments[arg_40_0 + 1]

		setActive(var_40_0:Find("unEquip"), not self.filterEquipments[arg_40_0 + 1])
		setActive(var_40_0:Find("bg"), var_40_1)
		setActive(var_40_0:Find("IconTpl"), var_40_1)

		if self.quickIndex == 6 then
			var_0_2(var_40_0, var_40_1, (var_40_1 and var_40_1.shipId or nil) and (getProxy(BayProxy):getShipById(var_40_1.shipId) or nil))
			onButton(self, var_40_0, function()
				local var_41_0 = {}

				if var_40_1 and PlayerPrefs.GetInt("QUICK_CHANGE_EQUIP", 1) == 1 then
					table.insert(var_41_0, function(arg_42_0)
						self:emit(EquipCodeScene.ON_SPWEAPON, {
							quickFlag = true,
							type = EquipmentInfoMediator.TYPE_REPLACE,
							oldSpWeaponUid = var_40_1:GetUID(),
							oldShipId = var_40_1:GetShipId(),
							shipVO = self:getEquipShipVO(self.equipData),
							quickCallback = arg_42_0
						})

						return
					end)
				end

				seriesAsync(var_41_0, function()
					self.equipData[self.quickIndex] = var_40_1

					local var_43_0 = self.rtCodePanel:Find("equipments_quick/SpSlot")

					var_0_3(var_43_0, var_40_1, (var_40_1 and var_40_1.shipId or nil) and (getProxy(BayProxy):getShipById(var_40_1.shipId) or nil))
					var_0_4(var_43_0, self.codeData[self.quickIndex], var_40_1)
					self:updateQuickPanel()

					return
				end)

				return
			end, SFX_PANEL)
		else
			local var_40_6 = var_40_0

			var_0_1(var_40_6, var_40_1 and setmetatable({
				count = var_40_1.count - underscore.reduce(self.equipData, 0, function(arg_44_0, arg_44_1)
					return arg_44_0 + (arg_44_1 == var_40_1 and 1 or 0)
				end)
			}, {
				__index = var_40_1
			}) or var_40_1, (var_40_1 and var_40_1.shipId or nil) and (getProxy(BayProxy):getShipById(var_40_1.shipId) or nil))
			setActive(var_40_0:Find("IconTpl/mask"), var_40_1 and var_40_1.mask)
			onButton(self, var_40_0, function()
				if var_40_1 and var_40_1.mask then
					return
				end

				local var_45_0 = {}

				if var_40_1 and PlayerPrefs.GetInt("QUICK_CHANGE_EQUIP", 1) == 1 then
					table.insert(var_45_0, function(arg_46_0)
						self:emit(EquipCodeScene.ON_EQUIPMENT, {
							quickFlag = true,
							type = EquipmentInfoMediator.TYPE_REPLACE,
							equipmentId = var_40_1.id,
							oldShipId = var_40_1.shipId,
							oldPos = var_40_1.shipPos,
							shipVO = self:getEquipShipVO(self.equipData),
							pos = self.quickIndex,
							quickCallback = arg_46_0
						})

						return
					end)
				end

				seriesAsync(var_45_0, function()
					self.equipData[self.quickIndex] = var_40_1

					local var_47_0 = self.rtCodePanel:Find("equipments_quick"):GetChild(self.quickIndex - 1)

					var_0_1(var_47_0, var_40_1, (var_40_1 and var_40_1.shipId or nil) and (getProxy(BayProxy):getShipById(var_40_1.shipId) or nil))
					var_0_4(var_47_0, self.codeData[self.quickIndex], var_40_1)
					self:updateQuickPanel()

					return
				end)

				return
			end, SFX_PANEL)
		end

		return
	end

	setText(var_14_0:Find("on/text2"), i18n("quick_equip_tip2"))
	setText(var_14_0:Find("off/text2"), i18n("quick_equip_tip2"))
	setText(self.rtQuickPanel:Find("title/equiping/on/text2"), i18n("quick_equip_tip1"))
	setText(self.rtQuickPanel:Find("title/equiping/off/text2"), i18n("quick_equip_tip1"))
	setText(self.rtQuickPanel:Find("title/text"), i18n("quick_equip_tip3"))
	setText(self.rtQuickPanel:Find("frame/emptyTitle/text"), i18n("quick_equip_tip4"))
	setText(self.rtQuickPanel:Find("frame/selectTitle/text"), i18n("quick_equip_tip5"))

	self.rtBottomPanel = self._tf:Find("bottom_panel")
	self.rtInputField = self.rtBottomPanel:Find("InputField")

	setText(self.rtInputField:Find("Placeholder"), i18n("equipcode_input"))
	setInputText(self.rtInputField, self.contextData.code or nil)

	self.btnInput = self.rtBottomPanel:Find("btn_confirm")

	onButton(self, self.btnInput, function()
		self.code = getInputText(self.rtInputField)

		self:updateDispalyPanel(self.rtCodePanel, "code")

		return
	end, SFX_CONFIRM)

	return
end

function EquipCodeScene:didEnter()
	self.code = buildEquipCode(self.shipVO)

	self:updateDispalyPanel(self.rtMainPanel, "main")
	self:updateDispalyPanel(self.rtCodePanel, "code")

	return
end

function EquipCodeScene:updateDispalyPanel(arg_50_1, arg_50_2)
	updateDrop(arg_50_1:Find("IconTpl"), {
		type = DROP_TYPE_SHIP,
		id = self.shipVO.configId
	})

	local var_50_0 = self.shipVO:IsSpweaponUnlock()

	setActive(arg_50_1:Find("equipments/SpSlot/Lock"), not var_50_0)

	if arg_50_2 == "main" then
		for iter_50_0, iter_50_1 in ipairs(self.shipVO:getAllEquipments()) do
			var_0_1(arg_50_1:Find("equipments"):GetChild(iter_50_0 - 1), iter_50_1)
		end

		var_0_3(arg_50_1:Find("equipments/SpSlot"), self.shipVO:GetSpWeapon(), self.shipVO)
	elseif arg_50_2 == "code" then
		local var_50_1 = false

		self.codeData = {}

		for iter_50_2, iter_50_3 in ipairs(parseEquipCode(self.code)) do
			if iter_50_2 == 6 then
				self.codeData[iter_50_2] = var_50_0 and pg.spweapon_data_statistics[iter_50_3] and SpWeapon.New({
					id = iter_50_3
				}) or false

				if self.codeData[iter_50_2] then
					if not self:getEquipShipVO(self.codeData):CanEquipSpWeapon(self.codeData[iter_50_2]) then
						self.codeData[iter_50_2] = false
						var_50_1 = true
					end
				end

				var_0_3(arg_50_1:Find("equipments/SpSlot"), self.codeData[iter_50_2])
			else
				self.codeData[iter_50_2] = pg.equip_data_template[iter_50_3] and Equipment.New({
					id = iter_50_3
				}) or false

				if self.codeData[iter_50_2] then
					local var_50_4

					if not self:getEquipShipVO(self.codeData):canEquipAtPos(self.codeData[iter_50_2], iter_50_2) then
						self.codeData[iter_50_2] = false
						var_50_1 = true
						var_50_4 = arg_50_1:Find("equipments")
					end
				end

				var_0_1(var_50_4:GetChild(iter_50_2 - 1), self.codeData[iter_50_2])
			end
		end

		if var_50_1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipcode_slot_unmatch"))
		end

		self.equipData = {}

		for iter_50_4, iter_50_5 in ipairs(self.codeData) do
			if iter_50_5 and self.shipData[iter_50_4] and iter_50_5.configId == self.shipData[iter_50_4].configId then
				self.equipData[iter_50_4] = self.shipData[iter_50_4]
			end
		end

		for iter_50_6, iter_50_7 in ipairs(self.codeData) do
			if iter_50_7 and not self.equipData[iter_50_6] then
				local var_50_5 = iter_50_6 == 6 and pg.spweapon_data_statistics or pg.equip_data_template
				local var_50_6 = {
					iter_50_7.configId
				}

				for iter_50_8, iter_50_9 in ipairs({
					"next",
					"prev"
				}) do
					local var_50_7 = iter_50_7.configId

					while var_50_5[var_50_7][iter_50_9] > 0 do
						var_50_7 = var_50_5[var_50_7][iter_50_9]

						table.insert(var_50_6, var_50_7)
					end
				end

				if iter_50_6 == 6 then
					for iter_50_10, iter_50_11 in ipairs(underscore.filter(self.spWeapons, function(arg_51_0)
						return not arg_51_0.shipId
					end)) do
						local var_50_8 = table.indexof(var_50_6, iter_50_11.configId)

						if var_50_8 and (not self.equipData[iter_50_6] or var_50_8 < table.indexof(var_50_6, self.equipData[iter_50_6].configId)) then
							self.equipData[iter_50_6] = iter_50_11
						end
					end
				else
					for iter_50_12, iter_50_13 in ipairs(underscore.filter(self.equips, function(arg_52_0)
						return not arg_52_0.shipId or arg_52_0.shipId == self.shipVO.id
					end)) do
						local var_50_9 = table.indexof(var_50_6, iter_50_13.configId)

						if var_50_9 and (not self.equipData[iter_50_6] or var_50_9 < table.indexof(var_50_6, self.equipData[iter_50_6].configId)) and iter_50_13.count > underscore.reduce(self.equipData, 0, function(arg_53_0, arg_53_1)
							return arg_53_0 + (arg_53_1 == iter_50_13 and 1 or 0)
						end) then
							self.equipData[iter_50_6] = iter_50_13
						end
					end
				end
			end

			self.equipData[iter_50_6] = defaultValue(self.equipData[iter_50_6], false)
		end

		setActive(arg_50_1:Find("equipments_quick/SpSlot/Lock"), not var_50_0)

		for iter_50_14, iter_50_15 in ipairs(self.equipData) do
			local var_50_10 = arg_50_1:Find("equipments_quick"):GetChild(iter_50_14 - 1)

			if iter_50_14 == 6 then
				var_0_3(var_50_10, iter_50_15, (iter_50_15 and iter_50_15.shipId or nil) and (getProxy(BayProxy):getShipById(iter_50_15.shipId) or nil))
			else
				var_0_1(var_50_10, iter_50_15, (iter_50_15 and iter_50_15.shipId or nil) and (getProxy(BayProxy):getShipById(iter_50_15.shipId) or nil))
			end

			var_0_4(var_50_10, self.codeData[iter_50_14], iter_50_15)
		end
	else
		assert(false)
	end

	return
end

function EquipCodeScene:initQuickPanel()
	eachChild(self.rtCodePanel:Find("equipments_quick"), function(arg_55_0)
		if arg_55_0:GetSiblingIndex() + 1 == 6 then
			SetCompomentEnabled(arg_55_0, typeof(Toggle), self.shipVO:IsSpweaponUnlock())
		else
			SetCompomentEnabled(arg_55_0, typeof(Toggle), true)
		end

		return
	end)

	if self.quickIndex then
		triggerToggle(self.rtCodePanel:Find("equipments_quick"):GetChild(self.quickIndex - 1), false)
	end

	triggerToggle(self.rtQuickPanel:Find("title/equiping"), true)
	self:updateQuickPanel()

	return
end

function EquipCodeScene:updateQuickPanel()
	if not isActive(self.rtQuickPanel) then
		return
	end

	setActive(self.rtQuickPanel:Find("title/filter"), self.quickIndex)
	setActive(self.rtQuickPanel:Find("frame/selectTitle"), not self.quickIndex)

	if self.quickIndex then
		self.filterEquipments = self.quickIndex == 6 and self:getFilterSpWeapon() or self:getFilterEquipments()

		if self.equipData[self.quickIndex] then
			table.insert(self.filterEquipments, 1, false)
		end

		self.comList:SetTotalCount(#self.filterEquipments)
		setActive(self.rtQuickPanel:Find("frame/emptyTitle"), #self.filterEquipments == 0)
	else
		self.comList:SetTotalCount(0)
		setActive(self.rtQuickPanel:Find("frame/emptyTitle"), false)
	end

	return
end

function EquipCodeScene:getFilterEquipments()
	local var_57_0 = self:getEquipShipVO(self.equipData)
	local var_57_1 = getInputText(self.nameSearchInput)
	local var_57_2 = {
		self.indexData.equipPropertyIndex,
		self.indexData.equipPropertyIndex2
	}

	return underscore(self.equips):chain():filter(function(arg_58_0)
		local var_58_0

		if arg_58_0.shipId then
			var_58_0 = self.equipingFlag

			if self.equipingFlag then
				if arg_58_0.count > underscore.reduce(self.equipData, 0, function(arg_59_0, arg_59_1)
					return arg_59_0 + (arg_58_0 == arg_59_1 and 1 or 0)
				end) and not var_57_0:isForbiddenAtPos(arg_58_0, self.quickIndex) then
					var_58_0 = IndexConst.filterEquipByType(arg_58_0, self.indexData.typeIndex)

					if var_58_0 then
						var_58_0 = IndexConst.filterEquipByProperty(arg_58_0, var_57_2)

						if var_58_0 then
							var_58_0 = IndexConst.filterEquipAmmo1(arg_58_0, self.indexData.equipAmmoIndex1)

							if var_58_0 then
								var_58_0 = IndexConst.filterEquipAmmo2(arg_58_0, self.indexData.equipAmmoIndex2)

								if var_58_0 then
									var_58_0 = IndexConst.filterEquipByCamp(arg_58_0, self.indexData.equipCampIndex)

									if var_58_0 then
										var_58_0 = IndexConst.filterEquipByRarity(arg_58_0, self.indexData.rarityIndex)

										if var_58_0 then
											var_58_0 = IndexConst.filterEquipByExtra(arg_58_0, self.indexData.extraIndex)

											if var_58_0 then
												if var_57_1 ~= "" then
													var_58_0 = arg_58_0:IsMatchKey(var_57_1)

													goto label_58_0

													var_58_0 = false
												else
													var_58_0 = true
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end

		::label_58_0::

		return var_58_0
	end):each(function(arg_60_0)
		arg_60_0.mask = not var_57_0:canEquipAtPos(arg_60_0, self.quickIndex)

		return
	end):value()
end

function EquipCodeScene:getFilterSpWeapon()
	local var_61_0 = self:getEquipShipVO(self.equipData)
	local var_61_1 = getInputText(self.nameSearchInput)

	return underscore.filter(self.spWeapons, function(arg_62_0)
		local var_62_0

		if arg_62_0.shipId then
			var_62_0 = self.equipingFlag

			if self.equipingFlag then
				if arg_62_0 ~= self.equipData[6] and not var_61_0:IsSpWeaponForbidden(arg_62_0) then
					var_62_0 = IndexConst.filterSpWeaponByType(arg_62_0, self.spweaponIndexDatas.typeIndex)

					if var_62_0 then
						var_62_0 = IndexConst.filterSpWeaponByRarity(arg_62_0, self.spweaponIndexDatas.rarityIndex)

						if var_62_0 then
							if var_61_1 ~= "" then
								var_62_0 = arg_62_0:IsMatchKey(var_61_1)

								goto label_62_0

								var_62_0 = false
							else
								var_62_0 = true
							end
						end
					end
				end
			end
		end

		::label_62_0::

		return var_62_0
	end)
end

function EquipCodeScene:willExit()
	if self.ltID then
		LeanTween.cancel(self.ltID)

		self.ltID = nil
	end

	return
end

return EquipCodeScene
