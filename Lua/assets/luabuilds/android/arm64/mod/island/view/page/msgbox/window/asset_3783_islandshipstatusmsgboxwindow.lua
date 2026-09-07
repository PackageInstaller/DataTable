local IslandShipStatusMsgboxWindow = class("IslandShipStatusMsgboxWindow", import(".IslandCommonMsgboxWindow"))

function IslandShipStatusMsgboxWindow:getUIName()
	return "IslandShipStatusMsgboxUI"
end

function IslandShipStatusMsgboxWindow:OnLoaded()
	IslandShipStatusMsgboxWindow.super.OnLoaded(self)

	self.buffDesc = self._tf:Find("Text"):GetComponent(typeof(Text))

	return
end

function IslandShipStatusMsgboxWindow:OnShow()
	IslandShipStatusMsgboxWindow.super.OnShow(self)
	self:FlushBuff()

	return
end

function IslandShipStatusMsgboxWindow:FlushBuff()
	if not self.settings.buff then
		return
	end

	self.buffDesc.text = ""

	self:AddTimer(self.settings.buff)

	return
end

function IslandShipStatusMsgboxWindow:AddTimer(arg_5_1)
	self:RemoveTimer()

	local var_5_0 = arg_5_1:GetEndTime()

	if var_5_0 <= 0 then
		return
	end

	self.timer = Timer.New(function()
		local var_6_0 = var_5_0 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_6_0 <= 0 then
			self:RemoveTimer()

			self.buffDesc.text = ""
		else
			self.buffDesc.text = arg_5_1:GetName() .. ":" .. pg.TimeMgr.GetInstance():DescCDTime(var_6_0)
		end

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function IslandShipStatusMsgboxWindow:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandShipStatusMsgboxWindow:OnHide()
	IslandShipStatusMsgboxWindow.super.OnHide(self)
	self:RemoveTimer()

	return
end

return IslandShipStatusMsgboxWindow
