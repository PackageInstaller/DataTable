local ReversePacmanDormShip = class("ReversePacmanDormShip", import("model.vo.Ship"))

function ReversePacmanDormShip:Ctor(arg_1_1)
	ReversePacmanDormShip.super.Ctor(self, arg_1_1)

	self.roleID = arg_1_1.roleID

	return
end

return ReversePacmanDormShip
