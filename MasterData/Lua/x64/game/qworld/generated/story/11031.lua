BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11031", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11031"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11031"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:SetCharToTagAction(9514, "1", function()
			return
		end)
		self:SetCharToTagAction(9073, "2", function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:HideAllDynamicAction(true, true, 4095, {})
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
	self:PlayActorAnimationAction(9514, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:PlayActorEmoteAction(9514, "happy01", 0, 1, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11031001, "", 9514)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("LastWord")
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
	self:PlayActorAnimationAction(9073, "conversation_1", 0.05, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11031002, "", 9073)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("LastWord")
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
	self:PlayActorAnimationAction(9514, "action3_1", 0.05, 2.266667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11031003, "", 9514)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("LastWord")
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_26_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_5()
	end)
end

function var_0_0:BlackFadeDialogueNode_5()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.5, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false, 4095, {})
		self:DestroyCharAction(9073)
		self:DestroyCharAction(9514)
		self:Agent_PlayerPosControl("chuansong", function()
			self:EnableCameraByTagAction("", 1, 0)
		end)
		self:WalkingPeopleGlobleCull(false)
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
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("LastWord", self.BlackFadeDialogueNode_5)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_6)
end

return var_0_0
