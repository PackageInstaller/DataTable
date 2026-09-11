BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11010", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11010"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11010"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.2, 0.2, function()
		self:SetCharToTagAction(9073, "1", function()
			return
		end)
		self:SetCharToTagAction(9074, "2", function()
			return
		end)
		self:SetCharToTagAction(9512, "3", function()
			return
		end)
		self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
		self:HideAllDynamicAction(true, true, 4095, {})
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
	self:PlayActorAnimationAction(9073, "happy01", 0, 2.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11010001, "", 9073)
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
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:PlayActorAnimationAction(9074, "conversation_1", 0, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11010002, "", 9074)
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
	self:EnableCameraByTagAction("4", 1, 0)
	self:PlayActorAnimationAction(9073, "proud_start", 0, 0.6, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11010003, "", 9073)
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
	self:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	self:PlayActorAnimationAction(9512, "action2_1", 0, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11010004, "", 9512)
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
	self:OnNext(function(arg_31_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:PlayActorAnimationAction(9073, "embarrassed", 0, 2.6, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11010005, "", 9073)
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
	self:OnNext(function(arg_36_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:PlayActorAnimationAction(9074, "conversation_1", 0, 3, function()
		return
	end)
	self:PlayActorAnimationAction(9512, "action2_3", 0, 1.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11010006, "", 9074)
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
	self:OnNext(function(arg_42_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:EnableCameraByTagAction("3", 1, 0)
	self:PlayActorAnimationAction(9073, "action3_1", 0, 2.266667, function()
		return
	end)
	self:CameraMoveAction("3", 4, 4, 6, 0.4)
	self:ShowTalkView()
	self:SetTalkContent(11010007, "", 9073)
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
	self:OnNext(function(arg_47_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:ShowTalkView()
	self:SetTalkContent(11010008, "", 9512)
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
	self:OnNext(function(arg_51_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_10()
	end)
end

function var_0_0:BlackFadeDialogueNode_10()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.4, 0.2, 0.2, function()
		self:DestroyCharAction(9073)
		self:DestroyCharAction(9074)
		self:DestroyCharAction(9512)
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
	self:RegisterTalkFunction("LastWord", self.BlackFadeDialogueNode_10)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_11)
end

return var_0_0
