BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10015", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "10015"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/10015"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.2, 0.2, function()
		self:SetCharToTagAction(9509, "9509_1", function()
			return
		end)
		self:SetCharToTagAction(9070, "9070_1", function()
			return
		end)
		self:HideAllDynamicAction(true, true)
		self:EnableCameraByTagAction("1", 1, 0)
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
	self:DelayTimeAction(3, function()
		self:PlayActorAnimationAction(9070, "summer_doubt", 0, 2, function()
			return
		end)
		self:SetNeedClick(true, {
			Invoke = function()
				self:Next()
			end
		})
		self:SetNeedSkip(false, nil)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10015001, "", 9070)
	self:SetNeedSkip(false, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(false, {
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
	self:EnableCameraByTagAction("2", 1, 0)
	self:PlayActorAnimationAction(9070, "summer_doubt", 0, 2, function()
		return
	end)
	self:PlayActorEmoteAction(9070, "sad03", 0, 1.933333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(10015002, "", 9070)
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
	self:OnNext(function(arg_23_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:ActorSeekerAction(9509, {
		"9509_2"
	}, 0.5, function()
		return
	end)
	self:EnableCameraByTagAction("3", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(10015003, "", 9509)
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
	self:OnNext(function(arg_28_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:EnableCameraByTagAction("4", 1, 0)
	self:CameraMoveAction("4", 4, 1, 0.2, 0.6)
	self:PlayActorEmoteAction(9070, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	self:DelayTimeAction(1.4, function()
		self:ActorSeekerAction(9070, {
			"9070_2"
		}, 2.1, function()
			return
		end)
		self:EnableCameraByTagAction("4_1", 1, 0)
		self:CameraMoveAction("4_1", 4, 5, 4, 0.6)
		self:DelayTimeAction(3, function()
			self:SetNeedClick(true, {
				Invoke = function()
					self:Next()
				end
			})
			self:SetNeedSkip(false, nil)
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10015004, "", 9070)
	self:SetNeedSkip(false, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(false, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_37_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:EnableCameraByTagAction("5", 1, 0)
	self:PlayActorAnimationAction(9509, "happy02", 0, 3, function()
		return
	end)
	self:DelayTimeAction(1, function()
		self:SetNeedClick(true, {
			Invoke = function()
				self:Next()
			end
		})
		self:SetNeedSkip(false, nil)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10015005, "", 9509)
	self:SetNeedSkip(false, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(false, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_44_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:EnableCameraByTagAction("6", 1, 0)
	self:PlayActorAnimationAction(9070, "stroke01", 0, 9.066668, function()
		return
	end)
	self:CameraMoveAction("6", 4, 1, 8, 0.4)
	self:PlayActorEmoteAction(9070, "shocked01_start", 0, 0.3666667, function()
		return
	end, false, false)
	self:ShowTalkView()
	self:SetTalkContent(10015006, "", 9070)
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
	self:OnNext(function(arg_50_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:PlayActorAnimationAction(9509, "dorm_male_idle01", 0, 8.166667, function()
		return
	end)
	self:EnableCameraByTagAction("7", 1, 0)
	self:CameraMoveAction("7", 4, 4, 6, 0.4)
	self:DelayTimeAction(2, function()
		self:SetNeedClick(true, {
			Invoke = function()
				self:Next()
			end
		})
		self:SetNeedSkip(false, nil)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10015007, "", 9509)
	self:SetNeedSkip(false, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(false, {
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
	self:EnableCameraByTagAction("8", 1, 0)
	self:CameraMoveAction("8", 4, 4, 6, 0.3)
	self:ActorSeekerAction(9509, {
		"9509_3"
	}, 0.5, function()
		return
	end)
	self:DelayTimeAction(1.8, function()
		self:PlayActorAnimationAction(9509, "action2_1", 0, 1.666667, function()
			return
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10015008, "", 9509)
	self:SetChoice({
		[0] = {
			id = 10015009,
			icon = "",
			Invoke = function()
				self:Next(10015009)
			end
		},
		{
			id = 10015014,
			icon = "",
			Invoke = function()
				self:Next(10015014)
			end
		},
		{
			id = 10015020,
			icon = "",
			Invoke = function()
				self:Next(10015020)
			end
		},
		Length = 3
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_65_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_65_0 == 10015009 then
			self:DialogueBranchNode_10()
		elseif arg_65_0 == 10015014 then
			self:DialogueBranchNode_11()
		elseif arg_65_0 == 10015020 then
			self:DialogueBranchNode_12()
		end
	end)
end

function var_0_0:DialogueBranchNode_10()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_13()
	end)
	self:Next()
end

function var_0_0:DialogueNode_13()
	self:EnableCameraByTagAction("9", 1, 0)
	self:PlayActorAnimationAction(9070, "action4_1", 0, 2.666667, function()
		return
	end)
	self:DelayTimeAction(2.5, function()
		self:SetNeedClick(true, {
			Invoke = function()
				self:Next()
			end
		})
		self:SetNeedSkip(false, nil)
	end)
	self:PlayActorAnimationAction(9509, "action2_3", 0, 1.333333, function()
		return
	end)
	self:PlayActorEmoteAction(9070, "laugh01", 0, 0.9333334, function()
		return
	end, false, false)
	self:ShowTalkView()
	self:SetTalkContent(10015010, "", 9509)
	self:SetNeedSkip(false, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(false, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_76_0)
		self:ClearOnNext()
		self:DialogueNode_14()
	end)
end

function var_0_0:DialogueNode_14()
	self:PlayActorAnimationAction(9070, "summer_doubt", 0.2, 2, function()
		return
	end)
	self:PlayActorEmoteAction(9070, "laugh01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:EnableCameraByTagAction("11", 1, 0)
	self:CameraMoveAction("11", 4, 6, 8, 0.4)
	self:ShowTalkView()
	self:SetTalkContent(10015011, "", 9070)
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
	self:OnNext(function(arg_82_0)
		self:ClearOnNext()
		self:DialogueNode_15()
	end)
end

function var_0_0:DialogueNode_15()
	self:EnableCameraByTagAction("12", 1, 0)
	self:CameraMoveAction("12", 4, 6, 6, 0.2)
	self:PlayActorEmoteAction(9509, "disdain01_start", 0, 0.4, function()
		return
	end, true, true)
	self:PlayActorAnimationAction(9509, "action2_1", 0, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10015012, "", 9509)
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
	self:OnNext(function(arg_88_0)
		self:ClearOnNext()
		self:DialogueNode_16()
	end)
end

function var_0_0:DialogueNode_16()
	self:EnableCameraByTagAction("13", 1, 0)
	self:PlayActorAnimationAction(9070, "stroke01", 0, 9.066668, function()
		return
	end)
	self:PlayActorEmoteAction(9070, "disdain01_start", 0, 0.4, function()
		return
	end, false, false)
	self:ShowTalkView()
	self:SetTalkContent(10015013, "", 9070)
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
	self:OnNext(function(arg_94_0)
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
end

function var_0_0:DialogueNode_17()
	self:EnableCameraByTagAction("25", 1, 0)
	self:CameraMoveAction("25", 4, 4, 8, 0.6)
	self:PlayActorAnimationAction(9509, "action2_3", 0, 1.333333, function()
		return
	end)
	self:PlayActorEmoteAction(9509, "", 0, 0, function()
		return
	end, false, false)
	self:ShowTalkView()
	self:SetTalkContent(10015025, "", 9509)
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
	self:OnNext(function(arg_100_0)
		self:ClearOnNext()
		self:DialogueNode_18()
	end)
end

function var_0_0:DialogueNode_18()
	self:EnableCameraByTagAction("25", 1, 0)
	self:PlayActorAnimationAction(9070, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10015026, "", 9070)
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
	self:OnNext(function(arg_105_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_19()
	end)
end

function var_0_0:BlackFadeDialogueNode_19()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.5, 0.2, 0.2, function()
		self:HideAllDynamicAction(false, false)
		self:EnableCameraByTagAction("", 1, 0)
		self:DestroyCharAction(9070)
		self:DestroyCharAction(9509)
		self:Agent_PlayerPosControl("9070_2", function()
			return
		end)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_20()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_20()
	self:EndStory()
end

function var_0_0:DialogueBranchNode_11()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_21()
	end)
	self:Next()
end

function var_0_0:DialogueNode_21()
	self:EnableCameraByTagAction("9", 1, 0)
	self:PlayActorAnimationAction(9070, "stroke02", 0, 5.166667, function()
		return
	end)
	self:PlayActorAnimationAction(9509, "action2_1", 0, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10015015, "", 9509)
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
	self:OnNext(function(arg_119_0)
		self:ClearOnNext()
		self:DialogueNode_22()
	end)
end

function var_0_0:DialogueNode_22()
	self:EnableCameraByTagAction("16", 1, 0)
	self:CameraMoveAction("16", 4, 4, 8, 0.6)
	self:PlayActorAnimationAction(9070, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10015016, "", 9070)
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
	self:OnNext(function(arg_124_0)
		self:ClearOnNext()
		self:DialogueNode_23()
	end)
end

function var_0_0:DialogueNode_23()
	self:EnableCameraByTagAction("17", 1, 0)
	self:PlayActorAnimationAction(9070, "summer_doubt", 0, 2, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10015017, "", 9070)
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
	self:OnNext(function(arg_129_0)
		self:ClearOnNext()
		self:DialogueNode_24()
	end)
end

function var_0_0:DialogueNode_24()
	self:EnableCameraByTagAction("18", 1, 0)
	self:PlayActorAnimationAction(9509, "action2_1", 0, 1.666667, function()
		return
	end)
	self:CameraMoveAction("18", 4, 1, 6, 0.4)
	self:ShowTalkView()
	self:SetTalkContent(10015018, "", 9509)
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
	self:OnNext(function(arg_134_0)
		self:ClearOnNext()
		self:DialogueNode_25()
	end)
end

function var_0_0:DialogueNode_25()
	self:PlayActorAnimationAction(9070, "stroke01", 0, 9.066668, function()
		return
	end)
	self:EnableCameraByTagAction("19", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(10015019, "", 9070)
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
	self:OnNext(function(arg_139_0)
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
end

function var_0_0:DialogueBranchNode_12()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_26()
	end)
	self:Next()
end

function var_0_0:DialogueNode_26()
	self:EnableCameraByTagAction("9", 1, 0)
	self:PlayActorAnimationAction(9070, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:CameraMoveAction("9", 4, 2, 10, 0.7)
	self:ShowTalkView()
	self:SetTalkContent(10015021, "", 0)
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
	self:OnNext(function(arg_146_0)
		self:ClearOnNext()
		self:DialogueNode_27()
	end)
end

function var_0_0:DialogueNode_27()
	self:EnableCameraByTagAction("22", 1, 0)
	self:CameraMoveAction("22", 4, 1, 1, 0.5)
	self:PlayActorAnimationAction(9509, "action2_1", 0, 1.666667, function()
		return
	end)
	self:PlayActorEmoteAction(9509, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(10015022, "", 0)
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
	self:OnNext(function(arg_152_0)
		self:ClearOnNext()
		self:DialogueNode_28()
	end)
end

function var_0_0:DialogueNode_28()
	self:EnableCameraByTagAction("23", 1, 0)
	self:PlayActorAnimationAction(9070, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10015023, "", 0)
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
	self:OnNext(function(arg_157_0)
		self:ClearOnNext()
		self:DialogueNode_29()
	end)
end

function var_0_0:DialogueNode_29()
	self:PlayActorAnimationAction(9070, "stroke01", 0.2, 9.066668, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10015024, "", 0)
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
	self:OnNext(function(arg_162_0)
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_20)
end

return var_0_0
