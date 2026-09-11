local HodurMainlineStageItem = class("HodurMainlineStageItem", ReduxView)

function HodurMainlineStageItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()
end

function HodurMainlineStageItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.mainControllerEx_:GetController("state")
	self.selectController_ = self.mainControllerEx_:GetController("select")
	self.lineController_ = self.mainControllerEx_:GetController("line")
	self.selected_ = false
end

function HodurMainlineStageItem:AddUIListener()
	self:AddBtnListener(self.stageBtn_, nil, function()
		if self.onClickHandler_ then
			self.onClickHandler_(self.stageID_)
		end
	end)
end

function HodurMainlineStageItem:SetData(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.stageID_ = arg_5_1
	self.pos_ = arg_5_2
	self.last_ = arg_5_3
	self.chapterID_ = arg_5_4

	self:RefreshUI()
end

function HodurMainlineStageItem:SetClickHandler(arg_6_1)
	self.onClickHandler_ = arg_6_1
end

function HodurMainlineStageItem:SetSelected(arg_7_1)
	self.selected_ = arg_7_1

	self:RefreshUI()
end

function HodurMainlineStageItem:RefreshUI()
	if self.last_ then
		self.lineController_:SetSelectedState("off")
	else
		self.lineController_:SetSelectedState("on")
	end

	local var_8_0 = ActivityHodurCfg[self.stageID_]

	self.selectController_:SetSelectedState(self.selected_ and "on" or "off")

	self.bossHeadImg_1.sprite = getSpriteWithoutAtlas(HodurConst.BOSS_IMG_PATH .. var_8_0.boss_img)
	self.bossHeadImg_2.sprite = getSpriteWithoutAtlas(HodurConst.BOSS_IMG_PATH .. var_8_0.boss_img)

	if self.isAni_ then
		return
	end

	if HodurTools.GetStagePass(self.stageID_, self.chapterID_) then
		self.stateController_:SetSelectedState("Complete")
	elseif HodurTools.GetStageUnlock(self.stageID_, self.chapterID_) then
		if self.pos_ ~= 1 and not getData("activity_hodur", "first_unlock_" .. self.stageID_) then
			saveData("activity_hodur", "first_unlock_" .. self.stageID_, true)
			self.stateController_:SetSelectedState("lock")
			FrameTimer.New(function()
				if self.aniTimer_ then
					self.aniTimer_:Stop()

					self.aniTimer_ = nil
					self.isAni_ = false
				end

				self.aniTimer_ = Timer.New(function()
					local var_10_0 = self.animator_:GetCurrentAnimatorStateInfo(0)

					if var_10_0.normalizedTime >= 0.55 and not self.aniNormal then
						self.aniNormal = true

						self.stateController_:SetSelectedState("Normal")
					end

					if var_10_0.normalizedTime >= 1 then
						if self.aniTimer_ then
							self.aniTimer_:Stop()

							self.aniTimer_ = nil
						end

						self.aniNormal = false

						manager.ui:UIEventEnabledByUI(true, false)

						self.isAni_ = false
					end
				end, 0.033, -1)

				self.aniTimer_:Start()
			end, 1, 1):Start()
			self.animator_:Play("UI_itemCheckpoint_unlock", 0, 0)
			manager.audio:PlayEffect("minigame_activity_4_7", "minigame_activity_4_7_hodur_lock02", "")
			manager.ui:UIEventEnabledByUI(false, true)

			self.isAni_ = true
		else
			self.stateController_:SetSelectedState("Normal")
		end
	else
		self.stateController_:SetSelectedState("lock")
	end
end

function HodurMainlineStageItem:Dispose()
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
		self.isAni_ = false
	end

	HodurMainlineStageItem.super.Dispose(self)
end

return HodurMainlineStageItem
