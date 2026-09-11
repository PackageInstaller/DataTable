QWorldMainMenuItemBase = import("game.views.qworld.main.QWorldMainMenuItemBase")

local QWorldMainMenuQuest = class("QWorldMainMenuQuest", QWorldMainMenuItemBase)

function QWorldMainMenuQuest:OnBtnClick()
	if not self.mainView:CheckCanInteract() then
		return
	end

	self.mainView.fadeAnim = true

	JumpTools.OpenPageByJump("/qworldQuestMain", {})
end

return QWorldMainMenuQuest
