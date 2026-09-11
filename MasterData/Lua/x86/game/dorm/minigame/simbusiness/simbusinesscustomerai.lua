local SimBusinessCustomerAI = class("SimBusinessCustomerAI")

local function var_0_1(arg_1_0)
	return nullable(Dorm.storage:PickData("sim.pos." .. arg_1_0), "transform")
end

function SimBusinessCustomerAI:Ctor()
	self.entityList = {}
	self.eventListener = EventListener.New()
end

function SimBusinessCustomerAI:Init()
	self.eventListener:Register(ON_DORM_CHARACTER_MOVE_PICK_INTERACT_AREA, handler(self, self.OnEnterInteractArea))
	self.eventListener:Register(ON_DORM_CHARACTER_WAIT_CMD, handler(self, self.OnWaitCmd))
end

function SimBusinessCustomerAI:Reset()
	self.eventListener:RemoveAll()

	self.entityList = {}
end

function SimBusinessCustomerAI:Add(arg_5_1)
	self.entityList[arg_5_1] = {}
end

function SimBusinessCustomerAI:Remove(arg_6_1)
	self.entityList[arg_6_1] = nil
end

local function var_0_2(arg_7_0, arg_7_1)
	if SimBusinessGoodsCfg[arg_7_1] == nil then
		return false
	end

	local var_7_0 = SimBusinessGuestCfg[DormUtils.GetEntityData(arg_7_0).cfgID].love_type

	if var_7_0 == SimBusinessGoodsCfg[arg_7_1].type then
		return true
	end

	if SimBusinessGoodsTrait.GoodsTraitAffectPreference(arg_7_1, var_7_0) then
		return true
	end

	return false
end

function SimBusinessCustomerAI:OnEnterInteractArea(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	local var_8_0 = self.entityList[arg_8_1]
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
	map = function(self)
		if self.exit then
			return 0
		end

		return 1
	end
}
local var_0_4 = {
	map = function(self)
		return Dorm.DormEntityManager.QueryPosition(self.target)
	end,
	lessOp = function(self, arg_11_1)
		if self.z == arg_11_1.z then
			return self.x < arg_11_1.x
		end

		return self.z < arg_11_1.z
	end
}

function SimBusinessCustomerAI:OnWaitCmd(arg_12_1)
	print("SimBusinessCustomerAI::OnWaitCmd", arg_12_1)

	self.entityList[arg_12_1] = {}
	DormUtils.GetEntityData(arg_12_1).simBussiness = self.entityList[arg_12_1]

	CommonTools.UniversalSortEx(self.entityList[arg_12_1], var_0_3, var_0_4)

	local var_12_0

	for iter_12_0, iter_12_1 in ipairs(self.entityList[arg_12_1]) do
		if iter_12_1.interactPos then
			Dorm.DormEntityManager.SendMoveLookToDirCMD(arg_12_1, iter_12_1.interactPos, true, true)
		end

		if iter_12_1.exit then
			DormCharacterInteractBehaviour.SendCustomInteract(arg_12_1, iter_12_1.target, SimBusinessGame.exitAction, true)

			var_12_0 = true

			break
		else
			Dorm.DormEntityManager.SendInteractToEntityCMD(arg_12_1, iter_12_1.target, iter_12_1.action, true)
			DormCharacterInteractBehaviour.SendCustomInteract(arg_12_1, iter_12_1.target, SimBusinessGame.settlementAction, true)
		end

		if iter_12_1.exitPos then
			Dorm.DormEntityManager.SendMoveLookToDirCMD(arg_12_1, iter_12_1.exitPos, true, true)
		end
	end

	if not var_12_0 then
		SimBusinessMgr.SendMoveToExitMoveCMD(arg_12_1, var_0_1("exit"), true)
	end
end

return SimBusinessCustomerAI
