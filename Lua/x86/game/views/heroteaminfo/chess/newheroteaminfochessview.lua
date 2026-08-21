local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("NewHeroTeamInfoChessView", var_0_0)

function var_0_1.UpdateBar(arg_1_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_1.OnEnter(arg_2_0)
	arg_2_0.teamLength_ = arg_2_0.params_.teamLength

	arg_2_0:InitOtherTeamHeroDic()
	var_0_1.super.OnEnter(arg_2_0)
end

function var_0_1.InitOtherTeamHeroDic(arg_3_0)
	arg_3_0.otherTeamHeroDic_ = {}

	for iter_3_0 = 1, 3 do
		if arg_3_0.params_.reserveParams.teamIndex ~= iter_3_0 then
			local var_3_0 = ReserveParams.New(arg_3_0.params_.reserveParams.reserveType, arg_3_0.params_.reserveParams.contID, iter_3_0, {
				stageType = arg_3_0.params_.stageType,
				stageID = arg_3_0.params_.stageID
			})
			local var_3_1 = ReserveTools.GetHeroList(var_3_0)

			for iter_3_1, iter_3_2 in ipairs(var_3_1) do
				if iter_3_2 ~= 0 then
					arg_3_0.otherTeamHeroDic_[iter_3_2] = true
				end
			end
		end
	end
end

function var_0_1.GetHeroHeadClass(arg_4_0)
	return NewChessHeroTeamHeadItem
end

function var_0_1.HeadRenderer(arg_5_0, arg_5_1, arg_5_2)
	var_0_1.super.HeadRenderer(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshTeamTag(arg_5_0.params_.reserveParams.contID, arg_5_0.params_.reserveParams.teamIndex, arg_5_0.teamLength_)

	if arg_5_0.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.MULTI then
		arg_5_2:SetHeroLock(arg_5_0.otherTeamHeroDic_[arg_5_2.heroId_] == true)
	end
end

function var_0_1.OnJoinClick(arg_6_0)
	local var_6_0
	local var_6_1
	local var_6_2

	if arg_6_0.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE then
		local var_6_3, var_6_4, var_6_5 = arg_6_0:TryToChangeSingleHero(arg_6_0.selectHeroData_.id, arg_6_0.selectHeroData_.trialID, arg_6_0.params_.selectHeroPos)
	else
		local var_6_6, var_6_7, var_6_8 = arg_6_0:TryToChangeMultiHero()

		arg_6_0:ExitFunc(var_6_7, var_6_8)
	end
end

function var_0_1.TryToChangeSingleHero(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0, var_7_1, var_7_2 = var_0_1.super.TryToChangeSingleHero(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_3
	local var_7_4
	local var_7_5

	for iter_7_0 = 1, 3 do
		if arg_7_0.params_.reserveParams.teamIndex ~= iter_7_0 then
			local var_7_6 = ReserveParams.New(arg_7_0.params_.reserveParams.reserveType, arg_7_0.params_.reserveParams.contID, iter_7_0, {
				stageType = arg_7_0.params_.stageType,
				stageID = arg_7_0.params_.stageID
			})
			local var_7_7 = ReserveTools.GetHeroList(var_7_6)

			for iter_7_1, iter_7_2 in ipairs(var_7_7) do
				if iter_7_2 ~= 0 then
					for iter_7_3 = 1, 3 do
						if iter_7_2 == var_7_1[iter_7_3] then
							var_7_3 = iter_7_0
							var_7_4 = var_7_7
							var_7_5 = iter_7_1
						end
					end
				end
			end
		end
	end

	if var_7_3 then
		local var_7_8 = GetTips("NUM_" .. var_7_3)

		ShowMessageBox({
			content = string.format(GetTips("CURHERO_USED"), var_7_8),
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

				local var_8_0 = ReserveParams.New(arg_7_0.params_.reserveParams.reserveType, arg_7_0.params_.reserveParams.contID, var_7_3, {
					stageType = arg_7_0.params_.stageType,
					stageID = arg_7_0.params_.stageID
				})

				ReserveTools.SetHeroList(var_8_0, var_7_4, {
					0,
					0,
					0
				})
				arg_7_0:ExitFunc(var_7_1, var_7_2)
			end
		})
	else
		arg_7_0:ExitFunc(var_7_1, var_7_2)
	end
end

function var_0_1.ExitFunc(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:TryToReoerderTeam(arg_9_1, arg_9_2)
	arg_9_0:TryToChangeTeam(arg_9_1, arg_9_2)
end

function var_0_1.CheckMultiModeCanAddHero(arg_10_0, arg_10_1)
	local var_10_0, var_10_1 = var_0_1.super.CheckMultiModeCanAddHero(arg_10_0, arg_10_1)

	if not var_10_0 then
		return var_10_0, var_10_1
	end

	return not arg_10_0.otherTeamHeroDic_[arg_10_1.id]
end

function var_0_1.ChangeTeam(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}

	for iter_11_0 = 1, 3 do
		if arg_11_1[iter_11_0] ~= 0 then
			var_11_0[#var_11_0 + 1] = arg_11_1[iter_11_0]
		end
	end

	for iter_11_1 = #var_11_0 + 1, 3 do
		var_11_0[iter_11_1] = 0
	end

	local var_11_1 = ComboSkillTools.GetRecommendSkillID(var_11_0, true)
	local var_11_2, var_11_3 = ReserveTools.GetMimirData(arg_11_0.params_.reserveParams)
	local var_11_4 = ReserveTools.GetCharChipBaseID(arg_11_0.params_.reserveParams)

	ReserveTools.SetTeam(arg_11_0.params_.reserveParams, var_11_0, arg_11_2 or {}, var_11_1, var_11_2, var_11_3, var_11_4)
end

return var_0_1
