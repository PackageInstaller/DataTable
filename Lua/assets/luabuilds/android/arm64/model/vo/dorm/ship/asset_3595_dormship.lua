local DormShip = class("DormShip")

DormShip.FLOOR_1 = 1
DormShip.FLOOR_2 = 2

function DormShip:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.floor = arg_1_1.floor
	self.moneny = arg_1_1.pop_icon or 0
	self.intimacy = arg_1_1.pop_intimacy or 0

	return
end

function DormShip:IsSameFloor(arg_2_1)
	return self.floor == arg_2_1
end

function DormShip:AddmoneyAndIntimacy(arg_3_1, arg_3_2)
	self.moneny = arg_3_1
	self.intimacy = arg_3_2

	return
end

function DormShip:GetInimacy()
	return self.intimacy
end

function DormShip:HasMoneyOrIntimacy()
	return self:HasMoney() or self:HasIntimacy()
end

function DormShip:HasMoney()
	return self.moneny > 0
end

function DormShip:GetMoney()
	return self.moneny
end

function DormShip:HasIntimacy()
	return self.intimacy > 0
end

function DormShip:GetIntimacy()
	return self.intimacy
end

function DormShip:ClearMoneyAndIntimacy()
	self:ClearMoney()
	self:ClearIntimacy()

	return
end

function DormShip:ClearMoney()
	self.moneny = 0

	return
end

function DormShip:ClearIntimacy()
	self.intimacy = 0

	return
end

function DormShip:IsSame(arg_13_1)
	return self.id == arg_13_1
end

function DormShip:ToBayShip()
	return (getProxy(BayProxy):RawGetShipById(self.id))
end

return DormShip
