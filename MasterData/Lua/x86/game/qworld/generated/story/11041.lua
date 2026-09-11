BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11041", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11041"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11041"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(true, true, 4095, {})
		self:EnableCameraCutAction(true)
		self:SetCharToTagAction(9060, "9060-1", function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:SetCharToTagAction(9510, "9510-1", function()
			return
		end)
		self:SetCharToTagAction(907301, "9073-1", function()
			return
		end)
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
	self:PlayActorAnimationAction(9060, "summer_doubt", 0.1, 2, function()
		return
	end)
	self:CameraMoveAction("1", 3, 6, 3, 0.2)
	self:ShowTalkView()
	self:SetTalkContent(11041001, "", 9060)
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
	self:PlayActorAnimationAction(907301, "happy02", 0.1, 3, function()
		return
	end)
	self:EnableCameraByTagAction("2", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11041002, "", 907301)
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
	self:PlayActorAnimationAction(9510, "conversation_2", 0.1, 3.166667, function()
		return
	end)
	self:EnableCameraByTagAction("3", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11041003, "", 9510)
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
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:EnableCameraByTagAction("4", 1, 0)
	self:SetLookAtParamsAction(907301, 0.8, 1, 0.8)
	self:LookAtRoleAction(true, 907301, "9510")
	self:ShowTalkView()
	self:SetTalkContent(11041004, "", 907301)
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
	self:OnNext(function(arg_30_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:PlayActorAnimationAction(9510, "think_start", 0.1, 1.333333, function()
		return
	end)
	self:DelayTimeAction(3, function()
		self:EnableCameraByTagAction("6", 1, 0)
		self:CameraMoveAction("6", 3, 1, 4, 2)
	end)
	self:DelayTimeAction(5, function()
		self:SetNeedClick(true, {
			Invoke = function()
				self:Next()
			end
		})
		self:SetNeedSkip(false, nil)
	end)
	self:EnableCameraByTagAction("5", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11041005, "", 9510)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("LastWord")
		end
	})
	self:SetNeedClick(false, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_38_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:PlayActorAnimationAction(9510, "think_end", 0.1, 1.666667, function()
		return
	end)
	self:EnableCameraByTagAction("5", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11041006, "", 9510)
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
	self:OnNext(function(arg_43_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:PlayActorAnimationAction(907301, "proud", 0.1, 2.333333, function()
		return
	end)
	self:EnableCameraByTagAction("7", 1, 0)
	self:PlayActorEmoteAction(907301, "happy01", 0, 1, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11041007, "", 907301)
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
	self:OnNext(function(arg_49_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_9()
	end)
end

function var_0_0:BlackFadeDialogueNode_9()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:DestroyCharAction(9060)
		self:DestroyCharAction(9510)
		self:DestroyCharAction(907301)
		self:HideAllDynamicAction(false, false, 4095, {})
		self:Agent_PlayerPosControl("chuansong", function()
			self:EnableCameraByTagAction("", 1, 0)
		end)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_10()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_10()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("LastWord", self.BlackFadeDialogueNode_9)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_10)
end

return var_0_0
