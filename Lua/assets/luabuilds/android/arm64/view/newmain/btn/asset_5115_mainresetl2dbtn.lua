local MainResetL2dBtn = class("MainResetL2dBtn", import(".MainBaseBtn"))

function MainResetL2dBtn:Ctor(arg_1_1, arg_1_2)
	MainResetL2dBtn.super.Ctor(self, arg_1_1, arg_1_2)
	self:bind(GAME.ROTATE_PAINTING_INDEX, function()
		self:FlushL2d()

		return
	end)

	return
end

function MainResetL2dBtn:OnClick()
	self:emit(NewMainScene.RESET_L2D)

	return
end

function MainResetL2dBtn:Flush(arg_4_1)
	self:FlushL2d()

	return
end

function MainResetL2dBtn:FlushL2d()
	if not getProxy(SettingsProxy):ShowL2dResetInMainScene() then
		setActive(self._tf, false)

		return
	end

	setActive(self._tf, MainPaintingView.GetAssistantStatus((getProxy(PlayerProxy):getRawData():GetFlagShip())) == MainPaintingView.STATE_L2D)

	return
end

return MainResetL2dBtn
