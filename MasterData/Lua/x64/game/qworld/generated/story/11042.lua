BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11042", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11042"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11042"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(true, true, 4095, {})
		self:SetCharToTagAction(907301, "1_0", function()
			self:ActorSeekerAction(907301, {
				"1"
			}, 2.5, function()
				return
			end)
		end)
		self:SetCharToTagAction(9074, "3", function()
			return
		end)
		self:SetCharToTagAction(9072, "2", function()
			return
		end)
		self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
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
	self:SetTalkContent(11042001, "", 907301)
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
	self:OnNext(function(arg_16_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:PlayActorAnimationAction(9074, "conversation_1", 0.05, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11042002, "", 9074)
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
	self:PlayActorAnimationAction(9072, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:EnableCameraByTagAction("3_1", 1, 0)
	self:CameraMoveAction("3_1", 4, 6, 5, 1.5)
	self:ShowTalkView()
	self:SetTalkContent(11042003, "", 9072)
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
	self:OnNext(function(arg_26_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:PlayActorAnimationAction(907301, "summer_doubt_start", 0.05, 0.7666667, function()
		return
	end)
	self:EnableCameraByTagAction("4", 1, 0)
	self:SetLookAtParamsAction(907301, 0.8, 1, 1)
	self:LookAtRoleAction(true, 907301, "9072")
	self:CameraMoveAction("4", 4, 4, 5, 0.1)
	self:ShowTalkView()
	self:SetTalkContent(11042004, "", 907301)
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
	self:OnNext(function(arg_31_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:PlayActorAnimationAction(9072, "conversation_1", 0.05, 3, function()
		return
	end)
	self:EnableCameraByTagAction("5", 1, 0)
	self:InstEffectAction({
		pointTag = "yahaha",
		destroyMode = "DontDestroy",
		createMode = "Point",
		path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
	})
	self:CameraMoveAction("5", 2, 1, 2, 0.3)
	self:DelayTimeAction(0.2, function()
		self:LoadThingToTag(1, "Yahaha_shigandang", "yahaha", function()
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
	self:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_action_sgd_appear", "", "")
	self:ShowTalkView()
	self:SetTalkContent(11042005, "", 9072)
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
	self:OnNext(function(arg_41_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:PlayActorAnimationAction(907301, "think_start", 0.05, 1.333333, function()
		return
	end)
	self:EnableCameraByTagAction("6", 1, 0)
	self:SetLookAtParamsAction(907301, 0.8, 1, 1)
	self:LookAtAction(true, 907301, "yahaha")
	self:ShowTalkView()
	self:SetTalkContent(11042006, "", 907301)
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
	self:OnNext(function(arg_46_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:PlayActorAnimationAction(9072, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:EnableCameraByTagAction("3", 1, 0)
	self:CameraMoveAction("3", 4, 3, 5.5, 0.3)
	self:ShowTalkView()
	self:SetTalkContent(11042007, "", 9072)
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
	self:OnNext(function(arg_51_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:PlayActorEmoteAction(9072, "happy01", 0, 1, function()
		return
	end, true, false)
	self:EnableCameraByTagAction("8", 1, 0)
	self:SetLookAtParamsAction(9072, 0.6, 0.8, 1)
	self:LookAtAction(true, 9072, "yahaha")
	self:InstEffectAction({
		pointTag = "yahaha",
		destroyMode = "DontDestroy",
		createMode = "Point",
		path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
	})
	self:DelayTimeAction(0.2, function()
		self:UnloadThing(1)
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
	self:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_action_sgd_disappear", "", "")
	self:ShowTalkView()
	self:SetTalkContent(11042008, "", 9072)
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
	self:OnNext(function(arg_60_0)
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:PlayActorAnimationAction(9074, "conversation_1", 0.05, 3, function()
		return
	end)
	self:EnableCameraByTagAction("9", 1, 0)
	self:SetLookAtParamsAction(9074, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9074, "9072")
	self:PlayActorEmoteAction(9074, "anger02_start", 0, 0.5, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11042009, "", 9074)
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
	self:OnNext(function(arg_66_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:PlayActorAnimationAction(9072, "proud_start", 0.05, 0.6, function()
		return
	end)
	self:SetLookAtParamsAction(9072, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9072, "907301")
	self:PlayActorEmoteAction(9072, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11042010, "", 9072)
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
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:PlayActorAnimationAction(907301, "summer_shock", 0, 1.166667, function()
		return
	end)
	self:EnableCameraByTagAction("6", 1, 0)
	self:DelayTimeAction(2, function()
		self:PlayActorAnimationAction(907301, "summer_doubt", 0, 2, function()
			return
		end)
	end)
	self:SetLookAtParamsAction(907301, 0.8, 1, 1)
	self:LookAtRoleAction(true, 907301, "9072")
	self:PlayActorEmoteAction(9072, "fear01", 0, 3.166667, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11042011, "", 0)
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
	self:OnNext(function(arg_80_0)
		self:ClearOnNext()
		self:DialogueNode_13()
	end)
end

function var_0_0:DialogueNode_13()
	self:PlayActorAnimationAction(9072, "proud_end", 0.05, 0.7666668, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11042012, "", 0)
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
	self:OnNext(function(arg_85_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_14()
	end)
end

function var_0_0:BlackFadeDialogueNode_14()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false, 4095, {})
		self:DestroyCharAction(9072)
		self:EnableCameraByTagAction("", 1, 0)
		self:DestroyCharAction(907301)
		self:DestroyCharAction(9074)
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
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_15)
end

return var_0_0
