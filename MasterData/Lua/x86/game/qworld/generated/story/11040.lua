BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11040", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11040"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11040"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:EnableCameraCutAction(true)
		self:SetCharToTagAction(9060, "9060-1", function()
			return
		end)
		self:SetCharToTagAction(9074, "9074-1", function()
			return
		end)
		self:HideAllDynamicAction(true, true, 11, {
			15
		})
		self:ActorSeekerAction(9060, {
			"9060-2"
		}, 0.5, function()
			return
		end)
		self:SetCharToTagAction(9510, "9510-1", function()
			return
		end)
		self:SetCharToTagAction(907301, "9073-1", function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:BirdsGlobleCull(true)
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
	self:CameraMoveAction("1", 3, 1, 4.5, 1)
	self:DelayTimeAction(4, function()
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
	self:ShowTalkView()
	self:SetTalkContent(11040001, "", 9060)
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
	self:OnNext(function(arg_20_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:EnableCameraByTagAction("2", 1, 0)
	self:PlayActorAnimationAction(9510, "summer_doubt", 0.1, 2, function()
		return
	end)
	self:PlayActorEmoteAction(9510, "blink", 0.2, 0.3333333, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11040002, "", 9510)
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
	self:OnNext(function(arg_26_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:PlayActorAnimationAction(907301, "action2_1", 0.1, 1.666667, function()
		return
	end)
	self:EnableCameraByTagAction("3", 2, 0.5)
	self:SetLookAtParamsAction(907301, 0.8, 1, 1)
	self:LookAtRoleAction(true, 907301, "9510")
	self:ShowTalkView()
	self:SetTalkContent(11040003, "", 907301)
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
	self:EnableCameraByTagAction("4", 2, 0.5)
	self:PlayActorEmoteAction(9510, "sad04_start", 0, 0.5, function()
		return
	end, true, true)
	self:PlayActorAnimationAction(9510, "summer_shock", 0, 1.166667, function()
		return
	end)
	self:SetLookAtParamsAction(9510, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9510, "907301")
	self:ShowTalkView()
	self:SetTalkContent(11040004, "", 9510)
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
	self:EnableCameraByTagAction("5", 1, 0.5)
	self:CameraMoveAction("5", 4, 6, 3, 0.2)
	self:PlayActorAnimationAction(907301, "proud", 0.05, 2.333333, function()
		return
	end)
	self:ActorSeekerAction(907301, {
		"9073-2"
	}, 0.5, function()
		return
	end)
	self:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11040005, "", 907301)
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
	self:OnNext(function(arg_44_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:PlayActorEmoteAction(9510, "sad03_end", 0, 0.7333333, function()
		self:DelayTimeAction(0.2, function()
			self:PlayActorAnimationAction(9510, "embarrassed", 0.05, 2.6, function()
				return
			end)
		end)
	end, true, false)
	self:SetLookAtParamsAction(9510, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9510, "907301")
	self:EnableCameraByTagAction("6", 1, 0.5)
	self:ShowTalkView()
	self:SetTalkContent(11040006, "", 9510)
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
	self:OnNext(function(arg_51_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:EnableCameraByTagAction("7", 1, 0.5)
	self:PlayActorAnimationAction(9074, "dorm_female_idle01", 0.05, 4.166667, function()
		return
	end)
	self:SetLookAtParamsAction(9074, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9074, "907301")
	self:ShowTalkView()
	self:SetTalkContent(11040007, "", 9074)
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
	self:OnNext(function(arg_56_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:EnableCameraByTagAction("8", 1, 0.5)
	self:CameraMoveAction("8", 3, 4, 2, 0.2)
	self:PlayActorAnimationAction(9510, "take", 0.05, 1.833333, function()
		return
	end)
	self:SetLookAtParamsAction(907301, 0.8, 1, 1)
	self:LookAtRoleAction(false, 907301, "907301")
	self:ShowTalkView()
	self:SetTalkContent(11040008, "", 9510)
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
	self:OnNext(function(arg_61_0)
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:ActorSeekerAction(9510, {
		"9510-2",
		"9510-3",
		"9510-4",
		"9510-5"
	}, 2.5, function()
		return
	end)
	self:DelayTimeAction(4, function()
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
	self:EnableCameraByTagAction("9_1", 1, 0.5)
	self:ShowTalkView()
	self:SetTalkContent(11040009, "", 9510)
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
	self:OnNext(function(arg_69_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:DestroyCharAction(9510)
	self:EnableCameraByTagAction("10", 1, 0.5)
	self:PlayActorAnimationAction(907301, "win", 0.05, 1.933333, function()
		return
	end)
	self:SetCharToTagAction(907301, "9073-2", function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11040010, "", 907301)
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
	self:EnableCameraByTagAction("11", 1, 0.5)
	self:PlayActorAnimationAction(9074, "action3_1", 0.05, 2.266667, function()
		return
	end)
	self:SetLookAtParamsAction(9074, 0.6, 0.8, 1)
	self:LookAtRoleAction(true, 9074, "907301")
	self:ShowTalkView()
	self:SetTalkContent(11040011, "", 9074)
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
	self:OnNext(function(arg_80_0)
		self:ClearOnNext()
		self:PureActorDialogueNode_13()
	end)
end

function var_0_0:PureActorDialogueNode_13()
	self:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		self:EnableCameraByTagAction("xiuchuan_1", 1, 0)
		self:PlayActorAnimationAction(907301, "jack_kick_1", 0, 1.166667, function()
			return
		end)
		self:SetCharToTagAction(907301, "xiuchuan_1", function()
			return
		end)
		self:DelayTimeAction(1.8, function()
			self:CameraMoveAction("xiuchuan_2", 1, 4, 4, 0.4)
			self:EnableCameraByTagAction("xiuchuan_2", 1, 0)
			self:DelayTimeAction(2.2, function()
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
							14
						})
					end)
					self:DelayTimeAction(2.6, function()
						self:EventAction(function()
							self:ImmediateNextFlag(-1)
						end)
					end)
				end)
				self:EnableCameraByTagAction("xiuchuan_4", 1, 0)
				self:DestroyCharAction(907301)
				self:CameraMoveAction("xiuchuan_4", 1, 4, 5, 0.4)
			end)
			self:SetCharToTagAction(907301, "xiuchuan_2", function()
				return
			end)
			self:PlayActorAnimationAction(907301, "jack_kick_2", 0, 1.933334, function()
				return
			end)
		end)
		self:CameraMoveAction("xiuchuan_1", 1, 2, 4, 0.4)
		self:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_story_06_xiuchuan", "", "")
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:BlackFadeDialogueNode_14()
	end)
end

function var_0_0:BlackFadeDialogueNode_14()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:DestroyCharAction(9060)
		self:DestroyCharAction(9510)
		self:DestroyCharAction(907301)
		self:DestroyCharAction(9074)
		self:HideAllDynamicAction(false, false, 4095, {})
		self:Agent_PlayerPosControl("chuansong", function()
			self:EnableCameraByTagAction("", 1, 0.5)
		end)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_15()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_15()
	self:EnableCameraCutAction(false)
	self:BirdsGlobleCull(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("LastWord", self.DialogueNode_12)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_15)
end

return var_0_0
