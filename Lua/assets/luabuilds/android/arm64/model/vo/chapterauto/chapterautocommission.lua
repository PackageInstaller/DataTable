local ChapterAutoCommission = class("ChapterAutoCommission", import("model.vo.BaseVO"))

ChapterAutoCommission.EXP_BOOK_ID = 16501

function ChapterAutoCommission:Ctor(arg_1_1)
	self.type = arg_1_1.type
	self.id = arg_1_1.id
	self.configId = self.id
	self.finishTime = arg_1_1.time
	self.ticketTime = arg_1_1.ticket_time
	self.costTime = arg_1_1.seconds

	return
end

function ChapterAutoCommission:bindConfigTable()
	return pg.chapter_auto_statistics
end

function ChapterAutoCommission:GetFinishTime()
	return self.finishTime
end

function ChapterAutoCommission:IsFinished()
	return pg.TimeMgr.GetInstance():GetServerTime() >= self:GetFinishTime()
end

function ChapterAutoCommission:GetTicketTime()
	return self.ticketTime
end

function ChapterAutoCommission:UsedTicket()
	return self:GetTicketTime() > 0
end

function ChapterAutoCommission:GetCostTime()
	return self.costTime
end

function ChapterAutoCommission:GetClassExpAward()
	return self:getConfig("base_class_exp") or 0
end

function ChapterAutoCommission:GetExpBookAward()
	return self:getConfig("drop_expbook") or 0
end

function ChapterAutoCommission:GetOnceOil(arg_10_1)
	return switch(self, {
		[ChapterAutoProxy.TYPE.SLG] = function()
			return pg.chapter_auto_statistics[arg_10_1].oil_limit
		end
	}, function()
		assert(false, "invalid chapter auto type: " .. tostring(self))

		return
	end)
end

return ChapterAutoCommission
