local LaunchBallAmulet = class("LaunchBallAmulet")
local var_0_1 = {}

var_0_1[1] = 1
var_0_1[2] = 3
var_0_1[3] = 4
var_0_1[4] = 7
var_0_1[5] = 2
var_0_1[6] = 5
var_0_1[7] = 6

local var_0_2 = "amulet s"
local var_0_3 = "amulet l"
local var_0_4 = "amulet ef"
local var_0_5 = 3
local var_0_6 = {
	{
		index = 1,
		anim_name = "EF_A",
		offset = Vector2(0, 20)
	},
	{
		index = 2,
		anim_name = "EF_B",
		offset = Vector2(0, 0)
	},
	{
		index = 3,
		anim_name = "EF_C",
		offset = Vector2(0, -20)
	}
}
local var_0_7 = 50
local var_0_8 = 70
local var_0_9 = -80
local var_0_10 = 1000
local var_0_11 = 90
local var_0_12 = -90
local var_0_13 = 1000
local var_0_14 = 0.05
local var_0_15 = 0.5
local var_0_16 = {
	{
		animator = "Amulet_Yellow_",
		name = "Yellow"
	},
	[3] = {
		animator = "Amulet_White_",
		name = "White"
	},
	[4] = {
		animator = "Amulet_Red_",
		name = "Red"
	},
	[7] = {
		animator = "Amulet_Purple_",
		name = "Purple"
	},
	{
		animator = "Amulet_Green_",
		name = "Green"
	},
	[5] = {
		animator = "Amulet_Blue_",
		name = "Blue"
	},
	[6] = {
		animator = "Amulet_Black_",
		name = "Black"
	}
}

function LaunchBallAmulet:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self.amuletLAnimators = {}
	self.amuletSAnimators = {}
	self.amuletEFAnimators = {}

	for iter_1_0, iter_1_1 in ipairs(var_0_16) do
		local var_1_1 = LoadAny(LaunchBallGameVo.ui_atlas, iter_1_1.animator .. "S", typeof(RuntimeAnimatorController))
		local var_1_2 = LoadAny(LaunchBallGameVo.ui_atlas, iter_1_1.animator .. "EF", typeof(RuntimeAnimatorController))

		table.insert(self.amuletLAnimators, {
			animator = LoadAny(LaunchBallGameVo.ui_atlas, iter_1_1.animator .. "L", typeof(RuntimeAnimatorController)),
			type = iter_1_0,
			name = iter_1_1.name
		})
		table.insert(self.amuletSAnimators, {
			animator = var_1_1,
			type = iter_1_0,
			name = iter_1_1.name
		})
		table.insert(self.amuletEFAnimators, {
			animator = var_1_2,
			type = iter_1_0,
			name = iter_1_1.name
		})
	end

	self._content = arg_1_1
	self._sContent = arg_1_2
	self._lifeContent = arg_1_3
	self._tpl = arg_1_4
	self._eventCall = arg_1_5
	self._amuletLTpl = findTF(self._tpl, "amuletL")
	self._amuletSTpl = findTF(self._tpl, "amuletS")
	self._amuletEfTpl = findTF(self._tpl, "amuletEF")
	self._butterflyTpl = findTF(self._tpl, "Butterfly")

	self:setAmuletL(nil)

	self.amuletS = nil
	self.amuletEFs = {}
	self.amuletLPool = {}
	self.amuletSPool = {}
	self.amuletEFPool = {}
	self._amuletFires = {}
	self.butterflys = {}

	return
end

function LaunchBallAmulet:start()
	self.lifeBound = GetComponent(findTF(self._lifeContent, tostring(LaunchBallGameVo.gameRoundData.amulet_life)), typeof(BoxCollider2D))
	self.min = self._lifeContent:InverseTransformPoint(self.lifeBound.bounds.min)
	self.max = self._lifeContent:InverseTransformPoint(self.lifeBound.bounds.max)
	self.amuletType = self:getRandomAmuletType()
	self.amuletNextType = self:getRandomAmuletType()

	self:setAmuletL(self:getAmulete(var_0_3, self.amuletType))

	self.amuletS = self:getAmulete(var_0_2, self.amuletNextType)
	self.amuletPos = Vector2(0, 0)
	self.angle = var_0_12
	self.rad = var_0_12 * math.deg2Rad
	self.amuletPos.x = math.cos(self.rad) * var_0_8
	self.amuletPos.y = math.sin(self.rad) * var_0_8
	self.isPlaying = false

	return
end

function LaunchBallAmulet:step()
	if not self.isPlaying then
		if LaunchBallGameVo.joyStickData and LaunchBallGameVo.joyStickData.angle then
			self.rad = LaunchBallGameVo.joyStickData.rad
			self.angle = LaunchBallGameVo.joyStickData.angle
			self.amuletPos.x = math.cos(self.rad) * var_0_8
			self.amuletPos.y = math.sin(self.rad) * var_0_8
		end

		if self.amuletL then
			self.amuletL.tf.anchoredPosition = self.amuletPos
			self.amuletL.rad = self.rad
		else
			self:setAmuletL(self:getAmulete(var_0_3, self.amuletNextType))
			self:returnAmulete(self.amuletS, self.amuletSPool)

			self.amuletNextType = self:getRandomAmuletType()
			self.amuletS = nil
			self.amuletS = self:getAmulete(var_0_2, self.amuletNextType)
		end

		if self.amuletS then
			self.amuletS.tf.anchoredPosition = Vector2(math.cos(self.rad) * var_0_9, math.sin(self.rad) * var_0_9)
		end
	end

	if self._amuletFires and #self._amuletFires > 0 then
		for iter_3_0 = #self._amuletFires, 1, -1 do
			self._amuletFires[iter_3_0].tf.anchoredPosition.x = self._amuletFires[iter_3_0].tf.anchoredPosition.x + self._amuletFires[iter_3_0].speed.x * LaunchBallGameVo.deltaTime
			self._amuletFires[iter_3_0].tf.anchoredPosition.y = self._amuletFires[iter_3_0].tf.anchoredPosition.y + self._amuletFires[iter_3_0].speed.y * LaunchBallGameVo.deltaTime
			self._amuletFires[iter_3_0].tf.anchoredPosition = self._amuletFires[iter_3_0].tf.anchoredPosition

			if self._amuletFires[iter_3_0].effectTime and self._amuletFires[iter_3_0].effectTime > 0 then
				self._amuletFires[iter_3_0].effectTime = self._amuletFires[iter_3_0].effectTime - LaunchBallGameVo.deltaTime

				if self._amuletFires[iter_3_0].effectTime <= 0 then
					self._amuletFires[iter_3_0].effectTime = var_0_14

					self:createEF(self._amuletFires[iter_3_0])
				end
			end

			if math.abs(self._amuletFires[iter_3_0].tf.anchoredPosition.x) > var_0_13 or math.abs(self._amuletFires[iter_3_0].tf.anchoredPosition.y) > var_0_13 then
				table.remove(self._amuletFires, iter_3_0)
				self:returnAmulete(self._amuletFires[iter_3_0], self.amuletLPool)
			elseif self._amuletFires[iter_3_0].removeFlag then
				table.remove(self._amuletFires, iter_3_0)
				self:returnAmulete(self._amuletFires[iter_3_0], self.amuletLPool)
			elseif self.lifeBound then
				if self._amuletFires[iter_3_0].tf.anchoredPosition.x >= self.max.x or self._amuletFires[iter_3_0].tf.anchoredPosition.x <= self.min.x then
					table.remove(self._amuletFires, iter_3_0)
					self:returnAmulete(self._amuletFires[iter_3_0], self.amuletLPool)
				elseif self._amuletFires[iter_3_0].tf.anchoredPosition.y >= self.max.y or self._amuletFires[iter_3_0].tf.anchoredPosition.y <= self.min.y then
					table.remove(self._amuletFires, iter_3_0)
					self:returnAmulete(self._amuletFires[iter_3_0], self.amuletLPool)
				end
			end
		end
	end

	if self.butterflys and #self.butterflys > 0 then
		for iter_3_1 = #self.butterflys, 1, -1 do
			self.butterflys[iter_3_1].tf.anchoredPosition.x = self.butterflys[iter_3_1].tf.anchoredPosition.x + self.butterflys[iter_3_1].speed.x * LaunchBallGameVo.deltaTime
			self.butterflys[iter_3_1].tf.anchoredPosition.y = self.butterflys[iter_3_1].tf.anchoredPosition.y + self.butterflys[iter_3_1].speed.y * LaunchBallGameVo.deltaTime
			self.butterflys[iter_3_1].tf.anchoredPosition = self.butterflys[iter_3_1].tf.anchoredPosition

			if math.abs(self.butterflys[iter_3_1].tf.anchoredPosition.x) > var_0_13 or math.abs(self.butterflys[iter_3_1].tf.anchoredPosition.y) > var_0_13 then
				self.butterflys[iter_3_1].anim = nil

				Destroy(self.butterflys[iter_3_1].tf)
				table.remove(self.butterflys, iter_3_1)
			elseif self.butterflys[iter_3_1].removeFlag then
				self.butterflys[iter_3_1].anim = nil

				Destroy(self.butterflys[iter_3_1].tf)
				table.remove(self.butterflys, iter_3_1)
			elseif self.butterflys[iter_3_1].tf.anchoredPosition.x >= self.max.x or self.butterflys[iter_3_1].tf.anchoredPosition.x <= self.min.x then
				self.butterflys[iter_3_1].anim = nil

				Destroy(self.butterflys[iter_3_1].tf)
				table.remove(self.butterflys, iter_3_1)
			elseif self.butterflys[iter_3_1].tf.anchoredPosition.y >= self.max.y or self.butterflys[iter_3_1].tf.anchoredPosition.y <= self.min.y then
				self.butterflys[iter_3_1].anim = nil

				Destroy(self.butterflys[iter_3_1].tf)
				table.remove(self.butterflys, iter_3_1)
			elseif self.butterflys[iter_3_1].removeTime and self.butterflys[iter_3_1].removeTime > 0 then
				self.butterflys[iter_3_1].removeTime = self.butterflys[iter_3_1].removeTime - LaunchBallGameVo.deltaTime

				if self.butterflys[iter_3_1].removeTime < 0 then
					self.butterflys[iter_3_1].removeTime = nil
					self.butterflys[iter_3_1].removeFlag = true
				end
			end
		end
	end

	if self.amuletEFs and #self.amuletEFs > 0 then
		for iter_3_2 = #self.amuletEFs, 1, -1 do
			if self.amuletEFs[iter_3_2].removeTime and self.amuletEFs[iter_3_2].removeTime > 0 then
				self.amuletEFs[iter_3_2].removeTime = self.amuletEFs[iter_3_2].removeTime - LaunchBallGameVo.deltaTime

				if self.amuletEFs[iter_3_2].removeTime <= 0 then
					table.remove(self.amuletEFs, iter_3_2)
					self:returnAmulete(self.amuletEFs[iter_3_2], self.amuletEFPool)
				end
			end
		end
	end

	return
end

function LaunchBallAmulet:getFireAmulet()
	return self._amuletFires
end

function LaunchBallAmulet:removeFireAmulet(arg_5_1)
	if self._amuletFires and #self._amuletFires > 0 then
		for iter_5_0 = #self._amuletFires, 1, -1 do
			if self._amuletFires[iter_5_0] then
				table.remove(self._amuletFires, iter_5_0)
				self:returnAmulete(self._amuletFires[iter_5_0], self.amuletLPool)
			end
		end
	end

	return
end

LaunchBallAmulet.fireIndex = 0

function LaunchBallAmulet:getAmulete(arg_6_1, arg_6_2)
	local var_6_0
	local var_6_1
	local var_6_2
	local var_6_3
	local var_6_4 = self._content

	if arg_6_1 == var_0_3 then
		var_6_1 = self.amuletLPool
		var_6_2 = self._amuletLTpl
		var_6_3 = Vector2(0, var_0_8)
	elseif arg_6_1 == var_0_2 then
		var_6_1 = self.amuletSPool
		var_6_2 = self._amuletSTpl
		var_6_3 = Vector2(0, var_0_9)
		var_6_4 = self._sContent
	elseif arg_6_1 == var_0_4 then
		var_6_1 = self.amuletEFPool
		var_6_2 = self._amuletEfTpl
		var_6_3 = Vector2(0, 0)
	end

	if not var_6_1 then
		return
	end

	for iter_6_0 = 1, #var_6_1 do
		var_6_0 = var_6_0 or table.remove(var_6_1, iter_6_0)
	end

	if not var_6_0 then
		local var_6_5 = tf(instantiate(var_6_2))

		setParent(var_6_5, var_6_4)

		var_6_0 = {
			tf = var_6_5,
			type = arg_6_1,
			anim = GetComponent(findTF(var_6_5, "ad/anim"), typeof(Animator)),
			animTf = findTF(var_6_5, "ad/anim")
		}
	end

	var_6_0.angle = nil
	var_6_0.fire = nil

	setActive(var_6_0.tf, true)

	var_6_0.tf.anchoredPosition = var_6_3
	var_6_0.anim.runtimeAnimatorController = self:getAnimator(arg_6_1, arg_6_2)
	var_6_0.tf.name = arg_6_1 .. "_" .. var_0_16[arg_6_2].name
	var_6_0.color = arg_6_2
	findTF(var_6_0.tf, "ad").localRotation = Quaternion.Euler(0, 0, 0)
	var_6_0.removeFlag = false

	if arg_6_1 == var_0_3 then
		var_6_0.effectTime = var_0_14
		var_6_0.effectIndex = 1
		var_6_0[LaunchBallGameConst.amulet_buff_back] = false
		var_6_0.concentrate = false
		var_6_0.fireIndex = LaunchBallAmulet.fireIndex
		var_6_0.overFlag = false
		var_6_0.overCount = 0
		LaunchBallAmulet.fireIndex = LaunchBallAmulet.fireIndex + 1
	elseif arg_6_1 == var_0_2 then
		-- block empty
	elseif arg_6_1 == var_0_4 then
		var_6_0.removeTime = var_0_15
	end

	return var_6_0
end

function LaunchBallAmulet:returnAmulete(arg_7_1, arg_7_2)
	setActive(arg_7_1.tf, false)
	table.insert(arg_7_2, arg_7_1)

	return
end

function LaunchBallAmulet:getColor()
	return self.amuletL.color
end

function LaunchBallAmulet:fireAmulet()
	if self.amuletL then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(LaunchBallGameVo.SFX_FIRE)

		self.amuletPos.x = math.cos(self.rad) * var_0_8
		self.amuletPos.y = math.sin(self.rad) * var_0_8
		self.amuletL.tf.anchoredPosition = self.amuletPos
		self.amuletL.angle = self.angle
		self.amuletL.rad = self.rad
		self.amuletL.speed = Vector2(math.cos(self.amuletL.rad) * var_0_10, math.sin(self.amuletL.rad) * var_0_10)

		self.amuletL.anim:Play("L_Fire")

		findTF(self.amuletL.tf, "ad").localEulerAngles = Vector3(0, 0, self.angle + var_0_11)

		if self.concentrateTime then
			self.amuletL.concentrate = true
			self.concentrateTime = self.concentrateTime - 1

			if self.concentrateTime <= 0 then
				self.concentrateTime = nil
			end
		end

		table.insert(self._amuletFires, self.amuletL)
		self:setAmuletL(nil)
	end

	return
end

function LaunchBallAmulet:randomFireAmulet(arg_10_1)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(LaunchBallGameVo.SFX_FIRE)

	local var_10_0 = self:getAmulete(var_0_3, self:getRandomAmuletType())

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		var_10_0[iter_10_0] = iter_10_1
	end

	local var_10_1 = math.random(1, 360)

	var_10_0.tf.anchoredPosition = Vector2(0, 0)
	var_10_0.rad = self.rad
	var_10_0.speed = Vector2(math.cos(math.deg2Rad * var_10_1) * var_0_10, math.sin(math.deg2Rad * var_10_1) * var_0_10)

	var_10_0.anim:Play("L_Fire")

	findTF(var_10_0.tf, "ad").localEulerAngles = Vector3(0, 0, var_10_1 + var_0_11)

	table.insert(self._amuletFires, var_10_0)

	return
end

function LaunchBallAmulet:setAmuletL(arg_11_1)
	self.amuletL = arg_11_1
	LaunchBallGameVo.amulet = self.amuletL

	return
end

function LaunchBallAmulet:createEF(arg_12_1)
	local var_12_0 = self:getAmulete(var_0_4, arg_12_1.color)

	arg_12_1.effectIndex = arg_12_1.effectIndex + 1
	var_12_0.tf.anchoredPosition = arg_12_1.tf.anchoredPosition

	local var_12_1 = math.cos(arg_12_1.rad)
	local var_12_2 = math.sin(arg_12_1.rad)

	findTF(var_12_0.tf, "ad").anchoredPosition = Vector2(var_12_1 * var_0_6[arg_12_1.effectIndex % var_0_5 + 1].offset.x - var_12_2 * var_0_6[arg_12_1.effectIndex % var_0_5 + 1].offset.y, var_12_1 * var_0_6[arg_12_1.effectIndex % var_0_5 + 1].offset.y + var_12_2 * var_0_6[arg_12_1.effectIndex % var_0_5 + 1].offset.x)

	var_12_0.anim:Play(var_0_6[arg_12_1.effectIndex % var_0_5 + 1].anim_name)
	table.insert(self.amuletEFs, var_12_0)

	return
end

function LaunchBallAmulet:getRandomAmuletType()
	if not LaunchBallGameVo.enemyColors or #LaunchBallGameVo.enemyColors == 0 then
		return var_0_1[math.random(1, #var_0_1)]
	else
		return LaunchBallGameVo.enemyColors[math.random(1, #LaunchBallGameVo.enemyColors)]
	end

	return
end

function LaunchBallAmulet:getAnimator(arg_14_1, arg_14_2)
	local var_14_0

	if arg_14_1 == var_0_3 then
		var_14_0 = self.amuletLAnimators
	elseif arg_14_1 == var_0_2 then
		var_14_0 = self.amuletSAnimators
	elseif arg_14_1 == var_0_4 then
		var_14_0 = self.amuletEFAnimators
	end

	for iter_14_0 = 1, #var_14_0 do
		if var_14_0[iter_14_0].type == arg_14_2 then
			return var_14_0[iter_14_0].animator
		end
	end

	return
end

function LaunchBallAmulet:getAmuletPos(arg_15_1, arg_15_2)
	return Vector2(math.cos(arg_15_2) * arg_15_1, math.sin(arg_15_2) * arg_15_1)
end

function LaunchBallAmulet:getAngle()
	return self.angle
end

function LaunchBallAmulet:eventCall(arg_17_1, arg_17_2)
	if arg_17_1 == LaunchBallGameScene.PLAYING_CHANGE then
		self.isPlaying = arg_17_2
	elseif arg_17_1 == LaunchBallGameScene.FIRE_AMULET then
		self:fireAmulet()
	elseif arg_17_1 == LaunchBallGameScene.RANDOM_FIRE then
		for iter_17_0 = 1, arg_17_2.num do
			self:randomFireAmulet(arg_17_2.data)
		end
	elseif arg_17_1 == LaunchBallGameScene.CHANGE_AMULET then
		if self.changeTime and LaunchBallGameVo.gameStepTime - self.changeTime < 1 then
			return
		end

		if self.amuletL then
			self.changeTime = LaunchBallGameVo.gameStepTime

			self:returnAmulete(self.amuletL, self.amuletLPool)
			self:setAmuletL(nil)
		end
	elseif arg_17_1 == LaunchBallGameScene.CONCENTRATE_TRIGGER then
		self.concentrateTime = arg_17_2.time
	elseif arg_17_1 == LaunchBallGameScene.SLEEP_TIME_TRIGGER then
		print("创建一个小蝴蝶")

		local var_17_0 = self:createButterfly()
	end

	return
end

function LaunchBallAmulet:getButterfly()
	return self.butterflys
end

function LaunchBallAmulet:createButterfly()
	local var_19_0 = tf(instantiate(self._butterflyTpl))
	local var_19_1 = GetComponent(findTF(var_19_0, "ad/anim"), typeof(Animator))

	var_19_0.anchoredPosition = Vector2(math.random(1, 20), math.random(1, 20))

	local var_19_2 = math.deg2Rad * math.random(1, 360)
	local var_19_3 = Vector2(math.cos(var_19_2) * var_0_7, math.sin(var_19_2) * var_0_7)
	local var_19_4 = 3

	findTF(var_19_0, "ad/anim").localScale = Vector3((var_19_3.x > 0 or nil) and (-1 * var_19_4 or 1 * var_19_4), var_19_4, var_19_4)

	table.insert(self.butterflys, {
		tf = var_19_0,
		anim = var_19_1,
		speed = var_19_3
	})
	setParent(var_19_0, self._content)
	setActive(var_19_0, true)

	return
end

function LaunchBallAmulet:clear()
	self:clearAmulet()

	return
end

function LaunchBallAmulet:clearAmulet()
	if self.amuletL then
		self:returnAmulete(self.amuletL, self.amuletLPool)
		self:setAmuletL(nil)
	end

	if self.amuletS then
		self:returnAmulete(self.amuletS, self.amuletSPool)

		self.amuletS = nil
	end

	if #self.amuletEFs > 0 then
		for iter_21_0 = #self.amuletEFs, 1, -1 do
			self:returnAmulete(table.remove(self.amuletEFs, iter_21_0), self.amuletEFPool)
		end
	end

	if self.butterflys and #self.butterflys > 0 then
		for iter_21_1 = #self.butterflys, 1, -1 do
			Destroy(self.butterflys[iter_21_1].tf)
		end

		self.butterflys = {}
	end

	return
end

return LaunchBallAmulet
