local TownBubbleSlot = class("TownBubbleSlot")

function TownBubbleSlot:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.pos = arg_1_1
	self.shipId = arg_1_2 or 0
	self.startTime = arg_1_3 or 0
	self.interval = pg.gameset.activity_town_bubble.description[1][1]
	self.maxCnt = pg.gameset.activity_town_bubble.description[2][1]
	self.passCnt = 0

	return
end

function TownBubbleSlot:OnUpdateTime(arg_2_1)
	if self.startTime == 0 or self.passCnt >= self.maxCnt then
		return
	end

	self.passCnt = math.min(math.floor((arg_2_1 - self.startTime) / self.interval), self.maxCnt)

	return
end

function TownBubbleSlot:GetPassCnt()
	return self.passCnt
end

function TownBubbleSlot:ResetStartTime(arg_4_1)
	self.startTime = arg_4_1
	self.passCnt = 0

	return
end

function TownBubbleSlot:GetShipId()
	return self.shipId
end

function TownBubbleSlot:IsNewEmpty()
	return self.startTime == 0
end

function TownBubbleSlot:ChangeShip(arg_7_1)
	self.shipId = arg_7_1

	if self.startTime == 0 then
		self.startTime = pg.TimeMgr.GetInstance():GetServerTime()
	end

	return
end

return TownBubbleSlot
