local StrategyMatrixSelectHeroProxy = class("StrategyMatrixSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function StrategyMatrixSelectHeroProxy:InitCustomParams(arg_1_1)
	self.matrix_activity_id = arg_1_1.matrix_activity_id
	self.nodeId = arg_1_1.nodeId
	self.needHeroPower = true
	self.needMimirPanel = false
	self.canChangeTeam = false
end

function StrategyMatrixSelectHeroProxy:GetRaceEffect()
	local var_2_0 = {}
	local var_2_1 = 0
	local var_2_2 = false

	for iter_2_0, iter_2_1 in pairs((self:GetHeroIDList())) do
		if iter_2_1 ~= 0 then
			var_2_0[HeroCfg[iter_2_1].race] = (var_2_0[HeroCfg[iter_2_1].race] or 0) + 1

			if var_2_0[HeroCfg[iter_2_1].race] == 2 then
				var_2_1 = HeroCfg[iter_2_1].race

				if StrategyMatrixData:GetRaceEffect(self.matrix_activity_id) then
					var_2_2 = true
				end
			elseif var_2_0[HeroCfg[iter_2_1].race] == 3 then
				var_2_2 = true
			end
		end
	end

	return var_2_1, var_2_0[var_2_1] or 1, var_2_2
end

function StrategyMatrixSelectHeroProxy:CustomGetSkinCfg(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3 ~= 0 then
		return SkinCfg[HeroStandardSystemCfg[arg_3_3].skin_id]
	else
		return StrategyMatrixData:GetHeroSkinCfg(self.matrix_activity_id, arg_3_2)
	end
end

function StrategyMatrixSelectHeroProxy:CustomGetTeamData()
	local var_4_0, var_4_1, var_4_2, var_4_3 = StrategyMatrixData:GetHeroTeam()

	return var_4_0, var_4_1, var_4_2, var_4_3
end

function StrategyMatrixSelectHeroProxy:CustomChangeHeroTeam(arg_5_1)
	StrategyMatrixData:SetMatrixBattleHeroTeam(self.matrix_activity_id, arg_5_1)
end

function StrategyMatrixSelectHeroProxy:CustomGetComboSkillID()
	return ComboSkillData:GetComboSkillID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX, nil, 1)
end

function StrategyMatrixSelectHeroProxy:CustomSetComboSkillID(arg_7_1)
	BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX, GetHeroTeamActivityID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX), arg_7_1)
end

function StrategyMatrixSelectHeroProxy:StartBattle()
	if StrategyMatrixData:GetGameState(self.matrix_activity_id) == MatrixConst.STATE_TYPE.NOTSTARTED then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MATRIX_REFRESH_DATA"),
			OkCallback = function()
				StrategyMatrixAction.GotoStrategyMatrixPrepare(self.matrix_activity_id)
			end
		})
	elseif StrategyMatrixData:GetMatrixPhaseData(self.matrix_activity_id):GetPhase() == 2 then
		StrategyMatrixAction.DoEvent(self.matrix_activity_id)
	else
		StrategyMatrixAction.QueryNextProgress(self.matrix_activity_id, {
			self.nodeId
		})
	end
end

return StrategyMatrixSelectHeroProxy
