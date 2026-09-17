local activity_pop_data = require("data.activity_pop_data")

BirthPopBaseLayer = class("BirthPopBaseLayer", function()
	return ActivityPopBaseLayer:createforchild()
end)

local var_0_1 = config._DEBUG and 0 or 1
local var_0_2 = config._DEBUG and "activityresource/activitypop/" or "activityui/activitypop/"
local var_0_3 = "ActivityPop_"
local activity_manager = require("controller.activity_manager")

function BirthPopBaseLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = BirthPopBaseLayer.new()

	var_2_0:initGaussBg(arg_2_1)

	return var_2_0
end

function BirthPopBaseLayer:init(arg_3_1)
	self._id = arg_3_1.id
	self._exitcallback = arg_3_1.exitcallback

	self:loadActivityPopAssets(self._id)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(var_0_2 .. ((config._DEBUG or nil) and (var_0_3 .. "8880829.json" or var_0_3 .. "8880829.ExportJson")))

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 1)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")

	self.rootpanel:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self.rootpanel:setTouchEnabled(true)
	self.showActions.extendVertical(self)
	self.rootLayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			if self._exitcallback then
				self._exitcallback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self:initActivityPopCompnents()
	self:updateUI()
	self:updateUIPos()
end

function BirthPopBaseLayer:updateUI()
	self.rootpanel:loadTexture(var_0_3 .. self._id .. "/bg.png", var_0_1)
	self.btnGoto:loadTextures(var_0_3 .. self._id .. "/btn_goto.png", nil, var_0_3 .. self._id .. "/btn_goto.png", var_0_1)
end

function BirthPopBaseLayer:updateUIPos()
	if not activity_pop_data[self._id] then
		return
	end

	if not activity_pop_data[self._id].go_btn_pos then
		return
	end

	local var_7_0, var_7_1 = activity_pop_data[self._id].go_btn_pos:match("([^,]+),(.+)")

	self.btnGoto:setPosition(var_7_0, var_7_1)
end
