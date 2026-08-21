-- chunkname: @IQIGame\\Net\\NetFormationResponse.lua

function net_formation.saveFormationResult(code)
	FormationModule.SaveFormationResult()
end

function net_formation.notifyFomationUpdate(formationPod)
	FormationModule.NotifyFormationUpdate(formationPod)
end

function net_formation.chooseHelpHeroResult(code, formationPod)
	FormationModule.ChooseHelpHeroResult(formationPod)
end

function net_formation.clearHelpHeroResult(code, formationPod)
	FormationModule.ClearHelpHeroResult(formationPod)
end

function net_formation.changeFormationNameResult(code, name)
	FormationModule.ChangeFormationNameResult(name)
end

function net_formation.presetFormationResult()
	FormationModule.PresetFormationResult()
end

function net_formation.canclePresetFormationResult()
	FormationModule.CanclePresetFormationResult()
end

function net_formation.getFormationResult()
	FormationModule.GetFormationResult()
end

function net_formation.syncPresetFormationResult(code)
	FormationModule.SyncPresetFormationResult()
end
