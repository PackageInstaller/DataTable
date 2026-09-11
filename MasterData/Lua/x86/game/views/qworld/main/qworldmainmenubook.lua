QWorldMainMenuItemBase = import("game.views.qworld.main.QWorldMainMenuItemBase")

local QWorldMainMenuBook = class("QWorldMainMenuBook", QWorldMainMenuItemBase)

function QWorldMainMenuBook:BindRed()
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.ACTIVITY_SANDPLAY_ILLU)
end

function QWorldMainMenuBook:UnBindRed()
	manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.ACTIVITY_SANDPLAY_ILLU)
end

function QWorldMainMenuBook:OnBtnClick()
	if not self.mainView:CheckCanInteract() then
		return
	end

	SandPlayIlluTool.EnterSandPlayIllu()
end

return QWorldMainMenuBook
