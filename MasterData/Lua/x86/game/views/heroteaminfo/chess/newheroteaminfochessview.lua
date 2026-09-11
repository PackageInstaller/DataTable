local NewHeroTeamInfoChessView = class("NewHeroTeamInfoChessView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function NewHeroTeamInfoChessView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function NewHeroTeamInfoChessView:OnEnter()
	self.teamLength_ = self.params_.teamLength

	self:InitOtherTeamHeroDic()
	NewHeroTeamInfoChessView.super.OnEnter(self)
end

function NewHeroTeamInfoChessView:InitOtherTeamHeroDic()
	self.otherTeamHeroDic_ = {}

	for iter_3_0 = 1, 3 do
		if self.params_.reserveParams.teamIndex ~= iter_3_0 then
			for iter_3_1, iter_3_2 in ipairs((ReserveTools.GetHeroList((ReserveParams.New(self.params_.reserveParams.reserveType, self.params_.reserveParams.contID, iter_3_0, {
				stageType = self.params_.stageType,
				stageID = self.params_.stageID
			}))))) do
				if iter_3_2 ~= 0 then
					self.otherTeamHeroDic_[iter_3_2] = true
				end
			end
		end
	end
end

function NewHeroTeamInfoChessView:GetHeroHeadClass()
	return NewChessHeroTeamHeadItem
end

function NewHeroTeamInfoChessView:HeadRenderer(arg_5_1, arg_5_2)
	NewHeroTeamInfoChessView.super.HeadRenderer(self, arg_5_1, arg_5_2)
	arg_5_2:RefreshTeamTag(self.params_.reserveParams.contID, self.params_.reserveParams.teamIndex, self.teamLength_)

	if self.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.MULTI then
		arg_5_2:SetHeroLock(self.otherTeamHeroDic_[arg_5_2.heroId_] == true)
	end
end

function NewHeroTeamInfoChessView:OnJoinClick()
	if self.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE then
		local var_6_3, var_6_4, var_6_5 = self:TryToChangeSingleHero(self.selectHeroData_.id, self.selectHeroData_.trialID, self.params_.selectHeroPos)
	else
		local var_6_6, var_6_7, var_6_8 = self:TryToChangeMultiHero()

		self:ExitFunc(var_6_7, var_6_8)
	end
end

function NewHeroTeamInfoChessView:TryToChangeSingleHero(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0, var_7_1, var_7_2 = NewHeroTeamInfoChessView.super.TryToChangeSingleHero(self, arg_7_1, arg_7_2, arg_7_3)
	local var_7_3
	local var_7_4
	local var_7_5

	for iter_7_0 = 1, 3 do
		if self.params_.reserveParams.teamIndex ~= iter_7_0 then
			local var_7_6 = ReserveTools.GetHeroList((ReserveParams.New(self.params_.reserveParams.reserveType, self.params_.reserveParams.contID, iter_7_0, {
				stageType = self.params_.stageType,
				stageID = self.params_.stageID
			})))

			for iter_7_1, iter_7_2 in ipairs(var_7_6) do
				if iter_7_2 ~= 0 then
					for iter_7_3 = 1, 3 do
						if iter_7_2 == var_7_1[iter_7_3] then
							var_7_3 = iter_7_0
							var_7_4 = var_7_6
							var_7_5 = iter_7_1
						end
					end
				end
			end
		end
	end

	if var_7_3 then
		ShowMessageBox({
			content = string.format(GetTips("CURHERO_USED"), (GetTips("NUM_" .. var_7_3))),
			OkCallback = function()
				var_7_4[var_7_5] = 0

				for iter_8_0 = 1, 2 do
					for iter_8_1 = iter_8_0 + 1, 3 do
						if var_7_4[iter_8_0] == 0 then
							var_7_4[iter_8_0] = var_7_4[iter_8_1]
							var_7_4[iter_8_1] = 0
						end
					end
				end

				ReserveTools.SetHeroList(ReserveParams.New(self.params_.reserveParams.reserveType, self.params_.reserveParams.contID, var_7_3, {
					stageType = self.params_.stageType,
					stageID = self.params_.stageID
				}), var_7_4, {
					0,
					0,
					0
				})
				self:ExitFunc(var_7_1, var_7_2)
			end
		})
	else
		self:ExitFunc(var_7_1, var_7_2)
	end
end

function NewHeroTeamInfoChessView:ExitFunc(arg_9_1, arg_9_2)
	self:TryToReoerderTeam(arg_9_1, arg_9_2)
	self:TryToChangeTeam(arg_9_1, arg_9_2)
end

function NewHeroTeamInfoChessView:CheckMultiModeCanAddHero(arg_10_1)
	local var_10_0, var_10_1 = NewHeroTeamInfoChessView.super.CheckMultiModeCanAddHero(self, arg_10_1)

	if not var_10_0 then
		return var_10_0, var_10_1
	end

	return not self.otherTeamHeroDic_[arg_10_1.id]
end

function NewHeroTeamInfoChessView:ChangeTeam(arg_11_1, arg_11_2)
	local var_11_0 = {}

	for iter_11_0 = 1, 3 do
		if arg_11_1[iter_11_0] ~= 0 then
			var_11_0[#var_11_0 + 1] = arg_11_1[iter_11_0]
		end
	end

	for iter_11_1 = #var_11_0 + 1, 3 do
		var_11_0[iter_11_1] = 0
	end

	local var_11_1, var_11_2 = ReserveTools.GetMimirData(self.params_.reserveParams)

	ReserveTools.SetTeam(self.params_.reserveParams, var_11_0, arg_11_2 or {}, ComboSkillTools.GetRecommendSkillID(var_11_0, true), var_11_1, var_11_2, (ReserveTools.GetCharChipBaseID(self.params_.reserveParams)))
end

return NewHeroTeamInfoChessView
