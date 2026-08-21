local var_0_0 = class("ChargeItemPanelLayer", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	if arg_1_0.contextData.panelConfig.extraItems then
		local var_1_0 = arg_1_0.contextData.panelConfig.extraItems or {}

		if arg_1_0:ExistSkinExperienceItem(var_1_0) then
			return "ChargeItem4SkinDiscountItemUI"
		else
			return "ChargeItemPanelUI"
		end

		return
	end
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initUIText()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:updatePanel()
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)

	return
end

function var_0_0.willExit(arg_4_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_4_0._tf)

	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.panelConfig = arg_5_0.contextData.panelConfig

	return
end

function var_0_0.initUIText(arg_6_0)
	setText(arg_6_0._tf:Find("window/button_container/button_cancel/Image"), i18n("text_cancel"))
	setText(arg_6_0._tf:Find("window/button_container/button_ok/Image"), i18n("text_buy"))

	return
end

function var_0_0.findUI(arg_7_0)
	arg_7_0.bg = arg_7_0._tf:Find("back_sign")
	arg_7_0.detailWindow = arg_7_0._tf:Find("window")
	arg_7_0.cancelBtn = arg_7_0.detailWindow:Find("button_container/button_cancel")
	arg_7_0.confirmBtn = arg_7_0.detailWindow:Find("button_container/button_ok")
	arg_7_0.detailName = arg_7_0.detailWindow:Find("goods/mask/name/Text")
	arg_7_0.detailIcon = arg_7_0.detailWindow:Find("goods/icon")
	arg_7_0.detailExtraDrop = arg_7_0.detailWindow:Find("goods/extra_drop")
	arg_7_0.detailRmb = arg_7_0.detailWindow:Find("prince_bg/contain/icon_rmb")
	arg_7_0.detailGem = arg_7_0.detailWindow:Find("prince_bg/contain/icon_gem")
	arg_7_0.detailGold = arg_7_0.detailWindow:Find("prince_bg/contain/icon_gold")
	arg_7_0.detailPrice = arg_7_0.detailWindow:Find("prince_bg/contain/Text")
	arg_7_0.detailTag = arg_7_0.detailWindow:Find("goods/tag")
	arg_7_0.detailTags = {}

	table.insert(arg_7_0.detailTags, arg_7_0.detailTag:Find("hot"))
	table.insert(arg_7_0.detailTags, arg_7_0.detailTag:Find("new"))
	table.insert(arg_7_0.detailTags, arg_7_0.detailTag:Find("advice"))
	table.insert(arg_7_0.detailTags, arg_7_0.detailTag:Find("double"))
	table.insert(arg_7_0.detailTags, arg_7_0.detailTag:Find("discount"))

	arg_7_0.detailTagAdviceTF = arg_7_0.detailTags[3]
	arg_7_0.detailTagDoubleTF = arg_7_0.detailTags[4]
	arg_7_0.detailContain = arg_7_0.detailWindow:Find("container")

	if arg_7_0.detailContain then
		arg_7_0.normal = arg_7_0.detailContain:Find("normal_items")
		arg_7_0.detailTip = arg_7_0.normal:Find("Text")
		arg_7_0.detailItem = arg_7_0.normal:Find("item_tpl")
		arg_7_0.extra = arg_7_0.detailContain:Find("items")
		arg_7_0.extraTip = arg_7_0.extra:Find("Text")
		arg_7_0.detailItemList = arg_7_0.extra:Find("scrollview/list")
		arg_7_0.extraDesc = arg_7_0.detailContain:Find("Text")
	end

	arg_7_0.detailNormalTip = arg_7_0.detailWindow:Find("NormalTips")
	arg_7_0.infoBtn = arg_7_0.detailWindow:Find("prince_bg/info")

	return
end

function var_0_0.addListener(arg_8_0)
	onButton(arg_8_0, arg_8_0.bg, function()
		arg_8_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.cancelBtn, function()
		arg_8_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.confirmBtn, function()
		if arg_8_0.panelConfig.limitArgs and type(arg_8_0.panelConfig.limitArgs) == "table" then
			if arg_8_0.panelConfig.limitArgs[1] and type(arg_8_0.panelConfig.limitArgs[1]) == "table" and #arg_8_0.panelConfig.limitArgs[1] >= 2 then
				local var_11_0, var_11_1 = unpack(arg_8_0.panelConfig.limitArgs[1])

				if var_11_0 == "lv_70" and var_11_1 <= getProxy(PlayerProxy):getRawData().level then
					table.insert({}, function(arg_12_0)
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							content = i18n("lv70_package_tip"),
							onYes = arg_12_0
						})

						return
					end)
				end
			end
		end

		for iter_11_0, iter_11_1 in ipairs(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SKIN_COUPON_COUNTING)) do
			if not arg_8_0.panelConfig.isChargeType then
				break
			end

			if not iter_11_1:isEnd() and table.contains(iter_11_1:getConfig("config_data")[1], arg_8_0.panelConfig.commodity.id) then
				local var_11_2 = Drop.New({
					type = DROP_TYPE_VITEM,
					id = iter_11_1:GetConfigClientSetting("item_id")
				})
				local var_11_3 = getProxy(ActivityProxy):getActivityById(var_11_2:getConfig("link_id"))

				if var_11_3 and not var_11_3:isEnd() then
					assert(var_11_3:getConfig("type") == ActivityConst.ACTIVITY_TYPE_SKIN_COUPON)

					local var_11_4, var_11_5 = var_11_3:GetOwnCount()

					if iter_11_1:GetConfigClientSetting("gift_tip")[arg_8_0.panelConfig.commodity.id][1] then
						table.insert({}, function(arg_13_0)
							pg.MsgboxMgr.GetInstance():ShowMsgBox({
								content = i18n(var_0, var_11_4, var_11_5),
								onYes = arg_13_0
							})

							return
						end)
					else
						table.insert({}, function(arg_14_0)
							arg_14_0()

							return
						end)
					end
				end
			end
		end

		seriesAsync({}, function()
			existCall(arg_8_0.panelConfig.onYes)
			arg_8_0:closeView()

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updatePanel(arg_16_0)
	local var_16_0 = arg_16_0.panelConfig.icon
	local var_16_1 = arg_16_0.panelConfig.name or ""
	local var_16_2 = arg_16_0.panelConfig.tipBonus or ""
	local var_16_3 = arg_16_0.panelConfig.bonusItem
	local var_16_4 = arg_16_0.panelConfig.tipExtra or ""
	local var_16_5 = arg_16_0.panelConfig.extraItems or {}

	if arg_16_0.panelConfig.price then
		local var_16_6 = arg_16_0.panelConfig.price or 0
		local var_16_7 = arg_16_0.panelConfig.isChargeType
		local var_16_8 = arg_16_0.panelConfig.isLocalPrice
		local var_16_9 = arg_16_0.panelConfig.isMonthCard
		local var_16_10 = arg_16_0.panelConfig.tagType
		local var_16_11 = arg_16_0.panelConfig.extraDrop
		local var_16_12 = arg_16_0.panelConfig.isForceGold
		local var_16_13 = arg_16_0.panelConfig.infoTip or ""

		if arg_16_0.detailNormalTip then
			setActive(arg_16_0.detailNormalTip, arg_16_0.panelConfig.normalTip)
		end

		if arg_16_0.detailContain then
			setActive(arg_16_0.detailContain, not arg_16_0.panelConfig.normalTip)
		end

		if arg_16_0.panelConfig.normalTip then
			if arg_16_0.detailNormalTip:GetComponent("Text") then
				setText(arg_16_0.detailNormalTip, arg_16_0.panelConfig.normalTip)
			else
				setButtonText(arg_16_0.detailNormalTip, arg_16_0.panelConfig.normalTip)
			end
		end

		setActive(arg_16_0.detailTag, var_16_10 > 0)

		if var_16_10 > 0 then
			for iter_16_0, iter_16_1 in ipairs(arg_16_0.detailTags) do
				setActive(iter_16_1, iter_16_0 == var_16_10)
			end
		end

		GetImageSpriteFromAtlasAsync(var_16_0, "", arg_16_0.detailIcon, false)
		setScrollText(arg_16_0.detailName, var_16_1)

		if arg_16_0.detailExtraDrop then
			setActive(arg_16_0.detailExtraDrop, var_16_11)

			if var_16_11 then
				setText(arg_16_0.detailExtraDrop:Find("Text"), i18n("battlepass_pay_acquire") .. "\n" .. var_16_11.count .. "x")
				updateDrop(arg_16_0.detailExtraDrop:Find("item/IconTpl"), setmetatable({
					count = 1
				}, {
					__index = var_16_11
				}))
			end
		end

		if PLATFORM_CODE == PLATFORM_CHT then
			setActive(arg_16_0.detailRmb, var_16_7 and not var_16_8)
		else
			setActive(arg_16_0.detailRmb, var_16_7)
		end

		setActive(arg_16_0.detailGem, not var_16_7 and not var_16_12)
		setActive(arg_16_0.detailGold, not var_16_7 and not isActive(arg_16_0.detailRmb) and not isActive(arg_16_0.detailGem))
		setText(arg_16_0.detailPrice, var_16_6)

		if arg_16_0.extraDesc ~= nil then
			local var_16_14 = arg_16_0.panelConfig.descExtra or ""

			setActive(arg_16_0.extraDesc, #var_16_14 > 0)
			setText(arg_16_0.extraDesc, var_16_14)
		end

		if arg_16_0.detailContain then
			setActive(arg_16_0.normal, var_16_9)

			if var_16_9 then
				updateDrop(arg_16_0.detailItem, var_16_3)
				onButton(arg_16_0, arg_16_0.detailItem, function()
					return
				end, SFX_PANEL)

				local var_16_15, var_16_16 = contentWrap(var_16_3:getConfig("name"), 10, 2)

				if var_16_15 then
					var_16_16 = var_16_16 .. "..."
				end

				setText(arg_16_0.detailItem:Find("name"), var_16_16)
				setText(arg_16_0.detailTip, var_16_2)
			end

			setText(arg_16_0.extraTip, var_16_4)

			if arg_16_0:ExistSkinExperienceItem(var_16_5) then
				arg_16_0:UpdateSkinDiscountItemItems(var_16_5)
			else
				arg_16_0:UpdateItems(var_16_5)
			end
		end

		local var_16_17 = var_16_13 ~= ""

		setActive(arg_16_0.infoBtn, var_16_13 ~= "")

		if var_16_17 then
			onButton(arg_16_0, arg_16_0.infoBtn, function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_HELP,
					helps = pg.gametip[var_16_13].tip
				})

				return
			end, SFX_PANEL)
		else
			removeOnButton(arg_16_0.infoBtn)
		end

		return
	end
end

function var_0_0.UpdateItems(arg_19_0, arg_19_1)
	UIItemList.StaticAlign(arg_19_0.detailItemList, arg_19_0.detailItem, #arg_19_1, function(arg_20_0, arg_20_1, arg_20_2)
		arg_20_1 = arg_20_1 + 1

		if arg_20_0 == UIItemList.EventUpdate then
			local var_20_0 = arg_19_1[arg_20_1]

			updateDrop(arg_20_2, arg_19_1[arg_20_1])

			local var_20_1, var_20_2 = contentWrap(arg_19_1[arg_20_1]:getConfig("name"), 8, 2)

			if var_20_1 then
				var_20_2 = var_20_2 .. "..."
			end

			setText(arg_20_2:Find("name"), var_20_2)
			onButton(arg_19_0, arg_20_2, function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = true,
					type = MSGBOX_TYPE_SINGLE_ITEM,
					drop = var_20_0
				})

				return
			end, SFX_PANEL)
			setBlackMask(arg_20_2:Find("icon_bg"), arg_19_1[arg_20_1].got, {
				color = Color(0, 0, 0, 0.6)
			})
			setActive(arg_20_2:Find("got"), arg_19_1[arg_20_1].got)
			setActive(arg_20_2:Find("special"), arg_19_1[arg_20_1].special)
		end

		return
	end)

	return
end

function var_0_0.UpdateSkinDiscountItemItems(arg_22_0, arg_22_1)
	local var_22_0, var_22_1 = arg_22_0:SplitItemAndSkinExperienceItem(arg_22_1)

	arg_22_0:UpdateItems(var_22_0)

	local var_22_2 = UIItemList.New(arg_22_0._tf:Find("window/container/bonus_gift/bg/scrollview/list"), arg_22_0._tf:Find("window/container/normal_items/item_tpl"))

	var_22_2:make(function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 == UIItemList.EventUpdate then
			arg_22_0:UpdateItem(var_22_1[arg_23_1 + 1], arg_23_2)
		end

		return
	end)
	var_22_2:align(#var_22_1)
	setText(arg_22_0._tf:Find("window/container/bonus_gift/bg/Text"), i18n("skin_discount_item_return_tip"))
	setText(arg_22_0._tf:Find("window/container/bonus_gift/bg/label"), i18n("skin_discount_item_extra_bounds"))

	return
end

function var_0_0.UpdateItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = Drop.Create({
		DROP_TYPE_ITEM,
		arg_24_1.id,
		arg_24_1.count
	})

	updateDrop(arg_24_2, var_24_0)
	setText(arg_24_2:Find("name"), shortenString(var_24_0:getName(), 4))
	onButton(arg_24_0, arg_24_2, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			type = MSGBOX_TYPE_SINGLE_ITEM,
			drop = var_24_0
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SplitItemAndSkinExperienceItem(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		if var_0_0.IsSkinExperienceItem(iter_26_1) then
			table.insert({}, iter_26_1)
		else
			table.insert({}, iter_26_1)
		end
	end

	return {}, {}
end

function var_0_0.IsSkinExperienceItem(arg_27_0)
	if not isa(arg_27_0, Drop) then
		arg_27_0 = Drop.New(arg_27_0)
	end

	local var_27_1 = arg_27_0:getConfigTable()

	return var_27_1 and var_27_1.usage == ItemUsage.USAGE_SKIN_EXP
end

function var_0_0.ExistSkinExperienceItem(arg_28_0, arg_28_1)
	return _.any(arg_28_1, function(arg_29_0)
		return var_0_0.IsSkinExperienceItem(arg_29_0)
	end)
end

return var_0_0
