NoviceJumpLayer = class("NoviceJumpLayer", function()
	return cc.Layer:create()
end)

local time_check_manager = require("controller.time_check_manager")
local activity_return_manager = require("controller.activity_return_manager")
local var_0_2 = require("controller.activity_return_manager")
local activity_manager = require("controller.activity_manager")
local playermodel = require("model.playermodel")
local var_0_5 = config._DEBUG and 0 or 1

local function var_0_6(arg_2_0)
	if arg_2_0 >= 86400 then
		return string.format(L_TIME_TEXT[1], math.floor(arg_2_0 / 86400), math.floor(arg_2_0 % 86400 / 3600))
	elseif arg_2_0 >= 3600 then
		return string.format(L_TIME_TEXT[2], math.floor(arg_2_0 / 3600), math.floor(arg_2_0 % 3600 / 60))
	else
		return string.format(L_TIME_TEXT[4], math.floor(arg_2_0 / 60), math.floor(arg_2_0 % 60))
	end
end

function NoviceJumpLayer.create(arg_3_0, ...)
	local var_3_0 = NoviceJumpLayer.new()

	var_3_0:init(...)

	return var_3_0
end

function NoviceJumpLayer:init(...)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			activity_manager:releaseEventListenerByName("NoviceJumpLayer")
		end
	end)
end

local var_0_7 = {
	{
		x = 320,
		y = 800 + GameDisplay.fix_y + GameDisplay.fix_y / 4
	},
	{
		x = 320,
		y = 480 + GameDisplay.fix_y
	},
	{
		x = 320,
		y = 160 + GameDisplay.fix_y - GameDisplay.fix_y / 4
	}
}

function NoviceJumpLayer:initUI(...)
	local var_6_0 = ccui.ImageView:create("NoviceJumpLayer/title.png", var_0_5)

	var_6_0:setPosition(cc.p(320, 990 + GameDisplay.fix_y + GameDisplay.fix_y / 2))
	self.rootLayer:addChild(var_6_0)

	local var_6_1 = 1

	activity_return_manager:get_game_buffs(function()
		for iter_7_0, iter_7_1 in pairs(var_0_2:get_buffs() or {}) do
			if iter_7_1.id == 3 and iter_7_1.time then
				local var_7_0 = time_check_manager:getCurTime()

				if iter_7_1.time - var_7_0 > 0 then
					local function var_7_1(arg_8_0, arg_8_1)
						if arg_8_1 ~= ccui.TouchEventType.ended then
							return
						end

						LayerManager:switchShowLayer("FightLayer")
					end

					local var_7_2 = ccui.ImageView:create("NoviceJumpLayer/1.png", var_0_5)

					var_7_2:setTouchEnabled(true)
					var_7_2:setPosition(var_0_7[var_6_1])
					var_7_2:addTouchEventListener(var_7_1)
					self.rootLayer:addChild(var_7_2)

					local var_7_3 = ccui.ImageView:create("NoviceJumpLayer/btn_1.png", var_0_5)

					var_7_3:setPositionX(488)
					var_7_3:setPositionY(24)
					var_7_2:addChild(var_7_3)

					local var_7_4 = ccui.ImageView:create("NoviceJumpLayer/timebg.png", var_0_5)

					var_7_4:setPosition(cc.p(522, 264))
					var_7_2:addChild(var_7_4)

					local var_7_5 = cc.Label:createWithTTF(L_TIME_TWO, FONT_W5, 16)

					var_7_5:setColor(cc.c3b(244, 230, 255))
					var_7_5:setPositionX(110)
					var_7_5:setPositionY(var_7_4:getContentSize().height / 2)
					var_7_4:addChild(var_7_5)
					var_7_5:setString(L_LEFT_TIME_SPACE .. var_0_6(iter_7_1.time - var_7_0))

					var_6_1 = var_6_1 + 1
				end
			end
		end

		local var_7_6 = RoleDefault:getInstance():getIntegerForKey("twistType2_remain_count", 30)
		local var_7_11 = playermodel.create_time + 2592000 - time_check_manager:getCurTime()

		if not playermodel.newbee_card_finishtime and var_7_11 > 0 then
			local var_7_12 = ccui.ImageView:create("NoviceJumpLayer/3.png", var_0_5)

			var_7_12:setTouchEnabled(true)
			var_7_12:setPosition(var_0_7[var_6_1])
			var_7_12:addTouchEventListener(function(arg_10_0, arg_10_1)
				if arg_10_1 ~= ccui.TouchEventType.ended then
					return
				end

				LayerManager:switchShowLayer("SupermarketLayer", {
					tab = 3
				})
			end)
			self.rootLayer:addChild(var_7_12)

			local var_7_13 = ccui.ImageView:create("NoviceJumpLayer/btn_3.png", var_0_5)

			var_7_13:setPositionX(488)
			var_7_13:setPositionY(24)
			var_7_12:addChild(var_7_13)

			local var_7_14 = ccui.ImageView:create("NoviceJumpLayer/timebg.png", var_0_5)

			var_7_14:setPosition(cc.p(522, 264))
			var_7_12:addChild(var_7_14)

			local var_7_15 = cc.Label:createWithTTF(L_LEFT_TIME_SPACE .. var_0_6(var_7_11), FONT_W5, 16)

			var_7_15:setColor(cc.c3b(244, 230, 255))
			var_7_15:setPositionX(110)
			var_7_15:setPositionY(var_7_14:getContentSize().height / 2)
			var_7_14:addChild(var_7_15)

			if playermodel.newbee_card_finishtime then
				var_7_14:setVisible(false)
				var_7_13:loadTexture("NoviceJumpLayer/btn_4.png", var_0_5)
			end

			var_6_1 = var_6_1 + 1
		end
	end)
end

function NoviceJumpLayer.exit(arg_11_0, ...)
	return
end
