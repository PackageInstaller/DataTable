local var_0_0 = import("game.views.sectionSelectHero.SectionAdditionalView")
local var_0_1 = class("MythicSectionAdditionalView", var_0_0)

function var_0_1.AddListener(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.raceBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription", {
			raceID = arg_1_0.maxRaceID_,
			sameCamp = arg_1_0.sameCamp_
		})
	end)
	arg_1_0:AddBtnListener(arg_1_0.startBtn_, nil, function()
		arg_1_0:OnClickStartBattle()
	end)
	arg_1_0:AddBtnListener(arg_1_0.reservesBtn_, nil, function()
		if not arg_1_0.sectionProxy_.canChangeReserveProposal then
			return
		end

		arg_1_0:GotoReservesProposalUI()
	end)
end

function var_0_1.Refresh(arg_5_0)
	arg_5_0:RefreshSubView()
	arg_5_0:RefreshUI()
	arg_5_0:GetHeroTeam()
end

function var_0_1.RefreshUI(arg_6_0)
	arg_6_0:RefresgStageInfoActive()
	arg_6_0:RefreshReservesBtn()
	arg_6_0:RefreshRace()
	arg_6_0:RefreshStartBtn()
end

function var_0_1.RefreshStartBtn(arg_7_0)
	local var_7_0 = arg_7_0.startBtn_.gameObject:GetComponentInChildren(typeof(Text))

	if var_7_0 then
		var_7_0.text = GetTips("CONFIRM_TEAM")
	end
end

function var_0_1.OnClickStartBattle(arg_8_0)
	arg_8_0:ConfirmTeam()
end

function var_0_1.OnSectionClickHero(arg_9_0, arg_9_1)
	arg_9_0.sectionProxy_:GotoHeroInfoUI(arg_9_1)
end

function var_0_1.ConfirmTeam(arg_10_0)
	arg_10_0:GetHeroTeam()

	local var_10_0 = clone(arg_10_0.heroTeam_)
	local var_10_1 = clone(arg_10_0.heroTrialList_)
	local var_10_2
	local var_10_3 = {}
	local var_10_4 = {}

	for iter_10_0 = 1, 2 do
		if arg_10_0.reserveParams_.teamIndex ~= iter_10_0 then
			local var_10_5 = ReserveParams.New(nil, arg_10_0.reserveParams_.contID, iter_10_0, {
				stageType = arg_10_0.sectionProxy_.stageType,
				stageID = arg_10_0.sectionProxy_.stageID
			})
			local var_10_6 = ReserveTools.GetHeroList(var_10_5)

			for iter_10_1, iter_10_2 in ipairs(var_10_6) do
				if iter_10_2 ~= 0 then
					for iter_10_3 = 1, 3 do
						if iter_10_2 == var_10_0[iter_10_3] then
							var_10_2 = iter_10_0
							var_10_3 = var_10_6

							table.insert(var_10_4, iter_10_1)
						end
					end
				end
			end
		end
	end

	if var_10_2 then
		local var_10_7 = GetTips("NUM_" .. var_10_2)

		ShowMessageBox({
			content = string.format(GetTips("CURHERO_USED"), var_10_7),
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

				local var_11_0 = ReserveParams.New(nil, arg_10_0.reserveParams_.contID, var_10_2, {
					stageType = arg_10_0.sectionProxy_.stageType,
					stageID = arg_10_0.sectionProxy_.stageID
				})

				ReserveTools.SetHeroList(var_11_0, var_10_3, {
					0,
					0,
					0
				})
				arg_10_0:ChangeTeam(var_10_0, var_10_1)
				CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
				arg_10_0:Back()
			end
		})
	else
		arg_10_0:ChangeTeam(var_10_0, var_10_1)
		CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
		arg_10_0:Back()
	end
end

function var_0_1.ChangeTeam(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {}

	for iter_12_0 = 1, 3 do
		if arg_12_1[iter_12_0] ~= 0 then
			var_12_0[#var_12_0 + 1] = arg_12_1[iter_12_0]
		end
	end

	for iter_12_1 = #var_12_0 + 1, 3 do
		var_12_0[iter_12_1] = 0
	end

	local var_12_1 = ReserveTools.GetComboSkillID(arg_12_0.reserveParams_)
	local var_12_2, var_12_3 = ReserveTools.GetMimirData(arg_12_0.reserveParams_)
	local var_12_4 = ReserveTools.GetCharChipBaseID(arg_12_0.reserveParams_)
	local var_12_5 = ReserveParams.New(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI, arg_12_0.reserveParams_.teamIndex, {
		stageType = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL,
		stageID = stageID
	})

	ReserveTools.SetTeam(var_12_5, var_12_0, arg_12_2 or {}, var_12_1, var_12_2, var_12_3, var_12_4)
end

function var_0_1.GetHeroTeam(arg_13_0)
	arg_13_0.heroTeam_, _, _, arg_13_0.heroTrialList_ = ReserveTools.GetHeroList(arg_13_0.reserveParams_)
end

return var_0_1
