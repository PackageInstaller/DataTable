local ObjectPool = class("ObjectPool")
local var_0_1 = 20

function ObjectPool:ctor()
	self._poolDict = {}
end

function ObjectPool:getObj(arg_2_1, arg_2_2)
	if not arg_2_1.isItem then
		assert(false, "cls must is ObjectPoolItem subclass")

		return
	end

	local var_2_0 = arg_2_1.__cname

	if not self._poolDict[arg_2_1.__cname] then
		self._poolDict[var_2_0] = {}

		local var_2_1 = arg_2_1.new()

		var_2_1:setPool(self)
		var_2_1:onGet(arg_2_2)

		return var_2_1
	end

	if #self._poolDict[var_2_0] > 0 then
		local var_2_2 = table.remove(self._poolDict[var_2_0])

		var_2_2:onGet(arg_2_2)

		return var_2_2
	else
		local var_2_3 = arg_2_1.new()

		var_2_3:setPool(self)
		var_2_3:onGet(arg_2_2)

		return var_2_3
	end
end

function ObjectPool:releaseObj(arg_3_1)
	if not arg_3_1.isItem then
		assert(false, "obj must is ObjectPoolItem subclass object")

		return
	end

	local var_3_0 = arg_3_1.__cname

	if not self._poolDict[arg_3_1.__cname] then
		self._poolDict[var_3_0] = {}

		arg_3_1:onReset()
		table.insert(self._poolDict[var_3_0], arg_3_1)

		return
	end

	if #self._poolDict[var_3_0] < var_0_1 then
		arg_3_1:onReset()
		table.insert(self._poolDict[var_3_0], arg_3_1)
	end
end

function ObjectPool:clear()
	self._poolDict = {}
end

return ObjectPool
