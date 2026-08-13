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

	local var_1_1

	if not arg_1_1.bomb then
		var_1_1 = 4
	end

	arg_1_0.bomb = var_1_1
	arg_1_0.bombCount = arg_1_0.bomb

	local var_1_2

	if not arg_1_1.power then
		var_1_2 = 4
	end

	arg_1_0.power = var_1_2

	local var_1_3

	if not arg_1_1.speed then
		var_1_3 = 4
	end

	arg_1_0.speed = var_1_3

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.UpdateSpirit

	defaultValue = var_1_10004

	var_1_5(var_1_4, var_1_10004(arg_1_1.spirit, true))

	arg_1_0.neglectTime = 0
	arg_1_0.invincibilityTime = 0

	arg_1_0:PlayIdle()

	local var_1_6 = arg_1_0.rtScale
	local var_1_7 = var_2.Find(var_1_6, "main/spirit")
	local var_1_8 = var_2.GetComponent

	typeof = var_4
	Image = var_5

	local var_1_9 = var_1_8(var_1_7, var_4(var_5)).material

	var_2.SetInt(var_1_9, "_Overwrite", 0)

	local var_1_10 = arg_1_0.rtScale
	local var_1_11 = var_2.Find(var_1_10, "main/character")
	local var_1_12 = var_2.GetComponent

	typeof = var_4
	DftAniEvent = var_5

	local var_1_13 = var_1_12(var_1_11, var_4(var_5))

	var_2.SetTriggerEvent(var_1_13, function()
		switch = var_2_10000

		var_2_10000(arg_1_0.status, {
			Burn_S = function()
				if arg_1_0.spriteVanish then
					local var_3_0 = arg_1_0

					var_3_0.spriteVanish = false
					setActive = var_3_0

					local var_3_1 = arg_1_0.rtScale

					var_3_0(var_1.Find(var_3_1, "front/EF_Vanish"), true)
				end

				return
			end
		})

		return
	end)
	var_2:SetEndEvent(function()
		arg_1_0.lock = false

		if arg_1_0.hp <= 0 then
			local var_4_0 = arg_1_0.responder

			var_0.GameFinish(var_4_0, false)
		end

		return
	end)

	eachChild = var_3

	local var_1_14 = arg_1_0.rtScale

	var_3(var_4.Find(var_1_14, "front"), function(arg_5_0)
		local var_5_0 = arg_5_0
		local var_5_1 = arg_5_0.GetComponent

		typeof = var_2_10003
		DftAniEvent = var_2_10004

		local var_5_2 = var_5_1(var_5_0, var_2_10003(var_2_10004))

		var_1.SetEndEvent(var_5_2, function()
			setActive = var_3_10000

			var_3_10000(arg_5_0, false)

			return
		end)

		return
	end)

	local var_1_15 = arg_1_0.rtScale
	local var_1_16 = var_3.Find(var_1_15, "front/EF_Summon")
	local var_1_17 = var_3.GetComponent

	typeof = var_5
	DftAniEvent = var_6

	local var_1_18 = var_1_17(var_1_16, var_5(var_6))

	var_3.SetTriggerEvent(var_1_18, function()
		local var_7_0 = arg_1_0

		defaultValue = var_2_10001
		var_7_0.summonCount = var_2_10001(arg_1_0.summonCount, 0) + 1

		local var_7_1 = arg_1_0.rtScale
		local var_7_2 = var_0.Find(var_7_1, "main/spirit")

		switch = var_7_1

		var_7_1(arg_1_0.summonCount, {
			function()
				GetOrAddComponent = var_3_10000

				local var_8_0 = var_7_2

				typeof = var_3_10002
				CanvasGroup = var_3_10003
				var_3_10000(var_8_0, var_3_10002(var_3_10003)).alpha = 0

				return
			end,
			function()
				GetOrAddComponent = var_3_10000

				local var_9_0 = var_7_2

				typeof = var_3_10002
				CanvasGroup = var_3_10003
				var_3_10000(var_9_0, var_3_10002(var_3_10003)).alpha = 1

				local var_9_1 = var_7_2
				local var_9_2 = var_0.GetComponent

				typeof = var_2
				Image = var_3_10003

				local var_9_3 = var_9_2(var_9_1, var_2(var_3_10003)).material

				var_0.SetInt(var_9_3, "_Overwrite", 1)

				return
			end,
			function()
				local var_10_0 = var_7_2
				local var_10_1 = var_0.GetComponent

				typeof = var_3_10002
				Image = var_3_10003

				local var_10_2 = var_10_1(var_10_0, var_3_10002(var_3_10003)).material

				var_0.SetInt(var_10_2, "_Overwrite", 0)

				return
			end
		})

		arg_1_0.summonCount = arg_1_0.summonCount % 3

		return
	end)

	return
end

function var_0_1.InitRegister(arg_11_0, arg_11_1)
	arg_11_0:Register("feedback", function()
		local var_12_0 = arg_11_0

		math = var_2_10001
		var_12_0.bombCount = var_2_10001.min(arg_11_0.bombCount + 1, arg_11_0.bomb)

		return
	end, {})
	arg_11_0:Register("burn", function()
		if arg_11_0.invincibilityTime > 0 then
			return
		end

		local var_13_0 = arg_11_0

		var_0.Hurt(var_13_0, 1)

		if arg_11_0.hp > 0 then
			local var_13_1 = arg_11_0

			var_0.PlayAnim(var_13_1, "Burn_S")
		else
			local var_13_2 = arg_11_0

			var_0.DeregisterAll(var_13_2)

			local var_13_3 = arg_11_0

			var_0.PlayAnim(var_13_3, "Gameover_B")
		end

		return
	end, {
		{
			0,
			0
		}
	})
	arg_11_0:Register("hit", function(arg_14_0, arg_14_1)
		if arg_11_0.invincibilityTime > 0 then
			return
		end

		local var_14_0 = arg_11_0

		var_2.Hurt(var_14_0, arg_14_0)

		pg = var_2

		local var_14_1 = var_2.CriMgr.GetInstance()

		var_2.PlaySoundEffect_V3(var_14_1, "ui-ryza-minigame-damage")

		local var_14_2 = arg_14_1 - arg_11_0.realPos

		math = var_14_1

		local var_14_3 = var_14_2 * (1 / var_14_1.sqrt(var_14_2:SqrMagnitude()))

		setAnchoredPosition = var_3

		local var_14_4 = arg_11_0.rtScale
		local var_14_5 = var_4.Find(var_14_4, "front/EF_Hit")

		NewPos = var_14_4

		var_3(var_14_5, var_14_4(var_14_3.x, -var_14_3.y) * 16)

		setActive = var_3

		local var_14_6 = arg_11_0.rtScale

		var_3(var_4.Find(var_14_6, "front/EF_Hit"), true)

		if arg_11_0.hp > 0 then
			RyzaMiniGameConfig = var_3

			local var_14_7 = var_3.GetFourDirMark(var_14_3)
			local var_14_8 = arg_11_0

			var_4.PlayAnim(var_14_8, "Damage_" .. (var_14_7 == "" and "S" or var_14_7))

			local var_14_9 = arg_11_0

			var_4.PlayDamage(var_14_9)
		else
			local var_14_10 = arg_11_0

			var_3.DeregisterAll(var_14_10)

			local var_14_11 = arg_11_0

			var_3.PlayAnim(var_14_11, "Gameover_A")
		end

		return
	end, {})

	return
end

function var_0_1.Hurt(arg_15_0, arg_15_1)
	if arg_15_0.spirit then
		arg_15_0.spriteVanish = true

		arg_15_0:UpdateSpirit(false)
	else
		arg_15_0.hp = arg_15_0.hp - arg_15_1

		local var_15_0 = arg_15_0.responder

		var_2.SyncStatus(var_15_0, arg_15_0, "hp", {
			num = arg_15_0.hp,
			delta = -arg_15_1
		})
	end

	arg_15_0.invincibilityTime = 3

	return
end

function var_0_1.AddItem(arg_16_0, arg_16_1)
	pg = var_1_10002

	local var_16_0 = var_1_10002.CriMgr.GetInstance()

	var_2.PlaySoundEffect_V3(var_16_0, "ui-ryza-minigame-powerup")

	switch = var_2

	var_2(arg_16_1, {
		bomb = function()
			local var_17_0 = arg_16_0

			math = var_2_10001
			var_17_0.bomb = var_2_10001.min(arg_16_0.bomb + 1, 7)
			arg_16_0.bombCount = arg_16_0.bombCount + 1

			local var_17_1 = arg_16_0.responder

			var_0.SyncStatus(var_17_1, arg_16_0, "bomb", {
				num = arg_16_0.bomb
			})

			return
		end,
		power = function()
			local var_18_0 = arg_16_0

			math = var_2_10001
			var_18_0.power = var_2_10001.min(arg_16_0.power + 1, 7)

			local var_18_1 = arg_16_0.responder

			var_0.SyncStatus(var_18_1, arg_16_0, "power", {
				num = arg_16_0.power
			})

			return
		end,
		speed = function()
			local var_19_0 = arg_16_0

			math = var_2_10001
			var_19_0.speed = var_2_10001.min(arg_16_0.speed + 1, 7)

			local var_19_1 = arg_16_0.responder

			var_0.SyncStatus(var_19_1, arg_16_0, "speed", {
				num = arg_16_0.speed
			})

			return
		end,
		hp1 = function()
			local var_20_0 = arg_16_0

			math = var_2_10001
			var_20_0.hp = var_2_10001.min(arg_16_0.hp + 1, 3)

			local var_20_1 = arg_16_0.responder

			var_0.SyncStatus(var_20_1, arg_16_0, "hp", {
				delta = 1,
				num = arg_16_0.hp
			})

			return
		end,
		hp2 = function()
			local var_21_0 = arg_16_0

			math = var_2_10001
			var_21_0.hp = var_2_10001.min(arg_16_0.hp + 2, 3)

			local var_21_1 = arg_16_0.responder

			var_0.SyncStatus(var_21_1, arg_16_0, "hp", {
				delta = 2,
				num = arg_16_0.hp
			})

			return
		end,
		spirit = function()
			if not arg_16_0.spirit then
				local var_22_0 = arg_16_0

				var_0.UpdateSpirit(var_22_0, true)

				setActive = var_0

				local var_22_1 = arg_16_0.rtScale

				var_0(var_1.Find(var_22_1, "front/EF_Summon"), true)
			end

			return
		end
	})

	return
end

function var_0_1.UpdateSpirit(arg_23_0, arg_23_1)
	arg_23_0.spirit = arg_23_1

	local var_23_0 = arg_23_0.spirit and "spirit" or "character"

	eachChild = var_1_10003

	local var_23_1 = arg_23_0.rtScale

	var_1_10003(var_4.Find(var_23_1, "main"), function(arg_24_0)
		setActive = var_2_10001

		var_2_10001(arg_24_0, arg_24_0.name == var_23_0)

		local var_24_0 = arg_24_0
		local var_24_1 = arg_24_0.GetComponent

		typeof = var_3
		Image = var_4

		local var_24_2 = var_24_1(var_24_0, var_3(var_4)).material

		var_1.SetInt(var_24_2, "_Overwrite", 0)

		return
	end)

	local var_23_2 = arg_23_0.rtScale

	arg_23_0.mainTarget = var_3.Find(var_23_2, "main/" .. var_23_0)

	return
end

function var_0_1.SetBomb(arg_25_0)
	if not arg_25_0.lock and arg_25_0.bombCount > 0 then
		local var_25_0 = arg_25_0.responder

		if var_1.GetCellCanBomb(var_25_0, arg_25_0.pos) then
			arg_25_0.bombCount = arg_25_0.bombCount - 1

			local var_25_1 = arg_25_0.responder

			var_1.Create(var_25_1, {
				name = "Bomb",
				pos = {
					arg_25_0.pos.x,
					arg_25_0.pos.y
				},
				power = arg_25_0.power
			})

			pg = var_1

			local var_25_2 = var_1.CriMgr.GetInstance()

			var_1.PlaySoundEffect_V3(var_25_2, "ui-ryza-minigame-boom set")
		end
	end

	return
end

function var_0_1.GetSpeed(arg_26_0)
	return arg_26_0.spirit and 7 or arg_26_0.speed
end

local var_0_2 = {
	S = {
		0,
		1
	},
	E = {
		1,
		0
	},
	N = {
		0,
		-1
	},
	W = {
		-1,
		0
	}
}
local var_0_3 = 0.15

function var_0_1.TimeUpdate(arg_27_0, arg_27_1)
	arg_27_0.invincibilityTime = arg_27_0.invincibilityTime - arg_27_1

	if not arg_27_0.lock then
		if arg_27_0.invincibilityTime > 0 then
			local var_27_0 = arg_27_0.rtScale
			local var_27_1 = var_2.Find(var_27_0, "main/character")
			local var_27_2 = var_2.GetComponent

			typeof = var_1_10004
			Image = var_1_10005

			local var_27_3 = var_27_2(var_27_1, var_1_10004(var_1_10005)).material
			local var_27_4 = var_2.SetInt

			var_1_10004 = "_Overwrite"
			math = var_1_10005

			var_27_4(var_27_3, var_1_10004, var_1_10005.floor(arg_27_0.invincibilityTime / var_0_3) % 2)
		end

		local var_27_5, var_27_6 = arg_27_0:GetMoveInfo()

		RyzaMiniGameConfig = var_1_10004

		local var_27_7 = var_1_10004.ReSetDir(var_27_6)

		RyzaMiniGameConfig = var_4

		if var_4.GetEightDirMark(var_27_7) == "" then
			if arg_27_0.spirit then
				arg_27_0.neglectTime = 0

				arg_27_0:PlayIdle()
			elseif arg_27_0.neglectTime < 5 then
				arg_27_0.neglectTime = arg_27_0.neglectTime + arg_27_1

				arg_27_0:PlayIdle()
			else
				arg_27_0:PlayNeglect(arg_27_1)
			end
		else
			arg_27_0.neglectTime = 0

			if arg_27_0:GetSpeed() < 7 then
				arg_27_0:PlayAnim("Trot_" .. var_4)
			else
				arg_27_0:PlayAnim("Run_" .. var_4)
			end
		end

		local var_27_8 = arg_27_0:MoveDelta(var_27_7, arg_27_0:GetSpeedDis() * arg_27_1)

		arg_27_0:MoveUpdate(var_27_8)

		if #var_4 == 1 and var_0_2[var_4][1] * var_27_8.x + var_0_2[var_4][2] * var_27_8.y == 0 then
			arg_27_0:Calling("touch", {
				arg_27_0
			}, {
				var_0_2[var_4]
			})
		end
	end

	return
end

function var_0_1.GetMoveInfo(arg_28_0)
	local var_28_0
	local var_28_1 = arg_28_0.responder
	local var_28_2 = var_2.GetJoyStick(var_28_1)
end

function var_0_1.PlayNeglect(arg_29_0, arg_29_1)
	defaultValue = var_1_10002
	arg_29_0.flowCount = var_1_10002(arg_29_0.flowCount, 0) + arg_29_1

	if arg_29_0.flowCount < 0.2 then
		return
	else
		arg_29_0.flowCount = 0
	end

	switch = var_2

	var_2(arg_29_0.status, {
		Idle_N = function()
			local var_30_0 = arg_29_0

			var_0.PlayAnim(var_30_0, "Idle_NE")

			return
		end,
		Idle_NE = function()
			local var_31_0 = arg_29_0

			var_0.PlayAnim(var_31_0, "Idle_E")

			return
		end,
		Idle_E = function()
			local var_32_0 = arg_29_0

			var_0.PlayAnim(var_32_0, "Idle_SE")

			return
		end,
		Idle_SE = function()
			local var_33_0 = arg_29_0

			var_0.PlayAnim(var_33_0, "Idle_S")

			return
		end,
		Idle_NW = function()
			local var_34_0 = arg_29_0

			var_0.PlayAnim(var_34_0, "Idle_W")

			return
		end,
		Idle_W = function()
			local var_35_0 = arg_29_0

			var_0.PlayAnim(var_35_0, "Idle_SW")

			return
		end,
		Idle_SW = function()
			local var_36_0 = arg_29_0

			var_0.PlayAnim(var_36_0, "Idle_S")

			return
		end,
		Idle_S = function()
			local var_37_0 = arg_29_0

			var_0.PlayAnim(var_37_0, "Neglect")

			return
		end,
		Neglect = function()
			return
		end
	})

	return
end

function var_0_1.PlayIdle(arg_39_0)
	local var_39_0 = arg_39_0
	local var_39_1 = arg_39_0.PlayAnim
	local var_39_2 = "Idle_"

	string = var_1_10004

	local var_39_3

	if not var_1_10004.split(arg_39_0.status, "_")[2] then
		var_39_3 = "S"
	end

	var_39_1(var_39_0, var_39_2 .. var_39_3)

	return
end

function var_0_1.PlayDamage(arg_40_0)
	local var_40_0 = arg_40_0
	local var_40_1 = arg_40_0.PlayAnim
	local var_40_2 = "Damage_"

	string = var_1_10004

	local var_40_3

	if not var_1_10004.split(arg_40_0.status, "_")[2] then
		var_40_3 = "S"
	end

	var_40_1(var_40_0, var_40_2 .. var_40_3)

	return
end

var_0_1.loopDic = {
	Neglect = true,
	Trot = true,
	Idle = true,
	Run = true
}

function var_0_1.UpdatePosition(arg_41_0)
	var_0_1.super.UpdatePosition(arg_41_0)

	local var_41_0 = arg_41_0.responder

	var_1.WindowFocrus(var_41_0, arg_41_0._tf.localPosition)

	return
end

function var_0_1.SetHide(arg_42_0, arg_42_1)
	var_0_1.super.SetHide(arg_42_0, arg_42_1)

	GetOrAddComponent = var_2

	local var_42_0 = arg_42_0._tf

	typeof = var_4
	CanvasGroup = var_1_10005
	var_2(var_42_0, var_4(var_1_10005)).alpha = arg_42_1 and 0.7 or 1

	return
end

return var_0_1
