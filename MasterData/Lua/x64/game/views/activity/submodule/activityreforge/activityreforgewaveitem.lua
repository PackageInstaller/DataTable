local ActivityReforgeWaveItem = class("ActivityReforgeWaveItem", ReduxView)

function ActivityReforgeWaveItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityReforgeWaveItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityReforgeWaveItem:InitUI()
	self:BindCfgUI()

	self.statusController_ = self.controllerEx_:GetController("status")
	self.selectController_ = self.controllerEx_:GetController("isselect")
	self.heroHeadItemList_ = {}

	for iter_3_0 = 1, 3 do
		self.heroHeadItemList_[iter_3_0] = ActivityReforgeHeroHeadItem.New(self["heroHeadGo" .. iter_3_0 .. "_"])
	end
end

function ActivityReforgeWaveItem:SetClickHandle(arg_4_1)
	self.clickHandle_ = arg_4_1
end

function ActivityReforgeWaveItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.index_ = arg_5_1
	self.waveID_ = arg_5_2

	if self.index_ == arg_5_3 then
		self.selectController_:SetSelectedState("true")
	else
		self.selectController_:SetSelectedState("false")
	end

	self.waveNum_.text = self.index_
	self.teamInfo_ = ActivityReforgeData:GetWaveTeamInfo(self.waveID_)

	if self.teamInfo_ == nil then
		self.statusController_:SetSelectedState("normal")
	else
		self.statusController_:SetSelectedState("hero")

		for iter_5_0 = 1, 3 do
			self.heroHeadItemList_[iter_5_0]:SetData(ActivityReforgeTeamCfg[self.teamInfo_.teamID].team_info[self.teamInfo_.level][iter_5_0])
		end
	end
end

function ActivityReforgeWaveItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickHandle_ then
			self.clickHandle_(self.index_)
		end
	end)
end

function ActivityReforgeWaveItem:Dispose()
	for iter_8_0 = 1, 3 do
		self.heroHeadItemList_[iter_8_0]:Dispose()

		self.heroHeadItemList_[iter_8_0] = nil
	end

	self.heroHeadItemList_ = nil
	self.clickHandle_ = nil

	ActivityReforgeWaveItem.super.Dispose(self)
end

return ActivityReforgeWaveItem
