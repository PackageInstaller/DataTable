local ShipFashionView = class("ShipFashionView", import("...base.BaseSubView"))

function ShipFashionView:getUIName()
	return "ShipFashionView"
end

function ShipFashionView:OnInit()
	self:InitFashion()

	return
end

function ShipFashionView:InitFashion()
	self.mainPanel = self._parentTf.parent
	self.stylePanel = self._tf
	self.styleScroll = self.stylePanel:Find("style_scroll")
	self.styleContainer = self.styleScroll:Find("view_port")
	self.styleCard = self.styleContainer:GetChild(0)
	self.hideObjToggleTF = findTF(self._tf, "btns/hideObjToggle")

	setActive(self.hideObjToggleTF, false)

	self.hideObjToggle = GetComponent(self.hideObjToggleTF, typeof(Toggle))

	setText(findTF(self.hideObjToggleTF, "Label"), i18n("paint_hide_other_obj_tip"))

	self.shareBtn = findTF(self._tf, "share_btn")
	self.phantomBtn = self._tf:Find("phantom_btn")

	onButton(self, self.phantomBtn, function()
		local var_4_0 = getProxy(TechnologyProxy):getBluePrintById(self:GetShipVO().groupId)

		self:emit(ShipMainMediator.OPEN_PHANTOM_LAYER, var_4_0 and var_4_0:getConfig("blueprint_version") or nil)

		return
	end, SFX_PANEL)
	setParent(self.phantomBtn, self._tf.parent)
	setActive(self.stylePanel, true)
	setActive(self.styleCard, false)

	self.fashionSkins = {}
	self.fashionCellMap = {}
	self.fashionGroup = 0
	self.fashionSkinId = 0
	self.onSelected = false
	self.isShareSkinFlag = false

	self:RegisterShareToggle()
	self:bind(ShipMainMediator.ON_NEXTSHIP_PREPARE, function(arg_5_0, arg_5_1)
		self._lastSelectCard = nil

		if self.isShareSkinFlag and arg_5_1 and #self:GetShareSkins(arg_5_1) <= 0 then
			self.isShareSkinFlag = false
		end

		return
	end)

	return
end

function ShipFashionView:SetShareData(arg_6_1)
	self.shareData = arg_6_1

	return
end

function ShipFashionView:GetShipVO()
	if self.shareData and self.shareData.shipVO then
		return self.shareData.shipVO
	end

	return nil
end

function ShipFashionView:SetSkinList(arg_8_1)
	self.skinList = arg_8_1

	return
end

function ShipFashionView:UpdateUI()
	triggerToggle(self.shareBtn, self.isShareSkinFlag)
	setActive(self.shareBtn, #self:GetShareSkins(self:GetShipVO()) > 0)
	setActive(self.phantomBtn, self:GetShipVO():isBluePrintShip())

	return
end

function ShipFashionView:OnSelected(arg_10_1)
	if arg_10_1 then
		self:OverlayPanel(self._parentTf, {
			pbList = {
				self.stylePanel:Find("style_desc"),
				self.stylePanel:Find("frame")
			},
			overlayType = LayerWeightConst.OVERLAY_UI_ADAPT
		})
	else
		self:UnOverlayPanel(self._parentTf, self.mainPanel)
	end

	self.onSelected = arg_10_1

	return
end

function ShipFashionView:GetShareSkins(arg_11_1)
	return (_.map(getProxy(ShipSkinProxy):GetShareSkinsForShip(arg_11_1), function(arg_12_0)
		return pg.ship_skin_template[arg_12_0.id]
	end))
end

function ShipFashionView:UpdateAllFashion(arg_13_1)
	local var_13_0 = self:GetShipVO()
	local var_13_1 = var_13_0.groupId

	if self.isShareSkinFlag then
		self.fashionSkins = self:GetShareSkins(var_13_0) or self.shareData:GetGroupSkinList(var_13_1)
	end

	if self.fashionGroup ~= var_13_1 or arg_13_1 then
		self.fashionGroup = var_13_1

		self:ResetFashion()

		for iter_13_0 = self.styleContainer.childCount, #self.fashionSkins - 1 do
			cloneTplTo(self.styleCard, self.styleContainer)
		end

		for iter_13_1 = #self.fashionSkins, self.styleContainer.childCount - 1 do
			local var_13_2 = self.styleContainer:GetChild(iter_13_1)

			if self.fashionCellMap[var_13_2] then
				self.fashionCellMap[var_13_2]:clear()
			end

			setActive(var_13_2, false)
		end

		for iter_13_2, iter_13_3 in ipairs(self.fashionSkins) do
			local var_13_3 = iter_13_2
			local var_13_4 = self.fashionSkins[iter_13_2]
			local var_13_5 = self.styleContainer:GetChild(iter_13_2 - 1)
			local var_13_6 = self.fashionCellMap[var_13_5]

			if not self.fashionCellMap[var_13_5] then
				var_13_6 = ShipSkinCard.New(var_13_5.gameObject)
				self.fashionCellMap[var_13_5] = var_13_6
			end

			local var_13_7 = self:GetShipVO():getRemouldSkinId() == var_13_4.id and self:GetShipVO():isRemoulded()
			local var_13_8 = self:GetShipVO():proposeSkinOwned(var_13_4)

			if not var_13_8 then
				var_13_8 = table.contains(self.skinList, var_13_4.id)
				var_13_8 = var_13_8 or var_13_7 or var_13_4.skin_type == ShipSkin.SKIN_TYPE_OLD or getProxy(ShipSkinProxy):hasSkin(var_13_4.id)
			end

			var_13_6:updateData(self:GetShipVO(), var_13_4, var_13_8)

			local var_13_9 = self:GetShipVO():useSkin(var_13_4.id)

			var_13_6:updateUsing(var_13_9)
			onButton(self, var_13_6.changeSkinTF, function(arg_14_0)
				if var_13_9 then
					ShipSkin.SetStoreChangeSkinId(ShipSkin.GetChangeSkinNextId(var_13_4.id), var_13_0:GetShipPhantomMark())
					pg.m02:sendNotification(GAME.CHANGE_SKIN_UPDATE, self:GetShipVO():GetShipPhantomMark())
				end

				return
			end, SFX_PANEL)
			onButton(self, var_13_5, function()
				self:clickCell(var_13_6, var_13_4)

				self._lastSelectCard = var_13_3

				return
			end)
			setActive(var_13_5, true)
		end
	else
		for iter_13_4, iter_13_5 in ipairs(self.fashionSkins) do
			local var_13_10 = self.fashionCellMap[self.styleContainer:GetChild(iter_13_4 - 1)]
			local var_13_11 = self:GetShipVO():getRemouldSkinId() == iter_13_5.id and self:GetShipVO():isRemoulded()
			local var_13_12 = self:GetShipVO():proposeSkinOwned(iter_13_5)

			if not var_13_12 then
				var_13_12 = table.contains(self.skinList, iter_13_5.id)
				var_13_12 = var_13_12 or var_13_11 or iter_13_5.skin_type == ShipSkin.SKIN_TYPE_OLD or getProxy(ShipSkinProxy):hasSkin(iter_13_5.id)
			end

			var_13_10:updateData(self:GetShipVO(), iter_13_5, var_13_12)
		end
	end

	self.fashionSkinId = self:GetShipVO():getSkinId()

	local var_13_13 = self.styleContainer:GetChild(0)

	for iter_13_6, iter_13_7 in ipairs(self.fashionSkins) do
		if iter_13_7.id == self.fashionSkinId then
			var_13_13 = self.styleContainer:GetChild(iter_13_6 - 1)

			break
		end
	end

	if self._lastSelectCard then
		var_13_13 = self.styleContainer:GetChild(self._lastSelectCard - 1)
		self._lastSelectCard = nil
	end

	triggerButton(var_13_13)

	return
end

function ShipFashionView:clickCell(arg_16_1, arg_16_2)
	if ShipViewConst.currentPage ~= ShipViewConst.PAGE.FASHION then
		return
	end

	self.clickCellTime = Time.realtimeSinceStartup
	self.fashionSkinId = arg_16_2.id

	self:UpdateFashionDetail(arg_16_2)
	self:emit(ShipViewConst.LOAD_PAINTING, arg_16_2.painting)
	self:emit(ShipViewConst.LOAD_PAINTING_BG, self:GetShipVO():rarity2bgPrintForGet(), self:GetShipVO():isBluePrintShip(), self:GetShipVO():isMetaShip())

	for iter_16_0, iter_16_1 in ipairs(self.fashionSkins) do
		local var_16_0 = self.fashionCellMap[self.styleContainer:GetChild(iter_16_0 - 1)]

		var_16_0:updateSelected(iter_16_1.id == self.fashionSkinId)
		var_16_0:updateUsing(self:GetShipVO():useSkin(iter_16_1.id))
	end

	local var_16_1 = arg_16_2.painting
	local var_16_2 = checkABExist("painting/" .. arg_16_2.painting .. "_n")

	setActive(self.hideObjToggle, var_16_2)

	if var_16_2 then
		self.hideObjToggle.isOn = PlayerPrefs.GetInt("paint_hide_other_obj_" .. var_16_1, 0) ~= 0

		onToggle(self, self.hideObjToggleTF, function(arg_17_0)
			PlayerPrefs.SetInt("paint_hide_other_obj_" .. var_16_1, arg_17_0 and 1 or 0)
			arg_16_1:flushSkin()
			self:emit(ShipViewConst.LOAD_PAINTING, var_16_1, true)

			return
		end, SFX_PANEL)
	end

	return
end

function ShipFashionView:UpdateFashion(arg_18_1)
	if ShipViewConst.currentPage ~= ShipViewConst.PAGE.FASHION or not self.shareData:HasFashion() then
		return
	end

	self:UpdateAllFashion(arg_18_1)

	return
end

function ShipFashionView:ResetFashion()
	self.fashionSkinId = 0

	return
end

function ShipFashionView:UpdateFashionDetail(arg_20_1)
	local var_20_0 = self.fashionDetailWrapper

	if not self.fashionDetailWrapper then
		var_20_0 = {
			name = findTF(self.stylePanel, "style_desc/name_bg/name"),
			descTxt = findTF(self.stylePanel, "style_desc/desc_frame/desc/Text"),
			character = findTF(self.stylePanel, "style_desc/character"),
			confirm = findTF(self.stylePanel, "confirm_button"),
			cancel = findTF(self.stylePanel, "cancel_button")
		}
		var_20_0.diamond = findTF(var_20_0.confirm, "diamond")
		var_20_0.using = findTF(var_20_0.confirm, "using")
		var_20_0.experience = findTF(var_20_0.confirm, "experience")
		var_20_0.change = findTF(var_20_0.confirm, "change")
		var_20_0.buy = findTF(var_20_0.confirm, "buy")
		var_20_0.activity = findTF(var_20_0.confirm, "activity")
		var_20_0.cantbuy = findTF(var_20_0.confirm, "cantbuy")
		var_20_0.prefab = "unknown"
		self.fashionDetailWrapper = var_20_0
	end

	setText(var_20_0.name, arg_20_1.name)
	setText(var_20_0.descTxt, SwitchSpecialChar(arg_20_1.desc, true))

	local var_20_1 = var_20_0.descTxt:GetComponent(typeof(Text))

	var_20_1.alignment = #var_20_1.text > 50 and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

	if var_20_0.prefab ~= arg_20_1.prefab then
		local var_20_2 = var_20_0.character:Find(var_20_0.prefab)

		if not IsNil(var_20_2) then
			PoolMgr.GetInstance():ReturnSpineChar(var_20_0.prefab, var_20_2.gameObject)
		end

		var_20_0.prefab = arg_20_1.prefab

		local var_20_3 = var_20_0.prefab

		self.spineChar = SpineAnimChar.New()

		self.spineChar:SetPaint(var_20_0.prefab)
		self.spineChar:Load(true, function(arg_21_0)
			if var_20_0.prefab ~= var_20_3 then
				arg_21_0:Dispose()
			else
				arg_21_0:SetName(var_20_3)
				arg_21_0:SetLocalPosition(Vector3.zero)
				arg_21_0:SetLocalScale(Vector3(0.5, 0.5, 1))
				arg_21_0:SetParent(var_20_0.character)
				arg_21_0:SetAction(arg_20_1.show_skin or "stand", 0)
			end

			return
		end)
	end

	local var_20_5 = (self:GetShipVO():proposeSkinOwned(arg_20_1) or table.contains(self.skinList, arg_20_1.id) or self:GetShipVO():getRemouldSkinId() == arg_20_1.id and self:GetShipVO():isRemoulded()) and 1 or 0
	local var_20_6

	if arg_20_1.shop_id > 0 then
		var_20_6 = pg.shop_template[arg_20_1.shop_id] or nil

		local var_20_7

		if var_20_6 then
			::label_20_0::

			var_20_7 = not pg.TimeMgr.GetInstance():inTime(var_20_6.time)
		end
	end

	local var_20_8 = arg_20_1.id == self:GetShipVO():getSkinId()
	local var_20_9 = arg_20_1.id == self:GetShipVO():getConfig("skin_id") or var_20_5 >= 1 or arg_20_1.skin_type == ShipSkin.SKIN_TYPE_OLD or getProxy(ShipSkinProxy):hasSkin(arg_20_1.id)
	local var_20_10 = getProxy(ShipSkinProxy):getSkinById(arg_20_1.id)
	local var_20_11 = getProxy(ShipSkinProxy):InForbiddenSkinListAndShow(arg_20_1.id)
	local var_20_12 = var_20_8 and var_20_10 and var_20_10:isExpireType()

	setActive(var_20_0.using, false)
	setActive(var_20_0.change, false)
	setActive(var_20_0.buy, false)
	setActive(var_20_0.experience, false)

	if var_20_12 then
		setGray(var_20_0.confirm, false)
		setActive(var_20_0.experience, true)
	elseif var_20_8 then
		setGray(var_20_0.confirm, false)
		setActive(var_20_0.using, true)
	elseif var_20_9 and ShipSkin.IsShareSkin(self:GetShipVO(), arg_20_1.id) and not ShipSkin.CanUseShareSkinForShip(self:GetShipVO(), arg_20_1.id) then
		setActive(var_20_0.change, true)
		setGray(var_20_0.confirm, true)
	elseif var_20_9 then
		setActive(var_20_0.change, true)
		setGray(var_20_0.confirm, false)
	elseif var_20_6 then
		setActive(var_20_0.buy, true)
		setGray(var_20_0.confirm, var_20_7 or var_20_11)
	else
		setActive(var_20_0.change, true)
		setGray(var_20_0.confirm, true)
	end

	onButton(self, var_20_0.confirm, function()
		if var_20_8 then
			if ShipSkin.IsChangeSkin(arg_20_1.id) then
				if self.clickCellTime and Time.realtimeSinceStartup - self.clickCellTime <= 0.35 then
					return
				end

				self:SilentTriggerToggleFalse()
				self:emit(ShipViewConst.SWITCH_TO_PAGE, ShipViewConst.PAGE.DETAIL)
			end
		elseif var_20_9 then
			if ShipSkin.IsShareSkin(self:GetShipVO(), arg_20_1.id) and not ShipSkin.CanUseShareSkinForShip(self:GetShipVO(), arg_20_1.id) then
				-- block empty
			else
				self:emit(ShipMainMediator.CHANGE_SKIN, self:GetShipVO().id, arg_20_1.id == self:GetShipVO():getConfig("skin_id") and 0 or arg_20_1.id)
			end
		elseif var_20_6 then
			if var_20_7 or var_20_11 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_skin_out_of_stock"))
			else
				local var_22_0 = Goods.Create({
					shop_id = var_20_6.id
				}, Goods.TYPE_SKIN)

				if var_22_0:isDisCount() and var_22_0:IsItemDiscountType() then
					self:emit(ShipMainMediator.BUY_ITEM_BY_ACT, var_20_6.id, 1)
				else
					local var_22_1 = {}

					var_22_1.content = i18n("text_buy_fashion_tip", var_22_0:GetPrice(), arg_20_1.name)

					function var_22_1.onYes()
						self:emit(ShipMainMediator.BUY_ITEM, var_20_6.id, 1)

						return
					end

					pg.MsgboxMgr.GetInstance():ShowMsgBox(var_22_1)
				end
			end
		end

		return
	end)
	onButton(self, var_20_0.cancel, function()
		if self.clickCellTime and Time.realtimeSinceStartup - self.clickCellTime <= 0.35 then
			return
		end

		self:SilentTriggerToggleFalse()
		self:emit(ShipViewConst.SWITCH_TO_PAGE, ShipViewConst.PAGE.DETAIL)

		return
	end)

	return
end

function ShipFashionView:SilentTriggerToggleFalse()
	self.fashionGroup = false
	self.isShareSkinFlag = false

	removeOnToggle(self.shareBtn)
	triggerToggle(self.shareBtn, false)
	self:RegisterShareToggle()

	return
end

function ShipFashionView:RegisterShareToggle()
	onToggle(self, self.shareBtn, function(arg_27_0)
		self.fashionGroup = false
		self.isShareSkinFlag = arg_27_0

		self:UpdateFashion()

		return
	end, SFX_PANEL)

	return
end

function ShipFashionView:OnDestroy()
	setParent(self.phantomBtn, self._tf)

	if self.fashionDetailWrapper and self.fashionDetailWrapper.character:Find(self.fashionDetailWrapper.prefab) and self.spineChar then
		self.spineChar:Dispose()

		self.spineChar = nil
	end

	self.fashionDetailWrapper = nil

	for iter_28_0, iter_28_1 in pairs(self.fashionCellMap) do
		iter_28_1:clear()
	end

	self.fashionCellMap = {}
	self.fashionSkins = {}
	self.fashionGroup = 0
	self.fashionSkinId = 0
	self.shareData = nil

	return
end

return ShipFashionView
