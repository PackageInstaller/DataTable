class = var_0_10000

local var_0_0 = var_0_10000("LaunchBallAmulet")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 5
local var_0_6 = 6
local var_0_7 = 7
local var_0_8 = {
	var_0_1,
	var_0_3,
	var_0_4,
	var_0_7,
	var_0_2,
	var_0_5,
	var_0_6
}
local var_0_9 = "amulet s"
local var_0_10 = "amulet l"
local var_0_11 = "amulet ef"
local var_0_12 = 3
local var_0_13 = {}
local var_0_14 = {
	index = 1,
	anim_name = "EF_A"
}

Vector2 = var_0_10015
var_0_14.offset = var_0_10015(0, 20)
var_0_13[1] = var_0_14

local var_0_15 = {
	index = 2,
	anim_name = "EF_B"
}

Vector2 = var_15
var_0_15.offset = var_15(0, 0)
var_0_13[2] = var_0_15

local var_0_16 = {
	index = 3,
	anim_name = "EF_C"
}

Vector2 = var_15
var_0_16.offset = var_15(0, -20)
var_0_13[3] = var_0_16

local var_0_17 = 50
local var_0_18 = 70
local var_0_19 = -80
local var_0_20 = 1000
local var_0_21 = 90
local var_0_22 = -90
local var_0_23 = 1000
local var_0_24 = 0.05
local var_0_25 = 0.5
local var_0_26 = {
	[var_0_1] = {
		animator = "Amulet_Yellow_",
		name = "Yellow"
	},
	[var_0_3] = {
		animator = "Amulet_White_",
		name = "White"
	},
	[var_0_4] = {
		animator = "Amulet_Red_",
		name = "Red"
	},
	[var_0_7] = {
		animator = "Amulet_Purple_",
		name = "Purple"
	},
	[var_0_2] = {
		animator = "Amulet_Green_",
		name = "Green"
	},
	[var_0_5] = {
		animator = "Amulet_Blue_",
		name = "Blue"
	},
	[var_0_6] = {
		animator = "Amulet_Black_",
		name = "Black"
	}
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.amuletLAnimators = {}
	arg_1_0.amuletSAnimators = {}
	arg_1_0.amuletEFAnimators = {}
	ipairs = var_6

	for iter_1_0, iter_1_1 in var_6(var_0_26) do
		local var_1_0 = iter_1_0
		local var_1_1 = iter_1_1.name
		local var_1_2 = iter_1_1.animator

		LoadAny = var_1_10014
		LaunchBallGameVo = var_1_10016
		var_1_10016 = var_1_10016.ui_atlas

		local var_1_3 = var_1_2 .. "L"

		typeof = var_18
		RuntimeAnimatorController = var_1_10020
		var_1_10014 = var_1_10014(var_1_10016, var_1_3, var_18(var_1_10020))
		LoadAny = var_1_10015
		LaunchBallGameVo = var_1_3

		local var_1_4 = var_1_3.ui_atlas
		local var_1_5 = var_1_2 .. "S"

		typeof = var_19
		RuntimeAnimatorController = var_1_10021
		var_1_10015 = var_1_10015(var_1_4, var_1_5, var_19(var_1_10021))
		LoadAny = var_1_10016
		LaunchBallGameVo = var_1_5

		local var_1_6 = var_1_5.ui_atlas
		local var_1_7 = var_1_2 .. "EF"

		typeof = var_1_10020
		RuntimeAnimatorController = var_1_10022
		var_1_10016 = var_1_10016(var_1_6, var_1_7, var_1_10020(var_1_10022))
		table = var_1_4

		var_1_4.insert(arg_1_0.amuletLAnimators, {
			animator = var_1_10014,
			type = var_1_0,
			name = var_1_1
		})

		table = var_17

		var_17.insert(arg_1_0.amuletSAnimators, {
			animator = var_1_10015,
			type = var_1_0,
			name = var_1_1
		})

		table = var_17

		var_17.insert(arg_1_0.amuletEFAnimators, {
			animator = var_1_10016,
			type = var_1_0,
			name = var_1_1
		})
	end

	arg_1_0._content = arg_1_1
	arg_1_0._sContent = arg_1_2
	arg_1_0._lifeContent = arg_1_3
	arg_1_0._tpl = arg_1_4
	arg_1_0._eventCall = arg_1_5
	findTF = var_6
	arg_1_0._amuletLTpl = var_6(arg_1_0._tpl, "amuletL")
	findTF = var_6
	arg_1_0._amuletSTpl = var_6(arg_1_0._tpl, "amuletS")
	findTF = var_6
	arg_1_0._amuletEfTpl = var_6(arg_1_0._tpl, "amuletEF")
	findTF = var_6
	arg_1_0._butterflyTpl = var_6(arg_1_0._tpl, "Butterfly")

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
	LaunchBallGameVo = var_1_10001

	local var_2_0 = var_1_10001.gameRoundData.amulet_life

	GetComponent = var_1_10002
	findTF = var_1_10004

	local var_2_1 = arg_2_0._lifeContent

	tostring = var_1_10007

	local var_2_2 = var_1_10004(var_2_1, var_1_10007(var_2_0))

	typeof = var_1_10005
	BoxCollider2D = var_7
	arg_2_0.lifeBound = var_1_10002(var_2_2, var_1_10005(var_7))

	local var_2_3 = arg_2_0._lifeContent

	arg_2_0.min = var_2.InverseTransformPoint(var_2_3, arg_2_0.lifeBound.bounds.min)

	local var_2_4 = arg_2_0._lifeContent

	arg_2_0.max = var_2.InverseTransformPoint(var_2_4, arg_2_0.lifeBound.bounds.max)
	arg_2_0.amuletType = arg_2_0:getRandomAmuletType()
	arg_2_0.amuletNextType = arg_2_0:getRandomAmuletType()

	arg_2_0:setAmuletL(arg_2_0:getAmulete(var_0_10, arg_2_0.amuletType))

	arg_2_0.amuletS = arg_2_0:getAmulete(var_0_9, arg_2_0.amuletNextType)
	Vector2 = var_2
	arg_2_0.amuletPos = var_2(0, 0)
	arg_2_0.angle = var_0_22

	local var_2_5 = var_0_22

	math = var_1_10003
	arg_2_0.rad = var_2_5 * var_1_10003.deg2Rad

	local var_2_6 = arg_2_0.amuletPos

	math = var_3
	var_2_6.x = var_3.cos(arg_2_0.rad) * var_0_18

	local var_2_7 = arg_2_0.amuletPos

	math = var_3
	var_2_7.y = var_3.sin(arg_2_0.rad) * var_0_18
	arg_2_0.isPlaying = false

	return
end

function var_0_0.step(arg_3_0)
	if not arg_3_0.isPlaying then
		LaunchBallGameVo = var_1

		if var_1.joyStickData then
			LaunchBallGameVo = var_1

			if var_1.joyStickData.angle then
				LaunchBallGameVo = var_1
				arg_3_0.rad = var_1.joyStickData.rad
				LaunchBallGameVo = var_1
				arg_3_0.angle = var_1.joyStickData.angle

				local var_3_0 = arg_3_0.amuletPos

				math = var_1_10002
				var_3_0.x = var_1_10002.cos(arg_3_0.rad) * var_0_18

				local var_3_1 = arg_3_0.amuletPos

				math = var_1_10002
				var_3_1.y = var_1_10002.sin(arg_3_0.rad) * var_0_18
			end
		end

		if arg_3_0.amuletL then
			arg_3_0.amuletL.tf.anchoredPosition = arg_3_0.amuletPos
			arg_3_0.amuletL.rad = arg_3_0.rad
		else
			arg_3_0:setAmuletL(arg_3_0:getAmulete(var_0_10, arg_3_0.amuletNextType))
			arg_3_0:returnAmulete(arg_3_0.amuletS, arg_3_0.amuletSPool)

			arg_3_0.amuletNextType = arg_3_0:getRandomAmuletType()
			arg_3_0.amuletS = nil
			arg_3_0.amuletS = arg_3_0:getAmulete(var_0_9, arg_3_0.amuletNextType)
		end

		if arg_3_0.amuletS then
			local var_3_2 = arg_3_0.amuletS.tf

			Vector2 = var_1_10002
			math = var_1_10004

			local var_3_3 = var_1_10004.cos(arg_3_0.rad) * var_0_19

			math = var_5
			var_3_2.anchoredPosition = var_1_10002(var_3_3, var_5.sin(arg_3_0.rad) * var_0_19)
		end
	end

	if arg_3_0._amuletFires and #arg_3_0._amuletFires > 0 then
		for iter_3_0 = #arg_3_0._amuletFires, 1, -1 do
			local var_3_4 = arg_3_0._amuletFires[iter_3_0].tf.anchoredPosition.x
			local var_3_5 = var_5.speed.x

			LaunchBallGameVo = var_1_10009
			var_6.x = var_3_4 + var_3_5 * var_1_10009.deltaTime

			local var_3_6 = var_6.y
			local var_3_7 = var_5.speed.y

			LaunchBallGameVo = var_1_10009
			var_6.y = var_3_6 + var_3_7 * var_1_10009.deltaTime
			var_5.tf.anchoredPosition = var_6

			local var_3_8

			if var_5.effectTime then
				var_3_8 = var_5.effectTime

				if 0 < var_3_8 then
					var_3_8 = var_5.effectTime
					LaunchBallGameVo = var_8
					var_5.effectTime = var_3_8 - var_8.deltaTime

					if var_5.effectTime <= 0 then
						var_5.effectTime = var_0_24
						var_1_10009 = arg_3_0

						arg_3_0.createEF(var_1_10009, var_5)
					end
				end
			end

			math = var_3_8

			if not (var_3_8.abs(var_6.x) > var_0_23) then
				math = var_7

				if var_7.abs(var_6.y) > var_0_23 then
					table = var_7

					var_7.remove(arg_3_0._amuletFires, iter_3_0)

					var_1_10009 = arg_3_0

					arg_3_0.returnAmulete(var_1_10009, var_5, arg_3_0.amuletLPool)
				elseif var_5.removeFlag then
					table = var_7

					var_7.remove(arg_3_0._amuletFires, iter_3_0)

					var_1_10009 = arg_3_0

					arg_3_0.returnAmulete(var_1_10009, var_5, arg_3_0.amuletLPool)
				elseif arg_3_0.lifeBound then
					if var_6.x >= arg_3_0.max.x or var_6.x <= arg_3_0.min.x then
						table = var_7

						var_7.remove(arg_3_0._amuletFires, iter_3_0)

						var_1_10009 = arg_3_0

						arg_3_0.returnAmulete(var_1_10009, var_5, arg_3_0.amuletLPool)
					elseif var_6.y >= arg_3_0.max.y or var_6.y <= arg_3_0.min.y then
						table = var_7

						var_7.remove(arg_3_0._amuletFires, iter_3_0)

						var_1_10009 = arg_3_0

						arg_3_0.returnAmulete(var_1_10009, var_5, arg_3_0.amuletLPool)
					end
				end
			end
		end
	end

	if arg_3_0.butterflys and #arg_3_0.butterflys > 0 then
		for iter_3_1 = #arg_3_0.butterflys, 1, -1 do
			local var_3_9 = arg_3_0.butterflys[iter_3_1].tf.anchoredPosition.x
			local var_3_10 = var_5.speed.x

			LaunchBallGameVo = var_1_10009
			var_6.x = var_3_9 + var_3_10 * var_1_10009.deltaTime

			local var_3_11 = var_6.y
			local var_3_12 = var_5.speed.y

			LaunchBallGameVo = var_1_10009
			var_6.y = var_3_11 + var_3_12 * var_1_10009.deltaTime

			local var_3_13 = var_5.tf

			var_3_13.anchoredPosition = var_6
			math = var_3_13

			if not (var_3_13.abs(var_6.x) > var_0_23) then
				math = var_7

				if var_7.abs(var_6.y) > var_0_23 then
					var_5.anim = nil
					Destroy = var_7

					var_7(var_5.tf)

					table = var_7

					var_7.remove(arg_3_0.butterflys, iter_3_1)
				elseif var_5.removeFlag then
					var_5.anim = nil
					Destroy = var_7

					var_7(var_5.tf)

					table = var_7

					var_7.remove(arg_3_0.butterflys, iter_3_1)
				elseif var_6.x >= arg_3_0.max.x or var_6.x <= arg_3_0.min.x then
					var_5.anim = nil
					Destroy = var_7

					var_7(var_5.tf)

					table = var_7

					var_7.remove(arg_3_0.butterflys, iter_3_1)
				elseif var_6.y >= arg_3_0.max.y or var_6.y <= arg_3_0.min.y then
					var_5.anim = nil
					Destroy = var_7

					var_7(var_5.tf)

					table = var_7

					var_7.remove(arg_3_0.butterflys, iter_3_1)
				elseif var_5.removeTime then
					local var_3_14 = var_5.removeTime

					if 0 < var_3_14 then
						local var_3_15 = var_5.removeTime

						LaunchBallGameVo = var_8
						var_5.removeTime = var_3_15 - var_8.deltaTime

						if var_5.removeTime < 0 then
							var_5.removeTime = nil
							var_5.removeFlag = true
						end
					end
				end
			end
		end
	end

	if arg_3_0.amuletEFs and #arg_3_0.amuletEFs > 0 then
		for iter_3_2 = #arg_3_0.amuletEFs, 1, -1 do
			if arg_3_0.amuletEFs[iter_3_2].removeTime then
				local var_3_16 = var_5.removeTime

				if 0 < var_3_16 then
					local var_3_17 = var_5.removeTime

					LaunchBallGameVo = var_7
					var_5.removeTime = var_3_17 - var_7.deltaTime

					if var_5.removeTime <= 0 then
						table = var_6

						var_6.remove(arg_3_0.amuletEFs, iter_3_2)
						arg_3_0:returnAmulete(var_5, arg_3_0.amuletEFPool)
					end
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
				table = var_1_10007

				var_1_10007.remove(arg_5_0._amuletFires, iter_5_0)
				arg_5_0:returnAmulete(var_6, arg_5_0.amuletLPool)
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

	if arg_6_1 == var_0_10 then
		var_6_1 = arg_6_0.amuletLPool
		var_6_2 = arg_6_0._amuletLTpl
		Vector2 = var_8
		var_6_3 = var_8(0, var_0_18)
	elseif arg_6_1 == var_0_9 then
		var_6_1 = arg_6_0.amuletSPool
		var_6_2 = arg_6_0._amuletSTpl
		Vector2 = var_8
		var_6_3 = var_8(0, var_0_19)
		var_6_4 = arg_6_0._sContent
	elseif arg_6_1 == var_0_11 then
		var_6_1 = arg_6_0.amuletEFPool
		var_6_2 = arg_6_0._amuletEfTpl
		Vector2 = var_8
		var_6_3 = var_8(0, 0)
	end

	if not var_6_1 then
		return
	end

	for iter_6_0 = 1, #var_6_1 do
		if not var_6_0 then
			table = var_1_10012
			var_6_0 = var_1_10012.remove(var_6_1, iter_6_0)
		end
	end

	if not var_6_0 then
		tf = var_8
		instantiate = var_10

		local var_6_5 = var_8(var_10(var_6_2))

		findTF = var_9

		local var_6_6 = var_9(var_6_5, "ad/anim")

		GetComponent = var_10
		findTF = var_12

		local var_6_7 = var_12(var_6_5, "ad/anim")

		typeof = var_1_10013
		Animator = var_15

		local var_6_8 = var_10(var_6_7, var_1_10013(var_15))

		setParent = var_11

		var_11(var_6_5, var_6_4)

		var_6_0 = {
			tf = var_6_5,
			type = arg_6_1,
			anim = var_6_8,
			animTf = var_6_6
		}
	end

	var_6_0.angle = nil
	var_6_0.fire = nil
	setActive = var_8

	var_8(var_6_0.tf, true)

	var_6_0.tf.anchoredPosition = var_6_3
	var_6_0.anim.runtimeAnimatorController = arg_6_0:getAnimator(arg_6_1, arg_6_2)

	local var_6_9 = var_6_0.tf

	var_6_9.name = arg_6_1 .. "_" .. var_0_26[arg_6_2].name
	var_6_0.color = arg_6_2
	findTF = var_6_9

	local var_6_10 = var_6_9(var_6_0.tf, "ad")

	Quaternion = var_9
	var_6_10.localRotation = var_9.Euler(0, 0, 0)
	var_6_0.removeFlag = false

	if arg_6_1 == var_0_10 then
		var_6_0.effectTime = var_0_24
		var_6_0.effectIndex = 1
		LaunchBallGameConst = var_8
		var_6_0[var_8.amulet_buff_back] = false
		var_6_0.concentrate = false
		var_6_0.fireIndex = var_0_0.fireIndex
		var_6_0.overFlag = false
		var_6_0.overCount = 0
		var_0_0.fireIndex = var_0_0.fireIndex + 1
	elseif arg_6_1 == var_0_9 then
		-- block empty
	elseif arg_6_1 == var_0_11 then
		var_6_0.removeTime = var_0_25
	end

	return var_6_0
end

function var_0_0.returnAmulete(arg_7_0, arg_7_1, arg_7_2)
	setActive = var_1_10003

	var_1_10003(arg_7_1.tf, false)

	table = var_1_10003

	var_1_10003.insert(arg_7_2, arg_7_1)

	return
end

function var_0_0.getColor(arg_8_0)
	return arg_8_0.amuletL.color
end

function var_0_0.fireAmulet(arg_9_0)
	if arg_9_0.amuletL then
		pg = var_1

		local var_9_0 = var_1.CriMgr.GetInstance()
		local var_9_1 = var_1.PlaySoundEffect_V3

		LaunchBallGameVo = var_1_10004

		var_9_1(var_9_0, var_1_10004.SFX_FIRE)

		local var_9_2 = arg_9_0.amuletPos

		math = var_1_10002
		var_9_2.x = var_1_10002.cos(arg_9_0.rad) * var_0_18

		local var_9_3 = arg_9_0.amuletPos

		math = var_2
		var_9_3.y = var_2.sin(arg_9_0.rad) * var_0_18
		arg_9_0.amuletL.tf.anchoredPosition = arg_9_0.amuletPos
		arg_9_0.amuletL.angle = arg_9_0.angle
		arg_9_0.amuletL.rad = arg_9_0.rad

		local var_9_4 = arg_9_0.amuletL

		Vector2 = var_2
		math = var_4

		local var_9_5 = var_4.cos(arg_9_0.amuletL.rad) * var_0_20

		math = var_5
		var_9_4.speed = var_2(var_9_5, var_5.sin(arg_9_0.amuletL.rad) * var_0_20)

		local var_9_6 = arg_9_0.amuletL.anim

		var_1.Play(var_9_6, "L_Fire")

		findTF = var_2

		local var_9_7 = var_2(arg_9_0.amuletL.tf, "ad")

		Vector3 = var_3
		var_9_7.localEulerAngles = var_3(0, 0, arg_9_0.angle + var_0_21)

		local var_9_8

		if arg_9_0.concentrateTime then
			var_9_8 = arg_9_0.amuletL
			var_9_8.concentrate = true
			arg_9_0.concentrateTime = arg_9_0.concentrateTime - 1

			if arg_9_0.concentrateTime <= 0 then
				arg_9_0.concentrateTime = nil
			end
		end

		table = var_9_8

		var_9_8.insert(arg_9_0._amuletFires, arg_9_0.amuletL)
		arg_9_0:setAmuletL(nil)
	end

	return
end

function var_0_0.randomFireAmulet(arg_10_0, arg_10_1)
	pg = var_1_10002

	local var_10_0 = var_1_10002.CriMgr.GetInstance()
	local var_10_1 = var_2.PlaySoundEffect_V3

	LaunchBallGameVo = var_1_10005

	var_10_1(var_10_0, var_1_10005.SFX_FIRE)

	local var_10_2 = arg_10_0:getAmulete(var_0_10, arg_10_0:getRandomAmuletType())

	pairs = var_1_10003

	for iter_10_0, iter_10_1 in var_1_10003(arg_10_1) do
		var_10_2[iter_10_0] = iter_10_1
	end

	math = var_3

	local var_10_3 = var_3.random(1, 360)

	math = var_4

	local var_10_4 = var_4.deg2Rad * var_10_3
	local var_10_5 = var_10_2.tf

	Vector2 = var_6
	var_10_5.anchoredPosition = var_6(0, 0)
	var_10_2.rad = arg_10_0.rad
	Vector2 = var_5
	math = iter_10_1

	local var_10_6 = iter_10_1.cos(var_10_4) * var_0_20

	math = var_8
	var_10_2.speed = var_5(var_10_6, var_8.sin(var_10_4) * var_0_20)

	local var_10_7 = var_10_2.anim

	var_5.Play(var_10_7, "L_Fire")

	findTF = var_6

	local var_10_8 = var_6(var_10_2.tf, "ad")

	Vector3 = var_10_6
	var_10_8.localEulerAngles = var_10_6(0, 0, var_10_3 + var_0_21)
	table = var_10_8

	var_10_8.insert(arg_10_0._amuletFires, var_10_2)

	return
end

function var_0_0.setAmuletL(arg_11_0, arg_11_1)
	arg_11_0.amuletL = arg_11_1
	LaunchBallGameVo = var_1_10002
	var_1_10002.amulet = arg_11_0.amuletL

	return
end

function var_0_0.createEF(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getAmulete(var_0_11, arg_12_1.color)

	arg_12_1.effectIndex = arg_12_1.effectIndex + 1

	local var_12_1 = arg_12_1.effectIndex % var_0_12 + 1
	local var_12_2 = var_0_13[var_12_1].anim_name
	local var_12_3

	var_12_3.anchoredPosition, var_12_3 = arg_12_1.tf.anchoredPosition, var_12_0.tf
	math = var_12_3

	local var_12_4 = var_12_3.cos(arg_12_1.rad)

	math = var_1_10007

	local var_12_5 = var_1_10007.sin(arg_12_1.rad)
	local var_12_6 = var_0_13[var_12_1].offset.x
	local var_12_7 = var_0_13[var_12_1].offset.y
	local var_12_8 = var_12_4 * var_12_6 - var_12_5 * var_12_7
	local var_12_9 = var_12_4 * var_12_7 + var_12_5 * var_12_6

	findTF = var_12

	local var_12_10 = var_12(var_12_0.tf, "ad")

	Vector2 = var_1_10013
	var_12_10.anchoredPosition = var_1_10013(var_12_8, var_12_9)

	local var_12_11 = var_12_0.anim

	var_12.Play(var_12_11, var_12_2)

	table = var_12

	var_12.insert(arg_12_0.amuletEFs, var_12_0)

	return
end

function var_0_0.getRandomAmuletType(arg_13_0)
	LaunchBallGameVo = var_1_10001

	if var_1_10001.enemyColors then
		LaunchBallGameVo = var_13_0

		local var_13_0

		if #var_13_0.enemyColors == 0 then
			var_13_0 = var_0_8
			math = var_1_10002

			return var_13_0[var_1_10002.random(1, #var_0_8)]
		else
			LaunchBallGameVo = var_13_0

			local var_13_1 = var_13_0.enemyColors

			math = var_1_10002

			local var_13_2 = var_1_10002.random
			local var_13_3 = 1

			LaunchBallGameVo = var_1_10005

			return var_13_1[var_13_2(var_13_3, #var_1_10005.enemyColors)]
		end

		return
	end
end

function var_0_0.getAnimator(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0

	if arg_14_1 == var_0_10 then
		var_14_0 = arg_14_0.amuletLAnimators
	elseif arg_14_1 == var_0_9 then
		var_14_0 = arg_14_0.amuletSAnimators
	elseif arg_14_1 == var_0_11 then
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
	math = var_1_10003

	local var_15_0 = var_1_10003.cos(arg_15_2)

	math = var_1_10004

	local var_15_1 = var_1_10004.sin(arg_15_2)
	local var_15_2 = var_15_0 * arg_15_1
	local var_15_3 = var_15_1 * arg_15_1

	Vector2 = var_1_10007

	return var_1_10007(var_15_2, var_15_3)
end

function var_0_0.getAngle(arg_16_0)
	return arg_16_0.angle
end

function var_0_0.eventCall(arg_17_0, arg_17_1, arg_17_2)
	LaunchBallGameScene = var_1_10003

	if arg_17_1 == var_1_10003.PLAYING_CHANGE then
		arg_17_0.isPlaying = arg_17_2
	else
		LaunchBallGameScene = var_3

		if arg_17_1 == var_3.FIRE_AMULET then
			arg_17_0:fireAmulet()
		else
			LaunchBallGameScene = var_3

			local var_17_0

			if arg_17_1 == var_3.RANDOM_FIRE then
				var_17_0 = arg_17_2.num

				local var_17_1 = arg_17_2.data

				for iter_17_0 = 1, var_17_0 do
					arg_17_0:randomFireAmulet(var_17_1)
				end
			else
				LaunchBallGameScene = var_17_0

				if arg_17_1 == var_17_0.CHANGE_AMULET then
					if arg_17_0.changeTime then
						LaunchBallGameVo = var_3

						if var_3.gameStepTime - arg_17_0.changeTime < 1 then
							return
						end
					end

					if arg_17_0.amuletL then
						LaunchBallGameVo = var_3
						arg_17_0.changeTime = var_3.gameStepTime

						arg_17_0:returnAmulete(arg_17_0.amuletL, arg_17_0.amuletLPool)
						arg_17_0:setAmuletL(nil)
					end
				else
					LaunchBallGameScene = var_3

					if arg_17_1 == var_3.CONCENTRATE_TRIGGER then
						arg_17_0.concentrateTime = arg_17_2.time
					else
						LaunchBallGameScene = var_3

						if arg_17_1 == var_3.SLEEP_TIME_TRIGGER then
							print = var_3

							var_3("创建一个小蝴蝶")

							local var_17_2 = arg_17_0:createButterfly()
						end
					end
				end
			end
		end
	end

	return
end

function var_0_0.getButterfly(arg_18_0)
	return arg_18_0.butterflys
end

function var_0_0.createButterfly(arg_19_0)
	tf = var_1_10001
	instantiate = var_1_10003

	local var_19_0 = var_1_10001(var_1_10003(arg_19_0._butterflyTpl))

	GetComponent = var_1_10002
	findTF = var_1_10004

	local var_19_1 = var_1_10004(var_19_0, "ad/anim")

	typeof = var_5
	Animator = var_7

	local var_19_2 = var_1_10002(var_19_1, var_5(var_7))

	Vector2 = var_3
	math = var_5

	local var_19_3 = var_5.random(1, 20)

	math = var_6
	var_19_0.anchoredPosition = var_3(var_19_3, var_6.random(1, 20))
	math = var_3

	local var_19_4 = var_3.random(1, 360)

	math = var_19_1

	local var_19_5 = var_19_1.deg2Rad * var_19_4

	Vector2 = var_5
	math = var_7

	local var_19_6 = var_7.cos(var_19_5) * var_0_17

	math = var_8

	local var_19_7 = var_5(var_19_6, var_8.sin(var_19_5) * var_0_17)
	local var_19_8 = 3
	local var_19_9 = var_19_7.x
	local var_19_10

	if not (0 < var_19_9) or not (-1 * var_19_8) then
		var_19_10 = 1 * var_19_8
	end

	findTF = var_8

	local var_19_11 = var_8(var_19_0, "ad/anim")

	Vector3 = var_9
	var_19_11.localScale = var_9(var_19_10, var_19_8, var_19_8)
	table = var_19_11

	var_19_11.insert(arg_19_0.butterflys, {
		tf = var_19_0,
		anim = var_19_2,
		speed = var_19_7
	})

	setParent = var_8

	var_8(var_19_0, arg_19_0._content)

	setActive = var_8

	var_8(var_19_0, true)

	return
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
			table = var_1_10005
			var_1_10005 = var_1_10005.remove(arg_21_0.amuletEFs, iter_21_0)

			arg_21_0:returnAmulete(var_1_10005, arg_21_0.amuletEFPool)
		end
	end

	if arg_21_0.butterflys and #arg_21_0.butterflys > 0 then
		for iter_21_1 = #arg_21_0.butterflys, 1, -1 do
			local var_21_0 = arg_21_0.butterflys[iter_21_1].tf

			Destroy = var_1_10006

			var_1_10006(arg_21_0.butterflys[iter_21_1].tf)
		end

		arg_21_0.butterflys = {}
	end

	return
end

return var_0_0
