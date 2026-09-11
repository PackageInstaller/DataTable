BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11034", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11034"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11034"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(true, true, 4081, {})
		self:SetCharToTagAction(907301, "9073_1", function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:CameraMoveAction("1", 4, 6, 2, 1)
		self:PlayActorAnimationAction(9070, "summer_shock_start", 0.05, 0.3333333, function()
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
	self:ShowTalkView()
	self:SetTalkContent(11034001, "", 9073)
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
	self:OnNext(function(arg_14_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:PlayActorAnimationAction(907301, "summer_doubt_end", 0.05, 0.4666667, function()
		return
	end)
	self:ActorSeekerAction(907301, {
		"1"
	}, 0.5, function()
		return
	end)
	self:SetCharToTagAction(9060, "9060_1", function()
		self:ActorSeekerAction(9060, {
			"2"
		}, 0.6, function()
			self:SetNeedClick(true, {
				Invoke = function()
					self:Next()
				end
			})
			self:SetNeedSkip(true, {
				Invoke = function()
					self:Skip("End")
				end
			})
		end)
	end)
	self:SetCharToTagAction(9510, "9510_1", function()
		self:DelayTimeAction(0.2, function()
			self:ActorSeekerAction(9510, {
				"3"
			}, 0.6, function()
				return
			end)
		end)
	end)
	self:DelayTimeAction(3.5, function()
		return
	end)
	self:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11034002, "", 9073)
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
	self:OnNext(function(arg_28_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:PlayActorAnimationAction(9060, "conversation_1", 0.05, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11034003, "", 9060)
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
	self:OnNext(function(arg_33_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:PlayActorEmoteAction(907301, "shocked01", 0, 1.4, function()
		self:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
			self:SetLookAtParamsAction(907301, 0.8, 1, 1)
			self:LookAtRoleAction(true, 907301, "9510")
			self:SetNeedClick(true, {
				Invoke = function()
					self:Next()
				end
			})
			self:SetNeedSkip(true, {
				Invoke = function()
					self:Skip("End")
				end
			})
		end)
	end, true, false)
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:SetLookAtParamsAction(907301, 0.8, 1, 1)
	self:LookAtRoleAction(true, 907301, "9060")
	self:ShowTalkView()
	self:SetTalkContent(11034004, "", 0)
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
	self:OnNext(function(arg_41_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11034005, "", 0)
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
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:PlayActorAnimationAction(907301, "embarrassed", 0.05, 2.6, function()
		self:PlayActorAnimationAction(907301, "excited_start", 0.05, 0.6666667, function()
			return
		end)
		self:PlayActorEmoteAction(907301, "anger02_start", 0, 0.5, function()
			return
		end, true, true)
	end)
	self:PlayActorEmoteAction(907301, "complaint02", 0, 1.466667, function()
		return
	end, true, false)
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11034006, "", 0)
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
	self:OnNext(function(arg_54_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:PlayActorAnimationAction(9510, "think_start", 0.05, 1.333333, function()
		return
	end)
	self:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	self:DelayTimeAction(2, function()
		self:PlayActorAnimationAction(9510, "think_end", 0.05, 1.666667, function()
			self:PlayActorAnimationAction(9510, "conversation_2", 0.1, 3.166667, function()
				return
			end)
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11034007, "", 0)
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
	self:OnNext(function(arg_62_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:PlayActorEmoteAction(907301, "", 0, 0, function()
		return
	end, false, false)
	self:PlayActorAnimationAction(907301, "excited_end", 0.05, 0.6666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11034008, "", 0)
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
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:PlayActorAnimationAction(9060, "proud_start", 0.05, 0.6, function()
		return
	end)
	self:PlayActorEmoteAction(9060, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:EnableCameraByTagAction("9", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11034009, "", 0)
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
	self:OnNext(function(arg_74_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		self:SetLookAtParamsAction(907301, 0.8, 1, 1)
		self:LookAtRoleAction(true, 907301, "9060")
	end)
	self:EnableCameraByTagAction("4", 1, 0)
	self:SetLookAtParamsAction(907301, 0.8, 1, 1)
	self:LookAtRoleAction(true, 907301, "9510")
	self:CameraMoveAction("4", 4, 4, 6, 0.6)
	self:ShowTalkView()
	self:SetTalkContent(11034010, "", 0)
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
	self:OnNext(function(arg_79_0)
		self:ClearOnNext()
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:ShowTalkView()
	self:SetTalkContent(11034011, "", 0)
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
	self:OnNext(function(arg_83_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_13()
	end)
end

function var_0_0:BlackFadeDialogueNode_13()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false, 4095, {})
		self:DestroyCharAction(907301)
		self:EnableCameraByTagAction("", 1, 0)
		self:DestroyCharAction(9060)
		self:DestroyCharAction(9510)
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
	self:RegisterTalkFunction("End", self.BlackFadeDialogueNode_13)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_14)
end

return var_0_0
