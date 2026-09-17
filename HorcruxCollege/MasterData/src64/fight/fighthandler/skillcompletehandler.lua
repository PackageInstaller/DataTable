local xplogic = require("fight.fightlogic.xplogic")

return function(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_1 then
		if not arg_1_0.skilllogic:doSequence(arg_1_1, arg_1_2) then
			if arg_1_2.skilltype == "xp" then
				arg_1_0:openRageAdd()
			end

			arg_1_0._playing = nil
			arg_1_0._lastAniName = nil
			arg_1_0._crossing = nil
			arg_1_0._crashing = nil

			arg_1_0:removeRushingForward()
			arg_1_0:setTurnbackLimit(false)
			arg_1_0.skeleton:setTimeScale(1)
			arg_1_0.logic:updateFight(arg_1_2.skilltype)
		end
	else
		if arg_1_2.skilltype == "xp" then
			arg_1_0:openRageAdd()
		end

		arg_1_0._playing = nil
		arg_1_0._lastAniName = nil
		arg_1_0._crossing = nil
		arg_1_0._crashing = nil

		arg_1_0:removeRushingForward()
		arg_1_0:setTurnbackLimit(false)
		arg_1_0.skeleton:setTimeScale(1)
		arg_1_0.logic:updateFight(arg_1_2.skilltype)
	end
end
