BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11018", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11018"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11018"
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
		self:SetCharToTagAction(9510, "2", function()
			return
		end)
		self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
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
	self:PlayActorAnimationAction(9073, "conversation_1", 0.05, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11018001, "", 9073)
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
	self:OnNext(function(arg_15_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:PlayActorEmoteAction(9510, "happy01", 0, 1, function()
		self:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
			return
		end)
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11018002, "", 9510)
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
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:PlayActorAnimationAction(9073, "action3_1", 0.05, 2.266667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11018003, "", 9073)
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
	self:EnableCameraByTagAction("1", 1, 0)
	self:PlayActorAnimationAction(9510, "dorm_male_idle01", 0.05, 8.166667, function()
		return
	end)
	self:PlayActorEmoteAction(9510, "happy01", 0, 1, function()
		return
	end, true, false)
	self:CameraMoveAction("1", 4, 4, 5, 0.4)
	self:ShowTalkView()
	self:SetTalkContent(11018004, "", 9510)
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
	self:OnNext(function(arg_32_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:PlayActorAnimationAction(9073, "firm", 0.05, 2.333333, function()
		return
	end)
	self:CameraMoveAction("1", 4, 1, 1, 0.2)
	self:ShowTalkView()
	self:SetTalkContent(11018005, "", 9073)
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
	self:OnNext(function(arg_37_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:PlayActorEmoteAction(9510, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:PlayActorAnimationAction(9510, "speechless", 0, 3.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11018006, "", 9510)
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
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:PlayActorAnimationAction(9073, "proud_start", 0.05, 0.6, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11018007, "", 9073)
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
	self:OnNext(function(arg_48_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:EnableCameraByTagAction("8", 1, 0)
	self:PlayActorEmoteAction(9510, "complaint01_end", 0, 0.5666668, function()
		self:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
			return
		end)
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11018008, "", 9510)
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
	self:OnNext(function(arg_54_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_10()
	end)
end

function var_0_0:BlackFadeDialogueNode_10()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:DestroyCharAction(9073)
		self:DestroyCharAction(9510)
		self:HideAllDynamicAction(false, false, 4095, {})
		self:Agent_PlayerPosControl("chuansong", function()
			self:EnableCameraByTagAction("", 1, 0)
		end)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_11()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_11()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("8", self.DialogueNode_7)
	self:RegisterTalkFunction("LastWord", self.BlackFadeDialogueNode_10)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_11)
end

return var_0_0
