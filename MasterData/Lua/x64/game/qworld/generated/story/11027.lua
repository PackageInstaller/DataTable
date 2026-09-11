BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11027", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11027"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11027"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:SetCharToTagAction(9073, "2", function()
			return
		end)
		self:HideAllDynamicAction(true, true, 4083, {})
		self:SetCharToTagAction(9519, "1", function()
			return
		end)
		self:SetCharToTagAction(9510, "3", function()
			return
		end)
		self:EnableCameraByTagAction("right_sight", 1, 0)
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
	self:EnableCameraByTagAction("right_sight", 1, 0)
	self:PlayActorAnimationAction(9073, "conversation_1", 0.05, 3, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "happy01", 0, 1, function()
		return
	end, true, false)
	self:EnableCameraCutAction(true)
	self:ShowTalkView()
	self:SetTalkContent(11027001, "", 9073)
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
	self:OnNext(function(arg_17_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:EnableCameraByTagAction("Middle_camra", 1, 0)
	self:PlayActorAnimationAction(9514, "proud", 0.05, 2.333333, function()
		return
	end)
	self:PlayActorEmoteAction(9514, "happy01_end", 0, 0.2666667, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11027002, "", 9519)
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
	self:OnNext(function(arg_23_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:EnableCameraByTagAction("left_sight", 1, 0)
	self:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:PlayActorEmoteAction(9510, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, false)
	self:SetLookAtParamsAction(9510, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9510, "9073")
	self:ShowTalkView()
	self:SetTalkContent(11027003, "", 9510)
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
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:EnableCameraByTagAction("right_sight", 1, 0)
	self:PlayActorAnimationAction(9073, "embarrassed", 0.05, 2.6, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "disdain01_start", 0, 0.4, function()
		return
	end, true, false)
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9073, "9510")
	self:ShowTalkView()
	self:SetTalkContent(11027004, "", 9073)
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
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
		return
	end)
	self:PlayActorEmoteAction(9510, "squint01_start", 0, 0.3333333, function()
		return
	end, true, false)
	self:SetLookAtParamsAction(9510, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9510, "9073")
	self:ShowTalkView()
	self:SetTalkContent(11027005, "", 9510)
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
	self:OnNext(function(arg_41_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:EnableCameraByTagAction("Middle_camra", 1, 0)
	self:PlayActorAnimationAction(9073, "troubled", 0.05, 3.666667, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "complaint02", 0, 1.466667, function()
		return
	end, true, false)
	self:SetLookAtParamsAction(9073, 0.668, 0.788, 1)
	self:LookAtRoleAction(true, 9073, "9510")
	self:ShowTalkView()
	self:SetTalkContent(11027006, "", 9073)
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
	self:OnNext(function(arg_47_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_8()
	end)
end

function var_0_0:BlackFadeDialogueNode_8()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false, 0, {})
		self:DestroyCharAction(9073)
		self:EnableCameraByTagAction("", 1, 0)
		self:DestroyCharAction(9514)
		self:DestroyCharAction(9510)
		self:WalkingPeopleGlobleCull(false)
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
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_9)
end

return var_0_0
