class = var_0_10000

local var_0_0 = "MainSpinePainting"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBasePainting"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.bgTr = arg_1_3
	findTF = var_4
	arg_1_0.spTF = var_4(arg_1_1, "spinePainting")
	findTF = var_4
	arg_1_0.spBg = var_4(arg_1_3, "spinePainting")
	GameObject = var_4

	local var_1_0 = var_4.Find("UICamera")

	arg_1_0.uiCam = var_4.GetComponent(var_1_0, "Camera")
	arg_1_0._initCallback = {}

	return
end

function var_0_1.GetCenterPos(arg_2_0)
	return arg_2_0.spTF.position
end

function var_0_1.OnLoad(arg_3_0, arg_3_1)
	SpinePainting = var_1_10002

	local var_3_0 = var_1_10002.GenerateData
	local var_3_1 = {
		ship = arg_3_0.ship
	}

	Vector3 = var_4
	var_3_1.position = var_4(0, 0, 0)
	var_3_1.parent = arg_3_0.spTF
	var_3_1.effectParent = arg_3_0.spBg

	local var_3_2 = var_3_0(var_3_1)

	arg_3_0:ClearScalePart()

	SpinePainting = var_3
	arg_3_0.spinePainting = var_3.New(var_3_2, function(arg_4_0)
		local var_4_0 = arg_3_0

		var_1.AdJustOrderInLayer(var_4_0, arg_4_0)

		local var_4_1 = arg_3_0

		var_1.InitSpecialTouch(var_4_1)
		arg_3_1()

		ipairs = var_1

		for iter_4_0, iter_4_1 in var_1(arg_3_0._initCallback) do
			iter_4_1()
		end

		local var_4_2 = arg_3_0

		var_4_2._initCallback = {}
		getProxy = var_4_2
		PlayerProxy = var_2

		local var_4_3 = var_4_2(var_2)

		if var_1.getFlag(var_4_3, "login") then
			getProxy = var_1
			PlayerProxy = var_4_3

			local var_4_4 = var_1(var_4_3)

			var_1.setFlag(var_4_4, "login", nil)

			local var_4_5 = arg_3_0

			var_1.TriggerEvent(var_4_5, "event_login")
		end

		local var_4_6 = arg_3_0

		var_1.InitScalePart(var_4_6)

		return
	end)

	local var_3_3 = arg_3_0.spinePainting

	var_3.setEventTriggerCallback(var_3_3, function(arg_5_0)
		local var_5_0 = arg_3_0

		var_1.onSpinePaintingEvent(var_5_0, arg_5_0)

		return
	end)

	return
end

function var_0_1.AdJustOrderInLayer(arg_6_0, arg_6_1)
	local var_6_0 = 0
	local var_6_1 = arg_6_0.container
	local var_6_2 = var_3.GetComponent

	typeof = var_1_10005
	Canvas = var_1_10006

	if var_6_2(var_6_1, var_1_10005(var_1_10006)) and var_3.overrideSorting and var_3.sortingOrder ~= 0 then
		local var_6_3 = arg_6_0.spTF
		local var_6_4 = var_4.GetComponentsInChildren

		typeof = var_1_10006
		Canvas = var_1_10007

		local var_6_5 = var_6_4(var_6_3, var_1_10006(var_1_10007))
		local var_6_6 = var_4.ToTable(var_6_5)

		ipairs = var_6_5

		for iter_6_0, iter_6_1 in var_6_5(var_6_6) do
			iter_6_1.overrideSorting = true
			var_6_0 = iter_6_1.sortingOrder - var_3.sortingOrder
			iter_6_1.sortingOrder = var_3.sortingOrder
		end
	end

	local var_6_7 = arg_6_0.bgTr
	local var_6_8 = var_4.GetComponent

	typeof = var_1_10006
	Canvas = var_1_10007

	if var_6_8(var_6_7, var_1_10006(var_1_10007)) and var_4.overrideSorting and var_4.sortingOrder ~= 0 then
		local var_6_9 = arg_6_0.spBg
		local var_6_10 = var_5.GetComponentsInChildren

		typeof = var_1_10007
		Canvas = iter_6_0

		local var_6_11 = var_6_10(var_6_9, var_1_10007(iter_6_0))
		local var_6_12 = var_5.ToTable(var_6_11)

		ipairs = var_6_11

		for iter_6_2, iter_6_3 in var_6_11(var_6_12) do
			iter_6_3.overrideSorting = true
			iter_6_3.sortingOrder = iter_6_3.sortingOrder - var_6_0
		end

		local var_6_13 = arg_6_0.spBg
		local var_6_14 = var_6.GetComponentsInChildren

		typeof = var_8

		local var_6_15 = var_6_14(var_6_13, var_8("UnityEngine.ParticleSystemRenderer"))
		local var_6_16 = var_6.ToTable(var_6_15)

		ipairs = var_6_15

		for iter_6_4, iter_6_5 in var_6_15(var_6_16) do
			iter_6_5.sortingOrder = iter_6_5.sortingOrder - var_6_0
		end
	end

	return
end

function var_0_1.InitSpecialTouch(arg_7_0)
	local var_7_0 = arg_7_0.ship
	local var_7_1 = var_1.getPainting(var_7_0)

	arg_7_0.specialClickDic = {}
	findTF = var_2

	local var_7_2 = arg_7_0.spTF

	if not var_2(var_3.GetChild(var_7_2, 0), "hitArea") then
		return
	end

	eachChild = var_3

	var_3(var_2, function(arg_8_0)
		local var_8_0 = arg_7_0

		if var_1.getDragTouchAble(var_8_0, arg_8_0.name, var_7_1) then
			local var_8_1 = arg_7_0

			GetOrAddComponent = var_8_0

			local var_8_2 = arg_8_0

			typeof = var_4
			EventTriggerListener = var_2_10005
			var_8_1.dragEvent = var_8_0(var_8_2, var_4(var_2_10005))

			local var_8_3 = arg_7_0.dragEvent

			var_1.AddPointDownFunc(var_8_3, function(arg_9_0, arg_9_1)
				arg_7_0.dragActive = true
				arg_7_0.dragStart = arg_9_1.position

				return
			end)

			local var_8_4 = arg_7_0.dragEvent

			var_1.AddPointUpFunc(var_8_4, function(arg_10_0, arg_10_1)
				if arg_7_0.dragActive then
					arg_7_0.dragActive = false

					local var_10_0 = arg_7_0

					Vector2 = var_3
					var_10_0.dragOffset = var_3(arg_7_0.dragStart.x - arg_10_1.position.x, arg_7_0.dragStart.y - arg_10_1.position.y)
					math = var_10_0

					if not (var_10_0.abs(arg_7_0.dragOffset.x) < 200) then
						math = var_2

						if var_2.abs(arg_7_0.dragOffset.y) < 200 then
							arg_7_0.dragUp = arg_10_1.position

							local var_10_1 = arg_7_0.spinePainting

							if var_2.isInAction(var_10_1) then
								return
							end

							local var_10_2
							local var_10_3 = arg_7_0

							if var_3.getDragTouchAble(var_10_3, arg_8_0.name, var_7_1) then
								local var_10_4 = arg_7_0.spinePainting

								var_10_2 = var_3.readyDragAction(var_10_4, arg_8_0.name, false)
							end

							if not var_10_2 then
								local var_10_5 = arg_7_0.uiCam
								local var_10_6 = var_3.ScreenToWorldPoint(var_10_5, arg_10_1.position)

								for iter_10_0 = 1, #arg_7_0.specialClickDic do
									local var_10_7 = arg_7_0.specialClickDic[iter_10_0].tf
									local var_10_8 = var_9.InverseTransformPoint(var_10_7, var_10_6)

									math = var_10_7

									if var_10_7.abs(var_10_8.x) < var_8.bound.x / 2 then
										math = var_10

										if var_10.abs(var_10_8.y) < var_8.bound.y / 2 then
											local var_10_9 = arg_7_0

											var_10.PrepareTriggerAction(var_10_9, var_8.name)

											local var_10_10 = arg_7_0

											var_10.TriggerPersonalTask(var_10_10, var_8.task)
										end
									end
								end
							end
						end

						return
					end
				end
			end)

			local var_8_5 = arg_7_0.dragEvent

			var_1.AddDragFunc(var_8_5, function(arg_11_0, arg_11_1)
				if arg_7_0.dragActive then
					if arg_7_0.isDragAndZoomState then
						arg_7_0.dragActive = false

						return
					end

					if arg_7_0.chatting then
						arg_7_0.dragActive = false

						return
					end

					local var_11_0 = arg_7_0

					Vector2 = var_3_10003
					var_11_0.dragOffset = var_3_10003(arg_7_0.dragStart.x - arg_11_1.position.x, arg_7_0.dragStart.y - arg_11_1.position.y)
					math = var_11_0

					if not (var_11_0.abs(arg_7_0.dragOffset.x) > 200) then
						math = var_2

						if var_2.abs(arg_7_0.dragOffset.y) > 200 then
							local var_11_1 = arg_7_0.spinePainting

							if var_2.readyDragAction(var_11_1, arg_8_0.name, true) then
								arg_7_0.dragActive = false
							end
						end

						local var_11_2 = arg_7_0.spinePainting

						var_2.OnDragMove(var_11_2, arg_8_0.name, arg_7_0.dragOffset)

						return
					end
				end
			end)
		else
			local var_8_6 = arg_7_0

			if var_1.GetSpecialTouchEvent(var_8_6, arg_8_0.name) then
				table = var_8_6

				var_8_6.insert(arg_7_0.specialClickDic, {
					name = var_1,
					task = arg_7_0.ship.groupId,
					bound = arg_8_0.sizeDelta,
					tf = arg_8_0
				})
			end

			onButton = var_8_6

			var_8_6(arg_7_0, arg_8_0, function()
				local var_12_0 = arg_7_0.spinePainting

				if var_0.isInAction(var_12_0) then
					return
				end

				local var_12_1 = arg_7_0
				local var_12_2 = var_0.GetSpecialTouchEvent(var_12_1, arg_8_0.name)
				local var_12_3 = arg_7_0

				if var_1.getDragTouchAble(var_12_3, arg_8_0.name, var_7_1) then
					if arg_7_0.isDragAndZoomState then
						return
					end

					if arg_7_0.chatting then
						return
					end

					local var_12_4 = arg_7_0.spinePainting

					var_1.readyDragAction(var_12_4, arg_8_0.name, false)
				elseif var_12_2 and not arg_7_0._asmrFlag then
					local var_12_5 = arg_7_0

					var_1.TriggerEvent(var_12_5, var_12_2)

					local var_12_6 = arg_7_0

					var_1.TriggerPersonalTask(var_12_6, arg_7_0.ship.groupId)
				end

				return
			end)
		end

		return
	end)

	return
end

function var_0_1.OnClick(arg_13_0)
	local var_13_0 = arg_13_0.spinePainting

	if var_1.isInAction(var_13_0) or arg_13_0._asmrFlag then
		return
	end

	local var_13_1 = arg_13_0:CollectTouchEvents()
	local var_13_2 = arg_13_0
	local var_13_3 = arg_13_0.TriggerEvent

	math = var_1_10004

	local var_13_4 = var_1_10004.ceil

	math = var_1_10005

	var_13_3(var_13_2, var_13_1[var_13_4(var_1_10005.random(#var_13_1))])

	return
end

function var_0_1.OnEnableTimerEvent(arg_14_0)
	local var_14_0 = arg_14_0.spinePainting

	return not var_1.isInAction(var_14_0) and not arg_14_0._asmrFlag
end

function var_0_1.PrepareTriggerAction(arg_15_0, arg_15_1)
	if arg_15_0._asmrFlag then
		return
	end

	local var_15_0
	local var_15_1 = false
	local var_15_2 = ""

	pg = var_1_10005

	if var_1_10005.AssistantInfo.GetAssistantEvents(arg_15_1) then
		pg = var_5
		var_15_0 = var_5.AssistantInfo.GetAssistantEvents(arg_15_1).action

		local var_15_3 = arg_15_0.spinePainting

		var_15_1 = var_5.getAnimationExist(var_15_3, var_15_0)

		local var_15_4 = arg_15_0.spinePainting

		var_15_2 = var_5.getIdleName(var_15_4)
	end

	if var_15_1 and var_15_2 == "normal" then
		local var_15_5 = arg_15_0.spinePainting

		var_5.SetOnceAction(var_15_5, var_15_0, nil, function()
			local var_16_0 = arg_15_0

			var_0.TryToTriggerEvent(var_16_0, arg_15_1)

			return
		end, true)
	else
		arg_15_0:TryToTriggerEvent(arg_15_1)
	end

	return
end

function var_0_1.GetEventExit(arg_17_0, arg_17_1)
	local var_17_0 = false

	pg = var_1_10003

	if var_1_10003.AssistantInfo.GetAssistantEvents(arg_17_1) then
		pg = var_3

		local var_17_1 = var_3.AssistantInfo.GetAssistantEvents(arg_17_1).action
		local var_17_2 = arg_17_0.spinePainting

		var_17_0 = var_4.getAnimationExist(var_17_2, var_17_1)
	end

	return var_17_0
end

function var_0_1.TryToTriggerEvent(arg_18_0, arg_18_1)
	arg_18_0:_TriggerEvent(arg_18_1)

	return
end

function var_0_1.onSpinePaintingEvent(arg_19_0, arg_19_1)
	arg_19_0:TryToTriggerEvent(arg_19_1)
	arg_19_0:TriggerPersonalTask(arg_19_0.ship.groupId)

	return
end

function var_0_1.GetPaintingTransform(arg_20_0)
	if arg_20_0.spinePainting then
		local var_20_0 = arg_20_0.spinePainting

		return var_1.GetSpineTrasform(var_20_0)
	end

	return nil
end

function var_0_1.GetPartScaleData(arg_21_0)
	pg = var_1_10001

	local var_21_0 = var_1_10001.ship_skin_template
	local var_21_1 = arg_21_0.ship

	return var_21_0[var_2.getSkinId(var_21_1)].part_scale.spine
end

function var_0_1.GetPartStateType(arg_22_0)
	MainPaintingView = var_1_10001

	return var_1_10001.STATE_SPINE_PAINTING
end

function var_0_1.getDragTouchAble(arg_23_0, arg_23_1, arg_23_2)
	SpinePaintingConst = var_1_10003

	if not var_1_10003.ship_drag_datas[arg_23_2] then
		return false
	end

	if var_3.hit_area then
		table = var_4

		return var_4.contains(var_3.hit_area, arg_23_1)
	end

	return false
end

function var_0_1.OnDisplayWorld(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.ship
	local var_24_1 = var_2.getCVIntimacy(var_24_0)

	ShipExpressionHelper = var_24_0

	local var_24_2 = var_24_0.GetExpression
	local var_24_3 = arg_24_0.paintingName
	local var_24_4 = arg_24_1
	local var_24_5 = var_24_1
	local var_24_6 = arg_24_0.ship

	if var_24_2(var_24_3, var_24_4, var_24_5, var_7.getSkinId(var_24_6)) and var_3 ~= "" then
		local var_24_7 = arg_24_0.spinePainting

		var_4.SetAction(var_24_7, var_3, 1)

		local var_24_8 = arg_24_0.spinePainting

		var_4.displayWord(var_24_8, true)
	end

	return
end

function var_0_1.OnDisplayWordEnd(arg_25_0)
	var_0_1.super.OnDisplayWordEnd(arg_25_0)

	local var_25_0 = arg_25_0.spinePainting

	var_1.SetEmptyAction(var_25_0, 1)

	local var_25_1 = arg_25_0.spinePainting

	var_1.displayWord(var_25_1, false)

	return
end

function var_0_1.OnLongPress(arg_26_0)
	if arg_26_0.isFoldState then
		return
	end

	pg = var_1

	local var_26_0 = var_1.m02
	local var_26_1 = var_1.sendNotification

	GAME = var_1_10003

	local var_26_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	var_26_1(var_26_0, var_26_2, var_1_10004.SHIPINFO, {
		shipId = arg_26_0.ship.id
	})

	return
end

function var_0_1.PlayChangeSkinActionIn(arg_27_0, arg_27_1)
	if arg_27_0.spinePainting then
		local function var_27_0()
			if arg_27_1 and arg_27_1.callback then
				arg_27_1.callback({
					flag = true
				})
			end

			return
		end

		local function var_27_1()
			local var_29_0 = arg_27_0.spinePainting

			if var_0.GetDragDataConfig(var_29_0, "change_in_hit") and #var_0 > 0 then
				local var_29_1 = arg_27_0.spinePainting

				var_1.readyDragAction(var_29_1, var_0, false)
				var_27_0()
			else
				local var_29_2 = arg_27_0.spinePainting

				if var_1.getAnimationExist(var_29_2, "change_in") then
					local var_29_3 = arg_27_0.spinePainting

					if var_1.checkActionPlayAble(var_29_3, "change_in", false, 0) then
						local var_29_4 = arg_27_0.spinePainting

						var_1.SetOnceAction(var_29_4, "change_in", nil, function()
							var_27_0()

							return
						end, true)

						goto label_29_0
					end
				end

				local var_29_5 = arg_27_0

				var_1.TriggerEvent(var_29_5, "event_login")
				var_27_0()
			end

			::label_29_0::

			return
		end

		local var_27_2 = arg_27_0.spinePainting

		if var_4.getInitFlag(var_27_2) then
			var_27_1()
		else
			arg_27_0:pullInitCallback(var_27_1)
		end
	end

	return
end

function var_0_1.pullInitCallback(arg_31_0, arg_31_1)
	table = var_1_10002

	var_1_10002.insert(arg_31_0._initCallback, arg_31_1)

	return
end

function var_0_1.PlayChangeSkinActionOut(arg_32_0, arg_32_1)
	if arg_32_0.spinePainting then
		local var_32_0 = arg_32_0.spinePainting

		if var_2.getAnimationExist(var_32_0, "change_out") then
			local var_32_1 = arg_32_0.spinePainting

			if var_2.checkActionPlayAble(var_32_1, "change_out", false, 0) then
				local var_32_2 = arg_32_0.spinePainting

				var_2.SetOnceAction(var_32_2, "change_out", function()
					return
				end, function()
					if arg_32_1 and arg_32_1.callback then
						arg_32_1.callback({
							flag = true
						})
					end

					return
				end, true)
			elseif arg_32_1 and arg_32_1.callback then
				arg_32_1.callback({
					flag = true
				})
			end

			goto label_32_0
		end
	end

	if arg_32_1 and arg_32_1.callback then
		arg_32_1.callback({
			flag = true
		})
	end

	::label_32_0::

	return
end

function var_0_1.OnUnload(arg_35_0)
	if arg_35_0.spinePainting then
		local var_35_0 = arg_35_0.spinePainting

		var_1.Dispose(var_35_0)

		arg_35_0.spinePainting = nil
	end

	if arg_35_0.dragEvent then
		ClearEventTrigger = var_1

		var_1(arg_35_0.dragEvent)
	end

	return
end

function var_0_1.GetOffset(arg_36_0)
	return arg_36_0.spTF.localPosition.x
end

function var_0_1.OnPause(arg_37_0)
	if arg_37_0.spinePainting then
		local var_37_0 = arg_37_0.spinePainting

		var_1.SetVisible(var_37_0, false)
	end

	return
end

function var_0_1.OnResume(arg_38_0)
	if arg_38_0.spinePainting then
		local var_38_0 = arg_38_0.spinePainting

		var_1.SetVisible(var_38_0, true)

		local var_38_1 = arg_38_0.spinePainting

		var_1.SetEmptyAction(var_38_1, 1)
	end

	return
end

return var_0_1
