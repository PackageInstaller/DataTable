local var_0_0 = import("game.views.osiris.recall.OsirisRecallView")
local var_0_1 = class("OsirisRecallRemasterdView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.list = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.m_list, OsirisRecallRemasteredItem)
	arg_1_0.playExtraStoryStartHandler_ = handler(arg_1_0, arg_1_0.PlayExtraStoryStart)
	arg_1_0.playExtraStoryOverHander_ = handler(arg_1_0, arg_1_0.PlayExtraStoryOver)
end

function var_0_1.OnEnter(arg_2_0)
	var_0_1.super.OnEnter(arg_2_0)
	manager.notify:RegistListener(PLAY_EXTRA_STORY_START, arg_2_0.playExtraStoryStartHandler_)
	manager.notify:RegistListener(PLAY_EXTRA_STORY_OVER, arg_2_0.playExtraStoryOverHander_)
end

function var_0_1.OnExit(arg_3_0)
	var_0_1.super.OnExit(arg_3_0)
	manager.notify:RemoveListener(PLAY_EXTRA_STORY_START, arg_3_0.playExtraStoryStartHandler_)
	manager.notify:RemoveListener(PLAY_EXTRA_STORY_OVER, arg_3_0.playExtraStoryOverHander_)
end

function var_0_1.Dispose(arg_4_0)
	arg_4_0.playExtraStoryStartHandler_ = nil
	arg_4_0.playExtraStoryOverHander_ = nil

	var_0_1.super.Dispose(arg_4_0)
end

function var_0_1.PlayExtraStoryStart(arg_5_0)
	arg_5_0.cachePosition_ = arg_5_0.list:GetScrolledPosition()
end

function var_0_1.PlayExtraStoryOver(arg_6_0)
	arg_6_0.list:StartScrollByPosition(#arg_6_0.data, arg_6_0.cachePosition_ or Vector3.one)
end

return var_0_1
