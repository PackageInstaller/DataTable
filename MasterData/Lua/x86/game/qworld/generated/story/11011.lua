BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11011", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11011"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11011"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.2, 0.2, function()
		self:SetCharToTagAction(9073, "2", function()
			return
		end)
		self:SetCharToTagAction(9074, "1", function()
			return
		end)
		self:SetCharToTagAction(9510, "3", function()
			return
		end)
		self:HideAllDynamicAction(true, true, 4083, {})
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
	self:PlayActorAnimationAction(9073, "action3_1", 0, 2.266667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11011001, "", 9073)
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
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:DelayTimeAction(2.5, function()
		self:BlackFadeAction(0.2, 0.2, 0.2, function()
			self:SetNeedClick(true, {
				Invoke = function()
					self:Next()
				end
			})
			self:SetNeedSkip(false, nil)
		end, function()
			self:EnableCameraByTagAction("2", 1, 0)
			self:CameraMoveAction("2", 4, 4, 4, 0.4)
		end)
	end)
	self:PlayActorAnimationAction(9074, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:SetLookAtParamsAction(9074, 0.8, 1, 0.7)
	self:LookAtRoleAction(true, 9074, "9073")
	self:ShowTalkView()
	self:SetTalkContent(11011002, "", 9074)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(false, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_25_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:SetLookAtParamsAction(9073, 0.8, 1, 0.7)
	self:LookAtRoleAction(true, 9073, "9510")
	self:PlayActorAnimationAction(9073, "think_loop", 0.1, 2, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11011003, "", 9073)
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
	self:OnNext(function(arg_30_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	self:SetLookAtParamsAction(9510, 0.8, 1, 0.7)
	self:LookAtRoleAction(true, 9510, "9073")
	self:PlayActorAnimationAction(9510, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11011004, "", 9510)
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
	self:EnableCameraByTagAction("3", 1, 0)
	self:PlayActorAnimationAction(9073, "summer_doubt_start", 0, 0.7666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11011005, "", 9073)
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
	self:PlayActorAnimationAction(9510, "conversation_1", 0.2, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11011006, "", 9510)
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
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:SetLookAtParamsAction(9074, 0.8, 1, 0.7)
	self:LookAtRoleAction(true, 9074, "9510")
	self:PlayActorEmoteAction(9074, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11011007, "", 0)
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
	self:OnNext(function(arg_50_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:SetLookAtParamsAction(9510, 0.8, 1, 0.7)
	self:LookAtRoleAction(true, 9510, "9074")
	self:PlayActorAnimationAction(9510, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	self:SetLookAtParamsAction(9073, 0.8, 1, 0.7)
	self:LookAtRoleAction(true, 9073, "9074")
	self:ShowTalkView()
	self:SetTalkContent(11011008, "", 0)
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
	self:OnNext(function(arg_55_0)
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:PlayActorAnimationAction(9073, "summer_doubt_end", 0.2, 0.4666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11011009, "", 0)
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
	self:PlayActorAnimationAction(9510, "conversation_1", 0.2, 3, function()
		return
	end)
	self:SetLookAtParamsAction(9510, 0.8, 1, 0.7)
	self:LookAtRoleAction(true, 9510, "9073")
	self:ShowTalkView()
	self:SetTalkContent(11011010, "", 0)
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
	self:OnBlackFade(false, 0, 0.2, 0.2, 0.2, function()
		self:DestroyCharAction(9073)
		self:DestroyCharAction(9074)
		self:DestroyCharAction(9510)
		self:HideAllDynamicAction(false, false, 4095, {})
		self:EnableCameraByTagAction("", 1, 0)
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
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_13)
end

return var_0_0
