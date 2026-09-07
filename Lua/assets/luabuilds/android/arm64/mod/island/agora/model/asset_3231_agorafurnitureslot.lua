local AgoraFurnitureSlot = class("AgoraFurnitureSlot")

function AgoraFurnitureSlot:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1
	self.hostId = arg_1_2
	self.userId = nil

	return
end

function AgoraFurnitureSlot:Lock(arg_2_1)
	self.userId = arg_2_1

	return
end

function AgoraFurnitureSlot:Release()
	self.userId = nil

	return
end

function AgoraFurnitureSlot:IsEmpty()
	return self.userId == nil
end

function AgoraFurnitureSlot:IsUsing(arg_5_1)
	return self.userId == arg_5_1
end

function AgoraFurnitureSlot:GetHostId()
	return self.hostId
end

function AgoraFurnitureSlot:GetUserId()
	return self.userId
end

return AgoraFurnitureSlot
