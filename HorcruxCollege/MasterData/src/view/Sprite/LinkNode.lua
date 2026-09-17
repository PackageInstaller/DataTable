local LinkNode = class("LinkNode", function(arg_1_0)
	return cc.SpriteBatchNode:create(arg_1_0)
end)
local LinkLine = class("LinkLine", function(arg_2_0)
	return cc.Sprite:create(arg_2_0)
end)

function LinkNode:create(arg_3_1, arg_3_2)
	local var_3_0 = LinkNode.new(arg_3_1)

	var_3_0:init(arg_3_1, arg_3_2)

	return var_3_0
end

function LinkNode:init(arg_4_1, arg_4_2)
	self._texture = arg_4_1

	self:drawLines(arg_4_2)
end

function LinkNode:drawLines(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		self:addChild((LinkLine:create(self._texture, iter_5_1)))
	end
end

function LinkLine:create(arg_6_1, arg_6_2)
	local var_6_0 = LinkLine.new(arg_6_1)

	var_6_0:init(arg_6_2)

	return var_6_0
end

function LinkLine:init(arg_7_1)
	self._start = arg_7_1[1]
	self._finish = arg_7_1[2]

	self:initLinePos()
	self:initLineLength()
	self:initLineRotate()
end

function LinkLine:initLinePos()
	self:setPosition(cc.p((self._start.x + self._finish.x) / 2, (self._start.y + self._finish.y) / 2))
end

function LinkLine:initLineLength()
	self:setScaleX(cc.pGetDistance(self._start, self._finish) / self:getContentSize().width)
end

local var_0_2 = 3.1415926

local function var_0_3(arg_10_0)
	return 180 * (1 - arg_10_0 / var_0_2)
end

function LinkLine:initLineRotate()
	self:setRotation((var_0_3((cc.pToAngleSelf(cc.p(self._finish.x - self._start.x, self._finish.y - self._start.y))))))
end

return LinkNode
