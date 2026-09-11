BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10013", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "10013"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/10013"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.3, function()
		self:SetCharToTagAction(9070, "9070_1", function()
			return
		end)
		self:SetCharToTagAction(9072, "9072_1", function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:HideAllDynamicAction(true, true)
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
	self:PlayActorAnimationAction(9070, "summer_doubt", 0, 2, function()
		return
	end)
	self:CameraMoveAction("1", 1, 4, 5, 0.15)
	self:ShowTalkView()
	self:SetTalkContent(10013001, "", 0)
	self:SetNeedSkip(false, {
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
	self:EnableCameraByTagAction("2", 1, 0)
	self:PlayActorEmoteAction(9072, "blink", 0.2, 0.3333333, function()
		return
	end, true, false)
	self:PlayActorAnimationAction(9072, "action2_1", 0.1, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10013002, "", 0)
	self:SetNeedSkip(false, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_21_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:EnableCameraByTagAction("3", 1, 0)
	self:DelayTimeAction(1.2, function()
		self:PlayActorEmoteAction(9070, "shocked01", 0.2, 1.4, function()
			return
		end, true, false)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10013003, "", 0)
	self:SetNeedSkip(false, {
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
	self:PlayActorAnimationAction(9072, "action2_3", 0.2, 0, function()
		return
	end)
	self:EnableCameraByTagAction("2", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(10013004, "", 0)
	self:SetNeedSkip(false, {
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
	self:PlayActorAnimationAction(9072, "action3_1", 0.1, 0, function()
		return
	end)
	self:CameraMoveAction("2", 10, 1, 5, 0.1)
	self:ShowTalkView()
	self:SetTalkContent(10013005, "", 0)
	self:SetNeedSkip(false, {
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
	self:PlayActorAnimationAction(9070, "cheer", 0, 2.333333, function()
		return
	end)
	self:EnableCameraByTagAction("4", 1, 0)
	self:CameraMoveAction("4", 10, 5, 5, 0.1)
	self:ShowTalkView()
	self:SetTalkContent(10013006, "", 0)
	self:SetNeedSkip(false, {
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
		self:EnableCameraByTagAction("", 1, 0)
		self:EnableCameraCutAction(true)
		self:HideAllDynamicAction(false, false)
		self:DestroyCharAction(9070)
		self:DestroyCharAction(9072)
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
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_9)
end

return var_0_0
