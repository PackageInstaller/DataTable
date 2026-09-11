BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11038", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11038"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11038"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(true, true, 4093, {
			60015
		})
		self:SetCharToTagAction(9074, "1_0", function()
			return
		end)
		self:SetCharToTagAction(9060, "2_0", function()
			self:ActorSeekerAction(9060, {
				"2"
			}, 0.5, function()
				return
			end)
		end)
		self:SetCharToTagAction(907301, "3_0", function()
			self:DelayTimeAction(0.2, function()
				self:ActorSeekerAction(907301, {
					"3"
				}, 0.5, function()
					return
				end)
			end)
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:CameraMoveAction("1", 4, 4, 3, 0.4)
		self:PlayActorAnimationAction(9074, "think_loop", 0, 2, function()
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
	self:DelayTimeAction(2, function()
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
	self:SetTalkContent(11038001, "", 0)
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
	self:OnNext(function(arg_22_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:EnableCameraByTagAction("2", 1, 0)
	self:CameraMoveAction("2", 4, 5, 4, 0.4)
	self:DelayTimeAction(1.5, function()
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
	self:SetTalkContent(11038002, "", 0)
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
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:PlayActorAnimationAction(9060, "summer_doubt", 0.05, 2, function()
		return
	end)
	self:PlayActorEmoteAction(9060, "sad03", 0, 1.933333, function()
		return
	end, true, false)
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11038003, "", 0)
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
	self:OnNext(function(arg_35_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:ActorSeekerAction(9074, {
		"1"
	}, 0.5, function()
		self:PlayActorAnimationAction(9074, "conversation_2", 0.05, 3.166667, function()
			return
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11038004, "", 0)
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
	self:OnNext(function(arg_41_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:PlayActorAnimationAction(907301, "conversation_1", 0.05, 3, function()
		return
	end)
	self:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	self:SetLookAtParamsAction(907301, 0.8, 1, 1)
	self:LookAtRoleAction(true, 907301, "9074")
	self:ShowTalkView()
	self:SetTalkContent(11038005, "", 0)
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
	self:OnNext(function(arg_46_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:EnableCameraByTagAction("3", 1, 0)
	self:SetLookAtParamsAction(9060, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9060, "907301")
	self:DelayTimeAction(1.2, function()
		self:PlayActorAnimationAction(9060, "summer_shock", 0.05, 1.166667, function()
			return
		end)
	end)
	self:CameraMoveAction("3", 4, 3, 5, 0.4)
	self:ShowTalkView()
	self:SetTalkContent(11038006, "", 0)
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
	self:OnNext(function(arg_52_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:PlayActorAnimationAction(907301, "firm_start", 0.05, 0.5666667, function()
		return
	end)
	self:SetLookAtParamsAction(907301, 0.8, 1, 1)
	self:LookAtRoleAction(true, 907301, "9060")
	self:ShowTalkView()
	self:SetTalkContent(11038007, "", 0)
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
	self:OnNext(function(arg_57_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:ShowTalkView()
	self:SetTalkContent(11038008, "", 0)
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
	self:OnNext(function(arg_61_0)
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:PlayActorAnimationAction(9074, "speechless", 0.05, 3.333333, function()
		return
	end)
	self:EnableCameraByTagAction("4", 1, 0)
	self:PlayActorAnimationAction(907301, "firm_end", 0.05, 0.5000001, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11038009, "", 0)
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
	self:OnNext(function(arg_67_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:ShowTalkView()
	self:SetTalkContent(11038010, "", 0)
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
	self:OnNext(function(arg_71_0)
		self:ClearOnNext()
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:PlayActorAnimationAction(9060, "conversation_1", 0.05, 3, function()
		return
	end)
	self:PlayActorEmoteAction(9060, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:SetLookAtParamsAction(9060, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9060, "9074")
	self:ShowTalkView()
	self:SetTalkContent(11038011, "", 0)
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
	self:OnNext(function(arg_77_0)
		self:ClearOnNext()
		self:DialogueNode_13()
	end)
end

function var_0_0:DialogueNode_13()
	self:ShowTalkView()
	self:SetTalkContent(11038012, "", 0)
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
	self:OnNext(function(arg_81_0)
		self:ClearOnNext()
		self:DialogueNode_14()
	end)
end

function var_0_0:DialogueNode_14()
	self:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:SetLookAtParamsAction(907301, 0.8, 1, 1)
	self:LookAtRoleAction(true, 907301, "9060")
	self:ShowTalkView()
	self:SetTalkContent(11038013, "", 0)
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
	self:OnNext(function(arg_86_0)
		self:ClearOnNext()
		self:DialogueNode_15()
	end)
end

function var_0_0:DialogueNode_15()
	self:ShowTalkView()
	self:SetTalkContent(11038014, "", 0)
	self:SetChoice({
		Length = 0
	}, true)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_88_0)
		self:ClearOnNext()
		self:CloseChoice()
	end)
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("LastWord", self.DialogueNode_15)
end

return var_0_0
