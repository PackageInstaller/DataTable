local CastleGameItem = class("CastleGameItem")
local var_0_1 = 70
local var_0_2 = 300
local var_0_5 = 125
local var_0_6 = "bubble_broken"
local var_0_7 = "bubble_wait"
local var_0_8 = "bubble_hold"
local var_0_9 = 130
local var_0_10 = 130

function CastleGameItem:Ctor(arg_1_1, arg_1_2)
	self._bubbleTpl = findTF(arg_1_1, "bubbleTpl")
	self._carriageTpl = findTF(arg_1_1, "carriageTpl")
	self._stoneTpl = findTF(arg_1_1, "stoneTpl")
	self._boomTpl = findTF(arg_1_1, "boomTpl")
	self._event = arg_1_2
	self.carriagePool = {}
	self.bubblePool = {}
	self.carriages = {}
	self.bubbles = {}
	self.stonePool = {}
	self.stones = {}
	self.boomPool = {}
	self.booms = {}

	return
end

function CastleGameItem:setContent(arg_2_1)
	if not arg_2_1 then
		print("容器不能为nil")

		return
	end

	self._content = arg_2_1

	return
end

function CastleGameItem:start()
	self.stoneDatas = {}

	for iter_3_0 = 1, #CastleGameVo.roundData.stone do
		table.insert(self.stoneDatas, {
			time = math.random() * (CastleGameVo.roundData.stone[iter_3_0].time[2] - CastleGameVo.roundData.stone[iter_3_0].time[1]) + CastleGameVo.roundData.stone[iter_3_0].time[1],
			indexs = CastleGameVo.roundData.stone[iter_3_0].index
		})
	end

	for iter_3_1 = #self.stones, 1, -1 do
		local var_3_0 = table.remove(self.stones, iter_3_1)

		setActive(var_3_0.tf, false)
		self:returnItem(var_3_0, self.stonePool)
	end

	for iter_3_2 = #self.carriages, 1, -1 do
		local var_3_1 = table.remove(self.carriages, iter_3_2)

		var_3_1.ready = 0

		setActive(var_3_1.tf, false)
		self:returnItem(var_3_1, self.carriagePool)
	end

	for iter_3_3 = #self.bubbles, 1, -1 do
		local var_3_2 = table.remove(self.bubbles, iter_3_3)

		var_3_2.ready = 0
		var_3_2.broken = true
		var_3_2.brokenTime = 0
		var_3_2.hit = false

		setActive(var_3_2.tf, false)
		self:returnItem(var_3_2, self.bubblePool)
	end

	for iter_3_4 = #self.booms, 1, -1 do
		local var_3_3 = table.remove(self.booms, iter_3_4)

		var_3_3.ready = 0
		var_3_3.broken = true
		var_3_3.brokenTime = 0

		setActive(var_3_3.tf, false)
		self:returnItem(var_3_3, self.boomPool)
	end

	self.floorIndexs = {}
	self.carriageTime = CastleGameVo.roundData.carriage
	self.bubbleTime = CastleGameVo.roundData.bubble_time
	self.boomTimes = {}

	for iter_3_5 = 1, #CastleGameVo.roundData.boom do
		table.insert(self.boomTimes, {
			time = CastleGameVo.roundData.boom[iter_3_5].time[math.random(1, #CastleGameVo.roundData.boom[iter_3_5].time)]
		})
	end

	return
end

function CastleGameItem:step()
	for iter_4_0 = #self.carriageTime, 1, -1 do
		if CastleGameVo.gameStepTime > self.carriageTime[iter_4_0] then
			table.remove(self.carriageTime, iter_4_0)
			self:appearCarriage()
		end
	end

	for iter_4_1 = #self.bubbleTime, 1, -1 do
		if CastleGameVo.gameStepTime > self.bubbleTime[iter_4_1].time then
			self:appearBubble(table.remove(self.bubbleTime, iter_4_1).num)
		end
	end

	for iter_4_2 = #self.boomTimes, 1, -1 do
		if CastleGameVo.gameStepTime > self.boomTimes[iter_4_2].time then
			table.remove(self.boomTimes, iter_4_2)
			self:appearBoom()
		end
	end

	for iter_4_3 = #self.carriages, 1, -1 do
		if self.carriages[iter_4_3].ready and self.carriages[iter_4_3].ready > 0 then
			self.carriages[iter_4_3].ready = self.carriages[iter_4_3].ready - CastleGameVo.deltaTime

			if self.carriages[iter_4_3].ready <= 0 then
				self.carriages[iter_4_3].ready = 0

				if self.itemRemindCallback then
					-- block empty
				end
			end
		else
			local var_4_0 = self.carriages[iter_4_3].tf
			local var_4_1 = Vector2(self.carriages[iter_4_3].tf.anchoredPosition.x + self.carriages[iter_4_3].speed.x * CastleGameVo.deltaTime * var_0_2, self.carriages[iter_4_3].tf.anchoredPosition.y + self.carriages[iter_4_3].speed.y * CastleGameVo.deltaTime * var_0_2)

			var_4_0.anchoredPosition = var_4_1

			if self.carriages[iter_4_3].tf.anchoredPosition.x < self.carriages[iter_4_3].target.x and var_4_1.x > self.carriages[iter_4_3].target.x then
				table.remove(self.carriages, iter_4_3)
				setActive(self.carriages[iter_4_3].tf, false)
				self:returnItem(self.carriages[iter_4_3], self.carriagePool)
			elseif self.carriages[iter_4_3].tf.anchoredPosition.x > self.carriages[iter_4_3].target.x and var_4_1.x < self.carriages[iter_4_3].target.x then
				table.remove(self.carriages, iter_4_3)
				setActive(self.carriages[iter_4_3].tf, false)
				self:returnItem(self.carriages[iter_4_3], self.carriagePool)
			end
		end
	end

	for iter_4_4 = #self.bubbles, 1, -1 do
		local var_4_2 = self.bubbles[iter_4_4]

		if self.bubbles[iter_4_4].ready and self.bubbles[iter_4_4].ready > 0 then
			self.bubbles[iter_4_4].ready = self.bubbles[iter_4_4].ready - CastleGameVo.deltaTime

			if self.bubbles[iter_4_4].ready <= 0 then
				self.bubbles[iter_4_4].ready = 0

				setActive(self.bubbles[iter_4_4].tf, true)
			end
		elseif self.bubbles[iter_4_4].brokenTime and self.bubbles[iter_4_4].brokenTime > 0 then
			self.bubbles[iter_4_4].brokenTime = self.bubbles[iter_4_4].brokenTime - CastleGameVo.deltaTime

			if not self.bubbles[iter_4_4].hit and CastleGameVo.bubble_broken_time - self.bubbles[iter_4_4].brokenTime > 1 then
				self.bubbles[iter_4_4].hit = true
			end

			if self.bubbles[iter_4_4].brokenTime < 0 then
				self.bubbles[iter_4_4].broken = true
				self.bubbles[iter_4_4].brokenTime = 0
				self.bubbles[iter_4_4].hit = false

				if self.bubbleBrokenCallback then
					self.bubbleBrokenCallback(self.bubbles[iter_4_4])
				end

				self:changeAnimAction(self.bubbles[iter_4_4].anims, var_0_6, 1, var_0_7, function()
					setActive(var_4_2.tf, false)

					return
				end)
				self:returnItem(self.bubbles[iter_4_4], self.bubblePool)
				table.remove(self.bubbles, iter_4_4)
			end
		end
	end

	for iter_4_5 = #self.stoneDatas, 1, -1 do
		if CastleGameVo.gameStepTime > self.stoneDatas[iter_4_5].time then
			self:appearStone(table.remove(self.stoneDatas, iter_4_5).indexs)
		end
	end

	for iter_4_6 = #self.stones, 1, -1 do
		if self.stones[iter_4_6].ready and self.stones[iter_4_6].ready > 0 then
			self.stones[iter_4_6].ready = self.stones[iter_4_6].ready - CastleGameVo.deltaTime

			if self.stones[iter_4_6].ready <= 0 then
				self.stones[iter_4_6].ready = 0

				setActive(self.stones[iter_4_6].tf, true)

				if self.floorBrokenCallback then
					self.floorBrokenCallback(self.stones[iter_4_6].useIndex, 0.5)
				end
			end
		elseif self.stones[iter_4_6].brokenTime and self.stones[iter_4_6].brokenTime > 0 then
			self.stones[iter_4_6].brokenTime = self.stones[iter_4_6].brokenTime - CastleGameVo.deltaTime

			if self.stones[iter_4_6].brokenTime <= 0 then
				self.stones[iter_4_6].broken = true
				self.stones[iter_4_6].brokenTime = nil

				table.remove(self.stones, iter_4_6)
				setActive(self.stones[iter_4_6].tf, false)
				self:returnItem(self.stones[iter_4_6], self.stonePool)
			end
		end
	end

	for iter_4_7 = #self.booms, 1, -1 do
		local var_4_3 = {}

		for iter_4_8, iter_4_9 in ipairs(self.booms[iter_4_7].bound.points:ToTable()) do
			findTF(self.booms[iter_4_7].tf, "zPos/" .. iter_4_8 + 1).anchoredPosition = Vector2(iter_4_9.x, iter_4_9.y)

			table.insert(var_4_3, (Vector2(self.booms[iter_4_7].tf.anchoredPosition.x + iter_4_9.x, self.booms[iter_4_7].tf.anchoredPosition.y + iter_4_9.y)))
		end

		self.booms[iter_4_7].boundPoints = var_4_3

		if self.booms[iter_4_7].ready and self.booms[iter_4_7].ready > 0 then
			self.booms[iter_4_7].ready = self.booms[iter_4_7].ready - CastleGameVo.deltaTime

			if self.booms[iter_4_7].ready <= 0 then
				self.booms[iter_4_7].ready = 0

				setActive(self.booms[iter_4_7].tf, true)

				if self.floorBrokenCallback then
					self.floorBrokenCallback(self.booms[iter_4_7].useIndex, 0.5)
				end
			end
		elseif self.booms[iter_4_7].brokenTime and self.booms[iter_4_7].brokenTime > 0 then
			self.booms[iter_4_7].brokenTime = self.booms[iter_4_7].brokenTime - CastleGameVo.deltaTime

			if self.booms[iter_4_7].brokenTime < 0 then
				self.booms[iter_4_7].broken = true
				self.booms[iter_4_7].brokenTime = 0

				setActive(self.booms[iter_4_7].tf, false)
				self:returnItem(table.remove(self.booms, iter_4_7), self.boomPool)
			end
		end
	end

	return
end

function CastleGameItem:appearStone(arg_6_1)
	local var_6_0
	local var_6_1 = {}
	local var_6_2 = self:getItemActiveIndex()

	for iter_6_0 = 1, #var_6_2 do
		if not table.contains(arg_6_1, var_6_2[iter_6_0]) then
			table.insert(var_6_1, var_6_2[iter_6_0])
		end
	end

	if #var_6_1 == 0 then
		return
	end

	if #self.stonePool > 0 then
		var_6_0 = table.remove(self.stonePool, 1)
	else
		local var_6_3 = tf(instantiate(self._stoneTpl))

		setParent(var_6_3, self._content)

		var_6_0 = {
			tf = var_6_3,
			bound = GetComponent(findTF(var_6_3, "zPos/anim/collider"), typeof(BoxCollider2D))
		}
	end

	local var_6_4 = findTF(var_6_0.tf, "zPos/anim/img")
	local var_6_5 = math.random(1, var_6_4.childCount) - 1

	for iter_6_1 = 0, var_6_4.childCount - 1 do
		setActive(var_6_4:GetChild(iter_6_1), iter_6_1 == var_6_5)
	end

	var_6_0.ready = CastleGameVo.item_ready_time
	var_6_0.brokenTime = CastleGameVo.stone_broken_time

	local var_6_6 = var_6_1[math.random(1, #var_6_1)]
	local var_6_7 = math.floor(var_6_6 / CastleGameVo.w_count)

	var_6_0.tf.anchoredPosition = CastleGameVo.GetRotationPosByWH(var_6_6 % CastleGameVo.w_count, var_6_7)

	setActive(var_6_0.tf, false)

	var_6_0.index = var_6_6
	var_6_0.useIndex = {
		var_6_6
	}

	if self.itemRemindCallback then
		self.itemRemindCallback({
			{
				w = var_6_6 % CastleGameVo.w_count,
				h = var_6_7,
				type = CastleGameRemind.remind_type_1
			}
		})
	end

	table.insert(self.stones, var_6_0)

	return
end

function CastleGameItem:returnItem(arg_7_1, arg_7_2)
	if self.itemChangeCallback then
		self.itemChangeCallback(arg_7_1, false)
	end

	table.insert(arg_7_2, arg_7_1)

	return
end

function CastleGameItem:appearBubble(arg_8_1)
	for iter_8_0 = 1, arg_8_1 do
		local var_8_0
		local var_8_1 = self:getItemActiveIndex()

		if #var_8_1 == 0 then
			return
		end

		if #self.bubblePool > 0 then
			var_8_0 = table.remove(self.bubblePool, 1)
		else
			local var_8_2 = tf(instantiate(self._bubbleTpl))
			local var_8_3 = findTF(var_8_2, "zPos/pos")
			local var_8_4 = GetComponent(findTF(var_8_2, "zPos/spine1"), typeof(SpineAnimUI))
			local var_8_5 = GetComponent(findTF(var_8_2, "zPos/spine2"), typeof(SpineAnimUI))
			local var_8_6 = GetComponent(findTF(var_8_2, "zPos/collider"), typeof(BoxCollider2D))
			local var_8_7 = var_8_2:InverseTransformPoint(var_8_6.bounds.min)
			local var_8_8 = var_8_2:InverseTransformPoint(var_8_6.bounds.max)

			setParent(var_8_2, self._content)

			var_8_0 = {
				tf = var_8_2,
				anims = {
					var_8_4,
					var_8_5
				},
				bound = var_8_6,
				pos = var_8_3,
				bmin = var_8_7,
				bmax = var_8_8
			}
		end

		local var_8_9 = var_8_1[math.random(1, #var_8_1)]

		var_8_0.start = CastleGameVo.GetRotationPosByWH(var_8_9 % CastleGameVo.w_count, (math.floor(var_8_9 / CastleGameVo.w_count)))
		var_8_0.start.y = var_8_0.start.y + var_0_5
		var_8_0.tf.anchoredPosition = var_8_0.start

		setActive(var_8_0.tf, false)

		var_8_0.ready = CastleGameVo.bubble_ready_time
		var_8_0.broken = false
		var_8_0.brokenTime = CastleGameVo.bubble_broken_time
		var_8_0.useIndex = {
			var_8_9
		}
		var_8_0.index = var_8_9

		if self.itemChangeCallback then
			self.itemChangeCallback(var_8_0, true)
		end

		setActive(var_8_0.tf, false)
		table.insert(self.bubbles, var_8_0)
		self:changeAnimAction(var_8_0.anims, var_0_8, -1)
	end

	return
end

function CastleGameItem:appearBoom()
	local var_9_0 = {}
	local var_9_1 = self:getItemActiveIndex()

	for iter_9_0 = 1, #var_9_1 do
		if var_9_1[iter_9_0] % CastleGameVo.w_count ~= CastleGameVo.w_count - 1 then
			if table.contains(var_9_1, var_9_1[iter_9_0] + 1) and table.contains(var_9_1, var_9_1[iter_9_0] + CastleGameVo.w_count) and table.contains(var_9_1, var_9_1[iter_9_0] + 1 + CastleGameVo.w_count) then
				table.insert(var_9_0, var_9_1[iter_9_0])
			end
		end
	end

	local var_9_2 = var_9_0[math.random(1, #var_9_0)]

	if #var_9_0 == 0 then
		return
	end

	local var_9_3

	if #self.boomPool > 0 then
		var_9_3 = table.remove(self.boomPool, 1)
	else
		local var_9_4 = tf(instantiate(self._boomTpl))

		setParent(var_9_4, self._content)

		var_9_3 = {
			tf = var_9_4,
			bound = GetComponent(findTF(var_9_4, "zPos/collider"), typeof("UnityEngine.PolygonCollider2D"))
		}
	end

	local var_9_5 = var_9_2 % CastleGameVo.w_count
	local var_9_6 = math.floor(var_9_2 / CastleGameVo.w_count)
	local var_9_7 = CastleGameVo.GetRotationPosByWH(var_9_2 % CastleGameVo.w_count, var_9_6)

	var_9_7.x = var_9_7.x + var_0_9
	var_9_7.y = var_9_7.y + var_0_10
	var_9_3.tf.anchoredPosition = var_9_7
	var_9_3.ready = CastleGameVo.item_ready_time
	var_9_3.broken = false

	setActive(var_9_3.tf, false)

	var_9_3.index = var_9_2
	var_9_3.useIndex = {
		var_9_2,
		var_9_2 + 1,
		var_9_2 + CastleGameVo.w_count,
		var_9_2 + CastleGameVo.w_count + 1
	}
	var_9_3.brokenTime = 1.5

	if self.itemChangeCallback then
		self.itemChangeCallback(var_9_3, true)
	end

	if self.itemRemindCallback then
		self.itemRemindCallback({
			{
				w = var_9_5,
				h = var_9_6,
				type = CastleGameRemind.remind_type_2
			}
		})
	end

	table.insert(self.booms, var_9_3)

	return
end

function CastleGameItem:setFloorBroken(arg_10_1)
	self.floorBrokenCallback = arg_10_1

	return
end

function CastleGameItem:setBubbleBroken(arg_11_1)
	self.bubbleBrokenCallback = arg_11_1

	return
end

function CastleGameItem:setItemChange(arg_12_1)
	self.itemChangeCallback = arg_12_1

	return
end

function CastleGameItem:setFloorIndexs(arg_13_1)
	self.floorIndexs = arg_13_1

	return
end

function CastleGameItem:getItemActiveIndex()
	local var_14_0 = {}
	local var_14_1 = {}

	for iter_14_0 = 1, #self.bubbles do
		for iter_14_1, iter_14_2 in ipairs(self.bubbles[iter_14_0].useIndex) do
			table.insert(var_14_1, iter_14_2)
		end
	end

	for iter_14_3 = 1, #self.booms do
		for iter_14_4, iter_14_5 in ipairs(self.booms[iter_14_3].useIndex) do
			table.insert(var_14_1, iter_14_5)
		end
	end

	for iter_14_6 = 1, #self.stones do
		for iter_14_7, iter_14_8 in ipairs(self.stones[iter_14_6].useIndex) do
			table.insert(var_14_1, iter_14_8)
		end
	end

	for iter_14_9 = 1, #self.floorIndexs do
		if not table.contains(var_14_1, self.floorIndexs[iter_14_9]) then
			table.insert(var_14_0, self.floorIndexs[iter_14_9])
		end
	end

	return var_14_0
end

function CastleGameItem:appearCarriage()
	local var_15_0

	if #self.carriagePool > 0 then
		var_15_0 = table.remove(self.carriagePool, 1)
	else
		local var_15_1 = tf(instantiate(self._carriageTpl))
		local var_15_2 = GetComponent(findTF(var_15_1, "zPos/collider"), typeof(BoxCollider2D))

		setParent(var_15_1, self._content)

		var_15_0 = {
			tf = var_15_1,
			bound = var_15_2,
			anims = {
				(GetComponent(findTF(var_15_1, "zPos/spine"), typeof(SpineAnimUI)))
			},
			bmin = var_15_1:InverseTransformPoint(var_15_2.bounds.min),
			bmax = var_15_1:InverseTransformPoint(var_15_2.bounds.max)
		}
	end

	local var_15_3 = self:getCarriageRoadlist()

	if #var_15_3 > 0 then
		local var_15_4 = var_15_3[math.random(1, #var_15_3)]

		var_15_0.w = var_15_4.w
		var_15_0.h = var_15_4.h
		var_15_0.target_w = var_15_4.target_w
		var_15_0.target_h = var_15_4.target_h
		findTF(var_15_0.tf, "zPos").localScale = var_15_4.scale
		var_15_0.start = CastleGameVo.GetRotationPosByWH(var_15_0.w, var_15_0.h)
		var_15_0.start.y = var_15_0.start.y + var_0_1
		var_15_0.target = CastleGameVo.GetRotationPosByWH(var_15_0.target_w, var_15_0.target_h)
		var_15_0.target.y = var_15_0.target.y + var_0_1
		var_15_0.tf.anchoredPosition = var_15_0.start
		var_15_0.ready = CastleGameVo.item_ready_time

		setActive(var_15_0.tf, false)
		setActive(var_15_0.tf, true)

		local var_15_5, var_15_6 = self:countSpeed(var_15_0.start, var_15_0.target)

		var_15_0.speed = var_15_5
		var_15_0.direct = var_15_6

		if self.itemChangeCallback then
			self.itemChangeCallback(var_15_0, true)
		end

		table.insert(self.carriages, var_15_0)
	else
		print("当前不存在可以出现马车的位置")
	end

	return
end

function CastleGameItem:getCarriageRoadlist()
	local var_16_0 = {}

	for iter_16_0 = 0, CastleGameVo.w_count - 1 do
		local var_16_1 = true

		for iter_16_1 = 0, CastleGameVo.h_count - 1 do
			if var_16_1 and not table.contains(self.floorIndexs, iter_16_0 + iter_16_1 * CastleGameVo.w_count) then
				var_16_1 = false
			end
		end

		if var_16_1 then
			table.insert(var_16_0, {
				h = -1,
				w = iter_16_0,
				target_w = iter_16_0,
				target_h = CastleGameVo.h_count,
				scale = Vector3(-1, 1, 1)
			})
		end
	end

	for iter_16_2 = 0, CastleGameVo.h_count - 1 do
		local var_16_2 = true

		for iter_16_3 = 0, CastleGameVo.w_count - 1 do
			if var_16_2 and not table.contains(self.floorIndexs, iter_16_3 + iter_16_2 * CastleGameVo.w_count) then
				var_16_2 = false
			end
		end

		if var_16_2 then
			table.insert(var_16_0, {
				w = -1,
				h = iter_16_2,
				target_w = CastleGameVo.w_count,
				target_h = iter_16_2,
				scale = Vector3(1, 1, 1)
			})
		end
	end

	return var_16_0
end

function CastleGameItem:setItemRemindCallback(arg_17_1)
	self.itemRemindCallback = arg_17_1

	return
end

function CastleGameItem:countSpeed(arg_18_1, arg_18_2)
	local var_18_0 = math.atan(math.abs(arg_18_2.y - arg_18_1.y) / math.abs(arg_18_2.x - arg_18_1.x))
	local var_18_1 = Vector2(math.cos(var_18_0) * (arg_18_2.x > arg_18_1.x and 1 or -1), math.sin(var_18_0) * (arg_18_2.y > arg_18_1.y and 1 or -1))
	local var_18_2 = Vector2(arg_18_2.x > arg_18_1.x and 1 or -1, arg_18_2.y > arg_18_1.y and 1 or -1)
end

function CastleGameItem:changeAnimAction(arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	local var_19_0 = 0

	for iter_19_0 = 1, #arg_19_1 do
		local var_19_1 = arg_19_1[iter_19_0]

		arg_19_1[iter_19_0]:SetActionCallBack(nil)
		arg_19_1[iter_19_0]:SetAction(arg_19_2, 0)
		arg_19_1[iter_19_0]:SetActionCallBack(function(arg_20_0)
			if arg_20_0 == "finish" then
				if arg_19_3 == 1 then
					var_19_1:SetActionCallBack(nil)
					var_19_1:SetAction(arg_19_4, 0)
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

function CastleGameItem:playerInBubble(arg_21_1, arg_21_2)
	arg_21_1.char = arg_21_2

	return
end

function CastleGameItem:getBooms()
	return self.booms
end

function CastleGameItem:getBubbles()
	return self.bubbles
end

function CastleGameItem:getCarriages()
	return self.carriages
end

function CastleGameItem:clear()
	return
end

return CastleGameItem
