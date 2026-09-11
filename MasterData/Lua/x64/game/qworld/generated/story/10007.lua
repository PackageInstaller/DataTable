BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10007", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "10007"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/10007"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.3, function()
		self:SetCharToTagAction(9071, "9071_1", function()
			self:PlayActorEmoteAction(9071, "emote@9071_face", 0, 4, function()
				return
			end, true, true)
		end)
		self:SetCharToTagAction(9070, "9070_1", function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:CameraMoveAction("1", 4, 4, 6, 0.3)
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
	self:PlayActorAnimationAction(9071, "action2_1", 0, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10007001, "", 9071)
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
	self:OnNext(function(arg_16_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:PlayActorEmoteAction(9070, "anger02", 0, 1.933333, function()
		return
	end, true, false)
	self:CameraMoveAction("2_1", 4, 1, 0.8, 0.4)
	self:EnableCameraByTagAction("2_1", 1, 0)
	self:DelayTimeAction(2, function()
		self:PlayActorAnimationAction(9070, "summer_doubt", 0, 2, function()
			return
		end)
		self:PlayActorEmoteAction(9070, "shocked01", 0, 1.4, function()
			return
		end, true, false)
		self:EnableCameraByTagAction("2_2", 1, 0)
		self:CameraMoveAction("2_2", 4, 2, 6, 0.3)
		self:SetNeedClick(true, {
			Invoke = function()
				self:Next()
			end
		})
		self:SetNeedSkip(false, nil)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10007002, "", 9070)
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
	self:OnNext(function(arg_25_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:EnableCameraByTagAction("3", 1, 0)
	self:CameraMoveAction("3", 4, 6, 3, 0.1)
	self:PlayActorAnimationAction(9071, "action2_3", 0, 1.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10007003, "", 9071)
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
	self:OnNext(function(arg_30_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:EnableCameraByTagAction("4", 1, 0)
	self:PlayActorEmoteAction(9070, "sad03", 0, 1.933333, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(10007004, "", 9070)
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
	self:EnableCameraByTagAction("5", 1, 0)
	self:CameraMoveAction("5", 4, 4, 6, 0.2)
	self:PlayActorAnimationAction(9070, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10007005, "", 9070)
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
	self:EnableCameraByTagAction("6", 1, 0)
	self:PlayActorAnimationAction(9071, "action2_1", 0, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10007006, "", 9071)
	self:SetChoice({
		Length = 1,
		[0] = {
			id = 10007007,
			icon = "",
			Invoke = function()
				self:Next(10007007)
			end
		}
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_44_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_44_0 == 10007007 then
			self:DialogueBranchNode_8()
		end
	end)
end

function var_0_0:DialogueBranchNode_8()
	self:OnNext(function()
		self:ClearOnNext()
		self:PureActorDialogueNode_9()
	end)
	self:Next()
end

function var_0_0:PureActorDialogueNode_9()
	self:EnableCameraByTagAction("7", 1, 0)
	self:CameraMoveAction("7", 4, 1, 1, 0.4)
	self:PlayActorEmoteAction(9070, "anger02_start", 0, 0.5, function()
		return
	end, true, true)
	self:DelayTimeAction(2, function()
		self:EventAction(function()
			self:ImmediateNextFlag(-1)
		end)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:EnableCameraByTagAction("8", 1, 0)
	self:CameraMoveAction("8", 4, 4, 6, 0.2)
	self:PlayActorAnimationAction(9071, "action2_3", 0, 1.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10007008, "", 9071)
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
	self:OnNext(function(arg_56_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:PlayActorAnimationAction(9070, "action4_1", 0, 2.666667, function()
		return
	end)
	self:EnableCameraByTagAction("9", 1, 0)
	self:CameraMoveAction("9", 4, 1, 8, 0.4)
	self:ShowTalkView()
	self:SetTalkContent(10007009, "", 9070)
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
	self:OnNext(function(arg_61_0)
		self:ClearOnNext()
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:PlayActorAnimationAction(9071, "dorm_male_idle01", 0, 8.166667, function()
		return
	end)
	self:EnableCameraByTagAction("10", 1, 0)
	self:CameraMoveAction("10", 4, 4, 6, 0.3)
	self:ShowTalkView()
	self:SetTalkContent(10007010, "", 9071)
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
	self:OnNext(function(arg_66_0)
		self:ClearOnNext()
		self:DialogueNode_13()
	end)
end

function var_0_0:DialogueNode_13()
	self:EnableCameraByTagAction("11", 1, 0)
	self:PlayActorAnimationAction(9070, "action4_3", 0, 4.3, function()
		return
	end)
	self:DelayTimeAction(0.5, function()
		self:PlayActorEmoteAction(9070, "shocked01_start", 0, 0.3666667, function()
			return
		end, true, true)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10007011, "", 9070)
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
	self:OnNext(function(arg_73_0)
		self:ClearOnNext()
		self:DialogueNode_14()
	end)
end

function var_0_0:DialogueNode_14()
	self:EnableCameraByTagAction("12_1", 1, 0)
	self:PlayActorAnimationAction(9071, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:CameraMoveAction("12_1", 4, 6, 6, 0.3)
	self:DelayTimeAction(3, function()
		self:EnableCameraByTagAction("12_2", 1, 0)
		self:CameraMoveAction("12_2", 1, 6, 7, 0.2)
		self:DelayTimeAction(1, function()
			self:SetNeedClick(true, {
				Invoke = function()
					self:Next()
				end
			})
			self:SetNeedSkip(false, nil)
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10007012, "", 9071)
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
	self:OnNext(function(arg_81_0)
		self:ClearOnNext()
		self:DialogueNode_15()
	end)
end

function var_0_0:DialogueNode_15()
	self:EnableCameraByTagAction("13_1", 1, 0)
	self:PlayActorAnimationAction(9071, "action2_1", 0, 1.666667, function()
		return
	end)
	self:CameraMoveAction("13_1", 4, 3, 6, 0.3)
	self:DelayTimeAction(2, function()
		self:BlackFadeAction(0.2, 0.3, 0.3, function()
			self:SetNeedClick(true, {
				Invoke = function()
					self:Next()
				end
			})
			self:SetNeedSkip(false, nil)
		end, function()
			self:EnableCameraByTagAction("13_2", 1, 0)
			self:HideAllDynamicAction(false, true)
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10007013, "", 9071)
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
	self:OnNext(function(arg_90_0)
		self:ClearOnNext()
		self:DialogueNode_16()
	end)
end

function var_0_0:DialogueNode_16()
	self:BlackFadeAction(0.2, 0.3, 0.2, function()
		return
	end, function()
		self:EnableCameraByTagAction("14", 1, 0)
		self:PlayActorAnimationAction(9070, "happy01", 0, 2.333333, function()
			self:PlayActorEmoteAction(9070, "happy01_start", 0, 0.1333333, function()
				return
			end, true, true)
		end)
		self:HideAllDynamicAction(true, true)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10007014, "", 9070)
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
	self:OnNext(function(arg_98_0)
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
end

function var_0_0:DialogueNode_17()
	self:EnableCameraByTagAction("15", 1, 0)
	self:CameraMoveAction("15", 4, 4, 6, 0.15)
	self:ShowTalkView()
	self:SetTalkContent(10007015, "", 9071)
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
	self:OnNext(function(arg_102_0)
		self:ClearOnNext()
		self:DialogueNode_18()
	end)
end

function var_0_0:DialogueNode_18()
	self:PlayActorEmoteAction(9070, "happy01_start", 0, 0.1333333, function()
		return
	end, false, false)
	self:PlayActorAnimationAction(9070, "happy02", 0, 3, function()
		return
	end)
	self:EnableCameraByTagAction("16", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(10007016, "", 9070)
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
	self:OnNext(function(arg_108_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_19()
	end)
end

function var_0_0:BlackFadeDialogueNode_19()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:EnableCameraCutAction(true)
		self:EnableCameraByTagAction("", 1, 0.7)
		self:HideAllDynamicAction(false, false)
		self:DestroyCharAction(9070)
		self:DestroyCharAction(9071)
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

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_20)
end

return var_0_0
