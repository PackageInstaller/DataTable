local FireWorkMainView = class("FireWorkMainView", ReduxView)

function FireWorkMainView:UIName()
	return "UI/EmptyDream/Firework/FireworkMainUI"
end

function FireWorkMainView:UIParent()
	return manager.ui.uiMain.transform
end

function FireWorkMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FireWorkMainView:InitUI()
	self:BindCfgUI()

	self.headList = LuaList.New(handler(self, self.IndexHeadItem), self.m_roleList, FireWorkHeadItem)
	self.rewardList = LuaList.New(handler(self, self.IndexRewardItem), self.m_rewardList, CommonItem)
	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function FireWorkMainView:AddUIListener()
	self:AddBtnListener(self.m_receiveBtn, nil, function()
		FireWorkAction.QueryReceiveReward(self.select)
	end)
	self:AddBtnListener(self.m_reviewBtn, nil, function()
		JumpTools.OpenPageByJump("/fireWorkShow", {
			fire_activity_id = self.select
		})
	end)
	self:AddBtnListener(self.m_inviteBtn, nil, function()
		JumpTools.OpenPageByJump("fireWorkMake", {
			start = true,
			fire_activity_id = self.select
		})
	end)
end

function FireWorkMainView:OnTop()
	local var_9_0

	if GameSetting.activity_firework_describe then
		var_9_0 = GameSetting.activity_firework_describe.value or {}
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = var_9_0
		}
	})
end

function FireWorkMainView:OnEnter()
	self.activity_id = ActivityConst.FIRE_WORK
	self.sub_activity_list = ActivityCfg[self.activity_id].sub_activity_list

	if self.params_.fire_activity_id then
		self.select = self.params_.fire_activity_id
		self.params_.fire_activity_id = nil
	end

	if self.select == nil or not ActivityData:GetActivityIsOpen(self.select) then
		for iter_10_0, iter_10_1 in ipairs(self.sub_activity_list) do
			if ActivityData:GetActivityIsOpen(iter_10_1) then
				self.select = iter_10_1

				break
			end
		end
	end

	self.headList:StartScroll(#self.sub_activity_list, table.indexof(self.sub_activity_list, self.select) or 1, true)
	self:RefreshUI()
	self:RefrenTime()

	self.timer = Timer.New(function()
		self:RefrenTime()
	end, 1, -1)

	self.timer:Start()

	if GameSetting.activity_firework_story.value[1] and not manager.story:IsStoryPlayed(GameSetting.activity_firework_story.value[1]) then
		manager.story:StartStoryById(GameSetting.activity_firework_story.value[1], function(arg_12_0)
			return
		end)
	end
end

function FireWorkMainView:OnExit()
	manager.windowBar:HideBar()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	for iter_13_0, iter_13_1 in pairs((self.headList:GetItemList())) do
		iter_13_1:OnExit()
	end
end

function FireWorkMainView:RefrenTime()
	local var_14_0 = ActivityData:GetActivityData(self.activity_id)

	self.m_timeLab.text = var_14_0 and var_14_0:IsActivitying() and manager.time:GetLostTimeStr(var_14_0.stopTime) or GetTips("TIME_OVER")

	for iter_14_0, iter_14_1 in pairs((self.headList:GetItemList())) do
		iter_14_1:RefrenTime()
	end
end

function FireWorkMainView:RefreshUI()
	if self.select and ActivityFireWorkCfg[self.select] then
		FireWorkAction.SetRead(self.select)

		self.m_roleDes.text = GetI18NText(ActivityFireWorkCfg[self.select].desc)
		self.m_roleIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/letter_role_title/" .. ActivityFireWorkCfg[self.select].icon)
		self.rewards = ActivityFireWorkCfg[self.select].reward_item_list

		self.rewardList:StartScroll(#self.rewards)

		if FireWorkData:GetReward(self.select) then
			self.stateController:SetSelectedIndex(2)
		elseif FireWorkData:GetInvited(self.select) then
			self.stateController:SetSelectedIndex(1)
		else
			self.stateController:SetSelectedIndex(0)
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.FIRE_WORK_OPEN, self.select), 0)
	else
		self.m_roleIcon.sprite = nil
		self.m_roleDes.text = ""

		self.rewardList:StartScroll(0)
		self.stateController:SetSelectedIndex(0)
	end
end

function FireWorkMainView:HeadClick(arg_16_1)
	self.select = arg_16_1

	self:RefreshUI()

	for iter_16_0, iter_16_1 in pairs((self.headList:GetItemList())) do
		iter_16_1:UpdateSelect(self.select)
	end
end

function FireWorkMainView:IndexHeadItem(arg_17_1, arg_17_2)
	arg_17_2:SetData(self.sub_activity_list[arg_17_1])
	arg_17_2:UpdateSelect(self.select)
	arg_17_2:RegistCallBack(handler(self, self.HeadClick))
end

function FireWorkMainView:IndexRewardItem(arg_18_1, arg_18_2)
	local var_18_0 = self.rewards[arg_18_1]

	arg_18_2:RefreshData(formatReward(self.rewards[arg_18_1]))
	arg_18_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_18_0)
	end)
end

function FireWorkMainView:Dispose()
	self.headList:Dispose()
	self.rewardList:Dispose()
	FireWorkMainView.super.Dispose(self)
end

function FireWorkMainView:OnFireWordUpdate()
	self:RefreshUI()
end

return FireWorkMainView
