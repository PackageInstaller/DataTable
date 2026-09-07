local Dorm3dSkinSelectLayer = class("Dorm3dSkinSelectLayer", import("view.base.BaseUI"))

function Dorm3dSkinSelectLayer:getUIName()
	return "Dorm3dSkinSelectLayer"
end

function Dorm3dSkinSelectLayer:init()
	self.btnChange = self._tf:Find("BG/bottom/btn_change")
	self.btnBuy = self._tf:Find("BG/bottom/btn_buy")
	self.priceText = self._tf:Find("BG/bottom/btn_buy/Price")
	self.line = self._tf:Find("BG/bottom/Line")
	self.desc = self._tf:Find("BG/bottom/desc")
	self.loader = AutoLoader.New()

	return
end

function Dorm3dSkinSelectLayer:SetApartment(arg_3_1)
	self.apartment = arg_3_1

	return
end

function Dorm3dSkinSelectLayer:didEnter()
	setText(self._tf:Find("BG/Scroll/Content/Unlock/Title/Text"), i18n("word_unlock"))
	setText(self._tf:Find("BG/Scroll/Content/Lock/Title/Text"), i18n("word_lock"))
	onButton(self, self._tf:Find("btn_back"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("BG/Close"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnChange, function()
		if self.contextData.isPublicRoom then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_skin_unlock"))

			return
		end

		if self:IsSameSkin() then
			return
		end

		self:emit(Dorm3dSkinSelectMediator.CHANGE_SKIN, self.contextData.groupId, self.selectedSkinId, self.hiddenList)

		if not self.contextData.onSwitchSkin then
			if pg.dorm3d_resource[self.selectedSkinId].wear_anim and pg.dorm3d_resource[self.selectedSkinId].wear_anim ~= "" then
				self.contextData.ladyEnv:PlaySingleAction(pg.dorm3d_resource[self.selectedSkinId].wear_anim)
			end
		end

		self.sortSkinId = self.selectedSkinId

		self:FlushSkinList()

		return
	end, SFX_PANEL)
	onButton(self, self.btnBuy, function()
		local var_8_0 = self.skinDic[self.selectedSkinId]:GetType()

		if var_8_0 == 2 then
			local var_8_1 = self.skinDic[self.selectedSkinId]:GetPublicRoomId()

			if getProxy(ApartmentProxy):getRoom(var_8_1) then
				self:emit(Dorm3dSkinSelectMediator.OPEN_ROOM_UNLOCK_WINDOW, var_8_1, self.contextData.groupId)
			else
				self:emit(Dorm3dSkinSelectMediator.OPEN_ROOM_UNLOCK_WINDOW, var_8_1)
			end
		elseif var_8_0 == 3 then
			local var_8_2 = self.skinDic[self.selectedSkinId]:GetShopId()
			local var_8_3 = CommonCommodity.New({
				id = var_8_2
			}, Goods.TYPE_SHOPSTREET)
			local var_8_4, var_8_5, var_8_6 = var_8_3:GetPrice()

			self:emit(Dorm3dSkinSelectMediator.OPEN_SHOP_WINDOW, {
				content = {
					icon = "<icon name=" .. var_8_3:GetResIcon() .. " w=1.1 h=1.1/>",
					off = var_8_5,
					cost = Drop.New({
						type = DROP_TYPE_RESOURCE,
						id = var_8_3:GetResType(),
						count = var_8_4
					}).count,
					old = var_8_6,
					name = self.skinDic[self.selectedSkinId]:GetName()
				},
				tip = i18n("dorm3d_shop_gift_tip"),
				drop = self.skinDic[self.selectedSkinId],
				onYes = function()
					self:emit(GAME.SHOPPING, {
						silentTip = true,
						count = 1,
						id = var_8_2
					})

					return
				end
			})
		end

		return
	end, SFX_PANEL)

	self.selectedSkinId = self.contextData.ladyEnv.skinId
	self.sortSkinId = self.selectedSkinId
	self.skinDic = {}

	for iter_4_0, iter_4_1 in ipairs(self.contextData.ladyEnv.skinIdList) do
		self.skinDic[iter_4_1] = Dorm3dSkin.New({
			configId = iter_4_1
		})
	end

	self:FlushSkinList()

	return
end

function Dorm3dSkinSelectLayer:FlushSkinList()
	local var_10_0 = {}
	local var_10_1 = {}

	_.each(self.contextData.ladyEnv.skinIdList, function(arg_11_0)
		if self.skinDic[arg_11_0]:IsShow() then
			if ApartmentProxy.CheckUnlockConfig(self.skinDic[arg_11_0]:GetUnlock()) then
				table.insert(var_10_0, arg_11_0)
			else
				table.insert(var_10_1, arg_11_0)
			end
		end

		return
	end)

	local function var_10_2(arg_12_0, arg_12_1)
		return (arg_12_0 == self.sortSkinId and 1 or 0) > (arg_12_1 == self.sortSkinId and 1 or 0)
	end

	table.sort(var_10_0, var_10_2)
	table.sort(var_10_1, var_10_2)

	local function var_10_3(arg_13_0, arg_13_1)
		local var_13_0

		if arg_13_1 then
			var_13_0 = var_10_0 or var_10_1
		end

		UIItemList.StaticAlign(arg_13_0, arg_13_0:GetChild(0), #var_13_0, function(arg_14_0, arg_14_1, arg_14_2)
			if arg_14_0 ~= UIItemList.EventUpdate then
				return
			end

			local var_14_0 = var_13_0[arg_14_1 + 1]

			setActive(arg_14_2:Find("Selected"), var_13_0[arg_14_1 + 1] == self.selectedSkinId)
			setActive(arg_14_2:Find("Lock"), not arg_13_1)

			if not arg_13_1 then
				setText(arg_14_2:Find("Lock/Bar/Text"), self.skinDic[var_14_0]:GetUnlockText())
			end

			self.loader:GetSpriteQuiet(string.format("dorm3dselect/apartment_skin_%d", var_14_0), "", arg_14_2:Find("Icon"))
			onButton(self, arg_14_2, function()
				self:OnclickSkin(var_14_0, arg_13_1)

				return
			end, SFX_PANEL)

			return
		end)

		return
	end

	var_10_3(self._tf:Find("BG/Scroll/Content/Unlock/List"), true)
	var_10_3(self._tf:Find("BG/Scroll/Content/Lock/List"), false)
	self:FlushSkinPartOptions()
	self:FlushBtns()

	return
end

function Dorm3dSkinSelectLayer:OnclickSkin(arg_16_1, arg_16_2)
	local var_16_0 = self.contextData.ladyEnv

	self.selectedSkinId = arg_16_1

	self:FlushBtns()
	self:FlushSkinPartOptions()

	if arg_16_1 ~= self.contextData.ladyEnv.skinId then
		if self.contextData.onSwitchSkin then
			self.contextData.onSwitchSkin(self.contextData.ladyEnv, self.contextData.groupId, self.selectedSkinId)
		else
			self.contextData.ladyEnv:SwitchCharacterSkin(self.contextData.groupId, self.selectedSkinId, function()
				Dorm3dHxHelper.HideCharacterPart(var_16_0.lady, self.hiddenList)

				local var_17_0 = self.skinDic[self.selectedSkinId]:GetSwitchAnim()

				if var_17_0 and var_17_0 ~= "" then
					var_16_0:PlaySingleAction(var_17_0)
				end

				return
			end)
		end
	end

	self:FlushSkinList()

	return
end

function Dorm3dSkinSelectLayer:FlushBtns()
	local var_18_0 = ApartmentProxy.CheckUnlockConfig(self.skinDic[self.selectedSkinId]:GetUnlock())

	setActive(self.btnChange, var_18_0)
	setActive(self.btnBuy, not var_18_0)

	if not var_18_0 then
		local var_18_1 = self.skinDic[self.selectedSkinId]:GetShopId()

		if not var_18_1 then
			return
		end

		local var_18_2 = CommonCommodity.New({
			id = var_18_1
		}, Goods.TYPE_SHOPSTREET)

		setText(self.priceText, "<icon name=" .. var_18_2:GetResIcon() .. " w=1.1 h=1.1/> " .. var_18_2:GetPrice())

		local var_18_3 = self.skinDic[self.selectedSkinId]:GetUnlock()[1]
		local var_18_4 = self.skinDic[self.selectedSkinId]:GetRemarks()

		if var_18_4 and var_18_4 ~= "" then
			setActive(self.line, false)
			setActive(self.desc, true)
			setText(self.desc, var_18_4)
		else
			setActive(self.line, true)
			setActive(self.desc, false)
		end
	else
		setActive(self.desc, false)

		if self:IsSameSkin() then
			setText(self.btnChange:Find("text"), i18n("dorm3d_skin_already"))
		else
			setText(self.btnChange:Find("text"), i18n("dorm3d_skin_confirm"))
		end
	end

	return
end

function Dorm3dSkinSelectLayer:FlushSkinPartOptions()
	local var_19_0 = pg.dorm3d_resource[self.selectedSkinId].hidden_part

	self.hiddenList = Clone(self.apartment:GetHiddenParts(self.selectedSkinId))

	UIItemList.StaticAlign(self._tf:Find("BG/parts"), self._tf:Find("BG/parts/tpl"), #pg.dorm3d_resource[self.selectedSkinId].hidden_part, function(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = var_19_0[arg_20_1 + 1]

		if arg_20_0 == UIItemList.EventInit then
			self.loader:GetSpriteQuiet("dorm3dskinpart/" .. var_19_0[arg_20_1 + 1][2], "", arg_20_2:Find("open"))
			self.loader:GetSpriteQuiet("dorm3dskinpart/" .. var_19_0[arg_20_1 + 1][2] .. "_close", "", arg_20_2:Find("close"))

			local var_20_1 = table.contains(self.hiddenList, var_19_0[arg_20_1 + 1][1])

			setActive(arg_20_2:Find("open"), not var_20_1)
			setActive(arg_20_2:Find("close"), var_20_1)
			onButton(self, arg_20_2, function()
				local var_21_0 = table.contains(self.hiddenList, var_20_0[1])

				if var_21_0 then
					table.removebyvalue(self.hiddenList, var_20_0[1])
				else
					table.insert(self.hiddenList, var_20_0[1])
				end

				local var_21_1 = not var_21_0

				setActive(arg_20_2:Find("open"), not not var_21_0)
				setActive(arg_20_2:Find("close"), var_21_1)
				Dorm3dHxHelper.HideCharacterPart(self.contextData.ladyEnv.lady, self.hiddenList)
				self:FlushBtns()

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function Dorm3dSkinSelectLayer:IsSameSkin()
	if self.selectedSkinId ~= self.apartment:GetCurSkinId() then
		return false
	end

	local var_22_0, var_22_1, var_22_2 = table.Diff(self.hiddenList, (self.apartment:GetHiddenParts(self.selectedSkinId)))

	return #var_22_1 == 0 and #var_22_2 == 0
end

function Dorm3dSkinSelectLayer:ConfirmCurrentSkin()
	self:OnclickSkin(self.selectedSkinId, true)

	return
end

function Dorm3dSkinSelectLayer:CancelCurrentSkin()
	self:OnclickSkin(self.contextData.ladyEnv.skinId, true)

	return
end

function Dorm3dSkinSelectLayer:willExit()
	self.loader:Clear()

	if self.contextData.isPublicRoom then
		return
	end

	local var_25_0 = self.apartment:GetCurSkinId()

	if self.contextData.ladyEnv.skinId ~= var_25_0 then
		self.contextData.ladyEnv:SwitchCharacterSkin(self.contextData.groupId, var_25_0, function()
			Dorm3dHxHelper.HideCharacterPart(self.contextData.ladyEnv.lady, self.apartment:GetHiddenParts(var_25_0))

			return
		end)
	else
		Dorm3dHxHelper.HideCharacterPart(self.contextData.ladyEnv.lady, self.apartment:GetHiddenParts(var_25_0))
	end

	return
end

return Dorm3dSkinSelectLayer
