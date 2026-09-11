BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10003", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "10003"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/10003"
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
		self:SetCharToTagAction(9074, "9074_1", function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
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
	self:PlayActorAnimationAction(9070, "happy01", 0.1, 2.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10003001, "", 9070)
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
	self:OnNext(function(arg_15_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:EnableCameraByTagAction("2", 1, 0)
	self:PlayActorAnimationAction(9074, "conversation_1", 0.1, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10003002, "", 9074)
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
	self:OnNext(function(arg_20_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:EnableCameraByTagAction("3", 1, 0)
	self:DelayTimeAction(1.5, function()
		self:PlayActorAnimationAction(9070, "summer_doubt", 0.3, 2, function()
			return
		end)
	end)
	self:PlayActorAnimationAction(9070, "conversation_1", 0.1, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10003003, "", 9070)
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
	self:OnNext(function(arg_27_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:PlayActorAnimationAction(9070, "conversation_2", 0.1, 3.166667, function()
		return
	end)
	self:EnableCameraByTagAction("4", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(10003004, "", 9070)
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
	self:OnNext(function(arg_32_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:BlackFadeAction(0.2, 0.3, 0.3, function()
		return
	end, function()
		self:EnableCameraByTagAction("5", 1, 0)
		self:DelayTimeAction(0.1, function()
			self:HideAllDynamicAction(false, false)
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10003005, "", 9074)
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
	self:OnNext(function(arg_39_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:ShowTalkView()
	self:SetTalkContent(10003006, "", 9070)
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
	self:OnNext(function(arg_43_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:ShowTalkView()
	self:SetTalkContent(10003007, "", 9074)
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
	self:OnNext(function(arg_47_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:ShowTalkView()
	self:SetTalkContent(10003008, "", 9070)
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
	self:OnNext(function(arg_51_0)
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:ShowTalkView()
	self:SetTalkContent(10003009, "", 9070)
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
	self:OnNext(function(arg_55_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:BlackFadeAction(0.2, 0.3, 0.3, function()
		return
	end, function()
		self:EnableCameraByTagAction("10", 1, 0)
		self:CameraMoveAction("10", 4, 4, 5, 0.1)
		self:PlayActorAnimationAction(9074, "conversation_1", 0.1, 3, function()
			return
		end)
		self:HideAllDynamicAction(true, true)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10003010, "", 9074)
	self:SetChoice({
		[0] = {
			id = 10003011,
			icon = "",
			Invoke = function()
				self:Next(10003011)
			end
		},
		{
			id = 10003014,
			icon = "",
			Invoke = function()
				self:Next(10003014)
			end
		},
		{
			id = 10003020,
			icon = "",
			Invoke = function()
				self:Next(10003020)
			end
		},
		Length = 3
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_63_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_63_0 == 10003011 then
			self:DialogueBranchNode_12()
		elseif arg_63_0 == 10003014 then
			self:DialogueBranchNode_13()
		elseif arg_63_0 == 10003020 then
			self:DialogueBranchNode_14()
		end
	end)
end

function var_0_0:DialogueBranchNode_12()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_15()
	end)
	self:Next()
end

function var_0_0:DialogueNode_15()
	self:EnableCameraByTagAction("11", 1, 0.7)
	self:PlayActorAnimationAction(9070, "win", 0, 1.933333, function()
		return
	end)
	self:DelayTimeAction(0.1, function()
		self:EnableCameraByTagAction("12", 2, 0.7)
	end)
	self:PlayActorEmoteAction(9070, "anger02_start", 0, 0.5, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(10003012, "", 9070)
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
		self:DialogueNode_16()
	end)
end

function var_0_0:DialogueNode_16()
	self:ShowTalkView()
	self:SetTalkContent(10003013, "", 9074)
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
	self:OnNext(function(arg_76_0)
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
end

function var_0_0:DialogueNode_17()
	self:EnableCameraByTagAction("24", 1, 0.7)
	self:PlayActorAnimationAction(9074, "action2_1", 0.1, 1.666667, function()
		return
	end)
	self:PlayActorEmoteAction(9074, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:CameraMoveAction("24", 4, 4, 6, 0.5)
	self:ShowTalkView()
	self:SetTalkContent(10003024, "", 9074)
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
		self:DialogueNode_18()
	end)
end

function var_0_0:DialogueNode_18()
	self:EnableCameraByTagAction("25", 1, 0.7)
	self:PlayActorAnimationAction(9070, "summer_shock_start", 0.15, 0.3333333, function()
		return
	end)
	self:PlayActorEmoteAction(9070, "complaint02_start", 0, 0.4, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(10003025, "", 9070)
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
		self:DialogueNode_19()
	end)
end

function var_0_0:DialogueNode_19()
	self:PlayActorAnimationAction(9074, "action2_3", 0.1, 1.333333, function()
		return
	end)
	self:CameraMoveAction("26", 4, 4, 8, 0.6)
	self:EnableCameraByTagAction("26", 1, 0.7)
	self:ShowTalkView()
	self:SetTalkContent(10003026, "", 9074)
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
	self:OnNext(function(arg_93_0)
		self:ClearOnNext()
		self:DialogueNode_20()
	end)
end

function var_0_0:DialogueNode_20()
	self:PlayActorAnimationAction(9070, "action5_1", 0.3, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10003027, "", 9070)
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
		self:DialogueNode_21()
	end)
end

function var_0_0:DialogueNode_21()
	self:EnableCameraByTagAction("28", 1, 0.7)
	self:CameraMoveAction("28", 4, 4, 10, 0.5)
	self:PlayActorAnimationAction(9074, "action2_1", 0.1, 1.666667, function()
		return
	end)
	self:PlayActorEmoteAction(9074, "complaint01", 0, 1.5, function()
		return
	end, false, false)
	self:PlayActorEmoteAction(9070, "complaint02", 0, 1.466667, function()
		return
	end, false, false)
	self:ShowTalkView()
	self:SetTalkContent(10003028, "", 9074)
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
		self:DialogueNode_22()
	end)
end

function var_0_0:DialogueNode_22()
	self:PlayActorAnimationAction(9070, "sad_01", 0.1, 6.166667, function()
		return
	end)
	self:EnableCameraByTagAction("27", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(10003029, "", 9070)
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
	self:OnNext(function(arg_110_0)
		self:ClearOnNext()
		self:DialogueNode_23()
	end)
end

function var_0_0:DialogueNode_23()
	self:PlayActorAnimationAction(9074, "action2_3", 0.1, 1.333333, function()
		return
	end)
	self:PlayActorEmoteAction(9074, "complaint01_start", 0.1, 0.3333333, function()
		return
	end, true, true)
	self:EnableCameraByTagAction("30", 1, 0.7)
	self:ShowTalkView()
	self:SetTalkContent(10003030, "", 9074)
	self:SetChoice({
		[0] = {
			id = 10003031,
			icon = "",
			Invoke = function()
				self:Next(10003031)
			end
		},
		{
			id = 10003033,
			icon = "",
			Invoke = function()
				self:Next(10003033)
			end
		},
		Length = 2
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_116_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_116_0 == 10003031 then
			self:DialogueBranchNode_24()
		elseif arg_116_0 == 10003033 then
			self:DialogueBranchNode_25()
		end
	end)
end

function var_0_0:DialogueBranchNode_24()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_26()
	end)
	self:Next()
end

function var_0_0:DialogueNode_26()
	self:EnableCameraByTagAction("31", 1, 0.7)
	self:PlayActorAnimationAction(9070, "sad_01", 0.1, 6.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10003032, "", 9074)
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
	self:OnNext(function(arg_123_0)
		self:ClearOnNext()
		self:DialogueNode_27()
	end)
end

function var_0_0:DialogueNode_27()
	self:EnableCameraByTagAction("35_1", 1, 0.7)
	self:PlayActorEmoteAction(9074, "squint01", 0, 1.733333, function()
		return
	end, true, false)
	self:DelayTimeAction(1.2, function()
		self:ActorSeekerAction(9074, {
			"9074_35"
		}, 0.5, function()
			return
		end)
		self:EnableCameraByTagAction("35_2", 1, 0.7)
		self:DelayTimeAction(1.5, function()
			self:EnableCameraByTagAction("35_3", 1, 0.7)
			self:SetNeedClick(true, {
				Invoke = function()
					self:Next()
				end
			})
			self:SetNeedSkip(false, nil)
			self:PlayActorAnimationAction(9074, "take", 0.1, 1.833333, function()
				return
			end)
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10003035, "", 9074)
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
	self:OnNext(function(arg_133_0)
		self:ClearOnNext()
		self:DialogueNode_28()
	end)
end

function var_0_0:DialogueNode_28()
	self:EnableCameraByTagAction("36", 1, 0.7)
	self:PlayActorEmoteAction(9070, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	self:CameraMoveAction("36", 4, 1, 6, 0.2)
	self:ShowTalkView()
	self:SetTalkContent(10003036, "", 9070)
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
	self:OnNext(function(arg_138_0)
		self:ClearOnNext()
		self:DialogueNode_29()
	end)
end

function var_0_0:DialogueNode_29()
	self:EnableCameraByTagAction("37", 1, 0.7)
	self:PlayActorAnimationAction(9074, "action2_1", 0.1, 1.666667, function()
		return
	end)
	self:PlayActorEmoteAction(9074, "laugh01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(10003037, "", 9074)
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
	self:OnNext(function(arg_144_0)
		self:ClearOnNext()
		self:DialogueNode_30()
	end)
end

function var_0_0:DialogueNode_30()
	self:EnableCameraByTagAction("38", 1, 0.7)
	self:SetLookAtParamsAction(9074, 0.6, 0.8, 1)
	self:LookAtAction(true, 9074, "9074_17")
	self:DelayTimeAction(1.5, function()
		self:PlayActorAnimationAction(9074, "action2_3", 0.1, 1.333333, function()
			return
		end)
		self:SetLookAtParamsAction(9074, 0.6, 0.8, 1)
		self:LookAtAction(false, 9074, "9074_17")
	end)
	self:PlayActorAnimationAction(9070, "stand_female", 0.1, 4, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10003038, "", 9074)
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
	self:OnNext(function(arg_151_0)
		self:ClearOnNext()
		self:DialogueNode_31()
	end)
end

function var_0_0:DialogueNode_31()
	self:EnableCameraByTagAction("39", 1, 0.7)
	self:PlayActorAnimationAction(9070, "action3_1", 0.1, 2.266667, function()
		return
	end)
	self:PlayActorEmoteAction(9070, "", 0, 0, function()
		return
	end, false, false)
	self:ShowTalkView()
	self:SetTalkContent(10003039, "", 9070)
	self:SetChoice({
		Length = 1,
		[0] = {
			id = 10003040,
			icon = "",
			Invoke = function()
				self:Next(10003040)
			end
		}
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_156_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_156_0 == 10003040 then
			self:DialogueBranchNode_32()
		end
	end)
end

function var_0_0:DialogueBranchNode_32()
	self:OnNext(function()
		self:ClearOnNext()
		self:BlackFadeDialogueNode_33()
	end)
	self:Next()
end

function var_0_0:BlackFadeDialogueNode_33()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:EnableCameraCutAction(true)
		self:EnableCameraByTagAction("", 1, 0.7)
		self:HideAllDynamicAction(false, false)
		self:DestroyCharAction(9070)
		self:DestroyCharAction(9074)
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
	self:EndStory()
end

function var_0_0:DialogueBranchNode_25()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_35()
	end)
	self:Next()
end

function var_0_0:DialogueNode_35()
	self:EnableCameraByTagAction("31", 1, 0.7)
	self:PlayActorAnimationAction(9070, "win", 0.1, 1.933333, function()
		return
	end)
	self:PlayActorEmoteAction(9070, "laugh01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(10003034, "", 9074)
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
	self:OnNext(function(arg_171_0)
		self:ClearOnNext()
		self:DialogueNode_27()
	end)
end

function var_0_0:DialogueBranchNode_13()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_36()
	end)
	self:Next()
end

function var_0_0:DialogueNode_36()
	self:EnableCameraByTagAction("14_1", 1, 0)
	self:PlayActorEmoteAction(9074, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(10003015, "", 9074)
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
	self:OnNext(function(arg_178_0)
		self:ClearOnNext()
		self:DialogueNode_37()
	end)
end

function var_0_0:DialogueNode_37()
	self:EnableCameraByTagAction("16", 1, 0)
	self:CameraMoveAction("16", 4, 1, 10, 0.5)
	self:PlayActorAnimationAction(9070, "conversation_2", 0.1, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10003016, "", 9070)
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
	self:OnNext(function(arg_183_0)
		self:ClearOnNext()
		self:DialogueNode_38()
	end)
end

function var_0_0:DialogueNode_38()
	self:PlayActorAnimationAction(9074, "action2_1", 0.1, 1.666667, function()
		return
	end)
	self:DelayTimeAction(3, function()
		self:BlackFadeAction(0.2, 0.3, 0.3, function()
			return
		end, function()
			self:CameraMoveAction("17", 4, 4, 6, 1)
			self:EnableCameraByTagAction("17", 1, 0)
		end)
	end)
	self:DelayTimeAction(2, function()
		self:SetLookAtParamsAction(9074, 0.6, 0.8, 1)
		self:LookAtAction(true, 9074, "9074_17")
	end)
	self:ShowTalkView()
	self:SetTalkContent(10003017, "", 9074)
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
	self:OnNext(function(arg_192_0)
		self:ClearOnNext()
		self:DialogueNode_39()
	end)
end

function var_0_0:DialogueNode_39()
	self:EnableCameraByTagAction("18", 1, 0)
	self:PlayActorAnimationAction(9070, "summer_doubt", 0.1, 2, function()
		return
	end)
	self:PlayActorEmoteAction(9070, "sad03", 0, 1.933333, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(10003018, "", 9070)
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
	self:OnNext(function(arg_198_0)
		self:ClearOnNext()
		self:DialogueNode_40()
	end)
end

function var_0_0:DialogueNode_40()
	self:EnableCameraByTagAction("19", 1, 0)
	self:PlayActorAnimationAction(9074, "action2_3", 0.1, 1.333333, function()
		return
	end)
	self:PlayActorEmoteAction(9074, "glory01", 0, 1.566667, function()
		return
	end, true, false)
	self:SetLookAtParamsAction(9074, 0.6, 0.8, 1)
	self:LookAtAction(false, 9074, "9074_17")
	self:ShowTalkView()
	self:SetTalkContent(10003019, "", 9074)
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
	self:OnNext(function(arg_204_0)
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
end

function var_0_0:DialogueBranchNode_14()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_41()
	end)
	self:Next()
end

function var_0_0:DialogueNode_41()
	self:EnableCameraByTagAction("21", 1, 0)
	self:CameraMoveAction("21", 4, 1, 0.5, 0.3)
	self:PlayActorEmoteAction(9074, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(10003021, "", 9074)
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
	self:OnNext(function(arg_211_0)
		self:ClearOnNext()
		self:DialogueNode_42()
	end)
end

function var_0_0:DialogueNode_42()
	self:EnableCameraByTagAction("22", 1, 0)
	self:CameraMoveAction("22", 2, 1, 7, 0.6)
	self:PlayActorAnimationAction(9070, "action3_1", 0, 2.266667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10003022, "", 9070)
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
	self:OnNext(function(arg_216_0)
		self:ClearOnNext()
		self:DialogueNode_43()
	end)
end

function var_0_0:DialogueNode_43()
	self:EnableCameraByTagAction("23", 1, 0)
	self:CameraMoveAction("23", 2, 4, 6, 0.2)
	self:PlayActorEmoteAction(9074, "squint01", 0, 1.733333, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(10003023, "", 9074)
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
	self:OnNext(function(arg_221_0)
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_34)
end

return var_0_0
