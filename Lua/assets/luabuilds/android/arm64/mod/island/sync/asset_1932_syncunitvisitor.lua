local SyncUnitVisitor = class("SyncUnitVisitor")

function SyncUnitVisitor:Ctor(arg_1_1)
	return
end

function SyncUnitVisitor:RecordLastInteract(arg_2_1, arg_2_2)
	self.lastInteract = {
		type = arg_2_2,
		id = arg_2_1
	}

	return
end

function SyncUnitVisitor:ClearLastInteract()
	self.lastInteract = nil

	return
end

function SyncUnitVisitor:GetLastInteract()
	return self.lastInteract
end

function SyncUnitVisitor:Dispose()
	return
end

return SyncUnitVisitor
