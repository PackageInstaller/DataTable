local SwitchSkinLayer = class("SwitchSkinLayer", import("..base.BaseUI"))

function SwitchSkinLayer:setShip(arg_1_1)
	self.shipVO = arg_1_1

	return
end

function SwitchSkinLayer:GetShareSkins()
	return (_.map(getProxy(ShipSkinProxy):GetShareSkinsForShip(self.shipVO), function(arg_3_0)
		return pg.ship_skin_template[arg_3_0.id]
	end))
end

function SwitchSkinLayer:setSkinList(arg_4_1)
	self.skinList = arg_4_1
	self.skins = self:getGroupSkinList(self.shipVO.groupId)
	self.shareSkins = self:GetShareSkins()

	return
end

function SwitchSkinLayer:getUIName()
	return "SwitchSkinLayer"
end

function SwitchSkinLayer:back()
	self:emit(SwitchSkinLayer.ON_CLOSE)

	return
end

function SwitchSkinLayer:init()
	self.shareBtn = self._tf:Find("select_skin/share_btn")

	self:BlurPanel(self._tf)

	return
end

function SwitchSkinLayer:didEnter()
	self:initSelectSkinPanel()
	triggerToggle(self.shareBtn, false)
	setActive(self.shareBtn, #self.shareSkins > 0)
	setText(findTF(self._tf, "select_skin/title/Text"), i18n("dorm3d_clothing_choose"))

	return
end

function SwitchSkinLayer:initSelectSkinPanel()
	self.skinPanel = self._tf

	onButton(self, self.skinPanel:Find("select_skin/btnBack"), function()
		self:back()

		return
	end)
	onButton(self, self.skinPanel:Find("print"), function()
		self:back()

		return
	end)
	onToggle(self, self.shareBtn, function(arg_12_0)
		if arg_12_0 then
			self:Flush(self.shareSkins)
		else
			self:Flush(self.skins)
		end

		self.shareOn = arg_12_0

		return
	end, SFX_PANEL)

	self.skinScroll = self.skinPanel:Find("select_skin/style_scroll")
	self.skinContainer = self.skinScroll:Find("view_port")
	self.skinCard = self.skinContainer:GetChild(0)

	setActive(self.skinCard, false)

	self.skinCardMap = {}

	return
end

function SwitchSkinLayer:openSelectSkinPanel()
	if self.shareOn then
		self:Flush(self.shareSkins)
	else
		self:Flush(self.skins)
	end

	return
end

function SwitchSkinLayer:Flush(arg_14_1)
	for iter_14_0 = self.skinContainer.childCount, #arg_14_1 - 1 do
		cloneTplTo(self.skinCard, self.skinContainer)
	end

	for iter_14_1 = #arg_14_1, self.skinContainer.childCount - 1 do
		setActive(self.skinContainer:GetChild(iter_14_1), false)
	end

	local var_14_0 = getProxy(ShipSkinProxy)

	for iter_14_2, iter_14_3 in ipairs(arg_14_1) do
		local var_14_2 = self.skinContainer:GetChild(iter_14_2 - 1)
		local var_14_3 = self.skinCardMap[var_14_2]

		if not self.skinCardMap[var_14_2] then
			var_14_3 = ShipSkinCard.New(var_14_2.gameObject)
			self.skinCardMap[var_14_2] = var_14_3
		end

		var_14_3:updateData(self.shipVO, iter_14_3, self.shipVO:proposeSkinOwned(iter_14_3) or table.contains(self.skinList, iter_14_3.id) or self.shipVO:getRemouldSkinId() == iter_14_3.id and self.shipVO:isRemoulded() or iter_14_3.skin_type == ShipSkin.SKIN_TYPE_OLD or var_14_0:hasSkin(iter_14_3.id))

		local var_14_4 = self.shipVO:useSkin(iter_14_3.id)

		var_14_3:updateUsing(var_14_4)
		removeOnButton(var_14_2)

		local var_14_5 = (self.shipVO:proposeSkinOwned(iter_14_3) or table.contains(self.skinList, iter_14_3.id) or self.shipVO:getRemouldSkinId() == iter_14_3.id and self.shipVO:isRemoulded()) and 1 or 0

		if iter_14_3.shop_id > 0 then
			local var_14_6 = pg.shop_template[iter_14_3.shop_id] or nil

			if var_14_6 then
				::label_14_0::

				local var_14_7 = not pg.TimeMgr.GetInstance():inTime(var_14_6.time)
			end
		end

		local var_14_8 = iter_14_3.id == self.shipVO:getSkinId()
		local var_14_9 = iter_14_3.id == self.shipVO:getConfig("skin_id") or var_14_5 >= 1 or iter_14_3.skin_type == ShipSkin.SKIN_TYPE_OLD or var_14_0:hasSkin(iter_14_3.id)
		local var_14_10 = getProxy(ShipSkinProxy):InForbiddenSkinListAndShow(iter_14_3.id)

		onToggle(self, var_14_3.hideObjToggleTF, function(arg_15_0)
			PlayerPrefs.SetInt("paint_hide_other_obj_" .. var_14_3.paintingName, arg_15_0 and 1 or 0)
			var_14_3:flushSkin()
			self:emit(SwitchSkinMediator.UPDATE_SKINCONFIG, self.shipVO:getSkinId())

			return
		end, SFX_PANEL)
		onButton(self, var_14_3.changeSkinTF, function(arg_16_0)
			local var_16_0 = ShipSkin.GetChangeSkinNextId(iter_14_3.id)

			ShipSkin.SetStoreChangeSkinId(var_16_0, self.shipVO:GetShipPhantomMark())

			if var_14_4 then
				self:emit(SwitchSkinMediator.CHANGE_SKIN, self.shipVO:GetShipPhantomMark(), var_16_0)
				pg.m02:sendNotification(GAME.CHANGE_SKIN_UPDATE, self.shipVO:GetShipPhantomMark())
			end

			return
		end, SFX_PANEL)
		onButton(self, var_14_2, function()
			if var_14_8 then
				self:back()
			elseif ShipSkin.IsShareSkin(self.shipVO, iter_14_3.id) and not ShipSkin.CanUseShareSkinForShip(self.shipVO, iter_14_3.id) then
				-- block empty
			elseif var_14_9 then
				self:emit(SwitchSkinMediator.CHANGE_SKIN, self.shipVO:GetShipPhantomMark(), iter_14_3.id == self.shipVO:getConfig("skin_id") and 0 or iter_14_3.id)
				self:back()
			elseif var_14_6 then
				if var_14_7 or var_14_10 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_skin_out_of_stock"))
				else
					local var_17_0 = Goods.Create({
						shop_id = var_14_6.id
					}, Goods.TYPE_SKIN)

					if var_17_0:isDisCount() and var_17_0:IsItemDiscountType() then
						self:emit(SwitchSkinMediator.BUY_ITEM_BY_ACT, var_14_6.id, 1)
					else
						local var_17_1 = {}

						var_17_1.content = i18n("text_buy_fashion_tip", var_17_0:GetPrice(), iter_14_3.name)

						function var_17_1.onYes()
							self:emit(SwitchSkinMediator.BUY_ITEM, var_14_6.id, 1)

							return
						end

						pg.MsgboxMgr.GetInstance():ShowMsgBox(var_17_1)
					end
				end
			end

			return
		end)
		setActive(var_14_2, true)
	end

	return
end

function SwitchSkinLayer:getGroupSkinList(arg_19_1)
	return getProxy(ShipSkinProxy):GetAllSkinForShip(self.shipVO)
end

function SwitchSkinLayer:willExit()
	for iter_20_0, iter_20_1 in pairs(self.skinCardMap) do
		iter_20_1:clear()
	end

	self:UnOverlayPanel(self._tf)

	return
end

return SwitchSkinLayer
