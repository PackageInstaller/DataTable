BlisterChapterSectionInfoView = import("game.views.activity.Submodule.BlisterGame.View.BlisterChapterSectionInfoView")

local var_0_0 = class("BlisterChapterSectionInfoView_4_3", BlisterChapterSectionInfoView)

function var_0_0.AddListeners(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.battleBtn_, nil, function()
		arg_1_0:Back()
		arg_1_0:OnClickBtn()
	end)
end

function var_0_0.UIName(arg_3_0)
	return "Widget/Version/Alone_Summer2024_BlisterGame/Alone_Summer2024_Bubble/Alone_SUBubbleInfoUI"
end

return var_0_0
