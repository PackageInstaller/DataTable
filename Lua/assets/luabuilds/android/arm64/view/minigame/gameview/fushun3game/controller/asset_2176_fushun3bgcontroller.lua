local Fushun3BgController = class("Fushun3BgController")

function Fushun3BgController:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self._bgTpl = arg_1_1
	self._fireTpl = arg_1_2
	self._backSceneTf = arg_1_4
	self._petalTpl = arg_1_3
	self._event = arg_1_5
	self._backBgBottomTf = findTF(self._backSceneTf, "bgBottom")
	self._backBgMidTf = findTF(self._backSceneTf, "bgMid")
	self._backBgTopTf = findTF(self._backSceneTf, "bgTop")
	self._backBgPetalTf = findTF(self._backSceneTf, "bgPetal")
	self.bgItems = {}
	self.bgsPool = {}
	self.bgLoops = {}

	for iter_1_0 = 1, #Fushun3GameConst.loop_bg do
		local var_1_0 = self:getBgData(Fushun3GameConst.loop_bg[iter_1_0])

		if var_1_0 then
			table.insert(self.bgLoops, {
				data = var_1_0,
				pos = Vector2(0, 0)
			})
		end
	end

	self._bgAnimTf = findTF(self._backSceneTf, "bg/anim")
	self.bgAnimator = GetComponent(findTF(self._backSceneTf, "bg/anim"), typeof(Animator))

	return
end

function Fushun3BgController:start()
	self:clearBg()

	self.fireTime = math.random() * (Fushun3GameConst.fire_time[2] - Fushun3GameConst.fire_time[1]) + Fushun3GameConst.fire_time[1]

	for iter_2_0 = 1, #self.bgLoops do
		self.bgLoops[iter_2_0].pos = Vector2(0, 0)
	end

	self.midBgPosX = 0

	self:createMidBg()

	self.topBgIds = Clone(Fushun3GameConst.top_bg)
	self.topBgIdx = math.random(1, #self.topBgIds)
	self.topBgPosX = 0
	self.petalCount = 0

	for iter_2_1 = self.topBgIdx, #self.topBgIds do
		self:createTopBg(self.topBgIds[iter_2_1])
	end

	self:changeDayNight(false)

	return
end

function Fushun3BgController:step()
	if self.fireTime > 0 then
		self.fireTime = self.fireTime - Time.deltaTime

		if self.fireTime <= 0 then
			if not Fushun3GameVo.GetTimeFlag() then
				self:createFire()
			end

			self.fireTime = math.random() * (Fushun3GameConst.fire_time[2] - Fushun3GameConst.fire_time[1]) + Fushun3GameConst.fire_time[1]
		end
	end

	if Fushun3GameVo.GetTimeFlag() and self.petalCount < Fushun3GameConst.petal_count_max then
		self:createPetal()
	end

	for iter_3_0 = 1, #self.bgLoops do
		if math.abs(self._backBgBottomTf.anchoredPosition.x) + self.bgLoops[iter_3_0].data.bound.x * Fushun3GameConst.game_scale * Fushun3GameConst.loop_nums >= self.bgLoops[iter_3_0].pos.x then
			local var_3_0 = self:getBgFromPool(self.bgLoops[iter_3_0].data.id)

			var_3_0.tf.anchoredPosition = Vector2(self.bgLoops[iter_3_0].pos.x, self.bgLoops[iter_3_0].data.pos.y)

			setActive(var_3_0.tf, true)
			table.insert(self.bgItems, var_3_0)

			self.bgLoops[iter_3_0].pos.x = self.bgLoops[iter_3_0].pos.x + self.bgLoops[iter_3_0].data.bound.x * Fushun3GameConst.game_scale
			self.bgLoops[iter_3_0].pos = self.bgLoops[iter_3_0].pos
		end
	end

	if self.topBgPosX < math.abs(self._backBgTopTf.anchoredPosition.x) + Fushun3GameConst.top_bg_inst_posX then
		self:createTopBg(self.topBgIds[self.topBgIdx])

		self.topBgIdx = self.topBgIdx >= #self.topBgIds and 1 or self.topBgIdx + 1
	end

	if self.midBgPosX < math.abs(self._backBgMidTf.anchoredPosition.x) + Fushun3GameConst.mid_bg_inst_posX then
		self:createMidBg()
	end

	if self.dayTimeCount and self.dayTimeCount > 0 then
		self.dayTimeCount = self.dayTimeCount - Time.deltaTime

		if self.dayTimeCount <= 0 then
			Fushun3GameVo.ChangeTimeType(self.timeTypeData.next)
			print("切换白天黑夜下一个阶段 = " .. tostring(self.timeTypeData.next))
			self:changeDayNight(true)
			self._event:emit(Fushun3GameEvent.day_night_change)
		end
	end

	for iter_3_1 = 1, #self.bgItems do
		if self.bgItems[iter_3_1].data.type == Fushun3GameConst.BG_TYPE_PETAL then
			self.bgItems[iter_3_1].tf.anchoredPosition.x = self.bgItems[iter_3_1].tf.anchoredPosition.x + self.bgItems[iter_3_1].speed.x * Time.deltaTime
			self.bgItems[iter_3_1].tf.anchoredPosition.y = self.bgItems[iter_3_1].tf.anchoredPosition.y + self.bgItems[iter_3_1].speed.y * Time.deltaTime
			self.bgItems[iter_3_1].tf.anchoredPosition = self.bgItems[iter_3_1].tf.anchoredPosition

			if self.bgItems[iter_3_1].tf.anchoredPosition.y < Fushun3GameConst.petal_remove_y then
				self.bgItems[iter_3_1].removeTime = 0
			end
		end
	end

	self:removeBg()

	return
end

function Fushun3BgController:changeDayNight(arg_4_1)
	self.timeTypeData = Fushun3GameVo.GetTimeTypeData()
	self.dayTimeCount = self.timeTypeData.time

	self:changeBg(arg_4_1)
	self:changeBgItems(arg_4_1)

	return
end

function Fushun3BgController:changeBgItems(arg_5_1)
	if arg_5_1 and self.currentItemTimeFlag == Fushun3GameVo.GetTimeFlag() then
		return
	end

	self.currentItemTimeFlag = Fushun3GameVo.GetTimeFlag()

	for iter_5_0 = 1, #self.bgItems do
		if self.bgItems[iter_5_0].data.type == Fushun3GameConst.BG_TYPE_FIRE then
			if self.bgItems[iter_5_0].removeTime and self.currentItemTimeFlag then
				self.bgItems[iter_5_0].removeTime = 0
			end
		elseif self.bgItems[iter_5_0].data.type == Fushun3GameConst.BG_TYPE_PETAL then
			if self.bgItems[iter_5_0].removeTime and not self.currentItemTimeFlag then
				self.bgItems[iter_5_0].removeTime = 0
			end
		else
			local var_5_0 = GetComponent(self.bgItems[iter_5_0].tf, typeof(Animator))

			if arg_5_1 then
				local var_5_1 = self.currentItemTimeFlag and findTF(self.bgItems[iter_5_0].tf, "day") or findTF(self.bgItems[iter_5_0].tf, "night")

				setActive(var_5_1, false)
				setActive(var_5_1, true)
				var_5_0:SetTrigger(Fushun3GameVo.GetTimeFlag() and "day" or "night")
			else
				var_5_0:SetTrigger(Fushun3GameVo.GetTimeFlag() and "day_no_fade" or "night_no_fade")
			end
		end
	end

	return
end

function Fushun3BgController:changeBg(arg_6_1)
	if arg_6_1 then
		self.bgAnimator:SetTrigger(self.timeTypeData.change_anim)
	else
		setActive(self._bgAnimTf, false)
		setActive(self._bgAnimTf, true)

		for iter_6_0 = 0, self._bgAnimTf.childCount - 1 do
			local var_6_0 = self._bgAnimTf:GetChild(iter_6_0)

			setActive(var_6_0, var_6_0.name == self.timeTypeData.tf)
		end

		self.bgAnimator:SetTrigger(self.timeTypeData.anim)
	end

	print("当前状态" .. tostring(self.timeTypeData.name))

	return
end

function Fushun3BgController:createTopBg(arg_7_1)
	local var_7_0 = self:getBgData(arg_7_1)

	if var_7_0 then
		local var_7_1 = self:getBgFromPool(var_7_0.id)

		var_7_1.tf.anchoredPosition = Vector2(self.topBgPosX, var_7_1.data.pos.y)
		self.topBgPosX = self.topBgPosX + var_7_1.data.bound.x * Fushun3GameConst.game_scale

		setActive(var_7_1.tf, true)
		table.insert(self.bgItems, var_7_1)
	end

	return
end

function Fushun3BgController:createMidBg()
	for iter_8_0 = 1, #Fushun3GameConst.mid_bg do
		local var_8_0 = Clone(Fushun3GameConst.mid_bg[iter_8_0].ids)

		for iter_8_1 = 1, Fushun3GameConst.mid_bg[iter_8_0].num do
			local var_8_1 = self:getBgFromPool((table.remove(var_8_0, math.random(1, #var_8_0))))

			if var_8_1 then
				var_8_1.tf.anchoredPosition = Fushun3GameConst.mid_bg[iter_8_0].mid_random and Vector2(math.random(900, 1000) + self.midBgPosX, var_8_1.data.pos.y) or Vector2(0 + self.midBgPosX, var_8_1.data.pos.y)

				setActive(var_8_1.tf, true)
				table.insert(self.bgItems, var_8_1)
			end
		end
	end

	self.midBgPosX = self.midBgPosX + Fushun3GameConst.mid_bg_inst_posX

	return
end

function Fushun3BgController:createPetal()
	local var_9_0 = Vector2(math.random(100, 1920), math.random(540, 1080))
	local var_9_1 = self:getBgFromPool(Fushun3GameConst.petal_ids[math.random(1, #Fushun3GameConst.petal_ids)])

	if var_9_1 then
		var_9_0.x = var_9_0.x + math.abs(var_9_1.parentTf.anchoredPosition.x)
		var_9_0.y = var_9_0.y
		var_9_1.tf.anchoredPosition = var_9_0
		var_9_1.removeTime = math.random(Fushun3GameConst.peta_remove_time[1], Fushun3GameConst.peta_remove_time[2])
		var_9_0.x = var_9_0.x + var_9_1.data.bound.x
		var_9_1.speed = Vector2(Fushun3GameConst.petal_speed[1] + math.random(1, Fushun3GameConst.petal_speed_offset), Fushun3GameConst.petal_speed[2] + math.random(1, Fushun3GameConst.petal_speed_offset))

		setActive(var_9_1.tf, true)
		table.insert(self.bgItems, var_9_1)

		self.petalCount = self.petalCount + 1
	end

	return
end

function Fushun3BgController:createFire()
	local var_10_0 = Fushun3GameConst.fire_group[math.random(1, #Fushun3GameConst.fire_group)]
	local var_10_1 = Vector2(math.random(100, 1920), 0)

	for iter_10_0 = 1, #var_10_0 do
		local var_10_2 = self:getBgFromPool(var_10_0[iter_10_0])

		if var_10_2 then
			var_10_1.x = var_10_1.x + math.abs(var_10_2.parentTf.anchoredPosition.x)
			var_10_1.y = var_10_2.data.pos.y
			var_10_2.tf.anchoredPosition = var_10_1
			var_10_2.removeTime = Fushun3GameConst.fire_remove
			var_10_1.x = var_10_1.x + var_10_2.data.bound.x

			setActive(var_10_2.tf, true)
			table.insert(self.bgItems, var_10_2)
		end
	end

	return
end

function Fushun3BgController:getBgData(arg_11_1)
	for iter_11_0 = 1, #Fushun3GameConst.bg_data do
		if Fushun3GameConst.bg_data[iter_11_0].id == arg_11_1 then
			return Fushun3GameConst.bg_data[iter_11_0]
		end
	end

	return
end

function Fushun3BgController:getBgFromPool(arg_12_1)
	for iter_12_0 = 1, #self.bgsPool do
		if self.bgsPool[iter_12_0].data.id == arg_12_1 then
			return table.remove(self.bgsPool, iter_12_0)
		end
	end

	local var_12_0

	for iter_12_1 = 1, #Fushun3GameConst.bg_data do
		if Fushun3GameConst.bg_data[iter_12_1].id == arg_12_1 then
			var_12_0 = Fushun3GameConst.bg_data[iter_12_1]
		end
	end

	if var_12_0 then
		local var_12_1
		local var_12_2

		if var_12_0.type == Fushun3GameConst.BG_TYPE_FIRE then
			var_12_1 = tf(instantiate(findTF(self._fireTpl, var_12_0.name)))
			var_12_2 = findTF(self._backSceneTf, "bgFire")
		elseif var_12_0.type == Fushun3GameConst.BG_TYPE_TOP then
			var_12_1 = tf(instantiate(findTF(self._bgTpl, var_12_0.name)))
			var_12_2 = findTF(self._backSceneTf, "bgTop")
		elseif var_12_0.type == Fushun3GameConst.BG_TYPE_MID then
			var_12_1 = tf(instantiate(findTF(self._bgTpl, var_12_0.name)))
			var_12_2 = findTF(self._backSceneTf, "bgMid")
		elseif var_12_0.type == Fushun3GameConst.BG_TYPE_LOOP then
			var_12_1 = tf(instantiate(findTF(self._bgTpl, var_12_0.name)))
			var_12_2 = findTF(self._backSceneTf, "bgBottom")
		elseif var_12_0.type == Fushun3GameConst.BG_TYPE_PETAL then
			var_12_1 = tf(instantiate(findTF(self._petalTpl, var_12_0.name)))
			var_12_2 = findTF(self._backSceneTf, "bgPetal")
		end

		if var_12_1 and var_12_2 then
			SetParent(var_12_1, var_12_2)
		end

		return {
			tf = var_12_1,
			data = var_12_0,
			parentTf = var_12_2
		}
	end

	return nil
end

function Fushun3BgController:clearBg()
	for iter_13_0 = #self.bgItems, 1, -1 do
		setActive(self.bgItems[iter_13_0].tf, false)
		table.insert(self.bgsPool, table.remove(self.bgItems, iter_13_0))
	end

	return
end

function Fushun3BgController:removeBg()
	local var_14_0 = {}

	for iter_14_0 = #self.bgItems, 1, -1 do
		if var_14_0[self.bgItems[iter_14_0].parentTf] == nil then
			var_14_0[self.bgItems[iter_14_0].parentTf] = math.abs(self.bgItems[iter_14_0].parentTf.anchoredPosition.x) + Fushun3GameConst.bg_remove_posX - self.bgItems[iter_14_0].data.bound.x * Fushun3GameConst.game_scale
		end

		if self.bgItems[iter_14_0].removeTime and self.bgItems[iter_14_0].removeTime > 0 then
			self.bgItems[iter_14_0].removeTime = self.bgItems[iter_14_0].removeTime - Time.deltaTime
		end

		if self.bgItems[iter_14_0].tf.anchoredPosition.x <= var_14_0[self.bgItems[iter_14_0].parentTf] then
			setActive(self.bgItems[iter_14_0].tf, false)
			table.insert(self.bgsPool, table.remove(self.bgItems, iter_14_0))
		elseif self.bgItems[iter_14_0].removeTime and self.bgItems[iter_14_0].removeTime <= 0 then
			if self.bgItems[iter_14_0].data.type == Fushun3GameConst.BG_TYPE_PETAL then
				self.petalCount = self.petalCount - 1
			end

			setActive(self.bgItems[iter_14_0].tf, false)
			table.insert(self.bgsPool, table.remove(self.bgItems, iter_14_0))
		end
	end

	return
end

return Fushun3BgController
