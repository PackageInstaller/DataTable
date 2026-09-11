BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11037", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11037"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11037"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(true, true)
		self:SetCharToTagAction(907301, "2", function()
			return
		end)
		self:SetCharToTagAction(9060, "1", function()
			return
		end)
		self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
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
	self:PlayActorAnimationAction(907301, "take", 0.05, 1.833333, function()
		self:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
			return
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11037001, "", 0)
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
	self:OnNext(function(arg_16_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:PlayActorAnimationAction(9060, "think_start", 0.05, 1.333333, function()
		return
	end)
	self:PlayActorEmoteAction(9060, "shocked01", 0, 1.4, function()
		return
	end, true, false)
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11037002, "", 0)
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
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:EnableCameraByTagAction("3", 1, 0)
	self:CameraMoveAction("3", 4, 5, 3, 0.3)
	self:SetLookAtParamsAction(907301, 0.8, 1, 1)
	self:LookAtAction(true, 907301, "3")
	self:ShowTalkView()
	self:SetTalkContent(11037003, "", 0)
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
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:PlayActorAnimationAction(9060, "firm", 0.05, 2.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11037004, "", 0)
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
	self:OnNext(function(arg_32_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:SetLookAtParamsAction(907301, 0.8, 1, 1)
	self:LookAtRoleAction(true, 907301, "9060")
	self:ShowTalkView()
	self:SetTalkContent(11037005, "", 0)
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
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:PlayActorAnimationAction(9060, "excited_start", 0.05, 0.6666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11037006, "", 0)
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
	self:OnNext(function(arg_42_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_8()
	end)
end

function var_0_0:BlackFadeDialogueNode_8()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false)
		self:DestroyCharAction(9060)
		self:EnableCameraByTagAction("", 1, 0)
		self:DestroyCharAction(907301)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_9()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_9()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.BlackFadeDialogueNode_8)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_9)
end

return var_0_0
