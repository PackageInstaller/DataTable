ys = ys or {}

local BattleBuffRemoteBone = class("BattleBuffRemoteBone", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffRemoteBone = BattleBuffRemoteBone
BattleBuffRemoteBone.__name = "BattleBuffRemoteBone"

function BattleBuffRemoteBone:Ctor(arg_1_1)
	BattleBuffRemoteBone.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffRemoteBone:SetArgs(arg_2_1, arg_2_2)
	self._group = arg_2_2:GetID()
	self._targetChoice = self._tempData.arg_list.bone_target
	self._bone = self._tempData.arg_list.bone_name

	return
end

function BattleBuffRemoteBone:onAttach(arg_3_1, arg_3_2)
	arg_3_1:SetRemoteBoundBone(self._group, self._bone, self._targetChoice)

	return
end

function BattleBuffRemoteBone:onRemove(arg_4_1, arg_4_2)
	arg_4_1:RemoveRemoteBoundBone(self._group)

	return
end

return
