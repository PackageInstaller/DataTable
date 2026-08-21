local var_0_0 = class("BeatGameMapPlane", import(".BeatGameMapBase"))
local var_0_1 = 500
local var_0_2 = 0.1
local var_0_3 = 20

function var_0_0.onInit(arg_1_0)
	arg_1_0.touchTf = findTF(arg_1_0._tf, "touch")
	arg_1_0.flapTf = findTF(arg_1_0._tf, "flap")
	arg_1_0.touchTrigger = GetOrAddComponent(arg_1_0.touchTf, typeof(EventTriggerListener))
	arg_1_0.flapTrigger = GetOrAddComponent(arg_1_0.flapTf, typeof(EventTriggerListener))

	arg_1_0.touchTrigger:AddPointDownFunc(function()
		arg_1_0:keyTrigger("catch", "item_touch", "touch")

		return
	end)
	arg_1_0.flapTrigger:AddPointDownFunc(function()
		arg_1_0:keyTrigger("refuse", "item_flap", "flap")

		return
	end)
	arg_1_0._event:bind(MusicBeatGameEvent.KEY_CODE_DOWN, function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_1 == KeyCode.A then
			arg_1_0:keyTrigger("refuse", "item_flap", "flap")
		elseif arg_4_1 == KeyCode.D then
			arg_1_0:keyTrigger("catch", "item_touch", "touch")
		end

		return
	end)

	arg_1_0.leftSpine = GetComponent(findTF(arg_1_0._tf, "char_left/ad/char"), typeof(SpineAnimUI))
	arg_1_0.leftSpineSkeleton = findTF(arg_1_0._tf, "char_left/ad/char"):GetComponent("SkeletonGraphic")
	arg_1_0.rightSpine = GetComponent(findTF(arg_1_0._tf, "char_right/ad/char"), typeof(SpineAnimUI))
	arg_1_0.rightSpineSkeleton = findTF(arg_1_0._tf, "char_right/ad/char"):GetComponent("SkeletonGraphic")
	arg_1_0.emojiTf = findTF(arg_1_0._tf, "emoji")

	setActive(arg_1_0.emojiTf, false)

	arg_1_0.beatCount = findTF(arg_1_0._tf, "beat_count")

	setActive(arg_1_0.beatCount, true)
	arg_1_0:initData()
	arg_1_0:initPosition()
	arg_1_0:initItemMap()

	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.dymItems = {}
	arg_5_0.itemMap = {}
	arg_5_0.itemFinalMap = {}

	return
end

function var_0_0.initPosition(arg_6_0)
	arg_6_0.content = findTF(arg_6_0._tf, "content")
	arg_6_0.startTf = findTF(arg_6_0._tf, "content/start")
	arg_6_0.endTf = findTF(arg_6_0._tf, "content/end")
	arg_6_0.startPosition = arg_6_0.startTf.anchoredPosition

	return
end

function var_0_0.initItemMap(arg_7_0)
	local var_7_0 = arg_7_0._data.items

	for iter_7_0 = 1, #arg_7_0._data.items do
		local var_7_1 = var_7_0[iter_7_0].track_key

		if arg_7_0.itemMap[var_7_0[iter_7_0].track_key] == nil then
			arg_7_0.itemMap[var_7_1] = {}
		elseif arg_7_0.itemFinalMap[var_7_1] == nil then
			arg_7_0.itemFinalMap[var_7_1] = {}
		end

		if var_7_0[iter_7_0].final then
			table.insert(arg_7_0.itemFinalMap[var_7_1], var_7_0[iter_7_0])
		else
			table.insert(arg_7_0.itemMap[var_7_1], var_7_0[iter_7_0])
		end
	end

	return
end

function var_0_0.createDymItem(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getItemData(arg_8_1.track.key_flag, arg_8_1.final)
	local var_8_1 = arg_8_0:createItemTf(var_8_0.prefab)
	local var_8_2 = GetComponent(var_8_1, typeof(Animator))

	var_8_2.speed = 1

	table.insert(arg_8_0.dymItems, {
		check = true,
		data = var_8_0,
		tf = var_8_1,
		anim = var_8_2,
		track = arg_8_1.track
	})

	return
end

function var_0_0.getItemData(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2 and arg_9_0.itemFinalMap[arg_9_1] or arg_9_0.itemMap[arg_9_1]

	return var_9_0[math.random(1, #var_9_0)]
end

function var_0_0.createItemTf(arg_10_0, arg_10_1)
	local var_10_0 = tf(instantiate(findTF(arg_10_0._tf, arg_10_1)))

	setParent(var_10_0, arg_10_0.content)
	setActive(var_10_0, false)

	var_10_0.anchoredPosition = arg_10_0.startTf.anchoredPosition

	return var_10_0
end

function var_0_0.keyTrigger(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_0.finalEnd then
		return
	end

	if arg_11_0.triggerCd then
		return
	end

	arg_11_0.triggerCd = var_0_2

	arg_11_0:setCharAnimation(arg_11_0.leftSpine, arg_11_1, 0, function()
		arg_11_0:setCharAnimation(arg_11_0.leftSpine, "idle", 0)
		arg_11_0.leftSpineSkeleton:Update(Time.deltaTime)

		return
	end, function()
		local var_13_0 = arg_11_0:getCheckDymItem()

		if var_13_0 then
			arg_11_0._event:emit(MusicBeatGameEvent.TRACK_EVENT_MATCH, var_13_0.track, function(arg_14_0, arg_14_1)
				if arg_14_0 then
					var_13_0.trigger = true
					var_13_0.anim.speed = 1

					var_13_0.anim:Play(arg_11_2, -1)

					if var_13_0.data.act == arg_11_3 then
						var_13_0.typeMatch = true

						arg_11_0._event:emit(MusicBeatGameEvent.ADD_SCORE, {
							num = var_13_0.data.score
						})
						arg_11_0:setEmoji("success")
						arg_11_0:changeLife(1)
					else
						if var_13_0.data.act == "flap" and arg_11_3 ~= "flap" then
							var_13_0.typeMatch = false

							arg_11_0:setCharAnimation(arg_11_0.leftSpine, "shock", 0, function()
								arg_11_0:setCharAnimation(arg_11_0.leftSpine, "idle", 0)

								return
							end)
							arg_11_0:changeLife(-1)
						end

						arg_11_0:setEmoji("fail")
					end

					local var_14_0

					if var_13_0.typeMatch then
						if var_13_0.data.act == "flap" then
							var_14_0 = MusicBeatGameConst.sfx_plane_success_hit
						elseif var_13_0.data.act == "touch" then
							var_14_0 = MusicBeatGameConst.sfx_plane_success_touch
						end
					elseif var_13_0.data.act == "flap" then
						var_14_0 = MusicBeatGameConst.sfx_plane_faild_hit
					elseif var_13_0.data.act == "touch" then
						var_14_0 = MusicBeatGameConst.sfx_plane_faild_touch
					end

					if var_14_0 then
						print("play Effect sound " .. var_14_0)
						pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_14_0)
					end
				end

				return
			end)
		end

		return
	end)

	return
end

function var_0_0.onStart(arg_16_0)
	arg_16_0.triggerCd = nil
	arg_16_0.finalEnd = false

	onNextTick(function()
		if arg_16_0.leftSpine then
			arg_16_0.leftSpine:Resume()
		end

		if arg_16_0.rightSpine then
			arg_16_0.rightSpine:Resume()
		end

		return
	end)

	arg_16_0.lifeCount = var_0_3

	arg_16_0:changeLife(0)
	arg_16_0:setCharAnimation(arg_16_0.leftSpine, "idle", 0, function()
		return
	end, function()
		return
	end)
	arg_16_0:setCharAnimation(arg_16_0.rightSpine, "idle", 0, function()
		return
	end, function()
		return
	end)

	return
end

function var_0_0.onStartTrack(arg_22_0, arg_22_1)
	arg_22_0:createDymItem(arg_22_1)

	return
end

function var_0_0.onStep(arg_23_0)
	if arg_23_0.triggerCd then
		arg_23_0.triggerCd = arg_23_0.triggerCd - arg_23_0._gameVo.deltaTime

		if arg_23_0.triggerCd <= 0 then
			arg_23_0.triggerCd = nil
		end
	end

	local var_23_0 = arg_23_0._gameVo:getCriInfoTime()

	if var_23_0 ~= -1 then
		for iter_23_0 = #arg_23_0.dymItems, 1, -1 do
			local var_23_1 = arg_23_0.dymItems[iter_23_0]

			if arg_23_0.dymItems[iter_23_0] then
				if var_23_1.active then
					if var_23_1.track.begin_time <= var_23_0 and var_23_0 - var_23_1.track.begin_time > var_0_1 then
						var_23_1.active = false
						var_23_1.remove = true
					end

					if var_23_1.check and not var_23_1.trigger and var_23_0 - var_23_1.track.begin_time > MusicBeatGameConst.beat_offset then
						var_23_1.check = false

						if not var_23_1.trigger then
							arg_23_0:setEmoji("miss")

							if var_23_1.data.act == "flap" then
								arg_23_0:changeLife(-1)
							end
						end
					end
				elseif var_23_1.remove == true then
					if var_23_1.data.final then
						arg_23_0.finalEnd = true

						arg_23_0:setCharAnimation(arg_23_0.leftSpine, var_23_1.typeMatch and "final_correct" or "final_wrong", 0, function()
							arg_23_0.leftSpine:Pause()

							return
						end)
						arg_23_0:setCharAnimation(arg_23_0.rightSpine, var_23_2, 0, function()
							arg_23_0.rightSpine:Pause()

							return
						end)
					end

					local var_23_4 = table.remove(arg_23_0.dymItems, iter_23_0)

					Destroy(var_23_4.tf)

					var_23_4.tf = nil
					var_23_4.anim = nil
					var_23_4.track = nil

					return
				elseif var_23_1.track.begin_time - var_23_0 > 0 and var_23_1.track.begin_time - var_23_0 <= var_23_1.data.distance_time then
					arg_23_0:activeDymItem(var_23_1)
				elseif not var_23_1.throw and var_23_1.track.begin_time - var_23_0 > 0 and var_23_1.track.begin_time - var_23_0 <= var_23_1.data.distance_time + 100 then
					var_23_1.throw = true

					arg_23_0:setCharAnimation(arg_23_0.rightSpine, "throw", 0, function()
						arg_23_0:setCharAnimation(arg_23_0.rightSpine, "idle", 0, nil, nil)

						return
					end, nil)
				elseif var_23_1.track.begin_time - var_23_0 <= var_23_1.data.distance_time / 2 or var_23_1.track.begin_time <= var_23_0 and not var_23_1.active then
					var_23_1.remove = true
				end
			else
				warning("dymitem == nil")
			end
		end
	end

	return
end

function var_0_0.onStop(arg_27_0)
	for iter_27_0 = 1, #arg_27_0.dymItems do
		if arg_27_0.dymItems[iter_27_0].anim then
			arg_27_0.dymItems[iter_27_0].anim.speed = 0
		end
	end

	return
end

function var_0_0.onResume(arg_28_0)
	for iter_28_0 = 1, #arg_28_0.dymItems do
		if arg_28_0.dymItems[iter_28_0].anim then
			arg_28_0.dymItems[iter_28_0].anim.speed = 1
		end
	end

	return
end

function var_0_0.changeLife(arg_29_0, arg_29_1)
	arg_29_0.lifeCount = arg_29_0.lifeCount + arg_29_1

	if arg_29_0.lifeCount <= 0 then
		arg_29_0._event:emit(MusicBeatGameEvent.GAME_OVER)
	end

	setText(findTF(arg_29_0.beatCount, "text"), arg_29_0.lifeCount)

	return
end

function var_0_0.setEmoji(arg_30_0, arg_30_1)
	setActive(arg_30_0.emojiTf, false)
	arg_30_0:setChildVisible(findTF(arg_30_0.emojiTf, "ad"), false)

	if arg_30_1 then
		setActive(arg_30_0.emojiTf, true)
		setActive(findTF(arg_30_0.emojiTf, "ad/" .. arg_30_1), true)
	end

	return
end

function var_0_0.setChildVisible(arg_31_0, arg_31_1, arg_31_2)
	for iter_31_0 = 1, arg_31_1.childCount do
		setActive(arg_31_1:GetChild(iter_31_0 - 1), arg_31_2)
	end

	return
end

function var_0_0.getCheckDymItem(arg_32_0)
	for iter_32_0 = 1, #arg_32_0.dymItems do
		if arg_32_0.dymItems[iter_32_0].check and not arg_32_0.dymItems[iter_32_0].trigger then
			return arg_32_0.dymItems[iter_32_0]
		end
	end

	return nil
end

function var_0_0.activeDymItem(arg_33_0, arg_33_1)
	setActive(arg_33_1.tf, true)

	arg_33_1.active = true

	arg_33_1.anim:Play("item_fly", -1, 0)

	arg_33_1.anim.speed = 1

	return
end

function var_0_0.setCharAnimation(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)
	if arg_34_1 then
		arg_34_1:SetActionCallBack(nil)
		arg_34_1:SetActionCallBack(function(arg_35_0)
			if arg_35_0 == "finish" and arg_34_4 then
				arg_34_1:SetActionCallBack(nil)
				arg_34_4()
			elseif arg_35_0 == "action" and arg_34_5 then
				arg_34_5()
			end

			return
		end)
	end

	if arg_34_1 == arg_34_0.leftSpine then
		print("set action" .. arg_34_2)
	end

	arg_34_1:SetAction(arg_34_2, arg_34_3)

	return
end

function var_0_0.onClear(arg_36_0)
	for iter_36_0 = 1, #arg_36_0.dymItems do
		if arg_36_0.dymItems[iter_36_0].tf then
			Destroy(arg_36_0.dymItems[iter_36_0].tf)

			arg_36_0.dymItems[iter_36_0].tf = nil
			arg_36_0.dymItems[iter_36_0].anim = nil
		end
	end

	arg_36_0.dymItems = {}

	return
end

function var_0_0.onDispose(arg_37_0)
	return
end

return var_0_0
