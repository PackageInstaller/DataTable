local LoadingSprite = class("LoadingSprite", function()
	return cc.Node:create()
end)

function LoadingSprite:create()
	local var_2_0 = LoadingSprite.new()

	var_2_0:init()

	return var_2_0
end

function LoadingSprite:init()
	local var_3_0 = cc.Sprite:create("loading/loadingcircle.png")

	self:addChild(var_3_0)

	local var_3_1 = cc.Sprite:create("loading/loadingword.png")

	var_3_1:setPosition(cc.p(0, -1 * var_3_0:getContentSize().height / 2 - 15))
	self:addChild(var_3_1)

	self._circle = var_3_0
	self._playing = false

	self:play()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			self._playing = false
		end
	end)
end

function LoadingSprite:play()
	if self._playing then
		return
	end

	self._circle:runAction(cc.RepeatForever:create(cc.RotateBy:create(1, 360)))

	self._playing = true
end

function LoadingSprite:stop()
	self:stopAllActions()

	self._playing = false
end

return LoadingSprite
