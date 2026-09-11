QWorldMainMenuItemBase = import("game.views.qworld.main.QWorldMainMenuItemBase")

local QWorldMainMenuSeal = class("QWorldMainMenuSeal", QWorldMainMenuItemBase)

function QWorldMainMenuSeal:BindRed()
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.ACTIVITY_SPRING_STAMPING)
end

function QWorldMainMenuSeal:UnBindRed()
	manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.ACTIVITY_SPRING_STAMPING)
end

function QWorldMainMenuSeal:OnBtnClick()
	if not self.mainView:CheckCanInteract() then
		return
	end

	self.mainView.fadeAnim = true

	JumpTools.OpenPageByJump("/springStampingMain")
end

return QWorldMainMenuSeal
