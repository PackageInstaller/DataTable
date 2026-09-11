local MythicSectionAdditionalView = class("MythicSectionAdditionalView", (import("game.views.sectionSelectHero.SectionAdditionalView")))

function MythicSectionAdditionalView:AddListener()
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

function MythicSectionAdditionalView:Refresh()
	self:RefreshSubView()
	self:RefreshUI()
	self:GetHeroTeam()
end

function MythicSectionAdditionalView:RefreshUI()
	self:RefresgStageInfoActive()
	self:RefreshReservesBtn()
	self:RefreshRace()
	self:RefreshStartBtn()
end

function MythicSectionAdditionalView:RefreshStartBtn()
	local var_7_0 = self.startBtn_.gameObject:GetComponentInChildren(typeof(Text))

	if var_7_0 then
		var_7_0.text = GetTips("CONFIRM_TEAM")
	end
end

function MythicSectionAdditionalView:OnClickStartBattle()
	self:ConfirmTeam()
end

function MythicSectionAdditionalView:OnSectionClickHero(arg_9_1)
	self.sectionProxy_:GotoHeroInfoUI(arg_9_1)
end

function MythicSectionAdditionalView:ConfirmTeam()
	self:GetHeroTeam()

	local var_10_0 = clone(self.heroTeam_)
	local var_10_1 = clone(self.heroTrialList_)
	local var_10_2
	local var_10_3 = {}
	local var_10_4 = {}

	for iter_10_0 = 1, 2 do
		if self.reserveParams_.teamIndex ~= iter_10_0 then
			local var_10_5 = ReserveTools.GetHeroList((ReserveParams.New(nil, self.reserveParams_.contID, iter_10_0, {
				stageType = self.sectionProxy_.stageType,
				stageID = self.sectionProxy_.stageID
			})))

			for iter_10_1, iter_10_2 in ipairs(var_10_5) do
				if iter_10_2 ~= 0 then
					for iter_10_3 = 1, 3 do
						if iter_10_2 == var_10_0[iter_10_3] then
							var_10_2 = iter_10_0
							var_10_3 = var_10_5

							table.insert(var_10_4, iter_10_1)
						end
					end
				end
			end
		end
	end

	if var_10_2 then
		ShowMessageBox({
			content = string.format(GetTips("CURHERO_USED"), (GetTips("NUM_" .. var_10_2))),
			OkCallback = function()
				for iter_11_0, iter_11_1 in pairs(var_10_4) do
					var_10_3[iter_11_1] = 0
				end

				for iter_11_2 = 1, 2 do
					for iter_11_3 = iter_11_2 + 1, 3 do
						if var_10_3[iter_11_2] == 0 then
							var_10_3[iter_11_2] = var_10_3[iter_11_3]
							var_10_3[iter_11_3] = 0
						end
					end
				end

				ReserveTools.SetHeroList(ReserveParams.New(nil, self.reserveParams_.contID, var_10_2, {
					stageType = self.sectionProxy_.stageType,
					stageID = self.sectionProxy_.stageID
				}), var_10_3, {
					0,
					0,
					0
				})
				self:ChangeTeam(var_10_0, var_10_1)
				CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
				self:Back()
			end
		})
	else
		self:ChangeTeam(var_10_0, var_10_1)
		CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
		self:Back()
	end
end

function MythicSectionAdditionalView:ChangeTeam(arg_12_1, arg_12_2)
	local var_12_0 = {}

	for iter_12_0 = 1, 3 do
		if arg_12_1[iter_12_0] ~= 0 then
			var_12_0[#var_12_0 + 1] = arg_12_1[iter_12_0]
		end
	end

	for iter_12_1 = #var_12_0 + 1, 3 do
		var_12_0[iter_12_1] = 0
	end

	local var_12_1, var_12_2 = ReserveTools.GetMimirData(self.reserveParams_)

	ReserveTools.SetTeam(ReserveParams.New(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI, self.reserveParams_.teamIndex, {
		stageType = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL,
		stageID = stageID
	}), var_12_0, arg_12_2 or {}, ReserveTools.GetComboSkillID(self.reserveParams_), var_12_1, var_12_2, (ReserveTools.GetCharChipBaseID(self.reserveParams_)))
end

function MythicSectionAdditionalView:GetHeroTeam()
	self.heroTeam_, _, _, self.heroTrialList_ = ReserveTools.GetHeroList(self.reserveParams_)
end

return MythicSectionAdditionalView
