ys = ys or {}

local BattleLastingAOEData = class("BattleLastingAOEData", ys.Battle.BattleAOEData)

ys.Battle.BattleLastingAOEData = BattleLastingAOEData
BattleLastingAOEData.__name = "BattleLastingAOEData"

function BattleLastingAOEData:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	BattleLastingAOEData.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3, arg_1_5)

	self._exitCldFunc = arg_1_4

	if arg_1_6 then
		self.Settle = self.frequentlySettle
	end

	self._handledList = {}

	return
end

function BattleLastingAOEData:Dispose()
	for iter_2_0, iter_2_1 in pairs(self._handledList) do
		self._exitCldFunc(iter_2_0)

		self._handledList[iter_2_0] = nil
	end

	self._exitCldFunc = nil
	self._handledList = nil

	BattleLastingAOEData.super.Dispose(self)

	return
end

function BattleLastingAOEData:Settle()
	local var_3_0 = {}
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(self._cldObjList) do
		var_3_1[iter_3_1.UID] = true

		if not self._handledList[iter_3_1] then
			var_3_0[#var_3_0 + 1] = iter_3_1
			self._handledList[iter_3_1] = true
		end
	end

	self.SortCldObjList(var_3_0)
	self._cldComponent:GetCldData():func(obj)

	for iter_3_2, iter_3_3 in pairs(self._handledList) do
		if not var_3_1[iter_3_2.UID] or iter_3_2.ImmuneCLD == true then
			self._exitCldFunc(iter_3_2)

			self._handledList[iter_3_2] = nil
		end
	end

	return
end

function BattleLastingAOEData:frequentlySettle()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(self._cldObjList) do
		var_4_0[iter_4_1.UID] = true
		self._handledList[iter_4_1] = self._handledList[iter_4_1] or true
	end

	for iter_4_2, iter_4_3 in pairs(self._handledList) do
		if not var_4_0[iter_4_2.UID] then
			self._exitCldFunc(iter_4_2)

			self._handledList[iter_4_2] = nil
		end
	end

	self.SortCldObjList(self._cldObjList)
	self._cldComponent:GetCldData().func(self._cldObjList)

	return
end

function BattleLastingAOEData:ForceExit(arg_5_1)
	local var_5_0

	for iter_5_0, iter_5_1 in pairs(self._handledList) do
		if iter_5_0.UID == arg_5_1 then
			var_5_0 = iter_5_0

			break
		end
	end

	if var_5_0 then
		self._exitCldFunc(var_5_0)

		self._handledList[var_5_0] = nil
	end

	return
end

return
