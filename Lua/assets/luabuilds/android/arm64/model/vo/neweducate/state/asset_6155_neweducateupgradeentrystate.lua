local NewEducateUpgradeEntryState = class("NewEducateUpgradeEntryState", import(".NewEducateStateBase"))

function NewEducateUpgradeEntryState:Ctor()
	self.finishFlag = false

	return
end

function NewEducateUpgradeEntryState:IsPriorityType()
	return true
end

function NewEducateUpgradeEntryState:GetSystemNo()
	return NewEducatePriorityFSM.SYSTEM.UPGRADE_ENTRY
end

function NewEducateUpgradeEntryState:MarkFinish()
	self.finishFlag = true

	return
end

function NewEducateUpgradeEntryState:IsFinish()
	return self.finishFlag
end

function NewEducateUpgradeEntryState:Reset()
	self.finishFlag = false

	return
end

return NewEducateUpgradeEntryState
