local MainL2dBoundBtn = class("MainL2dBoundBtn", import(".MainBaseBtn"))

function MainL2dBoundBtn:Ctor(arg_1_1, arg_1_2)
	MainL2dBoundBtn.super.Ctor(self, arg_1_1, arg_1_2)
	setActive(self._tf, false)
	self:bind(GAME.ROTATE_PAINTING_INDEX, function()
		self:FlushL2d()

		return
	end)

	return
end

function MainL2dBoundBtn:OnClick()
	Live2dConst.l2d_bound_open = not tobool(Live2dConst.l2d_bound_open)

	self:FlushL2d()
	pg.TipsMgr.GetInstance():ShowTips(i18n(Live2dConst.l2d_bound_open and "l2d_tip_on" or "l2d_tip_off"))

	return
end

function MainL2dBoundBtn:Flush(arg_4_1)
	self:FlushL2d()

	return
end

function MainL2dBoundBtn:IsFixed()
	return true
end

function MainL2dBoundBtn:FlushL2d()
	local var_6_0 = getProxy(PlayerProxy):getRawData():GetFlagShip()
	local var_6_1 = MainPaintingView.GetAssistantStatus(var_6_0) == MainPaintingView.STATE_L2D
	local var_6_2 = var_6_0:GetSkinConfig().ship_l2d_id

	if pg.ship_l2d_tips[var_6_0:GetSkinConfig().id] and var_6_1 and var_6_2 and type(var_6_2) == "table" and #var_6_2 > 0 then
		setActive(self._tf, true)
		setActive(findTF(self._tf, "on"), not Live2dConst.l2d_bound_open)
		setActive(findTF(self._tf, "off"), Live2dConst.l2d_bound_open)
	else
		Live2dConst.l2d_bound_open = false

		setActive(self._tf, false)
	end

	self:emit(NewMainScene.L2D_BOUND_CHANGE)

	return
end

return MainL2dBoundBtn
