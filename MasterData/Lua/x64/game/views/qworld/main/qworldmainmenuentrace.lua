QWorldMainMenuItemBase = import("game.views.qworld.main.QWorldMainMenuItemBase")

local QWorldMainMenuEntrace = class("QWorldMainMenuEntrace", QWorldMainMenuItemBase)

function QWorldMainMenuEntrace:BindRed()
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.QWORLD_ACTIVITY_ENTRY)
end

function QWorldMainMenuEntrace:UnBindRed()
	manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.QWORLD_ACTIVITY_ENTRY)
end

function QWorldMainMenuEntrace:OnBtnClick()
	if not self.mainView:CheckCanInteract() then
		return
	end

	if QWorldSystemData:IsSystemOpened(2004) then
		JumpTools.OpenPageByJump("/qWorldBookletEntry")
	end
end

return QWorldMainMenuEntrace
