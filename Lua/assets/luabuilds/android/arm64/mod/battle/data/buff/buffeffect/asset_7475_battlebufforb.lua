ys = ys or {}

local BattleBuffOrb = class("BattleBuffOrb", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffOrb = BattleBuffOrb
BattleBuffOrb.__name = "BattleBuffOrb"

function BattleBuffOrb:Ctor(arg_1_1)
	BattleBuffOrb.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffOrb:SetArgs(arg_2_1, arg_2_2)
	self._buffID = self._tempData.arg_list.buff_id
	self._rant = self._tempData.arg_list.rant or 10000
	self._level = self._tempData.arg_list.level or 1
	self._buffLevel = self._tempData.arg_list.buff_level or 1
	self._type = self._tempData.arg_list.type

	return
end

function BattleBuffOrb:onTrigger(arg_3_1, arg_3_2, arg_3_3)
	if self._type and arg_3_3._bullet:GetTemplate().type ~= self._type then
		return
	end

	self:attachOrb(arg_3_3._bullet)
	BattleBuffOrb.super.onTrigger(self, arg_3_1, arg_3_2, arg_3_3)

	return
end

function BattleBuffOrb:attachOrb(arg_4_1)
	arg_4_1:AppendAttachBuff({
		buff_id = self._buffID,
		rant = self._rant,
		level = self._level,
		buff_level = self._buffLevel
	})

	return
end

return
