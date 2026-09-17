PopAdventureInfiniteUpLayer = class("PopAdventureInfiniteUpLayer", function()
	return PopBaseLayer:create()
end)

function PopAdventureInfiniteUpLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopAdventureInfiniteUpLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

require("view.Sprite.ItemSprite")

local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local network = require("network.network")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")

function PopAdventureInfiniteUpLayer:init(arg_3_1)
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopAdventureInfiniteUpLayer.json" or "PopAdventureInfiniteUpLayer.ExportJson")

	self:addChild(self.rootlayer)
	self.rootlayer:setLocalZOrder(999)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_bottom")

	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2)

	self.panelback = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_back")

	self.panelback:setTouchEnabled(false)

	self.uplist = arg_3_1.uplist or {}

	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if arg_3_1 and arg_3_1.callback then
				arg_3_1.callback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 180)
	self.showActions.extendVertical(self)
	self:initElementText()
	self:initUplistNew()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			-- block empty
		end
	end)
end

function PopAdventureInfiniteUpLayer:initElementText()
	local var_7_0 = ccui.Helper:seekWidgetByName(self.rootpanel, "Label_8"):setString(L_ADVENTURE_INFINITE_LAYER.roleuptitle)
	local var_7_1 = ccui.Helper:seekWidgetByName(self.rootpanel, "Label_9"):setString(L_ADVENTURE_INFINITE_LAYER.roleupscore)
	local var_7_2 = ccui.Helper:seekWidgetByName(self.rootpanel, "Label_9_0"):setString(L_ADVENTURE_INFINITE_LAYER.tips1)

	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_score50"):getChildByName("Label_14"):setString(string.format(L_ADVENTURE_INFINITE_LAYER.tips2, 10) .. "%")
	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_score30"):getChildByName("Label_14"):setString(string.format(L_ADVENTURE_INFINITE_LAYER.tips2, 10) .. "%")
end

function PopAdventureInfiniteUpLayer:initUplist()
	local var_8_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_role_up")
	local var_8_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "ScrollView_scoreup")
	local var_8_2 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_score30")
	local var_8_3 = {}
	local var_8_4 = {}

	for iter_8_0, iter_8_1 in pairs(self.uplist) do
		if iter_8_1.up == "0.5" then
			var_8_3[#var_8_3 + 1] = iter_8_1.servantid
		else
			var_8_4[#var_8_4 + 1] = iter_8_1.servantid
		end
	end

	local var_8_5 = (math.ceil(#var_8_3 / 3) - 1) * 200 + (math.ceil(#var_8_4 / 3) - 1) * 200

	var_8_1:setContentSize(cc.size(545, 600))
	var_8_1:setClippingEnabled(true)
	var_8_1:setInnerContainerSize(cc.size(545, 600 + var_8_5))

	local var_8_6 = 0

	if #var_8_3 > 0 then
		ccui.Helper:seekWidgetByName(self.rootlayer, "Image_score50"):setPosition(cc.p(275, var_8_5 + 565 + var_8_6 * 200))
	end

	for iter_8_2 = 1, math.ceil(#var_8_3 / 3) do
		local var_8_8 = var_8_0:clone()
		local var_8_9 = var_8_8:getChildByName("Panel_role")

		var_8_9:setVisible(false)

		local var_8_10 = 0

		for iter_8_3 = 1, 3 do
			if not var_8_3[iter_8_3 + (iter_8_2 - 1) * 3] then
				break
			end

			local var_8_11 = var_8_9:clone()
			local var_8_12 = ccui.Helper:seekWidgetByName(var_8_11, "Label_role_name")
			local var_8_13 = ccui.Helper:seekWidgetByName(var_8_11, "Image_role")

			var_8_12:setString(servant_data[var_8_3[iter_8_3 + (iter_8_2 - 1) * 3]].name)
			var_8_13:loadTexture("role1/" .. model_data[servant_data[var_8_3[iter_8_3 + (iter_8_2 - 1) * 3]].modelid].cute_role .. ".png")
			var_8_11:setPosition(cc.p(var_8_10, 0))

			var_8_10 = var_8_10 + 170

			var_8_8:addChild(var_8_11, 99)
			var_8_11:setVisible(true)
		end

		var_8_8:setPosition(cc.p(20, var_8_5 + 320 - (iter_8_2 - 1) * 200))
		var_8_8:setName("panel_role_up_clone" .. iter_8_2)

		var_8_6 = var_8_6 - 1 > 0 and var_8_6 - 1 or 0

		var_8_1:addChild(var_8_8, 99)
	end

	if #var_8_3 > 0 and #var_8_4 > 0 then
		var_8_2:setPosition(cc.p(275, var_8_5 + 270 - (math.ceil(#var_8_3 / 3) - 1) * 200))
	end

	if #var_8_3 == 0 and #var_8_4 > 0 then
		var_8_2:setPosition(cc.p(275, var_8_5 + 565 + var_8_6 * 200))
	end

	for iter_8_4 = 1, math.ceil(#var_8_4 / 3) do
		local var_8_15 = var_8_0:clone()
		local var_8_16 = var_8_15:getChildByName("Panel_role")

		for iter_8_5 = 1, 3 do
			if not var_8_4[iter_8_5 + (iter_8_4 - 1) * 3] then
				break
			end

			local var_8_17 = var_8_16:clone()
			local var_8_18 = ccui.Helper:seekWidgetByName(var_8_17, "Label_role_name")
			local var_8_19 = ccui.Helper:seekWidgetByName(var_8_17, "Image_role")

			var_8_18:setString(servant_data[var_8_4[iter_8_5 + (iter_8_4 - 1) * 3]].name)
			var_8_19:loadTexture("role1/" .. model_data[servant_data[var_8_4[iter_8_5 + (iter_8_4 - 1) * 3]].modelid].cute_role .. ".png")
			var_8_17:setPosition(cc.p(0, 0))
			var_8_15:addChild(var_8_17, 99)
			var_8_17:setVisible(true)
		end

		var_8_15:setPosition(cc.p(20, 25 + var_8_6 * 200))

		var_8_6 = var_8_6 - 1 ~= 0 and var_8_6 - 1 or 0

		var_8_1:addChild(var_8_15, 99)
	end
end

function PopAdventureInfiniteUpLayer:initUplistNew()
	local var_9_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "ScrollView_scoreup")
	local var_9_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_role_up")
	local var_9_2 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_role")
	local var_9_3 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_score50")
	local var_9_4 = {}
	local var_9_5 = {}

	var_9_2:setVisible(false)

	local function var_9_6(arg_10_0)
		local var_10_0 = 0

		if not arg_10_0 then
			total = 0
		end

		for iter_10_0, iter_10_1 in pairs(arg_10_0) do
			var_10_0 = var_10_0 + 1
		end

		return var_10_0
	end

	for iter_9_0, iter_9_1 in pairs(self.uplist) do
		if var_9_4[iter_9_1.up] then
			table.insert(var_9_4[iter_9_1.up], iter_9_1.servantid)
		else
			var_9_4[iter_9_1.up] = {
				iter_9_1.servantid
			}

			table.insert(var_9_5, tonumber(iter_9_1.up))
		end
	end

	table.sort(var_9_5, function(arg_11_0, arg_11_1)
		return arg_11_1 < arg_11_0
	end)

	if not next(var_9_5) then
		return
	end

	local var_9_7 = 0

	for iter_9_2, iter_9_3 in ipairs(var_9_5) do
		var_9_7 = math.ceil(var_9_6(var_9_4[tostring(iter_9_3)]) / 3 - 1) * 200 + var_9_7 + 130
	end

	var_9_0:setContentSize(cc.size(545, 600))
	var_9_0:setClippingEnabled(true)
	var_9_0:setInnerContainerSize(cc.size(545, 600 + var_9_7))

	local var_9_8 = 0

	for iter_9_4, iter_9_5 in ipairs(var_9_5) do
		local var_9_10 = var_9_3:clone()

		var_9_10:getChildByName("Label_14"):setString(string.format(L_ADVENTURE_INFINITE_LAYER.tips2, iter_9_5 * 100) .. "%")
		var_9_10:setVisible(true)
		var_9_10:setName("listindex_" .. iter_9_4)

		if iter_9_4 == 1 then
			var_9_10:setPosition(cc.p(275, 600 + var_9_7 - 22))
		else
			var_9_10:setPosition(cc.p(275, var_9_0:getChildByName("panel_role_up_clone_" .. iter_9_4 - 1 .. math.ceil(var_9_6(var_9_4[tostring(var_9_5[iter_9_4 - 1])]) / 3)):getPositionY() - 22))
		end

		var_9_0:addChild(var_9_10, 99)

		for iter_9_6 = 1, math.ceil(var_9_6(var_9_4[tostring(iter_9_5)]) / 3) do
			local var_9_12 = var_9_1:clone()

			for iter_9_7 = 1, 3 do
				if not var_9_4[tostring(iter_9_5)][iter_9_7 + (iter_9_6 - 1) * 3] then
					break
				end

				local var_9_13 = var_9_4[tostring(iter_9_5)][iter_9_7 + (iter_9_6 - 1) * 3]

				if not var_9_13 then
					break
				end

				local var_9_14 = var_9_2:clone()
				local var_9_15 = ccui.Helper:seekWidgetByName(var_9_14, "Image_role")

				ccui.Helper:seekWidgetByName(var_9_14, "Label_role_name"):setString(servant_data[var_9_13].name)
				var_9_15:loadTexture("role1/" .. model_data[servant_data[var_9_13].modelid].cute_role .. ".png")
				var_9_14:setPosition(cc.p(0, 0))
				var_9_12:addChild(var_9_14, 99)
				var_9_14:setVisible(true)
			end

			var_9_12:setPosition(cc.p(20, var_9_0:getChildByName("listindex_" .. iter_9_4):getPositionY() - 50 - iter_9_6 * 200))
			var_9_12:setName("panel_role_up_clone_" .. iter_9_4 .. iter_9_6)

			var_9_8 = var_9_8 - 1 > 0 and var_9_8 - 1 or 0

			var_9_0:addChild(var_9_12, 99)
		end
	end
end
