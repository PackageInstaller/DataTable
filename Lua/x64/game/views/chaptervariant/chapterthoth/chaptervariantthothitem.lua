ChapterVariantSubPlotBaseItem = import("game.views.chapterVariant.base.ChapterVariantSubPlotBaseItem")

local var_0_0 = class("ChapterVariantThothItem", ChapterVariantSubPlotBaseItem)

function var_0_0.BindRedPoint(arg_1_0)
	manager.redPoint:bindUIandKey(arg_1_0.redPointParentTf_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_1_0.chapterID_))
end

function var_0_0.UnBindRedPoint(arg_2_0)
	manager.redPoint:unbindUIandKey(arg_2_0.redPointParentTf_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_2_0.chapterID_))
end

function var_0_0.RefreshControllerState(arg_3_0)
	if arg_3_0.isLock_ or arg_3_0.timeLock_ then
		arg_3_0.controller_:SetSelectedState("timeLock")

		if arg_3_0.timeLock_ == false and arg_3_0.isLock_ then
			arg_3_0.timerText_.text = GetTips("NEED_FINISH_PRE_NORMAL_STAGE")
		end
	else
		arg_3_0.controller_:SetSelectedState("normal")
	end
end

return var_0_0
