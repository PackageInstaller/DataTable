local SpireMonsterStruct = require("app.view.module.spire.model.struct.SpireMonsterStruct")
local SpireMonsterPool = class("SpireMonsterPool")

function SpireMonsterPool:ctor()
	self._standByList = {}
	self._usingList = {}
end

function SpireMonsterPool:prepareMonster(arg_2_1)
	for iter_2_0 = 1, arg_2_1 do
		self._standByList[iter_2_0] = SpireMonsterStruct.new()
	end
end

function SpireMonsterPool:getMonster()
	local var_3_0 = table.remove(self._standByList, 1)

	if var_3_0 then
		self._usingList[#self._usingList + 1] = var_3_0
	end

	return var_3_0
end

function SpireMonsterPool:returnMonster(arg_4_1)
	local var_4_0 = false

	for iter_4_0, iter_4_1 in ipairs(self._usingList) do
		if iter_4_1 == arg_4_1 then
			table.remove(self._usingList, iter_4_0)
			iter_4_1:clearOwnerRef()

			self._standByList[#self._standByList + 1] = arg_4_1
			var_4_0 = true

			break
		end
	end

	return var_4_0
end

function SpireMonsterPool:clearAllUsingList()
	for iter_5_0, iter_5_1 in ipairs(self._usingList) do
		iter_5_1:clearOwnerRef()

		self._standByList[#self._standByList + 1] = iter_5_1
	end

	self._usingList = {}
end

return SpireMonsterPool
