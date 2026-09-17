PopScoreArenaDetailPage = class("PopScoreArenaDetailPage", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")

local arenaawardsnew_data = require("data.arenaawardsnew_data")
local level_manager = require("controller.level_manager")

function PopScoreArenaDetailPage.create(arg_2_0)
	local var_2_0 = PopScoreArenaDetailPage.new()

	var_2_0:initBg()

	return var_2_0
end

function PopScoreArenaDetailPage:init()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ArenaDetailPage.json" or "ArenaDetailPage.ExportJson")

	self:addChild(self.rootLayer, 2)
	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_1")

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 + 64)

	self.surebtn = ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure")
	self.scrollpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView_73")
	self.label1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_74")
	self.labelRE = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_re")
	self.labelCE = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_class")
	self.des = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_8")

	global_window_open_action(self.rootpanel)

	local function var_3_0()
		LayerManager:removePopLayer(self.__queueindex)
	end

	local function var_3_1(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_window_close_action(self.rootpanel, var_3_0)
	end

	self:createFullScreenMask(var_3_1, 120)

	self.Panel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_74")

	self.scrollpanel:setInnerContainerSize(cc.size(476, self.Panel:getContentSize().height + 100))
	self.Panel:setPosition(cc.p(0, 100))
	self.surebtn:addTouchEventListener(var_3_1)
	self.des:setString(L_SCORE_AREAM_DETAIL_1)
	self.labelRE:setString(L_SCORE_AREAM_DETAIL_2)
	self.labelCE:setString(L_SCORE_AREAM_DETAIL_4)

	for iter_3_0 = 1, 5 do
		self.labelRE:getChildByName("Label_" .. iter_3_0):setString(L_SCORE_AREAM_DETAIL_3[iter_3_0])
	end

	for iter_3_1 = 1, 5 do
		local var_3_2 = self.labelCE:getChildByName("Label_" .. iter_3_1)

		var_3_2:setString(L_SCORE_AREAM_DETAIL_5[iter_3_1])
		var_3_2:getChildByName("lbl"):setString(L_SCORE_AREAM_DETAIL_6[iter_3_1])
	end

	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" and callback then
			callback()
		end
	end)
end

function PopScoreArenaDetailPage:initscrollPanel()
	local var_7_0 = {}

	self.label1:setPosition(cc.p(0, 0))

	local var_7_3 = self.scrollpanel:getContentSize()

	self.scrollpanel:setContentSize(var_7_3)
	self.scrollpanel:setInnerContainerSize(cc.size(var_7_3.width, self.label1:getContentSize().height + #arenaawardsnew_data * 50))
	self.label1:setPositionY(250)

	for iter_7_0, iter_7_1 in ipairs(arenaawardsnew_data) do
		var_7_0[iter_7_0] = L_SCORE_AREAN_AWARD_DATA[1] .. iter_7_1.diamond .. L_DIAMOND .. " + " .. iter_7_1.honor .. L_SCORE_AREAN_AWARD_DATA[3]
	end
end

function PopScoreArenaDetailPage:initBg()
	local var_8_0 = ccui.Layout:create()

	var_8_0:setTouchEnabled(true)
	var_8_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_8_0:setAnchorPoint(cc.p(0, 0))
	var_8_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_8_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_8_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_8_0:setOpacity(0)
	var_8_0:setCascadeOpacityEnabled(false)
	self:addChild(var_8_0, -1)

	local var_8_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_8_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_8_1:setPositionX(var_8_0:getContentSize().width / 2)
	var_8_1:setPositionY(var_8_0:getContentSize().height / 2)
	var_8_0:addChild(var_8_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_9_0)
		self:addChild(arg_9_0, -2)
		arg_9_0:setPositionY(arg_9_0:getPositionY() - GameDisplay.fix_y)
		self:init(msg, initInfo)
		var_8_0:setOpacity(102)
		var_8_0:setTouchEnabled(false)
	end)
end

function PopScoreArenaDetailPage:exit()
	self.hideActions.shrinkBoth(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

return PopScoreArenaDetailPage
