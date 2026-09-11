local Dorm3dShopUI = class("Dorm3dShopUI", import("view.base.BaseUI"))
local var_0_1 = pg.dorm3d_set
local var_0_2 = pg.dorm3d_shop_template
local var_0_3 = setmetatable({}, {
	__index = function(self, arg_1_1)
		self[arg_1_1] = ShopConst.GetShopConfig(arg_1_1)

		return self[arg_1_1]
	end
})
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

	for iter_6_0, iter_6_1 in ipairs(var_0_2.all) do
		table.insert(self.allCommodityCfgs, var_0_2[iter_6_1])
	end

	table.sort(self.allCommodityCfgs, function(arg_7_0, arg_7_1)
		if tonumber(arg_7_0.order) ~= tonumber(arg_7_1.order) then
			return tonumber(arg_7_0.order) < tonumber(arg_7_1.order)
		end

		return arg_7_0.id > arg_7_1.id
	end)

	self.roomCfgs = {}

	_.each(var_0_4.all, function(arg_8_0)
		if var_0_4[arg_8_0].type == 2 then
			table.insert(self.roomCfgs, var_0_4[arg_8_0])
		end

		return
	end)
	table.sort(self.roomCfgs, function(arg_9_0, arg_9_1)
		return arg_9_0.id < arg_9_1.id
	end)

	self.selectedId = 0

	return
end

function Dorm3dShopUI:SetPageBtns()
	SetParent(self.recommendationTg, self.rtAdapt:Find("left"), false)
	self.charaList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = self.roomCfgs[arg_11_1 + 1]

			GetImageSpriteFromAtlasAsync(string.format("dorm3dselect/room_icon_%s", string.lower(self.roomCfgs[arg_11_1 + 1].assets_prefix)), "", arg_11_2:Find("mask/icon"), false)
			setActive(arg_11_2:Find("tip"), Dorm3dShopUI.ShouldShowSumTip((self:GetCommoditiesCfgByChara(self.roomCfgs[arg_11_1 + 1].character[1]))))
			onToggle(self, arg_11_2, function(arg_12_0)
				if arg_12_0 then
					self.selectedId = var_11_0.id

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

	local var_10_0 = {}

	table.insertto(var_10_0, self:GetCommoditiesCfgByPanel(1, self.bannerCount))
	table.insertto(var_10_0, self:GetCommoditiesCfgByPanel(2, 1))
	table.insertto(var_10_0, self:GetCommoditiesCfgByPanel(3, 1))
	table.insertto(var_10_0, self:GetCommoditiesCfgByPanel(4, 1))
	table.insertto(var_10_0, self:GetCommoditiesCfgByPanel(5, 1))
	setActive(self.recommendationTg:Find("icon/tip"), Dorm3dShopUI.ShouldShowSumTip(var_10_0))
	onToggle(self, self.recommendationTg, function(arg_13_0)
		if arg_13_0 then
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

function Dorm3dShopUI:GetCommoditiesCfgByPanel(arg_14_1, arg_14_2)
	local var_14_0 = {}
	local var_14_1 = 0

	for iter_14_0, iter_14_1 in ipairs(self.allCommodityCfgs) do
		if not table.contains(self.showingCommoditiesIndex, iter_14_0) and table.contains(iter_14_1.panel, arg_14_1) then
			if not (self:IsCommodityOutOfDate(iter_14_1) or self:IsCommoditySoldOut(iter_14_1)) then
				var_14_1 = var_14_1 + 1

				table.insert(var_14_0, iter_14_1)
				table.insert(self.showingCommoditiesIndex, iter_14_0)
			end

			if var_14_1 == arg_14_2 then
				break
			end
		end
	end

	if var_14_1 < arg_14_2 then
		for iter_14_2, iter_14_3 in ipairs(self.allCommodityCfgs) do
			if not table.contains(self.showingCommoditiesIndex, iter_14_2) and table.contains(iter_14_3.panel, arg_14_1) then
				if not self:IsCommodityOutOfDate(iter_14_3) then
					var_14_1 = var_14_1 + 1

					table.insert(var_14_0, iter_14_3)
					table.insert(self.showingCommoditiesIndex, iter_14_2)
				end

				if var_14_1 == arg_14_2 then
					break
				end
			end
		end
	end

	return var_14_0
end

function Dorm3dShopUI:GetCommoditiesCfgByChara(arg_15_1)
	local var_15_0 = {}
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(self.allCommodityCfgs) do
		local var_15_2 = {}

		if iter_15_1.realroom_id ~= 0 then
			table.insertto(var_15_2, var_0_4[iter_15_1.realroom_id].character)
			table.insertto(var_15_2, var_0_4[iter_15_1.realroom_id].character_pay)
		end

		if iter_15_1.room_id == arg_15_1 or iter_15_1.room_id == 0 then
			if iter_15_1.realroom_id ~= 0 then
				if iter_15_1.realroom_id ~= 0 and table.contains(var_15_2, arg_15_1) then
					if not self:IsCommodityOutOfDate(iter_15_1) then
						if not self:IsCommoditySoldOut(iter_15_1) then
							table.insert(var_15_0, iter_15_1)
						else
							table.insert(var_15_1, iter_15_1)
						end
					end
				end
			end
		end
	end

	if #var_15_1 > 0 then
		table.insertto(var_15_0, var_15_1)
	end

	return var_15_0
end

function Dorm3dShopUI:IsCommodityOutOfDate(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1.shop_id) do
		if not pg.TimeMgr.GetInstance():inTime(var_0_3[iter_16_1].time) then
			return true
		end
	end

	return false
end

function Dorm3dShopUI:IsCommoditySoldOut(arg_17_1)
	if arg_17_1.type == 1 then
		if getProxy(ApartmentProxy):GetFurnitureShopCount(arg_17_1.item_id) > 0 then
			return true
		end
	elseif arg_17_1.type == 2 then
		return not Dorm3dGift.New({
			configId = arg_17_1.item_id
		}):CheckBuyLimit()
	elseif arg_17_1.type == 3 then
		local var_17_0 = getProxy(ApartmentProxy):getRoom(arg_17_1.item_id)

		return var_17_0 and var_17_0.unlockCharacter[arg_17_1.room_id]
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
	local var_23_0 = self.recommendationPage:Find("bannerCard")

	self.scrollSnap = self.scrollSnap or BannerScrollRectDorm3dShop.New(var_23_0:Find("mask/content"), var_23_0:Find("dots"))

	for iter_23_0, iter_23_1 in ipairs((self:GetCommoditiesCfgByPanel(1, self.bannerCount))) do
		local var_23_1 = self.scrollSnap:GetItemChild(iter_23_0) or self.scrollSnap:AddChild()
		local var_23_2 = self:IsCommoditySoldOut(iter_23_1)
		local var_23_3 = false
		local var_23_4 = false
		local var_23_5 = {}
		local var_23_6 = 0
		local var_23_7 = ""
		local var_23_8 = ""
		local var_23_9 = var_0_3[iter_23_1.shop_id[1]].group_type == 2 and i18n("dorm3d_shop_limit1") or i18n("dorm3d_shop_limit")

		if iter_23_1.type == 1 then
			local var_23_10 = var_0_6[iter_23_1.item_id]

			var_23_4 = var_0_6[iter_23_1.item_id].is_special == 1
			var_23_3 = not var_23_4 and var_23_10.is_exclusive == 1
			var_23_7 = Drop.New({
				count = 0,
				type = DROP_TYPE_DORM3D_FURNITURE,
				id = var_23_10.id
			}):getIcon()
			var_23_8 = var_23_9 .. " " .. getProxy(ApartmentProxy):GetFurnitureShopCount(iter_23_1.item_id) .. "/1"
			var_23_5 = var_23_10.unlock_tips or {}
			var_23_6 = iter_23_1.shop_id[1]
		elseif iter_23_1.type == 2 then
			local var_23_11 = var_0_5[iter_23_1.item_id]

			var_23_3 = iter_23_1.room_id ~= 0

			local var_23_12 = Dorm3dGift.New({
				configId = iter_23_1.item_id
			})
			local var_23_13 = {
				type = DROP_TYPE_DORM3D_GIFT,
				id = iter_23_1.item_id
			}

			var_23_13.count = getProxy(ApartmentProxy):getGiftCount(iter_23_1.item_id)
			var_23_7 = Drop.New(var_23_13):getIcon()

			local var_23_14 = 0

			for iter_23_2 = 1, #iter_23_1.shop_id do
				if not var_0_3[iter_23_1.shop_id[iter_23_2]].limit_args[1] and var_0_3[iter_23_1.shop_id[iter_23_2]].group_type == 0 then
					var_23_14 = 0
				elseif var_0_3[iter_23_1.shop_id[iter_23_2]].limit_args[1] and (var_0_3[iter_23_1.shop_id[iter_23_2]].limit_args[1][1] == "dailycount" or var_0_3[iter_23_1.shop_id[iter_23_2]].limit_args[1][1] == "count") then
					var_23_14 = var_0_3[iter_23_1.shop_id[iter_23_2]].limit_args[1][3]
				elseif var_0_3[iter_23_1.shop_id[iter_23_2]].group_type == 2 then
					var_23_14 = var_0_3[iter_23_1.shop_id[iter_23_2]].group_limit
				end
			end

			var_23_8 = var_23_9 .. " " .. getProxy(ApartmentProxy):GetGiftShopCount(iter_23_1.item_id) .. "/" .. var_23_14

			setText(var_23_1:Find("favor/number"), "+" .. pg.dorm3d_favor_trigger[var_0_5[iter_23_1.item_id].favor_trigger_id].num)

			var_23_1:Find("favor"):GetComponent(typeof(CanvasGroup)).alpha = var_23_2 and 0.5 or 1
			var_23_5 = var_23_11.unlock_tips or {}
			var_23_6 = var_23_12:GetShopID()
		elseif iter_23_1.type == 3 then
			var_23_3 = true

			for iter_23_3, iter_23_4 in ipairs(var_0_4[iter_23_1.item_id].invite_icon) do
				if iter_23_4[1] == iter_23_1.room_id then
					var_23_7 = iter_23_4[2]
				end
			end

			var_23_8 = var_23_9 .. " " .. (var_23_2 and 1 or 0) .. "/1"
			var_23_6 = iter_23_1.shop_id[1]
		end

		setActive(var_23_1:Find("bg/normal"), not var_23_3 and not var_23_4)
		setActive(var_23_1:Find("bg/zhuanshu"), var_23_3)
		setActive(var_23_1:Find("bg/tedian"), var_23_4)
		setActive(var_23_1:Find("normal"), not var_23_3 and not var_23_4)
		setActive(var_23_1:Find("zhuanshu"), var_23_3)
		setActive(var_23_1:Find("tedian"), var_23_4)
		setActive(var_23_1:Find("favor"), iter_23_1.type == 2)
		LoadImageSpriteAsync("dorm3dbanner/" .. iter_23_1.banners[1] .. "_shopCard1", var_23_1:Find("bannerMask/banner"), true)
		setText(var_23_1:Find("name"), iter_23_1.name)

		local var_23_15 = var_0_3[iter_23_1.shop_id[1]].time

		setActive(var_23_1:Find("timeLimit"), var_0_3[iter_23_1.shop_id[1]].time ~= "always")

		if var_23_15 ~= "always" then
			setText(var_23_1:Find("timeLimit/Text"), self:GetTimeRemain((pg.TimeMgr.GetInstance():parseTimeFromConfig(var_23_15[2]))))
		end

		self:SetBubbles(UIItemList.New(var_23_1:Find("bubbles/content"), var_23_1:Find("bubbles/content/tpl")), var_23_5)
		setActive(var_23_1:Find("consume"), not var_23_2)
		setActive(var_23_1:Find("soldOut"), var_23_2)

		local var_23_16 = CommonCommodity.New({
			id = var_23_6
		}, Goods.TYPE_SHOPSTREET)
		local var_23_17, var_23_18, var_23_19 = var_23_16:GetPrice()
		local var_23_20 = Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = var_23_16:GetResType(),
			count = var_23_17
		})

		setText(var_23_1:Find("consume/Text"), "<icon name=" .. var_23_16:GetResIcon() .. " w=0.81 h=0.81/>" .. var_23_17)
		GetImageSpriteFromAtlasAsync(var_23_7, "", var_23_1:Find("normal/Dorm3dIconTpl/icon"))
		GetImageSpriteFromAtlasAsync(var_23_7, "", var_23_1:Find("zhuanshu/Dorm3dIconTpl/icon"))
		GetImageSpriteFromAtlasAsync(var_23_7, "", var_23_1:Find("tedian/Dorm3dIconTpl/icon"))
		setText(var_23_1:Find("normal/countLimit"), var_23_8)
		setText(var_23_1:Find("zhuanshu/countLimit"), var_23_8)
		setText(var_23_1:Find("tedian/countLimit"), var_23_8)

		var_23_1:Find("normal/Dorm3dIconTpl"):GetComponent(typeof(CanvasGroup)).alpha = var_23_2 and 0.5 or 1
		var_23_1:Find("zhuanshu/Dorm3dIconTpl"):GetComponent(typeof(CanvasGroup)).alpha = var_23_2 and 0.5 or 1
		var_23_1:Find("tedian/Dorm3dIconTpl"):GetComponent(typeof(CanvasGroup)).alpha = var_23_2 and 0.5 or 1

		if not var_23_2 then
			onButton(self, var_23_1, function()
				self:ClickCommodity(iter_23_1, var_23_1:Find("tip"))

				return
			end, SFX_PANEL)
		else
			onButton(self, var_23_1, function()
				Dorm3dShopUI.UpdateCommodtyTip(iter_23_1)
				setActive(var_23_1:Find("tip"), false)
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_sell_out"))

				return
			end, SFX_PANEL)
		end

		local var_23_21 = Dorm3dShopUI.ShouldShowCommodtyTip(iter_23_1)

		setActive(var_23_1:Find("new"), var_23_21)
		setActive(var_23_1:Find("tip"), var_23_21)
	end

	self.scrollSnap:SetUp()

	return
end

function Dorm3dShopUI:SetGiftCard()
	local var_26_0 = self.recommendationPage:Find("giftCard")
	local var_26_1 = self:GetCommoditiesCfgByPanel(2, 1)[1]
	local var_26_2 = 0
	local var_26_3 = self:IsCommoditySoldOut(var_26_1)
	local var_26_4 = ""
	local var_26_5 = false
	local var_26_6 = false
	local var_26_7 = var_0_3[var_26_1.shop_id[1]].group_type == 2 and i18n("dorm3d_shop_limit1") or i18n("dorm3d_shop_limit")

	if var_26_1.type == 1 then
		local var_26_8 = var_0_6[var_26_1.item_id]

		var_26_6 = var_0_6[var_26_1.item_id].is_special == 1
		var_26_5 = not (var_26_6 or var_26_8.is_exclusive ~= 1)

		updateCustomDrop(var_26_0:Find("Dorm3dIconTpl"), (Drop.New({
			count = 0,
			type = DROP_TYPE_DORM3D_FURNITURE,
			id = var_26_8.id
		})))

		var_26_2 = var_26_1.shop_id[1]
		var_26_4 = var_26_7 .. " " .. getProxy(ApartmentProxy):GetFurnitureShopCount(var_26_1.item_id) .. "/1"
	elseif var_26_1.type == 2 then
		var_26_5 = var_26_1.room_id ~= 0

		local var_26_10 = Dorm3dGift.New({
			configId = var_26_1.item_id
		})
		local var_26_11 = {
			type = DROP_TYPE_DORM3D_GIFT,
			id = var_26_1.item_id
		}

		var_26_11.count = getProxy(ApartmentProxy):getGiftCount(var_26_1.item_id)

		setText(var_26_0:Find("favor/number"), "+" .. pg.dorm3d_favor_trigger[var_0_5[var_26_1.item_id].favor_trigger_id].num)
		updateCustomDrop(var_26_0:Find("Dorm3dIconTpl"), (Drop.New(var_26_11)))

		var_26_2 = var_26_10:GetShopID()

		local var_26_12 = 0

		for iter_26_0 = 1, #var_26_1.shop_id do
			if not var_0_3[var_26_1.shop_id[iter_26_0]].limit_args[1] and var_0_3[var_26_1.shop_id[iter_26_0]].group_type == 0 then
				var_26_12 = 0
			elseif var_0_3[var_26_1.shop_id[iter_26_0]].limit_args[1] and (var_0_3[var_26_1.shop_id[iter_26_0]].limit_args[1][1] == "dailycount" or var_0_3[var_26_1.shop_id[iter_26_0]].limit_args[1][1] == "count") then
				var_26_12 = var_0_3[var_26_1.shop_id[iter_26_0]].limit_args[1][3]
			elseif var_0_3[var_26_1.shop_id[iter_26_0]].group_type == 2 then
				var_26_12 = var_0_3[var_26_1.shop_id[iter_26_0]].group_limit
			end
		end

		var_26_4 = var_26_7 .. " " .. getProxy(ApartmentProxy):GetGiftShopCount(var_26_1.item_id) .. "/" .. var_26_12
	elseif var_26_1.type == 3 then
		var_26_5 = true

		local var_26_13 = ""

		for iter_26_1, iter_26_2 in ipairs(var_0_4[var_26_1.item_id].invite_icon) do
			if iter_26_2[1] == var_26_1.room_id then
				var_26_13 = iter_26_2[2]
			end
		end

		GetImageSpriteFromAtlasAsync(var_26_13, "", var_26_0:Find("Dorm3dIconTpl/icon"))
		GetImageSpriteFromAtlasAsync("weaponframes", "dorm3d_" .. ItemRarity.Rarity2Print(var_26_1.rarity), var_26_0:Find("Dorm3dIconTpl"))

		var_26_4 = var_26_7 .. " " .. (var_26_3 and 1 or 0) .. "/1"
		var_26_2 = var_26_1.shop_id[1]
	end

	var_26_0:Find("Dorm3dIconTpl"):GetComponent(typeof(CanvasGroup)).alpha = var_26_3 and 0.5 or 1
	var_26_0:Find("favor"):GetComponent(typeof(CanvasGroup)).alpha = var_26_3 and 0.5 or 1

	setActive(var_26_0:Find("bg/normal"), not var_26_5 and not var_26_6)
	setActive(var_26_0:Find("bg/zhuanshu"), var_26_5)
	setActive(var_26_0:Find("bg/tedian"), var_26_6)
	setActive(var_26_0:Find("normal"), not var_26_5 and not var_26_6)
	setActive(var_26_0:Find("zhuanshu"), var_26_5)
	setActive(var_26_0:Find("tedian"), var_26_6)
	setText(var_26_0:Find("normal/countLimit"), var_26_4)
	setText(var_26_0:Find("zhuanshu/countLimit"), var_26_4)
	setText(var_26_0:Find("tedian/countLimit"), var_26_4)
	LoadImageSpriteAsync("dorm3dbanner/" .. var_26_1.banners[1] .. "_shopCard2", var_26_0:Find("mask/item"), true)
	setScrollText(var_26_0:Find("name/text"), var_26_1.name)
	setActive(var_26_0:Find("favor"), var_26_1.type == 2)
	setActive(var_26_0:Find("consume"), not var_26_3)
	setActive(var_26_0:Find("soldOut"), var_26_3)

	local var_26_14 = var_0_3[var_26_1.shop_id[1]].time

	setActive(var_26_0:Find("timeLimit"), var_0_3[var_26_1.shop_id[1]].time ~= "always")

	if var_26_14 ~= "always" then
		setText(var_26_0:Find("timeLimit/Text"), self:GetTimeRemain((pg.TimeMgr.GetInstance():parseTimeFromConfig(var_26_14[2]))))
	end

	local var_26_15 = CommonCommodity.New({
		id = var_26_2
	}, Goods.TYPE_SHOPSTREET)
	local var_26_16, var_26_17, var_26_18 = var_26_15:GetPrice()
	local var_26_19 = Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = var_26_15:GetResType(),
		count = var_26_16
	})

	setText(var_26_0:Find("consume/Text"), "<icon name=" .. var_26_15:GetResIcon() .. " w=0.81 h=0.81/>" .. var_26_16)

	if not var_26_3 then
		onButton(self, var_26_0, function()
			self:ClickCommodity(var_26_1, var_26_0:Find("tip"))

			return
		end, SFX_PANEL)
	else
		onButton(self, var_26_0, function()
			Dorm3dShopUI.UpdateCommodtyTip(var_26_1)
			setActive(var_26_0:Find("tip"), false)
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_sell_out"))

			return
		end, SFX_PANEL)
	end

	local var_26_20 = Dorm3dShopUI.ShouldShowCommodtyTip(var_26_1)

	setActive(var_26_0:Find("new"), var_26_20)
	setActive(var_26_0:Find("tip"), var_26_20)

	return
end

function Dorm3dShopUI:SetNormalCard()
	for iter_29_0 = 1, 3 do
		local var_29_0 = self.recommendationPage:Find("card" .. iter_29_0)
		local var_29_1 = self:GetCommoditiesCfgByPanel(iter_29_0 + 2, 1)[1]
		local var_29_2 = false
		local var_29_3 = false
		local var_29_4 = self:IsCommoditySoldOut(var_29_1)
		local var_29_5 = {}
		local var_29_6 = 0
		local var_29_7 = ""
		local var_29_8 = var_0_3[var_29_1.shop_id[1]].group_type == 2 and i18n("dorm3d_shop_limit1") or i18n("dorm3d_shop_limit")

		if var_29_1.type == 1 then
			local var_29_9 = var_0_6[var_29_1.item_id]

			var_29_2 = var_0_6[var_29_1.item_id].is_special == 1
			var_29_3 = not var_29_2 and var_29_9.is_exclusive == 1
			var_29_7 = Drop.New({
				count = 0,
				type = DROP_TYPE_DORM3D_FURNITURE,
				id = var_29_9.id
			}):getIcon()

			setText(var_29_0:Find("countLimit/Text"), var_29_8 .. " " .. getProxy(ApartmentProxy):GetFurnitureShopCount(var_29_1.item_id) .. "/1")

			var_29_5 = var_29_9.unlock_tips or {}
			var_29_6 = var_29_1.shop_id[1]
		elseif var_29_1.type == 2 then
			local var_29_10 = var_0_5[var_29_1.item_id]

			var_29_3 = var_29_1.room_id ~= 0

			local var_29_11 = Dorm3dGift.New({
				configId = var_29_1.item_id
			})
			local var_29_12 = {
				type = DROP_TYPE_DORM3D_GIFT,
				id = var_29_1.item_id
			}

			var_29_12.count = getProxy(ApartmentProxy):getGiftCount(var_29_1.item_id)
			var_29_7 = Drop.New(var_29_12):getIcon()

			local var_29_13 = 0

			for iter_29_1 = 1, #var_29_1.shop_id do
				if not var_0_3[var_29_1.shop_id[iter_29_1]].limit_args[1] and var_0_3[var_29_1.shop_id[iter_29_1]].group_type == 0 then
					var_29_13 = 0
				elseif var_0_3[var_29_1.shop_id[iter_29_1]].limit_args[1] and (var_0_3[var_29_1.shop_id[iter_29_1]].limit_args[1][1] == "dailycount" or var_0_3[var_29_1.shop_id[iter_29_1]].limit_args[1][1] == "count") then
					var_29_13 = var_0_3[var_29_1.shop_id[iter_29_1]].limit_args[1][3]
				elseif var_0_3[var_29_1.shop_id[iter_29_1]].group_type == 2 then
					var_29_13 = var_0_3[var_29_1.shop_id[iter_29_1]].group_limit
				end
			end

			setText(var_29_0:Find("countLimit/Text"), var_29_8 .. " " .. getProxy(ApartmentProxy):GetGiftShopCount(var_29_1.item_id) .. "/" .. var_29_13)
			setText(var_29_0:Find("normal/favor/number"), "+" .. pg.dorm3d_favor_trigger[var_0_5[var_29_1.item_id].favor_trigger_id].num)
			setText(var_29_0:Find("zhuanshu/favor/number"), "+" .. pg.dorm3d_favor_trigger[var_0_5[var_29_1.item_id].favor_trigger_id].num)
			setText(var_29_0:Find("tedian/favor/number"), "+" .. pg.dorm3d_favor_trigger[var_0_5[var_29_1.item_id].favor_trigger_id].num)

			var_29_5 = var_29_10.unlock_tips or {}
			var_29_6 = var_29_11:GetShopID()
		elseif var_29_1.type == 3 then
			var_29_3 = true

			for iter_29_2, iter_29_3 in ipairs(var_0_4[var_29_1.item_id].invite_icon) do
				if iter_29_3[1] == var_29_1.room_id then
					var_29_7 = iter_29_3[2]
				end
			end

			setText(var_29_0:Find("countLimit/Text"), var_29_8 .. " " .. (var_29_4 and 1 or 0) .. "/1")

			var_29_6 = var_29_1.shop_id[1]
		end

		setActive(var_29_0:Find("bg/normal"), not var_29_3 and not var_29_2)
		setActive(var_29_0:Find("bg/zhuanshu"), var_29_3)
		setActive(var_29_0:Find("bg/tedian"), var_29_2)
		setActive(var_29_0:Find("normal"), not var_29_3 and not var_29_2)
		setActive(var_29_0:Find("zhuanshu"), var_29_3)
		setActive(var_29_0:Find("tedian"), var_29_2)
		setActive(var_29_0:Find("normal/favor"), var_29_1.type == 2)
		setActive(var_29_0:Find("zhuanshu/favor"), var_29_1.type == 2)
		setActive(var_29_0:Find("tedian/favor"), var_29_1.type == 2)
		setText(var_29_0:Find("name"), var_29_1.name)
		self:SetBubbles(UIItemList.New(var_29_0:Find("bubbles/content"), var_29_0:Find("bubbles/content/tpl")), var_29_5)
		setActive(var_29_0:Find("consume"), not var_29_4)
		setActive(var_29_0:Find("soldOut"), var_29_4)

		local var_29_14 = CommonCommodity.New({
			id = var_29_6
		}, Goods.TYPE_SHOPSTREET)
		local var_29_15, var_29_16, var_29_17 = var_29_14:GetPrice()
		local var_29_18 = Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = var_29_14:GetResType(),
			count = var_29_15
		})

		setText(var_29_0:Find("consume/Text"), "<icon name=" .. var_29_14:GetResIcon() .. " w=0.81 h=0.81/>" .. var_29_15)
		GetImageSpriteFromAtlasAsync(var_29_7, "", var_29_0:Find("normal/mask/Dorm3dIconTpl/icon"))
		GetImageSpriteFromAtlasAsync(var_29_7, "", var_29_0:Find("zhuanshu/mask/Dorm3dIconTpl/icon"))
		GetImageSpriteFromAtlasAsync(var_29_7, "", var_29_0:Find("tedian/mask/Dorm3dIconTpl/icon"))

		if not var_29_4 then
			onButton(self, var_29_0, function()
				self:ClickCommodity(var_29_1, var_29_0:Find("tip"))

				return
			end, SFX_PANEL)
		else
			onButton(self, var_29_0, function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_sell_out"))
				Dorm3dShopUI.UpdateCommodtyTip(var_29_1)
				setActive(var_29_0:Find("tip"), false)

				return
			end, SFX_PANEL)
		end

		local var_29_19 = Dorm3dShopUI.ShouldShowCommodtyTip(var_29_1)

		setActive(var_29_0:Find("new"), var_29_19)
		setActive(var_29_0:Find("tip"), var_29_19)
	end

	return
end

function Dorm3dShopUI:SetCharaCard()
	local var_32_0 = self:GetCommoditiesCfgByChara(var_0_4[self.selectedId].character[1])
	local var_32_1 = UIItemList.New(self.charaPage:Find("scroll/Viewport/Content"), self.charaPage:Find("scroll/Viewport/Content/card"))
	local var_32_2 = {}

	var_32_1:make(function(arg_33_0, arg_33_1, arg_33_2)
		if arg_33_0 == UIItemList.EventInit then
			local var_33_0 = var_32_0[arg_33_1 + 1]

			table.insert(var_32_2, {
				var_32_0[arg_33_1 + 1].type,
				arg_33_2
			})

			local var_33_1 = self:IsCommoditySoldOut(var_33_0)
			local var_33_2 = false
			local var_33_3 = false
			local var_33_4 = ""
			local var_33_5 = {}
			local var_33_6 = 0
			local var_33_7 = var_0_3[var_33_0.shop_id[1]].group_type == 2 and i18n("dorm3d_shop_limit1") or i18n("dorm3d_shop_limit")

			if var_33_0.type == 1 then
				local var_33_8 = var_0_6[var_33_0.item_id]

				var_33_3 = var_0_6[var_33_0.item_id].is_special == 1
				var_33_2 = not var_33_3 and var_33_8.is_exclusive == 1
				var_33_4 = Drop.New({
					count = 0,
					type = DROP_TYPE_DORM3D_FURNITURE,
					id = var_33_8.id
				}):getIcon()

				setText(arg_33_2:Find("descScroll/Viewport/Content/desc"), var_33_8.desc)
				setText(arg_33_2:Find("countLimit"), var_33_7 .. " " .. getProxy(ApartmentProxy):GetFurnitureShopCount(var_33_0.item_id) .. "/1")

				var_33_5 = var_33_8.unlock_tips or {}
				var_33_6 = var_33_0.shop_id[1]
			elseif var_33_0.type == 2 then
				local var_33_9 = var_0_5[var_33_0.item_id]

				var_33_2 = var_33_0.room_id ~= 0

				local var_33_10 = Dorm3dGift.New({
					configId = var_33_0.item_id
				})
				local var_33_11 = {
					type = DROP_TYPE_DORM3D_GIFT,
					id = var_33_0.item_id
				}

				var_33_11.count = getProxy(ApartmentProxy):getGiftCount(var_33_0.item_id)
				var_33_4 = Drop.New(var_33_11):getIcon()

				setText(arg_33_2:Find("descScroll/Viewport/Content/desc"), var_33_9.display)

				local var_33_12 = 0

				for iter_33_0 = 1, #var_33_0.shop_id do
					if not var_0_3[var_33_0.shop_id[iter_33_0]].limit_args[1] and var_0_3[var_33_0.shop_id[iter_33_0]].group_type == 0 then
						var_33_12 = 0
					elseif var_0_3[var_33_0.shop_id[iter_33_0]].limit_args[1] and (var_0_3[var_33_0.shop_id[iter_33_0]].limit_args[1][1] == "dailycount" or var_0_3[var_33_0.shop_id[iter_33_0]].limit_args[1][1] == "count") then
						var_33_12 = var_0_3[var_33_0.shop_id[iter_33_0]].limit_args[1][3]
					elseif var_0_3[var_33_0.shop_id[iter_33_0]].group_type == 2 then
						var_33_12 = var_0_3[var_33_0.shop_id[iter_33_0]].group_limit
					end
				end

				setText(arg_33_2:Find("countLimit"), var_33_7 .. " " .. getProxy(ApartmentProxy):GetGiftShopCount(var_33_0.item_id) .. "/" .. var_33_12)
				setText(arg_33_2:Find("favor/number"), "+" .. pg.dorm3d_favor_trigger[var_0_5[var_33_0.item_id].favor_trigger_id].num)

				var_33_5 = var_33_9.unlock_tips or {}
				var_33_6 = var_33_10:GetShopID()
			elseif var_33_0.type == 3 then
				var_33_2 = true

				for iter_33_1, iter_33_2 in ipairs(var_0_4[var_33_0.item_id].invite_icon) do
					if iter_33_2[1] == var_33_0.room_id then
						var_33_4 = iter_33_2[2]
					end
				end

				setText(arg_33_2:Find("descScroll/Viewport/Content/desc"), var_0_4[var_33_0.item_id].room_des)
				setText(arg_33_2:Find("countLimit"), var_33_7 .. " " .. (var_33_1 and 1 or 0) .. "/1")

				var_33_6 = var_33_0.shop_id[1]
			end

			setActive(arg_33_2:Find("bg/normal"), not var_33_1)
			setActive(arg_33_2:Find("bg/soldOut"), var_33_1)
			setActive(arg_33_2:Find("normal"), not var_33_2 and not var_33_3)
			setActive(arg_33_2:Find("zhuanshu"), var_33_2)
			setActive(arg_33_2:Find("tedian"), var_33_3)
			GetImageSpriteFromAtlasAsync(var_33_4, "", arg_33_2:Find("mask/Dorm3dIconTpl/icon"))
			setActive(arg_33_2:Find("favor"), var_33_0.type == 2)
			setScrollText(arg_33_2:Find("name/text"), var_33_0.name)
			self:SetBubbles(UIItemList.New(arg_33_2:Find("bubbles/content"), arg_33_2:Find("bubbles/content/tpl")), var_33_5)

			local var_33_13 = CommonCommodity.New({
				id = var_33_6
			}, Goods.TYPE_SHOPSTREET)
			local var_33_14, var_33_15, var_33_16 = var_33_13:GetPrice()
			local var_33_17 = Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = var_33_13:GetResType(),
				count = var_33_14
			})

			setText(arg_33_2:Find("consume/Text"), "<icon name=" .. var_33_13:GetResIcon() .. " w=0.81 h=0.81/>" .. var_33_14)
			setActive(arg_33_2:Find("consume"), not var_33_1)
			setActive(arg_33_2:Find("soldOut"), var_33_1)

			local var_33_18 = var_0_3[var_33_0.shop_id[1]].time

			setActive(arg_33_2:Find("timeLimit"), var_0_3[var_33_0.shop_id[1]].time ~= "always")

			if var_33_18 ~= "always" then
				setText(arg_33_2:Find("timeLimit/Text"), self:GetTimeRemain((pg.TimeMgr.GetInstance():parseTimeFromConfig(var_33_18[2]))))
			end

			if not var_33_1 then
				onButton(self, arg_33_2, function()
					self:ClickCommodity(var_33_0, arg_33_2:Find("tip"))

					return
				end, SFX_PANEL)
			else
				onButton(self, arg_33_2, function()
					Dorm3dShopUI.UpdateCommodtyTip(var_33_0)
					setActive(arg_33_2:Find("tip"), false)
					pg.TipsMgr.GetInstance():ShowTips(i18n("word_sell_out"))

					return
				end, SFX_PANEL)
			end

			local var_33_19 = Dorm3dShopUI.ShouldShowCommodtyTip(var_33_0)

			setActive(arg_33_2:Find("new"), var_33_19)
			setActive(arg_33_2:Find("tip"), var_33_19)
		end

		return
	end)
	var_32_1:align(#var_32_0)

	self.filterIndex = 1

	for iter_32_0 = 1, 4 do
		local var_32_3 = self.charaPage:Find("switch"):GetChild(iter_32_0 - 1)

		onToggle(self, var_32_3, function(arg_36_0)
			if arg_36_0 then
				self.filterIndex = iter_32_0

				if iter_32_0 == 1 then
					for iter_36_0, iter_36_1 in ipairs(var_32_2) do
						setActive(iter_36_1[2], true)
					end
				elseif iter_32_0 == 2 then
					for iter_36_2, iter_36_3 in ipairs(var_32_2) do
						setActive(iter_36_3[2], iter_36_3[1] == 2)
					end
				elseif iter_32_0 == 3 then
					for iter_36_4, iter_36_5 in ipairs(var_32_2) do
						setActive(iter_36_5[2], iter_36_5[1] == 1)
					end
				else
					for iter_36_6, iter_36_7 in ipairs(var_32_2) do
						setActive(iter_36_7[2], iter_36_7[1] == 3)
					end
				end

				for iter_36_8 = 1, 4 do
					setActive(self.charaPage:Find("switch"):GetChild(iter_36_8 - 1):Find("selected"), iter_36_8 == iter_32_0)
				end
			end

			return
		end)

		if iter_32_0 == 1 then
			triggerToggle(var_32_3, true)
		end
	end

	return
end

function Dorm3dShopUI:ClickCommodity(arg_37_1, arg_37_2)
	self.showCount = 1

	if arg_37_1.room_id ~= 0 then
		local var_37_0 = 0

		for iter_37_0, iter_37_1 in pairs(var_0_4) do
			if iter_37_1.type == 2 and iter_37_1.character[1] == arg_37_1.room_id then
				var_37_0 = iter_37_1.id
			end
		end

		if not getProxy(ApartmentProxy):getRoom(var_37_0) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_role_locked"))

			return
		end
	end

	if arg_37_1.realroom_id ~= 0 then
		if not getProxy(ApartmentProxy):getRoom(arg_37_1.realroom_id) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_publicroom_unlock") .. "：" .. pg.dorm3d_rooms[arg_37_1.realroom_id].room)

			return
		end
	end

	Dorm3dShopUI.UpdateCommodtyTip(arg_37_1)

	if arg_37_2 then
		setActive(arg_37_2, false)
	end

	if arg_37_1.type == 1 then
		local var_37_1 = Dorm3dFurniture.New({
			configId = arg_37_1.item_id
		})
		local var_37_2 = CommonCommodity.New({
			id = arg_37_1.shop_id[1]
		}, Goods.TYPE_SHOPSTREET)
		local var_37_3, var_37_4, var_37_5 = var_37_2:GetPrice()

		self:emit(Dorm3dShopMediator.SHOW_SHOPPING_CONFIRM_WINDOW, {
			content = {
				icon = "<icon name=" .. var_37_2:GetResIcon() .. " w=1.1 h=1.1/>",
				off = var_37_4,
				cost = Drop.New({
					type = DROP_TYPE_RESOURCE,
					id = var_37_2:GetResType(),
					count = var_37_3
				}).count,
				old = var_37_5,
				name = arg_37_1.name
			},
			tip = i18n("dorm3d_shop_gift_tip"),
			drop = var_37_1,
			endTime = var_37_1:GetEndTime(),
			onYes = function()
				if not var_37_1:InShopTime() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_purchase_outtime"))

					return
				end

				self:emit(GAME.SHOPPING, {
					silentTip = true,
					count = 1,
					shopId = arg_37_1.shop_id[1]
				})

				return
			end
		})
	elseif arg_37_1.type == 2 then
		local var_37_6 = 0

		for iter_37_2 = 1, #arg_37_1.shop_id do
			if not var_0_3[arg_37_1.shop_id[iter_37_2]].limit_args[1] and var_0_3[arg_37_1.shop_id[iter_37_2]].group_type == 0 then
				var_37_6 = 0
			elseif var_0_3[arg_37_1.shop_id[iter_37_2]].limit_args[1] and (var_0_3[arg_37_1.shop_id[iter_37_2]].limit_args[1][1] == "dailycount" or var_0_3[arg_37_1.shop_id[iter_37_2]].limit_args[1][1] == "count") then
				var_37_6 = var_0_3[arg_37_1.shop_id[iter_37_2]].limit_args[1][3]
			elseif var_0_3[arg_37_1.shop_id[iter_37_2]].group_type == 2 then
				var_37_6 = var_0_3[arg_37_1.shop_id[iter_37_2]].group_limit
			end
		end

		if var_37_6 > 1 then
			self:emit(Dorm3dShopMediator.OPEN_DETAIL, arg_37_1, (self.selectedId ~= 0 or nil) and var_0_4[self.selectedId].character[1], function(arg_39_0)
				self.showCount = arg_39_0

				return
			end)
		else
			local var_37_8 = Dorm3dGift.New({
				configId = arg_37_1.item_id
			})
			local var_37_9 = CommonCommodity.New({
				id = var_37_8:GetShopID()
			}, Goods.TYPE_SHOPSTREET)
			local var_37_10, var_37_11, var_37_12 = var_37_9:GetPrice()
			local var_37_13
			local var_37_14 = 0

			_.each(var_37_8:getConfig("shop_id"), function(arg_40_0)
				if var_0_3[arg_40_0].group_type == 2 then
					var_37_14 = math.max(var_0_3[arg_40_0].group_limit, var_37_14)
				end

				return
			end)

			if 0 > 0 then
				local var_37_15 = {}

				var_37_15[1] = getProxy(ApartmentProxy):GetGiftShopCount(var_37_8:GetConfigID())
				var_37_15[2] = 0
				var_37_13 = var_37_15
			end

			self:emit(Dorm3dShopMediator.SHOW_SHOPPING_CONFIRM_WINDOW, {
				content = {
					icon = "<icon name=" .. var_37_9:GetResIcon() .. " w=1.1 h=1.1/>",
					off = var_37_11,
					cost = Drop.New({
						type = DROP_TYPE_RESOURCE,
						id = var_37_9:GetResType(),
						count = var_37_10
					}).count,
					old = var_37_12,
					name = arg_37_1.name,
					weekLimit = var_37_13
				},
				tip = i18n("dorm3d_shop_gift_tip"),
				drop = var_37_8,
				groupId = arg_37_1.room_id,
				onYes = function()
					self:emit(GAME.SHOPPING, {
						silentTip = true,
						count = 1,
						shopId = var_37_8:GetShopID()
					})

					return
				end
			})
		end
	elseif arg_37_1.type == 3 then
		local var_37_16
		local var_37_17 = getProxy(ApartmentProxy):getRoom(arg_37_1.item_id)

		if not var_37_17 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_role_locked"))

			return
		end

		if not var_37_17.unlockCharacter[arg_37_1.room_id] then
			var_37_16 = "lock"
		elseif not getProxy(ApartmentProxy):getApartment(arg_37_1.room_id) then
			var_37_16 = "room"
		elseif Apartment.New({
			ship_group = arg_37_1.room_id
		}):needDownload() then
			var_37_16 = "download"
		end

		if var_37_16 == "lock" then
			self:emit(Dorm3dShopMediator.OPEN_ROOM_UNLOCK_WINDOW, arg_37_1.item_id, arg_37_1.room_id)
		elseif var_37_16 == "room" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_role_locked"))
		elseif var_37_16 == "download" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_guide_beach_tip"))
		end
	end

	return
end

function Dorm3dShopUI:SetBubbles(arg_42_1, arg_42_2)
	arg_42_1:make(function(arg_43_0, arg_43_1, arg_43_2)
		if arg_43_0 == UIItemList.EventInit then
			LoadImageSpriteAtlasAsync("ui/shoptip_atlas", "icon_" .. arg_42_2[arg_43_1 + 1], arg_43_2:Find("icon/icon"), true)
			setText(arg_43_2:Find("bubble/Text"), i18n("dorm3d_shop_tag" .. arg_42_2[arg_43_1 + 1]))
			setActive(arg_43_2:Find("bubble"), false)
			onToggle(self, arg_43_2, function(arg_44_0)
				setActive(arg_43_2:Find("icon/select"), arg_44_0)
				setActive(arg_43_2:Find("icon/unselect"), not arg_44_0)
				setActive(arg_43_2:Find("bubble"), arg_44_0)
				setActive(self.mask, arg_44_0)
				onButton(self, self.mask, function()
					triggerToggle(arg_43_2, false)

					return
				end, SFX_PANEL)

				return
			end)
		end

		return
	end)
	arg_42_1:align(#arg_42_2)

	return
end

function Dorm3dShopUI:GetTimeRemain(arg_46_1)
	local var_46_0 = pg.TimeMgr.GetInstance()
	local var_46_1 = math.max(arg_46_1 - var_46_0:GetServerTime(), 0)

	if var_46_0 > 0 then
		return math.floor(var_46_1 / 0) .. i18n("word_date")
	else
		local var_46_2 = math.floor(var_46_1 / 16)

		if var_46_2 > 0 then
			return var_46_2 .. i18n("word_hour")
		else
			local var_46_3 = math.floor(var_46_1 / 60)

			if var_46_3 > 0 then
				return var_46_3 .. i18n("word_minute")
			else
				return var_46_1 .. i18n("word_second")
			end
		end
	end

	return
end

function Dorm3dShopUI:ShouldShowCommodtyTip()
	if self.room_id ~= 0 then
		local var_47_0 = 0

		for iter_47_0, iter_47_1 in ipairs(var_0_4.all) do
			if var_0_4[iter_47_1].type == 2 and var_0_4[iter_47_1].character[1] == self.room_id then
				var_47_0 = iter_47_1
			end
		end

		if not getProxy(ApartmentProxy):getRoom(var_47_0) then
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
	for iter_48_0, iter_48_1 in ipairs(self) do
		if Dorm3dShopUI.ShouldShowCommodtyTip(iter_48_1) then
			return true
		end
	end

	return false
end

function Dorm3dShopUI.ShouldShowAllTip()
	local var_49_0 = {}

	for iter_49_0, iter_49_1 in ipairs(var_0_2.all) do
		local var_49_1 = false

		for iter_49_2, iter_49_3 in ipairs(var_0_2[iter_49_1].shop_id) do
			if not pg.TimeMgr.GetInstance():inTime(var_0_3[iter_49_3].time) then
				var_49_1 = true

				break
			end
		end

		if not var_49_1 then
			table.insert(var_49_0, var_0_2[iter_49_1])
		end
	end

	return Dorm3dShopUI.ShouldShowSumTip(var_49_0)
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
	for iter_51_0, iter_51_1 in ipairs(self) do
		Dorm3dShopUI.UpdateCommodtyTip(iter_51_1)
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
