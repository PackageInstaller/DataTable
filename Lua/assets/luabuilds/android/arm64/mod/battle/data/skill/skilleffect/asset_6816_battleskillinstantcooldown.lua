ys = ys or {}

local BattleSkillInstantCoolDown = class("BattleSkillInstantCoolDown", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillInstantCoolDown = BattleSkillInstantCoolDown
BattleSkillInstantCoolDown.__name = "BattleSkillInstantCoolDown"

function BattleSkillInstantCoolDown:Ctor(arg_1_1)
	BattleSkillInstantCoolDown.super.Ctor(self, arg_1_1, lv)

	self._weaponType = self._tempData.arg_list.weaponType

	return
end

function BattleSkillInstantCoolDown:DoDataEffect(arg_2_1, arg_2_2)
	local var_2_0 = self:_GetWeapon(arg_2_1)

	if var_2_0 then
		var_2_0:QuickCoolDown()
	end

	return
end

function BattleSkillInstantCoolDown:DoDataEffectWithoutTarget(arg_3_1)
	self:DoDataEffect(arg_3_1, nil)

	return
end

function BattleSkillInstantCoolDown:_GetWeapon(arg_4_1)
	return (self._weaponType == "AirAssist" or nil) and arg_4_1:GetAirAssistQueue():GetQueueHead()
end

return
