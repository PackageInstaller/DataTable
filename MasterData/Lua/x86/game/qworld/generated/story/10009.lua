BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10009", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "10009"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/10009"
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
		self:SetCharToTagAction(9072, "9072_1", function()
			return
		end)
		self:HideAllDynamicAction(true, true)
		self:SetCharToTagAction(9074, "9074", function()
			return
		end)
		self:ActorSeekerAction(9070, {
			"9070_2"
		}, 0.6, function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:SetLookAtParamsAction(9072, 0.8, 1, 0.1)
		self:LookAtRoleAction(true, 9072, "9070")
		self:SetLookAtParamsAction(9074, 0.8, 1, 0.1)
		self:LookAtRoleAction(true, 9074, "9070")
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
	self:DelayTimeAction(2, function()
		self:SetNeedClick(true, {
			Invoke = function()
				self:Next()
			end
		})
		self:SetNeedSkip(false, nil)
	end)
	self:CameraMoveAction("1", 1, 1, 3, 1)
	self:DelayTimeAction(2.2, function()
		self:SetNeedClick(true, {
			Invoke = function()
				self:Next()
			end
		})
		self:SetNeedSkip(false, nil)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10009001, "", 0)
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
	self:OnNext(function(arg_20_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:PlayActorAnimationAction(9072, "action4_1", 0.2, 2.666667, function()
		return
	end)
	self:EnableCameraByTagAction("2", 1, 0)
	self:DelayTimeAction(1, function()
		self:SetNeedClick(true, {
			Invoke = function()
				self:Next()
			end
		})
		self:SetNeedSkip(false, nil)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10009002, "", 0)
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
	self:OnNext(function(arg_27_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:PlayActorAnimationAction(9070, "stroke01", 0.2, 9.066668, function()
		return
	end)
	self:EnableCameraByTagAction("3", 1, 0)
	self:SetLookAtParamsAction(9070, 0.8, 1, 0.8)
	self:LookAtRoleAction(true, 9070, "9072")
	self:ShowTalkView()
	self:SetTalkContent(10009003, "", 0)
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
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:PlayActorAnimationAction(9072, "action4_3", 0.2, 4.3, function()
		return
	end)
	self:EnableCameraByTagAction("4", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(10009004, "", 0)
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
	self:OnNext(function(arg_37_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:PlayActorAnimationAction(9074, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	self:ActorSeekerAction(9070, {
		"9070_3"
	}, 0.5, function()
		return
	end)
	self:EnableCameraByTagAction("5", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(10009005, "", 0)
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
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:EnableCameraByTagAction("6", 1, 0)
	self:SetLookAtParamsAction(9070, 0.8, 1, 0.5)
	self:LookAtRoleAction(true, 9070, "9074")
	self:ShowTalkView()
	self:SetTalkContent(10009006, "", 0)
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
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:BlackFadeAction(0.3, 0.3, 0.3, function()
		self:DelayTimeAction(2, function()
			self:SetNeedClick(true, {
				Invoke = function()
					self:Next()
				end
			})
			self:SetNeedSkip(false, nil)
		end)
	end, function()
		self:EnableCameraByTagAction("7_1", 1, 0)
		self:HideAllDynamicAction(false, true)
		self:CameraMoveAction("7_1", 4, 6, 6, 0.3)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10009007, "", 0)
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
	self:OnNext(function(arg_55_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:CameraMoveAction("6", 1, 1, 3, 0.4)
	self:BlackFadeAction(0.3, 0.3, 0.3, function()
		self:DelayTimeAction(2, function()
			self:SetNeedClick(true, {
				Invoke = function()
					self:Next()
				end
			})
			self:SetNeedSkip(false, nil)
		end)
	end, function()
		self:PlayActorAnimationAction(9070, "happy03", 0.2, 6, function()
			return
		end)
		self:HideAllDynamicAction(true, true)
		self:EnableCameraByTagAction("6", 1, 0)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10009008, "", 0)
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
	self:OnNext(function(arg_64_0)
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:PlayActorAnimationAction(9072, "happy02", 0.2, 3, function()
		return
	end)
	self:EnableCameraByTagAction("7", 1, 0)
	self:CameraMoveAction("7", 3, 6, 4, 0.2)
	self:SetLookAtParamsAction(9070, 0.8, 1, 0.6)
	self:LookAtRoleAction(true, 9070, "9072")
	self:SetLookAtParamsAction(9074, 0.8, 1, 0.6)
	self:LookAtRoleAction(true, 9074, "9072")
	self:ShowTalkView()
	self:SetTalkContent(10009009, "", 0)
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
	self:OnNext(function(arg_69_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:ShowTalkView()
	self:SetTalkContent(10009010, "", 0)
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
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:PlayActorEmoteAction(9072, "disdain01_start", 0.2, 0.4, function()
		return
	end, true, true)
	self:ActorSeekerAction(9070, {
		"9070_2"
	}, 0.5, function()
		return
	end)
	self:EnableCameraByTagAction("7-2", 1, 0)
	self:PlayActorAnimationAction(9072, "dorm_female_idle01", 0.2, 4.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10009011, "", 0)
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
		self:DialogueNode_13()
	end)
end

function var_0_0:DialogueNode_13()
	self:PlayActorAnimationAction(9070, "win", 0.2, 1.933333, function()
		return
	end)
	self:EnableCameraByTagAction("8", 1, 0)
	self:SetLookAtParamsAction(9070, 0.6, 0.8, 1)
	self:LookAtRoleAction(true, 9070, "9072")
	self:PlayActorEmoteAction(9070, "laugh01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:CameraMoveAction("8", 4, 1, 0.6, 0.3)
	self:ShowTalkView()
	self:SetTalkContent(10009012, "", 0)
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
	self:OnNext(function(arg_86_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_14()
	end)
end

function var_0_0:BlackFadeDialogueNode_14()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:EnableCameraByTagAction("", 1, 0)
		self:HideAllDynamicAction(false, false)
		self:DestroyCharAction(9070)
		self:DestroyCharAction(9072)
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
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_15)
end

return var_0_0
