ClipSprite = class("ClipSprite", function()
	return cc.ClippingNode:create()
end)

function ClipSprite:init()
	local var_2_0 = cc.Director:getInstance():getWinSize()
	local var_2_1 = (function(arg_3_0, arg_3_1)
		local var_3_0 = cc.Sprite:create()

		var_3_0:setTexture(arg_3_0)
		var_3_0:setPosition(arg_3_1.x, arg_3_1.y)

		return var_3_0
	end)("levelScene/figure1.png", (cc.p(440, 340)))
	local var_2_2 = var_2_1:getBoundingBox()

	var_2_1:setScaleX(1.5873015873015872)

	self.stencil = var_2_1

	self:setInverted(true)
	self:setAlphaThreshold(1)
	self:setStencil(var_2_1)
	self:addChild((cc.LayerColor:create(cc.c4b(0, 0, 0, 0), var_2_0.width, var_2_0.height)))
end

function ClipSprite:getStencilRect()
	local var_4_0 = self.stencil:getBoundingBox()

	return cc.rect(self.stencil:getPositionX() - var_4_0.width / 2, self.stencil:getPositionY() - var_4_0.height / 2, var_4_0.width, var_4_0.height)
end

function ClipSprite.create(arg_5_0)
	local var_5_0 = ClipSprite.new()

	var_5_0:init()

	return var_5_0
end

return ClipSprite
