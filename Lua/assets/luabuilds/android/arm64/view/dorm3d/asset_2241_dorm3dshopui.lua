local Dorm3dShopUI = class("Dorm3dShopUI", import("view.base.BaseUI"))
local var_0_1 = pg.dorm3d_set
local var_0_2 = pg.dorm3d_shop_template
local var_0_3 = pg.shop_template
local var_0_4 = pg.dorm3d_rooms
local var_0_5 = pg.dorm3d_gift
local var_0_6 = pg.dorm3d_furniture_template

function Dorm3dShopUI:getUIName()
	return "Dorm3dShopUI"
end

function Dorm3dShopUI:init()
	self.closeBtn = self.rtAdapt:Find("closeBtn")
	self.res = self.rtAdapt:Find("resourceBg/res")
	self.recommendationTg = self.rtAdapt:Find("left/recommendation")
	self.charaList = UIItemList.New(self.rtAdapt:Find("left/charaScroll/mask/list"), self.rtAdapt:Find("left/charaScroll/mask/list/tpl"))
	self.recommendationPage = self.rtAdapt:Find("pages/recommendationPage")
	self.charaPage = self.rtAdapt:Find("pages/charaPage")
	self.mask = self._tf:Find("mask")

	setText(self.rtAdapt:Find("title/Text"), i18n("dorm3d_shop_title"))
	setText(self.recommendationPage:Find("bannerCard/mask/content/item/soldOut"), i18n("dorm3d_shop_sold_out"))
	setText(self.recommendationPage:Find("giftCard/soldOut"), i18n("dorm3d_shop_sold_out"))
	setText(self.recommendationPage:Find("card1/soldOut"), i18n("dorm3d_shop_sold_out"))
	setText(self.recommendationPage:Find("card2/soldOut"), i18n("dorm3d_shop_sold_out"))
	setText(self.recommendationPage:Find("card3/soldOut"), i18n("dorm3d_shop_sold_out"))
	setText(self.charaPage:Find("scroll/Viewport/Content/card/soldOut"), i18n("dorm3d_shop_sold_out"))
	setText(self.charaPage:Find("switch/all/Text"), i18n("dorm3d_shop_all"))
	setText(self.charaPage:Find("switch/gift/Text"), i18n("dorm3d_shop_gift1"))
	setText(self.charaPage:Find("switch/furniture/Text"), i18n("dorm3d_shop_furniture"))
	setText(self.charaPage:Find("switch/others/Text"), i18n("dorm3d_shop_others"))
	setText(self.charaPage:Find("switch/all/selected/Text"), i18n("dorm3d_shop_all"))
	setText(self.charaPage:Find("switch/gift/selected/Text"), i18n("dorm3d_shop_gift1"))
	setText(self.charaPage:Find("switch/furniture/selected/Text"), i18n("dorm3d_shop_furniture"))
	setText(self.charaPage:Find("switch/others/selected/Text"), i18n("dorm3d_shop_others"))

	return
end

function Dorm3dShopUI:didEnter()
	self:InitData()
	onButton(self, self.closeBtn, function()
		self:closeView()

		return
	end, SFX_PANEL)
	self:ShowResUI()
	self:SetPageBtns()
	triggerToggle(self.recommendationTg, true)

	return
end

function Dorm3dShopUI:InitData()
	self.bannerCount = var_0_1.drom3d_shop_product_panel_num.key_value_int
	self.allCommodityCfgs = {}

	for iter_5_0, iter_5_1 in ipairs(var_0_2.all) do
		table.insert(self.allCommodityCfgs, var_0_2[iter_5_1])
	end

	table.sort(self.allCommodityCfgs, function(arg_6_0, arg_6_1)
		if tonumber(arg_6_0.order) ~= tonumber(arg_6_1.order) then
			return tonumber(arg_6_0.order) < tonumber(arg_6_1.order)
		end

		return arg_6_0.id > arg_6_1.id
	end)

	self.roomCfgs = {}

	_.each(var_0_4.all, function(arg_7_0)
		if var_0_4[arg_7_0].type == 2 then
			table.insert(self.roomCfgs, var_0_4[arg_7_0])
		end

		return
	end)
	table.sort(self.roomCfgs, function(arg_8_0, arg_8_1)
		return arg_8_0.id < arg_8_1.id
	end)

	self.selectedId = 0

	return
end

function Dorm3dShopUI:SetPageBtns()
	SetParent(self.recommendationTg, self.rtAdapt:Find("left"), false)
	self.charaList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = self.roomCfgs[arg_10_1 + 1]

			GetImageSpriteFromAtlasAsync(string.format("dorm3dselect/room_icon_%s", string.lower(self.roomCfgs[arg_10_1 + 1].assets_prefix)), "", arg_10_2:Find("mask/icon"), false)
			setActive(arg_10_2:Find("tip"), Dorm3dShopUI.ShouldShowSumTip((self:GetCommoditiesCfgByChara(self.roomCfgs[arg_10_1 + 1].character[1]))))
			onToggle(self, arg_10_2, function(arg_11_0)
				if arg_11_0 then
					self.selectedId = var_10_0.id

					self:SetPageBtns()
					self:RefreshPage()
				end

				return
			end)
		end

		return
	end)
	self.charaList:align(#self.roomCfgs)

	self.showingCommoditiesIndex = {}

	local var_9_0 = {}

	table.insertto(var_9_0, self:GetCommoditiesCfgByPanel(1, self.bannerCount))
	table.insertto(var_9_0, self:GetCommoditiesCfgByPanel(2, 1))
	table.insertto(var_9_0, self:GetCommoditiesCfgByPanel(3, 1))
	table.insertto(var_9_0, self:GetCommoditiesCfgByPanel(4, 1))
	table.insertto(var_9_0, self:GetCommoditiesCfgByPanel(5, 1))
	setActive(self.recommendationTg:Find("icon/tip"), Dorm3dShopUI.ShouldShowSumTip(var_9_0))
	onToggle(self, self.recommendationTg, function(arg_12_0)
		if arg_12_0 then
			self.selectedId = 0

			self:SetPageBtns()
			self:RefreshPage()
		end

		return
	end)
	SetParent(self.recommendationTg, self.rtAdapt:Find("left/charaScroll/mask/list"), false)
	self.recommendationTg:SetSiblingIndex(0)

	return
end

function Dorm3dShopUI:GetCommoditiesCfgByPanel(arg_13_1, arg_13_2)
	local var_13_0 = {}
	local var_13_1 = 0

	for iter_13_0, iter_13_1 in ipairs(self.allCommodityCfgs) do
		if not table.contains(self.showingCommoditiesIndex, iter_13_0) and table.contains(iter_13_1.panel, arg_13_1) then
			if not (self:IsCommodityOutOfDate(iter_13_1) or self:IsCommoditySoldOut(iter_13_1)) then
				var_13_1 = var_13_1 + 1

				table.insert(var_13_0, iter_13_1)
				table.insert(self.showingCommoditiesIndex, iter_13_0)
			end

			if var_13_1 == arg_13_2 then
				break
			end
		end
	end

	if var_13_1 < arg_13_2 then
		for iter_13_2, iter_13_3 in ipairs(self.allCommodityCfgs) do
			if not table.contains(self.showingCommoditiesIndex, iter_13_2) and table.contains(iter_13_3.panel, arg_13_1) then
				if not self:IsCommodityOutOfDate(iter_13_3) then
					var_13_1 = var_13_1 + 1

					table.insert(var_13_0, iter_13_3)
					table.insert(self.showingCommoditiesIndex, iter_13_2)
				end

				if var_13_1 == arg_13_2 then
					break
				end
			end
		end
	end

	return var_13_0
end

function Dorm3dShopUI:GetCommoditiesCfgByChara(arg_14_1)
	local var_14_0 = {}
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in ipairs(self.allCommodityCfgs) do
		local var_14_2 = {}

		if iter_14_1.realroom_id ~= 0 then
			table.insertto(var_14_2, var_0_4[iter_14_1.realroom_id].character)
			table.insertto(var_14_2, var_0_4[iter_14_1.realroom_id].character_pay)
		end

		if iter_14_1.room_id == arg_14_1 or iter_14_1.room_id == 0 then
			if iter_14_1.realroom_id ~= 0 then
				if iter_14_1.realroom_id ~= 0 and table.contains(var_14_2, arg_14_1) then
					if not self:IsCommodityOutOfDate(iter_14_1) then
						if not self:IsCommoditySoldOut(iter_14_1) then
							table.insert(var_14_0, iter_14_1)
						else
							table.insert(var_14_1, iter_14_1)
						end
					end
				end
			end
		end
	end

	if #var_14_1 > 0 then
		table.insertto(var_14_0, var_14_1)
	end

	return var_14_0
end

function Dorm3dShopUI:IsCommodityOutOfDate(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1.shop_id) do
		if not pg.TimeMgr.GetInstance():inTime(var_0_3[iter_15_1].time) then
			return true
		end
	end

	return false
end

function Dorm3dShopUI:IsCommoditySoldOut(arg_16_1)
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

function Dorm3dShopUI:ShowResUI()
	self.goldMax = self.res:Find("gold/max"):GetComponent(typeof(Text))
	self.goldValue = self.res:Find("gold/Text"):GetComponent(typeof(Text))
	self.oilMax = self.res:Find("oil/max"):GetComponent(typeof(Text))
	self.oilValue = self.res:Find("oil/Text"):GetComponent(typeof(Text))
	self.gemValue = self.res:Find("gem/Text"):GetComponent(typeof(Text))

	PlayerResUI.StaticFlush(getProxy(PlayerProxy):getRawData(), self.goldMax, self.goldValue, self.oilMax, self.oilValue, self.gemValue)
	onButton(self, self.res:Find("gold"), function()
		pg.playerResUI:ClickGold()

		return
	end, SFX_PANEL)
	onButton(self, self.res:Find("oil"), function()
		pg.playerResUI:ClickOil()

		return
	end, SFX_PANEL)
	onButton(self, self.res:Find("gem"), function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)

	return
end

function Dorm3dShopUI:RefreshPage()
	self.showingCommoditiesIndex = {}

	setActive(self.recommendationPage, self.selectedId == 0)
	setActive(self.charaPage, self.selectedId ~= 0)

	if self.selectedId == 0 then
		self:SetBannnerCard()
		self:SetGiftCard()
		self:SetNormalCard()
	else
		self:SetCharaCard()
	end

	return
end

function Dorm3dShopUI:SetBannnerCard()
	local var_22_0 = self.recommendationPage:Find("bannerCard")

	self.scrollSnap = self.scrollSnap or BannerScrollRectDorm3dShop.New(var_22_0:Find("mask/content"), var_22_0:Find("dots"))

	for iter_22_0, iter_22_1 in ipairs((self:GetCommoditiesCfgByPanel(1, self.bannerCount))) do
		local var_22_1 = self.scrollSnap:GetItemChild(iter_22_0) or self.scrollSnap:AddChild()
		local var_22_2 = self:IsCommoditySoldOut(iter_22_1)
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
			var_22_8 = var_22_9 .. " " .. getProxy(ApartmentProxy):GetFurnitureShopCount(iter_22_1.item_id) .. "/1"
			var_22_5 = var_22_10.unlock_tips or {}
			var_22_6 = iter_22_1.shop_id[1]
		elseif iter_22_1.type == 2 then
			local var_22_11 = var_0_5[iter_22_1.item_id]

			var_22_3 = iter_22_1.room_id ~= 0

			local var_22_12 = Dorm3dGift.New({
				configId = iter_22_1.item_id
			})
			local var_22_13 = {
				type = DROP_TYPE_DORM3D_GIFT,
				id = iter_22_1.item_id
			}

			var_22_13.count = getProxy(ApartmentProxy):getGiftCount(iter_22_1.item_id)
			var_22_7 = Drop.New(var_22_13):getIcon()

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

			var_22_8 = var_22_9 .. " " .. getProxy(ApartmentProxy):GetGiftShopCount(iter_22_1.item_id) .. "/" .. var_22_14

			setText(var_22_1:Find("favor/number"), "+" .. pg.dorm3d_favor_trigger[var_0_5[iter_22_1.item_id].favor_trigger_id].num)

			var_22_1:Find("favor"):GetComponent(typeof(CanvasGroup)).alpha = var_22_2 and 0.5 or 1
			var_22_5 = var_22_11.unlock_tips or {}
			var_22_6 = var_22_12:GetShopID()
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

		local var_22_15 = var_0_3[iter_22_1.shop_id[1]].time

		setActive(var_22_1:Find("timeLimit"), var_0_3[iter_22_1.shop_id[1]].time ~= "always")

		if var_22_15 ~= "always" then
			setText(var_22_1:Find("timeLimit/Text"), self:GetTimeRemain((pg.TimeMgr.GetInstance():parseTimeFromConfig(var_22_15[2]))))
		end

		self:SetBubbles(UIItemList.New(var_22_1:Find("bubbles/content"), var_22_1:Find("bubbles/content/tpl")), var_22_5)
		setActive(var_22_1:Find("consume"), not var_22_2)
		setActive(var_22_1:Find("soldOut"), var_22_2)

		local var_22_16 = CommonCommodity.New({
			id = var_22_6
		}, Goods.TYPE_SHOPSTREET)
		local var_22_17, var_22_18, var_22_19 = var_22_16:GetPrice()
		local var_22_20 = Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = var_22_16:GetResType(),
			count = var_22_17
		})

		setText(var_22_1:Find("consume/Text"), "<icon name=" .. var_22_16:GetResIcon() .. " w=0.81 h=0.81/>" .. var_22_17)
		GetImageSpriteFromAtlasAsync(var_22_7, "", var_22_1:Find("normal/Dorm3dIconTpl/icon"))
		GetImageSpriteFromAtlasAsync(var_22_7, "", var_22_1:Find("zhuanshu/Dorm3dIconTpl/icon"))
		GetImageSpriteFromAtlasAsync(var_22_7, "", var_22_1:Find("tedian/Dorm3dIconTpl/icon"))
		setText(var_22_1:Find("normal/countLimit"), var_22_8)
		setText(var_22_1:Find("zhuanshu/countLimit"), var_22_8)
		setText(var_22_1:Find("tedian/countLimit"), var_22_8)

		var_22_1:Find("normal/Dorm3dIconTpl"):GetComponent(typeof(CanvasGroup)).alpha = var_22_2 and 0.5 or 1
		var_22_1:Find("zhuanshu/Dorm3dIconTpl"):GetComponent(typeof(CanvasGroup)).alpha = var_22_2 and 0.5 or 1
		var_22_1:Find("tedian/Dorm3dIconTpl"):GetComponent(typeof(CanvasGroup)).alpha = var_22_2 and 0.5 or 1

		if not var_22_2 then
			onButton(self, var_22_1, function()
				self:ClickCommodity(iter_22_1, var_22_1:Find("tip"))

				return
			end, SFX_PANEL)
		else
			onButton(self, var_22_1, function()
				Dorm3dShopUI.UpdateCommodtyTip(iter_22_1)
				setActive(var_22_1:Find("tip"), false)
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_sell_out"))

				return
			end, SFX_PANEL)
		end

		local var_22_21 = Dorm3dShopUI.ShouldShowCommodtyTip(iter_22_1)

		setActive(var_22_1:Find("new"), var_22_21)
		setActive(var_22_1:Find("tip"), var_22_21)
	end

	self.scrollSnap:SetUp()

	return
end

function Dorm3dShopUI:SetGiftCard()
	local var_25_0 = self.recommendationPage:Find("giftCard")
	local var_25_1 = self:GetCommoditiesCfgByPanel(2, 1)[1]
	local var_25_2 = 0
	local var_25_3 = self:IsCommoditySoldOut(var_25_1)
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
		local var_25_11 = {
			type = DROP_TYPE_DORM3D_GIFT,
			id = var_25_1.item_id
		}

		var_25_11.count = getProxy(ApartmentProxy):getGiftCount(var_25_1.item_id)

		setText(var_25_0:Find("favor/number"), "+" .. pg.dorm3d_favor_trigger[var_0_5[var_25_1.item_id].favor_trigger_id].num)
		updateCustomDrop(var_25_0:Find("Dorm3dIconTpl"), (Drop.New(var_25_11)))

		var_25_2 = var_25_10:GetShopID()

		local var_25_12 = 0

		for iter_25_0 = 1, #var_25_1.shop_id do
			if not var_0_3[var_25_1.shop_id[iter_25_0]].limit_args[1] and var_0_3[var_25_1.shop_id[iter_25_0]].group_type == 0 then
				var_25_12 = 0
			elseif var_0_3[var_25_1.shop_id[iter_25_0]].limit_args[1] and (var_0_3[var_25_1.shop_id[iter_25_0]].limit_args[1][1] == "dailycount" or var_0_3[var_25_1.shop_id[iter_25_0]].limit_args[1][1] == "count") then
				var_25_12 = var_0_3[var_25_1.shop_id[iter_25_0]].limit_args[1][3]
			elseif var_0_3[var_25_1.shop_id[iter_25_0]].group_type == 2 then
				var_25_12 = var_0_3[var_25_1.shop_id[iter_25_0]].group_limit
			end
		end

		var_25_4 = var_25_7 .. " " .. getProxy(ApartmentProxy):GetGiftShopCount(var_25_1.item_id) .. "/" .. var_25_12
	elseif var_25_1.type == 3 then
		var_25_5 = true

		local var_25_13 = ""

		for iter_25_1, iter_25_2 in ipairs(var_0_4[var_25_1.item_id].invite_icon) do
			if iter_25_2[1] == var_25_1.room_id then
				var_25_13 = iter_25_2[2]
			end
		end

		GetImageSpriteFromAtlasAsync(var_25_13, "", var_25_0:Find("Dorm3dIconTpl/icon"))
		GetImageSpriteFromAtlasAsync("weaponframes", "dorm3d_" .. ItemRarity.Rarity2Print(var_25_1.rarity), var_25_0:Find("Dorm3dIconTpl"))

		var_25_4 = var_25_7 .. " " .. (var_25_3 and 1 or 0) .. "/1"
		var_25_2 = var_25_1.shop_id[1]
	end

	var_25_0:Find("Dorm3dIconTpl"):GetComponent(typeof(CanvasGroup)).alpha = var_25_3 and 0.5 or 1
	var_25_0:Find("favor"):GetComponent(typeof(CanvasGroup)).alpha = var_25_3 and 0.5 or 1

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

	local var_25_14 = var_0_3[var_25_1.shop_id[1]].time

	setActive(var_25_0:Find("timeLimit"), var_0_3[var_25_1.shop_id[1]].time ~= "always")

	if var_25_14 ~= "always" then
		setText(var_25_0:Find("timeLimit/Text"), self:GetTimeRemain((pg.TimeMgr.GetInstance():parseTimeFromConfig(var_25_14[2]))))
	end

	local var_25_15 = CommonCommodity.New({
		id = var_25_2
	}, Goods.TYPE_SHOPSTREET)
	local var_25_16, var_25_17, var_25_18 = var_25_15:GetPrice()
	local var_25_19 = Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = var_25_15:GetResType(),
		count = var_25_16
	})

	setText(var_25_0:Find("consume/Text"), "<icon name=" .. var_25_15:GetResIcon() .. " w=0.81 h=0.81/>" .. var_25_16)

	if not var_25_3 then
		onButton(self, var_25_0, function()
			self:ClickCommodity(var_25_1, var_25_0:Find("tip"))

			return
		end, SFX_PANEL)
	else
		onButton(self, var_25_0, function()
			Dorm3dShopUI.UpdateCommodtyTip(var_25_1)
			setActive(var_25_0:Find("tip"), false)
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_sell_out"))

			return
		end, SFX_PANEL)
	end

	local var_25_20 = Dorm3dShopUI.ShouldShowCommodtyTip(var_25_1)

	setActive(var_25_0:Find("new"), var_25_20)
	setActive(var_25_0:Find("tip"), var_25_20)

	return
end

function Dorm3dShopUI:SetNormalCard()
	for iter_28_0 = 1, 3 do
		local var_28_0 = self.recommendationPage:Find("card" .. iter_28_0)
		local var_28_1 = self:GetCommoditiesCfgByPanel(iter_28_0 + 2, 1)[1]
		local var_28_2 = false
		local var_28_3 = false
		local var_28_4 = self:IsCommoditySoldOut(var_28_1)
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

			setText(var_28_0:Find("countLimit/Text"), var_28_8 .. " " .. getProxy(ApartmentProxy):GetFurnitureShopCount(var_28_1.item_id) .. "/1")

			var_28_5 = var_28_9.unlock_tips or {}
			var_28_6 = var_28_1.shop_id[1]
		elseif var_28_1.type == 2 then
			local var_28_10 = var_0_5[var_28_1.item_id]

			var_28_3 = var_28_1.room_id ~= 0

			local var_28_11 = Dorm3dGift.New({
				configId = var_28_1.item_id
			})
			local var_28_12 = {
				type = DROP_TYPE_DORM3D_GIFT,
				id = var_28_1.item_id
			}

			var_28_12.count = getProxy(ApartmentProxy):getGiftCount(var_28_1.item_id)
			var_28_7 = Drop.New(var_28_12):getIcon()

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

			setText(var_28_0:Find("countLimit/Text"), var_28_8 .. " " .. getProxy(ApartmentProxy):GetGiftShopCount(var_28_1.item_id) .. "/" .. var_28_13)
			setText(var_28_0:Find("normal/favor/number"), "+" .. pg.dorm3d_favor_trigger[var_0_5[var_28_1.item_id].favor_trigger_id].num)
			setText(var_28_0:Find("zhuanshu/favor/number"), "+" .. pg.dorm3d_favor_trigger[var_0_5[var_28_1.item_id].favor_trigger_id].num)
			setText(var_28_0:Find("tedian/favor/number"), "+" .. pg.dorm3d_favor_trigger[var_0_5[var_28_1.item_id].favor_trigger_id].num)

			var_28_5 = var_28_10.unlock_tips or {}
			var_28_6 = var_28_11:GetShopID()
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
		self:SetBubbles(UIItemList.New(var_28_0:Find("bubbles/content"), var_28_0:Find("bubbles/content/tpl")), var_28_5)
		setActive(var_28_0:Find("consume"), not var_28_4)
		setActive(var_28_0:Find("soldOut"), var_28_4)

		local var_28_14 = CommonCommodity.New({
			id = var_28_6
		}, Goods.TYPE_SHOPSTREET)
		local var_28_15, var_28_16, var_28_17 = var_28_14:GetPrice()
		local var_28_18 = Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = var_28_14:GetResType(),
			count = var_28_15
		})

		setText(var_28_0:Find("consume/Text"), "<icon name=" .. var_28_14:GetResIcon() .. " w=0.81 h=0.81/>" .. var_28_15)
		GetImageSpriteFromAtlasAsync(var_28_7, "", var_28_0:Find("normal/mask/Dorm3dIconTpl/icon"))
		GetImageSpriteFromAtlasAsync(var_28_7, "", var_28_0:Find("zhuanshu/mask/Dorm3dIconTpl/icon"))
		GetImageSpriteFromAtlasAsync(var_28_7, "", var_28_0:Find("tedian/mask/Dorm3dIconTpl/icon"))

		if not var_28_4 then
			onButton(self, var_28_0, function()
				self:ClickCommodity(var_28_1, var_28_0:Find("tip"))

				return
			end, SFX_PANEL)
		else
			onButton(self, var_28_0, function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_sell_out"))
				Dorm3dShopUI.UpdateCommodtyTip(var_28_1)
				setActive(var_28_0:Find("tip"), false)

				return
			end, SFX_PANEL)
		end

		local var_28_19 = Dorm3dShopUI.ShouldShowCommodtyTip(var_28_1)

		setActive(var_28_0:Find("new"), var_28_19)
		setActive(var_28_0:Find("tip"), var_28_19)
	end

	return
end

function Dorm3dShopUI:SetCharaCard()
	local var_31_0 = self:GetCommoditiesCfgByChara(var_0_4[self.selectedId].character[1])
	local var_31_1 = UIItemList.New(self.charaPage:Find("scroll/Viewport/Content"), self.charaPage:Find("scroll/Viewport/Content/card"))
	local var_31_2 = {}

	var_31_1:make(function(arg_32_0, arg_32_1, arg_32_2)
		if arg_32_0 == UIItemList.EventInit then
			local var_32_0 = var_31_0[arg_32_1 + 1]

			table.insert(var_31_2, {
				var_31_0[arg_32_1 + 1].type,
				arg_32_2
			})

			local var_32_1 = self:IsCommoditySoldOut(var_32_0)
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
				local var_32_11 = {
					type = DROP_TYPE_DORM3D_GIFT,
					id = var_32_0.item_id
				}

				var_32_11.count = getProxy(ApartmentProxy):getGiftCount(var_32_0.item_id)
				var_32_4 = Drop.New(var_32_11):getIcon()

				setText(arg_32_2:Find("descScroll/Viewport/Content/desc"), var_32_9.display)

				local var_32_12 = 0

				for iter_32_0 = 1, #var_32_0.shop_id do
					if not var_0_3[var_32_0.shop_id[iter_32_0]].limit_args[1] and var_0_3[var_32_0.shop_id[iter_32_0]].group_type == 0 then
						var_32_12 = 0
					elseif var_0_3[var_32_0.shop_id[iter_32_0]].limit_args[1] and (var_0_3[var_32_0.shop_id[iter_32_0]].limit_args[1][1] == "dailycount" or var_0_3[var_32_0.shop_id[iter_32_0]].limit_args[1][1] == "count") then
						var_32_12 = var_0_3[var_32_0.shop_id[iter_32_0]].limit_args[1][3]
					elseif var_0_3[var_32_0.shop_id[iter_32_0]].group_type == 2 then
						var_32_12 = var_0_3[var_32_0.shop_id[iter_32_0]].group_limit
					end
				end

				setText(arg_32_2:Find("countLimit"), var_32_7 .. " " .. getProxy(ApartmentProxy):GetGiftShopCount(var_32_0.item_id) .. "/" .. var_32_12)
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
			self:SetBubbles(UIItemList.New(arg_32_2:Find("bubbles/content"), arg_32_2:Find("bubbles/content/tpl")), var_32_5)

			local var_32_13 = CommonCommodity.New({
				id = var_32_6
			}, Goods.TYPE_SHOPSTREET)
			local var_32_14, var_32_15, var_32_16 = var_32_13:GetPrice()
			local var_32_17 = Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = var_32_13:GetResType(),
				count = var_32_14
			})

			setText(arg_32_2:Find("consume/Text"), "<icon name=" .. var_32_13:GetResIcon() .. " w=0.81 h=0.81/>" .. var_32_14)
			setActive(arg_32_2:Find("consume"), not var_32_1)
			setActive(arg_32_2:Find("soldOut"), var_32_1)

			local var_32_18 = var_0_3[var_32_0.shop_id[1]].time

			setActive(arg_32_2:Find("timeLimit"), var_0_3[var_32_0.shop_id[1]].time ~= "always")

			if var_32_18 ~= "always" then
				setText(arg_32_2:Find("timeLimit/Text"), self:GetTimeRemain((pg.TimeMgr.GetInstance():parseTimeFromConfig(var_32_18[2]))))
			end

			if not var_32_1 then
				onButton(self, arg_32_2, function()
					self:ClickCommodity(var_32_0, arg_32_2:Find("tip"))

					return
				end, SFX_PANEL)
			else
				onButton(self, arg_32_2, function()
					Dorm3dShopUI.UpdateCommodtyTip(var_32_0)
					setActive(arg_32_2:Find("tip"), false)
					pg.TipsMgr.GetInstance():ShowTips(i18n("word_sell_out"))

					return
				end, SFX_PANEL)
			end

			local var_32_19 = Dorm3dShopUI.ShouldShowCommodtyTip(var_32_0)

			setActive(arg_32_2:Find("new"), var_32_19)
			setActive(arg_32_2:Find("tip"), var_32_19)
		end

		return
	end)
	var_31_1:align(#var_31_0)

	self.filterIndex = 1

	for iter_31_0 = 1, 4 do
		local var_31_3 = self.charaPage:Find("switch"):GetChild(iter_31_0 - 1)

		onToggle(self, var_31_3, function(arg_35_0)
			if arg_35_0 then
				self.filterIndex = iter_31_0

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
					setActive(self.charaPage:Find("switch"):GetChild(iter_35_8 - 1):Find("selected"), iter_35_8 == iter_31_0)
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

function Dorm3dShopUI:ClickCommodity(arg_36_1, arg_36_2)
	self.showCount = 1

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

	Dorm3dShopUI.UpdateCommodtyTip(arg_36_1)

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

		self:emit(Dorm3dShopMediator.SHOW_SHOPPING_CONFIRM_WINDOW, {
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

				self:emit(GAME.SHOPPING, {
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
			self:emit(Dorm3dShopMediator.OPEN_DETAIL, arg_36_1, (self.selectedId ~= 0 or nil) and var_0_4[self.selectedId].character[1], function(arg_38_0)
				self.showCount = arg_38_0

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
				local var_36_15 = {}

				var_36_15[1] = getProxy(ApartmentProxy):GetGiftShopCount(var_36_8:GetConfigID())
				var_36_15[2] = 0
				var_36_13 = var_36_15
			end

			self:emit(Dorm3dShopMediator.SHOW_SHOPPING_CONFIRM_WINDOW, {
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
					self:emit(GAME.SHOPPING, {
						silentTip = true,
						count = 1,
						shopId = var_36_8:GetShopID()
					})

					return
				end
			})
		end
	elseif arg_36_1.type == 3 then
		local var_36_16
		local var_36_17 = getProxy(ApartmentProxy):getRoom(arg_36_1.item_id)

		if not var_36_17 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_role_locked"))

			return
		end

		if not var_36_17.unlockCharacter[arg_36_1.room_id] then
			var_36_16 = "lock"
		elseif not getProxy(ApartmentProxy):getApartment(arg_36_1.room_id) then
			var_36_16 = "room"
		elseif Apartment.New({
			ship_group = arg_36_1.room_id
		}):needDownload() then
			var_36_16 = "download"
		end

		if var_36_16 == "lock" then
			self:emit(Dorm3dShopMediator.OPEN_ROOM_UNLOCK_WINDOW, arg_36_1.item_id, arg_36_1.room_id)
		elseif var_36_16 == "room" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_role_locked"))
		elseif var_36_16 == "download" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_guide_beach_tip"))
		end
	end

	return
end

function Dorm3dShopUI:SetBubbles(arg_41_1, arg_41_2)
	arg_41_1:make(function(arg_42_0, arg_42_1, arg_42_2)
		if arg_42_0 == UIItemList.EventInit then
			LoadImageSpriteAtlasAsync("ui/shoptip_atlas", "icon_" .. arg_41_2[arg_42_1 + 1], arg_42_2:Find("icon/icon"), true)
			setText(arg_42_2:Find("bubble/Text"), i18n("dorm3d_shop_tag" .. arg_41_2[arg_42_1 + 1]))
			setActive(arg_42_2:Find("bubble"), false)
			onToggle(self, arg_42_2, function(arg_43_0)
				setActive(arg_42_2:Find("icon/select"), arg_43_0)
				setActive(arg_42_2:Find("icon/unselect"), not arg_43_0)
				setActive(arg_42_2:Find("bubble"), arg_43_0)
				setActive(self.mask, arg_43_0)
				onButton(self, self.mask, function()
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

function Dorm3dShopUI:GetTimeRemain(arg_45_1)
	local var_45_0 = pg.TimeMgr.GetInstance()
	local var_45_1 = math.max(arg_45_1 - var_45_0:GetServerTime(), 0)

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

function Dorm3dShopUI:ShouldShowCommodtyTip()
	if self.room_id ~= 0 then
		local var_46_0 = 0

		for iter_46_0, iter_46_1 in ipairs(var_0_4.all) do
			if var_0_4[iter_46_1].type == 2 and var_0_4[iter_46_1].character[1] == self.room_id then
				var_46_0 = iter_46_1
			end
		end

		if not getProxy(ApartmentProxy):getRoom(var_46_0) then
			return false
		end
	end

	if self.realroom_id ~= 0 then
		if not getProxy(ApartmentProxy):getRoom(self.realroom_id) then
			return false
		end
	end

	if self.type == 1 then
		return Dorm3dFurniture.NeedViewTipByFurnitureId(self.item_id)
	elseif self.type == 2 then
		return Dorm3dGift.NeedViewTipByGiftId(self.item_id) or var_0_3[self.shop_id[1]].group ~= 0 and PlayerPrefs.GetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dGiftWeekViewed_" .. self.item_id, 0) == 0
	end

	return false
end

function Dorm3dShopUI:ShouldShowSumTip()
	for iter_47_0, iter_47_1 in ipairs(self) do
		if Dorm3dShopUI.ShouldShowCommodtyTip(iter_47_1) then
			return true
		end
	end

	return false
end

function Dorm3dShopUI.ShouldShowAllTip()
	local var_48_0 = {}

	for iter_48_0, iter_48_1 in ipairs(var_0_2.all) do
		local var_48_1 = false

		for iter_48_2, iter_48_3 in ipairs(var_0_2[iter_48_1].shop_id) do
			if not pg.TimeMgr.GetInstance():inTime(var_0_3[iter_48_3].time) then
				var_48_1 = true

				break
			end
		end

		if not var_48_1 then
			table.insert(var_48_0, var_0_2[iter_48_1])
		end
	end

	return Dorm3dShopUI.ShouldShowSumTip(var_48_0)
end

function Dorm3dShopUI:UpdateCommodtyTip()
	if self.type == 1 then
		Dorm3dFurniture.SetViewedFlag(self.item_id)
	elseif self.type == 2 then
		Dorm3dGift.SetViewedFlag(self.item_id)

		if var_0_3[self.shop_id[1]].group ~= 0 then
			PlayerPrefs.SetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dGiftWeekViewed_" .. self.item_id, 1)
		end
	end

	return
end

function Dorm3dShopUI:UpdateSumTip()
	for iter_50_0, iter_50_1 in ipairs(self) do
		Dorm3dShopUI.UpdateCommodtyTip(iter_50_1)
	end

	return
end

function Dorm3dShopUI:willExit()
	self.scrollSnap:Dispose()

	self.scrollSnap = nil

	return
end

function Dorm3dShopUI:onBackPressed()
	self:closeView()

	return
end

return Dorm3dShopUI
