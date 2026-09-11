BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11006", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11006"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11006"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.2, 0.2, function()
		self:EnableCameraByTagAction("1", 1, 0)
		self:SetCharToTagAction(9512, "1", function()
			return
		end)
		self:SetCharToTagAction(9073, "0", function()
			return
		end)
		self:HideAllDynamicAction(true, true, 4095, {})
		self:ActorSeekerAction(9073, {
			"0_1"
		}, 0.4, function()
			return
		end)
		self:CameraMoveAction("1", 4, 3, 6, 1)
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
	self:SetTalkContent(11006001, "", 9073)
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
	self:OnNext(function(arg_15_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:SetCharToTagAction(9073, "0_1", function()
		return
	end)
	self:EnableCameraByTagAction("2", 1, 0)
	self:DelayTimeAction(2, function()
		self:EnableCameraByTagAction("2_1", 1, 0)
	end)
	self:DelayTimeAction(1, function()
		self:ActorSeekerAction(9073, {
			"3"
		}, 2.5, function()
			return
		end)
	end)
	self:PlayActorEmoteAction(9073, "shocked01", 0, 1.4, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11006002, "", 9073)
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
	self:OnNext(function(arg_24_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:SetCharToTagAction(9073, "3", function()
		return
	end)
	self:PlayActorEmoteAction(9512, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	self:PlayActorAnimationAction(9512, "summer_doubt", 0, 2, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006003, "", 9512)
	self:SetChoice({
		[0] = {
			id = 11006004,
			icon = "",
			Invoke = function()
				self:Next(11006004)
			end
		},
		{
			id = 11006005,
			icon = "",
			Invoke = function()
				self:Next(11006005)
			end
		},
		Length = 2
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_31_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_31_0 == 11006004 then
			self:DialogueBranchNode_5()
		elseif arg_31_0 == 11006005 then
			self:DialogueBranchNode_6()
		end
	end)
end

function var_0_0:DialogueBranchNode_5()
	self:OnNext(function()
		self:ClearOnNext()
		self:PureActorDialogueNode_7()
	end)
	self:Next()
end

function var_0_0:PureActorDialogueNode_7()
	self:PlayActorEmoteAction(9073, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	self:DelayTimeAction(2, function()
		self:EventAction(function()
			self:ImmediateNextFlag(-1)
		end)
		self:PlayActorEmoteAction(9073, "shocked01_end", 0, 0.4000001, function()
			return
		end, true, false)
	end)
	self:EnableCameraByTagAction("4_1", 1, 0)
	self:CameraMoveAction("4_1", 4, 1, 1, 0.3)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:PlayActorAnimationAction(9512, "action2_1", 0, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006006, "", 9512)
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
	self:OnNext(function(arg_44_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:PlayActorAnimationAction(9073, "happy04", 0, 2.2, function()
		return
	end)
	self:DelayTimeAction(1.5, function()
		self:SetNeedClick(true, {
			Invoke = function()
				self:Next()
			end
		})
		self:SetNeedSkip(false, nil)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006007, "", 9073)
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
	self:OnNext(function(arg_51_0)
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:PlayActorAnimationAction(9073, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006008, "", 9073)
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
	self:OnNext(function(arg_56_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:PlayActorEmoteAction(9512, "happy01_end", 0, 0.2666667, function()
		return
	end, true, false)
	self:PlayActorAnimationAction(9512, "action2_3", 0, 1.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006009, "", 9512)
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
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:PlayActorEmoteAction(9512, "squint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11006010, "", 9512)
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
	self:OnNext(function(arg_67_0)
		self:ClearOnNext()
		self:DialogueNode_13()
	end)
end

function var_0_0:DialogueNode_13()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:PlayActorAnimationAction(9073, "proud", 0, 2.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006011, "", 9073)
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
		self:DialogueNode_14()
	end)
end

function var_0_0:DialogueNode_14()
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:PlayActorAnimationAction(9512, "action2_1", 0, 1.666667, function()
		return
	end)
	self:PlayActorEmoteAction(9512, "squint01_end", 0, 0.4333335, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11006012, "", 9512)
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
	self:OnNext(function(arg_78_0)
		self:ClearOnNext()
		self:DialogueNode_15()
	end)
end

function var_0_0:DialogueNode_15()
	self:PlayActorAnimationAction(9512, "action2_3", 0, 1.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006013, "", 9512)
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
		self:DialogueNode_16()
	end)
end

function var_0_0:DialogueNode_16()
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:PlayActorAnimationAction(9073, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006014, "", 9073)
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
	self:OnNext(function(arg_88_0)
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
end

function var_0_0:DialogueNode_17()
	self:BlackFadeAction(0.2, 0.2, 0.2, function()
		return
	end, function()
		self:EnableCameraByTagAction("15", 1, 0)
		self:CameraMoveAction("15", 4, 4, 6, 0.5)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006015, "", 9512)
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
		self:DialogueNode_18()
	end)
end

function var_0_0:DialogueNode_18()
	self:DelayTimeAction(2, function()
		self:BlackFadeAction(0.2, 0.2, 0.2, function()
			return
		end, function()
			self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
			self:PlayActorAnimationAction(9512, "conversation_2", 0.2, 3.166667, function()
				return
			end)
			self:PlayActorEmoteAction(9512, "glory01", 0, 1.566667, function()
				return
			end, true, false)
		end)
		self:DelayTimeAction(0.5, function()
			self:SetNeedClick(true, {
				Invoke = function()
					self:Next()
				end
			})
			self:SetNeedSkip(false, nil)
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006016, "", 9512)
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
	self:OnNext(function(arg_105_0)
		self:ClearOnNext()
		self:DialogueNode_19()
	end)
end

function var_0_0:DialogueNode_19()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:PlayActorAnimationAction(9073, "summer_doubt", 0.2, 2, function()
		self:PlayActorAnimationAction(9073, "conversation_2", 0.2, 3.166667, function()
			return
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006017, "", 9073)
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
		self:DialogueNode_20()
	end)
end

function var_0_0:DialogueNode_20()
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:PlayActorEmoteAction(9512, "complaint01", 0, 1.5, function()
		self:PlayActorAnimationAction(9512, "conversation_2", 0.2, 3.166667, function()
			return
		end)
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11006018, "", 9512)
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
	self:OnNext(function(arg_117_0)
		self:ClearOnNext()
		self:DialogueNode_21()
	end)
end

function var_0_0:DialogueNode_21()
	self:BlackFadeAction(0.2, 0.2, 0.2, function()
		self:SetNeedClick(true, {
			Invoke = function()
				self:Next()
			end
		})
		self:SetNeedSkip(false, nil)
	end, function()
		self:EnableCameraByTagAction("19", 1, 0)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006019, "", 9512)
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
	self:OnNext(function(arg_124_0)
		self:ClearOnNext()
		self:DialogueNode_22()
	end)
end

function var_0_0:DialogueNode_22()
	self:ShowTalkView()
	self:SetTalkContent(11006020, "", 9512)
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
	self:OnNext(function(arg_128_0)
		self:ClearOnNext()
		self:DialogueNode_23()
	end)
end

function var_0_0:DialogueNode_23()
	self:PlayActorEmoteAction(9073, "squint01", 0, 1.733333, function()
		return
	end, true, false)
	self:BlackFadeAction(0.2, 0.2, 0.2, function()
		self:SetNeedClick(true, {
			Invoke = function()
				self:Next()
			end
		})
		self:SetNeedSkip(false, nil)
	end, function()
		self:EnableCameraByTagAction("21", 1, 0)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006021, "", 9073)
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
	self:OnNext(function(arg_136_0)
		self:ClearOnNext()
		self:DialogueNode_24()
	end)
end

function var_0_0:DialogueNode_24()
	self:PlayActorAnimationAction(9073, "proud_start", 0, 0.6, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "laugh01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11006022, "", 9073)
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
	self:OnNext(function(arg_142_0)
		self:ClearOnNext()
		self:DialogueNode_25()
	end)
end

function var_0_0:DialogueNode_25()
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:PlayActorAnimationAction(9512, "conversation_1", 0.2, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006023, "", 9512)
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
	self:OnNext(function(arg_147_0)
		self:ClearOnNext()
		self:DialogueNode_26()
	end)
end

function var_0_0:DialogueNode_26()
	self:EnableCameraByTagAction("24", 1, 0)
	self:PlayActorAnimationAction(9073, "summer_doubt_start", 0, 0.7666667, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11006024, "", 9073)
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
	self:OnNext(function(arg_153_0)
		self:ClearOnNext()
		self:DialogueNode_27()
	end)
end

function var_0_0:DialogueNode_27()
	self:SetCharToTagAction(9074, "4", function()
		return
	end)
	self:ActorSeekerAction(9074, {
		"2"
	}, 0.6, function()
		return
	end)
	self:EnableCameraByTagAction("25", 1, 0)
	self:DelayTimeAction(2, function()
		self:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
		self:SetCharToTagAction(9073, "6", function()
			self:SetLookAtParamsAction(9073, 0.8, 1, 0.7)
			self:LookAtRoleAction(true, 9073, "9074")
		end)
		self:SetCharToTagAction(9512, "5", function()
			return
		end)
		self:DelayTimeAction(0.8, function()
			self:SetNeedClick(true, {
				Invoke = function()
					self:Next()
				end
			})
			self:SetNeedSkip(false, nil)
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006025, "", 9074)
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
	self:OnNext(function(arg_164_0)
		self:ClearOnNext()
		self:DialogueNode_28()
	end)
end

function var_0_0:DialogueNode_28()
	self:PlayActorAnimationAction(9073, "summer_shock", 0.1, 1.166667, function()
		self:PlayActorEmoteAction(9073, "shocked01_end", 0, 0.4000001, function()
			return
		end, true, false)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006026, "", 9073)
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
	self:OnNext(function(arg_170_0)
		self:ClearOnNext()
		self:DialogueNode_29()
	end)
end

function var_0_0:DialogueNode_29()
	self:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	self:SetLookAtParamsAction(9074, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9074, "9073")
	self:ShowTalkView()
	self:SetTalkContent(11006027, "", 9074)
	self:SetChoice({
		[0] = {
			id = 11006028,
			icon = "",
			Invoke = function()
				self:Next(11006028)
			end
		},
		{
			id = 11006029,
			icon = "",
			Invoke = function()
				self:Next(11006029)
			end
		},
		Length = 2
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_174_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_174_0 == 11006028 then
			self:DialogueBranchNode_30()
		elseif arg_174_0 == 11006029 then
			self:DialogueBranchNode_31()
		end
	end)
end

function var_0_0:DialogueBranchNode_30()
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(false, 9073, "9074")
	self:OnNext(function()
		self:ClearOnNext()
		self:PureActorDialogueNode_32()
	end)
	self:Next()
end

function var_0_0:PureActorDialogueNode_32()
	self:PlayActorAnimationAction(9073, "angry01", 0.2, 4.333333, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "shocked01_end", 0, 0.4000001, function()
		return
	end, false, false)
	self:EnableCameraByTagAction("27", 1, 0)
	self:DelayTimeAction(3.5, function()
		self:EventAction(function()
			self:ImmediateNextFlag(-1)
		end)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_33()
	end)
end

function var_0_0:DialogueNode_33()
	self:PlayActorAnimationAction(9073, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "anger02_start", 0, 0.5, function()
		return
	end, true, true)
	self:EnableCameraByTagAction("30", 1, 0)
	self:SetLookAtParamsAction(9073, 0.8, 1, 1.2)
	self:LookAtRoleAction(true, 9073, "9074")
	self:ShowTalkView()
	self:SetTalkContent(11006030, "", 9073)
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
	self:OnNext(function(arg_188_0)
		self:ClearOnNext()
		self:DialogueNode_34()
	end)
end

function var_0_0:DialogueNode_34()
	self:EnableCameraByTagAction("31", 1, 0)
	self:PlayActorAnimationAction(9074, "conversation_1", 0.2, 3, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "anger02_end", 0, 0.6, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11006031, "", 9074)
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
	self:OnNext(function(arg_194_0)
		self:ClearOnNext()
		self:DialogueNode_35()
	end)
end

function var_0_0:DialogueNode_35()
	self:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9073, "9512")
	self:SetLookAtParamsAction(9074, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9074, "9512")
	self:ShowTalkView()
	self:SetTalkContent(11006032, "", 9073)
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
	self:OnNext(function(arg_198_0)
		self:ClearOnNext()
		self:DialogueNode_36()
	end)
end

function var_0_0:DialogueNode_36()
	self:EnableCameraByTagAction("33", 1, 0)
	self:PlayActorAnimationAction(9512, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006033, "", 9512)
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
	self:OnNext(function(arg_203_0)
		self:ClearOnNext()
		self:DialogueNode_37()
	end)
end

function var_0_0:DialogueNode_37()
	self:ShowTalkView()
	self:SetTalkContent(11006034, "", 9512)
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
	self:OnNext(function(arg_207_0)
		self:ClearOnNext()
		self:DialogueNode_38()
	end)
end

function var_0_0:DialogueNode_38()
	self:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	self:PlayActorAnimationAction(9074, "action2_1", 0.2, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006035, "", 9074)
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
	self:OnNext(function(arg_212_0)
		self:ClearOnNext()
		self:DialogueNode_39()
	end)
end

function var_0_0:DialogueNode_39()
	self:ShowTalkView()
	self:SetTalkContent(11006036, "", 0)
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
	self:OnNext(function(arg_216_0)
		self:ClearOnNext()
		self:DialogueNode_40()
	end)
end

function var_0_0:DialogueNode_40()
	self:PlayActorAnimationAction(9073, "stroke02", 0.2, 5.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11006037, "", 0)
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
	self:OnNext(function(arg_221_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_41()
	end)
end

function var_0_0:BlackFadeDialogueNode_41()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.5, 0.2, 0.2, function()
		self:DestroyCharAction(9073)
		self:DestroyCharAction(9074)
		self:DestroyCharAction(9512)
		self:EnableCameraByTagAction("", 1, 0)
		self:HideAllDynamicAction(false, false, 4095, {})
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_42()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_42()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:DialogueBranchNode_31()
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(false, 9073, "9074")
	self:OnNext(function()
		self:ClearOnNext()
		self:PureActorDialogueNode_32()
	end)
	self:Next()
end

function var_0_0:DialogueBranchNode_6()
	self:OnNext(function()
		self:ClearOnNext()
		self:PureActorDialogueNode_7()
	end)
	self:Next()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.BlackFadeDialogueNode_41)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_42)
end

return var_0_0
