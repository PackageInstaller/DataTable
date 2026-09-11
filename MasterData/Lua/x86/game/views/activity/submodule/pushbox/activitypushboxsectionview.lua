local ActivityPushBoxSectionView = class("ActivityPushBoxSectionView", ReduxView)

function ActivityPushBoxSectionView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityPushBoxSectionView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityPushBoxSectionView:InitUI()
	self:BindCfgUI()

	self.heroAffixItem_ = {}
	self.enemyAffixItem_ = {}
	self.statusCon_ = ControllerUtil.GetController(self.transform_, "status")
	self.levelCon_ = ControllerUtil.GetController(self.transform_, "level")
	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
	self.costCon_ = ControllerUtil.GetController(self.transform_, "cost")
	self.boxStateCon_ = ControllerUtil.GetController(self.transform_, "boxOrder")
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, CommonItem)
	self.boxScrollHelper_ = LuaList.New(handler(self, self.BoxIndexItem), self.boxListGo_, PushBoxReplayItem)
end

function ActivityPushBoxSectionView:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:RefreshData(formatReward(self.list_[arg_4_1]))
	arg_4_2:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_MERGE_ITEM, {
			arg_5_0.id
		})
	end)
end

function ActivityPushBoxSectionView:BoxIndexItem(arg_6_1, arg_6_2)
	arg_6_2:RefreshData(self.boxList_[arg_6_1])
end

function ActivityPushBoxSectionView:AddUIListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		if not self:CheckTime() then
			return
		end

		if self.cfg_.cost > ActivityPushBoxData:GetFatigue(self.mainActivityID_) then
			ShowTips("ORDER_FATIGUE_NOT_ENOUGH")

			return
		end

		JumpTools.OpenPageByJump("/sectionSelectHero", {
			section = self.cfg_.param,
			sectionType = BattleConst.STAGE_TYPE_NEW.PUSH_BOX_BATTLE,
			activityID = self.mainActivityID_,
			dest_id = self.id_
		})
	end)
	self:AddBtnListener(self.boxBtn_, nil, function()
		if not self:CheckTime() then
			return
		end

		JumpTools.OpenPageByJump("/pushBox", {
			map_id = self.cfg_.param,
			activityID = self.mainActivityID_,
			id = self.id_
		})
	end)
	self:AddBtnListener(self.boxTypeBtn_, nil, function()
		self.boxType_ = 1 - self.boxType_

		self:RefreshBoxType()
	end)
end

function ActivityPushBoxSectionView:OnEnter()
	return
end

function ActivityPushBoxSectionView:SetData(arg_12_1, arg_12_2)
	self.id_ = arg_12_1
	self.isClose_ = arg_12_2
	self.cfg_ = ActivityCelebrationOrderCfg[self.id_]

	self:RefreshData()
	self:RefreshUI()
end

function ActivityPushBoxSectionView:RefreshData()
	self.activityID_ = self.cfg_.activity_id
	self.mainActivityID_ = self.cfg_.main_activity
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
end

function ActivityPushBoxSectionView:RefreshUI()
	if self.cfg_.type == PushBoxConst.EVENT_TYPE.BATTLE then
		self:RefreshBattle()
	elseif self.cfg_.type == PushBoxConst.EVENT_TYPE.PUSH_BOX then
		self:RefreshBox()
	end

	self:RefreshReward()
end

function ActivityPushBoxSectionView:RefreshBattle()
	self.battleDesc_.text = self.cfg_.order_desc
	self.battleTitle_.text = self.cfg_.order_title

	local var_15_0 = self.cfg_.cost

	self.battleCost_.text = self.cfg_.cost
	self.battleIcon_.sprite = ItemTools.getItemLittleSprite((PushBoxTool:GetFatigueID(self.activityID_)))

	self.costCon_:SetSelectedState(var_15_0 <= ActivityPushBoxData:GetFatigue(self.mainActivityID_) and "true" or "false")

	local var_15_1 = getHeroAffixs(self.cfg_.affix_list)
	local var_15_2 = getMosterAffix(self.cfg_.affix_list)

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		self.heroAffixItem_[iter_15_0] = self.heroAffixItem_[iter_15_0] or PushBoxAffixItem.New(self.affixGo_, self.heroAffixContent_)

		self.heroAffixItem_[iter_15_0]:SetData(iter_15_1)
	end

	for iter_15_2 = #var_15_1 + 1, #self.heroAffixItem_ do
		self.heroAffixItem_[iter_15_2]:SetActive(false)
	end

	for iter_15_3, iter_15_4 in ipairs(var_15_2) do
		self.enemyAffixItem_[iter_15_3] = self.enemyAffixItem_[iter_15_3] or PushBoxAffixItem.New(self.affixGo_, self.enemyAffixContent_)

		self.enemyAffixItem_[iter_15_3]:SetData(iter_15_4)
	end

	for iter_15_5 = #var_15_2 + 1, #self.enemyAffixItem_ do
		self.enemyAffixItem_[iter_15_5]:SetActive(false)
	end

	self.statusCon_:SetSelectedState("normal")
	self.typeCon_:SetSelectedState("challenge")
	self.levelCon_:SetSelectedState(self.cfg_.hard)
	self.boxStateCon_:SetSelectedState("normal")
end

function ActivityPushBoxSectionView:RefreshBox()
	self.boxType_ = 1
	self.boxDesc_.text = self.cfg_.order_desc
	self.boxTitle_.text = self.cfg_.order_title

	self:RefreshTime()
	self:RefreshHistory()
	self:RefreshBoxType()
	self.typeCon_:SetSelectedState("box")
	self.statusCon_:SetSelectedState(self.isClose_ and "complete" or "normal")
end

function ActivityPushBoxSectionView:RefreshTime()
	self:StopTimer()

	if ActivityPushBoxData:GetNextID(self.mainActivityID_, self.id_) == 0 then
		SetActive(self.timeGo_, false)

		return
	end

	SetActive(self.timeGo_, true)

	local var_17_0 = manager.time:GetServerTime()
	local var_17_1 = manager.time:GetNextFreshTime()

	self.countDownTxt_.text = manager.time:DescCDTime(var_17_1 - var_17_0)
	self.timer_ = Timer.New(function()
		var_17_0 = manager.time:GetServerTime()
		self.countDownTxt_.text = manager.time:DescCDTime(var_17_1 - var_17_0)
	end, 1, -1)

	self.timer_:Start()
end

function ActivityPushBoxSectionView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityPushBoxSectionView:RefreshHistory()
	self.boxList_ = ActivityPushBoxData:GetFinishList(self.mainActivityID_)

	table.sort(self.boxList_, function(arg_21_0, arg_21_1)
		return arg_21_0 < arg_21_1
	end)
	self.boxScrollHelper_:StartScroll(#self.boxList_)
end

function ActivityPushBoxSectionView:RefreshBoxType()
	self.boxStateCon_:SetSelectedState(self.boxType_ == 1 and "normal" or "pastRecords")
end

function ActivityPushBoxSectionView:RefreshReward()
	self.list_ = self.cfg_.award_list

	self.scrollHelper_:StartScroll(#self.list_)
end

function ActivityPushBoxSectionView:CheckTime()
	local var_24_0 = manager.time:GetServerTime()

	if var_24_0 < self.startTime_ then
		ShowTips("SOLO_NOT_OPEN")

		return false
	end

	if var_24_0 >= self.stopTime_ then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

function ActivityPushBoxSectionView:Show(arg_25_1)
	SetActive(self.gameObject_, arg_25_1)
end

function ActivityPushBoxSectionView:OnExit()
	self:StopTimer()

	for iter_26_0, iter_26_1 in ipairs(self.scrollHelper_:GetItemList()) do
		iter_26_1:OnExit()
	end

	for iter_26_2, iter_26_3 in ipairs(self.boxScrollHelper_:GetItemList()) do
		iter_26_3:OnExit()
	end

	for iter_26_4, iter_26_5 in ipairs(self.heroAffixItem_) do
		iter_26_5:OnExit()
	end

	for iter_26_6, iter_26_7 in ipairs(self.enemyAffixItem_) do
		iter_26_7:OnExit()
	end
end

function ActivityPushBoxSectionView:Dispose()
	self:RemoveAllListeners()

	for iter_27_0, iter_27_1 in ipairs(self.scrollHelper_:GetItemList()) do
		iter_27_1:Dispose()
	end

	self.scrollHelper_:Dispose()

	for iter_27_2, iter_27_3 in ipairs(self.boxScrollHelper_:GetItemList()) do
		iter_27_3:Dispose()
	end

	self.boxScrollHelper_:Dispose()

	for iter_27_4, iter_27_5 in ipairs(self.heroAffixItem_) do
		iter_27_5:Dispose()
	end

	for iter_27_6, iter_27_7 in ipairs(self.enemyAffixItem_) do
		iter_27_7:Dispose()
	end

	self.super.Dispose(self)
end

return ActivityPushBoxSectionView
