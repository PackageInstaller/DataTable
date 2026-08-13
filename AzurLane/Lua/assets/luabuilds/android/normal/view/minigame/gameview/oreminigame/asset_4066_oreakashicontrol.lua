class = var_0_10000

local var_0_0 = var_0_10000("OreAkashiControl")

var_0_0.STATUS_NULL = 0
var_0_0.STATUS_WOOD_BOX = 1
var_0_0.STATUS_IRON_BOX = 2
var_0_0.STATUS_CART = 3
var_0_0.HIT_DELTA = 15
var_0_0.HIT_MOVE_TIME = 0.5

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.binder = arg_1_1
	arg_1_0._tf = arg_1_2
	arg_1_0.collisionMgr = arg_1_3

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	pg = var_1_10001
	arg_2_0.uiMgr = var_1_10001.UIMgr.GetInstance()

	local var_2_0 = arg_2_0.collisionMgr

	var_1.SetAkashiObject(var_2_0, arg_2_0)

	local var_2_1 = arg_2_0._tf

	arg_2_0.oreTpl = var_1.Find(var_2_1, "oreTpl")

	arg_2_0:AddListener()
	arg_2_0:AddDftAniEvent()
	arg_2_0:Reset()

	local var_2_2 = arg_2_0._tf

	arg_2_0.aabbTF = var_1.Find(var_2_2, "aabb")
	setActive = var_1

	local var_2_3 = arg_2_0.aabbTF

	OreGameConfig = var_3

	var_1(var_2_3, var_3.SHOW_AABB)

	OreGameHelper = var_1
	arg_2_0.aabb = var_1.GetAABBWithTF(arg_2_0.aabbTF)

	return
end

function var_0_0.AddListener(arg_3_0)
	local var_3_0 = arg_3_0.binder
	local var_3_1 = var_1.bind

	OreGameConfig = var_1_10003

	var_3_1(var_3_0, var_1_10003.EVENT_DO_CARRY, function(arg_4_0, arg_4_1)
		arg_3_0.weight = arg_3_0.weight + arg_4_1.weight
		arg_3_0.point = arg_3_0.point + arg_4_1.point

		local var_4_0 = arg_3_0

		var_2.CheckStatus(var_4_0)

		local var_4_1 = arg_3_0

		var_2.AddOre(var_4_1, arg_4_1.type)

		return
	end)

	local var_3_2 = arg_3_0.binder
	local var_3_3 = var_1.bind

	OreGameConfig = var_3

	var_3_3(var_3_2, var_3.EVENT_AKASHI_HIT, function(arg_5_0, arg_5_1)
		if arg_3_0.invincible then
			return
		end

		local var_5_0 = arg_3_0

		var_2.PlayHitAnim(var_5_0, arg_5_1.dir, arg_5_1.class, arg_5_1.y)

		return
	end)

	return
end

function var_0_0.AddDftAniEvent(arg_6_0)
	eachChild = var_1_10001

	local var_6_0 = arg_6_0._tf

	var_1_10001(var_2.Find(var_6_0, "main"), function(arg_7_0)
		local var_7_0 = arg_7_0:Find("main/Image")
		local var_7_1 = var_1.GetComponent

		typeof = var_3
		DftAniEvent = var_2_10004

		local var_7_2 = var_7_1(var_7_0, var_3(var_2_10004))

		var_1.SetEndEvent(var_7_2, function()
			if arg_6_0.isDeliver then
				local var_8_0 = arg_6_0

				var_0.ResetData(var_8_0)
			else
				local var_8_1 = arg_6_0

				var_0.ResetData(var_8_1)

				local var_8_2 = arg_6_0.mainTF
				local var_8_3 = var_0.Find(var_8_2, "main/Image")
				local var_8_4 = var_0.GetComponent

				typeof = var_2
				Animator = var_3_10003

				local var_8_5 = var_8_4(var_8_3, var_2(var_3_10003))

				var_0.Play(var_8_5, "Idle_S_Sad")

				arg_6_0.mainAnimName = "Idle_S_Sad"
			end

			return
		end)

		return
	end)

	eachChild = var_1_10001

	local var_6_1 = arg_6_0._tf

	var_1_10001(var_2.Find(var_6_1, "effect"), function(arg_9_0)
		local var_9_0 = arg_9_0
		local var_9_1 = arg_9_0.GetComponent

		typeof = var_2_10003
		DftAniEvent = var_2_10004

		local var_9_2 = var_9_1(var_9_0, var_2_10003(var_2_10004))

		var_1.SetEndEvent(var_9_2, function()
			setActive = var_3_10000

			var_3_10000(arg_9_0, false)

			return
		end)

		return
	end)

	return
end

function var_0_0.Reset(arg_11_0)
	setAnchoredPosition = var_1_10001

	local var_11_0 = arg_11_0._tf

	Vector2 = var_1_10003

	var_1_10001(var_11_0, var_1_10003(0, -100))

	arg_11_0.invincible = nil

	arg_11_0:ResetData()

	local var_11_1 = arg_11_0.mainTF
	local var_11_2 = var_1.Find(var_11_1, "main/Image")
	local var_11_3 = var_1.GetComponent

	typeof = var_3
	Animator = var_4

	local var_11_4 = var_11_3(var_11_2, var_3(var_4))

	var_1.Play(var_11_4, "Idle_S_0")

	return
end

function var_0_0.ResetData(arg_12_0)
	arg_12_0.mainAnimName, arg_12_0.toolAnimName, arg_12_0.oreAnimName = "", "", ""

	arg_12_0:SetAnimDir("S")

	arg_12_0.weight = 0
	arg_12_0.point = 0
	arg_12_0.isDeliver = false
	arg_12_0.playHitAnim = nil

	arg_12_0:ResetStatus()

	return
end

function var_0_0.ResetStatus(arg_13_0)
	arg_13_0:SetStatus(var_0_0.STATUS_NULL)

	arg_13_0.oreList = {}
	eachChild = var_1

	local var_13_0 = arg_13_0._tf

	var_1(var_2.Find(var_13_0, "main"), function(arg_14_0)
		for iter_14_0 = 1, 3 do
			local var_14_0 = arg_14_0
			local var_14_1 = arg_14_0.Find(var_14_0, "ore/Image/" .. iter_14_0 .. "/oreTF")

			removeAllChildren = var_14_0

			var_14_0(var_14_1)
		end

		return
	end)

	return
end

local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}

Vector2 = var_0_10004
var_0_3[1] = var_0_10004(0, 0)
Vector2 = var_4
var_0_3[2] = var_4(-1, 0)
Vector2 = var_4
var_0_3[3] = var_4(0, -11)
var_0_2.EF_Get = var_0_3

local var_0_4 = {}

Vector2 = var_4
var_0_4[1] = var_4(0, -5)
Vector2 = var_4
var_0_4[2] = var_4(0, -4)
var_0_2.EF_Upgrade = var_0_4
var_0_1.S = var_0_2

local var_0_5 = {}
local var_0_6 = {}

Vector2 = var_4
var_0_6[1] = var_4(13, 3)
Vector2 = var_4
var_0_6[2] = var_4(14.8, 4.4)
Vector2 = var_4
var_0_6[3] = var_4(-23, 4)
var_0_5.EF_Get = var_0_6

local var_0_7 = {}

Vector2 = var_4
var_0_7[1] = var_4(13, 0)
Vector2 = var_4
var_0_7[2] = var_4(18, 2.7)
var_0_5.EF_Upgrade = var_0_7
var_0_1.E = var_0_5

local var_0_8 = {}
local var_0_9 = {}

Vector2 = var_4
var_0_9[1] = var_4(-16, 3.5)
Vector2 = var_4
var_0_9[2] = var_4(-16, 5)
Vector2 = var_4
var_0_9[3] = var_4(-24, 4)
var_0_8.EF_Get = var_0_9

local var_0_10 = {}

Vector2 = var_4
var_0_10[1] = var_4(-18, 2)
Vector2 = var_4
var_0_10[2] = var_4(-22, 2)
var_0_8.EF_Upgrade = var_0_10
var_0_1.W = var_0_8

function var_0_0.PlayEffect(arg_15_0, arg_15_1)
	if arg_15_0.animDir == "N" then
		return
	end

	local var_15_0 = arg_15_0._tf
	local var_15_1 = var_3.Find(var_15_0, "effect/" .. arg_15_1)
	local var_15_2 = arg_15_0.status

	if arg_15_1 == "EF_Upgrade" then
		var_15_2 = arg_15_0.status == var_0_0.STATUS_IRON_BOX and 2 or 1
	end

	local var_15_3 = var_0_1[var_2][arg_15_1][var_15_2]

	setAnchoredPosition = var_6

	var_6(var_15_1, var_15_3)

	setActive = var_6

	var_6(var_15_1, true)

	return
end

function var_0_0.AddOre(arg_16_0, arg_16_1)
	if arg_16_0.status == var_0_0.STATUS_WOOD_BOX and #arg_16_0.oreList >= 6 then
		return
	end

	if (arg_16_0.status == var_0_0.STATUS_IRON_BOX or arg_16_0.status == var_0_0.STATUS_CART) and #arg_16_0.oreList >= 8 then
		return
	end

	table = var_2

	var_2.insert(arg_16_0.oreList, arg_16_1)

	eachChild = var_2

	local var_16_0 = arg_16_0._tf

	var_2(var_3.Find(var_16_0, "main"), function(arg_17_0)
		if arg_17_0.name == "N" and arg_16_0.status ~= var_0_0.STATUS_CART then
			return
		end

		local var_17_0 = arg_17_0:Find("ore/Image/" .. arg_16_0.status .. "/oreTF")
		local var_17_1 = arg_17_0:Find("ore/Image/" .. arg_16_0.status .. "/pos/" .. "num_" .. #arg_16_0.oreList)
		local var_17_6

		if var_17_0.childCount < #arg_16_0.oreList - 1 then
			ipairs = var_17_6

			for iter_17_0, iter_17_1 in var_17_6(arg_16_0.oreList) do
				local var_17_2 = arg_16_0.oreTpl
				local var_17_3 = var_8.Find(var_17_2, iter_17_1)

				cloneTplTo = var_17_2

				local var_17_4 = var_17_2(var_17_3, var_17_0, iter_17_0)
			end
		else
			local var_17_5 = arg_16_0.oreTpl

			var_17_6 = var_17_6.Find(var_17_5, arg_16_1)
			cloneTplTo = var_17_5

			local var_17_7 = var_17_5(var_17_6, var_17_0, #arg_16_0.oreList)
		end

		eachChild = var_17_6

		var_17_6(var_17_1, function(arg_18_0)
			setAnchoredPosition = var_3_10001

			local var_18_0 = var_17_0

			var_3_10001(var_2.Find(var_18_0, arg_18_0.name), arg_18_0.anchoredPosition)

			return
		end)

		return
	end)

	return
end

function var_0_0.CheckStatus(arg_19_0)
	local var_19_0 = false

	if arg_19_0.status == var_0_0.STATUS_NULL then
		var_19_0 = arg_19_0.weight >= 0
	elseif arg_19_0.status == var_0_0.STATUS_WOOD_BOX then
		local var_19_1 = arg_19_0.weight

		OreGameConfig = var_3
		var_19_0 = var_19_1 >= var_3.CAPACITY.WOOD_BOX
	elseif arg_19_0.status == var_0_0.STATUS_IRON_BOX then
		local var_19_2 = arg_19_0.weight

		OreGameConfig = var_3
		var_19_0 = var_19_2 >= var_3.CAPACITY.IRON_BOX
	end

	if var_19_0 then
		arg_19_0:PlayEffect("EF_Upgrade")
		arg_19_0:SetStatus(arg_19_0.status + 1)
	else
		arg_19_0:PlayEffect("EF_Get")
	end

	return
end

function var_0_0.SetStatus(arg_20_0, arg_20_1)
	arg_20_0.status = arg_20_1
	eachChild = var_1_10002

	local var_20_0 = arg_20_0._tf

	var_1_10002(var_3.Find(var_20_0, "main"), function(arg_21_0)
		setActive = var_2_10001

		var_2_10001(arg_21_0:Find("tool"), arg_20_0.status ~= var_0_0.STATUS_NULL)

		setActive = var_2_10001

		var_2_10001(arg_21_0:Find("ore"), arg_20_0.status ~= var_0_0.STATUS_NULL)

		eachChild = var_2_10001

		var_2_10001(arg_21_0:Find("ore/Image"), function(arg_22_0)
			setActive = var_3_10001

			local var_22_0 = arg_22_0
			local var_22_1 = arg_20_0.status

			tonumber = var_3_10004

			var_3_10001(var_22_0, var_22_1 == var_3_10004(arg_22_0.name))

			return
		end)

		return
	end)

	OreGameConfig = var_1_10002
	arg_20_0.speed = var_1_10002.SPEED[arg_20_0.status]

	return
end

function var_0_0.SetAnimDir(arg_23_0, arg_23_1)
	arg_23_0.animDir = arg_23_1
	eachChild = var_1_10002

	local var_23_0 = arg_23_0._tf

	var_1_10002(var_3.Find(var_23_0, "main"), function(arg_24_0)
		local var_24_0

		if arg_24_0.name == arg_23_0.animDir then
			setActive = var_24_0

			var_24_0(arg_24_0, true)

			var_24_0 = arg_23_0
			var_24_0.mainTF = arg_24_0
		else
			setActive = var_24_0

			var_24_0(arg_24_0, false)
		end

		return
	end)

	return
end

function var_0_0.PlayHitAnim(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_0.invincible = 0
	setActive = var_4

	local var_25_0 = arg_25_0._tf

	var_4(var_5.Find(var_25_0, "effect/EF_Clash_" .. arg_25_1), true)

	local var_25_1 = ""
	local var_25_2 = arg_25_2 < 4 and "Light" or "Heavy"

	arg_25_0.hitPos = {
		x = 0,
		y = 0
	}

	local var_25_3 = arg_25_0.hitPos
	local var_25_4

	if arg_25_1 ~= "W" or not -var_0_0.HIT_DELTA then
		var_25_4 = var_0_0.HIT_DELTA
	end

	var_25_3.x = var_25_4

	if arg_25_3 <= arg_25_0._tf.anchoredPosition.y then
		var_25_1 = arg_25_1 == "W" and "CW" or "CCW"
		arg_25_0.hitPos.y = var_0_0.HIT_DELTA
	else
		var_25_1 = arg_25_1 == "W" and "CCW" or "CW"
		arg_25_0.hitPos.y = -var_0_0.HIT_DELTA
	end

	arg_25_0.hitTime = 0
	arg_25_0.hitAnimName = "Stun_" .. var_25_2 .. "_" .. var_25_1

	local var_25_5 = arg_25_0.mainTF
	local var_25_6 = var_6.Find(var_25_5, "main/Image")
	local var_25_7 = var_6.GetComponent

	typeof = var_8
	Animator = var_9

	local var_25_8 = var_25_7(var_25_6, var_8(var_9))

	var_6.Play(var_25_8, "Clash_" .. arg_25_1)

	local var_25_9 = arg_25_0.binder
	local var_25_10 = var_6.emit

	OreGameConfig = var_8

	local var_25_11 = var_8.EVENT_PLAY_CONTAINER_HIT
	local var_25_12 = {
		pos = arg_25_0._tf.anchoredPosition,
		hitPos = arg_25_0.hitPos,
		status = arg_25_0.status
	}
	local var_25_13 = arg_25_0.mainTF
	local var_25_14 = var_10.Find
	local var_25_15 = "ore/Image/"

	tostring = var_1_10013
	var_25_12.oreTF = var_25_14(var_25_13, var_25_15 .. var_1_10013(arg_25_0.status))

	var_25_10(var_25_9, var_25_11, var_25_12)
	arg_25_0:ResetStatus()

	return
end

function var_0_0.PlayDeliver(arg_26_0)
	arg_26_0.isDeliver = true
	setActive = var_1

	local var_26_0 = arg_26_0.mainTF

	var_1(var_2.Find(var_26_0, "tool"), false)

	setActive = var_1

	local var_26_1 = arg_26_0.mainTF

	var_1(var_2.Find(var_26_1, "ore"), false)

	local var_26_2 = arg_26_0.mainTF
	local var_26_3 = var_1.Find(var_26_2, "main/Image")
	local var_26_4 = var_1.GetComponent

	typeof = var_3
	Animator = var_4

	local var_26_5 = var_26_4(var_26_3, var_3(var_4))

	var_1.Play(var_26_5, "Deliver")

	return
end

function var_0_0.CheckDeliver(arg_27_0)
	local var_27_0 = arg_27_0._tf.anchoredPosition.y

	OreGameConfig = var_1_10002

	if var_27_0 < var_1_10002.RANGE_Y[1] + 2 and arg_27_0._tf.anchoredPosition.x > -100 and arg_27_0._tf.anchoredPosition.x < 100 and arg_27_0.animDir == "S" and arg_27_0.weight > 0 then
		arg_27_0:PlayDeliver()

		local var_27_1 = arg_27_0.binder
		local var_27_2 = var_1.emit

		OreGameConfig = var_1_10003

		local var_27_3 = var_1_10003.EVENT_DELIVER
		local var_27_4 = {
			point = arg_27_0.point,
			status = arg_27_0.status,
			pos = arg_27_0._tf.anchoredPosition
		}
		local var_27_5 = arg_27_0.mainTF
		local var_27_6 = var_5.Find
		local var_27_7 = "ore/Image/"

		tostring = var_1_10008
		var_27_4.oreTF = var_27_6(var_27_5, var_27_7 .. var_1_10008(arg_27_0.status))

		var_27_2(var_27_1, var_27_3, var_27_4)
	end

	return
end

function var_0_0.OnTimer(arg_28_0, arg_28_1)
	if arg_28_0.invincible then
		arg_28_0.invincible = arg_28_0.invincible + arg_28_1

		local var_28_0 = arg_28_0.invincible

		OreGameConfig = var_1_10003

		if var_28_0 >= var_1_10003.INVINCIBLE_TIME then
			arg_28_0.invincible = nil
		end
	end

	if arg_28_0.hitTime then
		if arg_28_1 * 5 < arg_28_0.hitTime and arg_28_0.hitTime <= arg_28_1 * 6 then
			local var_28_1 = arg_28_0.mainTF
			local var_28_2 = var_2.Find(var_28_1, "main/Image")
			local var_28_3 = var_2.GetComponent

			typeof = var_4
			Animator = var_1_10005

			local var_28_4 = var_28_3(var_28_2, var_4(var_1_10005))

			var_2.Play(var_28_4, arg_28_0.hitAnimName)

			arg_28_0.playHitAnim = true
		elseif arg_28_0.hitTime > arg_28_1 * 6 then
			local var_28_5 = {
				x = arg_28_0._tf.anchoredPosition.x + arg_28_0.hitPos.x * arg_28_1 / var_0_0.HIT_MOVE_TIME,
				y = arg_28_0._tf.anchoredPosition.y + arg_28_0.hitPos.y * arg_28_1 / var_0_0.HIT_MOVE_TIME
			}

			arg_28_0:SetPosition(var_28_5)
		end

		arg_28_0.hitTime = arg_28_0.hitTime + arg_28_1

		if arg_28_0.hitTime >= var_0_0.HIT_MOVE_TIME then
			arg_28_0.hitTime = nil
		end

		return
	end

	if not arg_28_0.isDeliver and not arg_28_0.playHitAnim then
		Vector2 = var_2

		local var_28_6 = var_2(arg_28_0.uiMgr.hrz, arg_28_0.uiMgr.vtc)

		arg_28_0:UpdateAnim(var_28_6)
		arg_28_0:UpdatePosition(var_28_6)
		arg_28_0:CheckDeliver()
	end

	return
end

function var_0_0.UpdateAnim(arg_29_0, arg_29_1)
	OreGameHelper = var_1_10002

	local var_29_0 = var_1_10002.GetFourDirLabel(arg_29_1)
	local var_29_1 = false

	if var_29_0 == "STAND" then
		var_29_0 = arg_29_0.animDir
		var_29_1 = true
	end

	arg_29_0:SetAnimDir(var_29_0)

	local var_29_2 = ""
	local var_29_3 = ""
	local var_29_4 = ""

	if var_29_1 then
		if arg_29_0.mainAnimName ~= "Idle_S_Sad" then
			var_29_2 = "Idle_" .. var_29_0 .. "_" .. arg_29_0.status

			if arg_29_0.status ~= var_0_0.STATUS_NULL then
				var_29_3 = var_29_2
				var_29_4 = var_29_2
			end
		else
			var_29_2 = "Idle_S_Sad"
			var_29_3 = "Idle_S_1"
			var_29_4 = "Idle_S_1"
		end
	else
		var_29_2 = "Move_" .. var_29_0 .. "_" .. arg_29_0.status

		if arg_29_0.status ~= var_0_0.STATUS_NULL then
			var_29_3 = var_29_2
			var_29_4 = var_29_2
		end
	end

	if var_29_2 ~= "" and arg_29_0.mainAnimName ~= var_29_2 then
		local var_29_5 = arg_29_0.mainTF
		local var_29_6 = var_7.Find(var_29_5, "main/Image")
		local var_29_7 = var_7.GetComponent

		typeof = var_9
		Animator = var_1_10010

		local var_29_8 = var_29_7(var_29_6, var_9(var_1_10010))

		var_7.Play(var_29_8, var_29_2)

		arg_29_0.mainAnimName = var_29_2
	end

	if arg_29_0.status ~= var_0_0.STATUS_NULL then
		if var_29_4 ~= "" and var_29_4 ~= arg_29_0.toolAnimName then
			string = var_7

			if not var_7.find(var_29_4, "N_1") then
				string = var_7

				if var_7.find(var_29_4, "N_2") then
					local var_29_9 = arg_29_0.mainTF
					local var_29_10 = var_7.Find(var_29_9, "tool/Image")
					local var_29_11 = var_7.GetComponent

					typeof = var_9
					Image = var_1_10010
					var_29_11(var_29_10, var_9(var_1_10010)).enabled = false
				else
					local var_29_12 = arg_29_0.mainTF
					local var_29_13 = var_7.Find(var_29_12, "tool/Image")
					local var_29_14 = var_7.GetComponent

					typeof = var_9
					Image = var_1_10010
					var_29_14(var_29_13, var_9(var_1_10010)).enabled = true

					local var_29_15 = arg_29_0.mainTF
					local var_29_16 = var_7.Find(var_29_15, "tool/Image")
					local var_29_17 = var_7.GetComponent

					typeof = var_9
					Animator = var_1_10010

					local var_29_18 = var_29_17(var_29_16, var_9(var_1_10010))

					var_7.Play(var_29_18, var_29_4)
				end

				arg_29_0.toolAnimName = var_29_4

				if var_29_3 ~= "" and var_29_3 ~= arg_29_0.oreAnimName then
					local var_29_19 = arg_29_0.mainTF
					local var_29_20 = var_7.Find(var_29_19, "ore/Image")
					local var_29_21 = var_7.GetComponent

					typeof = var_9
					Animator = var_1_10010

					local var_29_22 = var_29_21(var_29_20, var_9(var_1_10010))

					var_7.Play(var_29_22, var_29_3)

					arg_29_0.oreAnimName = var_29_3

					local var_29_23 = arg_29_0.mainTF
					local var_29_24 = var_7.Find(var_29_23, "ore/Image/" .. arg_29_0.status .. "/oreTF")

					if not var_29_1 and var_0_0.oreAnimOffset[arg_29_0.status][arg_29_0.animDir] then
						setAnchoredPosition = var_29_23

						var_29_23(var_29_24, var_0_0.oreAnimOffset[arg_29_0.status][arg_29_0.animDir])
					else
						setAnchoredPosition = var_29_23

						local var_29_25 = var_29_24

						Vector2 = var_10

						var_29_23(var_29_25, var_10(0, 0))
					end
				end

				return
			end
		end
	end
end

local var_0_11 = {}
local var_0_12 = {}

Vector2 = var_4
var_0_12.S = var_4(0, -2)
Vector2 = var_4
var_0_12.W = var_4(1, -2)
var_0_11[1] = var_0_12

local var_0_13 = {}

Vector2 = var_4
var_0_13.S = var_4(0, -2)
var_0_11[2] = var_0_13

local var_0_14 = {}

Vector2 = var_4
var_0_14.W = var_4(5, 0)
Vector2 = var_4
var_0_14.E = var_4(-3, 0)
var_0_11[3] = var_0_14
var_0_0.oreAnimOffset = var_0_11

function var_0_0.UpdatePosition(arg_30_0, arg_30_1)
	OreGameHelper = var_1_10002

	local var_30_0 = var_1_10002.GetEightDirVector(arg_30_1)

	OreGameConfig = var_3

	local var_30_1 = var_30_0 * var_3.TIME_INTERVAL * arg_30_0.speed
	local var_30_2 = {
		x = arg_30_0._tf.anchoredPosition.x + var_30_1.x,
		y = arg_30_0._tf.anchoredPosition.y + var_30_1.y
	}

	arg_30_0:SetPosition(var_30_2)

	return
end

function var_0_0.SetPosition(arg_31_0, arg_31_1)
	OreGameHelper = var_1_10002

	if var_1_10002.CheckRemovable(arg_31_1) then
		setAnchoredPosition = var_2

		var_2(arg_31_0._tf, arg_31_1)

		local var_31_0 = arg_31_0._tf
		local var_31_1 = var_2.GetComponent

		typeof = var_4
		Canvas = var_1_10005
		var_31_1(var_31_0, var_4(var_1_10005)).sortingOrder = -arg_31_1.y + 320
	end

	return
end

function var_0_0.IsInvincible(arg_32_0)
	return arg_32_0.invincible
end

function var_0_0.GetAnimDirLabel(arg_33_0)
	return arg_33_0.animDir
end

function var_0_0.GetAABB(arg_34_0)
	return arg_34_0.aabb
end

function var_0_0.GetCarryTriggerOffset(arg_35_0)
	return {
		0,
		10
	}
end

function var_0_0.GetCollisionInfo(arg_36_0)
	return {
		pos = {
			x = arg_36_0._tf.anchoredPosition.x + arg_36_0.aabbTF.anchoredPosition.x,
			y = arg_36_0._tf.anchoredPosition.y + arg_36_0.aabbTF.anchoredPosition.y
		},
		aabb = arg_36_0:GetAABB(),
		carryOffset = arg_36_0:GetCarryTriggerOffset()
	}
end

return var_0_0
