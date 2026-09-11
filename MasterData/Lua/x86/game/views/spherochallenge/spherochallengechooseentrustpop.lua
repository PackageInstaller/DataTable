local SPHeroChallengeChooseEntrustPop = class("SPHeroChallengeChooseEntrustPop", ReduxView)

function SPHeroChallengeChooseEntrustPop:UIName()
	return "Widget/System/SPHeroChallenge/SPHeroChallengeEntrustPop"
end

function SPHeroChallengeChooseEntrustPop:UIParent()
	return manager.ui.uiPop.transform
end

function SPHeroChallengeChooseEntrustPop:OnCtor()
	return
end

function SPHeroChallengeChooseEntrustPop:Init()
	self:InitUI()
	self:AddUIListener()
end

function SPHeroChallengeChooseEntrustPop:InitUI()
	self:BindCfgUI()

	self.canChooseEntrustScroll = LuaList.New(handler(self, self.indexCanEntrust), self.uilistGo_, SPHeroChallengeEntrustItem)
	self.refreshTimeController = self.descController:GetController("refreshState")
end

function SPHeroChallengeChooseEntrustPop:OnEnter()
	self.activityInfo = SPHeroChallengeData:GetCurActivityInfo()
	self.activityID = SPHeroChallengeData:GetActivityID()

	self:RefreshOpenPage()
	self:RegisterEvents()
end

function SPHeroChallengeChooseEntrustPop:OnTop()
	return
end

function SPHeroChallengeChooseEntrustPop:OnExit()
	self:RemoveAllEventListener()
end

function SPHeroChallengeChooseEntrustPop:OnExit()
	return
end

function SPHeroChallengeChooseEntrustPop:AddUIListener()
	self:AddBtnListener(self.backMaskbtn, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.refreshBtn_, nil, function()
		if GameSetting.activity_hero_challenge_task_refresh_num.value[1] <= self.activityInfo.entrustTime then
			return
		end

		if self.activityInfo:GetRefreshFreeEntrustTime() <= 0 and CurrencyData:GetCurrencyNum(SPHeroChallengeData.activityCfg[self.activityID].refreshEntrustCost[1][1]) < SPHeroChallengeData.activityCfg[self.activityID].refreshEntrustCost[1][2] then
			ShowTips(GetTips("ACTIVITY_HERO_CHALLENGE_REFRESH_LACK"))

			return
		end

		SPHeroChallengeAction:RefreshEntrustList()
	end)
end

function SPHeroChallengeChooseEntrustPop:RegisterEvents()
	self:RegistEventListener(SP_HERO_CHALLENGE_REFRESH_ENTRUST, function()
		self:RefreshOpenPage()
	end)
	self:RegistEventListener(SP_HERO_CHALLENGE_START_ENTRUST, function()
		self:RefreshOpenPage()
	end)
end

function SPHeroChallengeChooseEntrustPop:Dispose()
	if self.canChooseEntrustScroll then
		self.canChooseEntrustScroll:Dispose()
	end

	SPHeroChallengeChooseEntrustPop.super.Dispose(self)
end

function SPHeroChallengeChooseEntrustPop:RefreshCanChooseEntrustList()
	self.canChooseList = {}

	if self.activityInfo then
		self.canChooseList = self.activityInfo.waitEntrustList or {}
	end

	self.canChooseEntrustScroll:StartScroll(#self.canChooseList)
end

function SPHeroChallengeChooseEntrustPop:indexCanEntrust(arg_18_1, arg_18_2)
	arg_18_2:RefreshUI({
		index = arg_18_1,
		id = self.canChooseList[arg_18_1]
	})
end

function SPHeroChallengeChooseEntrustPop:RefreshOpenPage()
	self:RefreshCanChooseEntrustList()

	local var_19_0 = self.activityInfo:GetRefreshFreeEntrustTime()

	if var_19_0 > 0 then
		self.refreshTimeController:SetSelectedState("free")

		self.freetextText_.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_ENTRUST_FREE_REFRESH"), var_19_0, GameSetting.activity_hero_challenge_task_free_refresh_num.value[1])
	elseif self.activityInfo:GetRefreshTotalEntrustTime() > 0 then
		self.refreshTimeController:SetSelectedState("charge")

		self.curiconImg_.sprite = ItemTools.getItemSprite(SPHeroChallengeData.activityCfg[self.activityID].refreshEntrustCost[1][1])
		self.freetextText_.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_REFRESH_NEED"), SPHeroChallengeData.activityCfg[self.activityID].refreshEntrustCost[1][2])
	else
		self.refreshTimeController:SetSelectedState("none")

		self.freetextText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_REFRESH_NONE")
	end
end

return SPHeroChallengeChooseEntrustPop
