BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11191", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11191"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11191"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:SetCharToTagAction(9535, "9535", function()
			return
		end)
		self:SetCharToTagAction(907301, "907301", function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:HideAllDynamicAction(true, true, 4083, {})
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
	self:PlayActorAnimationAction(9535, "conversation_1", 0.05, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11191001, "", 0)
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
	self:OnNext(function(arg_15_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11191002, "", 0)
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
	self:OnNext(function(arg_20_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:ShowTalkView()
	self:SetTalkContent(11191003, "", 0)
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
	self:OnNext(function(arg_24_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:PlayActorAnimationAction(907301, "think_start", 0.05, 1.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11191004, "", 0)
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
	self:OnNext(function(arg_29_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:PlayActorAnimationAction(9535, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11191005, "", 0)
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
	self:OnNext(function(arg_34_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:PlayActorAnimationAction(907301, "think_end", 0.05, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11191006, "", 0)
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
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:ShowTalkView()
	self:SetTalkContent(11191007, "", 0)
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
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:PlayActorAnimationAction(9535, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11191008, "", 0)
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
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:PlayActorAnimationAction(907301, "firm_start", 0.05, 0.5666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11191009, "", 0)
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
	self:OnNext(function(arg_53_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:ShowTalkView()
	self:SetTalkContent(11191010, "", 0)
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
	self:OnNext(function(arg_57_0)
		self:ClearOnNext()
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:ShowTalkView()
	self:SetTalkContent(11191011, "", 0)
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
	self:OnNext(function(arg_61_0)
		self:ClearOnNext()
		self:DialogueNode_13()
	end)
end

function var_0_0:DialogueNode_13()
	self:PlayActorAnimationAction(907301, "firm_end", 0.05, 0.5000001, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11191012, "", 0)
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
	self:OnNext(function(arg_66_0)
		self:ClearOnNext()
		self:DialogueNode_14()
	end)
end

function var_0_0:DialogueNode_14()
	self:PlayActorAnimationAction(9535, "stroke02", 0.05, 5.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11191013, "", 0)
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
	self:OnNext(function(arg_71_0)
		self:ClearOnNext()
		self:DialogueNode_15()
	end)
end

function var_0_0:DialogueNode_15()
	self:PlayActorAnimationAction(907301, "take", 0.05, 1.833333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11191014, "", 0)
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
	self:OnNext(function(arg_76_0)
		self:ClearOnNext()
		self:DialogueNode_16()
	end)
end

function var_0_0:DialogueNode_16()
	self:PlayActorAnimationAction(9535, "summer_doubt", 0.05, 2, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11191015, "", 0)
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
	self:OnNext(function(arg_81_0)
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
end

function var_0_0:DialogueNode_17()
	self:ShowTalkView()
	self:SetTalkContent(11191016, "", 0)
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
	self:OnNext(function(arg_85_0)
		self:ClearOnNext()
		self:DialogueNode_18()
	end)
end

function var_0_0:DialogueNode_18()
	self:PlayActorAnimationAction(907301, "proud_start", 0.05, 0.6, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11191017, "", 0)
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
	self:OnNext(function(arg_90_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_19()
	end)
end

function var_0_0:BlackFadeDialogueNode_19()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:EnableCameraByTagAction("", 1, 0)
		self:HideAllDynamicAction(false, false, 4081, {
			430001
		})
		self:DestroyCharAction(907301)
		self:DestroyCharAction(9535)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_20()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_20()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_20)
end

return var_0_0
