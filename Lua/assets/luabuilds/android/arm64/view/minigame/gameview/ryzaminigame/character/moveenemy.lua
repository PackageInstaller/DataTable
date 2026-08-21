local var_0_0 = class("MoveEnemy", import("view.miniGame.gameView.RyzaMiniGame.character.TargetMove"))

function var_0_0.InitUI(arg_1_0, arg_1_1)
	arg_1_0.hp = arg_1_1.hp or 3
	arg_1_0.hpMax = arg_1_0.hp
	arg_1_0.speed = arg_1_1.speed or 1
	arg_1_0.search = arg_1_1.search or 4
	arg_1_0.wander = arg_1_1.wander or 3
	arg_1_0.mainTarget = arg_1_0.rtScale:Find("main")

	arg_1_0:PlayWait()
	arg_1_0.mainTarget:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		arg_1_0.lock = false

		if arg_1_0.hp <= 0 then
			arg_1_0:Destroy()
		end

		return
	end)

	return
end

function var_0_0.InitRegister(arg_3_0, arg_3_1)
	arg_3_0:Register("burn", function()
		arg_3_0:Hurt(1)

		return
	end, {
		{
			0,
			0
		}
	})

	return
end

function var_0_0.Hurt(arg_5_0, arg_5_1)
	arg_5_0.hp = arg_5_0.hp - arg_5_1

	arg_5_0.responder:SyncStatus(arg_5_0, "hp", {
		num = arg_5_0.hp,
		max = arg_5_0.hpMax
	})

	if arg_5_0.hp > 0 then
		arg_5_0:PlayDamage()
	else
		arg_5_0:DeregisterAll()
		arg_5_0:PlayDead()
	end

	return
end

var_0_0.SpeedDistance = {
	[0] = 0,
	1,
	1.5,
	2,
	2.5,
	3,
	3.5,
	4
}

function var_0_0.TimeUpdate(arg_6_0, arg_6_1)
	if not arg_6_0.lock then
		local var_6_0, var_6_1 = arg_6_0:GetMoveInfo()
		local var_6_2

		if var_6_0 then
			var_6_2 = arg_6_0:MoveDelta(var_6_0, arg_6_0:GetSpeedDis() * arg_6_1)

			arg_6_0:ClearWander()
		else
			if not arg_6_0.wanderPos then
				arg_6_0.wanderPos = arg_6_0.pos
				arg_6_0.wanderDir = NewPos(0, 0)
				arg_6_0.wanderTime = 1.5
			end

			if arg_6_1 >= arg_6_0.wanderTime then
				arg_6_0.wanderDir = (arg_6_0.wanderPos + NewPos(math.random() * 2 - 1, math.random() * 2 - 1) * arg_6_0.wander - arg_6_0.realPos):Normalize()
			end

			var_6_2 = var_0_0.super.MoveDelta(arg_6_0, arg_6_0.wanderDir, arg_6_0:GetSpeedDis() * arg_6_1)
			arg_6_0.wanderTime = var_6_2.x == 0 and var_6_2.y == 0 and arg_6_0.wanderTime - arg_6_1 or 1.5
			arg_6_0.wanderDir = var_6_2:Normalize()
			var_6_1 = arg_6_0.wanderDir
		end

		if var_6_1.x == 0 and var_6_1.y == 0 then
			arg_6_0:PlayWait()
		else
			arg_6_0:PlayMove(RyzaMiniGameConfig.GetFourDirMark(var_6_1))
		end

		arg_6_0:MoveUpdate(var_6_2)
	end

	arg_6_0:TimeTrigger(arg_6_1)

	if arg_6_0.hide then
		arg_6_0:UpdateAlpha()
	end

	return
end

function var_0_0.MoveDelta(arg_7_0, arg_7_1, arg_7_2)
	if (arg_7_1 - arg_7_0.realPos).x == 0 and (arg_7_1 - arg_7_0.realPos).y == 0 then
		return NewPos(0, 0)
	else
		return (arg_7_1 - arg_7_0.realPos) * math.min(1, arg_7_2 / math.sqrt((arg_7_1 - arg_7_0.realPos):SqrMagnitude()))
	end

	return
end

function var_0_0.GetMoveInfo(arg_8_0)
	if arg_8_0.responder:SearchRyza(arg_8_0, arg_8_0.search) then
		local var_8_0 = arg_8_0.responder:Wayfinding(arg_8_0)

		if var_8_0 and #var_8_0 > 0 then
			local var_8_1 = var_8_0[#var_8_0]

			if (var_8_0[#var_8_0] - arg_8_0.realPos):SqrMagnitude() > (var_8_0[#var_8_0] - arg_8_0.pos):SqrMagnitude() then
				var_8_1 = arg_8_0.pos
			end

			local var_8_2 = var_8_1 - arg_8_0.realPos

			if (var_8_1 - arg_8_0.realPos).x ~= 0 or var_8_2.y ~= 0 then
				var_8_2 = var_8_2 * (1 / math.sqrt(var_8_2:SqrMagnitude()))
			end

			return var_8_1, var_8_2
		end
	end

	local var_8_4 = NewPos(0, 0)
end

function var_0_0.ClearWander(arg_9_0)
	arg_9_0.wanderPos = nil
	arg_9_0.wanderDir = nil
	arg_9_0.wanderTime = nil

	return
end

function var_0_0.PlayWait(arg_10_0)
	local var_10_0 = string.split(arg_10_0.status, "_")[2] or "S"

	arg_10_0:PlayAnim("Wait_" .. var_10_0)

	return
end

function var_0_0.PlayMove(arg_11_0, arg_11_1)
	arg_11_0:PlayAnim("Move_" .. arg_11_1)

	return
end

function var_0_0.PlayDamage(arg_12_0)
	if not arg_12_0.lock then
		local var_12_0 = string.split(arg_12_0.status, "_")[2] or "S"

		arg_12_0:PlayAnim("Damage_" .. var_12_0)
	end

	return
end

function var_0_0.PlayDead(arg_13_0)
	arg_13_0:SetHide(false)

	local var_13_0 = string.split(arg_13_0.status, "_")[2] or "S"

	arg_13_0:PlayAnim("Dead_" .. var_13_0)

	return
end

var_0_0.loopDic = {
	Move = true,
	Wait = true
}

function var_0_0.GetUIHeight(arg_14_0)
	return 128
end

function var_0_0.SetHide(arg_15_0, arg_15_1)
	var_0_0.super.SetHide(arg_15_0, arg_15_1)
	arg_15_0:UpdateAlpha()

	return
end

local var_0_1 = 7

function var_0_0.UpdateAlpha(arg_16_0)
	GetOrAddComponent(arg_16_0._tf, typeof(CanvasGroup)).alpha = not arg_16_0.hide and 1 or arg_16_0.responder.reactorRyza.hide and (arg_16_0.responder.reactorRyza.realPos - arg_16_0.realPos):SqrMagnitude() < var_0_1 * var_0_1 and 0.7 or 0

	return
end

function var_0_0.TimeTrigger(arg_17_0, arg_17_1)
	if arg_17_0.hp > 0 and arg_17_0.responder:CollideRyza(arg_17_0) then
		arg_17_0:Calling("hit", {
			1,
			arg_17_0.realPos
		}, MoveRyza)
	end

	return
end

return var_0_0
