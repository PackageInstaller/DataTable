BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11030", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11030"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11030"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(true, 11030001, 3, 0.5, 0.5, function()
		self:HideAllDynamicAction(true, true, 4095, {})
		self:SetCharToTagAction(9514, "1", function()
			self:InstEffectAction({
				attachFollow = false,
				delayTime = 4,
				createMode = "RoleAttach",
				destroyMode = "DelayTime",
				attachType = 10,
				roleId = 9514,
				path = "QWWorld/Effect/EmotionBubble/fx_xixi_1201_QW"
			})
		end)
		self:SetCharToTagAction(9521, "2", function()
			self:InstEffectAction({
				attachFollow = false,
				delayTime = 4,
				createMode = "RoleAttach",
				destroyMode = "DelayTime",
				attachType = 10,
				roleId = 9521,
				path = "QWWorld/Effect/EmotionBubble/fx_daxiao_0802_QW"
			})
		end)
		self:SetCharToTagAction(9518, "3", function()
			self:InstEffectAction({
				attachFollow = false,
				delayTime = 4,
				createMode = "RoleAttach",
				destroyMode = "DelayTime",
				attachType = 10,
				roleId = 9518,
				path = "QWWorld/Effect/EmotionBubble/fx_piaosan_1401"
			})
		end)
		self:SetCharToTagAction(9520, "4", function()
			self:InstEffectAction({
				attachFollow = false,
				delayTime = 4,
				createMode = "RoleAttach",
				destroyMode = "DelayTime",
				attachType = 10,
				roleId = 9520,
				path = "QWWorld/Effect/EmotionBubble/fx_daxiao_0801_QW_behind"
			})
		end)
		self:PlayActorAnimationAction(9514, "cute", 0.05, 2.333333, function()
			return
		end)
		self:PlayActorAnimationAction(9521, "action2_1", 0.05, 1.666667, function()
			return
		end)
		self:PlayActorAnimationAction(9518, "firm", 0.05, 2.333333, function()
			return
		end)
		self:PlayActorAnimationAction(9520, "conversation_2", 0.05, 3.166667, function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:WalkingPeopleGlobleCull(true)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:PureActorDialogueNode_2()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:PureActorDialogueNode_2()
	self:DelayTimeAction(3.5, function()
		self:EventAction(function()
			self:ImmediateNextFlag(-1)
		end)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:BlackFadeDialogueNode_3()
	end)
end

function var_0_0:BlackFadeDialogueNode_3()
	self:HideTalkView()
	self:OnBlackFade(true, 11030002, 3, 0.5, 1, function()
		self:EnableCameraByTagAction("2", 1, 0)
		self:SetCharToTagAction(9514, "8", function()
			return
		end)
		self:PlayActorAnimationAction(9514, "conversation_2", 0, 3.166667, function()
			return
		end)
		self:PlayActorEmoteAction(9514, "happy01_start", 0, 0.1333333, function()
			return
		end, true, true)
		self:SetCharToTagAction(9073, "9073", function()
			return
		end)
		self:SetCharToTagAction(9072, "9072", function()
			return
		end)
		self:SetCharToTagAction(9510, "9510", function()
			return
		end)
		self:DestroyCharAction(9512)
		self:DestroyCharAction(9513)
		self:DestroyCharAction(9523)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:DialogueNode_4()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:DialogueNode_4()
	self:ShowTalkView()
	self:SetTalkContent(11030003, "", 9514)
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
	self:OnNext(function(arg_34_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:EnableCameraByTagAction("4", 1, 0)
	self:PlayActorAnimationAction(9073, "proud", 0.05, 2.333333, function()
		self:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
			return
		end)
	end)
	self:PlayActorEmoteAction(9073, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11030004, "", 9073)
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
	self:EnableCameraByTagAction("5", 2, 1)
	self:PlayActorAnimationAction(9510, "action2_1", 0.05, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11030005, "", 9510)
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
	self:EnableCameraByTagAction("6", 1, 0)
	self:PlayActorAnimationAction(9514, "action3_1", 0.05, 2.266667, function()
		self:PlayActorAnimationAction(9514, "embarrassed", 0.05, 2.6, function()
			return
		end)
		self:PlayActorEmoteAction(9514, "blink", 0.1, 0.3333333, function()
			return
		end, true, false)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11030006, "", 9514)
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
	self:OnNext(function(arg_53_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:PlayActorAnimationAction(9514, "sad_02", 0.05, 6.733334, function()
		return
	end)
	self:PlayActorEmoteAction(9514, "blink", 0.1, 0.3333333, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11030007, "", 9514)
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
	self:OnNext(function(arg_59_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:EnableCameraByTagAction("4", 1, 0)
	self:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "blink", 0.1, 0.3333333, function()
		return
	end, false, false)
	self:ShowTalkView()
	self:SetTalkContent(11030008, "", 9073)
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
	self:OnNext(function(arg_65_0)
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:EnableCameraByTagAction("9", 2, 1)
	self:PlayActorAnimationAction(9072, "action2_1", 0.05, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11030009, "", 9072)
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
	self:OnNext(function(arg_70_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:EnableCameraByTagAction("10", 1, 0)
	self:PlayActorAnimationAction(9510, "firm_start", 0.05, 0.5666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11030010, "", 9510)
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
	self:OnNext(function(arg_75_0)
		self:ClearOnNext()
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:EnableCameraByTagAction("6", 1, 0)
	self:PlayActorAnimationAction(9514, "summer_doubt", 0.05, 2, function()
		self:PlayActorEmoteAction(9514, "glory01", 0.05, 1.566667, function()
			return
		end, true, false)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11030011, "", 9514)
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
		self:DialogueNode_13()
	end)
end

function var_0_0:DialogueNode_13()
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9073, "9510")
	self:EnableCameraByTagAction("10", 1, 0)
	self:DelayTimeAction(2, function()
		self:PlayActorAnimationAction(9073, "conversation_1", 0.05, 3, function()
			return
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11030012, "", 9073)
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
		self:DialogueNode_14()
	end)
end

function var_0_0:DialogueNode_14()
	self:EnableCameraByTagAction("5", 1, 0)
	self:PlayActorAnimationAction(9510, "action3_1", 0, 2.266667, function()
		self:SetLookAtParamsAction(9510, 0.8, 1, 1)
		self:LookAtRoleAction(true, 9510, "9514")
		self:DelayTimeAction(1, function()
			self:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
				return
			end)
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
			self:EnableCameraByTagAction("2", 1, 0)
		end)
	end)
	self:SetLookAtParamsAction(9072, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9072, "9073")
	self:SetLookAtParamsAction(9510, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9510, "9073")
	self:ShowTalkView()
	self:SetTalkContent(11030013, "", 9510)
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
	self:OnNext(function(arg_96_0)
		self:ClearOnNext()
		self:DialogueNode_15()
	end)
end

function var_0_0:DialogueNode_15()
	self:PlayActorAnimationAction(9514, "conversation_2", 0.05, 3.166667, function()
		self:PlayActorAnimationAction(9514, "summer_doubt", 0.05, 2, function()
			return
		end)
	end)
	self:SetLookAtParamsAction(9514, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9514, "9510")
	self:ShowTalkView()
	self:SetTalkContent(11030014, "", 9514)
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
		self:DialogueNode_16()
	end)
end

function var_0_0:DialogueNode_16()
	self:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
		return
	end)
	self:DelayTimeAction(1, function()
		self:BlackFadeAction(0.2, 0.5, 0.5, function()
			self:DelayTimeAction(0.5, function()
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
		end, function()
			self:EnableCameraByTagAction("15", 1, 0)
			self:CameraMoveAction("15", 4, 3, 5, 0.4)
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11030015, "", 9510)
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
	self:OnNext(function(arg_113_0)
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
end

function var_0_0:DialogueNode_17()
	self:PlayActorAnimationAction(9073, "win", 0.1, 1.933333, function()
		return
	end)
	self:SetLookAtParamsAction(9073, 0.6, 0.8, 1)
	self:LookAtRoleAction(true, 9073, "9510")
	self:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		self:EnableCameraByTagAction("4", 1, 0)
		self:PlayActorEmoteAction(9073, "shocked01", 0, 1.4, function()
			return
		end, true, false)
		self:CameraMoveAction("4", 4, 1, 0.6, 0.2)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11030016, "", 9073)
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
	self:OnNext(function(arg_121_0)
		self:ClearOnNext()
		self:DialogueNode_18()
	end)
end

function var_0_0:DialogueNode_18()
	self:EnableCameraByTagAction("10", 1, 0)
	self:PlayActorAnimationAction(9072, "conversation_1", 0.05, 3, function()
		return
	end)
	self:SetLookAtParamsAction(9072, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9072, "9073")
	self:ShowTalkView()
	self:SetTalkContent(11030017, "", 9072)
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
	self:OnNext(function(arg_126_0)
		self:ClearOnNext()
		self:DialogueNode_19()
	end)
end

function var_0_0:DialogueNode_19()
	self:PlayActorAnimationAction(9073, "cute", 0.1, 2.333333, function()
		return
	end)
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9073, "9072")
	self:ShowTalkView()
	self:SetTalkContent(11030018, "", 9073)
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
	self:OnNext(function(arg_131_0)
		self:ClearOnNext()
		self:DialogueNode_20()
	end)
end

function var_0_0:DialogueNode_20()
	self:EnableCameraByTagAction("19", 1, 0)
	self:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9073, "9510")
	self:ShowTalkView()
	self:SetTalkContent(11030019, "", 9073)
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
	self:OnNext(function(arg_136_0)
		self:ClearOnNext()
		self:DialogueNode_21()
	end)
end

function var_0_0:DialogueNode_21()
	self:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
		return
	end)
	self:PlayActorEmoteAction(9510, "happy01", 0, 1, function()
		return
	end, true, false)
	self:SetLookAtParamsAction(9510, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9510, "9073")
	self:ShowTalkView()
	self:SetTalkContent(11030020, "", 9510)
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
	self:OnNext(function(arg_142_0)
		self:ClearOnNext()
		self:DialogueNode_22()
	end)
end

function var_0_0:DialogueNode_22()
	self:EnableCameraByTagAction("19", 2, 1)
	self:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11030024, "", 9510)
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
	self:OnNext(function(arg_147_0)
		self:ClearOnNext()
		self:DialogueNode_23()
	end)
end

function var_0_0:DialogueNode_23()
	self:PlayActorAnimationAction(9073, "firm_start", 0.05, 0.5666667, function()
		return
	end)
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9073, "9510")
	self:PlayActorEmoteAction(9073, "blink", 0, 0.3333333, function()
		return
	end, true, false)
	self:EnableCameraByTagAction("19", 1, 1)
	self:ShowTalkView()
	self:SetTalkContent(11030025, "", 9073)
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
	self:OnNext(function(arg_153_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_24()
	end)
end

function var_0_0:BlackFadeDialogueNode_24()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false, 4095, {})
		self:DestroyCharAction(9072)
		self:DestroyCharAction(9073)
		self:DestroyCharAction(9510)
		self:DestroyCharAction(9514)
		self:Agent_PlayerPosControl("chuansong", function()
			self:EnableCameraByTagAction("", 1, 0)
		end)
		self:WalkingPeopleGlobleCull(false)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_25()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_25()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("LastWord", self.DialogueNode_23)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_25)
end

return var_0_0
