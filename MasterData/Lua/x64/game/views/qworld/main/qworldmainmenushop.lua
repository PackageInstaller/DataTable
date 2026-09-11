QWorldMainMenuItemBase = import("game.views.qworld.main.QWorldMainMenuItemBase")

local QWorldMainMenuShop = class("QWorldMainMenuShop", QWorldMainMenuItemBase)

function QWorldMainMenuShop:BindRed()
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.ACTIVITY_SPRING_FESTIVAL_SHOP)
end

function QWorldMainMenuShop:UnBindRed()
	manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.ACTIVITY_SPRING_FESTIVAL_SHOP)
end

function QWorldMainMenuShop:OnBtnClick()
	if not self.mainView:CheckCanInteract() then
		return
	end

	QWorldMgr:GetQWorldTagMgr():GotoTag(313631)
end

return QWorldMainMenuShop
