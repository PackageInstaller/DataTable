BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11016", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11016"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11016"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:SetCharToTagAction(9073, "1", function()
			return
		end)
		self:SetCharToTagAction(9513, "2", function()
			return
		end)
		self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
		self:HideAllDynamicAction(true, true, 4083, {})
		self:WalkingPeopleGlobleCull(true)
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
	self:PlayActorAnimationAction(9073, "conversation_1", 0, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11016001, "", 9073)
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
	self:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	self:PlayActorAnimationAction(9513, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:CameraMoveAction("LookAtCamera_2_2_R", 4, 4, 5, 0.3)
	self:DelayTimeAction(1, function()
		self:BlackFadeAction(0.2, 0.2, 0.2, function()
			return
		end, function()
			self:EnableCameraByTagAction("2", 1, 0)
			self:CameraMoveAction("2", 4, 6, 5, 0.3)
		end)
		self:DelayTimeAction(3, function()
			self:BlackFadeAction(0.2, 0.2, 0.2, function()
				return
			end, function()
				self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
			end)
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11016002, "", 9513)
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
	self:OnNext(function(arg_26_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:PlayActorAnimationAction(9073, "stroke01", 0, 9.066668, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11016003, "", 9073)
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
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:PlayActorEmoteAction(9513, "shocked01", 0, 1.4, function()
		self:PlayActorAnimationAction(9513, "conversation_1", 0, 3, function()
			return
		end)
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11016004, "", 9513)
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
	self:OnNext(function(arg_37_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:PlayActorAnimationAction(9073, "action2_1", 0, 1.666667, function()
		self:PlayActorAnimationAction(9073, "embarrassed", 0.1, 2.6, function()
			return
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11016005, "", 9073)
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
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:PlayActorEmoteAction(9513, "happy01", 0, 1, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11016006, "", 9513)
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
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:PlayActorAnimationAction(9073, "firm", 0, 2.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11016007, "", 9073)
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
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:EnableCameraByTagAction("1", 1, 0)
	self:PlayActorAnimationAction(9073, "happy04", 0, 2.2, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11016008, "", 9073)
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
	self:OnNext(function(arg_58_0)
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:PlayActorAnimationAction(9513, "conversation_1", 0, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11016009, "", 9513)
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
	self:OnNext(function(arg_63_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_11()
	end)
end

function var_0_0:BlackFadeDialogueNode_11()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:DestroyCharAction(9513)
		self:DestroyCharAction(9073)
		self:EnableCameraByTagAction("", 1, 0)
		self:HideAllDynamicAction(false, false, 4095, {})
		self:WalkingPeopleGlobleCull(false)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_12()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_12()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.BlackFadeDialogueNode_11)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_12)
end

return var_0_0
