local var_0_0 = {}
local var_0_1

var_0_0.heroId = nil
var_0_0.entrance = nil

function var_0_0.SetUpCooperation()
	manager.uiInit()

	whereami = "battle"

	manager.ui:SetMainCameraPos(Vector3.zero)
	manager.ui:SetMainCameraRot(Vector3.zero)
	JumpTools.OpenPageByJump("/HeroCooperationView", {
		heroId = var_0_0.heroId,
		entrance = var_0_0.entrance
	})
end

function var_0_0.OnCooperationSceneLoaded()
	return
end

function var_0_0.OnCooperationSceneExit()
	gameContext:SetSystemLayer("home")
end

return var_0_0
