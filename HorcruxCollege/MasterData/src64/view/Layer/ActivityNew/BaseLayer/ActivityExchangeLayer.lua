ActivityExchangeLayer = class("ActivityExchangeLayer", function()
	return cc.Layer:create()
end)

local item_data = require("data.item_data")
local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")
local component_manager = require("controller.component_manager")

local function var_0_5(arg_2_0)
	for iter_2_0 = 1, 6 do
		if not arg_2_0[iter_2_0] or not arg_2_0[iter_2_0].itemid then
			return false
		end
	end

	return true
end

function ActivityExchangeLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = ActivityExchangeLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function ActivityExchangeLayer:init(arg_4_1)
	self.activityId = arg_4_1.activityId
	self.layerName = "ActivityExchangeLayer_" .. self.activityId

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.bg = ccui.ImageView:create("mainScenebg/" .. self.layerName .. ".png")

	self.bg:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.bg, -1)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)

	self.exchangeList = {}

	self:initUI()
	self:fullScreen()
	self:registerActivityEventListener()
	activity_manager:get_activity_exchange_data(self.activityId)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)
			TextureManager:removeLayerTextures({
				self.layerName
			})
		end
	end)
end

function ActivityExchangeLayer:initUI()
	self.btnReturn = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_return")

	self.btnReturn:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self.title = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_4")

	self.title:setTouchEnabled(true)
	self.title:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityExchangeLayer_" .. self.activityId
		})
	end)

	self.exchangeBg = ccui.Helper:seekWidgetByName(self.rootLayer, "exchange_bg")
	self.lessLbl = self.exchangeBg:getChildByName("des")
	self.btnExchange = self.exchangeBg:getChildByName("exchange")

	self.btnExchange:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_0_5(self.exchangeList) then
			global_ShowBlockWords(L_EXPLORE_EVENT_RESULT_ERROR[2])

			return
		end

		activity_manager:activity_exchange_reward(self.activityId, self.exchangeList)
	end)

	for iter_6_0 = 1, 6 do
		self.exchangeList[iter_6_0] = {
			itemnum = 0
		}

		local var_6_0 = self.exchangeBg:getChildByName("ex" .. iter_6_0)

		var_6_0:getChildByName("+"):setVisible(false)
		var_6_0:getChildByName("+"):addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self.exchangeList[iter_6_0].itemid then
				return
			end

			self.exchangeList[iter_6_0].itemnum = math.min(self.exchangeList[iter_6_0].itemnum + 1, self:getItemMaxAddNum(self.exchangeList[iter_6_0].itemid, iter_6_0))

			var_6_0:getChildByName("num"):setString(self.exchangeList[iter_6_0].itemnum)
		end)
		var_6_0:getChildByName("-"):setVisible(false)
		var_6_0:getChildByName("-"):addTouchEventListener(function(arg_11_0, arg_11_1)
			if arg_11_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self.exchangeList[iter_6_0].itemid then
				return
			end

			self.exchangeList[iter_6_0].itemnum = math.max(self.exchangeList[iter_6_0].itemnum - 1, 1)

			var_6_0:getChildByName("num"):setString(self.exchangeList[iter_6_0].itemnum)
		end)
		var_6_0:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_12_0 = {}

			for iter_12_0, iter_12_1 in pairs(self.exchangeList) do
				if iter_12_1.entityid then
					var_12_0[iter_12_1.entityid] = true
				end
			end

			LayerManager:pushInLayer("BagLayerNew", {
				selectType = "ActivityExchange",
				bagType = 1,
				hideItem = var_12_0,
				exitCallback = function(arg_13_0, arg_13_1)
					if not self:checkCanUse(arg_13_1, arg_13_0, iter_6_0) then
						return
					end

					self.exchangeList[iter_6_0] = {
						itemnum = 1,
						entityid = arg_13_0,
						itemid = arg_13_1
					}

					local var_13_0 = string.format("equipment/%s.png", item_data[arg_13_1].image_id)

					var_6_0:getChildByName("item"):setVisible(false)

					if var_6_0:getChildByName("spriteIcon") then
						var_6_0:getChildByName("spriteIcon"):removeFromParent()
					end

					local var_13_1 = component_manager:create_component_icon(arg_13_0)

					var_13_1:setName("spriteIcon")
					var_13_1:setPosition(var_6_0:getContentSize().width / 2, var_6_0:getContentSize().height / 2)
					var_6_0:addChild(var_13_1)
					var_6_0:getChildByName("num"):setString(self.exchangeList[iter_6_0].itemnum)
				end
			})
		end)
	end
end

function ActivityExchangeLayer:getItemMaxAddNum(arg_14_1, arg_14_2)
	local var_14_0 = item_manager:getItemNumber(arg_14_1)

	for iter_14_0 = 1, 6 do
		if iter_14_0 ~= arg_14_2 and self.exchangeList[iter_14_0].itemid == arg_14_1 then
			var_14_0 = var_14_0 - self.exchangeList[iter_14_0].itemnum
		end
	end

	return var_14_0
end

function ActivityExchangeLayer:checkCanUse(arg_15_1, arg_15_2)
	if item_data[arg_15_1].bag_item_type ~= kITEM_COMPONENT then
		global_ShowBlockWords(L_ACTIVITY_EXCHAGE_ERROR[1])

		return false
	end

	local var_15_0 = item_manager:getItemNumber(arg_15_1)

	for iter_15_0 = 1, 6 do
		if self.exchangeList[iter_15_0].entityid == arg_15_2 then
			global_ShowBlockWords(L_ACTIVITY_EXCHAGE_ERROR[3])

			return false
		end

		if self.exchangeList[iter_15_0].itemid == arg_15_1 then
			var_15_0 = var_15_0 - self.exchangeList[iter_15_0].itemnum
		end
	end

	if var_15_0 < 1 then
		global_ShowBlockWords(L_ACTIVITY_EXCHAGE_ERROR[2])

		return false
	end

	return true
end

function ActivityExchangeLayer:fullScreen()
	self.btnReturn:setPositionY(self.btnReturn:getPositionY() - GameDisplay.fix_y)
	self.title:setPositionY(self.title:getPositionY() + GameDisplay.fix_y)
end

function ActivityExchangeLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.EXCHANGE_INFO_UPDATE, function(arg_18_0)
		self.lessTime = arg_18_0.lesstime

		self:upDateUI()
	end)
end

function ActivityExchangeLayer:upDateUI()
	self.lessLbl:setString(L_ACTIVITY_EXCHAGE)

	for iter_19_0 = 1, 6 do
		local var_19_0 = self.exchangeBg:getChildByName("ex" .. iter_19_0)

		var_19_0:getChildByName("num"):setString(0)
		var_19_0:getChildByName("item"):setVisible(true)

		self.exchangeList[iter_19_0] = {
			itemnum = 0
		}

		if var_19_0:getChildByName("spriteIcon") then
			var_19_0:getChildByName("spriteIcon"):removeFromParent()
		end
	end
end
