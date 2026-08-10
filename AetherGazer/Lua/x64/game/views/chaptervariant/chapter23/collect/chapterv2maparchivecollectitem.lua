LoopScrollViewBaseItem = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")

local var_0_0 = class("ChapterV2MapArchiveCollectItem", LoopScrollViewBaseItem)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.posControl_ = arg_1_0.conEx_:GetController("zoom")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		ChapterV2MapTools.OpenEvent(arg_2_0.eventId_)
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.index_ = arg_4_2
	arg_4_0.eventId_ = arg_4_1

	arg_4_0:Show(true)
	arg_4_0:RefreshUI()
end

function var_0_0.GetItemHeight(arg_5_0)
	return arg_5_0.transform_.sizeDelta.y
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = ChapterV2MapEventCfg[arg_6_0.eventId_]

	arg_6_0.titleText_.text = var_6_0.name

	arg_6_0.posControl_:SetSelectedState(arg_6_0.index_ % 2 == 1 and "state0" or "state1")
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.gameObject_)

	arg_7_0.gameObject_ = nil
	arg_7_0.transform_ = nil
end

return var_0_0
