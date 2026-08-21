local var_0_0 = class("LaunchBallAmulet")
local var_0_1 = {}

;({})[1] = 1
;({})[2] = 3
;({})[3] = 4
;({})[4] = 7
;({})[5] = 2
;({})[6] = 5
;({})[7] = 6

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

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.amuletLAnimators = {}
	arg_1_0.amuletSAnimators = {}
	arg_1_0.amuletEFAnimators = {}

	for iter_1_0, iter_1_1 in ipairs(var_0_16) do
		local var_1_1 = LoadAny(LaunchBallGameVo.ui_atlas, iter_1_1.animator .. "S", typeof(RuntimeAnimatorController))
		local var_1_2 = LoadAny(LaunchBallGameVo.ui_atlas, iter_1_1.animator .. "EF", typeof(RuntimeAnimatorController))

		table.insert(arg_1_0.amuletLAnimators, {
			animator = LoadAny(LaunchBallGameVo.ui_atlas, iter_1_1.animator .. "L", typeof(RuntimeAnimatorController)),
			type = iter_1_0,
			name = iter_1_1.name
		})
		table.insert(arg_1_0.amuletSAnimators, {
			animator = var_1_1,
			type = iter_1_0,
			name = iter_1_1.name
		})
		table.insert(arg_1_0.amuletEFAnimators, {
			animator = var_1_2,
			type = iter_1_0,
			name = iter_1_1.name
		})
	end

	arg_1_0._content = arg_1_1
	arg_1_0._sContent = arg_1_2
	arg_1_0._lifeContent = arg_1_3
	arg_1_0._tpl = arg_1_4
	arg_1_0._eventCall = arg_1_5
	arg_1_0._amuletLTpl = findTF(arg_1_0._tpl, "amuletL")
	arg_1_0._amuletSTpl = findTF(arg_1_0._tpl, "amuletS")
	arg_1_0._amuletEfTpl = findTF(arg_1_0._tpl, "amuletEF")
	arg_1_0._butterflyTpl = findTF(arg_1_0._tpl, "Butterfly")

	arg_1_0:setAmuletL(nil)

	arg_1_0.amuletS = nil
	arg_1_0.amuletEFs = {}
	arg_1_0.amuletLPool = {}
	arg_1_0.amuletSPool = {}
	arg_1_0.amuletEFPool = {}
	arg_1_0._amuletFires = {}
	arg_1_0.butterflys = {}

	return
end

function var_0_0.start(arg_2_0)
	arg_2_0.lifeBound = GetComponent(findTF(arg_2_0._lifeContent, tostring(LaunchBallGameVo.gameRoundData.amulet_life)), typeof(BoxCollider2D))
	arg_2_0.min = arg_2_0._lifeContent:InverseTransformPoint(arg_2_0.lifeBound.bounds.min)
	arg_2_0.max = arg_2_0._lifeContent:InverseTransformPoint(arg_2_0.lifeBound.bounds.max)
	arg_2_0.amuletType = arg_2_0:getRandomAmuletType()
	arg_2_0.amuletNextType = arg_2_0:getRandomAmuletType()

	arg_2_0:setAmuletL(arg_2_0:getAmulete(var_0_3, arg_2_0.amuletType))

	arg_2_0.amuletS = arg_2_0:getAmulete(var_0_2, arg_2_0.amuletNextType)
	arg_2_0.amuletPos = Vector2(0, 0)
	arg_2_0.angle = var_0_12
	arg_2_0.rad = var_0_12 * math.deg2Rad
	arg_2_0.amuletPos.x = math.cos(arg_2_0.rad) * var_0_8
	arg_2_0.amuletPos.y = math.sin(arg_2_0.rad) * var_0_8
	arg_2_0.isPlaying = false

	return
end

function var_0_0.step(arg_3_0)
	if not arg_3_0.isPlaying then
		if LaunchBallGameVo.joyStickData and LaunchBallGameVo.joyStickData.angle then
			arg_3_0.rad = LaunchBallGameVo.joyStickData.rad
			arg_3_0.angle = LaunchBallGameVo.joyStickData.angle
			arg_3_0.amuletPos.x = math.cos(arg_3_0.rad) * var_0_8
			arg_3_0.amuletPos.y = math.sin(arg_3_0.rad) * var_0_8
		end

		if arg_3_0.amuletL then
			arg_3_0.amuletL.tf.anchoredPosition = arg_3_0.amuletPos
			arg_3_0.amuletL.rad = arg_3_0.rad
		else
			arg_3_0:setAmuletL(arg_3_0:getAmulete(var_0_3, arg_3_0.amuletNextType))
			arg_3_0:returnAmulete(arg_3_0.amuletS, arg_3_0.amuletSPool)

			arg_3_0.amuletNextType = arg_3_0:getRandomAmuletType()
			arg_3_0.amuletS = nil
			arg_3_0.amuletS = arg_3_0:getAmulete(var_0_2, arg_3_0.amuletNextType)
		end

		if arg_3_0.amuletS then
			arg_3_0.amuletS.tf.anchoredPosition = Vector2(math.cos(arg_3_0.rad) * var_0_9, math.sin(arg_3_0.rad) * var_0_9)
		end
	end

	if arg_3_0._amuletFires and #arg_3_0._amuletFires > 0 then
		for iter_3_0 = #arg_3_0._amuletFires, 1, -1 do
			arg_3_0._amuletFires[iter_3_0].tf.anchoredPosition.x = arg_3_0._amuletFires[iter_3_0].tf.anchoredPosition.x + arg_3_0._amuletFires[iter_3_0].speed.x * LaunchBallGameVo.deltaTime
			arg_3_0._amuletFires[iter_3_0].tf.anchoredPosition.y = arg_3_0._amuletFires[iter_3_0].tf.anchoredPosition.y + arg_3_0._amuletFires[iter_3_0].speed.y * LaunchBallGameVo.deltaTime
			arg_3_0._amuletFires[iter_3_0].tf.anchoredPosition = arg_3_0._amuletFires[iter_3_0].tf.anchoredPosition

			if arg_3_0._amuletFires[iter_3_0].effectTime and arg_3_0._amuletFires[iter_3_0].effectTime > 0 then
				arg_3_0._amuletFires[iter_3_0].effectTime = arg_3_0._amuletFires[iter_3_0].effectTime - LaunchBallGameVo.deltaTime

				if arg_3_0._amuletFires[iter_3_0].effectTime <= 0 then
					arg_3_0._amuletFires[iter_3_0].effectTime = var_0_14

					arg_3_0:createEF(arg_3_0._amuletFires[iter_3_0])
				end
			end

			if math.abs(arg_3_0._amuletFires[iter_3_0].tf.anchoredPosition.x) > var_0_13 or math.abs(arg_3_0._amuletFires[iter_3_0].tf.anchoredPosition.y) > var_0_13 then
				table.remove(arg_3_0._amuletFires, iter_3_0)
				arg_3_0:returnAmulete(arg_3_0._amuletFires[iter_3_0], arg_3_0.amuletLPool)
			elseif arg_3_0._amuletFires[iter_3_0].removeFlag then
				table.remove(arg_3_0._amuletFires, iter_3_0)
				arg_3_0:returnAmulete(arg_3_0._amuletFires[iter_3_0], arg_3_0.amuletLPool)
			elseif arg_3_0.lifeBound then
				if arg_3_0._amuletFires[iter_3_0].tf.anchoredPosition.x >= arg_3_0.max.x or arg_3_0._amuletFires[iter_3_0].tf.anchoredPosition.x <= arg_3_0.min.x then
					table.remove(arg_3_0._amuletFires, iter_3_0)
					arg_3_0:returnAmulete(arg_3_0._amuletFires[iter_3_0], arg_3_0.amuletLPool)
				elseif arg_3_0._amuletFires[iter_3_0].tf.anchoredPosition.y >= arg_3_0.max.y or arg_3_0._amuletFires[iter_3_0].tf.anchoredPosition.y <= arg_3_0.min.y then
					table.remove(arg_3_0._amuletFires, iter_3_0)
					arg_3_0:returnAmulete(arg_3_0._amuletFires[iter_3_0], arg_3_0.amuletLPool)
				end
			end
		end
	end

	if arg_3_0.butterflys and #arg_3_0.butterflys > 0 then
		for iter_3_1 = #arg_3_0.butterflys, 1, -1 do
			arg_3_0.butterflys[iter_3_1].tf.anchoredPosition.x = arg_3_0.butterflys[iter_3_1].tf.anchoredPosition.x + arg_3_0.butterflys[iter_3_1].speed.x * LaunchBallGameVo.deltaTime
			arg_3_0.butterflys[iter_3_1].tf.anchoredPosition.y = arg_3_0.butterflys[iter_3_1].tf.anchoredPosition.y + arg_3_0.butterflys[iter_3_1].speed.y * LaunchBallGameVo.deltaTime
			arg_3_0.butterflys[iter_3_1].tf.anchoredPosition = arg_3_0.butterflys[iter_3_1].tf.anchoredPosition

			if math.abs(arg_3_0.butterflys[iter_3_1].tf.anchoredPosition.x) > var_0_13 or math.abs(arg_3_0.butterflys[iter_3_1].tf.anchoredPosition.y) > var_0_13 then
				arg_3_0.butterflys[iter_3_1].anim = nil

				Destroy(arg_3_0.butterflys[iter_3_1].tf)
				table.remove(arg_3_0.butterflys, iter_3_1)
			elseif arg_3_0.butterflys[iter_3_1].removeFlag then
				arg_3_0.butterflys[iter_3_1].anim = nil

				Destroy(arg_3_0.butterflys[iter_3_1].tf)
				table.remove(arg_3_0.butterflys, iter_3_1)
			elseif arg_3_0.butterflys[iter_3_1].tf.anchoredPosition.x >= arg_3_0.max.x or arg_3_0.butterflys[iter_3_1].tf.anchoredPosition.x <= arg_3_0.min.x then
				arg_3_0.butterflys[iter_3_1].anim = nil

				Destroy(arg_3_0.butterflys[iter_3_1].tf)
				table.remove(arg_3_0.butterflys, iter_3_1)
			elseif arg_3_0.butterflys[iter_3_1].tf.anchoredPosition.y >= arg_3_0.max.y or arg_3_0.butterflys[iter_3_1].tf.anchoredPosition.y <= arg_3_0.min.y then
				arg_3_0.butterflys[iter_3_1].anim = nil

				Destroy(arg_3_0.butterflys[iter_3_1].tf)
				table.remove(arg_3_0.butterflys, iter_3_1)
			elseif arg_3_0.butterflys[iter_3_1].removeTime and arg_3_0.butterflys[iter_3_1].removeTime > 0 then
				arg_3_0.butterflys[iter_3_1].removeTime = arg_3_0.butterflys[iter_3_1].removeTime - LaunchBallGameVo.deltaTime

				if arg_3_0.butterflys[iter_3_1].removeTime < 0 then
					arg_3_0.butterflys[iter_3_1].removeTime = nil
					arg_3_0.butterflys[iter_3_1].removeFlag = true
				end
			end
		end
	end

	if arg_3_0.amuletEFs and #arg_3_0.amuletEFs > 0 then
		for iter_3_2 = #arg_3_0.amuletEFs, 1, -1 do
			if arg_3_0.amuletEFs[iter_3_2].removeTime and arg_3_0.amuletEFs[iter_3_2].removeTime > 0 then
				arg_3_0.amuletEFs[iter_3_2].removeTime = arg_3_0.amuletEFs[iter_3_2].removeTime - LaunchBallGameVo.deltaTime

				if arg_3_0.amuletEFs[iter_3_2].removeTime <= 0 then
					table.remove(arg_3_0.amuletEFs, iter_3_2)
					arg_3_0:returnAmulete(arg_3_0.amuletEFs[iter_3_2], arg_3_0.amuletEFPool)
				end
			end
		end
	end

	return
end

function var_0_0.getFireAmulet(arg_4_0)
	return arg_4_0._amuletFires
end

function var_0_0.removeFireAmulet(arg_5_0, arg_5_1)
	if arg_5_0._amuletFires and #arg_5_0._amuletFires > 0 then
		for iter_5_0 = #arg_5_0._amuletFires, 1, -1 do
			if arg_5_0._amuletFires[iter_5_0] then
				table.remove(arg_5_0._amuletFires, iter_5_0)
				arg_5_0:returnAmulete(arg_5_0._amuletFires[iter_5_0], arg_5_0.amuletLPool)
			end
		end
	end

	return
end

var_0_0.fireIndex = 0

function var_0_0.getAmulete(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0
	local var_6_1
	local var_6_2
	local var_6_3
	local var_6_4 = arg_6_0._content

	if arg_6_1 == var_0_3 then
		var_6_1 = arg_6_0.amuletLPool
		var_6_2 = arg_6_0._amuletLTpl
		var_6_3 = Vector2(0, var_0_8)
	elseif arg_6_1 == var_0_2 then
		var_6_1 = arg_6_0.amuletSPool
		var_6_2 = arg_6_0._amuletSTpl
		var_6_3 = Vector2(0, var_0_9)
		var_6_4 = arg_6_0._sContent
	elseif arg_6_1 == var_0_4 then
		var_6_1 = arg_6_0.amuletEFPool
		var_6_2 = arg_6_0._amuletEfTpl
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
	var_6_0.anim.runtimeAnimatorController = arg_6_0:getAnimator(arg_6_1, arg_6_2)
	var_6_0.tf.name = arg_6_1 .. "_" .. var_0_16[arg_6_2].name
	var_6_0.color = arg_6_2
	findTF(var_6_0.tf, "ad").localRotation = Quaternion.Euler(0, 0, 0)
	var_6_0.removeFlag = false

	if arg_6_1 == var_0_3 then
		var_6_0.effectTime = var_0_14
		var_6_0.effectIndex = 1
		var_6_0[LaunchBallGameConst.amulet_buff_back] = false
		var_6_0.concentrate = false
		var_6_0.fireIndex = var_0_0.fireIndex
		var_6_0.overFlag = false
		var_6_0.overCount = 0
		var_0_0.fireIndex = var_0_0.fireIndex + 1
	elseif arg_6_1 == var_0_2 then
		-- block empty
	elseif arg_6_1 == var_0_4 then
		var_6_0.removeTime = var_0_15
	end

	return var_6_0
end

function var_0_0.returnAmulete(arg_7_0, arg_7_1, arg_7_2)
	setActive(arg_7_1.tf, false)
	table.insert(arg_7_2, arg_7_1)

	return
end

function var_0_0.getColor(arg_8_0)
	return arg_8_0.amuletL.color
end

function var_0_0.fireAmulet(arg_9_0)
	if arg_9_0.amuletL then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(LaunchBallGameVo.SFX_FIRE)

		arg_9_0.amuletPos.x = math.cos(arg_9_0.rad) * var_0_8
		arg_9_0.amuletPos.y = math.sin(arg_9_0.rad) * var_0_8
		arg_9_0.amuletL.tf.anchoredPosition = arg_9_0.amuletPos
		arg_9_0.amuletL.angle = arg_9_0.angle
		arg_9_0.amuletL.rad = arg_9_0.rad
		arg_9_0.amuletL.speed = Vector2(math.cos(arg_9_0.amuletL.rad) * var_0_10, math.sin(arg_9_0.amuletL.rad) * var_0_10)

		arg_9_0.amuletL.anim:Play("L_Fire")

		findTF(arg_9_0.amuletL.tf, "ad").localEulerAngles = Vector3(0, 0, arg_9_0.angle + var_0_11)

		if arg_9_0.concentrateTime then
			arg_9_0.amuletL.concentrate = true
			arg_9_0.concentrateTime = arg_9_0.concentrateTime - 1

			if arg_9_0.concentrateTime <= 0 then
				arg_9_0.concentrateTime = nil
			end
		end

		table.insert(arg_9_0._amuletFires, arg_9_0.amuletL)
		arg_9_0:setAmuletL(nil)
	end

	return
end

function var_0_0.randomFireAmulet(arg_10_0, arg_10_1)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(LaunchBallGameVo.SFX_FIRE)

	local var_10_0 = arg_10_0:getAmulete(var_0_3, arg_10_0:getRandomAmuletType())

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		var_10_0[iter_10_0] = iter_10_1
	end

	local var_10_1 = math.random(1, 360)

	var_10_0.tf.anchoredPosition = Vector2(0, 0)
	var_10_0.rad = arg_10_0.rad
	var_10_0.speed = Vector2(math.cos(math.deg2Rad * var_10_1) * var_0_10, math.sin(math.deg2Rad * var_10_1) * var_0_10)

	var_10_0.anim:Play("L_Fire")

	findTF(var_10_0.tf, "ad").localEulerAngles = Vector3(0, 0, var_10_1 + var_0_11)

	table.insert(arg_10_0._amuletFires, var_10_0)

	return
end

function var_0_0.setAmuletL(arg_11_0, arg_11_1)
	arg_11_0.amuletL = arg_11_1
	LaunchBallGameVo.amulet = arg_11_0.amuletL

	return
end

function var_0_0.createEF(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getAmulete(var_0_4, arg_12_1.color)

	arg_12_1.effectIndex = arg_12_1.effectIndex + 1
	var_12_0.tf.anchoredPosition = arg_12_1.tf.anchoredPosition

	local var_12_1 = math.cos(arg_12_1.rad)
	local var_12_2 = math.sin(arg_12_1.rad)

	findTF(var_12_0.tf, "ad").anchoredPosition = Vector2(var_12_1 * var_0_6[arg_12_1.effectIndex % var_0_5 + 1].offset.x - var_12_2 * var_0_6[arg_12_1.effectIndex % var_0_5 + 1].offset.y, var_12_1 * var_0_6[arg_12_1.effectIndex % var_0_5 + 1].offset.y + var_12_2 * var_0_6[arg_12_1.effectIndex % var_0_5 + 1].offset.x)

	var_12_0.anim:Play(var_0_6[arg_12_1.effectIndex % var_0_5 + 1].anim_name)
	table.insert(arg_12_0.amuletEFs, var_12_0)

	return
end

function var_0_0.getRandomAmuletType(arg_13_0)
	if not LaunchBallGameVo.enemyColors or #LaunchBallGameVo.enemyColors == 0 then
		return var_0_1[math.random(1, #var_0_1)]
	else
		return LaunchBallGameVo.enemyColors[math.random(1, #LaunchBallGameVo.enemyColors)]
	end

	return
end

function var_0_0.getAnimator(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0

	if arg_14_1 == var_0_3 then
		var_14_0 = arg_14_0.amuletLAnimators
	elseif arg_14_1 == var_0_2 then
		var_14_0 = arg_14_0.amuletSAnimators
	elseif arg_14_1 == var_0_4 then
		var_14_0 = arg_14_0.amuletEFAnimators
	end

	for iter_14_0 = 1, #var_14_0 do
		if var_14_0[iter_14_0].type == arg_14_2 then
			return var_14_0[iter_14_0].animator
		end
	end

	return
end

function var_0_0.getAmuletPos(arg_15_0, arg_15_1, arg_15_2)
	return Vector2(math.cos(arg_15_2) * arg_15_1, math.sin(arg_15_2) * arg_15_1)
end

function var_0_0.getAngle(arg_16_0)
	return arg_16_0.angle
end

function var_0_0.eventCall(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == LaunchBallGameScene.PLAYING_CHANGE then
		arg_17_0.isPlaying = arg_17_2
	elseif arg_17_1 == LaunchBallGameScene.FIRE_AMULET then
		arg_17_0:fireAmulet()
	elseif arg_17_1 == LaunchBallGameScene.RANDOM_FIRE then
		for iter_17_0 = 1, arg_17_2.num do
			arg_17_0:randomFireAmulet(arg_17_2.data)
		end
	elseif arg_17_1 == LaunchBallGameScene.CHANGE_AMULET then
		if arg_17_0.changeTime and LaunchBallGameVo.gameStepTime - arg_17_0.changeTime < 1 then
			return
		end

		if arg_17_0.amuletL then
			arg_17_0.changeTime = LaunchBallGameVo.gameStepTime

			arg_17_0:returnAmulete(arg_17_0.amuletL, arg_17_0.amuletLPool)
			arg_17_0:setAmuletL(nil)
		end
	elseif arg_17_1 == LaunchBallGameScene.CONCENTRATE_TRIGGER then
		arg_17_0.concentrateTime = arg_17_2.time
	elseif arg_17_1 == LaunchBallGameScene.SLEEP_TIME_TRIGGER then
		print("创建一个小蝴蝶")

		local var_17_0 = arg_17_0:createButterfly()
	end

	return
end

function var_0_0.getButterfly(arg_18_0)
	return arg_18_0.butterflys
end

function var_0_0.createButterfly(arg_19_0)
	local var_19_0 = tf(instantiate(arg_19_0._butterflyTpl))
	local var_19_1 = GetComponent(findTF(var_19_0, "ad/anim"), typeof(Animator))

	var_19_0.anchoredPosition = Vector2(math.random(1, 20), math.random(1, 20))

	local var_19_2 = math.deg2Rad * math.random(1, 360)
	local var_19_3 = Vector2(math.cos(var_19_2) * var_0_7, math.sin(var_19_2) * var_0_7)
	local var_19_4 = 3

	if var_19_3.x > 0 then
		local var_19_5 = -1 * var_19_4 or 1 * var_19_4

		findTF(var_19_0, "ad/anim").localScale = Vector3(var_19_5, var_19_4, var_19_4)

		table.insert(arg_19_0.butterflys, {
			tf = var_19_0,
			anim = var_19_1,
			speed = var_19_3
		})
		setParent(var_19_0, arg_19_0._content)
		setActive(var_19_0, true)

		return
	end
end

function var_0_0.clear(arg_20_0)
	arg_20_0:clearAmulet()

	return
end

function var_0_0.clearAmulet(arg_21_0)
	if arg_21_0.amuletL then
		arg_21_0:returnAmulete(arg_21_0.amuletL, arg_21_0.amuletLPool)
		arg_21_0:setAmuletL(nil)
	end

	if arg_21_0.amuletS then
		arg_21_0:returnAmulete(arg_21_0.amuletS, arg_21_0.amuletSPool)

		arg_21_0.amuletS = nil
	end

	if #arg_21_0.amuletEFs > 0 then
		for iter_21_0 = #arg_21_0.amuletEFs, 1, -1 do
			arg_21_0:returnAmulete(table.remove(arg_21_0.amuletEFs, iter_21_0), arg_21_0.amuletEFPool)
		end
	end

	if arg_21_0.butterflys and #arg_21_0.butterflys > 0 then
		for iter_21_1 = #arg_21_0.butterflys, 1, -1 do
			Destroy(arg_21_0.butterflys[iter_21_1].tf)
		end

		arg_21_0.butterflys = {}
	end

	return
end

return var_0_0
