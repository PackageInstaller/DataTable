MovingView = class("MovingView", function()
	return ccui.ScrollView:create()
end)

function MovingView.create(arg_2_0, arg_2_1)
	local var_2_0 = MovingView.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function MovingView:init(arg_3_1)
	self:initViewData(arg_3_1)
	self:initFirstView()
	self:registerTouchMoveEventListener()
end

function MovingView:getInnerContainerSize()
	local var_4_0
	local var_4_1

	if self.direction == cc.SCROLLVIEW_DIRECTION_HORIZONTAL then
		var_4_0 = self.height
		var_4_1 = 0

		for iter_4_0, iter_4_1 in pairs(self.cellConfs) do
			var_4_1 = var_4_1 + iter_4_1.size.width
		end

		var_4_1 = var_4_1 > self.width and var_4_1 or self.width
	elseif self.direction == cc.SCROLLVIEW_DIRECTION_VERTICAL then
		var_4_1 = self.width
		var_4_0 = 0

		for iter_4_2, iter_4_3 in pairs(self.cellConfs) do
			var_4_0 = var_4_0 + iter_4_3.size.height
		end

		var_4_0 = var_4_0 > self.height and var_4_0 or self.height
	end

	return cc.size(var_4_1, var_4_0)
end

function MovingView:initViewData(arg_5_1)
	self.initInfo = arg_5_1
	self.width = arg_5_1.width
	self.height = arg_5_1.height
	self.direction = arg_5_1.direction
	self.cellConfs = arg_5_1.cellConfs
	self.registerCellFunc = arg_5_1.registerCellFunc
	self.innerContainerSize = self:getInnerContainerSize()
end

function MovingView:initFirstView()
	self:setDirection(self.direction)
	self:setContentSize(cc.size(self.width, self.height))
	self:setInnerContainerSize(self.innerContainerSize)

	self.cellList = {}

	local var_6_0 = self.innerContainerSize.height

	for iter_6_0, iter_6_1 in ipairs(self.cellConfs) do
		local var_6_1 = cc.Node:create()

		var_6_1:setContentSize(iter_6_1.size)

		var_6_0 = var_6_0 - var_6_1:getContentSize().height

		var_6_1:setPosition(0, var_6_0)
		self:addChild(var_6_1)

		var_6_1.index = iter_6_0
		var_6_1.isHaveChild = false

		table.insert(self.cellList, var_6_1)
	end
end

function MovingView:updateCells()
	local var_7_0 = {
		[cc.SCROLLVIEW_DIRECTION_HORIZONTAL] = function(arg_8_0)
			local var_8_0 = arg_8_0:getPositionX() + self:getInnerContainer():getPositionX()

			return self:getContentSize().width, var_8_0, var_8_0 + arg_8_0:getContentSize().width
		end,
		[cc.SCROLLVIEW_DIRECTION_VERTICAL] = function(arg_9_0)
			local var_9_0 = arg_9_0:getPositionY() + self:getInnerContainer():getPositionY()

			return self:getContentSize().height, var_9_0, var_9_0 + arg_9_0:getContentSize().height
		end
	}

	for iter_7_0, iter_7_1 in ipairs(self.cellList) do
		local var_7_1, var_7_2, var_7_3 = var_7_0[self.direction](iter_7_1)

		if var_7_2 > 0 and var_7_2 < var_7_1 or var_7_3 > 0 and var_7_3 < var_7_1 then
			if not iter_7_1.isHaveChild then
				iter_7_1.addNum = not iter_7_1.addNum and 1 or iter_7_1.addNum + 1

				self.registerCellFunc(iter_7_1)

				iter_7_1.isHaveChild = true
			end
		else
			if iter_7_1.isHaveChild then
				iter_7_1.subNum = not iter_7_1.subNum and 1 or iter_7_1.subNum + 1
			end

			iter_7_1:removeAllChildren()

			iter_7_1.isHaveChild = false
		end
	end
end

function MovingView:registerTouchMoveEventListener()
	self:addEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.ScrollviewEventType.scrolling then
			return
		end

		self:updateCells()
	end)
end

function MovingView.registerCellUpdateEvent(arg_12_0, arg_12_1)
	if arg_12_1 and type(arg_12_1) == "function" then
		arg_12_0.registerCellFunc = arg_12_1
	end
end

function MovingView:resetView(arg_13_1)
	self:removeAllChildren()

	self.cellConfs = arg_13_1
	self.innerContainerSize = self:getInnerContainerSize()

	self:initFirstView()
	self:updateCells()
end
