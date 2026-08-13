class = var_0_10000

local var_0_0 = "GameRoomPokeView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = {
	1000,
	230
}
local var_0_6 = {
	300,
	100
}
local var_0_7 = "backyard"
local var_0_8 = "event:/ui/jida"
local var_0_9 = "event:/ui/quanji"
local var_0_10 = "event:/ui/baozhaxiaoshi"
local var_0_11 = ""
local var_0_12 = ""
local var_0_13 = "event:/ui/ddldaoshu2"
local var_0_14 = 0.5
local var_0_15 = 90
local var_0_16 = {
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
local var_0_17 = {
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
local var_0_18 = 3
local var_0_19 = {
	1,
	2,
	3
}
local var_0_20 = 10
local var_0_21 = 10

local function var_0_22(arg_1_0, arg_1_1)
	local var_1_0 = {
		ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._callback = arg_1_1
			GetComponent = var_1

			local var_2_0 = arg_2_0._tf

			typeof = var_2_10004
			Animator = var_2_10006
			arg_2_0._animator = var_1(var_2_0, var_2_10004(var_2_10006))
			arg_2_0._attakeCount = 0
			arg_2_0._attakeCd = 0
			arg_2_0._specialTime = 0
			arg_2_0._specialCount = 0
			GetComponent = var_1
			findTF = var_2_0

			local var_2_1 = var_2_0(arg_2_0._tf, "atkCollider")

			typeof = var_4
			BoxCollider2D = var_6
			arg_2_0.atkCollider = var_1(var_2_1, var_4(var_6))
			GetComponent = var_1
			findTF = var_2_1

			local var_2_2 = var_2_1(arg_2_0._tf, "specialCollider")

			typeof = var_4
			BoxCollider2D = var_6
			arg_2_0.specialCollider = var_1(var_2_2, var_4(var_6))
			GetComponent = var_1

			local var_2_3 = arg_2_0._tf

			typeof = var_4
			DftAniEvent = var_6

			local var_2_4 = var_1(var_2_3, var_4(var_6))

			var_1.SetStartEvent(var_2_4, function()
				return
			end)
			var_1:SetTriggerEvent(function()
				if arg_2_0._callback then
					local var_4_0 = arg_2_0
					local var_4_1 = var_0.getColliderData(var_4_0)

					arg_2_0._callback(var_4_1)

					local var_4_2 = arg_2_0

					if var_1.getSpecialState(var_4_2) then
						pg = var_1

						local var_4_3 = var_1.CriMgr.GetInstance()

						var_1.PlaySoundEffect_V3(var_4_3, var_0_9)
					end
				end

				return
			end)
			var_1:SetEndEvent(function()
				return
			end)

			return
		end,
		getColliderData = function(arg_6_0)
			local var_6_0

			if arg_6_0:getSpecialState() then
				var_6_0 = arg_6_0.specialCollider
			else
				var_6_0 = arg_6_0.atkCollider
			end

			local var_6_1 = var_6_0.bounds.max.x - var_6_0.bounds.min.x
			local var_6_2 = var_6_0.bounds.max.y - var_6_0.bounds.min.y

			return {
				pos = var_6_0.bounds.min,
				boundsLength = {
					width = var_6_1,
					height = var_6_2
				},
				damage = arg_6_0:getDamage()
			}
		end,
		atk = function(arg_7_0)
			pg = var_2_10001

			local var_7_0 = var_2_10001.CriMgr.GetInstance()

			var_1.PlaySoundEffect_V3(var_7_0, var_0_8)

			local var_7_1 = arg_7_0._animator

			var_1.SetTrigger(var_7_1, "atk")

			arg_7_0._attakeCd = var_0_14

			return
		end,
		specialAtk = function(arg_8_0)
			local var_8_0 = arg_8_0._animator

			var_1.SetTrigger(var_8_0, "special")

			arg_8_0._attakeCd = var_0_14

			return
		end,
		getDamage = function(arg_9_0)
			if arg_9_0._specialTime > 0 then
				return 3
			end

			return 1
		end,
		reset = function(arg_10_0)
			local var_10_0 = arg_10_0._animator

			var_1.SetTrigger(var_10_0, "reset")

			return
		end,
		setActive = function(arg_11_0, arg_11_1)
			SetActive = var_2_10002

			var_2_10002(arg_11_0._tf, arg_11_1)

			return
		end,
		setParent = function(arg_12_0, arg_12_1, arg_12_2)
			SetParent = var_2_10003

			var_2_10003(arg_12_0._tf, arg_12_1)
			arg_12_0:setActive(arg_12_2)

			return
		end,
		attakeAble = function(arg_13_0)
			return arg_13_0._attakeCd == 0
		end,
		moveTo = function(arg_14_0, arg_14_1)
			arg_14_1.y = arg_14_1.y + 100
			arg_14_0._tf.anchoredPosition = arg_14_1

			return
		end,
		attakeCount = function(arg_15_0, arg_15_1)
			arg_15_0._attakeCount = arg_15_0._attakeCount + arg_15_1 * 4

			if arg_15_0._attakeCount > 8 then
				arg_15_0._attakeCount = 8
			end

			if arg_15_0._attakeCount > 0 then
				arg_15_0._animator.speed = 0
			end

			return
		end,
		addSpecialCount = function(arg_16_0, arg_16_1)
			if arg_16_0._specialTime == 0 then
				arg_16_0._specialCount = arg_16_0._specialCount + arg_16_1

				if arg_16_0._specialCount >= var_0_21 then
					arg_16_0._specialCount = var_0_21
				end
			end

			return
		end,
		useSpecial = function(arg_17_0)
			if arg_17_0._specialTime and arg_17_0._specialCount >= var_0_21 then
				arg_17_0._specialCount = 0
				arg_17_0._specialTime = var_0_20

				return true
			end

			return false
		end,
		SetSiblingIndex = function(arg_18_0, arg_18_1)
			local var_18_0 = arg_18_0._tf

			var_2.SetSiblingIndex(var_18_0, arg_18_1)

			return
		end,
		getSpecialState = function(arg_19_0)
			return arg_19_0._specialTime > 0
		end,
		step = function(arg_20_0)
			if arg_20_0._attakeCount > 0 then
				arg_20_0._attakeCount = arg_20_0._attakeCount - 1

				if arg_20_0._attakeCount == 0 then
					arg_20_0._animator.speed = 1
				end
			end

			local var_20_0 = arg_20_0._attakeCd

			if 0 < var_20_0 then
				local var_20_1 = arg_20_0._attakeCd

				Time = var_2
				arg_20_0._attakeCd = var_20_1 - var_2.deltaTime
				arg_20_0._attakeCd = arg_20_0._attakeCd < 0 and 0 or arg_20_0._attakeCd
			end

			local var_20_2 = arg_20_0._specialTime

			if 0 < var_20_2 then
				local var_20_3 = arg_20_0._specialTime

				Time = var_2
				arg_20_0._specialTime = var_20_3 - var_2.deltaTime
				arg_20_0._specialTime = arg_20_0._specialTime < 0 and 0 or arg_20_0._specialTime
			end

			return
		end,
		inSpecial = function(arg_21_0)
			return arg_21_0._specialTime > 0
		end,
		getSpecialData = function(arg_22_0)
			return arg_22_0._specialTime, arg_22_0._specialCount
		end,
		clear = function(arg_23_0)
			arg_23_0._specialTime = 0
			arg_23_0._specialCount = 0

			arg_23_0:reset()

			return
		end,
		useAtk = function(arg_24_0)
			if arg_24_0:inSpecial() then
				arg_24_0:specialAtk()
			else
				arg_24_0:atk()
			end

			return
		end
	}

	var_2.ctor(var_1_0)

	return var_2
end

local function var_0_23(arg_25_0, arg_25_1)
	local var_25_0 = {
		ctor = function(arg_26_0)
			arg_26_0.playerTpl = arg_25_0
			arg_26_0.sceneTf = arg_25_1
			findTF = var_1
			arg_26_0._playerPos = var_1(arg_26_0.sceneTf, "playerPos")
			GameObject = var_1

			local var_26_0 = var_1.Find("UICamera")

			arg_26_0.uiCam = var_1.GetComponent(var_26_0, "Camera")
			GetOrAddComponent = var_1
			findTF = var_26_0
			arg_26_0.dragDelegate = var_1(var_26_0(arg_26_0.sceneTf, "clickBounds"), "EventTriggerListener")
			arg_26_0.dragDelegate.enabled = true

			local var_26_1 = arg_26_0.dragDelegate

			var_1.AddPointDownFunc(var_26_1, function(arg_27_0, arg_27_1)
				if arg_26_0.player then
					local var_27_0 = arg_26_0.player

					if var_2.attakeAble(var_27_0) then
						local var_27_1 = arg_26_0.uiCam
						local var_27_2 = var_2.ScreenToWorldPoint(var_27_1, arg_27_1.pressPosition)
						local var_27_3 = arg_26_0._playerPos
						local var_27_4 = var_3.InverseTransformPoint(var_27_3, var_27_2)
						local var_27_5 = arg_26_0.player

						var_4.moveTo(var_27_5, var_27_4)

						local var_27_6 = arg_26_0.player

						var_4.reset(var_27_6)

						local var_27_7 = arg_26_0.player

						var_4.useAtk(var_27_7)
					end
				end

				return
			end)

			return
		end,
		createPlayer = function(arg_28_0)
			if arg_28_0.player == nil then
				local var_28_0 = var_0_22

				tf = var_2_10003
				Instantiate = var_2_10005
				arg_28_0.player = var_28_0(var_2_10003(var_2_10005(arg_28_0.playerTpl)), function(arg_29_0)
					local var_29_0 = arg_28_0

					var_1.playerActHand(var_29_0, arg_29_0)

					return
				end)

				local var_28_1 = arg_28_0.player

				var_1.setParent(var_28_1, arg_28_0._playerPos, true)
			end

			return
		end,
		playerActHand = function(arg_30_0, arg_30_1)
			if arg_30_0.playerHandle then
				arg_30_0.playerHandle(arg_30_1)
			end

			return
		end,
		setPlayerHandle = function(arg_31_0, arg_31_1)
			arg_31_0.playerHandle = arg_31_1

			return
		end,
		step = function(arg_32_0)
			if arg_32_0.player then
				local var_32_0 = arg_32_0.player

				var_1.step(var_32_0)
			end

			return
		end,
		getSpecialData = function(arg_33_0)
			if arg_33_0.player then
				local var_33_0 = arg_33_0.player

				return var_1.getSpecialData(var_33_0)
			end

			return nil, nil
		end,
		useSpecial = function(arg_34_0)
			if arg_34_0.player then
				local var_34_0 = arg_34_0.player

				return var_1.useSpecial(var_34_0)
			end

			return
		end,
		attakeCount = function(arg_35_0, arg_35_1)
			if arg_35_0.player then
				local var_35_0 = arg_35_0.player

				var_2.attakeCount(var_35_0, arg_35_1)
			end

			return
		end,
		addSpecialCount = function(arg_36_0, arg_36_1)
			if arg_36_0.player then
				local var_36_0 = arg_36_0.player

				var_2.addSpecialCount(var_36_0, arg_36_1)
			end

			return
		end,
		clear = function(arg_37_0)
			if arg_37_0.player then
				local var_37_0 = arg_37_0.player

				var_1.clear(var_37_0)
			end

			return
		end
	}

	var_2.ctor(var_25_0)

	return var_2
end

local function var_0_24(arg_38_0, arg_38_1)
	local var_38_0 = {
		ctor = function(arg_39_0)
			arg_39_0._tf = arg_38_0
			arg_39_0._data = arg_38_1
			arg_39_0._life = 0
			arg_39_0._enable = false
			arg_39_0._attakeAble = false
			GetComponent = var_1

			local var_39_0 = arg_39_0._tf

			typeof = var_2_10004
			Animator = var_2_10006
			arg_39_0._animator = var_1(var_39_0, var_2_10004(var_2_10006))
			GetComponent = var_1
			arg_39_0._boxCollider = var_1(arg_39_0._tf, "BoxCollider2D")
			GetComponent = var_1

			local var_39_1 = arg_39_0._tf

			typeof = var_4
			DftAniEvent = var_2_10006

			local var_39_2 = var_1(var_39_1, var_4(var_2_10006))

			var_1.SetStartEvent(var_39_2, function()
				if arg_39_0._callback then
					arg_39_0._callback(var_0_4)
				end

				return
			end)
			var_1:SetTriggerEvent(function()
				if arg_39_0._callback then
					arg_39_0._callback(var_0_3)
				end

				return
			end)
			var_1:SetEndEvent(function()
				arg_39_0._enable = false

				if arg_39_0._callback then
					arg_39_0._callback(var_0_2)
				end

				return
			end)

			return
		end,
		setHandle = function(arg_43_0, arg_43_1)
			arg_43_0._callback = arg_43_1

			return
		end,
		getSpeed = function(arg_44_0)
			return arg_44_0._data.speed
		end,
		step = function(arg_45_0)
			local var_45_0 = arg_45_0._enableTime

			if 0 < var_45_0 then
				local var_45_1 = arg_45_0._enableTime

				Time = var_2
				arg_45_0._enableTime = var_45_1 - var_2.deltaTime

				if arg_45_0._enableTime < 0 then
					arg_45_0._enable = true
					arg_45_0._enableTime = 0
				end
			end

			return
		end,
		apear = function(arg_46_0)
			local var_46_0 = arg_46_0._animator

			var_1.SetTrigger(var_46_0, "pop")

			math = var_1
			arg_46_0._enableTime = var_1.random() * arg_46_0._data.enable_time + 0.5
			arg_46_0._life = arg_46_0._data.life
			arg_46_0._attakeAble = true

			return
		end,
		stop = function(arg_47_0)
			local var_47_0 = arg_47_0._animator

			var_1.SetBool(var_47_0, "stop", true)

			return
		end,
		damage = function(arg_48_0, arg_48_1)
			arg_48_0._life = arg_48_0._life - arg_48_1

			if arg_48_0._life <= 0 then
				pg = var_2

				local var_48_0 = var_2.CriMgr.GetInstance()

				var_2.PlaySoundEffect_V3(var_48_0, var_0_10)
				arg_48_0:dead()
			else
				local var_48_1 = arg_48_0._animator

				var_2.SetTrigger(var_48_1, "damage")

				arg_48_0._enable = false
				arg_48_0._enableTime = arg_48_0._data.damage_time
			end

			return
		end,
		dead = function(arg_49_0)
			local var_49_0 = arg_49_0._animator

			var_1.SetTrigger(var_49_0, "dead")

			arg_49_0._enable = false
			arg_49_0._enableTime = 0
			arg_49_0._attakeAble = false

			return
		end,
		steal = function(arg_50_0)
			local var_50_0 = arg_50_0._animator

			var_1.SetTrigger(var_50_0, "steal")

			arg_50_0._enable = false
			arg_50_0._attakeAble = false

			return
		end,
		move = function(arg_51_0, arg_51_1, arg_51_2)
			var_3.x = arg_51_0._tf.anchoredPosition.x + arg_51_1
			var_3.y = var_3.y + arg_51_2
			arg_51_0._tf.anchoredPosition = var_3

			local var_51_0 = arg_51_0._tf.localScale

			Mathf = var_2_10005

			local var_51_1 = var_2_10005.Abs(arg_51_0._tf.localScale.x) * -1

			Mathf = var_2_10006
			var_51_0.x = var_51_1 * var_2_10006.Sign(arg_51_1)
			arg_51_0._tf.localScale = var_51_0

			return
		end,
		moveTo = function(arg_52_0, arg_52_1)
			arg_52_0._tf.anchoredPosition = arg_52_1

			local var_52_0 = arg_52_0._tf.localScale

			Mathf = var_2_10003

			local var_52_1 = var_2_10003.Abs(arg_52_0._tf.localScale.x)

			Mathf = var_2_10004
			var_52_0.x = var_52_1 * var_2_10004.Sign(arg_52_0._tf.localPosition.x)
			arg_52_0._tf.localScale = var_52_0

			return
		end,
		setParent = function(arg_53_0, arg_53_1, arg_53_2)
			SetParent = var_2_10003

			var_2_10003(arg_53_0._tf, arg_53_1)
			arg_53_0:setActive(arg_53_2)

			return
		end,
		setActive = function(arg_54_0, arg_54_1)
			SetActive = var_2_10002

			var_2_10002(arg_54_0._tf, arg_54_1)

			return
		end,
		SetSiblingIndex = function(arg_55_0, arg_55_1)
			local var_55_0 = arg_55_0._tf

			var_2.SetSiblingIndex(var_55_0, arg_55_1)

			return
		end,
		getPosition = function(arg_56_0)
			return arg_56_0._tf.anchoredPosition
		end,
		getType = function(arg_57_0)
			return arg_57_0._data.type
		end,
		getMoveAble = function(arg_58_0)
			isActive = var_2_10001

			local var_58_0

			if var_2_10001(arg_58_0._tf) then
				var_58_0 = arg_58_0._enable
			end

			return var_58_0
		end,
		getAttakeAble = function(arg_59_0)
			isActive = var_2_10001

			local var_59_0

			if var_2_10001(arg_59_0._tf) then
				var_59_0 = arg_59_0._attakeAble
			end

			return var_59_0
		end,
		getBounds = function(arg_60_0)
			return arg_60_0._boxCollider.bounds
		end,
		getLife = function(arg_61_0)
			return arg_61_0._life
		end,
		getScore = function(arg_62_0)
			return arg_62_0._data.score
		end,
		getBoundLength = function(arg_63_0)
			if arg_63_0.boundsData == nil then
				local var_63_0 = arg_63_0._boxCollider.bounds.max.x - arg_63_0._boxCollider.bounds.min.x
				local var_63_1 = arg_63_0._boxCollider.bounds.max.y - arg_63_0._boxCollider.bounds.min.y

				arg_63_0.boundsData = {
					width = var_63_0,
					height = var_63_1
				}
			end

			return arg_63_0.boundsData
		end
	}

	var_2.ctor(var_38_0)

	return var_2
end

local function var_0_25(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	local var_64_0 = {
		ctor = function(arg_65_0)
			arg_65_0.enemysTpl = arg_64_0
			arg_65_0.sceneTf = arg_64_1
			findTF = var_1
			arg_65_0.enemyPos = var_1(arg_65_0.sceneTf, "enemyPos")
			findTF = var_1
			arg_65_0.createPos = var_1(arg_65_0.sceneTf, "createPos")
			arg_65_0.countsWeight = {}

			for iter_65_0 = 1, #var_0_17.enemy_amounts do
				local var_65_0 = {}
				local var_65_1 = 0
				local var_65_2 = var_0_17.enemy_amounts[iter_65_0]

				for iter_65_1 = 1, #var_65_2 do
					var_65_1 = var_65_1 + var_65_2[iter_65_1]
					table = var_12

					var_12.insert(var_65_0, var_65_1)
				end

				table = var_8

				var_8.insert(arg_65_0.countsWeight, var_65_0)
			end

			arg_65_0.callback = arg_64_2
			arg_65_0.callback2 = arg_64_3
			arg_65_0.enemys = {}
			arg_65_0.enemysPool = {}
			arg_65_0.apearTime = 0
			arg_65_0.stepTime = 0
			arg_65_0.level = 1
			arg_65_0.cakeLife = var_0_18
			findTF = var_1
			arg_65_0.cakeTf = var_1(arg_65_0.sceneTf, "enemyPos/cake")
			GetComponent = var_1
			findTF = var_3

			local var_65_3 = var_3(arg_65_0.cakeTf, "image")

			typeof = var_4
			Animator = var_6
			arg_65_0.cakeAniamtor = var_1(var_65_3, var_4(var_6))

			local var_65_4 = arg_65_0.cakeAniamtor

			var_1.SetInteger(var_65_4, "life", arg_65_0:getCakeLifeIndex())

			GetComponent = var_1
			arg_65_0.cakeBox = var_1(arg_65_0.cakeTf, "BoxCollider2D")
			arg_65_0.cakeBoundsLength = {
				width = arg_65_0.cakeBox.bounds.max.x - arg_65_0.cakeBox.bounds.min.x,
				height = arg_65_0.cakeBox.bounds.max.y - arg_65_0.cakeBox.bounds.min.y
			}
			arg_65_0.gameScore = 0
			arg_65_0.createBounds = {}

			for iter_65_2 = 0, arg_65_0.createPos.childCount - 1 do
				table = var_65_5

				local var_65_5 = var_65_5.insert
				local var_65_6 = arg_65_0.createBounds
				local var_65_7 = arg_65_0.createPos

				var_65_5(var_65_6, var_8.GetChild(var_65_7, iter_65_2))
			end

			return
		end,
		step = function(arg_66_0)
			for iter_66_0 = #var_0_17.level_up_time, 1, -1 do
				if iter_66_0 > arg_66_0.level and arg_66_0.stepTime > var_0_17.level_up_time[iter_66_0] and arg_66_0.level ~= iter_66_0 then
					arg_66_0.level = iter_66_0
					print = var_5

					var_5("level up :" .. arg_66_0.level)

					break
				end
			end

			local var_66_0

			if arg_66_0.apearTime == 0 then
				var_66_0 = arg_66_0:getCreateCounts()

				for iter_66_1 = 1, var_66_0 do
					if #arg_66_0.enemys < var_0_17.enemy_max[arg_66_0.level] then
						local var_66_1 = var_0_16

						math = var_7

						local var_66_2 = var_66_1[var_7.random(1, #var_0_16)]
						local var_66_3

						if not arg_66_0:getEnemyFromPool(var_66_2.type) then
							var_66_3 = arg_66_0:createEnemy(var_66_2)
						end

						table = var_8

						var_8.insert(arg_66_0.enemys, var_66_3)
						var_66_3:setActive(true)
						var_66_3:moveTo(arg_66_0:getRandApearPosition())
						var_66_3:apear()
					end
				end

				arg_66_0.apearTime = var_0_17.enemy_apear_time[arg_66_0.level]
			end

			table = var_66_0

			var_66_0.sort(arg_66_0.enemys, function(arg_67_0, arg_67_1)
				return arg_67_0:getPosition().y > arg_67_1:getPosition().y
			end)

			local var_66_4 = 0

			for iter_66_2 = #arg_66_0.enemys, 1, -1 do
				local var_66_5 = arg_66_0.enemys[iter_66_2]

				if arg_66_0.cakeTf.localPosition.y <= var_66_5:getPosition().y then
					var_66_4 = var_66_4 + 1
				end

				var_66_5:SetSiblingIndex(iter_66_2)
				var_66_5:step()

				if var_66_5:getMoveAble() then
					local var_66_6 = var_66_5:getPosition()
					local var_66_7 = arg_66_0

					if arg_66_0.checkEnemySteal(var_66_7, var_66_5) then
						var_66_7 = var_66_5

						var_66_5.steal(var_66_7)
					else
						Mathf = var_8

						local var_66_8 = var_8.Atan2

						Mathf = var_66_7

						local var_66_9 = var_66_7.Abs(var_66_6.y)

						Mathf = var_11

						local var_66_10 = var_66_8(var_66_9, var_11.Abs(var_66_6.x))
						local var_66_11 = var_66_5
						local var_66_12 = var_66_5.getSpeed(var_66_11)

						Mathf = var_66_9

						local var_66_13 = var_66_12 * var_66_9.Cos(var_66_10)

						Mathf = var_10

						local var_66_14 = var_66_13 * -var_10.Sign(var_66_6.x)
						local var_66_15 = var_66_5:getSpeed()

						Mathf = var_66_11

						local var_66_16 = var_66_15 * var_66_11.Sin(var_66_10)

						Mathf = var_11

						local var_66_17 = var_66_16 * -var_11.Sign(var_66_6.y)
						local var_66_18 = var_66_5
						local var_66_19 = var_66_5.move

						Time = var_2_10014
						var_2_10014 = var_66_14 * var_2_10014.deltaTime
						Time = var_2_10015

						var_66_19(var_66_18, var_2_10014, var_66_17 * var_2_10015.deltaTime)
					end
				end
			end

			local var_66_20 = arg_66_0.cakeTf

			var_2.SetSiblingIndex(var_66_20, var_66_4)

			local var_66_21 = arg_66_0.apearTime

			Time = var_3
			arg_66_0.apearTime = var_66_21 - var_3.deltaTime

			if arg_66_0.apearTime < 0 then
				arg_66_0.apearTime = 0
			end

			local var_66_22 = arg_66_0.stepTime

			Time = var_3
			arg_66_0.stepTime = var_66_22 + var_3.deltaTime

			local var_66_23 = arg_66_0.cakeAniamtor

			var_2.SetInteger(var_66_23, "life", arg_66_0:getCakeLifeIndex())

			return
		end,
		getCreateCounts = function(arg_68_0)
			local var_68_0 = arg_68_0.countsWeight[arg_68_0.level]

			math = var_2

			local var_68_1 = var_2.random(1, var_68_0[#var_68_0])

			for iter_68_0 = 1, #var_68_0 do
				if var_68_1 <= var_68_0[iter_68_0] then
					return iter_68_0
				end
			end

			return 1
		end,
		checkEnemySteal = function(arg_69_0, arg_69_1)
			local var_69_0 = arg_69_1:getBounds().min
			local var_69_1 = arg_69_1:getBoundLength()
			local var_69_2 = arg_69_0.cakeBox.bounds.min
			local var_69_3 = arg_69_0.cakeBoundsLength

			return arg_69_0:checkRectCollider(var_69_0, var_69_2, var_69_1, var_69_3)
		end,
		checkRectCollider = function(arg_70_0, arg_70_1, arg_70_2, arg_70_3, arg_70_4)
			local var_70_0 = arg_70_1.x
			local var_70_1 = arg_70_1.y
			local var_70_2 = arg_70_3.width
			local var_70_3 = arg_70_3.height
			local var_70_4 = arg_70_2.x
			local var_70_5 = arg_70_2.y
			local var_70_6 = arg_70_4.width
			local var_70_7 = arg_70_4.height

			if var_70_4 <= var_70_0 and var_70_0 >= var_70_4 + var_70_6 then
				return false
			elseif var_70_0 <= var_70_4 and var_70_4 >= var_70_0 + var_70_2 then
				return false
			elseif var_70_5 <= var_70_1 and var_70_1 >= var_70_5 + var_70_7 then
				return false
			elseif var_70_1 <= var_70_5 and var_70_5 >= var_70_1 + var_70_3 then
				return false
			else
				return true
			end

			return
		end,
		createEnemy = function(arg_71_0, arg_71_1)
			tf = var_2_10002
			Instantiate = var_2_10004

			local var_71_0 = var_2_10002(var_2_10004(arg_71_0.enemysTpl[arg_71_1.type]))
			local var_71_1 = var_0_24(var_71_0, arg_71_1)

			var_3.setHandle(var_71_1, function(arg_72_0)
				local var_72_0 = arg_71_0

				var_1.enemyEventHandle(var_72_0, arg_72_0, var_0)

				return
			end)
			var_3:setParent(arg_71_0.enemyPos, true)

			return var_3
		end,
		getEnemyFromPool = function(arg_73_0, arg_73_1)
			for iter_73_0 = 1, #arg_73_0.enemysPool do
				local var_73_0 = arg_73_0.enemysPool[iter_73_0]

				if var_6.getType(var_73_0) == arg_73_1 then
					table = var_7

					var_7.remove(arg_73_0.enemysPool, iter_73_0)

					return var_6
				end
			end

			return nil
		end,
		removeEnemy = function(arg_74_0, arg_74_1)
			for iter_74_0 = #arg_74_0.enemys, 1, -1 do
				if arg_74_0.enemys[iter_74_0] == arg_74_1 then
					table = var_6

					var_6.remove(arg_74_0.enemys, iter_74_0)
				end
			end

			arg_74_1:setActive(false)

			table = var_2

			var_2.insert(arg_74_0.enemysPool, arg_74_1)

			return
		end,
		getRandApearPosition = function(arg_75_0)
			math = var_2_10001

			local var_75_0 = var_2_10001.random(1, #arg_75_0.createBounds)
			local var_75_1 = arg_75_0.createBounds[var_75_0]

			math = var_3

			local var_75_2 = var_3.random() * (var_75_1.sizeDelta.x / 2)

			math = var_4

			local var_75_3 = var_75_2 * (var_4.random() < 0.5 and 1 or -1)

			math = var_4

			local var_75_4 = var_4.random() * (var_75_1.sizeDelta.y / 2)

			math = var_5

			local var_75_5 = var_75_4 * (var_5.random() < 0.5 and 1 or -1)
			local var_75_6 = var_75_1:TransformPoint(var_75_3, var_75_5, 0)
			local var_75_7 = arg_75_0.enemyPos

			return (var_6.InverseTransformPoint(var_75_7, var_75_6.x, var_75_6.y, var_75_6.z))
		end,
		enemyEventHandle = function(arg_76_0, arg_76_1, arg_76_2)
			if arg_76_1 == var_0_3 then
				arg_76_0.cakeLife = arg_76_0.cakeLife - 1

				if arg_76_0.callback2 then
					arg_76_0.callback2()
				end

				if arg_76_0.cakeLife <= 0 and arg_76_0.callback then
					arg_76_0.callback()
				end

				local var_76_0 = arg_76_0.cakeAniamtor

				var_3.SetInteger(var_76_0, "life", arg_76_0:getCakeLifeIndex())
			elseif arg_76_1 == var_0_2 then
				arg_76_0.gameScore = arg_76_0.gameScore + arg_76_2:getScore()

				arg_76_0:removeEnemy(arg_76_2)
			else
				arg_76_0:removeEnemy(arg_76_2)
			end

			return
		end,
		playerActAttake = function(arg_77_0, arg_77_1)
			local var_77_0 = arg_77_1.pos
			local var_77_1 = arg_77_1.boundsLength
			local var_77_2 = arg_77_1.damage
			local var_77_3 = 0
			local var_77_4 = 0

			for iter_77_0 = 1, #arg_77_0.enemys do
				local var_77_5 = arg_77_0.enemys[iter_77_0]

				if var_11.getAttakeAble(var_77_5) then
					local var_77_6 = var_11:getBounds().min
					local var_77_7 = var_11:getBoundLength()

					if arg_77_0:checkRectCollider(var_77_6, var_77_0, var_77_7, var_77_1) then
						var_11:damage(var_77_2)

						var_77_3 = var_77_3 + 1

						if var_11:getLife() == 0 then
							var_77_4 = var_77_4 + 1
						end
					end
				end
			end

			return var_77_3, var_77_4
		end,
		clear = function(arg_78_0)
			arg_78_0.stepTime = 0

			for iter_78_0 = #arg_78_0.enemys, 1, -1 do
				table = var_2_10005

				local var_78_0 = var_2_10005.remove(arg_78_0.enemys, iter_78_0)

				var_2_10005.setActive(var_78_0, false)

				table = var_6

				var_6.insert(arg_78_0.enemysPool, var_2_10005)
			end

			arg_78_0.cakeLife = var_0_18
			arg_78_0.gameScore = 0
			arg_78_0.level = 1

			return
		end,
		getCakeLife = function(arg_79_0)
			return arg_79_0.cakeLife
		end,
		getCakeLifeIndex = function(arg_80_0)
			for iter_80_0 = #var_0_19, 1, -1 do
				if arg_80_0.cakeLife >= var_0_19[iter_80_0] then
					return iter_80_0
				end
			end

			return 0
		end,
		getScore = function(arg_81_0)
			return arg_81_0.gameScore
		end
	}

	var_4.ctor(var_64_0)

	return var_4
end

local function var_0_26(arg_82_0, arg_82_1, arg_82_2)
	local var_82_0 = {
		ctor = function(arg_83_0)
			arg_83_0.playerController = arg_82_0
			arg_83_0.enemyController = arg_82_1
			arg_83_0.callback = arg_82_2

			local var_83_0 = arg_83_0.playerController

			var_1.setPlayerHandle(var_83_0, function(arg_84_0)
				local var_84_0 = arg_83_0.enemyController
				local var_84_1, var_84_2 = var_1.playerActAttake(var_84_0, arg_84_0)

				if var_84_1 > 0 then
					local var_84_3 = arg_83_0.playerController

					var_3.attakeCount(var_84_3, var_84_1)
				end

				if var_84_2 > 0 then
					local var_84_4 = arg_83_0.playerController

					var_3.addSpecialCount(var_84_4, var_84_2)

					if arg_83_0.callback then
						arg_83_0.callback()
					end
				end

				return
			end)

			return
		end
	}

	var_3.ctor(var_82_0)

	return var_3
end

local var_0_27 = "role type loop"
local var_0_28 = "role type normal"

local function var_0_29(arg_85_0, arg_85_1)
	local var_85_0 = {
		ctor = function(arg_86_0)
			arg_86_0.playerController = arg_85_1
			arg_86_0.roleTfs = arg_85_0
			arg_86_0.roleDatas = {}

			for iter_86_0 = 1, #arg_86_0.roleTfs do
				local var_86_0 = {}

				GetComponent = var_2_10006

				local var_86_1 = arg_86_0.roleTfs[iter_86_0]

				typeof = var_2_10009
				Animator = var_2_10011
				var_86_0.animator = var_2_10006(var_86_1, var_2_10009(var_2_10011))

				if iter_86_0 == 2 or iter_86_0 == 3 then
					var_86_0.type = var_0_27
					var_86_0.loop_time = {
						3,
						3
					}
					var_86_0.time = 0
				else
					var_86_0.type = var_0_28
				end

				table = var_2_10006

				var_2_10006.insert(arg_86_0.roleDatas, var_86_0)
			end

			return
		end,
		step = function(arg_87_0)
			local var_87_0 = arg_87_0.playerController
			local var_87_1 = var_1.getSpecialData(var_87_0)

			for iter_87_0 = 1, #arg_87_0.roleDatas do
				if arg_87_0.roleDatas[iter_87_0].type == var_0_27 then
					if var_6.time == 0 then
						local var_87_2 = var_6.animator

						var_7.SetTrigger(var_87_2, "loop")

						math = var_7
						var_6.time = var_7.random() * var_6.loop_time[1] + var_6.loop_time[2]
					else
						local var_87_3 = var_6.time

						Time = var_8
						var_6.time = var_87_3 - var_8.deltaTime

						if var_6.time < 0 then
							var_6.time = 0
						end
					end
				end

				if var_6.special and var_87_1 == 0 then
					local var_87_4 = var_6.animator

					var_7.SetTrigger(var_87_4, "reset")

					var_6.special = false
				end
			end

			return
		end,
		special = function(arg_88_0)
			for iter_88_0 = 1, #arg_88_0.roleDatas do
				local var_88_0 = arg_88_0.roleDatas[iter_88_0].animator

				var_6.SetTrigger(var_88_0, "special")

				var_5.special = true
			end

			return
		end,
		fail = function(arg_89_0)
			for iter_89_0 = 1, #arg_89_0.roleDatas do
				local var_89_0 = arg_89_0.roleDatas[iter_89_0].animator

				var_6.SetTrigger(var_89_0, "fail")
			end

			return
		end,
		reset = function(arg_90_0)
			for iter_90_0 = 1, #arg_90_0.roleDatas do
				local var_90_0 = arg_90_0.roleDatas[iter_90_0].animator

				var_6.SetTrigger(var_90_0, "reset")
			end

			return
		end
	}

	var_2.ctor(var_85_0)

	return var_2
end

function var_0_1.getUIName(arg_91_0)
	return "GameRoomPokeUI"
end

function var_0_1.getBGM(arg_92_0)
	return var_0_7
end

function var_0_1.didEnter(arg_93_0)
	arg_93_0:initData()
	arg_93_0:initUI()

	return
end

function var_0_1.initData(arg_94_0)
	arg_94_0.settlementFlag = false
	arg_94_0.gameStartFlag = false
	Application = var_1

	local var_94_0

	if not var_1.targetFrameRate then
		var_94_0 = 60
	end

	Timer = var_1_10002
	arg_94_0.timer = var_1_10002.New(function()
		local var_95_0 = arg_94_0

		var_0.onTimer(var_95_0)

		return
	end, 1 / var_94_0, -1, true)

	return
end

function var_0_1.initUI(arg_96_0)
	findTF = var_1_10001
	arg_96_0.clickMask = var_1_10001(arg_96_0._tf, "clickMask")
	findTF = var_1
	arg_96_0.countUI = var_1(arg_96_0._tf, "pop/CountUI")
	setActive = var_1

	var_1(arg_96_0.countUI, false)

	GetComponent = var_1
	findTF = var_3

	local var_96_0 = var_3(arg_96_0.countUI, "count")

	typeof = var_4
	Animator = var_6
	arg_96_0.countAnimator = var_1(var_96_0, var_4(var_6))
	GetComponent = var_1
	findTF = var_96_0

	local var_96_1 = var_96_0(arg_96_0.countUI, "count")

	typeof = var_4
	DftAniEvent = var_6
	arg_96_0.countDft = var_1(var_96_1, var_4(var_6))

	local var_96_2 = arg_96_0.countDft

	var_1.SetTriggerEvent(var_96_2, function()
		return
	end)

	local var_96_3 = arg_96_0.countDft

	var_1.SetEndEvent(var_96_3, function()
		setActive = var_2_10000

		var_2_10000(arg_96_0.countUI, false)

		local var_98_0 = arg_96_0

		var_0.gameStart(var_98_0)

		return
	end)

	findTF = var_1
	arg_96_0.leaveUI = var_1(arg_96_0._tf, "pop/LeaveUI")
	onButton = var_1

	local var_96_4 = arg_96_0

	findTF = var_4

	local var_96_5 = var_4(arg_96_0.leaveUI, "ad/btnOk")

	local function var_96_6()
		local var_99_0 = arg_96_0

		var_0.resumeGame(var_99_0)

		local var_99_1 = arg_96_0

		var_0.onGameOver(var_99_1)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_96_4, var_96_5, var_96_6, var_6)

	onButton = var_1

	local var_96_7 = arg_96_0

	findTF = var_96_5

	local var_96_8 = var_96_5(arg_96_0.leaveUI, "ad/btnCancel")

	local function var_96_9()
		local var_100_0 = arg_96_0

		var_0.resumeGame(var_100_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_96_7, var_96_8, var_96_9, var_6)

	findTF = var_1
	arg_96_0.pauseUI = var_1(arg_96_0._tf, "pop/pauseUI")
	onButton = var_1

	local var_96_10 = arg_96_0

	findTF = var_4

	local var_96_11 = var_4(arg_96_0.pauseUI, "ad/btnOk")

	local function var_96_12()
		setActive = var_2_10000

		var_2_10000(arg_96_0.pauseUI, false)

		local var_101_0 = arg_96_0

		var_0.resumeGame(var_101_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_96_10, var_96_11, var_96_12, var_6)

	findTF = var_1
	arg_96_0.settlementUI = var_1(arg_96_0._tf, "pop/SettleMentUI")
	onButton = var_1

	local var_96_13 = arg_96_0

	findTF = var_4

	local var_96_14 = var_4(arg_96_0.settlementUI, "ad/btnOver")

	local function var_96_15()
		setActive = var_2_10000

		var_2_10000(arg_96_0.settlementUI, false)

		local var_102_0 = arg_96_0

		var_0.openMenuUI(var_102_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_96_13, var_96_14, var_96_15, var_6)

	findTF = var_1
	arg_96_0.menuUI = var_1(arg_96_0._tf, "pop/menuUI")
	onButton = var_1

	local var_96_16 = arg_96_0

	findTF = var_4

	local var_96_17 = var_4(arg_96_0.menuUI, "btnBack")

	local function var_96_18()
		local var_103_0 = arg_96_0

		var_0.closeView(var_103_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_96_16, var_96_17, var_96_18, var_6)

	onButton = var_1

	local var_96_19 = arg_96_0

	findTF = var_96_17

	local var_96_20 = var_96_17(arg_96_0.menuUI, "btnRule")

	local function var_96_21()
		pg = var_2_10000

		local var_104_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_104_1 = var_0.ShowMsgBox
		local var_104_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_104_2.type = var_2_10004

		local var_104_3 = arg_96_0

		var_104_2.helps = var_4.getGameRoomData(var_104_3).game_help

		var_104_1(var_104_0, var_104_2)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_96_19, var_96_20, var_96_21, var_6)

	onButton = var_1

	local var_96_22 = arg_96_0

	findTF = var_96_20

	local var_96_23 = var_96_20(arg_96_0.menuUI, "btnStart")

	local function var_96_24()
		setActive = var_2_10000

		var_2_10000(arg_96_0.menuUI, false)

		local var_105_0 = arg_96_0

		var_0.readyStart(var_105_0)

		return
	end

	SFX_CANCEL = var_96_26

	var_1(var_96_22, var_96_23, var_96_24, var_96_26)

	findTF = var_1
	arg_96_0.gameUI = var_1(arg_96_0._tf, "ui/gameUI")
	findTF = var_1
	arg_96_0.textTime = var_1(arg_96_0.gameUI, "time")
	findTF = var_1
	arg_96_0.textScore = var_1(arg_96_0.gameUI, "score")
	arg_96_0.hearts = {}

	local var_96_25 = 3

	for iter_96_0 = 1, var_96_25 do
		findTF = var_96_26

		local var_96_26 = var_96_26(arg_96_0.gameUI, "heart" .. iter_96_0 .. "/img")

		table = var_7

		var_7.insert(arg_96_0.hearts, var_96_26)
	end

	onButton = var_2

	local var_96_27 = arg_96_0

	findTF = iter_96_0

	var_2(var_96_27, iter_96_0(arg_96_0.gameUI, "btnStop"), function()
		local var_106_0 = arg_96_0

		var_0.stopGame(var_106_0)

		setActive = var_0

		var_0(arg_96_0.pauseUI, true)

		return
	end)

	onButton = var_2

	local var_96_28 = arg_96_0

	findTF = var_5

	var_2(var_96_28, var_5(arg_96_0.gameUI, "btnLeave"), function()
		local var_107_0 = arg_96_0

		var_0.stopGame(var_107_0)

		setActive = var_0

		var_0(arg_96_0.leaveUI, true)

		return
	end)

	GetComponent = var_2
	findTF = var_96_28

	local var_96_29 = var_96_28(arg_96_0.gameUI, "btnSpecial/Slider")

	typeof = var_5
	Slider = var_7
	arg_96_0.specialSlider = var_2(var_96_29, var_5(var_7))
	findTF = var_2
	arg_96_0.touchSlider = var_2(arg_96_0.specialSlider, "touch")
	findTF = var_2
	arg_96_0.specialEffect = var_2(arg_96_0.gameUI, "btnSpecial/baoweidangao_extiao")
	findTF = var_2
	arg_96_0.arrowTf = var_2(arg_96_0.gameUI, "btnSpecial/arrow")
	onButton = var_2

	local var_96_30 = arg_96_0

	findTF = var_5

	var_2(var_96_30, var_5(arg_96_0.gameUI, "btnSpecial"), function()
		if arg_96_0.playerController then
			local var_108_0 = arg_96_0.playerController

			if var_0.useSpecial(var_108_0) then
				local var_108_1 = arg_96_0.bgRoleController

				var_1.special(var_108_1)
			end
		end

		return
	end)

	findTF = var_2
	arg_96_0.sceneTf = var_2(arg_96_0._tf, "scene")
	findTF = var_2
	arg_96_0.playerTpl = var_2(arg_96_0._tf, "playerTpl")
	arg_96_0.playerController = var_0_23(arg_96_0.playerTpl, arg_96_0.sceneTf)
	arg_96_0.enemyTpls = {}

	for iter_96_1 = 1, 4 do
		table = var_96_31

		local var_96_31 = var_96_31.insert
		local var_96_32 = arg_96_0.enemyTpls

		findTF = var_1_10009

		var_96_31(var_96_32, var_1_10009(arg_96_0._tf, "enemy" .. iter_96_1 .. "Tpl"))
	end

	arg_96_0.enemyController = var_0_25(arg_96_0.enemyTpls, arg_96_0.sceneTf, function()
		local var_109_0 = arg_96_0.bgRoleController

		var_0.fail(var_109_0)

		local var_109_1 = arg_96_0

		var_0.onGameOver(var_109_1)

		return
	end, function()
		local var_110_0 = arg_96_0

		var_0.gameUIUpdate(var_110_0)

		return
	end)
	arg_96_0.attakeController = var_0_26(arg_96_0.playerController, arg_96_0.enemyController, function()
		local var_111_0 = arg_96_0

		var_0.gameUIUpdate(var_111_0)

		return
	end)

	local var_96_33 = {}
	local var_96_34 = 4

	for iter_96_2 = 1, var_96_34 do
		table = var_96_32
		var_96_32 = var_96_32.insert

		local var_96_35 = var_96_33

		findTF = var_1_10011

		var_96_32(var_96_35, var_1_10011(arg_96_0._tf, "bg_background/role/role" .. iter_96_2))
	end

	arg_96_0.bgRoleController = var_0_29(var_96_33, arg_96_0.playerController)

	arg_96_0:updateMenuUI()
	arg_96_0:openMenuUI()

	if not arg_96_0.handle then
		UpdateBeat = var_4
		arg_96_0.handle = var_4:CreateListener(arg_96_0.Update, arg_96_0)
	end

	UpdateBeat = var_4

	var_4:AddListener(arg_96_0.handle)

	return
end

function var_0_1.updateMenuUI(arg_112_0)
	local var_112_0 = arg_112_0
	local var_112_1 = arg_112_0.getGameUsedTimes(var_112_0)
	local var_112_2 = arg_112_0:getGameTimes()

	setActive = var_112_0
	findTF = var_1_10005

	var_112_0(var_1_10005(arg_112_0.menuUI, "btnStart/tip"), var_112_2 > 0)
	arg_112_0:CheckGet()

	return
end

function var_0_1.openMenuUI(arg_113_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_113_0._tf, "scene_front"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_113_0._tf, "scene_background"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_113_0._tf, "scene"), false)

	setActive = var_1_10001

	var_1_10001(arg_113_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_113_0.menuUI, true)
	arg_113_0:openCoinLayer(true)
	arg_113_0:updateMenuUI()

	return
end

function var_0_1.showSettlement(arg_114_0)
	setActive = var_1_10001

	var_1_10001(arg_114_0.settlementUI, true)

	GetComponent = var_1_10001
	findTF = var_3

	local var_114_0 = var_3(arg_114_0.settlementUI, "ad")

	typeof = var_4
	Animator = var_6

	local var_114_1 = var_1_10001(var_114_0, var_4(var_6))

	var_1.Play(var_114_1, "settlement", -1, 0)

	local var_114_2 = arg_114_0:GetMGData()
	local var_114_3 = var_2.GetRuntimeData(var_114_2, "elements")
	local var_114_4 = arg_114_0.enemyController
	local var_114_5 = var_3.getScore(var_114_4)

	if var_114_3 then
		local var_114_6 = #var_114_3
		local var_114_7

		if not (0 < var_114_6) or not var_114_3[1] then
			var_114_7 = 0
		end

		if var_114_7 <= var_114_5 then
			var_114_7 = var_114_5

			arg_114_0:StoreDataToServer({
				var_114_7
			})
		end

		findTF = var_114_4

		local var_114_8 = var_114_4(arg_114_0.settlementUI, "ad/highText")

		findTF = var_6

		local var_114_9 = var_6(arg_114_0.settlementUI, "ad/currentText")

		setText = var_7

		var_7(var_114_8, var_114_7)

		setText = var_7

		var_7(var_114_9, var_114_5)
		arg_114_0:SendSuccess(var_114_5)

		return
	end
end

function var_0_1.Update(arg_115_0)
	arg_115_0:AddDebugInput()

	return
end

function var_0_1.AddDebugInput(arg_116_0)
	if arg_116_0.gameStop or arg_116_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		Input = var_1

		local var_116_0 = var_1.GetKeyDown

		KeyCode = var_1_10003

		if var_116_0(var_1_10003.Space) and arg_116_0.playerController then
			local var_116_1 = arg_116_0.playerController
			local var_116_2 = var_1.useSpecial(var_116_1)
		end
	end

	return
end

function var_0_1.CheckGet(arg_117_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_117_0.menuUI, "got"), false)

	if arg_117_0:getUltimate() then
		local var_117_0 = arg_117_0

		if arg_117_0.getUltimate(var_117_0) ~= 0 then
			setActive = var_1
			findTF = var_117_0

			var_1(var_117_0(arg_117_0.menuUI, "got"), true)
		end
	end

	if arg_117_0:getUltimate() == 0 then
		local var_117_1 = arg_117_0

		if arg_117_0.getGameTotalTime(var_117_1) > arg_117_0:getGameUsedTimes() then
			return
		end

		pg = var_117_1

		local var_117_2 = var_117_1.m02
		local var_117_3 = var_3.sendNotification

		GAME = var_6

		local var_117_4 = var_6.SEND_MINI_GAME_OP
		local var_117_5 = {
			hubid = arg_117_0:GetMGHubData().id
		}

		MiniGameOPCommand = var_8
		var_117_5.cmd = var_8.CMD_ULTIMATE
		var_117_5.args1 = {}

		var_117_3(var_117_2, var_117_4, var_117_5)

		setActive = var_117_3
		findTF = var_117_2

		var_117_3(var_117_2(arg_117_0.menuUI, "got"), true)
	end

	return
end

function var_0_1.clearUI(arg_118_0)
	return
end

function var_0_1.readyStart(arg_119_0)
	arg_119_0:openCoinLayer(false)

	setActive = var_1

	var_1(arg_119_0.countUI, true)

	local var_119_0 = arg_119_0.countAnimator

	var_1.Play(var_119_0, "count")

	pg = var_1

	local var_119_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_119_1, var_0_13)

	local var_119_2 = arg_119_0.bgRoleController

	var_1.reset(var_119_2)

	return
end

function var_0_1.gameStart(arg_120_0)
	arg_120_0.gameStartFlag = true
	arg_120_0.gameStepTime = 0
	arg_120_0.gameLastTime = var_0_15
	setActive = var_1
	findTF = var_1_10003

	var_1(var_1_10003(arg_120_0._tf, "scene_front"), true)

	setActive = var_1
	findTF = var_3

	var_1(var_3(arg_120_0._tf, "scene_background"), true)

	setActive = var_1
	findTF = var_3

	var_1(var_3(arg_120_0._tf, "scene"), true)

	setActive = var_1

	var_1(arg_120_0.gameUI, true)

	local var_120_0 = arg_120_0.playerController

	var_1.createPlayer(var_120_0)
	arg_120_0:timerStart()
	arg_120_0:gameUIUpdate()

	return
end

function var_0_1.onTimer(arg_121_0)
	arg_121_0:gameStep()

	return
end

function var_0_1.gameStep(arg_122_0)
	local var_122_0 = arg_122_0.playerController

	var_1.step(var_122_0)

	local var_122_1 = arg_122_0.enemyController

	var_1.step(var_122_1)

	local var_122_2 = arg_122_0.bgRoleController

	var_1.step(var_122_2)

	local var_122_3 = arg_122_0.gameLastTime

	Time = var_1_10002
	arg_122_0.gameLastTime = var_122_3 - var_1_10002.deltaTime
	setText = var_1

	local var_122_4 = arg_122_0.textScore
	local var_122_5 = arg_122_0.enemyController

	var_1(var_122_4, var_4.getScore(var_122_5))

	if arg_122_0.gameLastTime <= 0 then
		arg_122_0.gameLastTime = 0

		arg_122_0:onGameOver()
	end

	setText = var_1

	local var_122_6 = arg_122_0.textTime

	math = var_4

	var_1(var_122_6, var_4.ceil(arg_122_0.gameLastTime) .. "")

	local var_122_7 = arg_122_0.playerController
	local var_122_8, var_122_9 = var_1.getSpecialData(var_122_7)

	var_122_9 = var_122_9 or 0

	if 0 < var_122_8 then
		setSlider = var_3

		var_3(arg_122_0.specialSlider, 0, 1, var_122_8 / var_0_20)
	else
		setSlider = var_3

		var_3(arg_122_0.specialSlider, 0, 1, var_122_9 / var_0_21)
	end

	if var_122_9 == var_0_21 or 0 < var_122_8 then
		SetActive = var_3

		var_3(arg_122_0.touchSlider, false)

		SetActive = var_3

		var_3(arg_122_0.specialEffect, true)
	else
		SetActive = var_3

		var_3(arg_122_0.touchSlider, true)

		SetActive = var_3

		var_3(arg_122_0.specialEffect, false)
	end

	if arg_122_0.settlementFlag then
		SetActive = var_3

		var_3(arg_122_0.specialEffect, false)
	end

	SetActive = var_3

	var_3(arg_122_0.arrowTf, var_122_9 == var_0_21 and var_122_8 == 0)

	return
end

function var_0_1.gameUIUpdate(arg_123_0)
	for iter_123_0 = 1, #arg_123_0.hearts do
		local var_123_0 = arg_123_0.enemyController

		if iter_123_0 <= var_5.getCakeLifeIndex(var_123_0) then
			SetActive = var_5

			var_5(arg_123_0.hearts[iter_123_0], true)
		else
			SetActive = var_5

			var_5(arg_123_0.hearts[iter_123_0], false)
		end
	end

	setText = var_1

	local var_123_1 = arg_123_0.textScore
	local var_123_2 = arg_123_0.enemyController

	var_1(var_123_1, var_4.getScore(var_123_2))

	return
end

function var_0_1.resumeGame(arg_124_0)
	arg_124_0.gameStop = false
	setActive = var_1

	var_1(arg_124_0.leaveUI, false)
	arg_124_0:timerStart()

	return
end

function var_0_1.stopGame(arg_125_0)
	arg_125_0.gameStop = true

	arg_125_0:timerStop()

	return
end

function var_0_1.onGameOver(arg_126_0)
	if arg_126_0.settlementFlag then
		return
	end

	arg_126_0:timerStop()

	arg_126_0.settlementFlag = true
	SetActive = var_1

	var_1(arg_126_0.specialEffect, false)

	setActive = var_1

	var_1(arg_126_0.clickMask, true)

	LeanTween = var_1

	local var_126_0 = var_1.delayedCall

	go = var_3

	local var_126_1 = var_3(arg_126_0._tf)
	local var_126_2 = 1

	System = var_5

	var_126_0(var_126_1, var_126_2, var_5.Action(function()
		local var_127_0 = arg_126_0

		var_0.showSettlement(var_127_0)

		local var_127_1 = arg_126_0.enemyController

		var_0.clear(var_127_1)

		local var_127_2 = arg_126_0.playerController

		var_0.clear(var_127_2)

		local var_127_3 = arg_126_0.bgRoleController

		var_0.reset(var_127_3)

		arg_126_0.settlementFlag = false

		local var_127_4 = arg_126_0

		var_127_4.gameStartFlag = false
		setActive = var_127_4

		var_127_4(arg_126_0.clickMask, false)

		return
	end))

	return
end

function var_0_1.timerStop(arg_128_0)
	if arg_128_0.timer.running then
		local var_128_0 = arg_128_0.timer

		var_1.Stop(var_128_0)
	end

	return
end

function var_0_1.timerStart(arg_129_0)
	if not arg_129_0.timer.running then
		local var_129_0 = arg_129_0.timer

		var_1.Start(var_129_0)
	end

	return
end

function var_0_1.getGameTimes(arg_130_0)
	return arg_130_0:GetMGHubData().count
end

function var_0_1.getGameUsedTimes(arg_131_0)
	return arg_131_0:GetMGHubData().usedtime
end

function var_0_1.getUltimate(arg_132_0)
	return arg_132_0:GetMGHubData().ultimate
end

function var_0_1.getGameTotalTime(arg_133_0)
	local var_133_0 = arg_133_0:GetMGHubData()

	return (var_1.getConfig(var_133_0, "reward_need"))
end

function var_0_1.onBackPressed(arg_134_0)
	return
end

function var_0_1.willExit(arg_135_0)
	if arg_135_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_135_0.handle)
	end

	if arg_135_0.timer and arg_135_0.timer.running then
		local var_135_0 = arg_135_0.timer

		var_1.Stop(var_135_0)
	end

	arg_135_0.timer = nil

	return
end

return var_0_1
