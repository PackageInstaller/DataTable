BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11096", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11096"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11096"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:EnableCameraByTagAction("1", 1, 0)
		self:CameraMoveAction("1", 4, 5, 10, 0.7)
		self:SetCharToTagAction(907301, "1", function()
			return
		end)
		self:SetCharToTagAction(9060, "2", function()
			return
		end)
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
	self:PlayActorAnimationAction(907301, "think_start", 0.05, 1.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11036011, "", 0)
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
	self:PlayActorAnimationAction(9060, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:SetLookAtParamsAction(9060, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9060, "907301")
	self:ShowTalkView()
	self:SetTalkContent(11036012, "", 0)
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
	self:PlayActorAnimationAction(907301, "think_end", 0.05, 1.666667, function()
		return
	end)
	self:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_story_05_alarm", "", "")
	self:ShowTalkView()
	self:SetTalkContent(11036013, "", 0)
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
	self:OnNext(function(arg_25_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_5()
	end)
end

function var_0_0:BlackFadeDialogueNode_5()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false, 4083, {})
		self:DestroyCharAction(907301)
		self:DestroyCharAction(9060)
		self:EnableCameraByTagAction("", 1, 0)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_6()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_6()
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.BlackFadeDialogueNode_5)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_6)
end

return var_0_0
