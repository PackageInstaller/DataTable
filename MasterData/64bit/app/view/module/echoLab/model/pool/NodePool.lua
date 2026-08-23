local NodePool = class("NodePool")

function NodePool:ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self._poolList = {}
	self._compPackCage = arg_1_2
	self._compUrl = arg_1_3
	self._poolRoot = arg_1_1
	self._poolLength = arg_1_4 or 10

	self:setPoolLength(self._poolLength)
end

function NodePool:setPoolLength(arg_2_1)
	if arg_2_1 > #self._poolList then
		for iter_2_0 = #self._poolList + 1, arg_2_1 do
			table.insert(self._poolList, self:_createComp())
		end
	elseif arg_2_1 < #self._poolList then
		for iter_2_1 = #self._poolList, arg_2_1, -1 do
			self:_removeComp(self._poolList[iter_2_1])
			table.remove(self._poolList, iter_2_1)
		end
	end
end

function NodePool:_createComp()
	local var_3_0 = fgui.UIPackage:createObject(self._compPackCage, self._compUrl)

	self._poolRoot:addAutoRetain(var_3_0)

	return var_3_0
end

function NodePool:_removeComp(arg_4_1)
	self._poolRoot:removeAutoRetain(arg_4_1)
end

function NodePool:takeOutCompInPool()
	if #self._poolList > 0 then
		table.remove(self._poolList, #self._poolList)

		return self._poolList[#self._poolList]
	else
		return self:_createComp()
	end
end

function NodePool:takeOutFirstCompInPool()
	if #self._poolList > 0 then
		table.remove(self._poolList, 1)

		return self._poolList[1]
	else
		return self:_createComp()
	end
end

function NodePool:recoveryCompInPool(arg_7_1)
	if not arg_7_1 then
		return
	end

	if arg_7_1:getParent() then
		arg_7_1:removeFromParent()
	end

	if #self._poolList > self._poolLength then
		self:_removeComp(arg_7_1)
	else
		table.insert(self._poolList, arg_7_1)
	end
end

function NodePool:clearPool()
	for iter_8_0, iter_8_1 in ipairs(self._poolList) do
		self:_removeComp(iter_8_1)
	end

	self._poolList = {}
end

return NodePool
