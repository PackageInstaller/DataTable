-- chunkname: @IQIGame\\Net\\NetCombatFormationResponse.lua

function net_formation.saveFormationResult(code)
	CombatFormationModel.SaveFormationSucceed()
end

function net_formation.notifyFomationUpdate(formation)
	CombatFormationModel.UpdateFormation(formation)
end

function net_formation.chooseHelpHeroResult(code, formation)
	AssistInFightingModule.ChooseHelpHeroResult(code, formation)
end

function net_formation.clearHelpHeroResult(code, formation)
	AssistInFightingModule.ClearHelpHeroResult(code, formation)
end
