ys = ys or {}

local var_0_0 = ys
local BattleEnvironmentBehaviourPlaySFX = class("BattleEnvironmentBehaviourPlaySFX", ys.Battle.BattleEnvironmentBehaviour)

ys.Battle.BattleEnvironmentBehaviourPlaySFX = BattleEnvironmentBehaviourPlaySFX
BattleEnvironmentBehaviourPlaySFX.__name = "BattleEnvironmentBehaviourPlaySFX"

function BattleEnvironmentBehaviourPlaySFX:Ctor()
	BattleEnvironmentBehaviourPlaySFX.super.Ctor(self)

	return
end

function BattleEnvironmentBehaviourPlaySFX:SetTemplate(arg_2_1)
	BattleEnvironmentBehaviourPlaySFX.super.SetTemplate(self, arg_2_1)

	self._sfx = self._tmpData.SFX_ID

	return
end

function BattleEnvironmentBehaviourPlaySFX:doBehaviour()
	var_0_0.Battle.PlayBattleSFX(self._sfx)
	BattleEnvironmentBehaviourPlaySFX.super.doBehaviour(self)

	return
end

return
