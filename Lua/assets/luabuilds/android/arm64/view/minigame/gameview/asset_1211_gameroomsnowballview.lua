local GameRoomSnowballView = class("GameRoomSnowballView", import("..BaseMiniGameView"))
local var_0_1 = {
	-1920,
	-1080,
	1920,
	1080
}
local var_0_2 = "snowball_type_player"
local var_0_3 = "snowball_type_enemy"
local var_0_4 = "win"
local var_0_5 = "fail"
local var_0_6 = 3
local var_0_7 = 6
local var_0_8 = "charactor_type_other"
local var_0_9 = "charactor_type_enemy"
local var_0_10 = {}
local var_0_11 = {}

var_0_11.type = "charactor_type_other"
var_0_11.skin_names = {
	"bailu",
	"huangjia",
	"jiujiu"
}
var_0_11.score = {
	-50,
	200,
	-50
}
var_0_10.charactor_type_other = var_0_11
var_0_10.charactor_type_enemy = {
	type = "charactor_type_enemy",
	skin_names = {
		"enemy1",
		"enemy2",
		"enemy3",
		"enemy4",
		"enemy5",
		"enemy6"
	},
	score = {
		100,
		100,
		100,
		100,
		100,
		100
	}
}

local var_0_12 = 3
local var_0_13 = 1
local var_0_14 = 18
local var_0_15 = 30
local var_0_16 = 3
local var_0_18 = {
	12,
	14,
	15,
	16,
	17
}
local var_0_19 = {
	{
		3,
		5
	},
	{
		3,
		4
	},
	{
		2,
		4
	},
	{
		2,
		3
	},
	{
		2,
		2
	}
}
local var_0_20 = {
	{
		90,
		10,
		0
	},
	{
		70,
		20,
		10
	},
	{
		60,
		20,
		20
	},
	{
		50,
		30,
		20
	},
	{
		40,
		40,
		20
	}
}
local var_0_21 = {
	0,
	30,
	60,
	90,
	120
}
local var_0_22 = 1.5
local var_0_23 = {
	{
		weight = 70,
		type = "charactor_type_enemy",
		indexs = {
			1,
			2,
			3,
			4,
			5,
			6
		},
		time = {
			8,
			10
		},
		attack_time = {
			4,
			6
		}
	},
	{
		weight = 30,
		type = "charactor_type_other",
		indexs = {
			4,
			5,
			6
		},
		time = {
			5,
			7
		}
	}
}
local var_0_24 = "event:/ui/ddldaoshu2"
local var_0_25 = "event:/ui/sou"
local var_0_26 = "event:/ui/xueqiu"

local function var_0_28(arg_2_0)
	local var_2_0 = {}

	function var_2_0:Ctor()
		self._tf = arg_2_0
		self.reloadProgress = findTF(self._tf, "reloadProgress")
		self.playerAnimator = GetComponent(findTF(self._tf, "player"), typeof(Animator))
		self.playerDft = GetComponent(findTF(self._tf, "player"), typeof(DftAniEvent))

		self.playerDft:SetStartEvent(function()
			self.playerAnimator:ResetTrigger("throw")
			self.playerAnimator:SetBool("snowball", true)

			return
		end)
		self.playerDft:SetTriggerEvent(function()
			self:throwSnowball()

			return
		end)
		self.playerDft:SetEndEvent(function()
			return
		end)

		self.heartPos = findTF(self._tf, "heartPos")
		self.tplHeart = findTF(self._tf, "heartPos/tplHeart")
		self.collider = findTF(self._tf, "collider")
		self.throwCallback = nil
		self.damageCallback = nil
		self.gameOverCallback = nil

		return
	end

	function var_2_0:prepare()
		self._life = var_0_12
		self._reloadTime = nil
		self._skillTime = nil
		self.stepTime = 0

		self.playerAnimator:ResetTrigger("skill")
		self.playerAnimator:ResetTrigger("throw")
		self.playerAnimator:ResetTrigger("damage")
		self.playerAnimator:ResetTrigger("reload")
		self.playerAnimator:ResetTrigger("fail")
		self.playerAnimator:ResetTrigger("win")
		self.playerAnimator:ResetTrigger("fail")
		self.playerAnimator:SetTrigger("restart")
		self.playerAnimator:ResetTrigger("restart")
		self:Clear()

		return
	end

	function var_2_0:step()
		self.stepTime = self.stepTime + Time.deltaTime
		self._reloadTime = self._reloadTime or self.stepTime

		if not self.playerAnimator:GetBool("snowball") and self.stepTime - self._reloadTime > var_0_13 then
			self:reload()
		end

		if not self.playerAnimator:GetBool("snowball") and not isActive(self.reloadProgress) then
			setActive(self.reloadProgress, true)
		elseif self.playerAnimator:GetBool("snowball") and isActive(self.reloadProgress) then
			setActive(self.reloadProgress, false)
		end

		setSlider(self.reloadProgress, 0, 1, ((self.stepTime - self._reloadTime) / var_0_13 > 1 or nil) and 1)

		return
	end

	function var_2_0:reload()
		self.playerAnimator:SetTrigger("reload")

		return
	end

	function var_2_0:skill()
		if self._skillTime and self.stepTime - self._skillTime < var_0_15 then
			return
		end

		self._skillTime = self.stepTime
		self._reloadTime = self.stepTime

		self.playerAnimator:SetTrigger("skill")

		return
	end

	function var_2_0:throw()
		if self.playerAnimator:GetBool("snowball") then
			self.playerAnimator:SetTrigger("throw")

			return true
		end

		return false
	end

	function var_2_0:damage()
		if self._life == 0 then
			return
		end

		self._life = self._life - 1

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_26)

		if self.damageCallback then
			self.damageCallback()
		end

		if self._life > 0 then
			self.playerAnimator:SetTrigger("damage")
			self:createHeart()
		else
			self.playerAnimator:SetTrigger("fail")

			if self.gameOverCallback then
				self.gameOverCallback()
			end
		end

		return
	end

	function var_2_0:createHeart()
		local var_13_0 = tf(instantiate(self.tplHeart))

		GetComponent(var_13_0, typeof(DftAniEvent)):SetEndEvent(function()
			Destroy(var_13_0)

			return
		end)
		setParent(var_13_0, self.heartPos)
		setActive(var_13_0, true)

		return
	end

	function var_2_0:setSpeed(arg_15_1)
		self.playerAnimator.speed = arg_15_1

		return
	end

	function var_2_0:throwSnowball()
		if self.throwCallback then
			self.throwCallback(findTF(self._tf, "throwPos").position)
		end

		self.playerAnimator:SetBool("snowball", false)

		self._reloadTime = self.stepTime

		return
	end

	function var_2_0:move(arg_17_1)
		self._tf.anchoredPosition = arg_17_1

		return
	end

	function var_2_0:settlement(arg_18_1)
		if arg_18_1 == var_0_5 then
			self.playerAnimator:SetTrigger("fail")
		elseif arg_18_1 == var_0_4 then
			self.playerAnimator:SetTrigger("win")
		end

		return
	end

	function var_2_0:stop()
		self.playerAnimator.speed = 0

		return
	end

	function var_2_0:resume()
		self.playerAnimator.speed = 1

		return
	end

	function var_2_0:getTargetPosition()
		return findTF(self._tf, "targetPos").position
	end

	function var_2_0:getColliderBound()
		return self.collider.position, self.collider.sizeDelta
	end

	function var_2_0:getLife()
		return self._life
	end

	function var_2_0.Clear(arg_24_0)
		arg_24_0._life = var_0_12

		return
	end

	var_2_0:Ctor()

	return var_2_0
end

local function var_0_29(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = {
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	}

	var_25_0._id = nil

	function var_25_0:Ctor()
		self._animator = GetComponent(findTF(self._tf, "snowball"), typeof(Animator))
		self.snowballDft = GetComponent(findTF(self._tf, "snowball"), typeof(DftAniEvent))

		self.snowballDft:SetEndEvent(function()
			self._removeFlag = true

			self:dispose()

			return
		end)

		return
	end

	function var_25_0.setId(arg_28_0, arg_28_1)
		arg_28_0._id = arg_28_1

		return
	end

	function var_25_0:getId(arg_29_1)
		return self._id
	end

	function var_25_0:setPosition(arg_30_1)
		self._tf.anchoredPosition = arg_30_1
		self._tf.localEulerAngles = Vector3(0, 0, math.atan(arg_25_1.y / arg_25_1.x) * math.rad2Deg)

		return
	end

	function var_25_0:hit()
		self._hitFlag = true

		self._animator:SetTrigger("hit")

		return
	end

	function var_25_0:move()
		local var_32_0 = Time.deltaTime / 0.015

		if Time.deltaTime / 0.015 > 2 then
			var_32_0 = 1
		end

		local var_32_1 = self._tf.anchoredPosition

		if self._hitFlag then
			var_32_0 = var_32_0 / 8
		end

		var_32_1.x = var_32_1.x + self._moveDirect.x * var_32_0
		var_32_1.y = var_32_1.y + self._moveDirect.y * var_32_0
		self._tf.anchoredPosition = var_32_1

		return
	end

	function var_25_0:getRemoveFlag()
		return self._removeFlag
	end

	function var_25_0:checkOutScene()
		if self._tf.anchoredPosition.x < var_0_1[1] or self._tf.anchoredPosition.x > var_0_1[3] or self._tf.anchoredPosition.y < var_0_1[2] or self._tf.anchoredPosition.y > var_0_1[4] then
			self:dispose()

			return true
		end

		return false
	end

	function var_25_0:getAnchoredPos()
		return self._tf.anchoredPosition
	end

	function var_25_0:getTargetPos()
		return self.tar
	end

	function var_25_0:getType()
		return self._type
	end

	function var_25_0:getIndex()
		return self._targetIndex
	end

	function var_25_0:checkArrived(arg_39_1, arg_39_2)
		if self._hitFlag then
			return
		end

		local var_39_0 = self:getAnchoredPos()

		if var_39_0.x > arg_39_1.x and var_39_0.x < arg_39_1.x + arg_39_2.x and var_39_0.y > arg_39_1.y and var_39_0.y < arg_39_1.y + arg_39_2.y then
			return true
		end

		return false
	end

	function var_25_0:getArrived()
		if self._hitFlag then
			return
		end

		local var_40_0 = self:getAnchoredPos()

		if math.abs(self._targetPosition.x - var_40_0.x) <= math.abs(self._moveDirect.x * 2) and math.abs(self._targetPosition.y - var_40_0.y) <= math.abs(self._moveDirect.y * 2) then
			return true
		end

		return false
	end

	function var_25_0:dispose()
		if self._tf then
			Destroy(self._tf)

			self._tf = nil
		end

		return
	end

	var_25_0:Ctor()

	return var_25_0
end

local function var_0_30(arg_42_0, arg_42_1)
	local var_42_0 = {
		_snowballContainer = arg_42_0,
		_tplSnowball = arg_42_1,
		snowballs = {}
	}

	var_42_0._snowBallId = 0

	function var_42_0:createSnowball(arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_25)

		local var_43_0 = tf(Instantiate(self._tplSnowball))

		SetParent(var_43_0, self._snowballContainer)
		setActive(var_43_0, true)

		if arg_43_2.x < arg_43_1.x then
			var_43_0.localScale = Vector3(-1, 1, 1)
		end

		local var_43_1 = var_0_29(var_43_0, Vector3(arg_43_3 * (arg_43_2.x > arg_43_1.x and 1 or -1), (arg_43_2.y - arg_43_1.y) / (arg_43_2.x - arg_43_1.x) * (arg_43_3 * (arg_43_2.x > arg_43_1.x and 1 or -1)), 0), arg_43_2, arg_43_4, arg_43_5)

		var_43_1:setId(self:getSnowBallId())
		var_43_1:setPosition(arg_43_1)
		table.insert(self.snowballs, var_43_1)

		return
	end

	function var_42_0:prepare()
		for iter_44_0 = #self.snowballs, 1, -1 do
			table.remove(self.snowballs, iter_44_0)
			self.snowballs[iter_44_0]:dispose()
		end

		return
	end

	function var_42_0:step()
		for iter_45_0 = #self.snowballs, 1, -1 do
			if self.snowballs[iter_45_0]:getRemoveFlag() or self.snowballs[iter_45_0]:checkOutScene() then
				table.remove(self.snowballs, iter_45_0)
			else
				self.snowballs[iter_45_0]:move()
			end
		end

		return
	end

	function var_42_0:clearEnemySnowball()
		for iter_46_0 = #self.snowballs, 1, -1 do
			if self.snowballs[iter_46_0]:getType() == var_0_3 then
				self.snowballs[iter_46_0]:hit()
			end
		end

		return
	end

	function var_42_0:snowballHit(arg_47_1)
		if not arg_47_1 then
			return
		end

		for iter_47_0 = #self.snowballs, 1, -1 do
			if self.snowballs[iter_47_0]:getId() == arg_47_1 then
				self.snowballs[iter_47_0]:hit()
			end
		end

		return
	end

	function var_42_0:getSnowBallId()
		self._snowBallId = self._snowBallId + 1

		return self._snowBallId
	end

	function var_42_0:getSnowballs()
		return Clone(self.snowballs)
	end

	return var_42_0
end

local function var_0_31(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4)
	local var_50_0 = {
		_tf = arg_50_1,
		_index = arg_50_2,
		_data = arg_50_0,
		_name = arg_50_3,
		_score = arg_50_4,
		Ctor = function(self)
			self.leaveCallback = nil
			self.collider = findTF(self._tf, "collider")
			self.otherAnimator = GetComponent(findTF(self._tf, "char"), typeof(Animator))
			self.otherDft = GetComponent(findTF(self._tf, "char"), typeof(DftAniEvent))

			self.otherDft:SetEndEvent(function()
				if self.leaveCallback then
					self.leaveCallback()
				end

				self:dispose()

				return
			end)

			self._leaveTime = math.random(self._data.time[1], self._data.time[2])

			return
		end,
		step = function(self)
			if self.removeFlag then
				return
			end

			self._leaveTime = self._leaveTime - Time.deltaTime

			return
		end,
		getColliderBound = function(self)
			return self.collider.position, self.collider.sizeDelta
		end,
		apear = function(self)
			self.otherAnimator:SetTrigger("apear")

			return
		end,
		damage = function(self)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_26)
			self.otherAnimator:SetTrigger("damage")

			return
		end,
		leave = function(self)
			self.otherAnimator:SetTrigger("leave")

			return
		end,
		getLeaveTime = function(self)
			return self._leaveTime
		end,
		getScore = function(self)
			return self._score
		end,
		getType = function(self)
			return self._data.type
		end,
		getName = function(self)
			return self._name
		end,
		setSpeed = function(self, arg_62_1)
			self.otherAnimator.speed = arg_62_1

			return
		end,
		getPosition = function(self)
			return self._tf.position
		end,
		dispose = function(self)
			self.leaveCallback = nil

			if self._tf then
				Destroy(self._tf)

				self._tf = nil
			end

			self.removeFlag = true

			return
		end
	}

	var_50_0:Ctor()

	return var_50_0
end

local function var_0_32(arg_65_0, arg_65_1, arg_65_2, arg_65_3, arg_65_4)
	local var_65_0 = {
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(self)
			self.leaveCallback = nil
			self.enemyAnimator = GetComponent(findTF(self._tf, "char"), typeof(Animator))
			self.enemyDft = GetComponent(findTF(self._tf, "char"), typeof(DftAniEvent))
			self.collider = findTF(self._tf, "collider")
			self.throwPos = findTF(self._tf, "throwPos")

			self.enemyDft:SetEndEvent(function()
				if self.leaveCallback then
					self.leaveCallback()
				end

				self:dispose()

				return
			end)
			self.enemyDft:SetTriggerEvent(function()
				if self._throwCallback then
					self._throwCallback(self.throwPos.position, self._index)
				end

				return
			end)

			self._leaveTime = math.random(self._data.time[1], self._data.time[2])
			self._activeTime = 0

			return
		end
	}

	function var_65_0.setThrowCallback(arg_69_0, arg_69_1)
		var_65_0._throwCallback = arg_69_1

		return
	end

	function var_65_0:getColliderBound()
		return self.collider.position, self.collider.sizeDelta
	end

	function var_65_0:step()
		if self.removeFlag then
			return
		end

		self._leaveTime = self._leaveTime - Time.deltaTime
		self._activeTime = self._activeTime + Time.deltaTime

		if self._activeTime > var_0_22 then
			self._activeTime = 0

			if self:getSnowball() then
				self:throw()
				self.enemyAnimator:SetBool("snowball", false)
			else
				self.enemyAnimator:SetBool("snowball", true)
				self:reload()
			end
		end

		return
	end

	function var_65_0:apear()
		self.enemyAnimator:SetTrigger("apear")

		return
	end

	function var_65_0:damage()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_26)
		self.enemyAnimator:SetTrigger("damage")

		return
	end

	function var_65_0:leave()
		self.enemyAnimator:SetTrigger("leave")

		return
	end

	function var_65_0:reload()
		self.enemyAnimator:SetTrigger("reload")

		return
	end

	function var_65_0:throw()
		self.enemyAnimator:SetTrigger("throw")

		return
	end

	function var_65_0:hit()
		self.enemyAnimator:SetTrigger("hit")

		return
	end

	function var_65_0:getSnowball()
		return self.enemyAnimator:GetBool("snowball")
	end

	function var_65_0:getLeaveTime()
		return self._leaveTime
	end

	function var_65_0:getType()
		return self._data.type
	end

	function var_65_0:getScore()
		return self._score
	end

	function var_65_0:setSpeed(arg_82_1)
		self.enemyAnimator.speed = arg_82_1

		return
	end

	function var_65_0:getName()
		return self._name
	end

	function var_65_0:getPosition()
		return self._tf.position
	end

	function var_65_0:dispose()
		self.leaveCallback = nil

		if self._tf then
			Destroy(self._tf)

			self._tf = nil
		end

		self.removeFlag = true

		return
	end

	var_65_0:Ctor()

	return var_65_0
end

local function var_0_33(arg_86_0, arg_86_1)
	local var_86_0 = {
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}

	var_86_0.apearStepTime = nil
	var_86_0.gameStepTime = 0

	function var_86_0:Ctor()
		for iter_87_0 = 1, var_0_7 do
			self.charators[iter_87_0] = 0
		end

		self.throwCallback = nil
		self.charactorDamageCallback = nil

		return
	end

	function var_86_0:prepare()
		for iter_88_0, iter_88_1 in pairs(self.charators) do
			if iter_88_1 ~= 0 then
				iter_88_1:dispose()

				self.charators[iter_88_0] = 0
			end
		end

		self.gameStepTime = 0
		self.apearStepTime = nil

		return
	end

	function var_86_0:step()
		self.gameStepTime = self.gameStepTime + Time.deltaTime

		if self.gameStepTime > self:getNextApearTime() then
			for iter_89_0 = 1, self:getApearAmount() do
				self:apearCharactor()
			end

			self:setNextApearTime()
		end

		for iter_89_1 = 1, #self.charators do
			if self.charators[iter_89_1] ~= 0 then
				local var_89_0 = self.charators[iter_89_1]:getLeaveTime()

				if self.charators[iter_89_1]:getLeaveTime() < 0 then
					self:leaveCharactor(iter_89_1)
				else
					self.charators[iter_89_1]:step()
				end
			end
		end

		return
	end

	function var_86_0:leaveCharactor(arg_90_1)
		if self.charators[arg_90_1] ~= 0 then
			self.charators[arg_90_1]:leave()

			self.charators[arg_90_1] = 0
		end

		return
	end

	function var_86_0:removeCharactor(arg_91_1)
		if self.charators[arg_91_1] ~= 0 then
			self.charators[arg_91_1] = 0
		end

		return
	end

	function var_86_0:damageEnemy()
		for iter_92_0 = 1, #self.charators do
			if self.charators[iter_92_0] and self.charators[iter_92_0] ~= 0 and self.charators[iter_92_0]:getScore() > 0 then
				if self.charactorDamageCallback then
					self.charactorDamageCallback(self.charators[iter_92_0]:getPosition(), self.charators[iter_92_0]:getScore())
				end

				self.charators[iter_92_0]:damage()
				self:removeCharactor(iter_92_0)
			end
		end

		return
	end

	function var_86_0:getCharactorByIndex(arg_93_1)
		return self.charators[arg_93_1]
	end

	function var_86_0:apearCharactor()
		local var_94_0 = self:getAbleRandomDatas()

		if not var_94_0 then
			return
		end

		local var_94_1 = self:getDataByWeight(var_94_0)

		if not var_94_1 then
			return
		end

		local var_94_2, var_94_3 = self:getCharactorName(var_0_10[var_94_1.type])
		local var_94_4 = self:getCharactorRandomIndex(var_94_1)
		local var_94_5 = self:createCharactor(var_94_1, var_94_4, var_94_2, var_94_3)

		if var_94_5 then
			self:addCharactor(var_94_5, var_94_4)
		end

		return
	end

	function var_86_0:setSpeed(arg_95_1)
		self.speedValue = arg_95_1

		for iter_95_0 = 1, #self.charators do
			if self.charators[iter_95_0] and self.charators[iter_95_0] ~= 0 then
				self.charators[iter_95_0]:setSpeed(arg_95_1)
			end
		end

		return
	end

	function var_86_0:createCharactor(arg_96_1, arg_96_2, arg_96_3, arg_96_4)
		local var_96_0 = tf(Instantiate(self._tplCharactorDic[arg_96_3]))

		SetParent(var_96_0, (findTF(self._charactorContainer, arg_96_2)))
		setActive(var_96_0, true)

		local var_96_1

		if arg_96_1.type == var_0_8 then
			var_96_1 = var_0_31(arg_96_1, var_96_0, arg_96_2, arg_96_3, arg_96_4)
		elseif arg_96_1.type == var_0_9 then
			var_96_1 = var_0_32(arg_96_1, var_96_0, arg_96_2, arg_96_3, arg_96_4)

			var_96_1:setThrowCallback(self.throwCallback)
		end

		return var_96_1
	end

	function var_86_0:addCharactor(arg_97_1, arg_97_2)
		self.charators[arg_97_2] = arg_97_1

		arg_97_1:apear()

		return
	end

	function var_86_0:getCharactorRandomIndex(arg_98_1)
		local var_98_0 = self:getEmptyIndex()
		local var_98_1 = {}

		for iter_98_0 = 1, #var_98_0 do
			if table.contains(arg_98_1.indexs, var_98_0[iter_98_0]) then
				table.insert(var_98_1, var_98_0[iter_98_0])
			end
		end

		if #var_98_1 then
			return var_98_1[math.random(1, #var_98_1)]
		end

		return nil
	end

	function var_86_0.getCharactorName(arg_99_0, arg_99_1)
		local var_99_1 = math.random(1, #arg_99_1.skin_names)

		return arg_99_1.skin_names[var_99_1], arg_99_1.score[var_99_1]
	end

	function var_86_0:getDataByWeight(arg_100_1)
		if #arg_100_1 == 1 then
			return arg_100_1[1]
		else
			if not self.charactorWeight then
				self.charactorWeight = {}
				self.charactorSubWeight = 0

				for iter_100_0 = 1, #arg_100_1 do
					self.charactorSubWeight = self.charactorSubWeight + arg_100_1[iter_100_0].weight

					table.insert(self.charactorWeight, self.charactorSubWeight)
				end
			end

			local var_100_0 = math.random(0, self.charactorSubWeight)

			for iter_100_1 = #self.charactorWeight - 1, 1, -1 do
				if var_100_0 > self.charactorWeight[iter_100_1] then
					return arg_100_1[iter_100_1 + 1]
				end
			end

			return arg_100_1[1]
		end

		return nil
	end

	function var_86_0:getAbleRandomDatas()
		local var_101_0 = {}
		local var_101_1 = self:getEmptyIndex()

		if #var_101_1 == 0 then
			return var_101_0
		end

		for iter_101_0 = 1, #var_0_23 do
			for iter_101_1, iter_101_2 in ipairs(var_0_23[iter_101_0].indexs) do
				if table.contains(var_101_1, iter_101_2) and not nil then
					table.insert(var_101_0, var_0_23[iter_101_0])
				end
			end
		end

		return var_101_0
	end

	function var_86_0:getEmptyIndex()
		local var_102_0 = {}

		for iter_102_0, iter_102_1 in pairs(self.charators) do
			if iter_102_1 == 0 then
				table.insert(var_102_0, iter_102_0)
			end
		end

		return var_102_0
	end

	function var_86_0:getNextApearTime()
		if not self.apearStepTime then
			self:setNextApearTime()
		end

		return self.apearStepTime
	end

	function var_86_0:setNextApearTime()
		self.apearStepTime = self.apearStepTime or 0
		self.apearStepTime = self.apearStepTime + self:getApearTime()

		return
	end

	function var_86_0:getApearTime()
		local var_105_0 = 1

		for iter_105_0 = #var_0_21, 1, -1 do
			if self.gameStepTime > var_0_21[iter_105_0] then
				var_105_0 = iter_105_0

				break
			end
		end

		return math.random() * (var_0_19[var_105_0][2] - var_0_19[var_105_0][1]) + var_0_19[var_105_0][1]
	end

	function var_86_0:getApearAmount()
		local var_106_0 = 1

		for iter_106_0 = #var_0_21, 1, -1 do
			if self.gameStepTime > var_0_21[iter_106_0] then
				var_106_0 = iter_106_0

				break
			end
		end

		local var_106_1 = var_0_20[var_106_0]
		local var_106_2 = 0
		local var_106_3 = {}

		for iter_106_1 = 1, #var_0_20[var_106_0] do
			var_106_2 = var_106_2 + var_106_1[iter_106_1]

			table.insert(var_106_3, var_106_2)
		end

		local var_106_4 = math.random(0, var_106_2)

		for iter_106_2 = #var_106_3 - 1, 1, -1 do
			if var_106_4 > var_106_3[iter_106_2] then
				return iter_106_2 + 1
			end
		end

		return 1
	end

	var_86_0:Ctor()

	return var_86_0
end

local function var_0_34(arg_107_0, arg_107_1, arg_107_2, arg_107_3)
	local var_107_0 = {
		_player = arg_107_1,
		_charactorCtrl = arg_107_3,
		_snowballCtrl = arg_107_2,
		_sceneTf = arg_107_0
	}

	var_107_0.hitEnemyCallback = nil

	function var_107_0.Ctor(arg_108_0)
		return
	end

	function var_107_0.prepare(arg_109_0)
		return
	end

	function var_107_0:step()
		local var_110_0 = self._snowballCtrl:getSnowballs()

		for iter_110_0 = 1, #var_110_0 do
			local var_110_1 = var_110_0[iter_110_0]:getType()
			local var_110_2 = var_110_0[iter_110_0]:getIndex()
			local var_110_3 = arg_107_3:getCharactorByIndex(var_110_2)

			if var_110_1 == var_0_2 then
				if var_110_3 and var_110_3 ~= 0 then
					local var_110_4, var_110_5 = var_110_3:getColliderBound()

					if var_110_0[iter_110_0]:checkArrived(self._sceneTf:InverseTransformPoint(var_110_4), var_110_5) then
						var_110_3:damage()
						self._snowballCtrl:snowballHit(var_110_0[iter_110_0]:getId())
						arg_107_3:removeCharactor(var_110_2)

						if self.hitEnemyCallback then
							self.hitEnemyCallback(var_110_3:getType(), var_110_3:getName(), var_110_3:getScore(), var_110_3:getPosition())
						end
					end
				end
			elseif var_110_1 == var_0_3 then
				local var_110_6, var_110_7 = self._player:getColliderBound()

				if var_110_0[iter_110_0]:checkArrived(self._sceneTf:InverseTransformPoint(var_110_6), var_110_7) then
					if var_110_3 and var_110_3 ~= 0 and var_110_3:getType() == var_0_9 then
						var_110_3:hit()
					end

					self._player:damage()
					self._snowballCtrl:snowballHit(var_110_0[iter_110_0]:getId())
				end
			end
		end

		return
	end

	var_107_0:Ctor()

	return var_107_0
end

function GameRoomSnowballView:getUIName()
	return "GameRoomSnowballUI"
end

function GameRoomSnowballView:getBGM()
	return "backyard"
end

function GameRoomSnowballView:didEnter()
	self:initData()
	self:initUI()

	return
end

function GameRoomSnowballView:initData()
	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 0.016666666666666666, -1)

	return
end

function GameRoomSnowballView:initUI()
	self.sceneTf = findTF(self._tf, "scene")
	self.clickMask = findTF(self._tf, "clickMask")
	self.player = var_0_28(findTF(self._tf, "scene/luao"))

	function self.player.throwCallback(arg_117_0)
		self:onPlayerThrowSnowball(arg_117_0)

		return
	end

	function self.player.damageCallback()
		self:onPlayerDamage()

		return
	end

	function self.player.gameOverCallback()
		self:onGameOver()

		return
	end

	self.snowballContainer = findTF(self._tf, "scene_front/snowballContainer")
	self.tplSnowball = findTF(self._tf, "tplSnowball")
	self.snowballController = var_0_30(self.snowballContainer, self.tplSnowball)
	self.tplScore = findTF(self._tf, "tplScore")
	self.specialTf = findTF(self._tf, "scene_front/special")
	self.specialAniamtor = GetComponent(self.specialTf, typeof(Animator))

	GetComponent(self.specialTf, typeof(DftAniEvent)):SetTriggerEvent(function()
		self:specialComplete()

		return
	end)

	self.charactorContainer = findTF(self._tf, "scene/charactorContainer")

	local var_116_0 = {}

	for iter_116_0, iter_116_1 in pairs(var_0_10) do
		for iter_116_2, iter_116_3 in ipairs(iter_116_1.skin_names) do
			var_116_0[iter_116_3] = findTF(self._tf, "charactor/" .. iter_116_3)
		end
	end

	self.charactorController = var_0_33(self.charactorContainer, var_116_0)

	function self.charactorController.throwCallback(arg_121_0, arg_121_1)
		function self.charactorController.charactorDamageCallback(arg_122_0, arg_122_1)
			self:onHitEnemy(arg_122_1, arg_122_0)

			return
		end

		self:onEnemyThrowSnowball(arg_121_0, arg_121_1, var_0_18[self:getCurrentDiff()])

		return
	end

	self.colliderController = var_0_34(self.sceneTf, self.player, self.snowballController, self.charactorController)

	function self.colliderController.hitEnemyCallback(arg_123_0, arg_123_1, arg_123_2, arg_123_3)
		self:onHitEnemy(arg_123_2, arg_123_3)

		return
	end

	local var_116_1 = findTF(self._tf, "scene/moveCollider")

	self.playerMoveVecs = {}

	for iter_116_4 = 1, var_0_6 do
		table.insert(self.playerMoveVecs, findTF(var_116_1, iter_116_4).anchoredPosition)
	end

	self.lockTf = findTF(self._tf, "scene_front/lock")

	local var_116_2 = findTF(self._tf, "scene/throwCollider")

	for iter_116_5 = 1, var_0_7 do
		local var_116_3 = findTF(var_116_2, iter_116_5)
		local var_116_4 = iter_116_5

		onButton(self, var_116_3, function()
			local var_124_0 = self.charactorController:getCharactorByIndex(var_116_4)

			if var_124_0 and var_124_0 ~= 0 then
				local var_124_1 = findTF(var_116_3, "target").position

				self:throwSnowballTo(self.sceneTf:InverseTransformPoint(var_124_1.x, var_124_1.y, 0), var_116_4, var_124_0)
			end

			return
		end)
	end

	self.countUI = findTF(self._tf, "pop/CountUI")
	self.countAnimator = GetComponent(findTF(self.countUI, "count"), typeof(Animator))
	self.countDft = GetComponent(findTF(self.countUI, "count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		setActive(self.countUI, false)
		self:gameStart()

		return
	end)

	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	onButton(self, findTF(self.leaveUI, "ad/btnOk"), function()
		self:resumeGame()
		self.player:settlement(var_0_4)
		self:onGameOver()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:resumeGame()

		return
	end, SFX_CANCEL)

	self.pauseUI = findTF(self._tf, "pop/pauseUI")

	onButton(self, findTF(self.pauseUI, "ad/btnOk"), function()
		setActive(self.pauseUI, false)
		self:resumeGame()

		return
	end, SFX_CANCEL)

	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	onButton(self, findTF(self.settlementUI, "ad/btnOver"), function()
		setActive(self.settlementUI, false)
		self:openMenuUI()

		return
	end, SFX_CANCEL)

	self.menuUI = findTF(self._tf, "pop/menuUI")
	self.battleScrollRect = GetComponent(findTF(self.menuUI, "battList"), typeof(ScrollRect))
	self.totalTimes = self:getGameTotalTime()

	scrollTo(self.battleScrollRect, 0, 1 - (self:getGameUsedTimes() - 4 < 0 and 0 or self:getGameUsedTimes() - 4) / (self.totalTimes - 4))
	onButton(self, findTF(self.menuUI, "rightPanelBg/arrowUp"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y + 1 / (self.totalTimes - 4) > 1 or nil) and 1)

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "rightPanelBg/arrowDown"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y - 1 / (self.totalTimes - 4) < 0 or nil) and 0)

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnBack"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = self:getGameRoomData().game_help
		})

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnStart"), function()
		setActive(self.menuUI, false)
		self:openCoinLayer(false)
		self:readyStart()

		return
	end, SFX_CANCEL)

	local var_116_5 = findTF(self.menuUI, "tplBattleItem")

	self.battleItems = {}

	for iter_116_6 = 1, self.totalTimes do
		local var_116_6 = tf(instantiate(var_116_5))

		var_116_6.name = "battleItem_" .. iter_116_6

		setParent(var_116_6, findTF(self.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync("ui/minigameui/snowballgameui_atlas", "tx_" .. iter_116_6, function(arg_136_0)
			setImageSprite(findTF(var_116_6, "state_open/icon"), arg_136_0, true)
			setImageSprite(findTF(var_116_6, "state_clear/icon"), arg_136_0, true)
			setImageSprite(findTF(var_116_6, "state_current/icon"), arg_136_0, true)

			return
		end)
		GetSpriteFromAtlasAsync("ui/minigameui/snowballgameui_atlas", "battleDesc" .. iter_116_6, function(arg_137_0)
			setImageSprite(findTF(var_116_6, "state_open/buttomDesc"), arg_137_0, true)
			setImageSprite(findTF(var_116_6, "state_clear/buttomDesc"), arg_137_0, true)
			setImageSprite(findTF(var_116_6, "state_current/buttomDesc"), arg_137_0, true)
			setImageSprite(findTF(var_116_6, "state_closed/buttomDesc"), arg_137_0, true)

			return
		end)
		setActive(var_116_6, true)
		table.insert(self.battleItems, var_116_6)
	end

	self.gameUI = findTF(self._tf, "ui/gameUI")
	self.lifeProgress = findTF(self.gameUI, "lifeProgress")
	self.textLife = findTF(self.gameUI, "life")
	self.textScore = findTF(self.gameUI, "score")

	onButton(self, findTF(self.gameUI, "btnStop"), function()
		self:stopGame()
		setActive(self.pauseUI, true)

		return
	end)
	onButton(self, findTF(self.gameUI, "btnLeave"), function()
		self:stopGame()
		setActive(self.leaveUI, true)

		return
	end)
	onButton(self, findTF(self.gameUI, "btnMoveUp"), function()
		if self.playerPosIndex > 1 then
			self.playerPosIndex = self.playerPosIndex - 1

			self:movePlayerTo(self.playerPosIndex)
		end

		return
	end)
	onButton(self, findTF(self.gameUI, "btnMoveDown"), function()
		if self.playerPosIndex < #self.playerMoveVecs then
			self.playerPosIndex = self.playerPosIndex + 1

			self:movePlayerTo(self.playerPosIndex)
		end

		return
	end)

	self.btnSkill = findTF(self.gameUI, "btnSkill")

	onButton(self, self.btnSkill, function()
		if self.skilTime == var_0_15 then
			self.skilTime = 0

			self:usePlayerSkill()
		end

		return
	end)
	self:updateMenuUI()
	self:openMenuUI()

	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function GameRoomSnowballView:Update()
	self:AddDebugInput()

	return
end

function GameRoomSnowballView:AddDebugInput()
	if self.gameStop or self.settlementFlag then
		return
	end

	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.W) and self.playerPosIndex and self.playerPosIndex > 1 then
			self.playerPosIndex = self.playerPosIndex - 1

			self:movePlayerTo(self.playerPosIndex)
		end

		if Input.GetKeyDown(KeyCode.S) and self.playerPosIndex and self.playerPosIndex < #self.playerMoveVecs then
			self.playerPosIndex = self.playerPosIndex + 1

			self:movePlayerTo(self.playerPosIndex)
		end
	end

	return
end

function GameRoomSnowballView:getCurrentDiff()
	for iter_145_0 = #var_0_21, 1, -1 do
		if self.gameStepTime > var_0_21[iter_145_0] then
			return iter_145_0
		end
	end

	return
end

function GameRoomSnowballView:updateMenuUI()
	local var_146_0 = self:getGameUsedTimes()
	local var_146_1 = self:getGameTimes()

	for iter_146_0 = 1, #self.battleItems do
		setActive(findTF(self.battleItems[iter_146_0], "state_open"), false)
		setActive(findTF(self.battleItems[iter_146_0], "state_closed"), false)
		setActive(findTF(self.battleItems[iter_146_0], "state_clear"), false)
		setActive(findTF(self.battleItems[iter_146_0], "state_current"), false)

		if iter_146_0 <= var_146_0 then
			setActive(findTF(self.battleItems[iter_146_0], "state_clear"), true)
		elseif iter_146_0 == var_146_0 + 1 and var_146_1 >= 1 then
			setActive(findTF(self.battleItems[iter_146_0], "state_current"), true)
		elseif var_146_0 < iter_146_0 and iter_146_0 <= var_146_0 + var_146_1 then
			setActive(findTF(self.battleItems[iter_146_0], "state_open"), true)
		else
			setActive(findTF(self.battleItems[iter_146_0], "state_closed"), true)
		end
	end

	self.totalTimes = self:getGameTotalTime()

	local var_146_2 = 1 - (self:getGameUsedTimes() - 3 < 0 and 0 or self:getGameUsedTimes() - 3) / (self.totalTimes - 4)

	if var_146_2 > 1 then
		var_146_2 = 1
	end

	scrollTo(self.battleScrollRect, 0, var_146_2)
	setActive(findTF(self.menuUI, "btnStart/tip"), var_146_1 > 0)
	self:CheckGet()

	return
end

function GameRoomSnowballView:CheckGet()
	setActive(findTF(self.menuUI, "got"), false)

	if self:getUltimate() and self:getUltimate() ~= 0 then
		setActive(findTF(self.menuUI, "got"), true)
	end

	if self:getUltimate() == 0 then
		if self:getGameTotalTime() > self:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(self.menuUI, "got"), true)
	end

	return
end

function GameRoomSnowballView:openMenuUI()
	setActive(findTF(self._tf, "scene_front"), false)
	setActive(findTF(self._tf, "scene_background"), false)
	setActive(findTF(self._tf, "scene"), false)
	setActive(self.gameUI, false)
	setActive(self.menuUI, true)
	self:openCoinLayer(true)
	self:updateMenuUI()

	return
end

function GameRoomSnowballView:clearUI()
	setActive(self.sceneTf, false)
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)
	setActive(self.menuUI, false)
	setActive(self.gameUI, false)

	return
end

function GameRoomSnowballView:OnSendMiniGameOPDone(arg_150_1)
	if self.sendSuccessFlag then
		local var_150_0 = getProxy(MiniGameProxy):GetMiniGameData(MiniGameDataCreator.NewYearShrineGameID):GetRuntimeData("count") or 0

		pg.m02:sendNotification(GAME.MODIFY_MINI_GAME_DATA, {
			id = MiniGameDataCreator.NewYearShrineGameID,
			map = {
				count = var_150_0 + 2
			}
		})

		self.sendSuccessFlag = false
	end

	return
end

function GameRoomSnowballView:readyStart()
	setActive(self.countUI, true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_24)

	return
end

function GameRoomSnowballView:gameStart()
	setActive(findTF(self._tf, "scene_front"), true)
	setActive(findTF(self._tf, "scene_background"), true)
	setActive(findTF(self._tf, "scene"), true)
	setActive(self.gameUI, true)
	setActive(self.lockTf, false)

	self.gameStartFlag = true
	self.scoreNum = 0
	self.skilTime = 0
	self.playerPosIndex = 2

	self:movePlayerTo(self.playerPosIndex)

	self.specialTime = 0
	self.gameStepTime = 0

	self.player:prepare()
	self.snowballController:prepare()
	self.charactorController:prepare()
	self.colliderController:prepare()
	self:updateGameUI()
	self:timerStart()

	return
end

function GameRoomSnowballView:onPlayerDamage()
	self:updateGameUI()

	return
end

function GameRoomSnowballView:getGameTimes()
	return self:GetMGHubData().count
end

function GameRoomSnowballView:getGameUsedTimes()
	return self:GetMGHubData().usedtime
end

function GameRoomSnowballView:getUltimate()
	return self:GetMGHubData().ultimate
end

function GameRoomSnowballView:getGameTotalTime()
	return (self:GetMGHubData():getConfig("reward_need"))
end

function GameRoomSnowballView:changeSpeed(arg_158_1)
	self.player:setSpeed(arg_158_1)

	self.specialAniamtor.speed = arg_158_1

	self.charactorController:setSpeed(arg_158_1)

	return
end

function GameRoomSnowballView:onTimer()
	self.player:step()
	self.snowballController:step()
	self.charactorController:step()
	self.colliderController:step()
	self:gameStep()

	return
end

function GameRoomSnowballView:gameStep()
	self.gameStepTime = self.gameStepTime + Time.deltaTime
	self.skilTime = self.skilTime + Time.deltaTime

	if self.skilTime > var_0_15 then
		self.skilTime = var_0_15
	end

	self.skillProgress = self.skillProgress or GetComponent(findTF(self.btnSkill, "progress"), typeof(Image))
	self.skillProgress.fillAmount = self.skilTime / var_0_15

	if self.skilTime == var_0_15 then
		if not isActive(findTF(self.gameUI, "xuehezhan_zhiyuantiao")) then
			setActive(findTF(self.gameUI, "xuehezhan_zhiyuantiao"), true)
		end
	elseif isActive(findTF(self.gameUI, "xuehezhan_zhiyuantiao")) then
		setActive(findTF(self.gameUI, "xuehezhan_zhiyuantiao"), false)
	end

	if self.gameStepTime < self.specialTime then
		self.specialIndex = self.specialIndex or 0

		if self.specialIndex > 20 then
			self.specialIndex = 0

			self.charactorController:damageEnemy()
		end

		self.specialIndex = self.specialIndex + 1
	end

	return
end

function GameRoomSnowballView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function GameRoomSnowballView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function GameRoomSnowballView:movePlayerTo(arg_163_1)
	self.player:move(self.playerMoveVecs[arg_163_1])

	return
end

function GameRoomSnowballView:updateGameUI()
	setSlider(self.lifeProgress, 0, 1, self.player:getLife() / var_0_12)
	setText(self.textLife, self.player:getLife() .. "/" .. var_0_12)
	setText(self.textScore, self.scoreNum)

	return
end

function GameRoomSnowballView:throwSnowballTo(arg_165_1, arg_165_2, arg_165_3)
	self.throwTarget = arg_165_1
	self.targetIndex = arg_165_2

	if self.player:throw() and self.targetCharactor ~= arg_165_3 then
		setActive(self.lockTf, false)

		self.lockTf.anchoredPosition = arg_165_1

		setActive(self.lockTf, true)

		self.targetCharactor = arg_165_3
	end

	return
end

function GameRoomSnowballView:onPlayerThrowSnowball(arg_166_1)
	if self.throwTarget then
		self.snowballController:createSnowball(self.sceneTf:InverseTransformPoint(arg_166_1.x, arg_166_1.y, 0), self.throwTarget, var_0_14, var_0_2, self.targetIndex)

		self.throwTarget = nil
		self.targetIndex = nil
	end

	return
end

function GameRoomSnowballView:onEnemyThrowSnowball(arg_167_1, arg_167_2, arg_167_3)
	local var_167_0 = self.player:getTargetPosition()

	self.snowballController:createSnowball(self.sceneTf:InverseTransformPoint(arg_167_1.x, arg_167_1.y, 0), self.sceneTf:InverseTransformPoint(var_167_0.x, var_167_0.y, 0), arg_167_3, var_0_3, arg_167_2)

	return
end

function GameRoomSnowballView:usePlayerSkill()
	Time.timeScale = 0.05

	LeanTween.delayedCall(go(self.specialTf), 3, System.Action(function()
		if Time.timeScale ~= 1 then
			Time.timeScale = 1
		end

		return
	end))
	self.player:skill()
	self.snowballController:clearEnemySnowball()
	setActive(self.specialTf, true)

	self.specialEffect = self.specialEffect or findTF(self._tf, "xuehezhan_xueqiuhongzha")

	setActive(self.specialEffect, false)
	setActive(self.specialEffect, true)

	return
end

function GameRoomSnowballView:specialComplete()
	Time.timeScale = 1

	setActive(self.specialTf, false)

	self.specialTime = self.gameStepTime + var_0_16
	self.specialIndex = 0

	return
end

function GameRoomSnowballView:dropSpeedUp()
	return
end

function GameRoomSnowballView:onHitEnemy(arg_172_1, arg_172_2)
	self:addScore(arg_172_1, arg_172_2)
	self:updateGameUI()

	return
end

function GameRoomSnowballView:addScore(arg_173_1, arg_173_2)
	self.scoreNum = self.scoreNum + arg_173_1

	if self.scoreNum < 0 then
		self.scoreNum = 0
	end

	local var_173_0 = tf(instantiate(self.tplScore))
	local var_173_1 = findTF(var_173_0, "ad")
	local var_173_2 = GetComponent(var_173_1, typeof(DftAniEvent))

	var_173_0.anchoredPosition = self.snowballContainer:InverseTransformPoint(arg_173_2)

	if arg_173_1 > 0 then
		setActive(findTF(var_173_1, "add"), true)
		setText(findTF(var_173_1, "add"), "+" .. arg_173_1)
	else
		setActive(findTF(var_173_1, "sub"), true)
		setText(findTF(var_173_1, "sub"), arg_173_1)
	end

	setParent(var_173_0, self.snowballContainer)
	var_173_2:SetEndEvent(function()
		setActive(var_173_0, false)
		Destroy(var_173_0)

		return
	end)
	setActive(var_173_0, true)

	return
end

function GameRoomSnowballView:onGameOver()
	self:timerStop()

	self.settlementFlag = true

	setActive(self.clickMask, true)
	LeanTween.delayedCall(go(self._tf), 2, System.Action(function()
		self.settlementFlag = false
		self.gameStartFlag = false

		setActive(self.clickMask, false)
		setActive(findTF(self.gameUI, "xuehezhan_zhiyuantiao"), false)
		setActive(self.specialTf, false)
		self:showSettlement()

		return
	end))

	return
end

function GameRoomSnowballView:showSettlement()
	setActive(self.settlementUI, true)
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_177_0 = getProxy(GameRoomProxy):getRoomScore(self:getGameRoomData().id)

	if var_177_0 <= self.scoreNum then
		var_177_0 = self.scoreNum

		self:StoreDataToServer({
			self.scoreNum
		})
	end

	setText(findTF(self.settlementUI, "ad/highText"), var_177_0)
	setText(findTF(self.settlementUI, "ad/currentText"), self.scoreNum)

	self.sendSuccessFlag = true

	self:SendSuccess(self.scoreNum or 0)

	return
end

function GameRoomSnowballView:resumeGame()
	self.gameStop = false

	setActive(self.leaveUI, false)
	self:changeSpeed(1)
	self:timerStart()

	return
end

function GameRoomSnowballView:stopGame()
	self.gameStop = true

	self:timerStop()
	self:changeSpeed(0)

	return
end

function GameRoomSnowballView:onBackPressed()
	if not self.gameStartFlag then
		self:emit(GameRoomSnowballView.ON_BACK_PRESSED)
	else
		if self.settlementFlag then
			return
		end

		if isActive(self.pauseUI) then
			setActive(self.pauseUI, false)
		end

		self:stopGame()
		setActive(self.leaveUI, true)
	end

	return
end

function GameRoomSnowballView:willExit()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	if not self._tf then
		print()
	end

	if self._tf and LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	if self.specialTf and LeanTween.isTweening(go(self.specialTf)) then
		LeanTween.cancel(go(self.specialTf))
	end

	if self.specialEffect and LeanTween.isTweening(go(self.specialEffect)) then
		LeanTween.cancel(go(self.specialEffect))
	end

	if self.timer and self.timer.running then
		self.timer:Stop()
	end

	Time.timeScale = 1
	self.timer = nil

	return
end

return GameRoomSnowballView
