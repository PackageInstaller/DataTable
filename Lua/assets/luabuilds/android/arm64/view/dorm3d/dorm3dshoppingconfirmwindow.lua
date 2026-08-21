local var_0_0 = class("Dorm3dShoppingConfirmWindow", import("view.base.BaseUI"))

var_0_0.SELECTED_WIDTH = 52
var_0_0.UNSELECTED_WIDTH = 12
var_0_0.LOOP_DURATION = 5

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dShopWindow"
end

function var_0_0.init(arg_2_0)
	arg_2_0.previewTf = arg_2_0._tf:Find("Window/Preview")
	arg_2_0.bubbleContent = arg_2_0._tf:Find("Window/Bubbles/content")
	arg_2_0.bubbleTpl = arg_2_0._tf:Find("Window/Bubbles/tpl")
	arg_2_0.bubbleList = UIItemList.New(arg_2_0.bubbleContent, arg_2_0.bubbleTpl)
	arg_2_0.scrollSnap = BannerScrollRect4Dorm.New(arg_2_0._tf:Find("Window/banner/mask/content"), arg_2_0._tf:Find("Window/banner/dots"))

	setActive(arg_2_0.bubbleTpl, false)
	switch(arg_2_0.contextData.drop.__cname, {
		Dorm3dGift = function()
			arg_2_0.unlockTips = pg.dorm3d_gift[arg_2_0.contextData.drop.configId].unlock_tips or {}

			local var_3_0 = arg_2_0.contextData.groupId
			local var_3_1 = pg.dorm3d_gift[arg_2_0.contextData.drop.configId].unlock_banners or {}
			local var_3_2 = table.Find(var_3_1, function(arg_4_0, arg_4_1)
				if var_3_0 == nil or arg_4_1[1] == var_3_0 then
					return true
				end

				return
			end) or table.Find(var_3_1, function(arg_5_0)
				if arg_5_0[1] == 0 then
					return true
				end

				return
			end)

			arg_2_0.unlockBanners = var_3_2 and var_3_2[2]
			arg_2_0.isExclusive = pg.dorm3d_gift[arg_2_0.contextData.drop.configId].ship_group_id ~= 0
			arg_2_0.addFavor = pg.dorm3d_favor_trigger[pg.dorm3d_gift[arg_2_0.contextData.drop.configId].favor_trigger_id].num

			setActive(arg_2_0._tf:Find("Window/Title/gift"), true)

			return
		end,
		Dorm3dFurniture = function()
			arg_2_0.unlockTips = pg.dorm3d_furniture_template[arg_2_0.contextData.drop.configId].unlock_tips or {}
			arg_2_0.unlockBanners = pg.dorm3d_furniture_template[arg_2_0.contextData.drop.configId].unlock_banners or {}
			arg_2_0.isExclusive = pg.dorm3d_furniture_template[arg_2_0.contextData.drop.configId].is_exclusive == 1
			arg_2_0.isSpecial = pg.dorm3d_furniture_template[arg_2_0.contextData.drop.configId].is_special == 1

			setActive(arg_2_0._tf:Find("Window/Title/furniture"), true)

			return
		end,
		Dorm3dSkin = function()
			arg_2_0.unlockTips = pg.dorm3d_resource[arg_2_0.contextData.drop.configId].unlock_tips or {}
			arg_2_0.unlockBanners = pg.dorm3d_resource[arg_2_0.contextData.drop.configId].unlock_banners or {}

			setActive(arg_2_0._tf:Find("Window/Title/skin"), true)

			return
		end
	})

	return
end

function var_0_0.didEnter(arg_8_0)
	onButton(arg_8_0, arg_8_0._tf:Find("Window/Confirm"), function()
		arg_8_0:closeView()
		existCall(arg_8_0.contextData.onYes)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0._tf:Find("Window/Cancel"), function()
		arg_8_0:closeView()
		existCall(arg_8_0.contextData.onNo)

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0._tf:Find("Mask"), function()
		arg_8_0:closeView()
		existCall(arg_8_0.contextData.onClose)

		return
	end)
	arg_8_0:InitUIList()
	arg_8_0:InitDropIcon()
	arg_8_0:InitBanner()

	local var_8_0 = arg_8_0.contextData.content.cost == 0 and i18n("dorm3d_purchase_confirm_free", arg_8_0.contextData.content.icon, "x" .. arg_8_0.contextData.content.cost, arg_8_0.contextData.content.name) or arg_8_0.contextData.content.off > 0 and i18n("dorm3d_purchase_confirm_discount", arg_8_0.contextData.content.icon, "x" .. arg_8_0.contextData.content.cost, arg_8_0.contextData.content.old, arg_8_0.contextData.content.name) or i18n("dorm3d_purchase_confirm_original", arg_8_0.contextData.content.icon, "x" .. arg_8_0.contextData.content.cost, arg_8_0.contextData.content.name)

	switch(arg_8_0.contextData.drop.__cname, {
		Dorm3dGift = function()
			if arg_8_0.contextData.content.weekLimit then
				var_8_0 = var_8_0 .. i18n("dorm3d_purchase_weekly_limit", arg_8_0.contextData.content.weekLimit[1], arg_8_0.contextData.content.weekLimit[2])
			end

			return
		end,
		Dorm3dFurniture = function()
			local var_13_0 = arg_8_0.contextData.endTime

			if arg_8_0.contextData.endTime and arg_8_0.contextData.endTime > 0 then
				local function var_13_1(arg_14_0)
					local var_14_9000
					local var_14_0 = pg.TimeMgr.GetInstance()
					local var_14_1 = math.max(arg_14_0 - var_14_0.GetServerTime(var_14_9000), 0)

					if var_14_0 > 0 then
						return math.floor(var_14_1 / 0) .. i18n("word_date")
					else
						local var_14_2 = math.floor(var_14_1 / 16)

						if var_14_2 > 0 then
							return var_14_2 .. i18n("word_hour")
						else
							local var_14_3 = math.floor(var_14_1 / 60)

							if var_14_3 > 0 then
								return var_14_3 .. i18n("word_minute")
							else
								return var_14_1 .. i18n("word_second")
							end
						end
					end

					return
				end

				local var_13_2 = var_8_0

				arg_8_0.timerRefreshTime = Timer.New(function()
					setText(arg_8_0._tf:Find("Window/Content"), var_13_2 .. string.format("\n<size=28><color=#7c7e81>%s</color><color=#169fff>%s</color></size>", i18n("time_remaining_tip"), var_13_1(var_13_0)))

					return
				end, 1, -1)

				arg_8_0.timerRefreshTime:Start()

				var_8_0 = var_8_0 .. string.format("\n<size=28><color=#7c7e81>%s</color><color=#169fff>%s</color></size>", i18n("time_remaining_tip"), (function(arg_14_0)
					local var_14_9000
					local var_14_0 = pg.TimeMgr.GetInstance()
					local var_14_1 = math.max(arg_14_0 - var_14_0.GetServerTime(var_14_9000), 0)

					if var_14_0 > 0 then
						return math.floor(var_14_1 / 0) .. i18n("word_date")
					else
						local var_14_2 = math.floor(var_14_1 / 16)

						if var_14_2 > 0 then
							return var_14_2 .. i18n("word_hour")
						else
							local var_14_3 = math.floor(var_14_1 / 60)

							if var_14_3 > 0 then
								return var_14_3 .. i18n("word_minute")
							else
								return var_14_1 .. i18n("word_second")
							end
						end
					end

					return
				end)(arg_8_0.contextData.endTime))
			end

			return
		end
	})
	setText(arg_8_0._tf:Find("Window/Content"), var_8_0)
	setText(arg_8_0._tf:Find("Window/Confirm/Text"), i18n("msgbox_text_confirm"))
	setText(arg_8_0._tf:Find("Window/Cancel/Text"), i18n("msgbox_text_cancel"))
	pg.UIMgr.GetInstance():OverlayPanel(arg_8_0._tf)

	return
end

function var_0_0.InitBanner(arg_16_0)
	for iter_16_0 = 1, #arg_16_0.unlockBanners do
		LoadImageSpriteAsync("dorm3dbanner/" .. arg_16_0.unlockBanners[iter_16_0], (arg_16_0.scrollSnap:AddChild()))
	end

	arg_16_0.scrollSnap:SetUp()

	return
end

function var_0_0.InitUIList(arg_17_0)
	arg_17_0.bubbleList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventInit then
			LoadImageSpriteAtlasAsync("ui/shoptip_atlas", "icon_" .. arg_17_0.unlockTips[arg_18_1 + 1], arg_18_2:Find("icon/icon"), true)
			setText(arg_18_2:Find("bubble/Text"), i18n("dorm3d_shop_tag" .. arg_17_0.unlockTips[arg_18_1 + 1]))
			setActive(arg_18_2:Find("bubble"), false)
			onToggle(arg_17_0, arg_18_2, function(arg_19_0)
				setActive(arg_18_2:Find("icon/select"), arg_19_0)
				setActive(arg_18_2:Find("icon/unselect"), not arg_19_0)
				setActive(arg_18_2:Find("bubble"), arg_19_0)

				return
			end)
		end

		return
	end)
	arg_17_0.bubbleList:align(#arg_17_0.unlockTips)

	return
end

function var_0_0.InitDropIcon(arg_20_0)
	LoadImageSpriteAtlasAsync(arg_20_0.contextData.drop:GetIcon(), "", arg_20_0._tf:Find("Window/Item/Dorm3dIconTpl/icon"), true)
	GetImageSpriteFromAtlasAsync("weaponframes", "dorm3d_" .. ItemRarity.Rarity2Print(arg_20_0.contextData.drop:GetRarity()), arg_20_0._tf:Find("Window/Item/Dorm3dIconTpl"))

	local var_20_0 = arg_20_0.isExclusive or arg_20_0.isSpecial

	setActive(arg_20_0._tf:Find("Window/Item/sp"), var_20_0)

	if arg_20_0.isSpecial then
		setText(arg_20_0._tf:Find("Window/Item/sp/Text"), i18n("dorm3d_purchase_label_special"))
	elseif arg_20_0.isExclusive then
		setText(arg_20_0._tf:Find("Window/Item/sp/Text"), i18n("dorm3d_purchase_confirm_tip"))
	end

	if arg_20_0.addFavor then
		setActive(arg_20_0._tf:Find("Window/Item/gift"), true)
		setText(arg_20_0._tf:Find("Window/Item/gift/Text"), "+" .. arg_20_0.addFavor)
	end

	return
end

function var_0_0.willExit(arg_21_0)
	if arg_21_0.timerRefreshTime then
		arg_21_0.timerRefreshTime:Stop()

		arg_21_0.timerRefreshTime = nil
	end

	arg_21_0.scrollSnap:Dispose()

	arg_21_0.scrollSnap = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_21_0._tf)

	return
end

return var_0_0
