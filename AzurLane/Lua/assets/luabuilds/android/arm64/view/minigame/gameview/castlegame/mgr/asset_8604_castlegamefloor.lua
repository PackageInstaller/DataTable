class = var_0_10000

local var_0_0 = var_0_10000("CastleGameFloor")
local var_0_1 = 999999

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tpl = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0.floors = {}
	arg_1_0.colliders = {}
	arg_1_0.floorTfs = {}
	arg_1_0.bounds = {}
	CastleGameVo = var_3

	local var_1_0 = var_3.h_count

	CastleGameVo = var_1_10004

	local var_1_1 = var_1_0 * var_1_10004.w_count

	for iter_1_0 = 0, var_1_1 - 1 do
		tf = var_1_10008
		instantiate = var_1_10010
		var_1_10008 = var_1_10008(var_1_10010(arg_1_0._tpl))
		tostring = var_1_10009
		var_1_10008.name = var_1_10009(iter_1_0 + 1)
		setActive = var_1_10009

		var_1_10009(var_1_10008, true)

		findTF = var_1_10009
		var_1_10009 = var_1_10009(var_1_10008, "zPos")
		findTF = var_1_10010
		var_1_10010 = var_1_10010(var_1_10008, "zPos/floor/img")
		setImageSprite = var_11

		local var_1_2 = var_1_10010

		CastleGameVo = var_1_10014

		var_11(var_1_2, var_1_10014.getFloorImage(iter_1_0 + 1), true)

		local var_1_3 = var_1_10008.anchoredPosition

		findTF = var_12

		local var_1_4

		var_1_4, GetComponent = var_12(var_1_10008, "zPos/collider"), var_1_2
		typeof = var_16

		local var_1_5 = var_1_2(var_1_4, var_16("UnityEngine.PolygonCollider2D"))

		GetComponent = var_1_10014
		findTF = var_16

		local var_1_6 = var_16(var_1_10008, "zPos/floor")

		typeof = var_1_10017
		Animator = var_19
		var_1_10014 = var_1_10014(var_1_6, var_1_10017(var_19))
		CastleGameVo = var_1_4

		local var_1_7 = iter_1_0 % var_1_4.h_count

		math = var_1_6

		local var_1_8 = var_1_6.floor

		CastleGameVo = var_18

		local var_1_9 = var_1_8(iter_1_0 / var_18.w_count)

		table = var_1_10017

		var_1_10017.insert(arg_1_0.colliders, var_1_5)

		table = var_1_10017

		var_1_10017.insert(arg_1_0.floorTfs, var_1_10008)

		table = var_1_10017

		var_1_10017.insert(arg_1_0.floors, {
			fall = false,
			tf = var_1_10008,
			zPos = var_1_10009,
			anim = var_1_10014,
			index = iter_1_0,
			collider = var_1_5,
			w = var_1_7,
			h = var_1_9
		})
	end

	arg_1_0:updateFloorPos()
	arg_1_0:updateBounds()

	return
end

function var_0_0.getTfs(arg_2_0)
	return arg_2_0.floorTfs
end

function var_0_0.getFloors(arg_3_0)
	return arg_3_0.floors
end

function var_0_0.getActiveIndexs(arg_4_0)
	return arg_4_0.activeIndexs
end

function var_0_0.updateBounds(arg_5_0)
	for iter_5_0 = 1, #arg_5_0.floors do
		local var_5_0 = arg_5_0.floors[iter_5_0].collider
		local var_5_1 = arg_5_0.floors[iter_5_0].tf.anchoredPosition
		local var_5_2 = {}

		ipairs = var_1_10008

		local var_5_3 = var_5_0.points

		for iter_5_1, iter_5_2 in var_1_10008(var_10.ToTable(var_5_3)) do
			Vector2 = var_1_10013
			var_1_10013 = var_1_10013(var_5_1.x + iter_5_2.x, var_5_1.y + iter_5_2.y)
			table = var_1_10014

			var_1_10014.insert(var_5_2, var_1_10013)
		end

		var_1_10008 = arg_5_0.floors[iter_5_0]
		var_1_10008.bound = var_5_2
		table = var_1_10008

		var_1_10008.insert(arg_5_0.bounds, var_5_2)
	end

	return
end

function var_0_0.getBounds(arg_6_0)
	return arg_6_0.bounds
end

function var_0_0.setContent(arg_7_0, arg_7_1)
	if not arg_7_1 then
		print = var_1_10002

		var_1_10002("地板的容器不能为nil")

		return
	end

	arg_7_0._content = arg_7_1

	for iter_7_0 = 1, #arg_7_0.floorTfs do
		SetParent = var_1_10006

		var_1_10006(arg_7_0.floorTfs[iter_7_0], arg_7_1)
	end

	return
end

function var_0_0.start(arg_8_0)
	arg_8_0.fallDatas = arg_8_0:getFallDatas()
	arg_8_0.floorFallStep = var_0_1
	arg_8_0.activeIndexs = {}

	for iter_8_0 = 1, #arg_8_0.floors do
		arg_8_0.floors[iter_8_0].fall = false
		arg_8_0.floors[iter_8_0].removeTime = nil

		local var_8_0 = arg_8_0.floors[iter_8_0]

		var_8_0.revertTime = nil
		setActive = var_8_0

		var_8_0(arg_8_0.floors[iter_8_0].tf, false)

		setActive = var_8_0

		var_8_0(arg_8_0.floors[iter_8_0].tf, true)

		table = var_8_0

		var_8_0.insert(arg_8_0.activeIndexs, arg_8_0.floors[iter_8_0].index)
	end

	arg_8_0:updateFloorPos()

	return
end

function var_0_0.step(arg_9_0)
	if arg_9_0.floorFallStep then
		local var_9_0 = arg_9_0.floorFallStep

		if 0 < var_9_0 then
			local var_9_1 = arg_9_0.floorFallStep

			CastleGameVo = var_2
			arg_9_0.floorFallStep = var_9_1 - var_2.deltaTime

			if arg_9_0.floorFallStep <= 0 then
				-- block empty
			end
		end
	end

	for iter_9_0 = #arg_9_0.floors, 1, -1 do
		if arg_9_0.floors[iter_9_0].removeTime then
			local var_9_2 = var_1_10005.removeTime

			if 0 < var_9_2 then
				local var_9_3 = var_1_10005.removeTime

				CastleGameVo = var_7
				var_1_10005.removeTime = var_9_3 - var_7.deltaTime

				if var_1_10005.removeTime <= 0 then
					var_1_10005.removeTime = nil

					arg_9_0:applyFloorFall(var_1_10005)
				end
			end
		end
	end

	for iter_9_1 = #arg_9_0.floors, 1, -1 do
		if arg_9_0.floors[iter_9_1].revertTime then
			local var_9_4 = var_1_10005.revertTime

			if 0 < var_9_4 then
				local var_9_5 = var_1_10005.revertTime

				CastleGameVo = var_7
				var_1_10005.revertTime = var_9_5 - var_7.deltaTime

				if var_1_10005.revertTime <= 0 then
					var_1_10005.revertTime = nil

					arg_9_0:revertFloorFall(var_1_10005)
					arg_9_0:revertActiveFloor(var_1_10005)
				end
			end
		end
	end

	for iter_9_2 = #arg_9_0.fallDatas, 1, -1 do
		CastleGameVo = var_1_10005

		if var_1_10005.gameStepTime >= arg_9_0.fallDatas[iter_9_2].time then
			table = var_1_10005
			var_1_10005 = var_1_10005.remove(arg_9_0.fallDatas, iter_9_2)

			arg_9_0:removeFloorByFallData(var_1_10005)

			break
		end
	end

	return
end

function var_0_0.setBroken(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getFloorByIndex(arg_10_1)

	arg_10_0:setFloorFallTime(var_10_0, false, arg_10_2)

	return
end

function var_0_0.removeFloorByFallData(arg_11_0, arg_11_1)
	table = var_1_10002

	local var_11_0 = var_1_10002.remove
	local var_11_1 = arg_11_1.rule_id

	math = var_1_10005

	local var_11_2 = var_11_0(var_11_1, var_1_10005.random(1, #arg_11_1.rule_id))

	CastleGameVo = var_1_10003

	local var_11_3 = var_1_10003.floor_rule[var_11_2]

	for iter_11_0 = 1, #var_11_3 do
		local var_11_4 = arg_11_0:getFloorByIndex(var_11_3[iter_11_0])

		arg_11_0:setFloorFallTime(var_11_4, true, nil)
	end

	return
end

function var_0_0.clear(arg_12_0)
	return
end

function var_0_0.setFloorFallCallback(arg_13_0, arg_13_1)
	arg_13_0.floorFallCallback = arg_13_1

	return
end

function var_0_0.getFallDatas(arg_14_0)
	CastleGameVo = var_1_10001

	return var_1_10001.roundData.floors
end

function var_0_0.applyFloorFall(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.zPos
	local var_15_1 = arg_15_1.anim

	arg_15_1.fall = true
	CastleGameVo = var_4
	arg_15_1.revertTime = var_4.floor_revert_time

	var_15_1:Play("hide")

	return
end

function var_0_0.revertFloorFall(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.anim

	arg_16_1.fall = false

	var_16_0:Play("revert")

	return
end

function var_0_0.revertActiveFloor(arg_17_0, arg_17_1)
	table = var_1_10002

	if not var_1_10002.contains(arg_17_0.activeIndexs, arg_17_1.index) then
		table = var_2

		var_2.insert(arg_17_0.activeIndexs, arg_17_1.index)
	end

	return
end

function var_0_0.removeActiveFloor(arg_18_0, arg_18_1)
	for iter_18_0 = #arg_18_0.activeIndexs, 1, -1 do
		if arg_18_0.activeIndexs[iter_18_0] == arg_18_1.index then
			table = var_6

			var_6.remove(arg_18_0.activeIndexs, iter_18_0)
		end
	end

	return
end

function var_0_0.setFloorFallTime(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	for iter_19_0 = 1, #arg_19_1 do
		if arg_19_2 then
			local var_19_0 = arg_19_1[iter_19_0].anim

			var_8.Play(var_19_0, "shake")
		end

		local var_19_1

		if not arg_19_1[iter_19_0].fall then
			var_19_1 = arg_19_1[iter_19_0]

			if not arg_19_3 or not arg_19_3 then
				::label_19_0::

				CastleGameVo = var_1_10009
				var_1_10009 = var_1_10009.floor_remove_time
			end

			var_19_1.removeTime = var_1_10009
			var_19_1 = arg_19_1[iter_19_0]
			var_19_1.revertTime = nil

			arg_19_0:removeActiveFloor(arg_19_1[iter_19_0])
		else
			print = var_19_1

			var_19_1(arg_19_1[iter_19_0].index .. "已经被移除，无法设置掉落")
		end
	end

	return
end

function var_0_0.getFloorByIndex(arg_20_0, arg_20_1, arg_20_2)
	for iter_20_0 = 1, #arg_20_0.floors do
		if arg_20_0.floors[iter_20_0].index == arg_20_1 then
			return {
				arg_20_0.floors[iter_20_0]
			}
		end
	end

	print = var_3

	var_3("找不到index = " .. arg_20_1 .. "的地板")

	return {}
end

function var_0_0.updateFloorPos(arg_21_0)
	for iter_21_0 = 1, #arg_21_0.floors do
		local var_21_0 = arg_21_0.floors[iter_21_0].index

		CastleGameVo = var_1_10006
		var_1_10006 = var_21_0 % var_1_10006.w_count
		math = var_1_10007
		var_1_10007 = var_1_10007.floor
		CastleGameVo = var_1_10009
		var_1_10007 = var_1_10007(var_21_0 / var_1_10009.h_count)

		local var_21_1 = arg_21_0.floors[iter_21_0].tf

		CastleGameVo = var_1_10009
		var_21_1.anchoredPosition = var_1_10009.GetRotationPosByWH(var_1_10006, var_1_10007)
	end

	return
end

function var_0_0.getOutLandPoint(arg_22_0)
	local var_22_0 = arg_22_0.floors[1].bound[1]
	local var_22_1 = arg_22_0.floors

	CastleGameVo = var_1_10003

	local var_22_2 = var_1_10003.h_count - 1

	CastleGameVo = var_1_10004

	local var_22_3 = var_22_1[var_22_2 * var_1_10004.w_count + 1].bound[2]
	local var_22_4 = arg_22_0.floors

	CastleGameVo = var_4

	local var_22_5 = var_22_4[var_4.w_count].bound[4]
	local var_22_6 = arg_22_0.floors

	CastleGameVo = var_1_10005

	local var_22_7 = var_1_10005.h_count

	CastleGameVo = var_1_10006

	local var_22_8 = var_22_6[var_22_7 * var_1_10006.w_count].bound[3]

	return {
		lb = var_22_0,
		lt = var_22_3,
		rt = var_22_8,
		rb = var_22_5
	}
end

function var_0_0.press(arg_23_0, arg_23_1)
	return
end

return var_0_0
