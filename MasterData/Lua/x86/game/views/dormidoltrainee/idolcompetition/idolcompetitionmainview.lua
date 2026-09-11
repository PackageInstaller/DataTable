local IdolCompetitionMainView = class("IdolCompetitionMainView", ReduxView)

function IdolCompetitionMainView:UIName()
	return "Widget/BackHouseUI/Competition/IdolCompetitionMainUI"
end

function IdolCompetitionMainView:UIParent()
	return manager.ui.uiMain.transform
end

function IdolCompetitionMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IdolCompetitionMainView:InitUI()
	self:BindCfgUI()

	self.phaseItemList_ = {
		[3] = {},
		[4] = {},
		[5] = {}
	}

	for iter_4_0 = 1, 4 do
		table.insert(self.phaseItemList_[3], IdolCompetitionBattleItem.New(self["battle" .. iter_4_0 .. "Go_"]))
	end

	table.insert(self.phaseItemList_[4], IdolCompetitionBattleItem.New(self.battle5Go_))
	table.insert(self.phaseItemList_[4], IdolCompetitionBattleItem.New(self.battle6Go_))
	table.insert(self.phaseItemList_[5], IdolCompetitionBattleItem.New(self.battle7Go_))

	self.mainActivityID_ = 0
	self.raceActivityList_ = {}
	self.raceTime_ = {}
	self.secondStartTime_ = 0
	self.curRaceIndex_ = 0
	self.curRacePhase_ = 0
	self.myTakePartIn_ = nil
	self.phaseController_ = self.mainControllerEx_:GetController("phase")
	self.signController_ = self.mainControllerEx_:GetController("sign")
	self.championsMeController_ = self.mainControllerEx_:GetController("championsMe")
	self.raceSwitchController_ = self.mainControllerEx_:GetController("raceSwitch")
	self.race1TagController_ = self.mainControllerEx_:GetController("race1Tag")
	self.race2TagController_ = self.mainControllerEx_:GetController("race2Tag")
	self.hideRaceController_ = self.mainControllerEx_:GetController("hideRace")
end

function IdolCompetitionMainView:AddUIListener()
	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("idolCompetitionReward", {
			activity = self.mainActivityID_
		})
	end)
	self:AddBtnListener(self.trainBtn_, nil, function()
		JumpTools.OpenPageByJump("/idolTraineeTrain")
	end)
	self:AddBtnListener(self.signBtn_, nil, function()
		JumpTools.OpenPageByJump("/idolCompetitionSign", {
			activity = self.raceActivityList_[self.curRaceIndex_],
			index = self.curRaceIndex_
		})
	end)
	self:AddBtnListener(self.race1Btn_, nil, function()
		if self.curRaceIndex_ ~= 1 then
			IdolCompetitionData:TryToRequestNewPhaseData(self.raceActivityList_[1], function()
				self:RefreshPage(1)
			end)
		end
	end)
	self:AddBtnListener(self.race2Btn_, nil, function()
		if self.curRaceIndex_ ~= 2 then
			IdolCompetitionData:TryToRequestNewPhaseData(self.raceActivityList_[2], function()
				self:RefreshPage(2)
			end)
		end
	end)
	self:AddBtnListener(self.championsBtn_, nil, function()
		if curRacePhase_ == 5 then
			JumpTools.OpenPageByJump("idolCompetitionResult", {
				index = 1,
				phase = 5,
				activity = self.raceActivityList_[self.curRaceIndex_]
			})
		end
	end)
end

local var_0_1 = {
	"CamShootAtPos1",
	"CamShootAtPos2",
	"CamShootAtPos3",
	"CamShootAtPos4",
	"CamShootAtPos5"
}

function IdolCompetitionMainView:RestoreVCam()
	for iter_14_0, iter_14_1 in ipairs(var_0_1) do
		IdolTraineeCampBridge.SetVCamActive(iter_14_1, false)
	end

	if IdolTraineeCampBridge.cinemachineBrain.IsBlending then
		self:StartWaitCamBlend()
	end
end

function IdolCompetitionMainView:StartWaitCamBlend(arg_15_1)
	self:StopWaitCamBlend()
	SetActive(self.gameObject_, false)

	self.timer = Timer.New(function()
		if not IdolTraineeCampBridge.cinemachineBrain.IsBlending then
			self:StopWaitCamBlend()
			SetActive(self.gameObject_, true)

			if arg_15_1 then
				arg_15_1()
			end
		end
	end, 0.34, -1)

	self.timer:Start()
end

function IdolCompetitionMainView:StopWaitCamBlend()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function IdolCompetitionMainView:OnEnter()
	self:RestoreVCam()
	IdolTraineeCampBridge.SetVCamActive("CamShootAtCompetitionPos", true)
	IdolTraineeCampBridge.RemoveTrainingCharacter()

	self.mainActivityID_ = 2932801
	self.raceActivityList_ = ActivityCfg[self.mainActivityID_].sub_activity_list

	local var_18_0 = ActivityData:GetActivityData(self.raceActivityList_[2])

	if var_18_0 then
		self.secondStartTime_ = var_18_0.startTime
	end

	for iter_18_0 = 1, 2 do
		self.raceTime_[iter_18_0] = IdolCompetitionData:GetRaceRefreshTime(self.raceActivityList_[iter_18_0])

		local var_18_1 = IdolCompetitionData:GetRacePhase(self.raceActivityList_[iter_18_0])

		if not var_18_1 then
			self["race" .. iter_18_0 .. "TagController_"]:SetSelectedState("coming")
		elseif var_18_1 == 1 then
			self["race" .. iter_18_0 .. "TagController_"]:SetSelectedState("sign")
		elseif var_18_1 < 5 then
			self["race" .. iter_18_0 .. "TagController_"]:SetSelectedState("race")
		else
			self["race" .. iter_18_0 .. "TagController_"]:SetSelectedState("end")
		end
	end

	local var_18_2 = IdolCompetitionData:GetRacePhase(self.raceActivityList_[2])

	if var_18_2 and var_18_2 >= 1 then
		IdolCompetitionData:TryToRequestNewPhaseData(self.raceActivityList_[2], function()
			self:RefreshPage(2)
			self:AddTimer()
		end)
	else
		IdolCompetitionData:TryToRequestNewPhaseData(self.raceActivityList_[1], function()
			self:RefreshPage(1)
			self:AddTimer()
		end)
	end

	self:RegistEventListener(IDOL_COMPETITION_RACE_PHASE_UPDATE, handler(self, self.OnRacePhaseUpdate))
	manager.redPoint:bindUIandKey(self.signBtn_.transform, RedPointConst.ACTIVITY_IDOL_COMPETITION_SIGN)
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_IDOL_COMPETITION_REWARD)
end

function IdolCompetitionMainView:OnTop()
	self:RefreshBar()
end

function IdolCompetitionMainView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		ActivityTools.JumpBackToActivityMainViewByActivityID(self.mainActivityID_)
	end)
	manager.windowBar:RegistHomeCallBack(function()
		BackHomeTools:BackHomeGotoMain()
	end)
	manager.windowBar:SetGameHelpKey("IDOL_COMPETITION_MAIN_DESC")
end

function IdolCompetitionMainView:AddTimer()
	self:StopTimer()

	if self.raceTime_[self.curRaceIndex_] and manager.time:GetServerTime() <= self.raceTime_[self.curRaceIndex_][1] then
		self.signTimeText_.text = manager.time:GetLostTimeStrWith2Unit(self.raceTime_[self.curRaceIndex_][1]) .. GetTips("IDOL_COMPETITION_SIGN_TIME_TEXT")
	end

	if self.raceTime_[1] and manager.time:GetServerTime() <= self.raceTime_[1][1] then
		self.sign1TimeText_.text = manager.time:GetLostTimeStrWith2Unit(self.raceTime_[1][1]) .. GetTips("IDOL_COMPETITION_SIGN_TIME_TEXT")
	end

	if self.raceTime_[2] and manager.time:GetServerTime() <= self.raceTime_[2][1] then
		self.sign2TimeText_.text = manager.time:GetLostTimeStrWith2Unit(self.raceTime_[2][1]) .. GetTips("IDOL_COMPETITION_SIGN_TIME_TEXT")
	end

	if manager.time:GetServerTime() <= self.secondStartTime_ then
		self.sign2StartText_.text = manager.time:GetLostTimeStrWith2Unit(self.secondStartTime_) .. GetTips("IDOL_COMPETITION_START_TIME_TEXT")
	end

	self.remainTimer_ = Timer.New(function()
		if self.raceTime_[self.curRaceIndex_] and manager.time:GetServerTime() <= self.raceTime_[self.curRaceIndex_][1] then
			self.signTimeText_.text = manager.time:GetLostTimeStrWith2Unit(self.raceTime_[self.curRaceIndex_][1]) .. GetTips("IDOL_COMPETITION_SIGN_TIME_TEXT")
		end

		if self.raceTime_[1] and manager.time:GetServerTime() <= self.raceTime_[1][1] then
			self.sign1TimeText_.text = manager.time:GetLostTimeStrWith2Unit(self.raceTime_[1][1]) .. GetTips("IDOL_COMPETITION_SIGN_TIME_TEXT")
		end

		if self.raceTime_[2] and manager.time:GetServerTime() <= self.raceTime_[2][1] then
			self.sign2TimeText_.text = manager.time:GetLostTimeStrWith2Unit(self.raceTime_[2][1]) .. GetTips("IDOL_COMPETITION_SIGN_TIME_TEXT")
		end

		if manager.time:GetServerTime() <= self.secondStartTime_ then
			self.sign2StartText_.text = manager.time:GetLostTimeStrWith2Unit(self.secondStartTime_) .. GetTips("IDOL_COMPETITION_START_TIME_TEXT")
		end
	end, 1, -1)

	self.remainTimer_:Start()
end

function IdolCompetitionMainView:StopTimer()
	if self.remainTimer_ then
		self.remainTimer_:Stop()

		self.remainTimer_ = nil
	end
end

function IdolCompetitionMainView:RefreshPage(arg_28_1)
	self.curRaceIndex_ = arg_28_1
	self.curRacePhase_ = IdolCompetitionData:GetRacePhase(self.raceActivityList_[self.curRaceIndex_])
	self.myTakePartIn_ = IdolCompetitionData:CheckMeTakePartIn(self.raceActivityList_[self.curRaceIndex_])

	self.raceSwitchController_:SetSelectedState(tostring(arg_28_1))
	self.phaseController_:SetSelectedState(tostring(self.curRacePhase_))
	self.signController_:SetSelectedState(tostring(self.myTakePartIn_))

	if not self.myTakePartIn_ and self.curRacePhase_ > 1 then
		self.hideRaceController_:SetSelectedState("NotSignedUp")
		SetActive(self.myphaseGo_, false)

		return
	else
		self.hideRaceController_:SetSelectedState("normal")
	end

	if self.raceTime_[self.curRaceIndex_] then
		self.phase1TimeText_.text = manager.time:STimeDescS(self.raceTime_[self.curRaceIndex_][2], "!%m/%d %H:%M")
		self.phase2TimeText_.text = manager.time:STimeDescS(self.raceTime_[self.curRaceIndex_][3], "!%m/%d %H:%M")
		self.phase3TimeText_.text = manager.time:STimeDescS(self.raceTime_[self.curRaceIndex_][4], "!%m/%d %H:%M")
	end

	local var_28_0 = 3

	for iter_28_0, iter_28_1 in pairs(self.phaseItemList_) do
		for iter_28_2, iter_28_3 in ipairs(iter_28_1) do
			local var_28_1
			local var_28_2
			local var_28_3
			local var_28_4
			local var_28_5

			if iter_28_0 <= self.curRacePhase_ + 1 then
				var_28_1, var_28_2, var_28_3, var_28_4, var_28_5 = IdolCompetitionData:GetBattleInfo(self.raceActivityList_[self.curRaceIndex_], iter_28_0, iter_28_2)

				if var_28_1 and iter_28_0 > 3 then
					local var_28_6, var_28_7, var_28_8, var_28_9, var_28_10 = IdolCompetitionData:GetBattleInfo(self.raceActivityList_[self.curRaceIndex_], iter_28_0 - 1, iter_28_2 * 2 - 1)

					if var_28_7 then
						var_28_3 = var_28_10 == 1 and var_28_8 or var_28_9
					end

					local var_28_11, var_28_12, var_28_13, var_28_14, var_28_15 = IdolCompetitionData:GetBattleInfo(self.raceActivityList_[self.curRaceIndex_], iter_28_0 - 1, iter_28_2 * 2)

					if var_28_12 then
						var_28_4 = var_28_15 == 1 and var_28_13 or var_28_14
						var_28_1 = false
						var_28_2 = false
					end
				end
			else
				var_28_1 = true
			end

			iter_28_3:SetData(var_28_1, var_28_2, var_28_3, var_28_4, var_28_5, self.raceActivityList_[self.curRaceIndex_], function()
				if var_28_1 then
					return
				end

				if not var_28_2 then
					ShowTips("IDOL_COMPETITION_STAGE_WAITING")

					return
				end

				JumpTools.OpenPageByJump("idolCompetitionResult", {
					activity = self.raceActivityList_[self.curRaceIndex_],
					phase = iter_28_0,
					index = iter_28_2
				})
			end)

			if (var_28_3 == USER_ID or var_28_4 == USER_ID) and var_28_0 < iter_28_0 then
				var_28_0 = iter_28_0
			end

			if not var_28_1 and var_28_2 then
				if iter_28_0 == self.curRacePhase_ and getData("IdolCompetition", "battle_line_anim_" .. self.raceActivityList_[self.curRaceIndex_] .. "_" .. iter_28_0 .. "_" .. iter_28_2) ~= 1 then
					saveData("IdolCompetition", "battle_line_anim_" .. self.raceActivityList_[self.curRaceIndex_] .. "_" .. iter_28_0 .. "_" .. iter_28_2, 1)

					if var_28_5 == 1 then
						iter_28_3.line1Ani_:Play("line_up", -1, 0)
					elseif var_28_5 == 2 then
						iter_28_3.line2Ani_:Play("line_up", -1, 0)
					end
				elseif var_28_5 == 1 then
					iter_28_3.line1Ani_:Play("line_up", -1, 1)
				elseif var_28_5 == 2 then
					iter_28_3.line2Ani_:Play("line_up", -1, 1)
				end
			end

			if not var_28_1 then
				if iter_28_0 == self.curRacePhase_ + 1 and getData("IdolCompetition", "battle_player_anim_" .. self.raceActivityList_[self.curRaceIndex_] .. "_" .. iter_28_0 .. "_" .. iter_28_2) ~= 1 then
					saveData("IdolCompetition", "battle_player_anim_" .. self.raceActivityList_[self.curRaceIndex_] .. "_" .. iter_28_0 .. "_" .. iter_28_2, 1)
					iter_28_3.p1Ani_:Play("itemCompetitor", -1, 0)
					iter_28_3.p2Ani_:Play("itemCompetitor", -1, 0)
				else
					iter_28_3.p1Ani_:Play("itemCompetitor", -1, 1)
					iter_28_3.p2Ani_:Play("itemCompetitor", -1, 1)
				end
			end
		end
	end

	if self.myTakePartIn_ and self.curRacePhase_ > 1 then
		SetActive(self.myphaseGo_, true)

		self.myphaseText_.text = GetTips("IDOL_COMPETITION_PLAYER_PHASE_" .. var_28_0)
	else
		SetActive(self.myphaseGo_, false)
	end

	self.championsMeController_:SetSelectedState("false")

	if self.curRacePhase_ == 5 then
		local var_28_20, var_28_21, var_28_22, var_28_23, var_28_24 = IdolCompetitionData:GetBattleInfo(self.raceActivityList_[self.curRaceIndex_], 5, 1)
		local var_28_25 = IdolCompetitionData:GetRacePlayerInfo(self.raceActivityList_[self.curRaceIndex_], var_28_24 == 1 and var_28_22 or var_28_23)

		if (var_28_24 == 1 and var_28_22 or var_28_23) == USER_ID then
			self.championsMeController_:SetSelectedState("true")

			self.myphaseText_.text = GetTips("IDOL_COMPETITION_PLAYER_PHASE_CHAMPION")
		end

		if var_28_25.npc == 0 then
			self.championsImg_.sprite = ItemTools.getItemSprite(var_28_25.head)
		else
			self.championsImg_.spriteSync = "TextureConfig/BackHouseUI/IdolCompetitionNpcHead/" .. var_28_25.head
		end

		self.championsText_.text = var_28_25.name

		if getData("IdolCompetition", "battle_king_anim_" .. self.raceActivityList_[self.curRaceIndex_]) ~= 1 then
			saveData("IdolCompetition", "battle_king_anim_" .. self.raceActivityList_[self.curRaceIndex_], 1)
			self.kingAni_:Play("itemCompetitor_king_first", -1, 0)
		else
			self.kingAni_:Play("New State")
		end
	end
end

function IdolCompetitionMainView:OnRacePhaseUpdate()
	if self.curRaceIndex_ == 0 then
		return
	end

	local var_30_0 = manager.time:GetServerTime() < self.secondStartTime_ and 1 or 2

	IdolCompetitionData:TryToRequestNewPhaseData(self.raceActivityList_[manager.time:GetServerTime() < self.secondStartTime_ and 1 or 2], function()
		self:RefreshPage(var_30_0)

		self.raceTime_[var_30_0] = IdolCompetitionData:GetRaceRefreshTime(self.raceActivityList_[var_30_0])

		local var_31_0 = IdolCompetitionData:GetRacePhase(self.raceActivityList_[var_30_0])

		if not var_31_0 then
			self["race" .. var_30_0 .. "TagController_"]:SetSelectedState("coming")
		elseif var_31_0 == 1 then
			self["race" .. var_30_0 .. "TagController_"]:SetSelectedState("sign")
		elseif var_31_0 < 5 then
			self["race" .. var_30_0 .. "TagController_"]:SetSelectedState("race")
		else
			self["race" .. var_30_0 .. "TagController_"]:SetSelectedState("end")
		end
	end)
end

function IdolCompetitionMainView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
	self:StopWaitCamBlend()
	self:StopTimer()
	manager.redPoint:unbindUIandKey(self.signBtn_.transform, RedPointConst.ACTIVITY_IDOL_COMPETITION_SIGN)
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_IDOL_COMPETITION_REWARD)
end

function IdolCompetitionMainView:Dispose()
	self:StopWaitCamBlend()

	for iter_33_0, iter_33_1 in pairs(self.phaseItemList_) do
		for iter_33_2, iter_33_3 in ipairs(iter_33_1) do
			if iter_33_3 then
				iter_33_3:Dispose()
			end
		end

		iter_33_1 = nil
	end

	IdolCompetitionMainView.super.Dispose(self)
end

return IdolCompetitionMainView
