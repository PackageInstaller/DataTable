class = var_0_10000

local var_0_0 = var_0_10000("Fushun3MonsterController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._tpl = arg_1_1
	arg_1_0._parent = arg_1_2
	arg_1_0._event = arg_1_4
	arg_1_0._sceneTf = arg_1_3
	arg_1_0.monsterDatas = {}

	local var_1_0 = 1

	Fushun3GameConst = var_1_10006

	for iter_1_0 = var_1_0, #var_1_10006.monster_data do
		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		local var_1_1 = arg_1_0.monsterDatas

		Clone = var_1_10012
		Fushun3GameConst = var_1_10014

		var_1_10009(var_1_1, var_1_10012(var_1_10014.monster_data[iter_1_0]))
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
			local var_4_0 = arg_4_0.monsters[iter_4_0].rect

			var_5.step(var_4_0)
		end
	end

	arg_4_0:removeOutMonster()

	return
end

function var_0_0.removeOutMonster(arg_5_0)
	for iter_5_0 = #arg_5_0.monsters, 1, -1 do
		local var_5_0 = arg_5_0.monsters[iter_5_0].tf.anchoredPosition.x

		math = var_1_10007

		if var_5_0 <= var_1_10007.abs(arg_5_0._sceneTf.anchoredPosition.x) - 0 then
			local var_5_1 = arg_5_0
			local var_5_2 = arg_5_0.returnMonsterToPool

			table = var_9

			var_5_2(var_5_1, var_9.remove(arg_5_0.monsters, iter_5_0))
		end
	end

	return
end

function var_0_0.createMonster(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.monsterDatas

	math = var_1_10003

	local var_6_1 = var_6_0[var_1_10003.random(1, #arg_6_0.monsterDatas)]

	if arg_6_0:getOrCreateMonster(var_6_1.id) then
		var_3.damage = false
		setActive = var_4

		var_4(var_3.tf, true)

		var_3.tf.position = arg_6_1
	end

	return
end

function var_0_0.getOrCreateMonster(arg_7_0, arg_7_1)
	local var_7_0

	for iter_7_0 = 1, #arg_7_0.monsterPool do
		if arg_7_0.monsterPool[iter_7_0].data.id == arg_7_1 then
			table = var_7
			var_7_0 = var_7.remove(arg_7_0.monsterPool, iter_7_0)
			table = var_7

			var_7.insert(arg_7_0.monsters, var_7_0)

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
		local var_7_2 = var_7_1.name

		tf = var_5
		instantiate = iter_7_1
		findTF = var_1_10009

		local var_7_3 = var_5(iter_7_1(var_1_10009(arg_7_0._tpl, var_7_2)))

		Fushun3GameConst = var_6
		var_7_3.localScale = var_6.game_scale_v3
		RectCollider = var_6

		local var_7_4 = var_6.New(var_7_3, {}, arg_7_0._event)
		local var_7_5 = var_6.addScript

		FuShunMonsterScript = var_10

		var_7_5(var_7_4, var_10.New())

		local var_7_6 = var_6
		local var_7_7 = var_6.getCollisionInfo(var_7_6).config

		math = var_8

		local var_7_8 = var_8.random

		Fushun3GameConst = var_10

		local var_7_9 = var_10.monster_speed[1]

		Fushun3GameConst = var_11
		var_7_7.moveSpeed = var_7_8(var_7_9, var_11.monster_speed[2])
		GetComponent = var_7_7
		findTF = var_7_6

		local var_7_10 = var_7_6(var_7_3, "anim")

		typeof = var_7_9
		Animator = var_12

		local var_7_11 = var_7_7(var_7_10, var_7_9(var_12))

		setParent = var_8

		var_8(var_7_3, arg_7_0._parent)

		GetComponent = var_8
		findTF = var_10

		local var_7_12 = var_10(var_7_3, "collider")

		typeof = var_11
		BoxCollider2D = var_13

		local var_7_13 = var_8(var_7_12, var_11(var_13))

		findTF = var_7_10

		local var_7_14 = var_7_10(var_7_3, "collider").gameObject

		LayerMask = var_7_12
		var_7_14.layer = var_7_12.NameToLayer("Character")
		findTF = var_7_14

		local var_7_15 = var_7_14(var_7_3, "collider3D").gameObject

		LayerMask = var_10
		var_7_15.layer = var_10.NameToLayer("Character")

		local var_7_16 = var_7_3.gameObject

		LayerMask = var_10
		var_7_16.layer = var_10.NameToLayer("Character")
		var_7_0 = {
			tf = var_7_3,
			data = var_7_1,
			rect = var_6,
			animator = var_7_11,
			collider = var_7_13
		}
		GetComponent = var_9
		findTF = var_11

		local var_7_17 = var_11(var_7_3, "anim")

		typeof = var_12
		DftAniEvent = var_14

		local var_7_18 = var_9(var_7_17, var_12(var_14))

		var_9.SetEndEvent(var_7_18, function()
			local var_8_0 = arg_7_0

			var_0.removeMonster(var_8_0, var_7_0)

			return
		end)

		table = var_10

		var_10.insert(arg_7_0.monsters, var_7_0)
	end

	return var_7_0
end

function var_0_0.checkPlayerDamage(arg_9_0, arg_9_1, arg_9_2)
	for iter_9_0 = 1, #arg_9_0.monsters do
		if arg_9_0.monsters[iter_9_0].tf == arg_9_1 and var_7.damage then
			arg_9_2(true)

			return
		end
	end

	arg_9_2(false)

	return
end

function var_0_0.checkMonsterDamage(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_1.bounds

	for iter_10_0 = 1, #arg_10_0.monsters do
		local var_10_1 = arg_10_0.monsters[iter_10_0].collider.bounds

		if not var_9.damage then
			Fushun3GameConst = var_11

			if var_11.CheckBoxCollider(var_10_0.min, var_10_1.min, var_10_0.size, var_10_1.size) then
				arg_10_0:damageMonster(var_9.tf, arg_10_3)

				if arg_10_2 then
					arg_10_2(true)
				end

				return
			end
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
				var_8.damage = true
				Fushun3GameEvent = var_9

				if arg_11_2 == var_9.power_damage_monster_call then
					local var_11_0 = var_8.animator

					var_9.SetTrigger(var_11_0, "dmg_ex")
				else
					Fushun3GameEvent = var_9

					if arg_11_2 == var_9.shot_damage_monster_call then
						local var_11_1 = var_8.animator

						var_9.SetTrigger(var_11_1, "dmg_la")
					else
						Fushun3GameEvent = var_9

						if arg_11_2 == var_9.kick_damage_monster_call then
							local var_11_2 = var_8.animator

							var_9.SetTrigger(var_11_2, "dmg_jump")
						else
							Fushun3GameEvent = var_9

							if arg_11_2 == var_9.attack_damdage_monster_call then
								local var_11_3 = var_8.animator

								var_9.SetTrigger(var_11_3, "dmg_attack")
							end
						end
					end
				end

				local var_11_4 = arg_11_0._event
				local var_11_5 = var_9.emit

				Fushun3GameEvent = var_1_10012

				var_11_5(var_11_4, var_1_10012.add_monster_score_call)

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
			local var_12_0 = arg_12_0
			local var_12_1 = arg_12_0.returnMonsterToPool

			table = var_1_10009

			var_12_1(var_12_0, var_1_10009.remove(arg_12_0.monsters, iter_12_0))

			return
		end
	end

	return
end

function var_0_0.returnMonsterToPool(arg_13_0, arg_13_1)
	setActive = var_1_10002

	var_1_10002(arg_13_1.tf, false)

	table = var_1_10002

	var_1_10002.insert(arg_13_0.monsterPool, arg_13_1)

	return
end

function var_0_0.clearMonster(arg_14_0)
	for iter_14_0 = #arg_14_0.monsters, 1, -1 do
		local var_14_0 = arg_14_0
		local var_14_1 = arg_14_0.returnMonsterToPool

		table = var_1_10008

		var_14_1(var_14_0, var_1_10008.remove(arg_14_0.monsters, iter_14_0))
	end

	return
end

return var_0_0
