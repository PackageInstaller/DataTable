local AcademySlot = class("AcademySlot", import(".BaseVO"))

AcademySlot.STATE_IDLE = "STATE_IDLE"
AcademySlot.STATE_IN_CLASS = "STATE_IN_CLASS"
AcademySlot.STATE_CLASS_OVER = "STATE_CLASS_OVER"

function AcademySlot:Ctor()
	return
end

function AcademySlot:SetSlotData(arg_2_1)
	self._shipVO = arg_2_1.ship
	self._attrList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.attr_list) do
		self._attrList[iter_2_1.attr] = iter_2_1.num
	end

	self._timeStamp = arg_2_1.time

	return
end

function AcademySlot:GetShip()
	return self._shipVO
end

function AcademySlot:GetAttrList()
	return self._attrList
end

function AcademySlot:GetDuration()
	if self._timeStamp then
		return self._timeStamp - pg.TimeMgr.GetInstance():GetServerTime()
	else
		return nil
	end

	return
end

return AcademySlot
