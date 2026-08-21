local var_0_0 = class("Dorm3dShopUI", import("view.base.BaseUI"))
local var_0_1 = pg.dorm3d_set
local var_0_2 = pg.dorm3d_shop_template
local var_0_3 = pg.shop_template
local var_0_4 = pg.dorm3d_rooms
local var_0_5 = pg.dorm3d_gift
local var_0_6 = pg.dorm3d_furniture_template

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dShopUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.closeBtn = arg_2_0.rtAdapt:Find("closeBtn")
	arg_2_0.res = arg_2_0.rtAdapt:Find("resourceBg/res")
	arg_2_0.recommendationTg = arg_2_0.rtAdapt:Find("left/recommendation")
	arg_2_0.charaList = UIItemList.New(arg_2_0.rtAdapt:Find("left/charaScroll/mask/list"), arg_2_0.rtAdapt:Find("left/charaScroll/mask/list/tpl"))
	arg_2_0.recommendationPage = arg_2_0.rtAdapt:Find("pages/recommendationPage")
	arg_2_0.charaPage = arg_2_0.rtAdapt:Find("pages/charaPage")
	arg_2_0.mask = arg_2_0._tf:Find("mask")

	setText(arg_2_0.rtAdapt:Find("title/Text"), i18n("dorm3d_shop_title"))
	setText(arg_2_0.recommendationPage:Find("bannerCard/mask/content/item/soldOut"), i18n("dorm3d_shop_sold_out"))
	setText(arg_2_0.recommendationPage:Find("giftCard/soldOut"), i18n("dorm3d_shop_sold_out"))
	setText(arg_2_0.recommendationPage:Find("card1/soldOut"), i18n("dorm3d_shop_sold_out"))
	setText(arg_2_0.recommendationPage:Find("card2/soldOut"), i18n("dorm3d_shop_sold_out"))
	setText(arg_2_0.recommendationPage:Find("card3/soldOut"), i18n("dorm3d_shop_sold_out"))
	setText(arg_2_0.charaPage:Find("scroll/Viewport/Content/card/soldOut"), i18n("dorm3d_shop_sold_out"))
	setText(arg_2_0.charaPage:Find("switch/all/Text"), i18n("dorm3d_shop_all"))
	setText(arg_2_0.charaPage:Find("switch/gift/Text"), i18n("dorm3d_shop_gift1"))
	setText(arg_2_0.charaPage:Find("switch/furniture/Text"), i18n("dorm3d_shop_furniture"))
	setText(arg_2_0.charaPage:Find("switch/others/Text"), i18n("dorm3d_shop_others"))
	setText(arg_2_0.charaPage:Find("switch/all/selected/Text"), i18n("dorm3d_shop_all"))
	setText(arg_2_0.charaPage:Find("switch/gift/selected/Text"), i18n("dorm3d_shop_gift1"))
	setText(arg_2_0.charaPage:Find("switch/furniture/selected/Text"), i18n("dorm3d_shop_furniture"))
	setText(arg_2_0.charaPage:Find("switch/others/selected/Text"), i18n("dorm3d_shop_others"))

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:InitData()
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:closeView()

		return
	end, SFX_PANEL)
	arg_3_0:ShowResUI()
	arg_3_0:SetPageBtns()
	triggerToggle(arg_3_0.recommendationTg, true)

	return
end

function var_0_0.InitData(arg_5_0)
	arg_5_0.bannerCount = var_0_1.drom3d_shop_product_panel_num.key_value_int
	arg_5_0.allCommodityCfgs = {}

	for iter_5_0, iter_5_1 in ipairs(var_0_2.all) do
		table.insert(arg_5_0.allCommodityCfgs, var_0_2[iter_5_1])
	end

	table.sort(arg_5_0.allCommodityCfgs, function(arg_6_0, arg_6_1)
		if tonumber(arg_6_0.order) ~= tonumber(arg_6_1.order) then
			return tonumber(arg_6_0.order) < tonumber(arg_6_1.order)
		end

		return arg_6_0.id > arg_6_1.id
	end)

	arg_5_0.roomCfgs = {}

	_.each(var_0_4.all, function(arg_7_0)
		if var_0_4[arg_7_0].type == 2 then
			table.insert(arg_5_0.roomCfgs, var_0_4[arg_7_0])
		end

		return
	end)
	table.sort(arg_5_0.roomCfgs, function(arg_8_0, arg_8_1)
		return arg_8_0.id < arg_8_1.id
	end)

	arg_5_0.selectedId = 0

	return
end

function var_0_0.SetPageBtns(arg_9_0)
	SetParent(arg_9_0.recommendationTg, arg_9_0.rtAdapt:Find("left"), false)
	arg_9_0.charaList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = arg_9_0.roomCfgs[arg_10_1 + 1]

			GetImageSpriteFromAtlasAsync(string.format("dorm3dselect/room_icon_%s", string.lower(arg_9_0.roomCfgs[arg_10_1 + 1].assets_prefix)), "", arg_10_2:Find("mask/icon"), false)
			setActive(arg_10_2:Find("tip"), var_0_0.ShouldShowSumTip((arg_9_0:GetCommoditiesCfgByChara(arg_9_0.roomCfgs[arg_10_1 + 1].character[1]))))
			onToggle(arg_9_0, arg_10_2, function(arg_11_0)
				if arg_11_0 then
					arg_9_0.selectedId = var_10_0.id

					arg_9_0:SetPageBtns()
					arg_9_0:RefreshPage()
				end

				return
			end)
		end

		return
	end)
	arg_9_0.charaList:align(#arg_9_0.roomCfgs)

	arg_9_0.showingCommoditiesIndex = {}

	table.insertto({}, arg_9_0:GetCommoditiesCfgByPanel(1, arg_9_0.bannerCount))
	table.insertto({}, arg_9_0:GetCommoditiesCfgByPanel(2, 1))
	table.insertto({}, arg_9_0:GetCommoditiesCfgByPanel(3, 1))
	table.insertto({}, arg_9_0:GetCommoditiesCfgByPanel(4, 1))
	table.insertto({}, arg_9_0:GetCommoditiesCfgByPanel(5, 1))
	setActive(arg_9_0.recommendationTg:Find("icon/tip"), var_0_0.ShouldShowSumTip({}))
	onToggle(arg_9_0, arg_9_0.recommendationTg, function(arg_12_0)
		if arg_12_0 then
			arg_9_0.selectedId = 0

			arg_9_0:SetPageBtns()
			arg_9_0:RefreshPage()
		end

		return
	end)
	SetParent(arg_9_0.recommendationTg, arg_9_0.rtAdapt:Find("left/charaScroll/mask/list"), false)
	arg_9_0.recommendationTg:SetSiblingIndex(0)

	return
end

function var_0_0.GetCommoditiesCfgByPanel(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.allCommodityCfgs) do
		if not table.contains(arg_13_0.showingCommoditiesIndex, iter_13_0) and table.contains(iter_13_1.panel, arg_13_1) then
			local var_13_1 = arg_13_0:IsCommodityOutOfDate(iter_13_1) or arg_13_0:IsCommoditySoldOut(iter_13_1)

			if not var_13_1 then
				var_13_0 = var_13_0 + 1

				table.insert({}, iter_13_1)
				table.insert(arg_13_0.showingCommoditiesIndex, iter_13_0)
			end

			if var_13_0 == arg_13_2 then
				break
			end
		end
	end

	if var_13_0 < arg_13_2 then
		for iter_13_2, iter_13_3 in ipairs(arg_13_0.allCommodityCfgs) do
			if not table.contains(arg_13_0.showingCommoditiesIndex, iter_13_2) and table.contains(iter_13_3.panel, arg_13_1) then
				if not arg_13_0:IsCommodityOutOfDate(iter_13_3) then
					var_13_0 = var_13_0 + 1

					table.insert({}, iter_13_3)
					table.insert(arg_13_0.showingCommoditiesIndex, iter_13_2)
				end

				if var_13_0 == arg_13_2 then
					break
				end
			end
		end
	end

	return {}
end

function var_0_0.GetCommoditiesCfgByChara(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.allCommodityCfgs) do
		if iter_14_1.realroom_id ~= 0 then
			table.insertto({}, var_0_4[iter_14_1.realroom_id].character)
			table.insertto({}, var_0_4[iter_14_1.realroom_id].character_pay)
		end

		if iter_14_1.room_id == arg_14_1 or iter_14_1.room_id == 0 then
			if iter_14_1.realroom_id ~= 0 then
				if iter_14_1.realroom_id ~= 0 and table.contains({}, arg_14_1) then
					local var_14_0 = arg_14_0:IsCommoditySoldOut(iter_14_1)

					if not arg_14_0:IsCommodityOutOfDate(iter_14_1) then
						if not var_14_0 then
							table.insert({}, iter_14_1)
						else
							table.insert({}, iter_14_1)
						end
					end
				end
			end
		end
	end

	if #{} > 0 then
		table.insertto({}, {})
	end

	return {}
end

function var_0_0.IsCommodityOutOfDate(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1.shop_id) do
		local var_15_0 = pg.TimeMgr.GetInstance()

		if not var_15_0:inTime(var_0_3[iter_15_1].time) then
			return true
		end
	end

	return false
end

function var_0_0.IsCommoditySoldOut(arg_16_0, arg_16_1)
	if arg_16_1.type == 1 then
		if getProxy(ApartmentProxy):GetFurnitureShopCount(arg_16_1.item_id) > 0 then
			return true
		end
	elseif arg_16_1.type == 2 then
		return not Dorm3dGift.New({
			configId = arg_16_1.item_id
		}):CheckBuyLimit()
	elseif arg_16_1.type == 3 then
		local var_16_0 = getProxy(ApartmentProxy):getRoom(arg_16_1.item_id)

		return var_16_0 and var_16_0.unlockCharacter[arg_16_1.room_id]
	end

	return false
end

function var_0_0.ShowResUI(arg_17_0)
	arg_17_0.goldMax = arg_17_0.res:Find("gold/max"):GetComponent(typeof(Text))
	arg_17_0.goldValue = arg_17_0.res:Find("gold/Text"):GetComponent(typeof(Text))
	arg_17_0.oilMax = arg_17_0.res:Find("oil/max"):GetComponent(typeof(Text))
	arg_17_0.oilValue = arg_17_0.res:Find("oil/Text"):GetComponent(typeof(Text))
	arg_17_0.gemValue = arg_17_0.res:Find("gem/Text"):GetComponent(typeof(Text))

	PlayerResUI.StaticFlush(getProxy(PlayerProxy):getRawData(), arg_17_0.goldMax, arg_17_0.goldValue, arg_17_0.oilMax, arg_17_0.oilValue, arg_17_0.gemValue)
	onButton(arg_17_0, arg_17_0.res:Find("gold"), function()
		pg.playerResUI:ClickGold()

		return
	end, SFX_PANEL)
	onButton(arg_17_0, arg_17_0.res:Find("oil"), function()
		pg.playerResUI:ClickOil()

		return
	end, SFX_PANEL)
	onButton(arg_17_0, arg_17_0.res:Find("gem"), function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.RefreshPage(arg_21_0)
	arg_21_0.showingCommoditiesIndex = {}

	setActive(arg_21_0.recommendationPage, arg_21_0.selectedId == 0)
	setActive(arg_21_0.charaPage, arg_21_0.selectedId ~= 0)

	if arg_21_0.selectedId == 0 then
		arg_21_0:SetBannnerCard()
		arg_21_0:SetGiftCard()
		arg_21_0:SetNormalCard()
	else
		arg_21_0:SetCharaCard()
	end

	return
end

function var_0_0.SetBannnerCard(arg_22_0)
	local var_22_0 = arg_22_0.recommendationPage:Find("bannerCard")

	arg_22_0.scrollSnap = arg_22_0.scrollSnap or BannerScrollRectDorm3dShop.New(var_22_0:Find("mask/content"), var_22_0:Find("dots"))

	for iter_22_0, iter_22_1 in ipairs((arg_22_0:GetCommoditiesCfgByPanel(1, arg_22_0.bannerCount))) do
		local var_22_1 = arg_22_0.scrollSnap:GetItemChild(iter_22_0) or arg_22_0.scrollSnap:AddChild()
		local var_22_2 = arg_22_0:IsCommoditySoldOut(iter_22_1)
		local var_22_3 = false
		local var_22_4 = false
		local var_22_5 = {}
		local var_22_6 = 0
		local var_22_7 = ""
		local var_22_8 = ""
		local var_22_9 = var_0_3[iter_22_1.shop_id[1]].group_type == 2 and i18n("dorm3d_shop_limit1") or i18n("dorm3d_shop_limit")

		if iter_22_1.type == 1 then
			local var_22_10 = var_0_6[iter_22_1.item_id]

			var_22_4 = var_0_6[iter_22_1.item_id].is_special == 1
			var_22_3 = not var_22_4 and var_22_10.is_exclusive == 1
			var_22_7 = Drop.New({
				count = 0,
				type = DROP_TYPE_DORM3D_FURNITURE,
				id = var_22_10.id
			}):getIcon()

			local var_22_11 = getProxy(ApartmentProxy)

			var_22_8 = var_22_9 .. " " .. var_22_11:GetFurnitureShopCount(iter_22_1.item_id) .. "/1"
			var_22_5 = var_22_10.unlock_tips or {}
			var_22_6 = iter_22_1.shop_id[1]
		elseif iter_22_1.type == 2 then
			local var_22_12 = var_0_5[iter_22_1.item_id]

			var_22_3 = iter_22_1.room_id ~= 0

			local var_22_13 = Dorm3dGift.New({
				configId = iter_22_1.item_id
			})

			;({
				type = DROP_TYPE_DORM3D_GIFT,
				id = iter_22_1.item_id
			}).count = getProxy(ApartmentProxy):getGiftCount(iter_22_1.item_id)
			var_22_7 = Drop.New({
				type = DROP_TYPE_DORM3D_GIFT,
				id = iter_22_1.item_id
			}):getIcon()

			local var_22_14 = 0

			for iter_22_2 = 1, #iter_22_1.shop_id do
				if not var_0_3[iter_22_1.shop_id[iter_22_2]].limit_args[1] and var_0_3[iter_22_1.shop_id[iter_22_2]].group_type == 0 then
					var_22_14 = 0
				elseif var_0_3[iter_22_1.shop_id[iter_22_2]].limit_args[1] and (var_0_3[iter_22_1.shop_id[iter_22_2]].limit_args[1][1] == "dailycount" or var_0_3[iter_22_1.shop_id[iter_22_2]].limit_args[1][1] == "count") then
					var_22_14 = var_0_3[iter_22_1.shop_id[iter_22_2]].limit_args[1][3]
				elseif var_0_3[iter_22_1.shop_id[iter_22_2]].group_type == 2 then
					var_22_14 = var_0_3[iter_22_1.shop_id[iter_22_2]].group_limit
				end
			end

			local var_22_15 = getProxy(ApartmentProxy):GetGiftShopCount(iter_22_1.item_id)

			var_22_8 = var_22_9 .. " " .. var_22_15 .. "/" .. var_22_14

			setText(var_22_1:Find("favor/number"), "+" .. pg.dorm3d_favor_trigger[var_0_5[iter_22_1.item_id].favor_trigger_id].num)

			local var_22_16 = var_22_1:Find("favor")

			var_22_16:GetComponent(typeof(CanvasGroup)).alpha = var_22_2 and 0.5 or 1
			var_22_5 = var_22_12.unlock_tips or {}
			var_22_6 = var_22_13:GetShopID()
		elseif iter_22_1.type == 3 then
			var_22_3 = true

			for iter_22_3, iter_22_4 in ipairs(var_0_4[iter_22_1.item_id].invite_icon) do
				if iter_22_4[1] == iter_22_1.room_id then
					var_22_7 = iter_22_4[2]
				end
			end

			var_22_8 = var_22_9 .. " " .. (var_22_2 and 1 or 0) .. "/1"
			var_22_6 = iter_22_1.shop_id[1]
		end

		setActive(var_22_1:Find("bg/normal"), not var_22_3 and not var_22_4)
		setActive(var_22_1:Find("bg/zhuanshu"), var_22_3)
		setActive(var_22_1:Find("bg/tedian"), var_22_4)
		setActive(var_22_1:Find("normal"), not var_22_3 and not var_22_4)
		setActive(var_22_1:Find("zhuanshu"), var_22_3)
		setActive(var_22_1:Find("tedian"), var_22_4)
		setActive(var_22_1:Find("favor"), iter_22_1.type == 2)
		LoadImageSpriteAsync("dorm3dbanner/" .. iter_22_1.banners[1] .. "_shopCard1", var_22_1:Find("bannerMask/banner"), true)
		setText(var_22_1:Find("name"), iter_22_1.name)

		local var_22_17 = var_0_3[iter_22_1.shop_id[1]].time

		setActive(var_22_1:Find("timeLimit"), var_0_3[iter_22_1.shop_id[1]].time ~= "always")

		local var_22_19

		if var_22_17 ~= "always" then
			local var_22_18 = pg.TimeMgr.GetInstance()

			setText(var_22_1:Find("timeLimit/Text"), arg_22_0:GetTimeRemain((var_22_18:parseTimeFromConfig(var_22_17[2]))))

			var_22_19 = arg_22_0
		end

		arg_22_0:SetBubbles(UIItemList.New(var_22_1:Find("bubbles/content"), var_22_1:Find("bubbles/content/tpl")), var_22_5)
		setActive(var_22_1:Find("consume"), not var_22_2)
		setActive(var_22_1:Find("soldOut"), var_22_2)

		local var_22_20 = CommonCommodity.New({
			id = var_22_6
		}, Goods.TYPE_SHOPSTREET)
		local var_22_21, var_22_22, var_22_23 = var_22_20:GetPrice()
		local var_22_24 = Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = var_22_20:GetResType(),
			count = var_22_21
		})

		setText(var_22_1:Find("consume/Text"), "<icon name=" .. var_22_20:GetResIcon() .. " w=0.81 h=0.81/>" .. var_22_21)
		GetImageSpriteFromAtlasAsync(var_22_7, "", var_22_1:Find("normal/Dorm3dIconTpl/icon"))
		GetImageSpriteFromAtlasAsync(var_22_7, "", var_22_1:Find("zhuanshu/Dorm3dIconTpl/icon"))
		GetImageSpriteFromAtlasAsync(var_22_7, "", var_22_1:Find("tedian/Dorm3dIconTpl/icon"))
		setText(var_22_1:Find("normal/countLimit"), var_22_8)
		setText(var_22_1:Find("zhuanshu/countLimit"), var_22_8)
		setText(var_22_1:Find("tedian/countLimit"), var_22_8)

		local var_22_25 = var_22_1:Find("normal/Dorm3dIconTpl")

		var_22_25:GetComponent(typeof(CanvasGroup)).alpha = var_22_2 and 0.5 or 1

		local var_22_26 = var_22_1:Find("zhuanshu/Dorm3dIconTpl")

		var_22_26:GetComponent(typeof(CanvasGroup)).alpha = var_22_2 and 0.5 or 1

		local var_22_27 = var_22_1:Find("tedian/Dorm3dIconTpl")

		var_22_27:GetComponent(typeof(CanvasGroup)).alpha = var_22_2 and 0.5 or 1

		if not var_22_2 then
			onButton(arg_22_0, var_22_1, function()
				arg_22_0:ClickCommodity(iter_22_1, var_22_1:Find("tip"))

				return
			end, SFX_PANEL)
		else
			onButton(arg_22_0, var_22_1, function()
				var_0_0.UpdateCommodtyTip(iter_22_1)
				setActive(var_22_1:Find("tip"), false)
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_sell_out"))

				return
			end, SFX_PANEL)
		end

		local var_22_28 = var_0_0.ShouldShowCommodtyTip(iter_22_1)

		setActive(var_22_1:Find("new"), var_22_28)
		setActive(var_22_1:Find("tip"), var_22_28)
	end

	arg_22_0.scrollSnap:SetUp()

	return
end

function var_0_0.SetGiftCard(arg_25_0)
	local var_25_0 = arg_25_0.recommendationPage:Find("giftCard")
	local var_25_1 = arg_25_0:GetCommoditiesCfgByPanel(2, 1)[1]
	local var_25_2 = 0
	local var_25_3 = arg_25_0:IsCommoditySoldOut(var_25_1)
	local var_25_4 = ""
	local var_25_5 = false
	local var_25_6 = false
	local var_25_7 = var_0_3[var_25_1.shop_id[1]].group_type == 2 and i18n("dorm3d_shop_limit1") or i18n("dorm3d_shop_limit")

	if var_25_1.type == 1 then
		local var_25_8 = var_0_6[var_25_1.item_id]

		var_25_6 = var_0_6[var_25_1.item_id].is_special == 1
		var_25_5 = not (var_25_6 or var_25_8.is_exclusive ~= 1)

		updateCustomDrop(var_25_0:Find("Dorm3dIconTpl"), (Drop.New({
			count = 0,
			type = DROP_TYPE_DORM3D_FURNITURE,
			id = var_25_8.id
		})))

		var_25_2 = var_25_1.shop_id[1]
		var_25_4 = var_25_7 .. " " .. getProxy(ApartmentProxy):GetFurnitureShopCount(var_25_1.item_id) .. "/1"
	elseif var_25_1.type == 2 then
		var_25_5 = var_25_1.room_id ~= 0

		local var_25_10 = Dorm3dGift.New({
			configId = var_25_1.item_id
		})

		;({
			type = DROP_TYPE_DORM3D_GIFT,
			id = var_25_1.item_id
		}).count = getProxy(ApartmentProxy):getGiftCount(var_25_1.item_id)

		setText(var_25_0:Find("favor/number"), "+" .. pg.dorm3d_favor_trigger[var_0_5[var_25_1.item_id].favor_trigger_id].num)
		updateCustomDrop(var_25_0:Find("Dorm3dIconTpl"), (Drop.New({
			type = DROP_TYPE_DORM3D_GIFT,
			id = var_25_1.item_id
		})))

		var_25_2 = var_25_10:GetShopID()

		local var_25_11 = 0

		for iter_25_0 = 1, #var_25_1.shop_id do
			if not var_0_3[var_25_1.shop_id[iter_25_0]].limit_args[1] and var_0_3[var_25_1.shop_id[iter_25_0]].group_type == 0 then
				var_25_11 = 0
			elseif var_0_3[var_25_1.shop_id[iter_25_0]].limit_args[1] and (var_0_3[var_25_1.shop_id[iter_25_0]].limit_args[1][1] == "dailycount" or var_0_3[var_25_1.shop_id[iter_25_0]].limit_args[1][1] == "count") then
				var_25_11 = var_0_3[var_25_1.shop_id[iter_25_0]].limit_args[1][3]
			elseif var_0_3[var_25_1.shop_id[iter_25_0]].group_type == 2 then
				var_25_11 = var_0_3[var_25_1.shop_id[iter_25_0]].group_limit
			end
		end

		var_25_4 = var_25_7 .. " " .. getProxy(ApartmentProxy):GetGiftShopCount(var_25_1.item_id) .. "/" .. var_25_11
	elseif var_25_1.type == 3 then
		var_25_5 = true

		local var_25_12 = ""

		for iter_25_1, iter_25_2 in ipairs(var_0_4[var_25_1.item_id].invite_icon) do
			if iter_25_2[1] == var_25_1.room_id then
				var_25_12 = iter_25_2[2]
			end
		end

		GetImageSpriteFromAtlasAsync(var_25_12, "", var_25_0:Find("Dorm3dIconTpl/icon"))
		GetImageSpriteFromAtlasAsync("weaponframes", "dorm3d_" .. ItemRarity.Rarity2Print(var_25_1.rarity), var_25_0:Find("Dorm3dIconTpl"))

		var_25_4 = var_25_7 .. " " .. (var_25_3 and 1 or 0) .. "/1"
		var_25_2 = var_25_1.shop_id[1]
	end

	local var_25_13 = var_25_0:Find("Dorm3dIconTpl")

	var_25_13:GetComponent(typeof(CanvasGroup)).alpha = var_25_3 and 0.5 or 1

	local var_25_14 = var_25_0:Find("favor")

	var_25_14:GetComponent(typeof(CanvasGroup)).alpha = var_25_3 and 0.5 or 1

	setActive(var_25_0:Find("bg/normal"), not var_25_5 and not var_25_6)
	setActive(var_25_0:Find("bg/zhuanshu"), var_25_5)
	setActive(var_25_0:Find("bg/tedian"), var_25_6)
	setActive(var_25_0:Find("normal"), not var_25_5 and not var_25_6)
	setActive(var_25_0:Find("zhuanshu"), var_25_5)
	setActive(var_25_0:Find("tedian"), var_25_6)
	setText(var_25_0:Find("normal/countLimit"), var_25_4)
	setText(var_25_0:Find("zhuanshu/countLimit"), var_25_4)
	setText(var_25_0:Find("tedian/countLimit"), var_25_4)
	LoadImageSpriteAsync("dorm3dbanner/" .. var_25_1.banners[1] .. "_shopCard2", var_25_0:Find("mask/item"), true)
	setScrollText(var_25_0:Find("name/text"), var_25_1.name)
	setActive(var_25_0:Find("favor"), var_25_1.type == 2)
	setActive(var_25_0:Find("consume"), not var_25_3)
	setActive(var_25_0:Find("soldOut"), var_25_3)

	local var_25_15 = var_0_3[var_25_1.shop_id[1]].time

	setActive(var_25_0:Find("timeLimit"), var_0_3[var_25_1.shop_id[1]].time ~= "always")

	if var_25_15 ~= "always" then
		setText(var_25_0:Find("timeLimit/Text"), arg_25_0:GetTimeRemain((pg.TimeMgr.GetInstance():parseTimeFromConfig(var_25_15[2]))))
	end

	local var_25_16 = CommonCommodity.New({
		id = var_25_2
	}, Goods.TYPE_SHOPSTREET)
	local var_25_17, var_25_18, var_25_19 = var_25_16:GetPrice()
	local var_25_20 = Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = var_25_16:GetResType(),
		count = var_25_17
	})

	setText(var_25_0:Find("consume/Text"), "<icon name=" .. var_25_16:GetResIcon() .. " w=0.81 h=0.81/>" .. var_25_17)

	if not var_25_3 then
		onButton(arg_25_0, var_25_0, function()
			arg_25_0:ClickCommodity(var_25_1, var_25_0:Find("tip"))

			return
		end, SFX_PANEL)
	else
		onButton(arg_25_0, var_25_0, function()
			var_0_0.UpdateCommodtyTip(var_25_1)
			setActive(var_25_0:Find("tip"), false)
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_sell_out"))

			return
		end, SFX_PANEL)
	end

	local var_25_21 = var_0_0.ShouldShowCommodtyTip(var_25_1)

	setActive(var_25_0:Find("new"), var_25_21)
	setActive(var_25_0:Find("tip"), var_25_21)

	return
end

function var_0_0.SetNormalCard(arg_28_0)
	for iter_28_0 = 1, 3 do
		local var_28_0 = arg_28_0.recommendationPage:Find("card" .. iter_28_0)
		local var_28_1 = arg_28_0:GetCommoditiesCfgByPanel(iter_28_0 + 2, 1)[1]
		local var_28_2 = false
		local var_28_3 = false
		local var_28_4 = arg_28_0:IsCommoditySoldOut(var_28_1)
		local var_28_5 = {}
		local var_28_6 = 0
		local var_28_7 = ""
		local var_28_8 = var_0_3[var_28_1.shop_id[1]].group_type == 2 and i18n("dorm3d_shop_limit1") or i18n("dorm3d_shop_limit")

		if var_28_1.type == 1 then
			local var_28_9 = var_0_6[var_28_1.item_id]

			var_28_2 = var_0_6[var_28_1.item_id].is_special == 1
			var_28_3 = not var_28_2 and var_28_9.is_exclusive == 1
			var_28_7 = Drop.New({
				count = 0,
				type = DROP_TYPE_DORM3D_FURNITURE,
				id = var_28_9.id
			}):getIcon()

			local var_28_10 = getProxy(ApartmentProxy)

			setText(var_28_0:Find("countLimit/Text"), var_28_8 .. " " .. var_28_10:GetFurnitureShopCount(var_28_1.item_id) .. "/1")

			var_28_5 = var_28_9.unlock_tips or {}
			var_28_6 = var_28_1.shop_id[1]
		elseif var_28_1.type == 2 then
			local var_28_11 = var_0_5[var_28_1.item_id]

			var_28_3 = var_28_1.room_id ~= 0

			local var_28_12 = Dorm3dGift.New({
				configId = var_28_1.item_id
			})

			;({
				type = DROP_TYPE_DORM3D_GIFT,
				id = var_28_1.item_id
			}).count = getProxy(ApartmentProxy):getGiftCount(var_28_1.item_id)
			var_28_7 = Drop.New({
				type = DROP_TYPE_DORM3D_GIFT,
				id = var_28_1.item_id
			}):getIcon()

			local var_28_13 = 0

			for iter_28_1 = 1, #var_28_1.shop_id do
				if not var_0_3[var_28_1.shop_id[iter_28_1]].limit_args[1] and var_0_3[var_28_1.shop_id[iter_28_1]].group_type == 0 then
					var_28_13 = 0
				elseif var_0_3[var_28_1.shop_id[iter_28_1]].limit_args[1] and (var_0_3[var_28_1.shop_id[iter_28_1]].limit_args[1][1] == "dailycount" or var_0_3[var_28_1.shop_id[iter_28_1]].limit_args[1][1] == "count") then
					var_28_13 = var_0_3[var_28_1.shop_id[iter_28_1]].limit_args[1][3]
				elseif var_0_3[var_28_1.shop_id[iter_28_1]].group_type == 2 then
					var_28_13 = var_0_3[var_28_1.shop_id[iter_28_1]].group_limit
				end
			end

			local var_28_14 = getProxy(ApartmentProxy):GetGiftShopCount(var_28_1.item_id)

			setText(var_28_0:Find("countLimit/Text"), var_28_8 .. " " .. var_28_14 .. "/" .. var_28_13)
			setText(var_28_0:Find("normal/favor/number"), "+" .. pg.dorm3d_favor_trigger[var_0_5[var_28_1.item_id].favor_trigger_id].num)
			setText(var_28_0:Find("zhuanshu/favor/number"), "+" .. pg.dorm3d_favor_trigger[var_0_5[var_28_1.item_id].favor_trigger_id].num)
			setText(var_28_0:Find("tedian/favor/number"), "+" .. pg.dorm3d_favor_trigger[var_0_5[var_28_1.item_id].favor_trigger_id].num)

			var_28_5 = var_28_11.unlock_tips or {}
			var_28_6 = var_28_12:GetShopID()
		elseif var_28_1.type == 3 then
			var_28_3 = true

			for iter_28_2, iter_28_3 in ipairs(var_0_4[var_28_1.item_id].invite_icon) do
				if iter_28_3[1] == var_28_1.room_id then
					var_28_7 = iter_28_3[2]
				end
			end

			setText(var_28_0:Find("countLimit/Text"), var_28_8 .. " " .. (var_28_4 and 1 or 0) .. "/1")

			var_28_6 = var_28_1.shop_id[1]
		end

		setActive(var_28_0:Find("bg/normal"), not var_28_3 and not var_28_2)
		setActive(var_28_0:Find("bg/zhuanshu"), var_28_3)
		setActive(var_28_0:Find("bg/tedian"), var_28_2)
		setActive(var_28_0:Find("normal"), not var_28_3 and not var_28_2)
		setActive(var_28_0:Find("zhuanshu"), var_28_3)
		setActive(var_28_0:Find("tedian"), var_28_2)
		setActive(var_28_0:Find("normal/favor"), var_28_1.type == 2)
		setActive(var_28_0:Find("zhuanshu/favor"), var_28_1.type == 2)
		setActive(var_28_0:Find("tedian/favor"), var_28_1.type == 2)
		setText(var_28_0:Find("name"), var_28_1.name)
		arg_28_0:SetBubbles(UIItemList.New(var_28_0:Find("bubbles/content"), var_28_0:Find("bubbles/content/tpl")), var_28_5)
		setActive(var_28_0:Find("consume"), not var_28_4)
		setActive(var_28_0:Find("soldOut"), var_28_4)

		local var_28_15 = CommonCommodity.New({
			id = var_28_6
		}, Goods.TYPE_SHOPSTREET)
		local var_28_16, var_28_17, var_28_18 = var_28_15:GetPrice()
		local var_28_19 = Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = var_28_15:GetResType(),
			count = var_28_16
		})

		setText(var_28_0:Find("consume/Text"), "<icon name=" .. var_28_15:GetResIcon() .. " w=0.81 h=0.81/>" .. var_28_16)
		GetImageSpriteFromAtlasAsync(var_28_7, "", var_28_0:Find("normal/mask/Dorm3dIconTpl/icon"))
		GetImageSpriteFromAtlasAsync(var_28_7, "", var_28_0:Find("zhuanshu/mask/Dorm3dIconTpl/icon"))
		GetImageSpriteFromAtlasAsync(var_28_7, "", var_28_0:Find("tedian/mask/Dorm3dIconTpl/icon"))

		if not var_28_4 then
			onButton(arg_28_0, var_28_0, function()
				arg_28_0:ClickCommodity(var_28_1, var_28_0:Find("tip"))

				return
			end, SFX_PANEL)
		else
			onButton(arg_28_0, var_28_0, function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_sell_out"))
				var_0_0.UpdateCommodtyTip(var_28_1)
				setActive(var_28_0:Find("tip"), false)

				return
			end, SFX_PANEL)
		end

		local var_28_20 = var_0_0.ShouldShowCommodtyTip(var_28_1)

		setActive(var_28_0:Find("new"), var_28_20)
		setActive(var_28_0:Find("tip"), var_28_20)
	end

	return
end

function var_0_0.SetCharaCard(arg_31_0)
	local var_31_0 = arg_31_0:GetCommoditiesCfgByChara(var_0_4[arg_31_0.selectedId].character[1])
	local var_31_1 = UIItemList.New(arg_31_0.charaPage:Find("scroll/Viewport/Content"), arg_31_0.charaPage:Find("scroll/Viewport/Content/card"))
	local var_31_2 = {}

	var_31_1:make(function(arg_32_0, arg_32_1, arg_32_2)
		if arg_32_0 == UIItemList.EventInit then
			local var_32_0 = var_31_0[arg_32_1 + 1]

			table.insert(var_31_2, {
				var_31_0[arg_32_1 + 1].type,
				arg_32_2
			})

			local var_32_1 = arg_31_0:IsCommoditySoldOut(var_32_0)
			local var_32_2 = false
			local var_32_3 = false
			local var_32_4 = ""
			local var_32_5 = {}
			local var_32_6 = 0
			local var_32_7 = var_0_3[var_32_0.shop_id[1]].group_type == 2 and i18n("dorm3d_shop_limit1") or i18n("dorm3d_shop_limit")

			if var_32_0.type == 1 then
				local var_32_8 = var_0_6[var_32_0.item_id]

				var_32_3 = var_0_6[var_32_0.item_id].is_special == 1
				var_32_2 = not var_32_3 and var_32_8.is_exclusive == 1
				var_32_4 = Drop.New({
					count = 0,
					type = DROP_TYPE_DORM3D_FURNITURE,
					id = var_32_8.id
				}):getIcon()

				setText(arg_32_2:Find("descScroll/Viewport/Content/desc"), var_32_8.desc)
				setText(arg_32_2:Find("countLimit"), var_32_7 .. " " .. getProxy(ApartmentProxy):GetFurnitureShopCount(var_32_0.item_id) .. "/1")

				var_32_5 = var_32_8.unlock_tips or {}
				var_32_6 = var_32_0.shop_id[1]
			elseif var_32_0.type == 2 then
				local var_32_9 = var_0_5[var_32_0.item_id]

				var_32_2 = var_32_0.room_id ~= 0

				local var_32_10 = Dorm3dGift.New({
					configId = var_32_0.item_id
				})

				;({
					type = DROP_TYPE_DORM3D_GIFT,
					id = var_32_0.item_id
				}).count = getProxy(ApartmentProxy):getGiftCount(var_32_0.item_id)
				var_32_4 = Drop.New({
					type = DROP_TYPE_DORM3D_GIFT,
					id = var_32_0.item_id
				}):getIcon()

				setText(arg_32_2:Find("descScroll/Viewport/Content/desc"), var_32_9.display)

				local var_32_11 = 0

				for iter_32_0 = 1, #var_32_0.shop_id do
					if not var_0_3[var_32_0.shop_id[iter_32_0]].limit_args[1] and var_0_3[var_32_0.shop_id[iter_32_0]].group_type == 0 then
						var_32_11 = 0
					elseif var_0_3[var_32_0.shop_id[iter_32_0]].limit_args[1] and (var_0_3[var_32_0.shop_id[iter_32_0]].limit_args[1][1] == "dailycount" or var_0_3[var_32_0.shop_id[iter_32_0]].limit_args[1][1] == "count") then
						var_32_11 = var_0_3[var_32_0.shop_id[iter_32_0]].limit_args[1][3]
					elseif var_0_3[var_32_0.shop_id[iter_32_0]].group_type == 2 then
						var_32_11 = var_0_3[var_32_0.shop_id[iter_32_0]].group_limit
					end
				end

				setText(arg_32_2:Find("countLimit"), var_32_7 .. " " .. getProxy(ApartmentProxy):GetGiftShopCount(var_32_0.item_id) .. "/" .. var_32_11)
				setText(arg_32_2:Find("favor/number"), "+" .. pg.dorm3d_favor_trigger[var_0_5[var_32_0.item_id].favor_trigger_id].num)

				var_32_5 = var_32_9.unlock_tips or {}
				var_32_6 = var_32_10:GetShopID()
			elseif var_32_0.type == 3 then
				var_32_2 = true

				for iter_32_1, iter_32_2 in ipairs(var_0_4[var_32_0.item_id].invite_icon) do
					if iter_32_2[1] == var_32_0.room_id then
						var_32_4 = iter_32_2[2]
					end
				end

				setText(arg_32_2:Find("descScroll/Viewport/Content/desc"), var_0_4[var_32_0.item_id].room_des)
				setText(arg_32_2:Find("countLimit"), var_32_7 .. " " .. (var_32_1 and 1 or 0) .. "/1")

				var_32_6 = var_32_0.shop_id[1]
			end

			setActive(arg_32_2:Find("bg/normal"), not var_32_1)
			setActive(arg_32_2:Find("bg/soldOut"), var_32_1)
			setActive(arg_32_2:Find("normal"), not var_32_2 and not var_32_3)
			setActive(arg_32_2:Find("zhuanshu"), var_32_2)
			setActive(arg_32_2:Find("tedian"), var_32_3)
			GetImageSpriteFromAtlasAsync(var_32_4, "", arg_32_2:Find("mask/Dorm3dIconTpl/icon"))
			setActive(arg_32_2:Find("favor"), var_32_0.type == 2)
			setScrollText(arg_32_2:Find("name/text"), var_32_0.name)
			arg_31_0:SetBubbles(UIItemList.New(arg_32_2:Find("bubbles/content"), arg_32_2:Find("bubbles/content/tpl")), var_32_5)

			local var_32_12 = CommonCommodity.New({
				id = var_32_6
			}, Goods.TYPE_SHOPSTREET)
			local var_32_13, var_32_14, var_32_15 = var_32_12:GetPrice()
			local var_32_16 = Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = var_32_12:GetResType(),
				count = var_32_13
			})

			setText(arg_32_2:Find("consume/Text"), "<icon name=" .. var_32_12:GetResIcon() .. " w=0.81 h=0.81/>" .. var_32_13)
			setActive(arg_32_2:Find("consume"), not var_32_1)
			setActive(arg_32_2:Find("soldOut"), var_32_1)

			local var_32_17 = var_0_3[var_32_0.shop_id[1]].time

			setActive(arg_32_2:Find("timeLimit"), var_0_3[var_32_0.shop_id[1]].time ~= "always")

			if var_32_17 ~= "always" then
				setText(arg_32_2:Find("timeLimit/Text"), arg_31_0:GetTimeRemain((pg.TimeMgr.GetInstance():parseTimeFromConfig(var_32_17[2]))))
			end

			if not var_32_1 then
				onButton(arg_31_0, arg_32_2, function()
					arg_31_0:ClickCommodity(var_32_0, arg_32_2:Find("tip"))

					return
				end, SFX_PANEL)
			else
				onButton(arg_31_0, arg_32_2, function()
					var_0_0.UpdateCommodtyTip(var_32_0)
					setActive(arg_32_2:Find("tip"), false)
					pg.TipsMgr.GetInstance():ShowTips(i18n("word_sell_out"))

					return
				end, SFX_PANEL)
			end

			local var_32_18 = var_0_0.ShouldShowCommodtyTip(var_32_0)

			setActive(arg_32_2:Find("new"), var_32_18)
			setActive(arg_32_2:Find("tip"), var_32_18)
		end

		return
	end)
	var_31_1:align(#arg_31_0:GetCommoditiesCfgByChara(var_0_4[arg_31_0.selectedId].character[1]))

	arg_31_0.filterIndex = 1

	for iter_31_0 = 1, 4 do
		local var_31_3 = arg_31_0.charaPage:Find("switch"):GetChild(iter_31_0 - 1)

		onToggle(arg_31_0, var_31_3, function(arg_35_0)
			if arg_35_0 then
				arg_31_0.filterIndex = iter_31_0

				if iter_31_0 == 1 then
					for iter_35_0, iter_35_1 in ipairs(var_31_2) do
						setActive(iter_35_1[2], true)
					end
				elseif iter_31_0 == 2 then
					for iter_35_2, iter_35_3 in ipairs(var_31_2) do
						setActive(iter_35_3[2], iter_35_3[1] == 2)
					end
				elseif iter_31_0 == 3 then
					for iter_35_4, iter_35_5 in ipairs(var_31_2) do
						setActive(iter_35_5[2], iter_35_5[1] == 1)
					end
				else
					for iter_35_6, iter_35_7 in ipairs(var_31_2) do
						setActive(iter_35_7[2], iter_35_7[1] == 3)
					end
				end

				for iter_35_8 = 1, 4 do
					local var_35_0 = arg_31_0.charaPage:Find("switch"):GetChild(iter_35_8 - 1)

					setActive(var_35_0:Find("selected"), iter_35_8 == iter_31_0)
				end
			end

			return
		end)

		if iter_31_0 == 1 then
			triggerToggle(var_31_3, true)
		end
	end

	return
end

function var_0_0.ClickCommodity(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0.showCount = 1

	if arg_36_1.room_id ~= 0 then
		local var_36_0 = 0

		for iter_36_0, iter_36_1 in pairs(var_0_4) do
			if iter_36_1.type == 2 and iter_36_1.character[1] == arg_36_1.room_id then
				var_36_0 = iter_36_1.id
			end
		end

		if not getProxy(ApartmentProxy):getRoom(var_36_0) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_role_locked"))

			return
		end
	end

	if arg_36_1.realroom_id ~= 0 then
		if not getProxy(ApartmentProxy):getRoom(arg_36_1.realroom_id) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_publicroom_unlock") .. "：" .. pg.dorm3d_rooms[arg_36_1.realroom_id].room)

			return
		end
	end

	var_0_0.UpdateCommodtyTip(arg_36_1)

	if arg_36_2 then
		setActive(arg_36_2, false)
	end

	if arg_36_1.type == 1 then
		local var_36_1 = Dorm3dFurniture.New({
			configId = arg_36_1.item_id
		})
		local var_36_2 = CommonCommodity.New({
			id = arg_36_1.shop_id[1]
		}, Goods.TYPE_SHOPSTREET)
		local var_36_3, var_36_4, var_36_5 = var_36_2:GetPrice()

		arg_36_0:emit(Dorm3dShopMediator.SHOW_SHOPPING_CONFIRM_WINDOW, {
			content = {
				icon = "<icon name=" .. var_36_2:GetResIcon() .. " w=1.1 h=1.1/>",
				off = var_36_4,
				cost = Drop.New({
					type = DROP_TYPE_RESOURCE,
					id = var_36_2:GetResType(),
					count = var_36_3
				}).count,
				old = var_36_5,
				name = arg_36_1.name
			},
			tip = i18n("dorm3d_shop_gift_tip"),
			drop = var_36_1,
			endTime = var_36_1:GetEndTime(),
			onYes = function()
				if not var_36_1:InShopTime() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_purchase_outtime"))

					return
				end

				arg_36_0:emit(GAME.SHOPPING, {
					silentTip = true,
					count = 1,
					shopId = arg_36_1.shop_id[1]
				})

				return
			end
		})
	elseif arg_36_1.type == 2 then
		local var_36_6 = 0

		for iter_36_2 = 1, #arg_36_1.shop_id do
			if not var_0_3[arg_36_1.shop_id[iter_36_2]].limit_args[1] and var_0_3[arg_36_1.shop_id[iter_36_2]].group_type == 0 then
				var_36_6 = 0
			elseif var_0_3[arg_36_1.shop_id[iter_36_2]].limit_args[1] and (var_0_3[arg_36_1.shop_id[iter_36_2]].limit_args[1][1] == "dailycount" or var_0_3[arg_36_1.shop_id[iter_36_2]].limit_args[1][1] == "count") then
				var_36_6 = var_0_3[arg_36_1.shop_id[iter_36_2]].limit_args[1][3]
			elseif var_0_3[arg_36_1.shop_id[iter_36_2]].group_type == 2 then
				var_36_6 = var_0_3[arg_36_1.shop_id[iter_36_2]].group_limit
			end
		end

		if var_36_6 > 1 then
			local var_36_7 = 0

			if arg_36_0.selectedId ~= 0 then
				var_36_7 = var_0_4[arg_36_0.selectedId].character[1]
			end

			arg_36_0:emit(Dorm3dShopMediator.OPEN_DETAIL, arg_36_1, var_36_7, function(arg_38_0)
				arg_36_0.showCount = arg_38_0

				return
			end)
		else
			local var_36_8 = Dorm3dGift.New({
				configId = arg_36_1.item_id
			})
			local var_36_9 = CommonCommodity.New({
				id = var_36_8:GetShopID()
			}, Goods.TYPE_SHOPSTREET)
			local var_36_10, var_36_11, var_36_12 = var_36_9:GetPrice()
			local var_36_13
			local var_36_14 = 0

			_.each(var_36_8:getConfig("shop_id"), function(arg_39_0)
				if var_0_3[arg_39_0].group_type == 2 then
					var_36_14 = math.max(var_0_3[arg_39_0].group_limit, var_36_14)
				end

				return
			end)

			if 0 > 0 then
				({})[1] = getProxy(ApartmentProxy):GetGiftShopCount(var_36_8:GetConfigID())
				;({})[2] = 0
				var_36_13 = {}
			end

			arg_36_0:emit(Dorm3dShopMediator.SHOW_SHOPPING_CONFIRM_WINDOW, {
				content = {
					icon = "<icon name=" .. var_36_9:GetResIcon() .. " w=1.1 h=1.1/>",
					off = var_36_11,
					cost = Drop.New({
						type = DROP_TYPE_RESOURCE,
						id = var_36_9:GetResType(),
						count = var_36_10
					}).count,
					old = var_36_12,
					name = arg_36_1.name,
					weekLimit = var_36_13
				},
				tip = i18n("dorm3d_shop_gift_tip"),
				drop = var_36_8,
				groupId = arg_36_1.room_id,
				onYes = function()
					arg_36_0:emit(GAME.SHOPPING, {
						silentTip = true,
						count = 1,
						shopId = var_36_8:GetShopID()
					})

					return
				end
			})
		end
	elseif arg_36_1.type == 3 then
		local var_36_15
		local var_36_16 = getProxy(ApartmentProxy):getRoom(arg_36_1.item_id)

		if not var_36_16 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_role_locked"))

			return
		end

		if not var_36_16.unlockCharacter[arg_36_1.room_id] then
			var_36_15 = "lock"
		else
			local var_36_17 = getProxy(ApartmentProxy)

			if not var_36_17:getApartment(arg_36_1.room_id) then
				var_36_15 = "room"
			else
				local var_36_18 = Apartment.New({
					ship_group = arg_36_1.room_id
				})

				if var_36_18:needDownload() then
					var_36_15 = "download"
				end
			end
		end

		if var_36_15 == "lock" then
			arg_36_0:emit(Dorm3dShopMediator.OPEN_ROOM_UNLOCK_WINDOW, arg_36_1.item_id, arg_36_1.room_id)
		elseif var_36_15 == "room" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_role_locked"))
		elseif var_36_15 == "download" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_guide_beach_tip"))
		end
	end

	return
end

function var_0_0.SetBubbles(arg_41_0, arg_41_1, arg_41_2)
	arg_41_1:make(function(arg_42_0, arg_42_1, arg_42_2)
		if arg_42_0 == UIItemList.EventInit then
			LoadImageSpriteAtlasAsync("ui/shoptip_atlas", "icon_" .. arg_41_2[arg_42_1 + 1], arg_42_2:Find("icon/icon"), true)
			setText(arg_42_2:Find("bubble/Text"), i18n("dorm3d_shop_tag" .. arg_41_2[arg_42_1 + 1]))
			setActive(arg_42_2:Find("bubble"), false)
			onToggle(arg_41_0, arg_42_2, function(arg_43_0)
				setActive(arg_42_2:Find("icon/select"), arg_43_0)
				setActive(arg_42_2:Find("icon/unselect"), not arg_43_0)
				setActive(arg_42_2:Find("bubble"), arg_43_0)
				setActive(arg_41_0.mask, arg_43_0)
				onButton(arg_41_0, arg_41_0.mask, function()
					triggerToggle(arg_42_2, false)

					return
				end, SFX_PANEL)

				return
			end)
		end

		return
	end)
	arg_41_1:align(#arg_41_2)

	return
end

function var_0_0.GetTimeRemain(arg_45_0, arg_45_1)
	local var_45_9000
	local var_45_0 = pg.TimeMgr.GetInstance()
	local var_45_1 = math.max(arg_45_1 - var_45_0.GetServerTime(var_45_9000), 0)

	if var_45_0 > 0 then
		return math.floor(var_45_1 / 0) .. i18n("word_date")
	else
		local var_45_2 = math.floor(var_45_1 / 16)

		if var_45_2 > 0 then
			return var_45_2 .. i18n("word_hour")
		else
			local var_45_3 = math.floor(var_45_1 / 60)

			if var_45_3 > 0 then
				return var_45_3 .. i18n("word_minute")
			else
				return var_45_1 .. i18n("word_second")
			end
		end
	end

	return
end

function var_0_0.ShouldShowCommodtyTip(arg_46_0)
	if arg_46_0.room_id ~= 0 then
		local var_46_0 = 0

		for iter_46_0, iter_46_1 in ipairs(var_0_4.all) do
			if var_0_4[iter_46_1].type == 2 and var_0_4[iter_46_1].character[1] == arg_46_0.room_id then
				var_46_0 = iter_46_1
			end
		end

		if not getProxy(ApartmentProxy):getRoom(var_46_0) then
			return false
		end
	end

	if arg_46_0.realroom_id ~= 0 then
		if not getProxy(ApartmentProxy):getRoom(arg_46_0.realroom_id) then
			return false
		end
	end

	if arg_46_0.type == 1 then
		return Dorm3dFurniture.NeedViewTipByFurnitureId(arg_46_0.item_id)
	elseif arg_46_0.type == 2 then
		local var_46_1 = var_0_3[arg_46_0.shop_id[1]].group ~= 0 and PlayerPrefs.GetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dGiftWeekViewed_" .. arg_46_0.item_id, 0) == 0

		return Dorm3dGift.NeedViewTipByGiftId(arg_46_0.item_id) or var_46_1
	end

	return false
end

function var_0_0.ShouldShowSumTip(arg_47_0)
	for iter_47_0, iter_47_1 in ipairs(arg_47_0) do
		if var_0_0.ShouldShowCommodtyTip(iter_47_1) then
			return true
		end
	end

	return false
end

function var_0_0.ShouldShowAllTip()
	for iter_48_0, iter_48_1 in ipairs(var_0_2.all) do
		local var_48_0 = false

		for iter_48_2, iter_48_3 in ipairs(var_0_2[iter_48_1].shop_id) do
			local var_48_1 = pg.TimeMgr.GetInstance()

			if not var_48_1:inTime(var_0_3[iter_48_3].time) then
				var_48_0 = true

				break
			end
		end

		if not var_48_0 then
			table.insert({}, var_0_2[iter_48_1])
		end
	end

	return var_0_0.ShouldShowSumTip({})
end

function var_0_0.UpdateCommodtyTip(arg_49_0)
	if arg_49_0.type == 1 then
		Dorm3dFurniture.SetViewedFlag(arg_49_0.item_id)
	elseif arg_49_0.type == 2 then
		Dorm3dGift.SetViewedFlag(arg_49_0.item_id)

		if var_0_3[arg_49_0.shop_id[1]].group ~= 0 then
			PlayerPrefs.SetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dGiftWeekViewed_" .. arg_49_0.item_id, 1)
		end
	end

	return
end

function var_0_0.UpdateSumTip(arg_50_0)
	for iter_50_0, iter_50_1 in ipairs(arg_50_0) do
		var_0_0.UpdateCommodtyTip(iter_50_1)
	end

	return
end

function var_0_0.willExit(arg_51_0)
	arg_51_0.scrollSnap:Dispose()

	arg_51_0.scrollSnap = nil

	return
end

function var_0_0.onBackPressed(arg_52_0)
	arg_52_0:closeView()

	return
end

return var_0_0
