class = var_0_10000

local var_0_0 = "ObjectBush"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.miniGame.gameView.RyzaMiniGame.object.TargetObject"))

function var_0_1.GetBaseOrder(arg_1_0)
	return 3
end

function var_0_1.CellPassability(arg_2_0)
	return true
end

function var_0_1.FirePassability(arg_3_0)
	return 0
end

function var_0_1.InitUI(arg_4_0, arg_4_1)
	arg_4_0.hideCount = 0

	return
end

function var_0_1.InitRegister(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._tf
	local var_5_1 = var_2.Find(var_5_0, "Image")
	local var_5_2 = var_2.GetComponent

	typeof = var_1_10005
	Animator = var_1_10006

	local var_5_3 = var_5_2(var_5_1, var_1_10005(var_1_10006))

	arg_5_0:Register("burn", function()
		local var_6_0 = var_5_3

		var_0.Play(var_6_0, "New State")

		local var_6_1 = var_5_3

		var_0.Play(var_6_1, "Burn_A")

		return
	end, {
		{
			0,
			0
		}
	})
	arg_5_0:Register("move", function(arg_7_0)
		local var_7_0 = var_5_3

		var_1.Play(var_7_0, "New State")

		local var_7_1 = var_5_3

		var_1.Play(var_7_1, "Sway")

		pg = var_1

		local var_7_2 = var_1.CriMgr.GetInstance()

		var_1.PlaySoundEffect_V3(var_7_2, "ui-ryza-minigame-grass")
		arg_7_0:SetHide(true)

		isa = var_1

		local var_7_3 = arg_7_0

		MoveEnemy = var_3

		if not var_1(var_7_3, var_3) then
			local var_7_4 = arg_5_0

			var_1.ChangeHide(var_7_4, true)
		end

		return
	end, {
		{
			0,
			0
		}
	})
	arg_5_0:Register("leave", function(arg_8_0)
		local var_8_0 = var_5_3

		var_1.Play(var_8_0, "New State")

		local var_8_1 = var_5_3

		var_1.Play(var_8_1, "Sway")

		pg = var_1

		local var_8_2 = var_1.CriMgr.GetInstance()

		var_1.PlaySoundEffect_V3(var_8_2, "ui-ryza-minigame-grass")
		arg_8_0:SetHide(false)

		isa = var_1

		local var_8_3 = arg_8_0

		MoveEnemy = var_3

		if not var_1(var_8_3, var_3) then
			local var_8_4 = arg_5_0

			var_1.ChangeHide(var_8_4, false)
		end

		return
	end, {
		{
			0,
			0
		}
	})

	return
end

function var_0_1.ChangeHide(arg_9_0, arg_9_1)
	arg_9_0.hideCount = arg_9_0.hideCount + (arg_9_1 and 1 or -1)
	GetOrAddComponent = var_2

	local var_9_0 = arg_9_0._tf

	typeof = var_1_10004
	CanvasGroup = var_1_10005
	var_2(var_9_0, var_1_10004(var_1_10005)).alpha = arg_9_0.hideCount > 0 and 0.5 or 1

	return
end

return var_0_1
