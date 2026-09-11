local DemonChallengeMainView = class("DemonChallengeMainView", ReduxView)

function DemonChallengeMainView:UIName()
	return nil
end

function DemonChallengeMainView:UIParent()
	return manager.ui.uiMain.transform
end

function DemonChallengeMainView:InitGo(arg_3_1)
	if self.gameObject_ then
		self:Dispose()
		Object.Destroy(self.gameObject_)
	end

	self.gameObject_ = Object.Instantiate(Asset.Load(arg_3_1), self:UIParent())
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddUIListener()
end

function DemonChallengeMainView:InitUI()
	self:BindCfgUI()

	self.tree_ = LuaTree.New(self.treeGo_)

	self.tree_:SetSelectedHandler(handler(self, self.OnLevelSelect))
	self.tree_:SetRenderer(handler(self, self.LevelRenderer))

	self.levelControllerS_ = {}
	self.lockTextS_ = {}
	self.iconS_ = {}
end

function DemonChallengeMainView:AddUIListener()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("demonChallengeAward", {
			selectId = self.curSelectId_
		})
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		JumpTools.OpenPageByJump("demonChallengeDifficultySelect", {
			selectId = self.curSelectId_
		})
	end)

	if self.talentBtn_ then
		self:AddBtnListener(self.talentBtn_, nil, function()
			local var_8_0 = TalentTreeTools.GetActivityIdByTheme((ActivityTools.GetActivityTheme(self.activityId_)))

			if var_8_0 then
				JumpTools.OpenPageByJump("/talentTree", {
					activityID = var_8_0
				})
			end
		end)
	end
end

function DemonChallengeMainView:InitTree()
	local var_9_0 = UITreeData.New()
	local var_9_1 = ActivityData:GetActivityData(self.activityId_).subActivityIdList

	for iter_9_0 = 1, #var_9_1 do
		local var_9_2 = UITreeGroupData.New()

		var_9_2.id = var_9_1[iter_9_0]

		local var_9_3 = BattleHeartDemonStageCfg[DemonChallengeTools.GetStageId(var_9_1[iter_9_0], 1)]

		if var_9_3 then
			var_9_2.text = GetI18NText(var_9_3.name)
		end

		var_9_0.groupDatas:Add(var_9_2)
	end

	self.tree_:SetData(var_9_0)
end

function DemonChallengeMainView:OnLevelSelect(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = ActivityData:GetActivityData(arg_10_2)

	if not var_10_0:IsActivitying() then
		if self.curLevelIndex_ and self.curLevelIndex_ ~= arg_10_1 then
			if var_10_0.stopTime <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")
			else
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_10_0.startTime)))
			end

			self.tree_:SelectGroup(self.curLevelIndex_)
		else
			self.isNeedExit_ = true
		end

		return
	end

	self:RefreshRewardRedPoint(self.curSelectId_, arg_10_2)

	self.curLevelIndex_ = arg_10_1
	self.curSelectId_ = arg_10_2

	print("childId", childId)

	local var_10_1 = getSpriteWithoutAtlas("TextureConfig/" .. DemonChallengeCfg[DemonChallengeTools.GetChildId(self.curSelectId_, 1)].icon)

	if var_10_1 then
		self.roleImg_.sprite = var_10_1
	end

	self:RefreshDescText()
	SubDemonChallengeAction.SetSelectedActivityId(arg_10_2)
end

function DemonChallengeMainView:LevelRenderer(arg_11_1, arg_11_2)
	if self.levelControllerS_[arg_11_1] == nil then
		self.levelControllerS_[arg_11_1] = ControllerUtil.GetController(arg_11_2.transform, "lock")
	end

	self.levelControllerS_[arg_11_1]:SetSelectedState("false")

	self.lockTextS_[arg_11_1] = self:FindCom(typeof(Text), "title/lock/text", arg_11_2.transform)

	local var_11_0 = self:FindTrs("title/icon", arg_11_2.transform)

	if var_11_0 then
		self.iconS_[arg_11_1] = var_11_0:GetComponent(typeof(Image))
	end

	if self.iconS_[arg_11_1] then
		self.iconS_[arg_11_1].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/" .. DemonChallengeCfg[DemonChallengeTools.GetChildId(arg_11_1, 1)].icon)
	end
end

function DemonChallengeMainView:RefreshDescText()
	local var_12_0 = BattleHeartDemonStageCfg[DemonChallengeTools.GetStageId(self.curSelectId_, 1)]

	if var_12_0 then
		self.descText_.text = GetI18NText(var_12_0.tips)

		if self.titleText_ then
			self.titleText_.text = GetI18NText(var_12_0.name)
		end
	end
end

function DemonChallengeMainView:RefreshTime()
	local var_13_0 = ActivityData:GetActivityData(self.activityId_)

	if var_13_0:GetRemainTime() >= 0 then
		self.remainTimeText_.text = string.format(GetTips("TIME_DISPLAY_3"), manager.time:GetLostTimeStr(var_13_0.stopTime))
	end

	for iter_13_0, iter_13_1 in pairs(self.lockTextS_) do
		local var_13_1 = ActivityData:GetActivityData(iter_13_0)

		if var_13_1:GetTimeBeforeStart() > 0 then
			self.levelControllerS_[iter_13_0]:SetSelectedState("false")

			self.lockTextS_[iter_13_0].text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_13_1.startTime))

			if self.iconS_[iter_13_0] then
				self.iconS_[iter_13_0].color = Color.gray
			end
		else
			self.levelControllerS_[iter_13_0]:SetSelectedState("true")

			if self.iconS_[iter_13_0] then
				self.iconS_[iter_13_0].color = Color.white
			end
		end
	end
end

function DemonChallengeMainView:RegisterRedPoint()
	local var_14_0 = ActivityData:GetActivityData(self.activityId_).subActivityIdList

	for iter_14_0 = 1, #var_14_0 do
		manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(var_14_0[iter_14_0]), RedPointConst.DEMON_CHALLENGE .. var_14_0[iter_14_0])
	end
end

function DemonChallengeMainView:UnRegisterRedPoint()
	local var_15_0 = ActivityData:GetActivityData(self.activityId_).subActivityIdList

	for iter_15_0 = 1, #var_15_0 do
		manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(var_15_0[iter_15_0]), RedPointConst.DEMON_CHALLENGE .. var_15_0[iter_15_0])
	end

	if self.curSelectId_ then
		manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.DEMON_CHALLENGE_REWARD .. self.curSelectId_)
	end
end

function DemonChallengeMainView:RefreshRewardRedPoint(arg_16_1, arg_16_2)
	if arg_16_1 then
		manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.DEMON_CHALLENGE_REWARD .. arg_16_1)
	end

	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.DEMON_CHALLENGE_REWARD .. arg_16_2)
end

function DemonChallengeMainView:StartUpdateTimer()
	self:StopUpdatTimer()
	self:RefreshTime()

	self.updateTimer_ = Timer.New(function()
		self:RefreshTime()
	end, 1, -1)

	self.updateTimer_:Start()
end

function DemonChallengeMainView:StopUpdatTimer()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end
end

function DemonChallengeMainView:OnEnter()
	if not self.activityId_ or self.params_.activityID ~= self.activityId_ then
		self.activityId_ = self.params_.activityID

		self:InitGo(DemonChallengeTools.GetMainUIName(self.params_.activityID))
		self:InitTree()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_OSIRIS_HEART_DEMON_CHALLENGE_DESCRIPE")
	self:StartUpdateTimer()
	self:RegisterRedPoint()

	if self.params_.childId then
		local var_20_0 = table.indexof(ActivityData:GetActivityData(self.activityId_).subActivityIdList, self.params_.childId)

		if var_20_0 then
			self.tree_:SelectGroup(var_20_0)
		end

		self.params_.childId = nil
	elseif self.curLevelIndex_ then
		self.tree_:SelectGroup(self.curLevelIndex_)
	else
		self.tree_:SelectGroup(1)
	end

	if self.isNeedExit_ then
		ShowTips("TIME_OVER")

		self.timer_ = Timer.New(function()
			JumpTools.Back()
		end, 0.2, 1)

		self.timer_:Start()
	end
end

function DemonChallengeMainView:OnExit()
	self:StopUpdatTimer()
	self:UnRegisterRedPoint()
	manager.windowBar:HideBar()
end

function DemonChallengeMainView:Dispose()
	DemonChallengeMainView.super.Dispose(self)
	self.tree_:Dispose()

	self.activityId_ = nil
end

return DemonChallengeMainView
