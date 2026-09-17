local ActivityMainLayer_151 = class("ActivityMainLayer_151", function(...)
	return ActivityMainLayerBaseLayer:create(...)
end)
local activity_manager = require("controller.activity_manager")
local explore_manager = require("controller.explore_manager")

function ActivityMainLayer_151:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_151.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()

	return var_2_0
end

function ActivityMainLayer_151:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_151:initOther()
	return
end

function ActivityMainLayer_151:playOutEffect(arg_5_1)
	self.btnReturn:runAction(cc.Sequence:create(cc.MoveBy:create(0.1 * 3 / 4, cc.p(50, 0)), cc.MoveBy:create(0.1 / 4, cc.p(-250, 0)), cc.CallFunc:create(function()
		if arg_5_1 then
			arg_5_1()
		end
	end)))

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs((require("data.activity_main.uiconfig.activity_main_uiconfig_" .. self.id .. "_data"))) do
		if self[iter_5_0] then
			table.insert(var_5_0, {
				name = iter_5_0,
				posy = self[iter_5_0]:getPositionY()
			})
		end
	end

	table.sort(var_5_0, function(arg_7_0, arg_7_1)
		return arg_7_0.posy > arg_7_1.posy
	end)

	for iter_5_2, iter_5_3 in pairs(var_5_0) do
		self[iter_5_3.name]:setOpacity(255)
		self[iter_5_3.name]:runAction(cc.Sequence:create(cc.DelayTime:create(iter_5_2 / #var_5_0 * (0.1 + 0.3) / 2), cc.FadeOut:create((0.1 + 0.3) / 2)))
	end
end

function ActivityMainLayer_151:playInEffect(arg_8_1)
	local var_8_0 = self.btnReturn:getPositionX()

	self.btnReturn:setPositionX(700)
	self.btnReturn:runAction(cc.Sequence:create(cc.MoveTo:create(0.2 * 2 / 3, cc.p(var_8_0 - 10, self.btnReturn:getPositionY())), cc.MoveTo:create(0.2 * 1 / 6, cc.p(var_8_0 + 10, self.btnReturn:getPositionY())), cc.MoveTo:create(0.2 * 1 / 6, cc.p(var_8_0, self.btnReturn:getPositionY())), cc.CallFunc:create(function()
		if arg_8_1 then
			arg_8_1()
		end
	end)))

	local var_8_1 = require("data.activity_main.uiconfig.activity_main_uiconfig_" .. self.id .. "_data")
	local var_8_2 = {}

	for iter_8_0, iter_8_1 in pairs(var_8_1) do
		if self[iter_8_0] then
			table.insert(var_8_2, {
				name = iter_8_0,
				posy = self[iter_8_0]:getPositionY()
			})
		end
	end

	table.sort(var_8_2, function(arg_10_0, arg_10_1)
		return arg_10_0.posy < arg_10_1.posy
	end)

	for iter_8_2, iter_8_3 in pairs(var_8_2) do
		local var_8_3 = var_8_1[iter_8_3.name].action

		self[iter_8_3.name]:setOpacity(0)
		self[iter_8_3.name]:runAction(cc.Sequence:create(cc.DelayTime:create(iter_8_2 / #var_8_2 * (0.2 * 2) / 2), cc.FadeIn:create(0.2 * 2 / 2), cc.CallFunc:create(function(...)
			if var_8_3 then
				self[iter_8_3.name]:runAction((self:createActionobj(var_8_3)))
			end
		end)))
	end
end

return ActivityMainLayer_151
