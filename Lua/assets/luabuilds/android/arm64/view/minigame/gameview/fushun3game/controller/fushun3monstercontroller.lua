local var_0_0 = class("Fushun3MonsterController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._tpl = arg_1_1
	arg_1_0._parent = arg_1_2
	arg_1_0._event = arg_1_4
	arg_1_0._sceneTf = arg_1_3
	arg_1_0.monsterDatas = {}

	for iter_1_0 = 1, #Fushun3GameConst.monster_data do
		table.insert(arg_1_0.monsterDatas, Clone(Fushun3GameConst.monster_data[iter_1_0]))
	end

	arg_1_0.monsters = {}
	arg_1_0.monsterPool = {}

	return
end

function var_0_0.setDiff(arg_2_0, arg_2_1)
	return
end

function var_0_0.start(arg_3_0)
	arg_3_0:clearMonster()

	return
end

function var_0_0.step(arg_4_0)
	for iter_4_0 = 1, #arg_4_0.monsters do
		if not arg_4_0.monsters[iter_4_0].damage then
			arg_4_0.monsters[iter_4_0].rect:step()
		end
	end

	arg_4_0:removeOutMonster()

	return
end

function var_0_0.removeOutMonster(arg_5_0)
	for iter_5_0 = #arg_5_0.monsters, 1, -1 do
		if arg_5_0.monsters[iter_5_0].tf.anchoredPosition.x <= math.abs(arg_5_0._sceneTf.anchoredPosition.x) - 0 then
			arg_5_0:returnMonsterToPool(table.remove(arg_5_0.monsters, iter_5_0))
		end
	end

	return
end

function var_0_0.createMonster(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getOrCreateMonster(arg_6_0.monsterDatas[math.random(1, #arg_6_0.monsterDatas)].id)

	if var_6_0 then
		var_6_0.damage = false

		setActive(var_6_0.tf, true)

		var_6_0.tf.position = arg_6_1
	end

	return
end

function var_0_0.getOrCreateMonster(arg_7_0, arg_7_1)
	local var_7_0

	for iter_7_0 = 1, #arg_7_0.monsterPool do
		if arg_7_0.monsterPool[iter_7_0].data.id == arg_7_1 then
			var_7_0 = table.remove(arg_7_0.monsterPool, iter_7_0)

			table.insert(arg_7_0.monsters, var_7_0)

			return var_7_0
		end
	end

	local var_7_1

	for iter_7_1 = 1, #arg_7_0.monsterDatas do
		if arg_7_0.monsterDatas[iter_7_1].id == arg_7_1 then
			var_7_1 = arg_7_0.monsterDatas[iter_7_1]
		end
	end

	if var_7_1 then
		local var_7_2 = tf(instantiate(findTF(arg_7_0._tpl, var_7_1.name)))

		var_7_2.localScale = Fushun3GameConst.game_scale_v3

		local var_7_3 = RectCollider.New(var_7_2, {}, arg_7_0._event)

		var_7_3:addScript(FuShunMonsterScript.New())

		var_7_3:getCollisionInfo().config.moveSpeed = math.random(Fushun3GameConst.monster_speed[1], Fushun3GameConst.monster_speed[2])

		setParent(var_7_2, arg_7_0._parent)

		findTF(var_7_2, "collider").gameObject.layer = LayerMask.NameToLayer("Character")
		findTF(var_7_2, "collider3D").gameObject.layer = LayerMask.NameToLayer("Character")
		var_7_2.gameObject.layer = LayerMask.NameToLayer("Character")
		var_7_0 = {
			tf = var_7_2,
			data = var_7_1,
			rect = var_7_3,
			animator = GetComponent(findTF(var_7_2, "anim"), typeof(Animator)),
			collider = GetComponent(findTF(var_7_2, "collider"), typeof(BoxCollider2D))
		}

		GetComponent(findTF(var_7_2, "anim"), typeof(DftAniEvent)):SetEndEvent(function()
			arg_7_0:removeMonster(var_7_0)

			return
		end)
		table.insert(arg_7_0.monsters, var_7_0)
	end

	return var_7_0
end

function var_0_0.checkPlayerDamage(arg_9_0, arg_9_1, arg_9_2)
	for iter_9_0 = 1, #arg_9_0.monsters do
		if arg_9_0.monsters[iter_9_0].tf == arg_9_1 and arg_9_0.monsters[iter_9_0].damage then
			arg_9_2(true)

			return
		end
	end

	arg_9_2(false)

	return
end

function var_0_0.checkMonsterDamage(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	for iter_10_0 = 1, #arg_10_0.monsters do
		if not arg_10_0.monsters[iter_10_0].damage and Fushun3GameConst.CheckBoxCollider(arg_10_1.bounds.min, arg_10_0.monsters[iter_10_0].collider.bounds.min, arg_10_1.bounds.size, arg_10_0.monsters[iter_10_0].collider.bounds.size) then
			arg_10_0:damageMonster(arg_10_0.monsters[iter_10_0].tf, arg_10_3)

			if arg_10_2 then
				arg_10_2(true)
			end

			return
		end
	end

	if arg_10_2 then
		arg_10_2(false)
	end

	return
end

function var_0_0.damageMonster(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	for iter_11_0 = #arg_11_0.monsters, 1, -1 do
		if arg_11_0.monsters[iter_11_0].tf == arg_11_1 then
			if not arg_11_0.monsters[iter_11_0].damage then
				arg_11_0.monsters[iter_11_0].damage = true

				if arg_11_2 == Fushun3GameEvent.power_damage_monster_call then
					arg_11_0.monsters[iter_11_0].animator:SetTrigger("dmg_ex")
				elseif arg_11_2 == Fushun3GameEvent.shot_damage_monster_call then
					arg_11_0.monsters[iter_11_0].animator:SetTrigger("dmg_la")
				elseif arg_11_2 == Fushun3GameEvent.kick_damage_monster_call then
					arg_11_0.monsters[iter_11_0].animator:SetTrigger("dmg_jump")
				elseif arg_11_2 == Fushun3GameEvent.attack_damdage_monster_call then
					arg_11_0.monsters[iter_11_0].animator:SetTrigger("dmg_attack")
				end

				arg_11_0._event:emit(Fushun3GameEvent.add_monster_score_call)

				if arg_11_3 then
					arg_11_3(true)
				end
			end

			return
		end
	end

	if arg_11_3 then
		arg_11_3(false)
	end

	return
end

function var_0_0.removeMonster(arg_12_0, arg_12_1)
	for iter_12_0 = 1, #arg_12_0.monsters do
		if arg_12_0.monsters[iter_12_0] == arg_12_1 then
			arg_12_0:returnMonsterToPool(table.remove(arg_12_0.monsters, iter_12_0))

			return
		end
	end

	return
end

function var_0_0.returnMonsterToPool(arg_13_0, arg_13_1)
	setActive(arg_13_1.tf, false)
	table.insert(arg_13_0.monsterPool, arg_13_1)

	return
end

function var_0_0.clearMonster(arg_14_0)
	for iter_14_0 = #arg_14_0.monsters, 1, -1 do
		arg_14_0:returnMonsterToPool(table.remove(arg_14_0.monsters, iter_14_0))
	end

	return
end

return var_0_0
