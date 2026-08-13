class = var_0_10000

local var_0_0 = "EnemySmasher"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.miniGame.gameView.RyzaMiniGame.character.MoveEnemy"))

var_0_1.ConfigSkillCD = 10
var_0_1.ConfigSkillCount = 3
var_0_1.ImpackRange = 20

function var_0_1.InitUI(arg_1_0, arg_1_1)
	var_0_1.super.InitUI(arg_1_0, arg_1_1)

	local var_1_0

	if not arg_1_1.hp then
		var_1_0 = 2
	end

	arg_1_0.hp = var_1_0
	arg_1_0.hpMax = arg_1_0.hp

	local var_1_1

	if not arg_1_1.speed then
		var_1_1 = 2
	end

	arg_1_0.speed = var_1_1
	eachChild = var_1_1

	local var_1_2 = arg_1_0.rtScale

	var_1_1(var_4.Find(var_1_2, "front"), function(arg_2_0)
		local var_2_0 = arg_2_0
		local var_2_1 = arg_2_0.GetComponent

		typeof = var_2_10004
		DftAniEvent = var_2_10006

		local var_2_2 = var_2_1(var_2_0, var_2_10004(var_2_10006))

		var_1.SetEndEvent(var_2_2, function()
			setActive = var_3_10000

			var_3_10000(arg_2_0, false)

			return
		end)

		return
	end)

	local var_1_3 = arg_1_0.mainTarget
	local var_1_4 = var_2.GetComponent

	typeof = var_5
	DftAniEvent = var_7

	local var_1_5 = var_1_4(var_1_3, var_5(var_7))

	var_2.SetTriggerEvent(var_1_5, function()
		local var_4_0 = arg_1_0

		defaultValue = var_2_10001
		var_4_0.triggerCount = var_2_10001(arg_1_0.triggerCount, 0) + 1
		switch = var_4_0

		var_4_0(arg_1_0.triggerCount, {
			function()
				setActive = var_3_10000

				local var_5_0 = arg_1_0.rtScale

				var_3_10000(var_2.Find(var_5_0, "front/EF_Bullet_UP"), true)

				return
			end,
			function()
				setActive = var_3_10000

				local var_6_0 = arg_1_0.rtScale

				var_3_10000(var_2.Find(var_6_0, "front/EF_Bullet_UP_High"), true)

				return
			end
		})

		arg_1_0.triggerCount = arg_1_0.triggerCount % 2

		return
	end)

	local var_1_6 = arg_1_0.mainTarget
	local var_1_7 = var_2.GetComponent

	typeof = var_5
	DftAniEvent = var_7

	local var_1_8 = var_1_7(var_1_6, var_5(var_7))

	var_2.SetEndEvent(var_1_8, function()
		switch = var_2_10000

		var_2_10000(arg_1_0.status, {
			Attack_S = function()
				arg_1_0.impackCD = 0
				arg_1_0.impackCount = arg_1_0.ConfigSkillCount

				return
			end
		})

		arg_1_0.lock = false

		if arg_1_0.hp <= 0 then
			local var_7_0 = arg_1_0

			var_0.Destroy(var_7_0)
		end

		return
	end)

	arg_1_0.skillCD = 0
	arg_1_0.impackCount = 0

	return
end

function var_0_1.TimeTrigger(arg_9_0, arg_9_1)
	var_0_1.super.TimeTrigger(arg_9_0, arg_9_1)

	arg_9_0.skillCD = arg_9_0.skillCD - arg_9_1

	if not arg_9_0.lock and arg_9_0.skillCD <= 0 then
		local var_9_0 = arg_9_0.responder

		if var_2.SearchRyza(var_9_0, arg_9_0, arg_9_0.search) then
			local var_9_1 = arg_9_0.responder.reactorRyza.pos - arg_9_0.pos

			if var_3.SqrMagnitude(var_9_1) >= 4 then
				arg_9_0:PlayAnim("Attack_S")

				arg_9_0.skillCD = arg_9_0.ConfigSkillCD
				arg_9_0.skillCenterPos = arg_9_0.responder.reactorRyza.realPos
			end
		end
	end

	local function var_9_2()
		if arg_9_0.responder.reactorRyza.hide then
			return false
		else
			return (arg_9_0.responder.reactorRyza.realPos - arg_9_0.skillCenterPos).x * var_0.x < arg_9_0.ImpackRange * arg_9_0.ImpackRange / 4 and var_0.y * var_0.y < arg_9_0.ImpackRange * arg_9_0.ImpackRange / 4
		end

		return
	end

	if arg_9_0.impackCount > 0 then
		if var_9_2() then
			arg_9_0.impackCD = arg_9_0.impackCD - arg_9_1

			if arg_9_0.impackCD <= 0 then
				arg_9_0.impackCount = arg_9_0.impackCount - 1
				arg_9_0.impackCD = 0.5

				local var_9_3 = arg_9_0.responder.reactorRyza.pos
				local var_9_4 = arg_9_0.responder.reactorRyza.realPos
				local var_9_5 = arg_9_0.responder

				var_5.Create(var_9_5, {
					name = "Impack",
					pos = {
						var_9_3.x,
						var_9_3.y
					},
					realPos = {
						var_9_4.x,
						var_9_4.y
					}
				})
			end
		else
			arg_9_0.impackCount = 0
			arg_9_0.impackCD = nil
		end
	end

	return
end

return var_0_1
