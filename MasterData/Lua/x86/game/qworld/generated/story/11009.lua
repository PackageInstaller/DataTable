BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11009", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11009"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11009"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.2, 0.2, function()
		self:SetCharToTagAction(9512, "1", function()
			return
		end)
		self:SetCharToTagAction(9074, "4", function()
			return
		end)
		self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
		self:SetCharToTagAction(9073, "2", function()
			return
		end)
		self:HideAllDynamicAction(true, true, 4091, {})
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
	self:SetTalkContent(11009001, "", 9512)
	self:SetChoice({
		[0] = {
			id = 11009002,
			icon = "",
			Invoke = function()
				self:Next(11009002)
			end
		},
		{
			id = 11009003,
			icon = "",
			Invoke = function()
				self:Next(11009003)
			end
		},
		Length = 2
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_15_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_15_0 == 11009002 then
			self:DialogueBranchNode_3()
		elseif arg_15_0 == 11009003 then
			self:DialogueBranchNode_4()
		end
	end)
end

function var_0_0:DialogueBranchNode_3()
	self:OnNext(function()
		self:ClearOnNext()
		self:PureActorDialogueNode_5()
	end)
	self:Next()
end

function var_0_0:PureActorDialogueNode_5()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:PlayActorAnimationAction(9073, "proud", 0, 2.333333, function()
		return
	end)
	self:PlayActorAnimationAction(9074, "conversation_1", 0, 3, function()
		return
	end)
	self:DelayTimeAction(2, function()
		self:EventAction(function()
			self:ImmediateNextFlag(-1)
		end)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:PlayActorAnimationAction(9512, "conversation_1", 0, 3, function()
		return
	end)
	self:PlayActorEmoteAction(9512, "happy01", 0, 1, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11009004, "", 9512)
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
	self:OnNext(function(arg_29_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	self:PlayActorAnimationAction(9073, "embarrassed", 0, 2.6, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "happy01", 0, 1, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11009005, "", 9073)
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
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:EnableCameraByTagAction("6_1", 1, 0)
	self:CameraMoveAction("6_1", 4, 5, 4, 0.4)
	self:DelayTimeAction(2.5, function()
		self:BlackFadeAction(0.2, 0.2, 0.2, function()
			return
		end, function()
			self:EnableCameraByTagAction("6_2", 1, 0)
			self:CameraMoveAction("6_2", 4, 3, 6, 0.4)
		end)
	end)
	self:PlayActorAnimationAction(9512, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11009006, "", 9512)
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
	self:OnNext(function(arg_43_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:BlackFadeAction(0.2, 0.2, 0.2, function()
		return
	end, function()
		self:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	end)
	self:PlayActorAnimationAction(9074, "conversation_1", 0, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11009007, "", 9074)
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
	self:OnNext(function(arg_50_0)
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:EnableCameraByTagAction("8", 1, 0)
	self:SetCharToTagAction(9523, "3", function()
		return
	end)
	self:CameraMoveAction("8", 4, 5, 0.8, 0.35)
	self:DelayTimeAction(1, function()
		self:ActorSeekerAction(9523, {
			"7"
		}, 2.1, function()
			return
		end)
		self:DelayTimeAction(1, function()
			self:EnableCameraByTagAction("9", 1, 0)
			self:DelayTimeAction(0.5, function()
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
		end)
	end)
	self:SetCharToTagAction(9073, "6", function()
		self:SetLookAtParamsAction(9073, 0.8, 1, 1)
		self:LookAtRoleAction(true, 9073, "9523")
	end)
	self:SetCharToTagAction(9074, "8", function()
		self:SetLookAtParamsAction(9074, 0.8, 1, 1)
		self:LookAtRoleAction(true, 9074, "9523")
	end)
	self:SetCharToTagAction(9512, "5", function()
		self:SetLookAtParamsAction(9512, 0.8, 1, 1)
		self:LookAtRoleAction(true, 9512, "9523")
	end)
	self:ShowTalkView()
	self:SetTalkContent(11009008, "", 9523)
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
	self:OnNext(function(arg_64_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:EnableCameraByTagAction("10", 1, 0)
	self:PlayActorAnimationAction(9074, "summer_doubt", 0, 2, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11009009, "", 9074)
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
	self:OnNext(function(arg_69_0)
		self:ClearOnNext()
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:EnableCameraByTagAction("10_1", 1, 0)
	self:PlayActorAnimationAction(9523, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11009010, "", 9523)
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
	self:OnNext(function(arg_74_0)
		self:ClearOnNext()
		self:DialogueNode_13()
	end)
end

function var_0_0:DialogueNode_13()
	self:BlackFadeAction(0.2, 0.2, 0.2, function()
		return
	end, function()
		self:EnableCameraByTagAction("11", 1, 0)
		self:SetCharToTagAction(9523, "11", function()
			return
		end)
	end)
	self:SetLookAtParamsAction(9523, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9523, "9074")
	self:PlayActorAnimationAction(9523, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11009011, "", 9523)
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
	self:OnNext(function(arg_82_0)
		self:ClearOnNext()
		self:DialogueNode_14()
	end)
end

function var_0_0:DialogueNode_14()
	self:PlayActorAnimationAction(9074, "conversation_1", 0, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11009012, "", 9074)
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
	self:OnNext(function(arg_87_0)
		self:ClearOnNext()
		self:DialogueNode_15()
	end)
end

function var_0_0:DialogueNode_15()
	self:PlayActorAnimationAction(9523, "troubled", 0, 3.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11009013, "", 9523)
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
	self:OnNext(function(arg_92_0)
		self:ClearOnNext()
		self:DialogueNode_16()
	end)
end

function var_0_0:DialogueNode_16()
	self:EnableCameraByTagAction("14", 1, 0)
	self:PlayActorAnimationAction(9523, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11009014, "", 9523)
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
	self:OnNext(function(arg_97_0)
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
end

function var_0_0:DialogueNode_17()
	self:EnableCameraByTagAction("10", 1, 0)
	self:PlayActorEmoteAction(9074, "squint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11009015, "", 9074)
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
	self:OnNext(function(arg_102_0)
		self:ClearOnNext()
		self:DialogueNode_18()
	end)
end

function var_0_0:DialogueNode_18()
	self:EnableCameraByTagAction("16", 2, 1)
	self:PlayActorAnimationAction(9073, "conversation_1", 0, 3, function()
		return
	end)
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9073, "9074")
	self:ShowTalkView()
	self:SetTalkContent(11009016, "", 9073)
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
	self:OnNext(function(arg_107_0)
		self:ClearOnNext()
		self:DialogueNode_19()
	end)
end

function var_0_0:DialogueNode_19()
	self:EnableCameraByTagAction("17", 1, 0)
	self:SetCharToTagAction(9512, "1", function()
		self:SetLookAtParamsAction(9512, 0.8, 1, 1)
		self:LookAtRoleAction(true, 9512, "9073")
	end)
	self:PlayActorAnimationAction(9512, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11009017, "", 9512)
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
	self:OnNext(function(arg_113_0)
		self:ClearOnNext()
		self:DialogueNode_20()
	end)
end

function var_0_0:DialogueNode_20()
	self:ShowTalkView()
	self:SetTalkContent(11009018, "", 9512)
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
	self:OnNext(function(arg_117_0)
		self:ClearOnNext()
		self:DialogueNode_21()
	end)
end

function var_0_0:DialogueNode_21()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:SetCharToTagAction(9074, "4", function()
		self:SetLookAtParamsAction(9074, 0.8, 1, 0.7)
		self:LookAtRoleAction(true, 9074, "9512")
	end)
	self:SetCharToTagAction(9073, "2", function()
		self:SetLookAtParamsAction(9073, 0.8, 1, 0.7)
		self:LookAtRoleAction(true, 9073, "9512")
	end)
	self:PlayActorEmoteAction(9074, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	self:InstEffectAction({
		attachFollow = false,
		delayTime = 2,
		createMode = "RoleAttach",
		destroyMode = "DelayTime",
		attachType = 10,
		roleId = 9074,
		path = "QWWorld/Effect/EmotionBubble/fx_jingxia_0501"
	})
	self:ShowTalkView()
	self:SetTalkContent(11009019, "", 9074)
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
	self:OnNext(function(arg_124_0)
		self:ClearOnNext()
		self:DialogueNode_22()
	end)
end

function var_0_0:DialogueNode_22()
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9073, "9074")
	self:PlayActorAnimationAction(9073, "proud_start", 0, 0.6, function()
		self:InstEffectAction({
			attachFollow = false,
			delayTime = 1,
			createMode = "RoleAttach",
			destroyMode = "DelayTime",
			attachType = 10,
			roleId = 9073,
			path = "QWWorld/Effect/EmotionBubble/fx_daxiao_0801_QW"
		})
	end)
	self:ShowTalkView()
	self:SetTalkContent(11009020, "", 9073)
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
	self:OnNext(function(arg_129_0)
		self:ClearOnNext()
		self:DialogueNode_23()
	end)
end

function var_0_0:DialogueNode_23()
	self:EnableCameraByTagAction("21", 1, 0)
	self:PlayActorEmoteAction(9074, "squint01", 0, 1.733333, function()
		self:PlayActorAnimationAction(9074, "conversation_1", 0, 3, function()
			return
		end)
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11009021, "", 9074)
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
	self:OnNext(function(arg_135_0)
		self:ClearOnNext()
		self:DialogueNode_24()
	end)
end

function var_0_0:DialogueNode_24()
	self:ShowTalkView()
	self:SetTalkContent(11009022, "", 9512)
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
	self:OnNext(function(arg_139_0)
		self:ClearOnNext()
		self:DialogueNode_25()
	end)
end

function var_0_0:DialogueNode_25()
	self:EnableCameraByTagAction("3", 1, 0)
	self:PlayActorAnimationAction(9073, "proud_end", 0.1, 0.7666668, function()
		self:SetLookAtParamsAction(9073, 0.8, 1, 1)
		self:LookAtRoleAction(true, 9073, "9074")
		self:PlayActorAnimationAction(9073, "action3_1", 0.1, 2.266667, function()
			return
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11009023, "", 9073)
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
	self:OnNext(function(arg_145_0)
		self:ClearOnNext()
		self:DialogueNode_26()
	end)
end

function var_0_0:DialogueNode_26()
	self:SetLookAtParamsAction(9074, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9074, "9073")
	self:PlayActorAnimationAction(9074, "conversation_2", 0.1, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11009024, "", 9074)
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
	self:OnNext(function(arg_150_0)
		self:ClearOnNext()
		self:PureActorDialogueNode_27()
	end)
end

function var_0_0:PureActorDialogueNode_27()
	self:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		self:EnableCameraByTagAction("25", 1, 0)
		self:DelayTimeAction(1, function()
			self:ActorSeekerAction(9073, {
				"25_1"
			}, 0.5, function()
				return
			end)
		end)
		self:DelayTimeAction(3.5, function()
			self:EventAction(function()
				self:ImmediateNextFlag(-1)
			end)
		end)
		self:SetCharToTagAction(9073, "25", function()
			return
		end)
		self:SetCharToTagAction(9510, "26", function()
			return
		end)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_28()
	end)
end

function var_0_0:DialogueNode_28()
	self:SetCharToTagAction(9073, "25_1", function()
		self:PlayActorAnimationAction(9073, "happy01", 0, 2.333333, function()
			return
		end)
	end)
	self:EnableCameraByTagAction("25_1", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11009025, "", 9073)
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
	self:OnNext(function(arg_166_0)
		self:ClearOnNext()
		self:DialogueNode_29()
	end)
end

function var_0_0:DialogueNode_29()
	self:ActorSeekerAction(9510, {
		"26_1"
	}, 0.6, function()
		self:PlayActorAnimationAction(9510, "conversation_2", 0, 3.166667, function()
			return
		end)
	end)
	self:EnableCameraByTagAction("26", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11009026, "", 9510)
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
	self:OnNext(function(arg_172_0)
		self:ClearOnNext()
		self:DialogueNode_30()
	end)
end

function var_0_0:DialogueNode_30()
	self:PlayActorAnimationAction(9510, "think_loop", 0.2, 2, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11009027, "", 9510)
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
	self:OnNext(function(arg_177_0)
		self:ClearOnNext()
		self:DialogueNode_31()
	end)
end

function var_0_0:DialogueNode_31()
	self:BlackFadeAction(0.2, 0.2, 0.2, function()
		return
	end, function()
		self:EnableCameraByTagAction("27", 1, 0)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11009028, "", 9073)
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
	self:OnNext(function(arg_183_0)
		self:ClearOnNext()
		self:DialogueNode_32()
	end)
end

function var_0_0:DialogueNode_32()
	self:ShowTalkView()
	self:SetTalkContent(11009029, "", 9073)
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
	self:OnNext(function(arg_187_0)
		self:ClearOnNext()
		self:DialogueNode_33()
	end)
end

function var_0_0:DialogueNode_33()
	self:EnableCameraByTagAction("27", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11009030, "", 9073)
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
	self:OnNext(function(arg_191_0)
		self:ClearOnNext()
		self:PureActorDialogueNode_34()
	end)
end

function var_0_0:PureActorDialogueNode_34()
	self:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		self:EnableCameraByTagAction("xiuchuan3", 1, 0)
		self:PlayActorAnimationAction(9073, "jack_kick_1", 0, 1.166667, function()
			return
		end)
		self:SetCharToTagAction(9073, "xiuchuan_3", function()
			return
		end)
		self:DelayTimeAction(1.9, function()
			self:SetCharToTagAction(9073, "xiuchuan_4", function()
				return
			end)
			self:EnableCameraByTagAction("xiuchuan_4", 1, 0)
			self:CameraMoveAction("xiuchuan_4", 1, 4, 4, 0.4)
			self:DelayTimeAction(2.2, function()
				self:EnableCameraByTagAction("xiuchuan_6", 1, 0)
				self:CameraMoveAction("xiuchuan_6", 1, 4, 5, 0.4)
				self:DelayTimeAction(2, function()
					self:BlackFadeAction(0.2, 0.2, 0.2, function()
						self:InstEffectAction({
							pointTag = "bujian",
							destroyMode = "DontDestroy",
							createMode = "Point",
							path = "QWWorld/Effect/EmotionBubble/fx_canlan_0401.prefab"
						})
					end, function()
						self:HideAllDynamicAction(true, true, 4091, {
							10
						})
					end)
					self:DelayTimeAction(2.6, function()
						self:EventAction(function()
							self:ImmediateNextFlag(-1)
						end)
					end)
				end)
			end)
			self:PlayActorAnimationAction(9073, "jack_kick_2", 0, 1.866667, function()
				return
			end)
		end)
		self:CameraMoveAction("xiuchuan3", 1, 2, 4, 0.4)
		self:HideAllDynamicAction(true, true, 4091, {
			11
		})
		self:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_story_06_xiuchuan", "", "")
	end)
	self:Agent_PlayerPosControl("chuansong", function()
		return
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:BlackFadeDialogueNode_35()
	end)
end

function var_0_0:BlackFadeDialogueNode_35()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.2, 0.2, function()
		self:DestroyCharAction(9073)
		self:DestroyCharAction(9074)
		self:DestroyCharAction(9512)
		self:EnableCameraByTagAction("", 1, 0)
		self:HideAllDynamicAction(false, false, 4095, {})
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_36()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_36()
	self:EndStory()
end

function var_0_0:DialogueBranchNode_4()
	self:OnNext(function()
		self:ClearOnNext()
		self:PureActorDialogueNode_5()
	end)
	self:Next()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("LastWord", self.DialogueNode_33)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_36)
end

return var_0_0
