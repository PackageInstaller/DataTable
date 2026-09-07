ys = ys or {}

local BattleTriggerAOEData = class("BattleTriggerAOEData", ys.Battle.BattleAOEData)

ys.Battle.BattleTriggerAOEData = BattleTriggerAOEData
BattleTriggerAOEData.__name = "BattleTriggerAOEData"

function BattleTriggerAOEData:Ctor(arg_1_1, arg_1_2, arg_1_3)
	BattleTriggerAOEData.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3)

	return
end

function BattleTriggerAOEData:Settle()
	if #self._cldObjList > 0 then
		self.SortCldObjList(self._cldObjList)
		self._cldComponent:GetCldData().func(self._cldObjList)

		self._flag = false
	end

	return
end

return
