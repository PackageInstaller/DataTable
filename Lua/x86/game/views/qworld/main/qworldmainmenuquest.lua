QWorldMainMenuItemBase = import("game.views.qworld.main.QWorldMainMenuItemBase")

local var_0_0 = class("QWorldMainMenuQuest", QWorldMainMenuItemBase)

function var_0_0.OnBtnClick(arg_1_0)
	if not arg_1_0.mainView:CheckCanInteract() then
		return
	end

	arg_1_0.mainView.fadeAnim = true

	JumpTools.OpenPageByJump("/qworldQuestMain", {})
end

return var_0_0
