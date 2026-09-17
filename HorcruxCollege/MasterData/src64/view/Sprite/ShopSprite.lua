local var_0_0 = {}
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local playermodel = require("model.playermodel")
local furniture_data = require("data.furniture_data")
local shop_manager = require("controller.shop_manager")
local item_manager = require("controller.item_manager")
local component_manager = require("controller.component_manager")
local time_check_manager = require("controller.time_check_manager")
local drop_manager = require("controller.drop_manager")
local servant_data = require("data.servant_data")
local activity_plague_city_data = require("data.activity_plague_city_data")
local level_manager = require("controller.level_manager")
local shop_data = require("data.shop_data")
local major_factor_data = require("data.major_factor_data")
local furnituresuit_data = require("data.furnituresuit_data")
local Utility = require("common.Utility")
local var_0_17 = "default/default.png"
local var_0_18 = config._DEBUG and 0 or 1
local var_0_20 = L_NUMBER_TEXT
local var_0_22 = {
	"MarketLayer/market_tag_type1.png",
	"MarketLayer/market_tag_type2.png",
	"MarketLayer/market_tag_type3.png",
	"MarketLayer/market_tag_type4.png",
	"MarketLayer/discount_new_2.png",
	"MarketLayer/limit_forerver.png",
	"MarketLayer/market_tag_type5.png"
}

local function var_0_23(arg_1_0)
	if not arg_1_0.currency2 or item_manager:getItemNumber(arg_1_0.currency2) < arg_1_0.discount2 then
		return true
	end

	return false
end

local function var_0_24(arg_2_0, arg_2_1)
	local var_2_0 = {
		["2-1"] = function()
			if var_0_23(arg_2_1) then
				arg_2_0:getChildByName("Image_discountIcon"):setVisible(arg_2_1.discount and arg_2_1.discount ~= 10)
			end
		end,
		["2-2"] = function()
			if var_0_23(arg_2_1) then
				arg_2_0:getChildByName("Image_discountIcon"):setVisible(arg_2_1.discount and arg_2_1.discount ~= 10)
			end
		end,
		["2-4"] = function()
			if var_0_23(arg_2_1) then
				arg_2_0:getChildByName("Image_discountIcon"):setVisible(arg_2_1.discount and arg_2_1.discount ~= 10)
			end
		end,
		["2-6"] = function()
			if var_0_23(arg_2_1) then
				arg_2_0:getChildByName("Image_discountIcon"):setVisible(arg_2_1.discount and arg_2_1.discount ~= 10)
			end
		end
	}

	setmetatable(var_2_0, {
		__index = function(arg_7_0, arg_7_1)
			return function()
				if var_0_23(arg_2_1) then
					arg_2_0:getChildByName("Image_discountIcon"):setVisible(arg_2_1.discount and arg_2_1.discount < arg_2_1.cost_old)
				else
					arg_2_0:getChildByName("Image_discountIcon"):setVisible((arg_2_1.discount2 or nil) and arg_2_1.discount2 < arg_2_1.cost_old2)
				end
			end
		end
	})

	if arg_2_0.setSwallowTouches then
		arg_2_0:setSwallowTouches(false)
	end

	if arg_2_0:getChildByName("cut") then
		arg_2_0:getChildByName("cut"):getChildByName("icon"):setSwallowTouches(false)
	end

	arg_2_0:getChildByName("name"):setString(arg_2_1.name)
	arg_2_0:getChildByName("sold_out_word"):setVisible(arg_2_1.sell_out)
	arg_2_0:getChildByName("Panel_cost"):getChildByName("cost_label"):setString(math.floor(arg_2_1.cost))
	arg_2_0:getChildByName("cost_old"):getChildByName("Label_cost_old"):setString(arg_2_1.cost_old)

	if arg_2_1.cost2 then
		if arg_2_0:getChildByName("Panel_cost2") then
			local var_2_1 = arg_2_0:getChildByName("Panel_cost2")

			var_2_1:setVisible(true)

			local var_2_2 = var_2_1:getChildByName("coin_icon")

			var_2_1:getChildByName("cost_label"):setString(math.floor(arg_2_1.cost2))

			if arg_2_1.costIcon:find("equipment") then
				var_2_2:loadTexture(arg_2_1.costIcon2)
			else
				var_2_2:loadTexture(arg_2_1.costIcon2, var_0_18)
			end
		end
	else
		if arg_2_0:getChildByName("Panel_cost2") then
			arg_2_0:getChildByName("Panel_cost2"):setVisible(false)
		end

		if arg_2_0:getChildByName("Image_40") then
			arg_2_0:getChildByName("Image_40"):setVisible(false)
		end
	end

	if arg_2_0:getChildByName("Panel_cost2") then
		arg_2_0:getChildByName("Panel_cost2"):setVisible(not arg_2_1.sell_out)
	end

	if arg_2_0:getChildByName("Image_40") then
		arg_2_0:getChildByName("Image_40"):setVisible(not arg_2_1.sell_out)
	end

	ccui.Helper:seekWidgetByName(arg_2_0, "limit_number"):setString(arg_2_1.have_bought .. "/" .. (arg_2_1.buy_limit or 0))
	var_2_0[arg_2_0.type]()
	arg_2_0:getChildByName("Panel_limit"):setVisible(arg_2_1.buy_limit and arg_2_1.buy_limit ~= 1000000)
	arg_2_0:getChildByName("Image_redDot"):setVisible(arg_2_1.isnewitem)

	if arg_2_0:getChildByName("Panel_notUse") then
		arg_2_0:getChildByName("Panel_notUse"):setVisible(false)
	end

	if arg_2_1.costIcon:find("equipment") then
		arg_2_0:getChildByName("Panel_cost"):getChildByName("coin_icon"):loadTexture(arg_2_1.costIcon)
		arg_2_0:getChildByName("Panel_cost"):getChildByName("coin_icon"):setScale(0.32)
	else
		arg_2_0:getChildByName("Panel_cost"):getChildByName("coin_icon"):loadTexture(arg_2_1.costIcon, var_0_18)
	end

	arg_2_0:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_9_0:getTouchBeganPosition().y - arg_9_0:getTouchEndPosition().y) > 50 then
			return
		end

		if arg_2_0.is_lock_activitycity then
			if arg_2_1.lock_activitycity then
				local var_9_0 = {}

				for iter_9_0 in arg_2_1.lock_activitycity:gmatch("([^-]+)") do
					var_9_0[#var_9_0 + 1] = tonumber(iter_9_0)
				end

				global_ShowBlockWords(L_CLEAR_CHAPTER .. "【" .. L_MODE_DIFFICULTY_LAMIA[level_manager:getDifficultByMode(var_9_0[1])] .. level_manager:getChapterName(var_9_0[1], var_9_0[2]) .. "】" .. L_CAN_BUY)
			end
		elseif arg_2_0.family_shop_limit and arg_2_0.family_shop_limit > 0 then
			global_ShowBlockWords(string.format(COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips19, arg_2_0.family_shop_limit))
		else
			arg_2_1.touchCallBack(arg_9_0, arg_9_1)
		end
	end)

	arg_2_0.is_lock_activitycity = arg_2_1.is_lock_activitycity
	arg_2_0.lock_activitycity = arg_2_1.lock_activitycity
	arg_2_0.family_shop_limit = arg_2_1.family_shop_limit

	;(function()
		if arg_2_0:getChildByName("lock_city_des_panel") then
			arg_2_0:getChildByName("lock_city_des_panel"):setVisible(false)
		end

		if arg_2_1.is_lock_activitycity or arg_2_1.family_shop_limit then
			if not arg_2_0:getChildByName("lock_city_des_panel") then
				local var_10_0 = (function(arg_11_0, arg_11_1)
					local var_11_0 = ccui.Layout:create()

					var_11_0:setContentSize(arg_11_0)
					var_11_0:setAnchorPoint(cc.p(0.5, 0.5))
					var_11_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
					var_11_0:setBackGroundColor(cc.c3b(0, 0, 0))
					var_11_0:setBackGroundColorOpacity(180)

					local var_11_1 = cc.Label:createWithTTF(L_CLEAR_CHAPTER, FONT_DES, 26)

					var_11_1:setAnchorPoint(cc.p(0.5, 0.5))
					var_11_1:setPositionX(var_11_0:getContentSize().width / 2)
					var_11_1:setPositionY(var_11_0:getContentSize().height / 2 + 25)
					var_11_1:setName("desLabel1")
					var_11_0:addChild(var_11_1)

					local var_11_2 = cc.Label:createWithTTF("waring", FONT_DES, 26)

					var_11_2:setColor(cc.c3b(242, 12, 12))
					var_11_2:setAnchorPoint(cc.p(0.5, 0.5))
					var_11_2:setPositionX(var_11_0:getContentSize().width / 2)
					var_11_2:setPositionY(var_11_0:getContentSize().height / 2)
					var_11_2:setName("desLabel2")
					var_11_0:addChild(var_11_2)

					local var_11_3 = cc.Label:createWithTTF(L_CAN_BUY, FONT_DES, 26)

					var_11_3:setAnchorPoint(cc.p(0.5, 0.5))
					var_11_3:setPositionX(var_11_0:getContentSize().width / 2)
					var_11_3:setPositionY(var_11_0:getContentSize().height / 2 - 25)
					var_11_3:setName("desLabel3")
					var_11_0:addChild(var_11_3)

					return var_11_0
				end)(arg_2_0:getContentSize(), arg_2_1.lock_activitycity)

				var_10_0:setName("lock_city_des_panel")
				var_10_0:setPositionX(arg_2_0:getContentSize().width / 2)
				var_10_0:setPositionY(arg_2_0:getContentSize().height / 2)
				arg_2_0:addChild(var_10_0, 10000)
			end

			arg_2_0:getChildByName("lock_city_des_panel"):setVisible(true)

			if arg_2_1.lock_activitycity and arg_2_1.is_lock_activitycity then
				local var_10_1 = {}

				for iter_10_0 in arg_2_1.lock_activitycity:gmatch("([^-]+)") do
					var_10_1[#var_10_1 + 1] = tonumber(iter_10_0)
				end

				local var_10_2 = level_manager:getChapterName(var_10_1[1], var_10_1[2])
				local var_10_3 = "【" .. L_MODE_DIFFICULTY_LAMIA[level_manager:getDifficultByMode(var_10_1[1])] .. var_10_2 .. "】"

				arg_2_0:getChildByName("lock_city_des_panel"):getChildByName("desLabel2"):setString(var_10_2 and var_10_2 or "error")
			elseif arg_2_1.family_shop_limit and arg_2_1.family_shop_limit > 0 then
				local var_10_4 = arg_2_0:getChildByName("lock_city_des_panel"):getChildByName("desLabel2"):getTTFConfig()

				var_10_4.fontSize = 22

				arg_2_0:getChildByName("lock_city_des_panel"):getChildByName("desLabel2"):setTTFConfig(var_10_4)
				arg_2_0:getChildByName("lock_city_des_panel"):getChildByName("desLabel2"):setMaxLineWidth(180)
				arg_2_0:getChildByName("lock_city_des_panel"):getChildByName("desLabel2"):setString((string.format(COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips19, arg_2_1.family_shop_limit)))
				arg_2_0:getChildByName("lock_city_des_panel"):getChildByName("desLabel2"):setColor(cc.c3b(255, 255, 255))
				arg_2_0:getChildByName("lock_city_des_panel"):getChildByName("desLabel1"):setString("")
				arg_2_0:getChildByName("lock_city_des_panel"):getChildByName("desLabel3"):setString("")
			end
		end
	end)()
end

local function var_0_25(arg_12_0, arg_12_1)
	if not arg_12_0 then
		return "-1"
	end

	arg_12_1 = arg_12_1 or "剩"

	local var_12_5 = global_get_time_by_date(arg_12_0) - time_check_manager:getCurTime()

	if var_12_5 < 0 then
		return "-1"
	end

	local var_12_6 = math.floor(var_12_5 / 24 / 3600)
	local var_12_7 = math.floor((var_12_5 - var_12_6 * 24 * 3600) / 3600)
	local var_12_8 = math.floor((var_12_5 - var_12_6 * 24 * 3600 - var_12_7 * 3600) / 60)

	return arg_12_1 .. (var_12_6 ~= 0 and string.format(L_TIME_TEXT[1], var_12_6, var_12_7) or var_12_7 ~= 0 and string.format(L_TIME_TEXT[2], var_12_7, var_12_8) or string.format(L_TIME_TEXT[3], var_12_8))
end

local function var_0_26(arg_13_0, arg_13_1)
	local var_13_1 = item_data[arg_13_1.itemid].bag_item_type

	if arg_13_1.icon:find("equipment") or arg_13_1.icon:find("role") or arg_13_1.icon:find("mainScenebg") then
		arg_13_0:getChildByName("cut"):getChildByName("icon"):loadTextures(arg_13_1.icon, arg_13_1.icon, arg_13_1.icon)
	else
		arg_13_0:getChildByName("cut"):getChildByName("icon"):loadTextures(arg_13_1.icon, arg_13_1.icon, arg_13_1.icon, var_0_18)
	end

	arg_13_0:getChildByName("cut"):getChildByName("icon"):setScale((global_get_item_scale(arg_13_0:getChildByName("cut"):getChildByName("icon"), var_13_1)))

	arg_13_0:getChildByName("cut"):getChildByName("icon").afterLoadSuccess = function(self, ...)
		self:setScale(global_get_item_scale(self, var_13_1))
	end
end

local function var_0_27(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getChildByName("listViewStars")

	if not var_15_0 and arg_15_1 and arg_15_1.extraType == "star" then
		var_15_0 = ccui.ListView:create()

		var_15_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
		var_15_0:setName("listViewStars")
		var_15_0:setItemsMargin(-5)
		arg_15_0:addChild(var_15_0)
	end

	if var_15_0 then
		local var_15_1

		if arg_15_1 then
			::label_15_0::

			var_15_1 = arg_15_1.extraType and arg_15_1.extraType == "star"
		end

		var_15_0:setVisible(var_15_1)
		var_15_0:removeAllChildren()

		if arg_15_1.extraValue and arg_15_1.extraValue > 0 then
			local var_15_2 = 0
			local var_15_3 = 0

			for iter_15_0 = 1, arg_15_1.extraValue do
				local var_15_4 = ccui.ImageView:create("public/currency/weapon_star.png", var_0_18)

				var_15_0:pushBackCustomItem(var_15_4)

				var_15_2 = var_15_4:getContentSize().width
				var_15_3 = var_15_4:getContentSize().height + var_15_3
			end

			var_15_0:setAnchorPoint(0, 1)
			var_15_0:setContentSize(cc.size(var_15_2, var_15_3))
			var_15_0:setPosition(0, arg_15_0:getContentSize().height)
			var_15_0:doLayout()
		end
	end
end

local var_0_28

shopSpriteType1 = class("shopSpriteType1", function()
	if not var_0_28 then
		var_0_28 = ccui.Helper:seekWidgetByName(ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "MarketSpriteType1.json" or "MarketSpriteType1.ExportJson"), "item")

		var_0_28:retain()
	end

	return var_0_28:clone()
end)

function shopSpriteType1:update(arg_17_1)
	var_0_24(self, arg_17_1)
	updateCurPanelHaveServant(self, arg_17_1, cc.p(150, 83))

	if not var_0_23(arg_17_1) then
		self:getChildByName("Panel_cost"):setPositionX(110)
	else
		self:getChildByName("Panel_cost"):setPositionX(87)
	end

	if utfstrlen(self:getChildByName("name"):getString()) >= 8 then
		self:getChildByName("name"):setScale(0.9)
	end

	self:getChildByName("cut"):getChildByName("icon"):setVisible(true)

	if self:getChildByName("cut"):getChildByName("starsPanel") then
		self:getChildByName("cut"):removeChildByName("starsPanel")
	end

	if self:getChildByName("cut"):getChildByName("componentSp") then
		self:getChildByName("cut"):removeChildByName("componentSp")
	end

	if arg_17_1.bag_item_type == kITEM_WEAPON and arg_17_1.item_attr then
		local var_17_0 = weaponManager:decode_weapon_config(arg_17_1.item_attr)

		self:getChildByName("cut"):getChildByName("icon"):loadTextures("equipment/" .. item_data[arg_17_1.itemid].image_id .. ".png", "equipment/" .. item_data[arg_17_1.itemid].image_id .. ".png", "equipment/" .. item_data[arg_17_1.itemid].image_id .. ".png")

		local var_17_2 = var_17_0.nowStars
		local var_17_3 = ccui.Layout:create()

		var_17_3:setName("starsPanel")
		var_17_3:setVisible(true)
		self:getChildByName("cut"):addChild(var_17_3)

		for iter_17_0 = 1, var_17_2 do
			local var_17_6

			if config._DEBUG then
				var_17_6 = cc.Sprite:create(var_17_4) or cc.Sprite:createWithSpriteFrameName(var_17_4)
			end

			var_17_6:setName("star" .. iter_17_0)
			var_17_6:setPosition(14, (iter_17_0 - 1) * 24 + 20)
			var_17_6:setName("star")
			var_17_6:setVisible(iter_17_0 <= var_17_2)
			var_17_3:addChild(var_17_6)
		end
	elseif arg_17_1.bag_item_type == kITEM_COMPONENT and arg_17_1.item_attr then
		self:getChildByName("cut"):getChildByName("icon"):setVisible(false)

		local var_17_7 = component_manager:create_component_icon(arg_17_1.itemid, 0, arg_17_1.item_attr)

		var_17_7:setScale(1)
		var_17_7:setName("componentSp")
		self:getChildByName("cut"):addChild(var_17_7)
		var_17_7:setPosition(cc.p(90, 83))
		var_17_7:setAnchorPoint(cc.p(0.5, 0.5))
		self:getChildByName("cut"):getChildByName("icon"):setVisible(false)
	else
		var_0_26(self, arg_17_1)
	end

	if arg_17_1.cost2 then
		local var_17_8 = self:getChildByName("Panel_cost")
		local var_17_9 = self:getChildByName("Panel_cost2")

		var_17_8:setScale(0.9)
		var_17_9:setScale(0.9)
		var_17_9:getChildByName("Image_40"):setVisible(false)
		var_17_9:setVisible(true)

		if self:getChildByName("Image_40") then
			self:getChildByName("Image_40"):setVisible(true)
		else
			local var_17_10 = var_17_9:getChildByName("Image_40"):clone()

			var_17_10:setVisible(true)
			var_17_10:setPosition(cc.p(self:getContentSize().width / 2, -15))
			var_17_10:setScale(0.9)
			var_17_10:setName("Image_40")
			self:addChild(var_17_10, 10)
		end

		local var_17_11 = var_17_8:getChildByName("coin_icon")
		local var_17_12 = var_17_8:getChildByName("cost_label")

		var_17_11:setAnchorPoint(cc.p(0, 0.5))
		var_17_12:setAnchorPoint(cc.p(0, 0.5))

		local var_17_13 = var_17_11:getContentSize().width

		var_17_11:setPosition(cc.p(0, 0))
		var_17_12:setPosition(cc.p(var_17_13 - 15, 0))
		var_17_8:setContentSize(cc.size(var_17_13 + var_17_12:getContentSize().width, var_17_11:getContentSize().height))
		var_17_8:setAnchorPoint(cc.p(1, 0.5))
		var_17_8:setPosition(cc.p(87, 7))

		local var_17_14 = var_17_9:getChildByName("coin_icon")
		local var_17_15 = var_17_9:getChildByName("cost_label")

		var_17_14:setAnchorPoint(cc.p(0, 0.5))
		var_17_15:setAnchorPoint(cc.p(0, 0.5))

		local var_17_16 = var_17_14:getContentSize().width

		var_17_14:setPosition(cc.p(0, 0))
		var_17_15:setPosition(cc.p(var_17_16 - 15, 0))
		var_17_9:setContentSize(cc.size(var_17_16 + var_17_15:getContentSize().width, var_17_14:getContentSize().height))
		var_17_9:setAnchorPoint(cc.p(0, 0.5))
		var_17_9:setPosition(cc.p(97, 7))
	else
		local var_17_17 = self:getChildByName("Panel_cost")
		local var_17_18 = var_17_17:getChildByName("coin_icon")
		local var_17_19 = var_17_17:getChildByName("cost_label")

		self:getChildByName("Panel_cost2"):setVisible(false)
		var_17_17:setPositionX(95)
		var_17_17:setScale(1)
		var_17_17:setPosition(cc.p(87, -15))
		var_17_17:setAnchorPoint(cc.p(0, 0))
		var_17_17:setContentSize(cc.size(50, 50))
		var_17_18:setPosition(cc.p(-36, 0))
		var_17_18:setAnchorPoint(cc.p(0.5, 0.5))
		var_17_19:setPosition(cc.p(-22, 0))
		var_17_19:setAnchorPoint(cc.p(0, 0.5))

		if self:getChildByName("Image_40") then
			self:getChildByName("Image_40"):setVisible(false)
		end
	end

	self:loadTextures("public/box/new_item_bg" .. arg_17_1.quality .. ".png", "public/box/new_item_bg" .. arg_17_1.quality .. ".png", "", var_0_18)
	self:getChildByName("cost_old"):setVisible(false)
	self:getChildByName("cut"):getChildByName("Image_drawImg"):loadTexture("equipment/draw.png")
	self:getChildByName("cut"):getChildByName("Image_drawImg"):setVisible(arg_17_1.bag_item_type == kITEM_DRAWING)
	self:getChildByName("star_list"):removeAllItems()

	for iter_17_1 = 1, 5 do
		-- block empty
	end

	if var_0_22[arg_17_1.tag] then
		self:getChildByName("Image_discountIcon"):setVisible(false)
		self:getChildByName("discount"):setVisible(true)
		self:getChildByName("discount"):getChildByName("discount_label"):setVisible(false)
		self:getChildByName("discount"):loadTexture(var_0_22[arg_17_1.tag], var_0_18)
		self:getChildByName("discount"):setPosition(cc.p(155, 192))
	else
		self:getChildByName("discount"):getChildByName("discount_label"):setString((var_0_20[arg_17_1.discount] or "") .. L_DISCOUNT)
		self:getChildByName("discount"):setVisible(arg_17_1.discount < 10)
		self:getChildByName("discount"):setVisible(false)
		self:getChildByName("discount"):setPosition(cc.p(155, 187))
	end

	if shop_manager:is_collection(self.type) then
		self:getChildByName("discount"):setVisible(false)
		ccui.Helper:seekWidgetByName(self, "limit"):setString(L_RECYCLE)
		self:getChildByName("Image_have"):setVisible(item_manager:getItemNumber(arg_17_1.itemid) > 0 and not arg_17_1.sell_out)
		self:getChildByName("Image_discountIcon"):setVisible(false)
	else
		self:getChildByName("Image_have"):setVisible(false)
		ccui.Helper:seekWidgetByName(self, "limit"):setString(L_LIMIT)
	end

	if item_data[arg_17_1.itemid].bag_item_type == kITEM_HERO then
		self:getChildByName("Image_rarity"):setVisible(true)
		self:getChildByName("Image_rarity"):loadTexture(SHOT_RARITY_CION[servant_data[item_data[arg_17_1.itemid].servant].roll_rarity], var_0_18)
	else
		self:getChildByName("Image_rarity"):setVisible(false)
	end

	self:getChildByName("discount"):setPosition(cc.p(140, 192))
	self:getChildByName("Image_discountIcon"):loadTexture(var_0_22[5], var_0_18)
	self:getChildByName("Image_discountIcon"):setPosition(cc.p(140, 192))
	self:getChildByName("Image_discountIcon"):setAnchorPoint(cc.p(self:getChildByName("discount"):getAnchorPoint()))

	if not self:getChildByName("itemtype_tag") then
		local var_17_21 = ccui.ImageView:create("public/box/barrage_icon.png", var_0_18)

		var_17_21:setPosition(cc.p(36, 214))
		var_17_21:setName("itemtype_tag")
		self:addChild(var_17_21, 100)
	end

	local var_17_22 = {
		[kITEM_SKIN] = "public/box/skin_icon.png",
		[kITEM_SCULTURE] = "public/box/head_icon.png",
		[KITEM_BARRAGE_GIFT] = "public/box/barrage_icon.png",
		[kITEM_GIFT_FOR_FRIEND] = "public/box/gift_icon.png"
	}

	self:getChildByName("itemtype_tag"):setVisible(false)

	if var_17_22[arg_17_1.bag_item_type] then
		self:getChildByName("itemtype_tag"):loadTexture(var_17_22[arg_17_1.bag_item_type], var_0_18)
		self:getChildByName("itemtype_tag"):setVisible(true)
	end

	local var_17_23 = self:getChildByName("activity_level_clip")

	if not var_17_23 then
		var_17_23 = ccui.ImageView:create("mainScenebg/activity/branch173/activity_level_clip.png")

		var_17_23:setName("activity_level_clip")
		var_17_23:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2)
		self:addChild(var_17_23, 99)

		lbl = cc.Label:createWithTTF("", FONT_NAME, 24)

		lbl:setColor(cc.c3b(255, 186, 96))
		lbl:setName("activity_level_lbl")
		lbl:setPosition(var_17_23:getContentSize().width / 2 + 45, var_17_23:getContentSize().height / 2 - 8)
		var_17_23:addChild(lbl, 99)
	end

	var_17_23:setVisible(arg_17_1.activity_level ~= nil)
	var_17_23:getChildByName("activity_level_lbl"):setString(arg_17_1.activity_level or "")
	var_0_27(self, arg_17_1)
end

local var_0_29

shopSpriteType2 = class("shopSpriteType2", function()
	if not var_0_29 then
		var_0_29 = ccui.Helper:seekWidgetByName(ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "MarketSpriteType2.json" or "MarketSpriteType2.ExportJson"), "clothItem")

		var_0_29:loadTextures(var_0_17, var_0_17, var_0_17)
		var_0_29:retain()
	end

	return var_0_29:clone()
end)

function shopSpriteType2:update(arg_19_1)
	local var_19_0 = {}

	setmetatable(var_19_0, {
		__index = function(arg_20_0, arg_20_1)
			return function()
				ccui.Helper:seekWidgetByName(self, "icon"):setPositionY(126)

				local var_21_0 = string_split(arg_19_1.name, "】")

				if #var_21_0 == 1 then
					self:getChildByName("name"):setString(var_21_0[1])

					if self:getChildByName("name_top") then
						self:getChildByName("name_top"):setString(var_21_0[1])
					end
				else
					self:getChildByName("name"):setString(var_21_0[2])

					if self:getChildByName("name_top") then
						self:getChildByName("name_top"):setString(var_21_0[2])
					end
				end
			end
		end
	})
	var_0_24(self, arg_19_1)
	var_0_26(self, arg_19_1)
	;(function()
		local var_22_0

		if item_data[arg_19_1.itemid].model then
			if model_data[item_data[arg_19_1.itemid].model].live2d and not model_data[item_data[arg_19_1.itemid].model].origin then
				var_22_0 = "MarketLayer/skin_type_live2d.png"
			elseif model_data[item_data[arg_19_1.itemid].model].rolespine then
				var_22_0 = "MarketLayer/skin_type_spine.png"
			end

			self:getChildByName("Image_skinTypeIcon"):loadTexture(var_22_0, var_0_18)
		end

		self:getChildByName("Image_skinTypeIcon"):setVisible(var_22_0 ~= nil)

		if item_data[arg_19_1.itemid].model then
			self:getChildByName("Image_notHaveMajorIcon"):setVisible(not playermodel.haveSuit[model_data[item_data[arg_19_1.itemid].model].major])
		else
			self:getChildByName("Image_notHaveMajorIcon"):setVisible(false)
		end
	end)()
	;(function()
		(function()
			local var_24_0 = var_0_25(arg_19_1.discountfinish)

			if var_24_0 ~= "-1" then
				self:getChildByName("Panel_surplusTime"):setVisible(true)

				local var_24_1 = self:getChildByName("Panel_surplusTime"):getChildByName("Label_1")
				local var_24_2 = self:getChildByName("Panel_surplusTime"):getChildByName("Label_2")

				var_24_1:setString(L_MARKET_MSG.Discount_Rest .. "：")
				var_24_2:setString(var_24_0)
				var_24_1:setPositionX(var_24_2:getPositionX() - var_24_2:getContentSize().width)

				local var_24_3 = self:getChildByName("Panel_surplusTime")

				self:getChildByName("Panel_surplusTime"):getChildByName("Panel_timeBg").setContentSize(var_24_3, cc.size(var_24_1:getContentSize().width + var_24_2:getContentSize().width + 6, var_24_3:getChildByName("Panel_timeBg"):getContentSize().height))
				self:getChildByName("Image_discountIcon"):loadTexture("MarketLayer/limit_discount_2.png", var_0_18)
			else
				self:getChildByName("Panel_surplusTime"):setVisible(false)
				self:getChildByName("Image_discountIcon"):loadTexture("MarketLayer/discount_new_2.png", var_0_18)
			end
		end)()
		;(function()
			local var_25_0 = var_0_25(arg_19_1.finish_time)

			if var_25_0 ~= "-1" then
				self:getChildByName("Panel_surplusTime"):setVisible(true)

				local var_25_1 = self:getChildByName("Panel_surplusTime"):getChildByName("Label_1")
				local var_25_2 = self:getChildByName("Panel_surplusTime"):getChildByName("Label_2")

				var_25_1:setString(L_MARKET_MSG.Surplus_Rest .. "：")
				var_25_2:setString(var_25_0)
				var_25_1:setPositionX(var_25_2:getPositionX() - var_25_2:getContentSize().width)

				local var_25_3 = self:getChildByName("Panel_surplusTime")

				self:getChildByName("Panel_surplusTime"):getChildByName("Panel_timeBg").setContentSize(var_25_3, cc.size(var_25_1:getContentSize().width + var_25_2:getContentSize().width + 6, var_25_3:getChildByName("Panel_timeBg"):getContentSize().height))
			else
				self:getChildByName("Panel_surplusTime"):setVisible(false)
			end
		end)()

		if discountTime == "-1" and time == "-1" then
			self:getChildByName("Panel_surplusTime"):setVisible(false)
		end
	end)()
	;(function()
		local var_26_0 = self:getContentSize().width / 2 + 175

		self:getChildByName("Panel_cost"):setPositionX(320.5)

		if arg_19_1.sell_out == true then
			self:getChildByName("Panel_cost"):setVisible(false)
			self:getChildByName("Panel_cost2"):setVisible(false)
			self:getChildByName("cost_old"):setVisible(false)
			self:getChildByName("Image_notHaveMajorIcon"):setVisible(false)
			self:getChildByName("name_top"):setAnchorPoint(cc.p(0.5, 0.5))
			self:getChildByName("name"):setAnchorPoint(cc.p(0.5, 0.5))
			self:getChildByName("name_top"):setPositionX(251)
			self:getChildByName("name"):setPositionX(253)
		else
			self:getChildByName("name_top"):setAnchorPoint(cc.p(0, 0.5))
			self:getChildByName("name"):setAnchorPoint(cc.p(0, 0.5))
			self:getChildByName("name_top"):setPositionX(41)
			self:getChildByName("name"):setPositionX(43)

			if var_0_23(arg_19_1) then
				self:getChildByName("Panel_cost2"):setVisible(false)
				self:getChildByName("Panel_cost"):setPositionX(460.5)

				if arg_19_1.cost_old > arg_19_1.discount then
					self:getChildByName("Panel_cost"):setVisible(true)
					self:getChildByName("cost_old"):setVisible(true)
					self:getChildByName("cost_old"):getChildByName("Image_cost_old_icon"):loadTexture(arg_19_1.costIcon, var_0_18)
					self:getChildByName("Panel_cost"):getChildByName("cost_label"):setColor(cc.c3b(255, 255, 255))
				else
					self:getChildByName("Panel_cost"):setVisible(true)
					self:getChildByName("cost_old"):setVisible(false)
					self:getChildByName("Panel_cost"):getChildByName("cost_label"):setColor(cc.c3b(255, 255, 255))
				end
			elseif arg_19_1.cost_old2 > arg_19_1.discount2 then
				self:getChildByName("Panel_cost"):setVisible(true)
				self:getChildByName("cost_old"):setVisible(true)
				self:getChildByName("cost_old"):getChildByName("Image_cost_old_icon"):loadTexture(arg_19_1.costIcon2, var_0_18)
				self:getChildByName("Panel_cost"):getChildByName("cost_label"):setColor(cc.c3b(255, 255, 255))
			elseif arg_19_1.cost_old > arg_19_1.discount then
				self:getChildByName("Panel_cost"):setVisible(true)
				self:getChildByName("cost_old"):setVisible(true)
				self:getChildByName("cost_old"):getChildByName("Image_cost_old_icon"):loadTexture(arg_19_1.costIcon, var_0_18)
				self:getChildByName("Panel_cost"):getChildByName("cost_label"):setColor(cc.c3b(255, 255, 255))
			else
				self:getChildByName("Panel_cost"):setVisible(true)
				self:getChildByName("cost_old"):setVisible(false)
				self:getChildByName("Panel_cost"):getChildByName("cost_label"):setColor(cc.c3b(255, 255, 255))
			end
		end
	end)()
	var_19_0[self.type]()
end

local var_0_30

shopSpriteType3 = class("shopSpriteType3", function()
	if not var_0_30 then
		var_0_30 = ccui.Helper:seekWidgetByName(ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "MarketSpriteType3.json" or "MarketSpriteType3.ExportJson"), "clothItem")

		var_0_30:loadTextures(var_0_17, var_0_17, var_0_17)
		var_0_30:retain()
	end

	return var_0_30:clone()
end)

function shopSpriteType3:update(arg_28_1)
	local var_28_0 = {
		["1-2"] = function()
			ccui.Helper:seekWidgetByName(self, "icon"):setPositionY(298)
			self:getChildByName("name"):setString(item_data[arg_28_1.itemid].name)
			self:getChildByName("name_top"):setString(item_data[arg_28_1.itemid].name)
		end
	}

	setmetatable(var_28_0, {
		__index = function(arg_30_0, arg_30_1)
			return function()
				ccui.Helper:seekWidgetByName(self, "icon"):setPositionY(298)

				local var_31_0 = string_split(arg_28_1.name, "】")

				if #var_31_0 == 1 then
					self:getChildByName("name"):setString(var_31_0[1])

					if self:getChildByName("name_top") then
						self:getChildByName("name_top"):setString(var_31_0[1])
					end
				else
					self:getChildByName("name"):setString(var_31_0[2])

					if self:getChildByName("name_top") then
						self:getChildByName("name_top"):setString(var_31_0[2])
					end
				end
			end
		end
	})

	local function var_28_1()
		self:getChildByName("Panel_surplusTime"):setVisible(false)
		;(function()
			local var_33_0 = var_0_25(arg_28_1.discountfinish, "")

			if var_33_0 ~= "-1" and arg_28_1.cost_old and arg_28_1.discount and arg_28_1.cost_old > arg_28_1.discount then
				self:getChildByName("Panel_surplusTime"):setVisible(true)
				self:getChildByName("Panel_surplusTime"):getChildByName("Label_2"):setString(var_33_0)
				self:getChildByName("Image_discountIcon"):loadTexture("MarketLayer/limit_discount_2.png", var_0_18)
			else
				self:getChildByName("Image_discountIcon"):loadTexture("MarketLayer/discount_new_2.png", var_0_18)
			end
		end)()
		;(function()
			local var_34_0 = var_0_25(arg_28_1.finish_time, "")

			if var_34_0 ~= "-1" then
				self:getChildByName("Panel_surplusTime"):setVisible(true)
				self:getChildByName("Panel_surplusTime"):getChildByName("Label_2"):setString(var_34_0)
			end
		end)()
		;(function()
			local var_35_0 = var_0_25(arg_28_1.sell_time, "")

			if var_35_0 ~= "-1" and global_get_time_by_date(arg_28_1.sell_time) > time_check_manager:getCurTime() then
				self:getChildByName("Panel_surplusTime"):setVisible(true)
				self:getChildByName("Panel_surplusTime"):getChildByName("Label_2"):setString(var_35_0)
			end
		end)()
		self:getChildByName("Image_discountIcon"):setVisible(false)

		if discountTime == "-1" and time == "-1" then
			self:getChildByName("Panel_surplusTime"):setVisible(false)
		end
	end

	local function var_28_2()
		self:getChildByName("cost_old"):setVisible(true)

		local var_36_0 = self:getContentSize().width / 2 + 175

		self:getChildByName("Panel_cost"):setLocalZOrder(9)
		self:getChildByName("cost_old"):setLocalZOrder(9)

		if arg_28_1.sell_out == true then
			self:getChildByName("Panel_cost"):setVisible(false)
			self:getChildByName("cost_old"):setVisible(false)
			self:getChildByName("name_top"):setAnchorPoint(cc.p(0.5, 0.5))
			self:getChildByName("name"):setAnchorPoint(cc.p(0.5, 0.5))
			self:getChildByName("name_top"):setPositionX(251)
			self:getChildByName("name"):setPositionX(253)
			self:getChildByName("Image_notHaveMajorIcon"):setVisible(false)
		else
			self:getChildByName("name_top"):setAnchorPoint(cc.p(0, 0.5))
			self:getChildByName("name"):setAnchorPoint(cc.p(0, 0.5))
			self:getChildByName("name_top"):setPositionX(41)
			self:getChildByName("name"):setPositionX(43)
		end

		local var_36_1 = ccui.Helper:seekWidgetByName(self, "limit_number")

		ccui.Helper:seekWidgetByName(self, "limit_number"):setPositionX(60)

		local var_36_2 = math.abs(var_36_1:getContentSize().width - 35)
	end

	if arg_28_1.uncolor_clothes and arg_28_1.sell_out == true then
		local var_28_3 = shop_manager:fixUnColorMsg(arg_28_1)

		arg_28_1.sell_out = var_28_3.limit_buy_num <= 0
		arg_28_1.cost_old = var_28_3.cost_old
		arg_28_1.discount = var_28_3.slidecost.costnum
		arg_28_1.icon = item_data[arg_28_1.itemtype].bag_item_type == kITEM_SKIN and "mainScenebg/market/" .. item_data[var_28_3.itemtype].model .. ".png" or "mainScenebg/market/" .. item_data[var_28_3.itemtype].image_id .. ".png"
	end

	if item_data[arg_28_1.itemid].model then
		self:getChildByName("Image_notHaveMajorIcon"):setVisible(not playermodel.haveSuit[model_data[item_data[arg_28_1.itemid].model].major])
	else
		self:getChildByName("Image_notHaveMajorIcon"):setVisible(false)
	end

	var_0_24(self, arg_28_1)
	var_0_26(self, arg_28_1)
	var_28_1()
	var_28_0[self.type]()
	var_28_2()

	if arg_28_1.bag_item_type == kITEM_SKIN_GIFT or arg_28_1.bag_item_type == kITEM_SKIN then
		ccui.Helper:seekWidgetByName(self, "Panel_limit"):setVisible(false)
	end

	local var_28_4 = 185

	self:getChildByName("cost_old"):getChildByName("Image_cost_old_icon"):loadTexture(arg_28_1.costIcon, var_0_18)
	self:getChildByName("cost_old"):getChildByName("Image_cost_cur_icon"):loadTexture(arg_28_1.costIcon, var_0_18)
	self:getChildByName("cost_old"):getChildByName("Label_cost_old"):setString(arg_28_1.cost_old)

	if arg_28_1.cost_old > arg_28_1.discount then
		self:getChildByName("cost_old"):getChildByName("Image_cost_cur_icon"):setVisible(true)
		self:getChildByName("cost_old"):getChildByName("Label_cost_cur"):setVisible(true)
		self:getChildByName("cost_old"):getChildByName("Label_cost_cur"):setString(arg_28_1.discount)
		self:getChildByName("cost_old"):getChildByName("Image_cost_old_icon"):setVisible(true)
		self:getChildByName("cost_old"):getChildByName("Image_discountline"):setVisible(true)
		self:getChildByName("cost_old"):getChildByName("Label_cost_old"):setVisible(true)

		var_28_4 = 185
	else
		self:getChildByName("cost_old"):getChildByName("Image_cost_old_icon"):setVisible(false)
		self:getChildByName("cost_old"):getChildByName("Image_discountline"):setVisible(false)
		self:getChildByName("cost_old"):getChildByName("Label_cost_old"):setVisible(false)
		self:getChildByName("cost_old"):getChildByName("Image_cost_cur_icon"):setVisible(true)
		self:getChildByName("cost_old"):getChildByName("Label_cost_cur"):setVisible(true)
		self:getChildByName("cost_old"):getChildByName("Label_cost_cur"):setString(arg_28_1.cost_old)

		var_28_4 = 285
	end

	self:getChildByName("Panel_cost"):setPositionX(var_28_4)

	if arg_28_1.discount2 then
		self:getChildByName("Panel_cost"):setVisible(true)
		self:getChildByName("Panel_cost"):getChildByName("cost_label"):setString(arg_28_1.discount2)
		ccui.Helper:seekWidgetByName(self, "coin_icon"):loadTexture(arg_28_1.costIcon2, var_0_18)
	else
		self:getChildByName("Panel_cost"):setVisible(false)
	end

	;(function(...)
		if self:getChildByName("skintype_icon") then
			self:getChildByName("skintype_icon"):setName("skintype_icon_old")
			self:getChildByName("skintype_icon_old"):runAction(cc.RemoveSelf:create())
		end

		if self:getChildByName("skin_name_bg") then
			self:getChildByName("skin_name_bg"):setName("skin_name_bg_old")
			self:getChildByName("skin_name_bg_old"):runAction(cc.RemoveSelf:create())
		end

		if self:getChildByName("extra_item_bg") then
			self:getChildByName("extra_item_bg"):setName("extra_item_bg_old")
			self:getChildByName("extra_item_bg_old"):runAction(cc.RemoveSelf:create())
		end
	end)()
	;(function(...)
		while self:getChildByName("itemsprite_" .. 1) do
			self:getChildByName("itemsprite_" .. 1):setName("itemsprite_old" .. 1)
			self:getChildByName("itemsprite_old" .. 1):runAction(cc.RemoveSelf:create())
		end
	end)()
	;(function(...)
		if shop_data[arg_28_1.shopid].shop_ui_type ~= 1 then
			return
		end

		local var_39_0 = drop_manager:getDropMsg(item_data[arg_28_1.itemid].mode_id)

		table.sort(var_39_0.equips, function(arg_40_0, arg_40_1)
			return arg_40_0._index < arg_40_1._index
		end)

		local var_39_1 = {}

		if var_39_0.diamond > 0 then
			table.insert(var_39_1, {
				itemid = "diamond",
				num = var_39_0.diamond,
				name = L_DIAMOND
			})
		end

		if var_39_0.gold > 0 then
			table.insert(var_39_1, {
				itemid = "gold",
				num = var_39_0.gold,
				name = L_GOLD
			})
		end

		local var_39_2 = {}
		local var_39_3 = false
		local var_39_4 = false

		for iter_39_0, iter_39_1 in pairs(var_39_0.equips) do
			if item_data[iter_39_1.dropid].bag_item_type == kITEM_SKIN then
				return
			end

			if item_data[iter_39_1.dropid].bag_item_type == kITEM_GIFT_FOR_FRIEND then
				var_39_4 = true
			end

			if item_data[iter_39_1.dropid].bag_item_type == kITEM_FURNITURE then
				-- block empty
			end

			table.insert(var_39_2, {
				itemid = iter_39_1.dropid,
				num = iter_39_1.dropNum
			})
		end

		if var_39_4 and var_39_4 then
			var_39_3 = true
		end

		local var_39_7 = false

		while var_39_2[1] do
			local var_39_8 = false

			if item_data[var_39_2[1].itemid].bag_item_type == kITEM_FURNITURE then
				if not var_39_7 then
					var_39_7 = true
					var_39_2[1].path = string.gsub(arg_28_1.icon, ".png", "_furniture.jpg")
				else
					var_39_8 = true
				end
			end

			local var_39_9

			if var_39_8 then
				table.remove(var_39_2, 1)
			else
				var_39_9 = 1 + 1
			end
		end

		for iter_39_2, iter_39_3 in pairs(var_39_2) do
			table.insert(var_39_1, iter_39_3)
		end

		local var_39_10 = {}

		var_39_10 = var_39_3 and {
			cc.p(122, 479),
			cc.p(122, 324),
			cc.p(122, 169)
		} or #var_39_1 == 2 and {
			cc.p(122, 465),
			cc.p(122, 275)
		} or #var_39_1 == 3 and {
			cc.p(122, 211),
			cc.p(122, 352),
			cc.p(122, 494)
		} or {
			cc.p(122, 211),
			cc.p(122, 352),
			cc.p(122, 494)
		}

		for iter_39_4, iter_39_5 in pairs(var_39_1) do
			local var_39_11 = ItemSpriteShop:createSignItem()

			var_39_11:updateSignItemByItemid(iter_39_5.itemid, iter_39_5.num, nil, nil, iter_39_5.path)
			var_39_11:setName("itemsprite_" .. iter_39_4)
			var_39_11:setPosition(var_39_10[iter_39_4])
			self:addChild(var_39_11)
			var_39_11:setInfoTouchEvent(true)
			var_39_11:setSwallowTouches(true)
		end
	end)()
	;(function(...)
		local var_41_3
		local var_41_2
		local var_41_1
		local var_41_0

		if shop_data[arg_28_1.shopid].shop_ui_type ~= 2 then
			do return end

			var_41_1 = ""
		end

		for iter_41_0, iter_41_1 in pairs(drop_manager:getDropMsg(item_data[arg_28_1.itemid].mode_id).equips) do
			if item_data[iter_41_1.dropid].bag_item_type == kITEM_SKIN then
				var_41_0 = model_data[item_data[iter_41_1.dropid].model].live2d and not model_data[item_data[iter_41_1.dropid].model].origin and "live2d" or var_41_0
				var_41_0 = model_data[item_data[iter_41_1.dropid].model].rolespine and "spine" or var_41_0
				var_41_1 = item_data[iter_41_1.dropid].name
			else
				var_41_2 = iter_41_1.dropid
				var_41_3 = iter_41_1.dropNum
			end
		end

		local var_41_4 = ccui.ImageView:create("MarketLayer/skin_name_bg.png", var_0_18)

		var_41_4:setName("skin_name_bg")
		var_41_4:setPosition(cc.p(40, 456))
		self:addChild(var_41_4, 10)

		local var_41_5 = glabal_trans_text_horizontal_to_vertical(var_41_1)

		for iter_41_2, iter_41_3 in pairs({
			"【",
			"】",
			"%[",
			"%]"
		}) do
			var_41_5 = string.gsub(var_41_5, iter_41_3, "")
		end

		local var_41_6 = cc.Label:createWithTTF(var_41_5, FONT_BUTTON, 32)

		var_41_6:setPosition(cc.p(var_41_4:getContentSize().width / 2, 130))
		var_41_6:setScaleY(var_41_6:getContentSize().height < 240 and 1 or 240 / var_41_6:getContentSize().height)
		var_41_4:addChild(var_41_6)

		if not var_41_0 then
			var_41_6:setPositionY(190)
		end

		if var_41_2 then
			local var_41_7 = ccui.ImageView:create("MarketLayer/extra_item.png", var_0_18)

			var_41_7:setName("extra_item_bg")
			var_41_7:setPosition(cc.p(96, 102))
			self:addChild(var_41_7, 11)

			local var_41_8 = cc.Label:createWithTTF("赠:", FONT_BUTTON, 25)

			var_41_8:setAnchorPoint(cc.p(0, 0.5))
			var_41_8:setPositionX(7)
			var_41_8:setColor(cc.c3b(0, 0, 0))
			var_41_8:setPositionY(var_41_7:getContentSize().height / 2 - 22)
			var_41_7:addChild(var_41_8)

			local var_41_9 = cc.Label:createWithTTF("赠:", FONT_BUTTON, 25)

			var_41_9:setAnchorPoint(cc.p(0, 0.5))
			var_41_9:setPositionX(5)
			var_41_9:setPositionY(var_41_7:getContentSize().height / 2 - 24)
			var_41_7:addChild(var_41_9)

			if item_data[var_41_2].bag_item_type == kITEM_SCULTURE then
				local var_41_10 = AvatarSprite:create(var_41_2)

				var_41_10:setPositionX(40)
				var_41_10:setPositionY(14)
				var_41_10:setScale(0.49411764705882355)
				var_41_7:addChild(var_41_10)

				local var_41_11 = cc.Label:createWithTTF("x" .. var_41_3, FONT_BUTTON, 25)

				var_41_11:setAnchorPoint(cc.p(0, 0.5))
				var_41_11:setColor(cc.c3b(0, 0, 0))
				var_41_11:setPositionX(136)
				var_41_11:setPositionY(var_41_7:getContentSize().height / 2 - 22)
				var_41_7:addChild(var_41_11)

				local var_41_12 = cc.Label:createWithTTF("x" .. var_41_3, FONT_BUTTON, 25)

				var_41_12:setAnchorPoint(cc.p(0, 0.5))
				var_41_12:setPositionX(134)
				var_41_12:setPositionY(var_41_7:getContentSize().height / 2 - 24)
				var_41_7:addChild(var_41_12)
			else
				local var_41_13 = ccui.ImageView:create("equipment/" .. item_data[var_41_2].image_id .. ".png")

				var_41_13:setPositionX(var_41_7:getContentSize().width / 2)
				var_41_13:setPositionY(var_41_7:getContentSize().height / 2)
				var_41_13:setScale(0.6)
				var_41_7:addChild(var_41_13)

				local var_41_14 = cc.Label:createWithTTF("x" .. var_41_3, FONT_BUTTON, 25)

				var_41_14:setAnchorPoint(cc.p(0, 0.5))
				var_41_14:setColor(cc.c3b(0, 0, 0))
				var_41_14:setPositionX(136)
				var_41_14:setPositionY(var_41_7:getContentSize().height / 2 - 22)
				var_41_7:addChild(var_41_14)

				local var_41_15 = cc.Label:createWithTTF("x" .. var_41_3, FONT_BUTTON, 25)

				var_41_15:setAnchorPoint(cc.p(0, 0.5))
				var_41_15:setPositionX(134)
				var_41_15:setPositionY(var_41_7:getContentSize().height / 2 - 24)
				var_41_7:addChild(var_41_15)
			end
		end

		if var_41_0 then
			local var_41_16 = ccui.ImageView:create("MarketLayer/" .. var_41_0 .. ".png", var_0_18)

			var_41_16:setName("skintype_icon")
			var_41_16:setPosition(cc.p(40, 560))
			self:addChild(var_41_16, 12)
		end
	end)()
end

local var_0_31

shopSpriteType4 = class("shopSpriteType4", function()
	if not var_0_31 then
		var_0_31 = ccui.Helper:seekWidgetByName(ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "MarketSpriteType4.json" or "MarketSpriteType4.ExportJson"), "clothItem")

		var_0_31:loadTextures(var_0_17, var_0_17, var_0_17)
		var_0_31:retain()
	end

	return var_0_31:clone()
end)

function shopSpriteType4.update(arg_43_0, arg_43_1)
	var_0_24(arg_43_0, arg_43_1)
	var_0_26(arg_43_0, arg_43_1)
	;(function()
		(function()
			local var_45_0 = var_0_25(arg_43_1.discountfinish)

			if var_45_0 ~= "-1" then
				arg_43_0:getChildByName("Panel_surplusTime"):setVisible(true)

				local var_45_1 = arg_43_0:getChildByName("Panel_surplusTime"):getChildByName("Label_1")
				local var_45_2 = arg_43_0:getChildByName("Panel_surplusTime"):getChildByName("Label_2")

				var_45_1:setString(L_MARKET_MSG.Discount_Rest)
				var_45_2:setString(var_45_0)

				local var_45_3 = arg_43_0:getChildByName("Panel_surplusTime")

				arg_43_0:getChildByName("Panel_surplusTime"):getChildByName("Panel_timeBg").setContentSize(var_45_3, cc.size(var_45_1:getContentSize().width + var_45_2:getContentSize().width + 6, var_45_3:getChildByName("Panel_timeBg"):getContentSize().height))
			else
				arg_43_0:getChildByName("Panel_surplusTime"):setVisible(false)
			end
		end)()
		;(function()
			local var_46_0 = var_0_25(arg_43_1.finish_time)

			if var_46_0 ~= "-1" then
				arg_43_0:getChildByName("Panel_surplusTime"):setVisible(true)

				local var_46_1 = arg_43_0:getChildByName("Panel_surplusTime"):getChildByName("Label_1")
				local var_46_2 = arg_43_0:getChildByName("Panel_surplusTime"):getChildByName("Label_2")

				var_46_1:setString(L_MARKET_MSG.Surplus_Rest)
				var_46_2:setString(var_46_0)

				local var_46_3 = arg_43_0:getChildByName("Panel_surplusTime")

				arg_43_0:getChildByName("Panel_surplusTime"):getChildByName("Panel_timeBg").setContentSize(var_46_3, cc.size(var_46_1:getContentSize().width + var_46_2:getContentSize().width + 6, var_46_3:getChildByName("Panel_timeBg"):getContentSize().height))
				arg_43_0:getChildByName("Image_discountIcon"):setVisible(false)
			else
				arg_43_0:getChildByName("Panel_surplusTime"):setVisible(false)
			end
		end)()

		if discountTime == "-1" and time == "-1" then
			arg_43_0:getChildByName("Panel_surplusTime"):setVisible(false)
		end
	end)()
	;(function()
		local var_47_0 = arg_43_0:getContentSize().width / 2 + 175

		if arg_43_1.sell_out then
			arg_43_0:getChildByName("Panel_cost"):setVisible(false)
			arg_43_0:getChildByName("cost_old"):setVisible(false)
		else
			if arg_43_1.cost_old2 then
				arg_43_0:getChildByName("Panel_cost2"):setVisible(true)
				arg_43_0:getChildByName("Panel_cost"):setPositionX(320.5)
			else
				arg_43_0:getChildByName("Panel_cost2"):setVisible(false)
				arg_43_0:getChildByName("Panel_cost"):setPositionX(460.5)

				if arg_43_0:getChildByName("Image_40") then
					arg_43_0:getChildByName("Image_40"):setVisible(false)
				end
			end

			arg_43_0:getChildByName("Panel_cost"):setVisible(true)
			arg_43_0:getChildByName("cost_old"):setVisible(false)

			if arg_43_1.cost_old then
				arg_43_0:getChildByName("cost_old"):setVisible(true)
				arg_43_0:getChildByName("cost_old"):getChildByName("Image_cost_old_icon"):loadTexture(arg_43_1.costIcon, var_0_18)
			end

			if arg_43_1.discount >= arg_43_1.cost_old then
				arg_43_0:getChildByName("cost_old"):setVisible(false)
			end
		end
	end)()
	;(function()
		arg_43_0:getChildByName("name"):setString(item_data[arg_43_1.itemid].name)
		arg_43_0:getChildByName("name_top"):setString(item_data[arg_43_1.itemid].name)
	end)()
	updateCurFurnitureHaveServant(arg_43_0, arg_43_1)
end

function updateCurPanelHaveServant(arg_49_0, arg_49_1, arg_49_2)
	self = arg_49_0

	local var_49_0 = self:getChildByName("isShowHaveServant")
	local var_49_1 = self:getChildByName("mask")
	local var_49_2

	if arg_49_1.bag_item_type == kITEM_WEAPON then
		var_49_2 = item_data[arg_49_1.itemid].modelid
	elseif arg_49_1.bag_item_type == kITEM_GIFT_FOR_FRIEND and item_data[arg_49_1.itemid].exclusive then
		var_49_2 = major_factor_data[item_data[arg_49_1.itemid].exclusive].model
	elseif arg_49_1.bag_item_type == kITEM_FURNITURE_GIFT then
		local var_49_3 = item_data[arg_49_1.itemid] and item_data[arg_49_1.itemid].suit_id
		local var_49_4 = furnituresuit_data[var_49_3] and furnituresuit_data[var_49_3].servantid

		var_49_2 = major_factor_data[var_49_4] and major_factor_data[var_49_4].model

		self:getChildByName("Image_discountIcon"):setVisible(false)
	end

	if var_49_0 ~= nil then
		var_49_0:removeFromParent()
	end

	if var_49_1 ~= nil then
		var_49_1:removeFromParent()
	end

	if var_49_2 ~= nil then
		arg_49_2 = arg_49_2 or cc.p(100, 50)

		local var_49_5 = "roleimage/role1/" .. model_data[var_49_2].cute_role .. ".png"
		local var_49_6

		if config._DEBUG then
			var_49_6 = cc.Sprite:create("MarketLayer/avatar/clip_mask.png") or cc.Sprite:createWithSpriteFrameName("MarketLayer/avatar/clip_mask.png")
		end

		local var_49_7 = cc.Sprite:create(var_49_5)

		var_49_7:setScale(0.19)
		var_49_7:setPosition(cc.p(0, 5))

		local var_49_8 = cc.ClippingNode:create(var_49_6)

		var_49_8:setAlphaThreshold(0.5)
		var_49_8:setContentSize(cc.size(36, 36))
		var_49_8:setPosition(arg_49_2)
		var_49_8:addChild(var_49_7)
		var_49_8:setScale(1)
		var_49_8:setName("isShowHaveServant")
		var_49_8:setCascadeOpacityEnabled(true)
		self:addChild(var_49_8, 99)
		var_49_8:addChild((ccui.ImageView:create("MarketLayer/avatar/line.png", var_0_18)))

		local var_49_9 = ccui.ImageView:create("MarketLayer/avatar/mask.png", var_0_18)

		var_49_9:setName("mask")
		var_49_9:setPosition(arg_49_2)
		self:addChild(var_49_9, 99)

		local var_49_10 = ccui.ImageView:create("MarketLayer/avatar/lock.png", var_0_18)

		var_49_10:setPosition(cc.p(32, 6))
		var_49_9:addChild(var_49_10)
		self:getChildByName("mask"):setVisible(arg_49_1.canShowHaveServant == false)
	end
end

function updateCurFurnitureHaveServant(arg_50_0, arg_50_1, arg_50_2)
	self = arg_50_0

	local var_50_0 = self:getChildByName("isShowHaveServant")
	local var_50_1 = self:getChildByName("mask")
	local var_50_2 = self:getChildByName("di")
	local var_50_3

	if arg_50_1.bag_item_type == kITEM_WEAPON then
		var_50_3 = item_data[arg_50_1.itemid].modelid
	elseif arg_50_1.bag_item_type == kITEM_GIFT_FOR_FRIEND and item_data[arg_50_1.itemid].exclusive then
		var_50_3 = major_factor_data[item_data[arg_50_1.itemid].exclusive].model
	elseif arg_50_1.bag_item_type == kITEM_FURNITURE_GIFT then
		local var_50_4 = item_data[arg_50_1.itemid] and item_data[arg_50_1.itemid].suit_id
		local var_50_5 = furnituresuit_data[var_50_4] and furnituresuit_data[var_50_4].servantid

		var_50_3 = major_factor_data[var_50_5] and major_factor_data[var_50_5].model

		self:getChildByName("Image_discountIcon"):setVisible(false)
	end

	if var_50_0 ~= nil then
		var_50_0:removeFromParent()
	end

	if var_50_1 ~= nil then
		var_50_1:removeFromParent()
	end

	if var_50_2 ~= nil then
		var_50_2:removeFromParent()
	end

	if var_50_3 ~= nil then
		arg_50_2 = arg_50_2 or cc.p(60, 148)

		local var_50_6 = "roleimage/role1/" .. model_data[var_50_3].cute_role .. ".png"
		local var_50_7

		if config._DEBUG then
			var_50_7 = cc.Sprite:create("public/rolebg/q_avatar_furniture_mask.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/q_avatar_furniture_mask.png")
		end

		local var_50_8 = cc.Sprite:create(var_50_6)

		var_50_8:setScale(0.28)
		var_50_8:setPosition(cc.p(-20, 30))

		local var_50_9 = cc.ClippingNode:create(var_50_7)

		var_50_9:setAlphaThreshold(0.5)
		var_50_9:setContentSize(cc.size(120, 112))
		var_50_9:setPosition(arg_50_2)
		var_50_9:addChild(var_50_8)
		var_50_9:setScale(1)
		var_50_9:setName("isShowHaveServant")
		var_50_9:setCascadeOpacityEnabled(true)
		self:addChild(var_50_9, 99)

		local var_50_10 = ccui.ImageView:create("public/rolebg/q_avatar_furniture_lock.png", var_0_18)

		var_50_10:setName("mask")
		var_50_10:setPosition(arg_50_2)
		self:addChild(var_50_10, 99)
		self:getChildByName("mask"):setVisible(arg_50_1.canShowHaveServant == false)

		local var_50_11 = ccui.ImageView:create("public/rolebg/q_avatar_furniture_di.png", var_0_18)

		var_50_11:setName("di")
		var_50_11:setPosition(arg_50_2)
		self:addChild(var_50_11, 98)
	end
end

local var_0_32

shopSpriteType5 = class("shopSpriteType5", function()
	if not var_0_32 then
		var_0_32 = ccui.Helper:seekWidgetByName(ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "MarketSpriteType5.json" or "MarketSpriteType5.ExportJson"), "bg")

		var_0_32:retain()
	end

	return var_0_32:clone()
end)

function shopSpriteType5.update(arg_52_0, arg_52_1)
	var_0_24(arg_52_0, arg_52_1)
	var_0_26(arg_52_0, arg_52_1)
	;(function()
		local var_56_9000
		local var_56_0 = arg_52_0:getContentSize().width / 2 + 175

		if arg_52_1.sell_out then
			arg_52_0:getChildByName("Panel_cost"):setVisible(false)
			arg_52_0:getChildByName("cost_old"):setVisible(false)
		else
			arg_52_0:getChildByName("Panel_cost"):setVisible(true)

			if arg_52_1.cost_old then
				arg_52_0:getChildByName("cost_old"):setVisible(true)
				arg_52_0:getChildByName("cost_old"):getChildByName("Image_cost_old_icon"):loadTexture(arg_52_1.costIcon, var_0_18)
			end

			if arg_52_1.discount >= arg_52_1.cost_old then
				arg_52_0:getChildByName("cost_old"):setVisible(false)
			end
		end

		ccui.Helper:seekWidgetByName(arg_52_0, "limit_number"):setPositionX(ccui.Helper:seekWidgetByName(arg_52_0, "limit"):getPositionX() + ccui.Helper:seekWidgetByName(arg_52_0, "limit"):getContentSize().width)

		local var_56_1 = ccui.Helper:seekWidgetByName(arg_52_0, "limit_number")

		if var_56_1:getContentSize().width + ccui.Helper:seekWidgetByName(arg_52_0, "limit").getContentSize(var_56_1).width > 100 then
			local var_56_2 = ccui.Helper:seekWidgetByName(arg_52_0, "limit_number")

			ccui.Helper:seekWidgetByName(arg_52_0, "Panel_limit").setPositionX(ccui.Helper:seekWidgetByName(arg_52_0, "limit").getContentSize(var_56_2).width, 428.5 - (var_56_2:getContentSize().width + var_56_9000 - 100))
		end
	end)()
	;(function()
		arg_52_0:getChildByName("name"):setString(item_data[arg_52_1.itemid].name)
		arg_52_0:getChildByName("name_top"):setString(item_data[arg_52_1.itemid].name)
		arg_52_0:getChildByName("name_top_2"):setString(item_data[arg_52_1.itemid].name)
	end)()
	;(function()
		if arg_52_0:getChildByName("img_item") then
			arg_52_0:getChildByName("img_item"):removeFromParent()
		end

		require("view.Sprite.ItemSprite")

		local var_58_0 = ItemSprite:createNewWithItemId(arg_52_1.itemid, arg_52_1.item_number, "withoutBox")

		var_58_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_58_0:setPosition(cc.p(100, arg_52_0:getContentSize().height / 2 - 30))
		var_58_0:setName("img_item")
		arg_52_0:addChild(var_58_0, 5)
		arg_52_0:getChildByName("Image_redDot"):setVisible(false)
	end)()
end

local var_0_33

shopSpriteType6 = class("shopSpriteType6", function()
	if not var_0_33 then
		var_0_33 = ccui.Helper:seekWidgetByName(ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "MarketSpriteType6.json" or "MarketSpriteType6.ExportJson"), "panelItem")

		var_0_33:retain()
	end

	var_0_33:setAnchorPoint(0.5, 0.5)

	return var_0_33:clone()
end)

function shopSpriteType6:update(arg_60_1)
	Utility:addClickEventListener(self, handler(self, self.onPanelClick), arg_60_1)
	self:setSwallowsTouches(false)
	;(function(arg_61_0, arg_61_1)
		local var_61_0 = arg_61_0:getChildByName("imgRole")
		local var_61_1 = arg_61_0:getChildByName("imgFlag")
		local var_61_2 = arg_61_0:getChildByName("imgNameBg"):getChildByName("labelName")

		if not shop_data[arg_61_1.shopid] then
			print("miss shop_skin_config", arg_61_1.shopid)

			return
		end

		local var_61_3 = shop_data[arg_61_1.shopid].unique_item

		if not item_data[shop_data[arg_61_1.shopid].unique_item] then
			print("miss item data", var_61_3)

			return
		end

		local var_61_4 = tostring(item_data[var_61_3].model)

		var_61_2:setFontName(FONT_W5)
		var_61_2:setString(item_data[var_61_3].name)

		if var_61_4 and model_data[var_61_4] then
			var_61_0:loadTexture("roleimage/role/shop_image/" .. model_data[var_61_4].role_image .. ".png")
			var_61_0:setScale(0.7)
		end

		var_61_1:setVisible(true)

		if model_data[var_61_4].live2d and not model_data[var_61_4].origin then
			var_61_1:loadTexture("CostumeRoomLayer/live2d_sign.png", var_0_18)
		elseif model_data[var_61_4].rolespine then
			var_61_1:loadTexture("CostumeRoomLayer/dynamic.png", var_0_18)
		else
			var_61_1:setVisible(false)
		end

		var_61_1:setScale(0.8)
		var_61_1:setPosition(arg_61_0:getContentSize().width - 15, arg_61_0:getContentSize().height - 15)
	end)(self, arg_60_1)
	;(function(arg_62_0, arg_62_1)
		local var_62_0 = arg_62_0:getChildByName("imgDiscount"):getChildByName("labelDiscount")

		var_62_0:setFontName("fonts/name.ttf")
		var_62_0:setString("" .. math.floor(arg_62_1.cost / arg_62_1.cost_old * 10) .. "折")

		local var_62_1 = arg_62_0:getChildByName("imgPriceBg")
		local var_62_2 = var_62_1:getChildByName("imgCost")

		if arg_62_1.costIcon:find("equipment") then
			var_62_2:loadTexture(arg_62_1.costIcon)
			var_62_2:setScale(0.32)
		else
			var_62_2:loadTexture(arg_62_1.costIcon, var_0_18)
			var_62_2:setPositionX(10)
		end

		local var_62_3 = var_62_1:getChildByName("labelOriPrice")

		var_62_3:setFontName("fonts/newkj.ttf")
		var_62_3:setString("" .. arg_62_1.cost_old)
		var_62_3:setColor(cc.c3b(190, 190, 190))

		local var_62_4 = var_62_3:getChildByName("imgDiscountLine")

		if not var_62_4 then
			var_62_4 = ccui.ImageView:create("MarketLayer/discount_line.png", var_0_18)

			var_62_4:setName("imgDiscountLine")
			var_62_4:setPosition(var_62_3:getContentSize().width / 2, var_62_3:getContentSize().height / 2)
			var_62_4:setScale(0.5)
			var_62_3:addChild(var_62_4)
		end

		local var_62_5 = var_62_1:getChildByName("labelCurPrice")

		var_62_5:setString("" .. arg_62_1.cost)
		var_62_5:setFontName("fonts/newkj.ttf")
		var_62_5:setColor(cc.c3b(255, 230, 0))

		local var_62_6 = var_62_1:getChildByName("labelBought")

		if not var_62_6 then
			var_62_6 = ccui.Text:create("已购买", "fonts/newkj.ttf", 21)

			var_62_6:setPosition(var_62_3:getPositionX() + 25, var_62_3:getPositionY())
			var_62_1:addChild(var_62_6)
			var_62_6:setName("labelBought")
		end

		if not shop_data[arg_62_1.shopid] then
			print("miss shop_skin_config", arg_62_1.shopid)

			return
		end

		if not item_data[shop_data[arg_62_1.shopid].unique_item] then
			print("miss item data", shop_data[arg_62_1.shopid].unique_item)

			return
		end

		var_62_6:setVisible(arg_62_1.have_bought > 0)
		var_62_3:setVisible(arg_62_1.have_bought <= 0)
		var_62_5:setVisible(arg_62_1.have_bought <= 0)
		var_62_4:setVisible(arg_62_1.have_bought <= 0)
	end)(self, arg_60_1)
end

function shopSpriteType6.onPanelClick(arg_63_0, arg_63_1, arg_63_2)
	if arg_63_2.is_lock_activitycity then
		if arg_63_2.lock_activitycity then
			local var_63_0 = {}

			for iter_63_0 in arg_63_2.lock_activitycity:gmatch("([^-]+)") do
				var_63_0[#var_63_0 + 1] = tonumber(iter_63_0)
			end

			global_ShowBlockWords(L_CLEAR_CHAPTER .. "【" .. L_MODE_DIFFICULTY_LAMIA[level_manager:getDifficultByMode(var_63_0[1])] .. level_manager:getChapterName(var_63_0[1], var_63_0[2]) .. "】" .. L_CAN_BUY)
		end
	elseif arg_63_2.family_shop_limit and arg_63_2.family_shop_limit > 0 then
		global_ShowBlockWords(string.format(COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips19, arg_63_2.family_shop_limit))
	else
		arg_63_2.touchCallBack(arg_63_1, ccui.TouchEventType.ended)
	end
end

local var_0_34

shopSpriteType7 = class("shopSpriteType7", function()
	if not var_0_30 then
		var_0_30 = ccui.Helper:seekWidgetByName(ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "MarketSpriteType3.json" or "MarketSpriteType3.ExportJson"), "clothItem")

		var_0_30:loadTextures(var_0_17, var_0_17, var_0_17)
		var_0_30:retain()
	end

	if not var_0_34 then
		var_0_34 = ccui.Layout:create()

		var_0_34:setAnchorPoint(0.5, 0.5)
		var_0_34:setContentSize(164, 305)

		local var_64_0 = ccui.ImageView:create("MarketLayer/skin_show_small_bg.png", var_0_18)

		var_64_0:setName("skin_show_small_bg")
		var_64_0:setAnchorPoint(0, 0)
		var_0_34:addChild(var_64_0, 1)

		for iter_64_0, iter_64_1 in ipairs((var_0_30:getChildren())) do
			if iter_64_1:getName() ~= "cut" then
				var_0_34:addChild(iter_64_1:clone(), 3)
			end
		end

		var_0_34:retain()
	end

	return var_0_34:clone()
end)

function shopSpriteType7:updateChildsFromShopSpriteType3(arg_65_1)
	local var_65_0 = {
		["1-2"] = function()
			ccui.Helper:seekWidgetByName(self, "icon"):setPositionY(298)
			self:getChildByName("name"):setString(item_data[arg_65_1.itemid].name)
			self:getChildByName("name_top"):setString(item_data[arg_65_1.itemid].name)
		end
	}

	setmetatable(var_65_0, {
		__index = function(arg_67_0, arg_67_1)
			return function()
				local var_68_0 = string_split(arg_65_1.name, "】")

				if #var_68_0 == 1 then
					self:getChildByName("name"):setString(var_68_0[1])

					if self:getChildByName("name_top") then
						self:getChildByName("name_top"):setString(var_68_0[1])
					end
				else
					self:getChildByName("name"):setString(var_68_0[2])

					if self:getChildByName("name_top") then
						self:getChildByName("name_top"):setString(var_68_0[2])
					end
				end
			end
		end
	})

	local function var_65_1()
		self:getChildByName("Panel_surplusTime"):setVisible(false)
		;(function()
			local var_70_0 = var_0_25(arg_65_1.discountfinish, "")

			if var_70_0 ~= "-1" and arg_65_1.cost_old and arg_65_1.discount and arg_65_1.cost_old > arg_65_1.discount then
				self:getChildByName("Panel_surplusTime"):setVisible(true)
				self:getChildByName("Panel_surplusTime"):getChildByName("Label_2"):setString(var_70_0)
				self:getChildByName("Image_discountIcon"):loadTexture("MarketLayer/limit_discount_2.png", var_0_18)
			else
				self:getChildByName("Image_discountIcon"):loadTexture("MarketLayer/discount_new_2.png", var_0_18)
			end
		end)()
		;(function()
			local var_71_0 = var_0_25(arg_65_1.finish_time, "")

			if var_71_0 ~= "-1" then
				self:getChildByName("Panel_surplusTime"):setVisible(true)
				self:getChildByName("Panel_surplusTime"):getChildByName("Label_2"):setString(var_71_0)
			end
		end)()
		;(function()
			local var_72_0 = var_0_25(arg_65_1.sell_time, "")

			if var_72_0 ~= "-1" and global_get_time_by_date(arg_65_1.sell_time) > time_check_manager:getCurTime() then
				self:getChildByName("Panel_surplusTime"):setVisible(true)
				self:getChildByName("Panel_surplusTime"):getChildByName("Label_2"):setString(var_72_0)
			end
		end)()
		self:getChildByName("Image_discountIcon"):setVisible(false)

		if discountTime == "-1" and time == "-1" then
			self:getChildByName("Panel_surplusTime"):setVisible(false)
		end
	end

	local function var_65_2()
		self:getChildByName("cost_old"):setVisible(true)

		local var_73_0 = self:getContentSize().width / 2 + 175

		self:getChildByName("Panel_cost"):setLocalZOrder(9)
		self:getChildByName("cost_old"):setLocalZOrder(9)

		if arg_65_1.sell_out == true then
			self:getChildByName("Panel_cost"):setVisible(false)
			self:getChildByName("cost_old"):setVisible(false)
			self:getChildByName("name_top"):setAnchorPoint(cc.p(0.5, 0.5))
			self:getChildByName("name"):setAnchorPoint(cc.p(0.5, 0.5))
			self:getChildByName("name_top"):setPositionX(251)
			self:getChildByName("name"):setPositionX(253)
			self:getChildByName("Image_notHaveMajorIcon"):setVisible(false)
		else
			self:getChildByName("name_top"):setAnchorPoint(cc.p(0, 0.5))
			self:getChildByName("name"):setAnchorPoint(cc.p(0, 0.5))
			self:getChildByName("name_top"):setPositionX(41)
			self:getChildByName("name"):setPositionX(43)
		end

		local var_73_1 = ccui.Helper:seekWidgetByName(self, "limit_number")

		ccui.Helper:seekWidgetByName(self, "limit_number"):setPositionX(60)

		local var_73_2 = math.abs(var_73_1:getContentSize().width - 35)
	end

	if arg_65_1.uncolor_clothes and arg_65_1.sell_out == true then
		local var_65_3 = shop_manager:fixUnColorMsg(arg_65_1)

		arg_65_1.sell_out = var_65_3.limit_buy_num <= 0
		arg_65_1.cost_old = var_65_3.cost_old
		arg_65_1.discount = var_65_3.slidecost.costnum
		arg_65_1.icon = item_data[arg_65_1.itemtype].bag_item_type == kITEM_SKIN and "mainScenebg/market/" .. item_data[var_65_3.itemtype].model .. ".png" or "mainScenebg/market/" .. item_data[var_65_3.itemtype].image_id .. ".png"
	end

	if item_data[arg_65_1.itemid].model then
		self:getChildByName("Image_notHaveMajorIcon"):setVisible(not playermodel.haveSuit[model_data[item_data[arg_65_1.itemid].model].major])
	else
		self:getChildByName("Image_notHaveMajorIcon"):setVisible(false)
	end

	var_0_24(self, arg_65_1)
	var_65_1()
	var_65_0[self.type]()
	var_65_2()

	if arg_65_1.bag_item_type == kITEM_SKIN_GIFT or arg_65_1.bag_item_type == kITEM_SKIN then
		ccui.Helper:seekWidgetByName(self, "Panel_limit"):setVisible(false)
	end

	local var_65_4 = 185

	self:getChildByName("cost_old"):getChildByName("Image_cost_old_icon"):loadTexture(arg_65_1.costIcon, var_0_18)
	self:getChildByName("cost_old"):getChildByName("Image_cost_cur_icon"):loadTexture(arg_65_1.costIcon, var_0_18)
	self:getChildByName("cost_old"):getChildByName("Label_cost_old"):setString(arg_65_1.cost_old)

	if arg_65_1.cost_old > arg_65_1.discount then
		self:getChildByName("cost_old"):getChildByName("Image_cost_cur_icon"):setVisible(true)
		self:getChildByName("cost_old"):getChildByName("Label_cost_cur"):setVisible(true)
		self:getChildByName("cost_old"):getChildByName("Label_cost_cur"):setString(arg_65_1.discount)
		self:getChildByName("cost_old"):getChildByName("Image_cost_old_icon"):setVisible(true)
		self:getChildByName("cost_old"):getChildByName("Image_discountline"):setVisible(true)
		self:getChildByName("cost_old"):getChildByName("Label_cost_old"):setVisible(true)

		var_65_4 = 185
	else
		self:getChildByName("cost_old"):getChildByName("Image_cost_old_icon"):setVisible(false)
		self:getChildByName("cost_old"):getChildByName("Image_discountline"):setVisible(false)
		self:getChildByName("cost_old"):getChildByName("Label_cost_old"):setVisible(false)
		self:getChildByName("cost_old"):getChildByName("Image_cost_cur_icon"):setVisible(true)
		self:getChildByName("cost_old"):getChildByName("Label_cost_cur"):setVisible(true)
		self:getChildByName("cost_old"):getChildByName("Label_cost_cur"):setString(arg_65_1.cost_old)

		var_65_4 = 285
	end

	self:getChildByName("Panel_cost"):setPositionX(var_65_4)

	if arg_65_1.discount2 then
		self:getChildByName("Panel_cost"):setVisible(true)
		self:getChildByName("Panel_cost"):getChildByName("cost_label"):setString(arg_65_1.discount2)
		ccui.Helper:seekWidgetByName(self, "coin_icon"):loadTexture(arg_65_1.costIcon2, var_0_18)
	else
		self:getChildByName("Panel_cost"):setVisible(false)
	end

	;(function(...)
		if self:getChildByName("skintype_icon") then
			self:getChildByName("skintype_icon"):setName("skintype_icon_old")
			self:getChildByName("skintype_icon_old"):runAction(cc.RemoveSelf:create())
		end

		if self:getChildByName("skin_name_bg") then
			self:getChildByName("skin_name_bg"):setName("skin_name_bg_old")
			self:getChildByName("skin_name_bg_old"):runAction(cc.RemoveSelf:create())
		end

		if self:getChildByName("extra_item_bg") then
			self:getChildByName("extra_item_bg"):setName("extra_item_bg_old")
			self:getChildByName("extra_item_bg_old"):runAction(cc.RemoveSelf:create())
		end
	end)()
	;(function(...)
		while self:getChildByName("itemsprite_" .. 1) do
			self:getChildByName("itemsprite_" .. 1):setName("itemsprite_old" .. 1)
			self:getChildByName("itemsprite_old" .. 1):runAction(cc.RemoveSelf:create())
		end
	end)()
	;(function(...)
		if shop_data[arg_65_1.shopid].shop_ui_type ~= 1 then
			return
		end

		local var_76_0 = drop_manager:getDropMsg(item_data[arg_65_1.itemid].mode_id)

		table.sort(var_76_0.equips, function(arg_77_0, arg_77_1)
			return arg_77_0._index < arg_77_1._index
		end)

		local var_76_1 = {}

		if var_76_0.diamond > 0 then
			table.insert(var_76_1, {
				itemid = "diamond",
				num = var_76_0.diamond,
				name = L_DIAMOND
			})
		end

		if var_76_0.gold > 0 then
			table.insert(var_76_1, {
				itemid = "gold",
				num = var_76_0.gold,
				name = L_GOLD
			})
		end

		local var_76_2 = {}
		local var_76_3 = false
		local var_76_4 = false

		for iter_76_0, iter_76_1 in pairs(var_76_0.equips) do
			if item_data[iter_76_1.dropid].bag_item_type == kITEM_SKIN then
				return
			end

			if item_data[iter_76_1.dropid].bag_item_type == kITEM_GIFT_FOR_FRIEND then
				var_76_4 = true
			end

			if item_data[iter_76_1.dropid].bag_item_type == kITEM_FURNITURE then
				-- block empty
			end

			table.insert(var_76_2, {
				itemid = iter_76_1.dropid,
				num = iter_76_1.dropNum
			})
		end

		if var_76_4 and var_76_4 then
			var_76_3 = true
		end

		local var_76_7 = false

		while var_76_2[1] do
			local var_76_8 = false

			if item_data[var_76_2[1].itemid].bag_item_type == kITEM_FURNITURE then
				if not var_76_7 then
					var_76_7 = true
					var_76_2[1].path = string.gsub(arg_65_1.icon, ".png", "_furniture.jpg")
				else
					var_76_8 = true
				end
			end

			local var_76_9

			if var_76_8 then
				table.remove(var_76_2, 1)
			else
				var_76_9 = 1 + 1
			end
		end

		for iter_76_2, iter_76_3 in pairs(var_76_2) do
			table.insert(var_76_1, iter_76_3)
		end

		local var_76_10 = {}

		var_76_10 = var_76_3 and {
			cc.p(122, 479),
			cc.p(122, 324),
			cc.p(122, 169)
		} or #var_76_1 == 2 and {
			cc.p(122, 465),
			cc.p(122, 275)
		} or #var_76_1 == 3 and {
			cc.p(122, 211),
			cc.p(122, 352),
			cc.p(122, 494)
		} or {
			cc.p(122, 211),
			cc.p(122, 352),
			cc.p(122, 494)
		}

		for iter_76_4, iter_76_5 in pairs(var_76_1) do
			local var_76_11 = ItemSpriteShop:createSignItem()

			var_76_11:updateSignItemByItemid(iter_76_5.itemid, iter_76_5.num, nil, nil, iter_76_5.path)
			var_76_11:setName("itemsprite_" .. iter_76_4)
			var_76_11:setPosition(var_76_10[iter_76_4])
			self:addChild(var_76_11, 3)
			var_76_11:setInfoTouchEvent(true)
			var_76_11:setSwallowTouches(true)
		end
	end)()
	;(function(...)
		local var_78_2
		local var_78_0
		local var_78_3
		local var_78_1

		if shop_data[arg_65_1.shopid].shop_ui_type ~= 2 then
			do return end

			var_78_1 = ""
		end

		for iter_78_0, iter_78_1 in pairs(drop_manager:getDropMsg(item_data[arg_65_1.itemid].mode_id).equips) do
			if item_data[iter_78_1.dropid].bag_item_type == kITEM_SKIN then
				var_78_0 = model_data[item_data[iter_78_1.dropid].model].live2d and not model_data[item_data[iter_78_1.dropid].model].origin and "live2d" or var_78_0
				var_78_0 = model_data[item_data[iter_78_1.dropid].model].rolespine and "spine" or var_78_0
				var_78_1 = item_data[iter_78_1.dropid].name
			else
				var_78_2 = iter_78_1.dropid
				var_78_3 = iter_78_1.dropNum
			end
		end

		local var_78_4 = ccui.ImageView:create("MarketLayer/skin_name_bg.png", var_0_18)

		var_78_4:setName("skin_name_bg")
		var_78_4:setPosition(cc.p(40, 456))
		self:addChild(var_78_4, 10)

		local var_78_5 = glabal_trans_text_horizontal_to_vertical(var_78_1)

		for iter_78_2, iter_78_3 in pairs({
			"【",
			"】",
			"%[",
			"%]"
		}) do
			var_78_5 = string.gsub(var_78_5, iter_78_3, "")
		end

		local var_78_6 = cc.Label:createWithTTF(var_78_5, FONT_BUTTON, 32)

		var_78_6:setPosition(cc.p(var_78_4:getContentSize().width / 2, 130))
		var_78_6:setScaleY(var_78_6:getContentSize().height < 240 and 1 or 240 / var_78_6:getContentSize().height)
		var_78_4:addChild(var_78_6)

		if not var_78_0 then
			var_78_6:setPositionY(190)
		end

		if var_78_2 then
			local var_78_7 = ccui.ImageView:create("MarketLayer/extra_item.png", var_0_18)

			var_78_7:setName("extra_item_bg")
			var_78_7:setPosition(cc.p(96, 102))
			self:addChild(var_78_7, 11)

			local var_78_8 = cc.Label:createWithTTF(L_SHOPSPRITE[1], FONT_BUTTON, 25)

			var_78_8:setAnchorPoint(cc.p(0, 0.5))
			var_78_8:setPositionX(7)
			var_78_8:setColor(cc.c3b(0, 0, 0))
			var_78_8:setPositionY(var_78_7:getContentSize().height / 2 - 22)
			var_78_7:addChild(var_78_8)

			local var_78_9 = cc.Label:createWithTTF(L_SHOPSPRITE[1], FONT_BUTTON, 25)

			var_78_9:setAnchorPoint(cc.p(0, 0.5))
			var_78_9:setPositionX(5)
			var_78_9:setPositionY(var_78_7:getContentSize().height / 2 - 24)
			var_78_7:addChild(var_78_9)

			if item_data[var_78_2].bag_item_type == kITEM_SCULTURE then
				local var_78_10 = AvatarSprite:create(var_78_2)

				var_78_10:setPositionX(40)
				var_78_10:setPositionY(14)
				var_78_10:setScale(0.49411764705882355)
				var_78_7:addChild(var_78_10)

				local var_78_11 = cc.Label:createWithTTF("x" .. var_78_3, FONT_BUTTON, 25)

				var_78_11:setAnchorPoint(cc.p(0, 0.5))
				var_78_11:setColor(cc.c3b(0, 0, 0))
				var_78_11:setPositionX(136)
				var_78_11:setPositionY(var_78_7:getContentSize().height / 2 - 22)
				var_78_7:addChild(var_78_11)

				local var_78_12 = cc.Label:createWithTTF("x" .. var_78_3, FONT_BUTTON, 25)

				var_78_12:setAnchorPoint(cc.p(0, 0.5))
				var_78_12:setPositionX(134)
				var_78_12:setPositionY(var_78_7:getContentSize().height / 2 - 24)
				var_78_7:addChild(var_78_12)
			else
				local var_78_13 = ccui.ImageView:create("equipment/" .. item_data[var_78_2].image_id .. ".png")

				var_78_13:setPositionX(var_78_7:getContentSize().width / 2)
				var_78_13:setPositionY(var_78_7:getContentSize().height / 2)
				var_78_13:setScale(0.6)
				var_78_7:addChild(var_78_13)

				local var_78_14 = cc.Label:createWithTTF("x" .. var_78_3, FONT_BUTTON, 25)

				var_78_14:setAnchorPoint(cc.p(0, 0.5))
				var_78_14:setColor(cc.c3b(0, 0, 0))
				var_78_14:setPositionX(136)
				var_78_14:setPositionY(var_78_7:getContentSize().height / 2 - 22)
				var_78_7:addChild(var_78_14)

				local var_78_15 = cc.Label:createWithTTF("x" .. var_78_3, FONT_BUTTON, 25)

				var_78_15:setAnchorPoint(cc.p(0, 0.5))
				var_78_15:setPositionX(134)
				var_78_15:setPositionY(var_78_7:getContentSize().height / 2 - 24)
				var_78_7:addChild(var_78_15)
			end
		end

		if var_78_0 then
			local var_78_16 = ccui.ImageView:create("MarketLayer/" .. var_78_0 .. ".png", var_0_18)

			var_78_16:setName("skintype_icon")
			var_78_16:setPosition(cc.p(40, 560))
			self:addChild(var_78_16, 12)
		end
	end)()
end

function shopSpriteType7:fixChildsFromShopSpriteType3(arg_79_1)
	for iter_79_0, iter_79_1 in ipairs((self:getChildren())) do
		if iter_79_1:getName() ~= "skin_show_small_bg" then
			iter_79_1:setScale(0.7)
		end
	end

	self:getChildByName("Panel_cost"):setPosition(0, 0)
	self:getChildByName("cost_old"):setPosition(75, -20)
	self:getChildByName("cost_old"):getChildByName("Image_discountline"):setVisible(false)
	self:getChildByName("cost_old"):getChildByName("Image_cost_old_icon"):setVisible(false)
	self:getChildByName("cost_old"):getChildByName("Label_cost_old"):setVisible(false)
	self:getChildByName("shop_bg"):setPosition(164, -20)
	self:getChildByName("shop_bg"):setScale(1)
	self:getChildByName("shop_bg"):loadTexture("MarketLayer/small_shop_bg.png", var_0_18)
	self:getChildByName("name_top"):setPosition(30, 200)
	self:getChildByName("name_top"):setVisible(false)
	self:getChildByName("Image_notHaveMajorIcon"):setPositionX(80)
	self:getChildByName("Panel_surplusTime"):setPosition(164, 300)
	self:getChildByName("sold_out_word"):setPosition(81, -20)

	if self:getChildByName("skintype_icon") then
		self:getChildByName("skintype_icon"):setPosition(15, 282)
	end

	if self:getChildByName("skintype_icon_old") then
		self:getChildByName("skintype_icon_old"):setPosition(0, 0)
	end

	if self:getChildByName("skin_name_bg") then
		self:getChildByName("skin_name_bg"):setPosition(15, 210)
	end

	if self:getChildByName("skin_name_bg_old") then
		self:getChildByName("skin_name_bg_old"):setPosition(15, 210)
	end

	if self:getChildByName("extra_item_bg_old") then
		self:getChildByName("extra_item_bg_old"):setPosition(0, 0)
	end

	if self:getChildByName("extra_item_bg") then
		self:getChildByName("extra_item_bg"):setAnchorPoint(0, 0)
		self:getChildByName("extra_item_bg"):setPosition(0, 16)
	end
end

function shopSpriteType7:update(arg_80_1)
	local var_80_0 = self:getChildByName("skin_show_small_bg")
	local var_80_1 = var_80_0:getChildByName("clippingNode")

	if not var_80_1 then
		var_80_1 = cc.ClippingNode:create()

		var_80_1:setName("clippingNode")

		local var_80_2 = ccui.ImageView:create(arg_80_1.small_skin_img or arg_80_1.icon)

		var_80_2:setPosition(cc.p(82, 152))
		var_80_2:setName("imageView")
		var_80_1:addChild(var_80_2)
		var_80_1:setAnchorPoint(cc.p(0, 0))
		var_80_1:setPosition(cc.p(0, 0))
		var_80_1:setInverted(false)

		local var_80_3 = cc.DrawNode:create()

		var_80_3:drawSolidRect(cc.p(0, 0), cc.p(164, 305), cc.c4f(1, 1, 1, 1))
		var_80_1:setStencil(var_80_3)
		var_80_0:addChild(var_80_1)
	end

	var_80_1:getChildByName("imageView"):loadTexture(arg_80_1.small_skin_img or arg_80_1.icon)
	self:setSwallowsTouches(false)
	self:setTouchEnabled(true)
	self:updateChildsFromShopSpriteType3(arg_80_1)
	self:fixChildsFromShopSpriteType3()
end

function var_0_0.createWithName(arg_81_0, arg_81_1, arg_81_2)
	local var_81_0 = {
		shopSpriteType2 = function()
			return shopSpriteType2.new()
		end,
		shopSpriteType3 = function()
			return shopSpriteType3.new()
		end,
		shopSpriteType4 = function()
			return shopSpriteType4.new()
		end,
		shopSpriteType5 = function()
			return shopSpriteType5.new()
		end,
		shopSpriteType6 = function()
			return shopSpriteType6.new()
		end
	}

	setmetatable(var_81_0, {
		__index = function(arg_87_0, arg_87_1)
			return function()
				return shopSpriteType1.new()
			end
		end
	})

	if arg_81_2 then
		return shopSpriteType7.new()
	end

	return var_81_0[arg_81_1]()
end

local var_0_35 = {
	shopSpriteType1 = shopSpriteType1,
	shopSpriteType2 = shopSpriteType2,
	shopSpriteType3 = shopSpriteType3,
	shopSpriteType4 = shopSpriteType4,
	shopSpriteType5 = shopSpriteType5,
	shopSpriteType6 = shopSpriteType6
}

function var_0_0.getClass(arg_89_0)
	return var_0_35[arg_89_0]
end

return var_0_0
