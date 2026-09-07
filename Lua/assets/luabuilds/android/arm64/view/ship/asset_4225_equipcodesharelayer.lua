local EquipCodeShareLayer = class("EquipCodeShareLayer", import("..base.BaseUI"))

function EquipCodeShareLayer:getUIName()
	return "EquipCodeShareUI"
end

function EquipCodeShareLayer:setShipGroup(arg_2_1)
	self.shipGroup = arg_2_1
	self.codes = arg_2_1:getEquipCodes()

	local var_2_0 = {}

	self.firstPool = underscore(self.codes):chain():filter(function(arg_3_0)
		return arg_3_0.new == 0 and arg_3_0.state == 0
	end):sort(CompareFuncs({
		function(arg_4_0)
			return -arg_4_0.like
		end
	})):first(12):each(function(arg_5_0)
		var_2_0[arg_5_0.id] = true

		return
	end):sort(CompareFuncs({
		function(arg_6_0)
			return -arg_6_0.evaPoint
		end
	})):value()
	self.oldPool = underscore.filter(self.codes, function(arg_7_0)
		return arg_7_0.new == 0 and not var_2_0[arg_7_0.id]
	end)
	self.newPool = underscore.filter(self.codes, function(arg_8_0)
		return arg_8_0.new == 1
	end)

	return
end

local function var_0_1(arg_9_0, arg_9_1, arg_9_2)
	setActive(arg_9_0:Find("IconTpl"), tobool(arg_9_1))

	if not arg_9_1 then
		return
	end

	updateEquipment(arg_9_0:Find("IconTpl"), arg_9_1)

	if not arg_9_0:Find("IconTpl/icon_bg/equip_flag") then
		return
	end

	setActive(arg_9_0:Find("IconTpl/icon_bg/equip_flag"), arg_9_2)

	if not arg_9_2 then
		return
	end

	setImageSprite(arg_9_0:Find("IconTpl/icon_bg/equip_flag/Image"), LoadSprite("qicon/" .. arg_9_2:getPainting()))

	return
end

local function var_0_2(arg_10_0, arg_10_1, arg_10_2)
	setActive(arg_10_0:Find("Icon"), arg_10_1)
	setActive(arg_10_0:Find("IconShadow"), arg_10_1)

	if not arg_10_1 then
		return
	end

	UpdateSpWeaponSlot(arg_10_0, arg_10_1)

	if not arg_10_0:Find("Icon/equip_flag") then
		return
	end

	setActive(arg_10_0:Find("Icon/equip_flag"), arg_10_2)

	if not arg_10_2 then
		return
	end

	setImageSprite(arg_10_0:Find("Icon/equip_flag/Image"), LoadSprite("qicon/" .. arg_10_2:getPainting()))

	return
end

local var_0_3 = {
	customPanels = {
		minHeight = 650,
		labelIndex = {
			mode = CustomIndexLayer.Mode.AND,
			options = IndexConst.ECodeLabelIndexs,
			names = IndexConst.ECodeLabelNames
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
	}
}

function EquipCodeShareLayer:init()
	onButton(self, self._tf:Find("BG"), function()
		self:closeView()

		return
	end, SFX_CANCEL)

	self.rtMainPanel = self._tf:Find("mainPanel")

	onButton(self, self.rtMainPanel:Find("top_panel/btnBack"), function()
		self:closeView()

		return
	end, SFX_CANCEL)

	self.indexData = self.indexData or {}

	local var_11_0 = self.rtMainPanel:Find("top_panel/btn_filter")

	onButton(self, var_11_0, function()
		self:emit(EquipCodeShareMediator.OPEN_TAG_INDEX, setmetatable({
			indexDatas = Clone(self.indexData),
			callback = function(self)
				self.indexData.labelIndex = self.labelIndex

				local var_15_0 = self:isDefaultFilter()

				setImageAlpha(var_11_0, var_15_0 and 1 or 0)
				setActive(var_11_0:Find("on"), not var_15_0)

				self.refreshCount = 0

				self:refreshCodes()

				return
			end
		}, {
			__index = var_0_3
		}))

		return
	end, SFX_PANEL)

	self.rtShipCard = self.rtMainPanel:Find("left_panel/ship_tpl")

	onButton(self, self.rtMainPanel:Find("left_panel/btn_refresh"), function()
		self:refreshCodes()

		return
	end, SFX_PANEL)

	local var_11_1 = self.rtMainPanel:Find("right_panel/content/container")

	self.itemList = UIItemList.New(var_11_1, var_11_1:Find("tpl"))

	local var_11_2 = pg.equip_data_template
	local var_11_3 = pg.spweapon_data_statistics

	self.itemList:make(function(arg_17_0, arg_17_1, arg_17_2)
		arg_17_1 = arg_17_1 + 1

		if arg_17_0 == UIItemList.EventUpdate then
			local var_17_0 = self.filterCodes[arg_17_1]
			local var_17_1 = {}
			local var_17_4, var_17_5

			var_17_4, var_17_5, var_17_1[1], var_17_1[2] = unpack(string.split(self.filterCodes[arg_17_1].str, "&"))

			for iter_17_0, iter_17_1 in ipairs(parseEquipCode(var_17_4)) do
				if iter_17_0 == 6 then
					var_0_2(arg_17_2:Find("left/equipments/SpSlot"), var_11_3[iter_17_1] and SpWeapon.New({
						id = iter_17_1
					}) or false)
				else
					var_0_1(arg_17_2:Find("left/equipments"):GetChild(iter_17_0 - 1), var_11_2[iter_17_1] and Equipment.New({
						id = iter_17_1
					}) or false)
				end
			end

			for iter_17_2, iter_17_3 in ipairs({}) do
				setText(arg_17_2:Find("left/tags/" .. iter_17_2 .. "/Text"), i18n("equip_share_label_" .. iter_17_3))
			end

			setText(arg_17_2:Find("right/like/Text"), self.filterCodes[arg_17_1].like)
			onButton(self, arg_17_2:Find("right/like/btn_like"), function()
				if var_17_0.afterLike then
					pg.TipsMgr.GetInstance():ShowTips(i18n("equipcode_like_limited"))
				else
					function self.successCallback()
						self.successCallback = nil

						setText(arg_17_2:Find("right/like/Text"), var_17_0.like)

						return
					end

					self:emit(EquipCodeShareMediator.LIKE_EQUIP_CODE, self.shipGroup.id, var_17_0.id)
				end

				return
			end, SFX_PANEL)
			onButton(self, arg_17_2:Find("right/like/btn_impeach"), function()
				self.impeachCodeId = var_17_0.id

				setActive(self.rtMainPanel, false)
				setActive(self.impackPanel, true)
				triggerToggle(self.impackPanel:Find("window/msg_panel/content/options/tpl"), true)

				return
			end, SFX_PANEL)
			onButton(self, arg_17_2:Find("right/btn_copy"), function()
				UniPasteBoard.SetClipBoardString(var_17_4)
				pg.TipsMgr.GetInstance():ShowTips(i18n("equipcode_export_success"))

				return
			end, SFX_CONFIRM)
		end

		return
	end)
	setText(self.rtMainPanel:Find("right_panel/content/nothing/Text_2"), i18n("equipcode_share_listempty"))
	setText(self.rtMainPanel:Find("top_panel/title/name"), i18n("equipcode_share_title"))
	setText(self.rtMainPanel:Find("top_panel/title/name/name_en"), i18n("equipcode_share_titleeng"))
	self:initImpeachPanel()
	self:BlurPanel(self._tf)

	return
end

function EquipCodeShareLayer:refreshLikeCommand(arg_22_1, arg_22_2)
	local var_22_0 = underscore.detect(self.codes, function(arg_23_0)
		return arg_23_0.id == arg_22_1
	end)

	var_22_0.afterLike = true
	var_22_0.like = var_22_0.like + (arg_22_2 and 1 or 0)

	existCall(self.successCallback)

	return
end

function EquipCodeShareLayer:initImpeachPanel()
	self.impackPanel = self._tf:Find("impeachPanel")

	setText(self.impackPanel:Find("window/top/bg/impeach/title"), i18n("report_sent_title"))
	onButton(self, self.impackPanel:Find("window/top/btnBack"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)

	local var_24_0 = {
		{
			"equipcode_report_type_1",
			"equipcode_report_type_1"
		},
		{
			"equipcode_report_type_2",
			"equipcode_report_type_2"
		}
	}
	local var_24_1 = self.impackPanel:Find("window/msg_panel/content")

	setText(var_24_1:Find("title"), i18n("report_sent_desc"))

	local var_24_2 = UIItemList.New(var_24_1:Find("options"), var_24_1:Find("options/tpl"))

	var_24_2:make(function(arg_26_0, arg_26_1, arg_26_2)
		arg_26_1 = arg_26_1 + 1

		if arg_26_0 == UIItemList.EventUpdate then
			setText(arg_26_2:Find("Text"), i18n(var_24_0[arg_26_1][1]))
			setText(arg_26_2:Find("Text_2"), i18n(var_24_0[arg_26_1][2]))
			onToggle(self, arg_26_2, function(arg_27_0)
				self.impeachOption = arg_26_1

				return
			end)
		end

		return
	end)
	var_24_2:align(#var_24_0)

	local var_24_3 = var_24_1:Find("other/field/input")

	onButton(self, self.impackPanel:Find("window/button_container/button"), function()
		self:emit(EquipCodeShareMediator.IMPEACH_EQUIP_CODE, self.shipGroup.id, self.impeachCodeId, self.impeachOption)
		self:onBackPressed()

		return
	end, SFX_CONFIRM)

	return
end

function EquipCodeShareLayer:onBackPressed()
	if isActive(self.impackPanel) then
		setActive(self.rtMainPanel, true)
		setActive(self.impackPanel, false)

		return
	end

	self:closeView()

	return
end

function EquipCodeShareLayer:didEnter()
	self:flushShip()

	self.refreshCount = 0

	self:refreshCodes()

	return
end

function EquipCodeShareLayer:flushShip()
	self.head = self.rtMainPanel:Find("left_panel/ship_tpl")
	self.iconType = self.head:Find("content/main_bg/type_mask/type_icon"):GetComponent(typeof(Image))
	self.imageBg = self.head:Find("content/icon_bg"):GetComponent(typeof(Image))
	self.imageFrame = self.head:Find("content/main_bg/frame")
	self.iconShip = self.head:Find("content/icon"):GetComponent(typeof(Image))
	self.labelName = self.head:Find("content/main_bg/name_mask/name"):GetComponent(typeof(Text))
	self.scrollText = self.head:Find("content/main_bg/name_mask/name"):GetComponent(typeof(ScrollText))
	self.stars = self.head:Find("content/main_bg/stars")
	self.star = self.stars:Find("tpl")

	local var_31_0 = self.shipGroup:rarity2bgPrint(self.showTrans)

	setShipCardFrame(self.imageFrame, var_31_0, nil)
	GetImageSpriteFromAtlasAsync("bg/star_level_card_" .. var_31_0, "", self.imageBg)

	self.iconShip.sprite = GetSpriteFromAtlas("shipYardIcon/unknown", "")

	LoadImageSpriteAsync("shipYardIcon/" .. self.shipGroup:getPainting(self.showTrans), self.iconShip)

	self.labelName.text = self.shipGroup:getName(self.showTrans)

	if self.scrollText then
		self.scrollText:SetText(self.shipGroup:getName(self.showTrans))
	end

	local var_31_1 = GetSpriteFromAtlas("shiptype", shipType2print(self.shipGroup:getShipType(self.showTrans)))

	if not var_31_1 then
		warning("找不到船形, shipConfigId: " .. self.shipGroup.shipConfig.id)
	end

	self.iconType.sprite = var_31_1

	for iter_31_0 = self.stars.childCount, pg.ship_data_template[self.shipGroup.shipConfig.id].star_max - 1 do
		local var_31_2 = cloneTplTo(self.star, self.stars)
	end

	return
end

function EquipCodeShareLayer:isDefaultFilter()
	return underscore(self.indexData):chain():keys():all(function(arg_33_0)
		return self.indexData[arg_33_0] == var_0_3.customPanels[arg_33_0].options[1]
	end):value()
end

function EquipCodeShareLayer:codesFilter(arg_34_1)
	return underscore.filter(arg_34_1, function(arg_35_0)
		return IndexConst.filterEquipCodeByLable(arg_35_0, self.indexData.labelIndex)
	end)
end

function EquipCodeShareLayer:refreshCodes()
	self.refreshCount = self.refreshCount + 1
	self.filterCodes = {}

	if self.refreshCount > 4 or not self:isDefaultFilter() then
		local var_36_0 = self:codesFilter(self.codes)

		if #var_36_0 > 4 then
			for iter_36_0 = 1, 4 do
				local var_36_1 = math.random(#var_36_0)

				table.insert(self.filterCodes, var_36_0[var_36_1])
				table.remove(var_36_0, var_36_1)
			end
		else
			self.filterCodes = var_36_0
		end

		table.sort(self.filterCodes, CompareFuncs({
			function(arg_37_0)
				return -arg_37_0.like
			end
		}, false))
	else
		if #self.firstPool < 3 then
			self.filterCodes = underscore.rest(self.firstPool, 1)
		elseif #self.firstPool < self.refreshCount * 3 then
			local var_36_2 = underscore.rest(self.firstPool, 1)

			for iter_36_1 = 1, 3 do
				local var_36_3 = math.random(#var_36_2)

				table.insert(self.filterCodes, var_36_2[var_36_3])
				table.remove(var_36_2, var_36_3)
			end
		else
			self.filterCodes = underscore.slice(self.firstPool, (self.refreshCount - 1) * 3 + 1, 3)
		end

		local var_36_4 = {
			underscore.rest(self.newPool, 1),
			underscore.rest(self.oldPool, 1),
			underscore.filter(self.firstPool, function(arg_38_0)
				return underscore.all(self.filterCodes, function(arg_39_0)
					return arg_39_0.id ~= arg_38_0.id
				end)
			end)
		}

		while #self.filterCodes < 4 do
			local var_36_6

			if nil and #nil > 0 then
				local var_36_5 = math.random(#nil)

				table.insert(self.filterCodes, (nil)[var_36_5])
				table.remove(nil, var_36_5)
			elseif #var_36_4 > 0 then
				var_36_6 = table.remove(var_36_4, 1)
			else
				break
			end
		end
	end

	self.itemList:align(#self.filterCodes)
	setActive(self.rtMainPanel:Find("right_panel/content/nothing"), #self.filterCodes == 0)

	return
end

function EquipCodeShareLayer:willExit()
	self:UnOverlayPanel(self._tf)

	return
end

return EquipCodeShareLayer
