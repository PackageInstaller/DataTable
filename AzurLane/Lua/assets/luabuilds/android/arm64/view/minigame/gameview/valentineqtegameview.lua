local var_0_0 = class("ValentineQteGameView", import("..BaseMiniGameView"))

function var_0_0.getUIName(arg_1_0)
	return "ValentineQteGamePage"
end

function var_0_0.init(arg_2_0)
	arg_2_0.gameView = ValentineQteGamePage.New(arg_2_0._tf)

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0.gameView:SetUp(function()
		if arg_3_0:GetMGHubData().count > 0 then
			arg_3_0:SendSuccess(0)
		end

		return
	end, function()
		if arg_3_0.gameView then
			arg_3_0.gameView = nil
		end

		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end, arg_3_0:GetMGHubData().usedtime == 0)

	return
end

function var_0_0.onBackPressed(arg_6_0)
	if arg_6_0.gameView and arg_6_0.gameView:onBackPressed() then
		return
	end

	var_0_0.super.onBackPressed(arg_6_0)

	return
end

function var_0_0.willExit(arg_7_0)
	if arg_7_0.gameView then
		arg_7_0.gameView:Destroy()

		arg_7_0.gameView = nil
	end

	return
end

return var_0_0
