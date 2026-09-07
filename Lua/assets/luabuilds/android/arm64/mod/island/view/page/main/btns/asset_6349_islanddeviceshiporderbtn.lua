local IslandDeviceShipOrderBtn = class("IslandDeviceShipOrderBtn", import(".IslandDeviceBaseBtn"))

IslandDeviceShipOrderBtn.STATES = {
	WAITING = 3,
	FINISHED = 1,
	RUNNING = 2
}

function IslandDeviceShipOrderBtn:Init()
	IslandDeviceShipOrderBtn.super.Init(self)

	self.statesTF = self.unlockTF:Find("states")

	setText(self.statesTF:Find("finished/Text"), i18n("island_freight_btn_receive"))
	setText(self.statesTF:Find("waiting"), i18n("island_freight_btn_idle"))

	self.timeTxt = self.statesTF:Find("running/Text"):GetComponent(typeof(Text))

	return
end

function IslandDeviceShipOrderBtn:FlushDataUI()
	local var_2_0, var_2_1 = self:GetState()

	setActive(self.statesTF:Find("finished"), var_2_0 == IslandDeviceShipOrderBtn.STATES.FINISHED)
	setActive(self.statesTF:Find("running"), var_2_0 == IslandDeviceShipOrderBtn.STATES.RUNNING)
	setActive(self.statesTF:Find("waiting"), var_2_0 == IslandDeviceShipOrderBtn.STATES.WAITING)

	local var_2_2 = self.statesTF:GetComponent(typeof(Animation))

	if var_2_0 == IslandDeviceShipOrderBtn.STATES.FINISHED then
		var_2_2:Play("IslandDeviceUI_shipoderfinished_")
	elseif var_2_0 == IslandDeviceShipOrderBtn.STATES.RUNNING then
		var_2_2:Play("IslandDeviceUI_shipoderrunning_")
	elseif var_2_0 == IslandDeviceShipOrderBtn.STATES.WAITING then
		var_2_2:Play("IslandDeviceUI_shipoderwaiting_")
	else
		var_2_2:Stop()
	end

	self:RemoveTimer()

	if var_2_0 == IslandDeviceShipOrderBtn.STATES.RUNNING then
		self:AddTimer(var_2_1)
	end

	return
end

function IslandDeviceShipOrderBtn:AddTimer(arg_3_1)
	local var_3_0 = arg_3_1:GetEndTime()

	self.timer = Timer.New(function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = var_3_0 - pg.TimeMgr.GetInstance():GetServerTime()

		self.timeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_4_0)

		if var_4_0 <= 0 then
			self:RemoveTimer()
			self:FlushDataUI()
		end

		return
	end, 1, -1)

	self.timer.func()
	self.timer:Start()

	return
end

function IslandDeviceShipOrderBtn:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandDeviceShipOrderBtn:GetState()
	local var_6_0 = getProxy(IslandProxy):GetIsland()
	local var_6_1 = underscore.values(var_6_0:GetOrderAgency():GetShipSlotList())

	if var_6_0 then
		return IslandDeviceShipOrderBtn.STATES.FINISHED, (underscore.detect(var_6_1, function(arg_7_0)
			return arg_7_0:IsFinished()
		end))
	end

	local var_6_2 = underscore.select(var_6_1, function(arg_8_0)
		return arg_8_0:IsSubmited() and not arg_8_0:IsFinished()
	end)

	table.sort(var_6_2, CompareFuncs({
		function(arg_9_0)
			return arg_9_0:GetEndTime()
		end,
		function(arg_10_0)
			return arg_10_0.id
		end
	}))

	if #var_6_2 > 0 then
		return IslandDeviceShipOrderBtn.STATES.RUNNING, var_6_2[1]
	end

	return IslandDeviceShipOrderBtn.STATES.WAITING, nil
end

function IslandDeviceShipOrderBtn:Dispose()
	IslandDeviceShipOrderBtn.super.Dispose(self)
	self:RemoveTimer()

	return
end

return IslandDeviceShipOrderBtn
