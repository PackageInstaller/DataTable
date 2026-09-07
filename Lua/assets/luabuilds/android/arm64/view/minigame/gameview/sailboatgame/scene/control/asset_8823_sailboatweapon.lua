local SailBoatWeapon = class("SailBoatWeapon")
local var_0_1

function SailBoatWeapon:Ctor(arg_1_1)
	var_0_1 = SailBoatGameVo
	self._data = arg_1_1
	self._fireTime = nil

	return
end

function SailBoatWeapon:start()
	self._fireTime = self:getConfig("cd")

	return
end

function SailBoatWeapon:step(arg_3_1)
	if self._fireTime and self._fireTime > 0 then
		self._fireTime = self._fireTime - arg_3_1

		if self._fireTime < 0 then
			self._fireTime = 0
		end
	else
		self._fireTime = 0
	end

	return
end

function SailBoatWeapon:skillStep(arg_4_1)
	self._fireTime = self._fireTime - arg_4_1

	return
end

function SailBoatWeapon:getFireAble()
	if self._fireTime and self._fireTime > 0 then
		return false
	end

	return true
end

function SailBoatWeapon:fire()
	if not self:getFireAble() then
		return nil
	end

	self._fireTime = self:getConfig("cd")

	return self:getFireData()
end

function SailBoatWeapon:getFireTime()
	return self._fireTime or 0
end

function SailBoatWeapon:getFireData()
	return Clone(self._data)
end

function SailBoatWeapon:getAngel()
	return self:getConfig("angel")
end

function SailBoatWeapon:getDistance()
	return self:getConfig("distance")
end

function SailBoatWeapon:getDamage()
	return self:getConfig("damage")
end

function SailBoatWeapon:getFireFlag()
	return self._fireTime == 0
end

function SailBoatWeapon:getConfig(arg_13_1)
	return self._data[arg_13_1]
end

function SailBoatWeapon:clear()
	self._data = nil

	return
end

return SailBoatWeapon
