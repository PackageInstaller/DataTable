local var_0_0 = import("game.views.sectionSelectHero.SectionAdditionalView")
local var_0_1 = class("SequentialBattleSectionAdditionalView", var_0_0)

function var_0_1.InitSubViewCfg(arg_1_0)
	var_0_1.super.InitSubViewCfg(arg_1_0)

	arg_1_0.subViewDic_.buffView = {
		go = arg_1_0.buffGo_,
		getClassFunc = handler(arg_1_0, arg_1_0.GetBuffViewClass)
	}
end

function var_0_1.AddListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.raceBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription", {
			raceID = arg_2_0.maxRaceID_,
			sameCamp = arg_2_0.sameCamp_
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.startBtn_, nil, function()
		arg_2_0:OnClickStartBattle()
	end)
	arg_2_0:AddBtnListener(arg_2_0.reservesBtn_, nil, function()
		if not arg_2_0.sectionProxy_.canChangeReserveProposal then
			return
		end

		arg_2_0:GotoReservesProposalUI()
	end)
end

function var_0_1.Refresh(arg_6_0)
	var_0_1.super.Refresh(arg_6_0)
	arg_6_0:GetHeroTeam()
end

function var_0_1.RefreshUI(arg_7_0)
	var_0_1.super.RefreshUI(arg_7_0)
	arg_7_0:RefreshStartBtn()
end

function var_0_1.RefreshStartBtn(arg_8_0)
	local var_8_0 = arg_8_0.startBtn_.gameObject:GetComponentInChildren(typeof(Text))

	if var_8_0 then
		var_8_0.text = GetTips("CONFIRM_TEAM")
	end
end

function var_0_1.OnClickStartBattle(arg_9_0)
	arg_9_0:ConfirmTeam()
end

function var_0_1.OnSectionClickHero(arg_10_0, arg_10_1)
	arg_10_0.sectionProxy_:GotoHeroInfoUI(arg_10_1)
end

function var_0_1.ConfirmTeam(arg_11_0)
	arg_11_0:GetHeroTeam()

	local var_11_0 = clone(arg_11_0.heroTeam_)
	local var_11_1 = clone(arg_11_0.heroTrialList_)
	local var_11_2
	local var_11_3 = {}
	local var_11_4 = {}

	for iter_11_0 = 1, 4 do
		if arg_11_0.reserveParams_.teamIndex ~= iter_11_0 then
			local var_11_5 = ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, arg_11_0.reserveParams_.contID, iter_11_0, {
				stageType = arg_11_0.sectionProxy_.stageType,
				stageID = arg_11_0.sectionProxy_.stageID,
				activityID = arg_11_0.reserveParams_.customData.activityID
			})
			local var_11_6 = ReserveTools.GetHeroList(var_11_5)

			for iter_11_1, iter_11_2 in ipairs(var_11_6) do
				if iter_11_2 ~= 0 then
					for iter_11_3 = 1, 3 do
						if iter_11_2 == var_11_0[iter_11_3] then
							var_11_2 = iter_11_0
							var_11_3 = var_11_6

							table.insert(var_11_4, iter_11_1)
						end
					end
				end
			end
		end
	end

	if var_11_2 then
		local var_11_7 = GetTips("NUM_" .. var_11_2)

		ShowMessageBox({
			content = string.format(GetTips("CURHERO_USED"), var_11_7),
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

				local var_12_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, arg_11_0.reserveParams_.contID, var_11_2, {
					stageType = arg_11_0.sectionProxy_.stageType,
					stageID = arg_11_0.sectionProxy_.stageID,
					activityID = arg_11_0.reserveParams_.customData.activityID
				})

				ReserveTools.SetHeroList(var_12_0, var_11_3, {
					0,
					0,
					0
				})
				arg_11_0:ChangeTeam(var_11_0, var_11_1)
				CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
				arg_11_0:Back()
			end
		})
	else
		arg_11_0:ChangeTeam(var_11_0, var_11_1)
		CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
		arg_11_0:Back()
	end
end

function var_0_1.ChangeTeam(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {}

	for iter_13_0 = 1, 3 do
		if arg_13_1[iter_13_0] ~= 0 then
			var_13_0[#var_13_0 + 1] = arg_13_1[iter_13_0]
		end
	end

	for iter_13_1 = #var_13_0 + 1, 3 do
		var_13_0[iter_13_1] = 0
	end

	local var_13_1 = ReserveTools.GetComboSkillID(arg_13_0.reserveParams_)
	local var_13_2, var_13_3 = ReserveTools.GetMimirData(arg_13_0.reserveParams_)
	local var_13_4 = ReserveTools.GetCharChipBaseID(arg_13_0.reserveParams_)
	local var_13_5 = ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, arg_13_0.reserveParams_.contID, arg_13_0.reserveParams_.teamIndex, {
		stageType = arg_13_0.sectionProxy_.stageType,
		stageID = arg_13_0.sectionProxy_.stageID,
		activityID = arg_13_0.reserveParams_.customData.activityID
	})

	ReserveTools.SetTeam(var_13_5, var_13_0, arg_13_2 or {}, var_13_1, var_13_2, var_13_3, var_13_4)
end

function var_0_1.GetHeroTeam(arg_14_0)
	arg_14_0.heroTeam_, _, _, arg_14_0.heroTrialList_ = ReserveTools.GetHeroList(arg_14_0.reserveParams_)
end

function var_0_1.GetBuffViewClass(arg_15_0)
	return SectionSelectHeroBuffView
end

return var_0_1
