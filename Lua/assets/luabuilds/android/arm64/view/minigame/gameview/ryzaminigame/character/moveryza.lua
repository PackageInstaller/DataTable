local var_0_0 = class("MoveEnemy", import("view.miniGame.gameView.RyzaMiniGame.character.TargetMove"))

function var_0_0.InitUI(arg_1_0, arg_1_1)
	arg_1_0.hp = arg_1_1.hp or 3
	arg_1_0.bomb = arg_1_1.bomb or 4
	arg_1_0.bombCount = arg_1_0.bomb
	arg_1_0.power = arg_1_1.power or 4
	arg_1_0.speed = arg_1_1.speed or 4

	arg_1_0:UpdateSpirit(defaultValue(arg_1_1.spirit, true))

	arg_1_0.neglectTime = 0
	arg_1_0.invincibilityTime = 0

	arg_1_0:PlayIdle()
	arg_1_0.rtScale:Find("main/spirit"):GetComponent(typeof(Image)).material:SetInt("_Overwrite", 0)

	local var_1_0 = arg_1_0.rtScale:Find("main/character"):GetComponent(typeof(DftAniEvent))

	var_1_0:SetTriggerEvent(function()
		switch(arg_1_0.status, {
			Burn_S = function()
				if arg_1_0.spriteVanish then
					arg_1_0.spriteVanish = false

					setActive(arg_1_0.rtScale:Find("front/EF_Vanish"), true)
				end

				return
			end
		})

		return
	end)
	var_1_0:SetEndEvent(function()
		arg_1_0.lock = false

		if arg_1_0.hp <= 0 then
			arg_1_0.responder:GameFinish(false)
		end

		return
	end)
	eachChild(arg_1_0.rtScale:Find("front"), function(arg_5_0)
		arg_5_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			setActive(arg_5_0, false)

			return
		end)

		return
	end)
	arg_1_0.rtScale:Find("front/EF_Summon"):GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function()
		arg_1_0.summonCount = defaultValue(arg_1_0.summonCount, 0) + 1

		local var_7_0 = arg_1_0.rtScale:Find("main/spirit")

		switch(arg_1_0.summonCount, {
			function()
				GetOrAddComponent(var_7_0, typeof(CanvasGroup)).alpha = 0

				return
			end,
			function()
				GetOrAddComponent(var_7_0, typeof(CanvasGroup)).alpha = 1

				var_7_0:GetComponent(typeof(Image)).material:SetInt("_Overwrite", 1)

				return
			end,
			function()
				var_7_0:GetComponent(typeof(Image)).material:SetInt("_Overwrite", 0)

				return
			end
		})

		arg_1_0.summonCount = arg_1_0.summonCount % 3

		return
	end)

	return
end

function var_0_0.InitRegister(arg_11_0, arg_11_1)
	arg_11_0:Register("feedback", function()
		arg_11_0.bombCount = math.min(arg_11_0.bombCount + 1, arg_11_0.bomb)

		return
	end, {})
	arg_11_0:Register("burn", function()
		if arg_11_0.invincibilityTime > 0 then
			return
		end

		arg_11_0:Hurt(1)

		if arg_11_0.hp > 0 then
			arg_11_0:PlayAnim("Burn_S")
		else
			arg_11_0:DeregisterAll()
			arg_11_0:PlayAnim("Gameover_B")
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

		arg_11_0:Hurt(arg_14_0)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-ryza-minigame-damage")

		local var_14_0 = (arg_14_1 - arg_11_0.realPos) * (1 / math.sqrt((arg_14_1 - arg_11_0.realPos):SqrMagnitude()))

		setAnchoredPosition(arg_11_0.rtScale:Find("front/EF_Hit"), NewPos(var_14_0.x, -var_14_0.y) * 16)
		setActive(arg_11_0.rtScale:Find("front/EF_Hit"), true)

		if arg_11_0.hp > 0 then
			local var_14_1 = RyzaMiniGameConfig.GetFourDirMark(var_14_0)

			arg_11_0:PlayAnim("Damage_" .. (var_14_1 == "" and "S" or var_14_1))
			arg_11_0:PlayDamage()
		else
			arg_11_0:DeregisterAll()
			arg_11_0:PlayAnim("Gameover_A")
		end

		return
	end, {})

	return
end

function var_0_0.Hurt(arg_15_0, arg_15_1)
	if arg_15_0.spirit then
		arg_15_0.spriteVanish = true

		arg_15_0:UpdateSpirit(false)
	else
		arg_15_0.hp = arg_15_0.hp - arg_15_1

		arg_15_0.responder:SyncStatus(arg_15_0, "hp", {
			num = arg_15_0.hp,
			delta = -arg_15_1
		})
	end

	arg_15_0.invincibilityTime = 3

	return
end

function var_0_0.AddItem(arg_16_0, arg_16_1)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-ryza-minigame-powerup")
	switch(arg_16_1, {
		bomb = function()
			arg_16_0.bomb = math.min(arg_16_0.bomb + 1, 7)
			arg_16_0.bombCount = arg_16_0.bombCount + 1

			arg_16_0.responder:SyncStatus(arg_16_0, "bomb", {
				num = arg_16_0.bomb
			})

			return
		end,
		power = function()
			arg_16_0.power = math.min(arg_16_0.power + 1, 7)

			arg_16_0.responder:SyncStatus(arg_16_0, "power", {
				num = arg_16_0.power
			})

			return
		end,
		speed = function()
			arg_16_0.speed = math.min(arg_16_0.speed + 1, 7)

			arg_16_0.responder:SyncStatus(arg_16_0, "speed", {
				num = arg_16_0.speed
			})

			return
		end,
		hp1 = function()
			arg_16_0.hp = math.min(arg_16_0.hp + 1, 3)

			arg_16_0.responder:SyncStatus(arg_16_0, "hp", {
				delta = 1,
				num = arg_16_0.hp
			})

			return
		end,
		hp2 = function()
			arg_16_0.hp = math.min(arg_16_0.hp + 2, 3)

			arg_16_0.responder:SyncStatus(arg_16_0, "hp", {
				delta = 2,
				num = arg_16_0.hp
			})

			return
		end,
		spirit = function()
			if not arg_16_0.spirit then
				arg_16_0:UpdateSpirit(true)
				setActive(arg_16_0.rtScale:Find("front/EF_Summon"), true)
			end

			return
		end
	})

	return
end

function var_0_0.UpdateSpirit(arg_23_0, arg_23_1)
	arg_23_0.spirit = arg_23_1

	local var_23_0 = arg_23_0.spirit and "spirit" or "character"

	eachChild(arg_23_0.rtScale:Find("main"), function(arg_24_0)
		setActive(arg_24_0, arg_24_0.name == var_23_0)
		arg_24_0:GetComponent(typeof(Image)).material:SetInt("_Overwrite", 0)

		return
	end)

	arg_23_0.mainTarget = arg_23_0.rtScale:Find("main/" .. var_23_0)

	return
end

function var_0_0.SetBomb(arg_25_0)
	if not arg_25_0.lock and arg_25_0.bombCount > 0 and arg_25_0.responder:GetCellCanBomb(arg_25_0.pos) then
		arg_25_0.bombCount = arg_25_0.bombCount - 1

		arg_25_0.responder:Create({
			name = "Bomb",
			pos = {
				arg_25_0.pos.x,
				arg_25_0.pos.y
			},
			power = arg_25_0.power
		})
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-ryza-minigame-boom set")
	end

	return
end

function var_0_0.GetSpeed(arg_26_0)
	return arg_26_0.spirit and 7 or arg_26_0.speed
end

local var_0_1 = {
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
local var_0_2 = 0.15

function var_0_0.TimeUpdate(arg_27_0, arg_27_1)
	arg_27_0.invincibilityTime = arg_27_0.invincibilityTime - arg_27_1

	if not arg_27_0.lock then
		if arg_27_0.invincibilityTime > 0 then
			arg_27_0.rtScale:Find("main/character"):GetComponent(typeof(Image)).material:SetInt("_Overwrite", math.floor(arg_27_0.invincibilityTime / var_0_2) % 2)
		end

		local var_27_0, var_27_1 = arg_27_0:GetMoveInfo()
		local var_27_2 = RyzaMiniGameConfig.ReSetDir(var_27_1)
		local var_27_3 = RyzaMiniGameConfig.GetEightDirMark(var_27_2)

		if var_27_3 == "" then
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
				arg_27_0:PlayAnim("Trot_" .. var_27_3)
			else
				arg_27_0:PlayAnim("Run_" .. var_27_3)
			end
		end

		local var_27_4 = arg_27_0:MoveDelta(var_27_2, arg_27_0:GetSpeedDis() * arg_27_1)

		arg_27_0:MoveUpdate(var_27_4)

		if #var_27_3 == 1 and var_0_1[var_27_3][1] * var_27_4.x + var_0_1[var_27_3][2] * var_27_4.y == 0 then
			arg_27_0:Calling("touch", {
				arg_27_0
			}, {
				var_0_1[var_27_3]
			})
		end
	end

	return
end

function var_0_0.GetMoveInfo(arg_28_0)
	local var_28_1 = arg_28_0.responder:GetJoyStick()
end

function var_0_0.PlayNeglect(arg_29_0, arg_29_1)
	arg_29_0.flowCount = defaultValue(arg_29_0.flowCount, 0) + arg_29_1

	if arg_29_0.flowCount < 0.2 then
		return
	else
		arg_29_0.flowCount = 0
	end

	switch(arg_29_0.status, {
		Idle_N = function()
			arg_29_0:PlayAnim("Idle_NE")

			return
		end,
		Idle_NE = function()
			arg_29_0:PlayAnim("Idle_E")

			return
		end,
		Idle_E = function()
			arg_29_0:PlayAnim("Idle_SE")

			return
		end,
		Idle_SE = function()
			arg_29_0:PlayAnim("Idle_S")

			return
		end,
		Idle_NW = function()
			arg_29_0:PlayAnim("Idle_W")

			return
		end,
		Idle_W = function()
			arg_29_0:PlayAnim("Idle_SW")

			return
		end,
		Idle_SW = function()
			arg_29_0:PlayAnim("Idle_S")

			return
		end,
		Idle_S = function()
			arg_29_0:PlayAnim("Neglect")

			return
		end,
		Neglect = function()
			return
		end
	})

	return
end

function var_0_0.PlayIdle(arg_39_0)
	local var_39_0 = string.split(arg_39_0.status, "_")[2] or "S"

	arg_39_0:PlayAnim("Idle_" .. var_39_0)

	return
end

function var_0_0.PlayDamage(arg_40_0)
	local var_40_0 = string.split(arg_40_0.status, "_")[2] or "S"

	arg_40_0:PlayAnim("Damage_" .. var_40_0)

	return
end

var_0_0.loopDic = {
	Neglect = true,
	Trot = true,
	Idle = true,
	Run = true
}

function var_0_0.UpdatePosition(arg_41_0)
	var_0_0.super.UpdatePosition(arg_41_0)
	arg_41_0.responder:WindowFocrus(arg_41_0._tf.localPosition)

	return
end

function var_0_0.SetHide(arg_42_0, arg_42_1)
	var_0_0.super.SetHide(arg_42_0, arg_42_1)

	GetOrAddComponent(arg_42_0._tf, typeof(CanvasGroup)).alpha = arg_42_1 and 0.7 or 1

	return
end

return var_0_0
