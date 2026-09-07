local TownBubbleSlot2 = class("TownBubbleSlot2")

function TownBubbleSlot2:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.pos = arg_1_1
	self.shipId = arg_1_2 or 0
	self.startTime = arg_1_3 or 0
	self.interval = pg.activity_town_2[ActivityConst.LiquorFloor_ACT_ID].bubble[1][1]
	self.maxCnt = pg.activity_town_2[ActivityConst.LiquorFloor_ACT_ID].bubble[2][1]
	self.passCnt = 0

	return
end

function TownBubbleSlot2:OnUpdateTime(arg_2_1)
	if self.startTime == 0 or self.passCnt >= self.maxCnt then
		return
	end

	self.passCnt = math.min(math.floor((arg_2_1 - self.startTime) / self.interval), self.maxCnt)

	return
end

function TownBubbleSlot2:GetPassCnt()
	return self.passCnt
end

function TownBubbleSlot2:ResetStartTime(arg_4_1)
	self.startTime = arg_4_1
	self.passCnt = 0

	return
end

function TownBubbleSlot2:GetShipId()
	return self.shipId
end

function TownBubbleSlot2:IsNewEmpty()
	return self.startTime == 0
end

function TownBubbleSlot2:ChangeShip(arg_7_1)
	self.shipId = arg_7_1

	if self.startTime == 0 then
		self.startTime = pg.TimeMgr.GetInstance():GetServerTime()
	end

	return
end

return TownBubbleSlot2
