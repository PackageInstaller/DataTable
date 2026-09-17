SupermarketMarketSprite = class("SupermarketMarketSprite", function()
	return cc.Layer:create()
end)

function SupermarketMarketSprite.create(arg_2_0, arg_2_1)
	local var_2_0 = SupermarketMarketSprite.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

require("view.Sprite.ConfirmDialogSprite")

local L2Actor = require("view.Sprite.L2Actor")
local texture_manager = require("controller.texture_manager")
local shop_manager = require("controller.shop_manager")
local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local weapon_manager = require("controller.weapon_manager")
local alert_manager = require("controller.alert_manager")
local network = require("network.network")
local component_manager = require("controller.component_manager")
local audio_manager = require("controller.audio_manager")
local drop_manager = require("controller.drop_manager")
local time_check_manager = require("controller.time_check_manager")
local level_manager = require("controller.level_manager")
local armature_manager = require("controller.armature_manager")
local diamond_update_data = require("data.diamond_update_data")
local model_data = require("data.model_data")
local favorfile_data = require("data.favorfile_data")
local component_effect_data = require("data.component_effect_data")
local discount_manager = require("controller.discount_manager")
local var_0_20 = config._DEBUG and 0 or 1
local shop_data = require("data.shop_data")
local activity_manager = require("controller.activity_manager")
local community_system_manager = require("controller.community_system_manager")
local major_factor_data = require("data.major_factor_data")
local supermarket_manager = require("controller.supermarket_manager")
local servant_data = require("data.servant_data")
local var_0_27 = {}
local ShopSprite = require("view.Sprite.ShopSprite")

local function var_0_29(arg_3_0)
	return split(arg_3_0, "-")[1] .. "_" .. split(arg_3_0, "-")[2]
end

local var_0_30 = {
	["1-10301"] = 1,
	["1-10702"] = 3,
	["1-7"] = 1,
	["1-10001"] = 3,
	["1-8"] = 1,
	["1-1801"] = 2,
	["1-10404"] = 1,
	["1-509"] = 2,
	["1-16"] = 1,
	["1-15405"] = 1,
	["1-15701"] = 5,
	["1-35"] = 1,
	["1-137"] = 1,
	["1-24"] = 3,
	["1-39"] = 1,
	["1-37"] = 1,
	["1-13"] = 1,
	["2-4"] = 1,
	["1-22"] = 1,
	["1-9"] = 1,
	["1-4"] = 2,
	["1-26"] = 1,
	["1-20"] = 1,
	["1-14805"] = 4,
	["1-520"] = 1,
	["1-27"] = 1,
	["1-17101"] = 1,
	["1-15301"] = 1,
	["1-1"] = 1,
	["2-1"] = 1,
	["1-1371"] = 1,
	["1-13804"] = 1,
	["1-6"] = 2,
	["2-6"] = 1,
	["1-54"] = 1,
	["1-10801"] = 1,
	["1-52"] = 1,
	["1-32"] = 1,
	["1-51"] = 1,
	["1-53"] = 1,
	["1-31"] = 1,
	["1-3"] = 1,
	["1-30"] = 1,
	["1-12"] = 3,
	["1-10"] = 3,
	["1-50"] = 1,
	["1-11"] = 1,
	["1-29"] = 1,
	["1-10407"] = 1,
	["1-36"] = 1,
	["1-21"] = 3,
	["1-40"] = 1,
	["1-38"] = 1,
	["1-501"] = 2,
	["1-18"] = 1,
	["1-19"] = 1,
	["1-34"] = 1,
	["1-56"] = 1,
	["1-15601"] = 1,
	["1-17"] = 3,
	["1-55"] = 1,
	["1-11003"] = 3,
	["2-3"] = 1,
	["1-10402"] = 1,
	["1-16601"] = 1,
	["1-5"] = 1,
	["1-10403"] = 1,
	["1-10201"] = 1,
	["1-2"] = 4,
	["2-2"] = 1,
	["1-13802"] = 3,
	["1-10002"] = 1,
	["1-123000"] = 1,
	["1-10401"] = 1
}

setmetatable(var_0_30, {
	__index = function(arg_4_0, arg_4_1)
		return 3
	end
})

local var_0_31 = {
	["1-9"] = 0,
	["1-1"] = 0,
	["2-1"] = 0,
	["1-3"] = 0,
	["1-12"] = 0,
	["1-10"] = 0,
	["1-7"] = 0,
	["1-13"] = 0,
	["1-11"] = 0,
	["1-5"] = 0,
	["1-6"] = 0,
	["1-2"] = 0,
	["2-2"] = 0,
	["2-4"] = 0,
	["1-4"] = 0,
	["1-8"] = 0,
	["2-3"] = UNLOCK_COLLECTION_SHOP
}

setmetatable(var_0_31, {
	__index = function(arg_5_0, arg_5_1)
		return 0
	end
})

local var_0_32 = {
	NEVER = 0,
	EVERY_MONTH = 3,
	EVERY_DAY = 1,
	EVERY_WEEK = 2
}
local var_0_33 = {}
local var_0_34 = {
	{
		offsetx = 15,
		height = 275,
		width = 630,
		offsety = 10
	},
	{
		offsetx = 200,
		height = 320,
		width = 630,
		offsety = 20
	},
	{
		offsetx = 200,
		height = 660,
		width = 630,
		offsety = 0
	},
	{
		offsetx = 200,
		height = 280,
		width = 630,
		offsety = 20
	},
	{
		offsetx = 200,
		height = 280,
		width = 630,
		offsety = 20
	}
}

setmetatable(var_0_33, {
	__index = function(arg_6_0, arg_6_1)
		if var_0_34[var_0_30[arg_6_1]] then
			return var_0_34[var_0_30[arg_6_1]]
		else
			return {
				offsetx = 15,
				height = 275,
				width = 630,
				offsety = 10
			}
		end
	end
})

local var_0_35 = {
	[6800202] = "public/currency/6800202.png",
	[SHOP_CURRENCY_GOLD] = "public/currency/UI_battleEnd_gold.png",
	[SHOP_CURRENCY_DIAMOND] = "public/currency/UI_battleEnd_diamond.png",
	[SHOP_CURRENCY_HORNOR] = "public/currency/arenascene_dot_1.png",
	[SHOP_CURRENCY_EXPLORECOIN] = "public/currency/explorecoin.png",
	[SHOP_CURRENCY_RMB] = "public/currency/rmb_white.png",
	[BLACK_CARD] = "public/currency/1500001_1.png",
	[BLACK_SP_CARD] = "public/currency/1500002_1.png",
	[85000006] = "equipment/" .. item_data[85000006].image_id .. ".png"
}

setmetatable(var_0_35, {
	__index = function(arg_7_0, arg_7_1)
		return "public/currency/" .. item_data[arg_7_1].image_id .. ".png"
	end
})

local var_0_36 = {
	nil,
	"mainScenebg/market/",
	"mainScenebg/market/",
	"mainScenebg/market/"
}

setmetatable(var_0_36, {
	__index = function(arg_8_0, arg_8_1)
		return "equipment/"
	end
})

local var_0_37 = {
	".png",
	".jpg",
	nil,
	".jpg"
}

setmetatable(var_0_37, {
	__index = function(arg_9_0, arg_9_1)
		return ".png"
	end
})

local var_0_38 = {
	[SHOP_CURRENCY_GOLD] = function()
		return playermodel.gold
	end,
	[SHOP_CURRENCY_DIAMOND] = function()
		return playermodel.diamond
	end,
	[SHOP_CURRENCY_HORNOR] = function()
		return playermodel.honor
	end,
	[SHOP_CURRENCY_EXPLORECOIN] = function()
		return playermodel.explorecoin
	end,
	[SHOP_CURRENCY_RMB] = function()
		return 0
	end
}

setmetatable(var_0_38, {
	__index = function(arg_15_0, arg_15_1)
		return function()
			return item_manager:getItemNumber(arg_15_1)
		end
	end
})

function SupermarketMarketSprite:initSwitchEvent(arg_17_1)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("switchLeftBtn", function(arg_18_0)
		if not arg_18_0 or not arg_18_0.name then
			return
		end

		if arg_18_0.name == self.selectedType then
			return
		end

		self.selectedType = arg_18_0.name

		if self.openSingleMarket then
			if type(self.openSingleMarket) == "string" then
				self.openSingleMarket = {
					self.openSingleMarket
				}
			end

			local var_18_0 = false

			for iter_18_0, iter_18_1 in pairs(self.openSingleMarket) do
				if iter_18_1 == self.selectedType then
					var_18_0 = true
				end
			end

			if not var_18_0 then
				table.insert(self.openSingleMarket, self.selectedType)
			end

			self:updateDataByGain()
			self:updateBtnByGain()
			self:updateButtonList()
			self:refreshTime()
			self:refreshTableData()
			self:updateCurActiveTime()
		else
			self:switchBtn(arg_18_0.name)
			self:updateButtonList()
			self:refreshTableData()
			self:refreshTime()
			self:updateCurActiveTime()
		end
	end), self)
end

function SupermarketMarketSprite:switchBtn(arg_19_1)
	self:updateBlackCardDes()
	self:updatebtnCoupons()
end

function SupermarketMarketSprite:createButton(arg_20_1)
	local var_20_0 = ccui.Button:create()

	var_20_0:setSwallowTouches(false)
	var_20_0:setName(arg_20_1)
	var_20_0:loadTextures("SupermarketMarketSprite/1_1_normal.png", "SupermarketMarketSprite/1_1_normal.png", "", var_0_20)
	var_20_0:setAnchorPoint(cc.p(0.5, 0.5))

	if arg_20_1 ~= "1-10" then
		if arg_20_1 == "1-21" then
			L2ActorSprite = L2Actor:create("effect/market_sweep_light/skeleton.json", "effect/market_sweep_light/skeleton.atlas")

			L2ActorSprite:setPosition(cc.p(var_20_0:getContentSize().width / 2, var_20_0:getContentSize().height / 2))
			var_20_0:addChild(L2ActorSprite, 99)
			L2ActorSprite:playAni(nil, "animation", true)
		end
	end

	local var_20_1 = ccui.ImageView:create("SupermarketMarketSprite/shop_new_icon.png", var_0_20)

	var_20_1:setPosition(cc.p(var_20_0:getContentSize().width - 12, var_20_0:getContentSize().height - 15))
	var_20_1:setName("redDot")
	var_20_1:setVisible(false)
	var_20_0:addChild(var_20_1)

	for iter_20_0, iter_20_1 in pairs(self.buttonName) do
		if iter_20_1 == arg_20_1 then
			var_20_0:setTag(#self.buttonName - iter_20_0 + 10)
		end
	end

	if arg_20_1 == "2-1" then
		local var_20_2 = ccui.ImageView:create("SupermarketMarketSprite/shop_new_icon.png", var_0_20)

		var_20_2:setPositionX(var_20_0:getContentSize().width - 12)
		var_20_2:setPositionY(var_20_0:getContentSize().height - 15)
		var_20_2:setName("reddot")
		var_20_0:addChild(var_20_2)

		if alert_manager.alertsys[ALERT_MARKET] == true then
			var_20_2:setVisible(alert_manager.alertsys[ALERT_MARKET] == true)
		else
			var_20_2:setVisible(false)
		end
	end

	var_20_0:addTouchEventListener(function(arg_21_0, arg_21_1)
		if self.rpcCallbackFalg == false then
			return
		end

		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_21_0:getName() == "2-1" then
			alert_manager:unregister_alert(ALERT_MARKET)

			if arg_21_0:getChildByName("reddot") then
				arg_21_0:getChildByName("reddot"):setVisible(false)
				alert_manager:unregister_alert(ALERT_MARKET)
			end
		end

		if self.selectedType == arg_21_0:getName() then
			return
		end

		if math.abs(arg_21_0:getTouchBeganPosition().y - arg_21_0:getTouchEndPosition().y) > 50 then
			return
		end

		self.rpcCallbackFalg = false
		self.selectedType = arg_21_0:getName()

		print("self.selectedType", self.selectedType)
		self:updateButtonList()
		self:refreshTime()
		self:refreshTableData()
		self:updateCurActiveTime()
		self:checkpushBrowseTime()
		self:updateBlackCardDes()
		self:updatebtnCoupons()
	end)

	return var_20_0
end

function SupermarketMarketSprite:checkpushBrowseTime()
	if self.lastSelectType ~= self.selectedType then
		if self.lastSelectType then
			self:pushBrowseTime(self.lastSelectType)
		else
			self:pushBrowseTime(self.selectedType)
		end

		self.lastSelectType = self.selectedType
		self.lastBrowseTime = os.time()
	end
end

function SupermarketMarketSprite:pushBrowseTime(arg_23_1)
	if not self.lastBrowseTime then
		return
	end

	AnalyticManager.browseShop(arg_23_1, os.time() - self.lastBrowseTime)
end

local var_0_41 = 3000
local var_0_42 = 13000

function SupermarketMarketSprite:initTimeRefreshHandle()
	local var_24_0 = {
		[6] = var_0_42
	}
	local var_24_1 = {
		[6] = MAX_REFRESH_TIME_COMPONENT
	}

	local function var_24_2(arg_25_0)
		arg_25_0:setTouchEnabled(false)

		local function var_25_0(arg_26_0)
			local var_26_0 = var_24_0[self.shopList[self.marketType[self.selectedType]].id] or var_0_41

			if not diamond_update_data[var_26_0 + arg_26_0 + 1] then
				global_ShowBlockWords(L_MARKET_REFRESH.Out_Of_Times)

				return
			end

			local var_26_1 = diamond_update_data[var_26_0 + arg_26_0 + 1].costdiamond
			local var_26_2 = global_deepCopy(L_REFRESH_MARKET[self.shopList[self.marketType[self.selectedType]].id])
			local var_26_3 = (var_24_1[self.shopList[self.marketType[self.selectedType]].id] or MAX_REFRESH_TIME) - arg_26_0
			local var_26_4 = var_24_1[self.shopList[self.marketType[self.selectedType]].id] or MAX_REFRESH_TIME

			var_26_2.more = var_26_2.more .. var_26_3 .. "/" .. var_26_4
			var_26_2.titleImage = "title_refresh_shop.png"

			LayerManager:pushInLayer("PopDoLayer", {
				costtype = "diamond",
				markettype = self.shopList[self.marketType[self.selectedType]].id,
				remaintimes = var_26_3,
				totaltimes = var_26_4,
				surecallback = function()
					shop_manager:refresh_market(self.shopList[self.marketType[self.selectedType]].id, function(arg_28_0)
						if arg_28_0 == 1 then
							global_ShowBlockWords(L_MARKET_REFRESH.Success, RISE_WORDS_SUCCESS)
							self:refreshTableData()
						end
					end)
				end,
				own = playermodel.diamond,
				cost = var_26_1,
				labels = var_26_2
			})
		end

		shop_manager:get_market_refresh_time(self.shopList[self.marketType[self.selectedType]].id, function(arg_29_0, arg_29_1, arg_29_2)
			if arg_29_2 then
				global_ShowBlockWords(L_MARKET_REFRESH.Out_Of_Times)
				audio_manager:playeffectMusicTest("sound/invalid")
			else
				var_25_0(arg_29_0)
			end

			arg_25_0:setTouchEnabled(true)
		end)
	end

	self.refreshBtn:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.refreshmanual[self.selectedType] > 0 then
			var_24_2(arg_30_0)
		else
			global_ShowBlockWords(L_MARKET_REFRESH.Auto_Refresh)
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end)
end

function SupermarketMarketSprite:updateCurActiveTime()
	local var_31_0 = (function(arg_32_0)
		for iter_32_0, iter_32_1 in pairs(self.marketData) do
			if arg_32_0 == iter_32_1.id then
				return iter_32_0
			end
		end
	end)((tonumber(split(self.selectedType, "-")[2])))

	if self.marketData[var_31_0].stat == 2 then
		local var_31_1 = self.marketData[var_31_0].finishtime
		local var_31_2 = -1

		playermodel:getServerTime(function()
			var_31_2 = self:getResidueTime(var_31_1)

			self.panelBottom:getChildByName("Image_surplusTimeBottom"):getChildByName("Label_time"):setString(var_31_2)
			self.panelBottom:getChildByName("Image_surplusTimeBottom"):setVisible(true)

			if tonumber(var_31_2) == -1 then
				self.panelBottom:getChildByName("Image_surplusTimeBottom"):setVisible(false)
			end
		end)
	else
		self.panelBottom:getChildByName("Image_surplusTimeBottom"):setVisible(false)
	end
end

function SupermarketMarketSprite.getResidueTime(arg_34_0, arg_34_1)
	if not arg_34_1 then
		return "-1"
	end

	local var_34_5 = global_get_time_by_date(arg_34_1) - playermodel.onlineTime
	local var_34_6 = math.floor(var_34_5 / 24 / 3600)
	local var_34_7 = math.floor((var_34_5 - var_34_6 * 24 * 3600) / 3600)
	local var_34_8 = math.floor((var_34_5 - var_34_6 * 24 * 3600 - var_34_7 * 3600) / 60)

	return var_34_6 ~= 0 and string.format(L_TIME_TEXT[1], var_34_6, var_34_7) or var_34_7 ~= 0 and string.format(L_TIME_TEXT[2], var_34_7, var_34_8) or string.format(L_TIME_TEXT[3], var_34_8)
end

function SupermarketMarketSprite.isOpenShop(arg_35_0, arg_35_1)
	if config.limit_open_system and var_0_31[arg_35_1] then
		return level_manager:isPlayerPassLevel(var_0_31[arg_35_1])
	end

	return true
end

function SupermarketMarketSprite:updateDataByGain()
	self.shopList = {}

	for iter_36_0, iter_36_1 in pairs(self.marketData) do
		if iter_36_1.stat == 1 or iter_36_1.stat == 2 then
			if iter_36_1.type == "2-2" then
				local var_36_0, var_36_1 = LayerManager:getLayerUnlockStat("AdventureLayer")

				if var_36_0 then
					self.shopList[#self.shopList + 1] = {
						order = iter_36_1.order,
						id = iter_36_1.id,
						type = iter_36_1.type,
						refreshtime = iter_36_1.refreshtime,
						refreshtype = iter_36_1.refreshtype,
						refreshtime = iter_36_1.refreshtime,
						refreshmanual = iter_36_1.refreshmanual,
						havenewitem = iter_36_1.havenewitem
					}
				end
			else
				self.shopList[#self.shopList + 1] = {
					order = iter_36_1.order,
					id = iter_36_1.id,
					type = iter_36_1.type,
					refreshtime = iter_36_1.refreshtime,
					refreshtype = iter_36_1.refreshtype,
					refreshtime = iter_36_1.refreshtime,
					refreshmanual = iter_36_1.refreshmanual,
					havenewitem = iter_36_1.havenewitem
				}
			end
		end
	end

	table.sort(self.shopList, function(arg_37_0, arg_37_1)
		return arg_37_0.order < arg_37_1.order
	end)

	self.activityShopName = {}
	self.collegeShopName = {}
	self.catShopName = {}
	self.autoRefreshType = {}
	self.refreshmanual = {}
	self.marketType = {}
	self.nextRefreshTime = {}
	self.buttonName = {}

	for iter_36_2, iter_36_3 in pairs(self.shopList) do
		if self:isOpenShop(iter_36_3.type) and self:isOpenShopByParam(iter_36_3.type) then
			self.marketType[iter_36_3.type] = iter_36_2
			self.buttonName[#self.buttonName + 1] = iter_36_3.type
			self.autoRefreshType[iter_36_3.type] = iter_36_3.refreshtype
			self.nextRefreshTime[iter_36_3.type] = iter_36_3.refreshtime
			self.refreshmanual[iter_36_3.type] = iter_36_3.refreshmanual
		end
	end

	print("self.marketType====", dump(self.marketType))

	self.lastBrowseTime = os.time()
end

function SupermarketMarketSprite:initData()
	self.shopList = {}

	for iter_38_0, iter_38_1 in pairs(self.marketData) do
		if iter_38_1.stat == 1 or iter_38_1.stat == 2 then
			if iter_38_1.type == "2-2" then
				local var_38_0, var_38_1 = LayerManager:getLayerUnlockStat("AdventureLayer")

				if var_38_0 then
					self.shopList[#self.shopList + 1] = {
						order = iter_38_1.order,
						id = iter_38_1.id,
						type = iter_38_1.type,
						refreshtime = iter_38_1.refreshtime,
						refreshtype = iter_38_1.refreshtype,
						refreshtime = iter_38_1.refreshtime,
						refreshmanual = iter_38_1.refreshmanual,
						havenewitem = iter_38_1.havenewitem
					}
				end
			else
				self.shopList[#self.shopList + 1] = {
					order = iter_38_1.order,
					id = iter_38_1.id,
					type = iter_38_1.type,
					refreshtime = iter_38_1.refreshtime,
					refreshtype = iter_38_1.refreshtype,
					refreshtime = iter_38_1.refreshtime,
					refreshmanual = iter_38_1.refreshmanual,
					havenewitem = iter_38_1.havenewitem
				}
			end
		end
	end

	table.sort(self.shopList, function(arg_39_0, arg_39_1)
		return arg_39_0.order < arg_39_1.order
	end)

	self.activityShopName = {}
	self.collegeShopName = {}
	self.catShopName = {}
	self.autoRefreshType = {}
	self.refreshmanual = {}
	self.marketType = {}
	self.nextRefreshTime = {}
	self.buttonName = {}
	self.tableViewList = {}

	if self.openSingleMarket then
		local var_38_2 = true
		local var_38_3 = type(self.openSingleMarket) == "string" and {
			self.openSingleMarket
		} or self.openSingleMarket

		for iter_38_2, iter_38_3 in pairs(self.shopList) do
			if self:isOpenShop(iter_38_3.type) then
				for iter_38_4, iter_38_5 in pairs(var_38_3) do
					if iter_38_3.type == iter_38_5 then
						iter_38_5 = nil
						var_38_2 = false
					end
				end
			end
		end

		if var_38_2 then
			self.openSingleMarket = {
				"1-1"
			}
		end
	end

	for iter_38_6, iter_38_7 in pairs(self.shopList) do
		if self:isOpenShop(iter_38_7.type) and self:isOpenShopByParam(iter_38_7.type) then
			if not self.openSingleMarket then
				self.marketType[iter_38_7.type] = iter_38_6
				self.buttonName[#self.buttonName + 1] = iter_38_7.type
				self.autoRefreshType[iter_38_7.type] = iter_38_7.refreshtype
				self.nextRefreshTime[iter_38_7.type] = iter_38_7.refreshtime
				self.refreshmanual[iter_38_7.type] = iter_38_7.refreshmanual
			elseif self.openSingleMarket then
				self.marketType[iter_38_7.type] = iter_38_6
				self.buttonName[#self.buttonName + 1] = iter_38_7.type
				self.autoRefreshType[iter_38_7.type] = iter_38_7.refreshtype
				self.nextRefreshTime[iter_38_7.type] = iter_38_7.refreshtime
				self.refreshmanual[iter_38_7.type] = iter_38_7.refreshmanual
			end
		end
	end

	self.lastBrowseTime = os.time()
end

function SupermarketMarketSprite:isOpenShopByParam(arg_40_1)
	if self.openSingleMarket and type(self.openSingleMarket) == "table" then
		for iter_40_0, iter_40_1 in pairs(self.openSingleMarket) do
			if iter_40_1 == arg_40_1 then
				return true
			end
		end

		return false
	elseif self.openSingleMarket then
		return self.openSingleMarket == arg_40_1
	end

	return true
end

function SupermarketMarketSprite:init(arg_41_1)
	self.showinfo = arg_41_1 or {}
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "MarketLayer.json" or "MarketLayer.ExportJson")

	self:addChild(self.rootlayer)

	self.returnLayer = self.showinfo.returnLayer or nil
	self.exitCallback = self.showinfo.exitCallback or nil
	self.itemid = self.showinfo.itemid or nil
	self.openSingleMarket = self.showinfo.singleMarket
	self.buttonList = {}
	self.listData = {}
	self.costTypeTable = {}
	self.rpcCallbackFalg = false
	self.refresh_bg = ccui.Helper:seekWidgetByName(self.rootlayer, "refresh_bg")
	self.refreshBtn = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_refreshBtn")
	self.panelBottom = ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom")
	self.purchaseid_to_index = {}

	if self.openSingleMarket then
		self:getMarketDataFromServer(function()
			self:initData()
			self:setDefaultSelectType()
			self:updateButtonList()
			self:refreshTableData()
			self:refreshTime()
			self:updateCurActiveTime()
			self:registerTimeCheckEvent()
			self:updateBlackCardDes()
		end)
	else
		self:getMarketDataFromServer(function()
			self:initData()
			self:setDefaultSelectType()
			self:updateButtonList()
			self:refreshTableData()
			self:refreshTime()
			self:updateCurActiveTime()
			self:registerTimeCheckEvent()
			self:updateBlackCardDes()
		end)
		self:registerGuidesEvent()
	end

	self:initDumpPopHandle()
	self:initTimeRefreshHandle()
	self:initSwitchEvent(getSingleDataFromPopCallback)
	self:initEventListenter()
	self:initCouponsBtn()
	self:registerScriptHandler(function(arg_44_0)
		if arg_44_0 == "exit" then
			self:updateNewAlert()
			self:pushBrowseTime(self.selectedType)
			TextureManager:removeSpineTexturesWithOutCollect()
			shop_manager:clear_shop_buy_stack()

			if self.skeletonData then
				self.skeletonData:release()
			end

			self.skeletonData = nil

			activity_manager:releaseEventListenerByName("SupermarketMarketSprite")
		end
	end)
	self:registerCommityEventListener()
end

function SupermarketMarketSprite.exitAni(arg_45_0)
	return
end

function SupermarketMarketSprite.getMarketDataFromServer(arg_46_0, arg_46_1)
	shop_manager:get_config_data(function(arg_47_0, arg_47_1)
		if arg_47_0 == 1 then
			arg_46_0.marketData = arg_47_1

			time_check_manager:insertShopTimeTrigger(arg_47_1)

			if arg_46_1 then
				arg_46_1()
			end
		end
	end)
end

function SupermarketMarketSprite:setDefaultSelectType()
	for iter_48_0, iter_48_1 in pairs(self.buttonName) do
		if iter_48_1 == self.showinfo.showType then
			self.selectedType = self.showinfo.showType

			break
		end

		if iter_48_0 == #self.buttonName then
			self.selectedType = self.buttonName[1]
		end
	end
end

function SupermarketMarketSprite:updateBtnByGain()
	self.buttonList = {}

	for iter_49_0, iter_49_1 in ipairs(self.buttonName) do
		index = #self.buttonList + 1
		self.buttonList[index] = {}
		self.buttonList[index].button = self:createButton(iter_49_1)

		self.buttonList[index].button:getChildByName("redDot"):setVisible(self.shopList[self.marketType[iter_49_1]].havenewitem)

		self.buttonList[index].selected = self.selectedType == iter_49_1
		self.collegeShopName[#self.collegeShopName + 1] = self.buttonList[index].button
	end
end

function SupermarketMarketSprite:initDumpPopHandle()
	local function var_50_0()
		self:updateTopInfo()
	end

	self.dumpPopLayerFunc = {
		[SHOP_CURRENCY_GOLD] = function()
			({}).callback = var_50_0

			LayerManager:removePopLayer()
			LayerManager:pushInLayer("PopGoGainLayer", {
				item = "gold",
				callback = var_50_0
			})
		end,
		[SHOP_CURRENCY_DIAMOND] = function()
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1,
				callback = var_50_0
			})
		end,
		[SHOP_CURRENCY_HORNOR] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		[SHOP_CURRENCY_EXPLORECOIN] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ExploreMapLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_EXPLORECOIN
			})
		end,
		[BLACK_CARD] = function()
			LayerManager:pushInLayer("PopGoGainLayer", {
				item = BLACK_CARD
			})
		end,
		[BLACK_SP_CARD] = function()
			LayerManager:pushInLayer("PopGoGainLayer", {
				item = BLACK_SP_CARD
			})
		end,
		[GIFT_TICKET] = function()
			LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
				targetlayer = "PopSupermarketLayer",
				callback = var_50_0
			})
		end
	}

	setmetatable(self.dumpPopLayerFunc, {
		__index = function(arg_59_0, arg_59_1)
			return function(arg_60_0)
				if not item_data[arg_60_0].targetlayer1 then
					global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_59_1].name))

					return
				end

				if arg_60_0 then
					LayerManager:pushInLayer("PopGoGainLayer", {
						item = arg_60_0
					})
				end

				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end
	})
end

function SupermarketMarketSprite:getInitScrollPercent()
	for iter_61_0, iter_61_1 in pairs(self.shopList) do
		if self.selectedType == iter_61_1.type then
			return (iter_61_0 - 1) / (#self.shopList + 1) * 100
		end
	end
end

function SupermarketMarketSprite.sortMarketlist(arg_62_0, arg_62_1)
	local function var_62_0(arg_63_0)
		if item_data[arg_63_0].bag_item_type == kITEM_SKIN_GIFT then
			for iter_63_0, iter_63_1 in pairs(drop_manager:getDropMsg(item_data[arg_63_0].mode_id).equips) do
				if item_data[iter_63_1.dropid].bag_item_type == kITEM_SKIN then
					return playermodel.haveSuit[item_data[iter_63_1.dropid].major]
				end
			end
		end

		return false
	end

	local function var_62_1(arg_64_0, arg_64_1, arg_64_2)
		if arg_64_2 and arg_64_2.uncolor_clothes then
			if shop_manager:fixUnColorMsg(arg_64_2).limit_buy_num <= 0 then
				return 0
			else
				return 1
			end
		end

		if arg_64_0 == arg_64_1 then
			return 0
		else
			return 1
		end
	end

	local var_62_2 = {
		[6] = {
			weight = 5,
			func = function(self, arg_70_1)
				local var_70_0 = global_get_time_by_date(self.discountfinish) > time_check_manager:getCurTime() and 1 or 0
				local var_70_1 = global_get_time_by_date(arg_70_1.discountfinish) > time_check_manager:getCurTime() and 1 or 0

				if shop_manager:is_skin_shop(arg_62_0.selectedType) then
					return "=="
				end

				if var_70_0 == var_70_1 then
					return "=="
				else
					return var_70_1 < var_70_0
				end
			end
		},
		[5] = {
			weight = 10,
			func = function(self, arg_68_1)
				local var_68_2 = 0
				local var_68_3 = 0
				local var_68_4 = {
					[1502001] = true,
					[1502005] = true,
					[1502002] = true,
					[107103000] = true,
					[1502003] = true,
					[1502004] = true
				}

				if var_68_4[self.itemtype] then
					var_68_2 = 100
				end

				if var_68_4[arg_68_1.itemtype] then
					var_68_3 = 100
				end

				if var_68_2 == var_68_3 then
					return "=="
				else
					return var_68_3 < var_68_2
				end
			end
		},
		[4] = {
			weight = 3,
			func = function(self, arg_67_1)
				local var_67_0 = 0
				local var_67_1 = 0

				if item_data[self.itemtype].servant and item_data[self.itemtype].bag_item_type == kITEM_WEAPON and item_data[arg_67_1.itemtype].servant and item_data[arg_67_1.itemtype].bag_item_type == kITEM_WEAPON then
					var_67_0 = playermodel.haveServant[item_data[self.itemtype].servant] and 1 or 0
					var_67_1 = playermodel.haveServant[item_data[arg_67_1.itemtype].servant] and 1 or 0
				end

				if var_67_0 == var_67_1 then
					return "=="
				else
					return var_67_1 < var_67_0
				end
			end
		},
		[3] = {
			weight = 1,
			func = function(self, arg_69_1)
				return self.pos < arg_69_1.pos
			end
		},
		[2] = {
			weight = 2,
			func = function(self, arg_66_1)
				local var_66_0 = 0
				local var_66_1 = 0

				if item_data[self.itemtype].major and item_data[self.itemtype].bag_item_type == kITEM_SKIN then
					var_66_0 = playermodel.haveSuit[item_data[self.itemtype].major] and 1 or 0
				end

				if item_data[arg_66_1.itemtype].major and item_data[arg_66_1.itemtype].bag_item_type == kITEM_SKIN then
					var_66_1 = playermodel.haveSuit[item_data[arg_66_1.itemtype].major] and 1 or 0
				end

				if item_data[self.itemtype].exclusive and item_data[self.itemtype].bag_item_type == kITEM_GIFT_FOR_FRIEND then
					var_66_0 = playermodel.haveSuit[item_data[self.itemtype].exclusive] and 1 or 0
				end

				if item_data[arg_66_1.itemtype].exclusive and item_data[arg_66_1.itemtype].bag_item_type == kITEM_GIFT_FOR_FRIEND then
					var_66_1 = playermodel.haveSuit[item_data[arg_66_1.itemtype].exclusive] and 1 or 0
				end

				if item_data[self.itemtype].bag_item_type == kITEM_SKIN_GIFT then
					var_66_0 = var_62_0(self.itemtype) and 1 or 0
				end

				if item_data[arg_66_1.itemtype].bag_item_type == kITEM_SKIN_GIFT then
					var_66_1 = var_62_0(arg_66_1.itemtype) and 1 or 0
				end

				if var_66_0 == var_66_1 then
					return "=="
				else
					return var_66_1 < var_66_0
				end
			end
		},
		{
			weight = 6,
			func = function(self, arg_65_1)
				if var_62_1(self.buy_limit, self.have_bought, self) == var_62_1(arg_65_1.buy_limit, arg_65_1.have_bought, arg_65_1) then
					return "=="
				else
					return var_62_1(self.buy_limit, self.have_bought, self) > var_62_1(arg_65_1.buy_limit, arg_65_1.have_bought, arg_65_1)
				end
			end
		}
	}

	table.sort(var_62_2, function(arg_71_0, arg_71_1)
		return arg_71_0.weight > arg_71_1.weight
	end)
	table.sort(arg_62_1, function(arg_72_0, arg_72_1)
		for iter_72_0 = 1, #var_62_2 do
			if var_62_2[iter_72_0].func(arg_72_0, arg_72_1) ~= "==" then
				return var_62_2[iter_72_0].func(arg_72_0, arg_72_1)
			end
		end
	end)
end

function SupermarketMarketSprite.isWeaponMax(arg_73_0, arg_73_1, arg_73_2, arg_73_3)
	if item_data[arg_73_2].bag_item_type ~= kITEM_WEAPON then
		return false
	end

	local var_73_0 = 0

	if playermodel.weaponId[item_data[arg_73_2].servant] then
		for iter_73_0 = playermodel.items[playermodel.weaponId[item_data[arg_73_2].servant]].weapon_attr.nowStars + 1, item_data[playermodel.items[playermodel.weaponId[item_data[arg_73_2].servant]].itemid].max_star do
			var_73_0 = var_73_0 + item_data[arg_73_2]["upgrade_need_num" .. iter_73_0]
		end

		var_73_0 = var_73_0 - item_manager:getItemNumber(arg_73_2) + 1
	else
		var_73_0 = 1

		while item_data[arg_73_2]["upgrade_need_num" .. 1] do
			var_73_0 = var_73_0 + item_data[arg_73_2]["upgrade_need_num" .. 1]
		end

		var_73_0 = var_73_0 - item_manager:getItemNumber(arg_73_2)
	end

	if var_73_0 < arg_73_3 then
		return true
	end

	return false
end

function SupermarketMarketSprite:initEventListenter()
	self:initPurchaseEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("BUY_ONEKEY_SUCCESS", function(arg_75_0)
		if self.selectedType ~= arg_75_0.markettype then
			return
		end

		if arg_75_0.result ~= 1 then
			return
		end

		if not arg_75_0.marketitems then
			return
		end

		local var_75_0 = {}

		for iter_75_0, iter_75_1 in pairs(arg_75_0.marketitems) do
			var_75_0[iter_75_1.pos] = iter_75_1
		end

		for iter_75_2, iter_75_3 in pairs(self.listData) do
			if var_75_0[iter_75_3.pos] then
				iter_75_3.have_bought = var_75_0[iter_75_3.pos].buycount
				iter_75_3.sell_out = iter_75_3.buy_limit and iter_75_3.buy_limit <= iter_75_3.have_bought
			end
		end

		self:updateTopInfo()
		self:updateShowingCells()
	end), self)
end

function SupermarketMarketSprite:initPurchaseEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_77_0)
		if not arg_77_0 or not arg_77_0.id then
			return
		end

		local var_77_0 = self.purchaseid_to_index[arg_77_0.id]

		if not self.purchaseid_to_index[arg_77_0.id] then
			return
		end

		self:updateTopInfo()

		self.listData[var_77_0].have_bought = self.listData[var_77_0].have_bought + 1
		self.listData[var_77_0].sell_out = self.listData[var_77_0].buy_limit and self.listData[var_77_0].buy_limit <= self.listData[var_77_0].have_bought

		self:updateShowingCells()
	end), self)
end

function SupermarketMarketSprite:getListDataIndex()
	if not self.itemid then
		return
	end

	for iter_78_0 = 1, #self.listData do
		print(self.itemid, self.listData[iter_78_0].itemid)

		if self.itemid == self.listData[iter_78_0].itemid then
			return iter_78_0
		end
	end
end

function SupermarketMarketSprite:refreshTableData()
	if self.selectedType == "2-1" then
		alert_manager:unregister_alert(ALERT_MARKET)
	end

	local var_79_0 = {}

	local function var_79_1(arg_80_0, arg_80_1)
		local var_80_0 = {
			itemid = self.listData[arg_80_1].itemid,
			item_attr = self.listData[arg_80_1].item_attr,
			costIcon = self.listData[arg_80_1].costIcon,
			cost_old = self.listData[arg_80_1].cost_old,
			sell_time = self.listData[arg_80_1].sell_time,
			uncolor_clothes = self.listData[arg_80_1].uncolor_clothes
		}

		var_80_0.limitNum = self.listData[arg_80_1].buy_limit and self.listData[arg_80_1].buy_limit - self.listData[arg_80_1].have_bought or 100

		local var_80_1 = math.floor(var_0_38[self.listData[arg_80_1].currency]() / self.listData[arg_80_1].cost)

		if var_80_1 > var_80_0.limitNum then
			var_80_0.limitNum = var_80_0.limitNum or var_80_1
		end

		if shop_manager:is_collection(self.selectedType) then
			var_80_0.marketType = "market_collection"
			var_80_0.hideGainButton = false
			var_80_0.limitNum = self.listData[arg_80_1].buy_limit - self.listData[arg_80_1].have_bought
		else
			var_80_0.hideGainButton = true
		end

		local var_80_2 = self:getResidueTime(self.listData[arg_80_1].finish_time)

		if var_80_2 ~= "-1" then
			var_80_0.limit_time = L_MARKET_REFRESH.Rest_Time .. var_80_2
		end

		var_80_0.slidecost = {
			costtype = self.listData[arg_80_1].costIcon,
			costnum = math.floor(self.listData[arg_80_1].cost),
			nowHave = var_0_38[self.listData[arg_80_1].currency]()
		}

		function var_80_0:ShopSliderCallback(arg_81_1)
			if arg_81_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self:isBright() then
				return
			end

			if self.listData[arg_80_1].sell_time and time_check_manager:getCurTime() < global_get_time_by_date(self.listData[arg_80_1].sell_time) then
				global_ShowBlockWords(self.listData[arg_80_1].sell_time .. L_START_BUY)

				return
			end

			if var_80_0.marketType ~= "market_collection" and self.listData[arg_80_1].cost > var_0_38[self.listData[arg_80_1].currency]() then
				LayerManager:removePopLayer()
				self.dumpPopLayerFunc[arg_80_0.currency]()
				self:setTouchEnabled(true)

				return
			end

			if self:isWeaponMax(self.selectedType, self.listData[arg_80_1].itemid, curbuyTime) then
				global_ShowBlockWords(L_WEAPON_SELECT_MAX_STAR)
				self:setTouchEnabled(true)

				return
			end

			local var_81_0 = self.nowNum or 1

			shop_manager:market_buy(self.shopList[self.marketType[self.selectedType]].id, self.listData[arg_80_1].pos, function(arg_82_0)
				if arg_82_0 == 1 then
					self:updateTopInfo()

					self.listData[arg_80_1].have_bought = self.listData[arg_80_1].have_bought + var_81_0
					self.listData[arg_80_1].sell_out = self.listData[arg_80_1].buy_limit and self.listData[arg_80_1].buy_limit <= self.listData[arg_80_1].have_bought

					self:updateShowingCells()

					if item_data[var_80_0.itemid].bag_item_type == kITEM_HERO then
						require("view.Layer.GetRoleAnimationLayer")
						cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_80_0.itemid), 1000)
					end
				elseif arg_82_0 == 2 then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_82_0 == 3 then
					self.dumpPopLayerFunc[self.listData[arg_80_1].currency]()
				end
			end, var_81_0, function()
				LayerManager:removePopLayer()
			end)
		end

		if self.listData[arg_80_1].have_bought and self.listData[arg_80_1].buy_limit and not shop_manager:is_collection(self.selectedType) then
			var_80_0.limit_buy_num = self.listData[arg_80_1].buy_limit - self.listData[arg_80_1].have_bought
			var_80_0.have_bought_num = self.listData[arg_80_1].have_bought
		end

		self:showBuyPop(var_80_0)

		self.listData[arg_80_1].isnewitem = false

		self:updateButtonRed()
		self:updateShowingCells()
		AnalyticManager.clickMarketItem({
			shoptype = self.selectedType
		})
	end

	local function var_79_2(arg_84_0)
		local var_84_0 = var_79_0

		if arg_84_0.result == 1 then
			local function var_84_1(arg_85_0)
				if arg_85_0 == 1 then
					self:updateTopInfo()

					self.listData[var_84_0.index].have_bought = self.listData[var_84_0.index].have_bought + var_84_0.curbuyTime
					self.listData[var_84_0.index].sell_out = self.listData[var_84_0.index].buy_limit and self.listData[var_84_0.index].buy_limit <= self.listData[var_84_0.index].have_bought

					self:updateShowingCells()

					if self.selectedType == "1-9" then
						AnalyticManager.score_store_change({
							score_itemsid = self.listData[var_84_0.index].itemid
						})
					end

					if item_data[var_84_0.itemid].bag_item_type == kITEM_HERO then
						require("view.Layer.GetRoleAnimationLayer")
						cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_84_0.itemid), 1000)
					end
				elseif arg_85_0 == 2 then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_85_0 == 3 then
					self.dumpPopLayerFunc[self.listData[var_84_0.index].currency](self.listData[var_84_0.index].currency)
				end
			end

			if shop_manager:is_special_shopid(self.listData[var_79_0.index].shopid) then
				for iter_84_0 = 1, var_79_0.curbuyTime do
					shop_manager:push_back_shop_buy_stack(function(...)
						shop_manager:shop_buy(self.shopList[self.marketType[self.selectedType]].id, self.listData[var_84_0.index].shopid, var_84_1, 1, function()
							if shop_manager:is_shop_buy_stack_empty() then
								LayerManager:removePopLayer()
							end
						end)
					end)
				end

				if var_79_0.callback then
					var_79_0.callback()
				end

				self:playPumpkinSpine(function(...)
					shop_manager:pop_shop_buy_stack()()
				end)
			elseif arg_84_0.selectCoupon then
				shop_manager:shop_buy_with_ticket(self.shopList[self.marketType[self.selectedType]].id, self.listData[var_79_0.index].shopid, var_84_1, var_79_0.curbuyTime, function()
					if arg_84_0.closePop ~= false then
						LayerManager:removePopLayer()
					end

					if var_84_0.callback then
						var_84_0.callback()
					end
				end, arg_84_0.selectCoupon, 1)
			else
				shop_manager:shop_buy(self.shopList[self.marketType[self.selectedType]].id, self.listData[var_79_0.index].shopid, var_84_1, var_79_0.curbuyTime, function()
					if arg_84_0.closePop ~= false then
						LayerManager:removePopLayer()
					end

					if var_84_0.callback then
						var_84_0.callback()
					end
				end)
			end
		end
	end

	local function var_79_3(arg_91_0)
		if not arg_91_0.currency2 or discount_manager:getLastPriceByItem(arg_91_0.itemid, arg_91_0.currency2, arg_91_0.discount2) < arg_91_0.discount2 then
			return true
		end

		return false
	end

	local function var_79_4(arg_92_0, arg_92_1)
		local var_92_0 = {
			itemid = self.listData[arg_92_1].itemid,
			item_attr = self.listData[arg_92_1].item_attr,
			index = arg_92_1,
			shopid = self.listData[arg_92_1].shopid
		}

		if var_79_3(self.listData[arg_92_1]) then
			var_92_0.costIcon = self.listData[arg_92_1].costIcon
			var_92_0.cost_old = self.listData[arg_92_1].cost_old
			var_92_0.currency = self.listData[arg_92_1].currency
		else
			var_92_0.costIcon = self.listData[arg_92_1].costIcon2
			var_92_0.cost_old = self.listData[arg_92_1].cost_old2
			var_92_0.currency = self.listData[arg_92_1].currency2
		end

		var_92_0.limitNum = self.listData[arg_92_1].itemid == 9000004 and self.listData[arg_92_1].currency == 9000005 and (self.listData[arg_92_1].buy_limit and (self.listData[arg_92_1].buy_limit - self.listData[arg_92_1].have_bought >= 999 and 999 or self.listData[arg_92_1].buy_limit - self.listData[arg_92_1].have_bought) or 999) or self.listData[arg_92_1].buy_limit and (self.listData[arg_92_1].buy_limit - self.listData[arg_92_1].have_bought >= SHOP_NORMAL_BUY_LIMIT_NUM and SHOP_NORMAL_BUY_LIMIT_NUM or self.listData[arg_92_1].buy_limit - self.listData[arg_92_1].have_bought) or SHOP_NORMAL_BUY_LIMIT_NUM

		local var_92_1 = var_79_3(self.listData[arg_92_1]) and math.floor(var_0_38[self.listData[arg_92_1].currency]() / self.listData[arg_92_1].cost) or math.floor(var_0_38[self.listData[arg_92_1].currency2]() / self.listData[arg_92_1].cost2)

		if var_92_1 > var_92_0.limitNum then
			var_92_0.limitNum = var_92_0.limitNum or var_92_1
		end

		local var_92_2 = self:getResidueTime(self.listData[arg_92_1].finish_time)

		if var_92_2 ~= "-1" then
			var_92_0.limit_time = L_MARKET_REFRESH.Rest_Time .. var_92_2
		end

		var_92_0.slidecost = {}
		var_92_0.uncolor_clothes = self.listData[arg_92_1].uncolor_clothes

		if var_79_3(self.listData[arg_92_1]) then
			var_92_0.slidecost.costtype = self.listData[arg_92_1].costIcon
			var_92_0.slidecost.costnum = self.listData[arg_92_1].discount or self.listData[arg_92_1].cost
			var_92_0.slidecost.nowHave = var_0_38[self.listData[arg_92_1].currency]()
		else
			var_92_0.slidecost.costtype = self.listData[arg_92_1].costIcon2
			var_92_0.slidecost.costnum = self.listData[arg_92_1].discount2 or self.listData[arg_92_1].cost2
			var_92_0.slidecost.nowHave = var_0_38[self.listData[arg_92_1].currency2]()
		end

		function var_92_0:ShopSliderCallback(arg_93_1, arg_93_2, arg_93_3)
			if arg_93_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self:isBright() then
				return
			end

			if self.listData[arg_92_1].have_bought >= self.listData[arg_92_1].buy_limit then
				global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
				audio_manager:playeffectMusicTest("sound/invalid")

				return
			end

			if self.listData[arg_92_1].sell_time and time_check_manager:getCurTime() < global_get_time_by_date(self.listData[arg_92_1].sell_time) then
				global_ShowBlockWords(self.listData[arg_92_1].sell_time .. L_START_BUY)

				return
			end

			local var_93_0 = self.nowNum or 1

			var_79_0 = {
				curbuyTime = var_93_0,
				index = arg_92_1,
				itemid = var_92_0.itemid,
				callback = arg_93_2
			}

			if var_79_3(self.listData[arg_92_1]) then
				if arg_93_3 then
					if self.listData[arg_92_1].cost > var_0_38[self.listData[arg_92_1].currency]() + discount_manager:getCouponsDiscount(arg_93_3) then
						LayerManager:removePopLayer()
						self.dumpPopLayerFunc[arg_92_0.currency](arg_92_0.currency)

						return
					end
				elseif self.listData[arg_92_1].cost * var_93_0 > var_0_38[self.listData[arg_92_1].currency]() then
					LayerManager:removePopLayer()
					self.dumpPopLayerFunc[arg_92_0.currency](arg_92_0.currency)

					return
				end
			end

			if self:isWeaponMax(self.selectedType, var_79_0.itemid, var_79_0.curbuyTime) then
				global_ShowBlockWords(L_WEAPON_SELECT_MAX_STAR)
				self:setTouchEnabled(true)

				return
			end

			var_79_2({
				result = 1,
				selectCoupon = arg_93_3,
				closePop = self.closePop
			})
		end

		var_92_0.hideGainButton = true

		if self.listData[arg_92_1].have_bought and self.listData[arg_92_1].buy_limit and not shop_manager:is_collection(self.selectedType) then
			var_92_0.limit_buy_num = self.listData[arg_92_1].buy_limit - self.listData[arg_92_1].have_bought
			var_92_0.have_bought_num = self.listData[arg_92_1].have_bought
		end

		self:showBuyPop(var_92_0)

		self.listData[arg_92_1].isnewitem = false

		self:updateButtonRed()
		self:updateShowingCells()
		AnalyticManager.clickShopItem({
			shoptype = self.selectedType
		})
	end

	local function var_79_5(arg_94_0, arg_94_1)
		if self.listData[arg_94_1].currency == SHOP_CURRENCY_RMB then
			-- block empty
		else
			var_79_4(arg_94_0, arg_94_1)
		end
	end

	local var_79_6 = {}

	for iter_79_0, iter_79_1 in pairs(self.shopList) do
		if tonumber(split(iter_79_1.type, "-")[1]) == 1 then
			var_79_6[iter_79_1.type] = var_79_5
		elseif tonumber(split(iter_79_1.type, "-")[1]) == 2 then
			var_79_6[iter_79_1.type] = var_79_1
		end
	end

	local function var_79_7(...)
		local var_95_0 = self:getListDataIndex()

		if var_95_0 then
			if tonumber(split(self.selectedType, "-")[1]) == 1 then
				var_79_5(self.listData[var_95_0], var_95_0)
			else
				var_79_1(self.listData[var_95_0], var_95_0)
			end

			self.itemid = nil
		end
	end

	local function var_79_8(arg_96_0)
		self:sortMarketlist(arg_96_0)

		self.listData = {}
		self.costTypeTable = {}
		self.purchaseid_to_index = {}

		local var_96_0 = {}

		for iter_96_0, iter_96_1 in pairs(arg_96_0) do
			iter_96_1.price = iter_96_1.price or -1

			local var_96_1 = #self.listData + 1

			self.listData[#self.listData + 1] = {}
			iter_96_1.currency = iter_96_1.currency or 0
			iter_96_1.discount = iter_96_1.discount or 10

			if not var_96_0[iter_96_1.currency] then
				table.insert(self.costTypeTable, iter_96_1.currency)

				var_96_0[iter_96_1.currency] = iter_96_1.currency
			end

			if iter_96_1.currency2 and not var_96_0[iter_96_1.currency2] then
				table.insert(self.costTypeTable, iter_96_1.currency2)

				var_96_0[iter_96_1.currency2] = iter_96_1.currency2
			end

			if iter_96_1.item_number ~= 1 then
				if item_data[iter_96_1.itemtype].item_market_name then
					self.listData[var_96_1].name = item_data[iter_96_1.itemtype].item_market_name .. " X" .. iter_96_1.item_number or item_data[iter_96_1.itemtype].name .. " X" .. iter_96_1.item_number
				end
			elseif not item_data[iter_96_1.itemtype].item_market_name then
				self.listData[var_96_1].name = item_data[iter_96_1.itemtype].name
			end

			self.listData[var_96_1].itemid = iter_96_1.itemtype
			self.listData[var_96_1].shopid = iter_96_1.shopid
			self.listData[var_96_1].costIcon = var_0_35[iter_96_1.currency]
			self.listData[var_96_1].currency = iter_96_1.currency

			if iter_96_1.currency2 then
				self.listData[var_96_1].costIcon2 = var_0_35[iter_96_1.currency2]
				self.listData[var_96_1].currency2 = iter_96_1.currency2
				self.listData[var_96_1].discount2 = iter_96_1.discount2
				self.listData[var_96_1].cost_old2 = iter_96_1.price2
			end

			self.listData[var_96_1].isnewitem = iter_96_1.isnewitem
			self.listData[var_96_1].discountfinish = iter_96_1.discountfinish
			self.listData[var_96_1].canUse = self:isCanUseItem(iter_96_1.itemtype)
			self.listData[var_96_1].canShowHaveServant = self:isShowHaveServant(iter_96_1.itemtype)

			if tonumber(split(self.selectedType, "-")[1]) == 1 then
				self.listData[var_96_1].cost = iter_96_1.discount or iter_96_1.price

				if iter_96_1.currency2 then
					self.listData[var_96_1].cost2 = iter_96_1.discount2 or iter_96_1.price2
				end
			else
				self.listData[var_96_1].cost = iter_96_1.price * 0.1 * iter_96_1.discount * iter_96_1.item_number

				if iter_96_1.currency2 then
					self.listData[var_96_1].cost2 = iter_96_1.price2 * 0.1 * iter_96_1.discount2 * iter_96_1.item_number
				end
			end

			self.listData[var_96_1].uncolor_clothes = iter_96_1.uncolor_clothes
			self.listData[var_96_1].is_lock_activitycity = iter_96_1.is_lock_activitycity
			self.listData[var_96_1].lock_activitycity = iter_96_1.lock_activitycity
			self.listData[var_96_1].quality = item_data[iter_96_1.itemtype].equip_quality or 1
			self.listData[var_96_1].cost_old = iter_96_1.price
			self.listData[var_96_1].bag_item_type = item_data[iter_96_1.itemtype].bag_item_type
			self.listData[var_96_1].item_attr = iter_96_1.item_attr
			self.listData[var_96_1].finish_time = iter_96_1.finish_time
			self.listData[var_96_1].sell_time = iter_96_1.sell_time
			self.listData[var_96_1].family_shop_limit = iter_96_1.family_shop_limit

			if iter_96_1.item_attr and (item_data[iter_96_1.itemtype].bag_item_type == kITEM_WEAPON or item_data[iter_96_1.itemtype].bag_item_type == kITEM_COMPONENT) then
				-- block empty
			else
				self.listData[var_96_1].icon = item_data[iter_96_1.itemtype].bag_item_type == kITEM_SCULTURE and "roleimage/role/wuji/" .. item_data[iter_96_1.itemtype].image_id .. ".png" or item_data[iter_96_1.itemtype].bag_item_type == kITEM_COMPONENT and string.format("equipment/component/%d-%d-%d.png", component_effect_data[item_data[iter_96_1.itemtype].effect1].image_id, item_data[iter_96_1.itemtype].pos, item_data[iter_96_1.itemtype].main_attr) or item_data[iter_96_1.itemtype].bag_item_type == kITEM_SKIN and var_0_36[var_0_30[self.selectedType]] .. item_data[iter_96_1.itemtype].model .. var_0_37[var_0_30[self.selectedType]] or var_0_36[var_0_30[self.selectedType]] .. item_data[iter_96_1.itemtype].image_id .. var_0_37[var_0_30[self.selectedType]]
			end

			self.listData[var_96_1].discount = iter_96_1.discount
			self.listData[var_96_1].buy_limit = iter_96_1.buy_limit or 1000000
			self.listData[var_96_1].have_bought = iter_96_1.have_bought or 0
			self.listData[var_96_1].sell_out = iter_96_1.buy_limit and iter_96_1.buy_limit <= iter_96_1.have_bought
			self.listData[var_96_1].tag = iter_96_1.tag or 0
			self.listData[var_96_1].pos = iter_96_1.pos
			self.listData[var_96_1].currency = iter_96_1.currency
			self.listData[var_96_1].touchCallBack = function(arg_97_0, arg_97_1)
				arg_97_0.own = var_0_38[iter_96_1.currency]()
				arg_97_0.currency = iter_96_1.currency

				var_79_6[self.selectedType](arg_97_0, var_96_1)
			end
			self.listData[var_96_1].purchaseid = iter_96_1.productid

			if iter_96_1.productid then
				self.purchaseid_to_index[iter_96_1.productid] = var_96_1
			end
		end

		while 1 <= #self.listData do
			v = self.listData[1]

			local var_96_4

			if not cc.FileUtils:getInstance():isFileExist(v.icon) then
				print("因未找到资源路径" .. v.icon .. ",将商品[" .. v.shopid .. "]/物品[" .. v.itemid .. "]的商品从显示中移除")
				table.remove(self.listData, 1)
			else
				var_96_4 = 1 + 1
			end
		end

		table.sort(self.costTypeTable, function(arg_98_0, arg_98_1)
			if arg_98_0 and arg_98_1 then
				return arg_98_1 < arg_98_0
			else
				return true
			end
		end)
		self:updateTopInfo()
		self:updateTableView()
		self:updateButtonRed()

		self.rpcCallbackFalg = true
	end

	local function var_79_9()
		shop_manager:get_market_data(self.shopList[self.marketType[self.selectedType]].id, function(arg_100_0)
			var_79_8(arg_100_0)
			var_79_7()
		end)
	end

	local function var_79_10()
		shop_manager:get_shop_data(self.shopList[self.marketType[self.selectedType]].id, function(arg_102_0)
			var_79_8(arg_102_0)
			var_79_7()
		end)
	end

	local var_79_11 = {}

	for iter_79_2, iter_79_3 in pairs(self.shopList) do
		if tonumber(split(iter_79_3.type, "-")[1]) == 1 then
			var_79_11[iter_79_3.type] = var_79_10
		elseif tonumber(split(iter_79_3.type, "-")[1]) == 2 then
			var_79_11[iter_79_3.type] = var_79_9
		end
	end

	if var_79_11[self.selectedType] then
		var_79_11[self.selectedType]()
	end
end

function SupermarketMarketSprite.isCanUseItem(arg_103_0, arg_103_1)
	if item_data[arg_103_1].bag_item_type == kITEM_WEAPON then
		return playermodel.haveServant[item_data[arg_103_1].servant]
	end

	return true
end

function SupermarketMarketSprite.isShowHaveServant(arg_104_0, arg_104_1)
	local var_104_0 = false
	local var_104_1 = {}

	if item_data[arg_104_1] and item_data[arg_104_1].bag_item_type == kITEM_WEAPON then
		table.insert(var_104_1, item_data[arg_104_1].servant)
	elseif item_data[arg_104_1] and item_data[arg_104_1].bag_item_type == kITEM_GIFT_FOR_FRIEND then
		for iter_104_0, iter_104_1 in pairs(servant_data) do
			if iter_104_1.major == item_data[arg_104_1].exclusive then
				table.insert(var_104_1, iter_104_1.id)
			end
		end
	elseif item_data[arg_104_1] and item_data[arg_104_1].bag_item_type == kITEM_FURNITURE_GIFT and furnitureSuitData[item_data[arg_104_1].suit_id] then
		for iter_104_2, iter_104_3 in pairs(servant_data) do
			if iter_104_3.major == furnitureSuitData[item_data[arg_104_1].suit_id].servantid then
				table.insert(var_104_1, iter_104_3.id)
			end
		end
	end

	for iter_104_4, iter_104_5 in pairs(var_104_1) do
		if playermodel.haveServant[iter_104_5] then
			var_104_0 = true

			break
		end
	end

	return var_104_0
end

function SupermarketMarketSprite:showBuyPop(arg_105_1)
	local var_105_1 = discount_manager:getCanUseCoupin(arg_105_1.itemid, arg_105_1.currency, arg_105_1.costnum or arg_105_1.slidecost.costnum, self.selectedType)

	if var_105_1 and next(var_105_1) then
		self:showBachelorBuyPop(arg_105_1, var_105_1)

		return
	end

	local var_105_2 = {
		[kITEM_FURNITURE_GIFT] = function()
			self:showFurniturePop(arg_105_1)
		end,
		[kITEM_SKIN_GIFT] = function()
			self:showSoulGirlPop(arg_105_1, kITEM_SKIN_GIFT)
		end,
		[kITEM_SKIN] = function()
			self:showSoulGirlPop(arg_105_1, kITEM_SKIN)
		end,
		[KITEM_MARK_GIFT] = function()
			self:buyGift(arg_105_1)
		end,
		[KITEM_MARK_GIFT_SLIDER] = function()
			LayerManager:pushInLayer("PopOpenBagInfoLayer", arg_105_1)
		end,
		[KITEM_EMOTION_CHAT_GIFT] = function()
			LayerManager:pushInLayer("PopBuyChatEmotationGiftLayer", arg_105_1)
		end
	}

	if var_105_2[item_data[arg_105_1.itemid].bag_item_type] then
		var_105_2[item_data[arg_105_1.itemid].bag_item_type]()
	else
		LayerManager:pushInLayer("PopGoodsLayer", arg_105_1)
	end
end

function SupermarketMarketSprite.showBachelorBuyPop(arg_112_0, arg_112_1, arg_112_2)
	local var_112_0 = {
		[kITEM_FURNITURE_GIFT] = function()
			arg_112_1.couponList = arg_112_2

			arg_112_0:showBachelorFurniturePop(arg_112_1)
		end,
		[KITEM_MARK_GIFT] = function()
			arg_112_1.couponList = arg_112_2

			arg_112_0:buyBachelorGift(arg_112_1)
		end,
		[kITEM_SKIN_GIFT] = function()
			arg_112_1.couponList = arg_112_2

			arg_112_0:showSoulGirlPop(arg_112_1, kITEM_SKIN_GIFT)
		end,
		[kITEM_SKIN] = function()
			arg_112_1.couponList = arg_112_2

			arg_112_0:showSoulGirlPop(arg_112_1, kITEM_SKIN)
		end
	}

	if var_112_0[item_data[arg_112_1.itemid].bag_item_type] then
		var_112_0[item_data[arg_112_1.itemid].bag_item_type]()
	else
		LayerManager:pushInLayer("PopGoodsLayer", arg_112_1)
	end
end

function SupermarketMarketSprite:updateTopInfo()
	supermarket_manager:updateCurrencyList(self.costTypeTable)
end

local var_0_43 = 0

function SupermarketMarketSprite:updateTableView()
	self.node_number = var_0_30[self.selectedType] == 1 and 3 or 1
	self.tableViewList[var_0_30[self.selectedType]] = self.tableViewList[var_0_30[self.selectedType]] or self:createTableView()
	self.tableViewList[var_0_30[self.selectedType]].type = self.selectedType
	self.tableViewList[var_0_30[self.selectedType]].isRunAnim = true
	var_0_43 = 0
	self.tableViewList[var_0_30[self.selectedType]].node_number = self.node_number
	self.tableViewList[var_0_30[self.selectedType]].listData = self.listData

	self.tableViewList[var_0_30[self.selectedType]]:reloadData()

	local var_118_0 = var_0_30[self.selectedType]

	for iter_118_0, iter_118_1 in pairs(self.tableViewList) do
		iter_118_1:setVisible(iter_118_0 == var_118_0)
	end
end

local var_0_44 = 0
local var_0_46 = cc.size(630, 1015 + GameDisplay.fix_y * 2 - GameDisplay.notch_height)

function SupermarketMarketSprite:createTableView()
	local var_119_0 = cc.TableView:create(var_0_46)

	var_119_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_119_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_119_0:setAnchorPoint(cc.p(0, 0))

	if self.node_number == 3 then
		var_119_0:setPosition(60 - 10, 61 - GameDisplay.fix_y)
	else
		var_119_0:setPosition(60, 61 - GameDisplay.fix_y)
	end

	var_119_0:setDelegate()
	self.rootlayer:addChild(var_119_0)

	var_119_0.type = self.selectedType
	var_119_0.node_number = self.node_number
	var_119_0.listData = self.listData

	var_119_0:registerScriptHandler(function(arg_121_0, arg_121_1)
		if arg_121_1 == self:getListLen(var_119_0) - 1 then
			return var_0_33[var_119_0.type].width, var_0_33[var_119_0.type].height + 60
		else
			return var_0_33[var_119_0.type].width, var_0_33[var_119_0.type].height
		end
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_119_0:registerScriptHandler(function(arg_120_0, arg_120_1)
		local var_120_0 = arg_120_0:dequeueCell()
		local var_120_1 = 0

		if arg_120_1 == self:getListLen(var_119_0) - 1 then
			var_120_1 = var_0_33[var_119_0.type].height + 60
			var_0_44 = var_0_33[var_119_0.type].width
		else
			var_120_1 = var_0_33[var_119_0.type].height
			var_0_44 = var_0_33[var_119_0.type].width
		end

		if var_120_0 then
			var_0_43 = var_0_43 + 1

			for iter_120_0 = 1, var_119_0.node_number do
				local var_120_3 = var_120_0:getChildByName(iter_120_0)

				var_120_3:setPosition(cc.p(90 + iter_120_0 * var_0_33[var_119_0.type].offsetx + (iter_120_0 - 1) * var_120_3:getContentSize().width, var_0_33[var_119_0.type].height / 2 + var_0_33[var_119_0.type].offsety + ((arg_120_1 == self:getListLen(var_119_0) - 1 or nil) and 60)))

				var_120_3.type = var_119_0.type

				if var_119_0.listData[var_119_0.node_number * arg_120_1 + iter_120_0] then
					var_120_3:setVisible(true)
					var_120_3:update(arg_120_0.listData[var_119_0.node_number * arg_120_1 + iter_120_0])
				else
					var_120_3:setVisible(false)
				end

				if not self.startRunOutAni and var_119_0.isRunAnim and var_119_0.node_number == 1 and var_119_0.node_number * (arg_120_1 + iter_120_0) <= 4 then
					var_120_0:getChildByName(iter_120_0):setOpacity(0)
					var_120_0:getChildByName(iter_120_0):runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_120_1), cc.FadeIn:create(0.1)))
				elseif not self.startRunOutAni and var_119_0.isRunAnim and var_119_0.node_number == 3 and var_119_0.node_number * arg_120_1 + iter_120_0 <= 15 then
					var_120_0:getChildByName(iter_120_0):setOpacity(0)
					var_120_0:getChildByName(iter_120_0):runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_120_1), cc.FadeIn:create(0.1)))
				elseif var_120_0:getChildByName(iter_120_0):getOpacity() < 255 then
					var_120_0:getChildByName(iter_120_0):setOpacity(255)
				end
			end

			if math.ceil(var_0_46.height / var_120_1) <= var_0_43 then
				var_119_0.isRunAnim = false
				var_0_43 = 0
			end
		else
			var_120_0 = cc.TableViewCell:create()

			for iter_120_1 = 1, var_119_0.node_number do
				local var_120_5 = ShopSprite:createWithName("shopSpriteType" .. var_0_30[var_119_0.type])
				local var_120_6 = math.ceil(var_0_46.height / var_120_1)

				var_120_5:setPosition(cc.p(90 + iter_120_1 * var_0_33[var_119_0.type].offsetx + (iter_120_1 - 1) * var_120_5:getContentSize().width, var_0_33[var_119_0.type].height / 2 + var_0_33[var_119_0.type].offsety + ((arg_120_1 == self:getListLen(var_119_0) - 1 or nil) and 60)))

				if arg_120_1 < var_120_6 then
					var_120_5:setOpacity(0)
					var_120_5:runAction(cc.Sequence:create(cc.DelayTime:create((arg_120_1 + 1) * (LAYER_INTO_TIME / var_120_6)), cc.FadeIn:create(LAYER_INTO_TIME / var_120_6)))
				else
					var_120_5:setOpacity(255)
				end

				var_120_5.type = var_119_0.type

				var_120_5:setName(iter_120_1)
				var_120_0:addChild(var_120_5)

				if var_119_0.listData[var_119_0.node_number * arg_120_1 + iter_120_1] then
					var_120_5:setVisible(true)
					var_120_5:update(arg_120_0.listData[var_119_0.node_number * arg_120_1 + iter_120_1])
				else
					var_120_5:setVisible(false)
				end
			end
		end

		if self.startRunOutAni then
			self.startIndex = self.startIndex or arg_120_1

			local var_120_7 = LAYER_OUT_TIME / math.ceil(var_0_46.height / var_120_1)

			for iter_120_2 = 1, var_119_0.node_number do
				var_120_0:getChildByName(iter_120_2):runAction(cc.Sequence:create(cc.DelayTime:create((arg_120_1 - self.startIndex + 1) * var_120_7), cc.FadeOut:create(var_120_7)))
			end
		end

		return var_120_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_119_0:registerScriptHandler(function(arg_122_0, arg_122_1)
		return (self:getListLen(var_119_0))
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)

	return var_119_0
end

function SupermarketMarketSprite:layerOutAni(arg_123_1)
	self.startRunOutAni = true

	self:updateShowingCells()
	self.rootlayer:runAction(cc.Sequence:create(cc.DelayTime:create(LAYER_OUT_TIME), cc.CallFunc:create(arg_123_1)))
end

function SupermarketMarketSprite:updateButtonList()
	for iter_124_0, iter_124_1 in pairs(self.buttonList) do
		iter_124_1.selected = self.selectedType == iter_124_1.button:getName()

		local var_124_1 = var_0_29(iter_124_1.button:getName())

		if var_124_1 == "1_23" then
			var_124_1 = "1_15"
		end

		if iter_124_1.selected then
			iter_124_1.button:loadTextures("SupermarketMarketSprite/" .. var_124_1 .. "_on.png", "SupermarketMarketSprite/" .. var_124_1 .. "_on.png", "", var_0_20)
		else
			iter_124_1.button:loadTextures("SupermarketMarketSprite/" .. var_124_1 .. "_normal.png", "SupermarketMarketSprite/" .. var_124_1 .. "_normal.png", "", var_0_20)
		end
	end
end

function SupermarketMarketSprite:updateButtonRed()
	for iter_125_0, iter_125_1 in pairs(self.buttonList) do
		if self.selectedType == iter_125_1.button:getName() then
			iter_125_1.button:getChildByName("redDot"):setVisible(false)

			for iter_125_2, iter_125_3 in pairs(self.listData) do
				if iter_125_3.isnewitem then
					iter_125_1.button:getChildByName("redDot"):setVisible(true)

					break
				end
			end
		end
	end
end

function SupermarketMarketSprite:refreshTime()
	self.refreshBtn:setVisible(self.refreshmanual[self.selectedType] > 0)

	if self.autoRefreshType[self.selectedType] == var_0_32.NEVER then
		self.refresh_bg:setVisible(false)
		self:updateBtnBuyOnekey()

		return
	else
		self.refresh_bg:setVisible(true)

		if self.refreshmanual[self.selectedType] > 0 then
			self.refresh_bg:setPositionX(460)
		else
			self.refresh_bg:setPositionX(522)
		end
	end

	local function var_126_0(arg_127_0)
		local var_127_0 = {}

		;({
			[var_0_32.EVERY_DAY] = function()
				if #arg_127_0 == 1 then
					table.insert(var_127_0, {
						str = L_MARKET_REFRESH_TIME.Time_Label_Day,
						color = cc.c3b(242, 242, 242)
					})
					table.insert(var_127_0, {
						str = string.format("%02d:00", tonumber(arg_127_0[1])),
						color = cc.c3b(0, 255, 186)
					})
					table.insert(var_127_0, {
						str = L_MARKET_REFRESH_TIME.Refresh,
						color = cc.c3b(242, 242, 242)
					})
				else
					local var_128_0
					local var_128_1 = tonumber(os.date("%H"))

					for iter_128_0 = 1, #arg_127_0 do
						if var_128_1 < tonumber(arg_127_0[iter_128_0]) then
							var_128_0 = tonumber(arg_127_0[iter_128_0])

							break
						end
					end

					var_128_0 = var_128_0 or arg_127_0[1]

					local var_128_2 = string.format("%02d:00", tonumber(var_128_0))

					table.insert(var_127_0, {
						str = L_MARKET_REFRESH_TIME.Next_Time,
						color = cc.c3b(242, 242, 242)
					})
					table.insert(var_127_0, {
						str = var_128_2,
						color = cc.c3b(0, 255, 186)
					})
				end
			end,
			[var_0_32.EVERY_WEEK] = function()
				if #arg_127_0 == 1 then
					table.insert(var_127_0, {
						str = L_MARKET_REFRESH_TIME.Time_Label_Week,
						color = cc.c3b(242, 242, 242)
					})
					table.insert(var_127_0, {
						str = L_WEEK_TEXT[tonumber(arg_127_0[1])],
						color = cc.c3b(0, 255, 186)
					})
					table.insert(var_127_0, {
						str = L_MARKET_REFRESH_TIME.Refresh,
						color = cc.c3b(242, 242, 242)
					})
				else
					local var_129_0
					local var_129_1 = tonumber(os.date("%w"))

					for iter_129_0 = 1, #arg_127_0 do
						if var_129_1 < tonumber(arg_127_0[iter_129_0]) then
							var_129_0 = tonumber(arg_127_0[iter_129_0])

							break
						end
					end

					var_129_0 = var_129_0 or arg_127_0[1]

					table.insert(var_127_0, {
						str = L_MARKET_REFRESH_TIME.Next_Time,
						color = cc.c3b(242, 242, 242)
					})
					table.insert(var_127_0, {
						str = L_WEEK_TEXT[tonumber(var_129_0)],
						color = cc.c3b(0, 255, 186)
					})
				end
			end,
			[var_0_32.EVERY_MONTH] = function()
				if #arg_127_0 == 1 then
					table.insert(var_127_0, {
						str = L_MARKET_REFRESH_TIME.Time_Label_Month,
						color = cc.c3b(242, 242, 242)
					})
					table.insert(var_127_0, {
						str = string.format("%d", tonumber(arg_127_0[1])),
						color = cc.c3b(0, 255, 186)
					})
					table.insert(var_127_0, {
						str = L_MARKET_REFRESH_TIME.Day .. L_MARKET_REFRESH_TIME.Refresh,
						color = cc.c3b(242, 242, 242)
					})
				else
					local var_130_0
					local var_130_1 = tonumber(os.date("%m"))

					for iter_130_0 = 1, #arg_127_0 do
						if var_130_1 < tonumber(arg_127_0[iter_130_0]) then
							var_130_0 = tonumber(arg_127_0[iter_130_0])

							break
						end
					end

					var_130_0 = var_130_0 or arg_127_0[1]

					table.insert(var_127_0, {
						str = L_MARKET_REFRESH_TIME.Next_Time,
						color = cc.c3b(242, 242, 242)
					})
					table.insert(var_127_0, {
						str = string.format("%02d", tonumber(var_130_0)),
						color = cc.c3b(0, 255, 186)
					})
					table.insert(var_127_0, {
						str = L_MARKET_REFRESH_TIME.Day,
						color = cc.c3b(242, 242, 242)
					})
				end
			end
		})[self.autoRefreshType[self.selectedType]]()

		if not next(var_127_0) then
			var_127_0 = {
				{
					str = L_MARKET_REFRESH_TIME.No_Refresh,
					color = cc.c3b(242, 242, 242)
				}
			}
		end

		return var_127_0
	end

	local var_126_1 = (function()
		local var_131_0 = {}

		for iter_131_0 in self.nextRefreshTime[self.selectedType]:gmatch("(%d+)") do
			table.insert(var_131_0, iter_131_0)
		end

		return (var_126_0(var_131_0))
	end)()

	if self.selectedType == "1-13801" then
		var_126_1[1].str = "温馨、灿烂礼包每日"

		self.refresh_bg:setPositionX(410)
	end

	local var_126_2 = 3
	local var_126_3 = 0

	while var_126_2 >= 1 do
		if var_126_1[var_126_2] then
			self.refresh_bg:getChildByName("time_label" .. var_126_2):setAnchorPoint(cc.p(0, 0.5))
			self.refresh_bg:getChildByName("time_label" .. var_126_2):setVisible(true)
			self.refresh_bg:getChildByName("time_label" .. var_126_2):setString(var_126_1[var_126_2].str)
			self.refresh_bg:getChildByName("time_label" .. var_126_2):setColor(var_126_1[var_126_2].color)

			var_126_3 = var_126_3 + self.refresh_bg:getChildByName("time_label" .. var_126_2):getContentSize().width

			if var_126_2 == 1 then
				self.refresh_bg:setContentSize(cc.size(var_126_3 + 10, 40))
			end
		else
			self.refresh_bg:getChildByName("time_label" .. var_126_2):setVisible(false)
		end

		var_126_2 = var_126_2 - 1
	end

	local var_126_4 = 10

	while var_126_1[1] do
		self.refresh_bg:getChildByName("time_label" .. 1):setPositionX(var_126_4)

		var_126_4 = var_126_4 + self.refresh_bg:getChildByName("time_label" .. 1):getContentSize().width
	end

	self:updateBtnBuyOnekey()
end

function SupermarketMarketSprite:updateBtnBuyOnekey()
	if self.selectedType == "2-1" then
		local var_132_0 = self.refresh_bg:getParent()

		if var_132_0:getChildByName("btnbuyonekey") then
			var_132_0:getChildByName("btnbuyonekey"):setVisible(true)
		else
			local var_132_1 = ccui.Button:create("SupermarketMarketSprite/btn_buy_onekey.png", nil, "SupermarketMarketSprite/btn_buy_onekey.png", var_0_20)

			var_132_1:setName("btnbuyonekey")
			var_132_1:setAnchorPoint(cc.p(1, 0.5))
			var_132_1:setPosition(cc.p(self.refresh_bg:getPositionX() - self.refresh_bg:getContentSize().width * self.refresh_bg:getAnchorPoint().x - 20, self.refresh_bg:getPositionY() + 5))
			var_132_0:addChild(var_132_1, self.refresh_bg:getLocalZOrder())
			var_132_1:addTouchEventListener(function(arg_133_0, arg_133_1)
				if arg_133_1 ~= ccui.TouchEventType.ended then
					return
				end

				LayerManager:pushInLayer("PopMarketBuyOnekeyLayer")
			end)
		end
	else
		local var_132_2 = self.refresh_bg:getParent()

		if var_132_2:getChildByName("btnbuyonekey") then
			var_132_2:getChildByName("btnbuyonekey"):setVisible(false)
		end
	end
end

function SupermarketMarketSprite:tisPanel()
	if self.tipsPanel then
		self.tipsPanel:setVisible(true)
		self.tipsImage:setScale(0)
		self.tipsImage:runAction(cc.ScaleTo:create(0.2, 1))
	else
		self.tipsPanel = ccui.Layout:create()

		self.tipsPanel:setBackGroundImageColor(cc.c3b(255, 255, 255))
		self.tipsPanel:setContentSize(cc.size(cc.Director:getInstance():getVisibleSize().width, cc.Director:getInstance():getVisibleSize().height))
		self.tipsPanel:setAnchorPoint(cc.p(0.5, 0.5))
		self.tipsPanel:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
		self.tipsPanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		self.tipsPanel:setBackGroundColor(cc.c3b(0, 0, 0))
		self.tipsPanel:setBackGroundColorOpacity(180)
		self.tipsPanel:setTouchEnabled(true)
		self.tipsPanel:addTouchEventListener(function(arg_135_0, arg_135_1)
			if arg_135_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.tipsPanel:setVisible(false)
		end)
		self:addChild(self.tipsPanel, 100)

		self.tipsImage = ccui.ImageView:create("mainScenebg/guide/17.jpg")

		self.tipsImage:setScale(0)
		self.tipsImage:setPosition(cc.p(self.tipsPanel:getContentSize().width / 2, self.tipsPanel:getContentSize().height / 2))
		self.tipsImage:runAction(cc.ScaleTo:create(0.2, 1))
		self.tipsPanel:addChild(self.tipsImage)
	end
end

function SupermarketMarketSprite:showSoulGirlPop(arg_136_1, arg_136_2)
	local var_136_0 = item_data[arg_136_1.itemid].model
	local var_136_1 = ccs.GUIReader:getInstance()
	local var_136_2 = var_136_1:widgetFromJsonFile(config._DEBUG and "SoulGirlPop.json" or "SoulGirlPop.ExportJson")
	local var_136_3 = ccui.Helper:seekWidgetByName(var_136_2, "Panel_26")

	var_136_3.setLocalZOrder(var_136_1, 1)
	self:addChild(var_136_2)

	self.showSoulGirlScenePanel = ccui.Helper:seekWidgetByName(var_136_2, "Image_back")

	self.showSoulGirlScenePanel:setPosition(cc.p(320, 568))
	self.showSoulGirlScenePanel:setTouchEnabled(true)
	self.showSoulGirlScenePanel:setLocalZOrder(0)

	local var_136_4 = ccui.Helper:seekWidgetByName(var_136_2, "Button_return")

	if model_data[var_136_0].background and model_data[var_136_0].background == "dark" then
		var_136_4:loadTextures("SupermarketMarketSprite/return_btn_dark.png", nil, "SupermarketMarketSprite/return_btn_dark.png", var_0_20)
	else
		var_136_4:loadTextures("SupermarketMarketSprite/return_btn_bright.png", nil, "SupermarketMarketSprite/return_btn_bright.png", var_0_20)
	end

	var_136_4:setLocalZOrder(2)

	local function var_136_5(arg_137_0, arg_137_1)
		if arg_137_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.showgirlLayer:resetCurTalkConfig()
		var_136_2:runAction(cc.RemoveSelf:create())

		var_136_2 = nil
	end

	var_136_4:setTouchEnabled(false)
	self.showSoulGirlScenePanel:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function(...)
		var_136_4:setTouchEnabled(true)
		var_136_4:addTouchEventListener(var_136_5)
	end)))

	local var_136_6 = ccui.Layout:create()

	var_136_6:setTouchEnabled(true)
	var_136_6:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_136_6:setAnchorPoint(cc.p(0, 0))
	var_136_6:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_136_6:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_136_2:addChild(var_136_6, -2)

	local var_136_7 = ccui.Helper:seekWidgetByName(var_136_2, "Panel_cute_role")
	local var_136_8 = ccui.Helper:seekWidgetByName(var_136_2, "Image_cute_role")

	var_136_8:loadTexture("roleimage/role1/" .. model_data[var_136_0].cute_role .. ".png")
	var_136_8:setPosition(cc.p(var_136_7:getContentSize().width / 2, var_136_7:getContentSize().height / 2 + 30))
	var_136_8:setScale(0.4)
	var_136_8:setVisible(false)

	local var_136_9 = ccui.Helper:seekWidgetByName(var_136_2, "Panel_up"):setPositionY(568 + GameDisplay.fix_y)
	local var_136_10 = ccui.Helper:seekWidgetByName(var_136_2, "Panel_down"):setPositionY(568 - GameDisplay.fix_y)

	ccui.Helper:seekWidgetByName(var_136_2, "Panel_down"):setLocalZOrder(3)
	ccui.Helper:seekWidgetByName(var_136_2, "Panel_up"):setLocalZOrder(3)

	local var_136_11 = L2Actor:create(ROLE_SPINE_PATH .. model_data[var_136_0].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_136_0].spine_model .. ".atlas", (model_data[var_136_0].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_136_0].clothes_model .. ".atlas" or nil))

	var_136_11:setScale(model_data[var_136_0].modelscale / 1.3 * 0.4, model_data[var_136_0].modelscale / 1.3 * 0.4)
	var_136_11:setContentSize(cc.size(100, 200))
	var_136_11:setPosition(cc.p(var_136_7:getContentSize().width / 2, var_136_7:getContentSize().height / 2 - 60))
	var_136_7:addChild(var_136_11, 99)
	var_136_11:playAni(nil, "idle", true)
	var_136_7:addTouchEventListener(function(arg_139_0, arg_139_1)
		if arg_139_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_139_0 = math.random(2, 5)

		local function var_139_1()
			var_136_11:playAni(nil, "idle", true)
		end

		if var_139_0 == 2 then
			var_136_11:playAni(var_139_1, "run", false)
		elseif var_139_0 == 3 then
			var_136_11:playAni(var_139_1, "yule", false)
		elseif var_139_0 == 4 then
			var_136_11:playAni(var_139_1, "chihe", false)
		else
			var_136_11:playAni(var_139_1, "fadai", false)
		end
	end)

	local var_136_12 = ccui.Helper:seekWidgetByName(var_136_2, "Label_name")
	local var_136_13 = ccui.Helper:seekWidgetByName(var_136_2, "Image_cv")

	var_136_13:loadTexture("public/panelbg/cv_bg.png", var_0_20)

	if favorfile_data[3][model_data[var_136_0].photofile_model] then
		var_136_13:setVisible(favorfile_data[3][model_data[var_136_0].photofile_model] ~= L_CV_UNSURE)

		local var_136_14 = cc.Label:createWithTTF("CV/" .. favorfile_data[3][model_data[var_136_0].photofile_model], FONT_DES, 28)

		var_136_14:setPosition(cc.p(var_136_13:getContentSize().width / 2, var_136_13:getContentSize().height / 2 - 3))
		var_136_13:addChild(var_136_14)
	else
		var_136_13:setVisible(false)
	end

	var_136_12:setFontSize(global_change_fontsize_by_length(model_data[var_136_0].name, 40, 4, 6))
	var_136_12:setString(model_data[var_136_0].name)
	var_136_12:setLocalZOrder(9999)

	local var_136_15 = ccui.Helper:seekWidgetByName(var_136_2, "Label_name_bottom")
	local var_136_16 = ccui.Helper:seekWidgetByName(var_136_2, "Label_name_top")
	local var_136_17 = model_data[var_136_0].main_name

	if model_data[var_136_0].main_name == "焕丽凤翎" then
		var_136_17 = "焕丽凤  翎"
	end

	var_136_15:setString(var_136_17)
	var_136_16:setString(var_136_17)

	if model_data[var_136_0].background and model_data[var_136_0].background == "bright" then
		var_136_15:setColor(cc.c3b(40, 125, 205))
		var_136_16:setColor(cc.c3b(0, 255, 246))
	end

	local var_136_18 = ccui.Helper:seekWidgetByName(var_136_2, "Image_type")
	local var_136_19

	if model_data[var_136_0].live2d and not model_data[var_136_0].origin then
		var_136_19 = "SupermarketMarketSprite/skin_type_live2d.png"
	elseif model_data[var_136_0].rolespine then
		var_136_19 = "SupermarketMarketSprite/skin_type_spine.png"
	else
		var_136_18:setVisible(false)
	end

	local var_136_20 = model_data[var_136_0].uncolor_clothes
	local var_136_21 = ccui.Button:create("SupermarketMarketSprite/btn_uncolor.png", nil, "SupermarketMarketSprite/btn_uncolor.png", var_0_20)

	var_136_21:setPosition(cc.p(var_136_18:getPositionX(), var_136_18:getPositionY() + 100))
	var_136_18:getParent():addChild(var_136_21)

	local var_136_22

	if var_136_20 then
		function arg_136_1.updateLayerCallback()
			self:updateTopInfo()

			self.listData[arg_136_1.index].have_bought = self.listData[arg_136_1.index].have_bought + 1
			self.listData[arg_136_1.index].sell_out = self.listData[arg_136_1.index].buy_limit and self.listData[arg_136_1.index].buy_limit <= self.listData[arg_136_1.index].have_bought

			self:updateShowingCells()
		end

		var_136_22 = shop_manager:fixUnColorMsg(arg_136_1, tonumber(split(self.selectedType, "-")[2]))
	end

	var_136_21:setVisible(var_136_20 ~= nil)
	var_136_21:addTouchEventListener(function(arg_142_0, arg_142_1)
		if arg_142_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_142_0.curmodel == tostring(var_136_20) then
			self.showgirlLayer:update(tostring(var_136_0))

			arg_142_0.curmodel = tostring(var_136_0)

			self:updateSoulGirlPop(var_136_2, arg_136_1, arg_136_2, var_136_11)
			var_136_21:loadTextures("SupermarketMarketSprite/btn_uncolor.png", nil, "SupermarketMarketSprite/btn_uncolor.png", var_0_20)
		else
			self.showgirlLayer:update(tostring(var_136_20))

			arg_142_0.curmodel = tostring(var_136_20)

			self:updateSoulGirlPop(var_136_2, var_136_22, arg_136_2, var_136_11)
			var_136_21:loadTextures("SupermarketMarketSprite/btn_uncolor_on.png", nil, "SupermarketMarketSprite/btn_uncolor_on.png", var_0_20)
		end
	end)
	var_136_18:loadTextures(var_136_19, nil, var_136_19, var_0_20)
	var_136_18:addTouchEventListener(function(arg_143_0, arg_143_1)
		if arg_143_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:tisPanel()
	end)

	local var_136_23 = ccui.Helper:seekWidgetByName(var_136_2, "Image_cost_bottom")

	var_136_23:loadTexture("SupermarketMarketSprite/cost_bottom_bright.png", var_0_20)
	ccui.Helper:seekWidgetByName(var_136_2, "Image_name"):loadTexture("SupermarketMarketSprite/skin_name_bottom_bright.png", var_0_20)

	local var_136_24 = ccui.Helper:seekWidgetByName(var_136_2, "Button_buy")

	var_136_24:loadTextures("SupermarketMarketSprite/buy_btn_bright.png", nil, "SupermarketMarketSprite/buy_btn_bright.png", var_0_20)

	local var_136_25 = ccui.Layout:create()

	var_136_25:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_136_25:setAnchorPoint(cc.p(0.5, 0.5))
	var_136_25:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_136_25:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_136_25:setBackGroundColor(cc.c3b(0, 0, 0))
	var_136_25:setBackGroundColorOpacity(0)
	var_136_3:addChild(var_136_25, 2)

	local var_136_26 = cc.EventListenerTouchOneByOne:create()

	var_136_26:setSwallowTouches(false)
	var_136_26:registerScriptHandler(function(arg_144_0, arg_144_1)
		if arg_136_1.have_bought_num == 1 then
			return true
		end

		if var_0_27[playermodel.playerid][var_136_0] > PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT + 1 and arg_136_1.have_bought_num ~= 1 then
			function arg_136_1.shopcallback()
				if var_136_2 then
					var_136_2:runAction(cc.RemoveSelf:create())
				end

				var_136_2 = nil
			end

			LayerManager:pushInLayer("PopGoodsLayer", arg_136_1)

			return true
		elseif var_0_27[playermodel.playerid][var_136_0] >= PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT then
			var_0_27[playermodel.playerid][var_136_0] = var_0_27[playermodel.playerid][var_136_0] + 1

			global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Interaciton_Used_Up)

			return false
		else
			return true
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_136_26:registerScriptHandler(function(arg_146_0, arg_146_1)
		return false
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_136_25:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_136_26, var_136_25)
	var_136_24:addTouchEventListener(function(arg_147_0, arg_147_1)
		if arg_147_1 ~= ccui.TouchEventType.ended then
			return
		end

		function arg_136_1.shopcallback(arg_148_0)
			if var_136_2 then
				var_136_2:runAction(cc.RemoveSelf:create())
			end

			var_136_2 = nil
		end

		LayerManager:pushInLayer("PopGoodsLayer", arg_136_1)
	end)

	if arg_136_1.have_bought_num == 1 then
		var_136_24:setVisible(false)
		var_136_23:setVisible(false)
	end

	local var_136_27 = ccui.Helper:seekWidgetByName(var_136_2, "Image_costType_new")
	local var_136_28 = ccui.Helper:seekWidgetByName(var_136_2, "Label_cost_num_new")

	self.showSoulGirlScenePanel:setVisible(true)
	var_136_27:loadTexture(arg_136_1.slidecost.costtype, var_0_20)
	var_136_28:setString(arg_136_1.slidecost.costnum)

	local var_136_29 = ccui.Helper:seekWidgetByName(var_136_2, "Panel_old_cost")

	if arg_136_1.cost_old == arg_136_1.slidecost.costnum then
		var_136_29:setVisible(false)
		var_136_27:setPositionX(var_136_27:getPositionX() - 50)
		var_136_28:setPositionX(var_136_28:getPositionX() - 50)
	else
		var_136_29:getChildByName("Label_cost_num"):setString(arg_136_1.cost_old)
		var_136_29:getChildByName("Image_costType"):loadTexture(arg_136_1.slidecost.costtype, var_0_20)
	end

	self.showgirlLayer = require("view.Layer.ShowGirlLayer"):create(var_136_0, 3)

	self.showgirlLayer:resetCurTalkConfig()

	if not var_0_27[playermodel.playerid] then
		var_0_27[playermodel.playerid] = {}
		var_0_27[playermodel.playerid][var_136_0] = var_0_27[playermodel.playerid][var_136_0] or 0
	else
		var_0_27[playermodel.playerid][var_136_0] = var_0_27[playermodel.playerid][var_136_0] or 0
	end

	self.showgirlLayer:setTalkEnabled(arg_136_1.have_bought_num > 0 or var_0_27[playermodel.playerid][var_136_0] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	self.showgirlLayer:setTouchTalkCallback(function()
		var_0_27[playermodel.playerid][var_136_0] = var_0_27[playermodel.playerid][var_136_0] + 1

		self.showgirlLayer:setTalkEnabled(arg_136_1.have_bought_num > 0 or var_0_27[playermodel.playerid][var_136_0] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	end)
	var_136_3:addChild(self.showgirlLayer, 1)

	if model_data[var_136_0].backgroundid then
		local var_136_31 = BackGroundLayer:create(model_data[var_136_0].backgroundid, (model_data[var_136_0].is_own_full_screen_background == 1 or nil) and 2)

		var_136_3:addChild(var_136_31, 0)
		var_136_31:setName("backGroundLayer")
	end

	if arg_136_1.limit_buy_num <= 0 and var_136_20 then
		self.showgirlLayer:update(tostring(var_136_20))

		var_136_21.curmodel = tostring(var_136_20)

		self:updateSoulGirlPop(var_136_2, var_136_22, arg_136_2, var_136_11)
		var_136_21:loadTextures("SupermarketMarketSprite/btn_uncolor_on.png", nil, "SupermarketMarketSprite/btn_uncolor_on.png", var_0_20)
	end
end

function SupermarketMarketSprite.updateSoulGirlPop(arg_150_0, arg_150_1, arg_150_2, arg_150_3, arg_150_4)
	local var_150_0 = item_data[arg_150_2.itemid].model
	local var_150_1 = ccui.Helper:seekWidgetByName(arg_150_1, "Panel_26")
	local var_150_2 = ccui.Helper:seekWidgetByName(arg_150_1, "Button_return")

	if model_data[item_data[arg_150_2.itemid].model].background and model_data[var_150_0].background == "dark" then
		var_150_2:loadTextures("SupermarketMarketSprite/return_btn_dark.png", nil, "SupermarketMarketSprite/return_btn_dark.png", var_0_20)
	else
		var_150_2:loadTextures("SupermarketMarketSprite/return_btn_bright.png", nil, "SupermarketMarketSprite/return_btn_bright.png", var_0_20)
	end

	local var_150_3 = ccui.Helper:seekWidgetByName(arg_150_1, "Panel_cute_role")

	ccui.Helper:seekWidgetByName(arg_150_1, "Image_cute_role"):loadTexture("roleimage/role1/" .. model_data[var_150_0].cute_role .. ".png")
	ccui.Helper:seekWidgetByName(arg_150_1, "Label_name_bottom"):setString(model_data[var_150_0].main_name)
	ccui.Helper:seekWidgetByName(arg_150_1, "Label_name_top"):setString(model_data[var_150_0].main_name)
	arg_150_4:updateSpine(ROLE_SPINE_PATH .. model_data[var_150_0].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_150_0].spine_model .. ".atlas", (model_data[var_150_0].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_150_0].clothes_model .. ".atlas" or nil))
	arg_150_4:setScale(model_data[var_150_0].modelscale / 1.3 * 0.4, model_data[var_150_0].modelscale / 1.3 * 0.4)
	arg_150_4:playAni(nil, "idle", true)

	local var_150_4 = ccui.Helper:seekWidgetByName(arg_150_1, "Image_cost_bottom")
	local var_150_5 = ccui.Helper:seekWidgetByName(arg_150_1, "Button_buy")

	var_150_5:addTouchEventListener(function(arg_151_0, arg_151_1)
		if arg_151_1 ~= ccui.TouchEventType.ended then
			return
		end

		function arg_150_2.shopcallback(arg_152_0)
			if arg_150_1 then
				arg_150_1:runAction(cc.RemoveSelf:create())
			end

			arg_150_1 = nil
		end

		LayerManager:pushInLayer("PopGoodsLayer", arg_150_2)
	end)

	if arg_150_2.have_bought_num == 1 then
		var_150_5:setVisible(false)
		var_150_4:setVisible(false)
	else
		var_150_5:setVisible(true)
		var_150_4:setVisible(true)
	end

	ccui.Helper:seekWidgetByName(arg_150_1, "Image_costType_new"):loadTexture(arg_150_2.slidecost.costtype, var_0_20)
	ccui.Helper:seekWidgetByName(arg_150_1, "Label_cost_num_new"):setString(arg_150_2.slidecost.costnum)

	local var_150_6 = ccui.Helper:seekWidgetByName(arg_150_1, "Panel_old_cost")

	if arg_150_2.cost_old == arg_150_2.slidecost.costnum then
		var_150_6:setVisible(false)
	else
		var_150_6:getChildByName("Label_cost_num"):setString(arg_150_2.cost_old)
		var_150_6:getChildByName("Image_costType"):loadTexture(arg_150_2.slidecost.costtype, var_0_20)
	end

	if model_data[var_150_0].backgroundid then
		var_150_1:getChildByName("backGroundLayer"):update(model_data[var_150_0].backgroundid, (model_data[var_150_0].is_own_full_screen_background == 1 or nil) and 2)
	end
end

function SupermarketMarketSprite:showFurniturePop(arg_153_1)
	local var_153_0 = ccui.Layout:create()

	var_153_0:setTouchEnabled(true)
	var_153_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_153_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_153_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_153_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_153_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_153_0:setBackGroundColorOpacity(180)
	self:addChild(var_153_0, 10)

	local var_153_1 = ccui.ImageView:create("public/panelbg/bg_pop_small.png", var_0_20)

	var_153_1:setPosition(cc.p(var_153_0:getContentSize().width / 2, var_153_0:getContentSize().height / 2))
	var_153_1:setScaleY(0)
	var_153_1:setScaleY(0)
	var_153_1:runAction(cc.ScaleTo:create(0.2, 1.2))
	var_153_0:addChild(var_153_1)

	local var_153_2 = ccui.ImageView:create("mainScenebg/market/" .. arg_153_1.itemid .. ".jpg")

	var_153_2:setPosition(cc.p(var_153_0:getContentSize().width / 2, var_153_0:getContentSize().height / 2))
	var_153_0:addChild(var_153_2)

	local var_153_3 = ccui.ImageView:create("SupermarketMarketSprite/furniture_bg.png", var_0_20)

	var_153_3:setPosition(cc.p(var_153_2:getContentSize().width / 2, var_153_2:getContentSize().height / 2))
	var_153_2:addChild(var_153_3)

	local var_153_4 = string_split(item_data[arg_153_1.itemid].name, "】")

	if #var_153_4 == 2 then
		local var_153_5 = cc.Label:createWithTTF(var_153_4[2], FONT_DES, 26)

		var_153_5:setPosition(cc.p(470, 188))
		var_153_5:setColor(cc.c3b(187, 62, 198))
		var_153_3:addChild(var_153_5)

		local var_153_6 = cc.Label:createWithTTF(var_153_4[2], FONT_DES, 26)

		var_153_6:setPosition(cc.p(472, 188))
		var_153_6:setColor(cc.c3b(0, 168, 255))
		var_153_3:addChild(var_153_6)
	else
		local var_153_7 = cc.Label:createWithTTF(item_data[arg_153_1.itemid].name, FONT_DES, 26)

		var_153_7:setPosition(cc.p(470, 188))
		var_153_7:setColor(cc.c3b(187, 62, 198))
		var_153_3:addChild(var_153_7)

		local var_153_8 = cc.Label:createWithTTF(item_data[arg_153_1.itemid].name, FONT_DES, 26)

		var_153_8:setPosition(cc.p(472, 188))
		var_153_8:setColor(cc.c3b(0, 168, 255))
		var_153_3:addChild(var_153_8)
	end

	local var_153_9 = ccui.ImageView:create(arg_153_1.slidecost.costtype, var_0_20)

	var_153_9:setPositionX(var_153_3:getContentSize().width / 2 - 30)
	var_153_9:setPositionY(-130)
	var_153_3:addChild(var_153_9)

	local var_153_10 = cc.Label:createWithTTF(arg_153_1.slidecost.costnum, FONT_DES, 23)

	var_153_10:setAnchorPoint(cc.p(0, 0.5))
	var_153_10:setPositionX(var_153_9:getPositionX() + var_153_9:getContentSize().width / 2 + 5)
	var_153_10:setPositionY(var_153_9:getPositionY())
	var_153_3:addChild(var_153_10)

	local var_153_11
	local var_153_12

	if arg_153_1.limit_buy_num == 0 then
		var_153_11 = ccui.Button:create("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_20)
		var_153_12 = cc.Label:createWithTTF(L_MARKET_GOODS_LACK, FONT_BUTTON, 26)
	else
		var_153_11 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_20)
		var_153_12 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)
	end

	var_153_12:setColor(cc.c3b(12, 12, 12))
	var_153_11:setPosition(cc.p(var_153_3:getContentSize().width / 2, -60))
	var_153_12:setPosition(cc.p(var_153_11:getContentSize().width / 2, var_153_11:getContentSize().height / 2 - 5))
	var_153_11:addChild(var_153_12)
	var_153_3:addChild(var_153_11)
	var_153_11:addTouchEventListener(function(arg_154_0, arg_154_1)
		if arg_154_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_153_1.ShopSliderCallback then
			arg_153_1.ShopSliderCallback(arg_154_0, arg_154_1, function()
				var_153_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_153_0:runAction(cc.RemoveSelf:create())
				end)))
				var_153_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_153_0:runAction(cc.RemoveSelf:create())
				end)))
			end)
		end
	end)
	var_153_2:setScaleY(0)
	var_153_2:runAction(cc.ScaleTo:create(0.2, 1))
	var_153_0:addTouchEventListener(function(arg_158_0, arg_158_1)
		var_153_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_153_0:runAction(cc.RemoveSelf:create())
		end)))
		var_153_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_153_0:runAction(cc.RemoveSelf:create())
		end)))
	end)
end

function SupermarketMarketSprite:buyGift(arg_161_1)
	local var_161_0 = ccui.Layout:create()

	var_161_0:setTouchEnabled(true)
	var_161_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_161_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_161_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_161_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_161_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_161_0:setBackGroundColorOpacity(180)
	self:addChild(var_161_0, 10)

	local var_161_1 = ccui.ImageView:create(var_0_36[var_0_30[self.selectedType]] .. arg_161_1.itemid .. var_0_37[var_0_30[self.selectedType]])

	var_161_1:setPosition(cc.p(var_161_0:getContentSize().width / 2, var_161_0:getContentSize().height / 2))
	var_161_0:addChild(var_161_1)

	local var_161_2 = ccui.ImageView:create(arg_161_1.slidecost.costtype, var_0_20)

	var_161_2:setPositionX(var_161_1:getContentSize().width / 2 - 20)
	var_161_2:setPositionY(-130)
	var_161_1:addChild(var_161_2)

	local var_161_3 = cc.Label:createWithTTF(arg_161_1.slidecost.costnum, FONT_DES, 23)

	var_161_3:setAnchorPoint(cc.p(0, 0.5))
	var_161_3:setPositionX(var_161_2:getPositionX() + var_161_2:getContentSize().width / 2 + 5)
	var_161_3:setPositionY(var_161_2:getPositionY())
	var_161_1:addChild(var_161_3)

	local var_161_4 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_20)
	local var_161_5 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)

	var_161_5:setColor(cc.c3b(12, 12, 12))
	var_161_4:setPosition(cc.p(var_161_1:getContentSize().width / 2, -70))
	var_161_5:setPosition(cc.p(var_161_4:getContentSize().width / 2, var_161_4:getContentSize().height / 2 - 5))
	var_161_4:addChild(var_161_5)
	var_161_1:addChild(var_161_4)
	var_161_4:addTouchEventListener(function(arg_162_0, arg_162_1)
		if arg_162_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_161_1.ShopSliderCallback then
			arg_161_1.ShopSliderCallback(arg_162_0, arg_162_1, function()
				var_161_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_161_0:runAction(cc.RemoveSelf:create())
				end)))
			end)
		end
	end)
	var_161_1:setScaleY(0)
	var_161_1:runAction(cc.ScaleTo:create(0.2, 1))
	var_161_0:addTouchEventListener(function(arg_165_0, arg_165_1)
		var_161_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_161_0:runAction(cc.RemoveSelf:create())
		end)))
	end)
	;(function(...)
		local var_167_0

		for iter_167_0, iter_167_1 in pairs(self.listData) do
			if iter_167_1.shopid == arg_161_1.shopid then
				var_167_0 = iter_167_1
			end
		end

		if not var_167_0 then
			return
		end

		local var_167_1 = var_161_1

		while var_167_1:getChildByName("itemsprite_" .. 1) do
			var_167_1:getChildByName("itemsprite_" .. 1):setName("itemsprite_old" .. 1)
			var_167_1:getChildByName("itemsprite_old" .. 1):runAction(cc.RemoveSelf:create())
		end

		if not shop_data[var_167_0.shopid].shop_ui_type then
			return
		end

		local var_167_3 = drop_manager:getDropMsg(item_data[var_167_0.itemid].mode_id)

		table.sort(var_167_3.equips, function(arg_168_0, arg_168_1)
			return arg_168_0._index < arg_168_1._index
		end)

		local var_167_4 = {}

		if var_167_3.diamond > 0 then
			table.insert(var_167_4, {
				itemid = "diamond",
				num = var_167_3.diamond,
				name = L_DIAMOND
			})
		end

		if var_167_3.gold > 0 then
			table.insert(var_167_4, {
				itemid = "gold",
				num = var_167_3.gold,
				name = L_GOLD
			})
		end

		local var_167_5 = {}
		local var_167_6 = false
		local var_167_7 = false

		for iter_167_2, iter_167_3 in pairs(var_167_3.equips) do
			if item_data[iter_167_3.dropid].bag_item_type == kITEM_SKIN then
				return
			end

			if item_data[iter_167_3.dropid].bag_item_type == kITEM_GIFT_FOR_FRIEND then
				var_167_7 = true
			end

			if item_data[iter_167_3.dropid].bag_item_type == kITEM_FURNITURE then
				-- block empty
			end

			table.insert(var_167_5, {
				itemid = iter_167_3.dropid,
				num = iter_167_3.dropNum
			})
		end

		if var_167_7 and var_167_7 then
			var_167_6 = true
		end

		local var_167_10 = false

		while var_167_5[1] do
			local var_167_11 = false

			if item_data[var_167_5[1].itemid].bag_item_type == kITEM_FURNITURE then
				if not var_167_10 then
					var_167_10 = true
					var_167_5[1].path = string.gsub(var_167_0.icon, ".png", "_furniture.jpg")
				else
					var_167_11 = true
				end
			end

			local var_167_12

			if var_167_11 then
				table.remove(var_167_5, 1)
			else
				var_167_12 = 1 + 1
			end
		end

		for iter_167_4, iter_167_5 in pairs(var_167_5) do
			table.insert(var_167_4, iter_167_5)
		end

		local var_167_13 = {}

		var_167_13 = var_167_6 and {
			cc.p(122, 479),
			cc.p(122, 324),
			cc.p(122, 169)
		} or #var_167_4 == 2 and {
			cc.p(122, 465),
			cc.p(122, 275)
		} or #var_167_4 == 3 and {
			cc.p(122, 211),
			cc.p(122, 352),
			cc.p(122, 494)
		} or {
			cc.p(122, 211),
			cc.p(122, 352),
			cc.p(122, 494)
		}

		for iter_167_6, iter_167_7 in pairs(var_167_4) do
			local var_167_14 = ItemSpriteShop:createSignItem()

			var_167_14:updateSignItemByItemid(iter_167_7.itemid, iter_167_7.num, nil, nil, iter_167_7.path)
			var_167_14:setName("itemsprite_" .. iter_167_6)
			var_167_14:setPosition(var_167_13[iter_167_6])
			var_167_1:addChild(var_167_14)
			var_167_14:setInfoTouchEvent(true)
			var_167_14:setSwallowTouches(true)
		end
	end)()
end

function SupermarketMarketSprite.getListLen(arg_169_0, arg_169_1)
	return math.ceil(#arg_169_1.listData / arg_169_1.node_number)
end

function SupermarketMarketSprite:updateShowingCells()
	local var_170_0, var_170_1 = GetTableViewShowCellIdx(self.tableViewList[var_0_30[self.selectedType]], {
		cellsize = cc.size(var_0_33[self.selectedType].width, var_0_33[self.selectedType].height),
		maxcount = self:getListLen(self.tableViewList[var_0_30[self.selectedType]])
	})

	for iter_170_0 = var_170_0, var_170_1 do
		self.tableViewList[var_0_30[self.selectedType]]:updateCellAtIndex(iter_170_0)
	end
end

function SupermarketMarketSprite:updateNewAlert()
	local var_171_0 = false

	for iter_171_0, iter_171_1 in pairs(self.listData) do
		if iter_171_1.isnewitem then
			var_171_0 = true

			return
		end
	end

	if var_171_0 == false then
		alert_manager:unregister_alert(ALERT_NEW_MARKET)
	end
end

function SupermarketMarketSprite:updateBlackCardDes()
	if ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):getChildByName("img1") then
		ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):getChildByName("img1"):setVisible(false)
	end

	if ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):getChildByName("img2") then
		ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):getChildByName("img2"):setVisible(false)
	end

	if self.openSingleMarket and self.selectedType == "1-3" then
		if not ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):getChildByName("img1") then
			local var_172_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom")
			local var_172_1 = ccui.ImageView:create("SupermarketMarketSprite/tips_blackcard.png", var_0_20)

			var_172_1.setAnchorPoint(var_172_0, cc.p(0.5, 0.5))
			var_172_1:setPositionX(450)
			var_172_1:setPositionY(var_172_0:getContentSize().height / 2)
			var_172_1:setName("img1")
			ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):addChild(var_172_1)
		end

		ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):getChildByName("img1"):setVisible(true)
	end

	if self.openSingleMarket and self.selectedType == "1-11" then
		if not ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):getChildByName("img2") then
			local var_172_2 = ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom")
			local var_172_3 = ccui.ImageView:create("SupermarketMarketSprite/tips_blackcard_sp.png", var_0_20)

			var_172_3.setAnchorPoint(var_172_2, cc.p(0.5, 0.5))
			var_172_3:setPositionX(420)
			var_172_3:setPositionY(var_172_2:getContentSize().height / 2)
			var_172_3:setName("img2")
			ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):addChild(var_172_3)
		end

		ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):getChildByName("img2"):setVisible(true)
	end
end

function SupermarketMarketSprite:registerTimeCheckEvent()
	local var_173_0 = {}

	for iter_173_0, iter_173_1 in pairs(self.marketData) do
		if iter_173_1.refreshtype > 0 and iter_173_1.refreshtime then
			var_173_0[iter_173_1.refreshtype] = var_173_0[iter_173_1.refreshtype] or {}

			local var_173_1 = {}

			for iter_173_2 in iter_173_1.refreshtime:gmatch("(%d+)") do
				table.insert(var_173_1, iter_173_2)
			end

			for iter_173_3, iter_173_4 in pairs(var_173_1) do
				var_173_0[iter_173_1.refreshtype][string.format("%02d", iter_173_4)] = var_173_0[iter_173_1.refreshtype][string.format("%02d", iter_173_4)] or {}
				var_173_0[iter_173_1.refreshtype][string.format("%02d", iter_173_4)][iter_173_1.type] = var_173_0[iter_173_1.refreshtype][string.format("%02d", iter_173_4)][iter_173_1.type] or true
			end
		end
	end

	local var_173_2 = {
		DAY = 3,
		HOUR = 1,
		WDAY = 2
	}

	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("timeCheckManagerEvent", function(arg_174_0)
		if not var_173_0 or not next(var_173_0) then
			return
		end

		local var_174_0 = var_173_2[split(arg_174_0.eventType, "_")[1]]
		local var_174_1 = string.format("%02d", tostring(split(arg_174_0.eventType, "_")[2]))

		if var_173_0[var_174_0] and var_173_0[var_174_0][var_174_1] and var_173_0[var_174_0][var_174_1][self.selectedType] then
			self:showConfirmDialogPop()
			self:refreshTime()
			self:refreshTableData()
			self:updateCurActiveTime()
		end
	end), self)
end

function SupermarketMarketSprite.showConfirmDialogPop(arg_175_0)
	local var_175_0 = L_MARKET_CONFIRM_DIALOG.des
	local var_175_1 = L_MARKET_CONFIRM_DIALOG.title
	local var_175_2 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_Chapter_require.json" or "Pop_Chapter_require.ExportJson")
	local var_175_3 = string.len(L_MARKET_CONFIRM_DIALOG.des) * 8 + 10 > 320 and 320 or string.len(var_175_0) * 8 + 10

	ccui.Helper:seekWidgetByName(var_175_2, "Panel"):setContentSize(GameDisplay.getUiScreenSize())

	local var_175_5 = ccui.Helper:seekWidgetByName(var_175_2, "box")

	var_175_5:setPositionY(var_175_5:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
	ccui.Helper:seekWidgetByName(var_175_2, "description"):setContentSize(var_175_3, 60)
	ccui.Helper:seekWidgetByName(var_175_2, "title"):setString(var_175_1)
	ccui.Helper:seekWidgetByName(var_175_2, "description"):setString(var_175_0)
	ccui.Helper:seekWidgetByName(var_175_2, "image_Q"):loadTexture("roleimage/role1/100.png")

	local var_175_6 = ccui.Helper:seekWidgetByName(var_175_2, "button")

	var_175_6:getChildByName("button_label"):setString(L_BUTTON_TEXT.Sure)
	var_175_6:addTouchEventListener(function(arg_176_0, arg_176_1)
		if arg_176_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_175_2:runAction(cc.RemoveSelf:create())
	end)
	var_175_2:addTouchEventListener(function(arg_177_0, arg_177_1)
		if arg_177_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_175_2:runAction(cc.RemoveSelf:create())
	end)
	global_basic_scene:addChild(var_175_2, 100)
end

function SupermarketMarketSprite:registerGuidesEvent()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("select_market_type", function(arg_179_0)
		self.selectedType = arg_179_0.params

		self:updateButtonList()
		self:refreshTime()
		self:refreshTableData()
		self:updateCurActiveTime()
		self:checkpushBrowseTime()
	end), self)
end

function SupermarketMarketSprite:getShowStat()
	if self.openSingleMarket then
		return 1
	else
		return 0
	end
end

function SupermarketMarketSprite:playPumpkinSpine(arg_181_1)
	audio_manager:playeffectMusicTest("sound/halloween_open_package")

	if not self.skeletonData then
		self.skeletonData = SpineCacheManager:addSpineData(UI_SPINE_PATH .. "halloween_package.json", UI_SPINE_PATH .. "halloween_package.atlas")

		self.skeletonData:retain()
	end

	local var_181_0 = ccui.Layout:create()

	var_181_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_181_0:setAnchorPoint(cc.p(0, 0))
	var_181_0:setPosition(cc.p(0, 0))
	var_181_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_181_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_181_0:setBackGroundColorOpacity(180)
	cc.Director:getInstance():getRunningScene():addChild(var_181_0, 1000)
	var_181_0:runAction(cc.Sequence:create(cc.DelayTime:create(1.8), cc.CallFunc:create(function(...)
		if arg_181_1 then
			arg_181_1()
		end
	end), cc.RemoveSelf:create()))
	var_181_0:setTouchEnabled(true)
	var_181_0:addTouchEventListener(function(arg_183_0, arg_183_1)
		if arg_183_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_181_0:runAction(cc.RemoveSelf:create())

		if arg_181_1 then
			arg_181_1()
		end
	end)

	local var_181_1 = sp.SkeletonAnimation:create(self.skeletonData:getData())

	var_181_1:setPositionX(GameDisplay.width / 2)
	var_181_1:setPositionY(GameDisplay.height / 2)
	var_181_0:addChild(var_181_1)
	var_181_1:setAnimation(0, "animation", false)
end

function SupermarketMarketSprite:showBachelorFurniturePop(arg_184_1)
	local var_184_0 = ccui.Layout:create()

	var_184_0:setTouchEnabled(true)
	var_184_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_184_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_184_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_184_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_184_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_184_0:setBackGroundColorOpacity(180)
	self:addChild(var_184_0, 10)

	local var_184_1 = ccui.ImageView:create("public/panelbg/bg_pop_small.png", var_0_20)

	var_184_1:setPosition(cc.p(var_184_0:getContentSize().width / 2, var_184_0:getContentSize().height / 2))
	var_184_1:setScaleY(0)
	var_184_1:setScaleY(0)
	var_184_1:runAction(cc.ScaleTo:create(0.2, 1.2))
	var_184_0:addChild(var_184_1)

	local var_184_2 = ccui.ImageView:create("mainScenebg/market/" .. arg_184_1.itemid .. ".jpg")

	var_184_2:setPosition(cc.p(var_184_0:getContentSize().width / 2, var_184_0:getContentSize().height / 2))
	var_184_0:addChild(var_184_2)

	local var_184_3 = ccui.ImageView:create("SupermarketMarketSprite/furniture_bg.png", var_0_20)

	var_184_3:setPosition(cc.p(var_184_2:getContentSize().width / 2, var_184_2:getContentSize().height / 2))
	var_184_2:addChild(var_184_3)

	local var_184_4 = string_split(item_data[arg_184_1.itemid].name, "】")

	if #var_184_4 == 2 then
		local var_184_5 = cc.Label:createWithTTF(var_184_4[2], FONT_DES, 26)

		var_184_5:setPosition(cc.p(470, 188))
		var_184_5:setColor(cc.c3b(187, 62, 198))
		var_184_3:addChild(var_184_5)

		local var_184_6 = cc.Label:createWithTTF(var_184_4[2], FONT_DES, 26)

		var_184_6:setPosition(cc.p(472, 188))
		var_184_6:setColor(cc.c3b(0, 168, 255))
		var_184_3:addChild(var_184_6)
	else
		local var_184_7 = cc.Label:createWithTTF(item_data[arg_184_1.itemid].name, FONT_DES, 26)

		var_184_7:setPosition(cc.p(470, 188))
		var_184_7:setColor(cc.c3b(187, 62, 198))
		var_184_3:addChild(var_184_7)

		local var_184_8 = cc.Label:createWithTTF(item_data[arg_184_1.itemid].name, FONT_DES, 26)

		var_184_8:setPosition(cc.p(472, 188))
		var_184_8:setColor(cc.c3b(0, 168, 255))
		var_184_3:addChild(var_184_8)
	end

	local var_184_9 = ccui.ImageView:create(arg_184_1.slidecost.costtype, var_0_20)

	var_184_9:setPositionX(var_184_3:getContentSize().width / 2 - 30)
	var_184_9:setPositionY(-130)
	var_184_3:addChild(var_184_9)

	local var_184_10 = cc.Label:createWithTTF(arg_184_1.slidecost.costnum, FONT_DES, 23)

	var_184_10:setAnchorPoint(cc.p(0, 0.5))
	var_184_10:setPositionX(var_184_9:getPositionX() + var_184_9:getContentSize().width / 2 + 5)
	var_184_10:setPositionY(var_184_9:getPositionY())
	var_184_3:addChild(var_184_10)

	local var_184_11
	local var_184_12

	if arg_184_1.limit_buy_num == 0 then
		var_184_11 = ccui.Button:create("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_20)
		var_184_12 = cc.Label:createWithTTF(L_MARKET_GOODS_LACK, FONT_BUTTON, 26)
	else
		var_184_11 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_20)
		var_184_12 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)
	end

	var_184_12:setColor(cc.c3b(12, 12, 12))
	var_184_11:setPosition(cc.p(var_184_3:getContentSize().width / 2, -60))
	var_184_12:setPosition(cc.p(var_184_11:getContentSize().width / 2, var_184_11:getContentSize().height / 2 - 5))
	var_184_11:addChild(var_184_12)
	var_184_3:addChild(var_184_11)
	var_184_2:setScaleY(0)
	var_184_2:runAction(cc.ScaleTo:create(0.2, 1))
	var_184_0:addTouchEventListener(function(arg_185_0, arg_185_1)
		var_184_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_184_0:runAction(cc.RemoveSelf:create())
		end)))
		var_184_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_184_0:runAction(cc.RemoveSelf:create())
		end)))
	end)

	local var_184_13 = ccui.ImageView:create("public/panelbg/coupon_select_bg.png", var_0_20)

	var_184_13:setScale9Enabled(true)
	var_184_13:setCapInsets(cc.rect(0, 0, 10, 10))
	var_184_13:setContentSize(cc.size(640, 45 * (#arg_184_1.couponList + 1) + (#arg_184_1.couponList + 1 - 2) * 12))
	var_184_11:setPositionY(var_184_11:getPositionY() - var_184_13:getContentSize().height + 18)
	var_184_13:setAnchorPoint(cc.p(0.5, 0))
	var_184_13:setPosition(cc.p(282, var_184_11:getPositionY() + 30))
	var_184_3:addChild(var_184_13, 1)
	var_184_9:setPositionY(var_184_9:getPositionY() - var_184_13:getContentSize().height + 18)
	var_184_10:setPositionY(var_184_9:getPositionY())

	self.selectBtnList = {}

	local var_184_14

	for iter_184_0, iter_184_1 in pairs(arg_184_1.couponList) do
		local var_184_15 = ccui.ImageView:create("public/panelbg/coupon_sprite_bg.png", var_0_20)

		var_184_15:setPosition(cc.p(var_184_13:getContentSize().width / 2, var_184_13:getContentSize().height - 45 - (var_184_15:getContentSize().height + 12) * (iter_184_0 - 1)))
		var_184_13:addChild(var_184_15)

		local var_184_16 = ccui.ImageView:create("equipment/" .. iter_184_1.id .. ".png")

		var_184_16:setPosition(cc.p(40, 23))
		var_184_16:setScale(0.3)
		var_184_15:addChild(var_184_16)

		local var_184_17 = cc.Label:createWithTTF(iter_184_1.name .. " X" .. item_manager:getItemNumber(iter_184_1.id), FONT_NAME, 20)

		var_184_17:setColor(cc.c3b(188, 206, 226))
		var_184_17:setAnchorPoint(cc.p(0, 0.5))
		var_184_17:setPosition(cc.p(80, 23))
		var_184_15:addChild(var_184_17)

		local var_184_18 = ccui.ImageView:create(arg_184_1.slidecost.costtype, var_0_20)

		var_184_18:setPosition(cc.p(355, 23))
		var_184_15:addChild(var_184_18)

		local var_184_19 = "-" .. iter_184_1.discount1

		if iter_184_1.discount1 == -1 then
			var_184_19 = L_FREE_BUY

			var_184_18:setVisible(false)
		end

		local var_184_20 = cc.Label:createWithTTF(var_184_19, FONT_NAME, 24)

		var_184_20:setColor(cc.c3b(188, 206, 226))
		var_184_20:setPosition(cc.p(400, 23))
		var_184_15:addChild(var_184_20)

		local var_184_21 = ccui.Button:create("public/button/coupon_unselect.png", "public/button/coupon_unselect.png", "public/button/coupon_unselect.png", var_0_20)

		self.selectBtnList[iter_184_0] = var_184_21

		var_184_21:setPosition(cc.p(444, 22))
		var_184_15:addChild(var_184_21)
		var_184_21:addTouchEventListener(function(arg_188_0, arg_188_1)
			if arg_188_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:updateSelectBtn(iter_184_0)

			var_184_14 = iter_184_1.id

			var_184_10:setString((iter_184_1.discount1 == -1 or nil) and "0")
		end)
	end

	if arg_184_1.couponList[1] then
		self:updateSelectBtn(1)

		var_184_14 = arg_184_1.couponList[1].id

		var_184_10:setString((arg_184_1.couponList[1].discount1 == -1 or nil) and "0")
	end

	var_184_11:addTouchEventListener(function(arg_189_0, arg_189_1)
		if arg_189_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_184_1.ShopSliderCallback then
			arg_184_1.ShopSliderCallback(arg_189_0, arg_189_1, function()
				var_184_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_184_0:runAction(cc.RemoveSelf:create())
				end)))
				var_184_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_184_0:runAction(cc.RemoveSelf:create())
				end)))
			end, var_184_14)
		end
	end)
end

function SupermarketMarketSprite:updateSelectBtn(arg_193_1)
	for iter_193_0, iter_193_1 in pairs(self.selectBtnList) do
		if iter_193_0 == arg_193_1 then
			iter_193_1:loadTextures("public/button/coupon_select.png", "public/button/coupon_select.png", "public/button/coupon_select.png", var_0_20)
		else
			iter_193_1:loadTextures("public/button/coupon_unselect.png", "public/button/coupon_unselect.png", "public/button/coupon_unselect.png", var_0_20)
		end
	end
end

function SupermarketMarketSprite:buyBachelorGift(arg_194_1)
	local var_194_0 = ccui.Layout:create()

	var_194_0:setTouchEnabled(true)
	var_194_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_194_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_194_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_194_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_194_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_194_0:setBackGroundColorOpacity(180)
	self:addChild(var_194_0, 10)

	local var_194_1 = ccui.ImageView:create(var_0_36[var_0_30[self.selectedType]] .. arg_194_1.itemid .. var_0_37[var_0_30[self.selectedType]])

	var_194_1:setPosition(cc.p(var_194_0:getContentSize().width / 2, var_194_0:getContentSize().height / 2 + 100))
	var_194_0:addChild(var_194_1)

	local var_194_2 = ccui.ImageView:create(arg_194_1.slidecost.costtype, var_0_20)

	var_194_2:setPositionX(var_194_1:getContentSize().width / 2 - 20)
	var_194_2:setPositionY(-130)
	var_194_1:addChild(var_194_2)

	local var_194_3 = cc.Label:createWithTTF(arg_194_1.slidecost.costnum, FONT_DES, 23)

	var_194_3:setAnchorPoint(cc.p(0, 0.5))
	var_194_3:setPositionX(var_194_2:getPositionX() + var_194_2:getContentSize().width / 2 + 5)
	var_194_3:setPositionY(var_194_2:getPositionY())
	var_194_1:addChild(var_194_3)

	local var_194_4 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_20)
	local var_194_5 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)

	var_194_5:setColor(cc.c3b(12, 12, 12))
	var_194_4:setPosition(cc.p(var_194_1:getContentSize().width / 2, -70))
	var_194_5:setPosition(cc.p(var_194_4:getContentSize().width / 2, var_194_4:getContentSize().height / 2 - 5))
	var_194_4:addChild(var_194_5)
	var_194_1:addChild(var_194_4)
	var_194_1:setScaleY(0)
	var_194_1:runAction(cc.ScaleTo:create(0.2, 1))
	var_194_0:addTouchEventListener(function(arg_195_0, arg_195_1)
		var_194_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_194_0:runAction(cc.RemoveSelf:create())
		end)))
	end)

	local var_194_6 = ccui.ImageView:create("public/panelbg/coupon_select_bg.png", var_0_20)

	var_194_6:setScaleY(#arg_194_1.couponList + 1)
	var_194_4:setPositionY(var_194_4:getPositionY() - var_194_6:getContentSize().height * (#arg_194_1.couponList + 1) + 20)
	var_194_6:setAnchorPoint(cc.p(0.5, 0))
	var_194_6:setPosition(cc.p(282, var_194_4:getPositionY() + 40))
	var_194_1:addChild(var_194_6, 1)
	var_194_2:setPositionY(var_194_2:getPositionY() - var_194_6:getContentSize().height * (#arg_194_1.couponList + 1) + 18)
	var_194_3:setPositionY(var_194_2:getPositionY())

	self.selectBtnList = {}

	local var_194_7

	for iter_194_0, iter_194_1 in pairs(arg_194_1.couponList) do
		local var_194_8 = ccui.ImageView:create("public/panelbg/coupon_sprite_bg.png", var_0_20)

		var_194_8:setScaleY(1 / (#arg_194_1.couponList + 1))
		var_194_8:setPosition(cc.p(250, var_194_6:getContentSize().height - 13.5 - 18 * (iter_194_0 - 1)))
		var_194_6:addChild(var_194_8)

		local var_194_9 = ccui.ImageView:create("equipment/" .. iter_194_1.id .. ".png")

		var_194_9:setScale(0.3)
		var_194_9:setPosition(cc.p(40, 23))
		var_194_8:addChild(var_194_9)

		local var_194_10 = cc.Label:createWithTTF(iter_194_1.name .. " X" .. item_manager:getItemNumber(iter_194_1.id), FONT_NAME, 20)

		var_194_10:setColor(cc.c3b(188, 206, 226))
		var_194_10:setAnchorPoint(cc.p(0, 0.5))
		var_194_10:setPosition(cc.p(80, 23))
		var_194_8:addChild(var_194_10)

		local var_194_11 = ccui.ImageView:create(arg_194_1.slidecost.costtype, var_0_20)

		var_194_11:setPosition(cc.p(355, 23))
		var_194_8:addChild(var_194_11)

		local var_194_12 = "-" .. iter_194_1.discount1

		if iter_194_1.discount1 == -1 then
			var_194_12 = L_FREE_BUY

			var_194_11:setVisible(false)

			iter_194_1.discount1 = arg_194_1.slidecost.costnum
		end

		local var_194_13 = cc.Label:createWithTTF(var_194_12, FONT_NAME, 24)

		var_194_13:setColor(cc.c3b(188, 206, 226))
		var_194_13:setPosition(cc.p(400, 23))
		var_194_8:addChild(var_194_13)

		local var_194_14 = ccui.Button:create("public/button/coupon_unselect.png", "public/button/coupon_unselect.png", "public/button/coupon_unselect.png", var_0_20)

		self.selectBtnList[iter_194_0] = var_194_14

		var_194_14:setPosition(cc.p(444, 22))
		var_194_8:addChild(var_194_14)
		var_194_14:addTouchEventListener(function(arg_197_0, arg_197_1)
			if arg_197_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:updateSelectBtn(iter_194_0)

			var_194_7 = iter_194_1.id

			var_194_3:setString(arg_194_1.slidecost.costnum - iter_194_1.discount1)
		end)
	end

	if arg_194_1.couponList[1] then
		self:updateSelectBtn(1)

		var_194_7 = arg_194_1.couponList[1].id

		var_194_3:setString(arg_194_1.slidecost.costnum - arg_194_1.couponList[1].discount1)
	end

	var_194_4:addTouchEventListener(function(arg_198_0, arg_198_1)
		if arg_198_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_194_1.ShopSliderCallback then
			arg_194_1.ShopSliderCallback(arg_198_0, arg_198_1, function()
				var_194_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_194_0:runAction(cc.RemoveSelf:create())
				end)))
			end, var_194_7)
		end
	end)
end

function SupermarketMarketSprite:initCouponsBtn()
	self.btnCoupons = ccui.Button:create("SupermarketMarketSprite/btn_coupons.png", "SupermarketMarketSprite/btn_coupons.png", "SupermarketMarketSprite/btn_coupons.png", var_0_20)

	self.btnCoupons:setPosition(cc.p(560, ccui.Helper:seekWidgetByName(self.rootlayer, "button_back"):getPositionY() + 68 - GameDisplay.fix_y))
	self.rootlayer:addChild(self.btnCoupons, 9999)
	self:updatebtnCoupons()
end

function SupermarketMarketSprite:updatebtnCoupons()
	if self.btnCoupons then
		self.btnCoupons:setVisible(self.selectedType == "1-15301")
	end
end

function SupermarketMarketSprite.registerCommityEventListener(arg_203_0)
	activity_manager:registerEventListener("CommunityMainLayer", activity_manager.activityEventId.COMMUNITY_KICK_NOTICE, function(arg_204_0)
		if arg_204_0.familyid and arg_204_0.familyid == community_system_manager:getCurfamilyid() and arg_203_0.selectedType and arg_203_0.selectedType == "1-123000" then
			global_ShowBlockWords(COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips7)
			LayerManager:switchShowLayer("MainLayer")
		end
	end)
end

function SupermarketMarketSprite:updateBySupermarketLayer(arg_205_1)
	self.rpcCallbackFalg = false
	self.selectedType = arg_205_1

	print("self.selectedType", self.selectedType)
	self:updateButtonList()
	self:refreshTime()
	self:refreshTableData()
	self:updateCurActiveTime()
	self:checkpushBrowseTime()
	self:updateBlackCardDes()
	self:updatebtnCoupons()
end
