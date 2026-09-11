local AdminCatExploringView = class("AdminCatExploringView", ReduxView)

function AdminCatExploringView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdminCatExploringView:UIName()
	return "Widget/System/ExploreUI/ExploringPopUI"
end

function AdminCatExploringView:UIParent()
	return manager.ui.uiPop.transform
end

function AdminCatExploringView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.SetEventData), self.listGo_, AdminCatExploreEventView)
end

function AdminCatExploringView:SetEventData(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.regionData.eventData[arg_5_1], self.regionData.adminCatID, self.regionData.startTime)
end

function AdminCatExploringView:AddUIListener()
	self:AddBtnListener(self.maskBg_, nil, function()
		self:Back()
	end)
end

function AdminCatExploringView:UpdateView()
	local var_8_0 = 0

	self.regionData = AdminCatExploreData:GetDataByPara("regionData")[self.regionId]

	if self.regionData == nil then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(self.regionData.eventData) do
		if manager.time:GetServerTime() >= iter_8_1.time + self.regionData.startTime then
			var_8_0 = math.min(var_8_0 + 1, #self.regionData.eventData)
		end
	end

	local var_8_1 = 0

	for iter_8_2, iter_8_3 in ipairs(self.regionData.eventData) do
		if manager.time:GetServerTime() >= iter_8_3.time + self.regionData.startTime then
			var_8_1 = var_8_1 + 1
		end
	end

	self.regionTxt_.text = GetI18NText(ExploreAreaCfg[self.regionId].area_name)

	local var_8_2 = self.regionData.stopTime - manager.time:GetServerTime()

	self.remainTxt_.text = manager.time:DescCDTime(var_8_2)
	self.updateTimer_ = Timer.New(function()
		var_8_2 = self.regionData.stopTime - manager.time:GetServerTime()
		self.remainTxt_.text = manager.time:DescCDTime(var_8_2)

		if var_8_1 < #self.regionData.eventData and manager.time:GetServerTime() >= self.regionData.eventData[var_8_1 + 1].time + self.regionData.startTime then
			var_8_1 = math.min(var_8_1 + 1, #self.regionData.eventData)

			self.list:StartScroll(var_8_1, var_8_1)
		end

		if var_8_2 <= 0 then
			self.updateTimer_:Stop()

			self.updateTimer_ = nil

			self:Back()
			AdminCatExploreAction.AdminCatExploreFinish(self.regionId)
		end
	end, 1, var_8_2, 1)

	self.list:StartScroll(var_8_1)
	self.updateTimer_:Start()
end

function AdminCatExploringView:OnEnter()
	self.regionId = self.params_.regionId

	self:UpdateView()
	manager.audio:PlayEffect("ui_system_explore", "explore_working", "")
	manager.audio:PlayEffect("ui_system_explore", "explore_working_loop", "")
end

function AdminCatExploringView:OnExit()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end
end

function AdminCatExploringView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	AdminCatExploringView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AdminCatExploringView
