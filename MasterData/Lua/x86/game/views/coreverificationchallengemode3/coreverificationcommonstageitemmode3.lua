local CoreVerificationCommonStageItemMode3 = class("CoreVerificationCommonStageItemMode3", ReduxView)

function CoreVerificationCommonStageItemMode3:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.cfg = arg_1_2
	self.index = arg_1_3
	self.stage_id = arg_1_2.stage_id

	self:Init()
end

function CoreVerificationCommonStageItemMode3:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationCommonStageItemMode3:InitUI()
	self:BindCfgUI()

	self.challengeHeadItems = {}

	for iter_3_0 = 1, 3 do
		self.challengeHeadItems[iter_3_0] = CoreVerificationChallengeHeroHeadItem.New(self["heroItem_" .. iter_3_0], iter_3_0)
	end

	self.stateController_ = self.controller_:GetController("selection01")
	self.titleText_.text = self.cfg.stage_name
end

function CoreVerificationCommonStageItemMode3:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationCommonStageViewMode3", {
			cfg = self.cfg,
			index = self.index,
			heroList = (self.heroList or nil) and (self.heroList or {})
		})
	end)
end

function CoreVerificationCommonStageItemMode3:RefreshUI(arg_6_1)
	if arg_6_1 then
		if arg_6_1.common_lock_id then
			self.heroList = arg_6_1.common_lock_id or {}
		end

		if arg_6_1 and arg_6_1.stage_id > 0 and #arg_6_1.common_lock_id > 0 then
			self.stateController_:SetSelectedIndex(1)
		else
			self.stateController_:SetSelectedIndex(0)
		end

		local var_6_0 = arg_6_1.common_lock_id

		for iter_6_0 = 1, 3 do
			self.challengeHeadItems[iter_6_0]:RefreshUI((var_6_0[iter_6_0] or nil) and (var_6_0[iter_6_0] or 0))
		end

		self.scoreText_.text = arg_6_1.reset_normal_value
	else
		self.stateController_:SetSelectedIndex(0)

		for iter_6_1 = 1, 3 do
			self.challengeHeadItems[iter_6_1]:RefreshUI(0)
		end
	end
end

function CoreVerificationCommonStageItemMode3:Dispose()
	for iter_7_0 = 1, 3 do
		self.challengeHeadItems[iter_7_0]:Dispose()

		self.challengeHeadItems[iter_7_0] = nil
	end

	CoreVerificationCommonStageItemMode3.super.Dispose(self)
end

return CoreVerificationCommonStageItemMode3
