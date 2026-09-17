local var_0_0 = type
local var_0_1 = math.sqrt
local var_0_2 = math.abs
local var_0_3 = math.floor
local var_0_4 = math.min
local var_0_6 = table
local var_0_7 = table.insert
local var_0_8 = {}
local var_0_9 = {}
local var_0_10 = {}
local var_0_11 = {}

function BulletSprite:setBulletMoveConf(arg_1_1, arg_1_2)
	if arg_1_1 == "locktarget" then
		self._movingMgr = var_0_8.new(arg_1_2, self)
	elseif arg_1_1 == "lockposition" then
		self._movingMgr = var_0_9.new(arg_1_2, self)
	elseif arg_1_1 == "lockdirection" then
		self._movingMgr = var_0_10.new(arg_1_2, self)
	elseif arg_1_1 == "locktime" then
		self._movingMgr = var_0_11.new(arg_1_2, self)
	end

	self:setScale(self._movingMgr:getDirection() * STANDARD_SCALE * self._modelscale, STANDARD_SCALE * self._modelscale)
	self:setBaseDirection(self._movingMgr:getDirection())
end

BulletSprite.setFinalPosition = BulletSprite.setBulletMoveConf

local function var_0_12(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if cc.rectIntersectsRect(arg_2_0, arg_2_1) or cc.rectIntersectsRect(arg_2_2, arg_2_3) then
		return true
	else
		return arg_2_1.x > arg_2_0.x + arg_2_0.width and arg_2_2.x > arg_2_3.x + arg_2_3.width
	end
end

local function var_0_13(arg_3_0, arg_3_1)
	return {
		x = arg_3_0.x - arg_3_1.x,
		y = arg_3_0.y - arg_3_1.y
	}
end

local function var_0_14(arg_4_0)
	return var_0_1(arg_4_0.x * arg_4_0.x + arg_4_0.y * arg_4_0.y)
end

local function var_0_15(arg_5_0, arg_5_1)
	return var_0_14(var_0_13(arg_5_0, arg_5_1))
end

function var_0_8.new(arg_6_0, arg_6_1)
	local var_6_0 = setmetatable({}, {
		__index = var_0_8
	})

	var_6_0:init(arg_6_0, arg_6_1)

	return var_6_0
end

function var_0_8:init(arg_7_1, arg_7_2)
	self._type = "locktarget"

	if arg_7_1.object == "self" then
		self._target = arg_7_2.character or FightManager.getCharacter(arg_7_2.target)
	end

	self._executeBuffer = nil
	self._speed = cc.p(0, 0)

	if arg_7_1.offsetY <= 1 and var_0_2(arg_7_1.offsetX) <= 0.5 then
		self._crash = true
	end

	local var_7_0 = self._target

	self._finaloffset = cc.p(0, 0)
	self._finaloffset.x = var_0_3(arg_7_1.offsetX * var_7_0:getModelWidth() * var_7_0:getDirection())
	self._finaloffset.y = var_0_3(arg_7_1.offsetY * var_7_0:getModelHeight())

	local var_7_1, var_7_2 = var_7_0:get2DPosition()

	self._finalpos = cc.p(var_7_1, var_7_2)
	self._direction = arg_7_2._initpos._x <= self._finaloffset.x + var_7_1 and 1 or -1
	self._unitorder = arg_7_2:is_target_teammate(self._target) and 999 or arg_7_2._unitorder
end

function var_0_8:getDirection()
	return self._direction
end

function var_0_8:update(arg_9_1, arg_9_2)
	if self._target._instance and self._target:canBeLocked(self._unitorder) then
		if self._executeBuffer then
			local var_9_0 = self._target:getRect()

			arg_9_2:setPosition(cc.p(var_9_0.x + var_9_0.width / 2, var_9_0.y + self._finaloffset.y))

			self._executeBuffer = nil
			arg_9_2.yield = true

			arg_9_2:executeWithDestroy(arg_9_2.info.attack, arg_9_2.target)

			return
		end

		if self._crash then
			local var_9_1 = self._target:getRect()
			local var_9_2 = cc.rect(var_9_1.x + var_9_1.width / 2 + self._target:getSpeed() * arg_9_1, var_9_1.y, var_9_1.width, var_9_1.height)
			local var_9_3, var_9_4 = arg_9_2:get2DPosition()
			local var_9_5 = (var_9_1.x + var_9_1.width / 2 - var_9_3) * (arg_9_2._basicspeed * arg_9_1) / var_0_1((var_9_1.x + var_9_1.width / 2 - var_9_3) * (var_9_1.x + var_9_1.width / 2 - var_9_3) + (var_9_1.y + self._finaloffset.y - var_9_4) * (var_9_1.y + self._finaloffset.y - var_9_4))
			local var_9_6 = (var_9_1.y + self._finaloffset.y - var_9_4) * (arg_9_2._basicspeed * arg_9_1) / var_0_1((var_9_1.x + var_9_1.width / 2 - var_9_3) * (var_9_1.x + var_9_1.width / 2 - var_9_3) + (var_9_1.y + self._finaloffset.y - var_9_4) * (var_9_1.y + self._finaloffset.y - var_9_4))

			if var_0_12(cc.rect(var_9_3 - arg_9_2.size.width * ((arg_9_2._anchor.x - 0.5) * arg_9_2._basedir + 0.5), var_9_4 - arg_9_2.size.height * arg_9_2._anchor.y, arg_9_2.size.width, arg_9_2.size.height), var_9_1, cc.rect(var_9_3 + var_9_5 - arg_9_2.size.width * ((arg_9_2._anchor.x - 0.5) * arg_9_2._basedir + 0.5), var_9_4 + var_9_6 - arg_9_2.size.height * arg_9_2._anchor.y, arg_9_2.size.width, arg_9_2.size.height), var_9_2) then
				self._speed = cc.p(var_9_2.x + var_9_2.width * (1 - self._direction) / 2 - (var_9_3 + arg_9_2.size.width * (1 - arg_9_2._anchor.x) * self._direction), var_9_2.y + self._finaloffset.y - var_9_4)

				arg_9_2:setHitted(true)

				self._executeBuffer = true
			else
				self._speed = cc.p(var_9_5, var_9_6)
			end
		else
			local var_9_7 = arg_9_2._basicspeed * arg_9_1
			local var_9_8 = self:getStandardPosition()
			local var_9_9 = self._target:getModelSize().width
			local var_9_10 = self._target:getModelSize().height
			local var_9_11 = self._target:getStandardPosition() + self._target:getSpeed() * arg_9_1

			if FightManager.fightSpriteCrash({
				left = var_9_8 + self._direction * (arg_9_2._basicspeed * arg_9_1) - arg_9_2.size.width / 2,
				right = var_9_8 + self._direction * (arg_9_2._basicspeed * arg_9_1) + arg_9_2.size.width / 2
			}, {
				left = var_9_11 - var_9_9 / 2,
				right = var_9_11 + var_9_9 / 2
			}) then
				self._speed = cc.p(var_9_11 - var_9_8, 0)
				self._executeBuffer = true
			else
				self._speed = cc.p(self._direction * var_9_7, 0)
			end
		end
	else
		self._speed = cc.p(self._direction * arg_9_2._basicspeed * arg_9_1, 0)
	end
end

function var_0_8:getSpeed()
	return self._speed
end

function var_0_8.setSpeed(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._speed = cc.p(arg_11_1 * arg_11_2, 0)
end

function var_0_8:initCheck(arg_12_1)
	if cc.rectIntersectsRect(cc.rect(arg_12_1._initpos._x - arg_12_1.size.width * ((arg_12_1._anchor.x - 0.5) * arg_12_1._basedir + 0.5), arg_12_1._initpos._y - arg_12_1.size.height * arg_12_1._anchor.y, arg_12_1.size.width, arg_12_1.size.height), (self._target:getRect())) then
		self._speed = cc.p(0, 0)
		self._executeBuffer = true
	end
end

function var_0_8.finish(arg_13_0)
	return
end

function var_0_9.new(arg_14_0, arg_14_1)
	local var_14_0 = setmetatable({}, {
		__index = var_0_9
	})

	var_14_0:init(arg_14_0, arg_14_1)

	return var_14_0
end

function var_0_9:init(arg_15_1, arg_15_2)
	self._type = "lockposition"

	if var_0_0(arg_15_1.pos) == "string" then
		self._pos = arg_15_2.character._lockdistance or arg_15_1.pos
	end

	self._speed = cc.p(0, 0)
	self._direction = self._pos >= 0 and arg_15_2.character:getDirection() or -1 * arg_15_2.character:getDirection()
	self._unitorder = arg_15_2._unitorder
end

function var_0_9:getDirection()
	return self._direction
end

function var_0_9:update(arg_17_1, arg_17_2)
	if arg_17_2._distance >= var_0_2(self._pos) then
		arg_17_2.yield = true

		arg_17_2:executeWithDestroy(arg_17_2.info.attack)

		return
	else
		self._speed = cc.p(self._direction * (arg_17_2._basicspeed * arg_17_1), 0)
	end
end

function var_0_9:getSpeed()
	return self._speed
end

function var_0_9.setSpeed(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0._speed = cc.p(arg_19_1 * arg_19_2, 0)
end

function var_0_9.initCheck(arg_20_0, arg_20_1)
	return
end

function var_0_9.finish(arg_21_0)
	return
end

function var_0_10.new(arg_22_0, arg_22_1)
	local var_22_0 = setmetatable({}, {
		__index = var_0_10
	})

	var_22_0:init(arg_22_0, arg_22_1)

	return var_22_0
end

function var_0_10.init(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0._type = "lockdirection"
	arg_23_0._direction = arg_23_1.direction * arg_23_2.character:getDirection()
	arg_23_0._crashtype = arg_23_1.crashtype
	arg_23_0._executeBuffer = nil
	arg_23_0._finished = false
	arg_23_0._speed = cc.p(0, 0)
	arg_23_0._hittedinfo = {}
	arg_23_0._attachedCarry = setmetatable({}, {
		__mode = "kv"
	})

	if arg_23_2.charactertype == "player" then
		arg_23_0._targetpool = arg_23_1.targettype == "oponent" and "enemies" or "players"
	elseif arg_23_2.charactertype == "enemy" then
		arg_23_0._targetpool = arg_23_1.targettype == "oponent" and "players" or "enemies"
	end

	if arg_23_1.targettype == "oponent" then
		arg_23_0._unitorder = arg_23_2._unitorder or 999
	end
end

function var_0_10:getDirection()
	return self._direction
end

function var_0_10:update(arg_25_1, arg_25_2)
	if self._executeBuffer then
		if self._crashtype == "cross" then
			for iter_25_0, iter_25_1 in pairs(self._executeBuffer) do
				if iter_25_1._instance and iter_25_1:canBeLocked(self._unitorder) then
					arg_25_2:execute(arg_25_2.info.attack, iter_25_1.index)

					self._hittedinfo[iter_25_1.index] = true
				end
			end

			self._executeBuffer = nil
		elseif self._crashtype == "once" then
			arg_25_2.yield = true

			local var_25_0 = {}

			for iter_25_2, iter_25_3 in pairs(self._executeBuffer) do
				if iter_25_3._instance and iter_25_3:canBeLocked(self._unitorder) then
					var_0_7(var_25_0, iter_25_3.index)

					break
				end
			end

			arg_25_2:executeWithDestroy(arg_25_2.info.attack, var_25_0)

			self._executeBuffer = nil

			return
		elseif self._crashtype == "carry" then
			for iter_25_4, iter_25_5 in pairs(self._executeBuffer) do
				if iter_25_5._instance and iter_25_5:canBeLocked(self._unitorder) then
					iter_25_5:setCarriedConf(self)
					arg_25_2:execute(arg_25_2.info.attack, iter_25_5.index)

					self._hittedinfo[iter_25_5.index] = true
				end
			end

			self._executeBuffer = nil
		end
	end

	local var_25_1 = arg_25_2:getStandardPosition() + self._direction * arg_25_2._basicspeed * arg_25_1
	local var_25_2 = {
		left = var_25_1 - arg_25_2.size.width / 2,
		right = var_25_1 + arg_25_2.size.width / 2
	}

	for iter_25_6, iter_25_7 in pairs(FightManager[self._targetpool]) do
		if iter_25_7._instance and iter_25_7.index ~= arg_25_2.character.index and iter_25_7:canBeLocked(self._unitorder) and not self._hittedinfo[iter_25_7.index] then
			local var_25_3 = iter_25_7:getModelSize().width
			local var_25_4 = iter_25_7:getStandardPosition() + iter_25_7:getSpeed() * arg_25_1

			if FightManager.fightSpriteCrash(var_25_2, {
				left = var_25_4 - var_25_3 / 2,
				right = var_25_4 + var_25_3 / 2
			}) then
				self._executeBuffer = self._executeBuffer or {}

				var_0_7(self._executeBuffer, iter_25_7)
			end
		end
	end

	self._speed = cc.p(self._direction * arg_25_2._basicspeed * arg_25_1, 0)

	if self._crashtype == "carry" then
		for iter_25_8, iter_25_9 in ipairs(self._attachedCarry) do
			iter_25_9:update(self._direction * arg_25_2._basicspeed)
		end
	end
end

function var_0_10:getSpeed()
	return self._speed
end

function var_0_10:setSpeed(arg_27_1, arg_27_2)
	self._speed = cc.p(arg_27_1 * arg_27_2, 0)

	if self._crashtype == "carry" then
		for iter_27_0, iter_27_1 in ipairs(self._attachedCarry) do
			iter_27_1:update(arg_27_1)
		end
	end
end

function var_0_10:initCheck(arg_28_1)
	local var_28_0 = {
		left = arg_28_1._initpos._x - arg_28_1.size.width / 2,
		right = arg_28_1._initpos._x + arg_28_1.size.width / 2
	}

	for iter_28_0, iter_28_1 in pairs(FightManager[self._targetpool]) do
		if iter_28_1._instance and iter_28_1.index ~= arg_28_1.character.index and iter_28_1:canBeLocked(self._unitorder) and not self._hittedinfo[iter_28_1.index] and FightManager.fightSpriteCrash(var_28_0, iter_28_1:getCrashRect()) then
			self._executeBuffer = self._executeBuffer or {}

			var_0_7(self._executeBuffer, iter_28_1)
		end
	end
end

function var_0_10:attach(arg_29_1)
	var_0_6.insert(self._attachedCarry, arg_29_1)
end

function var_0_10:isFinish()
	return self._finished
end

function var_0_10.finish(arg_31_0)
	arg_31_0._finished = true
end

function var_0_11.new(arg_32_0, arg_32_1)
	local var_32_0 = setmetatable({}, {
		__index = var_0_11
	})

	var_32_0:init(arg_32_0, arg_32_1)

	return var_32_0
end

function var_0_11:init(arg_33_1, arg_33_2)
	self._type = "locktime"

	if arg_33_1.frame then
		self._duration = arg_33_1.frame / 30 or arg_33_1.time
	end

	self._elapse = 0

	if arg_33_1.object == "self" then
		self._target = arg_33_2.character or FightManager.getCharacter(arg_33_2.target)
	end

	self._speed = cc.p(0, 0)
	self._finaloffset = cc.p(0, 0)
	self._finaloffset.x = var_0_3(arg_33_1.offsetX * self._target:getModelWidth() * self._target:getDirection())
	self._finaloffset.y = var_0_3(arg_33_1.offsetY * self._target:getModelHeight())

	local var_33_0, var_33_1 = self._target:get2DPosition()

	self._finalpos = cc.p(var_33_0, var_33_1)

	local var_33_2 = arg_33_2._initpos._x
	local var_33_3 = self._finaloffset.x + var_33_0

	self._distance = var_0_15(cc.p(arg_33_2._initpos._x, arg_33_2._initpos._y), cc.p(self._finaloffset.x + var_33_0, self._finaloffset.y + var_33_1))
	self._direction = var_33_2 <= var_33_3 and 1 or -1
	self._unitorder = arg_33_2:is_target_teammate(self._target) and 999 or arg_33_2._unitorder
end

function var_0_11:getDirection()
	return self._direction
end

function var_0_11:update(arg_35_1, arg_35_2)
	local var_35_0 = self._elapse + arg_35_1

	if self._elapse >= self._duration then
		if self._target._instance and self._target:canBeLocked(self._unitorder) then
			local var_35_1, var_35_2 = self._target:get2DPosition()

			arg_35_2:setPosition(cc.p(var_35_1, var_35_2 + self._finaloffset.y))

			arg_35_2.yield = true

			arg_35_2:executeWithDestroy(arg_35_2.info.attack, arg_35_2.target, true)
		else
			arg_35_2:destroy()
		end

		return
	end

	if self._target._instance and self._target:canBeLocked(self._unitorder) then
		local var_35_3, var_35_4 = self._target:get2DPosition()

		self._finalpos = cc.p(var_35_3, var_35_4)

		local var_35_5, var_35_6 = arg_35_2:get2DPosition()

		self._distance = var_0_15(cc.p(arg_35_2._initpos._x, arg_35_2._initpos._y), cc.p(var_35_3, var_35_4 + self._finaloffset.y))
		self._speed = cc.p((var_35_3 - arg_35_2._initpos._x) * var_0_4(1, var_35_0 / self._duration) - (var_35_5 - arg_35_2._initpos._x), (var_35_4 + self._finaloffset.y - arg_35_2._initpos._y) * var_0_4(1, var_35_0 / self._duration) - (var_35_6 - arg_35_2._initpos._y))
	else
		self._speed = cc.p(self._distance / self._duration * self._direction * arg_35_1, 0)
	end

	self._elapse = var_35_0
end

function var_0_11:getSpeed()
	return self._speed
end

function var_0_11.setSpeed(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0._speed = cc.p(arg_37_1 * arg_37_2, 0)
end

function var_0_11.initCheck(arg_38_0, arg_38_1)
	return
end

function var_0_11.finish(arg_39_0)
	return
end
