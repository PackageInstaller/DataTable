local var_0_0 = import("game.views.autoChess.battle.render.renderController.AutoChessBaseRenderController")
local var_0_1 = class("AutoChessLeanTweenRenderController", var_0_0)

function var_0_1.OnCtor(arg_1_0)
	arg_1_0.leanTween = nil
	arg_1_0.tweenUpdateCallback = nil
end

function var_0_1.RegistTweenUpdateCallback(arg_2_0, arg_2_1)
	arg_2_0.tweenUpdateCallback = arg_2_1

	arg_2_0.leanTween:setOnUpdate(LuaHelper.FloatAction(function(arg_3_0)
		arg_2_0.tweenUpdateCallback(arg_3_0)
	end))
end

function var_0_1.Value(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0.leanTween = LeanTween.value(arg_4_1, arg_4_2, arg_4_3):setScale(arg_4_0.speed)

	arg_4_0.leanTween:setOnComplete(System.Action(function()
		arg_4_0:ClearLeanTween()
		arg_4_0:Finish()
	end))

	if arg_4_4 then
		arg_4_0.leanTween:setEase(arg_4_4)
	end
end

function var_0_1.OnPause(arg_6_0)
	if arg_6_0.leanTween then
		arg_6_0.leanTween:pause()
	end
end

function var_0_1.OnResume(arg_7_0)
	if arg_7_0.leanTween then
		arg_7_0.leanTween:resume()
	end
end

function var_0_1.OnSpeedChange(arg_8_0)
	if arg_8_0.leanTween then
		arg_8_0.leanTween:setScale(arg_8_0.speed)
	end
end

function var_0_1.Reset(arg_9_0)
	var_0_1.super.Reset(arg_9_0)
	arg_9_0:ClearLeanTween()
end

function var_0_1.ClearLeanTween(arg_10_0)
	if arg_10_0.leanTween then
		arg_10_0.leanTween:setOnUpdate(nil):setOnComplete(nil)
		LeanTween.cancel(arg_10_0.leanTween.id)

		arg_10_0.leanTween = nil
	end

	arg_10_0.tweenUpdateCallback = nil
end

return var_0_1
