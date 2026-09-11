local ActivitySummerSwimsuitPreheatStageView = class("ActivitySummerSwimsuitPreheatStageView", ReduxView)

function ActivitySummerSwimsuitPreheatStageView:UIName()
	return "Widget/Version/Alone_SummerUI_PreheatUI/Alone_SummerUI_PreheatPopUI"
end

function ActivitySummerSwimsuitPreheatStageView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivitySummerSwimsuitPreheatStageView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivitySummerSwimsuitPreheatStageView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, CommonItemView)
	self.stateController_ = self.conEx_:GetController("state")
end

function ActivitySummerSwimsuitPreheatStageView:AddUIListener()
	self:AddBtnListener(self.playBtn_, nil, function()
		self:OnClickPlayBtn()
	end)
	self:AddBtnListener(self.finPlayBtn_, nil, function()
		return
	end)
	self:AddBtnListener(self.getBtn_, nil, function()
		self:OnClickGetBtn()
	end)
	self:AddBtnListener(self.closeBtn_, nil, function()
		if self.isAniPlaying_ then
			return
		end

		self:Back()
	end)
end

function ActivitySummerSwimsuitPreheatStageView:OnEnter()
	manager.windowBar:HideBar()

	self.cfgId_ = self.params_.cfgId

	local var_10_0 = ActivitySummerSwimsuitPreheatTools.GetCfgMainActivityId(ActivitySummerSwimsuitPreheatCfg[self.cfgId_])

	SetActive(self.shutterAni_.gameObject, false)
	self:RefreshUI()
end

function ActivitySummerSwimsuitPreheatStageView:OnExit()
	local var_11_0 = ActivitySummerSwimsuitPreheatTools.GetCfgMainActivityId(ActivitySummerSwimsuitPreheatCfg[self.cfgId_])

	AnimatorTools.Stop()
end

function ActivitySummerSwimsuitPreheatStageView:IndexItem(arg_12_1, arg_12_2)
	self.itemList_[arg_12_1].clickFun = function(self)
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	arg_12_2:SetData(self.itemList_[arg_12_1])
end

function ActivitySummerSwimsuitPreheatStageView:RefreshUI()
	local var_14_0 = ActivitySummerSwimsuitPreheatCfg[self.cfgId_]
	local var_14_2 = ActivitySummerSwimsuitPreheatTools.GetCfgMainActivityId(ActivitySummerSwimsuitPreheatCfg[self.cfgId_])
	local var_14_3 = ActivitySummerSwimsuitPreheatTools.GetCfgStageImage(ActivitySummerSwimsuitPreheatCfg[self.cfgId_])

	self.isStageClear_ = ActivitySummerSwimsuitPreheatData.IsStageClear(var_14_2, ActivitySummerSwimsuitPreheatCfg[self.cfgId_].id)
	self.isRewardGot_ = ActivitySummerSwimsuitPreheatData.IsGotStageReward(var_14_2, var_14_0.id)

	if self.isStageClear_ then
		self.stateController_:SetSelectedState(self.isRewardGot_ and "finished" or "get")
	else
		self.stateController_:SetSelectedState("play")
	end

	self.itemList_ = {}

	for iter_14_0, iter_14_1 in pairs(var_14_0.reward_list) do
		local var_14_4 = clone(ItemTemplateData)

		var_14_4.id = iter_14_1[1]
		var_14_4.number = iter_14_1[2]
		var_14_4.completedFlag = self.isRewardGot_

		table.insert(self.itemList_, var_14_4)
	end

	self.img_.sprite = var_14_3
	self.text1_.text = var_14_0.preview_desc
	self.text2_.text = var_14_0.comment_desc

	self.uiList_:StartScroll(#self.itemList_, 1)
end

function ActivitySummerSwimsuitPreheatStageView:OnClickPlayBtn()
	if self.isAniPlaying_ then
		return
	end

	self:PlayEffects(function()
		self:Back()
		JumpTools.GoToSystem("/activitySummerSwimsuitPreheatGame", {
			cfgId = self.cfgId_
		})
	end)
end

function ActivitySummerSwimsuitPreheatStageView:PlayEffects(arg_17_1)
	self.isAniPlaying_ = true

	SetActive(self.shutterAni_.gameObject, true)
	AnimatorTools.PlayAnimationWithCallback(self.shutterAni_, "shutter_01_enter", function()
		self.isAniPlaying_ = false

		arg_17_1()
	end)
end

function ActivitySummerSwimsuitPreheatStageView:OnClickGetBtn()
	local var_19_0 = ActivitySummerSwimsuitPreheatTools.GetCfgMainActivityId(ActivitySummerSwimsuitPreheatCfg[self.cfgId_])

	ActivitySummerSwimsuitPreheatAction.GetStageReward(var_19_0, ActivitySummerSwimsuitPreheatCfg[self.cfgId_].id, function(arg_20_0, arg_20_1, arg_20_2)
		ActivitySummerSwimsuitPreheatAction.UpdateRedPoint(var_19_0)
		getReward(arg_20_2, nil, function()
			self:RefreshUI()
		end)
	end)
end

function ActivitySummerSwimsuitPreheatStageView:OnExitInput()
	self:Back()

	return true
end

function ActivitySummerSwimsuitPreheatStageView:Back()
	self.isAniPlaying_ = false

	ActivitySummerSwimsuitPreheatStageView.super.Back(self)
end

function ActivitySummerSwimsuitPreheatStageView:Dispose()
	self.uiList_:Dispose()
	ActivitySummerSwimsuitPreheatStageView.super.Dispose(self)
end

return ActivitySummerSwimsuitPreheatStageView
