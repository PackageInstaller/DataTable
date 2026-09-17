ChangeFigureLayer = class("ChangeFigureLayer", function()
	return cc.Layer:create()
end)

local playermodel = require("model.playermodel")
local var_0_1
local var_0_2

function ChangeFigureLayer.create(arg_2_0)
	local var_2_0 = ChangeFigureLayer.new()

	var_2_0:init()

	return var_2_0
end

function ChangeFigureLayer:init(arg_3_1)
	self.outTouchCallFunc = nil
	self.itemsList = {}
	var_0_1 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "change_figure.json" or "change_figure.Exportson")

	self:addChild(var_0_1)

	var_0_2 = ccui.Helper:seekWidgetByName(var_0_1, "Panel_revise_photo")

	var_0_2:setVisible(true)
	var_0_2:setTouchEnabled(true)
	var_0_2:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:runAction(cc.RemoveSelf:create())
	end)
	ccui.Helper:seekWidgetByName(var_0_1, "Panel_revise_name"):setVisible(false)
	ccui.Helper:seekWidgetByName(changeNicknameLayer, "Panel_revise_array"):setVisible(false)
	ccui.Helper:seekWidgetByName(changeNicknameLayer, "Panel_revise_saying"):setVisible(false)
	self:initHeadsList()
	self:initTitle()

	return true
end

function ChangeFigureLayer.addTouchEventListener(arg_5_0, arg_5_1)
	var_0_2:addTouchEventListener(arg_5_1)
end

function ChangeFigureLayer:setSelectedIDs(arg_6_1)
	self.selectedIDs = arg_6_1

	local var_6_0 = ccui.Helper:seekWidgetByName(var_0_2, "listview"):getItems()

	for iter_6_0, iter_6_1 in pairs(self.itemsList) do
		iter_6_1:getChildByName("selected"):setVisible(false)
	end

	for iter_6_2, iter_6_3 in pairs(self.selectedIDs) do
		if self.itemsList[iter_6_3] then
			self.itemsList[iter_6_3]:getChildByName("selected"):setVisible(true)
		end
	end
end

function ChangeFigureLayer:initHeadsList()
	local var_7_0 = ccui.Helper:seekWidgetByName(var_0_2, "listview")
	local var_7_1 = var_7_0:getChildByName("panelhead_exp")
	local var_7_2 = 1
	local var_7_3

	for iter_7_0, iter_7_1 in pairs(playermodel.haveSuit) do
		if iter_7_1 then
			if var_7_2 == 1 then
				var_7_3 = var_7_1:clone()

				var_7_3:removeFromParent()
				var_7_0:pushBackCustomItem(var_7_3)
			end

			local var_7_4 = ccui.Helper:seekWidgetByName(var_7_3, "figure_" .. var_7_2)

			var_7_4:loadTexture("role/head_" .. iter_7_0 .. ".png")
			var_7_4:setVisible(true)
			var_7_4:addTouchEventListener(function(arg_8_0, arg_8_1)
				if ccui.TouchEventType.ended == arg_8_1 and self.outTouchCallFunc then
					self:outTouchCallFunc(iter_7_0)
				end
			end)

			self.itemsList[iter_7_0] = var_7_4
			var_7_2 = var_7_2 + 1

			if var_7_2 > 4 then
				var_7_2 = 1
			end
		end
	end

	var_7_0:removeItem(0)

	return true
end

function ChangeFigureLayer.initTitle(arg_9_0)
	local var_9_0 = ccui.Helper:seekWidgetByName(var_0_2, "listview")

	ccui.Helper:seekWidgetByName(var_9_0:getParent(), "title"):setString(L_CHANGE_FIGURE_MSG.Title)
	ccui.Helper:seekWidgetByName(var_9_0:getParent(), "des"):setString(L_CHANGE_FIGURE_MSG.Des)
end
