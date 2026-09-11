BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10017", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "10017"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/10017"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:SetCharToTagAction(9070, "9070_1", function()
			return
		end)
		self:SetCharToTagAction(9509, "9509_1", function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:DelayTimeAction(0.2, function()
			self:EnableCameraByTagAction("1_1", 2, 0.8)
		end)
		self:HideAllDynamicAction(true, true)
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
	self:PlayActorEmoteAction(9509, "shocked01_start", 0.2, 0.3666667, function()
		return
	end, true, true)
	self:DelayTimeAction(2, function()
		self:PlayActorAnimationAction(9509, "happy02", 0.2, 3, function()
			return
		end)
		self:SetNeedClick(true, {
			Invoke = function()
				self:Next()
			end
		})
		self:SetNeedSkip(false, nil)
		self:PlayActorEmoteAction(9509, "shocked01_end", 0.2, 0.4000001, function()
			return
		end, true, false)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10017001, "", 9509)
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
	self:OnNext(function(arg_20_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:EnableCameraByTagAction("2", 1, 0)
	self:PlayActorEmoteAction(9070, "fear01", 0.2, 3.166667, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(10017002, "", 9070)
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
	self:OnNext(function(arg_25_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:ShowTalkView()
	self:SetTalkContent(10017003, "", 9509)
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
	self:OnNext(function(arg_29_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:PlayActorAnimationAction(9070, "summer_doubt", 0.2, 2, function()
		return
	end)
	self:EnableCameraByTagAction("4", 1, 0)
	self:DelayTimeAction(0.1, function()
		self:EnableCameraByTagAction("4_1", 2, 6)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10017004, "", 9070)
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
	self:OnNext(function(arg_35_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:PlayActorAnimationAction(9509, "conversation_1", 0.2, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10017005, "", 9509)
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
	self:OnNext(function(arg_40_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:PlayActorAnimationAction(9070, "sad_01", 0.2, 6.166667, function()
		return
	end)
	self:EnableCameraByTagAction("6", 1, 0)
	self:CameraMoveAction("6", 4, 1, 6, 0.2)
	self:ShowTalkView()
	self:SetTalkContent(10017006, "", 9070)
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
	self:OnNext(function(arg_45_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:DelayTimeAction(2.5, function()
		self:BlackFadeAction(0.2, 0.3, 0.3, function()
			self:EnableCameraByTagAction("7-2", 2, 7)
			self:SetNeedClick(true, {
				Invoke = function()
					self:Next()
				end
			})
			self:SetNeedSkip(false, nil)
		end, function()
			self:EnableCameraByTagAction("7-1", 1, 0)
			self:HideAllDynamicAction(true, true)
		end)
	end)
	self:DelayTimeAction(4.1, function()
		return
	end)
	self:EnableCameraByTagAction("7_0", 2, 3)
	self:ShowTalkView()
	self:SetTalkContent(10017007, "", 9070)
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
	self:OnNext(function(arg_54_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_9()
	end)
end

function var_0_0:BlackFadeDialogueNode_9()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:EnableCameraByTagAction("8", 1, 0)
		self:HideAllDynamicAction(false, false)
		self:CameraMoveAction("8", 4, 4, 4, 0.5)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:DialogueNode_10()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:DialogueNode_10()
	self:DelayTimeAction(3, function()
		self:BlackFadeAction(0.2, 0.3, 0.3, function()
			return
		end, function()
			self:EnableCameraByTagAction("8_1", 1, 0)
			self:CameraMoveAction("8_1", 4, 4, 4, 0.2)
		end)
	end)
	self:DelayTimeAction(6, function()
		self:BlackFadeAction(0.2, 0.3, 0.3, function()
			self:SetNeedClick(true, {
				Invoke = function()
					self:Next()
				end
			})
			self:SetNeedSkip(false, nil)
			self:PlayActorAnimationAction(9070, "sad_02", 0.2, 6.733334, function()
				return
			end)
		end, function()
			self:EnableCameraByTagAction("8_3", 1, 0)
			self:HideAllDynamicAction(true, true)
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10017008, "", 9070)
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
	self:OnNext(function(arg_70_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:EnableCameraByTagAction("9", 1, 0)
	self:PlayActorAnimationAction(9509, "conversation_1", 0.2, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10017009, "", 9509)
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
	self:OnNext(function(arg_75_0)
		self:ClearOnNext()
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:PlayActorAnimationAction(9070, "action4_1", 0.2, 2.666667, function()
		return
	end)
	self:EnableCameraByTagAction("10", 1, 0)
	self:DelayTimeAction(0.1, function()
		self:EnableCameraByTagAction("10_1", 2, 7)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10017010, "", 9070)
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
	self:OnNext(function(arg_81_0)
		self:ClearOnNext()
		self:DialogueNode_13()
	end)
end

function var_0_0:DialogueNode_13()
	self:EnableCameraByTagAction("11", 1, 0)
	self:PlayActorAnimationAction(9070, "action4_3", 0.2, 4.3, function()
		self:PlayActorEmoteAction(9070, "complaint01", 0, 1.5, function()
			return
		end, true, false)
	end)
	self:PlayActorAnimationAction(9509, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	self:DelayTimeAction(0.1, function()
		self:EnableCameraByTagAction("11_1", 2, 10)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10017011, "", 9509)
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
	self:OnNext(function(arg_89_0)
		self:ClearOnNext()
		self:DialogueNode_14()
	end)
end

function var_0_0:DialogueNode_14()
	self:PlayActorEmoteAction(9509, "squint01", 0, 1.733333, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(10017012, "", 9509)
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
		self:DialogueNode_15()
	end)
end

function var_0_0:DialogueNode_15()
	self:PlayActorAnimationAction(9070, "summer_shock_start", 0, 0.3333333, function()
		return
	end)
	self:EnableCameraByTagAction("13_1", 1, 0)
	self:DelayTimeAction(0.1, function()
		self:EnableCameraByTagAction("13", 2, 0.3)
	end)
	self:PlayActorEmoteAction(9070, "sad04_start", 0, 0.5, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(10017013, "", 9070)
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
	self:OnNext(function(arg_101_0)
		self:ClearOnNext()
		self:DialogueNode_16()
	end)
end

function var_0_0:DialogueNode_16()
	self:PlayActorAnimationAction(9509, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:EnableCameraByTagAction("14", 1, 0)
	self:DelayTimeAction(0.1, function()
		self:EnableCameraByTagAction("14_1", 7, 7)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10017014, "", 9509)
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
	self:OnNext(function(arg_107_0)
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
end

function var_0_0:DialogueNode_17()
	self:EnableCameraByTagAction("15", 1, 0)
	self:PlayActorAnimationAction(9509, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:DelayTimeAction(0.1, function()
		self:EnableCameraByTagAction("15_1", 7, 6)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10017015, "", 9509)
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
	self:OnNext(function(arg_113_0)
		self:ClearOnNext()
		self:DialogueNode_18()
	end)
end

function var_0_0:DialogueNode_18()
	self:PlayActorAnimationAction(9509, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:EnableCameraByTagAction("16", 1, 0)
	self:DelayTimeAction(0.1, function()
		self:EnableCameraByTagAction("16_1", 7, 6)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10017016, "", 9509)
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
		self:DialogueNode_19()
	end)
end

function var_0_0:DialogueNode_19()
	self:PlayActorAnimationAction(9509, "action2_1", 0.1, 1.666667, function()
		return
	end)
	self:EnableCameraByTagAction("17", 1, 0)
	self:PlayActorAnimationAction(9070, "action5_1", 0.15, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10017017, "", 9070)
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
	self:OnNext(function(arg_125_0)
		self:ClearOnNext()
		self:DialogueNode_20()
	end)
end

function var_0_0:DialogueNode_20()
	self:PlayActorAnimationAction(9509, "action2_3", 0.2, 1.333333, function()
		return
	end)
	self:EnableCameraByTagAction("18", 1, 0)
	self:DelayTimeAction(0.5, function()
		self:PlayActorEmoteAction(9070, "glory01", 0, 1.566667, function()
			return
		end, false, false)
	end)
	self:PlayActorEmoteAction(9509, "glory01", 0, 1.566667, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(10017018, "", 9509)
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
	self:OnNext(function(arg_133_0)
		self:ClearOnNext()
		self:DialogueNode_21()
	end)
end

function var_0_0:DialogueNode_21()
	self:EnableCameraByTagAction("19", 1, 0)
	self:DelayTimeAction(0.05, function()
		self:EnableCameraByTagAction("19_1", 7, 6.5)
	end)
	self:DelayTimeAction(6.3, function()
		self:EnableCameraByTagAction("19_2", 1, 0)
		self:CameraMoveAction("19_2", 1, 4, 6, 3)
		self:DelayTimeAction(1, function()
			self:SetNeedClick(true, {
				Invoke = function()
					self:Next()
				end
			})
			self:SetNeedSkip(false, nil)
		end)
	end)
	self:ActorSeekerAction(9509, {
		"9509_2",
		"9509_3"
	}, 0.8, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10017019, "", 9509)
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
	self:OnNext(function(arg_142_0)
		self:ClearOnNext()
		self:DialogueNode_22()
	end)
end

function var_0_0:DialogueNode_22()
	self:ShowTalkView()
	self:SetTalkContent(10017020, "", 9509)
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
		self:BlackFadeDialogueNode_23()
	end)
end

function var_0_0:BlackFadeDialogueNode_23()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:EnableCameraCutAction(true)
		self:EnableCameraByTagAction("", 1, 0)
		self:HideAllDynamicAction(false, false)
		self:DestroyCharAction(9070)
		self:DestroyCharAction(9509)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_24()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_24()
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_24)
end

return var_0_0
