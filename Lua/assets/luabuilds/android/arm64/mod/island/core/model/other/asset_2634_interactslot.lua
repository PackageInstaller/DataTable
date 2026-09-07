local InteractSlot = class("InteractSlot")

function InteractSlot:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1
	self.hostId = arg_1_2
	self.userId = nil

	return
end

function InteractSlot:Lock(arg_2_1)
	self.userId = arg_2_1

	return
end

function InteractSlot:Release()
	self.userId = nil

	return
end

function InteractSlot:IsEmpty()
	return self.userId == nil
end

function InteractSlot:IsUsing(arg_5_1)
	return self.userId == arg_5_1
end

function InteractSlot:GetHostId()
	return self.hostId
end

function InteractSlot:GetUserId()
	return self.userId
end

return InteractSlot
