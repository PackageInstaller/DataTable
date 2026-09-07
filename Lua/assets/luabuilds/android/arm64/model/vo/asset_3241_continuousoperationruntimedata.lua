local ContinuousOperationRuntimeData = class("ContinuousOperationRuntimeData")

function ContinuousOperationRuntimeData:Ctor(arg_1_1)
	for iter_1_0, iter_1_1 in pairs(arg_1_1) do
		self[iter_1_0] = iter_1_1
	end

	self.system = arg_1_1.system
	self.totalBattleTime = arg_1_1.battleTime
	self.battleTime = arg_1_1.battleTime
	self.drops = {}
	self.settlementDrops = {}
	self.events = {
		{},
		{},
		{}
	}
	self.active = nil
	self.clickStopAutoFlag = false

	return
end

function ContinuousOperationRuntimeData:GetSystem()
	return self.system
end

function ContinuousOperationRuntimeData:GetTotalBattleTime()
	return self.totalBattleTime
end

function ContinuousOperationRuntimeData:GetRestBattleTime()
	return self.battleTime
end

function ContinuousOperationRuntimeData:ConsumeBattleTime()
	self.battleTime = self.battleTime - 1

	self:ResetClickStopAutoFlag()

	return
end

function ContinuousOperationRuntimeData:IsFirstBattle()
	return self:GetTotalBattleTime() == self:GetRestBattleTime()
end

function ContinuousOperationRuntimeData:GetDrops()
	return self.drops
end

function ContinuousOperationRuntimeData:GetSettlementDrops()
	return self.settlementDrops
end

function ContinuousOperationRuntimeData:MergeDrops(arg_9_1, arg_9_2)
	self.drops = table.mergeArray(self.drops, arg_9_1)
	self.settlementDrops = table.mergeArray(self.settlementDrops, arg_9_2)

	return
end

function ContinuousOperationRuntimeData:MergeEvents(arg_10_1, arg_10_2, arg_10_3)
	self.events[1] = table.merge(self.events[1], arg_10_1 or {})
	self.events[2] = table.merge(self.events[2], arg_10_2 or {})
	self.events[3] = table.merge(self.events[3], arg_10_3 or {})

	return
end

function ContinuousOperationRuntimeData:GetEvents(arg_11_1)
	return self.events[arg_11_1]
end

function ContinuousOperationRuntimeData:TryActivate()
	if self.active ~= nil then
		return
	end

	self.active = true

	return
end

function ContinuousOperationRuntimeData:Stop(arg_13_1)
	self.active = false
	self.stopReason = arg_13_1 or ChapterConst.AUTOFIGHT_STOP_REASON.UNKNOWN

	return
end

function ContinuousOperationRuntimeData:IsActive()
	return tobool(self.active)
end

function ContinuousOperationRuntimeData:MarkClickStopAutoFlag()
	self.clickStopAutoFlag = true

	return
end

function ContinuousOperationRuntimeData:ResetClickStopAutoFlag()
	self.clickStopAutoFlag = false

	return
end

function ContinuousOperationRuntimeData:IsRecordTime()
	return self:IsActive() and not self.clickStopAutoFlag
end

return ContinuousOperationRuntimeData
