local BattleEntryManager = class("BattleEntryManager")

function BattleEntryManager:ctor()
	self._tweenEntry = {}
end

function BattleEntryManager:getFromPool(arg_2_1)
	arg_2_1 = tostring(arg_2_1)

	if self._tweenEntry[arg_2_1] and #self._tweenEntry[arg_2_1] > 0 then
		return table.remove(self._tweenEntry[arg_2_1], 1)
	end
end

function BattleEntryManager:saveToPool(arg_3_1, arg_3_2)
	if not arg_3_1 and not arg_3_2 then
		return
	end

	arg_3_1 = tostring(arg_3_1)
	self._tweenEntry[arg_3_1] = self._tweenEntry[arg_3_1] or {}

	table.insert(self._tweenEntry[arg_3_1], arg_3_2)
end

function BattleEntryManager:clearAll()
	for iter_4_0, iter_4_1 in pairs(self._tweenEntry) do
		for iter_4_2 = #iter_4_1, 1, -1 do
			iter_4_1[iter_4_2]:clearNode()
		end
	end

	self._tweenEntry = {}
end

function BattleEntryManager:debugDump()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(self._tweenEntry) do
		var_5_0[iter_5_0] = #iter_5_1
	end

	dump(var_5_0)
end

return BattleEntryManager
