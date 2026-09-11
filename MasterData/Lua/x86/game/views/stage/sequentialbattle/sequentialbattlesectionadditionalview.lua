local SequentialBattleSectionAdditionalView = class("SequentialBattleSectionAdditionalView", (import("game.views.sectionSelectHero.SectionAdditionalView")))

function SequentialBattleSectionAdditionalView:InitSubViewCfg()
	SequentialBattleSectionAdditionalView.super.InitSubViewCfg(self)

	self.subViewDic_.buffView = {
		go = self.buffGo_,
		getClassFunc = handler(self, self.GetBuffViewClass)
	}
end

function SequentialBattleSectionAdditionalView:AddListener()
	self:AddBtnListener(self.raceBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription", {
			raceID = self.maxRaceID_,
			sameCamp = self.sameCamp_
		})
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		self:OnClickStartBattle()
	end)
	self:AddBtnListener(self.reservesBtn_, nil, function()
		if not self.sectionProxy_.canChangeReserveProposal then
			return
		end

		self:GotoReservesProposalUI()
	end)
end

function SequentialBattleSectionAdditionalView:Refresh()
	SequentialBattleSectionAdditionalView.super.Refresh(self)
	self:GetHeroTeam()
end

function SequentialBattleSectionAdditionalView:RefreshUI()
	SequentialBattleSectionAdditionalView.super.RefreshUI(self)
	self:RefreshStartBtn()
end

function SequentialBattleSectionAdditionalView:RefreshStartBtn()
	local var_8_0 = self.startBtn_.gameObject:GetComponentInChildren(typeof(Text))

	if var_8_0 then
		var_8_0.text = GetTips("CONFIRM_TEAM")
	end
end

function SequentialBattleSectionAdditionalView:OnClickStartBattle()
	self:ConfirmTeam()
end

function SequentialBattleSectionAdditionalView:OnSectionClickHero(arg_10_1)
	self.sectionProxy_:GotoHeroInfoUI(arg_10_1)
end

function SequentialBattleSectionAdditionalView:ConfirmTeam()
	self:GetHeroTeam()

	local var_11_0 = clone(self.heroTeam_)
	local var_11_1 = clone(self.heroTrialList_)
	local var_11_2
	local var_11_3 = {}
	local var_11_4 = {}

	for iter_11_0 = 1, 4 do
		if self.reserveParams_.teamIndex ~= iter_11_0 then
			local var_11_5 = ReserveTools.GetHeroList((ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, self.reserveParams_.contID, iter_11_0, {
				stageType = self.sectionProxy_.stageType,
				stageID = self.sectionProxy_.stageID,
				activityID = self.reserveParams_.customData.activityID
			})))

			for iter_11_1, iter_11_2 in ipairs(var_11_5) do
				if iter_11_2 ~= 0 then
					for iter_11_3 = 1, 3 do
						if iter_11_2 == var_11_0[iter_11_3] then
							var_11_2 = iter_11_0
							var_11_3 = var_11_5

							table.insert(var_11_4, iter_11_1)
						end
					end
				end
			end
		end
	end

	if var_11_2 then
		ShowMessageBox({
			content = string.format(GetTips("CURHERO_USED"), (GetTips("NUM_" .. var_11_2))),
			OkCallback = function()
				for iter_12_0, iter_12_1 in pairs(var_11_4) do
					var_11_3[iter_12_1] = 0
				end

				for iter_12_2 = 1, 2 do
					for iter_12_3 = iter_12_2 + 1, 3 do
						if var_11_3[iter_12_2] == 0 then
							var_11_3[iter_12_2] = var_11_3[iter_12_3]
							var_11_3[iter_12_3] = 0
						end
					end
				end

				ReserveTools.SetHeroList(ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, self.reserveParams_.contID, var_11_2, {
					stageType = self.sectionProxy_.stageType,
					stageID = self.sectionProxy_.stageID,
					activityID = self.reserveParams_.customData.activityID
				}), var_11_3, {
					0,
					0,
					0
				})
				self:ChangeTeam(var_11_0, var_11_1)
				CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
				self:Back()
			end
		})
	else
		self:ChangeTeam(var_11_0, var_11_1)
		CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
		self:Back()
	end
end

function SequentialBattleSectionAdditionalView:ChangeTeam(arg_13_1, arg_13_2)
	local var_13_0 = {}

	for iter_13_0 = 1, 3 do
		if arg_13_1[iter_13_0] ~= 0 then
			var_13_0[#var_13_0 + 1] = arg_13_1[iter_13_0]
		end
	end

	for iter_13_1 = #var_13_0 + 1, 3 do
		var_13_0[iter_13_1] = 0
	end

	local var_13_1, var_13_2 = ReserveTools.GetMimirData(self.reserveParams_)

	ReserveTools.SetTeam(ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, self.reserveParams_.contID, self.reserveParams_.teamIndex, {
		stageType = self.sectionProxy_.stageType,
		stageID = self.sectionProxy_.stageID,
		activityID = self.reserveParams_.customData.activityID
	}), var_13_0, arg_13_2 or {}, ReserveTools.GetComboSkillID(self.reserveParams_), var_13_1, var_13_2, (ReserveTools.GetCharChipBaseID(self.reserveParams_)))
end

function SequentialBattleSectionAdditionalView:GetHeroTeam()
	self.heroTeam_, _, _, self.heroTrialList_ = ReserveTools.GetHeroList(self.reserveParams_)
end

function SequentialBattleSectionAdditionalView:GetBuffViewClass()
	return SectionSelectHeroBuffView
end

return SequentialBattleSectionAdditionalView
