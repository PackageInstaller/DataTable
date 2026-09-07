local SystemTipProxy = class("SystemTipProxy", import(".NetProxy"))

function SystemTipProxy:register()
	self:on(21536, function(arg_2_0)
		self:SetIslandTipData(arg_2_0.get_num, arg_2_0.empty_num, arg_2_0.get_times, arg_2_0.mange_flag)

		return
	end)

	self.islandAwardCnt = 0
	self.islandEmptyCnt = 0
	self.islandTimestamps = {}
	self.islandPostFlag = 0

	return
end

function SystemTipProxy:SetIslandTipData(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self.islandAwardCnt = arg_3_1
	self.islandEmptyCnt = arg_3_2
	self.islandTimestamps = arg_3_3

	table.sort(self.islandTimestamps)

	self.islandPostFlag = arg_3_4

	return
end

function SystemTipProxy:GetIslandTipInfos()
	if self.islandPostFlag == 0 then
		return 0, 0
	end

	local var_4_0 = pg.TimeMgr.GetInstance():GetServerTime()

	return underscore.reduce(self.islandTimestamps, self.islandAwardCnt, function(arg_5_0, arg_5_1)
		return arg_5_0 + (arg_5_1 <= var_4_0 and 1 or 0)
	end), self.islandEmptyCnt
end

function SystemTipProxy:IsIslandRedDotTip()
	if self.islandClickRecord then
		return false
	end

	local var_6_0, var_6_1 = self:GetIslandTipInfos()

	return var_6_0 > 0 or var_6_1 > 0
end

function SystemTipProxy:SetIslandClickRecord()
	self.islandClickRecord = true

	return
end

return SystemTipProxy
