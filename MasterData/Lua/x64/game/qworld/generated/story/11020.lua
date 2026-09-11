BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11020", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11020"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11020"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(true, true)
		self:SetCharToTagAction(9510, "1", function()
			return
		end)
		self:SetCharToTagAction(9073, "2", function()
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
	self:PlayActorAnimationAction(9073, "action3_1", 0.05, 2.266667, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11020001, "", 0)
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
	self:PlayActorEmoteAction(9510, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:PlayActorAnimationAction(9510, "action2_1", 0.05, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11020002, "", 0)
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
	self:PlayActorAnimationAction(9073, "proud_start", 0.05, 0.6, function()
		return
	end)
	self:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	self:PlayActorEmoteAction(9073, "happy01_end", 0, 0.2666667, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11020003, "", 0)
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
	self:OnNext(function(arg_28_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:PlayActorAnimationAction(9510, "action2_3", 0.05, 1.333333, function()
		return
	end)
	self:PlayActorEmoteAction(9510, "happy01", 0, 1, function()
		return
	end, true, false)
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11020004, "", 0)
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
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11020005, "", 0)
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
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:PlayActorEmoteAction(9073, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	self:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	self:CameraMoveAction("LookAtCamera_2_2_R", 4, 1, 0.7, 0.3)
	self:PlayActorAnimationAction(9073, "summer_shock_start", 0.05, 0.3333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11020006, "", 0)
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
	self:OnNext(function(arg_45_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:PlayActorEmoteAction(9510, "shocked01", 0, 1.4, function()
		return
	end, true, false)
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11020007, "", 0)
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
	self:OnNext(function(arg_51_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:EnableCameraByTagAction("1", 1, 0)
	self:CameraMoveAction("1", 4, 4, 5, 0.4)
	self:ShowTalkView()
	self:SetTalkContent(11020008, "", 0)
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
	self:OnNext(function(arg_56_0)
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:ShowTalkView()
	self:SetTalkContent(11020009, "", 0)
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
	self:OnNext(function(arg_60_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
		return
	end)
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11020010, "", 0)
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
	self:OnNext(function(arg_65_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_12()
	end)
end

function var_0_0:BlackFadeDialogueNode_12()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false)
		self:EnableCameraByTagAction("", 1, 0)
		self:DestroyCharAction(9073)
		self:DestroyCharAction(9510)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_13()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_13()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.BlackFadeDialogueNode_12)
end

return var_0_0
