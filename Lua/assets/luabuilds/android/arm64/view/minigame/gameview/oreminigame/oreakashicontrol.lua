local var_0_0 = class("OreAkashiControl")

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
	arg_2_0.uiMgr = pg.UIMgr.GetInstance()

	arg_2_0.collisionMgr:SetAkashiObject(arg_2_0)

	arg_2_0.oreTpl = arg_2_0._tf:Find("oreTpl")

	arg_2_0:AddListener()
	arg_2_0:AddDftAniEvent()
	arg_2_0:Reset()

	arg_2_0.aabbTF = arg_2_0._tf:Find("aabb")

	setActive(arg_2_0.aabbTF, OreGameConfig.SHOW_AABB)

	arg_2_0.aabb = OreGameHelper.GetAABBWithTF(arg_2_0.aabbTF)

	return
end

function var_0_0.AddListener(arg_3_0)
	arg_3_0.binder:bind(OreGameConfig.EVENT_DO_CARRY, function(arg_4_0, arg_4_1)
		arg_3_0.weight = arg_3_0.weight + arg_4_1.weight
		arg_3_0.point = arg_3_0.point + arg_4_1.point

		arg_3_0:CheckStatus()
		arg_3_0:AddOre(arg_4_1.type)

		return
	end)
	arg_3_0.binder:bind(OreGameConfig.EVENT_AKASHI_HIT, function(arg_5_0, arg_5_1)
		if arg_3_0.invincible then
			return
		end

		arg_3_0:PlayHitAnim(arg_5_1.dir, arg_5_1.class, arg_5_1.y)

		return
	end)

	return
end

function var_0_0.AddDftAniEvent(arg_6_0)
	eachChild(arg_6_0._tf:Find("main"), function(arg_7_0)
		arg_7_0:Find("main/Image"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			if arg_6_0.isDeliver then
				arg_6_0:ResetData()
			else
				arg_6_0:ResetData()
				arg_6_0.mainTF:Find("main/Image"):GetComponent(typeof(Animator)):Play("Idle_S_Sad")

				arg_6_0.mainAnimName = "Idle_S_Sad"
			end

			return
		end)

		return
	end)
	eachChild(arg_6_0._tf:Find("effect"), function(arg_9_0)
		arg_9_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			setActive(arg_9_0, false)

			return
		end)

		return
	end)

	return
end

function var_0_0.Reset(arg_11_0)
	setAnchoredPosition(arg_11_0._tf, Vector2(0, -100))

	arg_11_0.invincible = nil

	arg_11_0:ResetData()
	arg_11_0.mainTF:Find("main/Image"):GetComponent(typeof(Animator)):Play("Idle_S_0")

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

	eachChild(arg_13_0._tf:Find("main"), function(arg_14_0)
		for iter_14_0 = 1, 3 do
			removeAllChildren((arg_14_0:Find("ore/Image/" .. iter_14_0 .. "/oreTF")))
		end

		return
	end)

	return
end

local var_0_1 = {
	S = {
		EF_Get = {
			Vector2(0, 0),
			Vector2(-1, 0),
			Vector2(0, -11)
		},
		EF_Upgrade = {
			Vector2(0, -5),
			Vector2(0, -4)
		}
	},
	E = {
		EF_Get = {
			Vector2(13, 3),
			Vector2(14.8, 4.4),
			Vector2(-23, 4)
		},
		EF_Upgrade = {
			Vector2(13, 0),
			Vector2(18, 2.7)
		}
	},
	W = {
		EF_Get = {
			Vector2(-16, 3.5),
			Vector2(-16, 5),
			Vector2(-24, 4)
		},
		EF_Upgrade = {
			Vector2(-18, 2),
			Vector2(-22, 2)
		}
	}
}

function var_0_0.PlayEffect(arg_15_0, arg_15_1)
	if arg_15_0.animDir == "N" then
		return
	end

	local var_15_0 = arg_15_0._tf:Find("effect/" .. arg_15_1)
	local var_15_1 = arg_15_0.status

	if arg_15_1 == "EF_Upgrade" then
		var_15_1 = arg_15_0.status == var_0_0.STATUS_IRON_BOX and 2 or 1
	end

	setAnchoredPosition(var_15_0, var_0_1[arg_15_0.animDir][arg_15_1][var_15_1])
	setActive(var_15_0, true)

	return
end

function var_0_0.AddOre(arg_16_0, arg_16_1)
	if arg_16_0.status == var_0_0.STATUS_WOOD_BOX and #arg_16_0.oreList >= 6 then
		return
	end

	if (arg_16_0.status == var_0_0.STATUS_IRON_BOX or arg_16_0.status == var_0_0.STATUS_CART) and #arg_16_0.oreList >= 8 then
		return
	end

	table.insert(arg_16_0.oreList, arg_16_1)
	eachChild(arg_16_0._tf:Find("main"), function(arg_17_0)
		if arg_17_0.name == "N" and arg_16_0.status ~= var_0_0.STATUS_CART then
			return
		end

		local var_17_0 = arg_17_0:Find("ore/Image/" .. arg_16_0.status .. "/oreTF")
		local var_17_1 = arg_17_0:Find("ore/Image/" .. arg_16_0.status .. "/pos/" .. "num_" .. #arg_16_0.oreList)

		if var_17_0.childCount < #arg_16_0.oreList - 1 then
			for iter_17_0, iter_17_1 in ipairs(arg_16_0.oreList) do
				local var_17_2 = cloneTplTo(arg_16_0.oreTpl:Find(iter_17_1), var_17_0, iter_17_0)
			end
		else
			local var_17_3 = cloneTplTo(arg_16_0.oreTpl:Find(arg_16_1), var_17_0, #arg_16_0.oreList)
		end

		eachChild(var_17_1, function(arg_18_0)
			setAnchoredPosition(var_17_0:Find(arg_18_0.name), arg_18_0.anchoredPosition)

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
		var_19_0 = arg_19_0.weight >= OreGameConfig.CAPACITY.WOOD_BOX
	elseif arg_19_0.status == var_0_0.STATUS_IRON_BOX then
		var_19_0 = arg_19_0.weight >= OreGameConfig.CAPACITY.IRON_BOX
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

	eachChild(arg_20_0._tf:Find("main"), function(arg_21_0)
		setActive(arg_21_0:Find("tool"), arg_20_0.status ~= var_0_0.STATUS_NULL)
		setActive(arg_21_0:Find("ore"), arg_20_0.status ~= var_0_0.STATUS_NULL)
		eachChild(arg_21_0:Find("ore/Image"), function(arg_22_0)
			setActive(arg_22_0, arg_20_0.status == tonumber(arg_22_0.name))

			return
		end)

		return
	end)

	arg_20_0.speed = OreGameConfig.SPEED[arg_20_0.status]

	return
end

function var_0_0.SetAnimDir(arg_23_0, arg_23_1)
	arg_23_0.animDir = arg_23_1

	eachChild(arg_23_0._tf:Find("main"), function(arg_24_0)
		if arg_24_0.name == arg_23_0.animDir then
			setActive(arg_24_0, true)

			arg_23_0.mainTF = arg_24_0
		else
			setActive(arg_24_0, false)
		end

		return
	end)

	return
end

function var_0_0.PlayHitAnim(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_0.invincible = 0

	setActive(arg_25_0._tf:Find("effect/EF_Clash_" .. arg_25_1), true)

	local var_25_0 = ""
	local var_25_1 = arg_25_2 < 4 and "Light" or "Heavy"

	arg_25_0.hitPos = {
		x = 0,
		y = 0
	}

	local var_25_2 = arg_25_0.hitPos

	if arg_25_1 == "W" then
		var_25_2.x = -var_0_0.HIT_DELTA or var_0_0.HIT_DELTA

		if arg_25_3 <= arg_25_0._tf.anchoredPosition.y then
			var_25_0 = arg_25_1 == "W" and "CW" or "CCW"
			arg_25_0.hitPos.y = var_0_0.HIT_DELTA
		else
			var_25_0 = arg_25_1 == "W" and "CCW" or "CW"
			arg_25_0.hitPos.y = -var_0_0.HIT_DELTA
		end

		arg_25_0.hitTime = 0
		arg_25_0.hitAnimName = "Stun_" .. var_25_1 .. "_" .. var_25_0

		arg_25_0.mainTF:Find("main/Image"):GetComponent(typeof(Animator)):Play("Clash_" .. arg_25_1)
		arg_25_0.binder:emit(OreGameConfig.EVENT_PLAY_CONTAINER_HIT, {
			pos = arg_25_0._tf.anchoredPosition,
			hitPos = arg_25_0.hitPos,
			status = arg_25_0.status,
			oreTF = arg_25_0.mainTF:Find("ore/Image/" .. tostring(arg_25_0.status))
		})
		arg_25_0:ResetStatus()

		return
	end
end

function var_0_0.PlayDeliver(arg_26_0)
	arg_26_0.isDeliver = true

	setActive(arg_26_0.mainTF:Find("tool"), false)
	setActive(arg_26_0.mainTF:Find("ore"), false)
	arg_26_0.mainTF:Find("main/Image"):GetComponent(typeof(Animator)):Play("Deliver")

	return
end

function var_0_0.CheckDeliver(arg_27_0)
	if arg_27_0._tf.anchoredPosition.y < OreGameConfig.RANGE_Y[1] + 2 and arg_27_0._tf.anchoredPosition.x > -100 and arg_27_0._tf.anchoredPosition.x < 100 and arg_27_0.animDir == "S" and arg_27_0.weight > 0 then
		arg_27_0:PlayDeliver()
		arg_27_0.binder:emit(OreGameConfig.EVENT_DELIVER, {
			point = arg_27_0.point,
			status = arg_27_0.status,
			pos = arg_27_0._tf.anchoredPosition,
			oreTF = arg_27_0.mainTF:Find("ore/Image/" .. tostring(arg_27_0.status))
		})
	end

	return
end

function var_0_0.OnTimer(arg_28_0, arg_28_1)
	if arg_28_0.invincible then
		arg_28_0.invincible = arg_28_0.invincible + arg_28_1

		if arg_28_0.invincible >= OreGameConfig.INVINCIBLE_TIME then
			arg_28_0.invincible = nil
		end
	end

	if arg_28_0.hitTime then
		if arg_28_1 * 5 < arg_28_0.hitTime and arg_28_0.hitTime <= arg_28_1 * 6 then
			arg_28_0.mainTF:Find("main/Image"):GetComponent(typeof(Animator)):Play(arg_28_0.hitAnimName)

			arg_28_0.playHitAnim = true
		elseif arg_28_0.hitTime > arg_28_1 * 6 then
			arg_28_0:SetPosition({
				x = arg_28_0._tf.anchoredPosition.x + arg_28_0.hitPos.x * arg_28_1 / var_0_0.HIT_MOVE_TIME,
				y = arg_28_0._tf.anchoredPosition.y + arg_28_0.hitPos.y * arg_28_1 / var_0_0.HIT_MOVE_TIME
			})
		end

		arg_28_0.hitTime = arg_28_0.hitTime + arg_28_1

		if arg_28_0.hitTime >= var_0_0.HIT_MOVE_TIME then
			arg_28_0.hitTime = nil
		end

		return
	end

	if not arg_28_0.isDeliver and not arg_28_0.playHitAnim then
		local var_28_0 = Vector2(arg_28_0.uiMgr.hrz, arg_28_0.uiMgr.vtc)

		arg_28_0:UpdateAnim(var_28_0)
		arg_28_0:UpdatePosition(var_28_0)
		arg_28_0:CheckDeliver()
	end

	return
end

function var_0_0.UpdateAnim(arg_29_0, arg_29_1)
	local var_29_0 = OreGameHelper.GetFourDirLabel(arg_29_1)
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
		arg_29_0.mainTF:Find("main/Image"):GetComponent(typeof(Animator)):Play(var_29_2)

		arg_29_0.mainAnimName = var_29_2
	end

	if arg_29_0.status ~= var_0_0.STATUS_NULL then
		if var_29_4 ~= "" and var_29_4 ~= arg_29_0.toolAnimName then
			if string.find(var_29_4, "N_1") or string.find(var_29_4, "N_2") then
				local var_29_5 = arg_29_0.mainTF:Find("tool/Image")

				var_29_5:GetComponent(typeof(Image)).enabled = false
			else
				local var_29_6 = arg_29_0.mainTF:Find("tool/Image")

				var_29_6:GetComponent(typeof(Image)).enabled = true

				arg_29_0.mainTF:Find("tool/Image"):GetComponent(typeof(Animator)):Play(var_29_4)
			end

			arg_29_0.toolAnimName = var_29_4
		end

		if var_29_3 ~= "" and var_29_3 ~= arg_29_0.oreAnimName then
			arg_29_0.mainTF:Find("ore/Image"):GetComponent(typeof(Animator)):Play(var_29_3)

			arg_29_0.oreAnimName = var_29_3

			local var_29_7 = arg_29_0.mainTF:Find("ore/Image/" .. arg_29_0.status .. "/oreTF")

			if not var_29_1 and var_0_0.oreAnimOffset[arg_29_0.status][arg_29_0.animDir] then
				setAnchoredPosition(var_29_7, var_0_0.oreAnimOffset[arg_29_0.status][arg_29_0.animDir])
			else
				setAnchoredPosition(var_29_7, Vector2(0, 0))
			end
		end
	end

	return
end

var_0_0.oreAnimOffset = {
	{
		S = Vector2(0, -2),
		W = Vector2(1, -2)
	},
	{
		S = Vector2(0, -2)
	},
	{
		W = Vector2(5, 0),
		E = Vector2(-3, 0)
	}
}

function var_0_0.UpdatePosition(arg_30_0, arg_30_1)
	local var_30_0 = OreGameHelper.GetEightDirVector(arg_30_1) * OreGameConfig.TIME_INTERVAL * arg_30_0.speed

	arg_30_0:SetPosition({
		x = arg_30_0._tf.anchoredPosition.x + var_30_0.x,
		y = arg_30_0._tf.anchoredPosition.y + var_30_0.y
	})

	return
end

function var_0_0.SetPosition(arg_31_0, arg_31_1)
	if OreGameHelper.CheckRemovable(arg_31_1) then
		setAnchoredPosition(arg_31_0._tf, arg_31_1)

		arg_31_0._tf:GetComponent(typeof(Canvas)).sortingOrder = -arg_31_1.y + 320
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
