local IslandUrgencyOrder = class("IslandUrgencyOrder", import(".IslandOrder"))

function IslandUrgencyOrder:IsUrgency()
	return true
end

function IslandUrgencyOrder:GetTitle()
	return i18n("island_order_type_2")
end

function IslandUrgencyOrder:IsEmpty()
	local var_3_0

	if self.showFlag ~= IslandOrderSlot.SHOW_FLAG_TOMORROW then
		if pg.TimeMgr.GetInstance():GetServerTime() < self:GetDisappearTime() then
			var_3_0 = false

			goto label_3_0
		end
	end

	::label_3_0::

	return true
end

function IslandUrgencyOrder:Clear()
	self.showFlag = IslandOrderSlot.SHOW_FLAG_TOMORROW

	return
end

function IslandUrgencyOrder:IsLoading()
	return false
end

function IslandUrgencyOrder:CanReplace()
	return false
end

function IslandUrgencyOrder:GetTotalTime()
	return -1
end

function IslandUrgencyOrder:GetDisappearTime()
	return self.submitTime
end

function IslandUrgencyOrder:GetCanSubmitTime()
	return -1
end

return IslandUrgencyOrder
