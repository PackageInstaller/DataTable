local Dorm3dStockingView = class("Dorm3dStockingView", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

Dorm3dStockingView.TIP_WAIT_TIME = 5

function Dorm3dStockingView:Init()
	self.controlTF = self._tf:Find("StockingControl")
	self.uiTF = self._tf:Find("UI/stocking")
	self.tipTF = self.controlTF:Find("Tips")
	self.clickTF = self.controlTF:Find("ClickTips")

	onButton(self, self.uiTF:Find("btn_back"), function()
		self:emit(Dorm3dStockingMgr.EXIT_STOCKING_STATUS)

		return
	end, SFX_CANCEL)
	self:InitDragEvent()
	self:InitHint()
	self:Hide()

	return
end

function Dorm3dStockingView:InitDragEvent()
	local var_3_0 = self.controlTF:Find("ControlLayer"):GetComponent(typeof(SlideController))

	var_3_0:AddBeginDragFunc(function(arg_4_0, arg_4_1)
		setActive(self.tipTF, false)
		self.timer:Stop()
		self:emit(Dorm3dStockingMgr.ON_BEGIN_DRAG, arg_4_0, arg_4_1)

		return
	end)
	var_3_0:AddDragFunc(function(arg_5_0, arg_5_1)
		self:emit(Dorm3dStockingMgr.ON_DRAG, arg_5_0, arg_5_1)

		return
	end)
	var_3_0:AddDragEndFunc(function(arg_6_0, arg_6_1)
		self.timer:Start()
		self:emit(Dorm3dStockingMgr.ON_END_DRAG, arg_6_0, arg_6_1)

		return
	end)

	return
end

function Dorm3dStockingView:InitHint()
	self.time = Dorm3dStockingView.TIP_WAIT_TIME
	self.timer = Timer.New(function()
		if self.time <= 0 then
			self.time = Dorm3dStockingView.TIP_WAIT_TIME

			if isActive(self.tipTF) == false then
				setActive(self.tipTF, true)
				setActive(self.clickTF, true)
				self:FlushHint()
			end
		else
			self.time = self.time - 0.1
		end

		return
	end, 0.1, -1)

	return
end

function Dorm3dStockingView:FlushHint()
	local var_9_0 = {}

	self:emit(Dorm3dStockingMgr.GET_TIP_SHOW_INFO, var_9_0)

	local var_9_1 = var_9_0[1]
	local var_9_2 = var_9_0[2]

	UIItemList.StaticAlign(self.tipTF, self.tipTF:GetChild(0), #var_9_0[1], function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_10_1 = arg_10_1 + 1

		setLocalPosition(arg_10_2, LuaHelper.ScreenToLocal(self.tipTF, var_9_1[arg_10_1].pos, pg.UIMgr.GetInstance().uiCameraComp))
		setLocalRotation(arg_10_2, Quaternion.Euler(0, 0, Mathf.Atan2(var_9_1[arg_10_1].dir.y, var_9_1[arg_10_1].dir.x) * Mathf.Rad2Deg - 90))

		return
	end)
	UIItemList.StaticAlign(self.clickTF, self.clickTF:GetChild(0), #var_9_0[2], function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_11_1 = arg_11_1 + 1

		setLocalPosition(arg_11_2, LuaHelper.ScreenToLocal(self.clickTF, var_9_2[arg_11_1].pos, pg.UIMgr.GetInstance().uiCameraComp))

		return
	end)

	return
end

function Dorm3dStockingView:Show()
	setActive(self.controlTF, true)
	setActive(self.uiTF, true)
	self.timer:Start()

	return
end

function Dorm3dStockingView:Hide()
	setActive(self.controlTF, false)
	setActive(self.uiTF, false)
	self.timer:Stop()

	return
end

return Dorm3dStockingView
