BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11012", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11012"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11012"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(true, true, 4083, {})
		self:SetCharToTagAction(9523, "1", function()
			return
		end)
		self:SetCharToTagAction(9073, "2", function()
			return
		end)
		self:SetCharToTagAction(9074, "3", function()
			return
		end)
		self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
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
	self:PlayActorAnimationAction(9523, "angry01", 0, 4.333333, function()
		return
	end)
	self:PlayActorEmoteAction(9523, "complaint02_start", 0, 0.4, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11012001, "", 0)
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
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:PlayActorAnimationAction(9073, "summer_doubt", 0, 2, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11012002, "", 0)
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
	self:EnableCameraByTagAction("3", 1, 0)
	self:PlayActorEmoteAction(9523, "complaint02_end", 0, 0.5000001, function()
		return
	end, true, true)
	self:PlayActorAnimationAction(9523, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:CameraMoveAction("3", 4, 4, 6, 0.4)
	self:SetLookAtParamsAction(9523, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9523, "9073")
	self:ShowTalkView()
	self:SetTalkContent(11012003, "", 0)
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
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:PlayActorAnimationAction(9073, "win", 0, 1.933333, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11012004, "", 0)
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
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:PlayActorAnimationAction(9523, "happy01", 0, 2.333333, function()
		self:PlayActorAnimationAction(9523, "conversation_2", 0, 3.166667, function()
			return
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11012005, "", 0)
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
	self:OnNext(function(arg_40_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9073, "9074")
	self:PlayActorEmoteAction(9073, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:PlayActorAnimationAction(9073, "proud_start", 0, 0.6, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11012006, "", 0)
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
	self:OnNext(function(arg_46_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:PlayActorAnimationAction(9074, "action2_1", 0, 1.666667, function()
		return
	end)
	self:SetLookAtParamsAction(9074, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9074, "9073")
	self:PlayActorEmoteAction(9074, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11012007, "", 0)
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
	self:OnNext(function(arg_52_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:PlayActorAnimationAction(9074, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:PlayActorEmoteAction(9523, "happy01", 0, 1, function()
		return
	end, true, false)
	self:SetLookAtParamsAction(9523, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9523, "9074")
	self:ShowTalkView()
	self:SetTalkContent(11012008, "", 0)
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
	self:EnableCameraByTagAction("3", 1, 0)
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9073, "9523")
	self:PlayActorAnimationAction(9073, "action3_1", 0, 2.266667, function()
		return
	end)
	self:CameraMoveAction("3", 4, 3, 6, 0.4)
	self:SetLookAtParamsAction(9074, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9074, "9523")
	self:ShowTalkView()
	self:SetTalkContent(11012009, "", 0)
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
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:PlayActorAnimationAction(9523, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:SetLookAtParamsAction(9523, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9523, "9073")
	self:ShowTalkView()
	self:SetTalkContent(11012010, "", 0)
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
	self:OnNext(function(arg_68_0)
		self:ClearOnNext()
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:PlayActorAnimationAction(9523, "proud", 0, 2.333333, function()
		return
	end)
	self:SetLookAtParamsAction(9523, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9523, "9074")
	self:ShowTalkView()
	self:SetTalkContent(11012011, "", 0)
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
	self:OnNext(function(arg_73_0)
		self:ClearOnNext()
		self:DialogueNode_13()
	end)
end

function var_0_0:DialogueNode_13()
	self:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	self:PlayActorAnimationAction(9074, "conversation_1", 0, 3, function()
		return
	end)
	self:SetLookAtParamsAction(9074, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9074, "9523")
	self:PlayActorEmoteAction(9073, "", 0, 0, function()
		return
	end, false, false)
	self:PlayActorEmoteAction(9074, "", 0, 0, function()
		return
	end, false, false)
	self:ShowTalkView()
	self:SetTalkContent(11012012, "", 0)
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
	self:OnNext(function(arg_80_0)
		self:ClearOnNext()
		self:DialogueNode_14()
	end)
end

function var_0_0:DialogueNode_14()
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:PlayActorAnimationAction(9523, "take", 0, 1.833333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11012013, "", 0)
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
	self:OnNext(function(arg_85_0)
		self:ClearOnNext()
		self:DialogueNode_15()
	end)
end

function var_0_0:DialogueNode_15()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:PlayActorAnimationAction(9073, "summer_doubt", 0, 2, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11012014, "", 0)
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
	self:OnNext(function(arg_90_0)
		self:ClearOnNext()
		self:DialogueNode_16()
	end)
end

function var_0_0:DialogueNode_16()
	self:EnableCameraByTagAction("4", 1, 0)
	self:PlayActorAnimationAction(9523, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11012015, "", 0)
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
	self:OnNext(function(arg_95_0)
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
end

function var_0_0:DialogueNode_17()
	self:ShowTalkView()
	self:SetTalkContent(11012016, "", 0)
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
	self:OnNext(function(arg_99_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_18()
	end)
end

function var_0_0:BlackFadeDialogueNode_18()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:DestroyCharAction(9073)
		self:EnableCameraByTagAction("", 1, 0)
		self:DestroyCharAction(9074)
		self:DestroyCharAction(9523)
		self:HideAllDynamicAction(false, false, 4095, {})
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_19()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_19()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.BlackFadeDialogueNode_18)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_19)
end

return var_0_0
