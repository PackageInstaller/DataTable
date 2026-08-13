class = var_0_10000

local var_0_0 = var_0_10000("BeachGuardChar")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._config = arg_1_2
	arg_1_0._event = arg_1_3

	local var_1_0 = arg_1_0._tf

	var_1_0.name = arg_1_2.name
	BeachGuardConst = var_1_0
	arg_1_0._rid = var_1_0.getRid()
	BeachGuardAsset = var_4
	arg_1_0.animChar = var_4.getChar(arg_1_0._config.name)
	findTF = var_4
	arg_1_0.pos = var_4(arg_1_0._tf, "pos")
	setActive = var_4

	var_4(arg_1_0.animChar, true)

	setParent = var_4

	var_4(arg_1_0.animChar, arg_1_0.pos)

	local var_1_1 = arg_1_0.animChar

	Vector2 = var_5
	var_1_1.anchoredPosition = var_5(0, 0)
	findTF = var_1_1
	arg_1_0.animTf = var_1_1(arg_1_0.animChar, "anim")
	findTF = var_4
	arg_1_0.effectBackPos = var_4(arg_1_0._tf, "effectBackPos")
	findTF = var_4
	arg_1_0.effectFrontPos = var_4(arg_1_0._tf, "effectFrontPos")
	findTF = var_4
	arg_1_0.statusPos = var_4(arg_1_0._tf, "statusPos")
	arg_1_0.move = arg_1_0._config.move

	local var_1_2

	if arg_1_0._config.def then
		var_1_2 = arg_1_0._config.def > 0
	end

	arg_1_0.defFlag = var_1_2
	arg_1_0.skillDatas = {}

	for iter_1_0 = 1, #arg_1_0._config.skill do
		local var_1_3 = arg_1_0._config.skill[iter_1_0]

		BeachGuardConst = var_1_10009
		var_1_10009 = var_1_10009.skill[var_1_3]
		table = var_1_10010

		var_1_10010.insert(arg_1_0.skillDatas, {
			skill = var_1_10009,
			cd = var_1_10009.cd,
			auto = var_1_10009.auto
		})
	end

	arg_1_0.triggerData = {}
	GetComponent = var_4
	findTF = var_6

	local var_1_4 = var_6(arg_1_0.animChar, "anim")

	typeof = iter_1_0
	Animator = var_9
	arg_1_0.animator = var_4(var_1_4, iter_1_0(var_9))
	findTF = var_4
	arg_1_0.point = var_4(arg_1_0.animChar, "point")
	findTF = var_4
	arg_1_0.collider = var_4(arg_1_0.animChar, "charCollider")
	arg_1_0.minX = arg_1_0.collider.rect.min.x
	arg_1_0.minY = arg_1_0.collider.rect.min.y
	arg_1_0.maxX = arg_1_0.collider.rect.max.x
	arg_1_0.maxY = arg_1_0.collider.rect.max.y
	findTF = var_4
	arg_1_0.bulletPos = var_4(arg_1_0.animChar, "bullet")
	findTF = var_4
	arg_1_0.atkPos = var_4(arg_1_0.animChar, "atk")
	findTF = var_4

	local var_1_5 = var_4(arg_1_0._tf, "click")

	onButton = var_5

	local var_1_6 = arg_1_0._event

	findTF = var_8

	var_5(var_1_6, var_8(arg_1_0._tf, "click"), function()
		if arg_1_0.recycle then
			local var_2_0 = arg_1_0

			var_0.overLife(var_2_0)

			local var_2_1 = arg_1_0

			var_0.dead(var_2_1)

			local var_2_2 = arg_1_0._event
			local var_2_3 = var_0.emit

			BeachGuardGameView = var_2_10003

			var_2_3(var_2_2, var_2_10003.RECYCLES_CHAR_CANCEL)
		end

		return
	end)
	arg_1_0:prepareData()

	GetOrAddComponent = var_5

	local var_1_7 = arg_1_0.pos

	typeof = var_8
	CanvasGroup = var_10
	var_5(var_1_7, var_8(var_10)).blocksRaycasts = false

	return
end

function var_0_0.setParent(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	setParent = var_1_10004

	var_1_10004(arg_3_0._tf, arg_3_1)

	if not arg_3_3 then
		Vector2 = var_1_10004
		arg_3_3 = var_1_10004(0, 0)
	end

	local var_3_0 = arg_3_0._tf

	var_3_0.anchoredPosition = arg_3_3
	arg_3_0.inGrid = arg_3_2
	setActive = var_3_0

	var_3_0(arg_3_0._tf, true)

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

	local var_7_0

	if not arg_7_0._config.hp then
		var_7_0 = 1
	end

	arg_7_0.hp = var_7_0

	local var_7_1

	if not arg_7_0._config.def then
		var_7_1 = 0
	end

	arg_7_0.def = var_7_1

	for iter_7_0 = 1, #arg_7_0.skillDatas do
		local var_7_2 = arg_7_0.skillDatas[iter_7_0].skill

		arg_7_0.skillDatas[iter_7_0].cd = var_7_2.cd
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
	local var_8_0 = arg_8_0._tf

	var_2.SetSiblingIndex(var_8_0, arg_8_1)

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

			local var_10_0 = arg_10_0._event
			local var_10_1 = var_2.emit

			BeachGuardGameView = var_1_10005

			var_10_1(var_10_0, var_1_10005.REMOVE_CHAR, arg_10_0)
		end
	end

	if arg_10_0:isAlife() then
		for iter_10_0 = 1, #arg_10_0.buffs do
			var_6.time = arg_10_0.buffs[iter_10_0].time - arg_10_1

			if var_6.time <= 0 then
				var_6.times = 0

				if var_6.effectTfs then
					ipairs = var_7

					for iter_10_1, iter_10_4 in var_7(var_6.effectTfs) do
						setActive = var_1_10012

						var_1_10012(iter_10_4, false)
					end
				end

				if var_6.triggerEffectTfs then
					ipairs = var_7

					for iter_10_3, iter_10_4 in var_7(var_6.triggerEffectTfs) do
						setActive = var_1_10012

						var_1_10012(iter_10_4, false)
					end
				end
			end
		end

		for iter_10_5 = 1, #arg_10_0.skillDatas do
			local var_10_2 = arg_10_0.skillDatas[iter_10_5].skill
			local var_10_3 = arg_10_0.skillDatas[iter_10_5].cd
			local var_10_4 = arg_10_0.skillDatas[iter_10_5].auto

			if var_10_3 ~= 0 then
				if var_10_3 - arg_10_1 < 0 then
					var_10_3 = 0
				end

				arg_10_0.skillDatas[iter_10_5].cd = var_10_3
			end

			if var_10_3 == 0 then
				local var_10_5 = var_10_2.type

				BeachGuardConst = iter_10_4

				if var_10_5 == iter_10_4.skill_bullet and var_10_4 and arg_10_0.targetChar then
					arg_10_0:useSkill(var_6)
				else
					local var_10_6 = var_10_2.type

					BeachGuardConst = iter_10_4

					if var_10_6 == iter_10_4.skill_melee and arg_10_0.targetChar then
						arg_10_0:useSkill(var_6)
					else
						local var_10_7 = var_10_2.type

						BeachGuardConst = iter_10_4

						if var_10_7 == iter_10_4.skill_craft then
							arg_10_0:addCraft()
							arg_10_0:useSkill(var_6)
						end
					end
				end
			end
		end

		for iter_10_6 = #arg_10_0.triggerData, 1, -1 do
			var_6.time = arg_10_0.triggerData[iter_10_6].time - arg_10_1

			if var_6.time <= 0 then
				local var_10_8 = arg_10_0._event

				var_7.emit(var_10_8, var_6.event, var_6.data)

				table = var_7

				var_7.remove(arg_10_0.triggerData, iter_10_6)
			end
		end

		local var_10_9, var_10_10 = arg_10_0:getSpeed(arg_10_1)

		if arg_10_0.damageTime ~= 0 then
			local var_10_11 = arg_10_0.damageTime

			Time = var_5
			arg_10_0.damageTime = var_10_11 - var_5.deltaTime
			var_10_9 = 0
			var_10_10 = 0

			if arg_10_0.damageTime <= 0 then
				arg_10_0.damageTime = 0
			end
		elseif arg_10_0.targetChar then
			var_10_9 = 0
			var_10_10 = 0
		end

		local var_10_12 = var_10_9 * arg_10_0:getSpeedRate()

		arg_10_0:moveChar(var_10_12, var_10_10)

		if arg_10_0.speedX ~= var_10_12 then
			arg_10_0.speedX = var_10_12

			if arg_10_0.speedX ~= 0 then
				local var_10_13 = arg_10_0.animator

				var_4.SetBool(var_10_13, "move", true)

				local var_10_14 = arg_10_0.animator

				var_4.SetBool(var_10_14, "wait", false)
			else
				local var_10_15 = arg_10_0.animator

				var_4.SetBool(var_10_15, "move", false)

				local var_10_16 = arg_10_0.animator

				var_4.SetBool(var_10_16, "wait", true)
			end
		end

		if var_10_12 and var_10_12 ~= 0 and arg_10_0._tf.anchoredPosition.x <= -500 then
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
		findTF = var_1_10005

		local var_11_0 = arg_11_0.animChar
		local var_11_1 = "craft/"

		tostring = var_1_10009

		if var_1_10005(var_11_0, var_11_1 .. var_1_10009(iter_11_0)) then
			setActive = var_1_10006

			local var_11_2 = var_1_10005

			var_1_10009 = iter_11_0 <= arg_11_0.craftNum

			var_1_10006(var_11_2, var_1_10009)
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

	var_3.x = arg_14_0._tf.anchoredPosition.x + arg_14_1
	var_3.y = var_3.y + arg_14_2
	arg_14_0._tf.anchoredPosition = var_3

	return
end

function var_0_0.getSkillDistance(arg_15_0)
	if not arg_15_0.skillDistane then
		arg_15_0.skillDistane = 0

		for iter_15_0 = 1, #arg_15_0.skillDatas do
			if arg_15_0.skillDatas[iter_15_0].skill.distance and var_5 > arg_15_0.skillDistane then
				arg_15_0.skillDistane = var_5 + 0.5
			end
		end
	end

	return arg_15_0.skillDistane
end

function var_0_0.inBulletBound(arg_16_0)
	local var_16_0 = arg_16_0._tf.anchoredPosition.x

	BeachGuardConst = var_1_10002

	return var_16_0 < var_1_10002.enemy_bullet_width
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

	local var_19_0 = arg_19_0.animator

	var_1.SetTrigger(var_19_0, "dead")

	arg_19_0.timeToPool = 0.5
	arg_19_0.recycle = false

	return
end

function var_0_0.useSkill(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0

	if not arg_20_0.isAlife(var_20_0) then
		return
	end

	local var_20_1 = arg_20_1.skill

	BeachGuardConst = var_1_10003

	if var_1_10003.ignore_enemy_skill and arg_20_0.camp == 2 then
		arg_20_1.cd = var_20_1.cd

		return
	end

	local var_20_2 = var_20_1.anim_type

	BeachGuardConst = var_20_0

	if var_20_2 == var_20_0.anim_atk then
		local var_20_3 = arg_20_0.animator

		var_4.SetTrigger(var_20_3, "attack")
	else
		BeachGuardConst = var_4

		if var_20_2 == var_4.anim_craft then
			local var_20_4 = arg_20_0.animator

			var_4.SetTrigger(var_20_4, "create")
		end
	end

	local var_20_5 = arg_20_0:createUseData(var_20_1)

	table = var_1_10005

	local var_20_6 = var_1_10005.insert
	local var_20_7 = arg_20_0.triggerData
	local var_20_8 = {
		data = var_20_5,
		time = var_20_1.time
	}

	BeachGuardGameView = var_9
	var_20_8.event = var_9.USE_SKILL

	var_20_6(var_20_7, var_20_8)

	arg_20_1.cd = var_20_1.cd

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
	BeachGuardConst = var_1_10002

	if var_1_10002.ignore_damage then
		arg_23_1 = 0
	end

	if arg_23_0.def and arg_23_0.def > 0 then
		arg_23_0.def = arg_23_0.def - arg_23_1

		if arg_23_0.def <= 0 then
			local var_23_0 = arg_23_0.animator

			var_2.SetTrigger(var_23_0, "break")
			arg_23_0:setStatusIndex(2)
		elseif #arg_23_0.triggerData == 0 then
			local var_23_1 = arg_23_0.animator

			var_2.SetTrigger(var_23_1, "damage")
		end
	elseif arg_23_0.hp > 0 then
		arg_23_0.hp = arg_23_0.hp - arg_23_1

		if arg_23_0.hp <= 0 then
			arg_23_0:dead()
		elseif #arg_23_0.triggerData == 0 then
			local var_23_2 = arg_23_0.animator

			var_2.SetTrigger(var_23_2, "damage")
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
	local var_25_0 = arg_25_0.animator

	var_2.SetInteger(var_25_0, "wait_index", arg_25_1)

	local var_25_1 = arg_25_0.animator

	var_2.SetInteger(var_25_1, "damage_index", arg_25_1)

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
	local var_29_0 = {
		skill = arg_29_1
	}
	local var_29_1 = arg_29_1.type

	BeachGuardConst = var_1_10004

	if var_29_1 == var_1_10004.skill_bullet then
		var_29_0.position = arg_29_0.bulletPos.position
	else
		var_29_1 = arg_29_1.type
		BeachGuardConst = var_4

		if var_29_1 == var_4.skill_melee then
			var_29_0.position = arg_29_0.animTf.position
		else
			var_29_0.position = arg_29_0._tf.position
		end
	end

	Vector2 = var_29_1

	local var_29_2 = arg_29_0:getSkillDistance()

	BeachGuardConst = var_1_10006
	var_29_0.distanceVec = var_29_1(var_29_2 * var_1_10006.part_width, 0)

	local var_29_3

	if not arg_29_0._config.point then
		var_29_3 = 1
	end

	var_29_0.direct = var_29_3
	var_29_0.rid = arg_29_0._rid
	var_29_0.target = arg_29_0.targetChar
	var_29_0.damage = arg_29_1.damage
	var_29_0.camp = arg_29_0.camp
	var_29_0.line = arg_29_0._lineIndex
	var_29_0.useChar = arg_29_0
	var_29_0.atkRate = arg_29_0:getAtkRate()
	var_29_0.speedRate = arg_29_0:getSpeedRate()

	return var_29_0
end

function var_0_0.getAtkRate(arg_30_0)
	local var_30_0 = 1

	for iter_30_0 = 1, #arg_30_0.buffs do
		local var_30_1 = arg_30_0.buffs[iter_30_0].config.type

		BeachGuardConst = var_1_10008

		if var_30_1 == var_1_10008.buff_type_speed_down then
			var_30_0 = var_30_0 - var_6.config.rate * var_6.times
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
		local var_31_1 = arg_31_0.buffs[iter_31_0].config.type

		BeachGuardConst = var_1_10008

		if var_31_1 == var_1_10008.buff_type_speed_down then
			var_31_0 = var_31_0 - var_6.config.rate * var_6.times
		end
	end

	if var_31_0 < 0 then
		var_31_0 = 0
	end

	return var_31_0
end

function var_0_0.clear(arg_32_0)
	arg_32_0:prepareData()

	setActive = var_1

	var_1(arg_32_0._tf, false)

	arg_32_0.inGrid = false
	arg_32_0.targetChar = nil

	return
end

function var_0_0.getDistance(arg_33_0)
	local var_33_0

	if not arg_33_0._config.distance then
		var_33_0 = 0
	end

	return var_33_0
end

function var_0_0.setLineIndex(arg_34_0, arg_34_1)
	arg_34_0._lineIndex = arg_34_1

	return
end

function var_0_0.getLineIndex(arg_35_0)
	return arg_35_0._lineIndex
end

function var_0_0.getPos(arg_36_0)
	if not arg_36_0._anchoredPosition then
		arg_36_0._anchoredPosition = arg_36_0._tf.anchoredPosition
	end

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
	if not arg_39_0._position then
		arg_39_0._position = arg_39_0._tf.position
	end

	return arg_39_0._position
end

function var_0_0.getCollider(arg_40_0)
	return arg_40_0.collider
end

function var_0_0.checkCollider(arg_41_0, arg_41_1, arg_41_2)
	if not arg_41_0:isAlife() then
		return
	end

	local var_41_0 = arg_41_0.animChar

	if var_3.InverseTransformPoint(var_41_0, arg_41_1).x > arg_41_0.minX and var_3.x < arg_41_0.maxX and arg_41_2.x > arg_41_0._tf.anchoredPosition.x then
		return true
	end

	return false
end

function var_0_0.checkBulletCollider(arg_42_0, arg_42_1)
	if not arg_42_0:isAlife() then
		return
	end

	local var_42_0 = arg_42_0.animChar

	if var_2.InverseTransformPoint(var_42_0, arg_42_1).x > arg_42_0.minX and var_2.x < arg_42_0.maxX and var_2.y > arg_42_0.minY and var_2.y < arg_42_0.maxY then
		return true
	end

	return false
end

function var_0_0.setRaycast(arg_43_0, arg_43_1)
	GetComponent = var_1_10002
	findTF = var_1_10004

	local var_43_0 = var_1_10004(arg_43_0._tf, "click")

	typeof = var_1_10005
	Image = var_7
	var_1_10002(var_43_0, var_1_10005(var_7)).raycastTarget = arg_43_1

	return
end

function var_0_0.addBuff(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1.id
	local var_44_1 = arg_44_0:getOrCreateBuff(var_44_0)

	var_44_1.time = arg_44_1.time
	var_44_1.times = var_44_1.times + 1

	if var_44_1.times > arg_44_1.times then
		var_44_1.times = arg_44_1.times
	else
		ipairs = var_4

		for iter_44_0, iter_44_1 in var_4(var_44_1.triggerEffectTfs) do
			setActive = var_1_10009

			var_1_10009(iter_44_1, false)

			setActive = var_1_10009

			var_1_10009(iter_44_1, true)
		end
	end

	if var_44_1.effectTfs then
		ipairs = var_4

		for iter_44_2, iter_44_3 in var_4(var_44_1.effectTfs) do
			setActive = var_1_10009

			var_1_10009(iter_44_3, false)

			setActive = var_1_10009

			var_1_10009(iter_44_3, true)
		end
	end

	return
end

function var_0_0.removeBuff(arg_45_0, arg_45_1)
	for iter_45_0 = #arg_45_0.buffs, 1, -1 do
		if arg_45_0.buffs[iter_45_0] == arg_45_1 then
			table = var_6

			local var_45_0 = var_6.remove(arg_45_0.buffs, iter_45_0)

			arg_45_0:disposeBuff(var_45_0)
		end
	end

	return
end

function var_0_0.disposeBuff(arg_46_0, arg_46_1)
	if #arg_46_1.effectTfs > 0 then
		for iter_46_0 = 1, #arg_46_1.effectTfs do
			Destroy = var_1_10006

			var_1_10006(arg_46_1.effectTfs[iter_46_0])
		end
	end

	arg_46_1.effectTfs = {}

	if #arg_46_1.triggerEffectTfs > 0 then
		for iter_46_1 = 1, #arg_46_1.triggerEffectTfs do
			Destroy = var_1_10006

			var_1_10006(arg_46_1.triggerEffectTfs[iter_46_1])
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

	BeachGuardConst = var_3

	local var_47_1 = var_3.buff[arg_47_1]

	var_47_0.effectTfs = {}

	if var_47_1.effect and #var_47_1.effect > 0 then
		ipairs = var_4

		for iter_47_1, iter_47_2 in var_4(var_47_1.effect) do
			BeachGuardConst = var_1_10009
			var_1_10009 = var_1_10009.effect[iter_47_2]
			BeachGuardAsset = var_1_10010
			var_1_10010 = var_1_10010.getEffect(var_1_10009.name)

			if var_1_10009.front then
				setParent = var_11

				var_11(var_1_10010, arg_47_0.effectFrontPos)
			else
				setParent = var_11

				var_11(var_1_10010, arg_47_0.effectBackPos)
			end

			setActive = var_11

			var_11(var_1_10010, true)

			Vector2 = var_11
			var_1_10010.anchoredPosition = var_11(0, 0)
			table = var_11

			var_11.insert(var_47_0.effectTfs, var_1_10010)
		end
	end

	var_47_0.triggerEffectTfs = {}

	if var_47_1.trigger_effect and #var_47_1.trigger_effect > 0 then
		ipairs = var_4

		for iter_47_3, iter_47_4 in var_4(var_47_1.trigger_effect) do
			BeachGuardConst = var_1_10009
			var_1_10009 = var_1_10009.effect[iter_47_4]
			BeachGuardAsset = var_1_10010
			var_1_10010 = var_1_10010.getEffect(var_1_10009.name)

			if var_1_10009.front then
				setParent = var_11

				var_11(var_1_10010, arg_47_0.effectFrontPos)
			else
				setParent = var_11

				var_11(var_1_10010, arg_47_0.effectBackPos)
			end

			setActive = var_11

			var_11(var_1_10010, true)

			Vector2 = var_11
			var_1_10010.anchoredPosition = var_11(0, 0)
			table = var_11

			var_11.insert(var_47_0.triggerEffectTfs, var_1_10010)
		end
	end

	var_47_0.times = 0
	var_47_0.time = 0
	var_47_0.config = var_47_1
	table = var_4

	var_4.insert(arg_47_0.buffs, var_47_0)

	return var_47_0
end

function var_0_0.getScore(arg_48_0)
	local var_48_0

	if not arg_48_0._config.score then
		var_48_0 = 0
	end

	return var_48_0
end

return var_0_0
