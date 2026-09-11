local ReserveHeroPosTemplate = class("ReserveHeroPosTemplate")

function ReserveHeroPosTemplate:Ctor()
	self.x = 0
	self.y = 0
end

function ReserveHeroPosTemplate:UpdateServerData(arg_2_1)
	self.x = arg_2_1.x
	self.y = arg_2_1.y
end

return ReserveHeroPosTemplate
