local var_0_0 = class("SnowballGameView", import("..BaseMiniGameView"))
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

;({}).type = "charactor_type_other"
;({}).skin_names = {
	"bailu",
	"huangjia",
	"jiujiu"
}
;({}).score = {
	-50,
	200,
	-50
}
;({}).charactor_type_other = {}
;({}).charactor_type_enemy = {
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

local var_0_11 = 3
local var_0_12 = 1
local var_0_13 = 18
local var_0_14 = 30
local var_0_15 = 3
local var_0_17 = {
	12,
	14,
	15,
	16,
	17
}
local var_0_18 = {
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
local var_0_19 = {
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
local var_0_20 = {
	0,
	30,
	60,
	90,
	120
}
local var_0_21 = 1.5
local var_0_22 = {
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
local var_0_23 = "event:/ui/ddldaoshu2"
local var_0_24 = "event:/ui/sou"
local var_0_25 = "event:/ui/xueqiu"

local function var_0_27(arg_2_0)
	({}).Ctor = function(arg_3_0)
		arg_3_0._tf = arg_2_0
		arg_3_0.reloadProgress = findTF(arg_3_0._tf, "reloadProgress")
		arg_3_0.playerAnimator = GetComponent(findTF(arg_3_0._tf, "player"), typeof(Animator))
		arg_3_0.playerDft = GetComponent(findTF(arg_3_0._tf, "player"), typeof(DftAniEvent))

		arg_3_0.playerDft:SetStartEvent(function()
			arg_3_0.playerAnimator:ResetTrigger("throw")
			arg_3_0.playerAnimator:SetBool("snowball", true)

			return
		end)
		arg_3_0.playerDft:SetTriggerEvent(function()
			arg_3_0:throwSnowball()

			return
		end)
		arg_3_0.playerDft:SetEndEvent(function()
			return
		end)

		arg_3_0.heartPos = findTF(arg_3_0._tf, "heartPos")
		arg_3_0.tplHeart = findTF(arg_3_0._tf, "heartPos/tplHeart")
		arg_3_0.collider = findTF(arg_3_0._tf, "collider")
		arg_3_0.throwCallback = nil
		arg_3_0.damageCallback = nil
		arg_3_0.gameOverCallback = nil

		return
	end
	;({}).prepare = function(arg_7_0)
		arg_7_0._life = var_0_11
		arg_7_0._reloadTime = nil
		arg_7_0._skillTime = nil
		arg_7_0.stepTime = 0

		arg_7_0.playerAnimator:ResetTrigger("skill")
		arg_7_0.playerAnimator:ResetTrigger("throw")
		arg_7_0.playerAnimator:ResetTrigger("damage")
		arg_7_0.playerAnimator:ResetTrigger("reload")
		arg_7_0.playerAnimator:ResetTrigger("fail")
		arg_7_0.playerAnimator:ResetTrigger("win")
		arg_7_0.playerAnimator:ResetTrigger("fail")
		arg_7_0.playerAnimator:SetTrigger("restart")
		arg_7_0.playerAnimator:ResetTrigger("restart")
		arg_7_0:Clear()

		return
	end
	;({}).step = function(arg_8_0)
		arg_8_0.stepTime = arg_8_0.stepTime + Time.deltaTime
		arg_8_0._reloadTime = arg_8_0._reloadTime or arg_8_0.stepTime

		if not arg_8_0.playerAnimator:GetBool("snowball") and arg_8_0.stepTime - arg_8_0._reloadTime > var_0_12 then
			arg_8_0:reload()
		end

		if not arg_8_0.playerAnimator:GetBool("snowball") and not isActive(arg_8_0.reloadProgress) then
			setActive(arg_8_0.reloadProgress, true)
		elseif arg_8_0.playerAnimator:GetBool("snowball") and isActive(arg_8_0.reloadProgress) then
			setActive(arg_8_0.reloadProgress, false)
		end

		local var_8_0 = (arg_8_0.stepTime - arg_8_0._reloadTime) / var_0_12

		if (arg_8_0.stepTime - arg_8_0._reloadTime) / var_0_12 > 1 then
			var_8_0 = 1
		end

		setSlider(arg_8_0.reloadProgress, 0, 1, var_8_0)

		return
	end
	;({}).reload = function(arg_9_0)
		arg_9_0.playerAnimator:SetTrigger("reload")

		return
	end
	;({}).skill = function(arg_10_0)
		if arg_10_0._skillTime and arg_10_0.stepTime - arg_10_0._skillTime < var_0_14 then
			return
		end

		arg_10_0._skillTime = arg_10_0.stepTime
		arg_10_0._reloadTime = arg_10_0.stepTime

		arg_10_0.playerAnimator:SetTrigger("skill")

		return
	end
	;({}).throw = function(arg_11_0)
		if arg_11_0.playerAnimator:GetBool("snowball") then
			arg_11_0.playerAnimator:SetTrigger("throw")

			return true
		end

		return false
	end
	;({}).damage = function(arg_12_0)
		if arg_12_0._life == 0 then
			return
		end

		arg_12_0._life = arg_12_0._life - 1

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_25)

		if arg_12_0.damageCallback then
			arg_12_0.damageCallback()
		end

		if arg_12_0._life > 0 then
			arg_12_0.playerAnimator:SetTrigger("damage")
			arg_12_0:createHeart()
		else
			arg_12_0.playerAnimator:SetTrigger("fail")

			if arg_12_0.gameOverCallback then
				arg_12_0.gameOverCallback()
			end
		end

		return
	end
	;({}).createHeart = function(arg_13_0)
		local var_13_0 = tf(instantiate(arg_13_0.tplHeart))

		GetComponent(var_13_0, typeof(DftAniEvent)):SetEndEvent(function()
			Destroy(var_13_0)

			return
		end)
		setParent(var_13_0, arg_13_0.heartPos)
		setActive(var_13_0, true)

		return
	end
	;({}).setSpeed = function(arg_15_0, arg_15_1)
		arg_15_0.playerAnimator.speed = arg_15_1

		return
	end
	;({}).throwSnowball = function(arg_16_0)
		if arg_16_0.throwCallback then
			arg_16_0.throwCallback(findTF(arg_16_0._tf, "throwPos").position)
		end

		arg_16_0.playerAnimator:SetBool("snowball", false)

		arg_16_0._reloadTime = arg_16_0.stepTime

		return
	end
	;({}).move = function(arg_17_0, arg_17_1)
		arg_17_0._tf.anchoredPosition = arg_17_1

		return
	end
	;({}).settlement = function(arg_18_0, arg_18_1)
		if arg_18_1 == var_0_5 then
			arg_18_0.playerAnimator:SetTrigger("fail")
		elseif arg_18_1 == var_0_4 then
			arg_18_0.playerAnimator:SetTrigger("win")
		end

		return
	end
	;({}).stop = function(arg_19_0)
		arg_19_0.playerAnimator.speed = 0

		return
	end
	;({}).resume = function(arg_20_0)
		arg_20_0.playerAnimator.speed = 1

		return
	end
	;({}).getTargetPosition = function(arg_21_0)
		return findTF(arg_21_0._tf, "targetPos").position
	end
	;({}).getColliderBound = function(arg_22_0)
		return arg_22_0.collider.position, arg_22_0.collider.sizeDelta
	end
	;({}).getLife = function(arg_23_0)
		return arg_23_0._life
	end
	;({}).Clear = function(arg_24_0)
		arg_24_0._life = var_0_11

		return
	end

	;({}):Ctor()

	return {}
end

local function var_0_28(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	({
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	})._id = nil
	;({
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	}).Ctor = function(arg_26_0)
		arg_26_0._animator = GetComponent(findTF(arg_26_0._tf, "snowball"), typeof(Animator))
		arg_26_0.snowballDft = GetComponent(findTF(arg_26_0._tf, "snowball"), typeof(DftAniEvent))

		arg_26_0.snowballDft:SetEndEvent(function()
			arg_26_0._removeFlag = true

			arg_26_0:dispose()

			return
		end)

		return
	end
	;({
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	}).setId = function(arg_28_0, arg_28_1)
		arg_28_0._id = arg_28_1

		return
	end
	;({
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	}).getId = function(arg_29_0, arg_29_1)
		return arg_29_0._id
	end
	;({
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	}).setPosition = function(arg_30_0, arg_30_1)
		arg_30_0._tf.anchoredPosition = arg_30_1
		arg_30_0._tf.localEulerAngles = Vector3(0, 0, math.atan(arg_25_1.y / arg_25_1.x) * math.rad2Deg)

		return
	end
	;({
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	}).hit = function(arg_31_0)
		arg_31_0._hitFlag = true

		arg_31_0._animator:SetTrigger("hit")

		return
	end
	;({
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	}).move = function(arg_32_0)
		local var_32_0 = Time.deltaTime / 0.015

		if Time.deltaTime / 0.015 > 2 then
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
	;({
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	}).getRemoveFlag = function(arg_33_0)
		return arg_33_0._removeFlag
	end
	;({
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	}).checkOutScene = function(arg_34_0)
		if arg_34_0._tf.anchoredPosition.x < var_0_1[1] or arg_34_0._tf.anchoredPosition.x > var_0_1[3] or arg_34_0._tf.anchoredPosition.y < var_0_1[2] or arg_34_0._tf.anchoredPosition.y > var_0_1[4] then
			arg_34_0:dispose()

			return true
		end

		return false
	end
	;({
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	}).getAnchoredPos = function(arg_35_0)
		return arg_35_0._tf.anchoredPosition
	end
	;({
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	}).getTargetPos = function(arg_36_0)
		return arg_36_0.tar
	end
	;({
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	}).getType = function(arg_37_0)
		return arg_37_0._type
	end
	;({
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	}).getIndex = function(arg_38_0)
		return arg_38_0._targetIndex
	end
	;({
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	}).checkArrived = function(arg_39_0, arg_39_1, arg_39_2)
		if arg_39_0._hitFlag then
			return
		end

		local var_39_0 = arg_39_0:getAnchoredPos()

		if var_39_0.x > arg_39_1.x and var_39_0.x < arg_39_1.x + arg_39_2.x and var_39_0.y > arg_39_1.y and var_39_0.y < arg_39_1.y + arg_39_2.y then
			return true
		end

		return false
	end
	;({
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	}).getArrived = function(arg_40_0)
		if arg_40_0._hitFlag then
			return
		end

		local var_40_0 = arg_40_0:getAnchoredPos()

		if math.abs(arg_40_0._targetPosition.x - var_40_0.x) <= math.abs(arg_40_0._moveDirect.x * 2) and math.abs(arg_40_0._targetPosition.y - var_40_0.y) <= math.abs(arg_40_0._moveDirect.y * 2) then
			return true
		end

		return false
	end
	;({
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	}).dispose = function(arg_41_0)
		if arg_41_0._tf then
			Destroy(arg_41_0._tf)

			arg_41_0._tf = nil
		end

		return
	end

	;({
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	}):Ctor()

	return {
		_tf = arg_25_0,
		_moveDirect = arg_25_1,
		_targetPosition = arg_25_2,
		_type = arg_25_3,
		_targetIndex = arg_25_4
	}
end

local function var_0_29(arg_42_0, arg_42_1)
	({
		_snowballContainer = arg_42_0,
		_tplSnowball = arg_42_1,
		snowballs = {}
	})._snowBallId = 0
	;({
		_snowballContainer = arg_42_0,
		_tplSnowball = arg_42_1,
		snowballs = {}
	}).createSnowball = function(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_24)

		local var_43_0 = tf(Instantiate(arg_43_0._tplSnowball))

		SetParent(var_43_0, arg_43_0._snowballContainer)
		setActive(var_43_0, true)

		if arg_43_2.x < arg_43_1.x then
			var_43_0.localScale = Vector3(-1, 1, 1)
		end

		local var_43_1 = var_0_28(var_43_0, Vector3(arg_43_3 * (arg_43_2.x > arg_43_1.x and 1 or -1), (arg_43_2.y - arg_43_1.y) / (arg_43_2.x - arg_43_1.x) * (arg_43_3 * (arg_43_2.x > arg_43_1.x and 1 or -1)), 0), arg_43_2, arg_43_4, arg_43_5)

		var_43_1:setId(arg_43_0:getSnowBallId())
		var_43_1:setPosition(arg_43_1)
		table.insert(arg_43_0.snowballs, var_43_1)

		return
	end
	;({
		_snowballContainer = arg_42_0,
		_tplSnowball = arg_42_1,
		snowballs = {}
	}).prepare = function(arg_44_0)
		for iter_44_0 = #arg_44_0.snowballs, 1, -1 do
			table.remove(arg_44_0.snowballs, iter_44_0)
			arg_44_0.snowballs[iter_44_0]:dispose()
		end

		return
	end
	;({
		_snowballContainer = arg_42_0,
		_tplSnowball = arg_42_1,
		snowballs = {}
	}).step = function(arg_45_0)
		for iter_45_0 = #arg_45_0.snowballs, 1, -1 do
			if arg_45_0.snowballs[iter_45_0]:getRemoveFlag() or arg_45_0.snowballs[iter_45_0]:checkOutScene() then
				table.remove(arg_45_0.snowballs, iter_45_0)
			else
				arg_45_0.snowballs[iter_45_0]:move()
			end
		end

		return
	end
	;({
		_snowballContainer = arg_42_0,
		_tplSnowball = arg_42_1,
		snowballs = {}
	}).clearEnemySnowball = function(arg_46_0)
		for iter_46_0 = #arg_46_0.snowballs, 1, -1 do
			if arg_46_0.snowballs[iter_46_0]:getType() == var_0_3 then
				arg_46_0.snowballs[iter_46_0]:hit()
			end
		end

		return
	end
	;({
		_snowballContainer = arg_42_0,
		_tplSnowball = arg_42_1,
		snowballs = {}
	}).snowballHit = function(arg_47_0, arg_47_1)
		if not arg_47_1 then
			return
		end

		for iter_47_0 = #arg_47_0.snowballs, 1, -1 do
			if arg_47_0.snowballs[iter_47_0]:getId() == arg_47_1 then
				arg_47_0.snowballs[iter_47_0]:hit()
			end
		end

		return
	end
	;({
		_snowballContainer = arg_42_0,
		_tplSnowball = arg_42_1,
		snowballs = {}
	}).getSnowBallId = function(arg_48_0)
		arg_48_0._snowBallId = arg_48_0._snowBallId + 1

		return arg_48_0._snowBallId
	end
	;({
		_snowballContainer = arg_42_0,
		_tplSnowball = arg_42_1,
		snowballs = {}
	}).getSnowballs = function(arg_49_0)
		return Clone(arg_49_0.snowballs)
	end

	return {
		_snowballContainer = arg_42_0,
		_tplSnowball = arg_42_1,
		snowballs = {}
	}
end

local function var_0_30(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4)
	({
		_tf = arg_50_1,
		_index = arg_50_2,
		_data = arg_50_0,
		_name = arg_50_3,
		_score = arg_50_4,
		Ctor = function(arg_51_0)
			arg_51_0.leaveCallback = nil
			arg_51_0.collider = findTF(arg_51_0._tf, "collider")
			arg_51_0.otherAnimator = GetComponent(findTF(arg_51_0._tf, "char"), typeof(Animator))
			arg_51_0.otherDft = GetComponent(findTF(arg_51_0._tf, "char"), typeof(DftAniEvent))

			arg_51_0.otherDft:SetEndEvent(function()
				if arg_51_0.leaveCallback then
					arg_51_0.leaveCallback()
				end

				arg_51_0:dispose()

				return
			end)

			arg_51_0._leaveTime = math.random(arg_51_0._data.time[1], arg_51_0._data.time[2])

			return
		end,
		step = function(arg_53_0)
			if arg_53_0.removeFlag then
				return
			end

			arg_53_0._leaveTime = arg_53_0._leaveTime - Time.deltaTime

			return
		end,
		getColliderBound = function(arg_54_0)
			return arg_54_0.collider.position, arg_54_0.collider.sizeDelta
		end,
		apear = function(arg_55_0)
			arg_55_0.otherAnimator:SetTrigger("apear")

			return
		end,
		damage = function(arg_56_0)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_25)
			arg_56_0.otherAnimator:SetTrigger("damage")

			return
		end,
		leave = function(arg_57_0)
			arg_57_0.otherAnimator:SetTrigger("leave")

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
				Destroy(arg_64_0._tf)

				arg_64_0._tf = nil
			end

			arg_64_0.removeFlag = true

			return
		end
	}).Ctor({
		_tf = arg_50_1,
		_index = arg_50_2,
		_data = arg_50_0,
		_name = arg_50_3,
		_score = arg_50_4,
		Ctor = function(arg_51_0)
			arg_51_0.leaveCallback = nil
			arg_51_0.collider = findTF(arg_51_0._tf, "collider")
			arg_51_0.otherAnimator = GetComponent(findTF(arg_51_0._tf, "char"), typeof(Animator))
			arg_51_0.otherDft = GetComponent(findTF(arg_51_0._tf, "char"), typeof(DftAniEvent))

			arg_51_0.otherDft:SetEndEvent(function()
				if arg_51_0.leaveCallback then
					arg_51_0.leaveCallback()
				end

				arg_51_0:dispose()

				return
			end)

			arg_51_0._leaveTime = math.random(arg_51_0._data.time[1], arg_51_0._data.time[2])

			return
		end,
		step = function(arg_53_0)
			if arg_53_0.removeFlag then
				return
			end

			arg_53_0._leaveTime = arg_53_0._leaveTime - Time.deltaTime

			return
		end,
		getColliderBound = function(arg_54_0)
			return arg_54_0.collider.position, arg_54_0.collider.sizeDelta
		end,
		apear = function(arg_55_0)
			arg_55_0.otherAnimator:SetTrigger("apear")

			return
		end,
		damage = function(arg_56_0)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_25)
			arg_56_0.otherAnimator:SetTrigger("damage")

			return
		end,
		leave = function(arg_57_0)
			arg_57_0.otherAnimator:SetTrigger("leave")

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
				Destroy(arg_64_0._tf)

				arg_64_0._tf = nil
			end

			arg_64_0.removeFlag = true

			return
		end
	})

	return {
		_tf = arg_50_1,
		_index = arg_50_2,
		_data = arg_50_0,
		_name = arg_50_3,
		_score = arg_50_4,
		Ctor = function(arg_51_0)
			arg_51_0.leaveCallback = nil
			arg_51_0.collider = findTF(arg_51_0._tf, "collider")
			arg_51_0.otherAnimator = GetComponent(findTF(arg_51_0._tf, "char"), typeof(Animator))
			arg_51_0.otherDft = GetComponent(findTF(arg_51_0._tf, "char"), typeof(DftAniEvent))

			arg_51_0.otherDft:SetEndEvent(function()
				if arg_51_0.leaveCallback then
					arg_51_0.leaveCallback()
				end

				arg_51_0:dispose()

				return
			end)

			arg_51_0._leaveTime = math.random(arg_51_0._data.time[1], arg_51_0._data.time[2])

			return
		end,
		step = function(arg_53_0)
			if arg_53_0.removeFlag then
				return
			end

			arg_53_0._leaveTime = arg_53_0._leaveTime - Time.deltaTime

			return
		end,
		getColliderBound = function(arg_54_0)
			return arg_54_0.collider.position, arg_54_0.collider.sizeDelta
		end,
		apear = function(arg_55_0)
			arg_55_0.otherAnimator:SetTrigger("apear")

			return
		end,
		damage = function(arg_56_0)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_25)
			arg_56_0.otherAnimator:SetTrigger("damage")

			return
		end,
		leave = function(arg_57_0)
			arg_57_0.otherAnimator:SetTrigger("leave")

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
				Destroy(arg_64_0._tf)

				arg_64_0._tf = nil
			end

			arg_64_0.removeFlag = true

			return
		end
	}
end

local function var_0_31(arg_65_0, arg_65_1, arg_65_2, arg_65_3, arg_65_4)
	local var_65_0 = {
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}

	;({
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}).setThrowCallback = function(arg_69_0, arg_69_1)
		var_65_0._throwCallback = arg_69_1

		return
	end
	;({
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}).getColliderBound = function(arg_70_0)
		return arg_70_0.collider.position, arg_70_0.collider.sizeDelta
	end
	;({
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}).step = function(arg_71_0)
		if arg_71_0.removeFlag then
			return
		end

		arg_71_0._leaveTime = arg_71_0._leaveTime - Time.deltaTime
		arg_71_0._activeTime = arg_71_0._activeTime + Time.deltaTime

		if arg_71_0._activeTime > var_0_21 then
			arg_71_0._activeTime = 0

			if arg_71_0:getSnowball() then
				arg_71_0:throw()
				arg_71_0.enemyAnimator:SetBool("snowball", false)
			else
				arg_71_0.enemyAnimator:SetBool("snowball", true)
				arg_71_0:reload()
			end
		end

		return
	end
	;({
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}).apear = function(arg_72_0)
		arg_72_0.enemyAnimator:SetTrigger("apear")

		return
	end
	;({
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}).damage = function(arg_73_0)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_25)
		arg_73_0.enemyAnimator:SetTrigger("damage")

		return
	end
	;({
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}).leave = function(arg_74_0)
		arg_74_0.enemyAnimator:SetTrigger("leave")

		return
	end
	;({
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}).reload = function(arg_75_0)
		arg_75_0.enemyAnimator:SetTrigger("reload")

		return
	end
	;({
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}).throw = function(arg_76_0)
		arg_76_0.enemyAnimator:SetTrigger("throw")

		return
	end
	;({
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}).hit = function(arg_77_0)
		arg_77_0.enemyAnimator:SetTrigger("hit")

		return
	end
	;({
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}).getSnowball = function(arg_78_0)
		return arg_78_0.enemyAnimator:GetBool("snowball")
	end
	;({
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}).getLeaveTime = function(arg_79_0)
		return arg_79_0._leaveTime
	end
	;({
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}).getType = function(arg_80_0)
		return arg_80_0._data.type
	end
	;({
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}).getScore = function(arg_81_0)
		return arg_81_0._score
	end
	;({
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}).setSpeed = function(arg_82_0, arg_82_1)
		arg_82_0.enemyAnimator.speed = arg_82_1

		return
	end
	;({
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}).getName = function(arg_83_0)
		return arg_83_0._name
	end
	;({
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}).getPosition = function(arg_84_0)
		return arg_84_0._tf.position
	end
	;({
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}).dispose = function(arg_85_0)
		arg_85_0.leaveCallback = nil

		if arg_85_0._tf then
			Destroy(arg_85_0._tf)

			arg_85_0._tf = nil
		end

		arg_85_0.removeFlag = true

		return
	end

	;({
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}):Ctor()

	return {
		_tf = arg_65_1,
		_index = arg_65_2,
		_data = arg_65_0,
		_name = arg_65_3,
		_score = arg_65_4,
		Ctor = function(arg_66_0)
			arg_66_0.leaveCallback = nil
			arg_66_0.enemyAnimator = GetComponent(findTF(arg_66_0._tf, "char"), typeof(Animator))
			arg_66_0.enemyDft = GetComponent(findTF(arg_66_0._tf, "char"), typeof(DftAniEvent))
			arg_66_0.collider = findTF(arg_66_0._tf, "collider")
			arg_66_0.throwPos = findTF(arg_66_0._tf, "throwPos")

			arg_66_0.enemyDft:SetEndEvent(function()
				if arg_66_0.leaveCallback then
					arg_66_0.leaveCallback()
				end

				arg_66_0:dispose()

				return
			end)
			arg_66_0.enemyDft:SetTriggerEvent(function()
				if arg_66_0._throwCallback then
					arg_66_0._throwCallback(arg_66_0.throwPos.position, arg_66_0._index)
				end

				return
			end)

			arg_66_0._leaveTime = math.random(arg_66_0._data.time[1], arg_66_0._data.time[2])
			arg_66_0._activeTime = 0

			return
		end
	}
end

local function var_0_32(arg_86_0, arg_86_1)
	({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).apearStepTime = nil
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).gameStepTime = 0
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).Ctor = function(arg_87_0)
		for iter_87_0 = 1, var_0_7 do
			arg_87_0.charators[iter_87_0] = 0
		end

		arg_87_0.throwCallback = nil
		arg_87_0.charactorDamageCallback = nil

		return
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).prepare = function(arg_88_0)
		for iter_88_0, iter_88_1 in pairs(arg_88_0.charators) do
			if iter_88_1 ~= 0 then
				iter_88_1:dispose()

				arg_88_0.charators[iter_88_0] = 0
			end
		end

		arg_88_0.gameStepTime = 0
		arg_88_0.apearStepTime = nil

		return
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).step = function(arg_89_0)
		arg_89_0.gameStepTime = arg_89_0.gameStepTime + Time.deltaTime

		if arg_89_0.gameStepTime > arg_89_0:getNextApearTime() then
			for iter_89_0 = 1, arg_89_0:getApearAmount() do
				arg_89_0:apearCharactor()
			end

			arg_89_0:setNextApearTime()
		end

		for iter_89_1 = 1, #arg_89_0.charators do
			if arg_89_0.charators[iter_89_1] ~= 0 then
				local var_89_0 = arg_89_0.charators[iter_89_1]:getLeaveTime()

				if arg_89_0.charators[iter_89_1]:getLeaveTime() < 0 then
					arg_89_0:leaveCharactor(iter_89_1)
				else
					arg_89_0.charators[iter_89_1]:step()
				end
			end
		end

		return
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).leaveCharactor = function(arg_90_0, arg_90_1)
		if arg_90_0.charators[arg_90_1] ~= 0 then
			arg_90_0.charators[arg_90_1]:leave()

			arg_90_0.charators[arg_90_1] = 0
		end

		return
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).removeCharactor = function(arg_91_0, arg_91_1)
		if arg_91_0.charators[arg_91_1] ~= 0 then
			arg_91_0.charators[arg_91_1] = 0
		end

		return
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).damageEnemy = function(arg_92_0)
		for iter_92_0 = 1, #arg_92_0.charators do
			if arg_92_0.charators[iter_92_0] and arg_92_0.charators[iter_92_0] ~= 0 and arg_92_0.charators[iter_92_0]:getScore() > 0 then
				if arg_92_0.charactorDamageCallback then
					arg_92_0.charactorDamageCallback(arg_92_0.charators[iter_92_0]:getPosition(), arg_92_0.charators[iter_92_0]:getScore())
				end

				arg_92_0.charators[iter_92_0]:damage()
				arg_92_0:removeCharactor(iter_92_0)
			end
		end

		return
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).getCharactorByIndex = function(arg_93_0, arg_93_1)
		return arg_93_0.charators[arg_93_1]
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).apearCharactor = function(arg_94_0)
		local var_94_0 = arg_94_0:getAbleRandomDatas()

		if not var_94_0 then
			return
		end

		local var_94_1 = arg_94_0:getDataByWeight(var_94_0)

		if not var_94_1 then
			return
		end

		local var_94_2, var_94_3 = arg_94_0:getCharactorName(var_0_10[var_94_1.type])
		local var_94_4 = arg_94_0:getCharactorRandomIndex(var_94_1)
		local var_94_5 = arg_94_0:createCharactor(var_94_1, var_94_4, var_94_2, var_94_3)

		if var_94_5 then
			arg_94_0:addCharactor(var_94_5, var_94_4)
		end

		return
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).setSpeed = function(arg_95_0, arg_95_1)
		arg_95_0.speedValue = arg_95_1

		for iter_95_0 = 1, #arg_95_0.charators do
			if arg_95_0.charators[iter_95_0] and arg_95_0.charators[iter_95_0] ~= 0 then
				arg_95_0.charators[iter_95_0]:setSpeed(arg_95_1)
			end
		end

		return
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).createCharactor = function(arg_96_0, arg_96_1, arg_96_2, arg_96_3, arg_96_4)
		local var_96_0 = tf(Instantiate(arg_96_0._tplCharactorDic[arg_96_3]))

		SetParent(var_96_0, (findTF(arg_96_0._charactorContainer, arg_96_2)))
		setActive(var_96_0, true)

		local var_96_1

		if arg_96_1.type == var_0_8 then
			var_96_1 = var_0_30(arg_96_1, var_96_0, arg_96_2, arg_96_3, arg_96_4)
		elseif arg_96_1.type == var_0_9 then
			var_96_1 = var_0_31(arg_96_1, var_96_0, arg_96_2, arg_96_3, arg_96_4)

			var_96_1:setThrowCallback(arg_96_0.throwCallback)
		end

		return var_96_1
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).addCharactor = function(arg_97_0, arg_97_1, arg_97_2)
		arg_97_0.charators[arg_97_2] = arg_97_1

		arg_97_1:apear()

		return
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).getCharactorRandomIndex = function(arg_98_0, arg_98_1)
		local var_98_0 = arg_98_0:getEmptyIndex()

		for iter_98_0 = 1, #var_98_0 do
			if table.contains(arg_98_1.indexs, var_98_0[iter_98_0]) then
				table.insert({}, var_98_0[iter_98_0])
			end
		end

		if #{} then
			return ({})[math.random(1, #{})]
		end

		return nil
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).getCharactorName = function(arg_99_0, arg_99_1)
		local var_99_1 = math.random(1, #arg_99_1.skin_names)

		return arg_99_1.skin_names[var_99_1], arg_99_1.score[var_99_1]
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).getDataByWeight = function(arg_100_0, arg_100_1)
		if #arg_100_1 == 1 then
			return arg_100_1[1]
		else
			if not arg_100_0.charactorWeight then
				arg_100_0.charactorWeight = {}
				arg_100_0.charactorSubWeight = 0

				for iter_100_0 = 1, #arg_100_1 do
					arg_100_0.charactorSubWeight = arg_100_0.charactorSubWeight + arg_100_1[iter_100_0].weight

					table.insert(arg_100_0.charactorWeight, arg_100_0.charactorSubWeight)
				end
			end

			local var_100_0 = math.random(0, arg_100_0.charactorSubWeight)

			for iter_100_1 = #arg_100_0.charactorWeight - 1, 1, -1 do
				if var_100_0 > arg_100_0.charactorWeight[iter_100_1] then
					return arg_100_1[iter_100_1 + 1]
				end
			end

			return arg_100_1[1]
		end

		return nil
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).getAbleRandomDatas = function(arg_101_0)
		local var_101_0 = arg_101_0:getEmptyIndex()

		if #var_101_0 == 0 then
			return {}
		end

		for iter_101_0 = 1, #var_0_22 do
			for iter_101_1, iter_101_2 in ipairs(var_0_22[iter_101_0].indexs) do
				local var_101_1

				if table.contains(var_101_0, iter_101_2) and not nil then
					table.insert({}, var_0_22[iter_101_0])

					var_101_1 = true
				end
			end
		end

		return {}
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).getEmptyIndex = function(arg_102_0)
		for iter_102_0, iter_102_1 in pairs(arg_102_0.charators) do
			if iter_102_1 == 0 then
				table.insert({}, iter_102_0)
			end
		end

		return {}
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).getNextApearTime = function(arg_103_0)
		if not arg_103_0.apearStepTime then
			arg_103_0:setNextApearTime()
		end

		return arg_103_0.apearStepTime
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).setNextApearTime = function(arg_104_0)
		arg_104_0.apearStepTime = arg_104_0.apearStepTime or 0
		arg_104_0.apearStepTime = arg_104_0.apearStepTime + arg_104_0:getApearTime()

		return
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).getApearTime = function(arg_105_0)
		local var_105_0 = 1

		for iter_105_0 = #var_0_20, 1, -1 do
			if arg_105_0.gameStepTime > var_0_20[iter_105_0] then
				var_105_0 = iter_105_0

				break
			end
		end

		return math.random() * (var_0_18[var_105_0][2] - var_0_18[var_105_0][1]) + var_0_18[var_105_0][1]
	end
	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}).getApearAmount = function(arg_106_0)
		local var_106_0 = 1

		for iter_106_0 = #var_0_20, 1, -1 do
			if arg_106_0.gameStepTime > var_0_20[iter_106_0] then
				var_106_0 = iter_106_0

				break
			end
		end

		local var_106_1 = var_0_19[var_106_0]
		local var_106_2 = 0

		for iter_106_1 = 1, #var_0_19[var_106_0] do
			var_106_2 = var_106_2 + var_106_1[iter_106_1]

			table.insert({}, var_106_2)
		end

		local var_106_3 = math.random(0, var_106_2)

		for iter_106_2 = #{} - 1, 1, -1 do
			if var_106_3 > ({})[iter_106_2] then
				return iter_106_2 + 1
			end
		end

		return 1
	end

	;({
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}):Ctor()

	return {
		_tplCharactorDic = arg_86_1,
		_charactorContainer = arg_86_0,
		charators = {}
	}
end

local function var_0_33(arg_107_0, arg_107_1, arg_107_2, arg_107_3)
	({
		_player = arg_107_1,
		_charactorCtrl = arg_107_3,
		_snowballCtrl = arg_107_2,
		_sceneTf = arg_107_0
	}).hitEnemyCallback = nil
	;({
		_player = arg_107_1,
		_charactorCtrl = arg_107_3,
		_snowballCtrl = arg_107_2,
		_sceneTf = arg_107_0
	}).Ctor = function(arg_108_0)
		return
	end
	;({
		_player = arg_107_1,
		_charactorCtrl = arg_107_3,
		_snowballCtrl = arg_107_2,
		_sceneTf = arg_107_0
	}).prepare = function(arg_109_0)
		return
	end
	;({
		_player = arg_107_1,
		_charactorCtrl = arg_107_3,
		_snowballCtrl = arg_107_2,
		_sceneTf = arg_107_0
	}).step = function(arg_110_0)
		local var_110_0 = arg_110_0._snowballCtrl:getSnowballs()

		for iter_110_0 = 1, #var_110_0 do
			local var_110_1 = var_110_0[iter_110_0]:getType()
			local var_110_2 = var_110_0[iter_110_0]:getIndex()
			local var_110_3 = arg_107_3:getCharactorByIndex(var_110_2)

			if var_110_1 == var_0_2 then
				if var_110_3 and var_110_3 ~= 0 then
					local var_110_4, var_110_5 = var_110_3:getColliderBound()

					if var_110_0[iter_110_0]:checkArrived(arg_110_0._sceneTf:InverseTransformPoint(var_110_4), var_110_5) then
						var_110_3:damage()
						arg_110_0._snowballCtrl:snowballHit(var_110_0[iter_110_0]:getId())
						arg_107_3:removeCharactor(var_110_2)

						if arg_110_0.hitEnemyCallback then
							arg_110_0.hitEnemyCallback(var_110_3:getType(), var_110_3:getName(), var_110_3:getScore(), var_110_3:getPosition())
						end
					end
				end
			elseif var_110_1 == var_0_3 then
				local var_110_6, var_110_7 = arg_110_0._player:getColliderBound()

				if var_110_0[iter_110_0]:checkArrived(arg_110_0._sceneTf:InverseTransformPoint(var_110_6), var_110_7) then
					if var_110_3 and var_110_3 ~= 0 and var_110_3:getType() == var_0_9 then
						var_110_3:hit()
					end

					arg_110_0._player:damage()
					arg_110_0._snowballCtrl:snowballHit(var_110_0[iter_110_0]:getId())
				end
			end
		end

		return
	end

	;({
		_player = arg_107_1,
		_charactorCtrl = arg_107_3,
		_snowballCtrl = arg_107_2,
		_sceneTf = arg_107_0
	}):Ctor()

	return {
		_player = arg_107_1,
		_charactorCtrl = arg_107_3,
		_snowballCtrl = arg_107_2,
		_sceneTf = arg_107_0
	}
end

function var_0_0.getUIName(arg_111_0)
	return "SnowballGameUI"
end

function var_0_0.getBGM(arg_112_0)
	return "backyard"
end

function var_0_0.didEnter(arg_113_0)
	arg_113_0:initData()
	arg_113_0:initUI()

	return
end

function var_0_0.initData(arg_114_0)
	arg_114_0.timer = Timer.New(function()
		arg_114_0:onTimer()

		return
	end, 0.016666666666666666, -1)

	return
end

function var_0_0.initUI(arg_116_0)
	arg_116_0.sceneTf = findTF(arg_116_0._tf, "scene")
	arg_116_0.clickMask = findTF(arg_116_0._tf, "clickMask")
	arg_116_0.player = var_0_27(findTF(arg_116_0._tf, "scene/luao"))

	function arg_116_0.player.throwCallback(arg_117_0)
		arg_116_0:onPlayerThrowSnowball(arg_117_0)

		return
	end

	function arg_116_0.player.damageCallback()
		arg_116_0:onPlayerDamage()

		return
	end

	function arg_116_0.player.gameOverCallback()
		arg_116_0:onGameOver()

		return
	end

	arg_116_0.snowballContainer = findTF(arg_116_0._tf, "scene_front/snowballContainer")
	arg_116_0.tplSnowball = findTF(arg_116_0._tf, "tplSnowball")
	arg_116_0.snowballController = var_0_29(arg_116_0.snowballContainer, arg_116_0.tplSnowball)
	arg_116_0.tplScore = findTF(arg_116_0._tf, "tplScore")
	arg_116_0.specialTf = findTF(arg_116_0._tf, "scene_front/special")
	arg_116_0.specialAniamtor = GetComponent(arg_116_0.specialTf, typeof(Animator))

	GetComponent(arg_116_0.specialTf, typeof(DftAniEvent)):SetTriggerEvent(function()
		arg_116_0:specialComplete()

		return
	end)

	arg_116_0.charactorContainer = findTF(arg_116_0._tf, "scene/charactorContainer")

	for iter_116_0, iter_116_1 in pairs(var_0_10) do
		for iter_116_2, iter_116_3 in ipairs(iter_116_1.skin_names) do
			({})[iter_116_3] = findTF(arg_116_0._tf, "charactor/" .. iter_116_3)
		end
	end

	arg_116_0.charactorController = var_0_32(arg_116_0.charactorContainer, {})

	function arg_116_0.charactorController.throwCallback(arg_121_0, arg_121_1)
		function arg_116_0.charactorController.charactorDamageCallback(arg_122_0, arg_122_1)
			arg_116_0:onHitEnemy(arg_122_1, arg_122_0)

			return
		end

		arg_116_0:onEnemyThrowSnowball(arg_121_0, arg_121_1, var_0_17[arg_116_0:getCurrentDiff()])

		return
	end

	arg_116_0.colliderController = var_0_33(arg_116_0.sceneTf, arg_116_0.player, arg_116_0.snowballController, arg_116_0.charactorController)

	function arg_116_0.colliderController.hitEnemyCallback(arg_123_0, arg_123_1, arg_123_2, arg_123_3)
		arg_116_0:onHitEnemy(arg_123_2, arg_123_3)

		return
	end

	local var_116_0 = findTF(arg_116_0._tf, "scene/moveCollider")

	arg_116_0.playerMoveVecs = {}

	for iter_116_4 = 1, var_0_6 do
		table.insert(arg_116_0.playerMoveVecs, findTF(var_116_0, iter_116_4).anchoredPosition)
	end

	arg_116_0.lockTf = findTF(arg_116_0._tf, "scene_front/lock")

	local var_116_1 = findTF(arg_116_0._tf, "scene/throwCollider")

	for iter_116_5 = 1, var_0_7 do
		local var_116_2 = iter_116_5

		onButton(arg_116_0, findTF(var_116_1, iter_116_5), function()
			local var_124_0 = arg_116_0.charactorController:getCharactorByIndex(var_116_2)

			if var_124_0 and var_124_0 ~= 0 then
				local var_124_1 = findTF(var_0, "target").position

				arg_116_0:throwSnowballTo(arg_116_0.sceneTf:InverseTransformPoint(var_124_1.x, var_124_1.y, 0), var_116_2, var_124_0)
			end

			return
		end)
	end

	arg_116_0.countUI = findTF(arg_116_0._tf, "pop/CountUI")
	arg_116_0.countAnimator = GetComponent(findTF(arg_116_0.countUI, "count"), typeof(Animator))
	arg_116_0.countDft = GetComponent(findTF(arg_116_0.countUI, "count"), typeof(DftAniEvent))

	arg_116_0.countDft:SetTriggerEvent(function()
		return
	end)
	arg_116_0.countDft:SetEndEvent(function()
		setActive(arg_116_0.countUI, false)
		arg_116_0:gameStart()

		return
	end)

	arg_116_0.leaveUI = findTF(arg_116_0._tf, "pop/LeaveUI")

	onButton(arg_116_0, findTF(arg_116_0.leaveUI, "ad/btnOk"), function()
		arg_116_0:resumeGame()
		arg_116_0.player:settlement(var_0_4)
		arg_116_0:onGameOver()

		return
	end, SFX_CANCEL)
	onButton(arg_116_0, findTF(arg_116_0.leaveUI, "ad/btnCancel"), function()
		arg_116_0:resumeGame()

		return
	end, SFX_CANCEL)

	arg_116_0.pauseUI = findTF(arg_116_0._tf, "pop/pauseUI")

	onButton(arg_116_0, findTF(arg_116_0.pauseUI, "ad/btnOk"), function()
		setActive(arg_116_0.pauseUI, false)
		arg_116_0:resumeGame()

		return
	end, SFX_CANCEL)

	arg_116_0.settlementUI = findTF(arg_116_0._tf, "pop/SettleMentUI")

	onButton(arg_116_0, findTF(arg_116_0.settlementUI, "ad/btnOver"), function()
		setActive(arg_116_0.settlementUI, false)
		arg_116_0:openMenuUI()

		return
	end, SFX_CANCEL)

	arg_116_0.menuUI = findTF(arg_116_0._tf, "pop/menuUI")
	arg_116_0.battleScrollRect = GetComponent(findTF(arg_116_0.menuUI, "battList"), typeof(ScrollRect))
	arg_116_0.totalTimes = arg_116_0:getGameTotalTime()

	scrollTo(arg_116_0.battleScrollRect, 0, 1 - (arg_116_0:getGameUsedTimes() - 4 < 0 and 0 or arg_116_0:getGameUsedTimes() - 4) / (arg_116_0.totalTimes - 4))
	onButton(arg_116_0, findTF(arg_116_0.menuUI, "rightPanelBg/arrowUp"), function()
		local var_131_0 = arg_116_0.battleScrollRect.normalizedPosition.y + 1 / (arg_116_0.totalTimes - 4)

		if arg_116_0.battleScrollRect.normalizedPosition.y + 1 / (arg_116_0.totalTimes - 4) > 1 then
			var_131_0 = 1
		end

		scrollTo(arg_116_0.battleScrollRect, 0, var_131_0)

		return
	end, SFX_CANCEL)
	onButton(arg_116_0, findTF(arg_116_0.menuUI, "rightPanelBg/arrowDown"), function()
		local var_132_0 = arg_116_0.battleScrollRect.normalizedPosition.y - 1 / (arg_116_0.totalTimes - 4)

		if arg_116_0.battleScrollRect.normalizedPosition.y - 1 / (arg_116_0.totalTimes - 4) < 0 then
			var_132_0 = 0
		end

		scrollTo(arg_116_0.battleScrollRect, 0, var_132_0)

		return
	end, SFX_CANCEL)
	onButton(arg_116_0, findTF(arg_116_0.menuUI, "btnBack"), function()
		arg_116_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_116_0, findTF(arg_116_0.menuUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.snowball_help.tip
		})

		return
	end, SFX_CANCEL)
	onButton(arg_116_0, findTF(arg_116_0.menuUI, "btnStart"), function()
		setActive(arg_116_0.menuUI, false)
		arg_116_0:readyStart()

		return
	end, SFX_CANCEL)

	local var_116_3 = findTF(arg_116_0.menuUI, "tplBattleItem")

	arg_116_0.battleItems = {}

	for iter_116_6 = 1, arg_116_0.totalTimes do
		local var_116_4 = tf(instantiate(var_116_3))

		var_116_4.name = "battleItem_" .. iter_116_6

		setParent(var_116_4, findTF(arg_116_0.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync("ui/minigameui/snowballgameui_atlas", "tx_" .. iter_116_6, function(arg_136_0)
			setImageSprite(findTF(var_116_4, "state_open/icon"), arg_136_0, true)
			setImageSprite(findTF(var_116_4, "state_clear/icon"), arg_136_0, true)
			setImageSprite(findTF(var_116_4, "state_current/icon"), arg_136_0, true)

			return
		end)
		GetSpriteFromAtlasAsync("ui/minigameui/snowballgameui_atlas", "battleDesc" .. iter_116_6, function(arg_137_0)
			setImageSprite(findTF(var_116_4, "state_open/buttomDesc"), arg_137_0, true)
			setImageSprite(findTF(var_116_4, "state_clear/buttomDesc"), arg_137_0, true)
			setImageSprite(findTF(var_116_4, "state_current/buttomDesc"), arg_137_0, true)
			setImageSprite(findTF(var_116_4, "state_closed/buttomDesc"), arg_137_0, true)

			return
		end)
		setActive(var_116_4, true)
		table.insert(arg_116_0.battleItems, var_116_4)
	end

	arg_116_0.gameUI = findTF(arg_116_0._tf, "ui/gameUI")
	arg_116_0.lifeProgress = findTF(arg_116_0.gameUI, "lifeProgress")
	arg_116_0.textLife = findTF(arg_116_0.gameUI, "life")
	arg_116_0.textScore = findTF(arg_116_0.gameUI, "score")

	onButton(arg_116_0, findTF(arg_116_0.gameUI, "btnStop"), function()
		arg_116_0:stopGame()
		setActive(arg_116_0.pauseUI, true)

		return
	end)
	onButton(arg_116_0, findTF(arg_116_0.gameUI, "btnLeave"), function()
		arg_116_0:stopGame()
		setActive(arg_116_0.leaveUI, true)

		return
	end)
	onButton(arg_116_0, findTF(arg_116_0.gameUI, "btnMoveUp"), function()
		if arg_116_0.playerPosIndex > 1 then
			arg_116_0.playerPosIndex = arg_116_0.playerPosIndex - 1

			arg_116_0:movePlayerTo(arg_116_0.playerPosIndex)
		end

		return
	end)
	onButton(arg_116_0, findTF(arg_116_0.gameUI, "btnMoveDown"), function()
		if arg_116_0.playerPosIndex < #arg_116_0.playerMoveVecs then
			arg_116_0.playerPosIndex = arg_116_0.playerPosIndex + 1

			arg_116_0:movePlayerTo(arg_116_0.playerPosIndex)
		end

		return
	end)

	arg_116_0.btnSkill = findTF(arg_116_0.gameUI, "btnSkill")

	onButton(arg_116_0, arg_116_0.btnSkill, function()
		if arg_116_0.skilTime == var_0_14 then
			arg_116_0.skilTime = 0

			arg_116_0:usePlayerSkill()
		end

		return
	end)
	arg_116_0:updateMenuUI()
	arg_116_0:openMenuUI()

	arg_116_0.handle = arg_116_0.handle or UpdateBeat:CreateListener(arg_116_0.Update, arg_116_0)

	UpdateBeat:AddListener(arg_116_0.handle)

	return
end

function var_0_0.Update(arg_143_0)
	arg_143_0:AddDebugInput()

	return
end

function var_0_0.AddDebugInput(arg_144_0)
	if arg_144_0.gameStop or arg_144_0.settlementFlag then
		return
	end

	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.W) and arg_144_0.playerPosIndex and arg_144_0.playerPosIndex > 1 then
			arg_144_0.playerPosIndex = arg_144_0.playerPosIndex - 1

			arg_144_0:movePlayerTo(arg_144_0.playerPosIndex)
		end

		if Input.GetKeyDown(KeyCode.S) and arg_144_0.playerPosIndex and arg_144_0.playerPosIndex < #arg_144_0.playerMoveVecs then
			arg_144_0.playerPosIndex = arg_144_0.playerPosIndex + 1

			arg_144_0:movePlayerTo(arg_144_0.playerPosIndex)
		end
	end

	return
end

function var_0_0.getCurrentDiff(arg_145_0)
	for iter_145_0 = #var_0_20, 1, -1 do
		if arg_145_0.gameStepTime > var_0_20[iter_145_0] then
			return iter_145_0
		end
	end

	return
end

function var_0_0.updateMenuUI(arg_146_0)
	local var_146_0 = arg_146_0:getGameUsedTimes()
	local var_146_1 = arg_146_0:getGameTimes()

	for iter_146_0 = 1, #arg_146_0.battleItems do
		setActive(findTF(arg_146_0.battleItems[iter_146_0], "state_open"), false)
		setActive(findTF(arg_146_0.battleItems[iter_146_0], "state_closed"), false)
		setActive(findTF(arg_146_0.battleItems[iter_146_0], "state_clear"), false)
		setActive(findTF(arg_146_0.battleItems[iter_146_0], "state_current"), false)

		if iter_146_0 <= var_146_0 then
			setActive(findTF(arg_146_0.battleItems[iter_146_0], "state_clear"), true)
		elseif iter_146_0 == var_146_0 + 1 and var_146_1 >= 1 then
			setActive(findTF(arg_146_0.battleItems[iter_146_0], "state_current"), true)
		elseif var_146_0 < iter_146_0 and iter_146_0 <= var_146_0 + var_146_1 then
			setActive(findTF(arg_146_0.battleItems[iter_146_0], "state_open"), true)
		else
			setActive(findTF(arg_146_0.battleItems[iter_146_0], "state_closed"), true)
		end
	end

	arg_146_0.totalTimes = arg_146_0:getGameTotalTime()

	local var_146_2 = 1 - (arg_146_0:getGameUsedTimes() - 3 < 0 and 0 or arg_146_0:getGameUsedTimes() - 3) / (arg_146_0.totalTimes - 4)

	if var_146_2 > 1 then
		var_146_2 = 1
	end

	scrollTo(arg_146_0.battleScrollRect, 0, var_146_2)
	setActive(findTF(arg_146_0.menuUI, "btnStart/tip"), var_146_1 > 0)
	arg_146_0:CheckGet()

	return
end

function var_0_0.CheckGet(arg_147_0)
	setActive(findTF(arg_147_0.menuUI, "got"), false)

	if arg_147_0:getUltimate() and arg_147_0:getUltimate() ~= 0 then
		setActive(findTF(arg_147_0.menuUI, "got"), true)
	end

	if arg_147_0:getUltimate() == 0 then
		if arg_147_0:getGameTotalTime() > arg_147_0:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_147_0:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(arg_147_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.openMenuUI(arg_148_0)
	setActive(findTF(arg_148_0._tf, "scene_front"), false)
	setActive(findTF(arg_148_0._tf, "scene_background"), false)
	setActive(findTF(arg_148_0._tf, "scene"), false)
	setActive(arg_148_0.gameUI, false)
	setActive(arg_148_0.menuUI, true)
	arg_148_0:updateMenuUI()

	return
end

function var_0_0.clearUI(arg_149_0)
	setActive(arg_149_0.sceneTf, false)
	setActive(arg_149_0.settlementUI, false)
	setActive(arg_149_0.countUI, false)
	setActive(arg_149_0.menuUI, false)
	setActive(arg_149_0.gameUI, false)

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_150_0, arg_150_1)
	if arg_150_0.sendSuccessFlag then
		local var_150_0 = getProxy(MiniGameProxy):GetMiniGameData(MiniGameDataCreator.NewYearShrineGameID):GetRuntimeData("count") or 0

		pg.m02:sendNotification(GAME.MODIFY_MINI_GAME_DATA, {
			id = MiniGameDataCreator.NewYearShrineGameID,
			map = {
				count = var_150_0 + 2
			}
		})

		arg_150_0.sendSuccessFlag = false
	end

	return
end

function var_0_0.readyStart(arg_151_0)
	setActive(arg_151_0.countUI, true)
	arg_151_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_23)

	return
end

function var_0_0.gameStart(arg_152_0)
	setActive(findTF(arg_152_0._tf, "scene_front"), true)
	setActive(findTF(arg_152_0._tf, "scene_background"), true)
	setActive(findTF(arg_152_0._tf, "scene"), true)
	setActive(arg_152_0.gameUI, true)
	setActive(arg_152_0.lockTf, false)

	arg_152_0.gameStartFlag = true
	arg_152_0.scoreNum = 0
	arg_152_0.skilTime = 0
	arg_152_0.playerPosIndex = 2

	arg_152_0:movePlayerTo(arg_152_0.playerPosIndex)

	arg_152_0.specialTime = 0
	arg_152_0.gameStepTime = 0

	arg_152_0.player:prepare()
	arg_152_0.snowballController:prepare()
	arg_152_0.charactorController:prepare()
	arg_152_0.colliderController:prepare()
	arg_152_0:updateGameUI()
	arg_152_0:timerStart()

	return
end

function var_0_0.onPlayerDamage(arg_153_0)
	arg_153_0:updateGameUI()

	return
end

function var_0_0.getGameTimes(arg_154_0)
	return arg_154_0:GetMGHubData().count
end

function var_0_0.getGameUsedTimes(arg_155_0)
	return arg_155_0:GetMGHubData().usedtime
end

function var_0_0.getUltimate(arg_156_0)
	return arg_156_0:GetMGHubData().ultimate
end

function var_0_0.getGameTotalTime(arg_157_0)
	return (arg_157_0:GetMGHubData():getConfig("reward_need"))
end

function var_0_0.changeSpeed(arg_158_0, arg_158_1)
	arg_158_0.player:setSpeed(arg_158_1)

	arg_158_0.specialAniamtor.speed = arg_158_1

	arg_158_0.charactorController:setSpeed(arg_158_1)

	return
end

function var_0_0.onTimer(arg_159_0)
	arg_159_0.player:step()
	arg_159_0.snowballController:step()
	arg_159_0.charactorController:step()
	arg_159_0.colliderController:step()
	arg_159_0:gameStep()

	return
end

function var_0_0.gameStep(arg_160_0)
	arg_160_0.gameStepTime = arg_160_0.gameStepTime + Time.deltaTime
	arg_160_0.skilTime = arg_160_0.skilTime + Time.deltaTime

	if arg_160_0.skilTime > var_0_14 then
		arg_160_0.skilTime = var_0_14
	end

	arg_160_0.skillProgress = arg_160_0.skillProgress or GetComponent(findTF(arg_160_0.btnSkill, "progress"), typeof(Image))
	arg_160_0.skillProgress.fillAmount = arg_160_0.skilTime / var_0_14

	if arg_160_0.skilTime == var_0_14 then
		if not isActive(findTF(arg_160_0.gameUI, "xuehezhan_zhiyuantiao")) then
			setActive(findTF(arg_160_0.gameUI, "xuehezhan_zhiyuantiao"), true)
		end
	elseif isActive(findTF(arg_160_0.gameUI, "xuehezhan_zhiyuantiao")) then
		setActive(findTF(arg_160_0.gameUI, "xuehezhan_zhiyuantiao"), false)
	end

	if arg_160_0.gameStepTime < arg_160_0.specialTime then
		arg_160_0.specialIndex = arg_160_0.specialIndex or 0

		if arg_160_0.specialIndex > 20 then
			arg_160_0.specialIndex = 0

			arg_160_0.charactorController:damageEnemy()
		end

		arg_160_0.specialIndex = arg_160_0.specialIndex + 1
	end

	return
end

function var_0_0.timerStart(arg_161_0)
	if not arg_161_0.timer.running then
		arg_161_0.timer:Start()
	end

	return
end

function var_0_0.timerStop(arg_162_0)
	if arg_162_0.timer.running then
		arg_162_0.timer:Stop()
	end

	return
end

function var_0_0.movePlayerTo(arg_163_0, arg_163_1)
	arg_163_0.player:move(arg_163_0.playerMoveVecs[arg_163_1])

	return
end

function var_0_0.updateGameUI(arg_164_0)
	setSlider(arg_164_0.lifeProgress, 0, 1, arg_164_0.player:getLife() / var_0_11)
	setText(arg_164_0.textLife, arg_164_0.player:getLife() .. "/" .. var_0_11)
	setText(arg_164_0.textScore, arg_164_0.scoreNum)

	return
end

function var_0_0.throwSnowballTo(arg_165_0, arg_165_1, arg_165_2, arg_165_3)
	arg_165_0.throwTarget = arg_165_1
	arg_165_0.targetIndex = arg_165_2

	if arg_165_0.player:throw() and arg_165_0.targetCharactor ~= arg_165_3 then
		setActive(arg_165_0.lockTf, false)

		arg_165_0.lockTf.anchoredPosition = arg_165_1

		setActive(arg_165_0.lockTf, true)

		arg_165_0.targetCharactor = arg_165_3
	end

	return
end

function var_0_0.onPlayerThrowSnowball(arg_166_0, arg_166_1)
	if arg_166_0.throwTarget then
		arg_166_0.snowballController:createSnowball(arg_166_0.sceneTf:InverseTransformPoint(arg_166_1.x, arg_166_1.y, 0), arg_166_0.throwTarget, var_0_13, var_0_2, arg_166_0.targetIndex)

		arg_166_0.throwTarget = nil
		arg_166_0.targetIndex = nil
	end

	return
end

function var_0_0.onEnemyThrowSnowball(arg_167_0, arg_167_1, arg_167_2, arg_167_3)
	local var_167_0 = arg_167_0.player:getTargetPosition()

	arg_167_0.snowballController:createSnowball(arg_167_0.sceneTf:InverseTransformPoint(arg_167_1.x, arg_167_1.y, 0), arg_167_0.sceneTf:InverseTransformPoint(var_167_0.x, var_167_0.y, 0), arg_167_3, var_0_3, arg_167_2)

	return
end

function var_0_0.usePlayerSkill(arg_168_0)
	Time.timeScale = 0.05

	LeanTween.delayedCall(go(arg_168_0.specialTf), 3, System.Action(function()
		if Time.timeScale ~= 1 then
			Time.timeScale = 1
		end

		return
	end))
	arg_168_0.player:skill()
	arg_168_0.snowballController:clearEnemySnowball()
	setActive(arg_168_0.specialTf, true)

	arg_168_0.specialEffect = arg_168_0.specialEffect or findTF(arg_168_0._tf, "xuehezhan_xueqiuhongzha")

	setActive(arg_168_0.specialEffect, false)
	setActive(arg_168_0.specialEffect, true)

	return
end

function var_0_0.specialComplete(arg_170_0)
	Time.timeScale = 1

	setActive(arg_170_0.specialTf, false)

	arg_170_0.specialTime = arg_170_0.gameStepTime + var_0_15
	arg_170_0.specialIndex = 0

	return
end

function var_0_0.dropSpeedUp(arg_171_0)
	return
end

function var_0_0.onHitEnemy(arg_172_0, arg_172_1, arg_172_2)
	arg_172_0:addScore(arg_172_1, arg_172_2)
	arg_172_0:updateGameUI()

	return
end

function var_0_0.addScore(arg_173_0, arg_173_1, arg_173_2)
	arg_173_0.scoreNum = arg_173_0.scoreNum + arg_173_1

	if arg_173_0.scoreNum < 0 then
		arg_173_0.scoreNum = 0
	end

	local var_173_0 = tf(instantiate(arg_173_0.tplScore))
	local var_173_1 = findTF(var_173_0, "ad")
	local var_173_2 = GetComponent(var_173_1, typeof(DftAniEvent))

	var_173_0.anchoredPosition = arg_173_0.snowballContainer:InverseTransformPoint(arg_173_2)

	if arg_173_1 > 0 then
		setActive(findTF(var_173_1, "add"), true)
		setText(findTF(var_173_1, "add"), "+" .. arg_173_1)
	else
		setActive(findTF(var_173_1, "sub"), true)
		setText(findTF(var_173_1, "sub"), arg_173_1)
	end

	setParent(var_173_0, arg_173_0.snowballContainer)
	var_173_2:SetEndEvent(function()
		setActive(var_173_0, false)
		Destroy(var_173_0)

		return
	end)
	setActive(var_173_0, true)

	return
end

function var_0_0.onGameOver(arg_175_0)
	arg_175_0:timerStop()

	arg_175_0.settlementFlag = true

	setActive(arg_175_0.clickMask, true)
	LeanTween.delayedCall(go(arg_175_0._tf), 2, System.Action(function()
		arg_175_0.settlementFlag = false
		arg_175_0.gameStartFlag = false

		setActive(arg_175_0.clickMask, false)
		setActive(findTF(arg_175_0.gameUI, "xuehezhan_zhiyuantiao"), false)
		setActive(arg_175_0.specialTf, false)
		arg_175_0:showSettlement()

		return
	end))

	return
end

function var_0_0.showSettlement(arg_177_0)
	setActive(arg_177_0.settlementUI, true)
	GetComponent(findTF(arg_177_0.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_177_0 = arg_177_0:GetMGData():GetRuntimeData("elements")
	local var_177_1 = arg_177_0.scoreNum

	if var_177_0 and #var_177_0 > 0 then
		local var_177_2 = var_177_0[1] or 0

		if var_177_2 <= var_177_1 then
			var_177_2 = var_177_1

			arg_177_0:StoreDataToServer({
				var_177_1
			})
		end

		setText(findTF(arg_177_0.settlementUI, "ad/highText"), var_177_2)
		setText(findTF(arg_177_0.settlementUI, "ad/currentText"), var_177_1)

		if arg_177_0:getGameTimes() and arg_177_0:getGameTimes() > 0 then
			arg_177_0.sendSuccessFlag = true

			arg_177_0:SendSuccess(0)
		end

		return
	end
end

function var_0_0.resumeGame(arg_178_0)
	arg_178_0.gameStop = false

	setActive(arg_178_0.leaveUI, false)
	arg_178_0:changeSpeed(1)
	arg_178_0:timerStart()

	return
end

function var_0_0.stopGame(arg_179_0)
	arg_179_0.gameStop = true

	arg_179_0:timerStop()
	arg_179_0:changeSpeed(0)

	return
end

function var_0_0.onBackPressed(arg_180_0)
	if not arg_180_0.gameStartFlag then
		arg_180_0:emit(var_0_0.ON_BACK_PRESSED)
	else
		if arg_180_0.settlementFlag then
			return
		end

		if isActive(arg_180_0.pauseUI) then
			setActive(arg_180_0.pauseUI, false)
		end

		arg_180_0:stopGame()
		setActive(arg_180_0.leaveUI, true)
	end

	return
end

function var_0_0.willExit(arg_181_0)
	if arg_181_0.handle then
		UpdateBeat:RemoveListener(arg_181_0.handle)
	end

	if not arg_181_0._tf then
		print()
	end

	if arg_181_0._tf and LeanTween.isTweening(go(arg_181_0._tf)) then
		LeanTween.cancel(go(arg_181_0._tf))
	end

	if arg_181_0.specialTf and LeanTween.isTweening(go(arg_181_0.specialTf)) then
		LeanTween.cancel(go(arg_181_0.specialTf))
	end

	if arg_181_0.specialEffect and LeanTween.isTweening(go(arg_181_0.specialEffect)) then
		LeanTween.cancel(go(arg_181_0.specialEffect))
	end

	if arg_181_0.timer and arg_181_0.timer.running then
		arg_181_0.timer:Stop()
	end

	Time.timeScale = 1
	arg_181_0.timer = nil

	return
end

return var_0_0
