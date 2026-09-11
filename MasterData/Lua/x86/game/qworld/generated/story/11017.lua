BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11017", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11017"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11017"
end

function var_0_0:StartStory()
	self:PureActorDialogueNode_1()
end

function var_0_0:PureActorDialogueNode_1()
	self:BlackFadeAction(0.2, 0.2, 0.2, function()
		return
	end, function()
		self:EnableCameraByTagAction("ranbu_1", 1, 0)
		self:HideAllDynamicAction(true, true, 4083, {
			30008
		})
		self:InstEffectAction({
			pointTag = "ranbu_3",
			destroyMode = "DontDestroy",
			createMode = "Point",
			path = "QWWorld/Effect/fx_dye_cloth_3.prefab"
		})
		self:DelayTimeAction(1.5, function()
			self:InstEffectAction({
				pointTag = "ranbu_2",
				destroyMode = "DontDestroy",
				createMode = "Point",
				path = "QWWorld/Effect/fx_dye_cloth_2.prefab"
			})
		end)
		self:DelayTimeAction(3, function()
			self:InstEffectAction({
				pointTag = "ranbu_1",
				destroyMode = "DontDestroy",
				createMode = "Point",
				path = "QWWorld/Effect/fx_dye_cloth_1.prefab"
			})
		end)
		self:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_story_03_ranbu", "", "")
	end)
	self:DelayTimeAction(5, function()
		self:EventAction(function()
			self:ImmediateNextFlag(-1)
		end)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:BlackFadeDialogueNode_2()
	end)
end

function var_0_0:BlackFadeDialogueNode_2()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:SetCharToTagAction(9073, "1", function()
			return
		end)
		self:SetCharToTagAction(9513, "2", function()
			return
		end)
		self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
		self:HideAllDynamicAction(true, true, 4083, {
			30007,
			30008
		})
		self:WalkingPeopleGlobleCull(true)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:DialogueNode_3()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:DialogueNode_3()
	self:PlayActorAnimationAction(9073, "happy04", 0, 2.2, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11017001, "", 9073)
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
	self:OnNext(function(arg_23_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:PlayActorAnimationAction(9513, "conversation_1", 0, 3, function()
		self:PlayActorAnimationAction(9513, "summer_doubt", 0, 2, function()
			return
		end)
	end)
	self:CameraMoveAction("1", 4, 4, 5, 0.35)
	self:EnableCameraByTagAction("1", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11017002, "", 9513)
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
	self:OnNext(function(arg_29_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:PlayActorAnimationAction(9073, "embarrassed", 0, 2.6, function()
		self:PlayActorAnimationAction(9073, "conversation_2", 0, 3.166667, function()
			return
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11017003, "", 9073)
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
	self:OnNext(function(arg_35_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:PlayActorAnimationAction(9513, "action2_1", 0, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11017004, "", 9513)
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
	self:OnNext(function(arg_40_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:PlayActorAnimationAction(9073, "summer_doubt_start", 0, 0.7666667, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "happy01", 0, 1, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11017005, "", 9073)
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
	self:EnableCameraByTagAction("1", 1, 0)
	self:CameraMoveAction("1", 4, 4, 7, 0.5)
	self:PlayActorAnimationAction(9513, "action2_3", 0, 1.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11017006, "", 9513)
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
	self:PlayActorAnimationAction(9513, "action2_3", 0.1, 1.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11017007, "", 9513)
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
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:PlayActorAnimationAction(9073, "action3_1", 0, 2.266667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11017008, "", 9073)
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
	self:OnNext(function(arg_61_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	self:PlayActorAnimationAction(9513, "proud", 0, 2.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11017009, "", 9513)
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
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:EnableCameraByTagAction("10", 1, 0)
	self:PlayActorAnimationAction(9073, "conversation_2", 0, 3.166667, function()
		return
	end)
	self:CameraMoveAction("10", 7, 6, 6, 0.4)
	self:ShowTalkView()
	self:SetTalkContent(11017010, "", 9073)
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
	self:OnNext(function(arg_71_0)
		self:ClearOnNext()
		self:DialogueNode_13()
	end)
end

function var_0_0:DialogueNode_13()
	self:PlayActorAnimationAction(9513, "conversation_1", 0, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11017011, "", 9513)
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
	self:OnNext(function(arg_76_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_14()
	end)
end

function var_0_0:BlackFadeDialogueNode_14()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:DestroyCharAction(9073)
		self:DestroyCharAction(9513)
		self:EnableCameraByTagAction("", 1, 0)
		self:HideAllDynamicAction(false, false, 4095, {})
		self:WalkingPeopleGlobleCull(false)
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
	self:RegisterTalkFunction("End", self.BlackFadeDialogueNode_14)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_15)
end

return var_0_0
