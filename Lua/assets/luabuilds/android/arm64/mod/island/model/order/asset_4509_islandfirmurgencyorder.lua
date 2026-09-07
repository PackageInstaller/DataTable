local IslandFirmUrgencyOrder = class("IslandFirmUrgencyOrder", import(".IslandUrgencyOrder"))

function IslandFirmUrgencyOrder:IsFirm()
	return true
end

function IslandFirmUrgencyOrder:bindConfigTable()
	return pg.island_order
end

function IslandFirmUrgencyOrder:GetDisappearTime()
	return self.startTime + self:getConfig("effective_time")
end

function IslandFirmUrgencyOrder:GetAwardItemAndExp()
	return self:GenAwards((self:getConfig("award")))
end

return IslandFirmUrgencyOrder
