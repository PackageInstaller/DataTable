local IslandMsgBoxForStatusWindow = class("IslandMsgBoxForStatusWindow", import(".IslandCommonMsgboxWindow"))

function IslandMsgBoxForStatusWindow:getUIName()
	return "IslandCommonMsgBoxForStatus"
end

function IslandMsgBoxForStatusWindow:OnLoaded()
	IslandMsgBoxForStatusWindow.super.OnLoaded(self)

	self.uiItemList = UIItemList.New(self._tf:Find("scrollrect/list"), self._tf:Find("scrollrect/list/tpl"))
	self.timers = {}

	return
end

function IslandMsgBoxForStatusWindow:OnShow()
	IslandMsgBoxForStatusWindow.super.OnShow(self)
	self:FlushItems(self.settings)

	return
end

function IslandMsgBoxForStatusWindow:FlushBtn(arg_4_1)
	setActive(self.cancelBtn, false)

	return
end

function IslandMsgBoxForStatusWindow:FlushItems(arg_5_1)
	local var_5_0 = arg_5_1.statusList

	assert(arg_5_1.statusList)
	self.uiItemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = var_5_0[arg_6_1 + 1]
			local var_6_1 = "#303a3c"

			if var_5_0[arg_6_1 + 1]:IsRed() then
				var_6_1 = "#ff7e7e"
			elseif var_6_0:IsBlue() then
				var_6_1 = "#5dcbff"
			end

			setText(arg_6_2:Find("label/Text"), setColorStr(var_6_0:GetName(), var_6_1))
			setText(arg_6_2:Find("Text"), var_6_0:GetDesc())
			self:AddTimer(var_6_0:GetEndTime(), arg_6_2:Find("time/Text"), var_6_0.id)
		end

		return
	end)
	self.uiItemList:align(#arg_5_1.statusList)

	return
end

function IslandMsgBoxForStatusWindow:AddTimer(arg_7_1, arg_7_2, arg_7_3)
	self:RemoveTimer(arg_7_3)

	if arg_7_1 - pg.TimeMgr.GetInstance():GetServerTime() <= 0 then
		setText(arg_7_2, i18n("island_buff_lasttime", pg.TimeMgr.GetInstance():DescCDTime(0)))

		return
	end

	self.timers[arg_7_3] = Timer.New(function()
		local var_8_0 = arg_7_1 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_8_0 > 0 then
			setText(arg_7_2, i18n("island_buff_lasttime", pg.TimeMgr.GetInstance():DescCDTime(var_8_0)))
		else
			self:RemoveTimer(arg_7_3)
			setText(arg_7_2, i18n("island_buff_lasttime", pg.TimeMgr.GetInstance():DescCDTime(0)))
		end

		return
	end, 1, -1)

	self.timers[arg_7_3]:Start()
	self.timers[arg_7_3].func()

	return
end

function IslandMsgBoxForStatusWindow:RemoveTimer(arg_9_1)
	if self.timers[arg_9_1] then
		self.timers[arg_9_1]:Stop()

		self.timers[arg_9_1] = nil
	end

	return
end

function IslandMsgBoxForStatusWindow:RemoveTimers()
	for iter_10_0, iter_10_1 in pairs(self.timers) do
		iter_10_1:Stop()
	end

	self.timers = {}

	return
end

function IslandMsgBoxForStatusWindow:OnHide()
	IslandMsgBoxForStatusWindow.super.OnHide(self)
	self:RemoveTimers()

	return
end

function IslandMsgBoxForStatusWindow:OnDestroy()
	self:RemoveTimers()

	return
end

return IslandMsgBoxForStatusWindow
