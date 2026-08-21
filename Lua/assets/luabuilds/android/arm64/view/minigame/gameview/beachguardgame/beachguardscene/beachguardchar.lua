local var_0_0 = class("BeachGuardChar")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._config = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0._tf.name = arg_1_2.name
	arg_1_0._rid = BeachGuardConst.getRid()
	arg_1_0.animChar = BeachGuardAsset.getChar(arg_1_0._config.name)
	arg_1_0.pos = findTF(arg_1_0._tf, "pos")

	setActive(arg_1_0.animChar, true)
	setParent(arg_1_0.animChar, arg_1_0.pos)

	arg_1_0.animChar.anchoredPosition = Vector2(0, 0)
	arg_1_0.animTf = findTF(arg_1_0.animChar, "anim")
	arg_1_0.effectBackPos = findTF(arg_1_0._tf, "effectBackPos")
	arg_1_0.effectFrontPos = findTF(arg_1_0._tf, "effectFrontPos")
	arg_1_0.statusPos = findTF(arg_1_0._tf, "statusPos")
	arg_1_0.move = arg_1_0._config.move
	arg_1_0.defFlag = arg_1_0._config.def and arg_1_0._config.def > 0
	arg_1_0.skillDatas = {}

	for iter_1_0 = 1, #arg_1_0._config.skill do
		table.insert(arg_1_0.skillDatas, {
			skill = BeachGuardConst.skill[arg_1_0._config.skill[iter_1_0]],
			cd = BeachGuardConst.skill[arg_1_0._config.skill[iter_1_0]].cd,
			auto = BeachGuardConst.skill[arg_1_0._config.skill[iter_1_0]].auto
		})
	end

	arg_1_0.triggerData = {}
	arg_1_0.animator = GetComponent(findTF(arg_1_0.animChar, "anim"), typeof(Animator))
	arg_1_0.point = findTF(arg_1_0.animChar, "point")
	arg_1_0.collider = findTF(arg_1_0.animChar, "charCollider")
	arg_1_0.minX = arg_1_0.collider.rect.min.x
	arg_1_0.minY = arg_1_0.collider.rect.min.y
	arg_1_0.maxX = arg_1_0.collider.rect.max.x
	arg_1_0.maxY = arg_1_0.collider.rect.max.y
	arg_1_0.bulletPos = findTF(arg_1_0.animChar, "bullet")
	arg_1_0.atkPos = findTF(arg_1_0.animChar, "atk")

	local var_1_0 = findTF(arg_1_0._tf, "click")

	onButton(arg_1_0._event, findTF(arg_1_0._tf, "click"), function()
		if arg_1_0.recycle then
			arg_1_0:overLife()
			arg_1_0:dead()
			arg_1_0._event:emit(BeachGuardGameView.RECYCLES_CHAR_CANCEL)
		end

		return
	end)
	arg_1_0:prepareData()

	GetOrAddComponent(arg_1_0.pos, typeof(CanvasGroup)).blocksRaycasts = false

	return
end

function var_0_0.setParent(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	setParent(arg_3_0._tf, arg_3_1)

	arg_3_3 = arg_3_3 or Vector2(0, 0)
	arg_3_0._tf.anchoredPosition = arg_3_3
	arg_3_0.inGrid = arg_3_2

	setActive(arg_3_0._tf, true)

	return
end

function var_0_0.getId(arg_4_0)
	return arg_4_0:getConfig("id")
end

function var_0_0.overLife(arg_5_0)
	arg_5_0.hp = 0
	arg_5_0.def = 0

	return
end

function var_0_0.getConfig(arg_6_0, arg_6_1)
	return arg_6_0._config[arg_6_1]
end

function var_0_0.prepareData(arg_7_0)
	if arg_7_0.defFlag then
		arg_7_0:setStatusIndex(1)
	else
		arg_7_0:setStatusIndex(0)
	end

	arg_7_0.hp = arg_7_0._config.hp or 1
	arg_7_0.def = arg_7_0._config.def or 0

	for iter_7_0 = 1, #arg_7_0.skillDatas do
		arg_7_0.skillDatas[iter_7_0].cd = arg_7_0.skillDatas[iter_7_0].skill.cd
	end

	arg_7_0.buffAtkRate = 1
	arg_7_0.buffSpeedRate = 1
	arg_7_0.triggerData = {}
	arg_7_0.timeToPool = 0
	arg_7_0._lineIndex = nil
	arg_7_0._gridIndex = nil
	arg_7_0.damageTime = 0
	arg_7_0.recycle = false

	if arg_7_0.buffs and #arg_7_0.buffs > 0 then
		for iter_7_1 = 1, #arg_7_0.buffs do
			arg_7_0:disposeBuff(arg_7_0.buffs[iter_7_1])
		end
	end

	arg_7_0.craftNum = 0
	arg_7_0.buffs = {}

	return
end

function var_0_0.SetSiblingIndex(arg_8_0, arg_8_1)
	arg_8_0._tf:SetSiblingIndex(arg_8_1)

	return
end

function var_0_0.start(arg_9_0)
	arg_9_0:prepareData()

	return
end

function var_0_0.step(arg_10_0, arg_10_1)
	if arg_10_0.timeToPool > 0 then
		arg_10_0.timeToPool = arg_10_0.timeToPool - arg_10_1

		if arg_10_0.timeToPool <= 0 then
			arg_10_0.timeToPool = 0

			arg_10_0._event:emit(BeachGuardGameView.REMOVE_CHAR, arg_10_0)
		end
	end

	if arg_10_0:isAlife() then
		for iter_10_0 = 1, #arg_10_0.buffs do
			arg_10_0.buffs[iter_10_0].time = arg_10_0.buffs[iter_10_0].time - arg_10_1

			if arg_10_0.buffs[iter_10_0].time <= 0 then
				arg_10_0.buffs[iter_10_0].times = 0

				if arg_10_0.buffs[iter_10_0].effectTfs then
					for iter_10_1, iter_10_2 in ipairs(arg_10_0.buffs[iter_10_0].effectTfs) do
						setActive(iter_10_2, false)
					end
				end

				if arg_10_0.buffs[iter_10_0].triggerEffectTfs then
					for iter_10_3, iter_10_4 in ipairs(arg_10_0.buffs[iter_10_0].triggerEffectTfs) do
						setActive(iter_10_4, false)
					end
				end
			end
		end

		for iter_10_5 = 1, #arg_10_0.skillDatas do
			local var_10_0 = arg_10_0.skillDatas[iter_10_5].cd

			if arg_10_0.skillDatas[iter_10_5].cd ~= 0 then
				var_10_0 = var_10_0 - arg_10_1

				if var_10_0 < 0 then
					var_10_0 = 0
				end

				arg_10_0.skillDatas[iter_10_5].cd = var_10_0
			end

			if var_10_0 == 0 then
				if arg_10_0.skillDatas[iter_10_5].skill.type == BeachGuardConst.skill_bullet and arg_10_0.skillDatas[iter_10_5].auto and arg_10_0.targetChar then
					arg_10_0:useSkill(arg_10_0.skillDatas[iter_10_5])
				elseif arg_10_0.skillDatas[iter_10_5].skill.type == BeachGuardConst.skill_melee and arg_10_0.targetChar then
					arg_10_0:useSkill(arg_10_0.skillDatas[iter_10_5])
				elseif arg_10_0.skillDatas[iter_10_5].skill.type == BeachGuardConst.skill_craft then
					arg_10_0:addCraft()
					arg_10_0:useSkill(arg_10_0.skillDatas[iter_10_5])
				end
			end
		end

		for iter_10_6 = #arg_10_0.triggerData, 1, -1 do
			arg_10_0.triggerData[iter_10_6].time = arg_10_0.triggerData[iter_10_6].time - arg_10_1

			if arg_10_0.triggerData[iter_10_6].time <= 0 then
				arg_10_0._event:emit(arg_10_0.triggerData[iter_10_6].event, arg_10_0.triggerData[iter_10_6].data)
				table.remove(arg_10_0.triggerData, iter_10_6)
			end
		end

		local var_10_1, var_10_2 = arg_10_0:getSpeed(arg_10_1)

		if arg_10_0.damageTime ~= 0 then
			arg_10_0.damageTime = arg_10_0.damageTime - Time.deltaTime
			var_10_1 = 0
			var_10_2 = 0

			if arg_10_0.damageTime <= 0 then
				arg_10_0.damageTime = 0
			end
		elseif arg_10_0.targetChar then
			var_10_1 = 0
			var_10_2 = 0
		end

		local var_10_3 = var_10_1 * arg_10_0:getSpeedRate()

		arg_10_0:moveChar(var_10_3, var_10_2)

		if arg_10_0.speedX ~= var_10_3 then
			arg_10_0.speedX = var_10_3

			if arg_10_0.speedX ~= 0 then
				arg_10_0.animator:SetBool("move", true)
				arg_10_0.animator:SetBool("wait", false)
			else
				arg_10_0.animator:SetBool("move", false)
				arg_10_0.animator:SetBool("wait", true)
			end
		end

		if var_10_3 and var_10_3 ~= 0 and arg_10_0._tf.anchoredPosition.x <= -500 then
			arg_10_0:dead()
		end
	end

	arg_10_0._anchoredPosition = nil
	arg_10_0._position = nil

	return
end

function var_0_0.addCraft(arg_11_0)
	arg_11_0.craftNum = arg_11_0.craftNum + 1

	if arg_11_0.craftNum > 3 then
		arg_11_0.craftNum = 0
	end

	for iter_11_0 = 1, 3 do
		local var_11_0 = findTF(arg_11_0.animChar, "craft/" .. tostring(iter_11_0))

		if var_11_0 then
			setActive(var_11_0, iter_11_0 <= arg_11_0.craftNum)
		end
	end

	return
end

function var_0_0.getPointWorld(arg_12_0)
	return arg_12_0.point.position
end

function var_0_0.getSpeed(arg_13_0, arg_13_1)
	return arg_13_0.move.x * arg_13_1, arg_13_0.move.y * arg_13_1
end

function var_0_0.moveChar(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == 0 and arg_14_2 == 0 then
		return
	end

	local var_14_0 = arg_14_0._tf.anchoredPosition

	var_14_0.x = arg_14_0._tf.anchoredPosition.x + arg_14_1
	var_14_0.y = var_14_0.y + arg_14_2
	arg_14_0._tf.anchoredPosition = var_14_0

	return
end

function var_0_0.getSkillDistance(arg_15_0)
	if not arg_15_0.skillDistane then
		arg_15_0.skillDistane = 0

		for iter_15_0 = 1, #arg_15_0.skillDatas do
			if arg_15_0.skillDatas[iter_15_0].skill.distance and arg_15_0.skillDatas[iter_15_0].skill.distance > arg_15_0.skillDistane then
				arg_15_0.skillDistane = arg_15_0.skillDatas[iter_15_0].skill.distance + 0.5
			end
		end
	end

	return arg_15_0.skillDistane
end

function var_0_0.inBulletBound(arg_16_0)
	return arg_16_0._tf.anchoredPosition.x < BeachGuardConst.enemy_bullet_width
end

function var_0_0.setTarget(arg_17_0, arg_17_1)
	arg_17_0.targetChar = arg_17_1

	return
end

function var_0_0.getTarget(arg_18_0, arg_18_1)
	return arg_18_0.targetChar
end

function var_0_0.dead(arg_19_0)
	arg_19_0:overLife()
	arg_19_0.animator:SetTrigger("dead")

	arg_19_0.timeToPool = 0.5
	arg_19_0.recycle = false

	return
end

function var_0_0.useSkill(arg_20_0, arg_20_1)
	if not arg_20_0:isAlife() then
		return
	end

	local var_20_0 = arg_20_1.skill

	if BeachGuardConst.ignore_enemy_skill and arg_20_0.camp == 2 then
		arg_20_1.cd = var_20_0.cd

		return
	end

	local var_20_1 = var_20_0.anim_type

	if var_20_0.anim_type == BeachGuardConst.anim_atk then
		arg_20_0.animator:SetTrigger("attack")
	elseif var_20_1 == BeachGuardConst.anim_craft then
		arg_20_0.animator:SetTrigger("create")
	end

	;({}).data = arg_20_0:createUseData(var_20_0)
	;({}).time = var_20_0.time
	;({}).event = BeachGuardGameView.USE_SKILL

	table.insert(arg_20_0.triggerData, {})

	arg_20_1.cd = var_20_0.cd

	return
end

function var_0_0.setRecycleFlag(arg_21_0, arg_21_1)
	arg_21_0.recycle = arg_21_1

	return
end

function var_0_0.getRecycleFlag(arg_22_0)
	return arg_22_0.recycle
end

function var_0_0.damage(arg_23_0, arg_23_1)
	if BeachGuardConst.ignore_damage then
		arg_23_1 = 0
	end

	if arg_23_0.def and arg_23_0.def > 0 then
		arg_23_0.def = arg_23_0.def - arg_23_1

		if arg_23_0.def <= 0 then
			arg_23_0.animator:SetTrigger("break")
			arg_23_0:setStatusIndex(2)
		elseif #arg_23_0.triggerData == 0 then
			arg_23_0.animator:SetTrigger("damage")
		end
	elseif arg_23_0.hp > 0 then
		arg_23_0.hp = arg_23_0.hp - arg_23_1

		if arg_23_0.hp <= 0 then
			arg_23_0:dead()
		elseif #arg_23_0.triggerData == 0 then
			arg_23_0.animator:SetTrigger("damage")
		end
	end

	return
end

function var_0_0.isAlife(arg_24_0)
	if arg_24_0.def and arg_24_0.def > 0 then
		return true
	end

	if arg_24_0.hp and arg_24_0.hp > 0 then
		return true
	end

	return false
end

function var_0_0.setStatusIndex(arg_25_0, arg_25_1)
	arg_25_0.animator:SetInteger("wait_index", arg_25_1)
	arg_25_0.animator:SetInteger("damage_index", arg_25_1)

	return
end

function var_0_0.setCamp(arg_26_0, arg_26_1)
	arg_26_0.camp = arg_26_1

	return
end

function var_0_0.getCamp(arg_27_0)
	return arg_27_0.camp
end

function var_0_0.getAnimPos(arg_28_0)
	return arg_28_0.animTf.position
end

function var_0_0.createUseData(arg_29_0, arg_29_1)
	if arg_29_1.type == BeachGuardConst.skill_bullet then
		({
			skill = arg_29_1
		}).position = arg_29_0.bulletPos.position
	elseif arg_29_1.type == BeachGuardConst.skill_melee then
		({
			skill = arg_29_1
		}).position = arg_29_0.animTf.position
	else
		({
			skill = arg_29_1
		}).position = arg_29_0._tf.position
	end

	;({
		skill = arg_29_1
	}).distanceVec = Vector2(arg_29_0:getSkillDistance() * BeachGuardConst.part_width, 0)
	;({
		skill = arg_29_1
	}).direct = arg_29_0._config.point or 1
	;({
		skill = arg_29_1
	}).rid = arg_29_0._rid
	;({
		skill = arg_29_1
	}).target = arg_29_0.targetChar
	;({
		skill = arg_29_1
	}).damage = arg_29_1.damage
	;({
		skill = arg_29_1
	}).camp = arg_29_0.camp
	;({
		skill = arg_29_1
	}).line = arg_29_0._lineIndex
	;({
		skill = arg_29_1
	}).useChar = arg_29_0
	;({
		skill = arg_29_1
	}).atkRate = arg_29_0:getAtkRate()
	;({
		skill = arg_29_1
	}).speedRate = arg_29_0:getSpeedRate()

	return {
		skill = arg_29_1
	}
end

function var_0_0.getAtkRate(arg_30_0)
	local var_30_0 = 1

	for iter_30_0 = 1, #arg_30_0.buffs do
		if arg_30_0.buffs[iter_30_0].config.type == BeachGuardConst.buff_type_speed_down then
			var_30_0 = var_30_0 - arg_30_0.buffs[iter_30_0].config.rate * arg_30_0.buffs[iter_30_0].times
		end
	end

	if var_30_0 < 0 then
		var_30_0 = 0
	end

	return var_30_0
end

function var_0_0.getSpeedRate(arg_31_0)
	local var_31_0 = 1

	for iter_31_0 = 1, #arg_31_0.buffs do
		if arg_31_0.buffs[iter_31_0].config.type == BeachGuardConst.buff_type_speed_down then
			var_31_0 = var_31_0 - arg_31_0.buffs[iter_31_0].config.rate * arg_31_0.buffs[iter_31_0].times
		end
	end

	if var_31_0 < 0 then
		var_31_0 = 0
	end

	return var_31_0
end

function var_0_0.clear(arg_32_0)
	arg_32_0:prepareData()
	setActive(arg_32_0._tf, false)

	arg_32_0.inGrid = false
	arg_32_0.targetChar = nil

	return
end

function var_0_0.getDistance(arg_33_0)
	return arg_33_0._config.distance or 0
end

function var_0_0.setLineIndex(arg_34_0, arg_34_1)
	arg_34_0._lineIndex = arg_34_1

	return
end

function var_0_0.getLineIndex(arg_35_0)
	return arg_35_0._lineIndex
end

function var_0_0.getPos(arg_36_0)
	arg_36_0._anchoredPosition = arg_36_0._anchoredPosition or arg_36_0._tf.anchoredPosition

	return arg_36_0._anchoredPosition
end

function var_0_0.setGridIndex(arg_37_0, arg_37_1)
	arg_37_0._gridIndex = arg_37_1

	return
end

function var_0_0.getGridIndex(arg_38_0, arg_38_1)
	return arg_38_0._gridIndex
end

function var_0_0.getWorldPos(arg_39_0)
	arg_39_0._position = arg_39_0._position or arg_39_0._tf.position

	return arg_39_0._position
end

function var_0_0.getCollider(arg_40_0)
	return arg_40_0.collider
end

function var_0_0.checkCollider(arg_41_0, arg_41_1, arg_41_2)
	if not arg_41_0:isAlife() then
		return
	end

	local var_41_0 = arg_41_0.animChar:InverseTransformPoint(arg_41_1)

	if var_41_0.x > arg_41_0.minX and var_41_0.x < arg_41_0.maxX and arg_41_2.x > arg_41_0._tf.anchoredPosition.x then
		return true
	end

	return false
end

function var_0_0.checkBulletCollider(arg_42_0, arg_42_1)
	if not arg_42_0:isAlife() then
		return
	end

	local var_42_0 = arg_42_0.animChar:InverseTransformPoint(arg_42_1)

	if var_42_0.x > arg_42_0.minX and var_42_0.x < arg_42_0.maxX and var_42_0.y > arg_42_0.minY and var_42_0.y < arg_42_0.maxY then
		return true
	end

	return false
end

function var_0_0.setRaycast(arg_43_0, arg_43_1)
	GetComponent(findTF(arg_43_0._tf, "click"), typeof(Image)).raycastTarget = arg_43_1

	return
end

function var_0_0.addBuff(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0:getOrCreateBuff(arg_44_1.id)

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

function var_0_0.removeBuff(arg_45_0, arg_45_1)
	for iter_45_0 = #arg_45_0.buffs, 1, -1 do
		if arg_45_0.buffs[iter_45_0] == arg_45_1 then
			arg_45_0:disposeBuff((table.remove(arg_45_0.buffs, iter_45_0)))
		end
	end

	return
end

function var_0_0.disposeBuff(arg_46_0, arg_46_1)
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

function var_0_0.getOrCreateBuff(arg_47_0, arg_47_1)
	for iter_47_0 = 1, #arg_47_0.buffs do
		if arg_47_0.buffs[iter_47_0].config.id == arg_47_1 then
			return arg_47_0.buffs[iter_47_0]
		end
	end

	local var_47_0 = {}

	var_47_0.effectTfs = {}

	if BeachGuardConst.buff[arg_47_1].effect and #BeachGuardConst.buff[arg_47_1].effect > 0 then
		for iter_47_1, iter_47_2 in ipairs(BeachGuardConst.buff[arg_47_1].effect) do
			local var_47_1 = BeachGuardAsset.getEffect(BeachGuardConst.effect[iter_47_2].name)

			if BeachGuardConst.effect[iter_47_2].front then
				setParent(var_47_1, arg_47_0.effectFrontPos)
			else
				setParent(var_47_1, arg_47_0.effectBackPos)
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
				setParent(var_47_2, arg_47_0.effectFrontPos)
			else
				setParent(var_47_2, arg_47_0.effectBackPos)
			end

			setActive(var_47_2, true)

			var_47_2.anchoredPosition = Vector2(0, 0)

			table.insert(var_47_0.triggerEffectTfs, var_47_2)
		end
	end

	var_47_0.times = 0
	var_47_0.time = 0
	var_47_0.config = BeachGuardConst.buff[arg_47_1]

	table.insert(arg_47_0.buffs, var_47_0)

	return var_47_0
end

function var_0_0.getScore(arg_48_0)
	return arg_48_0._config.score or 0
end

return var_0_0
