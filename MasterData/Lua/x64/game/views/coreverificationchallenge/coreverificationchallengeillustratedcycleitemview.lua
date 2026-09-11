local CoreVerificationChallengeIllustratedCycleItemView = class("CoreVerificationChallengeIllustratedCycleItemView", ReduxView)

function CoreVerificationChallengeIllustratedCycleItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index = arg_1_2

	self:Init()
end

function CoreVerificationChallengeIllustratedCycleItemView:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.items = {}
	self.illustratedType = CoreVerificationChallengeTools.GetBadgeCount()
	self.stateController_ = self.controller_:GetController("default0")

	for iter_2_0 = 1, 4 do
		self.items[iter_2_0] = CoreVerificationChallengeIllustratedItem.New(self["badgeGo_" .. iter_2_0], iter_2_0)
	end
end

function CoreVerificationChallengeIllustratedCycleItemView:AddUIListener()
	return
end

function CoreVerificationChallengeIllustratedCycleItemView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function CoreVerificationChallengeIllustratedCycleItemView:Refresh(arg_5_1)
	self:Show(true)

	local var_5_0 = CoreVerificationChallengeTools.GetChallengeStageCfgByIndex(arg_5_1)
	local var_5_1 = 0

	for iter_5_0, iter_5_1 in ipairs(var_5_0.get_id_list_by_stage_type[2]) do
		if ActivityCfg[CoreVerificationClBadgeCfg[CoreVerificationClBadgeCfg.get_id_list_by_set_id_sort[arg_5_1][1]].activity_id].sub_activity_list[2] == var_5_0[iter_5_1].activity_id then
			var_5_1 = iter_5_0

			break
		end
	end

	self.bossIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/BossAttribute_new/", var_5_0[var_5_0.get_id_list_by_stage_type[2][var_5_1]].stage_img))

	local var_5_2 = CoreVerificationChallengeTools.GetIllustrated()

	for iter_5_2 = 1, 4 do
		for iter_5_3, iter_5_4 in ipairs(var_5_2) do
			if self.illustratedType[self.index] == CoreVerificationClBadgeCfg[iter_5_4.illustrated_id].set_id then
				if CoreVerificationClBadgeCfg[iter_5_4.illustrated_id].sort == 0 and iter_5_2 == 4 then
					self.items[4]:RefreshUI(iter_5_4, self.illustratedType[self.index])
				elseif CoreVerificationClBadgeCfg[iter_5_4.illustrated_id].sort == iter_5_2 then
					self.items[iter_5_2]:RefreshUI(iter_5_4, self.illustratedType[self.index])
				else
					self.items[iter_5_2]:RefreshUI(nil, self.illustratedType[self.index])
				end
			else
				self.items[iter_5_2]:RefreshUI(nil, self.illustratedType[self.index])
			end
		end

		if #var_5_2 < 1 then
			self.items[iter_5_2]:RefreshUI(nil, self.illustratedType[self.index])
		end
	end

	if self.index % 2 == 0 then
		self.stateController_:SetSelectedIndex(1)
	else
		self.stateController_:SetSelectedIndex(0)
	end
end

function CoreVerificationChallengeIllustratedCycleItemView:Show(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function CoreVerificationChallengeIllustratedCycleItemView:Dispose()
	for iter_7_0 = 1, 4 do
		self.items[iter_7_0]:Dispose()

		self.items[iter_7_0] = nil
	end

	CoreVerificationChallengeIllustratedCycleItemView.super.Dispose(self)
end

return CoreVerificationChallengeIllustratedCycleItemView
