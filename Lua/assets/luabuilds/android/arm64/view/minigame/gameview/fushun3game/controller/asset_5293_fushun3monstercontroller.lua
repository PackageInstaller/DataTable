local Fushun3MonsterController = class("Fushun3MonsterController")

function Fushun3MonsterController:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self._tpl = arg_1_1
	self._parent = arg_1_2
	self._event = arg_1_4
	self._sceneTf = arg_1_3
	self.monsterDatas = {}

	for iter_1_0 = 1, #Fushun3GameConst.monster_data do
		table.insert(self.monsterDatas, Clone(Fushun3GameConst.monster_data[iter_1_0]))
	end

	self.monsters = {}
	self.monsterPool = {}

	return
end

function Fushun3MonsterController:setDiff(arg_2_1)
	return
end

function Fushun3MonsterController:start()
	self:clearMonster()

	return
end

function Fushun3MonsterController:step()
	for iter_4_0 = 1, #self.monsters do
		if not self.monsters[iter_4_0].damage then
			self.monsters[iter_4_0].rect:step()
		end
	end

	self:removeOutMonster()

	return
end

function Fushun3MonsterController:removeOutMonster()
	for iter_5_0 = #self.monsters, 1, -1 do
		if self.monsters[iter_5_0].tf.anchoredPosition.x <= math.abs(self._sceneTf.anchoredPosition.x) - 0 then
			self:returnMonsterToPool(table.remove(self.monsters, iter_5_0))
		end
	end

	return
end

function Fushun3MonsterController:createMonster(arg_6_1)
	local var_6_0 = self:getOrCreateMonster(self.monsterDatas[math.random(1, #self.monsterDatas)].id)

	if var_6_0 then
		var_6_0.damage = false

		setActive(var_6_0.tf, true)

		var_6_0.tf.position = arg_6_1
	end

	return
end

function Fushun3MonsterController:getOrCreateMonster(arg_7_1)
	local var_7_0

	for iter_7_0 = 1, #self.monsterPool do
		if self.monsterPool[iter_7_0].data.id == arg_7_1 then
			var_7_0 = table.remove(self.monsterPool, iter_7_0)

			table.insert(self.monsters, var_7_0)

			return var_7_0
		end
	end

	local var_7_1

	for iter_7_1 = 1, #self.monsterDatas do
		if self.monsterDatas[iter_7_1].id == arg_7_1 then
			var_7_1 = self.monsterDatas[iter_7_1]
		end
	end

	if var_7_1 then
		local var_7_2 = tf(instantiate(findTF(self._tpl, var_7_1.name)))

		var_7_2.localScale = Fushun3GameConst.game_scale_v3

		local var_7_3 = RectCollider.New(var_7_2, {}, self._event)

		var_7_3:addScript(FuShunMonsterScript.New())

		var_7_3:getCollisionInfo().config.moveSpeed = math.random(Fushun3GameConst.monster_speed[1], Fushun3GameConst.monster_speed[2])

		setParent(var_7_2, self._parent)

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
			self:removeMonster(var_7_0)

			return
		end)
		table.insert(self.monsters, var_7_0)
	end

	return var_7_0
end

function Fushun3MonsterController:checkPlayerDamage(arg_9_1, arg_9_2)
	for iter_9_0 = 1, #self.monsters do
		if self.monsters[iter_9_0].tf == arg_9_1 and self.monsters[iter_9_0].damage then
			arg_9_2(true)

			return
		end
	end

	arg_9_2(false)

	return
end

function Fushun3MonsterController:checkMonsterDamage(arg_10_1, arg_10_2, arg_10_3)
	for iter_10_0 = 1, #self.monsters do
		if not self.monsters[iter_10_0].damage and Fushun3GameConst.CheckBoxCollider(arg_10_1.bounds.min, self.monsters[iter_10_0].collider.bounds.min, arg_10_1.bounds.size, self.monsters[iter_10_0].collider.bounds.size) then
			self:damageMonster(self.monsters[iter_10_0].tf, arg_10_3)

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

function Fushun3MonsterController:damageMonster(arg_11_1, arg_11_2, arg_11_3)
	for iter_11_0 = #self.monsters, 1, -1 do
		if self.monsters[iter_11_0].tf == arg_11_1 then
			if not self.monsters[iter_11_0].damage then
				self.monsters[iter_11_0].damage = true

				if arg_11_2 == Fushun3GameEvent.power_damage_monster_call then
					self.monsters[iter_11_0].animator:SetTrigger("dmg_ex")
				elseif arg_11_2 == Fushun3GameEvent.shot_damage_monster_call then
					self.monsters[iter_11_0].animator:SetTrigger("dmg_la")
				elseif arg_11_2 == Fushun3GameEvent.kick_damage_monster_call then
					self.monsters[iter_11_0].animator:SetTrigger("dmg_jump")
				elseif arg_11_2 == Fushun3GameEvent.attack_damdage_monster_call then
					self.monsters[iter_11_0].animator:SetTrigger("dmg_attack")
				end

				self._event:emit(Fushun3GameEvent.add_monster_score_call)

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

function Fushun3MonsterController:removeMonster(arg_12_1)
	for iter_12_0 = 1, #self.monsters do
		if self.monsters[iter_12_0] == arg_12_1 then
			self:returnMonsterToPool(table.remove(self.monsters, iter_12_0))

			return
		end
	end

	return
end

function Fushun3MonsterController:returnMonsterToPool(arg_13_1)
	setActive(arg_13_1.tf, false)
	table.insert(self.monsterPool, arg_13_1)

	return
end

function Fushun3MonsterController:clearMonster()
	for iter_14_0 = #self.monsters, 1, -1 do
		self:returnMonsterToPool(table.remove(self.monsters, iter_14_0))
	end

	return
end

return Fushun3MonsterController
