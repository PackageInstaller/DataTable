local BeachGuardChar = class("BeachGuardChar")

function BeachGuardChar:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._config = arg_1_2
	self._event = arg_1_3
	self._tf.name = arg_1_2.name
	self._rid = BeachGuardConst.getRid()
	self.animChar = BeachGuardAsset.getChar(self._config.name)
	self.pos = findTF(self._tf, "pos")

	setActive(self.animChar, true)
	setParent(self.animChar, self.pos)

	self.animChar.anchoredPosition = Vector2(0, 0)
	self.animTf = findTF(self.animChar, "anim")
	self.effectBackPos = findTF(self._tf, "effectBackPos")
	self.effectFrontPos = findTF(self._tf, "effectFrontPos")
	self.statusPos = findTF(self._tf, "statusPos")
	self.move = self._config.move
	self.defFlag = self._config.def and self._config.def > 0
	self.skillDatas = {}

	for iter_1_0 = 1, #self._config.skill do
		table.insert(self.skillDatas, {
			skill = BeachGuardConst.skill[self._config.skill[iter_1_0]],
			cd = BeachGuardConst.skill[self._config.skill[iter_1_0]].cd,
			auto = BeachGuardConst.skill[self._config.skill[iter_1_0]].auto
		})
	end

	self.triggerData = {}
	self.animator = GetComponent(findTF(self.animChar, "anim"), typeof(Animator))
	self.point = findTF(self.animChar, "point")
	self.collider = findTF(self.animChar, "charCollider")
	self.minX = self.collider.rect.min.x
	self.minY = self.collider.rect.min.y
	self.maxX = self.collider.rect.max.x
	self.maxY = self.collider.rect.max.y
	self.bulletPos = findTF(self.animChar, "bullet")
	self.atkPos = findTF(self.animChar, "atk")

	local var_1_0 = findTF(self._tf, "click")

	onButton(self._event, findTF(self._tf, "click"), function()
		if self.recycle then
			self:overLife()
			self:dead()
			self._event:emit(BeachGuardGameView.RECYCLES_CHAR_CANCEL)
		end

		return
	end)
	self:prepareData()

	GetOrAddComponent(self.pos, typeof(CanvasGroup)).blocksRaycasts = false

	return
end

function BeachGuardChar:setParent(arg_3_1, arg_3_2, arg_3_3)
	setParent(self._tf, arg_3_1)

	arg_3_3 = arg_3_3 or Vector2(0, 0)
	self._tf.anchoredPosition = arg_3_3
	self.inGrid = arg_3_2

	setActive(self._tf, true)

	return
end

function BeachGuardChar:getId()
	return self:getConfig("id")
end

function BeachGuardChar:overLife()
	self.hp = 0
	self.def = 0

	return
end

function BeachGuardChar:getConfig(arg_6_1)
	return self._config[arg_6_1]
end

function BeachGuardChar:prepareData()
	if self.defFlag then
		self:setStatusIndex(1)
	else
		self:setStatusIndex(0)
	end

	self.hp = self._config.hp or 1
	self.def = self._config.def or 0

	for iter_7_0 = 1, #self.skillDatas do
		self.skillDatas[iter_7_0].cd = self.skillDatas[iter_7_0].skill.cd
	end

	self.buffAtkRate = 1
	self.buffSpeedRate = 1
	self.triggerData = {}
	self.timeToPool = 0
	self._lineIndex = nil
	self._gridIndex = nil
	self.damageTime = 0
	self.recycle = false

	if self.buffs and #self.buffs > 0 then
		for iter_7_1 = 1, #self.buffs do
			self:disposeBuff(self.buffs[iter_7_1])
		end
	end

	self.craftNum = 0
	self.buffs = {}

	return
end

function BeachGuardChar:SetSiblingIndex(arg_8_1)
	self._tf:SetSiblingIndex(arg_8_1)

	return
end

function BeachGuardChar:start()
	self:prepareData()

	return
end

function BeachGuardChar:step(arg_10_1)
	if self.timeToPool > 0 then
		self.timeToPool = self.timeToPool - arg_10_1

		if self.timeToPool <= 0 then
			self.timeToPool = 0

			self._event:emit(BeachGuardGameView.REMOVE_CHAR, self)
		end
	end

	if self:isAlife() then
		for iter_10_0 = 1, #self.buffs do
			self.buffs[iter_10_0].time = self.buffs[iter_10_0].time - arg_10_1

			if self.buffs[iter_10_0].time <= 0 then
				self.buffs[iter_10_0].times = 0

				if self.buffs[iter_10_0].effectTfs then
					for iter_10_1, iter_10_2 in ipairs(self.buffs[iter_10_0].effectTfs) do
						setActive(iter_10_2, false)
					end
				end

				if self.buffs[iter_10_0].triggerEffectTfs then
					for iter_10_3, iter_10_4 in ipairs(self.buffs[iter_10_0].triggerEffectTfs) do
						setActive(iter_10_4, false)
					end
				end
			end
		end

		for iter_10_5 = 1, #self.skillDatas do
			local var_10_0 = self.skillDatas[iter_10_5].cd

			if self.skillDatas[iter_10_5].cd ~= 0 then
				var_10_0 = var_10_0 - arg_10_1

				if var_10_0 < 0 then
					var_10_0 = 0
				end

				self.skillDatas[iter_10_5].cd = var_10_0
			end

			if var_10_0 == 0 then
				if self.skillDatas[iter_10_5].skill.type == BeachGuardConst.skill_bullet and self.skillDatas[iter_10_5].auto and self.targetChar then
					self:useSkill(self.skillDatas[iter_10_5])
				elseif self.skillDatas[iter_10_5].skill.type == BeachGuardConst.skill_melee and self.targetChar then
					self:useSkill(self.skillDatas[iter_10_5])
				elseif self.skillDatas[iter_10_5].skill.type == BeachGuardConst.skill_craft then
					self:addCraft()
					self:useSkill(self.skillDatas[iter_10_5])
				end
			end
		end

		for iter_10_6 = #self.triggerData, 1, -1 do
			self.triggerData[iter_10_6].time = self.triggerData[iter_10_6].time - arg_10_1

			if self.triggerData[iter_10_6].time <= 0 then
				self._event:emit(self.triggerData[iter_10_6].event, self.triggerData[iter_10_6].data)
				table.remove(self.triggerData, iter_10_6)
			end
		end

		local var_10_1, var_10_2 = self:getSpeed(arg_10_1)

		if self.damageTime ~= 0 then
			self.damageTime = self.damageTime - Time.deltaTime
			var_10_1 = 0
			var_10_2 = 0

			if self.damageTime <= 0 then
				self.damageTime = 0
			end
		elseif self.targetChar then
			var_10_1 = 0
			var_10_2 = 0
		end

		local var_10_3 = var_10_1 * self:getSpeedRate()

		self:moveChar(var_10_3, var_10_2)

		if self.speedX ~= var_10_3 then
			self.speedX = var_10_3

			if self.speedX ~= 0 then
				self.animator:SetBool("move", true)
				self.animator:SetBool("wait", false)
			else
				self.animator:SetBool("move", false)
				self.animator:SetBool("wait", true)
			end
		end

		if var_10_3 and var_10_3 ~= 0 and self._tf.anchoredPosition.x <= -500 then
			self:dead()
		end
	end

	self._anchoredPosition = nil
	self._position = nil

	return
end

function BeachGuardChar:addCraft()
	self.craftNum = self.craftNum + 1

	if self.craftNum > 3 then
		self.craftNum = 0
	end

	for iter_11_0 = 1, 3 do
		local var_11_0 = findTF(self.animChar, "craft/" .. tostring(iter_11_0))

		if var_11_0 then
			setActive(var_11_0, iter_11_0 <= self.craftNum)
		end
	end

	return
end

function BeachGuardChar:getPointWorld()
	return self.point.position
end

function BeachGuardChar:getSpeed(arg_13_1)
	return self.move.x * arg_13_1, self.move.y * arg_13_1
end

function BeachGuardChar:moveChar(arg_14_1, arg_14_2)
	if arg_14_1 == 0 and arg_14_2 == 0 then
		return
	end

	local var_14_0 = self._tf.anchoredPosition

	var_14_0.x = self._tf.anchoredPosition.x + arg_14_1
	var_14_0.y = var_14_0.y + arg_14_2
	self._tf.anchoredPosition = var_14_0

	return
end

function BeachGuardChar:getSkillDistance()
	if not self.skillDistane then
		self.skillDistane = 0

		for iter_15_0 = 1, #self.skillDatas do
			if self.skillDatas[iter_15_0].skill.distance and self.skillDatas[iter_15_0].skill.distance > self.skillDistane then
				self.skillDistane = self.skillDatas[iter_15_0].skill.distance + 0.5
			end
		end
	end

	return self.skillDistane
end

function BeachGuardChar:inBulletBound()
	return self._tf.anchoredPosition.x < BeachGuardConst.enemy_bullet_width
end

function BeachGuardChar:setTarget(arg_17_1)
	self.targetChar = arg_17_1

	return
end

function BeachGuardChar:getTarget(arg_18_1)
	return self.targetChar
end

function BeachGuardChar:dead()
	self:overLife()
	self.animator:SetTrigger("dead")

	self.timeToPool = 0.5
	self.recycle = false

	return
end

function BeachGuardChar:useSkill(arg_20_1)
	if not self:isAlife() then
		return
	end

	local var_20_0 = arg_20_1.skill

	if BeachGuardConst.ignore_enemy_skill and self.camp == 2 then
		arg_20_1.cd = var_20_0.cd

		return
	end

	local var_20_1 = var_20_0.anim_type

	if var_20_0.anim_type == BeachGuardConst.anim_atk then
		self.animator:SetTrigger("attack")
	else
		local var_20_2

		if var_20_1 == BeachGuardConst.anim_craft then
			self.animator:SetTrigger("create")

			var_20_2 = {}
		end
	end

	var_20_2.data = self:createUseData(var_20_0)
	var_20_2.time = var_20_0.time
	var_20_2.event = BeachGuardGameView.USE_SKILL

	table.insert(self.triggerData, var_20_2)

	arg_20_1.cd = var_20_0.cd

	return
end

function BeachGuardChar:setRecycleFlag(arg_21_1)
	self.recycle = arg_21_1

	return
end

function BeachGuardChar:getRecycleFlag()
	return self.recycle
end

function BeachGuardChar:damage(arg_23_1)
	if BeachGuardConst.ignore_damage then
		arg_23_1 = 0
	end

	if self.def and self.def > 0 then
		self.def = self.def - arg_23_1

		if self.def <= 0 then
			self.animator:SetTrigger("break")
			self:setStatusIndex(2)
		elseif #self.triggerData == 0 then
			self.animator:SetTrigger("damage")
		end
	elseif self.hp > 0 then
		self.hp = self.hp - arg_23_1

		if self.hp <= 0 then
			self:dead()
		elseif #self.triggerData == 0 then
			self.animator:SetTrigger("damage")
		end
	end

	return
end

function BeachGuardChar:isAlife()
	if self.def and self.def > 0 then
		return true
	end

	if self.hp and self.hp > 0 then
		return true
	end

	return false
end

function BeachGuardChar:setStatusIndex(arg_25_1)
	self.animator:SetInteger("wait_index", arg_25_1)
	self.animator:SetInteger("damage_index", arg_25_1)

	return
end

function BeachGuardChar:setCamp(arg_26_1)
	self.camp = arg_26_1

	return
end

function BeachGuardChar:getCamp()
	return self.camp
end

function BeachGuardChar:getAnimPos()
	return self.animTf.position
end

function BeachGuardChar:createUseData(arg_29_1)
	local var_29_0 = {
		skill = arg_29_1
	}

	var_29_0.position = arg_29_1.type == BeachGuardConst.skill_bullet and self.bulletPos.position or arg_29_1.type == BeachGuardConst.skill_melee and self.animTf.position or self._tf.position
	var_29_0.distanceVec = Vector2(self:getSkillDistance() * BeachGuardConst.part_width, 0)
	var_29_0.direct = self._config.point or 1
	var_29_0.rid = self._rid
	var_29_0.target = self.targetChar
	var_29_0.damage = arg_29_1.damage
	var_29_0.camp = self.camp
	var_29_0.line = self._lineIndex
	var_29_0.useChar = self
	var_29_0.atkRate = self:getAtkRate()
	var_29_0.speedRate = self:getSpeedRate()

	return var_29_0
end

function BeachGuardChar:getAtkRate()
	local var_30_0 = 1

	for iter_30_0 = 1, #self.buffs do
		if self.buffs[iter_30_0].config.type == BeachGuardConst.buff_type_speed_down then
			var_30_0 = var_30_0 - self.buffs[iter_30_0].config.rate * self.buffs[iter_30_0].times
		end
	end

	if var_30_0 < 0 then
		var_30_0 = 0
	end

	return var_30_0
end

function BeachGuardChar:getSpeedRate()
	local var_31_0 = 1

	for iter_31_0 = 1, #self.buffs do
		if self.buffs[iter_31_0].config.type == BeachGuardConst.buff_type_speed_down then
			var_31_0 = var_31_0 - self.buffs[iter_31_0].config.rate * self.buffs[iter_31_0].times
		end
	end

	if var_31_0 < 0 then
		var_31_0 = 0
	end

	return var_31_0
end

function BeachGuardChar:clear()
	self:prepareData()
	setActive(self._tf, false)

	self.inGrid = false
	self.targetChar = nil

	return
end

function BeachGuardChar:getDistance()
	return self._config.distance or 0
end

function BeachGuardChar:setLineIndex(arg_34_1)
	self._lineIndex = arg_34_1

	return
end

function BeachGuardChar:getLineIndex()
	return self._lineIndex
end

function BeachGuardChar:getPos()
	self._anchoredPosition = self._anchoredPosition or self._tf.anchoredPosition

	return self._anchoredPosition
end

function BeachGuardChar:setGridIndex(arg_37_1)
	self._gridIndex = arg_37_1

	return
end

function BeachGuardChar:getGridIndex(arg_38_1)
	return self._gridIndex
end

function BeachGuardChar:getWorldPos()
	self._position = self._position or self._tf.position

	return self._position
end

function BeachGuardChar:getCollider()
	return self.collider
end

function BeachGuardChar:checkCollider(arg_41_1, arg_41_2)
	if not self:isAlife() then
		return
	end

	local var_41_0 = self.animChar:InverseTransformPoint(arg_41_1)

	if var_41_0.x > self.minX and var_41_0.x < self.maxX and arg_41_2.x > self._tf.anchoredPosition.x then
		return true
	end

	return false
end

function BeachGuardChar:checkBulletCollider(arg_42_1)
	if not self:isAlife() then
		return
	end

	local var_42_0 = self.animChar:InverseTransformPoint(arg_42_1)

	if var_42_0.x > self.minX and var_42_0.x < self.maxX and var_42_0.y > self.minY and var_42_0.y < self.maxY then
		return true
	end

	return false
end

function BeachGuardChar:setRaycast(arg_43_1)
	GetComponent(findTF(self._tf, "click"), typeof(Image)).raycastTarget = arg_43_1

	return
end

function BeachGuardChar:addBuff(arg_44_1)
	local var_44_0 = self:getOrCreateBuff(arg_44_1.id)

	var_44_0.time = arg_44_1.time
	var_44_0.times = var_44_0.times + 1

	if var_44_0.times > arg_44_1.times then
		var_44_0.times = arg_44_1.times
	else
		for iter_44_0, iter_44_1 in ipairs(var_44_0.triggerEffectTfs) do
			setActive(iter_44_1, false)
			setActive(iter_44_1, true)
		end
	end

	if var_44_0.effectTfs then
		for iter_44_2, iter_44_3 in ipairs(var_44_0.effectTfs) do
			setActive(iter_44_3, false)
			setActive(iter_44_3, true)
		end
	end

	return
end

function BeachGuardChar:removeBuff(arg_45_1)
	for iter_45_0 = #self.buffs, 1, -1 do
		if self.buffs[iter_45_0] == arg_45_1 then
			self:disposeBuff((table.remove(self.buffs, iter_45_0)))
		end
	end

	return
end

function BeachGuardChar:disposeBuff(arg_46_1)
	if #arg_46_1.effectTfs > 0 then
		for iter_46_0 = 1, #arg_46_1.effectTfs do
			Destroy(arg_46_1.effectTfs[iter_46_0])
		end
	end

	arg_46_1.effectTfs = {}

	if #arg_46_1.triggerEffectTfs > 0 then
		for iter_46_1 = 1, #arg_46_1.triggerEffectTfs do
			Destroy(arg_46_1.triggerEffectTfs[iter_46_1])
		end
	end

	arg_46_1.triggerEffectTfs = {}

	return
end

function BeachGuardChar:getOrCreateBuff(arg_47_1)
	for iter_47_0 = 1, #self.buffs do
		if self.buffs[iter_47_0].config.id == arg_47_1 then
			return self.buffs[iter_47_0]
		end
	end

	local var_47_0 = {}

	var_47_0.effectTfs = {}

	if BeachGuardConst.buff[arg_47_1].effect and #BeachGuardConst.buff[arg_47_1].effect > 0 then
		for iter_47_1, iter_47_2 in ipairs(BeachGuardConst.buff[arg_47_1].effect) do
			local var_47_1 = BeachGuardAsset.getEffect(BeachGuardConst.effect[iter_47_2].name)

			if BeachGuardConst.effect[iter_47_2].front then
				setParent(var_47_1, self.effectFrontPos)
			else
				setParent(var_47_1, self.effectBackPos)
			end

			setActive(var_47_1, true)

			var_47_1.anchoredPosition = Vector2(0, 0)

			table.insert(var_47_0.effectTfs, var_47_1)
		end
	end

	var_47_0.triggerEffectTfs = {}

	if BeachGuardConst.buff[arg_47_1].trigger_effect and #BeachGuardConst.buff[arg_47_1].trigger_effect > 0 then
		for iter_47_3, iter_47_4 in ipairs(BeachGuardConst.buff[arg_47_1].trigger_effect) do
			local var_47_2 = BeachGuardAsset.getEffect(BeachGuardConst.effect[iter_47_4].name)

			if BeachGuardConst.effect[iter_47_4].front then
				setParent(var_47_2, self.effectFrontPos)
			else
				setParent(var_47_2, self.effectBackPos)
			end

			setActive(var_47_2, true)

			var_47_2.anchoredPosition = Vector2(0, 0)

			table.insert(var_47_0.triggerEffectTfs, var_47_2)
		end
	end

	var_47_0.times = 0
	var_47_0.time = 0
	var_47_0.config = BeachGuardConst.buff[arg_47_1]

	table.insert(self.buffs, var_47_0)

	return var_47_0
end

function BeachGuardChar:getScore()
	return self._config.score or 0
end

return BeachGuardChar
