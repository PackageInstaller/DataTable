local CommonBuff = class("CommonBuff", import(".BaseVO"))

function CommonBuff:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.timestamp = arg_1_1.timestamp

	return
end

function CommonBuff:IsActiveType()
	return false
end

function CommonBuff:bindConfigTable()
	return pg.benefit_buff_template
end

function CommonBuff:checkShow()
	return self:getConfig("hide") ~= 1
end

function CommonBuff:isActivate()
	return pg.TimeMgr.GetInstance():GetServerTime() <= self.timestamp
end

function CommonBuff:getLeftTime()
	return self.timestamp - pg.TimeMgr.GetInstance():GetServerTime()
end

return CommonBuff
