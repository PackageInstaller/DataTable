BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11133", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11133"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11133"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:SetCharToTagAction(907301, "9073", function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:HideAllDynamicAction(true, true, 4081, {})
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:DialogueNode_2()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:DialogueNode_2()
	self:ShowTalkView()
	self:SetTalkContent(11133001, "", 0)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_13_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:PlayActorAnimationAction(907301, "think_start", 0.05, 1.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11133002, "", 0)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_18_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:ShowTalkView()
	self:SetTalkContent(11133003, "", 0)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_22_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:PlayActorAnimationAction(907301, "think_end", 0.05, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11133004, "", 0)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_27_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:InstEffectAction({
		delayTime = 2,
		createMode = "Point",
		destroyMode = "DelayTime",
		pointTag = "1",
		path = "QWWorld/Effect/EmotionBubble/fx_daxiao_0801.prefab"
	})
	self:ShowTalkView()
	self:SetTalkContent(11133005, "", 0)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_31_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:ShowTalkView()
	self:SetTalkContent(11133006, "", 0)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_35_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:InstEffectAction({
		delayTime = 2,
		createMode = "Point",
		destroyMode = "DelayTime",
		pointTag = "1",
		path = "QWWorld/Effect/EmotionBubble/fx_maohan_0301.prefab"
	})
	self:ShowTalkView()
	self:SetTalkContent(11133007, "", 0)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_39_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:InstEffectAction({
		delayTime = 2,
		createMode = "Point",
		destroyMode = "DelayTime",
		pointTag = "1",
		path = "QWWorld/Effect/EmotionBubble/fx_xixi_1201.prefab"
	})
	self:ShowTalkView()
	self:SetTalkContent(11133008, "", 0)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_43_0)
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:PlayActorAnimationAction(907301, "summer_doubt", 0.05, 2, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11133009, "", 0)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_48_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:InstEffectAction({
		delayTime = 2,
		createMode = "Point",
		destroyMode = "DelayTime",
		pointTag = "2",
		path = "QWWorld/Effect/EmotionBubble/fx_jinghuang_0902.prefab"
	})
	self:ShowTalkView()
	self:SetTalkContent(11133010, "", 0)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_52_0)
		self:ClearOnNext()
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:InstEffectAction({
		delayTime = 2,
		createMode = "Point",
		destroyMode = "DelayTime",
		pointTag = "1",
		path = "QWWorld/Effect/EmotionBubble/fx_maohan_0301.prefab"
	})
	self:ShowTalkView()
	self:SetTalkContent(11133011, "", 0)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_56_0)
		self:ClearOnNext()
		self:DialogueNode_13()
	end)
end

function var_0_0:DialogueNode_13()
	self:ShowTalkView()
	self:SetTalkContent(11133012, "", 0)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_60_0)
		self:ClearOnNext()
		self:DialogueNode_14()
	end)
end

function var_0_0:DialogueNode_14()
	self:ShowTalkView()
	self:SetTalkContent(11133013, "", 0)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_64_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_15()
	end)
end

function var_0_0:BlackFadeDialogueNode_15()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:EnableCameraByTagAction("", 1, 0)
		self:HideAllDynamicAction(false, false, 4095, {})
		self:DestroyCharAction(907301)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_16()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_16()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_16)
end

return var_0_0
