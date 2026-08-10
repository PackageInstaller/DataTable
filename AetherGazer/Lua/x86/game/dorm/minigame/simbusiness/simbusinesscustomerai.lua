local var_0_0 = class("SimBusinessCustomerAI")

local function var_0_1(arg_1_0)
	local var_1_0 = "sim.pos." .. arg_1_0

	return nullable(Dorm.storage:PickData(var_1_0), "transform")
end

function var_0_0.Ctor(arg_2_0)
	arg_2_0.entityList = {}
	arg_2_0.eventListener = EventListener.New()
end

function var_0_0.Init(arg_3_0)
	arg_3_0.eventListener:Register(ON_DORM_CHARACTER_MOVE_PICK_INTERACT_AREA, handler(arg_3_0, arg_3_0.OnEnterInteractArea))
	arg_3_0.eventListener:Register(ON_DORM_CHARACTER_WAIT_CMD, handler(arg_3_0, arg_3_0.OnWaitCmd))
end

function var_0_0.Reset(arg_4_0)
	arg_4_0.eventListener:RemoveAll()

	arg_4_0.entityList = {}
end

function var_0_0.Add(arg_5_0, arg_5_1)
	arg_5_0.entityList[arg_5_1] = {}
end

function var_0_0.Remove(arg_6_0, arg_6_1)
	arg_6_0.entityList[arg_6_1] = nil
end

local function var_0_2(arg_7_0, arg_7_1)
	local var_7_0 = SimBusinessGoodsCfg[arg_7_1]

	if var_7_0 == nil then
		return false
	end

	local var_7_1 = DormUtils.GetEntityData(arg_7_0).cfgID
	local var_7_2 = SimBusinessGuestCfg[var_7_1].love_type

	if var_7_2 == var_7_0.type then
		return true
	end

	if SimBusinessGoodsTrait.GoodsTraitAffectPreference(arg_7_1, var_7_2) then
		return true
	end

	return false
end

function var_0_0.OnEnterInteractArea(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	local var_8_0 = arg_8_0.entityList[arg_8_1]
	local var_8_1 = {
		target = arg_8_2,
		interactPos = arg_8_3,
		exitPos = arg_8_4,
		action = arg_8_5
	}

	if arg_8_2 == Dorm.storage:GetData("sim.entity.exit", 1) then
		var_8_1.exit = true
	elseif arg_8_5 then
		if DormUtils.GetEntityData(arg_8_1).hp <= 0 or not var_0_2(arg_8_1, DormUtils.GetEntityData(arg_8_2).goods) then
			return
		end
	else
		return
	end

	table.insert(var_8_0, var_8_1)
	Dorm.DormEntityManager.StopCurRunningCmd(arg_8_1)
end

local var_0_3 = {
	map = function(arg_9_0)
		if arg_9_0.exit then
			return 0
		end

		return 1
	end
}
local var_0_4 = {
	map = function(arg_10_0)
		return Dorm.DormEntityManager.QueryPosition(arg_10_0.target)
	end,
	lessOp = function(arg_11_0, arg_11_1)
		if arg_11_0.z == arg_11_1.z then
			return arg_11_0.x < arg_11_1.x
		end

		return arg_11_0.z < arg_11_1.z
	end
}

function var_0_0.OnWaitCmd(arg_12_0, arg_12_1)
	print("SimBusinessCustomerAI::OnWaitCmd", arg_12_1)

	local var_12_0 = arg_12_0.entityList[arg_12_1]

	arg_12_0.entityList[arg_12_1] = {}
	DormUtils.GetEntityData(arg_12_1).simBussiness = var_12_0

	CommonTools.UniversalSortEx(var_12_0, var_0_3, var_0_4)

	local var_12_1

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_2 = iter_12_1.target
		local var_12_3 = iter_12_1.action
		local var_12_4 = iter_12_1.interactPos
		local var_12_5 = iter_12_1.exitPos

		if var_12_4 then
			Dorm.DormEntityManager.SendMoveLookToDirCMD(arg_12_1, var_12_4, true, true)
		end

		if iter_12_1.exit then
			DormCharacterInteractBehaviour.SendCustomInteract(arg_12_1, var_12_2, SimBusinessGame.exitAction, true)

			var_12_1 = true

			break
		else
			Dorm.DormEntityManager.SendInteractToEntityCMD(arg_12_1, var_12_2, var_12_3, true)
			DormCharacterInteractBehaviour.SendCustomInteract(arg_12_1, var_12_2, SimBusinessGame.settlementAction, true)
		end

		if var_12_5 then
			Dorm.DormEntityManager.SendMoveLookToDirCMD(arg_12_1, var_12_5, true, true)
		end
	end

	if not var_12_1 then
		SimBusinessMgr.SendMoveToExitMoveCMD(arg_12_1, var_0_1("exit"), true)
	end
end

return var_0_0
