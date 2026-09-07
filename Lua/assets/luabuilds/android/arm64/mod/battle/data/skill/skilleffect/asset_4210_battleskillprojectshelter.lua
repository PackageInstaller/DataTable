ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleEvent
local var_0_2 = ys.Battle.BattleConfig
local BattleSkillProjectShelter = class("BattleSkillProjectShelter", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillProjectShelter = BattleSkillProjectShelter
BattleSkillProjectShelter.__name = "BattleSkillProjectShelter"

function BattleSkillProjectShelter:Ctor(arg_1_1, arg_1_2)
	BattleSkillProjectShelter.super.Ctor(self, arg_1_1, arg_1_2)

	self._duration = self._tempData.arg_list.duration
	self._offset = self._tempData.arg_list.offset
	self._fxID = self._tempData.arg_list.effect
	self._box = self._tempData.arg_list.box
	self._count = self._tempData.arg_list.count

	return
end

function BattleSkillProjectShelter:DoDataEffect(arg_2_1)
	local var_2_0 = var_0_0.Battle.BattleDataProxy.GetInstance()
	local var_2_1 = var_2_0:SpawnShelter(self._box, self._duration)
	local var_2_2 = arg_2_1:GetIFF()

	if var_2_2 == var_0_2.FOE_CODE then
		self._offset[1] = self._offset[1] * -1
	end

	local var_2_3 = arg_2_1:GetPosition() + BuildVector3(self._offset)

	var_2_1:SetIFF(var_2_2)
	var_2_1:SetArgs(self._count, self._duration, self._box, var_2_3, self._fxID)
	var_2_1:SetStartTimeStamp(pg.TimeMgr.GetInstance():GetCombatTime())
	var_2_0:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_SHELTER, {
		shelter = var_2_1
	}))

	return
end

function BattleSkillProjectShelter:DataEffectWithoutTarget(arg_3_1)
	self:DoDataEffect(arg_3_1)

	return
end

return
