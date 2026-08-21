local var_0_0 = import("game.views.autoChess.battle.render.renderController.AutoChessBaseRenderController")
local var_0_1 = class("AutoChessAnimatorRenderController", var_0_0)

function var_0_1.OnCtor(arg_1_0)
	arg_1_0.animator = nil
	arg_1_0.animaName = nil
end

function var_0_1.PlayAnim(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.animator = arg_2_1
	arg_2_0.animaName = arg_2_2
	arg_2_0.delaySecond = arg_2_3 or 0
	arg_2_0.curDelaySecond = arg_2_0.delaySecond

	if arg_2_0.delaySecond <= 0 then
		arg_2_0:Play()
	end
end

function var_0_1.OnPlay(arg_3_0)
	arg_3_0.animator.enabled = true
	arg_3_0.animator.speed = arg_3_0.speed

	arg_3_0.animator:Play(arg_3_0.animaName, -1, 0)
	arg_3_0.animator:Update(0)
end

function var_0_1.Update(arg_4_0, arg_4_1)
	if arg_4_0.status == AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.RUNNING then
		arg_4_0:CheckFinish()
	elseif arg_4_0.curDelaySecond > 0 then
		arg_4_0.curDelaySecond = arg_4_0.curDelaySecond - arg_4_1

		if arg_4_0.curDelaySecond <= 0 then
			arg_4_0:Play()
		end
	end
end

function var_0_1.CheckFinish(arg_5_0)
	local var_5_0 = arg_5_0.animator:GetCurrentAnimatorStateInfo(0)
	local var_5_1 = GameSetting.auto_chess_fixed_percentage.value[1] / 100

	if table.indexof(AutoChessConst.COMPLETE_PLAY_ANIM, arg_5_0.animName) then
		var_5_1 = 1
	end

	if not var_5_0:IsName(arg_5_0.animaName) or var_5_1 <= var_5_0.normalizedTime then
		arg_5_0.animator = nil
		arg_5_0.animaName = nil

		arg_5_0:Finish()
	end
end

function var_0_1.Reset(arg_6_0)
	var_0_1.super.Reset(arg_6_0)

	arg_6_0.animator = nil
	arg_6_0.animaName = nil
end

function var_0_1.OnPause(arg_7_0)
	arg_7_0.animator.speed = 0
end

function var_0_1.OnResume(arg_8_0)
	arg_8_0.animator.speed = arg_8_0.speed
end

function var_0_1.OnSpeedChange(arg_9_0)
	arg_9_0.animator.speed = arg_9_0.speed
end

return var_0_1
