local SPHeroChallengeScheduleView = class("SPHeroChallengeScheduleView", ReduxView)

function SPHeroChallengeScheduleView:UIName()
	return "Widget/System/SPHeroChallenge/SPHeroChallengeScheduleUI"
end

function SPHeroChallengeScheduleView:UIParent()
	return manager.ui.uiMain.transform
end

function SPHeroChallengeScheduleView:OnCtor()
	return
end

function SPHeroChallengeScheduleView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SPHeroChallengeScheduleView:InitUI()
	self:BindCfgUI()

	self.curScheduleScroll = LuaList.New(handler(self, self.indexSchedule), self.uilistGo_, SPHeroChallengeScheduleStartItem)
	self.awardItme = CommonItemView.New(self.commonitemGo_1)
	self.btnController = self.controller:GetController("state")
end

function SPHeroChallengeScheduleView:OnEnter()
	self.data = SPHeroChallengeData:GetCurActivityInfo()
	self.scheduleStart = false

	self:RegisterEvents()
	self:InitCanChooseScheduleList()
	self:RefreshCanChooseScheduleList()
	self:RefreshHadChossScheduleList()
	self:RefreshDailyAwardInfo()
end

function SPHeroChallengeScheduleView:OnTop()
	self:RefreshBar()
	self:BindRedPonit()
end

function SPHeroChallengeScheduleView:BindRedPonit()
	return
end

function SPHeroChallengeScheduleView:UnBindRedPonit()
	return
end

function SPHeroChallengeScheduleView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function SPHeroChallengeScheduleView:OnExit()
	manager.windowBar:HideBar()
	self:UnBindRedPonit()
	self:RemoveAllEventListener()
end

function SPHeroChallengeScheduleView:AddUIListener()
	self:AddBtnListenerScale(self.autoBtn_, nil, function()
		if not self.scheduleStart then
			SPHeroChallengeTools:AutoChooseSchedule()
		end
	end)
	self:AddBtnListenerScale(self.confirmBtn_, nil, function()
		if self.hadChooseList and not self.scheduleStart then
			local var_14_0 = self.data:GetScheduleDailyList()

			for iter_14_0, iter_14_1 in ipairs(var_14_0) do
				if iter_14_1 == 0 then
					ShowTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_EMPTY")

					return
				end
			end

			if #var_14_0 < SpHeroChallengeConst.scheduleNum then
				ShowTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_EMPTY")

				return
			end

			SPHeroChallengeAction:ConfirmScheduleList(var_14_0)
		end
	end)
end

function SPHeroChallengeScheduleView:RegisterEvents()
	self:RegistEventListener(SP_HERO_CHALLENGE_SCHEDULE_CONFIRM, function()
		JumpTools.OpenPageByJump("/spHeroChallengeMainView")
		ShowTips("ACTIVITY_HERO_CHALLENGE_SET_SCHEDULE_SUCCESS")
	end)
	self:RegistEventListener(SP_HERO_CHALLENGE_SCHEDULE_CHANGE, function(arg_17_0)
		if arg_17_0 then
			self:RefreshCanChooseScheduleList()
			self:RefreshSingleScheduleState(arg_17_0)
		end
	end)
end

function SPHeroChallengeScheduleView:Dispose()
	if self.scheduleTypePool then
		for iter_18_0, iter_18_1 in pairs(self.scheduleTypePool) do
			iter_18_1:Dispose()
		end

		self.scheduleTypePool = nil
	end

	if self.curScheduleScroll then
		self.curScheduleScroll:Dispose()
	end

	if self.awardItme then
		self.awardItme:Dispose()
	end

	SPHeroChallengeScheduleView.super.Dispose(self)
end

function SPHeroChallengeScheduleView:InitCanChooseScheduleList()
	if not self.initFlag then
		self.initFlag = true
		self.schedulePool = {}
		self.scheduleTypePool = {}

		for iter_19_0, iter_19_1 in ipairs(ActivityHeroChallengeScheduleCfg.get_id_list_by_type) do
			self.scheduleTypePool[iter_19_0] = SPHeroChallengeScheduleTypeItem.New(self.typegroupGo_, self.contentTrs_, iter_19_0)
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
	end
end

function SPHeroChallengeScheduleView:RefreshHadChossScheduleList()
	local var_20_0 = self.data:GetScheduleDailyList()

	self.hadChooseList = {}

	for iter_20_0 = 1, SpHeroChallengeConst.scheduleNum do
		local var_20_1 = self.data:GetStartListScheduleInfoByList(iter_20_0)

		self.hadChooseList[iter_20_0] = var_20_0[iter_20_0] and var_20_0[iter_20_0] ~= 0 and {
			scheduleID = var_20_0[iter_20_0],
			index = iter_20_0,
			isFinish = var_20_1 and var_20_1.isFinish
		} or {
			index = iter_20_0
		}
	end

	self.curScheduleScroll:StartScroll(#self.hadChooseList)
	self:RefreshConfirmBtnState()
end

function SPHeroChallengeScheduleView:RefreshDailyAwardInfo()
	local var_21_0 = ActivityHeroChallengeCfg[SPHeroChallengeData:GetActivityID()].daily_award[1]

	self.awardItme:SetData({
		id = var_21_0[1],
		number = var_21_0[2],
		clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id
			})
		end
	})
end

function SPHeroChallengeScheduleView:RefreshCanChooseScheduleList()
	if self.scheduleTypePool then
		for iter_23_0, iter_23_1 in ipairs(self.scheduleTypePool) do
			iter_23_1:RefreshUI()
		end
	end
end

function SPHeroChallengeScheduleView:indexSchedule(arg_24_1, arg_24_2)
	if not self.scheduleStart then
		arg_24_2:RefreshUI(self.hadChooseList[arg_24_1])
		arg_24_2:RegisterCancelCallBack(function()
			self:RefreshSingleScheduleState(arg_24_1)
		end)
	end
end

function SPHeroChallengeScheduleView:RefreshConfirmBtnState()
	local var_26_0 = self.data:GetScheduleDailyList()
	local var_26_1 = true

	for iter_26_0 = 1, SpHeroChallengeConst.scheduleNum do
		if var_26_0 and var_26_0[iter_26_0] and var_26_0[iter_26_0] ~= 0 then
			-- block empty
		else
			var_26_1 = false

			break
		end
	end

	if var_26_1 then
		self.btnController:SetSelectedState("normal")
	else
		self.btnController:SetSelectedState("unusable")
	end
end

function SPHeroChallengeScheduleView:RefreshSingleScheduleState(arg_27_1)
	local var_27_0 = self.data:GetScheduleDailyList()

	self.curScheduleScroll:GetItemByIndex(arg_27_1):RefreshUI(var_27_0[arg_27_1] and var_27_0[arg_27_1] ~= 0 and {
		scheduleID = var_27_0[arg_27_1],
		index = arg_27_1
	} or {
		index = arg_27_1
	})
	self:RefreshConfirmBtnState()
end

return SPHeroChallengeScheduleView
