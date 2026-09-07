ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleUnitEvent

ys.Battle.ManualWeaponQueue = class("ManualWeaponQueue")
ys.Battle.ManualWeaponQueue.__name = "ManualWeaponQueue"

function ys.Battle.ManualWeaponQueue:Ctor(arg_1_1)
	self:init()

	self._maxCount = arg_1_1 or 1

	return
end

function ys.Battle.ManualWeaponQueue.init(arg_2_0)
	var_0_0.EventListener.AttachEventListener(arg_2_0)

	arg_2_0._weaponList = {}
	arg_2_0._overheatQueue = {}
	arg_2_0._cooldownList = {}

	return
end

function ys.Battle.ManualWeaponQueue:AppendWeapon(arg_3_1)
	self._weaponList[arg_3_1] = true

	self:addWeaponEvent(arg_3_1)

	if arg_3_1:GetCurrentState() == arg_3_1.STATE_OVER_HEAT then
		self._overheatQueue[#self._overheatQueue + 1] = arg_3_1
	end

	return
end

function ys.Battle.ManualWeaponQueue:RemoveWeapon(arg_4_1)
	self._weaponList[arg_4_1] = nil

	self:removeWeaponEvent(arg_4_1)

	for iter_4_0, iter_4_1 in ipairs(self._overheatQueue) do
		if iter_4_1 == arg_4_1 then
			table.remove(self._overheatQueue, iter_4_0)

			break
		end
	end

	for iter_4_2, iter_4_3 in ipairs(self._cooldownList) do
		if iter_4_3 == arg_4_1 then
			table.remove(self._cooldownList, iter_4_2)
		end
	end

	return
end

function ys.Battle.ManualWeaponQueue:Containers(arg_5_1)
	return self._weaponList[arg_5_1]
end

function ys.Battle.ManualWeaponQueue:GetCoolDownList()
	return self._cooldownList
end

function ys.Battle.ManualWeaponQueue:GetQueueHead()
	return self._overheatQueue[#self._overheatQueue] or self._cooldownList[1]
end

function ys.Battle.ManualWeaponQueue:CheckWeaponInitalCD()
	for iter_8_0, iter_8_1 in pairs(self._weaponList) do
		if not iter_8_0:GetModifyInitialCD() then
			self._overheatQueue[#self._overheatQueue + 1] = iter_8_0
		end
	end

	while #self._cooldownList < self._maxCount and #self._overheatQueue > 0 do
		local var_8_0 = table.remove(self._overheatQueue, 1)

		var_8_0:InitialCD()

		self._cooldownList[#self._cooldownList + 1] = var_8_0
	end

	for iter_8_2, iter_8_3 in ipairs(self._overheatQueue) do
		iter_8_3:OverHeat()
	end

	return
end

function ys.Battle.ManualWeaponQueue:FlushWeaponReloadRequire()
	for iter_9_0, iter_9_1 in pairs(self._weaponList) do
		iter_9_0:FlushReloadRequire()
	end

	return
end

function ys.Battle.ManualWeaponQueue:Clear()
	for iter_10_0, iter_10_1 in pairs(self._weaponList) do
		self:removeWeaponEvent(iter_10_0)
	end

	self._weaponList = nil
	self._overheatQueue = nil

	var_0_0.EventListener.DetachEventListener(self)

	return
end

function ys.Battle.ManualWeaponQueue:addWeaponEvent(arg_11_1)
	arg_11_1:RegisterEventListener(self, var_0_2.MANUAL_WEAPON_FIRE, self.onManualWeaponFire)
	arg_11_1:RegisterEventListener(self, var_0_2.MANUAL_WEAPON_READY, self.onManualWeaponReady)
	arg_11_1:RegisterEventListener(self, var_0_2.MANUAL_WEAPON_INSTANT_READY, self.onManualInstantReady)

	return
end

function ys.Battle.ManualWeaponQueue.removeWeaponEvent(arg_12_0, arg_12_1)
	arg_12_1:UnregisterEventListener(arg_12_0, var_0_2.MANUAL_WEAPON_READY)
	arg_12_1:UnregisterEventListener(arg_12_0, var_0_2.MANUAL_WEAPON_FIRE)
	arg_12_1:UnregisterEventListener(arg_12_0, var_0_2.MANUAL_WEAPON_INSTANT_READY)

	return
end

function ys.Battle.ManualWeaponQueue:onManualWeaponFire(arg_13_1)
	arg_13_1.Dispatcher:OverHeat()

	self._overheatQueue[#self._overheatQueue + 1] = arg_13_1.Dispatcher

	self:fillCooldownList()

	return
end

function ys.Battle.ManualWeaponQueue:onManualWeaponReady(arg_14_1)
	self:removeFromCDList(arg_14_1.Dispatcher)
	self:fillCooldownList()

	return
end

function ys.Battle.ManualWeaponQueue:onManualInstantReady(arg_15_1)
	local var_15_0

	for iter_15_0, iter_15_1 in ipairs(self._overheatQueue) do
		if arg_15_1.Dispatcher == iter_15_1 then
			table.remove(self._overheatQueue, iter_15_0)

			var_15_0 = true

			break
		end
	end

	if not var_15_0 then
		self:removeFromCDList(arg_15_1.Dispatcher)
	end

	self:fillCooldownList()

	return
end

function ys.Battle.ManualWeaponQueue:removeFromCDList(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(self._cooldownList) do
		if arg_16_1 == iter_16_1 then
			table.remove(self._cooldownList, iter_16_0)

			break
		end
	end

	return
end

function ys.Battle.ManualWeaponQueue:fillCooldownList()
	while #self._cooldownList < self._maxCount and #self._overheatQueue > 0 do
		local var_17_0 = table.remove(self._overheatQueue, 1)

		var_17_0:EnterCoolDown()

		self._cooldownList[#self._cooldownList + 1] = var_17_0
	end

	return
end

return
