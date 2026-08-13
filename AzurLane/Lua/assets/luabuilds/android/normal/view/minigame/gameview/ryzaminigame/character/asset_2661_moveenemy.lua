class = var_0_10000

local var_0_0 = "MoveEnemy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.miniGame.gameView.RyzaMiniGame.character.TargetMove"))

function var_0_1.InitUI(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.hp then
		var_1_0 = 3
	end

	arg_1_0.hp = var_1_0
	arg_1_0.hpMax = arg_1_0.hp

	local var_1_1

	if not arg_1_1.speed then
		var_1_1 = 1
	end

	arg_1_0.speed = var_1_1

	local var_1_2

	if not arg_1_1.search then
		var_1_2 = 4
	end

	arg_1_0.search = var_1_2

	local var_1_3

	if not arg_1_1.wander then
		var_1_3 = 3
	end

	arg_1_0.wander = var_1_3

	local var_1_4 = arg_1_0.rtScale

	arg_1_0.mainTarget = var_2.Find(var_1_4, "main")

	arg_1_0:PlayWait()

	local var_1_5 = arg_1_0.mainTarget
	local var_1_6 = var_2.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10005

	local var_1_7 = var_1_6(var_1_5, var_4(var_1_10005))

	var_2.SetEndEvent(var_1_7, function()
		arg_1_0.lock = false

		if arg_1_0.hp <= 0 then
			local var_2_0 = arg_1_0

			var_0.Destroy(var_2_0)
		end

		return
	end)

	return
end

function var_0_1.InitRegister(arg_3_0, arg_3_1)
	arg_3_0:Register("burn", function()
		local var_4_0 = arg_3_0

		var_0.Hurt(var_4_0, 1)

		return
	end, {
		{
			0,
			0
		}
	})

	return
end

function var_0_1.Hurt(arg_5_0, arg_5_1)
	arg_5_0.hp = arg_5_0.hp - arg_5_1

	local var_5_0 = arg_5_0.responder

	var_2.SyncStatus(var_5_0, arg_5_0, "hp", {
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

var_0_1.SpeedDistance = {
	[0] = 0,
	1,
	1.5,
	2,
	2.5,
	3,
	3.5,
	4
}

function var_0_1.TimeUpdate(arg_6_0, arg_6_1)
	if not arg_6_0.lock then
		local var_6_0, var_6_1 = arg_6_0:GetMoveInfo()
		local var_6_2

		if var_6_0 then
			local var_6_3 = arg_6_0
			local var_6_4 = arg_6_0.MoveDelta

			var_1_10007 = var_6_0
			var_1_10009 = arg_6_0
			var_6_2 = var_6_4(var_6_3, var_1_10007, arg_6_0.GetSpeedDis(var_1_10009) * arg_6_1)

			arg_6_0:ClearWander()
		else
			local var_6_5
			local var_6_6

			if not arg_6_0.wanderPos then
				arg_6_0.wanderPos = arg_6_0.pos
				NewPos = var_1_10007
				arg_6_0.wanderDir = var_1_10007(0, 0)
				arg_6_0.wanderTime = 1.5
			end

			if arg_6_0.wanderTime <= arg_6_1 then
				var_1_10007 = arg_6_0.wanderPos
				NewPos = var_1_10008
				math = var_1_10009

				local var_6_7 = var_1_10009.random() * 2 - 1

				math = var_1_10010

				local var_6_8 = var_1_10007 + var_1_10008(var_6_7, var_1_10010.random() * 2 - 1) * arg_6_0.wander - arg_6_0.realPos

				arg_6_0.wanderDir = var_8.Normalize(var_6_8)
			end

			if var_0_1.super.MoveDelta(arg_6_0, arg_6_0.wanderDir, arg_6_0:GetSpeedDis() * arg_6_1).x == 0 and var_6_2.y == 0 then
				arg_6_0.wanderTime = arg_6_0.wanderTime - arg_6_1
			else
				arg_6_0.wanderTime = 1.5
			end

			arg_6_0.wanderDir = var_6_2:Normalize()
			var_6_1 = arg_6_0.wanderDir
		end

		if var_6_1.x == 0 and var_6_1.y == 0 then
			arg_6_0:PlayWait()
		else
			local var_6_9 = arg_6_0
			local var_6_10 = arg_6_0.PlayMove

			RyzaMiniGameConfig = var_1_10007

			var_6_10(var_6_9, var_1_10007.GetFourDirMark(var_6_1))
		end

		arg_6_0:MoveUpdate(var_6_2)
	end

	arg_6_0:TimeTrigger(arg_6_1)

	if arg_6_0.hide then
		arg_6_0:UpdateAlpha()
	end

	return
end

function var_0_1.MoveDelta(arg_7_0, arg_7_1, arg_7_2)
	if (arg_7_1 - arg_7_0.realPos).x == 0 and var_3.y == 0 then
		NewPos = var_4

		return var_4(0, 0)
	else
		math = var_4

		local var_7_0 = var_4.min
		local var_7_1 = 1

		math = var_1_10006

		return var_3 * var_7_0(var_7_1, arg_7_2 / var_1_10006.sqrt(var_3:SqrMagnitude()))
	end

	return
end

function var_0_1.GetMoveInfo(arg_8_0)
	local var_8_0 = arg_8_0.responder

	if var_1.SearchRyza(var_8_0, arg_8_0, arg_8_0.search) then
		var_8_0 = arg_8_0.responder

		if var_1.Wayfinding(var_8_0, arg_8_0) and #var_1 > 0 then
			local var_8_1 = var_1[#var_1] - arg_8_0.realPos
			local var_8_2 = var_8_0 - arg_8_0.pos

			if var_8_1:SqrMagnitude() > var_8_2:SqrMagnitude() then
				var_8_0 = arg_8_0.pos
			end

			local var_8_3

			if (var_8_0 - arg_8_0.realPos).x ~= 0 or var_8_3.y ~= 0 then
				math = var_6
				var_8_3 = var_8_3 * (1 / var_6.sqrt(var_8_3:SqrMagnitude()))
			end

			return var_8_0, var_8_3
		end
	end

	local var_8_4

	NewPos = var_8_0

	local var_8_5 = var_8_0(0, 0)
end

function var_0_1.ClearWander(arg_9_0)
	arg_9_0.wanderPos = nil
	arg_9_0.wanderDir = nil
	arg_9_0.wanderTime = nil

	return
end

function var_0_1.PlayWait(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.PlayAnim
	local var_10_2 = "Wait_"

	string = var_1_10004

	local var_10_3

	if not var_1_10004.split(arg_10_0.status, "_")[2] then
		var_10_3 = "S"
	end

	var_10_1(var_10_0, var_10_2 .. var_10_3)

	return
end

function var_0_1.PlayMove(arg_11_0, arg_11_1)
	arg_11_0:PlayAnim("Move_" .. arg_11_1)

	return
end

function var_0_1.PlayDamage(arg_12_0)
	if not arg_12_0.lock then
		local var_12_0 = arg_12_0
		local var_12_1 = arg_12_0.PlayAnim
		local var_12_2 = "Damage_"

		string = var_1_10004

		local var_12_3

		if not var_1_10004.split(arg_12_0.status, "_")[2] then
			var_12_3 = "S"
		end

		var_12_1(var_12_0, var_12_2 .. var_12_3)
	end

	return
end

function var_0_1.PlayDead(arg_13_0)
	arg_13_0:SetHide(false)

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.PlayAnim
	local var_13_2 = "Dead_"

	string = var_1_10004

	local var_13_3

	if not var_1_10004.split(arg_13_0.status, "_")[2] then
		var_13_3 = "S"
	end

	var_13_1(var_13_0, var_13_2 .. var_13_3)

	return
end

var_0_1.loopDic = {
	Move = true,
	Wait = true
}

function var_0_1.GetUIHeight(arg_14_0)
	return 128
end

function var_0_1.SetHide(arg_15_0, arg_15_1)
	var_0_1.super.SetHide(arg_15_0, arg_15_1)
	arg_15_0:UpdateAlpha()

	return
end

local var_0_2 = 7

function var_0_1.UpdateAlpha(arg_16_0)
	local var_16_0 = 1
	local var_16_1

	if not arg_16_0.hide then
		var_16_1 = 1
	else
		if arg_16_0.responder.reactorRyza.hide then
			local var_16_2 = arg_16_0.responder.reactorRyza.realPos - arg_16_0.realPos

			if var_2.SqrMagnitude(var_16_2) < var_0_2 * var_0_2 then
				var_16_1 = 0.7

				goto label_16_0
			end
		end

		var_16_1 = 0
	end

	::label_16_0::

	GetOrAddComponent = var_2

	local var_16_3 = arg_16_0._tf

	typeof = var_1_10004
	CanvasGroup = var_1_10005
	var_2(var_16_3, var_1_10004(var_1_10005)).alpha = var_16_1

	return
end

function var_0_1.TimeTrigger(arg_17_0, arg_17_1)
	if arg_17_0.hp > 0 then
		local var_17_0 = arg_17_0.responder

		if var_2.CollideRyza(var_17_0, arg_17_0) then
			local var_17_1 = arg_17_0
			local var_17_2 = arg_17_0.Calling
			local var_17_3 = "hit"
			local var_17_4 = {
				1,
				arg_17_0.realPos
			}

			MoveRyza = var_6

			var_17_2(var_17_1, var_17_3, var_17_4, var_6)
		end
	end

	return
end

return var_0_1
