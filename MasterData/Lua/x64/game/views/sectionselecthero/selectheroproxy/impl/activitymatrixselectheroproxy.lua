local ActivityMatrixSelectHeroProxy = class("ActivityMatrixSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function ActivityMatrixSelectHeroProxy:InitCustomParams(arg_1_1)
	self.matrix_activity_id = arg_1_1.matrix_activity_id
	self.eventId = arg_1_1.eventId
	self.needHeroPower = false
	self.needMimirPanel = false
	self.canChangeTeam = false
end

function ActivityMatrixSelectHeroProxy:GetRaceEffect()
	local var_2_0 = {}
	local var_2_1 = 0
	local var_2_2 = false

	for iter_2_0, iter_2_1 in pairs((self:GetHeroIDList())) do
		if iter_2_1 ~= 0 then
			var_2_0[HeroCfg[iter_2_1].race] = (var_2_0[HeroCfg[iter_2_1].race] or 0) + 1

			if var_2_0[HeroCfg[iter_2_1].race] == 2 then
				var_2_1 = HeroCfg[iter_2_1].race

				if ActivityMatrixData:GetRaceEffect(self.matrix_activity_id) then
					var_2_2 = true
				end
			elseif var_2_0[HeroCfg[iter_2_1].race] == 3 then
				var_2_2 = true
			end
		end
	end

	return var_2_1, var_2_0[var_2_1] or 1, var_2_2
end

function ActivityMatrixSelectHeroProxy:CustomGetSkinCfg(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3 ~= 0 then
		return SkinCfg[HeroStandardSystemCfg[arg_3_3].skin_id]
	else
		return ActivityMatrixData:GetHeroSkin(self.matrix_activity_id, arg_3_2)
	end
end

function ActivityMatrixSelectHeroProxy:CustomChangeHeroTeam(arg_4_1)
	ActivityMatrixData:SetMatrixBattleHeroTeam(self.matrix_activity_id, arg_4_1)
end

function ActivityMatrixSelectHeroProxy:CustomGetComboSkillID()
	return ComboSkillData:GetComboSkillID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX, nil, 1)
end

function ActivityMatrixSelectHeroProxy:CustomSetComboSkillID(arg_6_1)
	BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX, GetHeroTeamActivityID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX), arg_6_1)
end

function ActivityMatrixSelectHeroProxy:CustomGetTeamData()
	local var_7_0, var_7_1, var_7_2, var_7_3 = etLocalHeroTeam(self.stageType, self.stageID, self.activityID)

	return var_7_0, var_7_1, var_7_2, var_7_3
end

function ActivityMatrixSelectHeroProxy:StartBattle()
	if ActivityMatrixData:GetGameState(self.matrix_activity_id) == MatrixConst.STATE_TYPE.NOTSTARTED then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MATRIX_REFRESH_DATA"),
			OkCallback = function()
				JumpTools.GoToSystem("/matrixBlank/activityMatrix", {
					main_matrix_activity_id = ActivityMatrixData:GetMainActivityId(self.matrix_activity_id),
					matrix_activity_id = self.matrix_activity_id
				})
			end
		})
	elseif ActivityMatrixData:GetMatrixPhaseData(self.matrix_activity_id):GetPhase() == 2 then
		ActivityMatrixAction.DoEvent(self.matrix_activity_id)
	else
		ActivityMatrixAction.QueryNextProgress(self.matrix_activity_id, {
			self.eventId
		})
	end
end

return ActivityMatrixSelectHeroProxy
