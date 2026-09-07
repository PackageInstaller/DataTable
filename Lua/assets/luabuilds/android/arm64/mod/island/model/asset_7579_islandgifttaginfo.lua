local IslandGiftTagInfo = class("IslandGiftTagInfo")

function IslandGiftTagInfo:Ctor(arg_1_1)
	self.playerId = arg_1_1.key
	self.endTime = arg_1_1.value1
	self.giftCnt = arg_1_1.value2

	return
end

function IslandGiftTagInfo:Flush(arg_2_1, arg_2_2)
	self.endTime = arg_2_2
	self.giftCnt = arg_2_1

	return
end

function IslandGiftTagInfo:ExistGift()
	return self.giftCnt > 0 and pg.TimeMgr.GetInstance():GetServerTime() < self.endTime
end

return IslandGiftTagInfo
