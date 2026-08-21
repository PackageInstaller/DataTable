local var_0_0 = class("CastleGameFloor")
local var_0_1 = 999999

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tpl = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0.floors = {}
	arg_1_0.colliders = {}
	arg_1_0.floorTfs = {}
	arg_1_0.bounds = {}

	for iter_1_0 = 0, CastleGameVo.h_count * CastleGameVo.w_count - 1 do
		local var_1_0 = tf(instantiate(arg_1_0._tpl))

		var_1_0.name = tostring(iter_1_0 + 1)

		setActive(var_1_0, true)

		local var_1_1 = findTF(var_1_0, "zPos")

		setImageSprite(findTF(var_1_0, "zPos/floor/img"), CastleGameVo.getFloorImage(iter_1_0 + 1), true)

		local var_1_3 = GetComponent(findTF(var_1_0, "zPos/collider"), typeof("UnityEngine.PolygonCollider2D"))
		local var_1_4 = GetComponent(findTF(var_1_0, "zPos/floor"), typeof(Animator))
		local var_1_5 = math.floor(iter_1_0 / CastleGameVo.w_count)

		table.insert(arg_1_0.colliders, var_1_3)
		table.insert(arg_1_0.floorTfs, var_1_0)
		table.insert(arg_1_0.floors, {
			fall = false,
			tf = var_1_0,
			zPos = var_1_1,
			anim = var_1_4,
			index = iter_1_0,
			collider = var_1_3,
			w = iter_1_0 % CastleGameVo.h_count,
			h = var_1_5
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
		for iter_5_1, iter_5_2 in ipairs(arg_5_0.floors[iter_5_0].collider.points:ToTable()) do
			table.insert({}, (Vector2(arg_5_0.floors[iter_5_0].tf.anchoredPosition.x + iter_5_2.x, arg_5_0.floors[iter_5_0].tf.anchoredPosition.y + iter_5_2.y)))
		end

		arg_5_0.floors[iter_5_0].bound = {}

		table.insert(arg_5_0.bounds, {})
	end

	return
end

function var_0_0.getBounds(arg_6_0)
	return arg_6_0.bounds
end

function var_0_0.setContent(arg_7_0, arg_7_1)
	if not arg_7_1 then
		print("地板的容器不能为nil")

		return
	end

	arg_7_0._content = arg_7_1

	for iter_7_0 = 1, #arg_7_0.floorTfs do
		SetParent(arg_7_0.floorTfs[iter_7_0], arg_7_1)
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
		arg_8_0.floors[iter_8_0].revertTime = nil

		setActive(arg_8_0.floors[iter_8_0].tf, false)
		setActive(arg_8_0.floors[iter_8_0].tf, true)
		table.insert(arg_8_0.activeIndexs, arg_8_0.floors[iter_8_0].index)
	end

	arg_8_0:updateFloorPos()

	return
end

function var_0_0.step(arg_9_0)
	if arg_9_0.floorFallStep and arg_9_0.floorFallStep > 0 then
		arg_9_0.floorFallStep = arg_9_0.floorFallStep - CastleGameVo.deltaTime

		if arg_9_0.floorFallStep <= 0 then
			-- block empty
		end
	end

	for iter_9_0 = #arg_9_0.floors, 1, -1 do
		if arg_9_0.floors[iter_9_0].removeTime and arg_9_0.floors[iter_9_0].removeTime > 0 then
			arg_9_0.floors[iter_9_0].removeTime = arg_9_0.floors[iter_9_0].removeTime - CastleGameVo.deltaTime

			if arg_9_0.floors[iter_9_0].removeTime <= 0 then
				arg_9_0.floors[iter_9_0].removeTime = nil

				arg_9_0:applyFloorFall(arg_9_0.floors[iter_9_0])
			end
		end
	end

	for iter_9_1 = #arg_9_0.floors, 1, -1 do
		if arg_9_0.floors[iter_9_1].revertTime and arg_9_0.floors[iter_9_1].revertTime > 0 then
			arg_9_0.floors[iter_9_1].revertTime = arg_9_0.floors[iter_9_1].revertTime - CastleGameVo.deltaTime

			if arg_9_0.floors[iter_9_1].revertTime <= 0 then
				arg_9_0.floors[iter_9_1].revertTime = nil

				arg_9_0:revertFloorFall(arg_9_0.floors[iter_9_1])
				arg_9_0:revertActiveFloor(arg_9_0.floors[iter_9_1])
			end
		end
	end

	for iter_9_2 = #arg_9_0.fallDatas, 1, -1 do
		if CastleGameVo.gameStepTime >= arg_9_0.fallDatas[iter_9_2].time then
			arg_9_0:removeFloorByFallData((table.remove(arg_9_0.fallDatas, iter_9_2)))

			break
		end
	end

	return
end

function var_0_0.setBroken(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:setFloorFallTime(arg_10_0:getFloorByIndex(arg_10_1), false, arg_10_2)

	return
end

function var_0_0.removeFloorByFallData(arg_11_0, arg_11_1)
	local var_11_0 = CastleGameVo.floor_rule[table.remove(arg_11_1.rule_id, math.random(1, #arg_11_1.rule_id))]

	for iter_11_0 = 1, #var_11_0 do
		arg_11_0:setFloorFallTime(arg_11_0:getFloorByIndex(var_11_0[iter_11_0]), true, nil)
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
	return CastleGameVo.roundData.floors
end

function var_0_0.applyFloorFall(arg_15_0, arg_15_1)
	arg_15_1.fall = true
	arg_15_1.revertTime = CastleGameVo.floor_revert_time

	arg_15_1.anim:Play("hide")

	return
end

function var_0_0.revertFloorFall(arg_16_0, arg_16_1)
	arg_16_1.fall = false

	arg_16_1.anim:Play("revert")

	return
end

function var_0_0.revertActiveFloor(arg_17_0, arg_17_1)
	if not table.contains(arg_17_0.activeIndexs, arg_17_1.index) then
		table.insert(arg_17_0.activeIndexs, arg_17_1.index)
	end

	return
end

function var_0_0.removeActiveFloor(arg_18_0, arg_18_1)
	for iter_18_0 = #arg_18_0.activeIndexs, 1, -1 do
		if arg_18_0.activeIndexs[iter_18_0] == arg_18_1.index then
			table.remove(arg_18_0.activeIndexs, iter_18_0)
		end
	end

	return
end

function var_0_0.setFloorFallTime(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	for iter_19_0 = 1, #arg_19_1 do
		if arg_19_2 then
			arg_19_1[iter_19_0].anim:Play("shake")
		end

		if not arg_19_1[iter_19_0].fall then
			arg_19_1[iter_19_0].removeTime = arg_19_3 and arg_19_3 or CastleGameVo.floor_remove_time
			arg_19_1[iter_19_0].revertTime = nil

			arg_19_0:removeActiveFloor(arg_19_1[iter_19_0])
		else
			print(arg_19_1[iter_19_0].index .. "已经被移除，无法设置掉落")
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

	print("找不到index = " .. arg_20_1 .. "的地板")

	return {}
end

function var_0_0.updateFloorPos(arg_21_0)
	for iter_21_0 = 1, #arg_21_0.floors do
		arg_21_0.floors[iter_21_0].tf.anchoredPosition = CastleGameVo.GetRotationPosByWH(arg_21_0.floors[iter_21_0].index % CastleGameVo.w_count, (math.floor(arg_21_0.floors[iter_21_0].index / CastleGameVo.h_count)))
	end

	return
end

function var_0_0.getOutLandPoint(arg_22_0)
	return {
		lb = arg_22_0.floors[1].bound[1],
		lt = arg_22_0.floors[(CastleGameVo.h_count - 1) * CastleGameVo.w_count + 1].bound[2],
		rt = arg_22_0.floors[CastleGameVo.h_count * CastleGameVo.w_count].bound[3],
		rb = arg_22_0.floors[CastleGameVo.w_count].bound[4]
	}
end

function var_0_0.press(arg_23_0, arg_23_1)
	return
end

return var_0_0
