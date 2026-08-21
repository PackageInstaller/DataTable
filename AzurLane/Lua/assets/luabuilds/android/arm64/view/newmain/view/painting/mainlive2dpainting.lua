local var_0_0 = class("MainLive2dPainting", import(".MainBasePainting"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.live2dContainer = arg_1_1:Find("live2d")
	arg_1_0.cg = arg_1_0.live2dContainer:GetComponent(typeof(CanvasGroup))
	arg_1_0.currentWidth = Screen.width
	arg_1_0.currentHeight = Screen.height
	arg_1_0.isModifyOrder = false
	arg_1_0.actionWaiting = false
	arg_1_0.eventTrigger = GetOrAddComponent(arg_1_0.live2dContainer, typeof(EventTriggerListener))

	arg_1_0.eventTrigger:AddPointClickFunc(function()
		arg_1_0:OnClick()
		arg_1_0:TriggerPersonalTask(arg_1_0.ship.groupId)

		return
	end)

	return
end

function var_0_0.GetHalfBodyOffsetY(arg_3_0)
	if not arg_3_0:IslimitYPos() then
		return 0
	end

	return MainPaintingShift.GetHalfBodyOffsetY(arg_3_0.container.parent, arg_3_0.live2dContainer)
end

function var_0_0.OnLoad(arg_4_0, arg_4_1)
	if arg_4_0.live2dChar then
		arg_4_0:OnUnload()
	end

	local var_4_0 = Live2DPainting.GenerateData({
		loadPrefs = true,
		ship = arg_4_0.ship,
		position = Vector3(0, 0, 100),
		parent = arg_4_0.live2dContainer
	})

	arg_4_0.actionWaiting = false

	arg_4_0:SetContainerVisible(true)

	arg_4_0.cg.blocksRaycasts = true
	arg_4_0.live2dChar = Live2DPainting.New(var_4_0, function(arg_5_0)
		arg_4_0:AdJustOrderInLayer(arg_5_0)

		if Live2dConst.l2d_bound_open then
			arg_4_0:CreateL2dDragBound(arg_5_0)
		end

		if arg_4_0._initTriggerAction then
			for iter_5_0, iter_5_1 in ipairs(arg_4_0._initTriggerAction) do
				local var_5_0 = pg.AssistantInfo.GetAssistantEvents(iter_5_1).action

				if arg_4_0.live2dChar:checkActionExist(var_5_0) then
					arg_4_0.live2dChar:TriggerAction(var_5_0)

					arg_4_0._initTriggerAction = nil

					break
				end
			end

			arg_4_0._initTriggerAction = nil
		end

		arg_4_1()

		return
	end)
	arg_4_0.shipGroup = getProxy(CollectionProxy):getShipGroup(arg_4_0.ship.groupId)

	arg_4_0:UpdateContainerPosition()
	arg_4_0:AddScreenChangeTimer()

	arg_4_0.cvLoaded = false

	arg_4_0:preloadCv(function()
		arg_4_0.cvLoaded = true

		if arg_4_0.pretriggerEvent then
			arg_4_0:_TriggerEvent(arg_4_0.pretriggerEvent)

			arg_4_0.pretriggerEvent = nil
		end

		return
	end)

	return
end

function var_0_0.ResetState(arg_7_0)
	if not arg_7_0.live2dChar then
		return
	end

	arg_7_0.live2dChar:resetL2dData()

	return
end

function var_0_0.AdJustOrderInLayer(arg_8_0, arg_8_1)
	arg_8_1:setSortingLayer(LayerWeightConst.L2D_DEFAULT_LAYER)

	return
end

function var_0_0.ResetOrderInLayer(arg_9_0)
	if not arg_9_0.live2dChar then
		return
	end

	arg_9_0.live2dChar._go:GetComponent(typeof(CubismRenderController)).SortingOrder = 0

	return
end

function var_0_0.CreateL2dDragBound(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	arg_10_0._dragBoundsUI = arg_10_0._dragBoundsUI or L2dBoundsUI.New()

	arg_10_1:SetLive2dPlayingCallback(function()
		if arg_10_1 then
			arg_10_0._dragBoundsUI:ActionChange(arg_10_1)
		end

		return
	end)
	arg_10_0._dragBoundsUI:InitUI(nil, function()
		if arg_10_0._dragBoundsUI and arg_10_1 then
			arg_10_0._dragBoundsUI:SetData(arg_10_1:GetDragBounds(), arg_10_0.ship:getSkinId())
			arg_10_0._dragBoundsUI:SetParent(arg_10_0.container)
			arg_10_0._dragBoundsUI:ActionChange(arg_10_1:GetLive2DStateData())
		end

		return
	end)

	return
end

function var_0_0.AddScreenChangeTimer(arg_13_0)
	arg_13_0:RemoveScreenChangeTimer()

	if not arg_13_0:IslimitYPos() then
		return
	end

	arg_13_0.screenTimer = Timer.New(function()
		if arg_13_0.currentWidth ~= Screen.width or arg_13_0.currentHeight ~= Screen.height then
			arg_13_0.currentWidth = Screen.width
			arg_13_0.currentHeight = Screen.height

			arg_13_0:ResetContainerPosition()
			arg_13_0:UpdateContainerPosition()
		end

		return
	end, 0.5, -1)

	arg_13_0.screenTimer:Start()

	return
end

function var_0_0.RemoveScreenChangeTimer(arg_15_0)
	if arg_15_0.screenTimer then
		arg_15_0.screenTimer:Stop()

		arg_15_0.screenTimer = nil
	end

	return
end

function var_0_0.UpdateContainerPosition(arg_16_0)
	local var_16_0 = arg_16_0._shift and arg_16_0._shift:GetL2dShift() or arg_16_0.live2dContainer.localPosition

	if arg_16_0:IslimitYPos() then
		var_16_0.y = arg_16_0:GetHalfBodyOffsetY()
	end

	arg_16_0.live2dContainer.localPosition = var_16_0

	return
end

function var_0_0.ResetContainerPosition(arg_17_0)
	local var_17_0

	if arg_17_0._shift then
		var_17_0 = arg_17_0._shift:GetL2dShift()
	else
		var_17_0 = arg_17_0.live2dContainer.localPosition
		var_17_0.z = 0
	end

	if arg_17_0:IslimitYPos() then
		var_17_0.y = arg_17_0:GetHalfBodyOffsetY()
	end

	arg_17_0.live2dContainer.localPosition = var_17_0

	return
end

function var_0_0.OnUnload(arg_18_0)
	if arg_18_0.live2dChar then
		arg_18_0:RemoveScreenChangeTimer()
		arg_18_0:ResetContainerPosition()

		if arg_18_0.isModifyOrder then
			arg_18_0.isModifyOrder = false

			arg_18_0:ResetOrderInLayer()
		end

		arg_18_0.cg.blocksRaycasts = false

		arg_18_0.live2dChar:saveLive2dData()
		arg_18_0.live2dChar:Dispose()

		arg_18_0.live2dChar = nil
	end

	if arg_18_0._dragBoundsUI then
		arg_18_0._dragBoundsUI:Dispose()

		arg_18_0._dragBoundsUI = nil
	end

	return
end

function var_0_0.OnClick(arg_19_0)
	local var_19_0

	if arg_19_0.live2dChar and arg_19_0.live2dChar.state == Live2DPainting.STATE_INITED and not arg_19_0.live2dChar.ignoreReact then
		if not Input.mousePosition then
			return
		end

		local var_19_1 = arg_19_0.live2dChar:GetTouchPart()

		if var_19_1 > 0 then
			local var_19_2 = arg_19_0:GetTouchEvent(var_19_1)

			var_19_0 = var_19_2[math.ceil(math.random(#var_19_2))]
		else
			local var_19_3 = arg_19_0:GetIdleEvents()

			var_19_0 = var_19_3[math.floor(math.Random(0, #var_19_3)) + 1]
		end
	end

	if var_19_0 then
		arg_19_0:TriggerEvent(var_19_0)
	end

	return
end

function var_0_0._TriggerEvent(arg_20_0, arg_20_1)
	if not arg_20_0.cvLoaded then
		arg_20_0.pretriggerEvent = arg_20_1

		return
	end

	if not arg_20_1 then
		return
	end

	if arg_20_0.actionWaiting then
		return
	end

	local var_20_0 = arg_20_0:GetEventConfig(arg_20_1)

	local function var_20_1(arg_21_0)
		if arg_21_0 then
			if var_20_0.dialog ~= "" then
				arg_20_0:DisplayWord(var_20_0.dialog)
			else
				arg_20_0:TriggerNextEventAuto()
			end
		end

		arg_20_0.actionWaiting = false

		return
	end

	local var_20_2, var_20_3, var_20_4, var_20_5, var_20_6, var_20_7 = ShipWordHelper.GetCvDataForShip(arg_20_0.ship, var_20_0.dialog)
	local var_20_8 = var_20_0.action
	local var_20_9 = string.gsub(var_20_0.dialog, "main_", "main")

	var_20_8 = arg_20_0.ship.propose and pg.character_voice[var_20_9] and arg_20_0.shipGroup and arg_20_0.shipGroup:VoiceReplayCodition(pg.character_voice[var_20_9]) and arg_20_0.live2dChar:checkActionExist(var_20_8 .. "_ex") and var_20_8 .. "_ex" or var_20_8

	if not var_20_7 then
		arg_20_0.actionWaiting = true

		var_20_1((arg_20_0.live2dChar:TriggerAction(var_20_8)))
	else
		arg_20_0.actionWaiting = true

		if not var_20_4 or var_20_4 == nil or var_20_4 == "" or var_20_4 == "nil" then
			arg_20_0.actionWaiting = false

			var_20_1(true)
		end

		if not arg_20_0.live2dChar:TriggerAction(var_20_8, nil, nil, var_20_1) then
			arg_20_0.actionWaiting = false
		end
	end

	return
end

function var_0_0.PlayCV(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	arg_22_0:RemoveSeTimer()

	if arg_22_1 then
		arg_22_0.seTimer = Timer.New(function()
			pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. arg_22_1[1])

			return
		end, arg_22_1[2], 1)

		arg_22_0.seTimer:Start()
	end

	arg_22_0.cvLoader:Load(pg.CriMgr.GetCVBankName((ShipWordHelper.RawGetCVKey(arg_22_0.ship:getSkinId()))), arg_22_3, arg_22_2, arg_22_4)

	return
end

function var_0_0.RemoveSeTimer(arg_24_0)
	if arg_24_0.seTimer then
		arg_24_0.seTimer:Stop()

		arg_24_0.seTimer = nil
	end

	return
end

function var_0_0.PlayChangeSkinActionIn(arg_25_0, arg_25_1)
	if arg_25_0.live2dChar:IsLoaded() then
		if arg_25_0.live2dChar:checkActionExist("change_in") then
			arg_25_0:TriggerEvent("event_change_in")
		else
			arg_25_0:TriggerEvent("event_login")
		end
	else
		arg_25_0._initTriggerAction = {
			"event_change_in",
			"event_login"
		}
	end

	if arg_25_1 and arg_25_1.callback then
		arg_25_1.callback({
			flag = true
		})
	end

	return
end

function var_0_0.PlayChangeSkinActionOut(arg_26_0, arg_26_1)
	if arg_26_0.live2dChar:IsLoaded() and arg_26_0.live2dChar:checkActionExist("change_out") then
		arg_26_0:playSkinOut(arg_26_1)
	elseif arg_26_1 and arg_26_1.callback then
		arg_26_1.callback({
			flag = true
		})
	end

	return
end

function var_0_0.UpdateBound(arg_27_0)
	if not arg_27_0._dragBoundsUI and arg_27_0.live2dChar then
		arg_27_0:CreateL2dDragBound(arg_27_0.live2dChar)
		arg_27_0._dragBoundsUI:SetVisible(Live2dConst.l2d_bound_open)
	elseif arg_27_0._dragBoundsUI then
		if arg_27_0._dragBoundsUI:GetDragsCount() == 0 then
			arg_27_0._dragBoundsUI:SetData(arg_27_0.live2dChar:GetDragBounds(), arg_27_0.ship:getSkinId())
		end

		arg_27_0._dragBoundsUI:SetVisible(Live2dConst.l2d_bound_open)
	end

	return
end

function var_0_0.playSkinOut(arg_28_0, arg_28_1)
	local function var_28_0()
		if arg_28_1 and arg_28_1.callback then
			arg_28_1.callback({
				flag = true
			})
		end

		return
	end

	if not arg_28_0.live2dChar:TriggerAction("change_out", function()
		return
	end, false, function()
		if var_28_0 then
			var_28_0()

			var_28_0 = nil
		end

		return
	end) and function()
		if arg_28_1 and arg_28_1.callback then
			arg_28_1.callback({
				flag = true
			})
		end

		return
	end then
		(function()
			if arg_28_1 and arg_28_1.callback then
				arg_28_1.callback({
					flag = true
				})
			end

			return
		end)()

		var_28_0 = nil
	end

	return
end

function var_0_0.OnDisplayWorld(arg_32_0)
	return
end

function var_0_0.OnPause(arg_33_0)
	print("pause")
	arg_33_0:RemoveScreenChangeTimer()
	arg_33_0:ResetContainerPosition()

	arg_33_0.actionWaiting = false

	arg_33_0:OnUnload()

	return
end

function var_0_0.OnUpdateShip(arg_34_0, arg_34_1)
	if arg_34_1 then
		arg_34_0.live2dChar:updateShip(arg_34_1)
	end

	return
end

function var_0_0.SetContainerVisible(arg_35_0, arg_35_1)
	return
end

function var_0_0.IsLoaded(arg_36_0)
	if not arg_36_0.live2dChar then
		return false
	end

	return var_0_0.super.IsLoaded(arg_36_0)
end

function var_0_0.OnResume(arg_37_0)
	arg_37_0:SetContainerVisible(true)
	arg_37_0:AddScreenChangeTimer()
	arg_37_0:UpdateContainerPosition()
	onNextTick(function()
		if arg_37_0.ship then
			arg_37_0:Load(arg_37_0.ship)
		end

		return
	end)

	return
end

function var_0_0.Dispose(arg_39_0)
	var_0_0.super.Dispose(arg_39_0)
	arg_39_0:RemoveSeTimer()
	arg_39_0:RemoveScreenChangeTimer()

	if arg_39_0._dragBoundsUI then
		arg_39_0._dragBoundsUI:Dispose()

		arg_39_0._dragBoundsUI = nil
	end

	if arg_39_0.eventTrigger then
		ClearEventTrigger(arg_39_0.eventTrigger)
	end

	return
end

function var_0_0.GetOffset(arg_40_0)
	return arg_40_0.live2dContainer.localPosition.x
end

function var_0_0.GetCenterPos(arg_41_0)
	return arg_41_0.live2dContainer.position
end

function var_0_0.IslimitYPos(arg_42_0)
	return MainPaintingShift.IsLimitYPos(arg_42_0.ship:getPainting())
end

return var_0_0
