local SkinAtlasLive2dView = class("SkinAtlasLive2dView")
local var_0_1

function SkinAtlasLive2dView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	pg.DelegateInfo.New(self)

	self.ship = arg_1_1
	self.paintingTr = arg_1_2.parent
	self.live2dContainer = arg_1_2
	self.canClick = false
	self.inited = false
	var_0_1 = pg.AssistantInfo

	self:Init(arg_1_3)

	return
end

function SkinAtlasLive2dView:Init(arg_2_1)
	setActive(self.live2dContainer, true)

	self.live2dChar = Live2DPainting.New(Live2DPainting.GenerateData({
		ship = self.ship,
		position = Vector3(0, 0, -100),
		parent = self.live2dContainer,
		offset = self.ship:GetSkinConfig().shop_offset
	}), function(arg_3_0)
		self.inited = true

		if arg_2_1 then
			arg_2_1()
		end

		return
	end)

	return
end

function SkinAtlasLive2dView:OpenClick()
	onButton(self, self.paintingTr, function()
		if not self.inited then
			return
		end

		self:OnClick()

		return
	end)

	return
end

function SkinAtlasLive2dView:CloseClick()
	removeOnButton(self.paintingTr)

	return
end

function SkinAtlasLive2dView:OnClick()
	local var_7_0

	if self.live2dChar and self.live2dChar.state == Live2DPainting.STATE_INITED then
		if not Input.mousePosition then
			return
		end

		local var_7_1 = self.live2dChar:GetTouchPart()

		if var_7_1 > 0 then
			local var_7_2 = self:GetTouchEvent(var_7_1)

			var_7_0 = var_7_2[math.ceil(math.random(#var_7_2))]
		else
			local var_7_3 = self:GetTouchEvent()

			var_7_0 = var_7_3[math.floor(math.Random(0, #var_7_3)) + 1]
		end
	end

	if var_7_0 then
		self:TriggerEvent(var_7_0)
	end

	return
end

function SkinAtlasLive2dView:GetTouchEvent(arg_8_1)
	return (var_0_1.filterAssistantEvents(var_0_1.getAssistantTouchEvents(arg_8_1), self.ship:getSkinId(), 0))
end

function SkinAtlasLive2dView:GetEventConfig(arg_9_1)
	return pg.AssistantInfo.GetAssistantEvents(arg_9_1)
end

function SkinAtlasLive2dView:TriggerEvent(arg_10_1)
	if not arg_10_1 then
		return
	end

	local var_10_0 = self:GetEventConfig(arg_10_1)

	local function var_10_1()
		return
	end

	local var_10_2, var_10_3, var_10_4, var_10_5, var_10_6, var_10_7 = ShipWordHelper.GetCvDataForShip(self.ship, var_10_0.dialog)

	if not var_10_7 then
		self.live2dChar:TriggerAction(var_10_0.action)
		var_10_1()
	else
		self.live2dChar:TriggerAction(var_10_0.action, nil, nil, var_10_1)
	end

	return
end

function SkinAtlasLive2dView:Dispose()
	pg.DelegateInfo.Dispose(self)
	self.live2dChar:Dispose()

	self.live2dChar = nil

	setActive(self.live2dContainer, false)

	return
end

return SkinAtlasLive2dView
