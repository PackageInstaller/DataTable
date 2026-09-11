local MardukSpecialRankView = class("MardukSpecialRankView", ReduxView)

function MardukSpecialRankView:UIName()
	return "UI/MardukUI/special/MardukSpecialTaskUI"
end

function MardukSpecialRankView:UIParent()
	return manager.ui.uiMain.transform
end

function MardukSpecialRankView:OnCtor()
	return
end

function MardukSpecialRankView:Init()
	self:InitUI()
end

function MardukSpecialRankView:InitUI()
	self:BindCfgUI()

	self.activityOpenHandler_ = handler(self, self.ActivityOpen)
	self.tree_ = LuaTree.New(self.treeGo_)

	self.tree_:SetRenderer(handler(self, self.GroupRenderer))

	local var_5_0 = {}

	self.resultActivityIds_ = var_5_0
	self.activityIds_ = ActivityCfg[self.params_.activityID].sub_activity_list

	local var_5_1 = {}

	for iter_5_0, iter_5_1 in ipairs(ActivityCfg[self.params_.activityID].sub_activity_list) do
		if ActivityCfg[iter_5_1].sub_activity_list ~= nil and #ActivityCfg[iter_5_1].sub_activity_list > 0 then
			table.insert(var_5_0, iter_5_1)
			table.insert(var_5_1, ActivityQuickTrainingCfg[iter_5_1].stage_id)
		end
	end

	local var_5_2 = UITreeData.New()

	self.activityIds_ = var_5_0
	self.battleIds_ = var_5_1

	for iter_5_2 = 1, #var_5_0 do
		local var_5_4 = UITreeGroupData.New()

		var_5_4.id = var_5_0[iter_5_2]
		var_5_4.text = GetI18NText(BattleQuickTrainingCfg[var_5_1[iter_5_2]].name)

		var_5_2.groupDatas:Add(var_5_4)
	end

	self.tree_:SetData(var_5_2)
	self.tree_:SetSelectedHandler(handler(self, self.OnGroupSelect))

	self.rankContentView_ = MardukSpecialRankContentView.New(self.rankContentGo_)
end

function MardukSpecialRankView:GroupRenderer(arg_6_1, arg_6_2)
	local var_6_0 = ControllerUtil.GetController(arg_6_2.transform, "lock")

	if ActivityData:GetActivityIsOpen(arg_6_1) then
		var_6_0:SetSelectedState("false")
	else
		var_6_0:SetSelectedState("true")
	end
end

function MardukSpecialRankView:OnGroupSelect(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if not ActivityData:GetActivityIsOpen(self.activityIds_[arg_7_1]) then
		if ActivityData:GetActivityData(self.activityIds_[arg_7_1]).stopTime < manager.time:GetServerTime() then
			ShowTips(GetTips("TIME_OVER"))
		else
			ShowTips(string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.activityIds_[arg_7_1]).startTime))))
		end

		self.tree_:SelectGroup(self.curIndex_)

		return
	end

	self.curIndex_ = arg_7_1

	self.rankContentView_:SetMySelfData(self.battleIds_[arg_7_1])
	self:GetRankData(arg_7_1)
end

function MardukSpecialRankView:GetRankData(arg_8_1, arg_8_2)
	RankAction.QueryActivityRank(ActivityCfg[self.activityIds_[arg_8_1]].sub_activity_list[1])
end

function MardukSpecialRankView:UpdateGroupView(arg_9_1)
	self.rankContentView_:SetData(self.battleIds_[arg_9_1], ActivityCfg[self.activityIds_[arg_9_1]].sub_activity_list[1])
end

function MardukSpecialRankView:AddEventListeners()
	manager.notify:RegistListener(ACTIVITY_UPDATE, self.activityOpenHandler_)
end

function MardukSpecialRankView:OnTop()
	self:UpdateBar()
end

function MardukSpecialRankView:OnBehind()
	manager.windowBar:HideBar()
end

function MardukSpecialRankView:UpdateBar()
	self:ShowDefaultBar()
end

function MardukSpecialRankView:OnEnter()
	self:AddEventListeners()

	local var_14_0 = 1

	for iter_14_0 = 1, #self.resultActivityIds_ do
		if self.resultActivityIds_[iter_14_0] == self.params_.subActivityId then
			var_14_0 = iter_14_0
		end
	end

	self.rankContentView_:SetMySelfData(self.battleIds_[var_14_0])
	self:GetRankData(var_14_0)
	self.tree_:SelectGroup(var_14_0)
end

function MardukSpecialRankView:OnExit()
	self:RemoveAllEventListener()
	manager.notify:RemoveListener(ACTIVITY_UPDATE, self.activityOpenHandler_)
	manager.windowBar:HideBar()
end

function MardukSpecialRankView:OnMainHomeViewTop()
	return
end

function MardukSpecialRankView:ActivityOpen(arg_17_1)
	if table.indexof(self.activityIds_, arg_17_1) then
		self.tree_:Refresh()
	end
end

function MardukSpecialRankView:Dispose()
	if self.tree_ then
		self.tree_:Dispose()

		self.tree_ = nil
	end

	if self.rankContentView_ then
		self.rankContentView_:Dispose()

		self.rankContentView_ = nil
	end

	MardukSpecialRankView.super.Dispose(self)
end

function MardukSpecialRankView:OnRankUpdate()
	self:UpdateGroupView(self.curIndex_)
end

return MardukSpecialRankView
