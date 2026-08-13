class = var_0_10000

local var_0_0 = "SnowballGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))
local var_0_2 = {
	-1920,
	-1080,
	1920,
	1080
}
local var_0_3 = "snowball_type_player"
local var_0_4 = "snowball_type_enemy"
local var_0_5 = "win"
local var_0_6 = "fail"
local var_0_7 = 3
local var_0_8 = 6
local var_0_9 = "charactor_type_other"
local var_0_10 = "charactor_type_enemy"
local var_0_11 = {
	charactor_type_other = {
		type = var_0_9,
		skin_names = {
			"bailu",
			"huangjia",
			"jiujiu"
		},
		score = {
			-50,
			200,
			-50
		}
	},
	charactor_type_enemy = {
		type = var_0_10,
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
}
local var_0_12 = 3
local var_0_13 = 1
local var_0_14 = 18
local var_0_15 = 30
local var_0_16 = 3
local var_0_17 = 100
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
		type = var_0_10,
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
		type = var_0_9,
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

local function var_0_27(arg_1_0)
	print = var_1_10001

	var_1_10001(arg_1_0)

	return
end

local function var_0_28(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = 1

	function var_2_0.Ctor(arg_3_0)
		arg_3_0._tf = arg_2_0
		findTF = var_1
		arg_3_0.reloadProgress = var_1(arg_3_0._tf, "reloadProgress")
		GetComponent = var_1
		findTF = var_2

		local var_3_0 = var_2(arg_3_0._tf, "player")

		typeof = var_3
		Animator = var_4
		arg_3_0.playerAnimator = var_1(var_3_0, var_3(var_4))
		GetComponent = var_1
		findTF = var_3_0

		local var_3_1 = var_3_0(arg_3_0._tf, "player")

		typeof = var_3
		DftAniEvent = var_4
		arg_3_0.playerDft = var_1(var_3_1, var_3(var_4))

		local var_3_2 = arg_3_0.playerDft

		var_1.SetStartEvent(var_3_2, function()
			local var_4_0 = arg_3_0.playerAnimator

			var_0.ResetTrigger(var_4_0, "throw")

			local var_4_1 = arg_3_0.playerAnimator

			var_0.SetBool(var_4_1, "snowball", true)

			return
		end)

		local var_3_3 = arg_3_0.playerDft

		var_1.SetTriggerEvent(var_3_3, function()
			local var_5_0 = arg_3_0

			var_0.throwSnowball(var_5_0)

			return
		end)

		local var_3_4 = arg_3_0.playerDft

		var_1.SetEndEvent(var_3_4, function()
			return
		end)

		findTF = var_1
		arg_3_0.heartPos = var_1(arg_3_0._tf, "heartPos")
		findTF = var_1
		arg_3_0.tplHeart = var_1(arg_3_0._tf, "heartPos/tplHeart")
		findTF = var_1
		arg_3_0.collider = var_1(arg_3_0._tf, "collider")
		arg_3_0.throwCallback = nil
		arg_3_0.damageCallback = nil
		arg_3_0.gameOverCallback = nil

		return
	end

	function var_2_0.prepare(arg_7_0)
		arg_7_0._life = var_0_12
		arg_7_0._reloadTime = nil
		arg_7_0._skillTime = nil
		arg_7_0.stepTime = 0

		local var_7_0 = arg_7_0.playerAnimator

		var_1.ResetTrigger(var_7_0, "skill")

		local var_7_1 = arg_7_0.playerAnimator

		var_1.ResetTrigger(var_7_1, "throw")

		local var_7_2 = arg_7_0.playerAnimator

		var_1.ResetTrigger(var_7_2, "damage")

		local var_7_3 = arg_7_0.playerAnimator

		var_1.ResetTrigger(var_7_3, "reload")

		local var_7_4 = arg_7_0.playerAnimator

		var_1.ResetTrigger(var_7_4, "fail")

		local var_7_5 = arg_7_0.playerAnimator

		var_1.ResetTrigger(var_7_5, "win")

		local var_7_6 = arg_7_0.playerAnimator

		var_1.ResetTrigger(var_7_6, "fail")

		local var_7_7 = arg_7_0.playerAnimator

		var_1.SetTrigger(var_7_7, "restart")

		local var_7_8 = arg_7_0.playerAnimator

		var_1.ResetTrigger(var_7_8, "restart")
		arg_7_0:Clear()

		return
	end

	function var_2_0.step(arg_8_0)
		local var_8_0 = arg_8_0.stepTime

		Time = var_2_10002
		arg_8_0.stepTime = var_8_0 + var_2_10002.deltaTime

		if not arg_8_0._reloadTime then
			arg_8_0._reloadTime = arg_8_0.stepTime
		end

		local var_8_1 = arg_8_0.playerAnimator

		if not var_1.GetBool(var_8_1, "snowball") and arg_8_0.stepTime - arg_8_0._reloadTime > var_0_13 then
			arg_8_0:reload()
		end

		local var_8_2 = arg_8_0.playerAnimator

		if not var_1.GetBool(var_8_2, "snowball") then
			isActive = var_1

			if not var_1(arg_8_0.reloadProgress) then
				setActive = var_1

				var_1(arg_8_0.reloadProgress, true)

				goto label_8_0
			end
		end

		do
			local var_8_3 = arg_8_0.playerAnimator

			if var_1.GetBool(var_8_3, "snowball") then
				isActive = var_1

				if var_1(arg_8_0.reloadProgress) then
					setActive = var_1

					var_1(arg_8_0.reloadProgress, false)
				end
			end
		end

		::label_8_0::

		local var_8_4 = (arg_8_0.stepTime - arg_8_0._reloadTime) / var_0_13

		if 1 < var_8_4 then
			var_8_4 = 1
		end

		setSlider = var_2

		var_2(arg_8_0.reloadProgress, 0, 1, var_8_4)

		return
	end

	function var_2_0.reload(arg_9_0)
		local var_9_0 = arg_9_0.playerAnimator

		var_1.SetTrigger(var_9_0, "reload")

		return
	end

	function var_2_0.skill(arg_10_0)
		if arg_10_0._skillTime and arg_10_0.stepTime - arg_10_0._skillTime < var_0_15 then
			return
		end

		arg_10_0._skillTime = arg_10_0.stepTime
		arg_10_0._reloadTime = arg_10_0.stepTime

		local var_10_0 = arg_10_0.playerAnimator

		var_1.SetTrigger(var_10_0, "skill")

		return
	end

	function var_2_0.throw(arg_11_0)
		local var_11_0 = arg_11_0.playerAnimator

		if var_1.GetBool(var_11_0, "snowball") then
			local var_11_1 = arg_11_0.playerAnimator

			var_1.SetTrigger(var_11_1, "throw")

			return true
		end

		return false
	end

	function var_2_0.damage(arg_12_0)
		if arg_12_0._life == 0 then
			return
		end

		arg_12_0._life = arg_12_0._life - 1
		pg = var_1

		local var_12_0 = var_1.CriMgr.GetInstance()

		var_1.PlaySoundEffect_V3(var_12_0, var_0_26)

		if arg_12_0.damageCallback then
			arg_12_0.damageCallback()
		end

		if arg_12_0._life > 0 then
			local var_12_1 = arg_12_0.playerAnimator

			var_1.SetTrigger(var_12_1, "damage")
			arg_12_0:createHeart()
		else
			local var_12_2 = arg_12_0.playerAnimator

			var_1.SetTrigger(var_12_2, "fail")

			if arg_12_0.gameOverCallback then
				arg_12_0.gameOverCallback()
			end
		end

		return
	end

	function var_2_0.createHeart(arg_13_0)
		tf = var_2_10001
		instantiate = var_2_10002

		local var_13_0 = var_2_10001(var_2_10002(arg_13_0.tplHeart))

		GetComponent = var_2

		local var_13_1 = var_13_0

		typeof = var_2_10004
		DftAniEvent = var_2_10005

		local var_13_2 = var_2(var_13_1, var_2_10004(var_2_10005))

		var_2.SetEndEvent(var_13_2, function()
			Destroy = var_3_10000

			var_3_10000(var_13_0)

			return
		end)

		setParent = var_3

		var_3(var_13_0, arg_13_0.heartPos)

		setActive = var_3

		var_3(var_13_0, true)

		return
	end

	function var_2_0.setSpeed(arg_15_0, arg_15_1)
		arg_15_0.playerAnimator.speed = arg_15_1

		return
	end

	function var_2_0.throwSnowball(arg_16_0)
		if arg_16_0.throwCallback then
			findTF = var_1

			local var_16_0 = var_1(arg_16_0._tf, "throwPos").position

			arg_16_0.throwCallback(var_16_0)
		end

		local var_16_1 = arg_16_0.playerAnimator

		var_1.SetBool(var_16_1, "snowball", false)

		arg_16_0._reloadTime = arg_16_0.stepTime

		return
	end

	function var_2_0.move(arg_17_0, arg_17_1)
		arg_17_0._tf.anchoredPosition = arg_17_1

		return
	end

	function var_2_0.settlement(arg_18_0, arg_18_1)
		if arg_18_1 == var_0_6 then
			local var_18_0 = arg_18_0.playerAnimator

			var_2.SetTrigger(var_18_0, "fail")
		elseif arg_18_1 == var_0_5 then
			local var_18_1 = arg_18_0.playerAnimator

			var_2.SetTrigger(var_18_1, "win")
		end

		return
	end

	function var_2_0.stop(arg_19_0)
		arg_19_0.playerAnimator.speed = 0

		return
	end

	function var_2_0.resume(arg_20_0)
		arg_20_0.playerAnimator.speed = 1

		return
	end

	function var_2_0.getTargetPosition(arg_21_0)
		findTF = var_2_10001

		return var_2_10001(arg_21_0._tf, "targetPos").position
	end

	function var_2_0.getColliderBound(arg_22_0)
		return arg_22_0.collider.position, arg_22_0.collider.sizeDelta
	end

	function var_2_0.getLife(arg_23_0)
		return arg_23_0._life
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

	function var_25_0.Ctor(arg_26_0)
		GetComponent = var_2_10001
		findTF = var_2_10002

		local var_26_0 = var_2_10002(arg_26_0._tf, "snowball")

		typeof = var_3
		Animator = var_4
		arg_26_0._animator = var_2_10001(var_26_0, var_3(var_4))
		GetComponent = var_1
		findTF = var_26_0

		local var_26_1 = var_26_0(arg_26_0._tf, "snowball")

		typeof = var_3
		DftAniEvent = var_4
		arg_26_0.snowballDft = var_1(var_26_1, var_3(var_4))

		local var_26_2 = arg_26_0.snowballDft

		var_1.SetEndEvent(var_26_2, function()
			arg_26_0._removeFlag = true

			local var_27_0 = arg_26_0

			var_0.dispose(var_27_0)

			return
		end)

		return
	end

	function var_25_0.setId(arg_28_0, arg_28_1)
		arg_28_0._id = arg_28_1

		return
	end

	function var_25_0.getId(arg_29_0, arg_29_1)
		return arg_29_0._id
	end

	function var_25_0.setPosition(arg_30_0, arg_30_1)
		arg_30_0._tf.anchoredPosition = arg_30_1

		local var_30_0 = arg_30_0._tf

		Vector3 = var_2_10003

		local var_30_1 = 0
		local var_30_2 = 0

		math = var_2_10006

		local var_30_3 = var_2_10006.atan(arg_25_1.y / arg_25_1.x)

		math = var_7
		var_30_0.localEulerAngles = var_2_10003(var_30_1, var_30_2, var_30_3 * var_7.rad2Deg)

		return
	end

	function var_25_0.hit(arg_31_0)
		arg_31_0._hitFlag = true

		local var_31_0 = arg_31_0._animator

		var_1.SetTrigger(var_31_0, "hit")

		return
	end

	function var_25_0.move(arg_32_0)
		Time = var_2_10001

		local var_32_0

		if var_2_10001.deltaTime / 0.015 > 2 then
			var_32_0 = 1
		end

		local var_32_1 = arg_32_0._tf.anchoredPosition

		if arg_32_0._hitFlag then
			var_32_0 = var_32_0 / 8
		end

		var_32_1.x = var_32_1.x + arg_32_0._moveDirect.x * var_32_0
		var_32_1.y = var_32_1.y + arg_32_0._moveDirect.y * var_32_0
		arg_32_0._tf.anchoredPosition = var_32_1

		return
	end

	function var_25_0.getRemoveFlag(arg_33_0)
		return arg_33_0._removeFlag
	end

	function var_25_0.checkOutScene(arg_34_0)
		if arg_34_0._tf.anchoredPosition.x < var_0_2[1] or var_1.x > var_0_2[3] or var_1.y < var_0_2[2] or var_1.y > var_0_2[4] then
			arg_34_0:dispose()

			return true
		end

		return false
	end

	function var_25_0.getAnchoredPos(arg_35_0)
		return arg_35_0._tf.anchoredPosition
	end

	function var_25_0.getTargetPos(arg_36_0)
		return arg_36_0.tar
	end

	function var_25_0.getType(arg_37_0)
		return arg_37_0._type
	end

	function var_25_0.getIndex(arg_38_0)
		return arg_38_0._targetIndex
	end

	function var_25_0.checkArrived(arg_39_0, arg_39_1, arg_39_2)
		if arg_39_0._hitFlag then
			return
		end

		if arg_39_0:getAnchoredPos().x > arg_39_1.x and var_3.x < arg_39_1.x + arg_39_2.x and var_3.y > arg_39_1.y and var_3.y < arg_39_1.y + arg_39_2.y then
			return true
		end

		return false
	end

	function var_25_0.getArrived(arg_40_0)
		if arg_40_0._hitFlag then
			return
		end

		local var_40_0 = arg_40_0
		local var_40_1 = arg_40_0.getAnchoredPos(var_40_0)

		math = var_40_0

		local var_40_2 = var_40_0.abs(arg_40_0._targetPosition.x - var_40_1.x)

		math = var_3

		if var_40_2 <= var_3.abs(arg_40_0._moveDirect.x * 2) then
			math = var_40_2

			local var_40_3 = var_40_2.abs(arg_40_0._targetPosition.y - var_40_1.y)

			math = var_3

			if var_40_3 <= var_3.abs(arg_40_0._moveDirect.y * 2) then
				return true
			end
		end

		return false
	end

	function var_25_0.dispose(arg_41_0)
		if arg_41_0._tf then
			Destroy = var_1

			var_1(arg_41_0._tf)

			arg_41_0._tf = nil
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

	function var_42_0.createSnowball(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5)
		pg = var_2_10006

		local var_43_0 = var_2_10006.CriMgr.GetInstance()

		var_6.PlaySoundEffect_V3(var_43_0, var_0_25)

		tf = var_6
		Instantiate = var_43_0

		local var_43_1 = var_6(var_43_0(arg_43_0._tplSnowball))

		SetParent = var_7

		var_7(var_43_1, arg_43_0._snowballContainer)

		setActive = var_7

		var_7(var_43_1, true)

		local var_43_2 = arg_43_3 * (arg_43_2.x > arg_43_1.x and 1 or -1)
		local var_43_3 = (arg_43_2.y - arg_43_1.y) / (arg_43_2.x - arg_43_1.x) * var_43_2

		if arg_43_2.x < arg_43_1.x then
			Vector3 = var_9
			var_43_1.localScale = var_9(-1, 1, 1)
		end

		Vector3 = var_9

		local var_43_4 = var_9(var_43_2, var_43_3, 0)
		local var_43_5 = var_0_29(var_43_1, var_43_4, arg_43_2, arg_43_4, arg_43_5)

		var_10.setId(var_43_5, arg_43_0:getSnowBallId())
		var_10:setPosition(arg_43_1)

		table = var_11

		var_11.insert(arg_43_0.snowballs, var_10)

		return
	end

	function var_42_0.prepare(arg_44_0)
		for iter_44_0 = #arg_44_0.snowballs, 1, -1 do
			local var_44_0 = arg_44_0.snowballs[iter_44_0]

			table = var_2_10006

			var_2_10006.remove(arg_44_0.snowballs, iter_44_0)
			var_44_0:dispose()
		end

		return
	end

	function var_42_0.step(arg_45_0)
		for iter_45_0 = #arg_45_0.snowballs, 1, -1 do
			local var_45_0 = arg_45_0.snowballs[iter_45_0]

			if var_5.getRemoveFlag(var_45_0) or var_5:checkOutScene() then
				table = var_6

				var_6.remove(arg_45_0.snowballs, iter_45_0)
			else
				var_5:move()
			end
		end

		return
	end

	function var_42_0.clearEnemySnowball(arg_46_0)
		for iter_46_0 = #arg_46_0.snowballs, 1, -1 do
			local var_46_0 = arg_46_0.snowballs[iter_46_0]

			if var_5.getType(var_46_0) == var_0_4 then
				local var_46_1 = arg_46_0.snowballs[iter_46_0]

				var_5.hit(var_46_1)
			end
		end

		return
	end

	function var_42_0.snowballHit(arg_47_0, arg_47_1)
		if not arg_47_1 then
			return
		end

		for iter_47_0 = #arg_47_0.snowballs, 1, -1 do
			local var_47_0 = arg_47_0.snowballs[iter_47_0]

			if var_6.getId(var_47_0) == arg_47_1 then
				local var_47_1 = arg_47_0.snowballs[iter_47_0]

				var_6.hit(var_47_1)
			end
		end

		return
	end

	function var_42_0.getSnowBallId(arg_48_0)
		arg_48_0._snowBallId = arg_48_0._snowBallId + 1

		return arg_48_0._snowBallId
	end

	function var_42_0.getSnowballs(arg_49_0)
		Clone = var_2_10001

		return var_2_10001(arg_49_0.snowballs)
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
		Ctor = function(arg_51_0)
			arg_51_0.leaveCallback = nil
			findTF = var_1
			arg_51_0.collider = var_1(arg_51_0._tf, "collider")
			GetComponent = var_1
			findTF = var_2

			local var_51_0 = var_2(arg_51_0._tf, "char")

			typeof = var_3
			Animator = var_4
			arg_51_0.otherAnimator = var_1(var_51_0, var_3(var_4))
			GetComponent = var_1
			findTF = var_51_0

			local var_51_1 = var_51_0(arg_51_0._tf, "char")

			typeof = var_3
			DftAniEvent = var_4
			arg_51_0.otherDft = var_1(var_51_1, var_3(var_4))

			local var_51_2 = arg_51_0.otherDft

			var_1.SetEndEvent(var_51_2, function()
				if arg_51_0.leaveCallback then
					arg_51_0.leaveCallback()
				end

				local var_52_0 = arg_51_0

				var_0.dispose(var_52_0)

				return
			end)

			math = var_1
			arg_51_0._leaveTime = var_1.random(arg_51_0._data.time[1], arg_51_0._data.time[2])

			return
		end,
		step = function(arg_53_0)
			if arg_53_0.removeFlag then
				return
			end

			local var_53_0 = arg_53_0._leaveTime

			Time = var_2_10002
			arg_53_0._leaveTime = var_53_0 - var_2_10002.deltaTime

			return
		end,
		getColliderBound = function(arg_54_0)
			return arg_54_0.collider.position, arg_54_0.collider.sizeDelta
		end,
		apear = function(arg_55_0)
			local var_55_0 = arg_55_0.otherAnimator

			var_1.SetTrigger(var_55_0, "apear")

			return
		end,
		damage = function(arg_56_0)
			pg = var_2_10001

			local var_56_0 = var_2_10001.CriMgr.GetInstance()

			var_1.PlaySoundEffect_V3(var_56_0, var_0_26)

			local var_56_1 = arg_56_0.otherAnimator

			var_1.SetTrigger(var_56_1, "damage")

			return
		end,
		leave = function(arg_57_0)
			local var_57_0 = arg_57_0.otherAnimator

			var_1.SetTrigger(var_57_0, "leave")

			return
		end,
		getLeaveTime = function(arg_58_0)
			return arg_58_0._leaveTime
		end,
		getScore = function(arg_59_0)
			return arg_59_0._score
		end,
		getType = function(arg_60_0)
			return arg_60_0._data.type
		end,
		getName = function(arg_61_0)
			return arg_61_0._name
		end,
		setSpeed = function(arg_62_0, arg_62_1)
			arg_62_0.otherAnimator.speed = arg_62_1

			return
		end,
		getPosition = function(arg_63_0)
			return arg_63_0._tf.position
		end,
		dispose = function(arg_64_0)
			arg_64_0.leaveCallback = nil

			if arg_64_0._tf then
				Destroy = var_1

				var_1(arg_64_0._tf)

				arg_64_0._tf = nil
			end

			arg_64_0.removeFlag = true

			return
		end
	}

	var_5.Ctor(var_50_0)

	return var_5
end

local function var_0_32(arg_65_0, arg_65_1, arg_65_2, arg_65_3, arg_65_4)
	local var_65_0 = {
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			GetComponent = var_1
			findTF = var_2_10002

			local var_66_0 = var_2_10002(arg_66_0._tf, "char")

			typeof = var_3
			Animator = var_4
			arg_66_0.enemyAnimator = var_1(var_66_0, var_3(var_4))
			GetComponent = var_1
			findTF = var_66_0

			local var_66_1 = var_66_0(arg_66_0._tf, "char")

			typeof = var_3
			DftAniEvent = var_4
			arg_66_0.enemyDft = var_1(var_66_1, var_3(var_4))
			findTF = var_1
			arg_66_0.collider = var_1(arg_66_0._tf, "collider")
			findTF = var_1
			arg_66_0.throwPos = var_1(arg_66_0._tf, "throwPos")

			local var_66_2 = arg_66_0.enemyDft

			var_1.SetEndEvent(var_66_2, function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				local var_67_0 = arg_66_0

				var_0.dispose(var_67_0)

				return
			end)

			local var_66_3 = arg_66_0.enemyDft

			var_1.SetTriggerEvent(var_66_3, function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			math = var_1
			arg_66_0._leaveTime = var_1.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}

	function var_65_0.setThrowCallback(arg_69_0, arg_69_1)
		var_65_0._throwCallback = arg_69_1

		return
	end

	function var_65_0.getColliderBound(arg_70_0)
		return arg_70_0.collider.position, arg_70_0.collider.sizeDelta
	end

	function var_65_0.step(arg_71_0)
		if arg_71_0.removeFlag then
			return
		end

		local var_71_0 = arg_71_0._leaveTime

		Time = var_2_10002
		arg_71_0._leaveTime = var_71_0 - var_2_10002.deltaTime

		local var_71_1 = arg_71_0._activeTime

		Time = var_2
		arg_71_0._activeTime = var_71_1 + var_2.deltaTime

		if arg_71_0._activeTime > var_0_22 then
			arg_71_0._activeTime = 0

			if arg_71_0:getSnowball() then
				arg_71_0:throw()

				local var_71_2 = arg_71_0.enemyAnimator

				var_1.SetBool(var_71_2, "snowball", false)
			else
				local var_71_3 = arg_71_0.enemyAnimator

				var_1.SetBool(var_71_3, "snowball", true)
				arg_71_0:reload()
			end
		end

		return
	end

	function var_65_0.apear(arg_72_0)
		local var_72_0 = arg_72_0.enemyAnimator

		var_1.SetTrigger(var_72_0, "apear")

		return
	end

	function var_65_0.damage(arg_73_0)
		pg = var_2_10001

		local var_73_0 = var_2_10001.CriMgr.GetInstance()

		var_1.PlaySoundEffect_V3(var_73_0, var_0_26)

		local var_73_1 = arg_73_0.enemyAnimator

		var_1.SetTrigger(var_73_1, "damage")

		return
	end

	function var_65_0.leave(arg_74_0)
		local var_74_0 = arg_74_0.enemyAnimator

		var_1.SetTrigger(var_74_0, "leave")

		return
	end

	function var_65_0.reload(arg_75_0)
		local var_75_0 = arg_75_0.enemyAnimator

		var_1.SetTrigger(var_75_0, "reload")

		return
	end

	function var_65_0.throw(arg_76_0)
		local var_76_0 = arg_76_0.enemyAnimator

		var_1.SetTrigger(var_76_0, "throw")

		return
	end

	function var_65_0.hit(arg_77_0)
		local var_77_0 = arg_77_0.enemyAnimator

		var_1.SetTrigger(var_77_0, "hit")

		return
	end

	function var_65_0.getSnowball(arg_78_0)
		local var_78_0 = arg_78_0.enemyAnimator

		return var_1.GetBool(var_78_0, "snowball")
	end

	function var_65_0.getLeaveTime(arg_79_0)
		return arg_79_0._leaveTime
	end

	function var_65_0.getType(arg_80_0)
		return arg_80_0._data.type
	end

	function var_65_0.getScore(arg_81_0)
		return arg_81_0._score
	end

	function var_65_0.setSpeed(arg_82_0, arg_82_1)
		arg_82_0.enemyAnimator.speed = arg_82_1

		return
	end

	function var_65_0.getName(arg_83_0)
		return arg_83_0._name
	end

	function var_65_0.getPosition(arg_84_0)
		return arg_84_0._tf.position
	end

	function var_65_0.dispose(arg_85_0)
		arg_85_0.leaveCallback = nil

		if arg_85_0._tf then
			Destroy = var_1

			var_1(arg_85_0._tf)

			arg_85_0._tf = nil
		end

		arg_85_0.removeFlag = true

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

	function var_86_0.Ctor(arg_87_0)
		for iter_87_0 = 1, var_0_8 do
			arg_87_0.charators[iter_87_0] = 0
		end

		arg_87_0.throwCallback = nil
		arg_87_0.charactorDamageCallback = nil

		return
	end

	function var_86_0.prepare(arg_88_0)
		pairs = var_2_10001

		for iter_88_0, iter_88_1 in var_2_10001(arg_88_0.charators) do
			if iter_88_1 ~= 0 then
				iter_88_1:dispose()

				arg_88_0.charators[iter_88_0] = 0
			end
		end

		arg_88_0.gameStepTime = 0
		arg_88_0.apearStepTime = nil

		return
	end

	function var_86_0.step(arg_89_0)
		local var_89_0 = arg_89_0.gameStepTime

		Time = var_2_10002
		arg_89_0.gameStepTime = var_89_0 + var_2_10002.deltaTime

		if arg_89_0.gameStepTime > arg_89_0:getNextApearTime() then
			local var_89_1 = arg_89_0:getApearAmount()

			for iter_89_0 = 1, var_89_1 do
				arg_89_0:apearCharactor()
			end

			arg_89_0:setNextApearTime()
		end

		for iter_89_1 = 1, #arg_89_0.charators do
			if arg_89_0.charators[iter_89_1] ~= 0 then
				local var_89_2 = arg_89_0.charators[iter_89_1]
				local var_89_3 = var_5.getLeaveTime(var_89_2)
				local var_89_4 = arg_89_0.charators[iter_89_1]

				if var_6.getLeaveTime(var_89_4) < 0 then
					arg_89_0:leaveCharactor(iter_89_1)
				else
					local var_89_5 = arg_89_0.charators[iter_89_1]

					var_6.step(var_89_5)
				end
			end
		end

		return
	end

	function var_86_0.leaveCharactor(arg_90_0, arg_90_1)
		if arg_90_0.charators[arg_90_1] ~= 0 then
			local var_90_0 = arg_90_0.charators[arg_90_1]

			var_2.leave(var_90_0)

			arg_90_0.charators[arg_90_1] = 0
		end

		return
	end

	function var_86_0.removeCharactor(arg_91_0, arg_91_1)
		if arg_91_0.charators[arg_91_1] ~= 0 then
			arg_91_0.charators[arg_91_1] = 0
		end

		return
	end

	function var_86_0.damageEnemy(arg_92_0)
		for iter_92_0 = 1, #arg_92_0.charators do
			if arg_92_0.charators[iter_92_0] and arg_92_0.charators[iter_92_0] ~= 0 then
				local var_92_0 = arg_92_0.charators[iter_92_0]

				if var_5.getScore(var_92_0) > 0 then
					if arg_92_0.charactorDamageCallback then
						local var_92_1 = arg_92_0.charactorDamageCallback
						local var_92_2 = arg_92_0.charators[iter_92_0]
						local var_92_3 = var_6.getPosition(var_92_2)
						local var_92_4 = arg_92_0.charators[iter_92_0]

						var_92_1(var_92_3, var_7.getScore(var_92_4))
					end

					local var_92_5 = arg_92_0.charators[iter_92_0]

					var_5.damage(var_92_5)
					arg_92_0:removeCharactor(iter_92_0)
				end
			end
		end

		return
	end

	function var_86_0.getCharactorByIndex(arg_93_0, arg_93_1)
		return arg_93_0.charators[arg_93_1]
	end

	function var_86_0.apearCharactor(arg_94_0)
		if not arg_94_0:getAbleRandomDatas() then
			return
		end

		if not arg_94_0:getDataByWeight(var_1) then
			return
		end

		local var_94_0, var_94_1 = arg_94_0:getCharactorName(var_0_11[var_2.type])
		local var_94_2 = arg_94_0:getCharactorRandomIndex(var_2)

		if arg_94_0:createCharactor(var_2, var_94_2, var_94_0, var_94_1) then
			arg_94_0:addCharactor(var_6, var_94_2)
		end

		return
	end

	function var_86_0.setSpeed(arg_95_0, arg_95_1)
		arg_95_0.speedValue = arg_95_1

		for iter_95_0 = 1, #arg_95_0.charators do
			if arg_95_0.charators[iter_95_0] and arg_95_0.charators[iter_95_0] ~= 0 then
				local var_95_0 = arg_95_0.charators[iter_95_0]

				var_6.setSpeed(var_95_0, arg_95_1)
			end
		end

		return
	end

	function var_86_0.createCharactor(arg_96_0, arg_96_1, arg_96_2, arg_96_3, arg_96_4)
		tf = var_2_10005
		Instantiate = var_2_10006

		local var_96_0 = var_2_10005(var_2_10006(arg_96_0._tplCharactorDic[arg_96_3]))

		findTF = var_6

		local var_96_1 = var_6(arg_96_0._charactorContainer, arg_96_2)

		SetParent = var_7

		var_7(var_96_0, var_96_1)

		setActive = var_7

		var_7(var_96_0, true)

		local var_96_2

		if arg_96_1.type == var_0_9 then
			var_96_2 = var_0_31(arg_96_1, var_96_0, arg_96_2, arg_96_3, arg_96_4)
		elseif arg_96_1.type == var_0_10 then
			local var_96_3 = var_0_32(arg_96_1, var_96_0, arg_96_2, arg_96_3, arg_96_4)

			var_96_2.setThrowCallback(var_96_3, arg_96_0.throwCallback)
		end

		return var_96_2
	end

	function var_86_0.addCharactor(arg_97_0, arg_97_1, arg_97_2)
		arg_97_0.charators[arg_97_2] = arg_97_1

		arg_97_1:apear()

		return
	end

	function var_86_0.getCharactorRandomIndex(arg_98_0, arg_98_1)
		local var_98_0 = arg_98_0:getEmptyIndex()
		local var_98_1 = {}

		for iter_98_0 = 1, #var_98_0 do
			table = var_2_10008

			if var_2_10008.contains(arg_98_1.indexs, var_98_0[iter_98_0]) then
				table = var_2_10008

				var_2_10008.insert(var_98_1, var_98_0[iter_98_0])
			end
		end

		if #var_98_1 then
			math = var_4

			return var_98_1[var_4.random(1, #var_98_1)]
		end

		return nil
	end

	function var_86_0.getCharactorName(arg_99_0, arg_99_1)
		local var_99_0 = arg_99_1.skin_names

		math = var_2_10003

		local var_99_1 = var_2_10003.random(1, #arg_99_1.skin_names)

		return arg_99_1.skin_names[var_99_1], arg_99_1.score[var_99_1]
	end

	function var_86_0.getDataByWeight(arg_100_0, arg_100_1)
		if #arg_100_1 == 1 then
			return arg_100_1[1]
		else
			if not arg_100_0.charactorWeight then
				arg_100_0.charactorWeight = {}
				arg_100_0.charactorSubWeight = 0

				for iter_100_0 = 1, #arg_100_1 do
					arg_100_0.charactorSubWeight = arg_100_0.charactorSubWeight + arg_100_1[iter_100_0].weight
					table = var_6

					var_6.insert(arg_100_0.charactorWeight, arg_100_0.charactorSubWeight)
				end
			end

			math = var_2

			local var_100_0 = var_2.random(0, arg_100_0.charactorSubWeight)

			for iter_100_1 = #arg_100_0.charactorWeight - 1, 1, -1 do
				if var_100_0 > arg_100_0.charactorWeight[iter_100_1] then
					return arg_100_1[iter_100_1 + 1]
				end
			end

			return arg_100_1[1]
		end

		return nil
	end

	function var_86_0.getAbleRandomDatas(arg_101_0)
		local var_101_0 = {}

		if #arg_101_0:getEmptyIndex() == 0 then
			return var_101_0
		end

		for iter_101_0 = 1, #var_0_23 do
			local var_101_1 = var_0_23[iter_101_0].indexs
			local var_101_2

			ipairs = var_2_10009

			for iter_101_1, iter_101_2 in var_2_10009(var_101_1) do
				table = var_2_10014

				if var_2_10014.contains(var_2, iter_101_2) and not var_101_2 then
					table = var_2_10014

					var_2_10014.insert(var_101_0, var_0_23[iter_101_0])

					var_101_2 = true
				end
			end
		end

		return var_101_0
	end

	function var_86_0.getEmptyIndex(arg_102_0)
		local var_102_0 = {}

		pairs = var_2_10002

		for iter_102_0, iter_102_1 in var_2_10002(arg_102_0.charators) do
			if iter_102_1 == 0 then
				table = var_2_10007

				var_2_10007.insert(var_102_0, iter_102_0)
			end
		end

		return var_102_0
	end

	function var_86_0.getNextApearTime(arg_103_0)
		if not arg_103_0.apearStepTime then
			arg_103_0:setNextApearTime()
		end

		return arg_103_0.apearStepTime
	end

	function var_86_0.setNextApearTime(arg_104_0)
		if not arg_104_0.apearStepTime then
			arg_104_0.apearStepTime = 0
		end

		arg_104_0.apearStepTime = arg_104_0.apearStepTime + arg_104_0:getApearTime()

		return
	end

	function var_86_0.getApearTime(arg_105_0)
		local var_105_0 = 1

		for iter_105_0 = #var_0_21, 1, -1 do
			if arg_105_0.gameStepTime > var_0_21[iter_105_0] then
				var_105_0 = iter_105_0

				break
			end
		end

		local var_105_1 = var_0_19[var_105_0][2] - var_0_19[var_105_0][1]
		local var_105_2 = var_0_19[var_105_0][1]

		math = var_4

		return var_4.random() * var_105_1 + var_105_2
	end

	function var_86_0.getApearAmount(arg_106_0)
		local var_106_0 = 1

		for iter_106_0 = #var_0_21, 1, -1 do
			if arg_106_0.gameStepTime > var_0_21[iter_106_0] then
				var_106_0 = iter_106_0

				break
			end
		end

		local var_106_1 = var_0_20[var_106_0]
		local var_106_2 = 0
		local var_106_3 = {}

		for iter_106_1 = 1, #var_106_1 do
			var_106_2 = var_106_2 + var_106_1[iter_106_1]
			table = var_9

			var_9.insert(var_106_3, var_106_2)
		end

		math = var_5

		local var_106_4 = var_5.random(0, var_106_2)

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

	function var_107_0.step(arg_110_0)
		local var_110_0 = arg_110_0._snowballCtrl
		local var_110_1 = var_1.getSnowballs(var_110_0)

		for iter_110_0 = 1, #var_110_1 do
			local var_110_2 = var_110_1[iter_110_0]
			local var_110_3 = var_6.getType(var_110_2)
			local var_110_4 = var_110_1[iter_110_0]
			local var_110_5 = var_7.getIndex(var_110_4)
			local var_110_6 = arg_107_3
			local var_110_7 = var_8.getCharactorByIndex(var_110_6, var_110_5)

			if var_110_3 == var_0_3 then
				if var_110_7 and var_110_7 ~= 0 then
					local var_110_8, var_110_9 = var_110_7:getColliderBound()
					local var_110_10 = arg_110_0._sceneTf
					local var_110_11 = var_11.InverseTransformPoint(var_110_10, var_110_8)
					local var_110_12 = var_110_1[iter_110_0]

					if var_11.checkArrived(var_110_12, var_110_11, var_110_9) then
						var_110_7:damage()

						local var_110_13 = arg_110_0._snowballCtrl
						local var_110_14 = var_11.snowballHit
						local var_110_15 = var_110_1[iter_110_0]

						var_110_14(var_110_13, var_13.getId(var_110_15))

						local var_110_16 = arg_107_3

						var_11.removeCharactor(var_110_16, var_110_5)

						if arg_110_0.hitEnemyCallback then
							arg_110_0.hitEnemyCallback(var_110_7:getType(), var_110_7:getName(), var_110_7:getScore(), var_110_7:getPosition())
						end
					end
				end
			elseif var_110_3 == var_0_4 then
				local var_110_17 = arg_110_0._player
				local var_110_18, var_110_19 = var_9.getColliderBound(var_110_17)
				local var_110_20 = arg_110_0._sceneTf
				local var_110_21 = var_11.InverseTransformPoint(var_110_20, var_110_18)
				local var_110_22 = var_110_1[iter_110_0]

				if var_11.checkArrived(var_110_22, var_110_21, var_110_19) then
					if var_110_7 and var_110_7 ~= 0 and var_110_7:getType() == var_0_10 then
						var_110_7:hit()
					end

					local var_110_23 = arg_110_0._player

					var_11.damage(var_110_23)

					local var_110_24 = arg_110_0._snowballCtrl
					local var_110_25 = var_11.snowballHit
					local var_110_26 = var_110_1[iter_110_0]

					var_110_25(var_110_24, var_13.getId(var_110_26))
				end
			end
		end

		return
	end

	var_107_0:Ctor()

	return var_107_0
end

function var_0_1.getUIName(arg_111_0)
	return "SnowballGameUI"
end

function var_0_1.getBGM(arg_112_0)
	return "backyard"
end

function var_0_1.didEnter(arg_113_0)
	arg_113_0:initData()
	arg_113_0:initUI()

	return
end

function var_0_1.initData(arg_114_0)
	Timer = var_1_10001
	arg_114_0.timer = var_1_10001.New(function()
		local var_115_0 = arg_114_0

		var_0.onTimer(var_115_0)

		return
	end, 0.016666666666666666, -1)

	return
end

function var_0_1.initUI(arg_116_0)
	findTF = var_1_10001
	arg_116_0.sceneTf = var_1_10001(arg_116_0._tf, "scene")
	findTF = var_1
	arg_116_0.clickMask = var_1(arg_116_0._tf, "clickMask")

	local var_116_0 = var_0_28

	findTF = var_2
	arg_116_0.player = var_116_0(var_2(arg_116_0._tf, "scene/luao"))

	function arg_116_0.player.throwCallback(arg_117_0)
		local var_117_0 = arg_116_0

		var_1.onPlayerThrowSnowball(var_117_0, arg_117_0)

		return
	end

	function arg_116_0.player.damageCallback()
		local var_118_0 = arg_116_0

		var_0.onPlayerDamage(var_118_0)

		return
	end

	local var_116_1 = arg_116_0.player

	function var_116_1.gameOverCallback()
		local var_119_0 = arg_116_0

		var_0.onGameOver(var_119_0)

		return
	end

	findTF = var_116_1
	arg_116_0.snowballContainer = var_116_1(arg_116_0._tf, "scene_front/snowballContainer")
	findTF = var_1
	arg_116_0.tplSnowball = var_1(arg_116_0._tf, "tplSnowball")
	arg_116_0.snowballController = var_0_30(arg_116_0.snowballContainer, arg_116_0.tplSnowball)
	findTF = var_1
	arg_116_0.tplScore = var_1(arg_116_0._tf, "tplScore")
	findTF = var_1
	arg_116_0.specialTf = var_1(arg_116_0._tf, "scene_front/special")
	GetComponent = var_1

	local var_116_2 = arg_116_0.specialTf

	typeof = var_3
	Animator = var_4
	arg_116_0.specialAniamtor = var_1(var_116_2, var_3(var_4))
	GetComponent = var_1

	local var_116_3 = arg_116_0.specialTf

	typeof = var_3
	DftAniEvent = var_4

	local var_116_4 = var_1(var_116_3, var_3(var_4))

	var_1.SetTriggerEvent(var_116_4, function()
		local var_120_0 = arg_116_0

		var_0.specialComplete(var_120_0)

		return
	end)

	findTF = var_2
	arg_116_0.charactorContainer = var_2(arg_116_0._tf, "scene/charactorContainer")

	local var_116_5 = {}

	pairs = var_3

	for iter_116_0, iter_116_1 in var_3(var_0_11) do
		var_1_10008 = iter_116_1.skin_names
		ipairs = var_1_10009

		for iter_116_2, iter_116_3 in var_1_10009(var_1_10008) do
			findTF = var_1_10014
			var_116_5[iter_116_3] = var_1_10014(arg_116_0._tf, "charactor/" .. iter_116_3)
		end
	end

	arg_116_0.charactorController = var_0_33(arg_116_0.charactorContainer, var_116_5)

	function arg_116_0.charactorController.throwCallback(arg_121_0, arg_121_1)
		function arg_116_0.charactorController.charactorDamageCallback(arg_122_0, arg_122_1)
			local var_122_0 = arg_116_0

			var_2.onHitEnemy(var_122_0, arg_122_1, arg_122_0)

			return
		end

		local var_121_0 = var_0_18
		local var_121_1 = arg_116_0
		local var_121_2 = var_121_0[var_3.getCurrentDiff(var_121_1)]
		local var_121_3 = arg_116_0

		var_3.onEnemyThrowSnowball(var_121_3, arg_121_0, arg_121_1, var_121_2)

		return
	end

	arg_116_0.colliderController = var_0_34(arg_116_0.sceneTf, arg_116_0.player, arg_116_0.snowballController, arg_116_0.charactorController)

	local var_116_6 = arg_116_0.colliderController

	function var_116_6.hitEnemyCallback(arg_123_0, arg_123_1, arg_123_2, arg_123_3)
		local var_123_0 = arg_116_0

		var_4.onHitEnemy(var_123_0, arg_123_2, arg_123_3)

		return
	end

	findTF = var_116_6

	local var_116_7 = var_116_6(arg_116_0._tf, "scene/moveCollider")

	arg_116_0.playerMoveVecs = {}

	for iter_116_4 = 1, var_0_7 do
		findTF = var_1_10008
		var_1_10008 = var_1_10008(var_116_7, iter_116_4)
		table = var_1_10009

		var_1_10009.insert(arg_116_0.playerMoveVecs, var_1_10008.anchoredPosition)
	end

	findTF = var_4
	arg_116_0.lockTf = var_4(arg_116_0._tf, "scene_front/lock")
	findTF = var_4

	local var_116_8 = var_4(arg_116_0._tf, "scene/throwCollider")

	for iter_116_5 = 1, var_0_8 do
		findTF = var_1_10009
		var_1_10009 = var_1_10009(var_116_8, iter_116_5)

		local var_116_9 = iter_116_5

		onButton = var_1_10011

		var_1_10011(arg_116_0, var_1_10009, function()
			local var_124_0 = arg_116_0.charactorController

			if var_0.getCharactorByIndex(var_124_0, var_116_9) and var_0 ~= 0 then
				findTF = var_124_0

				local var_124_1 = var_124_0(var_1_10009, "target").position
				local var_124_2 = arg_116_0.sceneTf
				local var_124_3 = var_2.InverseTransformPoint(var_124_2, var_124_1.x, var_124_1.y, 0)
				local var_124_4 = arg_116_0

				var_3.throwSnowballTo(var_124_4, var_124_3, var_116_9, var_0)
			end

			return
		end)
	end

	findTF = var_5
	arg_116_0.countUI = var_5(arg_116_0._tf, "pop/CountUI")
	GetComponent = var_5
	findTF = var_6

	local var_116_10 = var_6(arg_116_0.countUI, "count")

	typeof = var_7
	Animator = var_8
	arg_116_0.countAnimator = var_5(var_116_10, var_7(var_8))
	GetComponent = var_5
	findTF = var_116_10

	local var_116_11 = var_116_10(arg_116_0.countUI, "count")

	typeof = var_7
	DftAniEvent = var_8
	arg_116_0.countDft = var_5(var_116_11, var_7(var_8))

	local var_116_12 = arg_116_0.countDft

	var_5.SetTriggerEvent(var_116_12, function()
		return
	end)

	local var_116_13 = arg_116_0.countDft

	var_5.SetEndEvent(var_116_13, function()
		setActive = var_2_10000

		var_2_10000(arg_116_0.countUI, false)

		local var_126_0 = arg_116_0

		var_0.gameStart(var_126_0)

		return
	end)

	findTF = var_5
	arg_116_0.leaveUI = var_5(arg_116_0._tf, "pop/LeaveUI")
	onButton = var_5

	local var_116_14 = arg_116_0

	findTF = var_7

	local var_116_15 = var_7(arg_116_0.leaveUI, "ad/btnOk")

	local function var_116_16()
		local var_127_0 = arg_116_0

		var_0.resumeGame(var_127_0)

		local var_127_1 = arg_116_0.player

		var_0.settlement(var_127_1, var_0_5)

		local var_127_2 = arg_116_0

		var_0.onGameOver(var_127_2)

		return
	end

	SFX_CANCEL = var_9

	var_5(var_116_14, var_116_15, var_116_16, var_9)

	onButton = var_5

	local var_116_17 = arg_116_0

	findTF = var_116_15

	local var_116_18 = var_116_15(arg_116_0.leaveUI, "ad/btnCancel")

	local function var_116_19()
		local var_128_0 = arg_116_0

		var_0.resumeGame(var_128_0)

		return
	end

	SFX_CANCEL = var_9

	var_5(var_116_17, var_116_18, var_116_19, var_9)

	findTF = var_5
	arg_116_0.pauseUI = var_5(arg_116_0._tf, "pop/pauseUI")
	onButton = var_5

	local var_116_20 = arg_116_0

	findTF = var_7

	local var_116_21 = var_7(arg_116_0.pauseUI, "ad/btnOk")

	local function var_116_22()
		setActive = var_2_10000

		var_2_10000(arg_116_0.pauseUI, false)

		local var_129_0 = arg_116_0

		var_0.resumeGame(var_129_0)

		return
	end

	SFX_CANCEL = var_9

	var_5(var_116_20, var_116_21, var_116_22, var_9)

	findTF = var_5
	arg_116_0.settlementUI = var_5(arg_116_0._tf, "pop/SettleMentUI")
	onButton = var_5

	local var_116_23 = arg_116_0

	findTF = var_7

	local var_116_24 = var_7(arg_116_0.settlementUI, "ad/btnOver")

	local function var_116_25()
		setActive = var_2_10000

		var_2_10000(arg_116_0.settlementUI, false)

		local var_130_0 = arg_116_0

		var_0.openMenuUI(var_130_0)

		return
	end

	SFX_CANCEL = var_9

	var_5(var_116_23, var_116_24, var_116_25, var_9)

	findTF = var_5
	arg_116_0.menuUI = var_5(arg_116_0._tf, "pop/menuUI")
	GetComponent = var_5
	findTF = var_6

	local var_116_26 = var_6(arg_116_0.menuUI, "battList")

	typeof = var_7
	ScrollRect = var_8
	arg_116_0.battleScrollRect = var_5(var_116_26, var_7(var_8))
	arg_116_0.totalTimes = arg_116_0:getGameTotalTime()

	local var_116_27, var_116_28

	if arg_116_0:getGameUsedTimes() - 4 < 0 then
		var_116_27 = 0
	else
		var_116_28 = arg_116_0
		var_116_27 = arg_116_0.getGameUsedTimes(var_116_28) - 4
	end

	scrollTo = var_116_28

	var_116_28(arg_116_0.battleScrollRect, 0, 1 - var_116_27 / (arg_116_0.totalTimes - 4))

	onButton = var_116_28

	local var_116_29 = arg_116_0

	findTF = var_8

	local var_116_30 = var_8(arg_116_0.menuUI, "rightPanelBg/arrowUp")

	local function var_116_31()
		local var_131_0 = arg_116_0.battleScrollRect.normalizedPosition.y + 1 / (arg_116_0.totalTimes - 4)

		if 1 < var_131_0 then
			var_131_0 = 1
		end

		scrollTo = var_1

		var_1(arg_116_0.battleScrollRect, 0, var_131_0)

		return
	end

	SFX_CANCEL = var_10

	var_116_28(var_116_29, var_116_30, var_116_31, var_10)

	onButton = var_116_28

	local var_116_32 = arg_116_0

	findTF = var_116_30

	local var_116_33 = var_116_30(arg_116_0.menuUI, "rightPanelBg/arrowDown")

	local function var_116_34()
		local var_132_0

		if arg_116_0.battleScrollRect.normalizedPosition.y - 1 / (arg_116_0.totalTimes - 4) < 0 then
			var_132_0 = 0
		end

		scrollTo = var_1

		var_1(arg_116_0.battleScrollRect, 0, var_132_0)

		return
	end

	SFX_CANCEL = var_10

	var_116_28(var_116_32, var_116_33, var_116_34, var_10)

	onButton = var_116_28

	local var_116_35 = arg_116_0

	findTF = var_116_33

	local var_116_36 = var_116_33(arg_116_0.menuUI, "btnBack")

	local function var_116_37()
		local var_133_0 = arg_116_0

		var_0.closeView(var_133_0)

		return
	end

	SFX_CANCEL = var_10

	var_116_28(var_116_35, var_116_36, var_116_37, var_10)

	onButton = var_116_28

	local var_116_38 = arg_116_0

	findTF = var_116_36

	local var_116_39 = var_116_36(arg_116_0.menuUI, "btnRule")

	local function var_116_40()
		pg = var_2_10000

		local var_134_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_134_1 = var_0.ShowMsgBox
		local var_134_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_134_2.type = var_2_10003
		pg = var_2_10003
		var_134_2.helps = var_2_10003.gametip.snowball_help.tip

		var_134_1(var_134_0, var_134_2)

		return
	end

	SFX_CANCEL = var_10

	var_116_28(var_116_38, var_116_39, var_116_40, var_10)

	onButton = var_116_28

	local var_116_41 = arg_116_0

	findTF = var_116_39

	local var_116_42 = var_116_39(arg_116_0.menuUI, "btnStart")

	local function var_116_43()
		setActive = var_2_10000

		var_2_10000(arg_116_0.menuUI, false)

		local var_135_0 = arg_116_0

		var_0.readyStart(var_135_0)

		return
	end

	SFX_CANCEL = var_10

	var_116_28(var_116_41, var_116_42, var_116_43, var_10)

	findTF = var_116_28

	local var_116_44 = var_116_28(arg_116_0.menuUI, "tplBattleItem")

	arg_116_0.battleItems = {}

	for iter_116_6 = 1, arg_116_0.totalTimes do
		tf = var_1_10011
		instantiate = iter_116_2
		var_1_10011 = var_1_10011(iter_116_2(var_116_44))
		var_1_10011.name = "battleItem_" .. iter_116_6
		setParent = iter_116_2

		local var_116_45 = var_1_10011

		findTF = var_1_10014

		iter_116_2(var_116_45, var_1_10014(arg_116_0.menuUI, "battList/Viewport/Content"))

		iter_116_2 = iter_116_6
		GetSpriteFromAtlasAsync = var_116_45

		var_116_45("ui/minigameui/snowballgameui_atlas", "tx_" .. iter_116_2, function(arg_136_0)
			setImageSprite = var_2_10001
			findTF = var_2_10002

			var_2_10001(var_2_10002(var_1_10011, "state_open/icon"), arg_136_0, true)

			setImageSprite = var_2_10001
			findTF = var_2

			var_2_10001(var_2(var_1_10011, "state_clear/icon"), arg_136_0, true)

			setImageSprite = var_2_10001
			findTF = var_2

			var_2_10001(var_2(var_1_10011, "state_current/icon"), arg_136_0, true)

			return
		end)

		GetSpriteFromAtlasAsync = var_116_45

		var_116_45("ui/minigameui/snowballgameui_atlas", "battleDesc" .. iter_116_2, function(arg_137_0)
			setImageSprite = var_2_10001
			findTF = var_2_10002

			var_2_10001(var_2_10002(var_1_10011, "state_open/buttomDesc"), arg_137_0, true)

			setImageSprite = var_2_10001
			findTF = var_2

			var_2_10001(var_2(var_1_10011, "state_clear/buttomDesc"), arg_137_0, true)

			setImageSprite = var_2_10001
			findTF = var_2

			var_2_10001(var_2(var_1_10011, "state_current/buttomDesc"), arg_137_0, true)

			setImageSprite = var_2_10001
			findTF = var_2

			var_2_10001(var_2(var_1_10011, "state_closed/buttomDesc"), arg_137_0, true)

			return
		end)

		setActive = var_116_45

		var_116_45(var_1_10011, true)

		table = var_116_45

		var_116_45.insert(arg_116_0.battleItems, var_1_10011)
	end

	findTF = var_7
	arg_116_0.gameUI = var_7(arg_116_0._tf, "ui/gameUI")
	findTF = var_7
	arg_116_0.lifeProgress = var_7(arg_116_0.gameUI, "lifeProgress")
	findTF = var_7
	arg_116_0.textLife = var_7(arg_116_0.gameUI, "life")
	findTF = var_7
	arg_116_0.textScore = var_7(arg_116_0.gameUI, "score")
	onButton = var_7

	local var_116_46 = arg_116_0

	findTF = var_9

	var_7(var_116_46, var_9(arg_116_0.gameUI, "btnStop"), function()
		local var_138_0 = arg_116_0

		var_0.stopGame(var_138_0)

		setActive = var_0

		var_0(arg_116_0.pauseUI, true)

		return
	end)

	onButton = var_7

	local var_116_47 = arg_116_0

	findTF = var_9

	var_7(var_116_47, var_9(arg_116_0.gameUI, "btnLeave"), function()
		local var_139_0 = arg_116_0

		var_0.stopGame(var_139_0)

		setActive = var_0

		var_0(arg_116_0.leaveUI, true)

		return
	end)

	onButton = var_7

	local var_116_48 = arg_116_0

	findTF = var_9

	var_7(var_116_48, var_9(arg_116_0.gameUI, "btnMoveUp"), function()
		if arg_116_0.playerPosIndex > 1 then
			arg_116_0.playerPosIndex = arg_116_0.playerPosIndex - 1

			local var_140_0 = arg_116_0

			var_0.movePlayerTo(var_140_0, arg_116_0.playerPosIndex)
		end

		return
	end)

	onButton = var_7

	local var_116_49 = arg_116_0

	findTF = var_9

	var_7(var_116_49, var_9(arg_116_0.gameUI, "btnMoveDown"), function()
		if arg_116_0.playerPosIndex < #arg_116_0.playerMoveVecs then
			arg_116_0.playerPosIndex = arg_116_0.playerPosIndex + 1

			local var_141_0 = arg_116_0

			var_0.movePlayerTo(var_141_0, arg_116_0.playerPosIndex)
		end

		return
	end)

	findTF = var_7
	arg_116_0.btnSkill = var_7(arg_116_0.gameUI, "btnSkill")
	onButton = var_7

	var_7(arg_116_0, arg_116_0.btnSkill, function()
		if arg_116_0.skilTime == var_0_15 then
			arg_116_0.skilTime = 0

			local var_142_0 = arg_116_0

			var_0.usePlayerSkill(var_142_0)
		end

		return
	end)
	arg_116_0:updateMenuUI()
	arg_116_0:openMenuUI()

	if not arg_116_0.handle then
		UpdateBeat = var_7
		arg_116_0.handle = var_7:CreateListener(arg_116_0.Update, arg_116_0)
	end

	UpdateBeat = var_7

	var_7:AddListener(arg_116_0.handle)

	return
end

function var_0_1.Update(arg_143_0)
	arg_143_0:AddDebugInput()

	return
end

function var_0_1.AddDebugInput(arg_144_0)
	if arg_144_0.gameStop or arg_144_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		Input = var_1

		local var_144_0 = var_1.GetKeyDown

		KeyCode = var_1_10002

		local var_144_1, var_144_2

		if var_144_0(var_1_10002.W) and arg_144_0.playerPosIndex then
			var_144_1 = arg_144_0.playerPosIndex

			if 1 < var_144_1 then
				arg_144_0.playerPosIndex = arg_144_0.playerPosIndex - 1
				var_144_2 = arg_144_0

				arg_144_0.movePlayerTo(var_144_2, arg_144_0.playerPosIndex)
			end
		end

		Input = var_144_1

		local var_144_3 = var_144_1.GetKeyDown

		KeyCode = var_144_2

		if var_144_3(var_144_2.S) and arg_144_0.playerPosIndex and arg_144_0.playerPosIndex < #arg_144_0.playerMoveVecs then
			arg_144_0.playerPosIndex = arg_144_0.playerPosIndex + 1

			arg_144_0:movePlayerTo(arg_144_0.playerPosIndex)
		end
	end

	return
end

function var_0_1.getCurrentDiff(arg_145_0)
	for iter_145_0 = #var_0_21, 1, -1 do
		if arg_145_0.gameStepTime > var_0_21[iter_145_0] then
			return iter_145_0
		end
	end

	return
end

function var_0_1.updateMenuUI(arg_146_0)
	local var_146_0 = arg_146_0:getGameUsedTimes()
	local var_146_1 = arg_146_0:getGameTimes()

	for iter_146_0 = 1, #arg_146_0.battleItems do
		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_146_0.battleItems[iter_146_0], "state_open"), false)

		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_146_0.battleItems[iter_146_0], "state_closed"), false)

		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_146_0.battleItems[iter_146_0], "state_clear"), false)

		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_146_0.battleItems[iter_146_0], "state_current"), false)

		if iter_146_0 <= var_146_0 then
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_146_0.battleItems[iter_146_0], "state_clear"), true)
		elseif iter_146_0 == var_146_0 + 1 and 1 <= var_146_1 then
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_146_0.battleItems[iter_146_0], "state_current"), true)
		elseif var_146_0 < iter_146_0 and iter_146_0 <= var_146_0 + var_146_1 then
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_146_0.battleItems[iter_146_0], "state_open"), true)
		else
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_146_0.battleItems[iter_146_0], "state_closed"), true)
		end
	end

	arg_146_0.totalTimes = arg_146_0:getGameTotalTime()

	local var_146_2 = 1 - (arg_146_0:getGameUsedTimes() - 3 < 0 and 0 or arg_146_0:getGameUsedTimes() - 3) / (arg_146_0.totalTimes - 4)

	if 1 < var_146_2 then
		var_146_2 = 1
	end

	scrollTo = var_5

	var_5(arg_146_0.battleScrollRect, 0, var_146_2)

	setActive = var_5
	findTF = var_6

	var_5(var_6(arg_146_0.menuUI, "btnStart/tip"), var_146_1 > 0)
	arg_146_0:CheckGet()

	return
end

function var_0_1.CheckGet(arg_147_0)
	setActive = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_147_0.menuUI, "got"), false)

	if arg_147_0:getUltimate() then
		local var_147_0 = arg_147_0

		if arg_147_0.getUltimate(var_147_0) ~= 0 then
			setActive = var_1
			findTF = var_147_0

			var_1(var_147_0(arg_147_0.menuUI, "got"), true)
		end
	end

	if arg_147_0:getUltimate() == 0 then
		local var_147_1 = arg_147_0:getGameTotalTime()
		local var_147_2 = arg_147_0

		if var_147_1 > arg_147_0.getGameUsedTimes(var_147_2) then
			return
		end

		pg = var_147_2

		local var_147_3 = var_147_2.m02
		local var_147_4 = var_3.sendNotification

		GAME = var_1_10005

		local var_147_5 = var_1_10005.SEND_MINI_GAME_OP
		local var_147_6 = {
			hubid = arg_147_0:GetMGHubData().id
		}

		MiniGameOPCommand = var_7
		var_147_6.cmd = var_7.CMD_ULTIMATE
		var_147_6.args1 = {}

		var_147_4(var_147_3, var_147_5, var_147_6)

		setActive = var_147_4
		findTF = var_147_3

		var_147_4(var_147_3(arg_147_0.menuUI, "got"), true)
	end

	return
end

function var_0_1.openMenuUI(arg_148_0)
	setActive = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_148_0._tf, "scene_front"), false)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_148_0._tf, "scene_background"), false)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_148_0._tf, "scene"), false)

	setActive = var_1_10001

	var_1_10001(arg_148_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_148_0.menuUI, true)
	arg_148_0:updateMenuUI()

	return
end

function var_0_1.clearUI(arg_149_0)
	setActive = var_1_10001

	var_1_10001(arg_149_0.sceneTf, false)

	setActive = var_1_10001

	var_1_10001(arg_149_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_149_0.countUI, false)

	setActive = var_1_10001

	var_1_10001(arg_149_0.menuUI, false)

	setActive = var_1_10001

	var_1_10001(arg_149_0.gameUI, false)

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_150_0, arg_150_1)
	if arg_150_0.sendSuccessFlag then
		getProxy = var_2
		MiniGameProxy = var_1_10003

		local var_150_0 = var_2(var_1_10003)
		local var_150_1 = var_2.GetMiniGameData

		MiniGameDataCreator = var_1_10004

		local var_150_2 = var_150_1(var_150_0, var_1_10004.NewYearShrineGameID)
		local var_150_3

		if not var_2.GetRuntimeData(var_150_2, "count") then
			var_150_3 = 0
		end

		local var_150_4 = var_150_3 + 2

		pg = var_5

		local var_150_5 = var_5.m02
		local var_150_6 = var_5.sendNotification

		GAME = var_1_10007

		local var_150_7 = var_1_10007.MODIFY_MINI_GAME_DATA
		local var_150_8 = {}

		MiniGameDataCreator = var_1_10009
		var_150_8.id = var_1_10009.NewYearShrineGameID
		var_150_8.map = {
			count = var_150_4
		}

		var_150_6(var_150_5, var_150_7, var_150_8)

		arg_150_0.sendSuccessFlag = false
	end

	return
end

function var_0_1.readyStart(arg_151_0)
	setActive = var_1_10001

	var_1_10001(arg_151_0.countUI, true)

	local var_151_0 = arg_151_0.countAnimator

	var_1.Play(var_151_0, "count")

	pg = var_1

	local var_151_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_151_1, var_0_24)

	return
end

function var_0_1.gameStart(arg_152_0)
	setActive = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_152_0._tf, "scene_front"), true)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_152_0._tf, "scene_background"), true)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_152_0._tf, "scene"), true)

	setActive = var_1_10001

	var_1_10001(arg_152_0.gameUI, true)

	setActive = var_1_10001

	var_1_10001(arg_152_0.lockTf, false)

	arg_152_0.gameStartFlag = true
	arg_152_0.scoreNum = 0
	arg_152_0.skilTime = 0
	arg_152_0.playerPosIndex = 2

	arg_152_0:movePlayerTo(arg_152_0.playerPosIndex)

	arg_152_0.specialTime = 0
	arg_152_0.gameStepTime = 0

	local var_152_0 = arg_152_0.player

	var_1.prepare(var_152_0)

	local var_152_1 = arg_152_0.snowballController

	var_1.prepare(var_152_1)

	local var_152_2 = arg_152_0.charactorController

	var_1.prepare(var_152_2)

	local var_152_3 = arg_152_0.colliderController

	var_1.prepare(var_152_3)
	arg_152_0:updateGameUI()
	arg_152_0:timerStart()

	return
end

function var_0_1.onPlayerDamage(arg_153_0)
	arg_153_0:updateGameUI()

	return
end

function var_0_1.getGameTimes(arg_154_0)
	return arg_154_0:GetMGHubData().count
end

function var_0_1.getGameUsedTimes(arg_155_0)
	return arg_155_0:GetMGHubData().usedtime
end

function var_0_1.getUltimate(arg_156_0)
	return arg_156_0:GetMGHubData().ultimate
end

function var_0_1.getGameTotalTime(arg_157_0)
	local var_157_0 = arg_157_0:GetMGHubData()

	return (var_1.getConfig(var_157_0, "reward_need"))
end

function var_0_1.changeSpeed(arg_158_0, arg_158_1)
	local var_158_0 = arg_158_0.player

	var_2.setSpeed(var_158_0, arg_158_1)

	arg_158_0.specialAniamtor.speed = arg_158_1

	local var_158_1 = arg_158_0.charactorController

	var_2.setSpeed(var_158_1, arg_158_1)

	return
end

function var_0_1.onTimer(arg_159_0)
	local var_159_0 = arg_159_0.player

	var_1.step(var_159_0)

	local var_159_1 = arg_159_0.snowballController

	var_1.step(var_159_1)

	local var_159_2 = arg_159_0.charactorController

	var_1.step(var_159_2)

	local var_159_3 = arg_159_0.colliderController

	var_1.step(var_159_3)
	arg_159_0:gameStep()

	return
end

function var_0_1.gameStep(arg_160_0)
	local var_160_0 = arg_160_0.gameStepTime

	Time = var_1_10002
	arg_160_0.gameStepTime = var_160_0 + var_1_10002.deltaTime

	local var_160_1 = arg_160_0.skilTime

	Time = var_2
	arg_160_0.skilTime = var_160_1 + var_2.deltaTime

	local var_160_2 = arg_160_0.skilTime

	if var_0_15 < var_160_2 then
		arg_160_0.skilTime = var_0_15
	end

	if not arg_160_0.skillProgress then
		GetComponent = var_1
		findTF = var_2

		local var_160_3 = var_2(arg_160_0.btnSkill, "progress")

		typeof = var_3
		Image = var_4
		arg_160_0.skillProgress = var_1(var_160_3, var_3(var_4))
	end

	arg_160_0.skillProgress.fillAmount = arg_160_0.skilTime / var_0_15

	if arg_160_0.skilTime == var_0_15 then
		isActive = var_1
		findTF = var_2

		if not var_1(var_2(arg_160_0.gameUI, "xuehezhan_zhiyuantiao")) then
			setActive = var_1
			findTF = var_2

			var_1(var_2(arg_160_0.gameUI, "xuehezhan_zhiyuantiao"), true)
		end
	else
		isActive = var_1
		findTF = var_2

		if var_1(var_2(arg_160_0.gameUI, "xuehezhan_zhiyuantiao")) then
			setActive = var_1
			findTF = var_2

			var_1(var_2(arg_160_0.gameUI, "xuehezhan_zhiyuantiao"), false)
		end
	end

	if arg_160_0.gameStepTime < arg_160_0.specialTime then
		if not arg_160_0.specialIndex then
			arg_160_0.specialIndex = 0
		end

		if arg_160_0.specialIndex > 20 then
			arg_160_0.specialIndex = 0

			local var_160_4 = arg_160_0.charactorController

			var_1.damageEnemy(var_160_4)
		end

		arg_160_0.specialIndex = arg_160_0.specialIndex + 1
	end

	return
end

function var_0_1.timerStart(arg_161_0)
	if not arg_161_0.timer.running then
		local var_161_0 = arg_161_0.timer

		var_1.Start(var_161_0)
	end

	return
end

function var_0_1.timerStop(arg_162_0)
	if arg_162_0.timer.running then
		local var_162_0 = arg_162_0.timer

		var_1.Stop(var_162_0)
	end

	return
end

function var_0_1.movePlayerTo(arg_163_0, arg_163_1)
	local var_163_0 = arg_163_0.player

	var_2.move(var_163_0, arg_163_0.playerMoveVecs[arg_163_1])

	return
end

function var_0_1.updateGameUI(arg_164_0)
	setSlider = var_1_10001

	local var_164_0 = arg_164_0.lifeProgress
	local var_164_1 = 0
	local var_164_2 = 1
	local var_164_3 = arg_164_0.player

	var_1_10001(var_164_0, var_164_1, var_164_2, var_5.getLife(var_164_3) / var_0_12)

	setText = var_1_10001

	local var_164_4 = arg_164_0.textLife
	local var_164_5 = arg_164_0.player

	var_1_10001(var_164_4, var_3.getLife(var_164_5) .. "/" .. var_0_12)

	setText = var_1_10001

	var_1_10001(arg_164_0.textScore, arg_164_0.scoreNum)

	return
end

function var_0_1.throwSnowballTo(arg_165_0, arg_165_1, arg_165_2, arg_165_3)
	arg_165_0.throwTarget = arg_165_1
	arg_165_0.targetIndex = arg_165_2

	local var_165_0 = arg_165_0.player

	if var_4.throw(var_165_0) and arg_165_0.targetCharactor ~= arg_165_3 then
		setActive = var_5

		var_5(arg_165_0.lockTf, false)

		local var_165_1 = arg_165_0.lockTf

		var_165_1.anchoredPosition = arg_165_1
		setActive = var_165_1

		var_165_1(arg_165_0.lockTf, true)

		arg_165_0.targetCharactor = arg_165_3
	end

	return
end

function var_0_1.onPlayerThrowSnowball(arg_166_0, arg_166_1)
	if arg_166_0.throwTarget then
		local var_166_0 = arg_166_0.sceneTf
		local var_166_1 = var_2.InverseTransformPoint(var_166_0, arg_166_1.x, arg_166_1.y, 0)
		local var_166_2 = arg_166_0.throwTarget
		local var_166_3 = arg_166_0.snowballController

		var_4.createSnowball(var_166_3, var_166_1, var_166_2, var_0_14, var_0_3, arg_166_0.targetIndex)

		arg_166_0.throwTarget = nil
		arg_166_0.targetIndex = nil
	end

	return
end

function var_0_1.onEnemyThrowSnowball(arg_167_0, arg_167_1, arg_167_2, arg_167_3)
	local var_167_0 = arg_167_0.sceneTf
	local var_167_1 = var_4.InverseTransformPoint(var_167_0, arg_167_1.x, arg_167_1.y, 0)
	local var_167_2 = arg_167_0.player
	local var_167_3 = var_5.getTargetPosition(var_167_2)
	local var_167_4 = arg_167_0.sceneTf
	local var_167_5 = var_6.InverseTransformPoint(var_167_4, var_167_3.x, var_167_3.y, 0)
	local var_167_6 = arg_167_0.snowballController

	var_7.createSnowball(var_167_6, var_167_1, var_167_5, arg_167_3, var_0_4, arg_167_2)

	return
end

function var_0_1.usePlayerSkill(arg_168_0)
	Time = var_1_10001
	var_1_10001.timeScale = 0.05
	LeanTween = var_1_10001

	local var_168_0 = var_1_10001.delayedCall

	go = var_2

	local var_168_1 = var_2(arg_168_0.specialTf)
	local var_168_2 = 3

	System = var_1_10004

	var_168_0(var_168_1, var_168_2, var_1_10004.Action(function()
		Time = var_2_10000

		if var_2_10000.timeScale ~= 1 then
			Time = var_0
			var_0.timeScale = 1
		end

		return
	end))

	local var_168_3 = arg_168_0.player

	var_1.skill(var_168_3)

	local var_168_4 = arg_168_0.snowballController

	var_1.clearEnemySnowball(var_168_4)

	setActive = var_1

	var_1(arg_168_0.specialTf, true)

	if not arg_168_0.specialEffect then
		findTF = var_1
		arg_168_0.specialEffect = var_1(arg_168_0._tf, "xuehezhan_xueqiuhongzha")
	end

	setActive = var_1

	var_1(arg_168_0.specialEffect, false)

	setActive = var_1

	var_1(arg_168_0.specialEffect, true)

	return
end

function var_0_1.specialComplete(arg_170_0)
	Time = var_1_10001
	var_1_10001.timeScale = 1
	setActive = var_1_10001

	var_1_10001(arg_170_0.specialTf, false)

	arg_170_0.specialTime = arg_170_0.gameStepTime + var_0_16
	arg_170_0.specialIndex = 0

	return
end

function var_0_1.dropSpeedUp(arg_171_0)
	return
end

function var_0_1.onHitEnemy(arg_172_0, arg_172_1, arg_172_2)
	arg_172_0:addScore(arg_172_1, arg_172_2)
	arg_172_0:updateGameUI()

	return
end

function var_0_1.addScore(arg_173_0, arg_173_1, arg_173_2)
	arg_173_0.scoreNum = arg_173_0.scoreNum + arg_173_1

	if arg_173_0.scoreNum < 0 then
		arg_173_0.scoreNum = 0
	end

	tf = var_3
	instantiate = var_4

	local var_173_0 = var_3(var_4(arg_173_0.tplScore))

	findTF = var_4

	local var_173_1 = var_4(var_173_0, "ad")

	GetComponent = var_5

	local var_173_2 = var_173_1

	typeof = var_1_10007
	DftAniEvent = var_1_10008

	local var_173_3 = var_5(var_173_2, var_1_10007(var_1_10008))
	local var_173_4 = arg_173_0.snowballContainer

	var_173_0.anchoredPosition = var_6.InverseTransformPoint(var_173_4, arg_173_2)

	if 0 < arg_173_1 then
		setActive = var_6
		findTF = var_173_4

		var_6(var_173_4(var_173_1, "add"), true)

		setText = var_6
		findTF = var_173_4

		var_6(var_173_4(var_173_1, "add"), "+" .. arg_173_1)
	else
		setActive = var_6
		findTF = var_173_4

		var_6(var_173_4(var_173_1, "sub"), true)

		setText = var_6
		findTF = var_7

		var_6(var_7(var_173_1, "sub"), arg_173_1)
	end

	setParent = var_6

	var_6(var_173_0, arg_173_0.snowballContainer)
	var_173_3:SetEndEvent(function()
		setActive = var_2_10000

		var_2_10000(var_173_0, false)

		Destroy = var_2_10000

		var_2_10000(var_173_0)

		return
	end)

	setActive = var_6

	var_6(var_173_0, true)

	return
end

function var_0_1.onGameOver(arg_175_0)
	arg_175_0:timerStop()

	arg_175_0.settlementFlag = true
	setActive = var_1

	var_1(arg_175_0.clickMask, true)

	LeanTween = var_1

	local var_175_0 = var_1.delayedCall

	go = var_2

	local var_175_1 = var_2(arg_175_0._tf)
	local var_175_2 = 2

	System = var_1_10004

	var_175_0(var_175_1, var_175_2, var_1_10004.Action(function()
		arg_175_0.settlementFlag = false

		local var_176_0 = arg_175_0

		var_176_0.gameStartFlag = false
		setActive = var_176_0

		var_176_0(arg_175_0.clickMask, false)

		setActive = var_176_0
		findTF = var_1

		var_176_0(var_1(arg_175_0.gameUI, "xuehezhan_zhiyuantiao"), false)

		setActive = var_176_0

		var_176_0(arg_175_0.specialTf, false)

		local var_176_1 = arg_175_0

		var_0.showSettlement(var_176_1)

		return
	end))

	return
end

function var_0_1.showSettlement(arg_177_0)
	setActive = var_1_10001

	var_1_10001(arg_177_0.settlementUI, true)

	GetComponent = var_1_10001
	findTF = var_2

	local var_177_0 = var_2(arg_177_0.settlementUI, "ad")

	typeof = var_3
	Animator = var_4

	local var_177_1 = var_1_10001(var_177_0, var_3(var_4))

	var_1.Play(var_177_1, "settlement", -1, 0)

	local var_177_2 = arg_177_0:GetMGData()
	local var_177_3 = var_2.GetRuntimeData(var_177_2, "elements")
	local var_177_4 = arg_177_0.scoreNum

	if var_177_3 then
		local var_177_5 = #var_177_3
		local var_177_6

		if not (0 < var_177_5) or not var_177_3[1] then
			var_177_6 = 0
		end

		if var_177_6 <= var_177_4 then
			var_177_6 = var_177_4

			arg_177_0:StoreDataToServer({
				var_177_6
			})
		end

		findTF = var_5

		local var_177_7 = var_5(arg_177_0.settlementUI, "ad/highText")

		findTF = var_6

		local var_177_8 = var_6(arg_177_0.settlementUI, "ad/currentText")

		setText = var_7

		var_7(var_177_7, var_177_6)

		setText = var_7

		var_7(var_177_8, var_177_4)

		if arg_177_0:getGameTimes() and arg_177_0:getGameTimes() > 0 then
			arg_177_0.sendSuccessFlag = true

			arg_177_0:SendSuccess(0)
		end

		return
	end
end

function var_0_1.resumeGame(arg_178_0)
	arg_178_0.gameStop = false
	setActive = var_1

	var_1(arg_178_0.leaveUI, false)
	arg_178_0:changeSpeed(1)
	arg_178_0:timerStart()

	return
end

function var_0_1.stopGame(arg_179_0)
	arg_179_0.gameStop = true

	arg_179_0:timerStop()
	arg_179_0:changeSpeed(0)

	return
end

function var_0_1.onBackPressed(arg_180_0)
	if not arg_180_0.gameStartFlag then
		arg_180_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_180_0.settlementFlag then
			return
		end

		isActive = var_1

		if var_1(arg_180_0.pauseUI) then
			setActive = var_1

			var_1(arg_180_0.pauseUI, false)
		end

		arg_180_0:stopGame()

		setActive = var_1

		var_1(arg_180_0.leaveUI, true)
	end

	return
end

function var_0_1.willExit(arg_181_0)
	if arg_181_0.handle then
		UpdateBeat = var_1
		var_1_10002 = var_1

		var_1.RemoveListener(var_1_10002, arg_181_0.handle)
	end

	if not arg_181_0._tf then
		print = var_1

		var_1()
	end

	if arg_181_0._tf then
		LeanTween = var_1

		local var_181_0 = var_1.isTweening

		go = var_1_10002

		if var_181_0(var_1_10002(arg_181_0._tf)) then
			LeanTween = var_1

			local var_181_1 = var_1.cancel

			go = var_1_10002

			var_181_1(var_1_10002(arg_181_0._tf))
		end
	end

	if arg_181_0.specialTf then
		LeanTween = var_1

		local var_181_2 = var_1.isTweening

		go = var_1_10002

		if var_181_2(var_1_10002(arg_181_0.specialTf)) then
			LeanTween = var_1

			local var_181_3 = var_1.cancel

			go = var_1_10002

			var_181_3(var_1_10002(arg_181_0.specialTf))
		end
	end

	if arg_181_0.specialEffect then
		LeanTween = var_1

		local var_181_4 = var_1.isTweening

		go = var_1_10002

		if var_181_4(var_1_10002(arg_181_0.specialEffect)) then
			LeanTween = var_1

			local var_181_5 = var_1.cancel

			go = var_2

			var_181_5(var_2(arg_181_0.specialEffect))
		end
	end

	if arg_181_0.timer and arg_181_0.timer.running then
		local var_181_6 = arg_181_0.timer

		var_1.Stop(var_181_6)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_181_0.timer = nil

	return
end

return var_0_1
