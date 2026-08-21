local var_0_0 = class("EatFoodGameView", import("..BaseMiniGameView"))
local var_0_1 = "xinnong-1"
local var_0_2 = "event:/ui/ddldaoshu2"
local var_0_3 = "event:/ui/zhengque"
local var_0_4 = "event:/ui/shibai2"
local var_0_5 = "event:/ui/deshou"
local var_0_6 = "event:/ui/shibai"
local var_0_7 = 60
local var_0_10 = 2.5
local var_0_11 = 3.75
local var_0_12 = {
	0,
	600
}
local var_0_13 = {
	150,
	150,
	150,
	140,
	140,
	140,
	130,
	130,
	130,
	120,
	120,
	120,
	110,
	110,
	100
}
local var_0_14 = {
	8,
	8,
	9,
	9,
	10,
	10,
	11,
	11,
	12,
	12,
	13,
	13,
	14,
	15,
	16,
	17,
	18,
	20
}
local var_0_15 = 400
local var_0_16 = 1
local var_0_17 = "event touch"
local var_0_18 = {
	15,
	25,
	40,
	75
}
local var_0_19 = {
	500,
	300,
	150,
	50
}
local var_0_20 = {
	-400,
	-300,
	-200,
	-100
}
local var_0_21 = {
	20,
	40,
	60,
	100
}
local var_0_22 = 0.8
local var_0_23 = 0.05
local var_0_24 = 1.4
local var_0_25 = {
	{
		id = 1,
		next_time = {
			3.5,
			4
		}
	},
	{
		id = 2,
		next_time = {
			3.5,
			4
		}
	},
	{
		id = 4,
		next_time = {
			3.5,
			4
		}
	}
}
local var_0_26 = 2
local var_0_27 = {
	1,
	3
}
local var_0_28 = 15
local var_0_29 = {
	3,
	6,
	9,
	11,
	13,
	15
}
local var_0_30 = 10
local var_0_31 = {
	{
		id = 3
	}
}
local var_0_32 = "event game over"

local function var_0_33(arg_1_0, arg_1_1)
	({
		ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._event = arg_1_1

			setActive(arg_2_0._tf, false)

			arg_2_0.sliderTouch = findTF(arg_2_0._tf, "touch")

			setActive(arg_2_0.sliderTouch, true)

			arg_2_0.sliderRange = findTF(arg_2_0._tf, "range")
			arg_2_0.sliderRange.anchoredPosition = Vector2(var_0_15, 0)

			return
		end,
		start = function(arg_3_0)
			arg_3_0.sliderIndex = 1
			arg_3_0.nextSliderTime = var_0_11
			arg_3_0.sliderTouchPos = Vector2(var_0_12[1], 0)

			arg_3_0:setSliderBarVisible(false)

			return
		end,
		step = function(arg_4_0)
			if arg_4_0.nextSliderTime then
				arg_4_0.nextSliderTime = arg_4_0.nextSliderTime - Time.deltaTime

				if arg_4_0.nextSliderTime <= 0 then
					arg_4_0:setSliderBarVisible(true)
					arg_4_0:startSliderBar()

					arg_4_0.nextSliderTime = arg_4_0.nextSliderTime + var_0_10
				end
			end

			if arg_4_0.sliderBeginning then
				arg_4_0.sliderTouchPos.x = arg_4_0.sliderTouchPos.x + arg_4_0.speed
				arg_4_0.sliderTouch.anchoredPosition = arg_4_0.sliderTouchPos

				if arg_4_0.sliderTouchPos.x > var_0_12[2] then
					arg_4_0:touch(false)
				end
			end

			return
		end,
		setSliderBarVisible = function(arg_5_0, arg_5_1)
			setActive(arg_5_0._tf, arg_5_1)

			return
		end,
		startSliderBar = function(arg_6_0)
			if arg_6_0.sliderIndex > #var_0_13 then
				arg_6_0.sliderIndex = 1
			end

			arg_6_0.sliderWidth = var_0_13[arg_6_0.sliderIndex]
			arg_6_0.speed = var_0_14[arg_6_0.sliderIndex]
			arg_6_0.sliderTouchPos.x = var_0_12[1]
			arg_6_0.sliderBeginning = true
			arg_6_0.sliderRange.sizeDelta = Vector2(arg_6_0.sliderWidth, arg_6_0.sliderRange.sizeDelta.y)

			return
		end,
		touch = function(arg_7_0, arg_7_1)
			if not arg_7_0.sliderBeginning then
				return
			end

			arg_7_0.sliderBeginning = false

			arg_7_0:setSliderBarVisible(false)

			local var_7_1 = 0
			local var_7_2 = math.abs(arg_7_0.sliderTouchPos.x - var_0_15)
			local var_7_3

			if var_7_2 < arg_7_0.sliderWidth / 2 then
				var_7_1 = arg_7_0:getScore(var_7_2)
				arg_7_0.sliderIndex = arg_7_0.sliderIndex + 1
				var_7_3 = true
			else
				if arg_7_0.sliderTouchPos.x < 100 or arg_7_0.sliderTouchPos.x > var_0_12[2] - 100 then
					var_7_1 = arg_7_0:getSubScore(arg_7_0.sliderTouchPos.x)
				end

				arg_7_0.nextSliderTime = arg_7_0.nextSliderTime + var_0_16
				var_7_3 = false
			end

			if var_7_3 then
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_5)
			else
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_6)
			end

			if arg_7_1 then
				arg_7_0._event:emit(var_0_17, {
					flag = var_7_3,
					score = var_7_1
				}, function()
					return
				end)
			end

			return
		end,
		getSubScore = function(arg_9_0, arg_9_1)
			local var_9_0 = arg_9_1 <= 100 and arg_9_1 or var_0_12[2] - arg_9_1

			for iter_9_0 = 1, #var_0_21 do
				if var_9_0 < var_0_21[iter_9_0] then
					return var_0_20[iter_9_0]
				end
			end

			return 0
		end,
		getScore = function(arg_10_0, arg_10_1)
			for iter_10_0 = 1, #var_0_18 do
				if arg_10_1 < var_0_18[iter_10_0] then
					return var_0_19[iter_10_0]
				end
			end

			return 0
		end,
		destroy = function(arg_11_0)
			return
		end
	}).ctor({
		ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._event = arg_1_1

			setActive(arg_2_0._tf, false)

			arg_2_0.sliderTouch = findTF(arg_2_0._tf, "touch")

			setActive(arg_2_0.sliderTouch, true)

			arg_2_0.sliderRange = findTF(arg_2_0._tf, "range")
			arg_2_0.sliderRange.anchoredPosition = Vector2(var_0_15, 0)

			return
		end,
		start = function(arg_3_0)
			arg_3_0.sliderIndex = 1
			arg_3_0.nextSliderTime = var_0_11
			arg_3_0.sliderTouchPos = Vector2(var_0_12[1], 0)

			arg_3_0:setSliderBarVisible(false)

			return
		end,
		step = function(arg_4_0)
			if arg_4_0.nextSliderTime then
				arg_4_0.nextSliderTime = arg_4_0.nextSliderTime - Time.deltaTime

				if arg_4_0.nextSliderTime <= 0 then
					arg_4_0:setSliderBarVisible(true)
					arg_4_0:startSliderBar()

					arg_4_0.nextSliderTime = arg_4_0.nextSliderTime + var_0_10
				end
			end

			if arg_4_0.sliderBeginning then
				arg_4_0.sliderTouchPos.x = arg_4_0.sliderTouchPos.x + arg_4_0.speed
				arg_4_0.sliderTouch.anchoredPosition = arg_4_0.sliderTouchPos

				if arg_4_0.sliderTouchPos.x > var_0_12[2] then
					arg_4_0:touch(false)
				end
			end

			return
		end,
		setSliderBarVisible = function(arg_5_0, arg_5_1)
			setActive(arg_5_0._tf, arg_5_1)

			return
		end,
		startSliderBar = function(arg_6_0)
			if arg_6_0.sliderIndex > #var_0_13 then
				arg_6_0.sliderIndex = 1
			end

			arg_6_0.sliderWidth = var_0_13[arg_6_0.sliderIndex]
			arg_6_0.speed = var_0_14[arg_6_0.sliderIndex]
			arg_6_0.sliderTouchPos.x = var_0_12[1]
			arg_6_0.sliderBeginning = true
			arg_6_0.sliderRange.sizeDelta = Vector2(arg_6_0.sliderWidth, arg_6_0.sliderRange.sizeDelta.y)

			return
		end,
		touch = function(arg_7_0, arg_7_1)
			if not arg_7_0.sliderBeginning then
				return
			end

			arg_7_0.sliderBeginning = false

			arg_7_0:setSliderBarVisible(false)

			local var_7_1 = 0
			local var_7_2 = math.abs(arg_7_0.sliderTouchPos.x - var_0_15)
			local var_7_3

			if var_7_2 < arg_7_0.sliderWidth / 2 then
				var_7_1 = arg_7_0:getScore(var_7_2)
				arg_7_0.sliderIndex = arg_7_0.sliderIndex + 1
				var_7_3 = true
			else
				if arg_7_0.sliderTouchPos.x < 100 or arg_7_0.sliderTouchPos.x > var_0_12[2] - 100 then
					var_7_1 = arg_7_0:getSubScore(arg_7_0.sliderTouchPos.x)
				end

				arg_7_0.nextSliderTime = arg_7_0.nextSliderTime + var_0_16
				var_7_3 = false
			end

			if var_7_3 then
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_5)
			else
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_6)
			end

			if arg_7_1 then
				arg_7_0._event:emit(var_0_17, {
					flag = var_7_3,
					score = var_7_1
				}, function()
					return
				end)
			end

			return
		end,
		getSubScore = function(arg_9_0, arg_9_1)
			local var_9_0 = arg_9_1 <= 100 and arg_9_1 or var_0_12[2] - arg_9_1

			for iter_9_0 = 1, #var_0_21 do
				if var_9_0 < var_0_21[iter_9_0] then
					return var_0_20[iter_9_0]
				end
			end

			return 0
		end,
		getScore = function(arg_10_0, arg_10_1)
			for iter_10_0 = 1, #var_0_18 do
				if arg_10_1 < var_0_18[iter_10_0] then
					return var_0_19[iter_10_0]
				end
			end

			return 0
		end,
		destroy = function(arg_11_0)
			return
		end
	})

	return {
		ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._event = arg_1_1

			setActive(arg_2_0._tf, false)

			arg_2_0.sliderTouch = findTF(arg_2_0._tf, "touch")

			setActive(arg_2_0.sliderTouch, true)

			arg_2_0.sliderRange = findTF(arg_2_0._tf, "range")
			arg_2_0.sliderRange.anchoredPosition = Vector2(var_0_15, 0)

			return
		end,
		start = function(arg_3_0)
			arg_3_0.sliderIndex = 1
			arg_3_0.nextSliderTime = var_0_11
			arg_3_0.sliderTouchPos = Vector2(var_0_12[1], 0)

			arg_3_0:setSliderBarVisible(false)

			return
		end,
		step = function(arg_4_0)
			if arg_4_0.nextSliderTime then
				arg_4_0.nextSliderTime = arg_4_0.nextSliderTime - Time.deltaTime

				if arg_4_0.nextSliderTime <= 0 then
					arg_4_0:setSliderBarVisible(true)
					arg_4_0:startSliderBar()

					arg_4_0.nextSliderTime = arg_4_0.nextSliderTime + var_0_10
				end
			end

			if arg_4_0.sliderBeginning then
				arg_4_0.sliderTouchPos.x = arg_4_0.sliderTouchPos.x + arg_4_0.speed
				arg_4_0.sliderTouch.anchoredPosition = arg_4_0.sliderTouchPos

				if arg_4_0.sliderTouchPos.x > var_0_12[2] then
					arg_4_0:touch(false)
				end
			end

			return
		end,
		setSliderBarVisible = function(arg_5_0, arg_5_1)
			setActive(arg_5_0._tf, arg_5_1)

			return
		end,
		startSliderBar = function(arg_6_0)
			if arg_6_0.sliderIndex > #var_0_13 then
				arg_6_0.sliderIndex = 1
			end

			arg_6_0.sliderWidth = var_0_13[arg_6_0.sliderIndex]
			arg_6_0.speed = var_0_14[arg_6_0.sliderIndex]
			arg_6_0.sliderTouchPos.x = var_0_12[1]
			arg_6_0.sliderBeginning = true
			arg_6_0.sliderRange.sizeDelta = Vector2(arg_6_0.sliderWidth, arg_6_0.sliderRange.sizeDelta.y)

			return
		end,
		touch = function(arg_7_0, arg_7_1)
			if not arg_7_0.sliderBeginning then
				return
			end

			arg_7_0.sliderBeginning = false

			arg_7_0:setSliderBarVisible(false)

			local var_7_1 = 0
			local var_7_2 = math.abs(arg_7_0.sliderTouchPos.x - var_0_15)
			local var_7_3

			if var_7_2 < arg_7_0.sliderWidth / 2 then
				var_7_1 = arg_7_0:getScore(var_7_2)
				arg_7_0.sliderIndex = arg_7_0.sliderIndex + 1
				var_7_3 = true
			else
				if arg_7_0.sliderTouchPos.x < 100 or arg_7_0.sliderTouchPos.x > var_0_12[2] - 100 then
					var_7_1 = arg_7_0:getSubScore(arg_7_0.sliderTouchPos.x)
				end

				arg_7_0.nextSliderTime = arg_7_0.nextSliderTime + var_0_16
				var_7_3 = false
			end

			if var_7_3 then
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_5)
			else
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_6)
			end

			if arg_7_1 then
				arg_7_0._event:emit(var_0_17, {
					flag = var_7_3,
					score = var_7_1
				}, function()
					return
				end)
			end

			return
		end,
		getSubScore = function(arg_9_0, arg_9_1)
			local var_9_0 = arg_9_1 <= 100 and arg_9_1 or var_0_12[2] - arg_9_1

			for iter_9_0 = 1, #var_0_21 do
				if var_9_0 < var_0_21[iter_9_0] then
					return var_0_20[iter_9_0]
				end
			end

			return 0
		end,
		getScore = function(arg_10_0, arg_10_1)
			for iter_10_0 = 1, #var_0_18 do
				if arg_10_1 < var_0_18[iter_10_0] then
					return var_0_19[iter_10_0]
				end
			end

			return 0
		end,
		destroy = function(arg_11_0)
			return
		end
	}
end

local function var_0_34(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	({
		ctor = function(arg_13_0)
			arg_13_0._charTpls = arg_12_0
			arg_13_0._foodTpl = arg_12_1
			arg_13_0._container = arg_12_2
			arg_13_0._event = arg_12_3

			return
		end,
		start = function(arg_14_0)
			arg_14_0:clear()

			arg_14_0.player = nil
			arg_14_0.chars = {}
			arg_14_0.animateSpeed = var_0_22
			arg_14_0.playerNextStepTimes = {}

			arg_14_0:create()

			return
		end,
		step = function(arg_15_0)
			for iter_15_0 = 1, #arg_15_0.chars do
				if not arg_15_0.chars[iter_15_0].nextTime then
					arg_15_0.chars[iter_15_0].nextTime = math.random(arg_15_0.chars[iter_15_0].next_time[1], arg_15_0.chars[iter_15_0].next_time[2])
				else
					arg_15_0.chars[iter_15_0].nextTime = arg_15_0.chars[iter_15_0].nextTime - Time.deltaTime

					if arg_15_0.chars[iter_15_0].nextTime <= 0 then
						arg_15_0.chars[iter_15_0].nextTime = nil
						arg_15_0.chars[iter_15_0].stepIndex = arg_15_0.chars[iter_15_0].stepIndex + 1

						if table.contains(var_0_29, arg_15_0.chars[iter_15_0].stepIndex) then
							arg_15_0.chars[iter_15_0].tfAnimator:SetTrigger("next")
						end

						if arg_15_0.chars[iter_15_0].stepIndex == var_0_30 then
							arg_15_0.chars[iter_15_0].tfAnimator:SetBool("eat", false)
							arg_15_0.chars[iter_15_0].tfAnimator:SetBool("bite", true)
						end

						if arg_15_0.chars[iter_15_0].stepIndex >= var_0_28 then
							arg_15_0:setWinChar(arg_15_0.chars[iter_15_0])
						end
					end
				end
			end

			return
		end,
		setWinChar = function(arg_16_0, arg_16_1)
			local var_16_0 = false

			if arg_16_1 then
				var_16_0 = arg_16_1.isPlayer
				arg_16_1.foodState = 6

				arg_16_1.foodTfAnimator:SetInteger("state", arg_16_1.foodState)
			end

			if arg_16_0.player == arg_16_1 then
				arg_16_0.player.tfAnimator:SetTrigger("victory")
			else
				arg_16_0.player.tfAnimator:SetTrigger("defeat")
			end

			for iter_16_0 = 1, #arg_16_0.chars do
				if arg_16_0.chars[iter_16_0] == arg_16_1 then
					arg_16_0.chars[iter_16_0].tfAnimator:SetTrigger("victory")
				else
					arg_16_0.chars[iter_16_0].tfAnimator:SetTrigger("defeat")
				end
			end

			arg_16_0._event:emit(var_0_32, var_16_0, function()
				return
			end)

			return
		end,
		onPlayerTouch = function(arg_18_0, arg_18_1)
			if arg_18_0.player then
				if arg_18_1.flag then
					arg_18_0.player.stepIndex = arg_18_0.player.stepIndex + 1

					if table.contains(var_0_29, arg_18_0.player.stepIndex) and not table.contains(arg_18_0.playerNextStepTimes, arg_18_0.player.stepIndex) then
						table.insert(arg_18_0.playerNextStepTimes, arg_18_0.player.stepIndex)
						arg_18_0.player.tfAnimator:SetTrigger("next")
					end

					if arg_18_0.player.stepIndex == var_0_30 then
						arg_18_0.player.tfAnimator:SetBool("eat", false)
						arg_18_0.player.tfAnimator:SetBool("bite", true)
					end

					if arg_18_0.player.stepIndex >= var_0_28 then
						arg_18_0:setWinChar(arg_18_0.player)
					end

					arg_18_0.animateSpeed = arg_18_0.animateSpeed + var_0_23

					if arg_18_0.animateSpeed > var_0_24 then
						arg_18_0.animateSpeed = var_0_24
					end

					arg_18_0.player.tfAnimator.speed = arg_18_0.animateSpeed
				else
					arg_18_0.animateSpeed = arg_18_0.animateSpeed - var_0_23

					if arg_18_0.animateSpeed < var_0_22 then
						arg_18_0.animateSpeed = var_0_22
					end

					arg_18_0.player.tfAnimator.speed = arg_18_0.animateSpeed

					arg_18_0.player.tfAnimator:SetTrigger("miss")
				end
			end

			return
		end,
		create = function(arg_19_0)
			local var_19_0 = Clone(var_0_31)

			arg_19_0.player = arg_19_0:getCharById(table.remove(var_19_0, math.random(1, #var_19_0)), var_0_26)

			local var_19_1 = Clone(var_0_25)

			for iter_19_0 = 1, #var_0_27 do
				table.insert(arg_19_0.chars, (arg_19_0:getCharById(table.remove(var_19_1, math.random(1, #var_19_1)), var_0_27[iter_19_0])))
			end

			return
		end,
		getCharById = function(arg_20_0, arg_20_1, arg_20_2)
			local var_20_0 = {}
			local var_20_1 = tf(instantiate(findTF(arg_20_0._charTpls, "char" .. arg_20_1.id)))
			local var_20_2 = tf(instantiate(arg_20_0._foodTpl))

			setParent(var_20_1, findTF(arg_20_0._container, tostring(arg_20_2)))
			setActive(var_20_1, true)
			setParent(var_20_2, findTF(arg_20_0._container, tostring(arg_20_2)))
			setActive(var_20_2, true)

			var_20_2.anchoredPosition = Vector2(0, -300)
			var_20_1.anchoredPosition = Vector2(0, 0)
			;({}).tf = var_20_1
			;({}).tfAnimator = GetComponent(findTF(var_20_1, "anim"), typeof(Animator))
			;({}).tfAnimator.speed = arg_20_0.animateSpeed
			;({}).foodTf = var_20_2
			;({}).foodTfAnimator = GetComponent(findTF(var_20_2, "anim"), typeof(Animator))
			;({}).foodTfAnimator.speed = var_0_22
			;({}).next_time = arg_20_1.next_time

			if not ({}).next_time then
				({}).isPlayer = true
			else
				({}).nextTime = math.random(0, arg_20_1.next_time[2] - arg_20_1.next_time[1]) + arg_20_1.next_time[1] + var_0_11
			end

			;({}).foodState = 0
			;({}).stepIndex = 0

			local var_20_3 = GetComponent(findTF(var_20_1, "anim"), typeof(DftAniEvent))

			var_20_3:SetStartEvent(function()
				var_20_0.foodState = var_20_0.foodState + 1

				var_20_0.foodTfAnimator:SetInteger("state", var_20_0.foodState)

				return
			end)
			var_20_3:SetTriggerEvent(function()
				return
			end)
			var_20_3:SetEndEvent(function()
				return
			end)

			return {}
		end,
		stop = function(arg_24_0)
			if arg_24_0.player then
				arg_24_0.player.tfAnimator.speed = 0
			end

			if arg_24_0.chars and #arg_24_0.chars > 0 then
				for iter_24_0 = 1, #arg_24_0.chars do
					arg_24_0.chars[iter_24_0].tfAnimator.speed = 0
				end
			end

			return
		end,
		resume = function(arg_25_0)
			if arg_25_0.player then
				arg_25_0.player.tfAnimator.speed = arg_25_0.animateSpeed
			end

			if arg_25_0.chars and #arg_25_0.chars > 0 then
				for iter_25_0 = 1, #arg_25_0.chars do
					arg_25_0.chars[iter_25_0].tfAnimator.speed = var_0_22
				end
			end

			return
		end,
		onTimeOut = function(arg_26_0)
			local var_26_0 = arg_26_0.player
			local var_26_1 = arg_26_0.player.stepIndex or 0

			for iter_26_0 = 1, #arg_26_0.chars do
				if var_26_1 < arg_26_0.chars[iter_26_0].stepIndex then
					var_26_0 = arg_26_0.chars[iter_26_0]
					var_26_1 = arg_26_0.chars[iter_26_0].stepIndex
				end
			end

			arg_26_0:setWinChar(var_26_0)

			return
		end,
		clear = function(arg_27_0)
			if arg_27_0.player then
				destroy(arg_27_0.player.tf)
				destroy(arg_27_0.player.foodTf)
			end

			if arg_27_0.chars then
				for iter_27_0 = 1, #arg_27_0.chars do
					destroy(arg_27_0.chars[iter_27_0].tf)
					destroy(arg_27_0.chars[iter_27_0].foodTf)
				end
			end

			return
		end
	}).ctor({
		ctor = function(arg_13_0)
			arg_13_0._charTpls = arg_12_0
			arg_13_0._foodTpl = arg_12_1
			arg_13_0._container = arg_12_2
			arg_13_0._event = arg_12_3

			return
		end,
		start = function(arg_14_0)
			arg_14_0:clear()

			arg_14_0.player = nil
			arg_14_0.chars = {}
			arg_14_0.animateSpeed = var_0_22
			arg_14_0.playerNextStepTimes = {}

			arg_14_0:create()

			return
		end,
		step = function(arg_15_0)
			for iter_15_0 = 1, #arg_15_0.chars do
				if not arg_15_0.chars[iter_15_0].nextTime then
					arg_15_0.chars[iter_15_0].nextTime = math.random(arg_15_0.chars[iter_15_0].next_time[1], arg_15_0.chars[iter_15_0].next_time[2])
				else
					arg_15_0.chars[iter_15_0].nextTime = arg_15_0.chars[iter_15_0].nextTime - Time.deltaTime

					if arg_15_0.chars[iter_15_0].nextTime <= 0 then
						arg_15_0.chars[iter_15_0].nextTime = nil
						arg_15_0.chars[iter_15_0].stepIndex = arg_15_0.chars[iter_15_0].stepIndex + 1

						if table.contains(var_0_29, arg_15_0.chars[iter_15_0].stepIndex) then
							arg_15_0.chars[iter_15_0].tfAnimator:SetTrigger("next")
						end

						if arg_15_0.chars[iter_15_0].stepIndex == var_0_30 then
							arg_15_0.chars[iter_15_0].tfAnimator:SetBool("eat", false)
							arg_15_0.chars[iter_15_0].tfAnimator:SetBool("bite", true)
						end

						if arg_15_0.chars[iter_15_0].stepIndex >= var_0_28 then
							arg_15_0:setWinChar(arg_15_0.chars[iter_15_0])
						end
					end
				end
			end

			return
		end,
		setWinChar = function(arg_16_0, arg_16_1)
			local var_16_0 = false

			if arg_16_1 then
				var_16_0 = arg_16_1.isPlayer
				arg_16_1.foodState = 6

				arg_16_1.foodTfAnimator:SetInteger("state", arg_16_1.foodState)
			end

			if arg_16_0.player == arg_16_1 then
				arg_16_0.player.tfAnimator:SetTrigger("victory")
			else
				arg_16_0.player.tfAnimator:SetTrigger("defeat")
			end

			for iter_16_0 = 1, #arg_16_0.chars do
				if arg_16_0.chars[iter_16_0] == arg_16_1 then
					arg_16_0.chars[iter_16_0].tfAnimator:SetTrigger("victory")
				else
					arg_16_0.chars[iter_16_0].tfAnimator:SetTrigger("defeat")
				end
			end

			arg_16_0._event:emit(var_0_32, var_16_0, function()
				return
			end)

			return
		end,
		onPlayerTouch = function(arg_18_0, arg_18_1)
			if arg_18_0.player then
				if arg_18_1.flag then
					arg_18_0.player.stepIndex = arg_18_0.player.stepIndex + 1

					if table.contains(var_0_29, arg_18_0.player.stepIndex) and not table.contains(arg_18_0.playerNextStepTimes, arg_18_0.player.stepIndex) then
						table.insert(arg_18_0.playerNextStepTimes, arg_18_0.player.stepIndex)
						arg_18_0.player.tfAnimator:SetTrigger("next")
					end

					if arg_18_0.player.stepIndex == var_0_30 then
						arg_18_0.player.tfAnimator:SetBool("eat", false)
						arg_18_0.player.tfAnimator:SetBool("bite", true)
					end

					if arg_18_0.player.stepIndex >= var_0_28 then
						arg_18_0:setWinChar(arg_18_0.player)
					end

					arg_18_0.animateSpeed = arg_18_0.animateSpeed + var_0_23

					if arg_18_0.animateSpeed > var_0_24 then
						arg_18_0.animateSpeed = var_0_24
					end

					arg_18_0.player.tfAnimator.speed = arg_18_0.animateSpeed
				else
					arg_18_0.animateSpeed = arg_18_0.animateSpeed - var_0_23

					if arg_18_0.animateSpeed < var_0_22 then
						arg_18_0.animateSpeed = var_0_22
					end

					arg_18_0.player.tfAnimator.speed = arg_18_0.animateSpeed

					arg_18_0.player.tfAnimator:SetTrigger("miss")
				end
			end

			return
		end,
		create = function(arg_19_0)
			local var_19_0 = Clone(var_0_31)

			arg_19_0.player = arg_19_0:getCharById(table.remove(var_19_0, math.random(1, #var_19_0)), var_0_26)

			local var_19_1 = Clone(var_0_25)

			for iter_19_0 = 1, #var_0_27 do
				table.insert(arg_19_0.chars, (arg_19_0:getCharById(table.remove(var_19_1, math.random(1, #var_19_1)), var_0_27[iter_19_0])))
			end

			return
		end,
		getCharById = function(arg_20_0, arg_20_1, arg_20_2)
			local var_20_0 = {}
			local var_20_1 = tf(instantiate(findTF(arg_20_0._charTpls, "char" .. arg_20_1.id)))
			local var_20_2 = tf(instantiate(arg_20_0._foodTpl))

			setParent(var_20_1, findTF(arg_20_0._container, tostring(arg_20_2)))
			setActive(var_20_1, true)
			setParent(var_20_2, findTF(arg_20_0._container, tostring(arg_20_2)))
			setActive(var_20_2, true)

			var_20_2.anchoredPosition = Vector2(0, -300)
			var_20_1.anchoredPosition = Vector2(0, 0)
			;({}).tf = var_20_1
			;({}).tfAnimator = GetComponent(findTF(var_20_1, "anim"), typeof(Animator))
			;({}).tfAnimator.speed = arg_20_0.animateSpeed
			;({}).foodTf = var_20_2
			;({}).foodTfAnimator = GetComponent(findTF(var_20_2, "anim"), typeof(Animator))
			;({}).foodTfAnimator.speed = var_0_22
			;({}).next_time = arg_20_1.next_time

			if not ({}).next_time then
				({}).isPlayer = true
			else
				({}).nextTime = math.random(0, arg_20_1.next_time[2] - arg_20_1.next_time[1]) + arg_20_1.next_time[1] + var_0_11
			end

			;({}).foodState = 0
			;({}).stepIndex = 0

			local var_20_3 = GetComponent(findTF(var_20_1, "anim"), typeof(DftAniEvent))

			var_20_3:SetStartEvent(function()
				var_20_0.foodState = var_20_0.foodState + 1

				var_20_0.foodTfAnimator:SetInteger("state", var_20_0.foodState)

				return
			end)
			var_20_3:SetTriggerEvent(function()
				return
			end)
			var_20_3:SetEndEvent(function()
				return
			end)

			return {}
		end,
		stop = function(arg_24_0)
			if arg_24_0.player then
				arg_24_0.player.tfAnimator.speed = 0
			end

			if arg_24_0.chars and #arg_24_0.chars > 0 then
				for iter_24_0 = 1, #arg_24_0.chars do
					arg_24_0.chars[iter_24_0].tfAnimator.speed = 0
				end
			end

			return
		end,
		resume = function(arg_25_0)
			if arg_25_0.player then
				arg_25_0.player.tfAnimator.speed = arg_25_0.animateSpeed
			end

			if arg_25_0.chars and #arg_25_0.chars > 0 then
				for iter_25_0 = 1, #arg_25_0.chars do
					arg_25_0.chars[iter_25_0].tfAnimator.speed = var_0_22
				end
			end

			return
		end,
		onTimeOut = function(arg_26_0)
			local var_26_0 = arg_26_0.player
			local var_26_1 = arg_26_0.player.stepIndex or 0

			for iter_26_0 = 1, #arg_26_0.chars do
				if var_26_1 < arg_26_0.chars[iter_26_0].stepIndex then
					var_26_0 = arg_26_0.chars[iter_26_0]
					var_26_1 = arg_26_0.chars[iter_26_0].stepIndex
				end
			end

			arg_26_0:setWinChar(var_26_0)

			return
		end,
		clear = function(arg_27_0)
			if arg_27_0.player then
				destroy(arg_27_0.player.tf)
				destroy(arg_27_0.player.foodTf)
			end

			if arg_27_0.chars then
				for iter_27_0 = 1, #arg_27_0.chars do
					destroy(arg_27_0.chars[iter_27_0].tf)
					destroy(arg_27_0.chars[iter_27_0].foodTf)
				end
			end

			return
		end
	})

	return {
		ctor = function(arg_13_0)
			arg_13_0._charTpls = arg_12_0
			arg_13_0._foodTpl = arg_12_1
			arg_13_0._container = arg_12_2
			arg_13_0._event = arg_12_3

			return
		end,
		start = function(arg_14_0)
			arg_14_0:clear()

			arg_14_0.player = nil
			arg_14_0.chars = {}
			arg_14_0.animateSpeed = var_0_22
			arg_14_0.playerNextStepTimes = {}

			arg_14_0:create()

			return
		end,
		step = function(arg_15_0)
			for iter_15_0 = 1, #arg_15_0.chars do
				if not arg_15_0.chars[iter_15_0].nextTime then
					arg_15_0.chars[iter_15_0].nextTime = math.random(arg_15_0.chars[iter_15_0].next_time[1], arg_15_0.chars[iter_15_0].next_time[2])
				else
					arg_15_0.chars[iter_15_0].nextTime = arg_15_0.chars[iter_15_0].nextTime - Time.deltaTime

					if arg_15_0.chars[iter_15_0].nextTime <= 0 then
						arg_15_0.chars[iter_15_0].nextTime = nil
						arg_15_0.chars[iter_15_0].stepIndex = arg_15_0.chars[iter_15_0].stepIndex + 1

						if table.contains(var_0_29, arg_15_0.chars[iter_15_0].stepIndex) then
							arg_15_0.chars[iter_15_0].tfAnimator:SetTrigger("next")
						end

						if arg_15_0.chars[iter_15_0].stepIndex == var_0_30 then
							arg_15_0.chars[iter_15_0].tfAnimator:SetBool("eat", false)
							arg_15_0.chars[iter_15_0].tfAnimator:SetBool("bite", true)
						end

						if arg_15_0.chars[iter_15_0].stepIndex >= var_0_28 then
							arg_15_0:setWinChar(arg_15_0.chars[iter_15_0])
						end
					end
				end
			end

			return
		end,
		setWinChar = function(arg_16_0, arg_16_1)
			local var_16_0 = false

			if arg_16_1 then
				var_16_0 = arg_16_1.isPlayer
				arg_16_1.foodState = 6

				arg_16_1.foodTfAnimator:SetInteger("state", arg_16_1.foodState)
			end

			if arg_16_0.player == arg_16_1 then
				arg_16_0.player.tfAnimator:SetTrigger("victory")
			else
				arg_16_0.player.tfAnimator:SetTrigger("defeat")
			end

			for iter_16_0 = 1, #arg_16_0.chars do
				if arg_16_0.chars[iter_16_0] == arg_16_1 then
					arg_16_0.chars[iter_16_0].tfAnimator:SetTrigger("victory")
				else
					arg_16_0.chars[iter_16_0].tfAnimator:SetTrigger("defeat")
				end
			end

			arg_16_0._event:emit(var_0_32, var_16_0, function()
				return
			end)

			return
		end,
		onPlayerTouch = function(arg_18_0, arg_18_1)
			if arg_18_0.player then
				if arg_18_1.flag then
					arg_18_0.player.stepIndex = arg_18_0.player.stepIndex + 1

					if table.contains(var_0_29, arg_18_0.player.stepIndex) and not table.contains(arg_18_0.playerNextStepTimes, arg_18_0.player.stepIndex) then
						table.insert(arg_18_0.playerNextStepTimes, arg_18_0.player.stepIndex)
						arg_18_0.player.tfAnimator:SetTrigger("next")
					end

					if arg_18_0.player.stepIndex == var_0_30 then
						arg_18_0.player.tfAnimator:SetBool("eat", false)
						arg_18_0.player.tfAnimator:SetBool("bite", true)
					end

					if arg_18_0.player.stepIndex >= var_0_28 then
						arg_18_0:setWinChar(arg_18_0.player)
					end

					arg_18_0.animateSpeed = arg_18_0.animateSpeed + var_0_23

					if arg_18_0.animateSpeed > var_0_24 then
						arg_18_0.animateSpeed = var_0_24
					end

					arg_18_0.player.tfAnimator.speed = arg_18_0.animateSpeed
				else
					arg_18_0.animateSpeed = arg_18_0.animateSpeed - var_0_23

					if arg_18_0.animateSpeed < var_0_22 then
						arg_18_0.animateSpeed = var_0_22
					end

					arg_18_0.player.tfAnimator.speed = arg_18_0.animateSpeed

					arg_18_0.player.tfAnimator:SetTrigger("miss")
				end
			end

			return
		end,
		create = function(arg_19_0)
			local var_19_0 = Clone(var_0_31)

			arg_19_0.player = arg_19_0:getCharById(table.remove(var_19_0, math.random(1, #var_19_0)), var_0_26)

			local var_19_1 = Clone(var_0_25)

			for iter_19_0 = 1, #var_0_27 do
				table.insert(arg_19_0.chars, (arg_19_0:getCharById(table.remove(var_19_1, math.random(1, #var_19_1)), var_0_27[iter_19_0])))
			end

			return
		end,
		getCharById = function(arg_20_0, arg_20_1, arg_20_2)
			local var_20_0 = {}
			local var_20_1 = tf(instantiate(findTF(arg_20_0._charTpls, "char" .. arg_20_1.id)))
			local var_20_2 = tf(instantiate(arg_20_0._foodTpl))

			setParent(var_20_1, findTF(arg_20_0._container, tostring(arg_20_2)))
			setActive(var_20_1, true)
			setParent(var_20_2, findTF(arg_20_0._container, tostring(arg_20_2)))
			setActive(var_20_2, true)

			var_20_2.anchoredPosition = Vector2(0, -300)
			var_20_1.anchoredPosition = Vector2(0, 0)
			;({}).tf = var_20_1
			;({}).tfAnimator = GetComponent(findTF(var_20_1, "anim"), typeof(Animator))
			;({}).tfAnimator.speed = arg_20_0.animateSpeed
			;({}).foodTf = var_20_2
			;({}).foodTfAnimator = GetComponent(findTF(var_20_2, "anim"), typeof(Animator))
			;({}).foodTfAnimator.speed = var_0_22
			;({}).next_time = arg_20_1.next_time

			if not ({}).next_time then
				({}).isPlayer = true
			else
				({}).nextTime = math.random(0, arg_20_1.next_time[2] - arg_20_1.next_time[1]) + arg_20_1.next_time[1] + var_0_11
			end

			;({}).foodState = 0
			;({}).stepIndex = 0

			local var_20_3 = GetComponent(findTF(var_20_1, "anim"), typeof(DftAniEvent))

			var_20_3:SetStartEvent(function()
				var_20_0.foodState = var_20_0.foodState + 1

				var_20_0.foodTfAnimator:SetInteger("state", var_20_0.foodState)

				return
			end)
			var_20_3:SetTriggerEvent(function()
				return
			end)
			var_20_3:SetEndEvent(function()
				return
			end)

			return {}
		end,
		stop = function(arg_24_0)
			if arg_24_0.player then
				arg_24_0.player.tfAnimator.speed = 0
			end

			if arg_24_0.chars and #arg_24_0.chars > 0 then
				for iter_24_0 = 1, #arg_24_0.chars do
					arg_24_0.chars[iter_24_0].tfAnimator.speed = 0
				end
			end

			return
		end,
		resume = function(arg_25_0)
			if arg_25_0.player then
				arg_25_0.player.tfAnimator.speed = arg_25_0.animateSpeed
			end

			if arg_25_0.chars and #arg_25_0.chars > 0 then
				for iter_25_0 = 1, #arg_25_0.chars do
					arg_25_0.chars[iter_25_0].tfAnimator.speed = var_0_22
				end
			end

			return
		end,
		onTimeOut = function(arg_26_0)
			local var_26_0 = arg_26_0.player
			local var_26_1 = arg_26_0.player.stepIndex or 0

			for iter_26_0 = 1, #arg_26_0.chars do
				if var_26_1 < arg_26_0.chars[iter_26_0].stepIndex then
					var_26_0 = arg_26_0.chars[iter_26_0]
					var_26_1 = arg_26_0.chars[iter_26_0].stepIndex
				end
			end

			arg_26_0:setWinChar(var_26_0)

			return
		end,
		clear = function(arg_27_0)
			if arg_27_0.player then
				destroy(arg_27_0.player.tf)
				destroy(arg_27_0.player.foodTf)
			end

			if arg_27_0.chars then
				for iter_27_0 = 1, #arg_27_0.chars do
					destroy(arg_27_0.chars[iter_27_0].tf)
					destroy(arg_27_0.chars[iter_27_0].foodTf)
				end
			end

			return
		end
	}
end

function var_0_0.getUIName(arg_28_0)
	return "EatFoodGameUI"
end

function var_0_0.getBGM(arg_29_0)
	return var_0_1
end

function var_0_0.didEnter(arg_30_0)
	arg_30_0:initEvent()
	arg_30_0:initData()
	arg_30_0:initUI()
	arg_30_0:initGameUI()
	arg_30_0:readyStart()

	return
end

function var_0_0.OnGetAwardDone(arg_31_0)
	arg_31_0:CheckGet()

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_32_0, arg_32_1)
	return
end

function var_0_0.initEvent(arg_33_0)
	arg_33_0:bind(var_0_32, function(arg_34_0, arg_34_1, arg_34_2)
		arg_33_0:setGameOver(arg_34_1)

		return
	end)
	arg_33_0:bind(var_0_17, function(arg_35_0, arg_35_1, arg_35_2)
		if arg_35_1.score and arg_35_1.score ~= 0 then
			arg_33_0:addScore(arg_35_1.score)
		end

		if arg_33_0.charController then
			arg_33_0.charController:onPlayerTouch(arg_35_1)
		end

		return
	end)

	return
end

function var_0_0.initData(arg_36_0)
	arg_36_0.dropData = pg.mini_game[arg_36_0:GetMGData().id].simple_config_data.drop

	local var_36_0 = Application.targetFrameRate or 60

	if var_36_0 > 60 then
		var_36_0 = 60
	end

	arg_36_0.timer = Timer.New(function()
		arg_36_0:onTimer()

		return
	end, 1 / var_36_0, -1)

	return
end

function var_0_0.initUI(arg_38_0)
	arg_38_0.backSceneTf = findTF(arg_38_0._tf, "scene_container/scene_background")
	arg_38_0.sceneTf = findTF(arg_38_0._tf, "scene_container/scene")
	arg_38_0.bgTf = findTF(arg_38_0._tf, "bg")
	arg_38_0.clickMask = findTF(arg_38_0._tf, "clickMask")
	arg_38_0.countUI = findTF(arg_38_0._tf, "pop/CountUI")
	arg_38_0.countAnimator = GetComponent(findTF(arg_38_0.countUI, "count"), typeof(Animator))
	arg_38_0.countDft = GetOrAddComponent(findTF(arg_38_0.countUI, "count"), typeof(DftAniEvent))

	arg_38_0.countDft:SetTriggerEvent(function()
		return
	end)
	arg_38_0.countDft:SetEndEvent(function()
		setActive(arg_38_0.countUI, false)

		arg_38_0.readyStart = false

		return
	end)
	SetActive(arg_38_0.countUI, false)

	arg_38_0.leaveUI = findTF(arg_38_0._tf, "pop/LeaveUI")

	onButton(arg_38_0, findTF(arg_38_0.leaveUI, "ad/btnOk"), function()
		arg_38_0:resumeGame()

		if arg_38_0.charController then
			arg_38_0.charController:stop()
		end

		arg_38_0:onGameOver(0)

		return
	end, SFX_CANCEL)
	onButton(arg_38_0, findTF(arg_38_0.leaveUI, "ad/btnCancel"), function()
		arg_38_0:resumeGame()

		return
	end, SFX_CANCEL)
	SetActive(arg_38_0.leaveUI, false)

	arg_38_0.pauseUI = findTF(arg_38_0._tf, "pop/pauseUI")

	onButton(arg_38_0, findTF(arg_38_0.pauseUI, "ad/btnOk"), function()
		setActive(arg_38_0.pauseUI, false)
		arg_38_0:resumeGame()

		return
	end, SFX_CANCEL)
	SetActive(arg_38_0.pauseUI, false)

	arg_38_0.resultUI = findTF(arg_38_0._tf, "pop/resultUI")

	SetActive(arg_38_0.resultUI, false)

	arg_38_0.settlementUI = findTF(arg_38_0._tf, "pop/SettleMentUI")

	onButton(arg_38_0, findTF(arg_38_0.settlementUI, "ad/btnOver"), function()
		setActive(arg_38_0.settlementUI, false)
		arg_38_0:closeView()

		return
	end, SFX_CANCEL)
	SetActive(arg_38_0.settlementUI, false)

	arg_38_0.handle = arg_38_0.handle or UpdateBeat:CreateListener(arg_38_0.Update, arg_38_0)

	UpdateBeat:AddListener(arg_38_0.handle)

	return
end

function var_0_0.initGameUI(arg_45_0)
	arg_45_0.gameUI = findTF(arg_45_0._tf, "ui/gameUI")

	onButton(arg_45_0, findTF(arg_45_0.gameUI, "topRight/btnStop"), function()
		arg_45_0:stopGame()
		setActive(arg_45_0.pauseUI, true)

		return
	end)
	onButton(arg_45_0, findTF(arg_45_0.gameUI, "btnLeave"), function()
		arg_45_0:stopGame()
		setActive(arg_45_0.leaveUI, true)

		return
	end)

	arg_45_0.dragDelegate = GetOrAddComponent(arg_45_0.sceneTf, "EventTriggerListener")
	arg_45_0.dragDelegate.enabled = true

	arg_45_0.dragDelegate:AddPointDownFunc(function(arg_48_0, arg_48_1)
		if arg_45_0.sliderController then
			arg_45_0.sliderController:touch(true)
		end

		return
	end)

	arg_45_0.gameTimeS = findTF(arg_45_0.gameUI, "top/time/s")
	arg_45_0.scoreTf = findTF(arg_45_0.gameUI, "top/score")
	arg_45_0.sceneScoreTf = findTF(arg_45_0.sceneTf, "score")
	arg_45_0.sliderController = var_0_33(findTF(arg_45_0.sceneTf, "collider"), arg_45_0)
	arg_45_0.charController = var_0_34(findTF(arg_45_0.sceneTf, "tpls"), findTF(arg_45_0.sceneTf, "food"), findTF(arg_45_0.sceneTf, "container"), arg_45_0)

	return
end

function var_0_0.Update(arg_49_0)
	arg_49_0:AddDebugInput()

	return
end

function var_0_0.AddDebugInput(arg_50_0)
	if arg_50_0.gameStop or arg_50_0.settlementFlag then
		return
	end

	if IsUnityEditor then
		-- block empty
	end

	return
end

function var_0_0.updateMenuUI(arg_51_0)
	return
end

function var_0_0.CheckGet(arg_52_0)
	if arg_52_0:getUltimate() == 0 then
		if arg_52_0:getGameTotalTime() > arg_52_0:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_52_0:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

function var_0_0.openMenuUI(arg_53_0)
	setActive(findTF(arg_53_0._tf, "scene_container"), false)
	setActive(findTF(arg_53_0.bgTf, "on"), true)
	setActive(arg_53_0.gameUI, false)
	setActive(arg_53_0.menuUI, true)

	return
end

function var_0_0.clearUI(arg_54_0)
	setActive(arg_54_0.sceneTf, false)
	setActive(arg_54_0.settlementUI, false)
	setActive(arg_54_0.countUI, false)
	setActive(arg_54_0.menuUI, false)
	setActive(arg_54_0.gameUI, false)

	return
end

function var_0_0.readyStart(arg_55_0)
	setActive(arg_55_0.countUI, true)
	arg_55_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)

	arg_55_0.readyStart = true

	arg_55_0:gameStart()

	return
end

function var_0_0.getGameTimes(arg_56_0)
	return arg_56_0:GetMGHubData().count
end

function var_0_0.getGameUsedTimes(arg_57_0)
	return arg_57_0:GetMGHubData().usedtime
end

function var_0_0.getUltimate(arg_58_0)
	return arg_58_0:GetMGHubData().ultimate
end

function var_0_0.getGameTotalTime(arg_59_0)
	return (arg_59_0:GetMGHubData():getConfig("reward_need"))
end

function var_0_0.gameStart(arg_60_0)
	setActive(findTF(arg_60_0._tf, "scene_container"), true)
	setActive(findTF(arg_60_0.bgTf, "on"), false)
	setActive(arg_60_0.gameUI, true)

	arg_60_0.gameStartFlag = true
	arg_60_0.scoreNum = 0
	arg_60_0.playerPosIndex = 2
	arg_60_0.gameStepTime = 0
	arg_60_0.gameTime = var_0_7

	if arg_60_0.sliderController then
		arg_60_0.sliderController:start()
	end

	if arg_60_0.charController then
		arg_60_0.charController:start()
	end

	arg_60_0:updateGameUI()
	arg_60_0:timerStart()

	return
end

function var_0_0.transformColor(arg_61_0, arg_61_1)
	return Color.New(tonumber(string.sub(arg_61_1, 1, 2), 16) / 255, tonumber(string.sub(arg_61_1, 3, 4), 16) / 255, tonumber(string.sub(arg_61_1, 5, 6), 16) / 255)
end

function var_0_0.addScore(arg_62_0, arg_62_1, arg_62_2)
	setActive(arg_62_0.sceneScoreTf, false)

	if arg_62_1 then
		arg_62_0.scoreNum = arg_62_0.scoreNum + arg_62_1

		if arg_62_1 >= 0 then
			local var_62_0 = "+" .. arg_62_1 or tostring(arg_62_1)

			setText(findTF(arg_62_0.sceneScoreTf, "img"), var_62_0)
			setActive(arg_62_0.sceneScoreTf, true)
			arg_62_0:updateGameUI()

			return
		end
	end
end

function var_0_0.onTimer(arg_63_0)
	arg_63_0:gameStep()

	return
end

function var_0_0.gameStep(arg_64_0)
	if not arg_64_0.readyStart then
		arg_64_0.gameTime = arg_64_0.gameTime - Time.deltaTime
		arg_64_0.gameStepTime = arg_64_0.gameStepTime + Time.deltaTime
	end

	if arg_64_0.gameTime < 0 then
		arg_64_0.gameTime = 0
	end

	arg_64_0:updateGameUI()

	if arg_64_0.sliderController then
		arg_64_0.sliderController:step()
	end

	if arg_64_0.charController then
		arg_64_0.charController:step()
	end

	if arg_64_0.gameTime <= 0 then
		if arg_64_0.charController then
			arg_64_0.charController:onTimeOut()
		end

		return
	end

	return
end

function var_0_0.timerStart(arg_65_0)
	if not arg_65_0.timer.running then
		arg_65_0.timer:Start()
	end

	return
end

function var_0_0.timerStop(arg_66_0)
	if arg_66_0.timer.running then
		arg_66_0.timer:Stop()
	end

	return
end

function var_0_0.updateGameUI(arg_67_0)
	setText(arg_67_0.scoreTf, arg_67_0.scoreNum)
	setText(arg_67_0.gameTimeS, math.ceil(arg_67_0.gameTime))

	return
end

function var_0_0.setGameOver(arg_68_0, arg_68_1)
	arg_68_0:onGameOver(3.5)

	local var_68_0
	local var_68_1

	if not Application.targetFrameRate then
		var_68_1 = 60
	end

	seriesAsync({
		function(arg_69_0)
			local var_69_0 = 0

			var_68_0 = Timer.New(function()
				var_69_0 = var_69_0 + 15

				if var_69_0 > 1400 then
					arg_69_0()
				end

				return
			end, 1 / var_68_1, -1)

			var_68_0:Start()

			return
		end,
		function(arg_71_0)
			if var_68_0 then
				var_68_0:Stop()

				var_68_0 = nil
			end

			if arg_68_1 then
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)
			else
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)
			end

			setActive(findTF(arg_68_0.resultUI, "ad/victory"), arg_68_1)
			setActive(findTF(arg_68_0.resultUI, "ad/defeat"), not arg_68_1)
			setActive(arg_68_0.resultUI, true)
			GetComponent(findTF(arg_68_0.resultUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

			local var_71_0 = 0

			var_68_0 = Timer.New(function()
				var_71_0 = var_71_0 + 15

				if var_71_0 > 1400 then
					setActive(arg_68_0.resultUI, false)
					arg_71_0()
				end

				return
			end, 1 / var_68_1, -1)

			var_68_0:Start()

			return
		end
	}, function()
		if var_68_0 then
			var_68_0:Stop()

			var_68_0 = nil
		end

		return
	end)

	return
end

function var_0_0.onGameOver(arg_74_0, arg_74_1)
	if arg_74_0.settlementFlag then
		return
	end

	arg_74_0:timerStop()

	arg_74_0.settlementFlag = true

	setActive(arg_74_0.clickMask, true)
	LeanTween.delayedCall(go(arg_74_0._tf), arg_74_1, System.Action(function()
		arg_74_0.settlementFlag = false
		arg_74_0.gameStartFlag = false

		setActive(arg_74_0.clickMask, false)
		arg_74_0:showSettlement()

		return
	end))

	return
end

function var_0_0.showSettlement(arg_76_0)
	setActive(arg_76_0.settlementUI, true)
	GetComponent(findTF(arg_76_0.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_76_0 = arg_76_0:GetMGData():GetRuntimeData("elements")
	local var_76_1 = arg_76_0.scoreNum

	if var_76_0 and #var_76_0 > 0 then
		local var_76_2 = var_76_0[1] or 0

		setActive(findTF(arg_76_0.settlementUI, "ad/new"), var_76_2 < var_76_1)

		if var_76_2 <= var_76_1 then
			var_76_2 = var_76_1

			arg_76_0:StoreDataToServer({
				var_76_1
			})
		end

		setText(findTF(arg_76_0.settlementUI, "ad/highText"), var_76_2)
		setText(findTF(arg_76_0.settlementUI, "ad/currentText"), var_76_1)

		if arg_76_0:getGameTimes() and arg_76_0:getGameTimes() > 0 then
			arg_76_0.sendSuccessFlag = true

			arg_76_0:SendSuccess(0)

			local var_76_3 = arg_76_0:getGameTotalTime()
			local var_76_4 = arg_76_0:getGameUsedTimes()
		end

		return
	end
end

function var_0_0.resumeGame(arg_77_0)
	arg_77_0.gameStop = false

	setActive(arg_77_0.leaveUI, false)

	if arg_77_0.charController then
		arg_77_0.charController:resume()
	end

	arg_77_0:timerStart()

	return
end

function var_0_0.stopGame(arg_78_0)
	arg_78_0.gameStop = true

	if arg_78_0.charController then
		arg_78_0.charController:stop()
	end

	arg_78_0:timerStop()

	return
end

function var_0_0.onBackPressed(arg_79_0)
	if not arg_79_0.gameStartFlag then
		arg_79_0:emit(var_0_0.ON_BACK_PRESSED)
	else
		if arg_79_0.settlementFlag then
			return
		end

		if isActive(arg_79_0.pauseUI) then
			setActive(arg_79_0.pauseUI, false)
		end

		arg_79_0:stopGame()
		setActive(arg_79_0.leaveUI, true)
	end

	return
end

function var_0_0.willExit(arg_80_0)
	if arg_80_0.handle then
		UpdateBeat:RemoveListener(arg_80_0.handle)
	end

	if arg_80_0._tf and LeanTween.isTweening(go(arg_80_0._tf)) then
		LeanTween.cancel(go(arg_80_0._tf))
	end

	if arg_80_0.timer and arg_80_0.timer.running then
		arg_80_0.timer:Stop()
	end

	Time.timeScale = 1
	arg_80_0.timer = nil

	return
end

return var_0_0
