local IslandMapPage = class("IslandMapPage", import(".IslandBaseMapPage"))

function IslandMapPage:OnInit()
	IslandMapPage.super.OnInit(self)

	self.timers = {}

	return
end

function IslandMapPage:Flush()
	IslandMapPage.super.Flush(self)

	for iter_2_0, iter_2_1 in pairs(self.maps) do
		if self:CheckUnlock(iter_2_0) then
			self:CheckProductions(iter_2_0)
			self:CheckAcceptableTask(iter_2_0)
			self:CheckFinishableTask(iter_2_0)
			setActive(iter_2_1:Find("icon"), not isActive(iter_2_1:Find("fetch")) and not isActive(iter_2_1:Find("finish")) and not isActive(iter_2_1:Find("fetch")))
		end
	end

	return
end

function IslandMapPage:OnHide()
	self:RemoveAllTimer()

	return
end

function IslandMapPage:CheckAcceptableTask(arg_4_1)
	(function(arg_5_0)
		SetActive(self.maps[arg_4_1]:Find("fetch"), arg_5_0)

		return
	end)(#getProxy(IslandProxy):GetIsland():GetTaskAgency():GetCanAcceptTasksByMapId(arg_4_1) > 0)

	return
end

function IslandMapPage:CheckFinishableTask(arg_6_1)
	(function(arg_7_0)
		SetActive(self.maps[arg_6_1]:Find("finish"), arg_7_0)

		return
	end)(#getProxy(IslandProxy):GetIsland():GetTaskAgency():GetCanSubmitTasksByMapId(arg_6_1) > 0)

	return
end

function IslandMapPage:CheckProductions(arg_8_1)
	local function var_8_0(arg_9_0)
		SetActive(self.maps[arg_8_1]:Find("full"), arg_9_0)

		return
	end

	if self.timers[arg_8_1] then
		self.timers[arg_8_1]:Stop()

		self.timers[arg_8_1] = nil
	end

	local var_8_1 = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetMinimumDelegationCompletionTimeByMapId(arg_8_1)

	if var_8_1 < 0 then
		var_8_0(false)

		return
	end

	local var_8_2 = var_8_1 - pg.TimeMgr.GetInstance():GetServerTime()

	if var_8_2 <= 0 then
		var_8_0(true)

		return
	end

	self.timers[arg_8_1] = Timer.New(function()
		var_8_0(true)

		return
	end, var_8_2, 1)

	self.timers[arg_8_1]:Start()

	return
end

function IslandMapPage:RemoveAllTimer()
	for iter_11_0, iter_11_1 in pairs(self.timers) do
		iter_11_1:Stop()
	end

	self.timers = {}

	return
end

function IslandMapPage:GoDesc(arg_12_1)
	self:OpenPage(IslandMapDescPage, arg_12_1)

	return
end

function IslandMapPage:OnDestroy()
	self:RemoveAllTimer()

	return
end

return IslandMapPage
