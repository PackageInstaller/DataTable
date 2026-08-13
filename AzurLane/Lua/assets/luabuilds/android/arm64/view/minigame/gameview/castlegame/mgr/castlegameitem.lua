class = var_0_10000

local var_0_0 = var_0_10000("CastleGameItem")
local var_0_1 = 70
local var_0_2 = 300
local var_0_3 = 166
local var_0_4 = {
	2,
	6
}
local var_0_5 = 125
local var_0_6 = "bubble_broken"
local var_0_7 = "bubble_wait"
local var_0_8 = "bubble_hold"
local var_0_9 = 130
local var_0_10 = 130

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	findTF = var_1_10003
	arg_1_0._bubbleTpl = var_1_10003(arg_1_1, "bubbleTpl")
	findTF = var_3
	arg_1_0._carriageTpl = var_3(arg_1_1, "carriageTpl")
	findTF = var_3
	arg_1_0._stoneTpl = var_3(arg_1_1, "stoneTpl")
	findTF = var_3
	arg_1_0._boomTpl = var_3(arg_1_1, "boomTpl")
	arg_1_0._event = arg_1_2
	arg_1_0.carriagePool = {}
	arg_1_0.bubblePool = {}
	arg_1_0.carriages = {}
	arg_1_0.bubbles = {}
	arg_1_0.stonePool = {}
	arg_1_0.stones = {}
	arg_1_0.boomPool = {}
	arg_1_0.booms = {}

	return
end

function var_0_0.setContent(arg_2_0, arg_2_1)
	if not arg_2_1 then
		print = var_1_10002

		var_1_10002("容器不能为nil")

		return
	end

	arg_2_0._content = arg_2_1

	return
end

function var_0_0.start(arg_3_0)
	CastleGameVo = var_1_10001

	local var_3_0 = var_1_10001.roundData.stone

	arg_3_0.stoneDatas = {}

	for iter_3_0 = 1, #var_3_0 do
		math = var_1_10006
		var_1_10006 = var_1_10006.random() * (var_3_0[iter_3_0].time[2] - var_3_0[iter_3_0].time[1]) + var_3_0[iter_3_0].time[1]
		var_1_10007 = var_3_0[iter_3_0].index
		table = var_1_10008

		var_1_10008.insert(arg_3_0.stoneDatas, {
			time = var_1_10006,
			indexs = var_1_10007
		})
	end

	for iter_3_1 = #arg_3_0.stones, 1, -1 do
		table = var_1_10006
		var_1_10006 = var_1_10006.remove(arg_3_0.stones, iter_3_1)
		setActive = var_1_10007

		var_1_10007(var_1_10006.tf, false)
		arg_3_0:returnItem(var_1_10006, arg_3_0.stonePool)
	end

	for iter_3_2 = #arg_3_0.carriages, 1, -1 do
		table = var_1_10006
		var_1_10006 = var_1_10006.remove(arg_3_0.carriages, iter_3_2)
		var_1_10006.ready = 0
		setActive = var_1_10007

		var_1_10007(var_1_10006.tf, false)
		arg_3_0:returnItem(var_1_10006, arg_3_0.carriagePool)
	end

	for iter_3_3 = #arg_3_0.bubbles, 1, -1 do
		table = var_1_10006
		var_1_10006 = var_1_10006.remove(arg_3_0.bubbles, iter_3_3)
		var_1_10006.ready = 0
		var_1_10006.broken = true
		var_1_10006.brokenTime = 0
		var_1_10006.hit = false
		setActive = var_1_10007

		var_1_10007(var_1_10006.tf, false)
		arg_3_0:returnItem(var_1_10006, arg_3_0.bubblePool)
	end

	for iter_3_4 = #arg_3_0.booms, 1, -1 do
		table = var_1_10006
		var_1_10006 = var_1_10006.remove(arg_3_0.booms, iter_3_4)
		var_1_10006.ready = 0
		var_1_10006.broken = true
		var_1_10006.brokenTime = 0
		setActive = var_1_10007

		var_1_10007(var_1_10006.tf, false)
		arg_3_0:returnItem(var_1_10006, arg_3_0.boomPool)
	end

	arg_3_0.floorIndexs = {}
	CastleGameVo = var_2
	arg_3_0.carriageTime = var_2.roundData.carriage
	CastleGameVo = var_2
	arg_3_0.bubbleTime = var_2.roundData.bubble_time
	arg_3_0.boomTimes = {}

	local var_3_1 = 1

	CastleGameVo = var_3

	for iter_3_5 = var_3_1, #var_3.roundData.boom do
		CastleGameVo = var_1_10006
		var_1_10006 = var_1_10006.roundData.boom[iter_3_5].time
		math = var_1_10007
		var_1_10007 = var_1_10006[var_1_10007.random(1, #var_1_10006)]
		table = var_1_10008

		var_1_10008.insert(arg_3_0.boomTimes, {
			time = var_1_10007
		})
	end

	return
end

function var_0_0.step(arg_4_0)
	for iter_4_0 = #arg_4_0.carriageTime, 1, -1 do
		CastleGameVo = var_1_10005
		var_1_10005 = var_1_10005.gameStepTime

		if arg_4_0.carriageTime[iter_4_0] < var_1_10005 then
			table = var_1_10005

			var_1_10005.remove(arg_4_0.carriageTime, iter_4_0)
			arg_4_0:appearCarriage()
		end
	end

	for iter_4_1 = #arg_4_0.bubbleTime, 1, -1 do
		CastleGameVo = var_1_10005
		var_1_10005 = var_1_10005.gameStepTime

		if arg_4_0.bubbleTime[iter_4_1].time < var_1_10005 then
			table = var_1_10005
			var_1_10005 = var_1_10005.remove(arg_4_0.bubbleTime, iter_4_1)
			var_1_10008 = arg_4_0

			arg_4_0.appearBubble(var_1_10008, var_1_10005.num)
		end
	end

	for iter_4_2 = #arg_4_0.boomTimes, 1, -1 do
		var_1_10005 = arg_4_0.boomTimes[iter_4_2]
		CastleGameVo = var_1_10006

		if var_1_10006.gameStepTime > var_1_10005.time then
			table = var_1_10006

			var_1_10006.remove(arg_4_0.boomTimes, iter_4_2)

			var_1_10008 = arg_4_0

			arg_4_0.appearBoom(var_1_10008)
		end
	end

	for iter_4_3 = #arg_4_0.carriages, 1, -1 do
		if arg_4_0.carriages[iter_4_3].ready then
			local var_4_0 = var_1_10005.ready

			if 0 < var_4_0 then
				local var_4_1 = var_1_10005.ready

				CastleGameVo = var_7
				var_1_10005.ready = var_4_1 - var_7.deltaTime

				if var_1_10005.ready <= 0 then
					var_1_10005.ready = 0

					if arg_4_0.itemRemindCallback then
						-- block empty
					end
				end

				goto label_4_0
			end
		end

		do
			local var_4_2 = var_1_10005.tf
			local var_4_3 = var_1_10005.target

			var_1_10008 = var_4_2.anchoredPosition
			Vector2 = var_1_10009

			local var_4_4 = var_1_10008.x
			local var_4_5 = var_1_10005.speed.x

			CastleGameVo = var_1_10013

			local var_4_6 = var_4_4 + var_4_5 * var_1_10013.deltaTime * var_0_2
			local var_4_7 = var_1_10008.y

			var_1_10013 = var_1_10005.speed.y
			CastleGameVo = var_1_10014
			var_4_2.anchoredPosition = var_1_10009(var_4_6, var_4_7 + var_1_10013 * var_1_10014.deltaTime * var_0_2)

			if var_1_10008.x < var_4_3.x and var_1_10009.x > var_4_3.x then
				table = var_10

				var_10.remove(arg_4_0.carriages, iter_4_3)

				setActive = var_10

				var_10(var_1_10005.tf, false)
				arg_4_0:returnItem(var_1_10005, arg_4_0.carriagePool)
			elseif var_1_10008.x > var_4_3.x and var_1_10009.x < var_4_3.x then
				table = var_10

				var_10.remove(arg_4_0.carriages, iter_4_3)

				setActive = var_10

				var_10(var_1_10005.tf, false)
				arg_4_0:returnItem(var_1_10005, arg_4_0.carriagePool)
			end
		end

		::label_4_0::
	end

	for iter_4_4 = #arg_4_0.bubbles, 1, -1 do
		if arg_4_0.bubbles[iter_4_4].ready then
			local var_4_8 = var_1_10005.ready

			if 0 < var_4_8 then
				local var_4_9 = var_1_10005.ready

				CastleGameVo = var_7
				var_1_10005.ready = var_4_9 - var_7.deltaTime

				if var_1_10005.ready <= 0 then
					var_1_10005.ready = 0
					setActive = var_6

					var_6(var_1_10005.tf, true)
				end

				goto label_4_1
			end
		end

		if var_1_10005.brokenTime then
			local var_4_10 = var_1_10005.brokenTime

			if 0 < var_4_10 then
				local var_4_11 = var_1_10005.brokenTime

				CastleGameVo = var_7
				var_1_10005.brokenTime = var_4_11 - var_7.deltaTime

				if not var_1_10005.hit then
					CastleGameVo = var_6

					if var_6.bubble_broken_time - var_1_10005.brokenTime > 1 then
						var_1_10005.hit = true
					end
				end

				if var_1_10005.brokenTime < 0 then
					var_1_10005.broken = true
					var_1_10005.brokenTime = 0
					var_1_10005.hit = false

					if arg_4_0.bubbleBrokenCallback then
						arg_4_0.bubbleBrokenCallback(var_1_10005)
					end

					var_1_10008 = arg_4_0

					arg_4_0.changeAnimAction(var_1_10008, var_1_10005.anims, var_0_6, 1, var_0_7, function()
						setActive = var_2_10000

						var_2_10000(var_1_10005.tf, false)

						return
					end)

					var_1_10008 = arg_4_0

					arg_4_0.returnItem(var_1_10008, var_1_10005, arg_4_0.bubblePool)

					table = var_6

					var_6.remove(arg_4_0.bubbles, iter_4_4)
				end
			end
		end

		::label_4_1::
	end

	for iter_4_5 = #arg_4_0.stoneDatas, 1, -1 do
		CastleGameVo = var_1_10005

		if var_1_10005.gameStepTime > arg_4_0.stoneDatas[iter_4_5].time then
			table = var_1_10005

			local var_4_12 = var_1_10005.remove(arg_4_0.stoneDatas, iter_4_5).indexs

			arg_4_0:appearStone(var_4_12)
		end
	end

	for iter_4_6 = #arg_4_0.stones, 1, -1 do
		if arg_4_0.stones[iter_4_6].ready then
			local var_4_13 = var_5.ready

			if 0 < var_4_13 then
				local var_4_14 = var_5.ready

				CastleGameVo = var_7
				var_5.ready = var_4_14 - var_7.deltaTime

				if var_5.ready <= 0 then
					var_5.ready = 0
					setActive = var_6

					var_6(var_5.tf, true)

					if arg_4_0.floorBrokenCallback then
						arg_4_0.floorBrokenCallback(var_5.useIndex, 0.5)
					end
				end

				goto label_4_2
			end
		end

		if var_5.brokenTime then
			local var_4_15 = var_5.brokenTime

			if 0 < var_4_15 then
				local var_4_16 = var_5.brokenTime

				CastleGameVo = var_7
				var_5.brokenTime = var_4_16 - var_7.deltaTime

				if var_5.brokenTime <= 0 then
					var_5.broken = true
					var_5.brokenTime = nil
					table = var_6

					var_6.remove(arg_4_0.stones, iter_4_6)

					setActive = var_6

					var_6(var_5.tf, false)

					var_1_10008 = arg_4_0

					arg_4_0.returnItem(var_1_10008, var_5, arg_4_0.stonePool)
				end
			end
		end

		::label_4_2::
	end

	for iter_4_7 = #arg_4_0.booms, 1, -1 do
		local var_4_17 = arg_4_0.booms[iter_4_7]
		local var_4_18 = arg_4_0.booms[iter_4_7].tf.anchoredPosition
		local var_4_19 = {}

		ipairs = var_1_10008

		local var_4_20 = var_4_17.bound.points

		for iter_4_8, iter_4_9 in var_1_10008(var_10.ToTable(var_4_20)) do
			findTF = var_1_10013
			var_1_10013 = var_1_10013(var_4_17.tf, "zPos/" .. iter_4_8 + 1)
			Vector2 = var_1_10014
			var_1_10013.anchoredPosition = var_1_10014(iter_4_9.x, iter_4_9.y)
			Vector2 = var_1_10013
			var_1_10013 = var_1_10013(var_4_18.x + iter_4_9.x, var_4_18.y + iter_4_9.y)
			table = var_1_10014

			var_1_10014.insert(var_4_19, var_1_10013)
		end

		var_4_17.boundPoints = var_4_19

		if var_4_17.ready then
			var_1_10008 = var_4_17.ready

			if 0 < var_1_10008 then
				var_1_10008 = var_4_17.ready
				CastleGameVo = var_9
				var_4_17.ready = var_1_10008 - var_9.deltaTime

				if var_4_17.ready <= 0 then
					var_4_17.ready = 0
					setActive = var_1_10008

					var_1_10008(var_4_17.tf, true)

					if arg_4_0.floorBrokenCallback then
						arg_4_0.floorBrokenCallback(var_4_17.useIndex, 0.5)
					end
				end

				goto label_4_3
			end
		end

		if var_4_17.brokenTime then
			var_1_10008 = var_4_17.brokenTime

			if 0 < var_1_10008 then
				var_1_10008 = var_4_17.brokenTime
				CastleGameVo = var_9
				var_4_17.brokenTime = var_1_10008 - var_9.deltaTime

				if var_4_17.brokenTime < 0 then
					var_4_17.broken = true
					var_4_17.brokenTime = 0
					setActive = var_1_10008

					var_1_10008(var_4_17.tf, false)

					table = var_1_10008
					var_1_10008 = var_1_10008.remove(arg_4_0.booms, iter_4_7)

					arg_4_0:returnItem(var_1_10008, arg_4_0.boomPool)
				end
			end
		end

		::label_4_3::
	end

	return
end

function var_0_0.appearStone(arg_6_0, arg_6_1)
	local var_6_0
	local var_6_1 = {}
	local var_6_2 = arg_6_0:getItemActiveIndex()

	for iter_6_0 = 1, #var_6_2 do
		table = var_1_10009

		if not var_1_10009.contains(arg_6_1, var_6_2[iter_6_0]) then
			table = var_1_10009

			var_1_10009.insert(var_6_1, var_6_2[iter_6_0])
		end
	end

	if #var_6_1 == 0 then
		return
	end

	local var_6_3 = #arg_6_0.stonePool

	if 0 < var_6_3 then
		table = var_6_3
		var_6_0 = var_6_3.remove(arg_6_0.stonePool, 1)
	else
		tf = var_6_3
		instantiate = var_7
		var_6_3 = var_6_3(var_7(arg_6_0._stoneTpl))
		setParent = var_6

		var_6(var_6_3, arg_6_0._content)

		GetComponent = var_6
		findTF = var_8

		local var_6_4 = var_8(var_6_3, "zPos/anim/collider")

		typeof = var_9
		BoxCollider2D = var_11

		local var_6_5 = var_6(var_6_4, var_9(var_11))

		var_6_0 = {
			tf = var_6_3,
			bound = var_6_5
		}
	end

	findTF = var_6_3

	local var_6_6 = var_6_3(var_6_0.tf, "zPos/anim/img").childCount

	math = var_7

	local var_6_7 = var_7.random(1, var_6_6) - 1

	for iter_6_1 = 0, var_6_6 - 1 do
		setActive = var_1_10012

		var_1_10012(var_5:GetChild(iter_6_1), iter_6_1 == var_6_7)
	end

	CastleGameVo = var_8
	var_6_0.ready = var_8.item_ready_time
	CastleGameVo = var_8
	var_6_0.brokenTime = var_8.stone_broken_time
	math = var_8

	local var_6_8 = var_6_1[var_8.random(1, #var_6_1)]

	CastleGameVo = var_9

	local var_6_9 = var_6_8 % var_9.w_count

	math = var_10

	local var_6_10 = var_10.floor

	CastleGameVo = var_1_10012

	local var_6_11 = var_6_10(var_6_8 / var_1_10012.w_count)
	local var_6_12 = var_6_0.tf

	CastleGameVo = var_12
	var_6_12.anchoredPosition = var_12.GetRotationPosByWH(var_6_9, var_6_11)
	setActive = var_6_12

	var_6_12(var_6_0.tf, false)

	var_6_0.index = var_6_8
	var_6_0.useIndex = {
		var_6_8
	}

	local var_6_13

	if arg_6_0.itemRemindCallback then
		var_6_13 = arg_6_0.itemRemindCallback

		local var_6_14 = {}
		local var_6_15 = {
			w = var_6_9,
			h = var_6_11
		}

		CastleGameRemind = var_15
		var_6_15.type = var_15.remind_type_1
		var_6_14[1] = var_6_15

		var_6_13(var_6_14)
	end

	table = var_6_13

	var_6_13.insert(arg_6_0.stones, var_6_0)

	return
end

function var_0_0.returnItem(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.itemChangeCallback then
		arg_7_0.itemChangeCallback(arg_7_1, false)
	end

	table = var_3

	var_3.insert(arg_7_2, arg_7_1)

	return
end

function var_0_0.appearBubble(arg_8_0, arg_8_1)
	for iter_8_0 = 1, arg_8_1 do
		local var_8_0

		if #arg_8_0:getItemActiveIndex() == 0 then
			return
		end

		local var_8_1 = #arg_8_0.bubblePool
		local var_8_2

		if 0 < var_8_1 then
			table = var_8_1
			var_8_0 = var_8_1.remove(arg_8_0.bubblePool, 1)
		else
			tf = var_8_1
			instantiate = var_1_10010
			var_8_1 = var_8_1(var_1_10010(arg_8_0._bubbleTpl))
			findTF = var_8_2
			var_8_2 = var_8_2(var_8_1, "zPos/pos")
			GetComponent = var_1_10010
			findTF = var_1_10012
			var_1_10012 = var_1_10012(var_8_1, "zPos/spine1")
			typeof = var_1_10013
			SpineAnimUI = var_15
			var_1_10010 = var_1_10010(var_1_10012, var_1_10013(var_15))
			GetComponent = var_11
			findTF = var_1_10013
			var_1_10013 = var_1_10013(var_8_1, "zPos/spine2")
			typeof = var_14
			SpineAnimUI = var_16

			local var_8_3 = var_11(var_1_10013, var_14(var_16))

			GetComponent = var_1_10012
			findTF = var_14

			local var_8_4 = var_14(var_8_1, "zPos/collider")

			typeof = var_15
			BoxCollider2D = var_17
			var_1_10012 = var_1_10012(var_8_4, var_15(var_17))

			local var_8_5 = var_8_1

			var_1_10013 = var_8_1.InverseTransformPoint(var_8_5, var_1_10012.bounds.min)

			local var_8_6 = var_8_1:InverseTransformPoint(var_1_10012.bounds.max)

			setParent = var_8_5

			var_8_5(var_8_1, arg_8_0._content)

			var_8_0 = {
				tf = var_8_1,
				anims = {
					var_1_10010,
					var_8_3
				},
				bound = var_1_10012,
				pos = var_8_2,
				bmin = var_1_10013,
				bmax = var_8_6
			}
		end

		math = var_8_1

		local var_8_7 = var_7[var_8_1.random(1, #var_7)]

		CastleGameVo = var_8_2

		local var_8_8 = var_8_7 % var_8_2.w_count

		math = var_1_10010
		var_1_10010 = var_1_10010.floor
		CastleGameVo = var_1_10012
		var_1_10010 = var_1_10010(var_8_7 / var_1_10012.w_count)
		CastleGameVo = var_11
		var_8_0.start = var_11.GetRotationPosByWH(var_8_8, var_1_10010)
		var_8_0.start.y = var_8_0.start.y + var_0_5

		local var_8_9 = var_8_0.tf

		var_8_9.anchoredPosition = var_8_0.start
		setActive = var_8_9

		var_8_9(var_8_0.tf, false)

		CastleGameVo = var_8_9
		var_8_0.ready = var_8_9.bubble_ready_time
		var_8_0.broken = false
		CastleGameVo = var_11
		var_8_0.brokenTime = var_11.bubble_broken_time
		var_8_0.useIndex = {
			var_8_7
		}
		var_8_0.index = var_8_7

		if arg_8_0.itemChangeCallback then
			arg_8_0.itemChangeCallback(var_8_0, true)
		end

		setActive = var_11

		var_11(var_8_0.tf, false)

		table = var_11

		var_11.insert(arg_8_0.bubbles, var_8_0)

		var_1_10013 = arg_8_0

		arg_8_0.changeAnimAction(var_1_10013, var_8_0.anims, var_0_8, -1)
	end

	return
end

function var_0_0.appearBoom(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = arg_9_0:getItemActiveIndex()

	for iter_9_0 = 1, #var_9_1 do
		var_1_10007 = var_9_1[iter_9_0]
		CastleGameVo = var_1_10008
		var_1_10008 = var_1_10007 % var_1_10008.w_count
		CastleGameVo = var_1_10009

		if var_1_10008 ~= var_1_10009.w_count - 1 then
			var_1_10008 = var_1_10007 + 1
			CastleGameVo = var_1_10009
			var_1_10009 = var_1_10007 + var_1_10009.w_count

			local var_9_2 = var_1_10007 + 1

			CastleGameVo = var_1_10011

			local var_9_3 = var_9_2 + var_1_10011.w_count

			table = var_1_10011

			if var_1_10011.contains(var_9_1, var_1_10008) then
				table = var_1_10011

				if var_1_10011.contains(var_9_1, var_1_10009) then
					table = var_1_10011

					if var_1_10011.contains(var_9_1, var_9_3) then
						table = var_1_10011

						var_1_10011.insert(var_9_0, var_1_10007)
					end
				end
			end
		end
	end

	math = var_3

	local var_9_4 = var_9_0[var_3.random(1, #var_9_0)]

	if #var_9_0 == 0 then
		return
	end

	local var_9_5
	local var_9_6 = #arg_9_0.boomPool
	local var_9_7

	if 0 < var_9_6 then
		table = var_9_6
		var_9_5 = var_9_6.remove(arg_9_0.boomPool, 1)
	else
		tf = var_9_6
		instantiate = var_1_10007
		var_9_6 = var_9_6(var_1_10007(arg_9_0._boomTpl))
		GetComponent = var_9_7
		findTF = var_1_10008
		var_1_10008 = var_1_10008(var_9_6, "zPos/collider")
		typeof = var_9
		var_9_7 = var_9_7(var_1_10008, var_9("UnityEngine.PolygonCollider2D"))
		setParent = var_1_10007

		var_1_10007(var_9_6, arg_9_0._content)

		var_9_5 = {
			tf = var_9_6,
			bound = var_9_7
		}
	end

	CastleGameVo = var_9_6

	local var_9_8 = var_9_4 % var_9_6.w_count

	math = var_9_7

	local var_9_9 = var_9_7.floor

	CastleGameVo = var_1_10008

	local var_9_10 = var_9_9(var_9_4 / var_1_10008.w_count)

	CastleGameVo = var_1_10007
	var_7.x = var_1_10007.GetRotationPosByWH(var_9_8, var_9_10).x + var_0_9
	var_7.y = var_7.y + var_0_10

	local var_9_11 = var_9_5.tf

	var_9_11.anchoredPosition = var_7
	CastleGameVo = var_9_11
	var_9_5.ready = var_9_11.item_ready_time
	var_9_5.broken = false
	setActive = var_8

	var_8(var_9_5.tf, false)

	var_9_5.index = var_9_4

	local var_9_12 = {
		var_9_4,
		var_9_4 + 1
	}

	CastleGameVo = var_9
	var_9_12[3] = var_9_4 + var_9.w_count
	CastleGameVo = var_9
	var_9_12[4] = var_9_4 + var_9.w_count + 1
	var_9_5.useIndex = var_9_12
	var_9_5.brokenTime = 1.5

	if arg_9_0.itemChangeCallback then
		arg_9_0.itemChangeCallback(var_9_5, true)
	end

	local var_9_13

	if arg_9_0.itemRemindCallback then
		var_9_13 = arg_9_0.itemRemindCallback

		local var_9_14 = {}
		local var_9_15 = {
			w = var_9_8,
			h = var_9_10
		}

		CastleGameRemind = var_1_10012
		var_9_15.type = var_1_10012.remind_type_2
		var_9_14[1] = var_9_15

		var_9_13(var_9_14)
	end

	table = var_9_13

	var_9_13.insert(arg_9_0.booms, var_9_5)

	return
end

function var_0_0.setFloorBroken(arg_10_0, arg_10_1)
	arg_10_0.floorBrokenCallback = arg_10_1

	return
end

function var_0_0.setBubbleBroken(arg_11_0, arg_11_1)
	arg_11_0.bubbleBrokenCallback = arg_11_1

	return
end

function var_0_0.setItemChange(arg_12_0, arg_12_1)
	arg_12_0.itemChangeCallback = arg_12_1

	return
end

function var_0_0.setFloorIndexs(arg_13_0, arg_13_1)
	arg_13_0.floorIndexs = arg_13_1

	return
end

function var_0_0.getItemActiveIndex(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = {}

	for iter_14_0 = 1, #arg_14_0.bubbles do
		ipairs = var_1_10007

		for iter_14_1, iter_14_2 in var_1_10007(arg_14_0.bubbles[iter_14_0].useIndex) do
			table = var_1_10012

			var_1_10012.insert(var_14_1, iter_14_2)
		end
	end

	for iter_14_3 = 1, #arg_14_0.booms do
		ipairs = var_1_10007

		for iter_14_4, iter_14_5 in var_1_10007(arg_14_0.booms[iter_14_3].useIndex) do
			table = var_1_10012

			var_1_10012.insert(var_14_1, iter_14_5)
		end
	end

	for iter_14_6 = 1, #arg_14_0.stones do
		ipairs = var_1_10007

		for iter_14_7, iter_14_8 in var_1_10007(arg_14_0.stones[iter_14_6].useIndex) do
			table = var_1_10012

			var_1_10012.insert(var_14_1, iter_14_8)
		end
	end

	for iter_14_9 = 1, #arg_14_0.floorIndexs do
		local var_14_2 = arg_14_0.floorIndexs[iter_14_9]

		table = var_1_10008

		if not var_1_10008.contains(var_14_1, var_14_2) then
			table = var_1_10008

			var_1_10008.insert(var_14_0, var_14_2)
		end
	end

	return var_14_0
end

function var_0_0.appearCarriage(arg_15_0)
	local var_15_0
	local var_15_1 = #arg_15_0.carriagePool

	if 0 < var_15_1 then
		table = var_15_1
		var_15_0 = var_15_1.remove(arg_15_0.carriagePool, 1)
	else
		tf = var_15_1
		instantiate = var_1_10004

		local var_15_2 = var_15_1(var_1_10004(arg_15_0._carriageTpl))

		GetComponent = var_3
		findTF = var_1_10005

		local var_15_3 = var_1_10005(var_15_2, "zPos/spine")

		typeof = var_6
		SpineAnimUI = var_8

		local var_15_4 = var_3(var_15_3, var_6(var_8))

		GetComponent = var_4
		findTF = var_6

		local var_15_5 = var_6(var_15_2, "zPos/collider")

		typeof = var_7
		BoxCollider2D = var_1_10009

		local var_15_6 = var_4(var_15_5, var_7(var_1_10009))
		local var_15_7 = var_15_2
		local var_15_8 = var_15_2.InverseTransformPoint(var_15_7, var_15_6.bounds.min)
		local var_15_9 = var_15_2:InverseTransformPoint(var_15_6.bounds.max)

		setParent = var_15_7

		var_15_7(var_15_2, arg_15_0._content)

		var_15_0 = {
			tf = var_15_2,
			bound = var_15_6,
			anims = {
				var_15_4
			},
			bmin = var_15_8,
			bmax = var_15_9
		}
	end

	if #arg_15_0:getCarriageRoadlist() > 0 then
		math = var_3

		local var_15_10 = var_2[var_3.random(1, #var_2)].w
		local var_15_11 = var_3.h
		local var_15_12 = var_3.target_w
		local var_15_13 = var_3.target_h
		local var_15_14 = var_3.scale

		var_15_0.w = var_15_10
		var_15_0.h = var_15_11
		var_15_0.target_w = var_15_12
		var_15_0.target_h = var_15_13
		findTF = var_1_10009

		local var_15_15 = var_1_10009(var_15_0.tf, "zPos")

		var_15_15.localScale = var_15_14
		CastleGameVo = var_15_15
		var_15_0.start = var_15_15.GetRotationPosByWH(var_15_0.w, var_15_0.h)

		local var_15_16 = var_15_0.start

		var_15_16.y = var_15_0.start.y + var_0_1
		CastleGameVo = var_15_16
		var_15_0.target = var_15_16.GetRotationPosByWH(var_15_0.target_w, var_15_0.target_h)
		var_15_0.target.y = var_15_0.target.y + var_0_1

		local var_15_17 = var_15_0.tf

		var_15_17.anchoredPosition = var_15_0.start
		CastleGameVo = var_15_17
		var_15_0.ready = var_15_17.item_ready_time
		setActive = var_9

		var_9(var_15_0.tf, false)

		setActive = var_9

		var_9(var_15_0.tf, true)

		local var_15_18, var_15_19 = arg_15_0:countSpeed(var_15_0.start, var_15_0.target)

		var_15_0.speed = var_15_18
		var_15_0.direct = var_15_19

		if arg_15_0.itemChangeCallback then
			arg_15_0.itemChangeCallback(var_15_0, true)
		end

		table = var_11

		var_11.insert(arg_15_0.carriages, var_15_0)
	else
		print = var_3

		var_3("当前不存在可以出现马车的位置")
	end

	return
end

function var_0_0.getCarriageRoadlist(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = 0

	CastleGameVo = var_1_10003

	for iter_16_0 = var_16_1, var_1_10003.w_count - 1 do
		local var_16_2 = true
		local var_16_3 = 0

		CastleGameVo = var_1_10008

		for iter_16_1 = var_16_3, var_1_10008.h_count - 1 do
			CastleGameVo = var_1_10011
			var_1_10011 = iter_16_0 + iter_16_1 * var_1_10011.w_count

			if var_16_2 then
				table = var_1_10012

				if not var_1_10012.contains(arg_16_0.floorIndexs, var_1_10011) then
					var_16_2 = false
				end
			end
		end

		if var_16_2 then
			table = var_16_3

			local var_16_4 = var_16_3.insert
			local var_16_5 = var_16_0
			local var_16_6 = {
				h = -1,
				w = iter_16_0,
				target_w = iter_16_0
			}

			CastleGameVo = var_1_10011
			var_16_6.target_h = var_1_10011.h_count
			Vector3 = var_1_10011
			var_16_6.scale = var_1_10011(-1, 1, 1)

			var_16_4(var_16_5, var_16_6)
		end
	end

	local var_16_7 = 0

	CastleGameVo = var_3

	for iter_16_2 = var_16_7, var_3.h_count - 1 do
		local var_16_8 = true
		local var_16_9 = 0

		CastleGameVo = var_1_10008

		for iter_16_3 = var_16_9, var_1_10008.w_count - 1 do
			CastleGameVo = var_1_10011
			var_1_10011 = iter_16_3 + iter_16_2 * var_1_10011.w_count

			if var_16_8 then
				table = var_1_10012

				if not var_1_10012.contains(arg_16_0.floorIndexs, var_1_10011) then
					var_16_8 = false
				end
			end
		end

		if var_16_8 then
			table = var_16_9

			local var_16_10 = var_16_9.insert
			local var_16_11 = var_16_0
			local var_16_12 = {
				w = -1,
				h = iter_16_2
			}

			CastleGameVo = var_1_10011
			var_16_12.target_w = var_1_10011.w_count
			var_16_12.target_h = iter_16_2
			Vector3 = var_1_10011
			var_16_12.scale = var_1_10011(1, 1, 1)

			var_16_10(var_16_11, var_16_12)
		end
	end

	return var_16_0
end

function var_0_0.setItemRemindCallback(arg_17_0, arg_17_1)
	arg_17_0.itemRemindCallback = arg_17_1

	return
end

function var_0_0.countSpeed(arg_18_0, arg_18_1, arg_18_2)
	math = var_1_10003

	local var_18_0 = var_1_10003.atan

	math = var_1_10005

	local var_18_1 = var_1_10005.abs(arg_18_2.y - arg_18_1.y)

	math = var_1_10006

	local var_18_2 = var_18_0(var_18_1 / var_1_10006.abs(arg_18_2.x - arg_18_1.x))
	local var_18_3 = arg_18_2.x > arg_18_1.x and 1 or -1
	local var_18_4 = arg_18_2.y
	local var_18_5 = arg_18_1.y < var_18_4 and 1 or -1

	math = var_6

	local var_18_6 = var_6.cos(var_18_2) * var_18_3

	math = var_7

	local var_18_7 = var_7.sin(var_18_2) * var_18_5

	Vector2 = var_8

	local var_18_8 = var_8(var_18_6, var_18_7)

	Vector2 = var_9

	local var_18_9 = var_9(var_18_3, var_18_5)
end

function var_0_0.changeAnimAction(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	local var_19_0 = 0

	for iter_19_0 = 1, #arg_19_1 do
		local var_19_1 = arg_19_1[iter_19_0]

		var_11.SetActionCallBack(var_19_1, nil)
		var_11:SetAction(arg_19_2, 0)
		var_11:SetActionCallBack(function(arg_20_0)
			if arg_20_0 == "finish" then
				if arg_19_3 == 1 then
					local var_20_0 = var_0

					var_1.SetActionCallBack(var_20_0, nil)

					local var_20_1 = var_0

					var_1.SetAction(var_20_1, arg_19_4, 0)
				end

				if arg_19_5 and var_19_0 == 0 then
					var_19_0 = 1

					arg_19_5()
				end
			end

			return
		end)

		if arg_19_3 ~= 1 and arg_19_5 and var_19_0 == 0 then
			var_19_0 = 1

			arg_19_5()
		end
	end

	return
end

function var_0_0.playerInBubble(arg_21_0, arg_21_1, arg_21_2)
	arg_21_1.char = arg_21_2

	return
end

function var_0_0.getBooms(arg_22_0)
	return arg_22_0.booms
end

function var_0_0.getBubbles(arg_23_0)
	return arg_23_0.bubbles
end

function var_0_0.getCarriages(arg_24_0)
	return arg_24_0.carriages
end

function var_0_0.clear(arg_25_0)
	return
end

return var_0_0
