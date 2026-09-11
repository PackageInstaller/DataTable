SectionBaseView = import("game.views.sectionInfo.SectionInfoBaseView")

local SPKailiTugSectionView = class("SPKailiTugSectionView", SectionBaseView)

function SPKailiTugSectionView:Init()
	SPKailiTugSectionView.super.Init(self)
	self.hideStageDescController_:SetSelectedState("true")

	self.sectionInfoThreeStarBar_ = SectionInfoThreeStarBar.New(self.threeStarGo_)

	self.hideFatigueController_:SetSelectedState("close")
end

function SPKailiTugSectionView:RefreshRewardItem(arg_2_1, arg_2_2)
	local var_2_0

	if self.rewardList_[arg_2_1] then
		var_2_0 = rewardToItemTemplate(self.rewardList_[arg_2_1])
		var_2_0.number = self.rewardList_[arg_2_1].number or 0

		function var_2_0:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id
			})
		end
	end

	var_2_0.completedFlag = self.isStageCleared

	arg_2_2:SetData(var_2_0)
end

function SPKailiTugSectionView:UIName()
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/KaliChapterSectionInfoUI"
end

function SPKailiTugSectionView:AddListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		self:Back()
		self:OnClickBtn()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function SPKailiTugSectionView:OnEnter()
	SPKailiTugSectionView.super.OnEnter(self)
end

function SPKailiTugSectionView:RefreshTitleDesc()
	return
end

function SPKailiTugSectionView:UpdateBar()
	return
end

function SPKailiTugSectionView:RefreshUI()
	self.hideThreeStarController_:SetSelectedState("false")
	self:RefreshReward()

	if self.lock_ then
		self.btnLockText_.text = self.lockTips_

		self.btnController_:SetSelectedState("true")
	else
		self.btnController_:SetSelectedState("false")
	end
end

function SPKailiTugSectionView:HaveCostCntFlag()
	return false
end

function SPKailiTugSectionView:RefreshData()
	local var_13_1 = ActivityKaliGameStageCfg[self.params_.stageID or 0]

	self.sectionName_.text = ActivityKaliGameStageCfg[self.params_.stageID or 0] and var_13_1.name

	local var_13_2 = TugGameData:GetStageData(self.params_.activityID, self.params_.stageID)

	self.isStageCleared = var_13_2
	self.cost_ = 0
	self.lock_ = not self.params_.lock

	if not ActivityData:GetActivityIsOpen(var_13_1.activity_id) then
		local var_13_3 = ActivityData:GetActivityData(var_13_1.activity_id)

		self.lockTips_ = var_13_3 and var_13_3.startTime and self.params_.prePass and string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(var_13_3.startTime)) or GetTips("ERROR_ACTIVITY_ZM_GAME_PRE_MISSION_UNLOCK")
	else
		self.lockTips_ = GetTips("ERROR_ACTIVITY_ZM_GAME_PRE_MISSION_UNLOCK")
	end

	self.threeStarDataList_ = {
		{
			var_13_2,
			{
				8
			}
		},
		{
			false
		},
		{
			false
		}
	}

	self.sectionInfoThreeStarBar_:SetData(self.threeStarDataList_)
end

function SPKailiTugSectionView:OnClickBtn()
	DormMinigame.Launch("HZ07_jiali2", TugGameBridge, {
		activityID = self.params_.activityID,
		stageID = self.params_.stageID
	})
end

function SPKailiTugSectionView:Dispose()
	SPKailiTugSectionView.super.Dispose(self)
	self.sectionInfoThreeStarBar_:Dispose()

	self.sectionInfoThreeStarBar_ = nil
end

function SPKailiTugSectionView:RefreshReward()
	local var_16_0 = self.params_.stageID or 0
	local var_16_1

	if ActivityKaliGameStageCfg[var_16_0] then
		var_16_1 = ActivityKaliGameStageCfg[var_16_0].reward or {}
	end

	self.rewardList_ = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		table.insert(self.rewardList_, (rewardToItemTemplate(formatReward(iter_16_1))))
	end

	local var_16_2 = self.rewardList_

	self.rewardTitleText_.text = GetTips("FIRST_DROP")

	if #var_16_2 > 0 and not self.isStageCleared then
		self.hideDropPanelController_:SetSelectedState("tru")
	else
		self.hideDropPanelController_:SetSelectedState("true")
	end

	self.uiList_:StartScroll(#var_16_2)
end

return SPKailiTugSectionView
