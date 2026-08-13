class = var_0_10000

local var_0_0 = var_0_10000("BoatAdBgControl")
local var_0_1
local var_0_2 = 2
local var_0_3 = 100
local var_0_4 = 1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	BoatAdGameVo = var_1_10003
	var_0_1 = var_1_10003
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	findTF = var_1_10003
	arg_1_0._content = var_1_10003(arg_1_0._tf, "scene_front/content")
	findTF = var_3
	arg_1_0._spineSea = var_3(arg_1_0._tf, "scene_background/content/spineSea")
	findTF = var_3
	arg_1_0._spineSeaLeft = var_3(arg_1_0._tf, "scene_background/content/spineSeaLeft")
	findTF = var_3
	arg_1_0._spineSeaRight = var_3(arg_1_0._tf, "scene_background/content/spineSeaRight")
	arg_1_0.graphicUI = {}
	table = var_3

	local var_1_0 = var_3.insert
	local var_1_1 = arg_1_0.graphicUI
	local var_1_2 = arg_1_0._spineSea

	var_1_0(var_1_1, var_5.GetComponent(var_1_2, "SkeletonGraphic"))

	table = var_1_0

	local var_1_3 = var_1_0.insert
	local var_1_4 = arg_1_0.graphicUI
	local var_1_5 = arg_1_0._spineSeaLeft

	var_1_3(var_1_4, var_5.GetComponent(var_1_5, "SkeletonGraphic"))

	table = var_1_3

	local var_1_6 = var_1_3.insert
	local var_1_7 = arg_1_0.graphicUI
	local var_1_8 = arg_1_0._spineSeaRight

	var_1_6(var_1_7, var_5.GetComponent(var_1_8, "SkeletonGraphic"))

	arg_1_0._bgs = {}
	arg_1_0._bgsPool = {}
	arg_1_0.thunders = {}

	for iter_1_0 = 1, 3 do
		local var_1_9 = var_0_1.GetGameTplTf("bgs/thunder_" .. iter_1_0)

		GetComponent = var_8
		findTF = var_9

		local var_1_10 = var_9(var_1_9, "ad/img/spine")

		typeof = var_10
		SpineAnimUI = var_11

		local var_1_11 = var_8(var_1_10, var_10(var_11))
		local var_1_12 = {
			active = false,
			tf = var_1_9,
			animUI = var_1_11
		}

		setParent = var_10

		var_10(var_1_9, arg_1_0._content)

		setActive = var_10

		var_10(var_1_9, false)

		table = var_10

		var_10.insert(arg_1_0.thunders, var_1_12)
	end

	return
end

function var_0_0.start(arg_2_0)
	arg_2_0:setSpineStop(false)
	arg_2_0:clear()

	arg_2_0._createTime = var_0_2
	arg_2_0._thunderTime = var_0_4

	return
end

function var_0_0.step(arg_3_0, arg_3_1)
	if arg_3_0._createTime > 0 then
		arg_3_0._createTime = arg_3_0._createTime - arg_3_1

		if arg_3_0._createTime <= 0 then
			arg_3_0._createTime = var_0_2
			math = var_2

			if var_2.random(1, 100) <= var_0_3 then
				local var_3_0 = arg_3_0
				local var_3_1 = arg_3_0.createBg

				BoatAdGameConst = var_4

				local var_3_2 = var_4.create_bg

				math = var_1_10005

				local var_3_3 = var_1_10005.random
				local var_3_4 = 1

				BoatAdGameConst = var_1_10007

				var_3_1(var_3_0, var_3_2[var_3_3(var_3_4, #var_1_10007.create_bg)])
			end
		end
	end

	if #arg_3_0._bgs > 0 and arg_3_0._thunderTime > 0 then
		arg_3_0._thunderTime = arg_3_0._thunderTime - arg_3_1

		if arg_3_0._thunderTime <= 0 then
			arg_3_0._thunderTime = var_0_4

			for iter_3_0 = 1, #arg_3_0.thunders do
				if arg_3_0.thunders[iter_3_0].active == false then
					var_6.active = true

					local var_3_5 = arg_3_0._bgs

					math = var_1_10008

					local var_3_6 = var_3_5[var_1_10008.random(1, #arg_3_0._bgs)]

					var_1_10008 = var_6.tf
					var_1_10008.anchoredPosition = var_3_6:getPosition()
					setActive = var_1_10008

					var_1_10008(var_6.tf, true)
					arg_3_0:setAnimation(arg_3_0.thunders[iter_3_0].animUI, "normal", function()
						local var_4_0 = var_0

						var_4_0.active = false
						setActive = var_4_0

						var_4_0(var_0.tf, false)

						return
					end)

					print = var_1_10008

					var_1_10008("创建闪电成功")

					break
				end
			end
		end
	end

	for iter_3_1 = #arg_3_0._bgs, 1, -1 do
		local var_3_7 = arg_3_0._bgs[iter_3_1]

		var_6.step(var_3_7, arg_3_1)

		if var_6:getRemoveFlag() then
			table = var_7

			var_7.remove(arg_3_0._bgs, iter_3_1)
			arg_3_0:returnBg(var_6)
		end
	end

	return
end

function var_0_0.returnBg(arg_5_0, arg_5_1)
	arg_5_1:clear()

	table = var_2

	var_2.insert(arg_5_0._bgsPool, arg_5_1)

	return
end

function var_0_0.getSpineStop(arg_6_0)
	return arg_6_0.spineStopFlag
end

function var_0_0.setSpineStop(arg_7_0, arg_7_1)
	arg_7_0.spineStopFlag = arg_7_1

	local var_7_0

	if arg_7_1 then
		var_7_0 = 0
	else
		BoatAdGameConst = var_1_10003
		var_7_0 = var_1_10003.spine_scale_time
	end

	for iter_7_0 = 1, #arg_7_0.graphicUI do
		arg_7_0.graphicUI[iter_7_0].AnimationState.TimeScale = var_7_0
	end

	return
end

function var_0_0.createBg(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1

	math = var_1_10003

	local var_8_1 = var_1_10003.random(1, 4)
	local var_8_2 = arg_8_0:getOrCreateItem(var_8_0)

	var_4.start(var_8_2)
	var_4:setMoveCount(var_8_1)

	table = var_5

	var_5.insert(arg_8_0._bgs, var_4)

	return
end

function var_0_0.getOrCreateItem(arg_9_0, arg_9_1)
	local var_9_0
	local var_9_1 = #arg_9_0._bgsPool

	if 0 < var_9_1 then
		for iter_9_0 = 1, #arg_9_0._bgsPool do
			local var_9_2 = arg_9_0._bgsPool[iter_9_0]

			if var_7.getId(var_9_2) == arg_9_1 then
				table = var_8
				var_9_0 = var_8.remove(arg_9_0._bgsPool, iter_9_0)

				break
			end
		end
	end

	if not var_9_0 then
		BoatAdGameConst = var_9_1

		if not var_9_1.game_bg[arg_9_1] then
			print = var_4

			var_4("不存在背景id" .. arg_9_1)
		end

		local var_9_3 = var_0_1.GetGameTplTf(var_3.tpl)

		BoatAdBg = var_5

		local var_9_4 = var_5.New(var_9_3, arg_9_0._event)

		var_9_0.setData(var_9_4, var_3)
		var_9_0:setContent(arg_9_0._content)
	end

	var_9_0:start()

	return var_9_0
end

function var_0_0.setMoveSpeed(arg_10_0, arg_10_1)
	arg_10_0._moveSpeed = arg_10_1

	for iter_10_0 = 1, #arg_10_0._bgs do
		local var_10_0 = arg_10_0._bgs[iter_10_0]

		var_6.setSpeed(var_10_0, arg_10_1)
	end

	if arg_10_1 == 0 then
		arg_10_0:setSpineStop(true)
	else
		arg_10_0:setSpineStop(false)
	end

	return
end

function var_0_0.getMoveSpeed(arg_11_0)
	return arg_11_0._moveSpeed
end

function var_0_0.stop(arg_12_0)
	local var_12_0

	if not arg_12_0._moveSpeed then
		var_12_0 = 1
	end

	arg_12_0.lastMoveSpeed = var_12_0

	arg_12_0:setMoveSpeed(0)

	return
end

function var_0_0.resume(arg_13_0)
	arg_13_0:setMoveSpeed(arg_13_0.lastMoveSpeed)

	return
end

function var_0_0.clear(arg_14_0)
	for iter_14_0 = #arg_14_0._bgs, 1, -1 do
		table = var_1_10005

		local var_14_0 = var_1_10005.remove(arg_14_0._bgs, iter_14_0)

		var_1_10005.clear(var_14_0)

		table = var_6

		var_6.insert(arg_14_0._bgsPool, var_1_10005)
	end

	for iter_14_1 = #arg_14_0.thunders, 1, -1 do
		local var_14_1 = arg_14_0.thunders[iter_14_1]

		var_14_1.active = false
		setActive = var_14_1

		var_14_1(arg_14_0.thunders[iter_14_1].tf, false)
	end

	arg_14_0:setMoveSpeed(1)

	return
end

function var_0_0.setAnimation(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_1:SetActionCallBack(nil)
	arg_15_1:SetAction(arg_15_2, 0)
	arg_15_1:SetActionCallBack(function(arg_16_0)
		if arg_16_0 == "action" and arg_15_4 then
			arg_15_4()
		end

		if arg_16_0 == "finish" then
			local var_16_0 = arg_15_1

			var_1.SetActionCallBack(var_16_0, nil)

			if arg_15_3 then
				arg_15_3()
			end
		end

		return
	end)

	return
end

function var_0_0.dispose(arg_17_0)
	return
end

return var_0_0
