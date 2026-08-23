local NewSlgBuildingElemNode = class("NewSlgBuildingElemNode", function()
	return cc.Node:create()
end)

function NewSlgBuildingElemNode:ctor()
	self._elemSprite = display.newSprite()

	self:addChild(self._elemSprite)
	self._elemSprite:setScale(0.8)

	self._tipSprite = display.newSprite()

	self:addChild(self._tipSprite)
end

function NewSlgBuildingElemNode:updateElemNode(arg_3_1)
	self._elemSprite:setSpriteFrame(arg_3_1.elemFrame)

	local var_3_0 = self._elemSprite:getContentSize()

	if arg_3_1.tipFrame then
		self._tipSprite:setSpriteFrame(arg_3_1.tipFrame)
		self._tipSprite:setVisible(true)
		self._tipSprite:setPosition(var_3_0.width / 4, -var_3_0.height / 4)
	else
		self._tipSprite:setVisible(false)
	end
end

return NewSlgBuildingElemNode
