local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("ActivityMatrixSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.matrix_activity_id = arg_1_1.matrix_activity_id
	arg_1_0.eventId = arg_1_1.eventId
	arg_1_0.needHeroPower = false
	arg_1_0.needMimirPanel = false
	arg_1_0.canChangeTeam = false
end

function var_0_1.GetRaceEffect(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = 0
	local var_2_2 = false
	local var_2_3 = arg_2_0:GetHeroIDList()

	for iter_2_0, iter_2_1 in pairs(var_2_3) do
		if iter_2_1 ~= 0 then
			local var_2_4 = HeroCfg[iter_2_1].race

			var_2_0[var_2_4] = (var_2_0[var_2_4] or 0) + 1

			if var_2_0[var_2_4] == 2 then
				var_2_1 = var_2_4

				if ActivityMatrixData:GetRaceEffect(arg_2_0.matrix_activity_id) then
					var_2_2 = true
				end
			elseif var_2_0[var_2_4] == 3 then
				var_2_2 = true
			end
		end
	end

	return var_2_1, var_2_0[var_2_1] or 1, var_2_2
end

function var_0_1.CustomGetSkinCfg(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3 ~= 0 then
		return SkinCfg[HeroStandardSystemCfg[arg_3_3].skin_id]
	else
		return ActivityMatrixData:GetHeroSkin(arg_3_0.matrix_activity_id, arg_3_2)
	end
end

function var_0_1.CustomChangeHeroTeam(arg_4_0, arg_4_1)
	ActivityMatrixData:SetMatrixBattleHeroTeam(arg_4_0.matrix_activity_id, arg_4_1)
end

function var_0_1.CustomGetComboSkillID(arg_5_0)
	return ComboSkillData:GetComboSkillID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX, nil, 1)
end

function var_0_1.CustomSetComboSkillID(arg_6_0, arg_6_1)
	local var_6_0 = GetHeroTeamActivityID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX)

	BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX, var_6_0, arg_6_1)
end

function var_0_1.CustomGetTeamData(arg_7_0)
	local var_7_0, var_7_1, var_7_2, var_7_3 = etLocalHeroTeam(arg_7_0.stageType, arg_7_0.stageID, arg_7_0.activityID)

	return var_7_0, var_7_1, var_7_2, var_7_3
end

function var_0_1.StartBattle(arg_8_0)
	if ActivityMatrixData:GetGameState(arg_8_0.matrix_activity_id) == MatrixConst.STATE_TYPE.NOTSTARTED then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MATRIX_REFRESH_DATA"),
			OkCallback = function()
				local var_9_0 = ActivityMatrixData:GetMainActivityId(arg_8_0.matrix_activity_id)

				JumpTools.GoToSystem("/matrixBlank/activityMatrix", {
					main_matrix_activity_id = var_9_0,
					matrix_activity_id = arg_8_0.matrix_activity_id
				})
			end
		})
	else
		local var_8_0 = ActivityMatrixData:GetMatrixPhaseData(arg_8_0.matrix_activity_id):GetPhase()
		local var_8_1 = arg_8_0.eventId

		if var_8_0 == 2 then
			ActivityMatrixAction.DoEvent(arg_8_0.matrix_activity_id)
		else
			ActivityMatrixAction.QueryNextProgress(arg_8_0.matrix_activity_id, {
				var_8_1
			})
		end
	end
end

return var_0_1
