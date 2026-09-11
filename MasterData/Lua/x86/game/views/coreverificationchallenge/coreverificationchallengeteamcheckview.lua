local CoreVerificationChallengeTeamCheckView = class("CoreVerificationChallengeTeamCheckView", ReduxView)

function CoreVerificationChallengeTeamCheckView:UIName()
	return "Widget/System/Core_verification_new/Core_verification_DetailUI"
end

function CoreVerificationChallengeTeamCheckView:UIParent()
	return manager.ui.uiPop.transform
end

function CoreVerificationChallengeTeamCheckView:Init()
	self:BindCfgUI()

	self.roleList_ = LuaList.New(handler(self, self.IndexItem), self.roleListGo_, CoreVerificationChallengeTeamInfoItem)
	self.affixList_ = LuaList.New(handler(self, self.IndexItem1), self.affixListGo_, CoreVerificationChallengeRankAffixItem)

	self:AddUIListener()
end

function CoreVerificationChallengeTeamCheckView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function CoreVerificationChallengeTeamCheckView:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(self.list[1].hero_list[arg_7_1], arg_7_1)
end

function CoreVerificationChallengeTeamCheckView:IndexItem1(arg_8_1, arg_8_2)
	arg_8_2:SetData(self.list[1].affix_list[arg_8_1], arg_8_1)
end

local function var_0_2(arg_10_0, arg_10_1)
	local var_10_0 = {}

	print("ProcessData", arg_10_1)

	if arg_10_0 then
		local var_10_1 = {}

		for iter_10_0, iter_10_1 in pairs(arg_10_0.stage_team_list) do
			var_10_1[1] = {}

			for iter_10_2, iter_10_3 in pairs(iter_10_1[1]) do
				if iter_10_3.hero_id then
					table.insert(var_10_1[1], iter_10_3.hero_id)
				end
			end
		end

		local var_10_3 = {}

		if arg_10_0.extraInfo then
			if arg_10_1 == 1 then
				for iter_10_4 = 1, #arg_10_0.extraInfo, 2 do
					table.insert(var_10_3, {
						id = arg_10_0.extraInfo[iter_10_4],
						lv = arg_10_0.extraInfo[iter_10_4 + 1]
					})
				end
			elseif arg_10_1 == 2 then
				for iter_10_5 = 1, #arg_10_0.extraInfo do
					local var_10_4 = 0

					for iter_10_6, iter_10_7 in ipairs(CoreVerificationClMode2Cfg.get_id_list_by_stage_type[2]) do
						for iter_10_8, iter_10_9 in ipairs(CoreVerificationClMode2Cfg[iter_10_7].stage_affix_debuff) do
							if iter_10_9 == arg_10_0.extraInfo[iter_10_5] then
								var_10_4 = 0

								break
							else
								var_10_4 = -1
							end
						end
					end

					table.insert(var_10_3, {
						id = arg_10_0.extraInfo[iter_10_5],
						lv = var_10_4
					})
				end
			end
		end

		var_10_0[1] = {
			hero_list = var_10_1[1],
			affix_list = var_10_3
		}
	end

	return var_10_0
end

function CoreVerificationChallengeTeamCheckView:OnEnter()
	self.coreVerificationModeIndex = self.params_.coreVerificationModeIndex or CoreVerificationChallengeTools.GetModeIndex()
	self.list = self.params_.notCoreCl and (self.params_.dataList or {}) or var_0_2(self.params_.data, self.coreVerificationModeIndex)

	self.roleList_:StartScroll(#self.list[1].hero_list)

	if self.list[1].affix_list and #self.list[1].affix_list > 0 then
		self.affixList_:StartScroll(#self.list[1].affix_list)
	else
		self.affixList_:StartScroll(0)
	end
end

function CoreVerificationChallengeTeamCheckView:OnExit()
	return
end

function CoreVerificationChallengeTeamCheckView:Dispose()
	CoreVerificationChallengeTeamCheckView.super.Dispose(self)

	if self.roleList_ then
		self.roleList_:Dispose()

		self.roleList_ = nil
	end

	if self.affixList_ then
		self.affixList_:Dispose()

		self.affixList_ = nil
	end
end

return CoreVerificationChallengeTeamCheckView
