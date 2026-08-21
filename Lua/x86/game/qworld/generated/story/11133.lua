BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11133", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11133"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11133"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(907301, "9073", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:HideAllDynamicAction(true, true, 4081, {})
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:DialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.DialogueNode_2(arg_10_0)
	arg_10_0:ShowTalkView()
	arg_10_0:SetTalkContent(11133001, "", 0)
	arg_10_0:SetNeedSkip(true, {
		Invoke = function()
			arg_10_0:Skip("End")
		end
	})
	arg_10_0:SetNeedClick(true, {
		Invoke = function()
			arg_10_0:Next()
		end
	})
	arg_10_0:OnNext(function(arg_13_0)
		arg_10_0:ClearOnNext()
		arg_10_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_14_0)
	arg_14_0:PlayActorAnimationAction(907301, "think_start", 0.05, 1.333333, function()
		return
	end)
	arg_14_0:ShowTalkView()
	arg_14_0:SetTalkContent(11133002, "", 0)
	arg_14_0:SetNeedSkip(true, {
		Invoke = function()
			arg_14_0:Skip("End")
		end
	})
	arg_14_0:SetNeedClick(true, {
		Invoke = function()
			arg_14_0:Next()
		end
	})
	arg_14_0:OnNext(function(arg_18_0)
		arg_14_0:ClearOnNext()
		arg_14_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_19_0)
	arg_19_0:ShowTalkView()
	arg_19_0:SetTalkContent(11133003, "", 0)
	arg_19_0:SetNeedSkip(true, {
		Invoke = function()
			arg_19_0:Skip("End")
		end
	})
	arg_19_0:SetNeedClick(true, {
		Invoke = function()
			arg_19_0:Next()
		end
	})
	arg_19_0:OnNext(function(arg_22_0)
		arg_19_0:ClearOnNext()
		arg_19_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_23_0)
	arg_23_0:PlayActorAnimationAction(907301, "think_end", 0.05, 1.666667, function()
		return
	end)
	arg_23_0:ShowTalkView()
	arg_23_0:SetTalkContent(11133004, "", 0)
	arg_23_0:SetNeedSkip(true, {
		Invoke = function()
			arg_23_0:Skip("End")
		end
	})
	arg_23_0:SetNeedClick(true, {
		Invoke = function()
			arg_23_0:Next()
		end
	})
	arg_23_0:OnNext(function(arg_27_0)
		arg_23_0:ClearOnNext()
		arg_23_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_28_0)
	arg_28_0:InstEffectAction({
		delayTime = 2,
		createMode = "Point",
		destroyMode = "DelayTime",
		pointTag = "1",
		path = "QWWorld/Effect/EmotionBubble/fx_daxiao_0801.prefab"
	})
	arg_28_0:ShowTalkView()
	arg_28_0:SetTalkContent(11133005, "", 0)
	arg_28_0:SetNeedSkip(true, {
		Invoke = function()
			arg_28_0:Skip("End")
		end
	})
	arg_28_0:SetNeedClick(true, {
		Invoke = function()
			arg_28_0:Next()
		end
	})
	arg_28_0:OnNext(function(arg_31_0)
		arg_28_0:ClearOnNext()
		arg_28_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_32_0)
	arg_32_0:ShowTalkView()
	arg_32_0:SetTalkContent(11133006, "", 0)
	arg_32_0:SetNeedSkip(true, {
		Invoke = function()
			arg_32_0:Skip("End")
		end
	})
	arg_32_0:SetNeedClick(true, {
		Invoke = function()
			arg_32_0:Next()
		end
	})
	arg_32_0:OnNext(function(arg_35_0)
		arg_32_0:ClearOnNext()
		arg_32_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_36_0)
	arg_36_0:InstEffectAction({
		delayTime = 2,
		createMode = "Point",
		destroyMode = "DelayTime",
		pointTag = "1",
		path = "QWWorld/Effect/EmotionBubble/fx_maohan_0301.prefab"
	})
	arg_36_0:ShowTalkView()
	arg_36_0:SetTalkContent(11133007, "", 0)
	arg_36_0:SetNeedSkip(true, {
		Invoke = function()
			arg_36_0:Skip("End")
		end
	})
	arg_36_0:SetNeedClick(true, {
		Invoke = function()
			arg_36_0:Next()
		end
	})
	arg_36_0:OnNext(function(arg_39_0)
		arg_36_0:ClearOnNext()
		arg_36_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_40_0)
	arg_40_0:InstEffectAction({
		delayTime = 2,
		createMode = "Point",
		destroyMode = "DelayTime",
		pointTag = "1",
		path = "QWWorld/Effect/EmotionBubble/fx_xixi_1201.prefab"
	})
	arg_40_0:ShowTalkView()
	arg_40_0:SetTalkContent(11133008, "", 0)
	arg_40_0:SetNeedSkip(true, {
		Invoke = function()
			arg_40_0:Skip("End")
		end
	})
	arg_40_0:SetNeedClick(true, {
		Invoke = function()
			arg_40_0:Next()
		end
	})
	arg_40_0:OnNext(function(arg_43_0)
		arg_40_0:ClearOnNext()
		arg_40_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_44_0)
	arg_44_0:PlayActorAnimationAction(907301, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_44_0:ShowTalkView()
	arg_44_0:SetTalkContent(11133009, "", 0)
	arg_44_0:SetNeedSkip(true, {
		Invoke = function()
			arg_44_0:Skip("End")
		end
	})
	arg_44_0:SetNeedClick(true, {
		Invoke = function()
			arg_44_0:Next()
		end
	})
	arg_44_0:OnNext(function(arg_48_0)
		arg_44_0:ClearOnNext()
		arg_44_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_49_0)
	arg_49_0:InstEffectAction({
		delayTime = 2,
		createMode = "Point",
		destroyMode = "DelayTime",
		pointTag = "2",
		path = "QWWorld/Effect/EmotionBubble/fx_jinghuang_0902.prefab"
	})
	arg_49_0:ShowTalkView()
	arg_49_0:SetTalkContent(11133010, "", 0)
	arg_49_0:SetNeedSkip(true, {
		Invoke = function()
			arg_49_0:Skip("End")
		end
	})
	arg_49_0:SetNeedClick(true, {
		Invoke = function()
			arg_49_0:Next()
		end
	})
	arg_49_0:OnNext(function(arg_52_0)
		arg_49_0:ClearOnNext()
		arg_49_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_53_0)
	arg_53_0:InstEffectAction({
		delayTime = 2,
		createMode = "Point",
		destroyMode = "DelayTime",
		pointTag = "1",
		path = "QWWorld/Effect/EmotionBubble/fx_maohan_0301.prefab"
	})
	arg_53_0:ShowTalkView()
	arg_53_0:SetTalkContent(11133011, "", 0)
	arg_53_0:SetNeedSkip(true, {
		Invoke = function()
			arg_53_0:Skip("End")
		end
	})
	arg_53_0:SetNeedClick(true, {
		Invoke = function()
			arg_53_0:Next()
		end
	})
	arg_53_0:OnNext(function(arg_56_0)
		arg_53_0:ClearOnNext()
		arg_53_0:DialogueNode_13()
	end)
end

function var_0_0.DialogueNode_13(arg_57_0)
	arg_57_0:ShowTalkView()
	arg_57_0:SetTalkContent(11133012, "", 0)
	arg_57_0:SetNeedSkip(true, {
		Invoke = function()
			arg_57_0:Skip("End")
		end
	})
	arg_57_0:SetNeedClick(true, {
		Invoke = function()
			arg_57_0:Next()
		end
	})
	arg_57_0:OnNext(function(arg_60_0)
		arg_57_0:ClearOnNext()
		arg_57_0:DialogueNode_14()
	end)
end

function var_0_0.DialogueNode_14(arg_61_0)
	arg_61_0:ShowTalkView()
	arg_61_0:SetTalkContent(11133013, "", 0)
	arg_61_0:SetNeedSkip(true, {
		Invoke = function()
			arg_61_0:Skip("End")
		end
	})
	arg_61_0:SetNeedClick(true, {
		Invoke = function()
			arg_61_0:Next()
		end
	})
	arg_61_0:OnNext(function(arg_64_0)
		arg_61_0:ClearOnNext()
		arg_61_0:BlackFadeDialogueNode_15()
	end)
end

function var_0_0.BlackFadeDialogueNode_15(arg_65_0)
	arg_65_0:HideTalkView()
	arg_65_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_65_0:EnableCameraByTagAction("", 1, 0)
		arg_65_0:HideAllDynamicAction(false, false, 4095, {})
		arg_65_0:DestroyCharAction(907301)
		arg_65_0:ContinueBlackFade()
		arg_65_0:OnNext(function()
			arg_65_0:ClearOnNext()
			arg_65_0:CloseStoryEventNode_16()
		end)
	end, function()
		arg_65_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_16(arg_69_0)
	arg_69_0:EnableCameraCutAction(false)
	arg_69_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_70_0)
	arg_70_0:RegisterTalkFunction("End", arg_70_0.CloseStoryEventNode_16)
end

return var_0_0
