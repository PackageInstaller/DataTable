local CoreVerificationCommonStageItem = class("CoreVerificationCommonStageItem", ReduxView)

function CoreVerificationCommonStageItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.cfg = arg_1_2
	self.index = arg_1_3
	self.stage_id = arg_1_2.stage_id

	self:Init()
end

function CoreVerificationCommonStageItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationCommonStageItem:InitUI()
	self:BindCfgUI()

	self.challengeHeadItems = {}
	self.buffList = {}

	for iter_3_0 = 1, 3 do
		self.challengeHeadItems[iter_3_0] = CoreVerificationChallengeHeroHeadItem.New(self["heroItem_" .. iter_3_0], iter_3_0)
	end

	self.stateController_ = self.controller_:GetController("selection01")
	self.titleText_.text = self.cfg.stage_name
end

function CoreVerificationCommonStageItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationCommonStageView", {
			cfg = self.cfg,
			index = self.index,
			heroList = (self.heroList or nil) and (self.heroList or {})
		})
	end)
end

function CoreVerificationCommonStageItem:RefreshUI(arg_6_1)
	if arg_6_1 then
		if arg_6_1.common_lock_id then
			self.heroList = arg_6_1.common_lock_id or {}
		end

		if arg_6_1 and arg_6_1.stage_id > 0 and #arg_6_1.common_lock_id > 0 then
			self.stateController_:SetSelectedIndex(1)
			self:RefreshAffix()
		else
			self.stateController_:SetSelectedIndex(0)

			if self.buffList and #self.buffList > 0 then
				for iter_6_0 = 1, #self.buffList do
					self.buffList[iter_6_0]:Dispose()
					Object.Destroy(self.buffList[iter_6_0].gameObject_)

					self.buffList[iter_6_0] = nil
				end
			end
		end

		local var_6_0 = arg_6_1.common_lock_id

		for iter_6_1 = 1, 3 do
			self.challengeHeadItems[iter_6_1]:RefreshUI((var_6_0[iter_6_1] or nil) and (var_6_0[iter_6_1] or 0))
		end
	else
		self.stateController_:SetSelectedIndex(0)

		if self.buffList and #self.buffList > 0 then
			for iter_6_2 = 1, #self.buffList do
				self.buffList[iter_6_2]:Dispose()
				Object.Destroy(self.buffList[iter_6_2].gameObject_)

				self.buffList[iter_6_2] = nil
			end
		end

		for iter_6_3 = 1, 3 do
			self.challengeHeadItems[iter_6_3]:RefreshUI(0)
		end
	end
end

function CoreVerificationCommonStageItem:RefreshAffix()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(self.cfg.stage_buff) do
		table.insert(var_7_0, {
			type = 1,
			buff_id = iter_7_1[1]
		})
	end

	for iter_7_2, iter_7_3 in ipairs(self.cfg.stage_debuff) do
		table.insert(var_7_0, {
			type = 2,
			buff_id = iter_7_3[1]
		})
	end

	for iter_7_4 = 1, #var_7_0 do
		self.buffList[iter_7_4] = self.buffList[iter_7_4] or CoreVerificationChallengeAffixItemItem.New((Object.Instantiate(self.affixItem_, self.tagParent_)))

		self.buffList[iter_7_4]:RefreshUI(var_7_0[iter_7_4])
		self.buffList[iter_7_4]:Show(true)
	end

	for iter_7_5 = #var_7_0 + 1, #self.buffList do
		self.buffList[iter_7_5]:Show(false)
	end
end

function CoreVerificationCommonStageItem:Dispose()
	for iter_8_0 = 1, 3 do
		self.challengeHeadItems[iter_8_0]:Dispose()

		self.challengeHeadItems[iter_8_0] = nil
	end

	if self.buffList then
		for iter_8_1 = 1, #self.buffList do
			self.buffList[iter_8_1]:Dispose()
			Object.Destroy(self.buffList[iter_8_1].gameObject_)

			self.buffList[iter_8_1] = nil
		end
	end

	CoreVerificationCommonStageItem.super.Dispose(self)
end

return CoreVerificationCommonStageItem
