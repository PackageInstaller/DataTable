BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11014", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11014"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11014"
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
		self:SetCharToTagAction(9074, "2", function()
			return
		end)
		self:EnableCameraByTagAction("3", 1, 0)
		self:HideAllDynamicAction(true, true, 4083, {})
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
	self:CameraMoveAction("3", 4, 2, 3, 0.4)
	self:ShowTalkView()
	self:SetTalkContent(11014001, "", 9073)
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
	self:OnNext(function(arg_14_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:PlayActorAnimationAction(9074, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:SetLookAtParamsAction(9074, 0.8, 1, 0.8)
	self:LookAtRoleAction(true, 9074, "9073")
	self:ShowTalkView()
	self:SetTalkContent(11014002, "", 9074)
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
	self:OnNext(function(arg_19_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:SetLookAtParamsAction(9073, 0.8, 1, 0.8)
	self:LookAtRoleAction(true, 9073, "9074")
	self:PlayActorEmoteAction(9073, "shocked01", 0, 1.4, function()
		self:PlayActorEmoteAction(9073, "happy01", 0, 1, function()
			return
		end, true, false)
	end, true, false)
	self:DelayTimeAction(2, function()
		self:PlayActorAnimationAction(9073, "summer_doubt", 0, 2, function()
			return
		end)
		self:SetNeedClick(true, {
			Invoke = function()
				self:Next()
			end
		})
		self:SetNeedSkip(true, {
			Invoke = function()
				self:Skip("LastWord")
			end
		})
	end)
	self:ShowTalkView()
	self:SetTalkContent(11014003, "", 9073)
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
	self:OnNext(function(arg_29_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:PlayActorAnimationAction(9074, "conversation_1", 0, 3, function()
		return
	end)
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11014004, "", 9074)
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
	self:OnNext(function(arg_34_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:PlayActorAnimationAction(9073, "action3_1", 0, 2.266667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11014005, "", 9073)
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
	self:OnNext(function(arg_39_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:EnableCameraByTagAction("4", 1, 0)
	self:CameraMoveAction("4", 4, 4, 8, 0.6)
	self:PlayActorAnimationAction(9073, "summer_doubt", 0.2, 2, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11014006, "", 9073)
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
	self:OnNext(function(arg_44_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:PlayActorAnimationAction(9074, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11014007, "", 9074)
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
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:PlayActorAnimationAction(9073, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11014008, "", 9073)
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
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	self:PlayActorAnimationAction(9074, "think_start", 0.2, 1.333333, function()
		return
	end)
	self:PlayActorEmoteAction(9074, "squint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11014009, "", 9074)
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
	self:OnNext(function(arg_60_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:PlayActorAnimationAction(9073, "action2_1", 0.2, 1.666667, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11014010, "", 9073)
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
	self:OnNext(function(arg_66_0)
		self:ClearOnNext()
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:SetLookAtParamsAction(9074, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9074, "9073")
	self:PlayActorEmoteAction(9074, "blink", 0.1, 0.3333333, function()
		return
	end, true, false)
	self:PlayActorAnimationAction(9074, "think_end", 0.2, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11014011, "", 9074)
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
	self:OnNext(function(arg_72_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_13()
	end)
end

function var_0_0:BlackFadeDialogueNode_13()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:DestroyCharAction(9073)
		self:DestroyCharAction(9074)
		self:HideAllDynamicAction(false, false, 4095, {})
		self:Agent_PlayerPosControl("chuansong", function()
			self:EnableCameraByTagAction("", 1, 0)
		end)
		self:WalkingPeopleGlobleCull(false)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_14()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_14()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("LastWord", self.DialogueNode_12)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_14)
end

return var_0_0
