PopGainPostcard = class("PopGainPostcard", function()
	return PopBaseLayer:create()
end)

local audio_manager = require("controller.audio_manager")
local postcard_data = require("data.postcard_data")
local var_0_2 = config._DEBUG and 0 or 1

function PopGainPostcard.create(arg_2_0, arg_2_1)
	local var_2_0 = PopGainPostcard.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopGainPostcard:init(arg_3_1)
	local var_3_0 = ccui.Layout:create()

	var_3_0:setContentSize(cc.size(640, GameDisplay.height))
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_3_0:setBackGroundColorOpacity(0)
	var_3_0:setCascadeOpacityEnabled(false)
	self:addChild(var_3_0, 99)
	LayerManager:createFullScreenMask(self, 220, function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
	audio_manager:playeffectMusic(TRAVEL_BACK_EFFECT)

	local var_3_1 = ccui.ImageView:create("gain_postcard/travel_bg.png", var_0_2)

	var_3_1:setScale9Enabled(true)
	var_3_1:setCapInsets(cc.rect(20, 70, 600, 170))
	var_3_1:setContentSize(cc.size(640, 895))
	var_3_1:setPosition(320, 600)
	var_3_0:addChild(var_3_1)

	local var_3_2 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_2)

	var_3_2:setPosition(320, 10)

	local var_3_3 = cc.Label:createWithTTF(L_BUTTON_TEXT.Comfirm, FONT_BUTTON, 30)

	var_3_3:setColor(cc.c3b(0, 0, 0))
	var_3_3:setPosition(cc.p(var_3_2:getContentSize().width / 2, var_3_2:getContentSize().height / 2 - 5))
	var_3_2:addChild(var_3_3, 999)
	var_3_1:addChild(var_3_2)
	var_3_2:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)

	local var_3_4
	local var_3_5
	local var_3_6
	local var_3_7

	function switchPostcard(arg_6_0)
		if arg_6_0 == var_3_0.postcard_order then
			return
		end

		if var_3_0.isRunningAction then
			return
		end

		var_3_0.isRunningAction = true

		local var_6_0 = arg_6_0 - var_3_0.postcard_order > 0 and "right" or "left"

		if (arg_6_0 - var_3_0.postcard_order > 0 and "right" or "left") == "right" then
			var_3_4:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(-var_3_4:getContentSize().width / 2, var_3_4:getPositionY())), cc.CallFunc:create(function()
				var_3_5:loadTexture("mainScenebg/postcard/" .. postcard_data[arg_3_1.postcards[arg_6_0]].image .. ".png")
				var_3_6:setString("   " .. postcard_data[arg_3_1.postcards[arg_6_0]].info)
				var_3_4:setPositionX(640 + var_3_4:getContentSize().width / 2)
			end), cc.MoveTo:create(0.1, cc.p(320, var_3_4:getPositionY())), cc.CallFunc:create(function()
				var_3_7[arg_6_0]:updateImg("gain_postcard/small_postcard_bg2.png")
				var_3_7[var_3_0.postcard_order]:updateImg("gain_postcard/small_postcard_bg1.png")

				var_3_0.postcard_order = arg_6_0
				var_3_0.isRunningAction = false
			end)))
		elseif var_6_0 == "left" then
			var_3_4:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(640 + var_3_4:getContentSize().width / 2, var_3_4:getPositionY())), cc.CallFunc:create(function()
				var_3_5:loadTexture("mainScenebg/postcard/" .. postcard_data[arg_3_1.postcards[arg_6_0]].image .. ".png")
				var_3_6:setString("   " .. postcard_data[arg_3_1.postcards[arg_6_0]].info)
				var_3_4:setPositionX(-var_3_4:getContentSize().width / 2)
			end), cc.MoveTo:create(0.1, cc.p(320, var_3_4:getPositionY())), cc.CallFunc:create(function()
				var_3_7[arg_6_0]:updateImg("gain_postcard/small_postcard_bg2.png")
				var_3_7[var_3_0.postcard_order]:updateImg("gain_postcard/small_postcard_bg1.png")

				var_3_0.postcard_order = arg_6_0
				var_3_0.isRunningAction = false
			end)))
		end
	end

	local function var_3_10()
		local var_11_0 = ccui.Button:create("gain_postcard/postcard_arrow.png", nil, "gain_postcard/postcard_arrow.png", var_0_2)

		var_11_0:setAnchorPoint(cc.p(0, 0.5))
		var_11_0:setPosition(0, var_3_4:getPositionY())
		var_3_1:addChild(var_11_0, 99)
		var_11_0:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			switchPostcard((var_3_0.postcard_order - 1 < 1 or nil) and (#arg_3_1.postcards or var_3_0.postcard_order - 1))
		end)

		local var_11_1 = ccui.Button:create("gain_postcard/postcard_arrow.png", nil, "gain_postcard/postcard_arrow.png", var_0_2)

		var_11_1:setFlippedX(true)
		var_11_1:setAnchorPoint(cc.p(1, 0.5))
		var_11_1:setPosition(640, var_3_4:getPositionY())
		var_3_1:addChild(var_11_1, 99)
		var_11_1:addTouchEventListener(function(arg_13_0, arg_13_1)
			if arg_13_1 ~= ccui.TouchEventType.ended then
				return
			end

			switchPostcard(var_3_0.postcard_order + 1 > #arg_3_1.postcards and 1 or var_3_0.postcard_order + 1)
		end)

		local var_11_2 = ccui.Layout:create()

		var_11_2:setContentSize(cc.size(640, var_3_4:getContentSize().height))
		var_11_2:setPosition(0, var_3_4:getPositionY() - var_3_4:getContentSize().height / 2)
		var_11_2:setTouchEnabled(false)
		var_3_1:addChild(var_11_2, 9)

		local var_11_3 = cc.EventListenerTouchOneByOne:create()

		var_11_3:setSwallowTouches(true)
		var_11_3:registerScriptHandler(function(arg_14_0, arg_14_1)
			if cc.rectContainsPoint(cc.rect(0, 0, var_11_2:getContentSize().width, var_11_2:getContentSize().height), (var_11_2:convertToNodeSpace(arg_14_0:getLocation()))) then
				return true
			else
				return false
			end
		end, cc.Handler.EVENT_TOUCH_BEGAN)
		var_11_3:registerScriptHandler(function(arg_15_0, arg_15_1)
			local var_15_0 = var_11_2:convertToNodeSpace(arg_15_0:getStartLocation())
			local var_15_1 = var_11_2:convertToNodeSpace(arg_15_0:getLocation())

			if var_15_0.x - var_15_1.x <= -200 then
				switchPostcard((var_3_0.postcard_order - 1 < 1 or nil) and (#arg_3_1.postcards or var_3_0.postcard_order - 1))
			elseif var_15_0.x - var_15_1.x >= 200 then
				switchPostcard(var_3_0.postcard_order + 1 > #arg_3_1.postcards and 1 or var_3_0.postcard_order + 1)
			end
		end, cc.Handler.EVENT_TOUCH_ENDED)
		var_11_2:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_11_3, var_11_2)

		var_3_7 = {}

		for iter_11_0, iter_11_1 in pairs(arg_3_1.postcards) do
			local var_11_4 = ccui.ImageView:create("gain_postcard/small_postcard_bg1.png", var_0_2)

			var_11_4:setTouchEnabled(true)
			var_11_4:setScale(1.4)
			var_11_4:setPosition((iter_11_0 - (#arg_3_1.postcards + 1) / 2) * 200 + 320, 333)
			var_3_1:addChild(var_11_4)

			var_3_7[iter_11_0] = var_11_4

			local var_11_5 = ccui.ImageView:create("mainScenebg/postcard/" .. postcard_data[iter_11_1].image .. ".png")

			var_11_5:setScale(112 / var_11_5:getContentSize().width)
			var_11_5:setPosition(var_11_4:getContentSize().width / 2, var_11_4:getContentSize().height / 2)
			var_11_4:addChild(var_11_5)
			var_11_4:addTouchEventListener(function(arg_16_0, arg_16_1)
				if arg_16_1 ~= ccui.TouchEventType.ended then
					return
				end

				switchPostcard(iter_11_0)
			end)

			function var_11_4.updateImg(arg_17_0, arg_17_1)
				var_11_4:loadTexture(arg_17_1, var_0_2)
				var_11_5:setPosition(var_11_4:getContentSize().width / 2, var_11_4:getContentSize().height / 2)
			end
		end

		var_3_0.postcard_order = 1

		var_3_7[var_3_0.postcard_order]:updateImg("gain_postcard/small_postcard_bg2.png")
	end

	;(function()
		var_3_4 = ccui.ImageView:create("gain_postcard/photo_bottom.png", var_0_2)

		var_3_4:setTouchEnabled(true)
		var_3_4:setScale9Enabled(true)
		var_3_4:setCapInsets(cc.rect(20, 20, 65, 65))
		var_3_4:setContentSize(cc.size(546, 347))
		var_3_1:addChild(var_3_4)

		var_3_5 = ccui.ImageView:create("mainScenebg/postcard/" .. ((arg_3_1.postcards or nil) and (postcard_data[arg_3_1.postcards[1]].image or arg_3_1.postcardInfo.img)) .. ".png")

		var_3_5:setAnchorPoint(cc.p(0.5, 1))
		var_3_5:setPosition(var_3_4:getContentSize().width / 2, var_3_4:getContentSize().height - 10)
		var_3_4:addChild(var_3_5)

		local var_18_0 = ccui.Layout:create()

		var_18_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_18_0:setBackGroundColor(cc.c3b(159, 173, 193))
		var_18_0:setContentSize(cc.size(530, 113))
		var_18_0:setTouchEnabled(false)
		var_3_4:addChild(var_18_0, 999)
		var_18_0:setPosition(cc.p(8, -var_18_0:getContentSize().height + 5))

		local var_18_1 = ccui.ImageView:create("gain_postcard/cube.png", var_0_2)

		var_18_1:setPosition(cc.p(15, 99))
		var_18_0:addChild(var_18_1, 999)

		var_3_6 = cc.Label:createWithTTF("   " .. ((arg_3_1.postcards or nil) and (postcard_data[arg_3_1.postcards[1]].info or arg_3_1.postcardInfo.des)), FONT_NAME, 20)

		var_3_6:setColor(cc.c3b(76, 99, 125))
		var_3_6:setAnchorPoint(cc.p(0, 1))
		var_3_6:setPosition(0, 104)
		var_3_6:setMaxLineWidth(530)
		var_18_0:addChild(var_3_6)

		if arg_3_1.postcards and #arg_3_1.postcards > 1 then
			var_3_4:setPosition(320, 648)
			var_3_10()
		else
			var_3_4:setPosition(320, 590)
		end
	end)()
	;(function()
		local var_19_0 = ccui.ImageView:create("gain_postcard/frame_bg.png", var_0_2)

		var_19_0:setScale9Enabled(true)
		var_19_0:setCapInsets(cc.rect(200, 40, 80, 120))
		var_19_0:setContentSize(cc.size(646, var_19_0:getContentSize().height))
		var_19_0:setAnchorPoint(cc.p(0, 0))
		var_19_0:setPosition(-10, 65)
		var_3_1:addChild(var_19_0)

		local var_19_1 = 8 + #arg_3_1.items * 122 < 604 and 604 or 8 + #arg_3_1.items * 122
		local var_19_2 = ccui.ScrollView:create()

		var_19_2:setClippingEnabled(true)
		var_19_2:setContentSize(cc.size(604, 151))
		var_19_2:setInnerContainerSize(cc.size(var_19_1, var_19_2:getContentSize().height))
		var_19_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_19_2:setBackGroundColor(cc.c3b(26, 32, 55))
		var_19_2:setPosition(31, 12)
		var_19_0:addChild(var_19_2)

		for iter_19_0, iter_19_1 in pairs(arg_3_1.items) do
			local var_19_3 = ItemSprite:createBigWithEntityId(iter_19_1.entityid, iter_19_1.dropNum)

			var_19_3:setScale(0.6)
			var_19_3:setAnchorPoint(cc.p(0, 0.5))
			var_19_3:setPosition(8 + (iter_19_0 - 1) * 122, var_19_2:getContentSize().height / 2)
			var_19_2:addChild(var_19_3)
			var_19_3:setTouchEnabled(true)
			var_19_3:addSpriteTouchEventListener(function(arg_20_0, arg_20_1)
				if arg_20_1 ~= ccui.TouchEventType.ended then
					return
				end

				PopLayer:Item({
					hideGainButton = true,
					itemid = iter_19_1.dropid,
					itemnum = iter_19_1.dropNum,
					entityid = iter_19_1.entityid
				})
			end)
		end
	end)()
end

function PopGainPostcard:exit()
	LayerManager:removePopLayer(self.__queueindex)
end
