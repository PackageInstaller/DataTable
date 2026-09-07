ys = ys or {}
ys.Battle.BattleBuffOverHealingShield = class("BattleBuffOverHealingShield", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffOverHealingShield.__name = "BattleBuffOverHealingShield"

local var_0_0 = ys.Battle.BattleBuffOverHealingShield

function ys.Battle.BattleBuffOverHealingShield.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffOverHealingShield:SetArgs(arg_2_1, arg_2_2)
	self._shieldDuration = self._tempData.arg_list.shield_duration
	self._shieldRate = self._tempData.arg_list.shield_rate
	self._shieldLabel = self._tempData.arg_list.shield_tag_list or {}
	self._shieldList = {}

	return
end

function ys.Battle.BattleBuffOverHealingShield:onOverHealing(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = math.ceil(arg_3_3.overHealing * self._shieldRate)

	if var_3_0 > 0 then
		table.insert(self._shieldList, {
			timeStamp = pg.TimeMgr.GetInstance():GetCombatTime(),
			value = var_3_0
		})
	end

	self:updateLabelTag(arg_3_1)

	return
end

function ys.Battle.BattleBuffOverHealingShield:onUpdate(arg_4_1, arg_4_2)
	local var_4_0 = pg.TimeMgr.GetInstance():GetCombatTime() - self._shieldDuration

	while #self._shieldList > 0 do
		if var_4_0 >= self._shieldList[#self._shieldList].timeStamp then
			table.remove(self._shieldList, #self._shieldList)
		end
	end

	self:updateLabelTag(arg_4_1)

	return
end

function ys.Battle.BattleBuffOverHealingShield:onTakeDamage(arg_5_1, arg_5_2, arg_5_3)
	if self:damageCheck(arg_5_3) and #self._shieldList > 0 then
		local var_5_0 = arg_5_3.damage
		local var_5_1 = 0

		while var_5_0 > 0 and var_5_1 < #self._shieldList do
			var_5_1 = var_5_1 + 1

			if var_5_0 <= self._shieldList[var_5_1].value then
				self._shieldList[var_5_1].value = self._shieldList[var_5_1].value - var_5_0
				var_5_0 = 0
			else
				var_5_0 = var_5_0 - self._shieldList[var_5_1].value
				self._shieldList[var_5_1].value = 0
			end
		end

		arg_5_3.damage = var_5_0

		while #self._shieldList > 0 do
			if self._shieldList[#self._shieldList].value <= 0 then
				table.remove(self._shieldList, #self._shieldList)
			end
		end

		self:updateLabelTag(arg_5_1)
	end

	return
end

function ys.Battle.BattleBuffOverHealingShield:updateLabelTag(arg_6_1)
	if #self._shieldList <= 0 then
		for iter_6_0, iter_6_1 in ipairs(self._shieldLabel) do
			arg_6_1:RemoveLabelTag(iter_6_1)
		end
	elseif not arg_6_1:ContainsLabelTag(self._shieldLabel) then
		for iter_6_2, iter_6_3 in ipairs(self._shieldLabel) do
			arg_6_1:AddLabelTag(iter_6_3)
		end
	end

	return
end

return
