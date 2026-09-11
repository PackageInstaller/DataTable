local DemonChallengeView = class("DemonChallengeView", ReduxView)

function DemonChallengeView:UIName()
	return "UI/VersionUI/OsirisUI/OsirisDemonUI"
end

function DemonChallengeView:UIParent()
	return manager.ui.uiMain.transform
end

function DemonChallengeView:Init()
	self.inited = false
	self.curLevelIndex_ = self.params_.levelIndex
	self.levelCount_ = DemonChallengeData:GetLevelCount()
	self.levelControllers_ = {}
	self.lastOpenStatusList_ = {}

	for iter_3_0 = 1, self.levelCount_ do
		self.lastOpenStatusList_[iter_3_0] = false
	end

	self:InitUI()
	self:AddUIListener()

	self.inited = true
	self.tiemOut_ = false
end

function DemonChallengeView:InitUI()
	self:BindCfgUI()

	self.openTimeTextList_ = {}
	self.levelNameTextList_ = {}
	self.tree_ = LuaTree.New(self.treeGo_)

	self.tree_:SetSelectedHandler(handler(self, self.OnLevelSelect))
	self.tree_:SetRenderer(handler(self, self.LevelRenderer))

	local var_4_0 = UITreeData.New()

	for iter_4_0 = 1, self.levelCount_ do
		local var_4_1 = UITreeGroupData.New()

		var_4_1.id = iter_4_0
		var_4_1.text = "group" .. iter_4_0

		var_4_0.groupDatas:Add(var_4_1)
	end

	self.tree_:SetData(var_4_0)
end

function DemonChallengeView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_OSIRIS_HEART_DEMON_CHALLENGE_DESCRIPE")

	if self.curLevelIndex_ == nil then
		self.curLevelIndex_ = DemonChallengeData:GetCacheSelectLevelIndex() or DemonChallengeData:GetAnyOpen()
	end

	self:AddUpdateTimer()
	self:RefreshTime()
	self:RegisterRedPoint()
end

function DemonChallengeView:OnTop()
	if self.curLevelIndex_ == -1 then
		print("********** 没有一个关卡是开启的 ***************")
		self:Back()

		return
	end

	self.tree_:SelectGroup(self.curLevelIndex_)
end

function DemonChallengeView:OnLevelSelect(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if not self.inited then
		return
	end

	if not DemonChallengeData:IsOpened(arg_7_1) then
		local var_7_0, var_7_1 = GetTips("OPEN_TIME")

		manager.tips:ShowTips(string.format(var_7_0, manager.time:GetLostTimeStr((DemonChallengeData:GetLevelOpenTimeByIndex(arg_7_1)))), var_7_1)
		self.tree_:SelectGroup(self.curLevelIndex_)

		return
	end

	self:RefreshRewardRedPoint(self.curLevelIndex_, arg_7_1)
	DemonChallengeData:SaveSelectLevelIndex(arg_7_1)

	if DemonChallengeData:IsSelected(arg_7_1) == false and not self.tiemOut_ then
		DemonChallengeData:SaveSelected(arg_7_1)
	end

	self.curLevelIndex_ = arg_7_1

	self:RefreshUI()
end

function DemonChallengeView:LevelRenderer(arg_8_1, arg_8_2)
	self:BindCfgUI(arg_8_2)

	self.levelControllers_[arg_8_1] = ControllerUtil.GetController(arg_8_2.transform, "lock")

	self.levelControllers_[arg_8_1]:SetSelectedState("false")

	self.openTimeTextList_[arg_8_1] = self.openTimeText_
	self.levelNameTextList_[arg_8_1] = self.levelNameText_

	self:RefreshLevelName(arg_8_1)
end

function DemonChallengeView:AddUIListener()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if self.tiemOut_ then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("demonChallengeReward", {
			levelIndex = self.curLevelIndex_
		})
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		if self.tiemOut_ then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("/demonChallengeSelect", {
			levelIndex = self.curLevelIndex_
		})
	end)
end

function DemonChallengeView:RegisterRedPoint()
	for iter_12_0 = 1, self.levelCount_ do
		manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(iter_12_0), RedPointConst[DemonChallengeData:GetRedPointConst(iter_12_0)])
	end
end

function DemonChallengeView:UnRegisterRedPoint()
	for iter_13_0 = 1, self.levelCount_ do
		manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(iter_13_0), RedPointConst[DemonChallengeData:GetRedPointConst(iter_13_0)])
	end

	if self.curLevelIndex_ ~= -1 then
		manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst[DemonChallengeData:GetRedPointConst(self.curLevelIndex_)])
	end
end

function DemonChallengeView:RefreshRewardRedPoint(arg_14_1, arg_14_2)
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst[DemonChallengeData:GetRedPointConst(arg_14_1)])

	local var_14_0 = DemonChallengeData:GetRedPointConst(arg_14_2)

	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst[var_14_0])

	if not DemonChallengeData:IsCompletedLevel(arg_14_2) then
		manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst[var_14_0])
	end
end

function DemonChallengeView:RefreshUI()
	self:RefreshDescText()
	self:RefreshRoleImg()
end

function DemonChallengeView:RefreshRoleImg()
	self.roleImg_.sprite = DemonChallengeData:GetRoleImg(self.curLevelIndex_)

	self:AdaptImage()
end

function DemonChallengeView:AdaptImage()
	if self.roleImageAdaptor_ == nil then
		self.roleImageAdaptor_ = self:FindCom("AdaptImage", nil, self.roleImageTrs_)
	end

	self.roleImageAdaptor_:AdaptImg()
end

function DemonChallengeView:RefreshLevelName(arg_18_1)
	self.levelNameTextList_[arg_18_1].text = DemonChallengeData:GetLevelName(arg_18_1)
end

function DemonChallengeView:RefreshTime()
	local var_19_0 = DemonChallengeData:GetRemainTime()

	if var_19_0 - manager.time:GetServerTime() > 0 then
		self.remainTimeText_.text = manager.time:GetLostTimeStr(var_19_0)
	else
		DemonChallengeData:SetAllRedPoint(0)

		self.tiemOut_ = true
		self.remainTimeText_.text = GetTips("TIME_OVER")

		self:RemoveUpdatTimer()

		return
	end

	if self.levelControllers_ ~= nil then
		for iter_19_0, iter_19_1 in pairs(self.levelControllers_) do
			if self.lastOpenStatusList_[iter_19_0] == false then
				local var_19_1 = DemonChallengeData:GetLevelOpenTimeByIndex(iter_19_0)
				local var_19_2 = var_19_1 - manager.time:GetServerTime() <= 0

				if var_19_2 == true then
					iter_19_1:SetSelectedState("true")
					DemonChallengeData:CalcRedPoint()
				else
					self:RefreshOpenTimeText(iter_19_0, var_19_1)
				end

				self.lastOpenStatusList_[iter_19_0] = var_19_2
			end
		end
	end
end

function DemonChallengeView:RefreshOpenTimeText(arg_20_1, arg_20_2)
	self.openTimeTextList_[arg_20_1].text = string.format("%s后开启", manager.time:GetLostTimeStr(arg_20_2))
end

function DemonChallengeView:RefreshDescText()
	self.descText_.text = DemonChallengeData:GetDescText(self.curLevelIndex_)
end

function DemonChallengeView:AddUpdateTimer()
	self:RemoveUpdatTimer()

	self.updateTimer_ = Timer.New(function()
		self:RefreshTime()
	end, 1, -1)

	if self.updateTimer_ then
		self.updateTimer_:Start()
	end
end

function DemonChallengeView:RemoveUpdatTimer()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end
end

function DemonChallengeView:OnExit()
	self:RemoveUpdatTimer()
	self:UnRegisterRedPoint()
	manager.windowBar:HideBar()
end

function DemonChallengeView:Dispose()
	if self.tree_ then
		self.tree_:Dispose()

		self.tree_ = nil
	end

	DemonChallengeView.super.Dispose(self)
end

return DemonChallengeView
