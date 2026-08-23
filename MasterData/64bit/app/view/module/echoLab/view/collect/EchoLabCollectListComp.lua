local EchoLabCollectListComp = class("EchoLabCollectListComp")

function EchoLabCollectListComp:ctor()
	self.itemList = {}
	self.totalH = 0
	self.margin = 4
	self.auto = false
	self._isMid = false
end

function EchoLabCollectListComp:setMidMode(arg_2_1)
	self._isMid = arg_2_1
end

function EchoLabCollectListComp:setMargin(arg_3_1)
	if self.margin == arg_3_1 then
		return
	end

	self.margin = arg_3_1

	if #self.itemList > 0 then
		self:layout(1, self.itemList[1])
	end
end

function EchoLabCollectListComp:setAutoAdaptHeight(arg_4_1)
	self.auto = arg_4_1
end

function EchoLabCollectListComp:receiveCompEvent(arg_5_1, arg_5_2)
	if arg_5_1 == "ItemSizeChange" then
		local var_5_0 = arg_5_2.index

		if arg_5_2.index > #self.itemList then
			var_5_0 = 1
		end

		self:layout(var_5_0, self.itemList[var_5_0])
	end

	return false
end

function EchoLabCollectListComp:layout(arg_6_1, arg_6_2)
	local var_6_0 = #self.itemList

	self.totalH = self.itemList[arg_6_1 - 1] and self.itemList[arg_6_1 - 1]:getPosition().y + self.itemList[arg_6_1 - 1]:getHeight() + self.margin or 0

	arg_6_2:setPosition(0, self.totalH)

	local var_6_1 = arg_6_2

	for iter_6_0 = arg_6_1 + 1, var_6_0 do
		self.totalH = self.totalH + arg_6_2:getHeight() + self.margin

		self.itemList[iter_6_0]:setPosition(0, self.totalH)

		var_6_1 = self.itemList[iter_6_0]
	end

	arg_6_2 = self.itemList[#self.itemList] or arg_6_2
	self.totalH = self.totalH + arg_6_2:getHeight()

	if self.auto then
		local var_6_2 = self:getSize()

		var_6_2.height = self.totalH

		self:setSize(var_6_2)
	end

	if self._isMid then
		self:_relayout()
	end
end

function EchoLabCollectListComp:_relayout()
	local var_7_0 = math.max(self.totalH, self:getSize().height)

	if self.totalH == var_7_0 then
		return
	end

	local var_7_1 = var_7_0 / 2 + self.totalH / 2

	for iter_7_0, iter_7_1 in ipairs(self.itemList) do
		iter_7_1:setPosition(0, var_7_1)

		var_7_1 = var_7_1 + iter_7_1:getSize().height + self.margin
	end
end

function EchoLabCollectListComp:clearAll()
	for iter_8_0, iter_8_1 in ipairs(self.itemList) do
		iter_8_1:removeFromParent()
	end

	self.itemList = {}
	self.totalH = 0
end

function EchoLabCollectListComp:addItem(arg_9_1)
	if not arg_9_1 then
		return
	end

	self.itemList = self.itemList or {}

	self:addChild(arg_9_1)
	self:addListen(arg_9_1)
	self:layout(#self.itemList + 1, arg_9_1)
	table.insert(self.itemList, arg_9_1)
end

function EchoLabCollectListComp:removeItem(arg_10_1)
	arg_10_1 = arg_10_1 or #self.itemList

	if not self.itemList[arg_10_1] then
		return
	end

	table.remove(self.itemList, arg_10_1):removeFromParent()
	self:layout(arg_10_1 - 1, self.itemList[arg_10_1 - 1])
end

function EchoLabCollectListComp:getItemNum()
	return #self.itemList
end

function EchoLabCollectListComp:getItemByIndex(arg_12_1)
	return self.itemList[arg_12_1]
end

function EchoLabCollectListComp:setUpdateFunc(arg_13_1)
	self._updateFunc = arg_13_1
end

function EchoLabCollectListComp:updateItem(arg_14_1, arg_14_2)
	if not self._updateFunc then
		return
	end

	arg_14_2 = arg_14_2 or 1

	for iter_14_0 = arg_14_2, arg_14_2 or #self.itemList do
		self._updateFunc(arg_14_1, self.itemList[iter_14_0])
	end
end

function EchoLabCollectListComp:getHeight()
	return self.totalH
end

return EchoLabCollectListComp
