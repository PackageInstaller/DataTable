local ZumaMainStageItem = class("ZumaMainStageItem", ReduxView)
local var_0_1 = {
	progressState = {
		star1 = "state2",
		name = "Progress",
		star2 = "state3",
		noShow = "state0",
		star0 = "state1",
		star3 = "state4"
	},
	selectState = {
		onSelect = "state1",
		name = "sel",
		unSelect = "state0"
	},
	stateState = {
		unComplete = "state2",
		name = "state",
		lock = "state0",
		normal = "state1"
	},
	rankState = {
		state2 = "state2",
		name = "rank",
		state1 = "state1",
		noShow = "no"
	},
	lineState = {
		normalColor = Color(0.611764705882353, 0.7372549019607844, 0.788235294117647, 1),
		lockColor = Color(0.7137254901960784, 0.7764705882352941, 0.8, 0.4)
	}
}
local var_0_2 = {
	UnComplete = 3,
	UnLock = 1,
	Complete = 2
}

function ZumaMainStageItem:SetRedState(arg_1_1)
	if arg_1_1 then
		manager.redPoint:bindUIandKey(self.stageitemBtn_.transform, string.format("%s_%s", RedPointConst.ZUMA_OPEN, self.levelCfg.activity_id))
	else
		manager.redPoint:unbindUIandKey(self.stageitemBtn_.transform, string.format("%s_%s", RedPointConst.ZUMA_OPEN, self.levelCfg.activity_id))
	end
end

function ZumaMainStageItem:OnCtor(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.index = arg_2_4
	self.gameObject_ = arg_2_1
	self.levelCfg = arg_2_3
	self.levelID = arg_2_3.id
	self.difficultType = arg_2_3.difficult

	self:InitUI()
end

function ZumaMainStageItem:InitUI()
	self:BindCfgUI()

	self.progressController = self.controllerexcollection_:GetController(var_0_1.progressState.name)
	self.selectController = self.controllerexcollection_:GetController(var_0_1.selectState.name)
	self.stateController = self.controllerexcollection_:GetController(var_0_1.stateState.name)
	self.rankController = self.controllerexcollection_:GetController(var_0_1.rankState.name)

	self:AddBtnListener(self.stageitemBtn_, nil, function()
		manager.notify:CallUpdateFunc(ZUMA_SELECT_CHAPTER, self.index)
	end)

	self.nameText_.text = self.levelCfg.name
end

function ZumaMainStageItem:RefreshUi()
	if self.rankNumTxt_ then
		self.rankNumTxt_.text = ZumaData:GetZumaStageScore(self.levelID) or 0
	end

	self:UpdateStageState()
end

function ZumaMainStageItem:GetLevelCfg()
	return self.levelCfg
end

function ZumaMainStageItem:UpdateSelectState(arg_7_1)
	self.selectController:SetSelectedState((arg_7_1 or nil) and (var_0_1.selectState.onSelect or var_0_1.selectState.unSelect))
end

function ZumaMainStageItem:UpdateStageState()
	local var_8_0 = ActivityData:GetActivityData(ActivityZumaLevelCfg[self.levelID].activity_id)

	if var_8_0 and var_8_0:IsActivitying() then
		if ZumaData:GetZumaStageScore(self.levelID) then
			self:CheckStageState(var_0_2.Complete)
		elseif ZumaData:GetZumaBeforeIsFinish(self.levelID) then
			self:CheckStageState(var_0_2.UnComplete)
		else
			self:CheckStageState(var_0_2.UnLock)
		end
	else
		self:CheckStageState(var_0_2.UnLock)
	end
end

function ZumaMainStageItem:CheckStageState(arg_9_1)
	self.stageState = arg_9_1

	self:ChangeLockState()
	self:ChangeProgressState()
	self:ChangeRankState()
end

function ZumaMainStageItem:ChangeLockState()
	if self.stageState == var_0_2.UnLock then
		self.stateController:SetSelectedState(var_0_1.stateState.lock)
	elseif self.stageState == var_0_2.Complete then
		self.stateController:SetSelectedState(var_0_1.stateState.normal)
	elseif self.stageState == var_0_2.UnComplete then
		self.stateController:SetSelectedState(var_0_1.stateState.unComplete)
	end
end

function ZumaMainStageItem:ChangeProgressState()
	if self.stageState == var_0_2.UnLock or self.difficultType == ZumaConst.ZUMA_DIFFICULT.NIGHT then
		self.progressController:SetSelectedState(var_0_1.progressState.noShow)
	elseif self.stageState == var_0_2.Complete then
		local var_11_0 = self:GetFinishConditionNums()

		if var_11_0 == 1 then
			self.progressController:SetSelectedState(var_0_1.progressState.star1)
		elseif var_11_0 == 2 then
			self.progressController:SetSelectedState(var_0_1.progressState.star2)
		elseif var_11_0 == 3 then
			self.progressController:SetSelectedState(var_0_1.progressState.star3)
		elseif var_11_0 == 0 then
			self.progressController:SetSelectedState(var_0_1.progressState.star0)
		end
	elseif self.stageState == var_0_2.UnComplete then
		self.progressController:SetSelectedState(var_0_1.progressState.star0)
	end
end

function ZumaMainStageItem:ChangeRankState()
	if not self.rankController then
		return
	end

	if self.difficultType ~= ZumaConst.ZUMA_DIFFICULT.NIGHT then
		self.rankController:SetSelectedState(var_0_1.rankState.noShow)

		return
	end

	if self.stageState == var_0_2.UnLock then
		self.rankController:SetSelectedState(var_0_1.rankState.noShow)
	elseif self.stageState == var_0_2.Complete then
		self.rankController:SetSelectedState(var_0_1.rankState.state2)
	elseif self.stageState == var_0_2.UnComplete then
		self.rankController:SetSelectedState(var_0_1.rankState.state1)
	end
end

function ZumaMainStageItem:GetFinishConditionNums()
	local var_13_0 = ZumaData:GetZumaStageScore(self.levelID)
	local var_13_1 = 0

	for iter_13_0, iter_13_1 in pairs(self.levelCfg.activity_point_reward or {}) do
		if var_13_0 >= ActivityPointRewardCfg[iter_13_1].need then
			var_13_1 = var_13_1 + 1
		end
	end

	return var_13_1
end

function ZumaMainStageItem:Dispose()
	ZumaMainStageItem.super.Dispose(self)
end

return ZumaMainStageItem
