local TacticRoomBuilding = class("TacticRoomBuilding", import(".NavalAcademyBuilding"))

function TacticRoomBuilding:GetGameObjectName()
	return "tacticRoom"
end

function TacticRoomBuilding:GetTitle()
	return i18n("school_title_xueyuan")
end

function TacticRoomBuilding:OnClick()
	self:emit(NavalAcademyMediator.ON_OPEN_TACTICROOM)

	return
end

function TacticRoomBuilding:IsTip()
	local var_4_0 = getProxy(NavalAcademyProxy):getStudents()

	if #var_4_0 <= 0 then
		return false
	end

	local var_4_1 = pg.TimeMgr.GetInstance():GetServerTime()
	local var_4_2

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		local var_4_3 = iter_4_1:getFinishTime() - var_4_1

		if not var_4_2 or var_4_3 < var_4_2 then
			var_4_2 = var_4_3
		end

		if var_4_3 <= 0 then
			return true
		end
	end

	self:RemoveTimer()

	if var_4_2 and var_4_2 > 0 then
		self:AddTimer(var_4_2)
	end

	return false
end

function TacticRoomBuilding:AddTimer(arg_5_1)
	self.timer = Timer.New(function()
		self:RefreshTip()

		return
	end, arg_5_1, 1)

	self.timer:Start()

	return
end

function TacticRoomBuilding:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function TacticRoomBuilding:Dispose()
	TacticRoomBuilding.super.Dispose(self)
	self:RemoveTimer()

	return
end

return TacticRoomBuilding
