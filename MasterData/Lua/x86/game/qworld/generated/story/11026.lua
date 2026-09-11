BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11026", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11026"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11026"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(true, true, 4081, {
			50010,
			50015,
			50009,
			50014,
			50017
		})
		self:SetCharToTagAction(9514, "1", function()
			return
		end)
		self:SetCharToTagAction(9510, "2", function()
			return
		end)
		self:SetCharToTagAction(9072, "4", function()
			return
		end)
		self:SetCharToTagAction(9073, "3", function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:CameraMoveAction("1", 4, 2, 4, 0.4)
		self:PlayActorAnimationAction(9514, "summer_doubt_start", 0.05, 0.7666667, function()
			return
		end)
		self:SetLookAtParamsAction(9510, 0.8, 1, 1)
		self:LookAtRoleAction(true, 9510, "9514")
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
	self:ShowTalkView()
	self:SetTalkContent(11026001, "", 0)
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
	self:ShowTalkView()
	self:SetTalkContent(11026002, "", 0)
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
	self:OnNext(function(arg_21_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:ShowTalkView()
	self:SetTalkContent(11026003, "", 0)
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
	self:OnNext(function(arg_25_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:EnableCameraByTagAction("2", 1, 0)
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9073, "9510")
	self:SetLookAtParamsAction(9074, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9074, "9510")
	self:ActorSeekerAction(9073, {
		"5"
	}, 0.6, function()
		return
	end)
	self:ActorSeekerAction(9072, {
		"6"
	}, 0.6, function()
		return
	end)
	self:SetLookAtParamsAction(9510, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9510, "9073")
	self:DelayTimeAction(2, function()
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
	self:ShowTalkView()
	self:SetTalkContent(11026004, "", 9073)
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
	self:OnNext(function(arg_34_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:EnableCameraByTagAction("3", 1, 0)
	self:PlayActorAnimationAction(9514, "summer_doubt_start", 0.05, 0.7666667, function()
		return
	end)
	self:PlayActorEmoteAction(9514, "sad03_start", 0, 0.4666667, function()
		return
	end, true, true)
	self:CameraMoveAction("3", 4, 4, 2, 0.3)
	self:SetLookAtParamsAction(9510, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9510, "9514")
	self:DelayTimeAction(1, function()
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
	self:ShowTalkView()
	self:SetTalkContent(11026005, "", 9510)
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
	self:OnNext(function(arg_43_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:EnableCameraByTagAction("6", 1, 0)
	self:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9073, "9072")
	self:ShowTalkView()
	self:SetTalkContent(11026006, "", 9073)
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
	self:OnNext(function(arg_48_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:PlayActorAnimationAction(9072, "conversation_1", 0.05, 3, function()
		return
	end)
	self:SetLookAtParamsAction(9072, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9072, "9073")
	self:ShowTalkView()
	self:SetTalkContent(11026007, "", 9072)
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
	self:OnNext(function(arg_53_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:EnableCameraByTagAction("8", 1, 0)
	self:ActorSeekerAction(9072, {
		"8"
	}, 0.7, function()
		return
	end)
	self:ActorSeekerAction(9510, {
		"9"
	}, 0.5, function()
		return
	end)
	self:DelayTimeAction(1, function()
		self:ActorSeekerAction(9514, {
			"10"
		}, 0, function()
			return
		end)
		self:DelayTimeAction(1, function()
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
	self:ActorSeekerAction(9073, {
		"7"
	}, 0.5, function()
		return
	end)
	self:PlayActorAnimationAction(9514, "summer_doubt_end", 0.05, 0.4666667, function()
		return
	end)
	self:PlayActorEmoteAction(9514, "blink", 0, 0.3333333, function()
		return
	end, true, false)
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9073, "9514")
	self:SetLookAtParamsAction(9072, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9072, "9514")
	self:ShowTalkView()
	self:SetTalkContent(11026008, "", 9072)
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
	self:OnNext(function(arg_67_0)
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:EnableCameraByTagAction("9", 1, 0)
	self:PlayActorAnimationAction(9514, "troubled", 0.05, 3.666667, function()
		return
	end)
	self:SetLookAtParamsAction(9514, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9514, "9072")
	self:ShowTalkView()
	self:SetTalkContent(11026009, "", 9514)
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
	self:OnNext(function(arg_72_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:EnableCameraByTagAction("10", 1, 0)
	self:PlayActorAnimationAction(9072, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:DelayTimeAction(2, function()
		self:EnableCameraByTagAction("10_1", 2, 1)
		self:DelayTimeAction(1, function()
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
			self:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
				return
			end)
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11026010, "", 9072)
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
	self:OnNext(function(arg_82_0)
		self:ClearOnNext()
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:PlayActorAnimationAction(9073, "proud", 0.05, 2.333333, function()
		self:PlayActorAnimationAction(9073, "conversation_1", 0.05, 3, function()
			return
		end)
	end)
	self:EnableCameraByTagAction("11", 2, 1)
	self:PlayActorEmoteAction(9073, "happy01", 0, 1, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11026011, "", 9073)
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
	self:OnNext(function(arg_89_0)
		self:ClearOnNext()
		self:DialogueNode_13()
	end)
end

function var_0_0:DialogueNode_13()
	self:EnableCameraByTagAction("12", 1, 0)
	self:PlayActorAnimationAction(9514, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:CameraMoveAction("12", 4, 4, 5, 0.4)
	self:ShowTalkView()
	self:SetTalkContent(11026012, "", 9514)
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
	self:OnNext(function(arg_94_0)
		self:ClearOnNext()
		self:DialogueNode_14()
	end)
end

function var_0_0:DialogueNode_14()
	self:EnableCameraByTagAction("9", 1, 0)
	self:PlayActorAnimationAction(9514, "dizzy", 0.05, 7, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11026013, "", 9514)
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
		self:DialogueNode_15()
	end)
end

function var_0_0:DialogueNode_15()
	self:EnableCameraByTagAction("11", 1, 0)
	self:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11026014, "", 9073)
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
	self:OnNext(function(arg_104_0)
		self:ClearOnNext()
		self:DialogueNode_16()
	end)
end

function var_0_0:DialogueNode_16()
	self:EnableCameraByTagAction("15", 1, 0)
	self:PlayActorAnimationAction(9514, "summer_doubt", 0.05, 2, function()
		return
	end)
	self:SetLookAtParamsAction(9514, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9514, "9073")
	self:PlayActorEmoteAction(9514, "sad03", 0, 1.933333, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11026015, "", 9514)
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
	self:OnNext(function(arg_110_0)
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
end

function var_0_0:DialogueNode_17()
	self:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11026016, "", 9073)
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
	self:OnNext(function(arg_115_0)
		self:ClearOnNext()
		self:DialogueNode_18()
	end)
end

function var_0_0:DialogueNode_18()
	self:PlayActorAnimationAction(9514, "take", 0.05, 1.833333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11026017, "", 9514)
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
	self:OnNext(function(arg_120_0)
		self:ClearOnNext()
		self:DialogueNode_19()
	end)
end

function var_0_0:DialogueNode_19()
	self:PlayActorAnimationAction(9073, "conversation_1", 0.05, 3, function()
		return
	end)
	self:EnableCameraByTagAction("11", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11026018, "", 9073)
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
	self:OnNext(function(arg_125_0)
		self:ClearOnNext()
		self:DialogueNode_20()
	end)
end

function var_0_0:DialogueNode_20()
	self:EnableCameraByTagAction("9", 1, 0)
	self:PlayActorAnimationAction(9514, "think_loop", 0, 2, function()
		return
	end)
	self:PlayActorEmoteAction(9514, "squint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:CameraMoveAction("9", 4, 1, 5, 0.3)
	self:ShowTalkView()
	self:SetTalkContent(11026019, "", 9514)
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
	self:OnNext(function(arg_131_0)
		self:ClearOnNext()
		self:DialogueNode_21()
	end)
end

function var_0_0:DialogueNode_21()
	self:ShowTalkView()
	self:SetTalkContent(11026020, "", 9514)
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
	self:OnNext(function(arg_135_0)
		self:ClearOnNext()
		self:DialogueNode_22()
	end)
end

function var_0_0:DialogueNode_22()
	self:PlayActorAnimationAction(9514, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:PlayActorEmoteAction(9514, "squint01_end", 0, 0.4333335, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11026021, "", 9514)
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
	self:OnNext(function(arg_141_0)
		self:ClearOnNext()
		self:DialogueNode_23()
	end)
end

function var_0_0:DialogueNode_23()
	self:EnableCameraByTagAction("21", 1, 0)
	self:PlayActorAnimationAction(9073, "action2_1", 0.05, 1.666667, function()
		return
	end)
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9073, "9510")
	self:ShowTalkView()
	self:SetTalkContent(11026022, "", 9073)
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
	self:OnNext(function(arg_146_0)
		self:ClearOnNext()
		self:DialogueNode_24()
	end)
end

function var_0_0:DialogueNode_24()
	self:PlayActorAnimationAction(9510, "embarrassed", 0.05, 2.6, function()
		return
	end)
	self:SetLookAtParamsAction(9510, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9510, "9073")
	self:PlayActorEmoteAction(9510, "happy01", 0, 1, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11026023, "", 9510)
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
	self:OnNext(function(arg_152_0)
		self:ClearOnNext()
		self:DialogueNode_25()
	end)
end

function var_0_0:DialogueNode_25()
	self:PlayActorAnimationAction(9073, "proud_start", 0.05, 0.6, function()
		return
	end)
	self:EnableCameraByTagAction("24", 2, 1)
	self:SetLookAtParamsAction(9072, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9072, "9510")
	self:PlayActorAnimationAction(9072, "conversation_1", 0.05, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11026024, "", 9072)
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
	self:OnNext(function(arg_158_0)
		self:ClearOnNext()
		self:DialogueNode_26()
	end)
end

function var_0_0:DialogueNode_26()
	self:PlayActorEmoteAction(9073, "happy01", 0, 1, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11026025, "", 9073)
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
	self:OnNext(function(arg_163_0)
		self:ClearOnNext()
		self:DialogueNode_27()
	end)
end

function var_0_0:DialogueNode_27()
	self:PlayActorAnimationAction(9510, "summer_doubt_start", 0.05, 0.7666667, function()
		return
	end)
	self:PlayActorEmoteAction(9510, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11026026, "", 9510)
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
	self:OnNext(function(arg_169_0)
		self:ClearOnNext()
		self:DialogueNode_28()
	end)
end

function var_0_0:DialogueNode_28()
	self:EnableCameraByTagAction("27", 1, 0)
	self:PlayActorAnimationAction(9073, "stand_female", 0.05, 4, function()
		return
	end)
	self:CameraMoveAction("27", 4, 4, 6, 0.5)
	self:DelayTimeAction(4, function()
		self:EnableCameraByTagAction("27_1", 1, 0)
		self:CameraMoveAction("27_1", 4, 6, 2, 0.2)
		self:PlayActorEmoteAction(9073, "squint01", 0, 1.733333, function()
			return
		end, true, false)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11026027, "", 9073)
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
	self:OnNext(function(arg_176_0)
		self:ClearOnNext()
		self:DialogueNode_29()
	end)
end

function var_0_0:DialogueNode_29()
	self:EnableCameraByTagAction("28", 1, 0)
	self:PlayActorAnimationAction(9072, "conversation_1", 0.05, 3, function()
		return
	end)
	self:SetLookAtParamsAction(9072, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9072, "9073")
	self:HideAllDynamicAction(true, true, 4081, {
		50010,
		50015,
		50009,
		50014,
		50017
	})
	self:ShowTalkView()
	self:SetTalkContent(11026028, "", 9072)
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
	self:OnNext(function(arg_181_0)
		self:ClearOnNext()
		self:DialogueNode_30()
	end)
end

function var_0_0:DialogueNode_30()
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9073, "9510")
	self:ShowTalkView()
	self:SetTalkContent(11026029, "", 9073)
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
	self:OnNext(function(arg_185_0)
		self:ClearOnNext()
		self:DialogueNode_31()
	end)
end

function var_0_0:DialogueNode_31()
	self:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		self:EnableCameraByTagAction("30", 1, 0)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11026030, "", 9510)
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
	self:OnNext(function(arg_191_0)
		self:ClearOnNext()
		self:DialogueNode_32()
	end)
end

function var_0_0:DialogueNode_32()
	self:ShowTalkView()
	self:SetTalkContent(11026031, "", 9073)
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
	self:OnNext(function(arg_195_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_33()
	end)
end

function var_0_0:BlackFadeDialogueNode_33()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false, 4095, {})
		self:DestroyCharAction(9073)
		self:EnableCameraByTagAction("", 1, 0)
		self:DestroyCharAction(9072)
		self:DestroyCharAction(9510)
		self:DestroyCharAction(9514)
		self:WalkingPeopleGlobleCull(false)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_34()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_34()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.BlackFadeDialogueNode_33)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_34)
end

return var_0_0
