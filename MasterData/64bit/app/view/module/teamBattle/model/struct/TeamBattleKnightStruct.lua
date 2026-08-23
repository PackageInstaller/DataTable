local TeamBattleKnightStruct = class("TeamBattleKnightStruct", (require("app.view.module.knight.model.KnightStruct")))

function TeamBattleKnightStruct:ctor(arg_1_1)
	TeamBattleKnightStruct.super.ctor(self, arg_1_1)

	self._hpRatio = 1000
end

function TeamBattleKnightStruct:updateHpRatio(arg_2_1)
	self._hpRatio = arg_2_1
end

function TeamBattleKnightStruct:getHpRatio()
	return self._hpRatio
end

function TeamBattleKnightStruct:getHpPercent()
	return self._hpRatio / 10
end

function TeamBattleKnightStruct:resetHpRatio()
	self._hpRatio = 1000
end

return TeamBattleKnightStruct
