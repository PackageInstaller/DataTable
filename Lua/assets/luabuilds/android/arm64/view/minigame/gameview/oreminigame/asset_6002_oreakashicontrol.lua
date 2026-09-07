local OreAkashiControl = class("OreAkashiControl")

OreAkashiControl.STATUS_NULL = 0
OreAkashiControl.STATUS_WOOD_BOX = 1
OreAkashiControl.STATUS_IRON_BOX = 2
OreAkashiControl.STATUS_CART = 3
OreAkashiControl.HIT_DELTA = 15
OreAkashiControl.HIT_MOVE_TIME = 0.5

function OreAkashiControl:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.binder = arg_1_1
	self._tf = arg_1_2
	self.collisionMgr = arg_1_3

	self:Init()

	return
end

function OreAkashiControl:Init()
	self.uiMgr = pg.UIMgr.GetInstance()

	self.collisionMgr:SetAkashiObject(self)

	self.oreTpl = self._tf:Find("oreTpl")

	self:AddListener()
	self:AddDftAniEvent()
	self:Reset()

	self.aabbTF = self._tf:Find("aabb")

	setActive(self.aabbTF, OreGameConfig.SHOW_AABB)

	self.aabb = OreGameHelper.GetAABBWithTF(self.aabbTF)

	return
end

function OreAkashiControl:AddListener()
	self.binder:bind(OreGameConfig.EVENT_DO_CARRY, function(arg_4_0, arg_4_1)
		self.weight = self.weight + arg_4_1.weight
		self.point = self.point + arg_4_1.point

		self:CheckStatus()
		self:AddOre(arg_4_1.type)

		return
	end)
	self.binder:bind(OreGameConfig.EVENT_AKASHI_HIT, function(arg_5_0, arg_5_1)
		if self.invincible then
			return
		end

		self:PlayHitAnim(arg_5_1.dir, arg_5_1.class, arg_5_1.y)

		return
	end)

	return
end

function OreAkashiControl:AddDftAniEvent()
	eachChild(self._tf:Find("main"), function(arg_7_0)
		arg_7_0:Find("main/Image"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			if self.isDeliver then
				self:ResetData()
			else
				self:ResetData()
				self.mainTF:Find("main/Image"):GetComponent(typeof(Animator)):Play("Idle_S_Sad")

				self.mainAnimName = "Idle_S_Sad"
			end

			return
		end)

		return
	end)
	eachChild(self._tf:Find("effect"), function(arg_9_0)
		arg_9_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			setActive(arg_9_0, false)

			return
		end)

		return
	end)

	return
end

function OreAkashiControl:Reset()
	setAnchoredPosition(self._tf, Vector2(0, -100))

	self.invincible = nil

	self:ResetData()
	self.mainTF:Find("main/Image"):GetComponent(typeof(Animator)):Play("Idle_S_0")

	return
end

function OreAkashiControl:ResetData()
	self.mainAnimName, self.toolAnimName, self.oreAnimName = "", "", ""

	self:SetAnimDir("S")

	self.weight = 0
	self.point = 0
	self.isDeliver = false
	self.playHitAnim = nil

	self:ResetStatus()

	return
end

function OreAkashiControl:ResetStatus()
	self:SetStatus(OreAkashiControl.STATUS_NULL)

	self.oreList = {}

	eachChild(self._tf:Find("main"), function(arg_14_0)
		for iter_14_0 = 1, 3 do
			removeAllChildren((arg_14_0:Find("ore/Image/" .. iter_14_0 .. "/oreTF")))
		end

		return
	end)

	return
end

local var_0_1 = {
	S = {
		EF_Get = {
			Vector2(0, 0),
			Vector2(-1, 0),
			Vector2(0, -11)
		},
		EF_Upgrade = {
			Vector2(0, -5),
			Vector2(0, -4)
		}
	},
	E = {
		EF_Get = {
			Vector2(13, 3),
			Vector2(14.8, 4.4),
			Vector2(-23, 4)
		},
		EF_Upgrade = {
			Vector2(13, 0),
			Vector2(18, 2.7)
		}
	},
	W = {
		EF_Get = {
			Vector2(-16, 3.5),
			Vector2(-16, 5),
			Vector2(-24, 4)
		},
		EF_Upgrade = {
			Vector2(-18, 2),
			Vector2(-22, 2)
		}
	}
}

function OreAkashiControl:PlayEffect(arg_15_1)
	if self.animDir == "N" then
		return
	end

	local var_15_0 = self._tf:Find("effect/" .. arg_15_1)

	setAnchoredPosition(var_15_0, var_0_1[self.animDir][arg_15_1][(arg_15_1 == "EF_Upgrade" or nil) and (self.status == OreAkashiControl.STATUS_IRON_BOX and 2 or 1)])
	setActive(var_15_0, true)

	return
end

function OreAkashiControl:AddOre(arg_16_1)
	if self.status == OreAkashiControl.STATUS_WOOD_BOX and #self.oreList >= 6 then
		return
	end

	if (self.status == OreAkashiControl.STATUS_IRON_BOX or self.status == OreAkashiControl.STATUS_CART) and #self.oreList >= 8 then
		return
	end

	table.insert(self.oreList, arg_16_1)
	eachChild(self._tf:Find("main"), function(arg_17_0)
		if arg_17_0.name == "N" and self.status ~= OreAkashiControl.STATUS_CART then
			return
		end

		local var_17_0 = arg_17_0:Find("ore/Image/" .. self.status .. "/oreTF")
		local var_17_1 = arg_17_0:Find("ore/Image/" .. self.status .. "/pos/" .. "num_" .. #self.oreList)

		if var_17_0.childCount < #self.oreList - 1 then
			for iter_17_0, iter_17_1 in ipairs(self.oreList) do
				local var_17_2 = cloneTplTo(self.oreTpl:Find(iter_17_1), var_17_0, iter_17_0)
			end
		else
			local var_17_3 = cloneTplTo(self.oreTpl:Find(arg_16_1), var_17_0, #self.oreList)
		end

		eachChild(var_17_1, function(arg_18_0)
			setAnchoredPosition(var_17_0:Find(arg_18_0.name), arg_18_0.anchoredPosition)

			return
		end)

		return
	end)

	return
end

function OreAkashiControl:CheckStatus()
	local var_19_0 = false

	if self.status == OreAkashiControl.STATUS_NULL then
		var_19_0 = self.weight >= 0
	elseif self.status == OreAkashiControl.STATUS_WOOD_BOX then
		var_19_0 = self.weight >= OreGameConfig.CAPACITY.WOOD_BOX
	elseif self.status == OreAkashiControl.STATUS_IRON_BOX then
		var_19_0 = self.weight >= OreGameConfig.CAPACITY.IRON_BOX
	end

	if var_19_0 then
		self:PlayEffect("EF_Upgrade")
		self:SetStatus(self.status + 1)
	else
		self:PlayEffect("EF_Get")
	end

	return
end

function OreAkashiControl:SetStatus(arg_20_1)
	self.status = arg_20_1

	eachChild(self._tf:Find("main"), function(arg_21_0)
		setActive(arg_21_0:Find("tool"), self.status ~= OreAkashiControl.STATUS_NULL)
		setActive(arg_21_0:Find("ore"), self.status ~= OreAkashiControl.STATUS_NULL)
		eachChild(arg_21_0:Find("ore/Image"), function(arg_22_0)
			setActive(arg_22_0, self.status == tonumber(arg_22_0.name))

			return
		end)

		return
	end)

	self.speed = OreGameConfig.SPEED[self.status]

	return
end

function OreAkashiControl:SetAnimDir(arg_23_1)
	self.animDir = arg_23_1

	eachChild(self._tf:Find("main"), function(arg_24_0)
		if arg_24_0.name == self.animDir then
			setActive(arg_24_0, true)

			self.mainTF = arg_24_0
		else
			setActive(arg_24_0, false)
		end

		return
	end)

	return
end

function OreAkashiControl:PlayHitAnim(arg_25_1, arg_25_2, arg_25_3)
	self.invincible = 0

	setActive(self._tf:Find("effect/EF_Clash_" .. arg_25_1), true)

	local var_25_0 = ""

	self.hitPos = {
		x = 0,
		y = 0
	}

	if arg_25_1 == "W" then
		self.hitPos.x = -OreAkashiControl.HIT_DELTA or OreAkashiControl.HIT_DELTA
	end

	if arg_25_3 <= self._tf.anchoredPosition.y then
		var_25_0 = arg_25_1 == "W" and "CW" or "CCW"
		self.hitPos.y = OreAkashiControl.HIT_DELTA
	else
		var_25_0 = arg_25_1 == "W" and "CCW" or "CW"
		self.hitPos.y = -OreAkashiControl.HIT_DELTA
	end

	self.hitTime = 0
	self.hitAnimName = "Stun_" .. (arg_25_2 < 4 and "Light" or "Heavy") .. "_" .. var_25_0

	self.mainTF:Find("main/Image"):GetComponent(typeof(Animator)):Play("Clash_" .. arg_25_1)
	self.binder:emit(OreGameConfig.EVENT_PLAY_CONTAINER_HIT, {
		pos = self._tf.anchoredPosition,
		hitPos = self.hitPos,
		status = self.status,
		oreTF = self.mainTF:Find("ore/Image/" .. tostring(self.status))
	})
	self:ResetStatus()

	return
end

function OreAkashiControl:PlayDeliver()
	self.isDeliver = true

	setActive(self.mainTF:Find("tool"), false)
	setActive(self.mainTF:Find("ore"), false)
	self.mainTF:Find("main/Image"):GetComponent(typeof(Animator)):Play("Deliver")

	return
end

function OreAkashiControl:CheckDeliver()
	if self._tf.anchoredPosition.y < OreGameConfig.RANGE_Y[1] + 2 and self._tf.anchoredPosition.x > -100 and self._tf.anchoredPosition.x < 100 and self.animDir == "S" and self.weight > 0 then
		self:PlayDeliver()
		self.binder:emit(OreGameConfig.EVENT_DELIVER, {
			point = self.point,
			status = self.status,
			pos = self._tf.anchoredPosition,
			oreTF = self.mainTF:Find("ore/Image/" .. tostring(self.status))
		})
	end

	return
end

function OreAkashiControl:OnTimer(arg_28_1)
	if self.invincible then
		self.invincible = self.invincible + arg_28_1

		if self.invincible >= OreGameConfig.INVINCIBLE_TIME then
			self.invincible = nil
		end
	end

	if self.hitTime then
		if arg_28_1 * 5 < self.hitTime and self.hitTime <= arg_28_1 * 6 then
			self.mainTF:Find("main/Image"):GetComponent(typeof(Animator)):Play(self.hitAnimName)

			self.playHitAnim = true
		elseif self.hitTime > arg_28_1 * 6 then
			self:SetPosition({
				x = self._tf.anchoredPosition.x + self.hitPos.x * arg_28_1 / OreAkashiControl.HIT_MOVE_TIME,
				y = self._tf.anchoredPosition.y + self.hitPos.y * arg_28_1 / OreAkashiControl.HIT_MOVE_TIME
			})
		end

		self.hitTime = self.hitTime + arg_28_1

		if self.hitTime >= OreAkashiControl.HIT_MOVE_TIME then
			self.hitTime = nil
		end

		return
	end

	if not self.isDeliver and not self.playHitAnim then
		local var_28_0 = Vector2(self.uiMgr.hrz, self.uiMgr.vtc)

		self:UpdateAnim(var_28_0)
		self:UpdatePosition(var_28_0)
		self:CheckDeliver()
	end

	return
end

function OreAkashiControl:UpdateAnim(arg_29_1)
	local var_29_0 = OreGameHelper.GetFourDirLabel(arg_29_1)
	local var_29_1 = false

	if var_29_0 == "STAND" then
		var_29_0 = self.animDir
		var_29_1 = true
	end

	self:SetAnimDir(var_29_0)

	local var_29_2 = ""
	local var_29_3 = ""
	local var_29_4 = ""

	if var_29_1 then
		if self.mainAnimName ~= "Idle_S_Sad" then
			var_29_2 = "Idle_" .. var_29_0 .. "_" .. self.status

			if self.status ~= OreAkashiControl.STATUS_NULL then
				var_29_3 = var_29_2
				var_29_4 = var_29_2
			end
		else
			var_29_2 = "Idle_S_Sad"
			var_29_3 = "Idle_S_1"
			var_29_4 = "Idle_S_1"
		end
	else
		var_29_2 = "Move_" .. var_29_0 .. "_" .. self.status

		if self.status ~= OreAkashiControl.STATUS_NULL then
			var_29_3 = var_29_2
			var_29_4 = var_29_2
		end
	end

	if var_29_2 ~= "" and self.mainAnimName ~= var_29_2 then
		self.mainTF:Find("main/Image"):GetComponent(typeof(Animator)):Play(var_29_2)

		self.mainAnimName = var_29_2
	end

	if self.status ~= OreAkashiControl.STATUS_NULL then
		if var_29_4 ~= "" and var_29_4 ~= self.toolAnimName then
			if string.find(var_29_4, "N_1") or string.find(var_29_4, "N_2") then
				self.mainTF:Find("tool/Image"):GetComponent(typeof(Image)).enabled = false
			else
				self.mainTF:Find("tool/Image"):GetComponent(typeof(Image)).enabled = true

				self.mainTF:Find("tool/Image"):GetComponent(typeof(Animator)):Play(var_29_4)
			end

			self.toolAnimName = var_29_4
		end

		if var_29_3 ~= "" and var_29_3 ~= self.oreAnimName then
			self.mainTF:Find("ore/Image"):GetComponent(typeof(Animator)):Play(var_29_3)

			self.oreAnimName = var_29_3

			local var_29_5 = self.mainTF:Find("ore/Image/" .. self.status .. "/oreTF")

			if not var_29_1 and OreAkashiControl.oreAnimOffset[self.status][self.animDir] then
				setAnchoredPosition(var_29_5, OreAkashiControl.oreAnimOffset[self.status][self.animDir])
			else
				setAnchoredPosition(var_29_5, Vector2(0, 0))
			end
		end
	end

	return
end

OreAkashiControl.oreAnimOffset = {
	{
		S = Vector2(0, -2),
		W = Vector2(1, -2)
	},
	{
		S = Vector2(0, -2)
	},
	{
		W = Vector2(5, 0),
		E = Vector2(-3, 0)
	}
}

function OreAkashiControl:UpdatePosition(arg_30_1)
	local var_30_0 = OreGameHelper.GetEightDirVector(arg_30_1) * OreGameConfig.TIME_INTERVAL * self.speed

	self:SetPosition({
		x = self._tf.anchoredPosition.x + var_30_0.x,
		y = self._tf.anchoredPosition.y + var_30_0.y
	})

	return
end

function OreAkashiControl:SetPosition(arg_31_1)
	if OreGameHelper.CheckRemovable(arg_31_1) then
		setAnchoredPosition(self._tf, arg_31_1)

		self._tf:GetComponent(typeof(Canvas)).sortingOrder = -arg_31_1.y + 320
	end

	return
end

function OreAkashiControl:IsInvincible()
	return self.invincible
end

function OreAkashiControl:GetAnimDirLabel()
	return self.animDir
end

function OreAkashiControl:GetAABB()
	return self.aabb
end

function OreAkashiControl:GetCarryTriggerOffset()
	return {
		0,
		10
	}
end

function OreAkashiControl:GetCollisionInfo()
	return {
		pos = {
			x = self._tf.anchoredPosition.x + self.aabbTF.anchoredPosition.x,
			y = self._tf.anchoredPosition.y + self.aabbTF.anchoredPosition.y
		},
		aabb = self:GetAABB(),
		carryOffset = self:GetCarryTriggerOffset()
	}
end

return OreAkashiControl
