ys = ys or {}

local var_0_0 = ys.Battle.BattleConfig.TorpedoCFG
local BattleTorpedoWeaponVO = class("BattleTorpedoWeaponVO", ys.Battle.BattlePlayerWeaponVO)

ys.Battle.BattleTorpedoWeaponVO = BattleTorpedoWeaponVO
BattleTorpedoWeaponVO.__name = "BattleTorpedoWeaponVO"

function BattleTorpedoWeaponVO:Ctor()
	BattleTorpedoWeaponVO.super.Ctor(self, var_0_0.GCD)

	return
end

function BattleTorpedoWeaponVO:AppendWeapon(arg_2_1)
	BattleTorpedoWeaponVO.super.AppendWeapon(self, arg_2_1)
	arg_2_1:SetPlayerTorpedoWeaponVO(self)

	return
end

function BattleTorpedoWeaponVO:GetCurrentWeaponIconIndex()
	return 2
end

return
