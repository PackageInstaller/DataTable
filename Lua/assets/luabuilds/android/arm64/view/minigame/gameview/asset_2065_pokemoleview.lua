local PokeMoleView = class("PokeMoleView", import("..BaseMiniGameView"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_6 = "backyard"
local var_0_7 = "event:/ui/jida"
local var_0_8 = "event:/ui/quanji"
local var_0_9 = "event:/ui/baozhaxiaoshi"
local var_0_12 = "event:/ui/ddldaoshu2"
local var_0_13 = 0.5
local var_0_14 = 90
local var_0_15 = {
	{
		speed = 60,
		life = 1,
		enable_time = 1,
		type = 1,
		score = 100,
		damage_time = 1
	},
	{
		speed = 65,
		life = 1,
		enable_time = 1,
		type = 2,
		score = 150,
		damage_time = 1
	},
	{
		speed = 50,
		life = 2,
		enable_time = 2,
		type = 3,
		score = 200,
		damage_time = 1
	},
	{
		speed = 55,
		life = 1,
		enable_time = 1,
		type = 4,
		score = 150,
		damage_time = 1
	}
}
local var_0_16 = {
	level_up_time = {
		0,
		20,
		40,
		60,
		80
	},
	enemy_apear_time = {
		2.5,
		2,
		1.5,
		1.5,
		1
	},
	enemy_max = {
		5,
		6,
		7,
		8,
		8
	},
	enemy_amounts = {
		{
			70,
			30
		},
		{
			70,
			30
		},
		{
			70,
			40
		},
		{
			70,
			40,
			20
		},
		{
			70,
			50,
			20
		}
	}
}
local var_0_17 = 3
local var_0_18 = {
	1,
	2,
	3
}
local var_0_19 = 10
local var_0_20 = 10

local function var_0_21(arg_1_0, arg_1_1)
	local var_1_0 = {
		ctor = function(self)
			self._tf = arg_1_0
			self._callback = arg_1_1
			self._animator = GetComponent(self._tf, typeof(Animator))
			self._attakeCount = 0
			self._attakeCd = 0
			self._specialTime = 0
			self._specialCount = 0
			self.atkCollider = GetComponent(findTF(self._tf, "atkCollider"), typeof(BoxCollider2D))
			self.specialCollider = GetComponent(findTF(self._tf, "specialCollider"), typeof(BoxCollider2D))

			local var_2_0 = GetComponent(self._tf, typeof(DftAniEvent))

			var_2_0:SetStartEvent(function()
				return
			end)
			var_2_0:SetTriggerEvent(function()
				if self._callback then
					self._callback((self:getColliderData()))

					if self:getSpecialState() then
						pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_8)
					end
				end

				return
			end)
			var_2_0:SetEndEvent(function()
				return
			end)

			return
		end,
		getColliderData = function(self)
			local var_6_0

			if self:getSpecialState() then
				var_6_0 = self.specialCollider
			end

			local var_6_2
			local var_6_1

			do
				var_6_0 = self.atkCollider
				var_6_1 = {
					pos = var_6_0.bounds.min
				}
				var_6_2 = {}
			end

			var_6_2.width = var_6_0.bounds.max.x - var_6_0.bounds.min.x
			var_6_2.height = var_6_0.bounds.max.y - var_6_0.bounds.min.y
			var_6_1.boundsLength = var_6_2
			var_6_1.damage = self:getDamage()

			return var_6_1
		end,
		atk = function(self)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_7)
			self._animator:SetTrigger("atk")

			self._attakeCd = var_0_13

			return
		end,
		specialAtk = function(self)
			self._animator:SetTrigger("special")

			self._attakeCd = var_0_13

			return
		end,
		getDamage = function(self)
			if self._specialTime > 0 then
				return 3
			end

			return 1
		end,
		reset = function(self)
			self._animator:SetTrigger("reset")

			return
		end,
		setActive = function(self, arg_11_1)
			SetActive(self._tf, arg_11_1)

			return
		end,
		setParent = function(self, arg_12_1, arg_12_2)
			SetParent(self._tf, arg_12_1)
			self:setActive(arg_12_2)

			return
		end,
		attakeAble = function(self)
			return self._attakeCd == 0
		end,
		moveTo = function(self, arg_14_1)
			arg_14_1.y = arg_14_1.y + 100
			self._tf.anchoredPosition = arg_14_1

			return
		end,
		attakeCount = function(self, arg_15_1)
			self._attakeCount = self._attakeCount + arg_15_1 * 4

			if self._attakeCount > 8 then
				self._attakeCount = 8
			end

			if self._attakeCount > 0 then
				self._animator.speed = 0
			end

			return
		end,
		addSpecialCount = function(self, arg_16_1)
			if self._specialTime == 0 then
				self._specialCount = self._specialCount + arg_16_1

				if self._specialCount >= var_0_20 then
					self._specialCount = var_0_20
				end
			end

			return
		end,
		useSpecial = function(self)
			if self._specialTime and self._specialCount >= var_0_20 then
				self._specialCount = 0
				self._specialTime = var_0_19

				return true
			end

			return false
		end,
		SetSiblingIndex = function(self, arg_18_1)
			self._tf:SetSiblingIndex(arg_18_1)

			return
		end,
		getSpecialState = function(self)
			return self._specialTime > 0
		end,
		step = function(self)
			if self._attakeCount > 0 then
				self._attakeCount = self._attakeCount - 1

				if self._attakeCount == 0 then
					self._animator.speed = 1
				end
			end

			if self._attakeCd > 0 then
				self._attakeCd = self._attakeCd - Time.deltaTime
				self._attakeCd = self._attakeCd < 0 and 0 or self._attakeCd
			end

			if self._specialTime > 0 then
				self._specialTime = self._specialTime - Time.deltaTime
				self._specialTime = self._specialTime < 0 and 0 or self._specialTime
			end

			return
		end,
		inSpecial = function(self)
			return self._specialTime > 0
		end,
		getSpecialData = function(self)
			return self._specialTime, self._specialCount
		end,
		clear = function(self)
			self._specialTime = 0
			self._specialCount = 0

			self:reset()

			return
		end,
		useAtk = function(self)
			if self:inSpecial() then
				self:specialAtk()
			else
				self:atk()
			end

			return
		end
	}

	var_1_0:ctor()

	return var_1_0
end

local function var_0_22(arg_25_0, arg_25_1)
	local var_25_0 = {
		ctor = function(self)
			self.playerTpl = arg_25_0
			self.sceneTf = arg_25_1
			self._playerPos = findTF(self.sceneTf, "playerPos")
			self.uiCam = GameObject.Find("UICamera"):GetComponent("Camera")
			self.dragDelegate = GetOrAddComponent(findTF(self.sceneTf, "clickBounds"), "EventTriggerListener")
			self.dragDelegate.enabled = true

			self.dragDelegate:AddPointDownFunc(function(arg_27_0, arg_27_1)
				if self.player and self.player:attakeAble() then
					self.player:moveTo((self._playerPos:InverseTransformPoint((self.uiCam:ScreenToWorldPoint(arg_27_1.pressPosition)))))
					self.player:reset()
					self.player:useAtk()
				end

				return
			end)

			return
		end,
		createPlayer = function(self)
			if self.player == nil then
				self.player = var_0_21(tf(Instantiate(self.playerTpl)), function(arg_29_0)
					self:playerActHand(arg_29_0)

					return
				end)

				self.player:setParent(self._playerPos, true)
			end

			return
		end,
		playerActHand = function(self, arg_30_1)
			if self.playerHandle then
				self.playerHandle(arg_30_1)
			end

			return
		end,
		setPlayerHandle = function(arg_31_0, arg_31_1)
			arg_31_0.playerHandle = arg_31_1

			return
		end,
		step = function(self)
			if self.player then
				self.player:step()
			end

			return
		end,
		getSpecialData = function(self)
			if self.player then
				return self.player:getSpecialData()
			end

			return nil, nil
		end,
		useSpecial = function(self)
			if self.player then
				return self.player:useSpecial()
			end

			return
		end,
		attakeCount = function(self, arg_35_1)
			if self.player then
				self.player:attakeCount(arg_35_1)
			end

			return
		end,
		addSpecialCount = function(self, arg_36_1)
			if self.player then
				self.player:addSpecialCount(arg_36_1)
			end

			return
		end,
		clear = function(self)
			if self.player then
				self.player:clear()
			end

			return
		end
	}

	var_25_0:ctor()

	return var_25_0
end

local function var_0_23(arg_38_0, arg_38_1)
	local var_38_0 = {
		ctor = function(self)
			self._tf = arg_38_0
			self._data = arg_38_1
			self._life = 0
			self._enable = false
			self._attakeAble = false
			self._animator = GetComponent(self._tf, typeof(Animator))
			self._boxCollider = GetComponent(self._tf, "BoxCollider2D")

			local var_39_0 = GetComponent(self._tf, typeof(DftAniEvent))

			var_39_0:SetStartEvent(function()
				if self._callback then
					self._callback(var_0_3)
				end

				return
			end)
			var_39_0:SetTriggerEvent(function()
				if self._callback then
					self._callback(var_0_2)
				end

				return
			end)
			var_39_0:SetEndEvent(function()
				self._enable = false

				if self._callback then
					self._callback(var_0_1)
				end

				return
			end)

			return
		end,
		setHandle = function(arg_43_0, arg_43_1)
			arg_43_0._callback = arg_43_1

			return
		end,
		getSpeed = function(self)
			return self._data.speed
		end,
		step = function(self)
			if self._enableTime > 0 then
				self._enableTime = self._enableTime - Time.deltaTime

				if self._enableTime < 0 then
					self._enable = true
					self._enableTime = 0
				end
			end

			return
		end,
		apear = function(self)
			self._animator:SetTrigger("pop")

			self._enableTime = math.random() * self._data.enable_time + 0.5
			self._life = self._data.life
			self._attakeAble = true

			return
		end,
		stop = function(self)
			self._animator:SetBool("stop", true)

			return
		end,
		damage = function(self, arg_48_1)
			self._life = self._life - arg_48_1

			if self._life <= 0 then
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_9)
				self:dead()
			else
				self._animator:SetTrigger("damage")

				self._enable = false
				self._enableTime = self._data.damage_time
			end

			return
		end,
		dead = function(self)
			self._animator:SetTrigger("dead")

			self._enable = false
			self._enableTime = 0
			self._attakeAble = false

			return
		end,
		steal = function(self)
			self._animator:SetTrigger("steal")

			self._enable = false
			self._attakeAble = false

			return
		end,
		move = function(self, arg_51_1, arg_51_2)
			self._tf.anchoredPosition.x = self._tf.anchoredPosition.x + arg_51_1
			self._tf.anchoredPosition.y = self._tf.anchoredPosition.y + arg_51_2
			self._tf.anchoredPosition = self._tf.anchoredPosition
			self._tf.localScale.x = Mathf.Abs(self._tf.localScale.x) * -1 * Mathf.Sign(arg_51_1)
			self._tf.localScale = self._tf.localScale

			return
		end,
		moveTo = function(self, arg_52_1)
			self._tf.anchoredPosition = arg_52_1
			self._tf.localScale.x = Mathf.Abs(self._tf.localScale.x) * Mathf.Sign(self._tf.localPosition.x)
			self._tf.localScale = self._tf.localScale

			return
		end,
		setParent = function(self, arg_53_1, arg_53_2)
			SetParent(self._tf, arg_53_1)
			self:setActive(arg_53_2)

			return
		end,
		setActive = function(self, arg_54_1)
			SetActive(self._tf, arg_54_1)

			return
		end,
		SetSiblingIndex = function(self, arg_55_1)
			self._tf:SetSiblingIndex(arg_55_1)

			return
		end,
		getPosition = function(self)
			return self._tf.anchoredPosition
		end,
		getType = function(self)
			return self._data.type
		end,
		getMoveAble = function(self)
			return isActive(self._tf) and self._enable
		end,
		getAttakeAble = function(self)
			return isActive(self._tf) and self._attakeAble
		end,
		getBounds = function(self)
			return self._boxCollider.bounds
		end,
		getLife = function(self)
			return self._life
		end,
		getScore = function(self)
			return self._data.score
		end,
		getBoundLength = function(self)
			if self.boundsData == nil then
				self.boundsData = {
					width = self._boxCollider.bounds.max.x - self._boxCollider.bounds.min.x,
					height = self._boxCollider.bounds.max.y - self._boxCollider.bounds.min.y
				}
			end

			return self.boundsData
		end
	}

	var_38_0:ctor()

	return var_38_0
end

local function var_0_24(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	local var_64_0 = {
		ctor = function(self)
			self.enemysTpl = arg_64_0
			self.sceneTf = arg_64_1
			self.enemyPos = findTF(self.sceneTf, "enemyPos")
			self.createPos = findTF(self.sceneTf, "createPos")
			self.countsWeight = {}

			for iter_65_0 = 1, #var_0_16.enemy_amounts do
				local var_65_0 = {}
				local var_65_1 = 0

				for iter_65_1 = 1, #var_0_16.enemy_amounts[iter_65_0] do
					var_65_1 = var_65_1 + var_0_16.enemy_amounts[iter_65_0][iter_65_1]

					table.insert(var_65_0, var_65_1)
				end

				table.insert(self.countsWeight, var_65_0)
			end

			self.callback = arg_64_2
			self.callback2 = arg_64_3
			self.enemys = {}
			self.enemysPool = {}
			self.apearTime = 0
			self.stepTime = 0
			self.level = 1
			self.cakeLife = var_0_17
			self.cakeTf = findTF(self.sceneTf, "enemyPos/cake")
			self.cakeAniamtor = GetComponent(findTF(self.cakeTf, "image"), typeof(Animator))

			self.cakeAniamtor:SetInteger("life", self:getCakeLifeIndex())

			self.cakeBox = GetComponent(self.cakeTf, "BoxCollider2D")
			self.cakeBoundsLength = {
				width = self.cakeBox.bounds.max.x - self.cakeBox.bounds.min.x,
				height = self.cakeBox.bounds.max.y - self.cakeBox.bounds.min.y
			}
			self.gameScore = 0
			self.createBounds = {}

			for iter_65_2 = 0, self.createPos.childCount - 1 do
				table.insert(self.createBounds, self.createPos:GetChild(iter_65_2))
			end

			return
		end,
		step = function(self)
			for iter_66_0 = #var_0_16.level_up_time, 1, -1 do
				if iter_66_0 > self.level and self.stepTime > var_0_16.level_up_time[iter_66_0] and self.level ~= iter_66_0 then
					self.level = iter_66_0

					print("level up :" .. self.level)

					break
				end
			end

			if self.apearTime == 0 then
				for iter_66_1 = 1, self:getCreateCounts() do
					if #self.enemys < var_0_16.enemy_max[self.level] then
						local var_66_0 = var_0_15[math.random(1, #var_0_15)]
						local var_66_1 = self:getEnemyFromPool(var_66_0.type) or self:createEnemy(var_66_0)

						table.insert(self.enemys, var_66_1)
						var_66_1:setActive(true)
						var_66_1:moveTo(self:getRandApearPosition())
						var_66_1:apear()
					end
				end

				self.apearTime = var_0_16.enemy_apear_time[self.level]
			end

			table.sort(self.enemys, function(arg_67_0, arg_67_1)
				return arg_67_0:getPosition().y > arg_67_1:getPosition().y
			end)

			local var_66_2 = 0

			for iter_66_2 = #self.enemys, 1, -1 do
				if self.cakeTf.localPosition.y <= self.enemys[iter_66_2]:getPosition().y then
					var_66_2 = var_66_2 + 1
				end

				self.enemys[iter_66_2]:SetSiblingIndex(iter_66_2)
				self.enemys[iter_66_2]:step()

				if self.enemys[iter_66_2]:getMoveAble() then
					local var_66_3 = self.enemys[iter_66_2]:getPosition()

					if self:checkEnemySteal(self.enemys[iter_66_2]) then
						self.enemys[iter_66_2]:steal()
					else
						local var_66_4 = Mathf.Atan2(Mathf.Abs(var_66_3.y), Mathf.Abs(var_66_3.x))

						self.enemys[iter_66_2]:move(self.enemys[iter_66_2]:getSpeed() * Mathf.Cos(var_66_4) * -Mathf.Sign(var_66_3.x) * Time.deltaTime, self.enemys[iter_66_2]:getSpeed() * Mathf.Sin(var_66_4) * -Mathf.Sign(var_66_3.y) * Time.deltaTime)
					end
				end
			end

			self.cakeTf:SetSiblingIndex(var_66_2)

			self.apearTime = self.apearTime - Time.deltaTime

			if self.apearTime < 0 then
				self.apearTime = 0
			end

			self.stepTime = self.stepTime + Time.deltaTime

			self.cakeAniamtor:SetInteger("life", self:getCakeLifeIndex())

			return
		end,
		getCreateCounts = function(self)
			local var_68_0 = math.random(1, self.countsWeight[self.level][#self.countsWeight[self.level]])

			for iter_68_0 = 1, #self.countsWeight[self.level] do
				if var_68_0 <= self.countsWeight[self.level][iter_68_0] then
					return iter_68_0
				end
			end

			return 1
		end,
		checkEnemySteal = function(self, arg_69_1)
			return self:checkRectCollider(arg_69_1:getBounds().min, self.cakeBox.bounds.min, arg_69_1:getBoundLength(), self.cakeBoundsLength)
		end,
		checkRectCollider = function(arg_70_0, arg_70_1, arg_70_2, arg_70_3, arg_70_4)
			if arg_70_2.x <= arg_70_1.x and arg_70_1.x >= arg_70_2.x + arg_70_4.width then
				return false
			elseif arg_70_1.x <= arg_70_2.x and arg_70_2.x >= arg_70_1.x + arg_70_3.width then
				return false
			elseif arg_70_2.y <= arg_70_1.y and arg_70_1.y >= arg_70_2.y + arg_70_4.height then
				return false
			elseif arg_70_1.y <= arg_70_2.y and arg_70_2.y >= arg_70_1.y + arg_70_3.height then
				return false
			else
				return true
			end

			return
		end,
		createEnemy = function(self, arg_71_1)
			local var_71_0 = var_0_23(tf(Instantiate(self.enemysTpl[arg_71_1.type])), arg_71_1)

			var_71_0:setHandle(function(arg_72_0)
				self:enemyEventHandle(arg_72_0, var_71_0)

				return
			end)
			var_71_0:setParent(self.enemyPos, true)

			return var_71_0
		end,
		getEnemyFromPool = function(self, arg_73_1)
			for iter_73_0 = 1, #self.enemysPool do
				if self.enemysPool[iter_73_0]:getType() == arg_73_1 then
					table.remove(self.enemysPool, iter_73_0)

					return self.enemysPool[iter_73_0]
				end
			end

			return nil
		end,
		removeEnemy = function(self, arg_74_1)
			for iter_74_0 = #self.enemys, 1, -1 do
				if self.enemys[iter_74_0] == arg_74_1 then
					table.remove(self.enemys, iter_74_0)
				end
			end

			arg_74_1:setActive(false)
			table.insert(self.enemysPool, arg_74_1)

			return
		end,
		getRandApearPosition = function(self)
			local var_75_0 = self.createBounds[math.random(1, #self.createBounds)]
			local var_75_1 = var_75_0:TransformPoint(math.random() * (var_75_0.sizeDelta.x / 2) * (math.random() < 0.5 and 1 or -1), math.random() * (var_75_0.sizeDelta.y / 2) * (math.random() < 0.5 and 1 or -1), 0)

			return (self.enemyPos:InverseTransformPoint(var_75_1.x, var_75_1.y, var_75_1.z))
		end,
		enemyEventHandle = function(self, arg_76_1, arg_76_2)
			if arg_76_1 == var_0_2 then
				self.cakeLife = self.cakeLife - 1

				if self.callback2 then
					self.callback2()
				end

				if self.cakeLife <= 0 and self.callback then
					self.callback()
				end

				self.cakeAniamtor:SetInteger("life", self:getCakeLifeIndex())
			elseif arg_76_1 == var_0_1 then
				self.gameScore = self.gameScore + arg_76_2:getScore()

				self:removeEnemy(arg_76_2)
			else
				self:removeEnemy(arg_76_2)
			end

			return
		end,
		playerActAttake = function(self, arg_77_1)
			local var_77_0 = 0
			local var_77_1 = 0

			for iter_77_0 = 1, #self.enemys do
				if self.enemys[iter_77_0]:getAttakeAble() and self:checkRectCollider(self.enemys[iter_77_0]:getBounds().min, arg_77_1.pos, self.enemys[iter_77_0]:getBoundLength(), arg_77_1.boundsLength) then
					self.enemys[iter_77_0]:damage(arg_77_1.damage)

					var_77_0 = var_77_0 + 1

					if self.enemys[iter_77_0]:getLife() == 0 then
						var_77_1 = var_77_1 + 1
					end
				end
			end

			return var_77_0, var_77_1
		end,
		clear = function(self)
			self.stepTime = 0

			for iter_78_0 = #self.enemys, 1, -1 do
				local var_78_0 = table.remove(self.enemys, iter_78_0)

				var_78_0:setActive(false)
				table.insert(self.enemysPool, var_78_0)
			end

			self.cakeLife = var_0_17
			self.gameScore = 0
			self.level = 1

			return
		end,
		getCakeLife = function(self)
			return self.cakeLife
		end,
		getCakeLifeIndex = function(self)
			for iter_80_0 = #var_0_18, 1, -1 do
				if self.cakeLife >= var_0_18[iter_80_0] then
					return iter_80_0
				end
			end

			return 0
		end,
		getScore = function(self)
			return self.gameScore
		end
	}

	var_64_0:ctor()

	return var_64_0
end

local function var_0_25(arg_82_0, arg_82_1, arg_82_2)
	local var_82_0 = {
		ctor = function(self)
			self.playerController = arg_82_0
			self.enemyController = arg_82_1
			self.callback = arg_82_2

			self.playerController:setPlayerHandle(function(arg_84_0)
				local var_84_0, var_84_1 = self.enemyController:playerActAttake(arg_84_0)

				if var_84_0 > 0 then
					self.playerController:attakeCount(var_84_0)
				end

				if var_84_1 > 0 then
					self.playerController:addSpecialCount(var_84_1)

					if self.callback then
						self.callback()
					end
				end

				return
			end)

			return
		end
	}

	var_82_0:ctor()

	return var_82_0
end

local var_0_26 = "role type loop"
local var_0_27 = "role type normal"

local function var_0_28(arg_85_0, arg_85_1)
	local var_85_0 = {
		ctor = function(self)
			self.playerController = arg_85_1
			self.roleTfs = arg_85_0
			self.roleDatas = {}

			for iter_86_0 = 1, #self.roleTfs do
				local var_86_0 = {
					animator = GetComponent(self.roleTfs[iter_86_0], typeof(Animator))
				}

				if iter_86_0 == 2 or iter_86_0 == 3 then
					var_86_0.type = var_0_26
					var_86_0.loop_time = {
						3,
						3
					}
					var_86_0.time = 0
				else
					var_86_0.type = var_0_27
				end

				table.insert(self.roleDatas, var_86_0)
			end

			return
		end,
		step = function(self)
			local var_87_0 = self.playerController:getSpecialData()

			for iter_87_0 = 1, #self.roleDatas do
				if self.roleDatas[iter_87_0].type == var_0_26 then
					if self.roleDatas[iter_87_0].time == 0 then
						self.roleDatas[iter_87_0].animator:SetTrigger("loop")

						self.roleDatas[iter_87_0].time = math.random() * self.roleDatas[iter_87_0].loop_time[1] + self.roleDatas[iter_87_0].loop_time[2]
					else
						self.roleDatas[iter_87_0].time = self.roleDatas[iter_87_0].time - Time.deltaTime

						if self.roleDatas[iter_87_0].time < 0 then
							self.roleDatas[iter_87_0].time = 0
						end
					end
				end

				if self.roleDatas[iter_87_0].special and var_87_0 == 0 then
					self.roleDatas[iter_87_0].animator:SetTrigger("reset")

					self.roleDatas[iter_87_0].special = false
				end
			end

			return
		end,
		special = function(self)
			for iter_88_0 = 1, #self.roleDatas do
				self.roleDatas[iter_88_0].animator:SetTrigger("special")

				self.roleDatas[iter_88_0].special = true
			end

			return
		end,
		fail = function(self)
			for iter_89_0 = 1, #self.roleDatas do
				self.roleDatas[iter_89_0].animator:SetTrigger("fail")
			end

			return
		end,
		reset = function(self)
			for iter_90_0 = 1, #self.roleDatas do
				self.roleDatas[iter_90_0].animator:SetTrigger("reset")
			end

			return
		end
	}

	var_85_0:ctor()

	return var_85_0
end

function PokeMoleView:getUIName()
	return "PokeMoleGameUI"
end

function PokeMoleView:getBGM()
	return var_0_6
end

function PokeMoleView:didEnter()
	self:initData()
	self:initUI()

	return
end

function PokeMoleView:initData()
	self.settlementFlag = false
	self.gameStartFlag = false
	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / (Application.targetFrameRate or 60), -1, true)

	return
end

function PokeMoleView:initUI()
	self.clickMask = findTF(self._tf, "clickMask")
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

	onButton(self, findTF(self.menuUI, "btnBack"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.securitycake_help.tip
		})

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnStart"), function()
		setActive(self.menuUI, false)
		self:readyStart()

		return
	end, SFX_CANCEL)

	self.gameUI = findTF(self._tf, "ui/gameUI")
	self.textTime = findTF(self.gameUI, "time")
	self.textScore = findTF(self.gameUI, "score")
	self.hearts = {}

	for iter_96_0 = 1, 3 do
		table.insert(self.hearts, (findTF(self.gameUI, "heart" .. iter_96_0 .. "/img")))
	end

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

	self.specialSlider = GetComponent(findTF(self.gameUI, "btnSpecial/Slider"), typeof(Slider))
	self.touchSlider = findTF(self.specialSlider, "touch")
	self.specialEffect = findTF(self.gameUI, "btnSpecial/baoweidangao_extiao")
	self.arrowTf = findTF(self.gameUI, "btnSpecial/arrow")

	onButton(self, findTF(self.gameUI, "btnSpecial"), function()
		if self.playerController and self.playerController:useSpecial() then
			self.bgRoleController:special()
		end

		return
	end)

	self.sceneTf = findTF(self._tf, "scene")
	self.playerTpl = findTF(self._tf, "playerTpl")
	self.playerController = var_0_22(self.playerTpl, self.sceneTf)
	self.enemyTpls = {}

	for iter_96_1 = 1, 4 do
		table.insert(self.enemyTpls, findTF(self._tf, "enemy" .. iter_96_1 .. "Tpl"))
	end

	self.enemyController = var_0_24(self.enemyTpls, self.sceneTf, function()
		self.bgRoleController:fail()
		self:onGameOver()

		return
	end, function()
		self:gameUIUpdate()

		return
	end)
	self.attakeController = var_0_25(self.playerController, self.enemyController, function()
		self:gameUIUpdate()

		return
	end)

	local var_96_0 = {}

	for iter_96_2 = 1, 4 do
		table.insert(var_96_0, findTF(self._tf, "bg_background/role/role" .. iter_96_2))
	end

	self.bgRoleController = var_0_28(var_96_0, self.playerController)

	self:updateMenuUI()
	self:openMenuUI()

	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function PokeMoleView:updateMenuUI()
	local var_112_0 = self:getGameUsedTimes()

	setActive(findTF(self.menuUI, "btnStart/tip"), self:getGameTimes() > 0)
	self:CheckGet()

	return
end

function PokeMoleView:openMenuUI()
	setActive(findTF(self._tf, "scene_front"), false)
	setActive(findTF(self._tf, "scene_background"), false)
	setActive(findTF(self._tf, "scene"), false)
	setActive(self.gameUI, false)
	setActive(self.menuUI, true)
	self:updateMenuUI()

	return
end

function PokeMoleView:showSettlement()
	setActive(self.settlementUI, true)
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_114_0 = self:GetMGData():GetRuntimeData("elements")
	local var_114_1 = self.enemyController:getScore()
	local var_114_2

	if var_114_0 and #var_114_0 > 0 then
		var_114_2 = var_114_0[1] or 0

		if var_114_2 <= var_114_1 then
			var_114_2 = var_114_1

			self:StoreDataToServer({
				var_114_1
			})
		end
	end

	setText(findTF(self.settlementUI, "ad/highText"), var_114_2)
	setText(findTF(self.settlementUI, "ad/currentText"), var_114_1)

	if self:getGameTimes() and self:getGameTimes() > 0 then
		self:SendSuccess(0)
	end

	return
end

function PokeMoleView:Update()
	self:AddDebugInput()

	return
end

function PokeMoleView:AddDebugInput()
	if self.gameStop or self.settlementFlag then
		return
	end

	if IsUnityEditor and Input.GetKeyDown(KeyCode.Space) and self.playerController then
		local var_116_0 = self.playerController:useSpecial()
	end

	return
end

function PokeMoleView:CheckGet()
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

function PokeMoleView:clearUI()
	return
end

function PokeMoleView:readyStart()
	setActive(self.countUI, true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_12)
	self.bgRoleController:reset()

	return
end

function PokeMoleView:gameStart()
	self.gameStartFlag = true
	self.gameStepTime = 0
	self.gameLastTime = var_0_14

	setActive(findTF(self._tf, "scene_front"), true)
	setActive(findTF(self._tf, "scene_background"), true)
	setActive(findTF(self._tf, "scene"), true)
	setActive(self.gameUI, true)
	self.playerController:createPlayer()
	self:timerStart()
	self:gameUIUpdate()

	return
end

function PokeMoleView:onTimer()
	self:gameStep()

	return
end

function PokeMoleView:gameStep()
	self.playerController:step()
	self.enemyController:step()
	self.bgRoleController:step()

	self.gameLastTime = self.gameLastTime - Time.deltaTime

	setText(self.textScore, self.enemyController:getScore())

	if self.gameLastTime <= 0 then
		self.gameLastTime = 0

		self:onGameOver()
	end

	setText(self.textTime, math.ceil(self.gameLastTime) .. "")

	local var_122_0, var_122_1 = self.playerController:getSpecialData()

	var_122_1 = var_122_1 or 0

	if var_122_0 > 0 then
		setSlider(self.specialSlider, 0, 1, var_122_0 / var_0_19)
	else
		setSlider(self.specialSlider, 0, 1, var_122_1 / var_0_20)
	end

	if var_122_1 == var_0_20 or var_122_0 > 0 then
		SetActive(self.touchSlider, false)
		SetActive(self.specialEffect, true)
	else
		SetActive(self.touchSlider, true)
		SetActive(self.specialEffect, false)
	end

	if self.settlementFlag then
		SetActive(self.specialEffect, false)
	end

	SetActive(self.arrowTf, var_122_1 == var_0_20 and var_122_0 == 0)

	return
end

function PokeMoleView:gameUIUpdate()
	for iter_123_0 = 1, #self.hearts do
		if iter_123_0 <= self.enemyController:getCakeLifeIndex() then
			SetActive(self.hearts[iter_123_0], true)
		else
			SetActive(self.hearts[iter_123_0], false)
		end
	end

	setText(self.textScore, self.enemyController:getScore())

	return
end

function PokeMoleView:resumeGame()
	self.gameStop = false

	setActive(self.leaveUI, false)
	self:timerStart()

	return
end

function PokeMoleView:stopGame()
	self.gameStop = true

	self:timerStop()

	return
end

function PokeMoleView:onGameOver()
	if self.settlementFlag then
		return
	end

	self:timerStop()

	self.settlementFlag = true

	SetActive(self.specialEffect, false)
	setActive(self.clickMask, true)
	LeanTween.delayedCall(go(self._tf), 1, System.Action(function()
		self:showSettlement()
		self.enemyController:clear()
		self.playerController:clear()
		self.bgRoleController:reset()

		self.settlementFlag = false
		self.gameStartFlag = false

		setActive(self.clickMask, false)

		return
	end))

	return
end

function PokeMoleView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function PokeMoleView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function PokeMoleView:getGameTimes()
	return self:GetMGHubData().count
end

function PokeMoleView:getGameUsedTimes()
	return self:GetMGHubData().usedtime
end

function PokeMoleView:getUltimate()
	return self:GetMGHubData().ultimate
end

function PokeMoleView:getGameTotalTime()
	return (self:GetMGHubData():getConfig("reward_need"))
end

function PokeMoleView:onBackPressed()
	return
end

function PokeMoleView:willExit()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	if self.timer and self.timer.running then
		self.timer:Stop()
	end

	self.timer = nil

	return
end

return PokeMoleView
