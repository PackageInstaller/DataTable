local ArtifactLevelView = class("ArtifactLevelView", ReduxView)

function ArtifactLevelView:UIName()
	return "UI/VersionUI/SummerUI/SummeDivinepersonalitytwoUI"
end

function ArtifactLevelView:UIParent()
	return manager.ui.uiMain.transform
end

function ArtifactLevelView:Ctor()
	self.itemControllers_ = {}
	self.openTimeTextList_ = {}
	self.curAwardsList_ = {}
	self.isInit_ = false
	self.isFirstIn_ = true
	self.activityId_ = ActivityConst.SUMMER_ARTIFACT
end

function ArtifactLevelView:Init()
	self.curLevelIndex_ = ArtifactLevelData:GetCurLevelIndex()
	self.levelCount_ = ArtifactLevelData:GetLevelCount()

	self:InitUI()
	self:AddUIListener()
end

function ArtifactLevelView:InitUI()
	self:BindCfgUI()

	self.awardList_ = LuaList.New(handler(self, self.AwardIndexItem), self.listGo_, CommonItem)
	self.tree_ = LuaTree.New(self.treeGo_)

	self.tree_:SetSelectedHandler(handler(self, self.OnLevelSelect))
	self.tree_:SetRenderer(handler(self, self.ItemRander))

	local var_5_0 = UITreeData.New()

	var_5_0.defaultIndex = ArtifactLevelData:GetCurLevelIndex() - 1

	for iter_5_0 = 1, self.levelCount_ do
		local var_5_1 = UITreeGroupData.New()

		var_5_1.id = iter_5_0
		var_5_1.text = ArtifactLevelData:GetLevelNameByIndex(iter_5_0)

		var_5_0.groupDatas:Add(var_5_1)
	end

	self.tree_:SetData(var_5_0)
end

function ArtifactLevelView:OnEnter()
	if self.isInit_ then
		self.curLevelIndex_ = ArtifactLevelData:GetCurLevelIndex()

		self:UpdateUI()

		self.timer_ = Timer.New(function()
			for iter_7_0 = 1, ArtifactLevelData:GetLevelCount() do
				if ArtifactLevelData:GetIsOpenByIndex(iter_7_0) then
					if ArtifactLevelData:GetIsAwardedByIndex(iter_7_0) then
						self.itemControllers_[iter_7_0]:SetSelectedState("get")
					else
						self.itemControllers_[iter_7_0]:SetSelectedState("unlock")
					end
				else
					self.itemControllers_[iter_7_0]:SetSelectedState("lock")

					self.openTimeTextList_[iter_7_0].text = ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(iter_7_0)).stopTime < manager.time:GetServerTime() and string.format(GetTips("TIME_OVER")) or string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(iter_7_0)).startTime)))
				end
			end
		end, 1, -1)

		self.timer_:Start()
		self:RegisterRedPoint()
	end
end

function ArtifactLevelView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SUMMER_ARTIFACT_DESCRIPE")
end

function ArtifactLevelView:OnExit()
	if self.timer_ then
		self.timer_:Stop()
	end

	manager.windowBar:HideBar()
	self:UnRegisterRedPoint()
end

function ArtifactLevelView:Dispose()
	if self.tree_ then
		self.tree_:Dispose()

		self.tree_ = nil
	end

	if self.awardList_ then
		self.awardList_:Dispose()

		self.awardList_ = nil
	end

	self.super.Dispose(self)
end

function ArtifactLevelView:OnLevelSelect(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if ArtifactLevelData:GetIsOpenByIndex(arg_11_1) then
		self.curLevelIndex_ = arg_11_1

		ArtifactLevelData:SetCurLevelIndex(arg_11_1)
		ArtifactLevelData:SetSelectedByIndex(arg_11_1)
		self:UpdateUI()
		ArtifactLevelData:UpdateRedPoint()
	elseif arg_11_1 ~= self.curLevelIndex_ then
		self.tree_:SelectGroup(self.curLevelIndex_)

		if ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(arg_11_1)).stopTime < manager.time:GetServerTime() then
			ShowTips(GetTips("TIME_OVER"))
		else
			ShowTips(string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(arg_11_1)).startTime))))
		end
	end
end

function ArtifactLevelView:ItemRander(arg_12_1, arg_12_2)
	self:BindCfgUI(arg_12_2)

	self.itemControllers_[arg_12_1] = ControllerUtil.GetController(arg_12_2.transform, "lock")

	if ArtifactLevelData:GetIsAwardedByIndex(arg_12_1) then
		self.itemControllers_[arg_12_1]:SetSelectedState("get")
	elseif ArtifactLevelData:GetIsOpenByIndex(arg_12_1) then
		self.itemControllers_[arg_12_1]:SetSelectedState("unlock")
	end

	self.openTimeTextList_[arg_12_1] = self.openTimeText_
	self.openTimeTextList_[arg_12_1].text = ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(arg_12_1)).stopTime < manager.time:GetServerTime() and string.format(GetTips("TIME_OVER")) or string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(arg_12_1)).startTime)))
	self.levelNumText_.text = "0" .. arg_12_1
	self.isInit_ = true
end

function ArtifactLevelView:AddUIListener()
	self:AddBtnListener(self.btnStart_, nil, function()
		if ArtifactLevelData:GetIsOpenByIndex(self.curLevelIndex_) then
			self:Go("/sectionSelectHero", {
				section = ActivityArtifactLevelCfg[ArtifactLevelData:GetLevelIdByIndex(self.curLevelIndex_)].stage_id,
				sectionType = BattleConst.STAGE_TYPE_NEW.ARTIFACT,
				activityID = ActivityConst.SUMMER_ARTIFACT
			})
		elseif ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(self.curLevelIndex_)).stopTime < manager.time:GetServerTime() then
			ShowTips(GetTips("TIME_OVER"))
		else
			ShowTips(string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(self.curLevelIndex_)).startTime))))
		end
	end)
end

function ArtifactLevelView:UpdateUI()
	if self.isInit_ then
		self.levelNameText_.text = ArtifactLevelData:GetLevelNameByIndex(self.curLevelIndex_)
		self.descText_.text = ArtifactLevelData:GetLevelDesc(self.curLevelIndex_)
		self.curAwardsList_ = getRewardFromDropCfg(ArtifactLevelData:GetAwardListByIndex(self.curLevelIndex_), true)

		self.awardList_:StartScroll(#self.curAwardsList_)
		ArtifactLevelData:UpdateRedPoint()
	end
end

function ArtifactLevelView:AwardIndexItem(arg_16_1, arg_16_2)
	arg_16_2:RefreshData(rewardToItemTemplate(self.curAwardsList_[arg_16_1]))

	local var_16_0 = ControllerUtil.GetController(arg_16_2.transform_, "received")

	if ArtifactLevelData:GetIsAwardedByIndex(self.curLevelIndex_) then
		var_16_0:SetSelectedState("true")
	else
		var_16_0:SetSelectedState("false")
	end

	arg_16_2:RegistCallBack(function(arg_17_0)
		ShowPopItem(POP_ITEM, arg_17_0)
	end)
end

function ArtifactLevelView:RegisterRedPoint()
	for iter_18_0 = 1, ArtifactLevelData:GetLevelCount() do
		manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(iter_18_0), string.format("%s_%s", RedPointConst.ARTIFACT, ArtifactLevelData:GetLevelIdByIndex(iter_18_0)))
	end
end

function ArtifactLevelView:UnRegisterRedPoint()
	for iter_19_0 = 1, ArtifactLevelData:GetLevelCount() do
		manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(iter_19_0), string.format("%s_%s", RedPointConst.ARTIFACT, ArtifactLevelData:GetLevelIdByIndex(iter_19_0)))
	end
end

return ArtifactLevelView
