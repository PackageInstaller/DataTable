local var_0_0 = import("game.views.chapterTimeLine.StoryTimeLineItemBaseView")
local var_0_1 = class("StoryTimeLineNormalIllutItemView", var_0_0)

function var_0_1.RefreshData(arg_1_0)
	arg_1_0.isIllu_ = true
end

function var_0_1.RefreshItem(arg_2_0)
	var_0_1.super.RefreshItem(arg_2_0)
end

function var_0_1.SetInfo(arg_3_0, arg_3_1)
	arg_3_0.info_ = arg_3_1
end

function var_0_1.SetSizeState(arg_4_0, arg_4_1)
	arg_4_0.sizeState_ = arg_4_1

	arg_4_0.stateController_:SetSelectedState(arg_4_1)
end

function var_0_1.SetUnlockNum(arg_5_0, arg_5_1)
	arg_5_0.unlockNum_ = arg_5_1

	if not arg_5_0.info_ then
		return
	end

	arg_5_0.illCollectNumText_.text = arg_5_0.unlockNum_ .. "/" .. arg_5_0.info_.all
end

return var_0_1
