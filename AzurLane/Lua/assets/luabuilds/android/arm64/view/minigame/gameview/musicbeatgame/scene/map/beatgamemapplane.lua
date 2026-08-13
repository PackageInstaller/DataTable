class = var_0_10000

local var_0_0 = "BeatGameMapPlane"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BeatGameMapBase"))
local var_0_2 = 500
local var_0_3 = 0.1
local var_0_4 = 20

function var_0_1.onInit(arg_1_0)
	findTF = var_1_10001
	arg_1_0.touchTf = var_1_10001(arg_1_0._tf, "touch")
	findTF = var_1
	arg_1_0.flapTf = var_1(arg_1_0._tf, "flap")
	GetOrAddComponent = var_1

	local var_1_0 = arg_1_0.touchTf

	typeof = var_4
	EventTriggerListener = var_1_10006
	arg_1_0.touchTrigger = var_1(var_1_0, var_4(var_1_10006))
	GetOrAddComponent = var_1

	local var_1_1 = arg_1_0.flapTf

	typeof = var_4
	EventTriggerListener = var_1_10006
	arg_1_0.flapTrigger = var_1(var_1_1, var_4(var_1_10006))

	local var_1_2 = arg_1_0.touchTrigger

	var_1.AddPointDownFunc(var_1_2, function()
		local var_2_0 = arg_1_0

		var_0.keyTrigger(var_2_0, "catch", "item_touch", "touch")

		return
	end)

	local var_1_3 = arg_1_0.flapTrigger

	var_1.AddPointDownFunc(var_1_3, function()
		local var_3_0 = arg_1_0

		var_0.keyTrigger(var_3_0, "refuse", "item_flap", "flap")

		return
	end)

	local var_1_4 = arg_1_0._event
	local var_1_5 = var_1.bind

	MusicBeatGameEvent = var_4

	var_1_5(var_1_4, var_4.KEY_CODE_DOWN, function(arg_4_0, arg_4_1, arg_4_2)
		KeyCode = var_2_10003

		if arg_4_1 == var_2_10003.A then
			local var_4_0 = arg_1_0

			var_3.keyTrigger(var_4_0, "refuse", "item_flap", "flap")
		else
			KeyCode = var_3

			if arg_4_1 == var_3.D then
				local var_4_1 = arg_1_0

				var_3.keyTrigger(var_4_1, "catch", "item_touch", "touch")
			end
		end

		return
	end)

	GetComponent = var_1_5
	findTF = var_1_4

	local var_1_6 = var_1_4(arg_1_0._tf, "char_left/ad/char")

	typeof = var_4
	SpineAnimUI = var_6
	arg_1_0.leftSpine = var_1_5(var_1_6, var_4(var_6))
	findTF = var_1

	local var_1_7 = var_1(arg_1_0._tf, "char_left/ad/char")

	arg_1_0.leftSpineSkeleton = var_1.GetComponent(var_1_7, "SkeletonGraphic")
	GetComponent = var_1
	findTF = var_1_7

	local var_1_8 = var_1_7(arg_1_0._tf, "char_right/ad/char")

	typeof = var_4
	SpineAnimUI = var_6
	arg_1_0.rightSpine = var_1(var_1_8, var_4(var_6))
	findTF = var_1

	local var_1_9 = var_1(arg_1_0._tf, "char_right/ad/char")

	arg_1_0.rightSpineSkeleton = var_1.GetComponent(var_1_9, "SkeletonGraphic")
	findTF = var_1
	arg_1_0.emojiTf = var_1(arg_1_0._tf, "emoji")
	setActive = var_1

	var_1(arg_1_0.emojiTf, false)

	findTF = var_1
	arg_1_0.beatCount = var_1(arg_1_0._tf, "beat_count")
	setActive = var_1

	var_1(arg_1_0.beatCount, true)
	arg_1_0:initData()
	arg_1_0:initPosition()
	arg_1_0:initItemMap()

	return
end

function var_0_1.initData(arg_5_0)
	arg_5_0.dymItems = {}
	arg_5_0.itemMap = {}
	arg_5_0.itemFinalMap = {}

	return
end

function var_0_1.initPosition(arg_6_0)
	findTF = var_1_10001
	arg_6_0.content = var_1_10001(arg_6_0._tf, "content")
	findTF = var_1
	arg_6_0.startTf = var_1(arg_6_0._tf, "content/start")
	findTF = var_1
	arg_6_0.endTf = var_1(arg_6_0._tf, "content/end")
	arg_6_0.startPosition = arg_6_0.startTf.anchoredPosition

	return
end

function var_0_1.initItemMap(arg_7_0)
	local var_7_0 = arg_7_0._data.items

	for iter_7_0 = 1, #var_7_0 do
		local var_7_1 = var_7_0[iter_7_0].track_key

		if arg_7_0.itemMap[var_7_1] == nil then
			arg_7_0.itemMap[var_7_1] = {}
		elseif arg_7_0.itemFinalMap[var_7_1] == nil then
			arg_7_0.itemFinalMap[var_7_1] = {}
		end

		if var_7_0[iter_7_0].final then
			table = var_7

			var_7.insert(arg_7_0.itemFinalMap[var_7_1], var_7_0[iter_7_0])
		else
			table = var_7

			var_7.insert(arg_7_0.itemMap[var_7_1], var_7_0[iter_7_0])
		end
	end

	return
end

function var_0_1.createDymItem(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.track
	local var_8_1 = arg_8_1.final
	local var_8_2 = arg_8_0
	local var_8_3 = arg_8_0.getItemData(var_8_2, var_8_0.key_flag, var_8_1)
	local var_8_4 = arg_8_0:createItemTf(var_8_3.prefab)

	GetComponent = var_8_2

	local var_8_5 = var_8_4

	typeof = var_1_10009
	Animator = var_1_10011

	local var_8_6 = var_8_2(var_8_5, var_1_10009(var_1_10011))

	var_8_6.speed = 1
	table = var_7

	var_7.insert(arg_8_0.dymItems, {
		check = true,
		data = var_8_3,
		tf = var_8_4,
		anim = var_8_6,
		track = var_8_0
	})

	return
end

function var_0_1.getItemData(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0

	if arg_9_2 then
		var_9_0 = arg_9_0.itemFinalMap[arg_9_1]
	else
		var_9_0 = arg_9_0.itemMap[arg_9_1]
	end

	math = var_1_10004

	return var_9_0[var_1_10004.random(1, #var_9_0)]
end

function var_0_1.createItemTf(arg_10_0, arg_10_1)
	tf = var_1_10002
	instantiate = var_1_10004
	findTF = var_1_10006

	local var_10_0 = var_1_10002(var_1_10004(var_1_10006(arg_10_0._tf, arg_10_1)))

	setParent = var_1_10003

	var_1_10003(var_10_0, arg_10_0.content)

	setActive = var_1_10003

	var_1_10003(var_10_0, false)

	var_10_0.anchoredPosition = arg_10_0.startTf.anchoredPosition

	return var_10_0
end

function var_0_1.keyTrigger(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_0.finalEnd then
		return
	end

	if arg_11_0.triggerCd then
		return
	end

	arg_11_0.triggerCd = var_0_3

	arg_11_0:setCharAnimation(arg_11_0.leftSpine, arg_11_1, 0, function()
		local var_12_0 = arg_11_0

		var_0.setCharAnimation(var_12_0, arg_11_0.leftSpine, "idle", 0)

		local var_12_1 = arg_11_0.leftSpineSkeleton
		local var_12_2 = var_0.Update

		Time = var_3

		var_12_2(var_12_1, var_3.deltaTime)

		return
	end, function()
		local var_13_0 = arg_11_0

		if var_0.getCheckDymItem(var_13_0) then
			local var_13_1 = arg_11_0._event
			local var_13_2 = var_1.emit

			MusicBeatGameEvent = var_2_10004

			var_13_2(var_13_1, var_2_10004.TRACK_EVENT_MATCH, var_0.track, function(arg_14_0, arg_14_1)
				if arg_14_0 then
					var_0.trigger = true
					var_0.anim.speed = 1

					local var_14_0 = var_0.anim

					var_2.Play(var_14_0, arg_11_2, -1)

					if var_0.data.act == arg_11_3 then
						var_0.typeMatch = true

						local var_14_1 = arg_11_0._event
						local var_14_2 = var_2.emit

						MusicBeatGameEvent = var_5

						var_14_2(var_14_1, var_5.ADD_SCORE, {
							num = var_0.data.score
						})

						local var_14_3 = arg_11_0

						var_2.setEmoji(var_14_3, "success")

						local var_14_4 = arg_11_0

						var_2.changeLife(var_14_4, 1)
					else
						if var_0.data.act == "flap" and arg_11_3 ~= "flap" then
							var_0.typeMatch = false

							local var_14_5 = arg_11_0

							var_2.setCharAnimation(var_14_5, arg_11_0.leftSpine, "shock", 0, function()
								local var_15_0 = arg_11_0

								var_0.setCharAnimation(var_15_0, arg_11_0.leftSpine, "idle", 0)

								return
							end)

							local var_14_6 = arg_11_0

							var_2.changeLife(var_14_6, -1)
						end

						local var_14_7 = arg_11_0

						var_2.setEmoji(var_14_7, "fail")
					end

					local var_14_8

					if var_0.typeMatch then
						if var_0.data.act == "flap" then
							MusicBeatGameConst = var_3
							var_14_8 = var_3.sfx_plane_success_hit
						elseif var_0.data.act == "touch" then
							MusicBeatGameConst = var_3
							var_14_8 = var_3.sfx_plane_success_touch
						end
					elseif var_0.data.act == "flap" then
						MusicBeatGameConst = var_3
						var_14_8 = var_3.sfx_plane_faild_hit
					elseif var_0.data.act == "touch" then
						MusicBeatGameConst = var_3
						var_14_8 = var_3.sfx_plane_faild_touch
					end

					if var_14_8 then
						print = var_3

						var_3("play Effect sound " .. var_14_8)

						pg = var_3

						local var_14_9 = var_3.CriMgr.GetInstance()

						var_3.PlaySoundEffect_V3(var_14_9, var_14_8)
					end
				end

				return
			end)
		end

		return
	end)

	return
end

function var_0_1.onStart(arg_16_0)
	arg_16_0.triggerCd = nil
	arg_16_0.finalEnd = false
	onNextTick = var_1

	var_1(function()
		if arg_16_0.leftSpine then
			local var_17_0 = arg_16_0.leftSpine

			var_0.Resume(var_17_0)
		end

		if arg_16_0.rightSpine then
			local var_17_1 = arg_16_0.rightSpine

			var_0.Resume(var_17_1)
		end

		return
	end)

	arg_16_0.lifeCount = var_0_4

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

function var_0_1.onStartTrack(arg_22_0, arg_22_1)
	arg_22_0:createDymItem(arg_22_1)

	return
end

function var_0_1.onStep(arg_23_0)
	if arg_23_0.triggerCd then
		arg_23_0.triggerCd = arg_23_0.triggerCd - arg_23_0._gameVo.deltaTime

		if arg_23_0.triggerCd <= 0 then
			arg_23_0.triggerCd = nil
		end
	end

	local var_23_0 = arg_23_0._gameVo

	if var_1.getCriInfoTime(var_23_0) ~= -1 then
		for iter_23_0 = #arg_23_0.dymItems, 1, -1 do
			if arg_23_0.dymItems[iter_23_0] then
				var_1_10007 = var_6.data.distance_time

				local var_23_1 = var_6.track.begin_time - var_1

				if var_6.active then
					if var_8 <= var_1 then
						local var_23_2 = var_1 - var_8

						if var_0_2 < var_23_2 then
							var_6.active = false
							var_6.remove = true
						end
					end

					if var_6.check and not var_6.trigger then
						local var_23_3 = var_1 - var_8

						MusicBeatGameConst = var_1_10011

						if var_1_10011.beat_offset < var_23_3 then
							var_6.check = false

							if not var_6.trigger then
								arg_23_0:setEmoji("miss")

								if var_6.data.act == "flap" then
									arg_23_0:changeLife(-1)
								end
							end
						end
					end
				elseif var_6.remove == true then
					local var_23_4

					if var_6.data.final then
						arg_23_0.finalEnd = true
						var_23_4 = nil
						var_23_4 = var_6.typeMatch and "final_correct" or "final_wrong"

						arg_23_0:setCharAnimation(arg_23_0.leftSpine, var_23_4, 0, function()
							local var_24_0 = arg_23_0.leftSpine

							var_0.Pause(var_24_0)

							return
						end)
						arg_23_0:setCharAnimation(arg_23_0.rightSpine, var_23_4, 0, function()
							local var_25_0 = arg_23_0.rightSpine

							var_0.Pause(var_25_0)

							return
						end)
					end

					table = var_23_4

					local var_23_5 = var_23_4.remove(arg_23_0.dymItems, iter_23_0)

					Destroy = var_1_10011

					var_1_10011(var_23_5.tf)

					var_23_5.tf = nil
					var_23_5.anim = nil
					var_23_5.track = nil

					return
				elseif var_23_1 > 0 and var_23_1 <= var_1_10007 then
					arg_23_0:activeDymItem(var_6)
				elseif not var_6.throw and var_23_1 > 0 and var_23_1 <= var_1_10007 + 100 then
					var_6.throw = true

					arg_23_0:setCharAnimation(arg_23_0.rightSpine, "throw", 0, function()
						local var_26_0 = arg_23_0

						var_0.setCharAnimation(var_26_0, arg_23_0.rightSpine, "idle", 0, nil, nil)

						return
					end, nil)
				elseif var_23_1 <= var_1_10007 / 2 or var_8 <= var_1 and not var_6.active then
					var_6.remove = true
				end
			else
				warning = var_1_10007

				var_1_10007("dymitem == nil")
			end
		end
	end

	return
end

function var_0_1.onStop(arg_27_0)
	for iter_27_0 = 1, #arg_27_0.dymItems do
		if arg_27_0.dymItems[iter_27_0].anim then
			var_5.speed = 0
		end
	end

	return
end

function var_0_1.onResume(arg_28_0)
	for iter_28_0 = 1, #arg_28_0.dymItems do
		if arg_28_0.dymItems[iter_28_0].anim then
			var_5.speed = 1
		end
	end

	return
end

function var_0_1.changeLife(arg_29_0, arg_29_1)
	arg_29_0.lifeCount = arg_29_0.lifeCount + arg_29_1

	local var_29_0

	if arg_29_0.lifeCount <= 0 then
		var_1_10004 = arg_29_0._event
		var_29_0 = var_29_0.emit
		MusicBeatGameEvent = var_1_10005

		var_29_0(var_1_10004, var_1_10005.GAME_OVER)
	end

	setText = var_29_0
	findTF = var_1_10004

	var_29_0(var_1_10004(arg_29_0.beatCount, "text"), arg_29_0.lifeCount)

	return
end

function var_0_1.setEmoji(arg_30_0, arg_30_1)
	setActive = var_1_10002

	var_1_10002(arg_30_0.emojiTf, false)

	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0.setChildVisible

	findTF = var_5

	var_30_1(var_30_0, var_5(arg_30_0.emojiTf, "ad"), false)

	if arg_30_1 then
		setActive = var_30_1

		var_30_1(arg_30_0.emojiTf, true)

		setActive = var_30_1
		findTF = var_4

		var_30_1(var_4(arg_30_0.emojiTf, "ad/" .. arg_30_1), true)
	end

	return
end

function var_0_1.setChildVisible(arg_31_0, arg_31_1, arg_31_2)
	for iter_31_0 = 1, arg_31_1.childCount do
		local var_31_0 = arg_31_1:GetChild(iter_31_0 - 1)

		setActive = var_1_10008

		var_1_10008(var_31_0, arg_31_2)
	end

	return
end

function var_0_1.getCheckDymItem(arg_32_0)
	for iter_32_0 = 1, #arg_32_0.dymItems do
		if arg_32_0.dymItems[iter_32_0].check and not var_5.trigger then
			return var_5
		end
	end

	return nil
end

function var_0_1.activeDymItem(arg_33_0, arg_33_1)
	setActive = var_1_10002

	var_1_10002(arg_33_1.tf, true)

	arg_33_1.active = true

	local var_33_0 = arg_33_1.anim

	var_2.Play(var_33_0, "item_fly", -1, 0)

	arg_33_1.anim.speed = 1

	return
end

function var_0_1.setCharAnimation(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)
	if arg_34_1 then
		arg_34_1:SetActionCallBack(nil)
		arg_34_1:SetActionCallBack(function(arg_35_0)
			if arg_35_0 == "finish" and arg_34_4 then
				local var_35_0 = arg_34_1

				var_1.SetActionCallBack(var_35_0, nil)
				arg_34_4()
			elseif arg_35_0 == "action" and arg_34_5 then
				arg_34_5()
			end

			return
		end)
	end

	if arg_34_1 == arg_34_0.leftSpine then
		print = var_6

		var_6("set action" .. arg_34_2)
	end

	arg_34_1:SetAction(arg_34_2, arg_34_3)

	return
end

function var_0_1.onClear(arg_36_0)
	for iter_36_0 = 1, #arg_36_0.dymItems do
		if arg_36_0.dymItems[iter_36_0].tf then
			Destroy = var_5

			var_5(arg_36_0.dymItems[iter_36_0].tf)

			arg_36_0.dymItems[iter_36_0].tf = nil
			arg_36_0.dymItems[iter_36_0].anim = nil
		end
	end

	arg_36_0.dymItems = {}

	return
end

function var_0_1.onDispose(arg_37_0)
	return
end

return var_0_1
