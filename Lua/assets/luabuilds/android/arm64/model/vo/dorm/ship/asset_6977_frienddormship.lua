local FriendDormShip = class("FriendDormShip", import(".DormShip"))

function FriendDormShip:Ctor(arg_1_1)
	FriendDormShip.super.Ctor(self, arg_1_1)

	self.configId = arg_1_1.tid
	self.skinId = arg_1_1.skin_id

	return
end

function FriendDormShip:ToBayShip()
	return (Ship.New({
		energy = 100,
		id = self.id,
		configId = self.configId,
		skin_id = self.skinId
	}))
end

return FriendDormShip
