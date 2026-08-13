class = var_0_10000

local var_0_0 = var_0_10000("Fushun3PlatformControll")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._tplTf = arg_1_2
	arg_1_0._content = arg_1_3
	arg_1_0._event = arg_1_4
	arg_1_0._platformPool = {}
	arg_1_0._platforms = {}
	arg_1_0._sceneTf = arg_1_1
	arg_1_0._weightTotal = 0
	arg_1_0.createDatas = nil

	return
end

function var_0_0.start(arg_2_0)
	arg_2_0.moveDistance = 0
	arg_2_0.fillDistance = 0
	arg_2_0.level = 0

	for iter_2_0 = #arg_2_0._platforms, 1, -1 do
		table = var_1_10005
		var_1_10005 = var_1_10005.remove(arg_2_0._platforms, iter_2_0)
		setActive = var_1_10006

		var_1_10006(var_1_10005.tf, false)

		table = var_1_10006

		var_1_10006.insert(arg_2_0._platformPool, var_1_10005)
	end

	arg_2_0.createDatas = {}
	arg_2_0._weightTotal = 0

	local var_2_0 = 1

	Fushun3GameConst = var_2

	for iter_2_1 = var_2_0, #var_2.platform_data do
		Clone = var_1_10005
		Fushun3GameConst = var_1_10007
		var_1_10005 = var_1_10005(var_1_10007.platform_data[iter_2_1])
		arg_2_0._weightTotal = arg_2_0._weightTotal + var_1_10005.weight
		table = var_6

		var_6.insert(arg_2_0.createDatas, {
			config = var_1_10005,
			weight = arg_2_0._weightTotal
		})
	end

	arg_2_0.initTimes = false

	arg_2_0:fillPlatform()

	arg_2_0.initTimes = true
	Fushun3GameVo = var_1
	arg_2_0.timeFlag = var_1.GetTimeFlag()

	arg_2_0:changePlatformShow(false)

	return
end

function var_0_0.updateCreateData(arg_3_0)
	arg_3_0.createDatas = {}
	arg_3_0._weightTotal = 0

	local var_3_0 = 1

	Fushun3GameConst = var_1_10002

	for iter_3_0 = var_3_0, #var_1_10002.platform_data do
		Clone = var_1_10005
		Fushun3GameConst = var_1_10007
		var_1_10005 = var_1_10005(var_1_10007.platform_data[iter_3_0])
		arg_3_0._weightTotal = arg_3_0._weightTotal + var_1_10005.weight + var_1_10005.diff * arg_3_0.level
		table = var_6

		var_6.insert(arg_3_0.createDatas, {
			config = var_1_10005,
			weight = arg_3_0._weightTotal
		})
	end

	return
end

function var_0_0.fillPlatform(arg_4_0)
	local var_4_0 = arg_4_0.fillDistance
	local var_4_1 = arg_4_0.moveDistance

	Fushun3GameConst = var_1_10003

	if var_4_0 < var_4_1 + var_1_10003.platform_distance then
		local var_4_2 = arg_4_0

		if arg_4_0.getPlatform(var_4_2).high then
			setActive = var_2
			findTF = var_1_10004

			var_2(var_1_10004(var_1.tf, "high_roof"), true)
		end

		table = var_2

		var_2.insert(arg_4_0._platforms, var_1)

		var_1.anchoredX = arg_4_0.fillDistance

		local var_4_3 = var_1.tf

		Vector2 = var_4_2
		var_4_3.anchoredPosition = var_4_2(arg_4_0.fillDistance, 0)
		setActive = var_4_3

		var_4_3(var_1.tf, true)

		GetComponent = var_4_3

		local var_4_4 = var_1.tf

		typeof = var_5
		Animator = var_1_10007

		local var_4_5 = var_4_3(var_4_4, var_5(var_1_10007))

		Fushun3GameVo = var_3

		local var_4_6 = var_3.GetTimeFlag() and "day_no_fade" or "night_no_fade"

		var_4_5:SetTrigger(var_4_6)

		if var_1.monster then
			findTF = var_4

			local var_4_7 = var_4(var_1.tf, "monster")
			local var_4_8 = arg_4_0._event
			local var_4_9 = var_5.emit

			Fushun3GameEvent = var_1_10008

			var_4_9(var_4_8, var_1_10008.create_monster_call, {
				pos = var_4_7.position
			})
		end

		if var_1.item then
			findTF = var_4

			local var_4_10 = var_4(var_1.tf, "item")
			local var_4_11 = 0
			local var_4_12 = arg_4_0._event
			local var_4_13 = var_6.emit

			Fushun3GameEvent = var_1_10009

			var_4_13(var_4_12, var_1_10009.create_platform_item_call, {
				pos = var_4_10.position,
				id = var_4_11
			})
		end

		arg_4_0.fillDistance = arg_4_0.fillDistance + var_1.distance

		arg_4_0:fillPlatform()
	end

	return
end

function var_0_0.getPlatform(arg_5_0)
	local var_5_0

	if arg_5_0.powerNum and arg_5_0.powerNum > 0 then
		arg_5_0.powerNum = arg_5_0.powerNum - 1

		if arg_5_0.powerNum <= 15 then
			var_5_0 = arg_5_0:getPowerPlatform()
		else
			var_5_0 = arg_5_0:getRandomPlatform()
		end
	else
		var_5_0 = arg_5_0:getRandomPlatform()
	end

	local var_5_1 = var_5_0.name
	local var_5_2 = var_5_0.distance
	local var_5_3 = var_5_0.monster
	local var_5_4 = var_5_0.high
	local var_5_5 = var_5_0.item
	local var_5_6 = arg_5_0
	local var_5_12

	if not arg_5_0.getPlatformFromPool(var_5_6, var_5_1) then
		tf = var_1_10008
		instantiate = var_10
		findTF = var_1_10012

		local var_5_7 = var_1_10008(var_10(var_1_10012(arg_5_0._tplTf, var_5_1)))

		Fushun3GameConst = var_5_6
		var_5_7.localScale = var_5_6.game_scale_v3

		for iter_5_0 = 0, 5 do
			local var_5_8 = iter_5_0 == 0 and "" or iter_5_0

			findTF = var_14

			if var_14(var_5_7, "collider" .. var_5_8) then
				local var_5_9 = var_14.gameObject

				LayerMask = var_16
				var_5_9.layer = var_16.NameToLayer("Collider")
			end
		end

		findTF = var_9

		local var_5_10

		if var_9(var_5_7, "high_roof") then
			var_5_10 = var_9.gameObject
			LayerMask = var_11
			var_5_10.layer = var_11.NameToLayer("Collider")
		end

		setParent = var_5_10

		var_5_10(var_5_7, arg_5_0._content)

		local var_5_11 = {
			name = var_5_1,
			tf = var_5_7
		}

		Fushun3GameConst = var_11
		var_5_11.distance = var_5_2 * var_11.game_scale
		var_5_11.monster = var_5_3
		var_5_11.high = var_5_4
		var_5_11.item = var_5_5
		var_5_12 = var_5_11
	end

	return var_5_12
end

function var_0_0.getPowerPlatform(arg_6_0)
	for iter_6_0 = 1, 10 do
		if arg_6_0.initTimes then
			math = var_5

			local var_6_0

			if not var_5.random(1, arg_6_0._weightTotal) then
				var_6_0 = 1
			end

			ipairs = var_1_10006

			for iter_6_1, iter_6_2 in var_1_10006(arg_6_0.createDatas) do
				if var_6_0 <= iter_6_2.weight and iter_6_2.config.power then
					return iter_6_2.config
				end
			end
		end
	end

	return arg_6_0:getRandomPlatform()
end

function var_0_0.getRandomPlatform(arg_7_0)
	if arg_7_0.initTimes then
		math = var_1

		local var_7_0

		if not var_1.random(1, arg_7_0._weightTotal) then
			var_7_0 = 1
		end

		for iter_7_0 = 1, #arg_7_0.createDatas do
			if var_7_0 <= arg_7_0.createDatas[iter_7_0].weight then
				return var_6.config
			end
		end

		return
	end
end

function var_0_0.getPlatformFromPool(arg_8_0, arg_8_1)
	for iter_8_0 = 1, #arg_8_0._platformPool do
		if arg_8_0._platformPool[iter_8_0].name == arg_8_1 then
			table = var_7

			return var_7.remove(arg_8_0._platformPool, iter_8_0)
		end
	end

	return nil
end

function var_0_0.removePlatform(arg_9_0)
	for iter_9_0 = #arg_9_0._platforms, 1, -1 do
		local var_9_0 = arg_9_0._platforms[iter_9_0].anchoredX
		local var_9_1 = arg_9_0.moveDistance

		Fushun3GameConst = var_1_10008

		if var_9_0 < var_9_1 - var_1_10008.platform_remove then
			setActive = var_9_0

			var_9_0(var_5.tf, false)

			table = var_9_0

			local var_9_2 = var_9_0.insert

			var_1_10008 = arg_9_0._platformPool
			table = var_9

			var_9_2(var_1_10008, var_9.remove(arg_9_0._platforms, iter_9_0))
		end
	end

	return
end

function var_0_0.step(arg_10_0)
	math = var_1_10001
	arg_10_0.moveDistance = var_1_10001.abs(arg_10_0._sceneTf.anchoredPosition.x)

	arg_10_0:fillPlatform()
	arg_10_0:removePlatform()

	return
end

function var_0_0.levelUp(arg_11_0)
	arg_11_0.level = arg_11_0.level + 1

	arg_11_0:updateCreateData()

	return
end

function var_0_0.updateDayNight(arg_12_0)
	local var_12_0 = arg_12_0.timeFlag

	Fushun3GameVo = var_1_10002

	if var_12_0 ~= var_1_10002.GetTimeFlag() then
		Fushun3GameVo = var_12_0
		arg_12_0.timeFlag = var_12_0.GetTimeFlag()

		arg_12_0:changePlatformShow(true)
	end

	return
end

function var_0_0.changePlatformShow(arg_13_0, arg_13_1)
	for iter_13_0 = #arg_13_0._platforms, 1, -1 do
		local var_13_0 = arg_13_0._platforms[iter_13_0].tf

		if arg_13_1 then
			GetComponent = var_1_10007
			var_1_10009 = var_13_0
			typeof = var_1_10010
			Animator = var_1_10012
			var_1_10007 = var_1_10007(var_1_10009, var_1_10010(var_1_10012))
			Fushun3GameVo = var_1_10008
			var_1_10008 = var_1_10008.GetTimeFlag() and "day" or "night"

			var_1_10007:SetTrigger(var_1_10008)
		else
			GetComponent = var_1_10007
			findTF = var_1_10009
			var_1_10009 = var_1_10009(var_13_0, "day")
			typeof = var_1_10010
			CanvasGroup = var_1_10012
			var_1_10007 = var_1_10007(var_1_10009, var_1_10010(var_1_10012))
			Fushun3GameVo = var_1_10008
			var_1_10008 = var_1_10008.GetTimeFlag() and 1 or 0
			var_1_10007.alpha = var_1_10008
			GetComponent = var_1_10007
			findTF = var_1_10009
			var_1_10009 = var_1_10009(var_13_0, "night")
			typeof = var_1_10010
			CanvasGroup = var_1_10012
			var_1_10007 = var_1_10007(var_1_10009, var_1_10010(var_1_10012))
			Fushun3GameVo = var_1_10008
			var_1_10008 = var_1_10008.GetTimeFlag() and 0 or 1
			var_1_10007.alpha = var_1_10008
		end
	end

	return
end

function var_0_0.onPlayerPower(arg_14_0)
	arg_14_0.powerNum = 20

	return
end

function var_0_0.dipose(arg_15_0)
	return
end

return var_0_0
