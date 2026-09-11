BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11022", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11022"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11022"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(true, true, 4095, {})
		self:EnableCameraByTagAction("1", 1, 0)
		self:SetCharToTagAction(9510, "3", function()
			return
		end)
		self:SetCharToTagAction(9515, "4", function()
			return
		end)
		self:SetCharToTagAction(9073, "2", function()
			return
		end)
		self:ActorSeekerAction(9073, {
			"6"
		}, 0.5, function()
			return
		end)
		self:PlayActorAnimationAction(9515, "speechless_start", 0.05, 0.5333334, function()
			return
		end)
		self:DelayTimeAction(0.2, function()
			self:ActorSeekerAction(9510, {
				"7"
			}, 0.5, function()
				return
			end)
		end)
		self:SetCharToTagAction(9072, "1", function()
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
	self:SetTalkContent(11022001, "", 9073)
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
	self:OnNext(function(arg_20_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:EnableCameraByTagAction("2", 1, 0)
	self:ActorSeekerAction(9072, {
		"8"
	}, 0.5, function()
		self:PlayActorAnimationAction(9072, "conversation_2", 0.05, 3.166667, function()
			return
		end)
		self:PlayActorEmoteAction(9072, "complaint02", 0, 1.466667, function()
			return
		end, true, false)
	end)
	self:CameraMoveAction("2", 4, 3, 5, 0.5)
	self:ShowTalkView()
	self:SetTalkContent(11022002, "", 9072)
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
	self:OnNext(function(arg_27_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:PlayActorAnimationAction(9073, "summer_doubt", 0.05, 2, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "shocked01", 0, 1.4, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11022003, "", 9073)
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
	self:EnableCameraByTagAction("4", 1, 0)
	self:CameraMoveAction("4", 4, 1, 5, 0.5)
	self:ShowTalkView()
	self:SetTalkContent(11022004, "", 9510)
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
	self:OnNext(function(arg_37_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:EnableCameraByTagAction("5", 1, 0)
	self:PlayActorAnimationAction(9072, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:CameraMoveAction("5", 4, 6, 5, 0.3)
	self:ShowTalkView()
	self:SetTalkContent(11022005, "", 9072)
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
	self:OnNext(function(arg_42_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:EnableCameraByTagAction("6", 1, 0)
	self:PlayActorAnimationAction(9073, "summer_doubt", 0.05, 2, function()
		return
	end)
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9073, "9072")
	self:SetLookAtParamsAction(9510, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9510, "9072")
	self:ShowTalkView()
	self:SetTalkContent(11022006, "", 9073)
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
	self:OnNext(function(arg_47_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:PlayActorAnimationAction(9510, "embarrassed", 0.05, 2.6, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11022007, "", 9510)
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
	self:PlayActorEmoteAction(9072, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	self:ActorSeekerAction(9072, {
		"5"
	}, 0.7, function()
		self:PlayActorAnimationAction(9072, "action2_1", 0.05, 1.666667, function()
			return
		end)
	end)
	self:DelayTimeAction(1, function()
		self:EnableCameraByTagAction("8", 1, 0)
	end)
	self:PlayActorEmoteAction(9073, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	self:PlayActorEmoteAction(9510, "shocked01", 0, 1.4, function()
		return
	end, true, false)
	self:SetCharToTagAction(9515, "9", function()
		return
	end)
	self:DelayTimeAction(2.8, function()
		self:SetNeedClick(true, {
			Invoke = function()
				self:Next()
			end
		})
		self:SetNeedSkip(false, nil)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11022008, "", 9072)
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
	self:OnNext(function(arg_65_0)
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:PlayActorEmoteAction(9073, "complaint02_start", 0, 0.4, function()
		return
	end, true, true)
	self:ActorSeekerAction(9073, {
		"10"
	}, 2.5, function()
		self:PlayActorAnimationAction(9073, "angry01", 0.05, 4.333333, function()
			return
		end)
	end)
	self:ActorSeekerAction(9510, {
		"11"
	}, 2.5, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11022009, "", 9073)
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
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:PlayActorAnimationAction(9515, "stand_female", 0, 4, function()
		return
	end)
	self:PlayActorEmoteAction(9072, "happy01_end", 0, 0.2666667, function()
		return
	end, true, false)
	self:CameraMoveAction("10", 4, 6, 5, 0.2)
	self:EnableCameraByTagAction("10", 1, 0)
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
	self:SetTalkContent(11022010, "", 9072)
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
	self:EnableCameraByTagAction("11", 1, 0)
	self:PlayActorAnimationAction(9515, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11022011, "", 9515)
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
	self:OnNext(function(arg_87_0)
		self:ClearOnNext()
		self:DialogueNode_13()
	end)
end

function var_0_0:DialogueNode_13()
	self:EnableCameraByTagAction("12", 1, 0)
	self:PlayActorAnimationAction(9072, "action2_1", 0.05, 1.666667, function()
		return
	end)
	self:CameraMoveAction("12", 4, 4, 5, 0.4)
	self:PlayActorAnimationAction(9073, "embarrassed", 0.05, 2.6, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "blink", 0, 0.3333333, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11022012, "", 9072)
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
	self:EnableCameraByTagAction("13", 1, 0)
	self:PlayActorAnimationAction(9515, "speechless_start", 0.05, 0.5333334, function()
		return
	end)
	self:PlayActorEmoteAction(9515, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11022013, "", 9515)
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
	self:OnNext(function(arg_100_0)
		self:ClearOnNext()
		self:DialogueNode_15()
	end)
end

function var_0_0:DialogueNode_15()
	self:EnableCameraByTagAction("14", 1, 0)
	self:PlayActorAnimationAction(9072, "action2_3", 0.05, 1.333333, function()
		return
	end)
	self:PlayActorEmoteAction(9072, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11022014, "", 9072)
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
	self:OnNext(function(arg_106_0)
		self:ClearOnNext()
		self:DialogueNode_16()
	end)
end

function var_0_0:DialogueNode_16()
	self:EnableCameraByTagAction("15", 1, 0)
	self:PlayActorAnimationAction(9515, "action2_1", 0.05, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11022015, "", 9515)
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
	self:OnNext(function(arg_111_0)
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
end

function var_0_0:DialogueNode_17()
	self:PlayActorAnimationAction(9072, "action2_1", 0.05, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11022016, "", 9072)
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
	self:OnNext(function(arg_116_0)
		self:ClearOnNext()
		self:DialogueNode_18()
	end)
end

function var_0_0:DialogueNode_18()
	self:EnableCameraByTagAction("13", 1, 0)
	self:PlayActorAnimationAction(9515, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:PlayActorEmoteAction(9515, "anger02_start", 0, 0.5, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11022017, "", 9515)
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
	self:OnNext(function(arg_122_0)
		self:ClearOnNext()
		self:DialogueNode_19()
	end)
end

function var_0_0:DialogueNode_19()
	self:EnableCameraByTagAction("14", 1, 0)
	self:PlayActorEmoteAction(9072, "happy01_end", 0, 0.2666667, function()
		return
	end, true, false)
	self:DelayTimeAction(1.5, function()
		self:PlayActorAnimationAction(9072, "take", 0.05, 1.833333, function()
			return
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11022018, "", 9072)
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
	self:OnNext(function(arg_129_0)
		self:ClearOnNext()
		self:DialogueNode_20()
	end)
end

function var_0_0:DialogueNode_20()
	self:EnableCameraByTagAction("15", 1, 0)
	self:PlayActorEmoteAction(9515, "shocked01", 0, 1.4, function()
		self:PlayActorAnimationAction(9515, "summer_doubt", 0.05, 2, function()
			return
		end)
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11022019, "", 9515)
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
		self:DialogueNode_21()
	end)
end

function var_0_0:DialogueNode_21()
	self:EnableCameraByTagAction("14", 1, 0)
	self:PlayActorAnimationAction(9072, "conversation_1", 0.05, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11022020, "", 9072)
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
	self:OnNext(function(arg_140_0)
		self:ClearOnNext()
		self:DialogueNode_22()
	end)
end

function var_0_0:DialogueNode_22()
	self:EnableCameraByTagAction("11", 1, 0)
	self:PlayActorEmoteAction(9073, "shocked01", 0, 1.4, function()
		return
	end, true, false)
	self:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_story_04_mingshi", "", "")
	self:ShowTalkView()
	self:SetTalkContent(11022021, "", 9515)
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
	self:OnNext(function(arg_145_0)
		self:ClearOnNext()
		self:DialogueNode_23()
	end)
end

function var_0_0:DialogueNode_23()
	self:PlayActorAnimationAction(9072, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11022022, "", 9072)
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
	self:OnNext(function(arg_150_0)
		self:ClearOnNext()
		self:DialogueNode_24()
	end)
end

function var_0_0:DialogueNode_24()
	self:EnableCameraByTagAction("13", 1, 0)
	self:PlayActorAnimationAction(9515, "think_loop", 0.05, 2, function()
		return
	end)
	self:PlayActorEmoteAction(9515, "disdain01_start", 0, 0.4, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11022023, "", 9515)
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
	self:OnNext(function(arg_156_0)
		self:ClearOnNext()
		self:DialogueNode_25()
	end)
end

function var_0_0:DialogueNode_25()
	self:EnableCameraByTagAction("24_1", 1, 0)
	self:PlayActorAnimationAction(9072, "conversation_1", 0.05, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11022024, "", 9072)
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
	self:OnNext(function(arg_161_0)
		self:ClearOnNext()
		self:DialogueNode_26()
	end)
end

function var_0_0:DialogueNode_26()
	self:EnableCameraByTagAction("15", 1, 0)
	self:PlayActorAnimationAction(9515, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:PlayActorEmoteAction(9515, "blink", 0, 0.3333333, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11022025, "", 9515)
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
	self:OnNext(function(arg_167_0)
		self:ClearOnNext()
		self:DialogueNode_27()
	end)
end

function var_0_0:DialogueNode_27()
	self:EnableCameraByTagAction("24", 1, 0)
	self:PlayActorAnimationAction(9072, "take", 0.05, 1.833333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11022026, "", 9072)
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
	self:OnNext(function(arg_172_0)
		self:ClearOnNext()
		self:DialogueNode_28()
	end)
end

function var_0_0:DialogueNode_28()
	self:PlayActorEmoteAction(9073, "disdain01_start", 0, 0.4, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11022027, "", 9515)
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
	self:OnNext(function(arg_177_0)
		self:ClearOnNext()
		self:DialogueNode_29()
	end)
end

function var_0_0:DialogueNode_29()
	self:ShowTalkView()
	self:SetTalkContent(11022028, "", 9073)
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
	self:EnableCameraByTagAction("13", 1, 0)
	self:PlayActorAnimationAction(9515, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:PlayActorEmoteAction(9515, "disdain01_end", 0, 0.4333334, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11022029, "", 9515)
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
	self:OnNext(function(arg_187_0)
		self:ClearOnNext()
		self:DialogueNode_31()
	end)
end

function var_0_0:DialogueNode_31()
	self:EnableCameraByTagAction("14", 1, 0)
	self:PlayActorEmoteAction(9072, "shocked01", 0, 1.4, function()
		self:PlayActorAnimationAction(9072, "conversation_1", 0.05, 3, function()
			return
		end)
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11022030, "", 9072)
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
	self:OnNext(function(arg_193_0)
		self:ClearOnNext()
		self:DialogueNode_32()
	end)
end

function var_0_0:DialogueNode_32()
	self:EnableCameraByTagAction("15", 1, 0)
	self:PlayActorAnimationAction(9515, "think_loop", 0, 2, function()
		return
	end)
	self:PlayActorEmoteAction(9515, "disdain01", 0, 1.566667, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11022031, "", 9515)
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
	self:OnNext(function(arg_199_0)
		self:ClearOnNext()
		self:DialogueNode_33()
	end)
end

function var_0_0:DialogueNode_33()
	self:ActorSeekerAction(9072, {
		"22"
	}, 0.5, function()
		self:PlayActorAnimationAction(9072, "take", 0.05, 1.833333, function()
			return
		end)
	end)
	self:DelayTimeAction(1, function()
		self:SetLookAtParamsAction(9510, 0.8, 1, 1)
		self:LookAtRoleAction(true, 9510, "9072")
		self:EnableCameraByTagAction("32", 1, 0)
		self:SetLookAtParamsAction(9073, 0.8, 1, 1)
		self:LookAtRoleAction(true, 9073, "9072")
	end)
	self:ShowTalkView()
	self:SetTalkContent(11022032, "", 9072)
	self:SetChoice({
		[0] = {
			id = 11022033,
			icon = "",
			Invoke = function()
				self:Next(11022033)
			end
		},
		{
			id = 11022034,
			icon = "",
			Invoke = function()
				self:Next(11022034)
			end
		},
		Length = 2
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_206_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_206_0 == 11022033 then
			self:DialogueBranchNode_34()
		elseif arg_206_0 == 11022034 then
			self:DialogueBranchNode_35()
		end
	end)
end

function var_0_0:DialogueBranchNode_34()
	self:OnNext(function()
		self:ClearOnNext()
		self:PureActorDialogueNode_36()
	end)
	self:Next()
end

function var_0_0:PureActorDialogueNode_36()
	self:EnableCameraByTagAction("33", 1, 0)
	self:PlayActorEmoteAction(9073, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	self:CameraMoveAction("33", 4, 1, 1, 0.35)
	self:DelayTimeAction(2, function()
		self:EventAction(function()
			self:ImmediateNextFlag(-1)
		end)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_37()
	end)
end

function var_0_0:DialogueNode_37()
	self:EnableCameraByTagAction("35", 1, 0)
	self:PlayActorAnimationAction(9072, "summer_doubt", 0.05, 2, function()
		self:PlayActorAnimationAction(9072, "conversation_2", 0.05, 3.166667, function()
			return
		end)
	end)
	self:PlayActorEmoteAction(9072, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11022035, "", 9072)
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
	self:OnNext(function(arg_220_0)
		self:ClearOnNext()
		self:DialogueNode_38()
	end)
end

function var_0_0:DialogueNode_38()
	self:PlayActorEmoteAction(9073, "happy01_start", 0, 0.1333333, function()
		return
	end, false, false)
	self:PlayActorAnimationAction(9073, "action3_1", 0.05, 2.266667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11022036, "", 9073)
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
	self:OnNext(function(arg_226_0)
		self:ClearOnNext()
		self:DialogueNode_39()
	end)
end

function var_0_0:DialogueNode_39()
	self:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11022037, "", 9510)
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
	self:OnNext(function(arg_231_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_40()
	end)
end

function var_0_0:BlackFadeDialogueNode_40()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false, 4095, {})
		self:EnableCameraByTagAction("", 1, 0)
		self:DestroyCharAction(9072)
		self:DestroyCharAction(9073)
		self:DestroyCharAction(9515)
		self:DestroyCharAction(9510)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_41()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_41()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:DialogueBranchNode_35()
	self:OnNext(function()
		self:ClearOnNext()
		self:PureActorDialogueNode_36()
	end)
	self:Next()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.BlackFadeDialogueNode_40)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_41)
end

return var_0_0
