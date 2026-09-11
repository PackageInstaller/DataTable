local AshInfinityView = class("AshInfinityView", ReduxView)

function AshInfinityView:UIName()
	return "Widget/System/Activity_EkChuah/EkChuah_BattleUI/EkChuah_BoundlessUI"
end

function AshInfinityView:UIParent()
	return manager.ui.uiMain.transform
end

function AshInfinityView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AshInfinityView:InitUI()
	self:BindCfgUI()
end

function AshInfinityView:AddUIListeners()
	self:AddBtnListener(self.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("/ashRankView")
	end)
	self:AddBtnListener(self.confirmBtn_, nil, function()
		self.aniTimer_ = Timer.New(function()
			if self.mainAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1.2 then
				manager.ui:UIEventEnabled(true)
				self:ConfirmBattle()

				if self.aniTimer_ then
					self.aniTimer_:Stop()

					self.aniTimer_ = nil
				end
			end
		end, 0.033, -1)

		manager.ui:UIEventEnabled(false)
		self.mainAnimator_:Play("UI_EkChuah_bloom", 0, 0)
		self.aniTimer_:Start()
	end)
end

function AshInfinityView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if ActivityData:GetActivityData(ActivityConst.ACTIVITY_ASH_RANK).stopTime <= manager.time:GetServerTime() then
		SetActive(self.rankBtn_.gameObject, false)
	else
		SetActive(self.rankBtn_.gameObject, true)
	end

	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(AshShootStageCfg.all) do
		if AshShootStageCfg[iter_9_1].stage_group == 4 then
			var_9_0 = iter_9_1

			break
		end
	end

	local var_9_1 = AshSystemData:GetStagePoint(var_9_0)

	self.pointTxt_.text = tostring((var_9_1 > 0 or nil) and tostring(var_9_1))
end

function AshInfinityView:ConfirmBattle()
	for iter_10_0, iter_10_1 in ipairs(AshShootStageCfg.all) do
		if AshShootStageCfg[iter_10_1].stage_group == 4 then
			JumpTools.OpenPageByJump("/ashPrepareView", {
				stageId = AshShootStageCfg[iter_10_1].stage_id,
				levelId = iter_10_1
			})

			return
		end
	end
end

function AshInfinityView:OnExit()
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	manager.windowBar:HideBar()
end

function AshInfinityView:Dispose()
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	self.super.Dispose(self)
end

return AshInfinityView
