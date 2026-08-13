class = var_0_10000

local var_0_0 = var_0_10000("L2dBoundsUI")
local var_0_1 = "l2dui"

function var_0_0.Ctor(arg_1_0)
	Timer = var_1_10001
	arg_1_0._timer = var_1_10001.New(function()
		local var_2_0 = arg_1_0

		var_0.step(var_2_0)

		return
	end, 0.03333333333333333, -1)

	local var_1_0 = arg_1_0._timer

	var_1.Start(var_1_0)

	arg_1_0._dragsUI = {}
	arg_1_0.visible = true
	pg = var_1
	var_0_1 = var_1.gameset.l2d_tips_default_icon.description

	return
end

function var_0_0.InitUI(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1 = arg_3_1 or "l2dboundsui"
	PoolMgr = var_1_10003

	local var_3_0 = var_1_10003.GetInstance()

	var_3.GetUI(var_3_0, arg_3_1, true, function(arg_4_0)
		if arg_3_0._isDispose then
			Destroy = var_1

			var_1(arg_4_0)

			return
		end

		local var_4_0 = arg_3_0

		var_1.onLoaded(var_4_0, arg_4_0)

		if arg_3_2 then
			arg_3_2(arg_3_0)
		end

		return
	end)

	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._bounds = arg_5_1
	pg = var_1_10003
	arg_5_0._tipConfig = var_1_10003.ship_l2d_tips[arg_5_2]

	if not arg_5_0._tipConfig then
		return
	end

	arg_5_0._tipOffset = arg_5_0._tipConfig.tips_offset
	arg_5_0._tipsScale = arg_5_0._tipConfig.tips_scale
	arg_5_0._tipsIdleBlackList = arg_5_0._tipConfig.idle_black_list
	arg_5_0._tipsAnimWhiteList = arg_5_0._tipConfig.anim_white_list

	arg_5_0:createDrags()

	return
end

function var_0_0.SetParent(arg_6_0, arg_6_1)
	if arg_6_0._tf then
		SetParent = var_2

		var_2(arg_6_0._tf, arg_6_1)
	end

	return
end

function var_0_0.onLoaded(arg_7_0, arg_7_1)
	tf = var_1_10002
	arg_7_0._tf = var_1_10002(arg_7_1)
	findTF = var_2
	arg_7_0._container = var_2(arg_7_0._tf, "ad")
	findTF = var_2
	arg_7_0._boundsTpl = var_2(arg_7_0._tf, "ad/bounds_tpl")
	setActive = var_2

	var_2(arg_7_0._boundsTpl, false)

	setActive = var_2

	var_2(arg_7_0._tf, true)

	return
end

function var_0_0.step(arg_8_0)
	if not arg_8_0._bounds or #arg_8_0._dragsUI == 0 then
		return
	end

	GameObject = var_1

	local var_8_0 = var_1.Find("UICamera")
	local var_8_1 = var_1.GetComponent

	typeof = var_1_10003
	Camera = var_1_10004

	local var_8_2 = var_8_1(var_8_0, var_1_10003(var_1_10004))
	local var_8_3 = var_1.ScreenToWorldPoint

	Vector3 = var_1_10004

	local var_8_4 = var_8_3(var_8_2, var_1_10004(0, 0, -10))
	local var_8_5 = var_1
	local var_8_6 = var_1.ScreenToWorldPoint

	Vector3 = var_5
	Screen = var_6

	local var_8_7 = var_6.width

	Screen = var_7

	local var_8_8 = var_8_6(var_8_5, var_5(var_8_7, var_7.height, -10))

	Screen = var_8_5

	local var_8_9 = var_8_5.width / (var_8_8.x - var_8_4.x)

	Screen = var_5

	local var_8_10 = var_5.height / (var_8_8.y - var_8_4.y)

	for iter_8_0 = 1, #arg_8_0._bounds do
		local var_8_11 = arg_8_0._bounds[iter_8_0].name
		local var_8_12 = var_10.bounds.min
		local var_8_13 = var_10.bounds.max
		local var_8_14 = true

		if not arg_8_0.visible then
			var_8_14 = false
		elseif arg_8_0._state.isPlaying then
			if not arg_8_0:MatchPlayingList(var_8_11) then
				var_8_14 = false
			end
		elseif not arg_8_0._state.isPlaying and arg_8_0:MatchIdleBlackList(var_8_11) then
			var_8_14 = false
		elseif var_8_12.x >= var_8_8.x or var_8_12.y >= var_8_8.y or var_8_13.x <= var_8_4.x or var_8_13.y <= var_8_4.y then
			var_8_14 = false
		end

		arg_8_0:setUIVisible(arg_8_0._dragsUI[iter_8_0], var_8_14)

		if var_8_14 then
			local var_8_15 = var_10.bounds.min
			local var_8_16 = var_10.bounds.max
			local var_8_17

			if not (var_8_15.x < var_8_4.x) or not var_8_4.x then
				var_8_17 = var_8_15.x
			end

			var_8_15.x = var_8_17

			local var_8_18

			if not (var_8_15.y < var_8_4.y) or not var_8_4.y then
				var_8_18 = var_8_15.y
			end

			var_8_15.y = var_8_18

			local var_8_19

			if not (var_8_16.x > var_8_8.x) or not var_8_8.x then
				var_8_19 = var_8_16.x
			end

			var_8_16.x = var_8_19

			local var_8_20

			if not (var_8_16.y > var_8_8.y) or not var_8_8.y then
				var_8_20 = var_8_16.y
			end

			var_8_16.y = var_8_20

			local var_8_21 = var_8_16.x - var_8_15.x
			local var_8_22 = var_8_16.y - var_8_15.y
			local var_8_23 = arg_8_0._dragsUI[iter_8_0]

			Vector3 = var_1_10020
			var_8_23.position = var_1_10020(var_8_15.x + var_8_21 / 2, var_8_15.y + var_8_22 / 2, 0)

			local var_8_24 = arg_8_0._dragsUI[iter_8_0]

			Vector2 = var_1_10020
			var_8_24.sizeDelta = var_1_10020(var_8_21 * var_8_9 - 10, var_8_22 * var_8_10 - 10)
		end
	end

	return
end

function var_0_0.setUIVisible(arg_9_0, arg_9_1, arg_9_2)
	isActive = var_1_10003

	if var_1_10003(arg_9_1) ~= arg_9_2 then
		setActive = var_3

		var_3(arg_9_1, arg_9_2)
	end

	return
end

function var_0_0.createDrags(arg_10_0)
	if arg_10_0._isDispose or not arg_10_0._boundsTpl then
		return
	end

	arg_10_0:clearDrags()

	for iter_10_0 = 1, #arg_10_0._bounds do
		local var_10_0 = arg_10_0._bounds[iter_10_0]

		Instantiate = var_1_10006
		var_1_10006 = var_1_10006(arg_10_0._boundsTpl)
		GetOrAddComponent = var_7

		local var_10_1 = var_1_10006

		typeof = var_1_10009
		EventTriggerListener = var_1_10010

		var_7(var_10_1, var_1_10009(var_1_10010))

		SetParent = var_7

		var_7(var_1_10006, arg_10_0._container)

		table = var_7

		local var_10_2 = var_7.insert
		local var_10_3 = arg_10_0._dragsUI

		tf = var_1_10009

		var_10_2(var_10_3, var_1_10009(var_1_10006))

		var_1_10006.name = var_10_0.name
		setText = var_7
		findTF = var_10_3

		var_7(var_10_3(var_1_10006, "ad/text"), var_10_0.name)

		setActive = var_7
		findTF = var_8

		var_7(var_8(var_1_10006, "ad/text"), false)

		local var_10_4 = var_10_0.name

		var_1_10009 = arg_10_0

		arg_10_0.getDragBoundUI(var_1_10009, var_10_4, function(arg_11_0)
			local var_11_0

			if arg_10_0._tf then
				tf = var_11_0
				var_11_0 = var_11_0(arg_11_0)
				arg_11_0.name = var_10_4
				findTF = var_2

				local var_11_1 = var_2(var_1_10006, "ad")

				SetParent = var_3

				var_3(var_11_0, var_11_1)

				local var_11_2 = arg_10_0
				local var_11_3 = var_3.GetOffset(var_11_2, var_10_4)
				local var_11_4 = arg_10_0

				var_11_0.localScale, var_11_0.anchoredPosition = var_4.GetScale(var_11_4, var_10_4), var_11_3
				setActive = var_11_4

				var_11_4(var_11_0, true)

				setText = var_11_4
				findTF = var_6

				local var_11_5 = var_6(var_11_0, "Image/Text")

				tostring = var_7

				var_11_4(var_11_5, var_7(iter_10_0))
			else
				Destroy = var_11_0

				var_11_0(arg_11_0)
			end

			return
		end)
	end

	return
end

function var_0_0.MatchIdleBlackList(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._state.idleIndex

	if arg_12_0._tipsIdleBlackList and #arg_12_0._tipsIdleBlackList >= 0 then
		ipairs = var_3

		for iter_12_0, iter_12_1 in var_3(arg_12_0._tipsIdleBlackList) do
			local var_12_1 = iter_12_1.drawable
			local var_12_2 = iter_12_1.idle

			table = var_1_10010

			if var_1_10010.contains(var_12_1, arg_12_1) then
				table = var_1_10010

				if var_1_10010.contains(var_12_2, var_12_0) then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.MatchPlayingList(arg_13_0, arg_13_1)
	if not arg_13_0._state.isPlaying then
		return false
	end

	local var_13_0 = arg_13_0._state.actionName

	if arg_13_0._tipsAnimWhiteList and #arg_13_0._tipsAnimWhiteList >= 0 then
		ipairs = var_4

		for iter_13_0, iter_13_1 in var_4(arg_13_0._tipsAnimWhiteList) do
			local var_13_1 = iter_13_1.drawable
			local var_13_2 = iter_13_1.white_list

			table = var_1_10011

			if var_1_10011.contains(var_13_1, arg_13_1) then
				table = var_1_10011

				if var_1_10011.contains(var_13_2, var_13_0) then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.GetScale(arg_14_0, arg_14_1)
	Vector3 = var_1_10002

	local var_14_0 = var_1_10002(1, 1, 1)

	if arg_14_0._tipsScale and #arg_14_0._tipsScale > 0 then
		ipairs = var_3

		for iter_14_0, iter_14_1 in var_3(arg_14_0._tipsScale) do
			local var_14_1 = iter_14_1.drawable
			local var_14_2 = iter_14_1.scale

			table = var_1_10010

			if var_1_10010.contains(var_14_1, arg_14_1) then
				var_14_0.x = var_14_2[1]
				var_14_0.y = var_14_2[2]
				var_14_0.z = var_14_2[3]
			end
		end
	end

	return var_14_0
end

function var_0_0.GetOffset(arg_15_0, arg_15_1)
	Vector2 = var_1_10002

	local var_15_0 = var_1_10002(0, 0)

	if arg_15_0._tipOffset and #arg_15_0._tipOffset > 0 then
		ipairs = var_3

		for iter_15_0, iter_15_1 in var_3(arg_15_0._tipOffset) do
			local var_15_1 = iter_15_1.drawable
			local var_15_2 = iter_15_1.offset

			table = var_1_10010

			if var_1_10010.contains(var_15_1, arg_15_1) then
				var_15_0.x = var_15_2[1]
				var_15_0.y = var_15_2[2]
			end
		end
	end

	return var_15_0
end

function var_0_0.getDragBoundUI(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0._tipConfig.tips_icon
	local var_16_1 = var_0_1

	if var_16_0 and #var_16_0 > 0 then
		ipairs = var_1_10005

		for iter_16_0, iter_16_1 in var_1_10005(var_16_0) do
			local var_16_2 = iter_16_1.drawable
			local var_16_3 = iter_16_1.icon

			table = var_1_10012

			if var_1_10012.contains(var_16_2, arg_16_1) then
				var_16_1 = iter_16_1.icon
			end
		end
	end

	PoolMgr = var_1_10005

	local var_16_4 = var_1_10005.GetInstance()

	var_5.GetPrefab(var_16_4, "ui/" .. var_16_1, nil, true, function(arg_17_0)
		if arg_16_2 then
			arg_16_2(arg_17_0)
		end

		return
	end)

	return
end

function var_0_0.GetDragsCount(arg_18_0)
	if arg_18_0._dragsUI then
		return #arg_18_0._dragsUI
	end

	return 0
end

function var_0_0.ActionChange(arg_19_0, arg_19_1)
	arg_19_0._state = arg_19_1

	return
end

function var_0_0.SetVisible(arg_20_0, arg_20_1)
	arg_20_0.visible = arg_20_1

	return
end

function var_0_0.clearDrags(arg_21_0)
	if arg_21_0._dragsUI and #arg_21_0._dragsUI > 0 then
		for iter_21_0 = 1, #arg_21_0._dragsUI do
			ClearEventTrigger = var_1_10005
			GetComponent = var_1_10006

			local var_21_0 = arg_21_0._dragsUI[iter_21_0]

			typeof = var_1_10008
			EventTriggerListener = var_1_10009

			var_1_10005(var_1_10006(var_21_0, var_1_10008(var_1_10009)))

			Destroy = var_1_10005

			var_1_10005(arg_21_0._dragsUI[iter_21_0])
		end

		arg_21_0._dragsUI = {}
	end

	return
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0._isDispose = true

	if arg_22_0._timer then
		local var_22_0 = arg_22_0._timer

		var_1.Stop(var_22_0)

		arg_22_0._timer = nil
	end

	if arg_22_0._bounds then
		arg_22_0._bounds = nil
	end

	if arg_22_0._tf then
		Destroy = var_1

		var_1(arg_22_0._tf)

		arg_22_0._tf = nil
	end

	arg_22_0._boundsTpl = nil

	arg_22_0:clearDrags()

	return
end

return var_0_0
