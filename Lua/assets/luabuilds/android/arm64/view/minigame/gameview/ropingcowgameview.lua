local var_0_0 = class("RopingCowGameView", import("..BaseMiniGameView"))
local var_0_1 = "story-richang-westdaily"
local var_0_2 = "event:/ui/ddldaoshu2"
local var_0_3 = "event:/ui/niujiao"
local var_0_4 = "event:/ui/taosheng"
local var_0_5 = 60
local var_0_6 = {
	{
		20,
		{
			0,
			0.25
		}
	},
	{
		40,
		{
			0.5,
			0.5
		}
	},
	{
		50,
		{
			0.5,
			1
		}
	},
	{
		60,
		{
			1,
			1.5
		}
	}
}
local var_0_7 = {
	{
		speed = 800,
		score = 300
	},
	{
		speed = 700,
		score = 200
	},
	{
		speed = 600,
		score = 100
	},
	{
		speed = 500,
		score = 50
	}
}
local var_0_8 = {
	{
		20,
		{
			300,
			300,
			200,
			200
		}
	},
	{
		40,
		{
			200,
			300,
			300,
			200
		}
	},
	{
		50,
		{
			150,
			250,
			300,
			300
		}
	},
	{
		60,
		{
			100,
			100,
			400,
			400
		}
	}
}
local var_0_9 = {
	-50,
	50
}
local var_0_10 = 0.75
local var_0_11 = 1700
local var_0_12 = 4
local var_0_13 = 0
local var_0_14 = 1
local var_0_15 = 2
local var_0_16 = "cow_event_capture"
local var_0_18 = "player_event_get"
local var_0_19 = "player_event_miss"
local var_0_20 = "player_event_cd"
local var_0_21 = "idol"
local var_0_22 = "miss"
local var_0_23 = "get"
local var_0_24 = "throw"
local var_0_25 = "event_capture"
local var_0_26 = "scene_item_type_time"
local var_0_27 = "scene_item_type_event"
local var_0_28 = {}

;({
	name = "backGround/2/jiujiuA"
}).type = "scene_item_type_time"
;({
	name = "backGround/2/jiujiuA"
}).params = {
	15,
	20
}
;({
	name = "backGround/2/jiujiuA"
}).states = {
	1,
	2,
	3
}
;({})[1] = {
	name = "backGround/2/jiujiuA"
}
;({})[2] = {
	name = "backGround/2/jiujiuB",
	type = "scene_item_type_time",
	params = {
		15,
		20
	},
	states = {
		1,
		2
	}
}
;({})[3] = {
	name = "backGround/2/jiujiuC",
	trigger = true,
	type = "scene_item_type_time",
	params = {
		15,
		20
	}
}
;({})[4] = {
	name = "backGround/3/jiujiuD",
	trigger = true,
	type = "scene_item_type_time",
	params = {
		20,
		22
	}
}
;({})[5] = {
	name = "backGround/3/train",
	trigger = true,
	type = "scene_item_type_time",
	params = {
		20,
		23
	}
}
;({})[6] = {
	name = "backGround/2/saloon",
	type = "scene_item_type_time",
	params = {
		15,
		20
	},
	states = {
		1,
		2,
		3
	}
}
;({})[7] = {
	name = "backGround/1/meow",
	type = "scene_item_type_time",
	params = {
		15,
		20
	},
	states = {
		1,
		2
	}
}
;({})[8] = {
	name = "backGround/1/sheriff",
	type = "scene_item_type_event",
	events = {
		"player_event_miss",
		"player_event_get",
		"player_event_cd"
	},
	states = {
		1,
		2,
		3
	}
}

local var_0_29 = "state"
local var_0_30 = "trigger"

local function var_0_31(arg_1_0, arg_1_1, arg_1_2)
	({
		ctor = function(arg_2_0)
			arg_2_0._tplCows = arg_1_0
			arg_2_0._container = arg_1_1
			arg_2_0._event = arg_1_2
			arg_2_0.cows = {}
			arg_2_0.cowWeights = {}

			for iter_2_0 = 1, #var_0_8 do
				arg_2_0.cowWeights[iter_2_0] = {}

				local var_2_0 = 0

				for iter_2_1, iter_2_2 in ipairs(var_0_8[iter_2_0][2]) do
					var_2_0 = var_2_0 + iter_2_2

					table.insert(arg_2_0.cowWeights[iter_2_0], var_2_0)
				end
			end

			return
		end,
		start = function(arg_3_0)
			arg_3_0.nextCreateTime = 0
			arg_3_0.lastTime = var_0_5

			arg_3_0:clear()

			return
		end,
		step = function(arg_4_0, arg_4_1)
			arg_4_0.lastTime = arg_4_0.lastTime - Time.deltaTime

			if arg_4_1 > arg_4_0.nextCreateTime then
				arg_4_0.nextCreateTime = arg_4_1 + arg_4_0:getNextCreateCowTime()

				arg_4_0:createCow()
			end

			for iter_4_0 = 1, #arg_4_0.cows do
				arg_4_0.cows[iter_4_0].tf.anchoredPosition.x = arg_4_0.cows[iter_4_0].tf.anchoredPosition.x - arg_4_0.cows[iter_4_0].data.speed * Time.deltaTime

				if arg_4_0.cows[iter_4_0].tf.anchoredPosition.x >= 0 and arg_4_0.cows[iter_4_0].tf.anchoredPosition.x <= 0 then
					arg_4_0:setCowAniamtion(arg_4_0.cows[iter_4_0].tf, var_0_15)
				end

				arg_4_0.cows[iter_4_0].tf.anchoredPosition = arg_4_0.cows[iter_4_0].tf.anchoredPosition
			end

			for iter_4_1 = #arg_4_0.cows, 1, -1 do
				if arg_4_0.cows[iter_4_1].tf.anchoredPosition.x <= -var_0_11 then
					arg_4_0:cowLeave(table.remove(arg_4_0.cows, iter_4_1).tf)
				end
			end

			return
		end,
		captureCow = function(arg_5_0, arg_5_1)
			local var_5_0

			for iter_5_0 = #arg_5_0.cows, 1, -1 do
				if arg_5_0.cows[iter_5_0].tf.anchoredPosition.x >= var_0_9[1] and arg_5_0.cows[iter_5_0].tf.anchoredPosition.x <= var_0_9[2] then
					if not var_5_0 then
						var_5_0 = iter_5_0
					elseif arg_5_0.cows[var_5_0].tf.anchoredPosition.x - arg_5_0.cows[iter_5_0].tf.anchoredPosition.x >= 0 then
						var_5_0 = iter_5_0
					end
				end
			end

			if var_5_0 then
				local var_5_2 = table.remove(arg_5_0.cows, var_5_0)

				arg_5_0:setCowAniamtion(var_5_2.tf, var_0_14)

				if arg_5_1 then
					arg_5_1(true)
				end

				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)
				arg_5_0._event:emit(var_0_16, var_5_2.data.score)
			elseif arg_5_1 then
				arg_5_1(false)
			end

			return
		end,
		clear = function(arg_6_0)
			for iter_6_0 = 1, #arg_6_0.cows do
				Destroy(arg_6_0.cows[iter_6_0].tf)
			end

			arg_6_0.cows = {}

			return
		end,
		destroy = function(arg_7_0)
			arg_7_0:clear()

			return
		end,
		createCow = function(arg_8_0)
			local var_8_0 = arg_8_0.cowWeights[arg_8_0:getCowWeightIndex()]
			local var_8_1 = math.random(0, var_8_0[#var_8_0])
			local var_8_2

			for iter_8_0 = 1, #var_8_0 do
				if var_8_1 < var_8_0[iter_8_0] then
					var_8_2 = iter_8_0

					break
				end
			end

			var_8_2 = var_8_2 or math.random(1, #var_0_7)

			local var_8_3 = tf(Instantiate(arg_8_0._tplCows[var_8_2]))

			SetActive(var_8_3, true)
			SetParent(var_8_3, arg_8_0._container)

			var_8_3.anchoredPosition = Vector3(var_0_11, 0, 0)

			arg_8_0:setCowAniamtion(var_8_3, var_0_13)
			GetOrAddComponent(findTF(var_8_3, "anim"), typeof(DftAniEvent)):SetEndEvent(function()
				arg_8_0:cowLeave(var_8_3)

				return
			end)
			table.insert(arg_8_0.cows, {
				tf = var_8_3,
				data = Clone(var_0_7[var_8_2])
			})

			return
		end,
		getCowWeightIndex = function(arg_10_0)
			for iter_10_0 = 1, #var_0_8 do
				if arg_10_0.lastTime and arg_10_0.lastTime < var_0_8[iter_10_0][1] then
					return iter_10_0
				end
			end

			return #var_0_8
		end,
		getNextCreateCowTime = function(arg_11_0)
			for iter_11_0 = 1, #var_0_6 do
				if arg_11_0.lastTime < var_0_6[iter_11_0][1] then
					return 0.3 + var_0_6[iter_11_0][2][1] + math.random() * (var_0_6[iter_11_0][2][2] - var_0_6[iter_11_0][2][1])
				end
			end

			return math.random(var_0_6[#var_0_6][2][1], var_0_6[#var_0_6][2][2])
		end,
		setCowAniamtion = function(arg_12_0, arg_12_1, arg_12_2)
			GetComponent(findTF(arg_12_1, "anim"), typeof(Animator)):SetInteger("state", arg_12_2)

			return
		end,
		cowLeave = function(arg_13_0, arg_13_1)
			Destroy(arg_13_1)

			return
		end
	}).ctor({
		ctor = function(arg_2_0)
			arg_2_0._tplCows = arg_1_0
			arg_2_0._container = arg_1_1
			arg_2_0._event = arg_1_2
			arg_2_0.cows = {}
			arg_2_0.cowWeights = {}

			for iter_2_0 = 1, #var_0_8 do
				arg_2_0.cowWeights[iter_2_0] = {}

				local var_2_0 = 0

				for iter_2_1, iter_2_2 in ipairs(var_0_8[iter_2_0][2]) do
					var_2_0 = var_2_0 + iter_2_2

					table.insert(arg_2_0.cowWeights[iter_2_0], var_2_0)
				end
			end

			return
		end,
		start = function(arg_3_0)
			arg_3_0.nextCreateTime = 0
			arg_3_0.lastTime = var_0_5

			arg_3_0:clear()

			return
		end,
		step = function(arg_4_0, arg_4_1)
			arg_4_0.lastTime = arg_4_0.lastTime - Time.deltaTime

			if arg_4_1 > arg_4_0.nextCreateTime then
				arg_4_0.nextCreateTime = arg_4_1 + arg_4_0:getNextCreateCowTime()

				arg_4_0:createCow()
			end

			for iter_4_0 = 1, #arg_4_0.cows do
				arg_4_0.cows[iter_4_0].tf.anchoredPosition.x = arg_4_0.cows[iter_4_0].tf.anchoredPosition.x - arg_4_0.cows[iter_4_0].data.speed * Time.deltaTime

				if arg_4_0.cows[iter_4_0].tf.anchoredPosition.x >= 0 and arg_4_0.cows[iter_4_0].tf.anchoredPosition.x <= 0 then
					arg_4_0:setCowAniamtion(arg_4_0.cows[iter_4_0].tf, var_0_15)
				end

				arg_4_0.cows[iter_4_0].tf.anchoredPosition = arg_4_0.cows[iter_4_0].tf.anchoredPosition
			end

			for iter_4_1 = #arg_4_0.cows, 1, -1 do
				if arg_4_0.cows[iter_4_1].tf.anchoredPosition.x <= -var_0_11 then
					arg_4_0:cowLeave(table.remove(arg_4_0.cows, iter_4_1).tf)
				end
			end

			return
		end,
		captureCow = function(arg_5_0, arg_5_1)
			local var_5_0

			for iter_5_0 = #arg_5_0.cows, 1, -1 do
				if arg_5_0.cows[iter_5_0].tf.anchoredPosition.x >= var_0_9[1] and arg_5_0.cows[iter_5_0].tf.anchoredPosition.x <= var_0_9[2] then
					if not var_5_0 then
						var_5_0 = iter_5_0
					elseif arg_5_0.cows[var_5_0].tf.anchoredPosition.x - arg_5_0.cows[iter_5_0].tf.anchoredPosition.x >= 0 then
						var_5_0 = iter_5_0
					end
				end
			end

			if var_5_0 then
				local var_5_2 = table.remove(arg_5_0.cows, var_5_0)

				arg_5_0:setCowAniamtion(var_5_2.tf, var_0_14)

				if arg_5_1 then
					arg_5_1(true)
				end

				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)
				arg_5_0._event:emit(var_0_16, var_5_2.data.score)
			elseif arg_5_1 then
				arg_5_1(false)
			end

			return
		end,
		clear = function(arg_6_0)
			for iter_6_0 = 1, #arg_6_0.cows do
				Destroy(arg_6_0.cows[iter_6_0].tf)
			end

			arg_6_0.cows = {}

			return
		end,
		destroy = function(arg_7_0)
			arg_7_0:clear()

			return
		end,
		createCow = function(arg_8_0)
			local var_8_0 = arg_8_0.cowWeights[arg_8_0:getCowWeightIndex()]
			local var_8_1 = math.random(0, var_8_0[#var_8_0])
			local var_8_2

			for iter_8_0 = 1, #var_8_0 do
				if var_8_1 < var_8_0[iter_8_0] then
					var_8_2 = iter_8_0

					break
				end
			end

			var_8_2 = var_8_2 or math.random(1, #var_0_7)

			local var_8_3 = tf(Instantiate(arg_8_0._tplCows[var_8_2]))

			SetActive(var_8_3, true)
			SetParent(var_8_3, arg_8_0._container)

			var_8_3.anchoredPosition = Vector3(var_0_11, 0, 0)

			arg_8_0:setCowAniamtion(var_8_3, var_0_13)
			GetOrAddComponent(findTF(var_8_3, "anim"), typeof(DftAniEvent)):SetEndEvent(function()
				arg_8_0:cowLeave(var_8_3)

				return
			end)
			table.insert(arg_8_0.cows, {
				tf = var_8_3,
				data = Clone(var_0_7[var_8_2])
			})

			return
		end,
		getCowWeightIndex = function(arg_10_0)
			for iter_10_0 = 1, #var_0_8 do
				if arg_10_0.lastTime and arg_10_0.lastTime < var_0_8[iter_10_0][1] then
					return iter_10_0
				end
			end

			return #var_0_8
		end,
		getNextCreateCowTime = function(arg_11_0)
			for iter_11_0 = 1, #var_0_6 do
				if arg_11_0.lastTime < var_0_6[iter_11_0][1] then
					return 0.3 + var_0_6[iter_11_0][2][1] + math.random() * (var_0_6[iter_11_0][2][2] - var_0_6[iter_11_0][2][1])
				end
			end

			return math.random(var_0_6[#var_0_6][2][1], var_0_6[#var_0_6][2][2])
		end,
		setCowAniamtion = function(arg_12_0, arg_12_1, arg_12_2)
			GetComponent(findTF(arg_12_1, "anim"), typeof(Animator)):SetInteger("state", arg_12_2)

			return
		end,
		cowLeave = function(arg_13_0, arg_13_1)
			Destroy(arg_13_1)

			return
		end
	})

	return {
		ctor = function(arg_2_0)
			arg_2_0._tplCows = arg_1_0
			arg_2_0._container = arg_1_1
			arg_2_0._event = arg_1_2
			arg_2_0.cows = {}
			arg_2_0.cowWeights = {}

			for iter_2_0 = 1, #var_0_8 do
				arg_2_0.cowWeights[iter_2_0] = {}

				local var_2_0 = 0

				for iter_2_1, iter_2_2 in ipairs(var_0_8[iter_2_0][2]) do
					var_2_0 = var_2_0 + iter_2_2

					table.insert(arg_2_0.cowWeights[iter_2_0], var_2_0)
				end
			end

			return
		end,
		start = function(arg_3_0)
			arg_3_0.nextCreateTime = 0
			arg_3_0.lastTime = var_0_5

			arg_3_0:clear()

			return
		end,
		step = function(arg_4_0, arg_4_1)
			arg_4_0.lastTime = arg_4_0.lastTime - Time.deltaTime

			if arg_4_1 > arg_4_0.nextCreateTime then
				arg_4_0.nextCreateTime = arg_4_1 + arg_4_0:getNextCreateCowTime()

				arg_4_0:createCow()
			end

			for iter_4_0 = 1, #arg_4_0.cows do
				arg_4_0.cows[iter_4_0].tf.anchoredPosition.x = arg_4_0.cows[iter_4_0].tf.anchoredPosition.x - arg_4_0.cows[iter_4_0].data.speed * Time.deltaTime

				if arg_4_0.cows[iter_4_0].tf.anchoredPosition.x >= 0 and arg_4_0.cows[iter_4_0].tf.anchoredPosition.x <= 0 then
					arg_4_0:setCowAniamtion(arg_4_0.cows[iter_4_0].tf, var_0_15)
				end

				arg_4_0.cows[iter_4_0].tf.anchoredPosition = arg_4_0.cows[iter_4_0].tf.anchoredPosition
			end

			for iter_4_1 = #arg_4_0.cows, 1, -1 do
				if arg_4_0.cows[iter_4_1].tf.anchoredPosition.x <= -var_0_11 then
					arg_4_0:cowLeave(table.remove(arg_4_0.cows, iter_4_1).tf)
				end
			end

			return
		end,
		captureCow = function(arg_5_0, arg_5_1)
			local var_5_0

			for iter_5_0 = #arg_5_0.cows, 1, -1 do
				if arg_5_0.cows[iter_5_0].tf.anchoredPosition.x >= var_0_9[1] and arg_5_0.cows[iter_5_0].tf.anchoredPosition.x <= var_0_9[2] then
					if not var_5_0 then
						var_5_0 = iter_5_0
					elseif arg_5_0.cows[var_5_0].tf.anchoredPosition.x - arg_5_0.cows[iter_5_0].tf.anchoredPosition.x >= 0 then
						var_5_0 = iter_5_0
					end
				end
			end

			if var_5_0 then
				local var_5_2 = table.remove(arg_5_0.cows, var_5_0)

				arg_5_0:setCowAniamtion(var_5_2.tf, var_0_14)

				if arg_5_1 then
					arg_5_1(true)
				end

				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)
				arg_5_0._event:emit(var_0_16, var_5_2.data.score)
			elseif arg_5_1 then
				arg_5_1(false)
			end

			return
		end,
		clear = function(arg_6_0)
			for iter_6_0 = 1, #arg_6_0.cows do
				Destroy(arg_6_0.cows[iter_6_0].tf)
			end

			arg_6_0.cows = {}

			return
		end,
		destroy = function(arg_7_0)
			arg_7_0:clear()

			return
		end,
		createCow = function(arg_8_0)
			local var_8_0 = arg_8_0.cowWeights[arg_8_0:getCowWeightIndex()]
			local var_8_1 = math.random(0, var_8_0[#var_8_0])
			local var_8_2

			for iter_8_0 = 1, #var_8_0 do
				if var_8_1 < var_8_0[iter_8_0] then
					var_8_2 = iter_8_0

					break
				end
			end

			var_8_2 = var_8_2 or math.random(1, #var_0_7)

			local var_8_3 = tf(Instantiate(arg_8_0._tplCows[var_8_2]))

			SetActive(var_8_3, true)
			SetParent(var_8_3, arg_8_0._container)

			var_8_3.anchoredPosition = Vector3(var_0_11, 0, 0)

			arg_8_0:setCowAniamtion(var_8_3, var_0_13)
			GetOrAddComponent(findTF(var_8_3, "anim"), typeof(DftAniEvent)):SetEndEvent(function()
				arg_8_0:cowLeave(var_8_3)

				return
			end)
			table.insert(arg_8_0.cows, {
				tf = var_8_3,
				data = Clone(var_0_7[var_8_2])
			})

			return
		end,
		getCowWeightIndex = function(arg_10_0)
			for iter_10_0 = 1, #var_0_8 do
				if arg_10_0.lastTime and arg_10_0.lastTime < var_0_8[iter_10_0][1] then
					return iter_10_0
				end
			end

			return #var_0_8
		end,
		getNextCreateCowTime = function(arg_11_0)
			for iter_11_0 = 1, #var_0_6 do
				if arg_11_0.lastTime < var_0_6[iter_11_0][1] then
					return 0.3 + var_0_6[iter_11_0][2][1] + math.random() * (var_0_6[iter_11_0][2][2] - var_0_6[iter_11_0][2][1])
				end
			end

			return math.random(var_0_6[#var_0_6][2][1], var_0_6[#var_0_6][2][2])
		end,
		setCowAniamtion = function(arg_12_0, arg_12_1, arg_12_2)
			GetComponent(findTF(arg_12_1, "anim"), typeof(Animator)):SetInteger("state", arg_12_2)

			return
		end,
		cowLeave = function(arg_13_0, arg_13_1)
			Destroy(arg_13_1)

			return
		end
	}
end

local function var_0_32(arg_14_0, arg_14_1)
	({
		ctor = function(arg_15_0)
			arg_15_0._playerTf = arg_14_0
			arg_15_0._initPosition = arg_15_0._playerTf.anchoredPosition
			arg_15_0._animator = GetComponent(findTF(arg_15_0._playerTf, "img"), typeof(Animator))

			arg_15_0:setPlayerAnim(var_0_21)

			arg_15_0._event = arg_14_1
			arg_15_0.playerDft = GetOrAddComponent(findTF(arg_15_0._playerTf, "img"), typeof(DftAniEvent))

			arg_15_0.playerDft:SetTriggerEvent(function()
				arg_15_0._event:emit(var_0_25, nil, function(arg_17_0)
					if arg_17_0 then
						arg_15_0:setPlayerAnim(var_0_23)
						arg_15_0._event:emit(var_0_18)
					else
						arg_15_0:setPlayerAnim(var_0_22)
					end

					return
				end)

				return
			end)
			arg_15_0.playerDft:SetEndEvent(function()
				arg_15_0._event:emit(var_0_19)

				return
			end)

			return
		end,
		throw = function(arg_19_0)
			if arg_19_0.captureCdTime then
				return
			end

			arg_19_0.captureCdTime = var_0_10

			arg_19_0:setPlayerAnim(var_0_24)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)

			return
		end,
		setPlayerAnim = function(arg_20_0, arg_20_1)
			arg_20_0._animator:SetTrigger(arg_20_1)

			return
		end,
		start = function(arg_21_0)
			arg_21_0.captureCdTime = 0

			return
		end,
		getThrowTime = function(arg_22_0)
			return arg_22_0.captureCdTime
		end,
		step = function(arg_23_0, arg_23_1)
			if arg_23_0.captureCdTime then
				if arg_23_0.captureCdTime < 0 then
					arg_23_0.captureCdTime = nil

					arg_23_0:setPlayerAnim(var_0_21)
					arg_23_0._event:emit(var_0_20)
				else
					arg_23_0.captureCdTime = arg_23_0.captureCdTime - Time.deltaTime
				end
			end

			return
		end,
		destory = function(arg_24_0)
			return
		end
	}).ctor({
		ctor = function(arg_15_0)
			arg_15_0._playerTf = arg_14_0
			arg_15_0._initPosition = arg_15_0._playerTf.anchoredPosition
			arg_15_0._animator = GetComponent(findTF(arg_15_0._playerTf, "img"), typeof(Animator))

			arg_15_0:setPlayerAnim(var_0_21)

			arg_15_0._event = arg_14_1
			arg_15_0.playerDft = GetOrAddComponent(findTF(arg_15_0._playerTf, "img"), typeof(DftAniEvent))

			arg_15_0.playerDft:SetTriggerEvent(function()
				arg_15_0._event:emit(var_0_25, nil, function(arg_17_0)
					if arg_17_0 then
						arg_15_0:setPlayerAnim(var_0_23)
						arg_15_0._event:emit(var_0_18)
					else
						arg_15_0:setPlayerAnim(var_0_22)
					end

					return
				end)

				return
			end)
			arg_15_0.playerDft:SetEndEvent(function()
				arg_15_0._event:emit(var_0_19)

				return
			end)

			return
		end,
		throw = function(arg_19_0)
			if arg_19_0.captureCdTime then
				return
			end

			arg_19_0.captureCdTime = var_0_10

			arg_19_0:setPlayerAnim(var_0_24)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)

			return
		end,
		setPlayerAnim = function(arg_20_0, arg_20_1)
			arg_20_0._animator:SetTrigger(arg_20_1)

			return
		end,
		start = function(arg_21_0)
			arg_21_0.captureCdTime = 0

			return
		end,
		getThrowTime = function(arg_22_0)
			return arg_22_0.captureCdTime
		end,
		step = function(arg_23_0, arg_23_1)
			if arg_23_0.captureCdTime then
				if arg_23_0.captureCdTime < 0 then
					arg_23_0.captureCdTime = nil

					arg_23_0:setPlayerAnim(var_0_21)
					arg_23_0._event:emit(var_0_20)
				else
					arg_23_0.captureCdTime = arg_23_0.captureCdTime - Time.deltaTime
				end
			end

			return
		end,
		destory = function(arg_24_0)
			return
		end
	})

	return {
		ctor = function(arg_15_0)
			arg_15_0._playerTf = arg_14_0
			arg_15_0._initPosition = arg_15_0._playerTf.anchoredPosition
			arg_15_0._animator = GetComponent(findTF(arg_15_0._playerTf, "img"), typeof(Animator))

			arg_15_0:setPlayerAnim(var_0_21)

			arg_15_0._event = arg_14_1
			arg_15_0.playerDft = GetOrAddComponent(findTF(arg_15_0._playerTf, "img"), typeof(DftAniEvent))

			arg_15_0.playerDft:SetTriggerEvent(function()
				arg_15_0._event:emit(var_0_25, nil, function(arg_17_0)
					if arg_17_0 then
						arg_15_0:setPlayerAnim(var_0_23)
						arg_15_0._event:emit(var_0_18)
					else
						arg_15_0:setPlayerAnim(var_0_22)
					end

					return
				end)

				return
			end)
			arg_15_0.playerDft:SetEndEvent(function()
				arg_15_0._event:emit(var_0_19)

				return
			end)

			return
		end,
		throw = function(arg_19_0)
			if arg_19_0.captureCdTime then
				return
			end

			arg_19_0.captureCdTime = var_0_10

			arg_19_0:setPlayerAnim(var_0_24)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)

			return
		end,
		setPlayerAnim = function(arg_20_0, arg_20_1)
			arg_20_0._animator:SetTrigger(arg_20_1)

			return
		end,
		start = function(arg_21_0)
			arg_21_0.captureCdTime = 0

			return
		end,
		getThrowTime = function(arg_22_0)
			return arg_22_0.captureCdTime
		end,
		step = function(arg_23_0, arg_23_1)
			if arg_23_0.captureCdTime then
				if arg_23_0.captureCdTime < 0 then
					arg_23_0.captureCdTime = nil

					arg_23_0:setPlayerAnim(var_0_21)
					arg_23_0._event:emit(var_0_20)
				else
					arg_23_0.captureCdTime = arg_23_0.captureCdTime - Time.deltaTime
				end
			end

			return
		end,
		destory = function(arg_24_0)
			return
		end
	}
end

local function var_0_33(arg_25_0)
	({
		ctor = function(arg_26_0)
			arg_26_0._backSceneTf = arg_25_0

			if not arg_26_0.sceneItems then
				arg_26_0.sceneItems = {}

				for iter_26_0 = 1, #var_0_28 do
					table.insert(arg_26_0.sceneItems, {
						tf = findTF(arg_26_0._backSceneTf, var_0_28[iter_26_0].name),
						data = var_0_28[iter_26_0]
					})
				end
			end

			return
		end,
		onEventHandle = function(arg_27_0, arg_27_1)
			for iter_27_0 = 1, #arg_27_0.sceneItems do
				if arg_27_0.sceneItems[iter_27_0].data.type == var_0_27 then
					for iter_27_1, iter_27_2 in ipairs(arg_27_0.sceneItems[iter_27_0].data.events) do
						if iter_27_2 == arg_27_1 and arg_27_0.sceneItems[iter_27_0].data.states then
							arg_27_0:changeSceneItemAnim(var_0_29, arg_27_0.sceneItems[iter_27_0].data.states[iter_27_1], arg_27_0.sceneItems[iter_27_0].tf)
						end
					end
				end
			end

			return
		end,
		step = function(arg_28_0, arg_28_1)
			for iter_28_0 = 1, #arg_28_0.sceneItems do
				if arg_28_0.sceneItems[iter_28_0].data.type == var_0_26 then
					if not arg_28_0.sceneItems[iter_28_0].time then
						arg_28_0.sceneItems[iter_28_0].time = math.random(arg_28_0.sceneItems[iter_28_0].data.params[1], arg_28_0.sceneItems[iter_28_0].data.params[2])
					elseif arg_28_0.sceneItems[iter_28_0].time > 0 then
						arg_28_0.sceneItems[iter_28_0].time = arg_28_0.sceneItems[iter_28_0].time - Time.deltaTime
					else
						arg_28_0.sceneItems[iter_28_0].time = math.random(arg_28_0.sceneItems[iter_28_0].data.params[1], arg_28_0.sceneItems[iter_28_0].data.params[2])

						if arg_28_0.sceneItems[iter_28_0].data.states then
							arg_28_0:changeSceneItemAnim(var_0_29, arg_28_0.sceneItems[iter_28_0].data.states[math.random(1, #arg_28_0.sceneItems[iter_28_0].data.states)], arg_28_0.sceneItems[iter_28_0].tf)
						elseif arg_28_0.sceneItems[iter_28_0].data.trigger then
							arg_28_0:changeSceneItemAnim(var_0_30, nil, arg_28_0.sceneItems[iter_28_0].tf)
						end
					end
				end
			end

			return
		end,
		changeSceneItemAnim = function(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
			local var_29_0 = GetComponent(arg_29_3, typeof(Animator))

			if arg_29_1 == var_0_29 then
				var_29_0:SetInteger("state", arg_29_2)
			elseif arg_29_1 == var_0_30 then
				var_29_0:SetTrigger("trigger")
			end

			return
		end
	}).ctor({
		ctor = function(arg_26_0)
			arg_26_0._backSceneTf = arg_25_0

			if not arg_26_0.sceneItems then
				arg_26_0.sceneItems = {}

				for iter_26_0 = 1, #var_0_28 do
					table.insert(arg_26_0.sceneItems, {
						tf = findTF(arg_26_0._backSceneTf, var_0_28[iter_26_0].name),
						data = var_0_28[iter_26_0]
					})
				end
			end

			return
		end,
		onEventHandle = function(arg_27_0, arg_27_1)
			for iter_27_0 = 1, #arg_27_0.sceneItems do
				if arg_27_0.sceneItems[iter_27_0].data.type == var_0_27 then
					for iter_27_1, iter_27_2 in ipairs(arg_27_0.sceneItems[iter_27_0].data.events) do
						if iter_27_2 == arg_27_1 and arg_27_0.sceneItems[iter_27_0].data.states then
							arg_27_0:changeSceneItemAnim(var_0_29, arg_27_0.sceneItems[iter_27_0].data.states[iter_27_1], arg_27_0.sceneItems[iter_27_0].tf)
						end
					end
				end
			end

			return
		end,
		step = function(arg_28_0, arg_28_1)
			for iter_28_0 = 1, #arg_28_0.sceneItems do
				if arg_28_0.sceneItems[iter_28_0].data.type == var_0_26 then
					if not arg_28_0.sceneItems[iter_28_0].time then
						arg_28_0.sceneItems[iter_28_0].time = math.random(arg_28_0.sceneItems[iter_28_0].data.params[1], arg_28_0.sceneItems[iter_28_0].data.params[2])
					elseif arg_28_0.sceneItems[iter_28_0].time > 0 then
						arg_28_0.sceneItems[iter_28_0].time = arg_28_0.sceneItems[iter_28_0].time - Time.deltaTime
					else
						arg_28_0.sceneItems[iter_28_0].time = math.random(arg_28_0.sceneItems[iter_28_0].data.params[1], arg_28_0.sceneItems[iter_28_0].data.params[2])

						if arg_28_0.sceneItems[iter_28_0].data.states then
							arg_28_0:changeSceneItemAnim(var_0_29, arg_28_0.sceneItems[iter_28_0].data.states[math.random(1, #arg_28_0.sceneItems[iter_28_0].data.states)], arg_28_0.sceneItems[iter_28_0].tf)
						elseif arg_28_0.sceneItems[iter_28_0].data.trigger then
							arg_28_0:changeSceneItemAnim(var_0_30, nil, arg_28_0.sceneItems[iter_28_0].tf)
						end
					end
				end
			end

			return
		end,
		changeSceneItemAnim = function(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
			local var_29_0 = GetComponent(arg_29_3, typeof(Animator))

			if arg_29_1 == var_0_29 then
				var_29_0:SetInteger("state", arg_29_2)
			elseif arg_29_1 == var_0_30 then
				var_29_0:SetTrigger("trigger")
			end

			return
		end
	})

	return {
		ctor = function(arg_26_0)
			arg_26_0._backSceneTf = arg_25_0

			if not arg_26_0.sceneItems then
				arg_26_0.sceneItems = {}

				for iter_26_0 = 1, #var_0_28 do
					table.insert(arg_26_0.sceneItems, {
						tf = findTF(arg_26_0._backSceneTf, var_0_28[iter_26_0].name),
						data = var_0_28[iter_26_0]
					})
				end
			end

			return
		end,
		onEventHandle = function(arg_27_0, arg_27_1)
			for iter_27_0 = 1, #arg_27_0.sceneItems do
				if arg_27_0.sceneItems[iter_27_0].data.type == var_0_27 then
					for iter_27_1, iter_27_2 in ipairs(arg_27_0.sceneItems[iter_27_0].data.events) do
						if iter_27_2 == arg_27_1 and arg_27_0.sceneItems[iter_27_0].data.states then
							arg_27_0:changeSceneItemAnim(var_0_29, arg_27_0.sceneItems[iter_27_0].data.states[iter_27_1], arg_27_0.sceneItems[iter_27_0].tf)
						end
					end
				end
			end

			return
		end,
		step = function(arg_28_0, arg_28_1)
			for iter_28_0 = 1, #arg_28_0.sceneItems do
				if arg_28_0.sceneItems[iter_28_0].data.type == var_0_26 then
					if not arg_28_0.sceneItems[iter_28_0].time then
						arg_28_0.sceneItems[iter_28_0].time = math.random(arg_28_0.sceneItems[iter_28_0].data.params[1], arg_28_0.sceneItems[iter_28_0].data.params[2])
					elseif arg_28_0.sceneItems[iter_28_0].time > 0 then
						arg_28_0.sceneItems[iter_28_0].time = arg_28_0.sceneItems[iter_28_0].time - Time.deltaTime
					else
						arg_28_0.sceneItems[iter_28_0].time = math.random(arg_28_0.sceneItems[iter_28_0].data.params[1], arg_28_0.sceneItems[iter_28_0].data.params[2])

						if arg_28_0.sceneItems[iter_28_0].data.states then
							arg_28_0:changeSceneItemAnim(var_0_29, arg_28_0.sceneItems[iter_28_0].data.states[math.random(1, #arg_28_0.sceneItems[iter_28_0].data.states)], arg_28_0.sceneItems[iter_28_0].tf)
						elseif arg_28_0.sceneItems[iter_28_0].data.trigger then
							arg_28_0:changeSceneItemAnim(var_0_30, nil, arg_28_0.sceneItems[iter_28_0].tf)
						end
					end
				end
			end

			return
		end,
		changeSceneItemAnim = function(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
			local var_29_0 = GetComponent(arg_29_3, typeof(Animator))

			if arg_29_1 == var_0_29 then
				var_29_0:SetInteger("state", arg_29_2)
			elseif arg_29_1 == var_0_30 then
				var_29_0:SetTrigger("trigger")
			end

			return
		end
	}
end

function var_0_0.getUIName(arg_30_0)
	return "RopingCowGameUI"
end

function var_0_0.getBGM(arg_31_0)
	return var_0_1
end

function var_0_0.didEnter(arg_32_0)
	arg_32_0:initEvent()
	arg_32_0:initData()
	arg_32_0:initUI()
	arg_32_0:initGameUI()
	arg_32_0:updateMenuUI()
	arg_32_0:openMenuUI()

	return
end

function var_0_0.initEvent(arg_33_0)
	arg_33_0:bind(var_0_16, function(arg_34_0, arg_34_1, arg_34_2)
		arg_33_0:addScore(arg_34_1)
		arg_33_0:onEventHandle(var_0_16)

		return
	end)
	arg_33_0:bind(var_0_25, function(arg_35_0, arg_35_1, arg_35_2)
		if arg_33_0._cowController then
			arg_33_0._cowController:captureCow(arg_35_2)
		end

		arg_33_0:onEventHandle(var_0_25)

		return
	end)
	arg_33_0:bind(var_0_18, function(arg_36_0, arg_36_1, arg_36_2)
		arg_33_0:onEventHandle(var_0_18)

		return
	end)
	arg_33_0:bind(var_0_19, function(arg_37_0, arg_37_1, arg_37_2)
		arg_33_0:onEventHandle(var_0_19)

		return
	end)
	arg_33_0:bind(var_0_20, function(arg_38_0, arg_38_1, arg_38_2)
		arg_33_0:onEventHandle(var_0_20)

		return
	end)

	return
end

function var_0_0.onEventHandle(arg_39_0, arg_39_1)
	if arg_39_0._sceneItemController then
		arg_39_0._sceneItemController:onEventHandle(arg_39_1)
	end

	return
end

function var_0_0.initData(arg_40_0)
	arg_40_0.storylist = pg.mini_game[arg_40_0:GetMGData().id].simple_config_data.story

	local var_40_0 = pg.mini_game[arg_40_0:GetMGData().id].simple_config_data.stroy_act

	arg_40_0.storyFinal = pg.activity_template[var_40_0].config_client.story
	arg_40_0.storyBefore = pg.activity_template[var_40_0].config_client.beforestory

	local var_40_1 = Application.targetFrameRate or 60

	if var_40_1 > 60 then
		var_40_1 = 60
	end

	arg_40_0.timer = Timer.New(function()
		arg_40_0:onTimer()

		return
	end, 1 / var_40_1, -1)

	return
end

function var_0_0.initUI(arg_42_0)
	arg_42_0.backSceneTf = findTF(arg_42_0._tf, "scene_background")
	arg_42_0.sceneTf = findTF(arg_42_0._tf, "scene")
	arg_42_0.clickMask = findTF(arg_42_0._tf, "clickMask")
	arg_42_0.countUI = findTF(arg_42_0._tf, "pop/CountUI")
	arg_42_0.countAnimator = GetComponent(findTF(arg_42_0.countUI, "count"), typeof(Animator))
	arg_42_0.countDft = GetOrAddComponent(findTF(arg_42_0.countUI, "count"), typeof(DftAniEvent))

	arg_42_0.countDft:SetTriggerEvent(function()
		return
	end)
	arg_42_0.countDft:SetEndEvent(function()
		setActive(arg_42_0.countUI, false)
		arg_42_0:gameStart()

		return
	end)

	arg_42_0.leaveUI = findTF(arg_42_0._tf, "pop/LeaveUI")

	onButton(arg_42_0, findTF(arg_42_0.leaveUI, "ad/btnOk"), function()
		arg_42_0:resumeGame()
		arg_42_0:onGameOver()

		return
	end, SFX_CANCEL)
	onButton(arg_42_0, findTF(arg_42_0.leaveUI, "ad/btnCancel"), function()
		arg_42_0:resumeGame()

		return
	end, SFX_CANCEL)

	arg_42_0.pauseUI = findTF(arg_42_0._tf, "pop/pauseUI")

	onButton(arg_42_0, findTF(arg_42_0.pauseUI, "ad/btnOk"), function()
		setActive(arg_42_0.pauseUI, false)
		arg_42_0:resumeGame()

		return
	end, SFX_CANCEL)

	arg_42_0.settlementUI = findTF(arg_42_0._tf, "pop/SettleMentUI")

	onButton(arg_42_0, findTF(arg_42_0.settlementUI, "ad/btnOver"), function()
		setActive(arg_42_0.settlementUI, false)
		arg_42_0:openMenuUI()

		return
	end, SFX_CANCEL)

	arg_42_0.menuUI = findTF(arg_42_0._tf, "pop/menuUI")
	arg_42_0.battleScrollRect = GetComponent(findTF(arg_42_0.menuUI, "battList"), typeof(ScrollRect))
	arg_42_0.totalTimes = arg_42_0:getGameTotalTime()

	scrollTo(arg_42_0.battleScrollRect, 0, 1 - (arg_42_0:getGameUsedTimes() - 4 < 0 and 0 or arg_42_0:getGameUsedTimes() - 4) / (arg_42_0.totalTimes - 4))
	onButton(arg_42_0, findTF(arg_42_0.menuUI, "rightPanelBg/arrowUp"), function()
		local var_49_0 = arg_42_0.battleScrollRect.normalizedPosition.y + 1 / (arg_42_0.totalTimes - 4)

		if arg_42_0.battleScrollRect.normalizedPosition.y + 1 / (arg_42_0.totalTimes - 4) > 1 then
			var_49_0 = 1
		end

		scrollTo(arg_42_0.battleScrollRect, 0, var_49_0)

		return
	end, SFX_CANCEL)
	onButton(arg_42_0, findTF(arg_42_0.menuUI, "rightPanelBg/arrowDown"), function()
		local var_50_0 = arg_42_0.battleScrollRect.normalizedPosition.y - 1 / (arg_42_0.totalTimes - 4)

		if arg_42_0.battleScrollRect.normalizedPosition.y - 1 / (arg_42_0.totalTimes - 4) < 0 then
			var_50_0 = 0
		end

		scrollTo(arg_42_0.battleScrollRect, 0, var_50_0)

		return
	end, SFX_CANCEL)
	onButton(arg_42_0, findTF(arg_42_0.menuUI, "btnBack"), function()
		arg_42_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_42_0, findTF(arg_42_0.menuUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.cowboy_tips.tip
		})

		return
	end, SFX_CANCEL)
	onButton(arg_42_0, findTF(arg_42_0.menuUI, "btnStart"), function()
		if arg_42_0:getGameTimes() > 0 then
			arg_42_0:checkOverflow(pg.mini_game[arg_42_0:GetMGData().id].simple_config_data.drop[arg_42_0:getGameUsedTimes() + 1], function()
				setActive(arg_42_0.menuUI, false)
				arg_42_0:readyStart()

				return
			end)
		else
			setActive(arg_42_0.menuUI, false)
			arg_42_0:readyStart()
		end

		return
	end, SFX_CANCEL)

	local var_42_0 = findTF(arg_42_0.menuUI, "tplBattleItem")

	arg_42_0.battleItems = {}
	arg_42_0.dropItems = {}

	local var_42_1 = pg.mini_game[arg_42_0:GetMGData().id].simple_config_data.drop

	for iter_42_0 = 1, #var_42_1 do
		local var_42_2 = tf(instantiate(var_42_0))

		var_42_2.name = "battleItem_" .. iter_42_0

		setParent(var_42_2, findTF(arg_42_0.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync("ui/minigameui/ropingcowgameui_atlas", "battleDesc" .. iter_42_0, function(arg_55_0)
			setImageSprite(findTF(var_42_2, "state_open/buttomDesc"), arg_55_0, true)
			setImageSprite(findTF(var_42_2, "state_clear/buttomDesc"), arg_55_0, true)
			setImageSprite(findTF(var_42_2, "state_current/buttomDesc"), arg_55_0, true)
			setImageSprite(findTF(var_42_2, "state_closed/buttomDesc"), arg_55_0, true)

			return
		end)

		local var_42_3 = findTF(var_42_2, "icon")

		updateDrop(var_42_3, {
			type = var_42_1[iter_42_0][1],
			id = var_42_1[iter_42_0][2],
			count = var_42_1[iter_42_0][3]
		})
		onButton(arg_42_0, var_42_3, function()
			arg_42_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
		table.insert(arg_42_0.dropItems, var_42_3)
		setActive(var_42_2, true)
		table.insert(arg_42_0.battleItems, var_42_2)
	end

	arg_42_0.handle = arg_42_0.handle or UpdateBeat:CreateListener(arg_42_0.Update, arg_42_0)

	UpdateBeat:AddListener(arg_42_0.handle)

	return
end

function var_0_0.initGameUI(arg_57_0)
	arg_57_0.gameUI = findTF(arg_57_0._tf, "ui/gameUI")

	onButton(arg_57_0, findTF(arg_57_0.gameUI, "topRight/btnStop"), function()
		arg_57_0:stopGame()
		setActive(arg_57_0.pauseUI, true)

		return
	end)
	onButton(arg_57_0, findTF(arg_57_0.gameUI, "btnLeave"), function()
		arg_57_0:stopGame()
		setActive(arg_57_0.leaveUI, true)

		return
	end)

	arg_57_0.gameTimeS = findTF(arg_57_0.gameUI, "top/time/s")
	arg_57_0.scoreTf = findTF(arg_57_0.gameUI, "top/score")
	arg_57_0.btnCapture = findTF(arg_57_0.gameUI, "btnCapture")
	arg_57_0.captureButton = GetOrAddComponent(arg_57_0.btnCapture, "EventTriggerListener")

	arg_57_0.captureButton:AddPointDownFunc(function(arg_60_0, arg_60_1)
		if arg_57_0._playerController then
			arg_57_0._playerController:throw()
		end

		return
	end)

	for iter_57_0 = 1, var_0_12 do
		table.insert({}, (findTF(arg_57_0.sceneTf, "cow" .. iter_57_0)))
	end

	arg_57_0.sceneScoreTf = findTF(arg_57_0.sceneTf, "score")
	arg_57_0._playerController = var_0_32(findTF(arg_57_0.sceneTf, "player"), arg_57_0)
	arg_57_0._cowController = var_0_31({}, findTF(arg_57_0.sceneTf, "cowContainer"), arg_57_0)
	arg_57_0._sceneItemController = var_0_33(arg_57_0.backSceneTf)

	return
end

function var_0_0.Update(arg_61_0)
	arg_61_0:AddDebugInput()

	return
end

function var_0_0.AddDebugInput(arg_62_0)
	if arg_62_0.gameStop or arg_62_0.settlementFlag then
		return
	end

	if IsUnityEditor and Input.GetKeyDown(KeyCode.S) and arg_62_0._playerController then
		arg_62_0._playerController:throw()
	end

	return
end

function var_0_0.updateMenuUI(arg_63_0)
	local var_63_0 = arg_63_0:getGameUsedTimes()
	local var_63_1 = arg_63_0:getGameTimes()

	for iter_63_0 = 1, #arg_63_0.battleItems do
		setActive(findTF(arg_63_0.battleItems[iter_63_0], "state_open"), false)
		setActive(findTF(arg_63_0.battleItems[iter_63_0], "state_closed"), false)
		setActive(findTF(arg_63_0.battleItems[iter_63_0], "state_clear"), false)
		setActive(findTF(arg_63_0.battleItems[iter_63_0], "state_current"), false)

		if iter_63_0 <= var_63_0 then
			SetParent(arg_63_0.dropItems[iter_63_0], findTF(arg_63_0.battleItems[iter_63_0], "state_clear/icon"))
			setActive(arg_63_0.dropItems[iter_63_0], true)
			setActive(findTF(arg_63_0.battleItems[iter_63_0], "state_clear"), true)
		elseif iter_63_0 == var_63_0 + 1 and var_63_1 >= 1 then
			setActive(findTF(arg_63_0.battleItems[iter_63_0], "state_current"), true)
			SetParent(arg_63_0.dropItems[iter_63_0], findTF(arg_63_0.battleItems[iter_63_0], "state_current/icon"))
			setActive(arg_63_0.dropItems[iter_63_0], true)
		elseif var_63_0 < iter_63_0 and iter_63_0 <= var_63_0 + var_63_1 then
			setActive(findTF(arg_63_0.battleItems[iter_63_0], "state_open"), true)
			SetParent(arg_63_0.dropItems[iter_63_0], findTF(arg_63_0.battleItems[iter_63_0], "state_open/icon"))
			setActive(arg_63_0.dropItems[iter_63_0], true)
		else
			setActive(findTF(arg_63_0.battleItems[iter_63_0], "state_closed"), true)
			setActive(arg_63_0.dropItems[iter_63_0], false)
		end
	end

	arg_63_0.totalTimes = arg_63_0:getGameTotalTime()

	local var_63_2 = 1 - (arg_63_0:getGameUsedTimes() - 3 < 0 and 0 or arg_63_0:getGameUsedTimes() - 3) / (arg_63_0.totalTimes - 4)

	if var_63_2 > 1 then
		var_63_2 = 1
	end

	scrollTo(arg_63_0.battleScrollRect, 0, var_63_2)
	setActive(findTF(arg_63_0.menuUI, "btnStart/tip"), var_63_1 > 0)
	arg_63_0:CheckGet()

	return
end

function var_0_0.CheckGet(arg_64_0)
	setActive(findTF(arg_64_0.menuUI, "got"), false)

	if arg_64_0:getUltimate() and arg_64_0:getUltimate() ~= 0 then
		setActive(findTF(arg_64_0.menuUI, "got"), true)
	end

	if arg_64_0:getUltimate() == 0 then
		if arg_64_0:getGameTotalTime() > arg_64_0:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_64_0:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(arg_64_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.openMenuUI(arg_65_0)
	setActive(findTF(arg_65_0._tf, "scene_front"), false)
	setActive(findTF(arg_65_0._tf, "scene_background"), false)
	setActive(findTF(arg_65_0._tf, "scene"), false)
	setActive(arg_65_0.gameUI, false)
	setActive(arg_65_0.menuUI, true)
	arg_65_0:updateMenuUI()

	return
end

function var_0_0.clearUI(arg_66_0)
	setActive(arg_66_0.sceneTf, false)
	setActive(arg_66_0.settlementUI, false)
	setActive(arg_66_0.countUI, false)
	setActive(arg_66_0.menuUI, false)
	setActive(arg_66_0.gameUI, false)

	return
end

function var_0_0.readyStart(arg_67_0)
	setActive(arg_67_0.countUI, true)
	arg_67_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)

	return
end

function var_0_0.gameStart(arg_68_0)
	setActive(findTF(arg_68_0._tf, "scene_front"), true)
	setActive(findTF(arg_68_0._tf, "scene_background"), true)
	setActive(findTF(arg_68_0._tf, "scene"), true)
	setActive(arg_68_0.gameUI, true)

	arg_68_0.gameStartFlag = true
	arg_68_0.scoreNum = 0
	arg_68_0.playerPosIndex = 2
	arg_68_0.gameStepTime = 0
	arg_68_0.heart = 3
	arg_68_0.gameTime = var_0_5

	if arg_68_0._cowController then
		arg_68_0._cowController:start()
	end

	if arg_68_0._playerController then
		arg_68_0._playerController:start()
	end

	arg_68_0:updateGameUI()
	arg_68_0:timerStart()

	return
end

function var_0_0.getGameTimes(arg_69_0)
	return arg_69_0:GetMGHubData().count
end

function var_0_0.getGameUsedTimes(arg_70_0)
	return arg_70_0:GetMGHubData().usedtime
end

function var_0_0.getUltimate(arg_71_0)
	return arg_71_0:GetMGHubData().ultimate
end

function var_0_0.getGameTotalTime(arg_72_0)
	return (arg_72_0:GetMGHubData():getConfig("reward_need"))
end

function var_0_0.changeSpeed(arg_73_0, arg_73_1)
	return
end

function var_0_0.onTimer(arg_74_0)
	arg_74_0:gameStep()

	return
end

function var_0_0.gameStep(arg_75_0)
	arg_75_0.gameTime = arg_75_0.gameTime - Time.deltaTime

	if arg_75_0.gameTime < 0 then
		arg_75_0.gameTime = 0
	end

	arg_75_0.gameStepTime = arg_75_0.gameStepTime + Time.deltaTime

	if arg_75_0._cowController then
		arg_75_0._cowController:step(arg_75_0.gameStepTime)
	end

	if arg_75_0._playerController then
		arg_75_0._playerController:step(arg_75_0.gameStepTime)
	end

	if arg_75_0._sceneItemController then
		arg_75_0._sceneItemController:step(arg_75_0.gameStepTime)
	end

	arg_75_0:updateGameUI()

	if arg_75_0.gameTime <= 0 then
		arg_75_0:onGameOver()

		return
	end

	return
end

function var_0_0.timerStart(arg_76_0)
	if not arg_76_0.timer.running then
		arg_76_0.timer:Start()
	end

	return
end

function var_0_0.timerStop(arg_77_0)
	if arg_77_0.timer.running then
		arg_77_0.timer:Stop()
	end

	return
end

function var_0_0.updateGameUI(arg_78_0)
	setText(arg_78_0.scoreTf, arg_78_0.scoreNum)
	setText(arg_78_0.gameTimeS, math.ceil(arg_78_0.gameTime))

	arg_78_0.captureCdMaskImg = arg_78_0.captureCdMaskImg or GetComponent(findTF(arg_78_0.btnCapture, "cd"), typeof(Image))

	if arg_78_0._playerController then
		local var_78_0 = arg_78_0._playerController:getThrowTime()

		arg_78_0.captureCdMaskImg.fillAmount = var_78_0 and var_78_0 > 0 and var_78_0 / var_0_10 or 0
	end

	return
end

function var_0_0.addScore(arg_79_0, arg_79_1)
	arg_79_0.scoreNum = arg_79_0.scoreNum + arg_79_1

	if arg_79_0.scoreNum < 0 then
		arg_79_0.scoreNum = 0
	end

	setActive(arg_79_0.sceneScoreTf, false)

	for iter_79_0 = 0, arg_79_0.sceneScoreTf.childCount - 1 do
		local var_79_0 = arg_79_0.sceneScoreTf:GetChild(iter_79_0)

		if var_79_0.name == tostring(arg_79_1) then
			setActive(var_79_0, true)
		else
			setActive(var_79_0, false)
		end
	end

	setActive(arg_79_0.sceneScoreTf, true)

	return
end

function var_0_0.onGameOver(arg_80_0)
	if arg_80_0.settlementFlag then
		return
	end

	arg_80_0:timerStop()

	arg_80_0.settlementFlag = true

	setActive(arg_80_0.sceneScoreTf, false)
	setActive(arg_80_0.clickMask, true)

	if arg_80_0._cowController then
		arg_80_0._cowController:clear()
	end

	LeanTween.delayedCall(go(arg_80_0._tf), 0.1, System.Action(function()
		arg_80_0.settlementFlag = false
		arg_80_0.gameStartFlag = false

		setActive(arg_80_0.clickMask, false)
		arg_80_0:showSettlement()

		return
	end))

	return
end

function var_0_0.showSettlement(arg_82_0)
	setActive(arg_82_0.settlementUI, true)
	GetComponent(findTF(arg_82_0.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_82_0 = arg_82_0:GetMGData():GetRuntimeData("elements")
	local var_82_1 = arg_82_0.scoreNum

	if var_82_0 and #var_82_0 > 0 then
		local var_82_2 = var_82_0[1] or 0

		setActive(findTF(arg_82_0.settlementUI, "ad/new"), var_82_2 < var_82_1)

		if var_82_2 <= var_82_1 then
			var_82_2 = var_82_1

			arg_82_0:StoreDataToServer({
				var_82_1
			})
		end

		setText(findTF(arg_82_0.settlementUI, "ad/highText"), var_82_2)
		setText(findTF(arg_82_0.settlementUI, "ad/currentText"), var_82_1)

		if arg_82_0:getGameTimes() and arg_82_0:getGameTimes() > 0 then
			local var_82_3 = arg_82_0:getGameUsedTimes() + 1
			local var_82_4 = pg.NewStoryMgr.GetInstance()

			if arg_82_0.storylist[var_82_3] then
				local var_82_5 = arg_82_0.storylist[var_82_3][1] or nil

				if var_82_5 and not var_82_4:IsPlayed(var_82_5) then
					arg_82_0.sendSuccessFlag = true

					var_82_4:Play(var_82_5, function()
						local var_83_0 = true

						if not var_82_4:IsPlayed(arg_82_0.storyFinal[1][1]) then
							for iter_83_0, iter_83_1 in ipairs(arg_82_0.storyBefore) do
								if not var_82_4:IsPlayed(iter_83_1[1]) then
									var_83_0 = false
								end
							end
						else
							var_83_0 = false
						end

						if var_83_0 then
							var_82_4:Play(arg_82_0.storyFinal[1][1], function()
								arg_82_0:SendSuccess(0)

								return
							end)
						else
							arg_82_0:SendSuccess(0)
						end

						return
					end)
				else
					arg_82_0.sendSuccessFlag = true

					arg_82_0:SendSuccess(0)
				end

				return
			end
		end
	end
end

function var_0_0.resumeGame(arg_85_0)
	arg_85_0.gameStop = false

	setActive(arg_85_0.leaveUI, false)
	arg_85_0:changeSpeed(1)
	arg_85_0:timerStart()

	return
end

function var_0_0.stopGame(arg_86_0)
	arg_86_0.gameStop = true

	arg_86_0:timerStop()
	arg_86_0:changeSpeed(0)

	return
end

function var_0_0.checkOverflow(arg_87_0, arg_87_1, arg_87_2)
	local var_87_0 = getProxy(PlayerProxy):getRawData()
	local var_87_1 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
	local var_87_2, var_87_3 = Task.StaticJudgeOverflow(var_87_0.gold, var_87_0.oil, var_87_1, true, true, {
		arg_87_1
	})

	if var_87_2 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_ITEM_BOX,
			content = i18n("award_max_warning_minigame"),
			items = var_87_3,
			onYes = arg_87_2
		})
	else
		arg_87_2()
	end

	return
end

function var_0_0.onBackPressed(arg_88_0)
	if not arg_88_0.gameStartFlag then
		arg_88_0:emit(var_0_0.ON_BACK_PRESSED)
	else
		if arg_88_0.settlementFlag then
			return
		end

		if isActive(arg_88_0.pauseUI) then
			setActive(arg_88_0.pauseUI, false)
		end

		arg_88_0:stopGame()
		setActive(arg_88_0.leaveUI, true)
	end

	return
end

function var_0_0.willExit(arg_89_0)
	if arg_89_0.handle then
		UpdateBeat:RemoveListener(arg_89_0.handle)
	end

	if arg_89_0._tf and LeanTween.isTweening(go(arg_89_0._tf)) then
		LeanTween.cancel(go(arg_89_0._tf))
	end

	if arg_89_0.timer and arg_89_0.timer.running then
		arg_89_0.timer:Stop()
	end

	Time.timeScale = 1
	arg_89_0.timer = nil

	return
end

return var_0_0
