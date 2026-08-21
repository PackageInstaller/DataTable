local var_0_0 = false

function Dorm.Enter()
	var_0_0 = true
end

function Dorm.Leave()
	var_0_0 = false
end

function Dorm.InvokeEvent(arg_3_0, ...)
	if var_0_0 then
		manager.notify:Invoke(arg_3_0, ...)
	end
end

function Dorm.InvokeEntityEvent(arg_4_0, arg_4_1, ...)
	if var_0_0 then
		manager.notify:Invoke(arg_4_0, arg_4_1, ...)
	end
end

function Dorm.RecordItemTagData(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = Dorm.sceneItemInfo[arg_5_0] or {}

	var_5_0[arg_5_1] = arg_5_2
	Dorm.sceneItemInfo[arg_5_0] = var_5_0
end

local var_0_1 = {}

local function var_0_2(arg_6_0, arg_6_1)
	table.insert(var_0_1, {
		arg_6_0,
		arg_6_1
	})
end

local function var_0_3(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	Dorm.DormEntityManager.SendMoveCMD(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
end

local function var_0_4(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	Dorm.DormEntityManager.SendMoveLookAtCMD(arg_8_0, arg_8_1, arg_8_2 or arg_8_1, arg_8_3, arg_8_4)
end

local function var_0_5(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	Dorm.DormEntityManager.SendMoveLookToDirCMD(arg_9_0, arg_9_1, arg_9_2 or arg_9_1, arg_9_3, arg_9_4)
end

local function var_0_6(arg_10_0, arg_10_1, arg_10_2)
	Dorm.DormEntityManager.SendRndWanderMoveCMD(arg_10_0, arg_10_1, arg_10_2)
end

local function var_0_7(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2 = arg_11_2 == nil and true or arg_11_2

	Dorm.DormEntityManager.SendInteractToEntityCMD(arg_11_0, arg_11_1, arg_11_2)
end

function DormRegisterCMDEvent()
	for iter_12_0, iter_12_1 in ipairs(var_0_1) do
		local var_12_0, var_12_1, var_12_2 = unpack(iter_12_1)

		if not var_12_2 then
			manager.notify:RegistListener(var_12_0, var_12_1)

			iter_12_1[3] = true
		end
	end
end

function DormEventInvoke(arg_13_0, arg_13_1, arg_13_2, ...)
	manager.notify:Invoke(arg_13_0, arg_13_2, ...)
	Dorm.storage:RecordData(DormEnum.Namespace.EntityCurrentAction, arg_13_2, arg_13_1)
end

var_0_2(DORM_CHARACTER_MOVE, var_0_3)
var_0_2(DORM_CHARACTER_MOVE_LOOK_AT, var_0_4)
var_0_2(DORM_CHARACTER_MOVE_LOOK_TO_DIR, var_0_5)
var_0_2(DORM_CHARACTER_MOVE_WANDER, var_0_6)
var_0_2(DORM_CHARACTER_INTERACT, var_0_7)
