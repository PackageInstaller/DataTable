local IslandShipDressUpPageNew = class("IslandShipDressUpPageNew", import("...base.IslandBasePage"))

IslandShipDressUpPageNew.CHANGE_SKIN = "IslandShipDressUpPage:CHANGE_SKIN"

function IslandShipDressUpPageNew:getUIName()
	return "IslandShipDressUI"
end

local var_0_1 = {
	IslandShipDressHelperNew.DressType.Hair,
	IslandShipDressHelperNew.DressType.Face,
	IslandShipDressHelperNew.DressType.Body,
	[5] = IslandShipDressHelperNew.DressType.BackDecorate,
	[6] = IslandShipDressHelperNew.DressType.Flotage,
	[7] = IslandShipDressHelperNew.DressType.Footprint
}

IslandShipDressUpPageNew.SORT_DEFAULT = 1
IslandShipDressUpPageNew.SORT_RARITY = 2
IslandShipDressUpPageNew.SORT_CANSEND = 3
IslandShipDressUpPageNew.SORT_LIST = {
	IslandShipDressUpPageNew.SORT_DEFAULT,
	IslandShipDressUpPageNew.SORT_RARITY,
	IslandShipDressUpPageNew.SORT_CANSEND
}
IslandShipDressUpPageNew.SORTCN = {
	[IslandShipDressUpPageNew.SORT_DEFAULT] = i18n("word_default"),
	[IslandShipDressUpPageNew.SORT_RARITY] = i18n("word_rarity"),
	[IslandShipDressUpPageNew.SORT_CANSEND] = i18n("island_word_give")
}

function IslandShipDressUpPageNew:Sort2CN()
	return IslandShipDressUpPageNew.SORTCN[self]
end

function IslandShipDressUpPageNew:OnLoaded()
	self.rightPanel = self._tf:Find("adapt/right_panel")
	self.togglePanel = self.rightPanel:Find("toggles/select_toggles")
	self.saveBtn = self._tf:Find("adapt/save")
	self.restBtn = self._tf:Find("adapt/reset")

	setText(self.saveBtn:Find("Text"), i18n("word_save"))
	setText(self.restBtn:Find("Text"), i18n("island_word_reset"))

	self.toggles = {
		self.togglePanel:Find("hair"),
		self.togglePanel:Find("face"),
		self.togglePanel:Find("body"),
		self.togglePanel:Find("skin"),
		self.togglePanel:Find("wing"),
		self.togglePanel:Find("trailing"),
		self.togglePanel:Find("footprint")
	}
	self.dressCards = {}
	self.skinCards = {}
	self.dressTF = self.rightPanel:Find("dress")
	self.skinTF = self.rightPanel:Find("skin")
	self.dressRectTF = self.dressTF:Find("dress_container")
	self.dressRect = self.dressTF:Find("dress_container/dress"):GetComponent("LScrollRect")
	self.dressEmpty = self.dressTF:Find("dressEmpty")
	self.dressEmptyTips = self.dressEmpty:Find("layout/empty_tips")
	self.dressList = {}

	function self.dressRect.onInitItem(arg_4_0)
		self:OnDressInitItem(arg_4_0)

		return
	end

	function self.dressRect.onUpdateItem(arg_5_0, arg_5_1)
		self:OnDressUpdateItem(arg_5_0, arg_5_1)

		return
	end

	self.skinRect = self.skinTF:Find("dress_container/dress"):GetComponent("LScrollRect")
	self.skinRectTF = self.skinTF:Find("dress_container")
	self.skinEmpty = self.skinTF:Find("skinEmpty")
	self.skinEmptyTips = self.skinEmpty:Find("layout/empty_tips")

	function self.skinRect.onInitItem(arg_6_0)
		self:OnSkinInitItem(arg_6_0)

		return
	end

	function self.skinRect.onUpdateItem(arg_7_0, arg_7_1)
		self:OnSkinUpdateItem(arg_7_0, arg_7_1)

		return
	end

	self.sortBtn = self.dressTF:Find("order")
	self.orderBtn = self.sortBtn:Find("icon")
	self.orderTxt = self.sortBtn:Find("Text_1"):GetComponent(typeof(Text))
	self.sortPage = IslandShipDressUpSortPage.New(self._tf)
	self.dressUpConfireBtn = self._tf:Find("adapt/confire")
	self.dressUpConfireText = self._tf:Find("adapt/confire/Text")

	setText(self.dressUpConfireText, i18n("island_dress_initial_makesure"))

	self.colorList = self._tf:Find("adapt/left_color_panel/colorList")
	self.colorItem = self._tf:Find("adapt/left_color_panel/colorList/item")
	self.color_listPanel = self._tf:Find("adapt/left_color_panel")
	self.color_bg_unlock = self._tf:Find("adapt/left_color_panel/bg1")
	self.color_bg_locked = self._tf:Find("adapt/left_color_panel/bglocked")
	self.color_lockedBtn = self.color_bg_locked:Find("unlockedBtn")
	self.color_cost_item_icon = self.color_bg_locked:Find("itemcost")
	self.color_cost_item_count = self.color_bg_locked:Find("cost_num")

	setActive(self.sortBtn, false)
	setText(self.color_bg_locked:Find("tips"), i18n("island_dresscolorunlock_tips"))
	setText(self.color_lockedBtn:Find("Text"), i18n("island_dresscolorunlock"))

	self.colorItemUIList = UIItemList.New(self.colorList, self.colorItem)
	self.hatTF = self._tf:Find("adapt/btns/hat")
	self.hatOn = self.hatTF:Find("hatOn")
	self.hatOff = self.hatTF:Find("hatOff")
	self.morphTF = self._tf:Find("adapt/btns/morph")
	self.morphBtn = self.morphTF and self.morphTF:Find("morphBtn")
	self.morphBlocker = self._tf:Find("adapt/morph_blocker")

	setActive(self.morphBlocker, false)

	self.dressDetailPopup = IslandShipDressDescBox.New(self._tf, self.event, self.contextData)

	return
end

function IslandShipDressUpPageNew:CheckDressIsExclusive(arg_8_1)
	local var_8_0 = pg.island_dress_template[arg_8_1]

	if pg.island_dress_template[arg_8_1].exclusive_skin ~= "" then
		for iter_8_0, iter_8_1 in ipairs(pg.island_dress_template[arg_8_1].exclusive_skin) do
			if iter_8_1 == self.curSkinId then
				return false, true
			end
		end
	end

	if var_8_0.exclusive_default_skin ~= "" and (self.curSkinId == nil or self.curSkinId == 0) then
		for iter_8_2, iter_8_3 in ipairs(var_8_0.exclusive_default_skin) do
			if iter_8_3 == self.shipId then
				return true, false
			end
		end
	end

	return false, false
end

function IslandShipDressUpPageNew:ClickDressCardItem(arg_9_1)
	if self.shipId ~= 0 then
		if arg_9_1.needRedDot then
			local var_9_0 = {}

			table.insert(var_9_0, arg_9_1.id)
			pg.m02:sendNotification(GAME.ISLAND_SEND_ROLE_DRESS_READ, {
				dress_List = var_9_0
			})
		end

		local var_9_1, var_9_2 = self:CheckDressIsExclusive(arg_9_1.id)

		if var_9_2 or var_9_1 then
			local var_9_3 = pg.island_dress_template[arg_9_1.id]

			if var_9_1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_dress_mutually_exclusive1", var_9_3.name))

				return
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_dress_mutually_exclusive1", var_9_3.name))

				return
			end
		end

		local var_9_4 = self.curShipDressTypeDataDic[self.dressType]

		if self.curShipDressTypeDataDic[self.dressType]:CheckIsEqualByShipIdAndDressId(arg_9_1.holdedShipId or 0, arg_9_1.id) then
			var_9_4:SetShipAndDressId(nil, nil)
		else
			var_9_4:SetShipAndDressId(arg_9_1.holdedShipId or 0, arg_9_1.id)
		end

		local var_9_5 = {
			colorId = 0
		}

		var_9_5.id = var_9_4.dress_id or 0

		self.shipDressHelper:ChangeDressByType(self.dressType, var_9_5)
		self.dressRect:SetTotalCount(#self.dressList)

		return
	end

	if arg_9_1.needRedDot then
		local var_9_6 = {}

		table.insert(var_9_6, arg_9_1.id)
		pg.m02:sendNotification(GAME.ISLAND_SEND_COMMANDER_DRESS_READ, {
			dress_List = var_9_6
		})
	end

	local var_9_7 = arg_9_1.id

	if self.curDressTypeDataDic[self.dressType] == arg_9_1.id then
		if table.contains(IslandShipDressHelperNew.CommanderCustom, self.dressType) then
			return
		else
			var_9_7 = 0
		end
	end

	if self.dressType == IslandShipDressHelperNew.DressType.Body then
		local var_9_8 = self.dressUpAgency:GetTwinCurId(var_9_7)

		if var_9_8 and var_9_8 ~= 0 then
			var_9_7 = var_9_8
		end
	end

	self.curDressTypeDataDic[self.dressType] = var_9_7

	self.shipDressHelper:ChangeDressByType(self.dressType, {
		id = var_9_7,
		colorId = (function()
			local var_10_0 = 0

			if var_9_7 ~= 0 and self.shipId == 0 then
				var_10_0 = self.dressUpAgency:GetCurrentColorByDressId(var_9_7)
				self.dressColorDic[var_9_7] = var_10_0
			end

			return var_10_0
		end)()
	})
	self.dressRect:SetTotalCount(#self.dressList)
	self:CheckHatAutoTakeOff(var_9_7)
	self:UpdateHatDisplay()
	self:UpdateMorphDisplay()
	self:UpdateColorList(true)

	return
end

function IslandShipDressUpPageNew:CheckHatAutoTakeOff(arg_11_1)
	if self.dressType == IslandShipDressHelperNew.DressType.Body then
		local var_11_0 = self.dressUpAgency:GetBodyHatDressId(arg_11_1)

		if not var_11_0 or var_11_0 == 0 then
			self.curDressTypeDataDic[IslandShipDressHelperNew.DressType.Hat] = 0

			self.shipDressHelper:ChangeDressByType(IslandShipDressHelperNew.DressType.Hat, {
				id = 0,
				colorId = 0
			})
		end
	end

	return
end

function IslandShipDressUpPageNew:UpdateHatToggleDisplay(arg_12_1)
	setActive(self.hatOn, not arg_12_1)
	setActive(self.hatOff, arg_12_1)

	return
end

function IslandShipDressUpPageNew:UpdateHatDisplay()
	if self.dressType ~= IslandShipDressHelperNew.DressType.Body then
		setActive(self.hatTF, false)

		return
	end

	local var_13_0 = self.curDressTypeDataDic[self.dressType]

	if not self.curDressTypeDataDic[self.dressType] or var_13_0 == 0 then
		setActive(self.hatTF, false)

		return
	end

	local var_13_1 = (pg.island_dress_template.get_id_list_by_related_dress[var_13_0] or {})[1]

	if not (pg.island_dress_template.get_id_list_by_related_dress[var_13_0] or {})[1] then
		setActive(self.hatTF, false)

		return
	end

	setActive(self.hatTF, true)

	local var_13_2 = pg.island_dress_template[var_13_1].type
	local var_13_3 = self.dressUpAgency:GetBodyHatIsOn(var_13_0, var_13_1)

	self.shipDressHelper:ChangeDressByType(pg.island_dress_template[var_13_1].type, {
		id = var_13_3 and var_13_1 or 0
	})

	self.curDressTypeDataDic[var_13_2] = var_13_3 and var_13_1 or 0

	self:UpdateHatToggleDisplay(var_13_3)

	if pg.island_dress_template[var_13_1].takeoff_btn_is_hide == 1 then
		setActive(self.hatTF, false)
	end

	onButton(self, self.hatOn, function()
		if self.curDressTypeDataDic[var_13_2] ~= var_13_1 then
			self.curDressTypeDataDic[var_13_2] = var_13_1

			self.shipDressHelper:ChangeDressByType(var_13_2, {
				id = var_13_1
			})
			self:UpdateHatToggleDisplay(true)
		end

		return
	end)
	onButton(self, self.hatOff, function()
		if self.curDressTypeDataDic[var_13_2] ~= 0 then
			self.curDressTypeDataDic[var_13_2] = 0

			self.shipDressHelper:ChangeDressByType(var_13_2, {
				id = 0
			})
			self:UpdateHatToggleDisplay(false)
		end

		return
	end)

	return
end

function IslandShipDressUpPageNew:OnDressInitItem(arg_16_1)
	self.dressCards[arg_16_1] = IslandDressCard.New(arg_16_1)

	return
end

function IslandShipDressUpPageNew:UpdateMorphDisplay()
	if self.dressType ~= IslandShipDressHelperNew.DressType.Body then
		setActive(self.morphTF, false)

		return
	end

	local var_17_0 = self.curDressTypeDataDic[self.dressType]

	if not self.curDressTypeDataDic[self.dressType] or var_17_0 == 0 then
		setActive(self.morphTF, false)

		return
	end

	local var_17_1 = 0

	if pg.island_dress_template[var_17_0].cloth_related and pg.island_dress_template[var_17_0].cloth_related ~= 0 then
		var_17_1 = pg.island_dress_template[var_17_0].cloth_related
	end

	if var_17_1 == 0 then
		setActive(self.morphTF, false)

		return
	end

	setActive(self.morphTF, true)
	onButton(self, self.morphBtn, function()
		self:DoMorphSwitch(var_17_0, var_17_1)

		return
	end)

	return
end

function IslandShipDressUpPageNew:DoMorphSwitch(arg_19_1, arg_19_2)
	if self.morphing then
		return
	end

	self:SetMorphBlock(true)

	if not self.shipDressHelper then
		self:DoSwitch(arg_19_2, function()
			self:SetMorphBlock(false)

			return
		end)

		return
	end

	self.shipDressHelper:DoMorphSwitch(arg_19_1, arg_19_2, function()
		self:DoSwitch(arg_19_2, function()
			self:SetMorphBlock(false)

			return
		end)

		return
	end)

	return
end

function IslandShipDressUpPageNew:SetMorphBlock(arg_23_1)
	self.morphing = arg_23_1

	setActive(self.morphBlocker, arg_23_1)

	return
end

function IslandShipDressUpPageNew:CanEsc()
	if self.morphing then
		return false
	end

	return true
end

function IslandShipDressUpPageNew:DoSwitch(arg_25_1, arg_25_2)
	self.curDressTypeDataDic[IslandShipDressHelperNew.DressType.Body] = arg_25_1

	self.shipDressHelper:ChangeDressByType(IslandShipDressHelperNew.DressType.Body, {
		colorId = 0,
		id = arg_25_1
	}, arg_25_2)
	self:CheckHatAutoTakeOff(arg_25_1)
	self:UpdateHatDisplay()
	self:UpdateMorphDisplay()

	return
end

function IslandShipDressUpPageNew:AddLongPressListeners(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	self.isLongPress = false

	local function var_26_0()
		if self.isLongPress then
			self.dressDetailPopup:ExecuteAction("Hide")

			self.isLongPress = false
		end

		return
	end

	local var_26_1 = GetOrAddComponent(arg_26_2, typeof(LongPressTrigger))

	var_26_1.onClick:RemoveAllListeners()
	var_26_1.onClick:AddListener(function()
		if self.isLongPress then
			var_26_0()

			return
		end

		arg_26_4()

		return
	end)
	var_26_1.onLongPressed:RemoveAllListeners()
	var_26_1.onLongPressed:AddListener(function()
		self.isLongPress = true

		local var_29_0 = self._tf:InverseTransformPoint(tf(arg_26_2).position)

		self.dressDetailPopup:ExecuteAction("Show", arg_26_1, arg_26_3, (Vector2(var_29_0.x - tf(arg_26_2).sizeDelta.x / 2, var_29_0.y + tf(arg_26_2).sizeDelta.y / 2)))

		return
	end)
	var_26_1.onReleased:RemoveAllListeners()
	var_26_1.onReleased:AddListener(var_26_0)

	return
end

function IslandShipDressUpPageNew:OnDressUpdateItem(arg_30_1, arg_30_2)
	local var_30_0 = self.dressCards[arg_30_2]

	if not self.dressCards[arg_30_2] then
		self:OnDressInitItem(arg_30_2)

		var_30_0 = self.dressCards[arg_30_2]
	end

	local var_30_1 = self.dressList[arg_30_1 + 1]

	setActive(var_30_0.canSendTF, false)

	local var_30_2 = var_30_1.ownCount ~= nil

	setActive(var_30_0.ownNumTF, var_30_1.ownCount ~= nil)

	if var_30_2 then
		setText(var_30_0.ownNumText, "×" .. var_30_1.ownCount)
	end

	local var_30_3 = var_30_1.holdedShipId ~= nil

	setActive(var_30_0.shipHoldTF, var_30_1.holdedShipId ~= nil)

	if var_30_3 then
		GetImageSpriteFromAtlasAsync("island/IslandShipIcon/" .. IslandShip.StaticGetPrefab(var_30_1.holdedShipId), "", var_30_0.shipIcon)
	end

	setActive(var_30_0.redDot, var_30_1.needRedDot)

	local var_30_5 = var_30_1.id
	local var_30_6 = tf(arg_30_2)

	self:AddLongPressListeners(IslandShipDressDescBox.TYPE.DRESS, arg_30_2, var_30_1.id, function()
		self:ClickDressCardItem(var_30_1)

		return
	end)

	local var_30_7 = false

	if self.shipId == 0 then
		var_30_7 = (self.curDressTypeDataDic[self.dressType] ~= 0 and self.curDressTypeDataDic[self.dressType] or nil) == var_30_1.id or (self.curDressTypeDataDic[self.dressType] ~= 0 and self.curDressTypeDataDic[self.dressType] or nil) == var_30_1:getConfig("cloth_related")

		setActive(var_30_0.exclusionTF, false)
	else
		local var_30_9, var_30_10 = self:CheckDressIsExclusive(var_30_1.id)

		setActive(var_30_0.exclusionTF, var_30_9 or var_30_10)

		var_30_7 = self.curShipDressTypeDataDic[self.dressType]:CheckIsEqualByShipIdAndDressId(var_30_1.holdedShipId or 0, var_30_1.id)
	end

	var_30_0:Update(var_30_5, var_30_7)

	return
end

function IslandShipDressUpPageNew:OnSkinInitItem(arg_32_1)
	self.skinCards[arg_32_1] = IslandSkinCard.New(arg_32_1)

	return
end

function IslandShipDressUpPageNew:OnSkinUpdateItem(arg_33_1, arg_33_2)
	local var_33_0 = self.skinCards[arg_33_2]

	if not self.skinCards[arg_33_2] then
		self:OnSkinInitItem(arg_33_2)

		var_33_0 = self.skinCards[arg_33_2]
	end

	local var_33_1 = self.skinList[arg_33_1 + 1]

	setActive(tf(arg_33_2):Find("changeColor"), true)
	var_33_0:Update(var_33_1, self.curSkinId ~= 0 and self.curSkinId or nil)
	self:AddLongPressListeners(IslandShipDressDescBox.TYPE.SKIN, arg_33_2, var_33_1, function()
		self:ClickSkinCardItem(var_33_1)

		return
	end)

	return
end

function IslandShipDressUpPageNew:ChangeModelBySkinAndSkinColor()
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs({
		IslandShipDressHelperNew.DressType.BackDecorate,
		IslandShipDressHelperNew.DressType.Flotage,
		IslandShipDressHelperNew.DressType.Footprint
	}) do
		local var_35_1 = self.curShipDressTypeDataDic[iter_35_1]

		if self.curShipDressTypeDataDic[iter_35_1] and var_35_1.dress_id and var_35_1.dress_id ~= 0 then
			if self.curSkinId ~= 0 then
				for iter_35_2, iter_35_3 in ipairs(pg.island_dress_template[var_35_1.dress_id].exclusive_skin == "" and {} or pg.island_dress_template[var_35_1.dress_id].exclusive_skin) do
					if iter_35_3 == self.curSkinId then
						table.insert(var_35_0, var_35_1.dress_id)
						var_35_1:SetShipAndDressId(nil, nil)
					end
				end
			else
				for iter_35_4, iter_35_5 in ipairs(pg.island_dress_template[var_35_1.dress_id].exclusive_default_skin == "" and {} or pg.island_dress_template[var_35_1.dress_id].exclusive_default_skin) do
					if iter_35_5 == self.shipId then
						table.insert(var_35_0, var_35_1.dress_id)
						var_35_1:SetShipAndDressId(nil, nil)
					end
				end
			end
		end
	end

	if #var_35_0 > 0 then
		local var_35_3 = ""

		for iter_35_6, iter_35_7 in ipairs(var_35_0) do
			local var_35_4 = pg.island_dress_template[iter_35_7].name

			if iter_35_6 > 1 then
				var_35_4 = "," .. var_35_4
			end

			var_35_3 = var_35_3 .. var_35_4
		end

		pg.TipsMgr.GetInstance():ShowTips(i18n("island_dress_mutually_exclusive", var_35_3))
	end

	self:emit(IslandShipMainPage.CLEAR_ITEM_ANIMATOR)

	local var_35_5 = self.characterAgency:GetShipById(self.shipId):GetModelBySkinAndColorId(self.curSkinId, self.curskinColorId)

	if #var_35_0 > 0 then
		self.shipDressHelper:ChangeModelTransfromByUnitIdAndChangeDress(var_35_5, var_35_0, nil, nil, true)
	else
		self.shipDressHelper:ChangeModelTransfromByUnitId(var_35_5, nil, true)
	end

	return
end

function IslandShipDressUpPageNew:ClickSkinCardItem(arg_36_1)
	self.curSkinId = arg_36_1 == self.curSkinId and 0 or arg_36_1

	self:UpdateSkinList()

	if self.curSkinId ~= 0 then
		self.curskinColorId = self.characterAgency:GetCurrentSkinColorByShipId(self.shipId, self.curSkinId)
	end

	self:ChangeModelBySkinAndSkinColor()
	self:UpdateColorList()
	self:UpdateHatDisplay()

	return
end

function IslandShipDressUpPageNew:ClearSkinSelected(arg_37_1)
	return
end

function IslandShipDressUpPageNew:AddListeners()
	self:AddListener(GAME.ISLAND_CHANGE_ROLE_DRESS_DONE, self.OnChangeRoleDressDone)
	self:AddListener(GAME.ISLAND_SEND_ROLE_DRESS_READ_DONE, self.OnSendRoleDressReadDone)
	self:AddListener(GAME.ISLAND_SEND_COMMANDER_DRESS_READ_DONE, self.OnSendRoleDressReadDone)
	self:AddListener(GAME.ISLAND_BUY_ROLE_SKIN_COLOR_DONE, self.OnBuyRoleSkinColorDone)
	self:AddListener(GAME.ISLAND_BUY_ROLE_DRESS_COLOR_DONE, self.OnBuyRoleDressColorDone)
	self:AddListener(GAME.ISLAND_SHOP_OP_DONE, self.GetBuySkindDone)

	return
end

function IslandShipDressUpPageNew:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_CHANGE_ROLE_DRESS_DONE, self.OnChangeRoleDressDone)
	self:RemoveListener(GAME.ISLAND_SEND_ROLE_DRESS_READ_DONE, self.OnSendRoleDressReadDone)
	self:RemoveListener(GAME.ISLAND_SEND_COMMANDER_DRESS_READ_DONE, self.OnSendRoleDressReadDone)
	self:RemoveListener(GAME.ISLAND_BUY_ROLE_SKIN_COLOR_DONE, self.OnBuyRoleSkinColorDone)
	self:RemoveListener(GAME.ISLAND_BUY_ROLE_DRESS_COLOR_DONE, self.OnBuyRoleDressColorDone)
	self:RemoveListener(GAME.ISLAND_SHOP_OP_DONE, self.GetBuySkindDone)

	return
end

function IslandShipDressUpPageNew:OnClosePage(arg_40_1)
	return
end

function IslandShipDressUpPageNew:OnInit()
	onButton(self, self.saveBtn, function()
		if not self:CheckDressIsDirty() then
			if self.changeDressType then
				pg.m02:sendNotification(GAME.ISLAND_CHEATER_CHANGE_VIEW_DRESSID, {
					type = self.changeDressType,
					game_type = PlayRoomTools.GetGameTypeID(),
					ship_id = self.shipId
				})
				pg.m02:sendNotification(GAME.PLAY_ROOM_REFRESH_ROOM_INFO)
			end

			pg.TipsMgr.GetInstance():ShowTips(i18n("island_dress_save1"))

			return
		end

		self:SaveDressUpDataHandle()

		return
	end, SFX_PANEL)
	onButton(self, self.dressUpConfireBtn, function()
		self:ShowMsgBox({
			type = IslandMsgBox.TYPE_COMMON,
			content = i18n("island_dressup_tip"),
			onYes = function()
				self:SaveDressUpDataHandle()

				return
			end,
			onNo = function()
				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.restBtn, function()
		self:ResetDressUp()

		return
	end, SFX_PANEL)

	for iter_41_0, iter_41_1 in ipairs(self.toggles) do
		onToggle(self, iter_41_1, function(arg_47_0)
			if arg_47_0 then
				self:SwitchPage(iter_41_0)
			end

			return
		end, SFX_PANEL)
	end

	onButton(self, self.sortBtn, function()
		self.sortPage:ExecuteAction("Show", self.indexData, function(arg_49_0)
			self:OnSort(arg_49_0)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self.orderBtn, function()
		self:OnOrder(1 - self.indexData.order)

		return
	end, SFX_PANEL)

	return
end

function IslandShipDressUpPageNew:OnSort(arg_51_1)
	self.indexData.sortKey = arg_51_1

	self:UpdateOrderTxt()
	self:UpdateDressUpList()

	return
end

function IslandShipDressUpPageNew:OnOrder(arg_52_1)
	self.indexData.order = arg_52_1
	self.orderBtn.localScale = Vector3(1, arg_52_1 == 1 and 1 or -1, 1)

	self:UpdateDressUpList()

	return
end

function IslandShipDressUpPageNew:UpdateOrderTxt()
	self.orderTxt.text = IslandShipDressUpPageNew.SORTCN[self.indexData.sortKey]

	return
end

function IslandShipDressUpPageNew:SwitchPage(arg_54_1)
	self.currentToggleIndex = arg_54_1

	if self.currentToggleIndex == 4 then
		setActive(self.dressTF, false)
		setActive(self.skinTF, true)
		setActive(self.hatTF, false)
		self:GetSkinList()
		self:UpdateSkinList()
		self:UpdateColorList()
	else
		self.dressType = var_0_1[self.currentToggleIndex]

		if self.SmoothFunc then
			if self.dressType == IslandShipDressHelperNew.DressType.BackDecorate then
				self.SmoothFunc(Quaternion.Euler(0, 0, 0))
			else
				self.SmoothFunc(Quaternion.Euler(0, 180, 0))
			end
		end

		setActive(self.dressTF, true)
		setActive(self.skinTF, false)
		self:GetDressUpList()
		self:UpdateDressUpList()
		self:UpdateHatDisplay()
		self:UpdateMorphDisplay()
		self:UpdateOrderTxt()
		self:UpdateColorList(true)
	end

	return
end

function IslandShipDressUpPageNew:GetDressUpList()
	self.dressList = {}

	if self.shipId == 0 then
		for iter_55_0, iter_55_1 in ipairs(self.dressUpAgency:GetHasDressByType(self.dressType)) do
			local var_55_0 = pg.island_dress_template[iter_55_1.id]

			if pg.island_dress_template[iter_55_1.id].is_hide ~= 1 then
				table.insert(self.dressList, IslandDressItem.New({
					id = iter_55_1.id,
					quality = var_55_0.quality,
					needRedDot = iter_55_1.state == 0
				}))
			end
		end
	else
		for iter_55_2, iter_55_3 in pairs(self.characterAgency:GetAllOwnDressDic()) do
			if iter_55_3:getConfigTable().type == self.dressType and iter_55_3.num > 0 and iter_55_3:getConfigTable().is_hide ~= 1 then
				table.insert(self.dressList, IslandDressItem.New({
					id = iter_55_3.id,
					ownCount = iter_55_3.num,
					needRedDot = iter_55_3.read == 0,
					quality = pg.island_dress_template[iter_55_3.id].quality
				}))
			end
		end

		for iter_55_4, iter_55_5 in pairs(self.characterAgency:GetShipHoldedDressDic()) do
			for iter_55_6, iter_55_7 in ipairs(iter_55_5) do
				if iter_55_7:getConfigTable().type == self.dressType and iter_55_7:getConfigTable().is_hide ~= 1 then
					table.insert(self.dressList, IslandDressItem.New({
						id = iter_55_7.dress_id,
						holdedShipId = iter_55_7.ship_id,
						quality = pg.island_dress_template[iter_55_7.dress_id].quality
					}))
				end
			end
		end
	end

	table.sort(self.dressList, CompareFuncs((self.indexData.sortKey == IslandShipDressUpPageNew.SORT_DEFAULT or nil) and {
		function(arg_56_0)
			return arg_56_0.holdedShipId and 0 or 1
		end,
		function(arg_57_0)
			return arg_57_0.needRedDot and 0 or 1
		end,
		function(arg_58_0)
			return -arg_58_0.quality
		end,
		function(arg_59_0)
			return -arg_59_0.id
		end
	}))

	return
end

function IslandShipDressUpPageNew:GetSkinList()
	if self.shipId ~= 0 then
		self.skinList = {}

		for iter_60_0, iter_60_1 in ipairs(pg.island_skin_template.get_id_list_by_ship_group[self.shipId] or {}) do
			if self.characterAgency:CheckSkinIsOwned(iter_60_1) then
				table.insert(self.skinList, iter_60_1)
			end
		end
	end

	return
end

function IslandShipDressUpPageNew:UpdateSkinList()
	local var_61_0 = #self.skinList

	setActive(self.skinRectTF, #self.skinList ~= 0)
	setActive(self.skinEmpty, var_61_0 == 0)
	self.skinRect:SetTotalCount(var_61_0)
	setText(self.skinEmptyTips, i18n("island_dress_no_item"))

	return
end

function IslandShipDressUpPageNew:UpdateDressUpList()
	if self.currentToggleIndex == 4 then
		return
	end

	local var_62_0 = #self.dressList

	setActive(self.dressRectTF, #self.dressList ~= 0)
	setActive(self.dressEmpty, var_62_0 == 0)
	setText(self.dressEmptyTips, i18n("island_dress_no_item"))
	setActive(self.sortBtn, false)

	if var_62_0 ~= 0 then
		self.dressRect:SetTotalCount(var_62_0)
	end

	return
end

function IslandShipDressUpPageNew:OnShow(arg_63_1, arg_63_2, arg_63_3, arg_63_4, arg_63_5)
	self.changeDressType = arg_63_5
	self.SmoothFunc = arg_63_4
	self.isFirstDressUp = arg_63_2

	setActive(self.color_listPanel, false)
	setActive(self.saveBtn, not arg_63_2)
	setActive(self.restBtn, not arg_63_2)

	self.shipDressHelper = arg_63_3
	self.island = getProxy(IslandProxy):GetIsland()
	self.characterAgency = self.island:GetCharacterAgency()
	self.dressUpAgency = self.island:GetDressUpAgency()
	self.shipId = arg_63_1
	self.indexData = {
		order = 1,
		sortKey = IslandShipDressUpPageNew.SORT_DEFAULT
	}
	self.smothObj = smothObj

	self:InitCurDressData()
	setActive(self.dressUpConfireBtn, arg_63_2)

	if arg_63_1 == 0 then
		setActive(self.toggles[4], false)
		setActive(self.toggles[5], not arg_63_2)
		setActive(self.toggles[6], not arg_63_2)
		setActive(self.toggles[7], not arg_63_2)
		triggerToggle(self.toggles[1], true)
	else
		setActive(self.toggles[4], true)
		triggerToggle(self.toggles[4], true)
	end

	if self.changeDressType then
		for iter_63_0, iter_63_1 in ipairs(pg.gameset.bar_not_display_dress_type.description) do
			for iter_63_2, iter_63_3 in pairs(var_0_1) do
				if iter_63_3 == iter_63_1 then
					setActive(self.toggles[iter_63_2], false)
				end
			end
		end
	end

	setActive(self.toggles[1], arg_63_1 == 0)
	setActive(self.toggles[2], arg_63_1 == 0)
	setActive(self.toggles[3], arg_63_1 == 0)
	self:UpdateRightReddot()

	return
end

function IslandShipDressUpPageNew:InitCurDressData()
	self.curDressTypeDataDic = {}
	self.curShipDressTypeDataDic = {}
	self.dressColorDic = {}

	if self.shipId == 0 then
		for iter_64_0, iter_64_1 in pairs((self.isFirstDressUp or nil) and (IslandShipDressHelperNew.CommanderCustom or IslandShipDressHelperNew.DressType)) do
			local var_64_0

			if self.isFirstDressUp then
				var_64_0 = IslandShipDressHelperNew.GetInitDressByType(iter_64_1) or self.dressUpAgency:GetDressByType(iter_64_1)
			end

			self.curDressTypeDataDic[iter_64_1] = var_64_0

			if var_64_0 then
				self.dressColorDic[var_64_0] = self.dressUpAgency:GetCurrentColorByDressId(var_64_0)
			end
		end
	else
		self.curSkinId = self.characterAgency:GetShipById(self.shipId):GetCurSkinId()
		self.curskinColorId = self.curSkinId == 0 and 0 or self.characterAgency:GetCurrentSkinColorByShipId(self.shipId, self.curSkinId)

		for iter_64_2, iter_64_3 in pairs(IslandShipDressHelperNew.ExtraDressType) do
			self.curShipDressTypeDataDic[iter_64_3] = IslandShipDressItem.New(self.characterAgency:GetCurDressIdByShipId(self.shipId, iter_64_3) or {})
		end
	end

	return
end

function IslandShipDressUpPageNew:CheckDressIsDirty()
	if self.shipId == 0 then
		for iter_65_0, iter_65_1 in pairs(self.curDressTypeDataDic) do
			if (self.dressUpAgency:GetDressByType(iter_65_0) or 0) ~= iter_65_1 then
				return true
			end

			if iter_65_1 ~= 0 then
				if self.dressUpAgency:GetCurrentColorByDressId(iter_65_1) ~= ((not self.dressColorDic[iter_65_1] or nil) and 0) then
					return true
				end
			end
		end

		return false
	else
		local var_65_1 = self.characterAgency:GetShipById(self.shipId):GetCurSkinId()

		if var_65_1 ~= self.curSkinId or self.characterAgency:GetCurrentSkinColorByShipId(self.shipId, var_65_1) ~= self.curskinColorId then
			return true
		end

		for iter_65_2, iter_65_3 in pairs(self.curShipDressTypeDataDic) do
			if not iter_65_3:CheckIsEqualByShipDressItem(self.characterAgency:GetCurDressIdByShipId(self.shipId, iter_65_2) or {}) then
				return true
			end
		end

		return false
	end

	return
end

function IslandShipDressUpPageNew:ResetDressUp()
	if self.shipId == 0 then
		for iter_66_0, iter_66_1 in pairs(IslandShipDressHelperNew.DressType) do
			local var_66_0 = self.dressUpAgency:GetDressByType(iter_66_1) or 0
			local var_66_1 = self.dressUpAgency:GetCurrentColorByDressId(var_66_0)

			if var_66_0 == self.curDressTypeDataDic[iter_66_1] and self.dressColorDic[self.curDressTypeDataDic[iter_66_1]] ~= var_66_1 then
				self.shipDressHelper:ChangeCommanderPartColor(iter_66_1, var_66_1)

				return
			end

			self.shipDressHelper:ChangeDressByType(iter_66_1, {
				id = var_66_0,
				colorId = var_66_1
			})

			self.curDressTypeDataDic[iter_66_1] = var_66_0
			self.dressColorDic[var_66_0] = var_66_1
		end

		self:UpdateDressUpList()
		self:UpdateHatDisplay()
		self:UpdateMorphDisplay()
	else
		local var_66_2 = self.characterAgency:GetShipById(self.shipId)

		if (function()
			local var_67_0 = var_66_2:GetCurSkinId()
			local var_67_1 = self.characterAgency:GetCurrentSkinColorByShipId(self.shipId, var_67_0)

			if var_67_0 ~= self.curSkinId or var_67_1 ~= self.curskinColorId then
				self.curSkinId = var_67_0
				self.curskinColorId = var_67_1

				return true
			end

			return false
		end)() then
			self.shipDressHelper:ChangeModelTransfromByUnitId((var_66_2:GetModelBySkinAndColorId(self.curSkinId, self.curskinColorId)))
			self:UpdateSkinList()
			self:UpdateColorList()
		end

		for iter_66_2, iter_66_3 in ipairs({
			IslandShipDressHelperNew.DressType.BackDecorate,
			IslandShipDressHelperNew.DressType.Flotage,
			IslandShipDressHelperNew.DressType.Footprint
		}) do
			local var_66_3 = self.characterAgency:GetCurDressIdByShipId(self.shipId, iter_66_3) or {}
			local var_66_5 = {
				colorId = 0
			}

			var_66_5.id = var_66_3.dress_id or 0

			self.shipDressHelper:ChangeDressByType(iter_66_3, var_66_5)

			self.curShipDressTypeDataDic[iter_66_3] = IslandShipDressItem.New(var_66_3)
		end

		self:UpdateDressUpList()
	end

	return
end

function IslandShipDressUpPageNew:CheckShipCanSave()
	local var_68_0 = true

	if not self.characterAgency:CheckSkinIsOwned(self.curSkinId) then
		self.curSkinId = self.characterAgency:GetShipById(self.shipId):GetCurSkinId()
		var_68_0 = false
	end

	if self.curSkinId ~= 0 and not self.characterAgency:CheckSkinColorIsOwned(self.curSkinId, self.curskinColorId) then
		self.curskinColorId = self.characterAgency:GetCurrentSkinColorByShipId(self.shipId, self.curSkinId)
		var_68_0 = false
	end

	return var_68_0
end

function IslandShipDressUpPageNew:SaveDressUpDataHandle(arg_69_1)
	if self.shipId == 0 then
		self:SaveDressUpData(arg_69_1)
	else
		if not self:CheckShipCanSave() then
			self.shipDressHelper:ChangeModelTransfromByUnitId((self.characterAgency:GetShipById(self.shipId):GetModelBySkinAndColorId(self.curSkinId, self.curskinColorId)))
			self:UpdateSkinList()
			self:UpdateColorList()
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_dress_save2"))
			existCall(arg_69_1)

			return
		end

		self:SaveDressUpData(arg_69_1)
	end

	return
end

function IslandShipDressUpPageNew:SaveDressUpData(arg_70_1)
	if self.shipId == 0 then
		local var_70_0, var_70_1 = (function()
			local var_71_0 = {}
			local var_71_1 = {}

			for iter_71_0, iter_71_1 in pairs(self.curDressTypeDataDic) do
				local var_71_2 = iter_71_1 ~= self.dressUpAgency:GetDressByType(iter_71_0)

				if (iter_71_0 == IslandShipDressHelperNew.DressType.Hat and iter_71_1 == 0 or nil) and true then
					table.insert(var_71_0, {
						type = iter_71_0,
						id = iter_71_1
					})
				end

				local var_71_3 = self.dressColorDic[iter_71_1] or 0

				if self.dressUpAgency:GetCurrentColorByDressId(iter_71_1) ~= var_71_3 then
					table.insert(var_71_1, {
						id = iter_71_1,
						color = var_71_3
					})
				end
			end

			return var_71_0, var_71_1
		end)()

		pg.m02:sendNotification(GAME.ISLAND_CHANGE_COMMANDER_DRESS, {
			dress_List = var_70_0,
			color_list = var_70_1,
			island_id = self.island.id
		})
		existCall(arg_70_1)
	else
		local var_70_2 = {}
		local var_70_3 = {}
		local var_70_4 = {}
		local var_70_5 = {}

		for iter_70_0, iter_70_1 in pairs(self.curShipDressTypeDataDic) do
			local var_70_6 = self.characterAgency:GetCurDressIdByShipId(self.shipId, iter_70_0) or {}

			if not iter_70_1:CheckIsEqualByShipDressItem(var_70_6) then
				if not iter_70_1.dress_id then
					table.insert(var_70_3, var_70_6.dress_id)
				elseif iter_70_1.ship_id ~= 0 then
					if var_70_6.dress_id then
						table.insert(var_70_5, var_70_6.dress_id)
					end

					table.insert(var_70_4, {
						ship_id = iter_70_1.ship_id,
						dress_id = iter_70_1.dress_id
					})
				else
					if var_70_6.dress_id then
						table.insert(var_70_3, var_70_6.dress_id)
					end

					table.insert(var_70_2, {
						ship_id = iter_70_1.ship_id,
						dress_id = iter_70_1.dress_id
					})
				end
			end
		end

		local function var_70_7()
			pg.m02:sendNotification(GAME.ISLAND_CHANGE_DRESS, {
				dress_List = var_70_2,
				unload_dress = var_70_3,
				ship_id = self.shipId,
				skin_id = self.curSkinId,
				color_id = self.curskinColorId
			})

			if self.changeDressType then
				pg.m02:sendNotification(GAME.ISLAND_CHEATER_CHANGE_VIEW_DRESSID, {
					type = self.changeDressType,
					game_type = PlayRoomTools.GetGameTypeID(),
					ship_id = self.shipId
				})
			end

			return
		end

		if #var_70_4 == 0 then
			var_70_7()
			existCall(arg_70_1)

			return
		end

		self:ShowMsgBox({
			type = IslandMsgBox.TYPE_DRESS_WEAR_CONFIRE,
			content = i18n("island_dress_replace_tip"),
			needconfirmDressList = var_70_4,
			onYes = function()
				for iter_73_0, iter_73_1 in ipairs(var_70_4) do
					table.insert(var_70_2, iter_73_1)
				end

				for iter_73_2, iter_73_3 in ipairs(var_70_5) do
					table.insert(var_70_3, iter_73_3)
				end

				var_70_7()
				existCall(arg_70_1)

				return
			end,
			onNo = function()
				existCall(arg_70_1)

				return
			end
		})
	end

	return
end

function IslandShipDressUpPageNew:CheckInReturn(arg_75_1)
	if self.morphing then
		return
	end

	if not self:CheckDressIsDirty() then
		existCall(arg_75_1)

		return
	end

	if not self:CheckShipCanSave() then
		existCall(arg_75_1)
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_dress_exit2"))

		return
	end

	self:ShowMsgBox({
		type = IslandMsgBox.TYPE_COMMON,
		content = i18n("island_dressup_tip_1"),
		onYes = function()
			self:SaveDressUpDataHandle(arg_75_1)

			return
		end,
		onNo = function()
			existCall(arg_75_1)

			return
		end
	})

	return
end

function IslandShipDressUpPageNew:OnChangeRoleDressDone()
	for iter_78_0, iter_78_1 in pairs(self.curShipDressTypeDataDic) do
		self.curShipDressTypeDataDic[iter_78_0] = IslandShipDressItem.New(self.characterAgency:GetCurDressIdByShipId(self.shipId, iter_78_0) or {})
	end

	self:GetDressUpList()
	self:UpdateDressUpList()

	return
end

function IslandShipDressUpPageNew:OnSendRoleDressReadDone(arg_79_1)
	for iter_79_0, iter_79_1 in ipairs(arg_79_1) do
		for iter_79_2, iter_79_3 in ipairs(self.dressList) do
			if iter_79_3.id == iter_79_1 and iter_79_3.needRedDot then
				iter_79_3.needRedDot = false
			end
		end
	end

	self:UpdateDressUpList()
	self:UpdateRightReddot()

	return
end

function IslandShipDressUpPageNew:OnBuyRoleSkinColorDone()
	self:UpdateColorList()

	return
end

function IslandShipDressUpPageNew:OnBuyRoleDressColorDone()
	self:UpdateColorList(true)

	return
end

function IslandShipDressUpPageNew:GetBuySkindDone()
	self:UpdateSkinList()

	return
end

function IslandShipDressUpPageNew:UpdateRightReddot()
	for iter_83_0, iter_83_1 in ipairs(self.shipId == 0 and {
		1,
		2,
		3,
		5,
		6,
		7
	} or {
		5,
		6,
		7
	}) do
		setActive(self.toggles[iter_83_1]:Find("red_dot"), self.shipId == 0 and self.dressUpAgency:CheckRedDotByDressType(var_0_1[iter_83_1]) or self.characterAgency:CheckRedDotByDressType(var_0_1[iter_83_1]))
	end

	return
end

function IslandShipDressUpPageNew:UpdateColorPanel()
	if not (function()
		if self.isDressColor then
			if not self.curDressTypeDataDic[self.dressType] or self.curDressTypeDataDic[self.dressType] == 0 then
				return false
			end

			return #(pg.island_dress_colordiff_template.get_id_list_by_belongto_dress[self.curDressTypeDataDic[self.dressType]] or {}) > 0
		end

		if self.curSkinId ~= 0 then
			if not (self.curSkinId or nil) then
				return false
			end
		end

		return true
	end)() then
		setActive(self.color_listPanel, false)

		return
	end

	setActive(self.color_listPanel, true)

	return
end

function IslandShipDressUpPageNew:UpdateColorUnlockState()
	local var_86_0
	local var_86_1
	local var_86_2

	if self.isDressColor then
		var_86_2 = self.curDressTypeDataDic[self.dressType]

		if not self.curDressTypeDataDic[self.dressType] or var_86_2 == 0 then
			return true
		end

		var_86_1 = self.dressColorDic[var_86_2] or 0
		var_86_0 = pg.island_dress_colordiff_template[var_86_1]
	else
		var_86_0 = pg.island_skin_colordiff_template[self.curskinColorId]
	end

	local var_86_3, var_86_4 = (function()
		if self.isDressColor then
			if self.shipId == 0 then
				if self.dressUpAgency:CheckDressColorIsOwned(var_86_2, var_86_1) then
					return true
				end
			else
				return true
			end

			return false, true
		else
			if not self.curskinColorId or self.curskinColorId == 0 then
				return true
			end

			if self.characterAgency:CheckSkinColorIsOwned(self.curSkinId, self.curskinColorId) then
				return true
			end

			return false, (self.characterAgency:CheckSkinIsOwned(self.curSkinId))
		end

		return
	end)()

	if var_86_3 then
		setActive(self.color_bg_unlock, true)
		setActive(self.color_bg_locked, false)
	else
		setActive(self.color_bg_unlock, false)
		setActive(self.color_bg_locked, true)
		GetImageSpriteFromAtlasAsync("island/" .. pg.island_item_data_template[var_86_0.cost[1][1]].icon, "", self.color_cost_item_icon)
		setText(self.color_cost_item_count, "×" .. var_86_0.cost[1][2])
		setActive(self.color_lockedBtn, var_86_4)
	end

	onButton(self, self.color_lockedBtn, function()
		local function var_88_0()
			if self.isDressColor then
				pg.m02:sendNotification(GAME.ISLAND_BUY_ROLE_DRESS_COLOR, {
					id = self.shipId,
					dress_id = var_86_2,
					color_id = var_86_1
				})
			else
				pg.m02:sendNotification(GAME.ISLAND_BUY_ROLE_SKIN_COLOR, {
					ship_id = self.shipId,
					skin_id = self.curSkinId,
					color_id = self.curskinColorId
				})
			end

			return
		end

		self:ShowMsgBox({
			type = IslandMsgBox.TYPE_COMMON,
			content = i18n("island_dress_color_buy", pg.island_item_data_template[var_86_0.cost[1][1]].name .. "x" .. var_86_0.cost[1][2]),
			onYes = function()
				if not (function(arg_91_0)
					local var_91_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

					for iter_91_0, iter_91_1 in ipairs(arg_91_0) do
						if iter_91_1[2] > var_91_0:GetOwnCount(iter_91_1[1]) then
							return false
						end
					end

					return true
				end)(var_86_0.cost) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

					return
				end

				var_88_0()

				return
			end,
			onNo = function()
				return
			end
		})

		return
	end)

	return
end

function IslandShipDressUpPageNew:UpdateColorItemList()
	(function()
		self.colorItemList = {}

		if self.isDressColor then
			local var_94_0 = self.curDressTypeDataDic[self.dressType]
			local var_94_1 = self.dressColorDic[self.curDressTypeDataDic[self.dressType]]
			local var_94_2 = pg.island_dress_colordiff_template.get_id_list_by_belongto_dress[self.curDressTypeDataDic[self.dressType]] or {}

			if #var_94_2 > 0 then
				local var_94_3 = {
					itemId = 0,
					selected = var_94_1 == 0
				}

				var_94_3.owned = true

				table.insert(self.colorItemList, var_94_3)

				for iter_94_0, iter_94_1 in ipairs(var_94_2) do
					table.insert(self.colorItemList, {
						itemId = iter_94_1,
						selected = var_94_1 == iter_94_1,
						owned = self.dressUpAgency:CheckDressColorIsOwned(var_94_0, iter_94_1),
						costItemIcon = pg.island_dress_colordiff_template[iter_94_1].color_icon
					})
				end
			end
		else
			local var_94_4 = pg.island_skin_colordiff_template.get_id_list_by_skin_group[self.curSkinId]
			local var_94_5

			if not pg.island_skin_colordiff_template.get_id_list_by_skin_group[self.curSkinId] then
				var_94_4 = {}
				var_94_5 = {
					itemId = 0
				}
			end

			var_94_5.selected = self.curskinColorId == 0
			var_94_5.owned = self.characterAgency:CheckSkinIsOwned(self.curSkinId)

			table.insert(self.colorItemList, var_94_5)

			for iter_94_2, iter_94_3 in ipairs(var_94_4) do
				table.insert(self.colorItemList, {
					itemId = iter_94_3,
					selected = self.curskinColorId == iter_94_3,
					owned = self.characterAgency:CheckSkinColorIsOwned(self.curSkinId, iter_94_3),
					costItemIcon = pg.island_skin_colordiff_template[iter_94_3].color_icon
				})
			end
		end

		return
	end)()
	self.colorItemUIList:make(function(arg_95_0, arg_95_1, arg_95_2)
		if arg_95_0 == UIItemList.EventUpdate then
			arg_95_1 = arg_95_1 + 1

			local var_95_0 = self.colorItemList[arg_95_1]

			setActive(arg_95_2:Find("select"), self.colorItemList[arg_95_1].selected)

			local var_95_1 = var_95_0.itemId

			setActive(arg_95_2:Find("orginName"), var_95_0.itemId == 0)
			setActive(arg_95_2:Find("locked"), var_95_1 == 0)
			setActive(arg_95_2:Find("icon"), false)

			if var_95_0.costItemIcon then
				setActive(arg_95_2:Find("icon"), true)
				GetImageSpriteFromAtlasAsync("island/IslandDressIcon/" .. var_95_0.costItemIcon, "", arg_95_2:Find("icon"))
			end

			setActive(arg_95_2:Find("locked"), not var_95_0.owned)
			onButton(self, arg_95_2, function()
				if self.isDressColor then
					if var_95_1 == self.dressColorDic[self.curDressTypeDataDic[self.dressType]] then
						return
					end

					self.dressColorDic[self.curDressTypeDataDic[self.dressType]] = var_95_1

					self.shipDressHelper:ChangeCommanderPartColor(self.dressType, var_95_1)
				else
					if var_95_1 == self.curskinColorId then
						return
					end

					self.curskinColorId = var_95_1

					self:ChangeModelBySkinAndSkinColor()
				end

				self:UpdateColorList(self.isDressColor)

				return
			end)
		end

		return
	end)
	self.colorItemUIList:align(#self.colorItemList)

	return
end

function IslandShipDressUpPageNew:UpdateColorList(arg_97_1)
	self.isDressColor = arg_97_1

	self:UpdateColorPanel()
	self:UpdateColorUnlockState()
	self:UpdateColorItemList()

	return
end

function IslandShipDressUpPageNew:OnHide()
	return
end

function IslandShipDressUpPageNew:OnDestroy()
	if self.shipDressHelper then
		self.shipDressHelper:StopMorphSwitch()
	end

	self:SetMorphBlock(false)
	ClearLScrollrect(self.dressRect)
	ClearLScrollrect(self.skinRect)

	for iter_99_0, iter_99_1 in pairs(self.dressCards or {}) do
		iter_99_1:Dispose()
	end

	self.dressCards = nil

	for iter_99_2, iter_99_3 in pairs(self.skinCards or {}) do
		iter_99_3:Dispose()
	end

	self.skinCards = nil

	if self.dressDetailPopup then
		self.dressDetailPopup:Destroy()

		self.dressDetailPopup = nil
	end

	return
end

return IslandShipDressUpPageNew
