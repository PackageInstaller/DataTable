local var_0_0 = class("Dorm3dSkinSelectLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dSkinSelectLayer"
end

function var_0_0.init(arg_2_0)
	arg_2_0.btnChange = arg_2_0._tf:Find("BG/bottom/btn_change")
	arg_2_0.btnBuy = arg_2_0._tf:Find("BG/bottom/btn_buy")
	arg_2_0.priceText = arg_2_0._tf:Find("BG/bottom/btn_buy/Price")
	arg_2_0.line = arg_2_0._tf:Find("BG/bottom/Line")
	arg_2_0.desc = arg_2_0._tf:Find("BG/bottom/desc")
	arg_2_0.loader = AutoLoader.New()

	return
end

function var_0_0.SetApartment(arg_3_0, arg_3_1)
	arg_3_0.apartment = arg_3_1

	return
end

function var_0_0.didEnter(arg_4_0)
	setText(arg_4_0._tf:Find("BG/Scroll/Content/Unlock/Title/Text"), i18n("word_unlock"))
	setText(arg_4_0._tf:Find("BG/Scroll/Content/Lock/Title/Text"), i18n("word_lock"))
	onButton(arg_4_0, arg_4_0._tf:Find("btn_back"), function()
		arg_4_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0._tf:Find("BG/Close"), function()
		arg_4_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0.btnChange, function()
		if arg_4_0.contextData.isPublicRoom then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_skin_unlock"))

			return
		end

		if arg_4_0:IsSameSkin() then
			return
		end

		arg_4_0:emit(Dorm3dSkinSelectMediator.CHANGE_SKIN, arg_4_0.contextData.groupId, arg_4_0.selectedSkinId, arg_4_0.hiddenList)

		if not arg_4_0.contextData.onSwitchSkin then
			if pg.dorm3d_resource[arg_4_0.selectedSkinId].wear_anim and pg.dorm3d_resource[arg_4_0.selectedSkinId].wear_anim ~= "" then
				arg_4_0.contextData.ladyEnv:PlaySingleAction(pg.dorm3d_resource[arg_4_0.selectedSkinId].wear_anim)
			end
		end

		arg_4_0.sortSkinId = arg_4_0.selectedSkinId

		arg_4_0:FlushSkinList()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.btnBuy, function()
		local var_8_0 = arg_4_0.skinDic[arg_4_0.selectedSkinId]:GetType()

		if var_8_0 == 2 then
			local var_8_1 = arg_4_0.skinDic[arg_4_0.selectedSkinId]:GetPublicRoomId()

			if getProxy(ApartmentProxy):getRoom(var_8_1) then
				arg_4_0:emit(Dorm3dSkinSelectMediator.OPEN_ROOM_UNLOCK_WINDOW, var_8_1, arg_4_0.contextData.groupId)
			else
				arg_4_0:emit(Dorm3dSkinSelectMediator.OPEN_ROOM_UNLOCK_WINDOW, var_8_1)
			end
		elseif var_8_0 == 3 then
			local var_8_2 = CommonCommodity.New({
				id = arg_4_0.skinDic[arg_4_0.selectedSkinId]:GetShopId()
			}, Goods.TYPE_SHOPSTREET)
			local var_8_3, var_8_4, var_8_5 = var_8_2:GetPrice()

			arg_4_0:emit(Dorm3dSkinSelectMediator.OPEN_SHOP_WINDOW, {
				content = {
					icon = "<icon name=" .. var_8_2:GetResIcon() .. " w=1.1 h=1.1/>",
					off = var_8_4,
					cost = Drop.New({
						type = DROP_TYPE_RESOURCE,
						id = var_8_2:GetResType(),
						count = var_8_3
					}).count,
					old = var_8_5,
					name = arg_4_0.skinDic[arg_4_0.selectedSkinId]:GetName()
				},
				tip = i18n("dorm3d_shop_gift_tip"),
				drop = arg_4_0.skinDic[arg_4_0.selectedSkinId],
				onYes = function()
					arg_4_0:emit(GAME.SHOPPING, {
						silentTip = true,
						count = 1,
						id = var_0
					})

					return
				end
			})
		end

		return
	end, SFX_PANEL)

	arg_4_0.selectedSkinId = arg_4_0.contextData.ladyEnv.skinId
	arg_4_0.sortSkinId = arg_4_0.selectedSkinId
	arg_4_0.skinDic = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.contextData.ladyEnv.skinIdList) do
		arg_4_0.skinDic[iter_4_1] = Dorm3dSkin.New({
			configId = iter_4_1
		})
	end

	arg_4_0:FlushSkinList()

	return
end

function var_0_0.FlushSkinList(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = {}

	_.each(arg_10_0.contextData.ladyEnv.skinIdList, function(arg_11_0)
		if arg_10_0.skinDic[arg_11_0]:IsShow() then
			if ApartmentProxy.CheckUnlockConfig(arg_10_0.skinDic[arg_11_0]:GetUnlock()) then
				table.insert(var_10_0, arg_11_0)
			else
				table.insert(var_10_1, arg_11_0)
			end
		end

		return
	end)
	table.sort({}, function(arg_12_0, arg_12_1)
		return (arg_12_0 == arg_10_0.sortSkinId and 1 or 0) > (arg_12_1 == arg_10_0.sortSkinId and 1 or 0)
	end)
	table.sort({}, function(arg_12_0, arg_12_1)
		return (arg_12_0 == arg_10_0.sortSkinId and 1 or 0) > (arg_12_1 == arg_10_0.sortSkinId and 1 or 0)
	end)
	;(function(arg_13_0, arg_13_1)
		if arg_13_1 then
			local var_13_0 = var_10_0 or var_10_1

			UIItemList.StaticAlign(arg_13_0, arg_13_0:GetChild(0), #var_13_0, function(arg_14_0, arg_14_1, arg_14_2)
				if arg_14_0 ~= UIItemList.EventUpdate then
					return
				end

				local var_14_0 = var_13_0[arg_14_1 + 1]

				setActive(arg_14_2:Find("Selected"), var_13_0[arg_14_1 + 1] == arg_10_0.selectedSkinId)
				setActive(arg_14_2:Find("Lock"), not arg_13_1)

				if not arg_13_1 then
					setText(arg_14_2:Find("Lock/Bar/Text"), arg_10_0.skinDic[var_14_0]:GetUnlockText())
				end

				arg_10_0.loader:GetSpriteQuiet(string.format("dorm3dselect/apartment_skin_%d", var_14_0), "", arg_14_2:Find("Icon"))
				onButton(arg_10_0, arg_14_2, function()
					arg_10_0:OnclickSkin(var_14_0, arg_13_1)

					return
				end, SFX_PANEL)

				return
			end)

			return
		end
	end)(arg_10_0._tf:Find("BG/Scroll/Content/Unlock/List"), true)
	;(function(arg_13_0, arg_13_1)
		if arg_13_1 then
			local var_13_0 = var_10_0 or var_10_1

			UIItemList.StaticAlign(arg_13_0, arg_13_0:GetChild(0), #var_13_0, function(arg_14_0, arg_14_1, arg_14_2)
				if arg_14_0 ~= UIItemList.EventUpdate then
					return
				end

				local var_14_0 = var_13_0[arg_14_1 + 1]

				setActive(arg_14_2:Find("Selected"), var_13_0[arg_14_1 + 1] == arg_10_0.selectedSkinId)
				setActive(arg_14_2:Find("Lock"), not arg_13_1)

				if not arg_13_1 then
					setText(arg_14_2:Find("Lock/Bar/Text"), arg_10_0.skinDic[var_14_0]:GetUnlockText())
				end

				arg_10_0.loader:GetSpriteQuiet(string.format("dorm3dselect/apartment_skin_%d", var_14_0), "", arg_14_2:Find("Icon"))
				onButton(arg_10_0, arg_14_2, function()
					arg_10_0:OnclickSkin(var_14_0, arg_13_1)

					return
				end, SFX_PANEL)

				return
			end)

			return
		end
	end)(arg_10_0._tf:Find("BG/Scroll/Content/Lock/List"), false)
	arg_10_0:FlushSkinPartOptions()
	arg_10_0:FlushBtns()

	return
end

function var_0_0.OnclickSkin(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.contextData.ladyEnv

	arg_16_0.selectedSkinId = arg_16_1

	arg_16_0:FlushBtns()
	arg_16_0:FlushSkinPartOptions()

	if arg_16_1 ~= arg_16_0.contextData.ladyEnv.skinId then
		if arg_16_0.contextData.onSwitchSkin then
			arg_16_0.contextData.onSwitchSkin(arg_16_0.contextData.ladyEnv, arg_16_0.contextData.groupId, arg_16_0.selectedSkinId)
		else
			arg_16_0.contextData.ladyEnv:SwitchCharacterSkin(arg_16_0.contextData.groupId, arg_16_0.selectedSkinId, function()
				Dorm3dHxHelper.HideCharacterPart(var_16_0.lady, arg_16_0.hiddenList)

				local var_17_0 = arg_16_0.skinDic[arg_16_0.selectedSkinId]:GetSwitchAnim()

				if var_17_0 and var_17_0 ~= "" then
					var_16_0:PlaySingleAction(var_17_0)
				end

				return
			end)
		end
	end

	arg_16_0:FlushSkinList()

	return
end

function var_0_0.FlushBtns(arg_18_0)
	local var_18_0 = ApartmentProxy.CheckUnlockConfig(arg_18_0.skinDic[arg_18_0.selectedSkinId]:GetUnlock())

	setActive(arg_18_0.btnChange, var_18_0)
	setActive(arg_18_0.btnBuy, not var_18_0)

	if not var_18_0 then
		local var_18_1 = arg_18_0.skinDic[arg_18_0.selectedSkinId]:GetShopId()

		if not var_18_1 then
			return
		end

		local var_18_2 = CommonCommodity.New({
			id = var_18_1
		}, Goods.TYPE_SHOPSTREET)

		setText(arg_18_0.priceText, "<icon name=" .. var_18_2:GetResIcon() .. " w=1.1 h=1.1/> " .. var_18_2:GetPrice())

		local var_18_3 = arg_18_0.skinDic[arg_18_0.selectedSkinId]:GetUnlock()[1]
		local var_18_4 = arg_18_0.skinDic[arg_18_0.selectedSkinId]:GetRemarks()

		if var_18_4 and var_18_4 ~= "" then
			setActive(arg_18_0.line, false)
			setActive(arg_18_0.desc, true)
			setText(arg_18_0.desc, var_18_4)
		else
			setActive(arg_18_0.line, true)
			setActive(arg_18_0.desc, false)
		end
	else
		setActive(arg_18_0.desc, false)

		if arg_18_0:IsSameSkin() then
			setText(arg_18_0.btnChange:Find("text"), i18n("dorm3d_skin_already"))
		else
			setText(arg_18_0.btnChange:Find("text"), i18n("dorm3d_skin_confirm"))
		end
	end

	return
end

function var_0_0.FlushSkinPartOptions(arg_19_0)
	local var_19_0 = pg.dorm3d_resource[arg_19_0.selectedSkinId].hidden_part

	arg_19_0.hiddenList = Clone(arg_19_0.apartment:GetHiddenParts(arg_19_0.selectedSkinId))

	UIItemList.StaticAlign(arg_19_0._tf:Find("BG/parts"), arg_19_0._tf:Find("BG/parts/tpl"), #pg.dorm3d_resource[arg_19_0.selectedSkinId].hidden_part, function(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = var_19_0[arg_20_1 + 1]

		if arg_20_0 == UIItemList.EventInit then
			arg_19_0.loader:GetSpriteQuiet("dorm3dskinpart/" .. var_19_0[arg_20_1 + 1][2], "", arg_20_2:Find("open"))
			arg_19_0.loader:GetSpriteQuiet("dorm3dskinpart/" .. var_19_0[arg_20_1 + 1][2] .. "_close", "", arg_20_2:Find("close"))

			local var_20_1 = table.contains(arg_19_0.hiddenList, var_19_0[arg_20_1 + 1][1])

			setActive(arg_20_2:Find("open"), not var_20_1)
			setActive(arg_20_2:Find("close"), var_20_1)
			onButton(arg_19_0, arg_20_2, function()
				local var_21_0 = table.contains(arg_19_0.hiddenList, var_20_0[1])

				if var_21_0 then
					table.removebyvalue(arg_19_0.hiddenList, var_20_0[1])
				else
					table.insert(arg_19_0.hiddenList, var_20_0[1])
				end

				local var_21_1 = not var_21_0

				setActive(arg_20_2:Find("open"), not not var_21_0)
				setActive(arg_20_2:Find("close"), var_21_1)
				Dorm3dHxHelper.HideCharacterPart(arg_19_0.contextData.ladyEnv.lady, arg_19_0.hiddenList)
				arg_19_0:FlushBtns()

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function var_0_0.IsSameSkin(arg_22_0)
	if arg_22_0.selectedSkinId ~= arg_22_0.apartment:GetCurSkinId() then
		return false
	end

	local var_22_0, var_22_1, var_22_2 = table.Diff(arg_22_0.hiddenList, (arg_22_0.apartment:GetHiddenParts(arg_22_0.selectedSkinId)))

	return #var_22_1 == 0 and #var_22_2 == 0
end

function var_0_0.ConfirmCurrentSkin(arg_23_0)
	arg_23_0:OnclickSkin(arg_23_0.selectedSkinId, true)

	return
end

function var_0_0.CancelCurrentSkin(arg_24_0)
	arg_24_0:OnclickSkin(arg_24_0.contextData.ladyEnv.skinId, true)

	return
end

function var_0_0.willExit(arg_25_0)
	arg_25_0.loader:Clear()

	if arg_25_0.contextData.isPublicRoom then
		return
	end

	local var_25_0 = arg_25_0.apartment:GetCurSkinId()

	if arg_25_0.contextData.ladyEnv.skinId ~= var_25_0 then
		arg_25_0.contextData.ladyEnv:SwitchCharacterSkin(arg_25_0.contextData.groupId, var_25_0, function()
			Dorm3dHxHelper.HideCharacterPart(arg_25_0.contextData.ladyEnv.lady, arg_25_0.apartment:GetHiddenParts(var_25_0))

			return
		end)
	else
		Dorm3dHxHelper.HideCharacterPart(arg_25_0.contextData.ladyEnv.lady, arg_25_0.apartment:GetHiddenParts(var_25_0))
	end

	return
end

return var_0_0
