local var_0_0 = class("Fushun3CharController")
local var_0_1 = 3

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0._rectCollider = arg_1_1
	arg_1_0._charTf = arg_1_2
	arg_1_0._anim = findTF(arg_1_0._charTf, "anim")
	arg_1_0._pos = findTF(arg_1_0._charTf, "pos")
	arg_1_0._itemPos = findTF(arg_1_0._charTf, "itemPos")
	arg_1_0._dftEvent = GetOrAddComponent(arg_1_0._anim, typeof(DftAniEvent))
	arg_1_0._effectPos = findTF(arg_1_0._charTf, "effectPos")
	arg_1_0._effectFrPos = findTF(arg_1_0._charTf, "effectFrPos")
	arg_1_0._effectBkPos = findTF(arg_1_0._charTf, "effectBkPos")
	arg_1_0._powerSlider = arg_1_4
	arg_1_0._collider = findTF(arg_1_0._charTf, "collider")
	arg_1_0._collider.gameObject.layer = LayerMask.NameToLayer("Character")

	arg_1_0._dftEvent:SetTriggerEvent(function()
		local var_2_0
		local var_2_1 = arg_1_0._animator:GetCurrentAnimatorClipInfo(0)

		if var_2_1 and var_2_1.Length > 0 then
			var_2_0 = ReflectionHelp.RefGetProperty(typeof("UnityEngine.AnimatorClipInfo"), "clip", var_2_1[0])
		end

		if var_2_0 then
			arg_1_0._event:emit(Fushun3GameEvent.add_anim_effect_call, {
				clipName = var_2_0.name,
				targetTf = arg_1_0._effectPos
			})
		end

		return
	end)

	arg_1_0._charItemCatchTf = findTF(arg_1_0._effectPos, "charItem")
	arg_1_0._charItemCatch = GetComponent(findTF(arg_1_0._charItemCatchTf, "catch"), typeof(Animator))
	arg_1_0._charShieldTf = findTF(arg_1_0._effectPos, "shield")
	arg_1_0._collisionInfo = arg_1_3
	arg_1_0._event = arg_1_5
	arg_1_0._animator = GetComponent(arg_1_0._anim, typeof(Animator))
	arg_1_0._powerScript = arg_1_0._rectCollider:getScript(FuShunPowerSpeedScript)
	arg_1_0._jumpScript = arg_1_0._rectCollider:getScript(FuShunJumpScript)
	arg_1_0._damageScript = arg_1_0._rectCollider:getScript(FuShunDamageScript)
	arg_1_0._attackScript = arg_1_0._rectCollider:getScript(FuShunAttakeScript)
	arg_1_0._monsterLayer = LayerMask.NameToLayer("Character")
	arg_1_0._damageTf = findTF(arg_1_0._charTf, "damage")
	arg_1_0._damageCollider = GetComponent(arg_1_0._damageTf, typeof(BoxCollider2D))
	arg_1_0._attackCd = nil

	arg_1_0._event:bind(Fushun3GameEvent.script_jump_event, function()
		if arg_1_0._attackCd == 0 and arg_1_0.damageCd == 0 and arg_1_0._animator then
			arg_1_0._animator:SetTrigger("jump")
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_JUMP)
		end

		return
	end)
	arg_1_0._event:bind(Fushun3GameEvent.script_attack_event, function()
		if arg_1_0._attackCd == 0 and arg_1_0.damageCd == 0 then
			arg_1_0._animator:SetTrigger("attack")

			arg_1_0._attackCd = Fushun3GameConst.attack_cd

			if arg_1_0:getBuff(Fushun3GameConst.buff_weapon) then
				arg_1_0._event:emit(Fushun3GameEvent.create_item_call, {
					name = math.random(1, 30) == 1 and "tamachan" or "rocket",
					pos = arg_1_0._itemPos.position
				})
				arg_1_0._charItemCatch:SetTrigger("attack")
			else
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_ATTACK)

				arg_1_0._attackTime = Fushun3GameConst.attack_time
			end
		end

		return
	end)
	arg_1_0._event:bind(Fushun3GameEvent.script_power_event, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0._animator:SetTrigger("ex")
		arg_1_0._charItemCatch:SetTrigger("ex")

		return
	end)

	arg_1_0.damageCd = 0
	arg_1_0.buffList = {}

	if Application.isEditor then
		arg_1_0.handle = arg_1_0.handle or UpdateBeat:CreateListener(function()
			if Input.GetKeyDown(KeyCode.Y) then
				if arg_1_0:getBuffById(Fushun3GameConst.buff_data[1].id) then
					arg_1_0:removeBuff(Clone(Fushun3GameConst.buff_data[1]))
				else
					arg_1_0:addBuff(Clone(Fushun3GameConst.buff_data[1]))
				end
			elseif Input.GetKeyDown(KeyCode.U) then
				if arg_1_0:getBuffById(Fushun3GameConst.buff_data[2].id) then
					arg_1_0:removeBuff(Clone(Fushun3GameConst.buff_data[2]))
				else
					arg_1_0:addBuff(Clone(Fushun3GameConst.buff_data[2]))
				end
			elseif Input.GetKeyDown(KeyCode.I) then
				if arg_1_0:getBuffById(Fushun3GameConst.buff_data[4].id) then
					arg_1_0:removeBuff(Clone(Fushun3GameConst.buff_data[4]))
				else
					arg_1_0:addBuff(Clone(Fushun3GameConst.buff_data[4]))
				end
			elseif Input.GetKeyDown(KeyCode.O) then
				arg_1_0:addBuff(Clone(Fushun3GameConst.buff_data[5]))
			end

			return
		end, arg_1_0)

		UpdateBeat:AddListener(arg_1_0.handle, arg_1_0)
	end

	return
end

function var_0_0.start(arg_7_0)
	arg_7_0._animator:SetBool("la", false)
	arg_7_0._animator:SetBool("s", false)
	arg_7_0._animator:SetBool("below", arg_7_0._collisionInfo.below)

	arg_7_0._attackCd = Fushun3GameConst.attack_cd
	arg_7_0._charTf.anchoredPosition = Fushun3GameConst.char_init_pos
	arg_7_0.buffList = {}
	arg_7_0._attackTime = 0
	arg_7_0.power = 0
	arg_7_0._powerTime = 0
	arg_7_0.powerFlag = false
	arg_7_0.shieldNum = 0

	arg_7_0:updateBuffShow(Fushun3GameConst.buff_shield)

	arg_7_0.heart = Fushun3GameConst.heart_num

	setActive(arg_7_0._charItemCatchTf, false)

	return
end

function var_0_0.step(arg_8_0)
	if arg_8_0._charTf.anchoredPosition.y >= 1200 or arg_8_0._charTf.anchoredPosition.y <= -200 then
		if arg_8_0._powerTime > 0 then
			arg_8_0._charTf.anchoredPosition = Vector2(arg_8_0._charTf.anchoredPosition.x + 100, 1000)
		else
			arg_8_0._event:emit(Fushun3GameEvent.game_over_call)
		end

		return
	end

	arg_8_0._powerSlider.value = arg_8_0.power / Fushun3GameConst.power_max_num

	arg_8_0._animator:SetBool("below", arg_8_0._collisionInfo.below)

	local var_8_0 = arg_8_0._collisionInfo:getVelocity()

	arg_8_0._animator:SetFloat("moveAmountX", var_8_0.x)
	arg_8_0._animator:SetFloat("moveAmountY", var_8_0.y)

	if arg_8_0._attackCd > 0 then
		arg_8_0._attackCd = arg_8_0._attackCd - Time.deltaTime
		arg_8_0._attackCd = arg_8_0._attackCd < 0 and 0 or arg_8_0._attackCd
	end

	if arg_8_0._powerTime > 0 then
		arg_8_0._powerTime = arg_8_0._powerTime - Time.deltaTime

		if arg_8_0._powerTime < 0 then
			arg_8_0._powerTime = 0
		end
	end

	for iter_8_0 = #arg_8_0.buffList, 1, -1 do
		if arg_8_0.buffList[iter_8_0].time then
			arg_8_0.buffList[iter_8_0].time = arg_8_0.buffList[iter_8_0].time - Time.deltaTime

			if arg_8_0.buffList[iter_8_0].time <= 0 then
				arg_8_0:removeBuff(arg_8_0.buffList[iter_8_0])
			end
		end
	end

	for iter_8_1, iter_8_2 in pairs(arg_8_0._collisionInfo.horizontalLeftTfs) do
		table.insert({}, iter_8_2)
	end

	for iter_8_3, iter_8_4 in pairs(arg_8_0._collisionInfo.horizontalRightTfs) do
		table.insert({}, iter_8_4)
	end

	for iter_8_5, iter_8_6 in pairs(arg_8_0._collisionInfo.verticalBottomTfs) do
		table.insert({}, iter_8_6)
	end

	if #{} > 0 then
		if arg_8_0:getBuff(Fushun3GameConst.buff_power_speed) then
			for iter_8_7 = 1, #{} do
				if go(({})[iter_8_7]).layer == arg_8_0._monsterLayer then
					arg_8_0._event:emit(Fushun3GameEvent.power_damage_monster_call, {
						tf = ({})[iter_8_7]
					})
				end
			end
		else
			for iter_8_8 = 1, #{} do
				if arg_8_0._powerTime == 0 and go(({})[iter_8_8]).layer == arg_8_0._monsterLayer and arg_8_0.damageCd == 0 then
					arg_8_0._event:emit(Fushun3GameEvent.check_player_damage, {
						tf = ({})[iter_8_8],
						callback = function(arg_9_0)
							if not arg_9_0 then
								arg_8_0:damageChar()
							end

							return
						end
					})
				elseif findTF(({})[iter_8_8], "high_roof") then
					setActive(findTF(({})[iter_8_8], "high_roof"), false)
					arg_8_0._collisionInfo:changeVelocity(0, arg_8_0._collisionInfo.config.minJumpVelocity, nil)

					if arg_8_0._powerTime == 0 and arg_8_0.damageCd == 0 then
						arg_8_0:damageChar()
					end
				end
			end
		end
	elseif {} and #{} > 0 then
		for iter_8_9 = 1, #{} do
			if go(({})[iter_8_9]).layer == arg_8_0._monsterLayer then
				if arg_8_0:getBuff(Fushun3GameConst.buff_speed) then
					arg_8_0._event:emit(Fushun3GameEvent.kick_damage_monster_call, {
						tf = ({})[iter_8_9],
						callback = function(arg_10_0)
							if arg_10_0 then
								arg_8_0._collisionInfo:changeVelocity(nil, arg_8_0._collisionInfo.config.minJumpVelocity, nil)
							end

							return
						end
					})
				else
					arg_8_0._event:emit(Fushun3GameEvent.check_player_damage, {
						tf = ({})[iter_8_9],
						callback = function(arg_11_0)
							if not arg_11_0 then
								arg_8_0:damageChar()
							end

							return
						end
					})
				end
			end
		end
	end

	arg_8_0:flushBuff()

	if arg_8_0.damageCd > 0 then
		arg_8_0.damageCd = arg_8_0.damageCd - Time.deltaTime
		arg_8_0.damageCd = arg_8_0.damageCd <= 0 and 0 or arg_8_0.damageCd
	end

	if arg_8_0._attackTime > 0 then
		arg_8_0._event:emit(Fushun3GameEvent.player_attack_call, {
			collider = arg_8_0._damageCollider,
			callback = function(arg_12_0)
				if arg_12_0 then
					arg_8_0._event:emit(Fushun3GameEvent.add_effect_call, {
						effectName = "EF_fr_Attack",
						targetTf = arg_8_0._effectPos
					})
				end

				return
			end
		})

		arg_8_0._attackTime = arg_8_0._attackTime - Time.deltaTime
		arg_8_0._attackTime = arg_8_0._attackTime <= 0 and 0 or arg_8_0._attackTime
	end

	if arg_8_0.power == Fushun3GameConst.power_max_num and not arg_8_0.powerFlag and arg_8_0._charTf.anchoredPosition.y >= 200 then
		arg_8_0.powerFlag = true

		arg_8_0._event:emit(Fushun3GameEvent.power_speed_call)

		if not arg_8_0.powerBuff then
			for iter_8_10 = 1, #Fushun3GameConst.buff_data do
				if Fushun3GameConst.buff_data[iter_8_10].buff == Fushun3GameConst.buff_power_speed then
					arg_8_0.powerBuff = Clone(Fushun3GameConst.buff_data[iter_8_10])
				end
			end
		end

		arg_8_0:addBuff(Clone(arg_8_0.powerBuff))
	end

	if arg_8_0.powerFlag then
		arg_8_0.power = arg_8_0.power - Fushun3GameConst.power_sub_time * Time.deltaTime

		if arg_8_0.power <= 0 then
			arg_8_0.power = 0
			arg_8_0.powerFlag = false

			arg_8_0:removeBuff(Clone(arg_8_0.powerBuff))
		end
	elseif arg_8_0.power >= Fushun3GameConst.power_max_num then
		arg_8_0.power = Fushun3GameConst.power_max_num
	end

	return
end

function var_0_0.jump(arg_13_0)
	if arg_13_0._jumpScript:checkScirptApply() then
		arg_13_0._jumpScript:active(true)
	end

	return
end

function var_0_0.attack(arg_14_0)
	if arg_14_0._attackScript:checkScirptApply() then
		arg_14_0._attackScript:active(true)
	end

	return
end

function var_0_0.damageChar(arg_15_0)
	if arg_15_0._damageScript:checkScirptApply() then
		arg_15_0._damageScript:active(true)

		if arg_15_0.damageCd == 0 then
			if arg_15_0.shieldNum > 0 then
				arg_15_0.shieldNum = arg_15_0.shieldNum - 1

				arg_15_0._animator:SetTrigger("damage")
				arg_15_0:updateBuffShow(Fushun3GameConst.buff_shield)
				arg_15_0._event:emit(Fushun3GameEvent.add_effect_call, {
					effectName = "EF_Barrier_Break",
					targetTf = arg_15_0._effectPos
				})
			else
				arg_15_0.heart = arg_15_0.heart - 1

				if arg_15_0.heart <= 0 then
					arg_15_0.heart = 0
				end

				if arg_15_0.heart == 0 then
					arg_15_0._animator:SetTrigger("down")
				elseif #arg_15_0.buffList > 0 then
					arg_15_0:removeBuff(arg_15_0.buffList[math.random(1, #arg_15_0.buffList)], true)
					arg_15_0._animator:SetTrigger("respawn")
				else
					arg_15_0._animator:SetTrigger("damage")
				end
			end

			arg_15_0.damageCd = Fushun3GameConst.damage_cd

			if arg_15_0._attackTime > 0 then
				arg_15_0._attackTime = 0
			end

			arg_15_0._event:emit(Fushun3GameEvent.char_damaged_call)
		end
	end

	return
end

function var_0_0.addPower(arg_16_0, arg_16_1)
	if not arg_16_0.powerFlag then
		arg_16_0.power = arg_16_0.power + arg_16_1
	end

	return
end

function var_0_0.getBuff(arg_17_0, arg_17_1)
	for iter_17_0 = 1, #arg_17_0.buffList do
		if arg_17_0.buffList[iter_17_0].buff == arg_17_1 then
			return arg_17_0.buffList[iter_17_0]
		end
	end

	return nil
end

function var_0_0.getBuffById(arg_18_0, arg_18_1)
	for iter_18_0 = 1, #arg_18_0.buffList do
		if arg_18_0.buffList[iter_18_0].id == arg_18_1 then
			return arg_18_0.buffList[iter_18_0]
		end
	end

	return nil
end

function var_0_0.setBuff(arg_19_0, arg_19_1)
	local var_19_0

	for iter_19_0 = 1, #Fushun3GameConst.buff_data do
		if Fushun3GameConst.buff_data[iter_19_0].id == arg_19_1.buff_id then
			var_19_0 = Fushun3GameConst.buff_data[iter_19_0]
		end
	end

	if var_19_0 then
		arg_19_0:addBuff(Clone(var_19_0))
	end

	return
end

function var_0_0.addBuff(arg_20_0, arg_20_1)
	for iter_20_0 = 1, #arg_20_0.buffList do
		if arg_20_0.buffList[iter_20_0].id == arg_20_1.id then
			if arg_20_1.buff == Fushun3GameConst.buff_shield then
				if arg_20_0.shieldNum == var_0_1 then
					return
				end
			else
				return
			end
		end
	end

	local var_20_0 = arg_20_0:getItemTriggerFlag()

	if arg_20_1.buff == Fushun3GameConst.buff_speed then
		arg_20_0._animator:SetBool("s", true)

		arg_20_0._collisionInfo.config.moveSpeed = Fushun3GameConst.move_speed_shoose

		if not var_20_0 then
			arg_20_0._animator:SetTrigger("item")
		end
	elseif arg_20_1.buff == Fushun3GameConst.buff_power_speed then
		if arg_20_0._powerScript:checkScirptApply() then
			arg_20_0._powerScript:active(true)
			arg_20_0._animator:SetTrigger("ex_on")
			arg_20_0._charItemCatch:SetTrigger("ex_on")
		end
	elseif arg_20_1.buff == Fushun3GameConst.buff_weapon then
		arg_20_0._animator:SetBool("la", true)

		if not var_20_0 then
			arg_20_0._animator:SetTrigger("item")
		end
	elseif arg_20_1.buff == Fushun3GameConst.buff_catch then
		setActive(arg_20_0._charItemCatchTf, true)
		arg_20_0._charItemCatch:SetTrigger("ride")
	elseif arg_20_1.buff == Fushun3GameConst.buff_shield then
		arg_20_0.shieldNum = arg_20_0.shieldNum + 1

		if arg_20_0.shieldNum > var_0_1 then
			arg_20_0.shieldNum = var_0_1
		end

		arg_20_0:updateBuffShow(Fushun3GameConst.buff_shield)
		arg_20_0._event:emit(Fushun3GameEvent.add_effect_call, {
			effectName = "EF_Barrier_Get",
			targetTf = arg_20_0._effectPos
		})
	end

	table.insert(arg_20_0.buffList, arg_20_1)

	return
end

function var_0_0.updateBuffShow(arg_21_0, arg_21_1)
	if arg_21_1 == Fushun3GameConst.buff_shield then
		for iter_21_0 = 1, var_0_1 do
			local var_21_0 = iter_21_0

			setActive(findTF(arg_21_0._charShieldTf, tostring(iter_21_0)), iter_21_0 <= arg_21_0.shieldNum)
			setActive(findTF(arg_21_0._effectFrPos, "Barrier/" .. tostring(var_21_0)), arg_21_0.shieldNum == var_21_0)
			setActive(findTF(arg_21_0._effectBkPos, "Barrier/" .. tostring(var_21_0)), arg_21_0.shieldNum == var_21_0)
		end

		setActive(arg_21_0._charShieldTf, false)
		setActive(arg_21_0._charShieldTf, true)
	end

	return
end

function var_0_0.removeBuff(arg_22_0, arg_22_1, arg_22_2)
	for iter_22_0 = 1, #arg_22_0.buffList do
		if arg_22_0.buffList[iter_22_0].buff == arg_22_1.buff then
			local var_22_0 = arg_22_0:getItemTriggerFlag()

			if arg_22_0.buffList[iter_22_0].buff == Fushun3GameConst.buff_speed then
				arg_22_0._animator:SetBool("s", false)

				arg_22_0._collisionInfo.config.moveSpeed = Fushun3GameConst.move_speed

				if not var_22_0 and not arg_22_2 then
					arg_22_0._animator:SetTrigger("item")
				end
			elseif arg_22_0.buffList[iter_22_0].buff == Fushun3GameConst.buff_power_speed then
				arg_22_0._powerScript:active(false)
				arg_22_0._animator:SetTrigger("ex_off")
				arg_22_0._charItemCatch:SetTrigger("ex_off")

				arg_22_0._powerTime = Fushun3GameConst.power_time
			elseif arg_22_0.buffList[iter_22_0].buff == Fushun3GameConst.buff_weapon then
				arg_22_0._animator:SetBool("la", false)

				if not var_22_0 and not arg_22_2 then
					arg_22_0._animator:SetTrigger("item")
				end
			elseif arg_22_0.buffList[iter_22_0].buff == Fushun3GameConst.buff_catch then
				setActive(arg_22_0._charItemCatchTf, false)
			end

			table.remove(arg_22_0.buffList, iter_22_0)

			return
		end
	end

	return
end

function var_0_0.flushBuff(arg_23_0)
	for iter_23_0 = 1, #arg_23_0.buffList do
		if arg_23_0.buffList[iter_23_0].buff == Fushun3GameConst.buff_speed then
			-- block empty
		elseif arg_23_0.buffList[iter_23_0].buff == Fushun3GameConst.buff_power_speed then
			-- block empty
		elseif arg_23_0.buffList[iter_23_0].buff == Fushun3GameConst.buff_weapon then
			-- block empty
		elseif arg_23_0.buffList[iter_23_0].buff == Fushun3GameConst.buff_catch then
			arg_23_0._charTf.anchoredPosition.y = arg_23_0._charTf.anchoredPosition.y + arg_23_0._itemPos.anchoredPosition.y

			arg_23_0._event:emit(Fushun3GameEvent.item_follow_call, {
				anchoredPos = arg_23_0._charTf.anchoredPosition
			})
		end
	end

	return
end

function var_0_0.getHeart(arg_24_0)
	return arg_24_0.heart
end

function var_0_0.getItemTriggerFlag(arg_25_0)
	for iter_25_0 = 1, #arg_25_0.buffList do
		if arg_25_0.buffList[iter_25_0].lock_item then
			return true
		end
	end

	return false
end

function var_0_0.dispose(arg_26_0)
	if Application.isEditor then
		UpdateBeat:RemoveListener(arg_26_0.handle)

		arg_26_0.handle = nil
	end

	return
end

return var_0_0
