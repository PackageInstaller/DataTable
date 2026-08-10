QWorldMainMenuItemBase = import("game.views.qworld.main.QWorldMainMenuItemBase")

local var_0_0 = class("QWorldMainMenuShop", QWorldMainMenuItemBase)

function var_0_0.BindRed(arg_1_0)
	manager.redPoint:bindUIandKey(arg_1_0.transform_, RedPointConst.ACTIVITY_SPRING_FESTIVAL_SHOP)
end

function var_0_0.UnBindRed(arg_2_0)
	manager.redPoint:unbindUIandKey(arg_2_0.transform_, RedPointConst.ACTIVITY_SPRING_FESTIVAL_SHOP)
end

function var_0_0.OnBtnClick(arg_3_0)
	if not arg_3_0.mainView:CheckCanInteract() then
		return
	end

	QWorldMgr:GetQWorldTagMgr():GotoTag(313631)
end

return var_0_0
