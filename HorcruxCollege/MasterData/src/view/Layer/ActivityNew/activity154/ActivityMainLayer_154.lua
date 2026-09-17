local ActivityMainLayer_154 = class("ActivityMainLayer_154", function(...)
	return ActivityMainLayerBaseLayer:create(...)
end)
local activity_manager = require("controller.activity_manager")
local explore_manager = require("controller.explore_manager")
local time_check_manager = require("controller.time_check_manager")

function ActivityMainLayer_154:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_154.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther()

	return var_2_0
end

function ActivityMainLayer_154:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_154:initOther()
	self.btnRoulette:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		goto_complete_system({
			jump_to_system = "2700163"
		})
	end)

	if time_check_manager:getCurTime() < global_get_time_by_date("2021-02-01 20:00:00") then
		self.btnWar:loadTextures("activitiesRes/activity154/main/btn_war_2.png", nil, "activitiesRes/activity154/main/btn_war_2.png")
	end
end

function ActivityMainLayer_154:playOutEffect(arg_6_1)
	self:stopAllActions()

	if self.effecticon then
		self.effecticon:setVisible(false)
	end

	local var_6_0 = 0.1

	self.btnReturn:runAction(cc.Sequence:create(cc.MoveBy:create(var_6_0 * 3 / 4, cc.p(50, 0)), cc.MoveBy:create(var_6_0 / 4, cc.p(-250, 0)), cc.CallFunc:create(function()
		if arg_6_1 then
			arg_6_1()
		end
	end)))

	local var_6_1 = {}

	for iter_6_0, iter_6_1 in pairs((require("data.activity_main.uiconfig.activity_main_uiconfig_" .. self.id .. "_data"))) do
		if self[iter_6_0] then
			table.insert(var_6_1, {
				name = iter_6_0,
				posy = self[iter_6_0]:getPositionY()
			})
		end
	end

	table.sort(var_6_1, function(arg_8_0, arg_8_1)
		return arg_8_0.posy > arg_8_1.posy
	end)

	for iter_6_2, iter_6_3 in pairs(var_6_1) do
		self[iter_6_3.name]:setOpacity(255)
		self[iter_6_3.name]:runAction(cc.Sequence:create(cc.DelayTime:create(iter_6_2 / #var_6_1 * (var_6_0 + 0.3) / 2), cc.FadeOut:create((var_6_0 + 0.3) / 2)))
	end
end

local function var_0_5(arg_9_0, arg_9_1)
	return cc.Sequence:create(cc.EaseOut:create(cc.FadeOut:create(arg_9_0 / arg_9_1 / 2), arg_9_0 / arg_9_1 / 2 * 0.7), cc.EaseIn:create(cc.FadeIn:create(arg_9_0 / arg_9_1 / 2), arg_9_0 / arg_9_1 / 2 * 0.7))
end

function ActivityMainLayer_154:playInEffect(arg_10_1)
	local var_10_0 = self.btnReturn:getPositionX()

	self.btnReturn:setPositionX(700)
	self.btnReturn:runAction(cc.Sequence:create(cc.MoveTo:create(0.2 * 2 / 3, cc.p(var_10_0 - 10, self.btnReturn:getPositionY())), cc.MoveTo:create(0.2 * 1 / 6, cc.p(var_10_0 + 10, self.btnReturn:getPositionY())), cc.MoveTo:create(0.2 * 1 / 6, cc.p(var_10_0, self.btnReturn:getPositionY())), cc.CallFunc:create(function()
		if arg_10_1 then
			arg_10_1()
		end
	end)))

	for iter_10_0, iter_10_1 in pairs({
		{
			self.btnCollect,
			0.78,
			3
		},
		{
			self.btnWar,
			0.9099999999999999,
			3
		},
		{
			self.btnLevel,
			0.65,
			3
		},
		{
			self.btnRandfight,
			1.04,
			2
		},
		{
			self.btnTwist,
			1.04,
			2
		},
		{
			self.btnShop,
			0.9880000000000001,
			3
		},
		{
			self.btnBp,
			0.9880000000000001,
			3
		},
		{
			self.btnFlop,
			0.65,
			3
		},
		{
			self.btnTotalTask,
			0.78,
			3
		},
		{
			self.btnRecharge,
			0.9099999999999999,
			3
		}
	}) do
		local var_10_1 = iter_10_1[2] or math.random(85, 100) / 100
		local var_10_2 = iter_10_1[3] or math.random(2, 3)
		local var_10_3 = 0

		if var_10_2 == 3 then
			iter_10_1[1]:runAction(cc.Sequence:create(cc.DelayTime:create(var_10_3), var_0_5(var_10_1, var_10_2), var_0_5(var_10_1, var_10_2), var_0_5(var_10_1, var_10_2)))
		else
			iter_10_1[1]:runAction(cc.Sequence:create(cc.DelayTime:create(var_10_3), var_0_5(var_10_1, var_10_2), var_0_5(var_10_1, var_10_2)))
		end
	end

	local function var_10_4()
		local var_12_0 = ccui.ImageView:create()

		var_12_0:loadTexture("activitiesRes/activity154/main/btn_role.png")
		var_12_0:setOpacity(0)
		var_12_0:setName("effect_icon")
		var_12_0:setPosition(self.btnRole:getPositionX(), self.btnRole:getPositionY())
		self.rootLayer:addChild(var_12_0, 3)

		self.effecticon = var_12_0

		var_12_0:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.3), (cc.EaseIn:create(cc.MoveBy:create(0.3, cc.p(0, 0)), 2.5))), cc.CallFunc:create(function()
			self.btnRole:setVisible(true)
		end), cc.Spawn:create(cc.ScaleTo:create(0.5, self.btnRole:getScale() * 1.03), cc.FadeOut:create(0.5)), (cc.CallFunc:create(function()
			self:removeChild(var_12_0)

			self.effecticon = nil
		end))))
	end

	self:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
		var_10_4()
	end), cc.DelayTime:create(10))))
end

return ActivityMainLayer_154
