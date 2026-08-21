ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleUnitEvent

ys.Battle.ManualWeaponQueue = class("ManualWeaponQueue")
ys.Battle.ManualWeaponQueue.__name = "ManualWeaponQueue"

function ys.Battle.ManualWeaponQueue.Ctor(arg_1_0, arg_1_1)
	arg_1_0:init()

	arg_1_0._maxCount = arg_1_1 or 1

	return
end

function ys.Battle.ManualWeaponQueue.init(arg_2_0)
	var_0_0.EventListener.AttachEventListener(arg_2_0)

	arg_2_0._weaponList = {}
	arg_2_0._overheatQueue = {}
	arg_2_0._cooldownList = {}

	return
end

function ys.Battle.ManualWeaponQueue.AppendWeapon(arg_3_0, arg_3_1)
	arg_3_0._weaponList[arg_3_1] = true

	arg_3_0:addWeaponEvent(arg_3_1)

	if arg_3_1:GetCurrentState() == arg_3_1.STATE_OVER_HEAT then
		arg_3_0._overheatQueue[#arg_3_0._overheatQueue + 1] = arg_3_1
	end

	return
end

function ys.Battle.ManualWeaponQueue.RemoveWeapon(arg_4_0, arg_4_1)
	arg_4_0._weaponList[arg_4_1] = nil

	arg_4_0:removeWeaponEvent(arg_4_1)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._overheatQueue) do
		if iter_4_1 == arg_4_1 then
			table.remove(arg_4_0._overheatQueue, iter_4_0)

			break
		end
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_0._cooldownList) do
		if iter_4_3 == arg_4_1 then
			table.remove(arg_4_0._cooldownList, iter_4_2)
		end
	end

	return
end

function ys.Battle.ManualWeaponQueue.Containers(arg_5_0, arg_5_1)
	return arg_5_0._weaponList[arg_5_1]
end

function ys.Battle.ManualWeaponQueue.GetCoolDownList(arg_6_0)
	return arg_6_0._cooldownList
end

function ys.Battle.ManualWeaponQueue.GetQueueHead(arg_7_0)
	return arg_7_0._overheatQueue[#arg_7_0._overheatQueue] or arg_7_0._cooldownList[1]
end

function ys.Battle.ManualWeaponQueue.CheckWeaponInitalCD(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._weaponList) do
		if not iter_8_0:GetModifyInitialCD() then
			arg_8_0._overheatQueue[#arg_8_0._overheatQueue + 1] = iter_8_0
		end
	end

	while #arg_8_0._cooldownList < arg_8_0._maxCount and #arg_8_0._overheatQueue > 0 do
		local var_8_0 = table.remove(arg_8_0._overheatQueue, 1)

		var_8_0:InitialCD()

		arg_8_0._cooldownList[#arg_8_0._cooldownList + 1] = var_8_0
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_0._overheatQueue) do
		iter_8_3:OverHeat()
	end

	return
end

function ys.Battle.ManualWeaponQueue.FlushWeaponReloadRequire(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._weaponList) do
		iter_9_0:FlushReloadRequire()
	end

	return
end

function ys.Battle.ManualWeaponQueue.Clear(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._weaponList) do
		arg_10_0:removeWeaponEvent(iter_10_0)
	end

	arg_10_0._weaponList = nil
	arg_10_0._overheatQueue = nil

	var_0_0.EventListener.DetachEventListener(arg_10_0)

	return
end

function ys.Battle.ManualWeaponQueue.addWeaponEvent(arg_11_0, arg_11_1)
	arg_11_1:RegisterEventListener(arg_11_0, var_0_2.MANUAL_WEAPON_FIRE, arg_11_0.onManualWeaponFire)
	arg_11_1:RegisterEventListener(arg_11_0, var_0_2.MANUAL_WEAPON_READY, arg_11_0.onManualWeaponReady)
	arg_11_1:RegisterEventListener(arg_11_0, var_0_2.MANUAL_WEAPON_INSTANT_READY, arg_11_0.onManualInstantReady)

	return
end

function ys.Battle.ManualWeaponQueue.removeWeaponEvent(arg_12_0, arg_12_1)
	arg_12_1:UnregisterEventListener(arg_12_0, var_0_2.MANUAL_WEAPON_READY)
	arg_12_1:UnregisterEventListener(arg_12_0, var_0_2.MANUAL_WEAPON_FIRE)
	arg_12_1:UnregisterEventListener(arg_12_0, var_0_2.MANUAL_WEAPON_INSTANT_READY)

	return
end

function ys.Battle.ManualWeaponQueue.onManualWeaponFire(arg_13_0, arg_13_1)
	arg_13_1.Dispatcher:OverHeat()

	arg_13_0._overheatQueue[#arg_13_0._overheatQueue + 1] = arg_13_1.Dispatcher

	arg_13_0:fillCooldownList()

	return
end

function ys.Battle.ManualWeaponQueue.onManualWeaponReady(arg_14_0, arg_14_1)
	arg_14_0:removeFromCDList(arg_14_1.Dispatcher)
	arg_14_0:fillCooldownList()

	return
end

function ys.Battle.ManualWeaponQueue.onManualInstantReady(arg_15_0, arg_15_1)
	local var_15_0

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._overheatQueue) do
		if arg_15_1.Dispatcher == iter_15_1 then
			table.remove(arg_15_0._overheatQueue, iter_15_0)

			var_15_0 = true

			break
		end
	end

	if not var_15_0 then
		arg_15_0:removeFromCDList(arg_15_1.Dispatcher)
	end

	arg_15_0:fillCooldownList()

	return
end

function ys.Battle.ManualWeaponQueue.removeFromCDList(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0._cooldownList) do
		if arg_16_1 == iter_16_1 then
			table.remove(arg_16_0._cooldownList, iter_16_0)

			break
		end
	end

	return
end

function ys.Battle.ManualWeaponQueue.fillCooldownList(arg_17_0)
	while #arg_17_0._cooldownList < arg_17_0._maxCount and #arg_17_0._overheatQueue > 0 do
		local var_17_0 = table.remove(arg_17_0._overheatQueue, 1)

		var_17_0:EnterCoolDown()

		arg_17_0._cooldownList[#arg_17_0._cooldownList + 1] = var_17_0
	end

	return
end

return
