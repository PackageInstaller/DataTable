local var_0_0 = class("SkinAtlasLive2dView")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.ship = arg_1_1
	arg_1_0.paintingTr = arg_1_2.parent
	arg_1_0.live2dContainer = arg_1_2
	arg_1_0.canClick = false
	arg_1_0.inited = false
	var_0_1 = pg.AssistantInfo

	arg_1_0:Init(arg_1_3)

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	setActive(arg_2_0.live2dContainer, true)

	arg_2_0.live2dChar = Live2DPainting.New(Live2DPainting.GenerateData({
		ship = arg_2_0.ship,
		position = Vector3(0, 0, -100),
		parent = arg_2_0.live2dContainer,
		offset = arg_2_0.ship:GetSkinConfig().shop_offset
	}), function(arg_3_0)
		arg_2_0.inited = true

		if arg_2_1 then
			arg_2_1()
		end

		return
	end)

	return
end

function var_0_0.OpenClick(arg_4_0)
	onButton(arg_4_0, arg_4_0.paintingTr, function()
		if not arg_4_0.inited then
			return
		end

		arg_4_0:OnClick()

		return
	end)

	return
end

function var_0_0.CloseClick(arg_6_0)
	removeOnButton(arg_6_0.paintingTr)

	return
end

function var_0_0.OnClick(arg_7_0)
	local var_7_0

	if arg_7_0.live2dChar and arg_7_0.live2dChar.state == Live2DPainting.STATE_INITED then
		if not Input.mousePosition then
			return
		end

		local var_7_1 = arg_7_0.live2dChar:GetTouchPart()

		if var_7_1 > 0 then
			local var_7_2 = arg_7_0:GetTouchEvent(var_7_1)

			var_7_0 = var_7_2[math.ceil(math.random(#var_7_2))]
		else
			local var_7_3 = arg_7_0:GetTouchEvent()

			var_7_0 = var_7_3[math.floor(math.Random(0, #var_7_3)) + 1]
		end
	end

	if var_7_0 then
		arg_7_0:TriggerEvent(var_7_0)
	end

	return
end

function var_0_0.GetTouchEvent(arg_8_0, arg_8_1)
	return (var_0_1.filterAssistantEvents(var_0_1.getAssistantTouchEvents(arg_8_1), arg_8_0.ship:getSkinId(), 0))
end

function var_0_0.GetEventConfig(arg_9_0, arg_9_1)
	return pg.AssistantInfo.GetAssistantEvents(arg_9_1)
end

function var_0_0.TriggerEvent(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	local var_10_0 = arg_10_0:GetEventConfig(arg_10_1)
	local var_10_1, var_10_2, var_10_3, var_10_4, var_10_5, var_10_6 = ShipWordHelper.GetCvDataForShip(arg_10_0.ship, var_10_0.dialog)

	if not var_10_6 then
		arg_10_0.live2dChar:TriggerAction(var_10_0.action)
		;(function()
			return
		end)()
	else
		arg_10_0.live2dChar:TriggerAction(var_10_0.action, nil, nil, function()
			return
		end)
	end

	return
end

function var_0_0.Dispose(arg_12_0)
	pg.DelegateInfo.Dispose(arg_12_0)
	arg_12_0.live2dChar:Dispose()

	arg_12_0.live2dChar = nil

	setActive(arg_12_0.live2dContainer, false)

	return
end

return var_0_0
