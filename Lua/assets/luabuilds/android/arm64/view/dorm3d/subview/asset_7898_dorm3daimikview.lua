local Dorm3dAimIKView = class("Dorm3dAimIKView", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

Dorm3dAimIKView.TIP_WAIT_TIME = 5
Dorm3dAimIKView.BIND_DRAG_AREA = "Dorm3dAimIKView.BindDragArea"
Dorm3dAimIKView.SHOW_OR_HIDE = "Dorm3dAimIKView.ShowOrHide"

function Dorm3dAimIKView:Init()
	self.tipTF = self._tf:Find("Tips")
	self.layer = self._tf:Find("ControlLayer")
	self.controller = self.layer:GetComponent(typeof(SlideController))

	self:InitDragEvent()
	self:InitHint()
	self:Hide()
	self:bind(Dorm3dAimIKView.BIND_DRAG_AREA, function(arg_2_0, arg_2_1)
		arg_2_1.dragArea = self.layer

		return
	end)
	self:bind(Dorm3dAimIKView.SHOW_OR_HIDE, function(arg_3_0, arg_3_1)
		if arg_3_1 then
			self:Show()
		else
			self:Hide()
		end

		return
	end)

	return
end

function Dorm3dAimIKView:InitDragEvent()
	self.controller:AddBeginDragFunc(function(arg_5_0, arg_5_1)
		setActive(self.tipTF, false)
		self.timer:Stop()
		self:emit(AimIKSystem.ON_BEGIN_DRAG, arg_5_0, arg_5_1)

		return
	end)
	self.controller:AddDragFunc(function(arg_6_0, arg_6_1)
		self:emit(AimIKSystem.ON_DRAG, arg_6_0, arg_6_1)

		return
	end)
	self.controller:AddDragEndFunc(function(arg_7_0, arg_7_1)
		self.timer:Start()
		self:emit(AimIKSystem.ON_END_DRAG, arg_7_0, arg_7_1)

		return
	end)

	return
end

function Dorm3dAimIKView:InitHint()
	self.time = Dorm3dAimIKView.TIP_WAIT_TIME
	self.timer = Timer.New(function()
		if self.time <= 0 then
			self.time = Dorm3dAimIKView.TIP_WAIT_TIME

			if isActive(self.tipTF) == false then
				setActive(self.tipTF, true)
				self:FlushHint()
			end
		else
			self.time = self.time - 0.1
		end

		return
	end, 0.1, -1)

	return
end

function Dorm3dAimIKView:FlushHint()
	local var_10_0 = {}

	self:emit(AimIKSystem.GET_TIP_SHOW_INFO, var_10_0)

	local var_10_1 = var_10_0[1]

	UIItemList.StaticAlign(self.tipTF, self.tipTF:GetChild(0), #var_10_0[1], function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_11_1 = arg_11_1 + 1

		setLocalPosition(arg_11_2, LuaHelper.ScreenToLocal(self.tipTF, var_10_1[arg_11_1].pos, pg.UIMgr.GetInstance().uiCameraComp))

		return
	end)

	return
end

function Dorm3dAimIKView:Show()
	Dorm3dAimIKView.super.Show(self)
	self.timer:Start()

	return
end

function Dorm3dAimIKView:Hide()
	Dorm3dAimIKView.super.Hide(self)
	self.timer:Stop()

	return
end

return Dorm3dAimIKView
