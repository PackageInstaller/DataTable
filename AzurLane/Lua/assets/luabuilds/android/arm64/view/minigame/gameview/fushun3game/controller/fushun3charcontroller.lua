class = var_0_10000

local var_0_0 = var_0_10000("Fushun3CharController")
local var_0_1 = 3

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0._rectCollider = arg_1_1
	arg_1_0._charTf = arg_1_2
	findTF = var_1_10006
	arg_1_0._anim = var_1_10006(arg_1_0._charTf, "anim")
	findTF = var_6
	arg_1_0._pos = var_6(arg_1_0._charTf, "pos")
	findTF = var_6
	arg_1_0._itemPos = var_6(arg_1_0._charTf, "itemPos")
	GetOrAddComponent = var_6

	local var_1_0 = arg_1_0._anim

	typeof = var_9
	DftAniEvent = var_1_10011
	arg_1_0._dftEvent = var_6(var_1_0, var_9(var_1_10011))
	findTF = var_6
	arg_1_0._effectPos = var_6(arg_1_0._charTf, "effectPos")
	findTF = var_6
	arg_1_0._effectFrPos = var_6(arg_1_0._charTf, "effectFrPos")
	findTF = var_6
	arg_1_0._effectBkPos = var_6(arg_1_0._charTf, "effectBkPos")
	arg_1_0._powerSlider = arg_1_4
	findTF = var_6
	arg_1_0._collider = var_6(arg_1_0._charTf, "collider")

	local var_1_1 = arg_1_0._collider.gameObject

	LayerMask = var_1_10007
	var_1_1.layer = var_1_10007.NameToLayer("Character")

	local var_1_2 = arg_1_0._dftEvent

	var_6.SetTriggerEvent(var_1_2, function()
		local var_2_0
		local var_2_1 = arg_1_0._animator

		if var_1.GetCurrentAnimatorClipInfo(var_2_1, 0) and var_1.Length > 0 then
			ReflectionHelp = var_2

			local var_2_2 = var_2.RefGetProperty

			typeof = var_4
			var_2_0 = var_2_2(var_4("UnityEngine.AnimatorClipInfo"), "clip", var_1[0])
		end

		if var_2_0 then
			local var_2_3 = arg_1_0._event
			local var_2_4 = var_2.emit

			Fushun3GameEvent = var_2_10005

			var_2_4(var_2_3, var_2_10005.add_anim_effect_call, {
				clipName = var_2_0.name,
				targetTf = arg_1_0._effectPos
			})
		end

		return
	end)

	findTF = var_6
	arg_1_0._charItemCatchTf = var_6(arg_1_0._effectPos, "charItem")
	GetComponent = var_6
	findTF = var_8

	local var_1_3 = var_8(arg_1_0._charItemCatchTf, "catch")

	typeof = var_9
	Animator = var_11
	arg_1_0._charItemCatch = var_6(var_1_3, var_9(var_11))
	findTF = var_6
	arg_1_0._charShieldTf = var_6(arg_1_0._effectPos, "shield")
	arg_1_0._collisionInfo = arg_1_3
	arg_1_0._event = arg_1_5
	GetComponent = var_6

	local var_1_4 = arg_1_0._anim

	typeof = var_9
	Animator = var_11
	arg_1_0._animator = var_6(var_1_4, var_9(var_11))

	local var_1_5 = arg_1_0._rectCollider
	local var_1_6 = var_6.getScript

	FuShunPowerSpeedScript = var_9
	arg_1_0._powerScript = var_1_6(var_1_5, var_9)

	local var_1_7 = arg_1_0._rectCollider
	local var_1_8 = var_6.getScript

	FuShunJumpScript = var_9
	arg_1_0._jumpScript = var_1_8(var_1_7, var_9)

	local var_1_9 = arg_1_0._rectCollider
	local var_1_10 = var_6.getScript

	FuShunDamageScript = var_9
	arg_1_0._damageScript = var_1_10(var_1_9, var_9)

	local var_1_11 = arg_1_0._rectCollider
	local var_1_12 = var_6.getScript

	FuShunAttakeScript = var_9
	arg_1_0._attackScript = var_1_12(var_1_11, var_9)
	LayerMask = var_6
	arg_1_0._monsterLayer = var_6.NameToLayer("Character")
	findTF = var_6
	arg_1_0._damageTf = var_6(arg_1_0._charTf, "damage")
	GetComponent = var_6

	local var_1_13 = arg_1_0._damageTf

	typeof = var_9
	BoxCollider2D = var_11
	arg_1_0._damageCollider = var_6(var_1_13, var_9(var_11))
	arg_1_0._attackCd = nil

	local var_1_14 = arg_1_0._event
	local var_1_15 = var_6.bind

	Fushun3GameEvent = var_9

	var_1_15(var_1_14, var_9.script_jump_event, function()
		if arg_1_0._attackCd == 0 and arg_1_0.damageCd == 0 and arg_1_0._animator then
			local var_3_0 = arg_1_0._animator

			var_0.SetTrigger(var_3_0, "jump")

			pg = var_0

			local var_3_1 = var_0.CriMgr.GetInstance()
			local var_3_2 = var_0.PlaySoundEffect_V3

			SFX_JUMP = var_3

			var_3_2(var_3_1, var_3)
		end

		return
	end)

	local var_1_16 = arg_1_0._event
	local var_1_17 = var_6.bind

	Fushun3GameEvent = var_9

	var_1_17(var_1_16, var_9.script_attack_event, function()
		if arg_1_0._attackCd == 0 and arg_1_0.damageCd == 0 then
			local var_4_0 = arg_1_0._animator

			var_0.SetTrigger(var_4_0, "attack")

			local var_4_1 = arg_1_0

			Fushun3GameConst = var_2_10001
			var_4_1._attackCd = var_2_10001.attack_cd

			local var_4_2 = arg_1_0
			local var_4_3 = var_0.getBuff

			Fushun3GameConst = var_3

			local var_4_4, var_4_5, var_4_6

			if var_4_3(var_4_2, var_3.buff_weapon) then
				math = var_4_4
				var_4_4 = var_4_4.random(1, 30) == 1 and "tamachan" or "rocket"
				var_4_5 = arg_1_0._event
				var_4_6 = var_4_6.emit
				Fushun3GameEvent = var_2_10004

				var_4_6(var_4_5, var_2_10004.create_item_call, {
					name = var_4_4,
					pos = arg_1_0._itemPos.position
				})

				var_4_5 = arg_1_0._charItemCatch

				var_4_6.SetTrigger(var_4_5, "attack")
			else
				pg = var_4_4

				local var_4_7 = var_4_4.CriMgr.GetInstance()
				local var_4_8 = var_0.PlaySoundEffect_V3

				SFX_ATTACK = var_4_5

				var_4_8(var_4_7, var_4_5)

				local var_4_9 = arg_1_0

				Fushun3GameConst = var_4_6
				var_4_9._attackTime = var_4_6.attack_time
			end
		end

		return
	end)

	local var_1_18 = arg_1_0._event
	local var_1_19 = var_6.bind

	Fushun3GameEvent = var_9

	var_1_19(var_1_18, var_9.script_power_event, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0._animator

		var_3.SetTrigger(var_5_0, "ex")

		local var_5_1 = arg_1_0._charItemCatch

		var_3.SetTrigger(var_5_1, "ex")

		return
	end)

	arg_1_0.damageCd = 0
	arg_1_0.buffList = {}
	Application = var_6

	if var_6.isEditor then
		if not arg_1_0.handle then
			UpdateBeat = var_6
			arg_1_0.handle = var_6:CreateListener(function()
				Input = var_2_10000

				local var_6_0 = var_2_10000.GetKeyDown

				KeyCode = var_2_10002

				local var_6_1

				if var_6_0(var_2_10002.Y) then
					var_6_1 = 1

					local var_6_2 = arg_1_0

					var_2_10001 = var_2_10001.getBuffById
					Fushun3GameConst = var_2_10004

					if var_2_10001(var_6_2, var_2_10004.buff_data[var_6_1].id) then
						local var_6_3 = arg_1_0

						var_2_10001 = var_2_10001.removeBuff
						Clone = var_2_10004
						Fushun3GameConst = var_2_10006

						var_2_10001(var_6_3, var_2_10004(var_2_10006.buff_data[var_6_1]))
					else
						local var_6_4 = arg_1_0

						var_2_10001 = var_2_10001.addBuff
						Clone = var_2_10004
						Fushun3GameConst = var_2_10006

						var_2_10001(var_6_4, var_2_10004(var_2_10006.buff_data[var_6_1]))
					end
				else
					Input = var_6_1

					local var_6_5 = var_6_1.GetKeyDown

					KeyCode = var_2

					local var_6_6, var_6_8

					if var_6_5(var_2.U) then
						var_6_6 = 2
						Fushun3GameConst = var_2_10001

						local var_6_7 = var_2_10001.buff_data[var_6_6]

						var_2_10004 = arg_1_0

						if var_6_8.getBuffById(var_2_10004, var_6_7.id) then
							var_2_10004 = arg_1_0
							var_6_8 = var_6_8.removeBuff
							Clone = var_5
							Fushun3GameConst = var_2_10007

							var_6_8(var_2_10004, var_5(var_2_10007.buff_data[var_6_6]))
						else
							var_2_10004 = arg_1_0
							var_6_8 = var_6_8.addBuff
							Clone = var_5
							Fushun3GameConst = var_2_10007

							var_6_8(var_2_10004, var_5(var_2_10007.buff_data[var_6_6]))
						end
					else
						Input = var_6_6

						local var_6_9 = var_6_6.GetKeyDown

						KeyCode = var_6_8

						local var_6_10

						if var_6_9(var_6_8.I) then
							var_6_10 = 4

							local var_6_11 = arg_1_0
							local var_6_12 = var_1.getBuffById

							Fushun3GameConst = var_2_10004

							if var_6_12(var_6_11, var_2_10004.buff_data[var_6_10].id) then
								local var_6_13 = arg_1_0
								local var_6_14 = var_1.removeBuff

								Clone = var_2_10004
								Fushun3GameConst = var_2_10006

								var_6_14(var_6_13, var_2_10004(var_2_10006.buff_data[var_6_10]))
							else
								local var_6_15 = arg_1_0
								local var_6_16 = var_1.addBuff

								Clone = var_2_10004
								Fushun3GameConst = var_2_10006

								var_6_16(var_6_15, var_2_10004(var_2_10006.buff_data[var_6_10]))
							end
						else
							Input = var_6_10

							local var_6_17 = var_6_10.GetKeyDown

							KeyCode = var_2

							if var_6_17(var_2.O) then
								local var_6_18 = 5
								local var_6_19 = arg_1_0
								local var_6_20 = var_1.addBuff

								Clone = var_2_10004
								Fushun3GameConst = var_2_10006

								var_6_20(var_6_19, var_2_10004(var_2_10006.buff_data[var_6_18]))
							end
						end
					end
				end

				return
			end, arg_1_0)
		end

		UpdateBeat = var_6

		var_6:AddListener(arg_1_0.handle, arg_1_0)
	end

	return
end

function var_0_0.start(arg_7_0)
	local var_7_0 = arg_7_0._animator

	var_1.SetBool(var_7_0, "la", false)

	local var_7_1 = arg_7_0._animator

	var_1.SetBool(var_7_1, "s", false)

	local var_7_2 = arg_7_0._animator

	var_1.SetBool(var_7_2, "below", arg_7_0._collisionInfo.below)

	Fushun3GameConst = var_1
	arg_7_0._attackCd = var_1.attack_cd

	local var_7_3 = arg_7_0._charTf

	Fushun3GameConst = var_1_10002
	var_7_3.anchoredPosition = var_1_10002.char_init_pos
	arg_7_0.buffList = {}
	arg_7_0._attackTime = 0
	arg_7_0.power = 0
	arg_7_0._powerTime = 0
	arg_7_0.powerFlag = false
	arg_7_0.shieldNum = 0

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_0.updateBuffShow

	Fushun3GameConst = var_4

	var_7_5(var_7_4, var_4.buff_shield)

	Fushun3GameConst = var_7_5
	arg_7_0.heart = var_7_5.heart_num
	setActive = var_1

	var_1(arg_7_0._charItemCatchTf, false)

	return
end

function var_0_0.step(arg_8_0)
	if arg_8_0._charTf.anchoredPosition.y >= 1200 or arg_8_0._charTf.anchoredPosition.y <= -200 then
		local var_8_0 = arg_8_0._powerTime

		if 0 < var_8_0 then
			local var_8_1 = arg_8_0._charTf

			Vector2 = var_2
			var_8_1.anchoredPosition = var_2(arg_8_0._charTf.anchoredPosition.x + 100, 1000)
		else
			var_1_10003 = arg_8_0._event

			local var_8_2 = var_1.emit

			Fushun3GameEvent = var_1_10004

			var_8_2(var_1_10003, var_1_10004.game_over_call)
		end

		return
	end

	local var_8_3 = arg_8_0._powerSlider
	local var_8_4 = arg_8_0.power

	Fushun3GameConst = var_1_10003
	var_8_3.value = var_8_4 / var_1_10003.power_max_num

	local var_8_5 = arg_8_0._animator

	var_1.SetBool(var_8_5, "below", arg_8_0._collisionInfo.below)

	local var_8_6 = arg_8_0._collisionInfo
	local var_8_7 = var_1.getVelocity(var_8_6)
	local var_8_8 = arg_8_0._animator

	var_2.SetFloat(var_8_8, "moveAmountX", var_8_7.x)

	local var_8_9 = arg_8_0._animator

	var_2.SetFloat(var_8_9, "moveAmountY", var_8_7.y)

	local var_8_10 = arg_8_0._attackCd

	if 0 < var_8_10 then
		local var_8_11 = arg_8_0._attackCd

		Time = var_3
		arg_8_0._attackCd = var_8_11 - var_3.deltaTime
		arg_8_0._attackCd = arg_8_0._attackCd < 0 and 0 or arg_8_0._attackCd
	end

	local var_8_12 = arg_8_0._powerTime

	if 0 < var_8_12 then
		local var_8_13 = arg_8_0._powerTime

		Time = var_3
		arg_8_0._powerTime = var_8_13 - var_3.deltaTime

		if arg_8_0._powerTime < 0 then
			arg_8_0._powerTime = 0
		end
	end

	for iter_8_0 = #arg_8_0.buffList, 1, -1 do
		if arg_8_0.buffList[iter_8_0].time then
			local var_8_14 = var_6.time

			Time = var_1_10008
			var_6.time = var_8_14 - var_1_10008.deltaTime

			if var_6.time <= 0 then
				var_1_10009 = arg_8_0

				arg_8_0.removeBuff(var_1_10009, var_6)
			end
		end
	end

	local var_8_15 = {}

	pairs = var_3

	for iter_8_1, iter_8_2 in var_3(arg_8_0._collisionInfo.horizontalLeftTfs) do
		table = var_1_10008

		var_1_10008.insert(var_8_15, iter_8_2)
	end

	pairs = var_3

	for iter_8_3, iter_8_4 in var_3(arg_8_0._collisionInfo.horizontalRightTfs) do
		table = var_1_10008

		var_1_10008.insert(var_8_15, iter_8_4)
	end

	local var_8_16 = {}

	pairs = var_4

	for iter_8_10, iter_8_6 in var_4(arg_8_0._collisionInfo.verticalBottomTfs) do
		table = var_1_10009

		var_1_10009.insert(var_8_16, iter_8_6)
	end

	if #var_8_15 > 0 then
		local var_8_17 = arg_8_0
		local var_8_18 = arg_8_0.getBuff

		Fushun3GameConst = iter_8_10

		if var_8_18(var_8_17, iter_8_10.buff_power_speed) then
			for iter_8_10 = 1, #var_8_15 do
				go = iter_8_6

				if iter_8_6(var_8_15[iter_8_10]).layer == arg_8_0._monsterLayer then
					var_1_10010 = arg_8_0._event
					iter_8_6 = iter_8_6.emit
					Fushun3GameEvent = var_1_10011

					iter_8_6(var_1_10010, var_1_10011.power_damage_monster_call, {
						tf = var_8_15[iter_8_10]
					})
				end
			end
		else
			for iter_8_10 = 1, #var_8_15 do
				if arg_8_0._powerTime == 0 then
					go = iter_8_6

					if iter_8_6(var_8_15[iter_8_10]).layer == arg_8_0._monsterLayer and arg_8_0.damageCd == 0 then
						var_1_10010 = arg_8_0._event
						iter_8_6 = iter_8_6.emit
						Fushun3GameEvent = var_1_10011

						iter_8_6(var_1_10010, var_1_10011.check_player_damage, {
							tf = var_8_15[iter_8_10],
							callback = function(arg_9_0)
								if not arg_9_0 then
									local var_9_0 = arg_8_0

									var_1.damageChar(var_9_0)
								end

								return
							end
						})

						goto label_8_0
					end
				end

				findTF = iter_8_6

				if iter_8_6(var_8_15[iter_8_10], "high_roof") then
					setActive = var_1_10009
					findTF = var_1_10011

					var_1_10009(var_1_10011(var_8_15[iter_8_10], "high_roof"), false)

					var_1_10011 = arg_8_0._collisionInfo

					var_1_10009.changeVelocity(var_1_10011, 0, arg_8_0._collisionInfo.config.minJumpVelocity, nil)

					if arg_8_0._powerTime == 0 and arg_8_0.damageCd == 0 then
						var_1_10011 = arg_8_0

						arg_8_0.damageChar(var_1_10011)
					end
				end

				::label_8_0::
			end
		end
	elseif var_8_16 and #var_8_16 > 0 then
		for iter_8_10 = 1, #var_8_16 do
			go = iter_8_6

			if iter_8_6(var_8_16[iter_8_10]).layer == arg_8_0._monsterLayer then
				var_1_10010 = arg_8_0
				iter_8_6 = arg_8_0.getBuff
				Fushun3GameConst = var_1_10011

				if iter_8_6(var_1_10010, var_1_10011.buff_speed) then
					var_1_10010 = arg_8_0._event
					iter_8_6 = iter_8_6.emit
					Fushun3GameEvent = var_1_10011

					iter_8_6(var_1_10010, var_1_10011.kick_damage_monster_call, {
						tf = var_8_16[iter_8_10],
						callback = function(arg_10_0)
							if arg_10_0 then
								local var_10_0 = arg_8_0._collisionInfo

								var_1.changeVelocity(var_10_0, nil, arg_8_0._collisionInfo.config.minJumpVelocity, nil)
							end

							return
						end
					})
				else
					var_1_10010 = arg_8_0._event
					iter_8_6 = iter_8_6.emit
					Fushun3GameEvent = var_1_10011

					iter_8_6(var_1_10010, var_1_10011.check_player_damage, {
						tf = var_8_15[iter_8_10],
						callback = function(arg_11_0)
							if not arg_11_0 then
								local var_11_0 = arg_8_0

								var_1.damageChar(var_11_0)
							end

							return
						end
					})
				end
			end
		end
	end

	local var_8_19 = arg_8_0

	arg_8_0.flushBuff(var_8_19)

	local var_8_20 = arg_8_0.damageCd

	if 0 < var_8_20 then
		local var_8_21 = arg_8_0.damageCd

		Time = var_5
		arg_8_0.damageCd = var_8_21 - var_5.deltaTime
		arg_8_0.damageCd = arg_8_0.damageCd <= 0 and 0 or arg_8_0.damageCd
	end

	local var_8_22 = arg_8_0._attackTime

	if 0 < var_8_22 then
		var_8_19 = arg_8_0._event

		local var_8_23 = var_4.emit

		Fushun3GameEvent = iter_8_10

		var_8_23(var_8_19, iter_8_10.player_attack_call, {
			collider = arg_8_0._damageCollider,
			callback = function(arg_12_0)
				if arg_12_0 then
					local var_12_0 = arg_8_0._event
					local var_12_1 = var_1.emit

					Fushun3GameEvent = var_2_10004

					var_12_1(var_12_0, var_2_10004.add_effect_call, {
						effectName = "EF_fr_Attack",
						targetTf = arg_8_0._effectPos
					})
				end

				return
			end
		})

		local var_8_24 = arg_8_0._attackTime

		Time = var_5
		arg_8_0._attackTime = var_8_24 - var_5.deltaTime
		arg_8_0._attackTime = arg_8_0._attackTime <= 0 and 0 or arg_8_0._attackTime
	end

	local var_8_25 = arg_8_0.power

	Fushun3GameConst = var_5

	if var_8_25 == var_5.power_max_num and not arg_8_0.powerFlag then
		local var_8_26 = arg_8_0._charTf.anchoredPosition.y

		if 200 <= var_8_26 then
			arg_8_0.powerFlag = true
			var_8_19 = arg_8_0._event

			local var_8_27 = var_4.emit

			Fushun3GameEvent = iter_8_10

			var_8_27(var_8_19, iter_8_10.power_speed_call)

			if not arg_8_0.powerBuff then
				local var_8_28 = 1

				Fushun3GameConst = var_8_31

				for iter_8_10 = var_8_28, #var_8_31.buff_data do
					Fushun3GameConst = iter_8_6
					iter_8_6 = iter_8_6.buff_data[iter_8_10].buff
					Fushun3GameConst = var_1_10009

					if iter_8_6 == var_1_10009.buff_power_speed then
						Clone = iter_8_6
						Fushun3GameConst = var_1_10010
						arg_8_0.powerBuff = iter_8_6(var_1_10010.buff_data[iter_8_10])
					end
				end
			end

			var_8_19 = arg_8_0

			local var_8_29 = arg_8_0.addBuff

			Clone = iter_8_10

			var_8_29(var_8_19, iter_8_10(arg_8_0.powerBuff))
		end
	end

	local var_8_31

	if arg_8_0.powerFlag then
		local var_8_30 = arg_8_0.power

		Fushun3GameConst = var_8_31
		var_8_31 = var_8_31.power_sub_time
		Time = var_8_19
		arg_8_0.power = var_8_30 - var_8_31 * var_8_19.deltaTime

		if arg_8_0.power <= 0 then
			arg_8_0.power = 0
			arg_8_0.powerFlag = false

			local var_8_32 = arg_8_0
			local var_8_33 = arg_8_0.removeBuff

			Clone = iter_8_10

			var_8_33(var_8_32, iter_8_10(arg_8_0.powerBuff))
		end
	else
		local var_8_34 = arg_8_0.power

		Fushun3GameConst = var_8_31

		if var_8_34 >= var_8_31.power_max_num then
			Fushun3GameConst = var_8_34
			arg_8_0.power = var_8_34.power_max_num
		end
	end

	return
end

function var_0_0.jump(arg_13_0)
	local var_13_0 = arg_13_0._jumpScript

	if var_1.checkScirptApply(var_13_0) then
		local var_13_1 = arg_13_0._jumpScript

		var_1.active(var_13_1, true)
	end

	return
end

function var_0_0.attack(arg_14_0)
	local var_14_0 = arg_14_0._attackScript

	if var_1.checkScirptApply(var_14_0) then
		local var_14_1 = arg_14_0._attackScript

		var_1.active(var_14_1, true)
	end

	return
end

function var_0_0.damageChar(arg_15_0)
	local var_15_0 = arg_15_0._damageScript

	if var_1.checkScirptApply(var_15_0) then
		local var_15_1 = arg_15_0._damageScript

		var_1.active(var_15_1, true)

		if arg_15_0.damageCd == 0 then
			local var_15_4, var_15_8

			if arg_15_0.shieldNum > 0 then
				arg_15_0.shieldNum = arg_15_0.shieldNum - 1

				local var_15_2 = arg_15_0._animator

				var_15_4.SetTrigger(var_15_2, "damage")

				local var_15_3 = arg_15_0

				var_15_4 = arg_15_0.updateBuffShow
				Fushun3GameConst = var_15_8

				var_15_4(var_15_3, var_15_8.buff_shield)

				local var_15_5 = arg_15_0._event

				var_15_4 = var_15_4.emit
				Fushun3GameEvent = var_15_8

				var_15_4(var_15_5, var_15_8.add_effect_call, {
					effectName = "EF_Barrier_Break",
					targetTf = arg_15_0._effectPos
				})
			else
				arg_15_0.heart = arg_15_0.heart - 1

				if arg_15_0.heart <= 0 then
					arg_15_0.heart = 0
				end

				if arg_15_0.heart == 0 then
					local var_15_6 = arg_15_0._animator

					var_15_4.SetTrigger(var_15_6, "down")
				elseif #arg_15_0.buffList > 0 then
					local var_15_7 = arg_15_0

					var_15_4 = arg_15_0.removeBuff
					var_15_8 = arg_15_0.buffList
					math = var_1_10005

					var_15_4(var_15_7, var_15_8[var_1_10005.random(1, #arg_15_0.buffList)], true)

					local var_15_9 = arg_15_0._animator

					var_15_4.SetTrigger(var_15_9, "respawn")
				else
					local var_15_10 = arg_15_0._animator

					var_15_4.SetTrigger(var_15_10, "damage")
				end
			end

			Fushun3GameConst = var_15_4
			arg_15_0.damageCd = var_15_4.damage_cd

			if arg_15_0._attackTime > 0 then
				arg_15_0._attackTime = 0
			end

			local var_15_11 = arg_15_0._event
			local var_15_12 = var_1.emit

			Fushun3GameEvent = var_15_8

			var_15_12(var_15_11, var_15_8.char_damaged_call)
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
	local var_19_0 = arg_19_1.buff_id
	local var_19_1
	local var_19_2 = 1

	Fushun3GameConst = var_1_10005

	for iter_19_0 = var_19_2, #var_1_10005.buff_data do
		Fushun3GameConst = var_1_10008

		if var_1_10008.buff_data[iter_19_0].id == var_19_0 then
			Fushun3GameConst = var_1_10008
			var_19_1 = var_1_10008.buff_data[iter_19_0]
		end
	end

	if var_19_1 then
		local var_19_3 = arg_19_0
		local var_19_4 = arg_19_0.addBuff

		Clone = iter_19_0

		var_19_4(var_19_3, iter_19_0(var_19_1))
	end

	return
end

function var_0_0.addBuff(arg_20_0, arg_20_1)
	for iter_20_0 = 1, #arg_20_0.buffList do
		if arg_20_0.buffList[iter_20_0].id == arg_20_1.id then
			var_1_10006 = arg_20_1.buff
			Fushun3GameConst = var_7

			if var_1_10006 == var_7.buff_shield then
				if arg_20_0.shieldNum == var_0_1 then
					return
				end
			else
				return
			end
		end
	end

	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.getItemTriggerFlag(var_20_0)
	local var_20_2 = arg_20_1.buff

	Fushun3GameConst = var_20_0

	if var_20_2 == var_20_0.buff_speed then
		local var_20_3 = arg_20_0._animator

		var_20_2.SetBool(var_20_3, "s", true)

		var_20_2 = arg_20_0._collisionInfo.config
		Fushun3GameConst = var_4
		var_20_2.moveSpeed = var_4.move_speed_shoose

		if not var_20_1 then
			local var_20_4 = arg_20_0._animator

			var_20_2.SetTrigger(var_20_4, "item")
		end
	else
		var_20_2 = arg_20_1.buff
		Fushun3GameConst = var_4

		if var_20_2 == var_4.buff_power_speed then
			local var_20_5 = arg_20_0._powerScript

			if var_20_2.checkScirptApply(var_20_5) then
				local var_20_6 = arg_20_0._powerScript

				var_20_2.active(var_20_6, true)

				local var_20_7 = arg_20_0._animator

				var_20_2.SetTrigger(var_20_7, "ex_on")

				local var_20_8 = arg_20_0._charItemCatch

				var_20_2.SetTrigger(var_20_8, "ex_on")
			end
		else
			var_20_2 = arg_20_1.buff
			Fushun3GameConst = var_4

			if var_20_2 == var_4.buff_weapon then
				local var_20_9 = arg_20_0._animator

				var_20_2.SetBool(var_20_9, "la", true)

				if not var_20_1 then
					local var_20_10 = arg_20_0._animator

					var_20_2.SetTrigger(var_20_10, "item")
				end
			else
				var_20_2 = arg_20_1.buff
				Fushun3GameConst = var_4

				if var_20_2 == var_4.buff_catch then
					setActive = var_20_2

					var_20_2(arg_20_0._charItemCatchTf, true)

					local var_20_11 = arg_20_0._charItemCatch

					var_20_2.SetTrigger(var_20_11, "ride")
				else
					var_20_2 = arg_20_1.buff
					Fushun3GameConst = var_4

					if var_20_2 == var_4.buff_shield then
						arg_20_0.shieldNum = arg_20_0.shieldNum + 1

						if arg_20_0.shieldNum > var_0_1 then
							arg_20_0.shieldNum = var_0_1
						end

						local var_20_12 = arg_20_0

						var_20_2 = arg_20_0.updateBuffShow
						Fushun3GameConst = var_1_10006

						var_20_2(var_20_12, var_1_10006.buff_shield)

						local var_20_13 = arg_20_0._event

						var_20_2 = var_20_2.emit
						Fushun3GameEvent = var_6

						var_20_2(var_20_13, var_6.add_effect_call, {
							effectName = "EF_Barrier_Get",
							targetTf = arg_20_0._effectPos
						})
					end
				end
			end
		end
	end

	table = var_20_2

	var_20_2.insert(arg_20_0.buffList, arg_20_1)

	return
end

function var_0_0.updateBuffShow(arg_21_0, arg_21_1)
	Fushun3GameConst = var_1_10002

	if arg_21_1 == var_1_10002.buff_shield then
		for iter_21_0 = 1, var_0_1 do
			local var_21_0 = iter_21_0

			findTF = var_1_10007

			local var_21_1 = arg_21_0._charShieldTf

			tostring = var_1_10010
			var_1_10007 = var_1_10007(var_21_1, var_1_10010(var_21_0))
			setActive = var_1_10008

			var_1_10008(var_1_10007, var_21_0 <= arg_21_0.shieldNum)

			setActive = var_1_10008
			findTF = var_1_10010

			local var_21_2 = arg_21_0._effectFrPos
			local var_21_3 = "Barrier/"

			tostring = var_1_10014

			var_1_10008(var_1_10010(var_21_2, var_21_3 .. var_1_10014(var_21_0)), arg_21_0.shieldNum == var_21_0)

			setActive = var_1_10008
			findTF = var_1_10010

			local var_21_4 = arg_21_0._effectBkPos
			local var_21_5 = "Barrier/"

			tostring = var_1_10014

			var_1_10008(var_1_10010(var_21_4, var_21_5 .. var_1_10014(var_21_0)), arg_21_0.shieldNum == var_21_0)
		end

		setActive = var_2

		var_2(arg_21_0._charShieldTf, false)

		setActive = var_2

		var_2(arg_21_0._charShieldTf, true)
	end

	return
end

function var_0_0.removeBuff(arg_22_0, arg_22_1, arg_22_2)
	for iter_22_0 = 1, #arg_22_0.buffList do
		if arg_22_0.buffList[iter_22_0].buff == arg_22_1.buff then
			local var_22_0 = arg_22_0
			local var_22_1 = arg_22_0.getItemTriggerFlag(var_22_0)
			local var_22_2 = var_7.buff

			Fushun3GameConst = var_22_0

			if var_22_2 == var_22_0.buff_speed then
				local var_22_3 = arg_22_0._animator

				var_22_2.SetBool(var_22_3, "s", false)

				var_22_2 = arg_22_0._collisionInfo.config
				Fushun3GameConst = var_10
				var_22_2.moveSpeed = var_10.move_speed

				if not var_22_1 and not arg_22_2 then
					local var_22_4 = arg_22_0._animator

					var_22_2.SetTrigger(var_22_4, "item")
				end
			else
				var_22_2 = var_7.buff
				Fushun3GameConst = var_10

				if var_22_2 == var_10.buff_power_speed then
					local var_22_5 = arg_22_0._powerScript

					var_22_2.active(var_22_5, false)

					local var_22_6 = arg_22_0._animator

					var_22_2.SetTrigger(var_22_6, "ex_off")

					local var_22_7 = arg_22_0._charItemCatch

					var_22_2.SetTrigger(var_22_7, "ex_off")

					Fushun3GameConst = var_22_2
					arg_22_0._powerTime = var_22_2.power_time
				else
					var_22_2 = var_7.buff
					Fushun3GameConst = var_10

					if var_22_2 == var_10.buff_weapon then
						local var_22_8 = arg_22_0._animator

						var_22_2.SetBool(var_22_8, "la", false)

						if not var_22_1 and not arg_22_2 then
							local var_22_9 = arg_22_0._animator

							var_22_2.SetTrigger(var_22_9, "item")
						end
					else
						var_22_2 = var_7.buff
						Fushun3GameConst = var_10

						if var_22_2 == var_10.buff_catch then
							setActive = var_22_2

							var_22_2(arg_22_0._charItemCatchTf, false)
						end
					end
				end
			end

			table = var_22_2

			var_22_2.remove(arg_22_0.buffList, iter_22_0)

			return
		end
	end

	return
end

function var_0_0.flushBuff(arg_23_0)
	for iter_23_0 = 1, #arg_23_0.buffList do
		local var_23_0 = arg_23_0.buffList[iter_23_0].buff

		Fushun3GameConst = var_1_10007

		if var_23_0 == var_1_10007.buff_speed then
			-- block empty
		else
			local var_23_1 = var_5.buff

			Fushun3GameConst = var_1_10007

			if var_23_1 == var_1_10007.buff_power_speed then
				-- block empty
			else
				local var_23_2 = var_5.buff

				Fushun3GameConst = var_1_10007

				if var_23_2 == var_1_10007.buff_weapon then
					-- block empty
				else
					local var_23_3 = var_5.buff

					Fushun3GameConst = var_1_10007

					if var_23_3 == var_1_10007.buff_catch then
						var_6.y = arg_23_0._charTf.anchoredPosition.y + arg_23_0._itemPos.anchoredPosition.y

						local var_23_4 = arg_23_0._event

						var_1_10007 = var_1_10007.emit
						Fushun3GameEvent = var_1_10010

						var_1_10007(var_23_4, var_1_10010.item_follow_call, {
							anchoredPos = var_6
						})
					end
				end
			end
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
	Application = var_1_10001

	if var_1_10001.isEditor then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_26_0.handle)

		arg_26_0.handle = nil
	end

	return
end

return var_0_0
