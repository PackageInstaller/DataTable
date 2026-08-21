local var_0_0 = class("MainSpinePainting", import(".MainBasePainting"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.bgTr = arg_1_3
	arg_1_0.spTF = findTF(arg_1_1, "spinePainting")
	arg_1_0.spBg = findTF(arg_1_3, "spinePainting")
	arg_1_0.uiCam = GameObject.Find("UICamera"):GetComponent("Camera")
	arg_1_0._initCallback = {}

	return
end

function var_0_0.GetCenterPos(arg_2_0)
	return arg_2_0.spTF.position
end

function var_0_0.OnLoad(arg_3_0, arg_3_1)
	arg_3_0:ClearScalePart()

	arg_3_0.spinePainting = SpinePainting.New(SpinePainting.GenerateData({
		ship = arg_3_0.ship,
		position = Vector3(0, 0, 0),
		parent = arg_3_0.spTF,
		effectParent = arg_3_0.spBg
	}), function(arg_4_0)
		arg_3_0:AdJustOrderInLayer(arg_4_0)
		arg_3_0:InitSpecialTouch()
		arg_3_1()

		for iter_4_0, iter_4_1 in ipairs(arg_3_0._initCallback) do
			iter_4_1()
		end

		arg_3_0._initCallback = {}

		if getProxy(PlayerProxy):getFlag("login") then
			getProxy(PlayerProxy):setFlag("login", nil)
			arg_3_0:TriggerEvent("event_login")
		end

		arg_3_0:InitScalePart()

		return
	end)

	arg_3_0.spinePainting:setEventTriggerCallback(function(arg_5_0)
		arg_3_0:onSpinePaintingEvent(arg_5_0)

		return
	end)

	return
end

function var_0_0.AdJustOrderInLayer(arg_6_0, arg_6_1)
	local var_6_0 = 0
	local var_6_1 = arg_6_0.container:GetComponent(typeof(Canvas))

	if var_6_1 and var_6_1.overrideSorting and var_6_1.sortingOrder ~= 0 then
		for iter_6_0, iter_6_1 in ipairs((arg_6_0.spTF:GetComponentsInChildren(typeof(Canvas)):ToTable())) do
			iter_6_1.overrideSorting = true
			var_6_0 = iter_6_1.sortingOrder - var_6_1.sortingOrder
			iter_6_1.sortingOrder = var_6_1.sortingOrder
		end
	end

	local var_6_2 = arg_6_0.bgTr:GetComponent(typeof(Canvas))

	if var_6_2 and var_6_2.overrideSorting and var_6_2.sortingOrder ~= 0 then
		for iter_6_2, iter_6_3 in ipairs((arg_6_0.spBg:GetComponentsInChildren(typeof(Canvas)):ToTable())) do
			iter_6_3.overrideSorting = true
			iter_6_3.sortingOrder = iter_6_3.sortingOrder - var_6_0
		end

		for iter_6_4, iter_6_5 in ipairs((arg_6_0.spBg:GetComponentsInChildren(typeof("UnityEngine.ParticleSystemRenderer")):ToTable())) do
			iter_6_5.sortingOrder = iter_6_5.sortingOrder - var_6_0
		end
	end

	return
end

function var_0_0.InitSpecialTouch(arg_7_0)
	local var_7_0 = arg_7_0.ship:getPainting()

	arg_7_0.specialClickDic = {}

	local var_7_1 = findTF(arg_7_0.spTF:GetChild(0), "hitArea")

	if not var_7_1 then
		return
	end

	eachChild(var_7_1, function(arg_8_0)
		if arg_7_0:getDragTouchAble(arg_8_0.name, var_7_0) then
			arg_7_0.dragEvent = GetOrAddComponent(arg_8_0, typeof(EventTriggerListener))

			arg_7_0.dragEvent:AddPointDownFunc(function(arg_9_0, arg_9_1)
				arg_7_0.dragActive = true
				arg_7_0.dragStart = arg_9_1.position

				return
			end)
			arg_7_0.dragEvent:AddPointUpFunc(function(arg_10_0, arg_10_1)
				if arg_7_0.dragActive then
					arg_7_0.dragActive = false
					arg_7_0.dragOffset = Vector2(arg_7_0.dragStart.x - arg_10_1.position.x, arg_7_0.dragStart.y - arg_10_1.position.y)

					if math.abs(arg_7_0.dragOffset.x) < 200 or math.abs(arg_7_0.dragOffset.y) < 200 then
						arg_7_0.dragUp = arg_10_1.position

						if arg_7_0.spinePainting:isInAction() then
							return
						end

						local var_10_0

						if arg_7_0:getDragTouchAble(arg_8_0.name, var_7_0) then
							var_10_0 = arg_7_0.spinePainting:readyDragAction(arg_8_0.name, false)
						end

						if not var_10_0 then
							local var_10_1 = arg_7_0.uiCam:ScreenToWorldPoint(arg_10_1.position)

							for iter_10_0 = 1, #arg_7_0.specialClickDic do
								local var_10_2 = arg_7_0.specialClickDic[iter_10_0].tf:InverseTransformPoint(var_10_1)

								if math.abs(var_10_2.x) < arg_7_0.specialClickDic[iter_10_0].bound.x / 2 and math.abs(var_10_2.y) < arg_7_0.specialClickDic[iter_10_0].bound.y / 2 then
									arg_7_0:PrepareTriggerAction(arg_7_0.specialClickDic[iter_10_0].name)
									arg_7_0:TriggerPersonalTask(arg_7_0.specialClickDic[iter_10_0].task)
								end
							end
						end
					end
				end

				return
			end)
			arg_7_0.dragEvent:AddDragFunc(function(arg_11_0, arg_11_1)
				if arg_7_0.dragActive then
					if arg_7_0.isDragAndZoomState then
						arg_7_0.dragActive = false

						return
					end

					if arg_7_0.chatting then
						arg_7_0.dragActive = false

						return
					end

					arg_7_0.dragOffset = Vector2(arg_7_0.dragStart.x - arg_11_1.position.x, arg_7_0.dragStart.y - arg_11_1.position.y)

					if (math.abs(arg_7_0.dragOffset.x) > 200 or math.abs(arg_7_0.dragOffset.y) > 200) and arg_7_0.spinePainting:readyDragAction(arg_8_0.name, true) then
						arg_7_0.dragActive = false
					end

					arg_7_0.spinePainting:OnDragMove(arg_8_0.name, arg_7_0.dragOffset)
				end

				return
			end)
		else
			local var_8_0 = arg_7_0:GetSpecialTouchEvent(arg_8_0.name)

			if var_8_0 then
				table.insert(arg_7_0.specialClickDic, {
					name = var_8_0,
					task = arg_7_0.ship.groupId,
					bound = arg_8_0.sizeDelta,
					tf = arg_8_0
				})
			end

			onButton(arg_7_0, arg_8_0, function()
				if arg_7_0.spinePainting:isInAction() then
					return
				end

				local var_12_0 = arg_7_0:GetSpecialTouchEvent(arg_8_0.name)

				if arg_7_0:getDragTouchAble(arg_8_0.name, var_7_0) then
					if arg_7_0.isDragAndZoomState then
						return
					end

					if arg_7_0.chatting then
						return
					end

					arg_7_0.spinePainting:readyDragAction(arg_8_0.name, false)
				elseif var_12_0 and not arg_7_0._asmrFlag then
					arg_7_0:TriggerEvent(var_12_0)
					arg_7_0:TriggerPersonalTask(arg_7_0.ship.groupId)
				end

				return
			end)
		end

		return
	end)

	return
end

function var_0_0.OnClick(arg_13_0)
	if arg_13_0.spinePainting:isInAction() or arg_13_0._asmrFlag then
		return
	end

	local var_13_0 = arg_13_0:CollectTouchEvents()

	arg_13_0:TriggerEvent(var_13_0[math.ceil(math.random(#var_13_0))])

	return
end

function var_0_0.OnEnableTimerEvent(arg_14_0)
	return not arg_14_0.spinePainting:isInAction() and not arg_14_0._asmrFlag
end

function var_0_0.PrepareTriggerAction(arg_15_0, arg_15_1)
	if arg_15_0._asmrFlag then
		return
	end

	local var_15_0
	local var_15_1 = false
	local var_15_2 = ""

	if pg.AssistantInfo.GetAssistantEvents(arg_15_1) then
		var_15_0 = pg.AssistantInfo.GetAssistantEvents(arg_15_1).action
		var_15_1 = arg_15_0.spinePainting:getAnimationExist(var_15_0)
		var_15_2 = arg_15_0.spinePainting:getIdleName()
	end

	if var_15_1 and var_15_2 == "normal" then
		arg_15_0.spinePainting:SetOnceAction(var_15_0, nil, function()
			arg_15_0:TryToTriggerEvent(arg_15_1)

			return
		end, true)
	else
		arg_15_0:TryToTriggerEvent(arg_15_1)
	end

	return
end

function var_0_0.GetEventExit(arg_17_0, arg_17_1)
	local var_17_0 = false

	if pg.AssistantInfo.GetAssistantEvents(arg_17_1) then
		var_17_0 = arg_17_0.spinePainting:getAnimationExist(pg.AssistantInfo.GetAssistantEvents(arg_17_1).action)
	end

	return var_17_0
end

function var_0_0.TryToTriggerEvent(arg_18_0, arg_18_1)
	arg_18_0:_TriggerEvent(arg_18_1)

	return
end

function var_0_0.onSpinePaintingEvent(arg_19_0, arg_19_1)
	arg_19_0:TryToTriggerEvent(arg_19_1)
	arg_19_0:TriggerPersonalTask(arg_19_0.ship.groupId)

	return
end

function var_0_0.GetPaintingTransform(arg_20_0)
	if arg_20_0.spinePainting then
		return arg_20_0.spinePainting:GetSpineTrasform()
	end

	return nil
end

function var_0_0.GetPartScaleData(arg_21_0)
	return pg.ship_skin_template[arg_21_0.ship:getSkinId()].part_scale.spine
end

function var_0_0.GetPartStateType(arg_22_0)
	return MainPaintingView.STATE_SPINE_PAINTING
end

function var_0_0.getDragTouchAble(arg_23_0, arg_23_1, arg_23_2)
	if not SpinePaintingConst.ship_drag_datas[arg_23_2] then
		return false
	end

	if SpinePaintingConst.ship_drag_datas[arg_23_2].hit_area then
		return table.contains(SpinePaintingConst.ship_drag_datas[arg_23_2].hit_area, arg_23_1)
	end

	return false
end

function var_0_0.OnDisplayWorld(arg_24_0, arg_24_1)
	local var_24_0 = ShipExpressionHelper.GetExpression(arg_24_0.paintingName, arg_24_1, arg_24_0.ship:getCVIntimacy(), arg_24_0.ship:getSkinId())

	if var_24_0 and var_24_0 ~= "" then
		arg_24_0.spinePainting:SetAction(var_24_0, 1)
		arg_24_0.spinePainting:displayWord(true)
	end

	return
end

function var_0_0.OnDisplayWordEnd(arg_25_0)
	var_0_0.super.OnDisplayWordEnd(arg_25_0)
	arg_25_0.spinePainting:SetEmptyAction(1)
	arg_25_0.spinePainting:displayWord(false)

	return
end

function var_0_0.OnLongPress(arg_26_0)
	if arg_26_0.isFoldState then
		return
	end

	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
		shipId = arg_26_0.ship.id
	})

	return
end

function var_0_0.PlayChangeSkinActionIn(arg_27_0, arg_27_1)
	if arg_27_0.spinePainting then
		local function var_27_0()
			if arg_27_1 and arg_27_1.callback then
				arg_27_1.callback({
					flag = true
				})
			end

			return
		end

		if arg_27_0.spinePainting:getInitFlag() then
			(function()
				local var_29_0 = arg_27_0.spinePainting:GetDragDataConfig("change_in_hit")

				if var_29_0 and #var_29_0 > 0 then
					arg_27_0.spinePainting:readyDragAction(var_29_0, false)
					var_27_0()
				elseif arg_27_0.spinePainting:getAnimationExist("change_in") and arg_27_0.spinePainting:checkActionPlayAble("change_in", false, 0) then
					arg_27_0.spinePainting:SetOnceAction("change_in", nil, function()
						var_27_0()

						return
					end, true)
				else
					arg_27_0:TriggerEvent("event_login")
					var_27_0()
				end

				return
			end)()
		else
			arg_27_0:pullInitCallback(function()
				local var_29_0 = arg_27_0.spinePainting:GetDragDataConfig("change_in_hit")

				if var_29_0 and #var_29_0 > 0 then
					arg_27_0.spinePainting:readyDragAction(var_29_0, false)
					var_27_0()
				elseif arg_27_0.spinePainting:getAnimationExist("change_in") and arg_27_0.spinePainting:checkActionPlayAble("change_in", false, 0) then
					arg_27_0.spinePainting:SetOnceAction("change_in", nil, function()
						var_27_0()

						return
					end, true)
				else
					arg_27_0:TriggerEvent("event_login")
					var_27_0()
				end

				return
			end)
		end
	end

	return
end

function var_0_0.pullInitCallback(arg_31_0, arg_31_1)
	table.insert(arg_31_0._initCallback, arg_31_1)

	return
end

function var_0_0.PlayChangeSkinActionOut(arg_32_0, arg_32_1)
	if arg_32_0.spinePainting and arg_32_0.spinePainting:getAnimationExist("change_out") then
		if arg_32_0.spinePainting:checkActionPlayAble("change_out", false, 0) then
			arg_32_0.spinePainting:SetOnceAction("change_out", function()
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
	elseif arg_32_1 and arg_32_1.callback then
		arg_32_1.callback({
			flag = true
		})
	end

	return
end

function var_0_0.OnUnload(arg_35_0)
	if arg_35_0.spinePainting then
		arg_35_0.spinePainting:Dispose()

		arg_35_0.spinePainting = nil
	end

	if arg_35_0.dragEvent then
		ClearEventTrigger(arg_35_0.dragEvent)
	end

	return
end

function var_0_0.GetOffset(arg_36_0)
	return arg_36_0.spTF.localPosition.x
end

function var_0_0.OnPause(arg_37_0)
	if arg_37_0.spinePainting then
		arg_37_0.spinePainting:SetVisible(false)
	end

	return
end

function var_0_0.OnResume(arg_38_0)
	if arg_38_0.spinePainting then
		arg_38_0.spinePainting:SetVisible(true)
		arg_38_0.spinePainting:SetEmptyAction(1)
	end

	return
end

return var_0_0
