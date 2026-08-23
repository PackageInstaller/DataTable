local NewSlgBuildingWeatherNode = class("NewSlgBuildingWeatherNode", function()
	return cc.Node:create()
end)

function NewSlgBuildingWeatherNode:ctor()
	self._bgSprite = display.newSprite()

	self:addChild(self._bgSprite)

	self._weatherSprite = display.newSprite()

	self:addChild(self._weatherSprite)
end

function NewSlgBuildingWeatherNode:updateWeatherNode(arg_3_1)
	self._bgSprite:setSpriteFrame(arg_3_1.bgFrame)
	self._weatherSprite:setSpriteFrame(arg_3_1.weatherFrame)
end

return NewSlgBuildingWeatherNode
