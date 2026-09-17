PopCookLayer = class("PopCookLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")

local network = require("network.network")
local food_data = require("data.food_production.eatables.food_data")
local eatables_data = require("data.food_production.eatables.eatables_data")
local role_conversation_data = require("data.role_conversation_data")
local conversation_class_data = require("data.conversation_class_data")
local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local cook_manager = require("controller.cook_manager")
local var_0_9 = config._DEBUG and 0 or 1
local var_0_10 = "equipment/"
local var_0_11 = 71
local var_0_12 = 72
local var_0_13 = 1
local var_0_14 = 2
local var_0_15 = {
	5,
	9,
	13,
	17,
	21
}
local var_0_16 = {
	feed = {
		on = "cook/feed_button_on.png",
		off = "cook/feed_button.png"
	},
	make = {
		on = "cook/make_button_on.png",
		off = "cook/make_button.png"
	}
}
local var_0_17

function PopCookLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopCookLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopCookLayer.getInstance()
	return var_0_17
end

function PopCookLayer:init(arg_4_1)
	var_0_17 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Popfood.json" or "Popfood.ExportJson")

	self:addChild(self.rootLayer)

	self.menuLayout = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView_menu")

	self.menuLayout:setVisible(false)

	self.cookLayout = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cook")

	self.cookLayout:setVisible(false)

	self.scrollView = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView_food")

	self.scrollView:removeAllChildren()

	self.wordPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_words")
	self.returnBnt = ccui.Helper:seekWidgetByName(self.rootLayer, "button_return")
	self.sureButton = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure")

	self.wordPanel:setVisible(false)

	self.remindLabel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_remind")

	self.remindLabel:setVisible(false)
	ccui.Helper:seekWidgetByName(self.remindLabel, "Label_diamond_num"):setString(TIMEOUT_FEED_COST)
	self.returnBnt:setFlippedX(false)
	self.returnBnt:setPosition(cc.p(604, 1112))
	self.returnBnt:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.now_show_type == var_0_13 then
			self:runAction(cc.RemoveSelf:create())
		elseif self.now_show_type == var_0_14 then
			self:updateMenuPop()

			if self.linePanel then
				self.linePanel:removeFromParent()

				self.linePanel = nil
			end

			if self.oneFoodPanel then
				self.oneFoodPanel:removeAllChildren()

				self.oneFoodPanel = nil
			end

			if self.scrollView then
				self.scrollView:removeAllChildren()
			end

			self.remindLabel:setVisible(false)
			self.wordPanel:setVisible(false)

			self.now_show_type = var_0_13
		end
	end)
	self.rootLayer:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:runAction(cc.RemoveSelf:create())
	end)

	self.now_show_type = var_0_13
	self.soulid = arg_4_1

	network:rpc("get_server_date", {
		datetype = "%H"
	}, function(arg_7_0)
		self.now_time = tonumber(arg_7_0.date)

		self:initMenuPop(arg_4_1)
		self.menuLayout:setVisible(true)
	end)
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" then
			var_0_17 = nil
		end
	end)
end

function PopCookLayer:initMenuPop(arg_9_1)
	self.oneMenuBgs = {}

	local var_9_0 = tonumber(os.date("%H"))

	for iter_9_0, iter_9_1 in ipairs(var_0_15) do
		self.mealType = 5

		if iter_9_1 > self.now_time then
			self.mealType = iter_9_0 - 1

			if self.mealType > 0 then
				self.mealType = self.mealType or 5
			end

			break
		end
	end

	if self.mealType > 3 then
		self.menuLayout:scrollToBottom(0, false)
	end

	for iter_9_2 = 1, 5 do
		local var_9_1 = self.menuLayout:getChildByName("Image_" .. ONEMENU[iter_9_2])

		if iter_9_2 == self.mealType then
			var_9_1:loadTexture("public/popup_new_bg_on.png", var_0_9)
		end

		var_9_1:getChildByName("Button_eatable"):setVisible(false)

		for iter_9_3, iter_9_4 in pairs(cook_manager.girlsMenus[arg_9_1][iter_9_2]) do
			local var_9_2 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, "", var_0_9)
			local var_9_3 = ItemSprite:createWithItemId(iter_9_4.id)

			var_9_3.isreday = true

			var_9_3:setPosition(cc.p(var_9_3:getContentSize().width / 2, var_9_3:getContentSize().height / 2))
			var_9_3:setName("icon")
			var_9_2:addChild(var_9_3)
			var_9_2:setName("eatable" .. iter_9_3)
			var_9_2:setPosition(cc.p(68 + (iter_9_3 - 1) * 116, 68))
			var_9_1:addChild(var_9_2)

			if iter_9_4.isate then
				var_9_2:addTouchEventListener(function(arg_10_0, arg_10_1)
					if arg_10_1 ~= ccui.TouchEventType.ended then
						return
					end

					global_ShowBlockWords(L_HAVE_ATE)
				end)
			else
				var_9_3:setOpacity(100)

				for iter_9_5, iter_9_6 in ipairs((cook_manager:getBaseFoods(iter_9_4.id))) do
					if not item_manager:isHaveEnoughItem(iter_9_6.itemid, iter_9_6.num) then
						var_9_3.isreday = false

						break
					end
				end

				if item_data[iter_9_4.id].bag_item_type == kITEM_FOOD then
					var_9_3.isreday = false
				end

				if item_manager:getItemNumber(iter_9_4.id) > 0 then
					local var_9_4

					if config._DEBUG then
						var_9_4 = cc.Sprite:create("cook/can_feed.png") or cc.Sprite:createWithSpriteFrameName("cook/can_feed.png")
					end

					var_9_4:setPosition(cc.p(var_9_3:getContentSize().width - 5 - var_9_4:getBoundingBox().width / 2, 5 + var_9_4:getBoundingBox().height / 2))
					var_9_4:setName("feed_sp")
					var_9_2:addChild(var_9_4, 5)
				elseif var_9_3.isreday then
					local var_9_5

					if config._DEBUG then
						var_9_5 = cc.Sprite:create("cook/can_make.png") or cc.Sprite:createWithSpriteFrameName("cook/can_make.png")
					end

					var_9_5:setPosition(cc.p(var_9_3:getContentSize().width - 5 - var_9_5:getBoundingBox().width / 2, 5 + var_9_5:getBoundingBox().height / 2))
					var_9_5:setName("add_sp")
					var_9_2:addChild(var_9_5, 5)
				end

				var_9_2:addTouchEventListener(function(arg_11_0, arg_11_1)
					if arg_11_1 ~= ccui.TouchEventType.ended then
						return
					end

					self:getFoodCookData(iter_9_4.id, iter_9_2, iter_9_3, arg_9_1)
				end)
			end
		end

		self.oneMenuBgs[iter_9_2] = var_9_1
	end
end

function PopCookLayer:updateMenuPop()
	self.cookLayout:setVisible(false)
	self.menuLayout:setVisible(true)

	for iter_12_0 = 1, 5 do
		local var_12_0 = self.oneMenuBgs[iter_12_0]

		if iter_12_0 == self.mealType then
			var_12_0:loadTexture("public/popup_new_bg_on.png", var_0_9)
		else
			var_12_0:loadTexture("public/popup_new_bg2.png", var_0_9)
		end

		var_12_0:getChildByName("Button_eatable"):setVisible(false)

		for iter_12_1, iter_12_2 in pairs(cook_manager.girlsMenus[self.soulid][iter_12_0]) do
			local var_12_1 = var_12_0:getChildByName("eatable" .. iter_12_1)
			local var_12_2 = var_12_1:getChildByName("icon")

			if var_12_1:getChildByName("feed_sp") then
				var_12_1:getChildByName("feed_sp"):removeFromParent()
			end

			if var_12_1:getChildByName("add_sp") then
				var_12_1:getChildByName("add_sp"):removeFromParent()
			end

			if iter_12_2.isate then
				var_12_2:setOpacity(255)
				var_12_1:addTouchEventListener(function(arg_13_0, arg_13_1)
					if arg_13_1 ~= ccui.TouchEventType.ended then
						return
					end

					global_ShowBlockWords(L_HAVE_ATE)
				end)
			else
				var_12_2:setOpacity(100)

				var_12_2.isreday = true

				for iter_12_3, iter_12_4 in ipairs((cook_manager:getBaseFoods(iter_12_2.id))) do
					if not item_manager:isHaveEnoughItem(iter_12_4.itemid, iter_12_4.num) then
						var_12_2.isreday = false

						break
					end
				end

				if item_data[iter_12_2.id].bag_item_type == kITEM_FOOD then
					var_12_2.isreday = false
				end

				if item_manager:getItemNumber(iter_12_2.id) > 0 then
					local var_12_3

					if config._DEBUG then
						var_12_3 = cc.Sprite:create("cook/can_feed.png") or cc.Sprite:createWithSpriteFrameName("cook/can_feed.png")
					end

					var_12_3:setPosition(cc.p(var_12_2:getContentSize().width - 5 - var_12_3:getBoundingBox().width / 2, 5 + var_12_3:getBoundingBox().height / 2))
					var_12_3:setName("feed_sp")
					var_12_1:addChild(var_12_3)
				elseif var_12_2.isreday then
					local var_12_4

					if config._DEBUG then
						var_12_4 = cc.Sprite:create("cook/can_make.png") or cc.Sprite:createWithSpriteFrameName("cook/can_make.png")
					end

					var_12_4:setPosition(cc.p(var_12_2:getContentSize().width - 5 - var_12_4:getBoundingBox().width / 2, 5 + var_12_4:getBoundingBox().height / 2))
					var_12_4:setName("add_sp")
					var_12_1:addChild(var_12_4)
				end

				var_12_1:addTouchEventListener(function(arg_14_0, arg_14_1)
					if arg_14_1 ~= ccui.TouchEventType.ended then
						return
					end

					self:getFoodCookData(iter_12_2.id, iter_12_0, iter_12_1, soulid)
				end)
			end
		end
	end
end

function PopCookLayer:getFoodCookData(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	if item_data[arg_15_1].bag_item_type == kITEM_FOOD and item_manager:getItemNumber(arg_15_1) <= 0 then
		global_ShowBlockWords(L_CANNOT_EAT)

		return
	end

	self.cookLayout:setVisible(true)
	self.menuLayout:setVisible(false)

	self.now_show_type = var_0_14

	if arg_15_2 < self.mealType then
		self.remindLabel:setVisible(true)
	end

	self.foodid = arg_15_1
	self.cookType = arg_15_2
	self.orderid = arg_15_3

	if math.floor(arg_15_1 / 100000) == var_0_12 then
		self.foodData = eatables_data[arg_15_1]
		self.baseFoods = {}

		local var_15_0 = 1

		while self.foodData["base_food" .. 1] do
			self.baseFoods[var_15_0] = {
				id = self.foodData["base_food" .. 1],
				num = self.foodData["base_weight" .. 1] / food_data[self.foodData["base_food" .. 1]].weight
			}
			var_15_0 = var_15_0 + 1
		end

		self:initScrollView()
	elseif math.floor(arg_15_1 / 100000) == var_0_11 then
		self.foodData = food_data[arg_15_1]

		self:initOneFood()
	end
end

function PopCookLayer:initOneFood()
	if self:getChildByName("oneFoodPanel") then
		self.oneFoodPanel = self:getChildByName("oneFoodPanel")
	else
		self.oneFoodPanel = ccui.Layout:create()

		self.oneFoodPanel:setName("oneFoodPanel")
		self:addChild(self.oneFoodPanel)
	end

	self.oneFood = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, "", var_0_9)

	self.oneFood:setPosition(cc.p(320, 750))
	self.oneFoodPanel:addChild(self.oneFood)

	local var_16_0 = ItemSprite:createWithItemId(self.foodData.id)

	var_16_0:setPosition(cc.p(var_16_0:getContentSize().width / 2, var_16_0:getContentSize().height / 2))
	self.oneFood:addChild(var_16_0)

	local var_16_1 = cc.Label:createWithTTF(L_FOOD_NAME .. " " .. self.foodData.name, "fonts/newkj.ttf", 22)

	var_16_1:setPosition(cc.p(320, self.oneFood:getPositionY() - self.oneFood:getContentSize().height / 2 - var_16_1:getContentSize().height / 2 - 5))
	self.oneFoodPanel:addChild(var_16_1)

	local var_16_2 = cc.Label:createWithTTF(L_FOOD_NUM .. " " .. item_manager:getItemNumber(self.foodData.id), "fonts/newkj.ttf", 22)

	var_16_2:setPosition(cc.p(320, var_16_1:getPositionY() - var_16_1:getContentSize().height / 2 - var_16_2:getContentSize().height / 2))
	self.oneFoodPanel:addChild(var_16_2)

	local var_16_3 = {
		taste = 7,
		sweet = 4,
		hot = 6,
		salty = 8,
		color = 3,
		smell = 5,
		sour = 2
	}
	local var_16_4 = 125
	local var_16_5 = 600
	local var_16_6 = cc.Label:createWithTTF(L_FOOD_FULL_SCORE, "fonts/new1.ttf", 22)

	var_16_6:setAnchorPoint(cc.p(0, 0.5))
	var_16_6:setPosition(cc.p(var_16_4, var_16_5))
	self.oneFoodPanel:addChild(var_16_6)

	for iter_16_0, iter_16_1 in pairs(L_FOOD_ATTR) do
		local var_16_7 = cc.Label:createWithTTF("", "fonts/new1.ttf", 22)

		if iter_16_0 == "color" or iter_16_0 == "smell" or iter_16_0 == "taste" then
			var_16_7:setString(iter_16_1 .. ": " .. item_data[self.foodData.id][iter_16_0] * item_data[self.foodData.id].weight .. "/" .. item_data[self.foodData.id][iter_16_0] * item_data[self.foodData.id].weight)
		else
			var_16_7:setString(iter_16_1 .. ": " .. item_data[self.foodData.id][iter_16_0] * item_data[self.foodData.id].weight)
		end

		var_16_7:setAnchorPoint(cc.p(0, 0.5))
		var_16_7:setPosition(cc.p(var_16_4 + 300 * ((var_16_3[iter_16_0] + 1) % 2), var_16_5 - math.floor((var_16_3[iter_16_0] - 1) / 2) * (var_16_7:getContentSize().height + 20)))
		self.oneFoodPanel:addChild(var_16_7)
	end

	self.sureButton:loadTextures(var_0_16.feed.off, var_0_16.feed.on, var_0_16.feed.on, var_0_9)
	self.sureButton:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_17_0:setTouchEnabled(false)

		if DormitoryLayer.getInstance().soulInfos[DormitoryLayer.getInstance().soul_to_index[self.soulid]].isleave then
			global_ShowBlockWords(L_EAT_NO_FIGHT)
			arg_17_0:setTouchEnabled(true)
		else
			if self.mealType ~= self.cookType then
				if self.mealType > self.cookType and playermodel.diamond < TIMEOUT_FEED_COST then
					LayerManager:pushInLayer("PopGoBuyDiamond", {
						is_need_pop_layer = 0
					})
					arg_17_0:setTouchEnabled(true)

					return
				elseif self.mealType < self.cookType then
					global_ShowBlockWords(L_EAT_TIME_NO_YET)
					arg_17_0:setTouchEnabled(true)

					return
				end
			end

			local var_17_0 = self.foodData.id

			cook_manager:feedEatable(self.foodData.id, self.cookType, self.orderid, self.soulid, function(arg_18_0, arg_18_1, arg_18_2)
				if arg_18_0 == 1 then
					if DormitoryLayer.getInstance() then
						local var_18_0
						local var_18_1

						if arg_18_2 < 0 then
							var_18_0 = "hitdown"
							var_18_1 = conversation_class_data[self.soulid * 10000 + 801].conversation1
						elseif arg_18_2 / item_data[var_17_0].favor >= 0.8 then
							var_18_0 = "win"
							var_18_1 = conversation_class_data[self.soulid * 10000 + 601].conversation1
						else
							var_18_0 = "win"
							var_18_1 = conversation_class_data[self.soulid * 10000 + 701].conversation1
						end

						local var_18_2 = role_conversation_data[var_18_1].dec

						DormitoryLayer.getInstance():updateGiftPanel(self.soulid, arg_18_1, arg_18_2)
						DormitoryLayer.getInstance():insertAnimate(self.soulid, var_18_0, var_18_2)
					end

					self:runAction(cc.RemoveSelf:create())
				else
					arg_17_0:setTouchEnabled(true)
				end
			end)
		end
	end)
end

function PopCookLayer:initScorePanel(arg_19_1)
	local var_19_0 = true

	self.wordPanel:setVisible(true)

	if self.linePanel then
		self.linePanel:setVisible(false)
	end

	local var_19_1 = playermodel.items[arg_19_1]

	for iter_19_0, iter_19_1 in pairs(playermodel.items[arg_19_1].eatable_attr) do
		if iter_19_0 ~= "debuff_activity" and iter_19_0 ~= "debuff_favor" and iter_19_0 ~= "raw_foods" and iter_19_0 ~= "coke_foods" then
			if iter_19_0 == "color" or iter_19_0 == "smell" or iter_19_0 == "taste" then
				self.wordPanel:getChildByName("Label_" .. iter_19_0):getChildByName("Label_14"):setString(iter_19_1 .. "/" .. eatables_data[var_19_1.itemid]["max_" .. iter_19_0])
			else
				self.wordPanel:getChildByName("Label_" .. iter_19_0):getChildByName("Label_14"):setString(iter_19_1)
			end
		else
			var_19_0 = false
		end
	end

	self.wordPanel:getChildByName("Label_total_score"):getChildByName("Label_14"):setString(math.floor((var_19_1.eatable_attr.color + var_19_1.eatable_attr.smell + var_19_1.eatable_attr.taste) / (eatables_data[var_19_1.itemid].max_color + eatables_data[var_19_1.itemid].max_taste + eatables_data[var_19_1.itemid].max_smell) * 1000 + 0.5) / 10)

	if var_19_0 then
		self.wordPanel:getChildByName("Label_8"):setString(L_FOOD_HEALTH)
	else
		self.wordPanel:getChildByName("Label_8"):setString(L_FOOD_UNHEALTH)
	end
end

function PopCookLayer:initTreeDiagram()
	local function var_20_0(arg_21_0)
		local var_21_0 = true

		for iter_21_0, iter_21_1 in pairs(self.baseFoods) do
			if item_manager:isHaveEnoughItem(iter_21_1.id, iter_21_1.num) then
				self.linePanel:getChildByName("basefood" .. iter_21_0):setOpacity(255)
			else
				self.linePanel:getChildByName("basefood" .. iter_21_0):setOpacity(100)

				var_21_0 = false
			end
		end

		if var_21_0 then
			arg_21_0:setOpacity(255)
		else
			arg_21_0:setOpacity(100)
		end
	end

	self.wordPanel:setVisible(false)

	if self.linePanel then
		self.linePanel:setVisible(true)
	else
		self.linePanel = ccui.Layout:create()

		self:addChild(self.linePanel)

		local var_20_1 = cc.DrawNode:create()

		self.linePanel:addChild(var_20_1, 10)

		local function var_20_2(arg_22_0, arg_22_1)
			var_20_1:drawSegment(arg_22_0, arg_22_1, 2, cc.c4f(1, 1, 1, 1))
		end

		local var_20_4 = ItemSprite:createWithItemId(self.foodData.id, 1)

		var_20_4:setPosition(cc.p(SCREEN_WIDTH / 2, 650))
		var_20_4:setName("targetFoodBnt")
		self.linePanel:addChild(var_20_4, 11)
		var_20_2(cc.p(SCREEN_WIDTH / 2, 650 - var_20_4:getContentSize().height / 2), cc.p(SCREEN_WIDTH / 2, 535))

		local var_20_5 = #self.baseFoods
		local var_20_6 = #self.baseFoods - 1 == 0 and 0 or 430 / (#self.baseFoods - 1)

		for iter_20_0, iter_20_1 in ipairs(self.baseFoods) do
			local var_20_7 = ccui.ImageView:create(ITEM_BUTTON_DEFAULT_IMAGE, var_0_9)

			var_20_7:setName("basefood" .. iter_20_0)
			var_20_7:setPosition(cc.p(320 + (iter_20_0 - (var_20_5 + 1) / 2) * var_20_6, 420))

			local var_20_8 = ItemSprite:createWithItemId(iter_20_1.id, iter_20_1.num)

			var_20_8:setAnchorPoint(cc.p(0, 0))
			var_20_8:setName(iter_20_0)
			var_20_7:addChild(var_20_8)
			self.linePanel:addChild(var_20_7, 11)
			var_20_2(cc.p(320 + (iter_20_0 - (var_20_5 + 1) / 2) * var_20_6, 420 + var_20_8:getContentSize().height / 2), cc.p(320 + (iter_20_0 - (var_20_5 + 1) / 2) * var_20_6, 535))

			if iter_20_0 == 1 then
				var_20_2(cc.p(320 + (iter_20_0 - (var_20_5 + 1) / 2) * var_20_6, 535), cc.p(320 + (var_20_5 - (var_20_5 + 1) / 2) * var_20_6, 535))
			end

			if config._DEBUG then
				var_20_7:setTouchEnabled(true)
				var_20_7:addTouchEventListener(function(arg_23_0, arg_23_1)
					if arg_23_1 ~= ccui.TouchEventType.ended then
						return
					end

					arg_23_0:setTouchEnabled(false)
					network:rpc("get_items", {
						itemtype = iter_20_1.id,
						num = iter_20_1.num
					}, function(arg_24_0)
						if arg_24_0.result == 1 then
							global_riseWord(L_ROLE_WEAPON_SUCCESS)
							print_lua_table(arg_24_0.items)
							item_manager:setItemByServerItem(arg_24_0.items[1])
							arg_23_0:setTouchEnabled(true)
							var_20_0(var_20_4)
						end
					end)
				end)
			end
		end

		var_20_0(var_20_4)

		function self.linePanel.update(arg_25_0)
			var_20_0(var_20_4)
		end
	end
end

function PopCookLayer:initScrollView(arg_26_1)
	local var_26_0

	self.eatablesBnt = {}
	self.eatablelist = item_manager:getItemByItemId(self.foodid)

	table.sort(self.eatablelist, function(arg_27_0, arg_27_1)
		return cook_manager:getEatableScore(arg_27_0) > cook_manager:getEatableScore(arg_27_1)
	end)

	local var_26_1 = #self.eatablelist
	local var_26_2 = (#self.eatablelist + 1) * 118 < self.scrollView:getContentSize().width and self.scrollView:getContentSize().width or (var_26_1 + 1) * 118

	local function var_26_3(arg_28_0)
		for iter_28_0, iter_28_1 in pairs(self.eatablesBnt) do
			if iter_28_0 == arg_28_0 then
				iter_28_1:setBright(false)
			else
				iter_28_1:setBright(true)
			end
		end

		if arg_28_0 == var_26_1 + 1 then
			self.sureButton:loadTextures(var_0_16.make.off, var_0_16.make.on, var_0_16.make.on, var_0_9)
			self:initTreeDiagram()

			self.sureButton.nowType = "make"

			self.remindLabel:setVisible(false)
		else
			self.sureButton:loadTextures(var_0_16.feed.off, var_0_16.feed.on, var_0_16.feed.on, var_0_9)
			self:initScorePanel(self.eatablesBnt[arg_28_0].entityid)

			self.sureButton.nowType = self.eatablesBnt[arg_28_0].entityid

			if self.mealType > self.cookType then
				self.remindLabel:setVisible(true)
			end
		end
	end

	self.scrollView:removeAllChildren()
	self.scrollView:setInnerContainerSize(cc.size(var_26_2, self.scrollView:getContentSize().height))
	self.scrollView:setBounceEnabled(true)
	self.scrollView:setClippingEnabled(true)
	self.scrollView:setDirection(2)

	if next(self.eatablelist) ~= nil then
		local var_26_4 = 0

		for iter_26_0 = 1, var_26_1 do
			local var_26_5 = ItemSprite:create(playermodel.items[self.eatablelist[iter_26_0]].entityid)

			var_26_5:setAnchorPoint(cc.p(0.5, 0.5))
			var_26_5:setPosition(cc.p(69 + (iter_26_0 - 1) * 118, self.scrollView:getContentSize().height / 2))
			self.scrollView:addChild(var_26_5)

			local var_26_6 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, "cook/frame1_on.png", "cook/frame1_on.png", var_0_9)

			var_26_6.entityid = playermodel.items[self.eatablelist[iter_26_0]].entityid

			var_26_6:setPosition(var_26_5:getPosition())
			self.scrollView:addChild(var_26_6)

			self.eatablesBnt[#self.eatablesBnt + 1] = var_26_6

			var_26_6:addTouchEventListener(function(arg_29_0, arg_29_1)
				if arg_29_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_29_0:isBright() then
					return
				end

				var_26_3(iter_26_0)
			end)

			if var_26_4 < playermodel.items[self.eatablelist[iter_26_0]].entityid then
				var_26_4 = playermodel.items[self.eatablelist[iter_26_0]].entityid
				var_26_0 = iter_26_0
			end
		end
	end

	local var_26_7 = ccui.Button:create("cook/frame1.png", "cook/frame1_on.png", "cook/frame2_on.png", var_0_9)

	var_26_7:setPosition(cc.p(69 + var_26_1 * 118, self.scrollView:getContentSize().height / 2))
	var_26_7:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_30_0:isBright() then
			return
		end

		var_26_3(#self.eatablesBnt)
	end)
	self.scrollView:addChild(var_26_7)

	self.eatablesBnt[#self.eatablesBnt + 1] = var_26_7
	var_26_0 = arg_26_1 and var_26_0 or 1

	var_26_3(var_26_0)
	self.sureButton:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_31_0:setTouchEnabled(false)

		if arg_31_0.nowType == "make" then
			if cook_manager.cookStage == 2 then
				DormitoryLayer.getInstance():addChild(CookLayer:create(), 99)
				arg_31_0:setTouchEnabled(true)
			else
				for iter_31_0, iter_31_1 in pairs(self.baseFoods) do
					if iter_31_1.num > item_manager:getItemNumber(iter_31_1.id) then
						arg_31_0:setTouchEnabled(true)
						global_ShowBlockWords(L_FOOD_LACK)

						return
					end
				end

				cook_manager:checkReadyCook(self.foodid, self.cookType, self.orderid, self.soulid, function(arg_32_0)
					if arg_32_0 == 1 then
						require("view.Layer.CookLayer")
						DormitoryLayer.getInstance():addChild(CookLayer:create(self.foodid), 100)
					end

					arg_31_0:setTouchEnabled(true)
				end)
			end
		elseif DormitoryLayer.getInstance().soulInfos[DormitoryLayer.getInstance().soul_to_index[self.soulid]].isleave then
			global_ShowBlockWords(L_EAT_NO_FIGHT)
			arg_31_0:setTouchEnabled(true)
		else
			if self.mealType ~= self.cookType then
				if self.mealType > self.cookType and playermodel.diamond < TIMEOUT_FEED_COST then
					LayerManager:pushInLayer("PopGoBuyDiamond", {
						is_need_pop_layer = 0
					})
					arg_31_0:setTouchEnabled(true)

					return
				elseif self.mealType < self.cookType then
					global_ShowBlockWords(L_EAT_TIME_NO_YET)
					arg_31_0:setTouchEnabled(true)

					return
				end
			end

			local var_31_0 = playermodel.items[arg_31_0.nowType].itemid

			cook_manager:feedEatable(arg_31_0.nowType, self.cookType, self.orderid, self.soulid, function(arg_33_0, arg_33_1, arg_33_2)
				if arg_33_0 == 1 then
					if DormitoryLayer.getInstance() then
						local var_33_0
						local var_33_1

						if arg_33_2 < 0 then
							var_33_0 = "hitdown"
							var_33_1 = conversation_class_data[self.soulid * 10000 + 801].conversation1
						elseif arg_33_2 / item_data[var_31_0].favor >= 0.8 then
							var_33_0 = "win"
							var_33_1 = conversation_class_data[self.soulid * 10000 + 601].conversation1
						else
							var_33_0 = "win"
							var_33_1 = conversation_class_data[self.soulid * 10000 + 701].conversation1
						end

						local var_33_2 = role_conversation_data[var_33_1].dec

						DormitoryLayer.getInstance():updateGiftPanel(self.soulid, arg_33_1, arg_33_2)
						DormitoryLayer.getInstance():insertAnimate(self.soulid, var_33_0, var_33_2)
					end

					self:runAction(cc.RemoveSelf:create())
				else
					arg_31_0:setTouchEnabled(true)
				end
			end)
		end
	end)
end
