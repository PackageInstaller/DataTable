class = var_0_10000

local var_0_0 = var_0_10000("Fushun3BgController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0._bgTpl = arg_1_1
	arg_1_0._fireTpl = arg_1_2
	arg_1_0._backSceneTf = arg_1_4
	arg_1_0._petalTpl = arg_1_3
	arg_1_0._event = arg_1_5
	findTF = var_1_10006
	arg_1_0._backBgBottomTf = var_1_10006(arg_1_0._backSceneTf, "bgBottom")
	findTF = var_6
	arg_1_0._backBgMidTf = var_6(arg_1_0._backSceneTf, "bgMid")
	findTF = var_6
	arg_1_0._backBgTopTf = var_6(arg_1_0._backSceneTf, "bgTop")
	findTF = var_6
	arg_1_0._backBgPetalTf = var_6(arg_1_0._backSceneTf, "bgPetal")
	arg_1_0.bgItems = {}
	arg_1_0.bgsPool = {}
	arg_1_0.bgLoops = {}

	local var_1_0 = 1

	Fushun3GameConst = var_7

	for iter_1_0 = var_1_0, #var_7.loop_bg do
		local var_1_1 = arg_1_0
		local var_1_2 = arg_1_0.getBgData

		Fushun3GameConst = var_1_10012

		if var_1_2(var_1_1, var_1_10012.loop_bg[iter_1_0]) then
			table = var_1_1

			local var_1_3 = var_1_1.insert

			var_1_10012 = arg_1_0.bgLoops

			local var_1_4 = {
				data = var_10
			}

			Vector2 = var_1_10014
			var_1_4.pos = var_1_10014(0, 0)

			var_1_3(var_1_10012, var_1_4)
		end
	end

	findTF = var_1_0
	arg_1_0._bgAnimTf = var_1_0(arg_1_0._backSceneTf, "bg/anim")
	GetComponent = var_6
	findTF = var_7

	local var_1_5 = var_7(arg_1_0._backSceneTf, "bg/anim")

	typeof = var_8
	Animator = var_9
	arg_1_0.bgAnimator = var_6(var_1_5, var_8(var_9))

	return
end

function var_0_0.start(arg_2_0)
	local var_2_0 = arg_2_0

	arg_2_0.clearBg(var_2_0)

	math = var_1

	local var_2_1 = var_1.random()

	Fushun3GameConst = var_2_0

	local var_2_2 = var_2_0.fire_time[2]

	Fushun3GameConst = var_1_10003

	local var_2_3 = var_2_1 * (var_2_2 - var_1_10003.fire_time[1])

	Fushun3GameConst = var_2
	arg_2_0.fireTime = var_2_3 + var_2.fire_time[1]

	for iter_2_0 = 1, #arg_2_0.bgLoops do
		local var_2_4 = arg_2_0.bgLoops[iter_2_0]

		Vector2 = var_1_10006
		var_2_4.pos = var_1_10006(0, 0)
	end

	arg_2_0.midBgPosX = 0

	local var_2_5 = arg_2_0

	arg_2_0.createMidBg(var_2_5)

	Clone = var_1
	Fushun3GameConst = var_2_5
	arg_2_0.topBgIds = var_1(var_2_5.top_bg)
	math = var_1
	arg_2_0.topBgIdx = var_1.random(1, #arg_2_0.topBgIds)
	arg_2_0.topBgPosX = 0
	arg_2_0.petalCount = 0

	for iter_2_1 = arg_2_0.topBgIdx, #arg_2_0.topBgIds do
		arg_2_0:createTopBg(arg_2_0.topBgIds[iter_2_1])
	end

	arg_2_0:changeDayNight(false)

	return
end

function var_0_0.step(arg_3_0)
	local var_3_0 = arg_3_0.fireTime
	local var_3_1

	if 0 < var_3_0 then
		var_3_0 = arg_3_0.fireTime
		Time = var_3_1
		arg_3_0.fireTime = var_3_0 - var_3_1.deltaTime

		if arg_3_0.fireTime <= 0 then
			Fushun3GameVo = var_3_0

			if not var_3_0.GetTimeFlag() then
				var_3_1 = arg_3_0

				arg_3_0.createFire(var_3_1)
			end

			math = var_3_0
			var_3_0 = var_3_0.random()
			Fushun3GameConst = var_3_1
			var_3_1 = var_3_1.fire_time[2]
			Fushun3GameConst = var_1_10003
			var_3_0 = var_3_0 * (var_3_1 - var_1_10003.fire_time[1])
			Fushun3GameConst = var_3_1
			arg_3_0.fireTime = var_3_0 + var_3_1.fire_time[1]
		end
	end

	Fushun3GameVo = var_3_0

	if var_3_0.GetTimeFlag() then
		local var_3_2 = arg_3_0.petalCount

		Fushun3GameConst = var_3_1

		if var_3_2 < var_3_1.petal_count_max then
			arg_3_0:createPetal()
		end
	end

	for iter_3_0 = 1, #arg_3_0.bgLoops do
		local var_3_3 = arg_3_0._backBgBottomTf.anchoredPosition
		local var_3_4 = arg_3_0.bgLoops[iter_3_0].data

		var_1_10007 = arg_3_0.bgLoops[iter_3_0].pos

		local var_3_5 = var_3_4.bound.x

		Fushun3GameConst = var_1_10009

		local var_3_6 = var_3_5 * var_1_10009.game_scale

		math = var_1_10009
		var_1_10009 = var_1_10009.abs(var_3_3.x)
		Fushun3GameConst = var_10

		if var_1_10009 + var_3_6 * var_10.loop_nums >= var_1_10007.x then
			local var_3_7 = arg_3_0:getBgFromPool(var_3_4.id).tf

			Vector2 = var_12
			var_3_7.anchoredPosition = var_12(var_1_10007.x, var_3_4.pos.y)
			setActive = var_3_7

			var_3_7(var_10.tf, true)

			table = var_3_7

			var_3_7.insert(arg_3_0.bgItems, var_10)

			var_1_10007.x = var_1_10007.x + var_3_6
			arg_3_0.bgLoops[iter_3_0].pos = var_1_10007
		end
	end

	local var_3_8 = arg_3_0.topBgPosX

	math = var_2

	local var_3_9 = var_2.abs(arg_3_0._backBgTopTf.anchoredPosition.x)

	Fushun3GameConst = var_3

	if var_3_8 < var_3_9 + var_3.top_bg_inst_posX then
		local var_3_10 = arg_3_0.topBgIds[arg_3_0.topBgIdx]

		arg_3_0:createTopBg(var_3_10)

		if arg_3_0.topBgIdx >= #arg_3_0.topBgIds then
			arg_3_0.topBgIdx = 1
		else
			arg_3_0.topBgIdx = arg_3_0.topBgIdx + 1
		end
	end

	local var_3_11 = arg_3_0.midBgPosX

	math = var_2

	local var_3_12 = var_2.abs(arg_3_0._backBgMidTf.anchoredPosition.x)

	Fushun3GameConst = var_3

	if var_3_11 < var_3_12 + var_3.mid_bg_inst_posX then
		arg_3_0:createMidBg()
	end

	if arg_3_0.dayTimeCount then
		local var_3_13 = arg_3_0.dayTimeCount

		if 0 < var_3_13 then
			local var_3_14 = arg_3_0.dayTimeCount

			Time = var_2
			arg_3_0.dayTimeCount = var_3_14 - var_2.deltaTime

			if arg_3_0.dayTimeCount <= 0 then
				Fushun3GameVo = var_1

				var_1.ChangeTimeType(arg_3_0.timeTypeData.next)

				print = var_1

				local var_3_15 = "切换白天黑夜下一个阶段 = "

				tostring = var_3

				var_1(var_3_15 .. var_3(arg_3_0.timeTypeData.next))
				arg_3_0:changeDayNight(true)

				local var_3_16 = arg_3_0._event
				local var_3_17 = var_1.emit

				Fushun3GameEvent = var_3

				var_3_17(var_3_16, var_3.day_night_change)
			end
		end
	end

	for iter_3_1 = 1, #arg_3_0.bgItems do
		local var_3_18 = arg_3_0.bgItems[iter_3_1].data.type

		Fushun3GameConst = var_1_10007

		if var_3_18 == var_1_10007.BG_TYPE_PETAL then
			var_1_10007 = var_5.tf.anchoredPosition.x

			local var_3_19 = var_5.speed.x

			Time = var_1_10009
			var_6.x = var_1_10007 + var_3_19 * var_1_10009.deltaTime
			var_1_10007 = var_6.y

			local var_3_20 = var_5.speed.y

			Time = var_1_10009
			var_6.y = var_1_10007 + var_3_20 * var_1_10009.deltaTime
			var_1_10007 = var_5.tf
			var_1_10007.anchoredPosition = var_6
			var_1_10007 = var_6.y
			Fushun3GameConst = var_8

			if var_1_10007 < var_8.petal_remove_y then
				var_5.removeTime = 0
			end
		end
	end

	arg_3_0:removeBg()

	return
end

function var_0_0.changeDayNight(arg_4_0, arg_4_1)
	Fushun3GameVo = var_1_10002
	arg_4_0.timeTypeData = var_1_10002.GetTimeTypeData()
	arg_4_0.dayTimeCount = arg_4_0.timeTypeData.time

	arg_4_0:changeBg(arg_4_1)
	arg_4_0:changeBgItems(arg_4_1)

	return
end

function var_0_0.changeBgItems(arg_5_0, arg_5_1)
	if arg_5_1 then
		var_1_10002 = arg_5_0.currentItemTimeFlag
		Fushun3GameVo = var_1_10003

		if var_1_10002 == var_1_10003.GetTimeFlag() then
			return
		end
	end

	Fushun3GameVo = var_1_10002
	arg_5_0.currentItemTimeFlag = var_1_10002.GetTimeFlag()

	for iter_5_0 = 1, #arg_5_0.bgItems do
		local var_5_0 = arg_5_0.bgItems[iter_5_0].tf
		local var_5_1 = arg_5_0.bgItems[iter_5_0].data.type

		Fushun3GameConst = var_1_10009

		if var_5_1 == var_1_10009.BG_TYPE_FIRE then
			if arg_5_0.bgItems[iter_5_0].removeTime and arg_5_0.currentItemTimeFlag then
				arg_5_0.bgItems[iter_5_0].removeTime = 0
			end

			goto label_5_0
		end

		local var_5_2 = var_7.type

		Fushun3GameConst = var_1_10009

		if var_5_2 == var_1_10009.BG_TYPE_PETAL then
			if arg_5_0.bgItems[iter_5_0].removeTime and not arg_5_0.currentItemTimeFlag then
				var_5_2 = arg_5_0.bgItems[iter_5_0]
				var_5_2.removeTime = 0
			end

			goto label_5_0
		end

		GetComponent = var_5_2
		var_1_10009 = var_5_0
		typeof = var_1_10010
		Animator = var_1_10011

		local var_5_3 = var_5_2(var_1_10009, var_1_10010(var_1_10011))

		if arg_5_1 then
			if arg_5_0.currentItemTimeFlag then
				findTF = var_1_10009

				if not var_1_10009(var_5_0, "day") then
					findTF = var_1_10009
					var_1_10009 = var_1_10009(var_5_0, "night")
				end

				setActive = var_1_10010

				var_1_10010(var_1_10009, false)

				setActive = var_1_10010

				var_1_10010(var_1_10009, true)

				Fushun3GameVo = var_1_10010
				var_1_10010 = var_1_10010.GetTimeFlag() and "day" or "night"

				var_5_3:SetTrigger(var_1_10010)

				if false then
					Fushun3GameVo = var_1_10009
					var_1_10009 = var_1_10009.GetTimeFlag() and "day_no_fade" or "night_no_fade"
					var_1_10011 = var_5_3

					var_5_3.SetTrigger(var_1_10011, var_1_10009)
				end

				::label_5_0::
			end
		end
	end

	return
end

function var_0_0.changeBg(arg_6_0, arg_6_1)
	if arg_6_1 then
		local var_6_0 = arg_6_0.bgAnimator

		var_1_10002.SetTrigger(var_6_0, arg_6_0.timeTypeData.change_anim)
	else
		setActive = var_1_10002

		var_1_10002(arg_6_0._bgAnimTf, false)

		setActive = var_1_10002

		var_1_10002(arg_6_0._bgAnimTf, true)

		var_1_10002 = arg_6_0._bgAnimTf.childCount

		for iter_6_0 = 0, var_1_10002 - 1 do
			local var_6_1 = arg_6_0._bgAnimTf
			local var_6_2 = var_7.GetChild(var_6_1, iter_6_0)

			setActive = var_6_1

			var_6_1(var_6_2, var_6_2.name == arg_6_0.timeTypeData.tf)
		end

		var_1_10004 = arg_6_0.bgAnimator

		var_3.SetTrigger(var_1_10004, arg_6_0.timeTypeData.anim)
	end

	print = var_1_10002

	local var_6_3 = "当前状态"

	tostring = var_1_10004

	var_1_10002(var_6_3 .. var_1_10004(arg_6_0.timeTypeData.name))

	return
end

function var_0_0.createTopBg(arg_7_0, arg_7_1)
	if arg_7_0:getBgData(arg_7_1) then
		local var_7_0 = arg_7_0:getBgFromPool(var_2.id).tf

		Vector2 = var_5
		var_7_0.anchoredPosition = var_5(arg_7_0.topBgPosX, var_3.data.pos.y)

		local var_7_1 = arg_7_0.topBgPosX
		local var_7_2 = var_3.data.bound.x

		Fushun3GameConst = var_6
		arg_7_0.topBgPosX = var_7_1 + var_7_2 * var_6.game_scale
		setActive = var_4

		var_4(var_3.tf, true)

		table = var_4

		var_4.insert(arg_7_0.bgItems, var_3)
	end

	return
end

function var_0_0.createMidBg(arg_8_0)
	local var_8_0 = 0
	local var_8_1 = 1

	Fushun3GameConst = var_1_10003

	for iter_8_0 = var_8_1, #var_1_10003.mid_bg do
		Fushun3GameConst = var_1_10006

		local var_8_2 = var_1_10006.mid_bg[iter_8_0].num
		local var_8_3 = var_1_10006.mid_random

		Clone = var_1_10009
		var_1_10009 = var_1_10009(var_1_10006.ids)

		for iter_8_1 = 1, var_8_2 do
			table = var_1_10014
			var_1_10014 = var_1_10014.remove

			local var_8_4 = var_1_10009

			math = var_1_10016
			var_1_10014 = var_1_10014(var_8_4, var_1_10016.random(1, #var_1_10009))
			var_1_10016 = arg_8_0

			if arg_8_0.getBgFromPool(var_1_10016, var_1_10014) then
				if var_8_3 then
					var_1_10016 = var_15.tf
					Vector2 = var_17
					math = var_18
					var_1_10016.anchoredPosition = var_17(var_18.random(900, 1000) + arg_8_0.midBgPosX, var_15.data.pos.y)
				else
					var_1_10016 = var_15.tf
					Vector2 = var_17
					var_1_10016.anchoredPosition = var_17(var_8_0 + arg_8_0.midBgPosX, var_15.data.pos.y)
					var_1_10016 = var_15.data.bound.x
					Fushun3GameConst = var_17
					var_8_0 = var_8_0 + var_1_10016 * var_17.game_scale
				end

				setActive = var_1_10016

				var_1_10016(var_15.tf, true)

				table = var_1_10016

				var_1_10016.insert(arg_8_0.bgItems, var_15)
			end
		end
	end

	local var_8_5 = arg_8_0.midBgPosX

	Fushun3GameConst = var_3
	arg_8_0.midBgPosX = var_8_5 + var_3.mid_bg_inst_posX

	return
end

function var_0_0.createPetal(arg_9_0)
	Fushun3GameConst = var_1_10001

	local var_9_0 = var_1_10001.petal_ids

	math = var_1_10002

	local var_9_1 = var_1_10002.random
	local var_9_2 = 1

	Fushun3GameConst = var_1_10004

	local var_9_3 = var_9_0[var_9_1(var_9_2, #var_1_10004.petal_ids)]

	Vector2 = var_2
	math = var_9_2

	local var_9_4 = var_9_2.random(100, 1920)

	math = var_4

	local var_9_5 = var_2(var_9_4, var_4.random(540, 1080))

	if arg_9_0:getBgFromPool(var_9_3) then
		local var_9_6 = var_9_5.x

		math = var_5
		var_9_5.x = var_9_6 + var_5.abs(var_3.parentTf.anchoredPosition.x)
		var_9_5.y = var_9_5.y

		local var_9_7 = var_3.tf

		var_9_7.anchoredPosition = var_9_5
		math = var_9_7

		local var_9_8 = var_9_7.random

		Fushun3GameConst = var_5

		local var_9_9 = var_5.peta_remove_time[1]

		Fushun3GameConst = var_6
		var_3.removeTime = var_9_8(var_9_9, var_6.peta_remove_time[2])
		var_9_5.x = var_9_5.x + var_3.data.bound.x
		Vector2 = var_4
		Fushun3GameConst = var_5

		local var_9_10 = var_5.petal_speed[1]

		math = var_6

		local var_9_11 = var_6.random
		local var_9_12 = 1

		Fushun3GameConst = var_1_10008

		local var_9_13 = var_9_10 + var_9_11(var_9_12, var_1_10008.petal_speed_offset)

		Fushun3GameConst = var_6

		local var_9_14 = var_6.petal_speed[2]

		math = var_9_12

		local var_9_15 = var_9_12.random
		local var_9_16 = 1

		Fushun3GameConst = var_1_10009
		var_3.speed = var_4(var_9_13, var_9_14 + var_9_15(var_9_16, var_1_10009.petal_speed_offset))
		setActive = var_4

		var_4(var_3.tf, true)

		table = var_4

		var_4.insert(arg_9_0.bgItems, var_3)

		arg_9_0.petalCount = arg_9_0.petalCount + 1
	end

	return
end

function var_0_0.createFire(arg_10_0)
	Fushun3GameConst = var_1_10001

	local var_10_0 = var_1_10001.fire_group

	math = var_1_10002

	local var_10_1 = var_1_10002.random
	local var_10_2 = 1

	Fushun3GameConst = var_1_10004

	local var_10_3 = var_10_0[var_10_1(var_10_2, #var_1_10004.fire_group)]

	Vector2 = var_2
	math = var_10_2

	local var_10_4 = var_2(var_10_2.random(100, 1920), 0)

	for iter_10_0 = 1, #var_10_3 do
		local var_10_5 = var_10_3[iter_10_0]

		if arg_10_0:getBgFromPool(var_10_5) then
			local var_10_6 = var_10_4.x

			math = var_10
			var_10_4.x = var_10_6 + var_10.abs(var_8.parentTf.anchoredPosition.x)
			var_10_4.y = var_8.data.pos.y

			local var_10_7 = var_8.tf

			var_10_7.anchoredPosition = var_10_4
			Fushun3GameConst = var_10_7
			var_8.removeTime = var_10_7.fire_remove
			var_10_4.x = var_10_4.x + var_8.data.bound.x
			setActive = var_9

			var_9(var_8.tf, true)

			table = var_9

			var_9.insert(arg_10_0.bgItems, var_8)
		end
	end

	return
end

function var_0_0.getBgData(arg_11_0, arg_11_1)
	local var_11_0 = 1

	Fushun3GameConst = var_1_10003

	for iter_11_0 = var_11_0, #var_1_10003.bg_data do
		Fushun3GameConst = var_1_10006

		if var_1_10006.bg_data[iter_11_0].id == arg_11_1 then
			Fushun3GameConst = var_1_10006

			return var_1_10006.bg_data[iter_11_0]
		end
	end

	return
end

function var_0_0.getBgFromPool(arg_12_0, arg_12_1)
	for iter_12_0 = 1, #arg_12_0.bgsPool do
		if arg_12_0.bgsPool[iter_12_0].data.id == arg_12_1 then
			table = var_1_10007

			return var_1_10007.remove(arg_12_0.bgsPool, iter_12_0)
		end
	end

	local var_12_0
	local var_12_1 = 1

	Fushun3GameConst = var_4

	for iter_12_1 = var_12_1, #var_4.bg_data do
		Fushun3GameConst = var_1_10007

		if var_1_10007.bg_data[iter_12_1].id == arg_12_1 then
			var_12_0 = var_1_10007
		end
	end

	if var_12_0 then
		local var_12_2
		local var_12_3
		local var_12_4 = var_12_0.type

		Fushun3GameConst = iter_12_1

		if var_12_4 == iter_12_1.BG_TYPE_FIRE then
			tf = var_12_4
			instantiate = var_6
			findTF = var_1_10007
			var_12_2 = var_12_4(var_6(var_1_10007(arg_12_0._fireTpl, var_12_0.name)))
			findTF = var_12_4
			var_12_3 = var_12_4(arg_12_0._backSceneTf, "bgFire")
		else
			var_12_4 = var_12_0.type
			Fushun3GameConst = var_6

			if var_12_4 == var_6.BG_TYPE_TOP then
				tf = var_12_4
				instantiate = var_6
				findTF = var_1_10007
				var_12_2 = var_12_4(var_6(var_1_10007(arg_12_0._bgTpl, var_12_0.name)))
				findTF = var_12_4
				var_12_3 = var_12_4(arg_12_0._backSceneTf, "bgTop")
			else
				var_12_4 = var_12_0.type
				Fushun3GameConst = var_6

				if var_12_4 == var_6.BG_TYPE_MID then
					tf = var_12_4
					instantiate = var_6
					findTF = var_1_10007
					var_12_2 = var_12_4(var_6(var_1_10007(arg_12_0._bgTpl, var_12_0.name)))
					findTF = var_12_4
					var_12_3 = var_12_4(arg_12_0._backSceneTf, "bgMid")
				else
					var_12_4 = var_12_0.type
					Fushun3GameConst = var_6

					if var_12_4 == var_6.BG_TYPE_LOOP then
						tf = var_12_4
						instantiate = var_6
						findTF = var_1_10007
						var_12_2 = var_12_4(var_6(var_1_10007(arg_12_0._bgTpl, var_12_0.name)))
						findTF = var_12_4
						var_12_3 = var_12_4(arg_12_0._backSceneTf, "bgBottom")
					else
						var_12_4 = var_12_0.type
						Fushun3GameConst = var_6

						if var_12_4 == var_6.BG_TYPE_PETAL then
							tf = var_12_4
							instantiate = var_6
							findTF = var_1_10007
							var_12_2 = var_12_4(var_6(var_1_10007(arg_12_0._petalTpl, var_12_0.name)))
							findTF = var_12_4
							var_12_3 = var_12_4(arg_12_0._backSceneTf, "bgPetal")
						end
					end
				end
			end
		end

		if var_12_2 and var_12_3 then
			SetParent = var_12_4

			var_12_4(var_12_2, var_12_3)
		end

		return {
			tf = var_12_2,
			data = var_12_0,
			parentTf = var_12_3
		}
	end

	return nil
end

function var_0_0.clearBg(arg_13_0)
	for iter_13_0 = #arg_13_0.bgItems, 1, -1 do
		setActive = var_1_10005

		var_1_10005(arg_13_0.bgItems[iter_13_0].tf, false)

		table = var_1_10005
		var_1_10005 = var_1_10005.insert

		local var_13_0 = arg_13_0.bgsPool

		table = var_7

		var_1_10005(var_13_0, var_7.remove(arg_13_0.bgItems, iter_13_0))
	end

	return
end

function var_0_0.removeBg(arg_14_0)
	local var_14_0 = {}

	for iter_14_0 = #arg_14_0.bgItems, 1, -1 do
		if var_14_0[arg_14_0.bgItems[iter_14_0].parentTf] == nil then
			local var_14_1 = var_6.parentTf

			math = var_1_10008
			var_1_10008 = var_1_10008.abs(var_6.parentTf.anchoredPosition.x)
			Fushun3GameConst = var_9
			var_1_10008 = var_1_10008 + var_9.bg_remove_posX

			local var_14_2 = var_6.data.bound.x

			Fushun3GameConst = var_1_10010
			var_14_0[var_14_1] = var_1_10008 - var_14_2 * var_1_10010.game_scale
		end

		if var_6.removeTime then
			local var_14_3 = var_6.removeTime

			if 0 < var_14_3 then
				local var_14_4 = var_6.removeTime

				Time = var_1_10008
				var_6.removeTime = var_14_4 - var_1_10008.deltaTime
			end
		end

		if var_6.tf.anchoredPosition.x <= var_14_0[var_6.parentTf] then
			setActive = var_7

			var_7(var_6.tf, false)

			table = var_7

			local var_14_5 = var_7.insert

			var_1_10008 = arg_14_0.bgsPool
			table = var_9

			var_14_5(var_1_10008, var_9.remove(arg_14_0.bgItems, iter_14_0))
		elseif var_6.removeTime and var_6.removeTime <= 0 then
			local var_14_6 = var_6.data.type

			Fushun3GameConst = var_1_10008

			if var_14_6 == var_1_10008.BG_TYPE_PETAL then
				arg_14_0.petalCount = arg_14_0.petalCount - 1
			end

			setActive = var_14_6

			var_14_6(var_6.tf, false)

			table = var_14_6

			local var_14_7 = var_14_6.insert

			var_1_10008 = arg_14_0.bgsPool
			table = var_9

			var_14_7(var_1_10008, var_9.remove(arg_14_0.bgItems, iter_14_0))
		end
	end

	return
end

return var_0_0
