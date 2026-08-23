local BattleConst = require("app.view.battle.const.BattleConst")
local SpineEffect = class("SpineEffect", require("app.view.common.SpineBase"))

function SpineEffect:ctor(arg_1_1)
	if type(arg_1_1) ~= "table" then
		arg_1_1 = {}
	end

	assert(arg_1_1.resId, "cannot create spine without resId")

	arg_1_1.path = g.core.common.Path:getEffSpine(arg_1_1.resId)
	arg_1_1.anim = BattleConst.SPINE_ACTION_TYPE.PLAY

	SpineEffect.super.ctor(self, arg_1_1)

	self._spineType = BattleConst.SPINE_TYPE.GAME
end

return SpineEffect
