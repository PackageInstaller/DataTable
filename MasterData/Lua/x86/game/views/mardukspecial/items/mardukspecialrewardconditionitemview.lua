local MardukSpecialRewardConditionItemView = class("MardukSpecialRewardConditionItemView", ReduxView)

function MardukSpecialRewardConditionItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MardukSpecialRewardConditionItemView:Init()
	self:InitUI()
	self:AddUIListener()
	self:AddEventListeners()
end

function MardukSpecialRewardConditionItemView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, FactorySoloChallengeRewardCommonItem)
end

function MardukSpecialRewardConditionItemView:indexItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(self.cfg_.reward_item_list[arg_4_1], POP_ITEM)
end

function MardukSpecialRewardConditionItemView:AddUIListener()
	self:AddBtnListener(self.getBtn_, nil, function()
		ActivityAction.GetBonus({
			self.rewardId_
		})
	end)
end

function MardukSpecialRewardConditionItemView:AddEventListeners()
	self:RegistEventListener(MARDUK_SPECIAL_REWARD_UPDATE, function(arg_8_0)
		if table.indexof(arg_8_0, self.rewardId_) then
			self:UpdateView()
		end
	end)
end

function MardukSpecialRewardConditionItemView:SetData(arg_9_1, arg_9_2, arg_9_3)
	self.activityId_ = arg_9_3
	self.index_ = arg_9_1
	self.rewardId_ = arg_9_2
	self.cfg_ = ActivityPointRewardCfg[arg_9_2]

	self:UpdateView()
end

function MardukSpecialRewardConditionItemView:UpdateView()
	self.conditionLabel_.text = string.format(GetTips("FACTORY_ACTIVITY_POINT_REWARD"), self.cfg_.need)

	self.uiList_:StartScroll(#self.cfg_.reward_item_list)

	if MardukSpecialData:HaveGotReward(self.activityId_, self.rewardId_) then
		self.statusController_:SetSelectedState("haveGet")
	elseif MardukSpecialData:GetPoint(self.activityId_) >= self.cfg_.need then
		self.statusController_:SetSelectedState("canGet")
	else
		self.statusController_:SetSelectedState("unFinish")
	end
end

function MardukSpecialRewardConditionItemView:OnEnter()
	return
end

function MardukSpecialRewardConditionItemView:OnExit()
	return
end

function MardukSpecialRewardConditionItemView:OnMainHomeViewTop()
	return
end

function MardukSpecialRewardConditionItemView:Dispose()
	self:RemoveAllEventListener()

	self.data_ = nil

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	MardukSpecialRewardConditionItemView.super.Dispose(self)
end

return MardukSpecialRewardConditionItemView
