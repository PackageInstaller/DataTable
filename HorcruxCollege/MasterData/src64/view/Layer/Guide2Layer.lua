Guide2Layer = class("Guide2Layer", function()
	return cc.Layer:create()
end)

function Guide2Layer:ctor()
	local var_2_0 = cc.Director:getInstance():getWinSize()

	self.size = var_2_0

	local var_2_1 = ccui.Button:create("guide/guidShade.png", "guide/guidShade.png")

	var_2_1:setPosition(var_2_0.width / 2, var_2_0.height / 2)
	var_2_1:setOpacity(0)
	self:addChild(var_2_1, -1, 10)
	self:guideSprite(2)
	self:event()
end

function Guide2Layer.guideSprite(arg_3_0, arg_3_1)
	local function var_3_0(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
		guide = cc.Sprite:create("guide/" .. arg_4_0 .. "/guide1.png")

		local var_4_0 = cc.Animation:create()

		for iter_4_0 = 1, 6 do
			var_4_0:addSpriteFrameWithFile("guide/" .. arg_4_0 .. "/guide" .. iter_4_0 .. ".png")
		end

		var_4_0:setLoops(100000000)
		var_4_0:setDelayPerUnit(0.15)
		var_4_0:setRestoreOriginalFrame(true)
		guide:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Animate:create(var_4_0), cc.DelayTime:create(0.3))))
		guide:setPosition(cc.p(arg_4_1, arg_4_2))
		guide:setScale(arg_4_3)

		local var_4_1 = cc.Sprite:create()

		var_4_1:setTexture("guide/finger.png")
		var_4_1:setPosition(cc.p(arg_4_4, arg_4_5))
		var_4_1:setScale(arg_4_3)

		local var_4_2
		local var_4_3
		local var_4_4
		local var_4_5
		local var_4_6 = cc.Sprite:create("guide/guideTitle.png")

		if arg_4_0 == "guide1" then
			var_4_2 = cc.MoveBy:create(0.3, cc.p(-100, 25))
			var_4_3 = cc.MoveBy:create(0.6, cc.p(180, 120))
			var_4_4 = cc.DelayTime:create(0.3)
			var_4_5 = cc.MoveTo:create(0, cc.p(arg_4_4, arg_4_5))

			var_4_6:setPosition(cc.p(arg_4_4 - 10, arg_4_5 - 40))
		end

		if arg_4_0 == "guide2" then
			var_4_2 = cc.MoveBy:create(0.2, cc.p(-12, -95))
			var_4_3 = cc.MoveBy:create(0.2, cc.p(-45, -60))
			var_4_5 = cc.MoveBy:create(0.2, cc.p(-75, -25))
			var_4_4 = cc.DelayTime:create(0.3)
			move4 = cc.MoveTo:create(0, cc.p(arg_4_4, arg_4_5))

			var_4_6:setPosition(cc.p(arg_4_4 + 50, arg_4_5 - 180))
		end

		var_4_1:runAction(cc.RepeatForever:create((cc.Sequence:create(var_4_2, var_4_3, var_4_5, var_4_4, move4))))
		var_4_6:setScale(0.6)
		arg_3_0:addChild(var_4_6, 2, 12 * arg_3_1)
		arg_3_0:addChild(var_4_1, 10, 11 * arg_3_1)
		arg_3_0:addChild(guide, 9, 10 * arg_3_1)
	end

	if arg_3_1 == 1 then
		var_3_0("guide1", 400, 300, 0.8, 470, 200)
	else
		var_3_0("guide2", 542, 260, 0.8, 625, 320)
	end
end

function Guide2Layer.event(arg_5_0)
	local var_5_0 = cc.EventListenerTouchOneByOne:create()

	var_5_0:registerScriptHandler(function(arg_6_0, arg_6_1)
		stap = arg_6_0:getLocationInView()

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_5_0:registerScriptHandler(function(arg_7_0, arg_7_1)
		return
	end, cc.Handler.EVENT_TOUCH_MOVED)
	var_5_0:registerScriptHandler(function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_0:getLocationInView()
		local var_8_1 = arg_8_1:getCurrentTarget()
		local var_8_2 = arg_5_0:getChildByTag(10)
		local var_8_3 = var_8_2:getBoundingBox()

		if cc.rectContainsPoint(cc.rect(var_8_2:getPositionX() - var_8_3.width / 2, var_8_2:getPositionY() - var_8_3.height / 2, var_8_3.width, var_8_3.height), (cc.Director:getInstance():convertToGL(var_8_0))) and math.abs(var_8_0.y - stap.y) >= 100 then
			arg_5_0:removeAllChildren()
			require("view.Layer.Guide3Layer")
			cc.Director:getInstance():getRunningScene():getChildByTag(0):getChildByTag(100):addChild(Guide3Layer:create(), 100, 100)
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(var_5_0, arg_5_0)
end

function Guide2Layer.create(arg_9_0)
	return (Guide2Layer.new())
end

return Guide2Layer
