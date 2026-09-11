BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11044", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11044"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11044"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(true, true, 4095, {})
		self:SetCharToTagAction(907301, "1", function()
			return
		end)
		self:SetCharToTagAction(9074, "2", function()
			return
		end)
		self:SetCharToTagAction(9510, "3", function()
			return
		end)
		self:SetCharToTagAction(9072, "4", function()
			return
		end)
		self:SetCharToTagAction(9071, "5", function()
			self:DelayTimeAction(0.1, function()
				self:ActorSeekerAction(9071, {
					"5_1"
				}, 0.8, function()
					return
				end)
			end)
		end)
		self:SetCharToTagAction(9060, "6", function()
			return
		end)
		self:ActorSeekerAction(907301, {
			"1_1"
		}, 2.5, function()
			return
		end)
		self:ActorSeekerAction(9510, {
			"3_1"
		}, 0.6, function()
			return
		end)
		self:ActorSeekerAction(9072, {
			"1_1"
		}, 0.6, function()
			return
		end)
		self:ActorSeekerAction(9060, {
			"6_1"
		}, 0.65, function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:DelayTimeAction(0.2, function()
			self:ActorSeekerAction(9074, {
				"1_1"
			}, 0.6, function()
				return
			end)
		end)
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
	self:DelayTimeAction(2.6, function()
		self:EventAction(function()
			self:ImmediateNextFlag(-1)
		end)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:PlayActorAnimationAction(9060, "dorm_male_idle01", 0.1, 8.166667, function()
		return
	end)
	self:DelayTimeAction(2.5, function()
		self:EnableCameraByTagAction("1_1", 1, 0)
		self:CameraMoveAction("1_1", 4, 6, 6, 0.4)
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
	end)
	self:SetLookAtParamsAction(9060, 0.8, 1, 1)
	self:LookAtAction(true, 9060, "ta")
	self:ShowTalkView()
	self:SetTalkContent(11044001, "", 9060)
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
	self:OnNext(function(arg_35_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:EnableCameraByTagAction("2", 1, 0)
	self:PlayActorAnimationAction(907301, "proud_start", 0.05, 0.6, function()
		return
	end)
	self:DelayTimeAction(0.5, function()
		self:PlayActorEmoteAction(907301, "happy01_start", 0, 0.1333333, function()
			return
		end, true, true)
	end)
	self:SetCharToTagAction(907301, "1_2", function()
		return
	end)
	self:DelayTimeAction(2, function()
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
	self:ShowTalkView()
	self:SetTalkContent(11044002, "", 907301)
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
	self:OnNext(function(arg_46_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:PlayActorEmoteAction(907301, "happy01_end", 0, 0.2666667, function()
		return
	end, true, false)
	self:SetLookAtParamsAction(907301, 0.8, 1, 1)
	self:LookAtAction(true, 907301, "kan")
	self:InstEffectAction({
		attachFollow = false,
		delayTime = 5,
		createMode = "RoleAttach",
		destroyMode = "DelayTime",
		attachType = 10,
		roleId = 907301,
		path = "QWWorld/Effect/EmotionBubble/fx_daxiao_0802_QW"
	})
	self:ShowTalkView()
	self:SetTalkContent(11044003, "", 907301)
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
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:EnableCameraByTagAction("4", 1, 0)
	self:PlayActorAnimationAction(9071, "conversation_1", 0.05, 3, function()
		return
	end)
	self:DestroyCharAction(9072)
	self:DestroyCharAction(9074)
	self:ShowTalkView()
	self:SetTalkContent(11044004, "", 9071)
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
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:PlayActorAnimationAction(9510, "stroke01", 0.05, 9.066668, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11044005, "", 9510)
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
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:ShowTalkView()
	self:SetTalkContent(11044006, "", 907301)
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
		self:BlackFadeDialogueNode_9()
	end)
end

function var_0_0:BlackFadeDialogueNode_9()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false, 4095, {})
		self:DestroyCharAction(907301)
		self:EnableCameraByTagAction("", 1, 0)
		self:DestroyCharAction(9071)
		self:DestroyCharAction(9060)
		self:DestroyCharAction(9510)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_10()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_10()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("LastWord", self.BlackFadeDialogueNode_9)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_10)
end

return var_0_0
