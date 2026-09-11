BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11023", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11023"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11023"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 11023001, 2.5, 0.5, 0.5, function()
		self:SetCharToTagAction(9515, "1", function()
			return
		end)
		self:SetCharToTagAction(9073, "2", function()
			return
		end)
		self:SetCharToTagAction(9072, "3", function()
			return
		end)
		self:SetCharToTagAction(9510, "4", function()
			return
		end)
		self:SetLookAtParamsAction(9073, 0.8, 1, 1)
		self:LookAtRoleAction(true, 9073, "9515")
		self:SetLookAtParamsAction(9510, 0.8, 1, 1)
		self:LookAtRoleAction(true, 9510, "9515")
		self:SetLookAtParamsAction(9072, 0.8, 1, 1)
		self:LookAtRoleAction(true, 9072, "9515")
		self:EnableCameraByTagAction("1", 1, 0)
		self:PlayActorAnimationAction(9515, "think_loop", 0, 2, function()
			return
		end)
		self:PlayActorEmoteAction(9515, "squint01_start", 0, 0.3333333, function()
			return
		end, true, true)
		self:HideAllDynamicAction(true, true, 4091, {
			13
		})
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
	self:SetTalkContent(11023002, "", 9515)
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
	self:OnNext(function(arg_18_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:EnableCameraByTagAction("2", 1, 0)
	self:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11023003, "", 9510)
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
	self:OnNext(function(arg_23_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:EnableCameraByTagAction("4", 1, 0)
	self:PlayActorEmoteAction(9515, "squint01_end", 0, 0.4333335, function()
		return
	end, true, false)
	self:SetLookAtParamsAction(9515, 0.6, 0.8, 1)
	self:LookAtRoleAction(true, 9515, "9510")
	self:ActorSeekerAction(9515, {
		"5"
	}, 0.3, function()
		self:DelayTimeAction(0.5, function()
			self:PlayActorAnimationAction(9515, "action2_1", 0.05, 1.666667, function()
				return
			end)
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11023004, "", 9515)
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
	self:OnNext(function(arg_31_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:EnableCameraByTagAction("5", 1, 0)
	self:PlayActorAnimationAction(9515, "action2_3", 0.05, 1.333333, function()
		self:PlayActorAnimationAction(9515, "conversation_2", 0.05, 3.166667, function()
			return
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11023005, "", 9515)
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
	self:OnNext(function(arg_37_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:PlayActorAnimationAction(9073, "action3_1", 0.05, 2.266667, function()
		return
	end)
	self:EnableCameraByTagAction("6", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11023006, "", 9073)
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
	self:OnNext(function(arg_42_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:SetLookAtParamsAction(9515, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9515, "9073")
	self:EnableCameraByTagAction("7", 1, 0)
	self:PlayActorAnimationAction(9515, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:CameraMoveAction("7", 4, 5, 5, 0.2)
	self:ShowTalkView()
	self:SetTalkContent(11023007, "", 9515)
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
	self:OnNext(function(arg_47_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:EnableCameraByTagAction("8", 1, 0)
	self:PlayActorEmoteAction(9072, "disdain01_start", 0, 0.4, function()
		return
	end, true, true)
	self:CameraMoveAction("8", 4, 1, 0.8, 0.4)
	self:ShowTalkView()
	self:SetTalkContent(11023008, "", 9072)
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
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:EnableCameraByTagAction("9", 1, 0)
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9073, "9072")
	self:PlayActorAnimationAction(9073, "summer_doubt", 0.05, 2, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11023009, "", 9073)
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
	self:OnNext(function(arg_58_0)
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:SetLookAtParamsAction(9072, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9072, "9073")
	self:PlayActorAnimationAction(9072, "action2_1", 0.05, 1.666667, function()
		return
	end)
	self:PlayActorEmoteAction(9072, "shocked01_start", 0, 0.3666667, function()
		return
	end, false, false)
	self:ShowTalkView()
	self:SetTalkContent(11023010, "", 9072)
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
	self:OnNext(function(arg_64_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:PlayActorAnimationAction(9073, "action3_1", 0.05, 2.266667, function()
		return
	end)
	self:EnableCameraByTagAction("11", 1, 0)
	self:SetLookAtParamsAction(9510, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9510, "9072")
	self:PlayActorEmoteAction(9073, "shocked01_start", 0, 0.3666667, function()
		return
	end, false, false)
	self:ShowTalkView()
	self:SetTalkContent(11023011, "", 9073)
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
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11023012, "", 9510)
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
		self:DialogueNode_13()
	end)
end

function var_0_0:DialogueNode_13()
	self:PlayActorAnimationAction(9073, "action3_3", 0.05, 2.566667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11023013, "", 9073)
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
	self:OnNext(function(arg_80_0)
		self:ClearOnNext()
		self:DialogueNode_14()
	end)
end

function var_0_0:DialogueNode_14()
	self:EnableCameraByTagAction("14", 1, 0)
	self:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
		return
	end)
	self:PlayActorEmoteAction(9510, "blink", 0, 0.3333333, function()
		return
	end, true, false)
	self:SetLookAtParamsAction(9072, 0.6, 0.8, 1)
	self:LookAtRoleAction(false, 9072, "9073")
	self:ShowTalkView()
	self:SetTalkContent(11023014, "", 9510)
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
	self:EnableCameraByTagAction("15", 1, 0)
	self:PlayActorAnimationAction(9073, "summer_doubt", 0.05, 2, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11023015, "", 9073)
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
	self:EnableCameraByTagAction("16", 1, 0)
	self:CameraMoveAction("16", 4, 1, 0.8, 0.3)
	self:PlayActorAnimationAction(9072, "proud_start", 0.05, 0.6, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11023016, "", 9072)
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
	self:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		self:EnableCameraByTagAction("27", 1, 0)
		self:CameraMoveAction("27", 4, 4, 10, 1.5)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11023017, "", 9072)
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
	self:OnNext(function(arg_103_0)
		self:ClearOnNext()
		self:DialogueNode_18()
	end)
end

function var_0_0:DialogueNode_18()
	self:ShowTalkView()
	self:SetTalkContent(11023018, "", 9072)
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
	self:ShowTalkView()
	self:SetTalkContent(11023019, "", 9073)
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
	self:OnNext(function(arg_111_0)
		self:ClearOnNext()
		self:PureActorDialogueNode_20()
	end)
end

function var_0_0:PureActorDialogueNode_20()
	self:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		self:EnableCameraByTagAction("xiuchuan_1", 1, 0)
		self:PlayActorAnimationAction(9073, "jack_kick_1", 0, 1.166667, function()
			return
		end)
		self:SetCharToTagAction(9073, "xiuchuan_1", function()
			return
		end)
		self:DelayTimeAction(1.8, function()
			self:CameraMoveAction("xiuchuan_2", 1, 4, 4, 0.4)
			self:EnableCameraByTagAction("xiuchuan_2", 1, 0)
			self:DelayTimeAction(2.2, function()
				self:EnableCameraByTagAction("xiuchuan_4", 1, 0)
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
							12
						})
					end)
					self:DelayTimeAction(2.6, function()
						self:EventAction(function()
							self:ImmediateNextFlag(-1)
						end)
					end)
				end)
				self:DestroyCharAction(9073)
				self:CameraMoveAction("xiuchuan_4", 1, 4, 5, 0.4)
			end)
			self:SetCharToTagAction(9073, "xiuchuan_2", function()
				return
			end)
			self:PlayActorAnimationAction(9073, "jack_kick_2", 0, 1.933334, function()
				return
			end)
		end)
		self:CameraMoveAction("xiuchuan_1", 1, 2, 4, 0.4)
		self:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_story_06_xiuchuan", "", "")
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:BlackFadeDialogueNode_21()
	end)
end

function var_0_0:BlackFadeDialogueNode_21()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false, 4095, {})
		self:DestroyCharAction(9072)
		self:DestroyCharAction(9510)
		self:DestroyCharAction(9515)
		self:Agent_PlayerPosControl("chuansong", function()
			self:EnableCameraByTagAction("", 1, 0)
		end)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_22()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_22()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("LastWord", self.DialogueNode_19)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_22)
end

return var_0_0
