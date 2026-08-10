QWorldMainMenuItemBase = import("game.views.qworld.main.QWorldMainMenuItemBase")

local var_0_0 = class("QWorldMainMenuSeal", QWorldMainMenuItemBase)

function var_0_0.BindRed(arg_1_0)
	manager.redPoint:bindUIandKey(arg_1_0.transform_, RedPointConst.ACTIVITY_SPRING_STAMPING)
end

function var_0_0.UnBindRed(arg_2_0)
	manager.redPoint:unbindUIandKey(arg_2_0.transform_, RedPointConst.ACTIVITY_SPRING_STAMPING)
end

function var_0_0.OnBtnClick(arg_3_0)
	if not arg_3_0.mainView:CheckCanInteract() then
		return
	end

	arg_3_0.mainView.fadeAnim = true

	JumpTools.OpenPageByJump("/springStampingMain")
end

return var_0_0
