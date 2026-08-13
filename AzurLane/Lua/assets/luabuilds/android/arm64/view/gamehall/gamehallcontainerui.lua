class = var_0_10000

local var_0_0 = var_0_10000("GameHallContainerUI")
local var_0_1 = 4

Vector3 = var_2

local var_0_2 = var_2(0.7, 0.7, 0.7)
local var_0_3 = "mingshi"
local var_0_4 = 0.1
local var_0_5 = 100
local var_0_6 = 4
local var_0_7
local var_0_8
local var_0_9 = 3256
local var_0_10 = 1920
local var_0_11 = {
	{
		"item3",
		"item3/spine"
	}
}
local var_0_12 = {
	{
		bound = "item1/spine/bound",
		pos = "item1/spine/pos",
		spine = "item1/spine"
	},
	{
		bound = "item2/spine2/bound",
		pos = "item2/spine2/pos",
		spine = "item2/spine2"
	},
	{
		bound = "item2/spine3/bound",
		pos = "item2/spine3/pos",
		spine = "item2/spine3"
	},
	{
		bound = "item4/spine1/bound",
		pos = "item4/spine1/pos",
		spine = "item4/spine1"
	},
	{
		bound = "item4/spine2/bound",
		pos = "item4/spine2/pos",
		spine = "item4/spine2"
	},
	{
		bound = "item6/spine1/bound",
		pos = "item6/spine1/pos",
		spine = "item6/spine1"
	},
	{
		bound = "item6/spine2/bound",
		pos = "item6/spine2/pos",
		spine = "item6/spine2"
	}
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	local var_1_0 = var_1_10002.UIMgr.GetInstance().uiCamera.gameObject.transform
	local var_1_1 = var_2.Find(var_1_0, "Canvas").sizeDelta.x - var_0_10
	local var_1_2 = var_0_10 - var_0_9 + var_1_1

	var_0_7 = {
		var_1_2,
		0
	}
	var_0_8 = {
		0,
		0
	}
	arg_1_0.container = arg_1_1
	findTF = var_5
	arg_1_0.content = var_5(arg_1_0.container, "content")
	findTF = var_5
	arg_1_0.pos = var_5(arg_1_0.content, "pos")
	findTF = var_5
	arg_1_0.boundContainer = var_5(arg_1_0.content, "bound")
	arg_1_0.charContentEvents = {}
	arg_1_0.charContentCollider = {}
	arg_1_0.items = {}

	for iter_1_0 = 0, arg_1_0.pos.childCount - 1 do
		table = var_1_10009
		var_1_10009 = var_1_10009.insert
		var_1_10011 = arg_1_0.items
		var_1_10014 = arg_1_0.pos

		var_1_10009(var_1_10011, var_1_10012.GetChild(var_1_10014, iter_1_0))
	end

	arg_1_0.sitItems = {}

	for iter_1_1 = 1, #var_0_12 do
		local var_1_3 = var_0_12[iter_1_1]

		findTF = var_1_10010
		var_1_10010 = var_1_10010(arg_1_0.pos, var_1_3.pos)
		GetComponent = var_1_10011
		findTF = var_1_10013
		var_1_10013 = var_1_10013(arg_1_0.pos, var_1_3.spine)
		typeof = var_1_10014
		SpineAnimUI = var_1_10016
		var_1_10011 = var_1_10011(var_1_10013, var_1_10014(var_1_10016))
		GetComponent = var_1_10012
		findTF = var_1_10014
		var_1_10014 = var_1_10014(arg_1_0.pos, var_1_3.bound)
		typeof = var_15
		BoxCollider2D = var_1_10017
		var_1_10012 = var_1_10012(var_1_10014, var_15(var_1_10017))

		local var_1_4 = arg_1_0.pos

		var_1_10013 = var_1_10013.InverseTransformPoint(var_1_4, var_1_10012.bounds.min)
		var_1_10016 = arg_1_0.pos
		var_1_10014 = var_1_10014.InverseTransformPoint(var_1_10016, var_1_10012.bounds.max)
		table = var_1_4

		var_1_4.insert(arg_1_0.sitItems, {
			sit = false,
			pos = var_1_10010,
			min = var_1_10013,
			max = var_1_10014,
			anim = var_1_10011
		})
	end

	getProxy = var_5
	BayProxy = var_7

	local var_1_5 = var_5(var_7)
	local var_1_6 = var_5.getShips(var_1_5)
	local var_1_7 = {}

	for iter_1_2 = 1, #var_1_6 do
		table = var_1_10012

		if not var_1_10012.contains(var_1_7, var_1_6[iter_1_2].name) then
			table = var_1_10012
			var_1_10012 = var_1_10012.insert
			var_1_10014 = var_1_7
			var_1_10017 = var_1_6[iter_1_2]

			var_1_10012(var_1_10014, var_15.getPrefab(var_1_10017))
		end
	end

	if var_0_1 > #var_1_7 then
		var_0_1 = #var_1_7
	end

	arg_1_0.chars = {}

	for iter_1_3 = 1, var_0_1 do
		local var_1_8 = iter_1_3

		table = var_1_10013
		var_1_10013 = var_1_10013.remove

		local var_1_9 = var_1_7

		math = var_1_10016
		var_1_10013 = var_1_10013(var_1_9, var_1_10016.random(1, #var_1_7))
		SpineAnimChar = var_1_10014
		var_1_10017 = var_1_10014.New()

		var_1_10014.SetPaint(var_1_10017, var_1_10013)

		var_1_10017 = var_1_10014

		var_1_10014.Load(var_1_10017, true, function(arg_2_0)
			arg_2_0:SetAction("stand2", 0)
			arg_2_0:SetParent(arg_1_0.pos)
			arg_2_0:SetLocalScale(var_0_2)

			findTF = var_1

			local var_2_0 = arg_1_0.boundContainer

			tostring = var_4

			local var_2_1

			var_2_1, GetComponent = var_1(var_2_0, var_4(var_1_8)), var_2_10002
			typeof = var_5
			BoxCollider2D = var_2_10007

			local var_2_2 = var_2_10002(var_2_1, var_5(var_2_10007))
			local var_2_3 = arg_1_0.pos
			local var_2_4 = var_3.InverseTransformPoint(var_2_3, var_2_2.bounds.min)
			local var_2_5 = arg_1_0.pos
			local var_2_6 = var_4.InverseTransformPoint(var_2_5, var_2_2.bounds.max)
			local var_2_7 = arg_2_0
			local var_2_8 = arg_2_0.SetAnchoredPosition
			local var_2_9 = arg_1_0

			var_2_8(var_2_7, var_8.getTargetPos(var_2_9, var_2_4, var_2_6))

			table = var_2_8

			local var_2_10 = var_2_8.insert
			local var_2_11 = arg_1_0.chars
			local var_2_12 = {
				model = arg_2_0
			}

			Vector2 = var_2_10009
			var_2_12.vel = var_2_10009(0, 0)
			var_2_12.bound = {
				var_2_4.x,
				var_2_4.y,
				var_2_6.x,
				var_2_6.y
			}
			var_2_12.min = var_2_4
			var_2_12.max = var_2_6
			var_2_12.pos = arg_2_0:GetAnchoredPosition()
			var_2_12.curScale = arg_2_0:GetLocalScale()

			var_2_10(var_2_11, var_2_12)

			table = var_2_10

			local var_2_13 = var_2_10.insert
			local var_2_14 = arg_1_0.items

			tf = var_2_12

			var_2_13(var_2_14, var_2_12(arg_2_0:GetModel()))

			return
		end)
	end

	findTF = var_8
	arg_1_0.bataiTf = var_8(arg_1_0.pos, "batai")
	arg_1_0.coinChar = nil
	PoolMgr = var_8

	local var_1_10 = var_8.GetInstance()

	var_8.GetSpineChar(var_1_10, var_0_3, true, function(arg_3_0)
		local var_3_0 = arg_1_0

		tf = var_2_10002
		var_3_0.coinChar = var_2_10002(arg_3_0)
		tf = var_3_0

		local var_3_1 = var_3_0(arg_3_0)
		local var_3_2 = var_1.GetComponent

		typeof = var_4
		SpineAnimUI = var_2_10006

		local var_3_3 = var_3_2(var_3_1, var_4(var_2_10006))

		var_1.SetAction(var_3_3, "stand2", 0)

		setParent = var_2
		tf = var_3_3

		local var_3_4 = var_3_3(arg_3_0)

		findTF = var_5

		var_2(var_3_4, var_5(arg_1_0.bataiTf, "char"))

		setLocalScale = var_2

		var_2(arg_3_0, var_0_2)

		return
	end)

	local var_1_11 = arg_1_0.content

	Vector2 = var_9
	var_1_11.anchoredPosition = var_9(0, 0)
	GetOrAddComponent = var_1_11

	local var_1_12 = arg_1_0.content

	typeof = var_11
	EventTriggerListener = var_1_14

	local var_1_13 = var_1_11(var_1_12, var_11(var_1_14))

	Vector2 = var_9
	arg_1_0.velocityXSmoothing = var_9(0, 0)
	arg_1_0.offsetPosition = arg_1_0.content.anchoredPosition

	var_1_13:AddBeginDragFunc(function(arg_4_0, arg_4_1)
		arg_1_0.prevPosition = arg_4_1.position
		arg_1_0.scenePosition = arg_1_0.content.anchoredPosition

		local var_4_0 = arg_1_0

		Vector2 = var_3
		var_4_0.velocityXSmoothing = var_3(0, 0)
		arg_1_0.offsetPosition = arg_1_0.content.anchoredPosition

		return
	end)
	var_1_13:AddDragFunc(function(arg_5_0, arg_5_1)
		arg_1_0.offsetPosition.x = arg_5_1.position.x - arg_1_0.prevPosition.x + arg_1_0.scenePosition.x
		arg_1_0.offsetPosition.y = arg_5_1.position.y - arg_1_0.prevPosition.y + arg_1_0.scenePosition.y

		local var_5_0 = arg_1_0.offsetPosition
		local var_5_1

		if not (arg_1_0.offsetPosition.x > var_0_7[2]) or not var_0_7[2] then
			var_5_1 = arg_1_0.offsetPosition.x
		end

		var_5_0.x = var_5_1

		local var_5_2 = arg_1_0.offsetPosition
		local var_5_3

		if not (arg_1_0.offsetPosition.x < var_0_7[1]) or not var_0_7[1] then
			var_5_3 = arg_1_0.offsetPosition.x
		end

		var_5_2.x = var_5_3

		local var_5_4 = arg_1_0.offsetPosition
		local var_5_5

		if not (arg_1_0.offsetPosition.y > var_0_8[2]) or not var_0_8[2] then
			var_5_5 = arg_1_0.offsetPosition.y
		end

		var_5_4.y = var_5_5

		local var_5_6 = arg_1_0.offsetPosition
		local var_5_7

		if not (arg_1_0.offsetPosition.y < var_0_8[1]) or not var_0_8[1] then
			var_5_7 = arg_1_0.offsetPosition.y
		end

		var_5_6.y = var_5_7

		return
	end)
	var_1_13:AddDragEndFunc(function(arg_6_0, arg_6_1)
		return
	end)

	arg_1_0.clickItems = {}

	for iter_1_4 = 1, #var_0_11 do
		findTF = var_1_14

		local var_1_14 = var_1_14(arg_1_0.pos, var_0_11[iter_1_4][1])

		GetComponent = var_1_10014
		findTF = var_16

		local var_1_15 = var_16(arg_1_0.pos, var_0_11[iter_1_4][2])

		typeof = var_1_10017
		SpineAnimUI = var_19
		var_1_10014 = var_1_10014(var_1_15, var_1_10017(var_19))
		table = var_15

		var_15.insert(arg_1_0.clickItems, {
			time = 0,
			tf = var_1_14,
			anim = var_1_10014
		})

		onButton = var_15

		var_15(arg_1_0._event, var_1_14, function()
			local var_7_0 = arg_1_0

			if var_0.checkClickTime(var_7_0, var_1_10014) then
				local var_7_1 = arg_1_0

				var_0.setAnimAction(var_7_1, var_1_10014, "action", 1, "normal")
			end

			return
		end)
	end

	return
end

function var_0_0.setCharSit(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1.sitFlag or arg_8_2.sitFlag then
		return
	end

	local var_8_0 = arg_8_1.model
	local var_8_1 = arg_8_2.pos
	local var_8_2 = arg_8_2.anim
	local var_8_3 = arg_8_1.model

	var_6.SetLocalScale(var_8_3, var_0_2)
	arg_8_0:setCharAction(var_8_0, "sit", 0, nil)
	arg_8_0:setAnimAction(var_8_2, "sit", 0, nil)

	arg_8_1.curAction = "sit"
	arg_8_2.curAction = "sit"
	arg_8_1.target = nil
	arg_8_1.sitItem = arg_8_2
	arg_8_1.sitFlag = true
	math = var_6
	arg_8_1.time = var_6.random(10, 20)
	Vector2 = var_6
	arg_8_1.vel = var_6(0, 0)
	arg_8_2.sitFlag = true

	local var_8_4 = arg_8_1.model

	var_6.SetParent(var_8_4, var_8_1)

	local var_8_5 = arg_8_1.model
	local var_8_6 = var_6.SetAnchoredPosition

	Vector2 = var_9

	var_8_6(var_8_5, var_9(0, 0))

	return
end

function var_0_0.stopCharSit(arg_9_0, arg_9_1)
	arg_9_1.sitItem.sitFlag = false

	arg_9_0:setCharAction(arg_9_1.model, "walk", 0, nil)
	arg_9_0:setAnimAction(arg_9_1.sitItem.anim, "normal", 0, nil)

	arg_9_1.sitItem = nil
	arg_9_1.sitFlag = false

	local var_9_0 = arg_9_1.model

	var_2.SetParent(var_9_0, arg_9_0.pos)

	local var_9_1 = arg_9_1.model

	var_2.SetAnchoredPosition(var_9_1, arg_9_1.pos)

	return
end

function var_0_0.checkClickTime(arg_10_0, arg_10_1)
	for iter_10_0 = 1, #arg_10_0.clickItems do
		if arg_10_0.clickItems[iter_10_0].anim == arg_10_1 then
			if arg_10_0.clickItems[iter_10_0].time ~= 0 then
				Time = var_6

				local var_10_0 = var_6.realtimeSinceStartup

				if arg_10_0.clickItems[iter_10_0].time < var_10_0 then
					local var_10_1 = arg_10_0.clickItems[iter_10_0]

					Time = var_1_10007
					var_10_1.time = var_1_10007.realtimeSinceStartup + 2

					return true
				end
			end
		end
	end

	return false
end

function var_0_0.step(arg_11_0)
	local var_11_0 = arg_11_0.content

	Vector2 = var_1_10002
	var_11_0.anchoredPosition, arg_11_0.velocityXSmoothing = var_1_10002.SmoothDamp(arg_11_0.content.anchoredPosition, arg_11_0.offsetPosition, arg_11_0.velocityXSmoothing, var_0_4)

	for iter_11_0 = 1, #arg_11_0.chars do
		local var_11_1 = arg_11_0.chars[iter_11_0].time
		local var_11_2 = var_5.pos

		if not var_11_1 or var_11_1 <= 0 then
			local var_11_3

			if var_5.sitFlag then
				arg_11_0:stopCharSit(var_5)
			else
				math = var_11_3

				if var_11_3.random(1, 10) > 5 then
					var_11_3 = arg_11_0:getTargetPos(var_5.min, var_5.max)
					var_1_10011 = arg_11_0
					var_5.vel, var_5.target = arg_11_0.getVel(var_1_10011, var_11_2, var_11_3), var_11_3
				end
			end

			math = var_11_3
			var_5.time = var_11_3.random(1, var_0_6)
		end

		if var_5.target and not var_5.sitFlag then
			local var_11_4 = {}
			local var_11_5 = var_5.vel.x * var_0_5

			Time = var_10
			var_11_4[1] = var_11_5 * var_10.deltaTime

			local var_11_6 = var_5.vel.y * var_0_5

			Time = var_10
			var_11_4[2] = var_11_6 * var_10.deltaTime

			if var_11_4[1] ~= 0 then
				var_5.pos.x = var_5.pos.x + var_11_4[1]
			end

			if var_11_4[2] ~= 0 then
				var_5.pos.y = var_5.pos.y + var_11_4[2]
			end

			local var_11_7 = var_5.bound

			if var_5.pos.x < var_11_7[1] then
				var_5.pos.x = var_11_7[1]
				var_5.vel.x = 0
			end

			local var_11_8 = var_5.pos.x

			if var_11_7[3] < var_11_8 then
				var_5.pos.x = var_11_7[3]
				var_5.vel.x = 0
			end

			if var_5.pos.y < var_11_7[2] then
				var_5.pos.y = var_11_7[2]
				var_5.vel.y = 0
			end

			local var_11_9 = var_5.pos.y

			if var_11_7[4] < var_11_9 then
				var_5.pos.y = var_11_7[4]
				var_5.vel.y = 0
			end

			local var_11_10 = var_5.model

			var_10.SetAnchoredPosition(var_11_10, var_5.pos)

			local var_11_11 = var_5.target

			math = var_1_10011

			if var_1_10011.abs(var_5.target.x - var_5.pos.x) < 10 then
				var_1_10011 = var_5.vel
				var_1_10011.x = 0
			end

			math = var_1_10011

			if var_1_10011.abs(var_5.target.y - var_5.pos.y) < 10 then
				var_1_10011 = var_5.vel
				var_1_10011.y = 0
			end
		end

		local var_11_12 = true
		local var_11_13 = var_5.sitFlag

		if var_5.vel.x == 0 and var_5.vel.y == 0 then
			local var_11_14 = var_5.time

			Time = var_1_10011
			var_5.time = var_11_14 - var_1_10011.deltaTime
			var_11_12 = false
		end

		if not var_11_12 and var_5.target then
			var_5.target = nil
		end

		if not var_5.sitFlag and not var_11_12 then
			var_5.ableSit = true
		end

		if var_5.vel.x ~= 0 then
			local var_11_15 = var_5.vel.x
			local var_11_16 = 0 < var_11_15 and 1 or -1

			math = var_1_10011

			if var_1_10011.sign(var_5.curScale.x) ~= var_11_16 then
				var_1_10011 = var_5.curScale
				var_1_10011.x = var_11_16 * var_0_2.x

				local var_11_17 = var_5.model

				var_1_10011.SetLocalScale(var_11_17, var_5.curScale)
			end
		end

		if var_11_12 then
			if var_5.curAction ~= "walk" then
				var_5.curAction = "walk"

				local var_11_18 = var_5.model

				var_10.SetAction(var_11_18, "walk", 0)
			end
		elseif var_11_13 then
			if var_5.curAction ~= "sit" then
				var_5.curAction = "sit"

				local var_11_19 = var_5.model

				var_10.SetAction(var_11_19, "sit", 0)
			end
		elseif var_5.curAction ~= "stand2" then
			var_5.curAction = "stand2"

			local var_11_20 = var_5.model

			var_10.SetAction(var_11_20, "stand2", 0)
		end

		if var_11_12 then
			arg_11_0:checkCharSit(var_5)
		end
	end

	table = var_1

	var_1.sort(arg_11_0.items, function(arg_12_0, arg_12_1)
		if arg_12_0.anchoredPosition.y < arg_12_1.anchoredPosition.y then
			return true
		end

		return
	end)

	ipairs = var_1

	for iter_11_1, iter_11_2 in var_1(arg_11_0.items) do
		iter_11_2:SetAsFirstSibling()
	end

	return
end

function var_0_0.checkCharSit(arg_13_0, arg_13_1)
	if not arg_13_1.ableSit then
		return
	end

	local var_13_0 = arg_13_1.pos

	for iter_13_0 = 1, #arg_13_0.sitItems do
		local var_13_1 = arg_13_0.sitItems[iter_13_0].min
		local var_13_2 = var_7.max

		if var_13_0.x > var_13_1.x and var_13_0.x < var_13_2.x and var_13_0.y > var_13_1.y and var_13_0.y < var_13_2.y then
			math = var_10

			if var_10.random(1, 10) > 7 then
				print = var_12

				var_12("角色想坐下")
				arg_13_0:setCharSit(arg_13_1, var_7)
			else
				arg_13_1.ableSit = false
				print = var_12

				var_12("角色不想坐下")
			end
		end
	end

	return
end

function var_0_0.getVel(arg_14_0, arg_14_1, arg_14_2)
	math = var_1_10003

	local var_14_0 = var_1_10003.atan

	math = var_1_10005

	local var_14_1 = var_1_10005.abs(arg_14_2.y - arg_14_1.y)

	math = var_1_10006

	local var_14_2 = var_14_0(var_14_1 / var_1_10006.abs(arg_14_2.x - arg_14_1.x))
	local var_14_3 = arg_14_2.x > arg_14_1.x and 1 or -1
	local var_14_4 = arg_14_2.y
	local var_14_5 = arg_14_1.y < var_14_4 and 1 or -1

	math = var_6

	local var_14_6 = var_6.cos(var_14_2) * var_14_3

	math = var_7

	local var_14_7 = var_7.sin(var_14_2) * var_14_5

	Vector2 = var_8

	return var_8(var_14_6, var_14_7)
end

function var_0_0.setCharAction(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_1:SetActionCallBack(nil)
	arg_15_1:SetAction(arg_15_2, 0)
	arg_15_1:SetActionCallBack(function(arg_16_0)
		if arg_16_0 == "finish" and arg_15_3 == 1 then
			local var_16_0 = arg_15_1

			var_1.SetActionCallBack(var_16_0, nil)

			local var_16_1 = arg_15_1

			var_1.SetAction(var_16_1, arg_15_4, 0)
		end

		return
	end)

	return
end

function var_0_0.setAnimAction(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	arg_17_1:SetActionCallBack(nil)
	arg_17_1:SetAction(arg_17_2, 0)
	arg_17_1:SetActionCallBack(function(arg_18_0)
		if arg_18_0 == "finish" and arg_17_3 == 1 then
			local var_18_0 = arg_17_1

			var_1.SetActionCallBack(var_18_0, nil)

			local var_18_1 = arg_17_1

			var_1.SetAction(var_18_1, arg_17_4, 0)
		end

		return
	end)

	return
end

function var_0_0.getTargetPos(arg_19_0, arg_19_1, arg_19_2)
	tonumber = var_1_10003

	local var_19_0 = var_1_10003(arg_19_2.x)

	tonumber = var_1_10004

	local var_19_1 = var_19_0 - var_1_10004(arg_19_1.x)

	tonumber = var_4

	local var_19_2 = var_4(arg_19_2.y)

	tonumber = var_5

	local var_19_3 = var_19_2 - var_5(arg_19_1.y)

	Vector2 = var_5

	local var_19_4 = arg_19_1.x

	math = var_1_10008

	local var_19_5 = var_19_4 + var_1_10008.random(1, var_19_1)
	local var_19_6 = arg_19_1.y

	math = var_1_10009

	return var_5(var_19_5, var_19_6 + var_1_10009.random(1, var_19_3))
end

function var_0_0.isPointInMatrix(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	return arg_20_0:getCross(arg_20_1, arg_20_2, arg_20_5) * arg_20_0:getCross(arg_20_3, arg_20_4, arg_20_5) >= 0 and arg_20_0:getCross(arg_20_2, arg_20_3, arg_20_5) * arg_20_0:getCross(arg_20_4, arg_20_1, arg_20_5) >= 0
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.coinChar then
		PoolMgr = var_1

		local var_21_0 = var_1.GetInstance()
		local var_21_1 = var_1.ReturnSpineChar
		local var_21_2 = var_0_3

		go = var_1_10005

		var_21_1(var_21_0, var_21_2, var_1_10005(arg_21_0.coinChar))

		arg_21_0.coinChar = nil
	end

	if arg_21_0.chars and #arg_21_0.chars > 0 then
		for iter_21_0 = 1, #arg_21_0.chars do
			local var_21_3 = arg_21_0.chars[iter_21_0].model

			var_5.Dispose(var_21_3)
		end

		arg_21_0.chars = nil
	end

	return
end

return var_0_0
