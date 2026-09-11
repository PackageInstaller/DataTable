local MoonBoView = class("MoonBoView", ReduxView)

function MoonBoView:UIName()
	return "UI/VolumeIIIUI/VolumeBocakeMainUI"
end

function MoonBoView:UIParent()
	return manager.ui.uiMain.transform
end

function MoonBoView:Init()
	self:InitUI()
	self:AddUIListeners()
	self:AddEventListeners()
end

function MoonBoView:InitUI()
	self:BindCfgUI()

	self.isShowDiceController_ = ControllerUtil.GetController(self.transform_, "IsShowDice")
	self.isShowDice_ = false
	self.IsAniSelfPlay_ = false
	self.todices_ = {}
	self.activedice1_ = nil
	self.activedice2_ = nil
	self.activedice3_ = nil
	self.activedice4_ = nil
	self.activedice5_ = nil
	self.activedice6_ = nil
end

function MoonBoView:AddUIListeners()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if self.isShowDice_ == false then
			JumpTools.OpenPageByJump("moonBoRewardView", {
				activityId = self.activityID_
			})
		end
	end)
	self:AddBtnListener(self.ruleBtn_, nil, function()
		if self.isShowDice_ == false then
			JumpTools.OpenPageByJump("moonBoIntroduceView", {
				activityId = self.activityID_
			})
		end
	end)
	self:AddBtnListener(self.moonBoBtn_, nil, function()
		if self.isShowDice_ == false then
			self.isShowDice_ = true

			if ActivityData:GetActivityIsOpen(self.activityID_) then
				if MoonBoData:GetCanGetCount() <= 0 then
					self.isShowDice_ = false

					ShowTips(GetTips("ACTIVITY_MOONCAKE_GAMBLING_NUM_ZERO"))
				else
					MoonBoAction:GetMoonBo(self.activityID_)
				end
			else
				self.isShowDice_ = false

				ShowTips(GetTips("TIME_OVER"))
			end
		end
	end)
end

function MoonBoView:AddEventListeners()
	self:RegistEventListener(MOONBO_SUCCESS, function()
		manager.windowBar:HideBar()
		AnimatorTools.PlayAnimationWithCallback(self.selfAni_, "VolumeBocakeMainUI_close", function()
			self.isShowDiceController_:SetSelectedState("true")
			SetActive(self.diceGo_, true)

			self.todices_ = MoonBoData:GetCurDices()

			SetActive(self.activedice1_, false)
			SetActive(self.activedice2_, false)
			SetActive(self.activedice3_, false)
			SetActive(self.activedice4_, false)
			SetActive(self.activedice5_, false)
			SetActive(self.activedice6_, false)

			self.activedice1_ = self:DiceToRight(self.dice1_, 1)
			self.activedice2_ = self:DiceToRight(self.dice2_, 2)
			self.activedice3_ = self:DiceToRight(self.dice3_, 3)
			self.activedice4_ = self:DiceToRight(self.dice4_, 4)
			self.activedice5_ = self:DiceToRight(self.dice5_, 5)
			self.activedice6_ = self:DiceToRight(self.dice6_, 6)

			SetActive(self.activedice1_, true)
			SetActive(self.activedice2_, true)
			SetActive(self.activedice3_, true)
			SetActive(self.activedice4_, true)
			SetActive(self.activedice5_, true)
			SetActive(self.activedice6_, true)
			manager.audio:PlayEffect("minigame_activity_1_3", "minigame_diceroll", "")
			AnimatorTools.PlayAnimationWithCallback(self.diceAni_, "VolumeBocakeMainUI_roll", function()
				manager.windowBar:SwitchBar({
					BACK_BAR,
					HOME_BAR,
					INFO_BAR
				})

				self.isShowDice_ = false

				self.isShowDiceController_:SetSelectedState("false")
				AnimatorTools.Stop()
				JumpTools.OpenPageByJump("moonBoResultView", {
					activityId = self.activityID_
				})
			end)
		end)
	end)
end

function MoonBoView:OnEnter()
	self.isEnter_ = true
	self.activityID_ = self.params_.activityID
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime
	self.timeText_.text = manager.time:GetServerTime() < self.stopTime_ and manager.time:GetLostTimeStr(self.stopTime_) or GetTips("TIME_OVER")
	self.timer_ = Timer.New(function()
		MoonBoData:FreshTime()

		if manager.time:GetServerTime() < self.stopTime_ then
			self.timeText_.text = manager.time:GetLostTimeStr(self.stopTime_)
		else
			self:StopTimer()

			self.timeText_.text = GetTips("TIME_OVER")

			return
		end
	end, 1, -1)

	self.timer_:Start()

	self.canGetCountText_.text = MoonBoData:GetCanGetCount()
	self.onNewDayhandler_ = handler(self, self.OnNewDay)

	manager.notify:RegistListener(ACTIVITY_MOONBO_NEWDAY, self.onNewDayhandler_)
	manager.redPoint:bindUIandKey(self.moonBoTrs_, string.format("%s_%s", RedPointConst.MOONBO, self.activityID_))
	self.selfAni_:Play("VolumeBocakeMainUI")

	self.diceAniGo_ = Object.Instantiate(Asset.Load("UI/VolumeIIIUI/VolumeBocake_shaizi"))
	self.diceAniGo_.transform.position = Vector3(0, 0, 10)

	manager.ui:SetMainCamera("moonBo")
	ComponentBinder.GetInstance():BindCfgUI(self, self.diceAniGo_)
	self.diceAni_:Play("VolumeBocakeMainUI_none")
	SetActive(self.diceGo_, false)
	UnityEngine.Physics2D.SyncTransforms()
end

function MoonBoView:DiceToRight(arg_15_1, arg_15_2)
	local var_15_0

	if self.todices_[arg_15_2] == 1 then
		var_15_0 = arg_15_1.transform:Find("1").gameObject
	elseif self.todices_[arg_15_2] == 2 then
		var_15_0 = arg_15_1.transform:Find("2").gameObject
	elseif self.todices_[arg_15_2] == 3 then
		var_15_0 = arg_15_1.transform:Find("3").gameObject
	elseif self.todices_[arg_15_2] == 4 then
		var_15_0 = arg_15_1.transform:Find("4").gameObject
	elseif self.todices_[arg_15_2] == 5 then
		var_15_0 = arg_15_1.transform:Find("5").gameObject
	elseif self.todices_[arg_15_2] == 6 then
		var_15_0 = arg_15_1.transform:Find("6").gameObject
	end

	return var_15_0
end

function MoonBoView:OnNewDay()
	self.canGetCountText_.text = ActivityData:GetActivityIsOpen(self.activityID_) and MoonBoData:GetCanGetCount() or 0
end

function MoonBoView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MOONCAKE_GAMBLING_DESCRIPE")

	if MoonBoData:GetIsShowReward() == true then
		MoonBoData:SetIsShowReward(false)
		getReward(formatRewardCfgList(MoonBoData:GetCurReward()))
	end

	self.canGetCountText_.text = MoonBoData:GetCanGetCount()

	if self.isEnter_ == false then
		self.selfAni_:Play("VolumeBocakeMainUI", 0, 1)
	end

	self.diceAni_:Play("VolumeBocakeMainUI_none")
	SetActive(self.diceGo_, false)

	self.isEnter_ = false
end

function MoonBoView:OnExit()
	manager.windowBar:HideBar()
	AnimatorTools.Stop()
	self:StopTimer()
	manager.notify:RemoveListener(ACTIVITY_MOONBO_NEWDAY, self.onNewDayhandler_)
	manager.redPoint:unbindUIandKey(self.moonBoTrs_, string.format("%s_%s", RedPointConst.MOONBO, self.activityID_))
	manager.ui:ResetMainCamera()

	if self.diceAniGo_ then
		Object.Destroy(self.diceAniGo_)

		self.diceAniGo_ = nil
	end
end

function MoonBoView:Dispose()
	self:StopTimer()
	self:RemoveAllEventListener()
	self.super.Dispose(self)
end

function MoonBoView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return MoonBoView
