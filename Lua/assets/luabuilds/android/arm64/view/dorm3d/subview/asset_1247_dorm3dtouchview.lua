local Dorm3dTouchView = class("Dorm3dTouchView", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

function Dorm3dTouchView:Init()
	self.rtIKUI = self._tf:Find("UI/ik")
	self.rtTouchGamePanel = self._tf:Find("ExtraScreen/TouchGame")

	setActive(self.rtIKUI:Find("btn_back_heartbeat"), false)
	setActive(self.rtTouchGamePanel, false)
	onButton(self, self.rtIKUI:Find("btn_back"), function()
		local var_2_0 = {}

		self:emit(RoomIKSystem.CONSUME_IK_SPECIAL_CALL, var_2_0)

		if not var_2_0.consumed then
			self:emit(RoomTouchSystem.EXIT_TOUCH_MODE)
		end

		return
	end, SFX_DORM_BACK)
	onButton(self, self.rtIKUI:Find("btn_back_heartbeat"), function()
		self:emit(RoomTouchSystem.EXIT_HEARTBEAT_MODE)

		return
	end, SFX_DORM_BACK)
	self:bind(RoomTouchSystem.UPDATE_TOUCH_PANEL, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		self:UpdateTouchPanel(arg_4_1, arg_4_2, arg_4_3)

		return
	end)
	self:bind(RoomTouchSystem.UPDATE_TOUCH_COUNT, function(arg_5_0, arg_5_1)
		self:UpdateTouchCount(arg_5_1)

		return
	end)
	self:bind(RoomTouchSystem.UPDATE_TOUCH_LEVEL, function(arg_6_0, arg_6_1)
		self:UpdateTouchLevel(arg_6_1)

		return
	end)
	self:bind(RoomTouchSystem.UPDATE_TOUCH_DISPLAY, function(arg_7_0, arg_7_1, arg_7_2)
		self:UpdateTouchLevel(arg_7_1)
		self:UpdateTouchCount(arg_7_2)

		return
	end)

	return
end

function Dorm3dTouchView:UpdateTouchPanel(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_1 then
		setActive(self.rtTouchGamePanel, true)
		quickPlayAnimation(self.rtTouchGamePanel, "anim_dorm3d_touch_in")
		quickPlayAnimation(self.rtTouchGamePanel:Find("slider/icon"), "anim_dorm3d_touch_icon")
		existCall(arg_8_3)
	elseif arg_8_2 then
		quickPlayAnimation(self.rtTouchGamePanel, "anim_dorm3d_touch_out")
		onDelayTick(function()
			setActive(self.rtTouchGamePanel, false)
			existCall(arg_8_3)

			return
		end, 0.5)
	else
		setActive(self.rtTouchGamePanel, false)
		existCall(arg_8_3)
	end

	return
end

function Dorm3dTouchView:UpdateTouchLevel(arg_10_1)
	self.touchLevel = arg_10_1

	setActive(self.rtTouchGamePanel:Find("effect_bg"), arg_10_1 == 2)
	setActive(self.rtTouchGamePanel:Find("slider/icon/beating"), arg_10_1 == 2)

	if arg_10_1 == 1 then
		setActive(self.rtIKUI:Find("btn_back"), true)
		setActive(self.rtIKUI:Find("btn_back_heartbeat"), false)
		quickPlayAnimation(self.rtTouchGamePanel, "anim_dorm3d_touch_change_out")
		quickPlayAnimation(self.rtTouchGamePanel:Find("slider/icon"), "anim_dorm3d_touch_icon")
	elseif arg_10_1 == 2 then
		setActive(self.rtIKUI:Find("btn_back"), false)
		setActive(self.rtIKUI:Find("btn_back_heartbeat"), true)
		quickPlayAnimation(self.rtTouchGamePanel, "anim_dorm3d_touch_change")
		quickPlayAnimation(self.rtTouchGamePanel:Find("slider/icon"), "anim_dorm3d_touch_icon_1")
		pg.CriMgr.GetInstance():PlaySE_V3("ui-dorm_heartbeat")
	end

	return
end

function Dorm3dTouchView:UpdateTouchCount(arg_11_1)
	setSlider(self.rtTouchGamePanel:Find("slider"), 0, 100, (self.touchLevel and self.touchLevel > 1 or nil) and (arg_11_1 >= 200 and 100 or arg_11_1 % 100))

	return
end

return Dorm3dTouchView
