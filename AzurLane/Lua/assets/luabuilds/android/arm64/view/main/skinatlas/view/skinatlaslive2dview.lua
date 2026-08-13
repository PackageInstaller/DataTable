class = var_0_10000

local var_0_0 = var_0_10000("SkinAtlasLive2dView")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	pg = var_1_10004

	var_1_10004.DelegateInfo.New(arg_1_0)

	arg_1_0.ship = arg_1_1
	arg_1_0.paintingTr = arg_1_2.parent
	arg_1_0.live2dContainer = arg_1_2
	arg_1_0.canClick = false
	arg_1_0.inited = false
	pg = var_4
	var_0_1 = var_4.AssistantInfo

	arg_1_0:Init(arg_1_3)

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.ship

	setActive = var_1_10003

	var_1_10003(arg_2_0.live2dContainer, true)

	Live2DPainting = var_1_10003

	local var_2_1 = var_1_10003.GenerateData
	local var_2_2 = {
		ship = var_2_0
	}

	Vector3 = var_6
	var_2_2.position = var_6(0, 0, -100)
	var_2_2.parent = arg_2_0.live2dContainer
	var_2_2.offset = var_2_0:GetSkinConfig().shop_offset

	local var_2_3 = var_2_1(var_2_2)

	Live2DPainting = var_1_10004
	arg_2_0.live2dChar = var_1_10004.New(var_2_3, function(arg_3_0)
		arg_2_0.inited = true

		if arg_2_1 then
			arg_2_1()
		end

		return
	end)

	return
end

function var_0_0.OpenClick(arg_4_0)
	onButton = var_1_10001

	var_1_10001(arg_4_0, arg_4_0.paintingTr, function()
		if not arg_4_0.inited then
			return
		end

		local var_5_0 = arg_4_0

		var_0.OnClick(var_5_0)

		return
	end)

	return
end

function var_0_0.CloseClick(arg_6_0)
	removeOnButton = var_1_10001

	var_1_10001(arg_6_0.paintingTr)

	return
end

function var_0_0.OnClick(arg_7_0)
	local var_7_0

	if arg_7_0.live2dChar then
		local var_7_1 = arg_7_0.live2dChar.state

		Live2DPainting = var_1_10003

		if var_7_1 == var_1_10003.STATE_INITED then
			Input = var_7_1

			if not var_7_1.mousePosition then
				return
			end

			local var_7_2 = arg_7_0.live2dChar

			if var_3.GetTouchPart(var_7_2) > 0 then
				local var_7_3 = arg_7_0:GetTouchEvent(var_3)

				math = var_7_2
				var_7_2 = var_7_2.ceil
				math = var_1_10007
				var_7_0 = var_7_3[var_7_2(var_1_10007.random(#var_7_3))]
			else
				local var_7_4 = arg_7_0:GetTouchEvent()

				math = var_7_2

				local var_7_5 = var_7_2.floor

				math = var_1_10007
				var_7_0 = var_7_4[var_7_5(var_1_10007.Random(0, #var_7_4)) + 1]
			end
		end
	end

	if var_7_0 then
		arg_7_0:TriggerEvent(var_7_0)
	end

	return
end

function var_0_0.GetTouchEvent(arg_8_0, arg_8_1)
	local var_8_0 = var_0_1.filterAssistantEvents
	local var_8_1 = var_0_1.getAssistantTouchEvents(arg_8_1)
	local var_8_2 = arg_8_0.ship

	return (var_8_0(var_8_1, var_5.getSkinId(var_8_2), 0))
end

function var_0_0.GetEventConfig(arg_9_0, arg_9_1)
	pg = var_1_10002

	return var_1_10002.AssistantInfo.GetAssistantEvents(arg_9_1)
end

function var_0_0.TriggerEvent(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.GetEventConfig(var_10_0, arg_10_1)

	local function var_10_2()
		return
	end

	ShipWordHelper = var_10_0

	local var_10_3, var_10_4, var_10_5, var_10_6, var_10_7, var_10_8 = var_10_0.GetCvDataForShip(arg_10_0.ship, var_10_1.dialog)

	if not var_10_8 then
		local var_10_9 = arg_10_0.live2dChar

		var_10.TriggerAction(var_10_9, var_10_1.action)
		var_10_2()
	else
		local var_10_10 = arg_10_0.live2dChar

		var_10.TriggerAction(var_10_10, var_10_1.action, nil, nil, var_10_2)
	end

	return
end

function var_0_0.Dispose(arg_12_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_12_0)

	local var_12_0 = arg_12_0.live2dChar

	var_1.Dispose(var_12_0)

	arg_12_0.live2dChar = nil
	setActive = var_1

	var_1(arg_12_0.live2dContainer, false)

	return
end

return var_0_0
