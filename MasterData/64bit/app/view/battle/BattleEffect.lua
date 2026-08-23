local BattlePath = require("app.view.battle.BattlePath")
local BattleConst = require("app.view.battle.const.BattleConst")
local BattleEffect = class("BattleEffect", require("app.view.common.SpineBase"))

function BattleEffect:ctor(arg_1_1, arg_1_2)
	if type(arg_1_1) ~= "table" then
		arg_1_1 = {}
	end

	self._battleLayer = arg_1_2

	if arg_1_1.resId then
		arg_1_1.path = BattlePath.getSpineEffectPath(arg_1_1.resId)
	else
		arg_1_1.resId = ""
	end

	assert(arg_1_1.resId, "cannot create spine without resId")

	arg_1_1.anim = arg_1_1.anim or BattleConst.SPINE_ACTION_TYPE.PLAY

	BattleEffect.super.ctor(self, arg_1_1)

	self._spineType = BattleConst.SPINE_TYPE.EFFECT
end

function BattleEffect:_parsingJsonFile()
	BattleEffect.super._parsingJsonFile(self)

	if self._jsonData then
		for iter_2_0, iter_2_1 in pairs(self._jsonData) do
			if iter_2_0 ~= "name" then
				if iter_2_1.cri then
					self:addCriSpriteAtSlot({
						movieName = iter_2_1.cri
					}, iter_2_0)
				end

				if iter_2_1.effect then
					local var_2_0 = {
						resId = iter_2_1.effect
					}

					var_2_0.isLoop = false

					self:addSpineEffectAtSlot(var_2_0, iter_2_0)
				end
			end
		end
	end
end

return BattleEffect
