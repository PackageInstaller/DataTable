local MoveEnemy = class("MoveEnemy", import("view.miniGame.gameView.RyzaMiniGame.character.TargetMove"))

function MoveEnemy:InitUI(arg_1_1)
	self.hp = arg_1_1.hp or 3
	self.bomb = arg_1_1.bomb or 4
	self.bombCount = self.bomb
	self.power = arg_1_1.power or 4
	self.speed = arg_1_1.speed or 4

	self:UpdateSpirit(defaultValue(arg_1_1.spirit, true))

	self.neglectTime = 0
	self.invincibilityTime = 0

	self:PlayIdle()
	self.rtScale:Find("main/spirit"):GetComponent(typeof(Image)).material:SetInt("_Overwrite", 0)

	local var_1_0 = self.rtScale:Find("main/character"):GetComponent(typeof(DftAniEvent))

	var_1_0:SetTriggerEvent(function()
		switch(self.status, {
			Burn_S = function()
				if self.spriteVanish then
					self.spriteVanish = false

					setActive(self.rtScale:Find("front/EF_Vanish"), true)
				end

				return
			end
		})

		return
	end)
	var_1_0:SetEndEvent(function()
		self.lock = false

		if self.hp <= 0 then
			self.responder:GameFinish(false)
		end

		return
	end)
	eachChild(self.rtScale:Find("front"), function(arg_5_0)
		arg_5_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			setActive(arg_5_0, false)

			return
		end)

		return
	end)
	self.rtScale:Find("front/EF_Summon"):GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function()
		self.summonCount = defaultValue(self.summonCount, 0) + 1

		local var_7_0 = self.rtScale:Find("main/spirit")

		switch(self.summonCount, {
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

		self.summonCount = self.summonCount % 3

		return
	end)

	return
end

function MoveEnemy:InitRegister(arg_11_1)
	self:Register("feedback", function()
		self.bombCount = math.min(self.bombCount + 1, self.bomb)

		return
	end, {})
	self:Register("burn", function()
		if self.invincibilityTime > 0 then
			return
		end

		self:Hurt(1)

		if self.hp > 0 then
			self:PlayAnim("Burn_S")
		else
			self:DeregisterAll()
			self:PlayAnim("Gameover_B")
		end

		return
	end, {
		{
			0,
			0
		}
	})
	self:Register("hit", function(arg_14_0, arg_14_1)
		if self.invincibilityTime > 0 then
			return
		end

		self:Hurt(arg_14_0)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-ryza-minigame-damage")

		local var_14_0 = (arg_14_1 - self.realPos) * (1 / math.sqrt((arg_14_1 - self.realPos):SqrMagnitude()))

		setAnchoredPosition(self.rtScale:Find("front/EF_Hit"), NewPos(var_14_0.x, -var_14_0.y) * 16)
		setActive(self.rtScale:Find("front/EF_Hit"), true)

		if self.hp > 0 then
			local var_14_1 = RyzaMiniGameConfig.GetFourDirMark(var_14_0)

			self:PlayAnim("Damage_" .. (var_14_1 == "" and "S" or var_14_1))
			self:PlayDamage()
		else
			self:DeregisterAll()
			self:PlayAnim("Gameover_A")
		end

		return
	end, {})

	return
end

function MoveEnemy:Hurt(arg_15_1)
	if self.spirit then
		self.spriteVanish = true

		self:UpdateSpirit(false)
	else
		self.hp = self.hp - arg_15_1

		self.responder:SyncStatus(self, "hp", {
			num = self.hp,
			delta = -arg_15_1
		})
	end

	self.invincibilityTime = 3

	return
end

function MoveEnemy:AddItem(arg_16_1)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-ryza-minigame-powerup")
	switch(arg_16_1, {
		bomb = function()
			self.bomb = math.min(self.bomb + 1, 7)
			self.bombCount = self.bombCount + 1

			self.responder:SyncStatus(self, "bomb", {
				num = self.bomb
			})

			return
		end,
		power = function()
			self.power = math.min(self.power + 1, 7)

			self.responder:SyncStatus(self, "power", {
				num = self.power
			})

			return
		end,
		speed = function()
			self.speed = math.min(self.speed + 1, 7)

			self.responder:SyncStatus(self, "speed", {
				num = self.speed
			})

			return
		end,
		hp1 = function()
			self.hp = math.min(self.hp + 1, 3)

			self.responder:SyncStatus(self, "hp", {
				delta = 1,
				num = self.hp
			})

			return
		end,
		hp2 = function()
			self.hp = math.min(self.hp + 2, 3)

			self.responder:SyncStatus(self, "hp", {
				delta = 2,
				num = self.hp
			})

			return
		end,
		spirit = function()
			if not self.spirit then
				self:UpdateSpirit(true)
				setActive(self.rtScale:Find("front/EF_Summon"), true)
			end

			return
		end
	})

	return
end

function MoveEnemy:UpdateSpirit(arg_23_1)
	self.spirit = arg_23_1

	local var_23_0 = self.spirit and "spirit" or "character"

	eachChild(self.rtScale:Find("main"), function(arg_24_0)
		setActive(arg_24_0, arg_24_0.name == var_23_0)
		arg_24_0:GetComponent(typeof(Image)).material:SetInt("_Overwrite", 0)

		return
	end)

	self.mainTarget = self.rtScale:Find("main/" .. var_23_0)

	return
end

function MoveEnemy:SetBomb()
	if not self.lock and self.bombCount > 0 and self.responder:GetCellCanBomb(self.pos) then
		self.bombCount = self.bombCount - 1

		self.responder:Create({
			name = "Bomb",
			pos = {
				self.pos.x,
				self.pos.y
			},
			power = self.power
		})
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-ryza-minigame-boom set")
	end

	return
end

function MoveEnemy:GetSpeed()
	return self.spirit and 7 or self.speed
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

function MoveEnemy:TimeUpdate(arg_27_1)
	self.invincibilityTime = self.invincibilityTime - arg_27_1

	if not self.lock then
		if self.invincibilityTime > 0 then
			self.rtScale:Find("main/character"):GetComponent(typeof(Image)).material:SetInt("_Overwrite", math.floor(self.invincibilityTime / var_0_2) % 2)
		end

		local var_27_0, var_27_1 = self:GetMoveInfo()
		local var_27_2 = RyzaMiniGameConfig.ReSetDir(var_27_1)
		local var_27_3 = RyzaMiniGameConfig.GetEightDirMark(var_27_2)

		if var_27_3 == "" then
			if self.spirit then
				self.neglectTime = 0

				self:PlayIdle()
			elseif self.neglectTime < 5 then
				self.neglectTime = self.neglectTime + arg_27_1

				self:PlayIdle()
			else
				self:PlayNeglect(arg_27_1)
			end
		else
			self.neglectTime = 0

			if self:GetSpeed() < 7 then
				self:PlayAnim("Trot_" .. var_27_3)
			else
				self:PlayAnim("Run_" .. var_27_3)
			end
		end

		local var_27_4 = self:MoveDelta(var_27_2, self:GetSpeedDis() * arg_27_1)

		self:MoveUpdate(var_27_4)

		if #var_27_3 == 1 and var_0_1[var_27_3][1] * var_27_4.x + var_0_1[var_27_3][2] * var_27_4.y == 0 then
			self:Calling("touch", {
				self
			}, {
				var_0_1[var_27_3]
			})
		end
	end

	return
end

function MoveEnemy:GetMoveInfo()
	local var_28_1 = self.responder:GetJoyStick()
end

function MoveEnemy:PlayNeglect(arg_29_1)
	self.flowCount = defaultValue(self.flowCount, 0) + arg_29_1

	if self.flowCount < 0.2 then
		return
	else
		self.flowCount = 0
	end

	switch(self.status, {
		Idle_N = function()
			self:PlayAnim("Idle_NE")

			return
		end,
		Idle_NE = function()
			self:PlayAnim("Idle_E")

			return
		end,
		Idle_E = function()
			self:PlayAnim("Idle_SE")

			return
		end,
		Idle_SE = function()
			self:PlayAnim("Idle_S")

			return
		end,
		Idle_NW = function()
			self:PlayAnim("Idle_W")

			return
		end,
		Idle_W = function()
			self:PlayAnim("Idle_SW")

			return
		end,
		Idle_SW = function()
			self:PlayAnim("Idle_S")

			return
		end,
		Idle_S = function()
			self:PlayAnim("Neglect")

			return
		end,
		Neglect = function()
			return
		end
	})

	return
end

function MoveEnemy:PlayIdle()
	self:PlayAnim("Idle_" .. (string.split(self.status, "_")[2] or "S"))

	return
end

function MoveEnemy:PlayDamage()
	self:PlayAnim("Damage_" .. (string.split(self.status, "_")[2] or "S"))

	return
end

MoveEnemy.loopDic = {
	Neglect = true,
	Trot = true,
	Idle = true,
	Run = true
}

function MoveEnemy:UpdatePosition()
	MoveEnemy.super.UpdatePosition(self)
	self.responder:WindowFocrus(self._tf.localPosition)

	return
end

function MoveEnemy:SetHide(arg_42_1)
	MoveEnemy.super.SetHide(self, arg_42_1)

	GetOrAddComponent(self._tf, typeof(CanvasGroup)).alpha = arg_42_1 and 0.7 or 1

	return
end

return MoveEnemy
