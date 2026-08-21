local var_0_0 = class("BoatAdBgControl")
local var_0_1
local var_0_2 = 2
local var_0_3 = 100
local var_0_4 = 1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1 = BoatAdGameVo
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._content = findTF(arg_1_0._tf, "scene_front/content")
	arg_1_0._spineSea = findTF(arg_1_0._tf, "scene_background/content/spineSea")
	arg_1_0._spineSeaLeft = findTF(arg_1_0._tf, "scene_background/content/spineSeaLeft")
	arg_1_0._spineSeaRight = findTF(arg_1_0._tf, "scene_background/content/spineSeaRight")
	arg_1_0.graphicUI = {}

	table.insert(arg_1_0.graphicUI, arg_1_0._spineSea:GetComponent("SkeletonGraphic"))
	table.insert(arg_1_0.graphicUI, arg_1_0._spineSeaLeft:GetComponent("SkeletonGraphic"))
	table.insert(arg_1_0.graphicUI, arg_1_0._spineSeaRight:GetComponent("SkeletonGraphic"))

	arg_1_0._bgs = {}
	arg_1_0._bgsPool = {}
	arg_1_0.thunders = {}

	for iter_1_0 = 1, 3 do
		local var_1_0 = var_0_1.GetGameTplTf("bgs/thunder_" .. iter_1_0)
		local var_1_1 = {
			active = false,
			tf = var_1_0,
			animUI = GetComponent(findTF(var_1_0, "ad/img/spine"), typeof(SpineAnimUI))
		}

		setParent(var_1_0, arg_1_0._content)
		setActive(var_1_0, false)
		table.insert(arg_1_0.thunders, var_1_1)
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

			if math.random(1, 100) <= var_0_3 then
				arg_3_0:createBg(BoatAdGameConst.create_bg[math.random(1, #BoatAdGameConst.create_bg)])
			end
		end
	end

	if #arg_3_0._bgs > 0 and arg_3_0._thunderTime > 0 then
		arg_3_0._thunderTime = arg_3_0._thunderTime - arg_3_1

		if arg_3_0._thunderTime <= 0 then
			arg_3_0._thunderTime = var_0_4

			for iter_3_0 = 1, #arg_3_0.thunders do
				local var_3_0 = arg_3_0.thunders[iter_3_0]

				if arg_3_0.thunders[iter_3_0].active == false then
					arg_3_0.thunders[iter_3_0].active = true
					arg_3_0.thunders[iter_3_0].tf.anchoredPosition = arg_3_0._bgs[math.random(1, #arg_3_0._bgs)]:getPosition()

					setActive(arg_3_0.thunders[iter_3_0].tf, true)
					arg_3_0:setAnimation(arg_3_0.thunders[iter_3_0].animUI, "normal", function()
						var_3_0.active = false

						setActive(var_3_0.tf, false)

						return
					end)
					print("创建闪电成功")

					break
				end
			end
		end
	end

	for iter_3_1 = #arg_3_0._bgs, 1, -1 do
		arg_3_0._bgs[iter_3_1]:step(arg_3_1)

		if arg_3_0._bgs[iter_3_1]:getRemoveFlag() then
			table.remove(arg_3_0._bgs, iter_3_1)
			arg_3_0:returnBg(arg_3_0._bgs[iter_3_1])
		end
	end

	return
end

function var_0_0.returnBg(arg_5_0, arg_5_1)
	arg_5_1:clear()
	table.insert(arg_5_0._bgsPool, arg_5_1)

	return
end

function var_0_0.getSpineStop(arg_6_0)
	return arg_6_0.spineStopFlag
end

function var_0_0.setSpineStop(arg_7_0, arg_7_1)
	arg_7_0.spineStopFlag = arg_7_1

	for iter_7_0 = 1, #arg_7_0.graphicUI do
		arg_7_0.graphicUI[iter_7_0].AnimationState.TimeScale = var_7_0
	end

	return
end

function var_0_0.createBg(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getOrCreateItem(arg_8_1)

	var_8_0:start()
	var_8_0:setMoveCount((math.random(1, 4)))
	table.insert(arg_8_0._bgs, var_8_0)

	return
end

function var_0_0.getOrCreateItem(arg_9_0, arg_9_1)
	local var_9_0

	if #arg_9_0._bgsPool > 0 then
		for iter_9_0 = 1, #arg_9_0._bgsPool do
			if arg_9_0._bgsPool[iter_9_0]:getId() == arg_9_1 then
				var_9_0 = table.remove(arg_9_0._bgsPool, iter_9_0)

				break
			end
		end
	end

	if not var_9_0 then
		if not BoatAdGameConst.game_bg[arg_9_1] then
			print("不存在背景id" .. arg_9_1)
		end

		var_9_0 = BoatAdBg.New(var_0_1.GetGameTplTf(BoatAdGameConst.game_bg[arg_9_1].tpl), arg_9_0._event)

		var_9_0:setData(BoatAdGameConst.game_bg[arg_9_1])
		var_9_0:setContent(arg_9_0._content)
	end

	var_9_0:start()

	return var_9_0
end

function var_0_0.setMoveSpeed(arg_10_0, arg_10_1)
	arg_10_0._moveSpeed = arg_10_1

	for iter_10_0 = 1, #arg_10_0._bgs do
		arg_10_0._bgs[iter_10_0]:setSpeed(arg_10_1)
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
	arg_12_0.lastMoveSpeed = arg_12_0._moveSpeed or 1

	arg_12_0:setMoveSpeed(0)

	return
end

function var_0_0.resume(arg_13_0)
	arg_13_0:setMoveSpeed(arg_13_0.lastMoveSpeed)

	return
end

function var_0_0.clear(arg_14_0)
	for iter_14_0 = #arg_14_0._bgs, 1, -1 do
		local var_14_0 = table.remove(arg_14_0._bgs, iter_14_0)

		var_14_0:clear()
		table.insert(arg_14_0._bgsPool, var_14_0)
	end

	for iter_14_1 = #arg_14_0.thunders, 1, -1 do
		arg_14_0.thunders[iter_14_1].active = false

		setActive(arg_14_0.thunders[iter_14_1].tf, false)
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
			arg_15_1:SetActionCallBack(nil)

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
