BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11039", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11039"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11039"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:SetCharToTagAction(9510, "1", function()
			return
		end)
		self:SetCharToTagAction(9074, "2_0", function()
			self:ActorSeekerAction(9074, {
				"2"
			}, 0.5, function()
				return
			end)
		end)
		self:SetCharToTagAction(9060, "4_0", function()
			self:DelayTimeAction(0.1, function()
				self:ActorSeekerAction(9060, {
					"4"
				}, 0.5, function()
					return
				end)
			end)
		end)
		self:SetCharToTagAction(907301, "3_0", function()
			self:DelayTimeAction(0.2, function()
				self:ActorSeekerAction(907301, {
					"3"
				}, 0.5, function()
					return
				end)
			end)
		end)
		self:HideAllDynamicAction(true, true, 4083, {})
		self:EnableCameraByTagAction("1", 1, 0)
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
	self:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
		return
	end)
	self:DelayTimeAction(2.5, function()
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
	self:SetTalkContent(11039001, "", 0)
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
	self:OnNext(function(arg_25_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:EnableCameraByTagAction("2", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11039002, "", 0)
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
	self:OnNext(function(arg_30_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:EnableCameraByTagAction("3", 1, 0)
	self:CameraMoveAction("3", 4, 3, 5, 0.4)
	self:PlayActorAnimationAction(9510, "think_start", 0.05, 1.333333, function()
		return
	end)
	self:DelayTimeAction(2, function()
		self:EnableCameraByTagAction("3_1", 1, 0)
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
		self:CameraMoveAction("3_1", 4, 4, 5, 0.4)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11039003, "", 0)
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
	self:OnNext(function(arg_38_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:PlayActorAnimationAction(907301, "excited_start", 0.05, 0.6666667, function()
		return
	end)
	self:EnableCameraByTagAction("2", 1, 0)
	self:PlayActorEmoteAction(907301, "anger02", 0, 1.933333, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11039004, "", 0)
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
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:EnableCameraByTagAction("5", 1, 0)
	self:CameraMoveAction("5", 4, 5, 5, 0.2)
	self:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11039005, "", 0)
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
	self:OnNext(function(arg_49_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:EnableCameraByTagAction("1", 1, 0)
	self:PlayActorAnimationAction(907301, "firm_start", 0.05, 0.5666667, function()
		return
	end)
	self:PlayActorAnimationAction(9060, "proud_start", 0.05, 0.6, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11039006, "", 0)
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
	self:OnNext(function(arg_55_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:PlayActorAnimationAction(9510, "action2_1", 0.05, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11039007, "", 0)
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
	self:OnNext(function(arg_60_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_9()
	end)
end

function var_0_0:BlackFadeDialogueNode_9()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:EnableCameraByTagAction("", 1, 0)
		self:DestroyCharAction(907301)
		self:DestroyCharAction(9074)
		self:DestroyCharAction(9060)
		self:HideAllDynamicAction(false, false, 4083, {})
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
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_10)
end

return var_0_0
