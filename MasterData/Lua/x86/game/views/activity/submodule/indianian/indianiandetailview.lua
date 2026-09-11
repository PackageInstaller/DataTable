local IndiaNianDetailView = class("IndiaNianDetailView", ReduxView)

function IndiaNianDetailView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaNianUI/IndiaNianExplainUI"
end

function IndiaNianDetailView:UIParent()
	return manager.ui.uiMain.transform
end

function IndiaNianDetailView:Init()
	self:InitUI()
	self:AddUIListener()

	self.stageItemList_ = {}

	for iter_3_0 = 1, 8 do
		table.insert(self.stageItemList_, (IndiaNianStageDescItem.New(self["stageGo_" .. iter_3_0])))
	end

	self.iconController_ = ControllerUtil.GetController(self.transform_, "icon")
end

function IndiaNianDetailView:InitUI()
	self:BindCfgUI()
end

function IndiaNianDetailView:AddUIListener()
	self:AddBtnListener(self.bossBtn_, nil, function()
		_G.IndiaNianDescSelectedIndex = 0
		self.selectedIndex_ = 0

		IndiaNianData:SetSelectedDescIndex(self.selectedIndex_)
		self:RefreshBossUI()
	end)
end

function IndiaNianDetailView:OnDataUpdate()
	self:RefreshData()
	self:RefreshUI()
end

function IndiaNianDetailView:RefreshData()
	self.bossCfgIDList_ = IndiaNianCfg.get_id_list_by_activity_id[self.activityID_]
	self.round = IndiaNianData:GetRound()

	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(self.bossCfgIDList_) do
		local var_8_1 = IndiaNianCfg[iter_8_1]

		if IndiaNianCfg[iter_8_1].group_id == 100 and not var_8_0[var_8_1.group_id] then
			self.bossCfg_ = var_8_1

			IndiaNianData:SetSelectedStage(self.bossCfg_.stage_id)
		elseif not var_8_0[var_8_1.group_id] then
			self.stageItemList_[1]:SetData(1, var_8_1)
			self.stageItemList_[1]:SetCallBack(function(arg_9_0)
				_G.IndiaNianDescSelectedIndex = arg_9_0
				self.selectedIndex_ = arg_9_0

				self:RefreshUI()
			end)
		end

		var_8_0[var_8_1.group_id] = true
	end
end

function IndiaNianDetailView:OnEnter()
	self.activityID_ = IndiaNianData:GetActivityID()
	self.selectedIndex_ = _G.IndiaNianDescSelectedIndex or 0

	self:RefreshData()
	self:RefreshUI()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function IndiaNianDetailView:OnExit()
	if self.stageItemList_ then
		for iter_11_0 = 1, 8 do
			self.stageItemList_[iter_11_0]:OnExit()
		end
	end
end

function IndiaNianDetailView:RefreshUI()
	if self.selectedIndex_ == 0 then
		self:RefreshBossUI()

		return
	end

	local var_12_0 = self.stageItemList_[self.selectedIndex_].cfg_

	self.descText_.text = self.stageItemList_[self.selectedIndex_].cfg_.desc
	self.nameText_.text = var_12_0.name

	self.iconController_:SetSelectedState("subBoss")

	self.titleImg_.sprite = getSprite("Atlas/IndiaUI_2_8", var_12_0.icon)

	for iter_12_0, iter_12_1 in ipairs(self.stageItemList_) do
		iter_12_1:RefreshState()
	end
end

function IndiaNianDetailView:RefreshBossUI()
	self.descText_.text = self.bossCfg_.desc
	self.nameText_.text = self.bossCfg_.name

	self.iconController_:SetSelectedState("boss")

	for iter_13_0, iter_13_1 in ipairs(self.stageItemList_) do
		iter_13_1:RefreshState()
	end
end

function IndiaNianDetailView:Dispose()
	IndiaNianDetailView.super.Dispose(self)

	for iter_14_0, iter_14_1 in pairs(self.stageItemList_) do
		iter_14_1:Dispose()
	end

	self.stageItemList_ = nil
end

return IndiaNianDetailView
