local var_0_0 = import("...StateBase")
local var_0_1 = class("GuelGameAcion.ExitState", var_0_0)

function var_0_1.Enter(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Enter(arg_1_0, arg_1_1)

	arg_1_1.exit = true

	if arg_1_2 then
		arg_1_1:DoAction(arg_1_2 .. "_101", function()
			arg_1_1:Reset()
			manager.posterGirl:SetStateCanChange(true)
			manager.notify:Invoke(HOME_BTN_VISIBE, true)
			manager.posterGirl:ExitMiniGame()
			arg_1_1:GetCurMainActor():ChangeState(PosterGirlConst.StateKay.init)
		end, false, 0)
		arg_1_1:PlayTalk(arg_1_2)
	else
		arg_1_1:Reset()
		manager.posterGirl:SetStateCanChange(true)
		manager.notify:Invoke(HOME_BTN_VISIBE, true)
		manager.posterGirl:ExitMiniGame()
		arg_1_1:GetCurMainActor():ChangeState(PosterGirlConst.StateKay.init_no_blend)
	end
end

return var_0_1
