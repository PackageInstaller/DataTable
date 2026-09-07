local CastleGameFloor = class("CastleGameFloor")
local var_0_1 = 999999

function CastleGameFloor:Ctor(arg_1_1, arg_1_2)
	self._tpl = arg_1_1
	self._event = arg_1_2
	self.floors = {}
	self.colliders = {}
	self.floorTfs = {}
	self.bounds = {}

	for iter_1_0 = 0, CastleGameVo.h_count * CastleGameVo.w_count - 1 do
		local var_1_0 = tf(instantiate(self._tpl))

		var_1_0.name = tostring(iter_1_0 + 1)

		setActive(var_1_0, true)

		local var_1_1 = findTF(var_1_0, "zPos")

		setImageSprite(findTF(var_1_0, "zPos/floor/img"), CastleGameVo.getFloorImage(iter_1_0 + 1), true)

		local var_1_3 = GetComponent(findTF(var_1_0, "zPos/collider"), typeof("UnityEngine.PolygonCollider2D"))
		local var_1_4 = GetComponent(findTF(var_1_0, "zPos/floor"), typeof(Animator))
		local var_1_5 = math.floor(iter_1_0 / CastleGameVo.w_count)

		table.insert(self.colliders, var_1_3)
		table.insert(self.floorTfs, var_1_0)
		table.insert(self.floors, {
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

	self:updateFloorPos()
	self:updateBounds()

	return
end

function CastleGameFloor:getTfs()
	return self.floorTfs
end

function CastleGameFloor:getFloors()
	return self.floors
end

function CastleGameFloor:getActiveIndexs()
	return self.activeIndexs
end

function CastleGameFloor:updateBounds()
	for iter_5_0 = 1, #self.floors do
		local var_5_0 = {}

		for iter_5_1, iter_5_2 in ipairs(self.floors[iter_5_0].collider.points:ToTable()) do
			table.insert(var_5_0, (Vector2(self.floors[iter_5_0].tf.anchoredPosition.x + iter_5_2.x, self.floors[iter_5_0].tf.anchoredPosition.y + iter_5_2.y)))
		end

		self.floors[iter_5_0].bound = var_5_0

		table.insert(self.bounds, var_5_0)
	end

	return
end

function CastleGameFloor:getBounds()
	return self.bounds
end

function CastleGameFloor:setContent(arg_7_1)
	if not arg_7_1 then
		print("地板的容器不能为nil")

		return
	end

	self._content = arg_7_1

	for iter_7_0 = 1, #self.floorTfs do
		SetParent(self.floorTfs[iter_7_0], arg_7_1)
	end

	return
end

function CastleGameFloor:start()
	self.fallDatas = self:getFallDatas()
	self.floorFallStep = var_0_1
	self.activeIndexs = {}

	for iter_8_0 = 1, #self.floors do
		self.floors[iter_8_0].fall = false
		self.floors[iter_8_0].removeTime = nil
		self.floors[iter_8_0].revertTime = nil

		setActive(self.floors[iter_8_0].tf, false)
		setActive(self.floors[iter_8_0].tf, true)
		table.insert(self.activeIndexs, self.floors[iter_8_0].index)
	end

	self:updateFloorPos()

	return
end

function CastleGameFloor:step()
	if self.floorFallStep and self.floorFallStep > 0 then
		self.floorFallStep = self.floorFallStep - CastleGameVo.deltaTime

		if self.floorFallStep <= 0 then
			-- block empty
		end
	end

	for iter_9_0 = #self.floors, 1, -1 do
		if self.floors[iter_9_0].removeTime and self.floors[iter_9_0].removeTime > 0 then
			self.floors[iter_9_0].removeTime = self.floors[iter_9_0].removeTime - CastleGameVo.deltaTime

			if self.floors[iter_9_0].removeTime <= 0 then
				self.floors[iter_9_0].removeTime = nil

				self:applyFloorFall(self.floors[iter_9_0])
			end
		end
	end

	for iter_9_1 = #self.floors, 1, -1 do
		if self.floors[iter_9_1].revertTime and self.floors[iter_9_1].revertTime > 0 then
			self.floors[iter_9_1].revertTime = self.floors[iter_9_1].revertTime - CastleGameVo.deltaTime

			if self.floors[iter_9_1].revertTime <= 0 then
				self.floors[iter_9_1].revertTime = nil

				self:revertFloorFall(self.floors[iter_9_1])
				self:revertActiveFloor(self.floors[iter_9_1])
			end
		end
	end

	for iter_9_2 = #self.fallDatas, 1, -1 do
		if CastleGameVo.gameStepTime >= self.fallDatas[iter_9_2].time then
			self:removeFloorByFallData((table.remove(self.fallDatas, iter_9_2)))

			break
		end
	end

	return
end

function CastleGameFloor:setBroken(arg_10_1, arg_10_2)
	self:setFloorFallTime(self:getFloorByIndex(arg_10_1), false, arg_10_2)

	return
end

function CastleGameFloor:removeFloorByFallData(arg_11_1)
	local var_11_0 = CastleGameVo.floor_rule[table.remove(arg_11_1.rule_id, math.random(1, #arg_11_1.rule_id))]

	for iter_11_0 = 1, #var_11_0 do
		self:setFloorFallTime(self:getFloorByIndex(var_11_0[iter_11_0]), true, nil)
	end

	return
end

function CastleGameFloor:clear()
	return
end

function CastleGameFloor:setFloorFallCallback(arg_13_1)
	self.floorFallCallback = arg_13_1

	return
end

function CastleGameFloor:getFallDatas()
	return CastleGameVo.roundData.floors
end

function CastleGameFloor:applyFloorFall(arg_15_1)
	arg_15_1.fall = true
	arg_15_1.revertTime = CastleGameVo.floor_revert_time

	arg_15_1.anim:Play("hide")

	return
end

function CastleGameFloor:revertFloorFall(arg_16_1)
	arg_16_1.fall = false

	arg_16_1.anim:Play("revert")

	return
end

function CastleGameFloor:revertActiveFloor(arg_17_1)
	if not table.contains(self.activeIndexs, arg_17_1.index) then
		table.insert(self.activeIndexs, arg_17_1.index)
	end

	return
end

function CastleGameFloor:removeActiveFloor(arg_18_1)
	for iter_18_0 = #self.activeIndexs, 1, -1 do
		if self.activeIndexs[iter_18_0] == arg_18_1.index then
			table.remove(self.activeIndexs, iter_18_0)
		end
	end

	return
end

function CastleGameFloor:setFloorFallTime(arg_19_1, arg_19_2, arg_19_3)
	for iter_19_0 = 1, #arg_19_1 do
		if arg_19_2 then
			arg_19_1[iter_19_0].anim:Play("shake")
		end

		if not arg_19_1[iter_19_0].fall then
			arg_19_1[iter_19_0].removeTime = arg_19_3 and arg_19_3 or CastleGameVo.floor_remove_time
			arg_19_1[iter_19_0].revertTime = nil

			self:removeActiveFloor(arg_19_1[iter_19_0])
		else
			print(arg_19_1[iter_19_0].index .. "已经被移除，无法设置掉落")
		end
	end

	return
end

function CastleGameFloor:getFloorByIndex(arg_20_1, arg_20_2)
	for iter_20_0 = 1, #self.floors do
		if self.floors[iter_20_0].index == arg_20_1 then
			return {
				self.floors[iter_20_0]
			}
		end
	end

	print("找不到index = " .. arg_20_1 .. "的地板")

	return {}
end

function CastleGameFloor:updateFloorPos()
	for iter_21_0 = 1, #self.floors do
		self.floors[iter_21_0].tf.anchoredPosition = CastleGameVo.GetRotationPosByWH(self.floors[iter_21_0].index % CastleGameVo.w_count, (math.floor(self.floors[iter_21_0].index / CastleGameVo.h_count)))
	end

	return
end

function CastleGameFloor:getOutLandPoint()
	return {
		lb = self.floors[1].bound[1],
		lt = self.floors[(CastleGameVo.h_count - 1) * CastleGameVo.w_count + 1].bound[2],
		rt = self.floors[CastleGameVo.h_count * CastleGameVo.w_count].bound[3],
		rb = self.floors[CastleGameVo.w_count].bound[4]
	}
end

function CastleGameFloor:press(arg_23_1)
	return
end

return CastleGameFloor
