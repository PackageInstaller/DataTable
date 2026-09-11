local ActivityNewWarChessRewardItemItem = class("ActivityNewWarChessRewardItemItem", ReduxView)

function ActivityNewWarChessRewardItemItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityNewWarChessRewardItemItem:Init()
	self:InitUI()
	self:AddUIListener()
	self:AddEventListeners()
end

function ActivityNewWarChessRewardItemItem:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.m_list, CommonItem)
end

function ActivityNewWarChessRewardItemItem:indexItem(arg_4_1, arg_4_2)
	arg_4_2:RefreshData(formatReward(self.cfg_[arg_4_1]))
	arg_4_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, self.cfg_[arg_4_1])
	end)
end

function ActivityNewWarChessRewardItemItem:AddUIListener()
	self:AddBtnListener(self.m_receiveBtn, nil, function()
		NewWarChessAction.GetActivityReward(self.levelID_, self.activityId_, {
			self.exploreLevel_
		})
	end)
end

function ActivityNewWarChessRewardItemItem:AddEventListeners()
	self:RegistEventListener(ACTIVITY_NEWWARCHESS_REWARD_UPDATE, function(arg_9_0, arg_9_1)
		if arg_9_0 == self.levelID_ and table.indexof(arg_9_1, self.exploreLevel_) then
			self:UpdateView()
		end
	end)
end

function ActivityNewWarChessRewardItemItem:SetData(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self.index_ = arg_10_1
	self.levelID_ = arg_10_2
	self.activityId_ = arg_10_3
	self.exploreLevel_ = arg_10_4
	self.cfg_ = NewWarChessLevelCfg[self.levelID_].reward[table.indexof(NewWarChessLevelCfg[arg_10_2].explore, self.exploreLevel_)]

	self:UpdateView()
end

function ActivityNewWarChessRewardItemItem:UpdateView()
	self.m_pointLab.text = self.exploreLevel_ .. "%"

	self.uiList_:StartScroll(#self.cfg_)

	if NewWarChessData:GetRewardIsGet(self.levelID_, self.exploreLevel_) then
		self.statusController_:SetSelectedState("rewarded")
	elseif NewWarChessData:GetExploreValue(self.levelID_) >= self.exploreLevel_ then
		self.statusController_:SetSelectedState("complete")
	else
		self.statusController_:SetSelectedState("unfinished")
	end
end

function ActivityNewWarChessRewardItemItem:Dispose()
	self:RemoveAllEventListener()

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	ActivityNewWarChessRewardItemItem.super.Dispose(self)
end

return ActivityNewWarChessRewardItemItem
