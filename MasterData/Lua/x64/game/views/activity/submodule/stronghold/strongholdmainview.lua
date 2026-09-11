local StrongholdMainView = class("StrongholdMainView", ReduxView)

function StrongholdMainView:UIBackCount()
	return 2
end

function StrongholdMainView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/StrongholdMainUI"
end

function StrongholdMainView:UIParent()
	return manager.ui.uiMain.transform
end

function StrongholdMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrongholdMainView:InitUI()
	self:BindCfgUI()

	self.difficultyList = LuaList.New(handler(self, self.IndexItem), self.m_difficultyList, StrongholdMainDifficultyItem)
	self.itemClickHandler = handler(self, self.OnItemClick)
	self.matchTime = 0
	self.colorController = ControllerUtil.GetController(self.transform_, "color")
	self.matchController = ControllerUtil.GetController(self.transform_, "match")

	self.matchController:SetSelectedIndex(0)
end

function StrongholdMainView:AddUIListener()
	self:AddBtnListener(nil, self.m_createRoomBtn, function()
		if not ActivityTools.GetActivityIsOpenWithTip(self.selectId) then
			return
		end

		if CooperationData:GetRoomData() then
			CooperationTools.GotoCooperation()
		else
			local var_7_0

			if CooperationData:GetIsMatching() then
				ShowTips("ERROR_COORDINATOR_ALREADY_IN_MATCH")

				do return end

				var_7_0 = {}
			end

			var_7_0[1] = CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.STRONGHOLD, self.selectId, self.selectId)

			CooperationAction.CreateRoom(self.selectId, BattleConst.STAGE_TYPE_NEW.STRONGHOLD, var_7_0, self.selectId)
		end
	end)
	self:AddBtnListener(nil, self.m_quickJoinBtn, function()
		if CooperationData:GetIsMatching() then
			CooperationAction.CancelMatching()
		else
			local var_8_0

			if not ActivityTools.GetActivityIsOpenWithTip(self.selectId) then
				do return end

				var_8_0 = {}
			end

			var_8_0[1] = CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.STRONGHOLD, self.selectId, self.selectId)

			CooperationAction.StartMatching(self.selectId, BattleConst.STAGE_TYPE_NEW.STRONGHOLD, var_8_0, self.selectId)
		end
	end)
	self:AddBtnListener(nil, self.m_inviteBtn, function()
		JumpTools.OpenPageByJump("cooperationApply", {
			selectIndex = BattleConst.STAGE_TYPE_NEW.STRONGHOLD
		})
	end)
	self:AddBtnListener(nil, self.m_taskBtn, function()
		JumpTools.OpenPageByJump("/strongholdOperate", {
			selectIndex = 1,
			activity_id = self.activity_id
		})
	end)
	self:AddBtnListener(nil, self.m_skillBtn, function()
		JumpTools.OpenPageByJump("/strongholdOperate", {
			selectIndex = 2,
			activity_id = self.activity_id
		})
	end)
	self:AddBtnListener(nil, self.m_increaseBtn, function()
		JumpTools.OpenPageByJump("/strongholdOperate", {
			selectIndex = 3,
			activity_id = self.activity_id
		})
	end)
	self:AddBtnListener(nil, self.m_rewardBtn, function()
		JumpTools.OpenPageByJump("/strongholdOperate", {
			selectIndex = 4,
			activity_id = self.activity_id
		})
	end)
	self:AddBtnListener(nil, self.m_atlasBtn, function()
		JumpTools.OpenPageByJump("strongholdAtlas", {
			activity_id = self.activity_id
		})
	end)
	self:AddBtnListener(nil, self.m_teachBtn, function()
		self:Go("/sectionSelectHeroTeach", {
			section = BattleConst.COOPERATION_STRONGHOLD_TEACH_STAGE_ID,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING
		})
	end)
	self:AddBtnListener(nil, self.m_operateBtn, function()
		JumpTools.OpenPageByJump("strongholdOperate", {
			selectIndex = 1,
			activity_id = self.activity_id
		})
	end)
end

function StrongholdMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INVITE_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_STRONGHOLD_DES")
end

function StrongholdMainView:OnEnter()
	self.activity_id = ActivityConst.ACTIVITY_STRONGHOLD
	self.stronghold_stage_activity_list = {}

	for iter_18_0, iter_18_1 in ipairs(ActivityCfg[self.activity_id].sub_activity_list) do
		if ActivityTemplateConst.STRONGHOLD_STAGE == ActivityCfg[iter_18_1].activity_template then
			table.insert(self.stronghold_stage_activity_list, iter_18_1)
		end
	end

	if self.selectId == nil then
		self.selectId = self.stronghold_stage_activity_list[1]
	end

	if self.selectId == 182203 then
		self.colorController:SetSelectedIndex(1)
	else
		self.colorController:SetSelectedIndex(0)
	end

	self.difficultyList:StartScroll(#self.stronghold_stage_activity_list)

	local var_18_0, var_18_1 = StrongholdData:GetStrongholdLevelAndIncreasePoint(self.activity_id)

	self.m_lvLab.text = var_18_0

	self:RefreshUI()

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:RefreshTime()
		end, 1, -1)
	end

	self.timer_:Start()
	self:RefreshTime()
	manager.redPoint:bindUIandKey(self.m_taskBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_TASK, self.activity_id))
	manager.redPoint:bindUIandKey(self.m_increaseBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_INCREASE, self.activity_id))
	manager.redPoint:bindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_REWARD, self.activity_id))
	manager.redPoint:bindUIandKey(self.m_operateBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD, self.activity_id))
	manager.redPoint:bindUIandKey(self.m_inviteBtn.transform, RedPointConst.COOPERATION_INVIT)
end

function StrongholdMainView:RefreshUI()
	local var_20_0 = CooperationData:GetIsMatching()

	self.m_matchingLab.text = var_20_0 and GetTips("COOPERATION_CANCEL_MATCH") or GetTips("COOPERATION_START_MATCH")
	self.matchTime = 0
	self.m_matchingTime.text = ""

	self.matchController:SetSelectedIndex(var_20_0 and 1 or 0)
end

function StrongholdMainView:OnExit()
	manager.windowBar:HideBar()

	if CooperationData:GetIsMatching() then
		CooperationAction.CancelMatching()
	end

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	manager.redPoint:unbindUIandKey(self.m_taskBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_TASK, self.activity_id))
	manager.redPoint:unbindUIandKey(self.m_increaseBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_INCREASE, self.activity_id))
	manager.redPoint:unbindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_REWARD, self.activity_id))
	manager.redPoint:unbindUIandKey(self.m_operateBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD, self.activity_id))
	manager.redPoint:unbindUIandKey(self.m_inviteBtn.transform, RedPointConst.COOPERATION_INVIT)
	self.matchController:SetSelectedIndex(0)
end

function StrongholdMainView:RefreshTime()
	local var_22_0 = ActivityData:GetActivityData(self.activity_id)

	self.m_timeLab.text = var_22_0 and var_22_0:IsActivitying() and GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr(var_22_0.stopTime) or GetTips("TIME_OUT")

	for iter_22_0, iter_22_1 in pairs((self.difficultyList:GetItemList())) do
		iter_22_1:RefreshTime()
	end

	if CooperationData:GetIsMatching() then
		self.matchTime = self.matchTime + 1
		self.m_matchingTime.text = string.format(GetTips("COOPERATION_MATCHING"), self.matchTime)
	end
end

function StrongholdMainView:IndexItem(arg_23_1, arg_23_2)
	arg_23_2:SetData(self.activity_id, self.stronghold_stage_activity_list[arg_23_1])
	arg_23_2:SetSelect(self.selectId)
	arg_23_2:RegistCallBack(self.itemClickHandler)
end

function StrongholdMainView:OnItemClick(arg_24_1)
	self.selectId = arg_24_1

	self.difficultyList:Refresh()

	if arg_24_1 == 182203 then
		self.colorController:SetSelectedIndex(1)
	else
		self.colorController:SetSelectedIndex(0)
	end
end

function StrongholdMainView:Dispose()
	self.difficultyList:Dispose()
	StrongholdMainView.super.Dispose(self)
end

function StrongholdMainView:OnCooperationIsMatchingChange()
	self:RefreshUI()
end

function StrongholdMainView:OnStrongholdUpgradeIncrease()
	self.difficultyList:Refresh()
end

return StrongholdMainView
