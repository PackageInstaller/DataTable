local PublicArg = class("PublicArg")

PublicArg.TypePlayerName = 1
PublicArg.TypeShipId = 2
PublicArg.TypeEquipId = 3
PublicArg.TypeItemId = 4
PublicArg.TypeNums = 5
PublicArg.TypeWorldBoss = 6

function PublicArg:Ctor(arg_1_1)
	self.type = arg_1_1.type
	self.string = arg_1_1.string
	self.int = arg_1_1.int

	return
end

return PublicArg
