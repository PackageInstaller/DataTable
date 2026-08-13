class = var_0_10000

local var_0_0 = "MainLive2dPainting"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBasePainting"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.live2dContainer = arg_1_1:Find("live2d")

	local var_1_0 = arg_1_0.live2dContainer
	local var_1_1 = var_3.GetComponent

	typeof = var_6
	CanvasGroup = var_1_10008
	arg_1_0.cg = var_1_1(var_1_0, var_6(var_1_10008))
	Screen = var_3
	arg_1_0.currentWidth = var_3.width
	Screen = var_3
	arg_1_0.currentHeight = var_3.height
	arg_1_0.isModifyOrder = false
	arg_1_0.actionWaiting = false
	GetOrAddComponent = var_3

	local var_1_2 = arg_1_0.live2dContainer

	typeof = var_6
	EventTriggerListener = var_1_10008
	arg_1_0.eventTrigger = var_3(var_1_2, var_6(var_1_10008))

	local var_1_3 = arg_1_0.eventTrigger

	var_3.AddPointClickFunc(var_1_3, function()
		local var_2_0 = arg_1_0

		var_0.OnClick(var_2_0)

		local var_2_1 = arg_1_0

		var_0.TriggerPersonalTask(var_2_1, arg_1_0.ship.groupId)

		return
	end)

	return
end

function var_0_1.GetHalfBodyOffsetY(arg_3_0)
	if not arg_3_0:IslimitYPos() then
		return 0
	end

	MainPaintingShift = var_1

	return var_1.GetHalfBodyOffsetY(arg_3_0.container.parent, arg_3_0.live2dContainer)
end

function var_0_1.OnLoad(arg_4_0, arg_4_1)
	if arg_4_0.live2dChar then
		arg_4_0:OnUnload()
	end

	Live2DPainting = var_2

	local var_4_0 = var_2.GenerateData
	local var_4_1 = {
		loadPrefs = true,
		ship = arg_4_0.ship
	}

	Vector3 = var_5
	var_4_1.position = var_5(0, 0, 100)
	var_4_1.parent = arg_4_0.live2dContainer

	local var_4_2 = var_4_0(var_4_1)

	arg_4_0.actionWaiting = false

	arg_4_0:SetContainerVisible(true)

	local var_4_3 = arg_4_0.cg

	var_4_3.blocksRaycasts = true
	Live2DPainting = var_4_3
	arg_4_0.live2dChar = var_4_3.New(var_4_2, function(arg_5_0)
		local var_5_0 = arg_4_0

		var_1.AdJustOrderInLayer(var_5_0, arg_5_0)

		Live2dConst = var_1

		if var_1.l2d_bound_open then
			local var_5_1 = arg_4_0

			var_1.CreateL2dDragBound(var_5_1, arg_5_0)
		end

		if arg_4_0._initTriggerAction then
			ipairs = var_1

			for iter_5_0, iter_5_1 in var_1(arg_4_0._initTriggerAction) do
				pg = var_2_10006
				var_2_10006 = var_2_10006.AssistantInfo.GetAssistantEvents(iter_5_1).action

				local var_5_2 = arg_4_0.live2dChar

				if var_7.checkActionExist(var_5_2, var_2_10006) then
					local var_5_3 = arg_4_0.live2dChar

					var_7.TriggerAction(var_5_3, var_2_10006)

					arg_4_0._initTriggerAction = nil

					break
				end
			end

			arg_4_0._initTriggerAction = nil
		end

		arg_4_1()

		return
	end)
	getProxy = var_3
	CollectionProxy = var_5

	local var_4_4 = var_3(var_5)

	arg_4_0.shipGroup = var_3.getShipGroup(var_4_4, arg_4_0.ship.groupId)

	arg_4_0:UpdateContainerPosition()
	arg_4_0:AddScreenChangeTimer()

	arg_4_0.cvLoaded = false

	arg_4_0:preloadCv(function()
		arg_4_0.cvLoaded = true

		if arg_4_0.pretriggerEvent then
			local var_6_0 = arg_4_0

			var_0._TriggerEvent(var_6_0, arg_4_0.pretriggerEvent)

			arg_4_0.pretriggerEvent = nil
		end

		return
	end)

	return
end

function var_0_1.ResetState(arg_7_0)
	if not arg_7_0.live2dChar then
		return
	end

	local var_7_0 = arg_7_0.live2dChar

	var_1.resetL2dData(var_7_0)

	return
end

function var_0_1.AdJustOrderInLayer(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.setSortingLayer

	LayerWeightConst = var_1_10005

	var_8_1(var_8_0, var_1_10005.L2D_DEFAULT_LAYER)

	return
end

function var_0_1.ResetOrderInLayer(arg_9_0)
	if not arg_9_0.live2dChar then
		return
	end

	local var_9_0 = arg_9_0.live2dChar._go
	local var_9_1 = var_1.GetComponent

	typeof = var_1_10004
	CubismRenderController = var_1_10006
	var_9_1(var_9_0, var_1_10004(var_1_10006)).SortingOrder = 0

	return
end

function var_0_1.CreateL2dDragBound(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	if not arg_10_0._dragBoundsUI then
		L2dBoundsUI = var_2
		arg_10_0._dragBoundsUI = var_2.New()
	end

	arg_10_1:SetLive2dPlayingCallback(function()
		if arg_10_1 then
			local var_11_0 = arg_10_0._dragBoundsUI

			var_0.ActionChange(var_11_0, arg_10_1)
		end

		return
	end)

	local var_10_0 = arg_10_0._dragBoundsUI

	var_2.InitUI(var_10_0, nil, function()
		if arg_10_0._dragBoundsUI and arg_10_1 then
			local var_12_0 = arg_10_1
			local var_12_1 = var_0.GetDragBounds(var_12_0)
			local var_12_2 = arg_10_0._dragBoundsUI
			local var_12_3 = var_1.SetData
			local var_12_4 = var_12_1
			local var_12_5 = arg_10_0.ship

			var_12_3(var_12_2, var_12_4, var_5.getSkinId(var_12_5))

			local var_12_6 = arg_10_0._dragBoundsUI

			var_1.SetParent(var_12_6, arg_10_0.container)

			local var_12_7 = arg_10_0._dragBoundsUI
			local var_12_8 = var_1.ActionChange
			local var_12_9 = arg_10_1

			var_12_8(var_12_7, var_4.GetLive2DStateData(var_12_9))
		end

		return
	end)

	return
end

function var_0_1.AddScreenChangeTimer(arg_13_0)
	arg_13_0:RemoveScreenChangeTimer()

	if not arg_13_0:IslimitYPos() then
		return
	end

	Timer = var_1
	arg_13_0.screenTimer = var_1.New(function()
		local var_14_0 = arg_13_0.currentWidth

		Screen = var_2_10001

		if var_14_0 == var_2_10001.width then
			local var_14_1 = arg_13_0.currentHeight

			Screen = var_1

			if var_14_1 ~= var_1.height then
				local var_14_2 = arg_13_0

				Screen = var_1
				var_14_2.currentWidth = var_1.width

				local var_14_3 = arg_13_0

				Screen = var_1
				var_14_3.currentHeight = var_1.height

				local var_14_4 = arg_13_0

				var_0.ResetContainerPosition(var_14_4)

				local var_14_5 = arg_13_0

				var_0.UpdateContainerPosition(var_14_5)
			end

			return
		end
	end, 0.5, -1)

	local var_13_0 = arg_13_0.screenTimer

	var_1.Start(var_13_0)

	return
end

function var_0_1.RemoveScreenChangeTimer(arg_15_0)
	if arg_15_0.screenTimer then
		local var_15_0 = arg_15_0.screenTimer

		var_1.Stop(var_15_0)

		arg_15_0.screenTimer = nil
	end

	return
end

function var_0_1.UpdateContainerPosition(arg_16_0)
	local var_16_0

	if arg_16_0._shift then
		local var_16_1 = arg_16_0._shift

		var_16_0 = var_2.GetL2dShift(var_16_1)
	else
		var_16_0 = arg_16_0.live2dContainer.localPosition
	end

	if arg_16_0:IslimitYPos() then
		var_16_0.y = arg_16_0:GetHalfBodyOffsetY()
	end

	arg_16_0.live2dContainer.localPosition = var_16_0

	return
end

function var_0_1.ResetContainerPosition(arg_17_0)
	local var_17_0

	if arg_17_0._shift then
		local var_17_1 = arg_17_0._shift

		var_17_0 = var_2.GetL2dShift(var_17_1)
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

function var_0_1.OnUnload(arg_18_0)
	if arg_18_0.live2dChar then
		arg_18_0:RemoveScreenChangeTimer()
		arg_18_0:ResetContainerPosition()

		if arg_18_0.isModifyOrder then
			arg_18_0.isModifyOrder = false

			arg_18_0:ResetOrderInLayer()
		end

		arg_18_0.cg.blocksRaycasts = false

		local var_18_0 = arg_18_0.live2dChar

		var_1.saveLive2dData(var_18_0)

		local var_18_1 = arg_18_0.live2dChar

		var_1.Dispose(var_18_1)

		arg_18_0.live2dChar = nil
	end

	if arg_18_0._dragBoundsUI then
		local var_18_2 = arg_18_0._dragBoundsUI

		var_1.Dispose(var_18_2)

		arg_18_0._dragBoundsUI = nil
	end

	return
end

function var_0_1.OnClick(arg_19_0)
	local var_19_0

	if arg_19_0.live2dChar then
		local var_19_1 = arg_19_0.live2dChar.state

		Live2DPainting = var_1_10003

		if var_19_1 == var_1_10003.STATE_INITED and not arg_19_0.live2dChar.ignoreReact then
			Input = var_2

			if not var_2.mousePosition then
				return
			end

			local var_19_2 = arg_19_0.live2dChar

			if var_3.GetTouchPart(var_19_2) > 0 then
				local var_19_3 = arg_19_0:GetTouchEvent(var_3)

				math = var_19_2
				var_19_2 = var_19_2.ceil
				math = var_1_10007
				var_19_0 = var_19_3[var_19_2(var_1_10007.random(#var_19_3))]
			else
				local var_19_4 = arg_19_0:GetIdleEvents()

				math = var_19_2

				local var_19_5 = var_19_2.floor

				math = var_1_10007
				var_19_0 = var_19_4[var_19_5(var_1_10007.Random(0, #var_19_4)) + 1]
			end
		end
	end

	if var_19_0 then
		arg_19_0:TriggerEvent(var_19_0)
	end

	return
end

function var_0_1._TriggerEvent(arg_20_0, arg_20_1)
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

	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.GetEventConfig(var_20_0, arg_20_1)

	local function var_20_2(arg_21_0)
		if arg_21_0 then
			if var_20_1.dialog ~= "" then
				local var_21_0 = arg_20_0

				var_1.DisplayWord(var_21_0, var_20_1.dialog)
			else
				local var_21_1 = arg_20_0

				var_1.TriggerNextEventAuto(var_21_1)
			end
		end

		arg_20_0.actionWaiting = false

		return
	end

	ShipWordHelper = var_20_0

	local var_20_3, var_20_4, var_20_5, var_20_6, var_20_7, var_20_8 = var_20_0.GetCvDataForShip(arg_20_0.ship, var_20_1.dialog)
	local var_20_9 = var_20_1.action
	local var_20_10 = var_20_1.dialog

	string = var_1_10012

	local var_20_11 = var_1_10012.gsub(var_20_10, "main_", "main")

	if arg_20_0.ship.propose then
		pg = var_12

		if var_12.character_voice[var_20_11] and arg_20_0.shipGroup then
			local var_20_12 = arg_20_0.shipGroup
			local var_20_13 = var_12.VoiceReplayCodition

			pg = var_15

			if var_20_13(var_20_12, var_15.character_voice[var_20_11]) then
				local var_20_14 = arg_20_0.live2dChar

				if var_12.checkActionExist(var_20_14, var_20_9 .. "_ex") then
					var_20_9 = var_20_9 .. "_ex"
				end
			end
		end
	end

	if not var_20_8 then
		arg_20_0.actionWaiting = true

		local var_20_15 = arg_20_0.live2dChar
		local var_20_16 = var_12.TriggerAction(var_20_15, var_20_9)

		var_20_2(var_20_16)
	else
		arg_20_0.actionWaiting = true

		if not var_20_5 or var_20_5 == nil or var_20_5 == "" or var_20_5 == "nil" then
			arg_20_0.actionWaiting = false

			var_20_2(true)
		end

		local var_20_17 = arg_20_0.live2dChar

		if not var_12.TriggerAction(var_20_17, var_20_9, nil, nil, var_20_2) then
			arg_20_0.actionWaiting = false
		end
	end

	return
end

function var_0_1.PlayCV(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	arg_22_0:RemoveSeTimer()

	if arg_22_1 then
		Timer = var_5
		arg_22_0.seTimer = var_5.New(function()
			pg = var_2_10000

			local var_23_0 = var_2_10000.CriMgr.GetInstance()

			var_0.PlaySoundEffect_V3(var_23_0, "event:/ui/" .. arg_22_1[1])

			return
		end, arg_22_1[2], 1)

		local var_22_0 = arg_22_0.seTimer

		var_5.Start(var_22_0)
	end

	ShipWordHelper = var_5

	local var_22_1 = var_5.RawGetCVKey
	local var_22_2 = arg_22_0.ship
	local var_22_3 = var_22_1(var_7.getSkinId(var_22_2))

	pg = var_1_10006

	local var_22_4 = var_1_10006.CriMgr.GetCVBankName(var_22_3)
	local var_22_5 = arg_22_0.cvLoader

	var_7.Load(var_22_5, var_22_4, arg_22_3, arg_22_2, arg_22_4)

	return
end

function var_0_1.RemoveSeTimer(arg_24_0)
	if arg_24_0.seTimer then
		local var_24_0 = arg_24_0.seTimer

		var_1.Stop(var_24_0)

		arg_24_0.seTimer = nil
	end

	return
end

function var_0_1.PlayChangeSkinActionIn(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.live2dChar

	if var_2.IsLoaded(var_25_0) then
		local var_25_1 = arg_25_0.live2dChar

		if var_2.checkActionExist(var_25_1, "change_in") then
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

function var_0_1.PlayChangeSkinActionOut(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.live2dChar

	if var_2.IsLoaded(var_26_0) then
		local var_26_1 = arg_26_0.live2dChar

		if var_2.checkActionExist(var_26_1, "change_out") then
			arg_26_0:playSkinOut(arg_26_1)

			goto label_26_0
		end
	end

	if arg_26_1 and arg_26_1.callback then
		arg_26_1.callback({
			flag = true
		})
	end

	::label_26_0::

	return
end

function var_0_1.UpdateBound(arg_27_0)
	if not arg_27_0._dragBoundsUI and arg_27_0.live2dChar then
		arg_27_0:CreateL2dDragBound(arg_27_0.live2dChar)

		local var_27_0 = arg_27_0._dragBoundsUI
		local var_27_1 = var_1.SetVisible

		Live2dConst = var_1_10004

		var_27_1(var_27_0, var_1_10004.l2d_bound_open)
	elseif arg_27_0._dragBoundsUI then
		local var_27_2 = arg_27_0._dragBoundsUI

		if var_1.GetDragsCount(var_27_2) == 0 then
			local var_27_3 = arg_27_0.live2dChar
			local var_27_4 = var_1.GetDragBounds(var_27_3)

			var_1_10004 = arg_27_0._dragBoundsUI

			local var_27_5 = var_2.SetData
			local var_27_6 = var_27_4
			local var_27_7 = arg_27_0.ship

			var_27_5(var_1_10004, var_27_6, var_6.getSkinId(var_27_7))
		end

		local var_27_8 = arg_27_0._dragBoundsUI
		local var_27_9 = var_1.SetVisible

		Live2dConst = var_1_10004

		var_27_9(var_27_8, var_1_10004.l2d_bound_open)
	end

	return
end

function var_0_1.playSkinOut(arg_28_0, arg_28_1)
	local function var_28_0()
		if arg_28_1 and arg_28_1.callback then
			arg_28_1.callback({
				flag = true
			})
		end

		return
	end

	local var_28_1 = arg_28_0.live2dChar

	if not var_3.TriggerAction(var_28_1, "change_out", function()
		return
	end, false, function()
		if var_28_0 then
			var_28_0()

			var_28_0 = nil
		end

		return
	end) and var_28_0 then
		var_28_0()

		var_28_0 = nil
	end

	return
end

function var_0_1.OnDisplayWorld(arg_32_0)
	return
end

function var_0_1.OnPause(arg_33_0)
	print = var_1_10001

	var_1_10001("pause")
	arg_33_0:RemoveScreenChangeTimer()
	arg_33_0:ResetContainerPosition()

	arg_33_0.actionWaiting = false

	arg_33_0:OnUnload()

	return
end

function var_0_1.OnUpdateShip(arg_34_0, arg_34_1)
	if arg_34_1 then
		local var_34_0 = arg_34_0.live2dChar

		var_2.updateShip(var_34_0, arg_34_1)
	end

	return
end

function var_0_1.SetContainerVisible(arg_35_0, arg_35_1)
	return
end

function var_0_1.IsLoaded(arg_36_0)
	if not arg_36_0.live2dChar then
		return false
	end

	return var_0_1.super.IsLoaded(arg_36_0)
end

function var_0_1.OnResume(arg_37_0)
	arg_37_0:SetContainerVisible(true)
	arg_37_0:AddScreenChangeTimer()
	arg_37_0:UpdateContainerPosition()

	onNextTick = var_1

	var_1(function()
		if arg_37_0.ship then
			local var_38_0 = arg_37_0

			var_0.Load(var_38_0, arg_37_0.ship)
		end

		return
	end)

	return
end

function var_0_1.Dispose(arg_39_0)
	var_0_1.super.Dispose(arg_39_0)
	arg_39_0:RemoveSeTimer()
	arg_39_0:RemoveScreenChangeTimer()

	if arg_39_0._dragBoundsUI then
		local var_39_0 = arg_39_0._dragBoundsUI

		var_1.Dispose(var_39_0)

		arg_39_0._dragBoundsUI = nil
	end

	if arg_39_0.eventTrigger then
		ClearEventTrigger = var_1

		var_1(arg_39_0.eventTrigger)
	end

	return
end

function var_0_1.GetOffset(arg_40_0)
	return arg_40_0.live2dContainer.localPosition.x
end

function var_0_1.GetCenterPos(arg_41_0)
	return arg_41_0.live2dContainer.position
end

function var_0_1.IslimitYPos(arg_42_0)
	MainPaintingShift = var_1_10001

	local var_42_0 = var_1_10001.IsLimitYPos
	local var_42_1 = arg_42_0.ship

	return var_42_0(var_3.getPainting(var_42_1))
end

return var_0_1
