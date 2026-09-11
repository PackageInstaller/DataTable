BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11003", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11003"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11003"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.1, 0.3, 0.3, function()
		self:SetCharToTagAction(9510, "2", function()
			return
		end)
		self:SetCharToTagAction(9073, "1", function()
			return
		end)
		self:SetCharToTagAction(9511, "3", function()
			return
		end)
		self:EnableCameraByTagAction("3", 1, 0)
		self:HideAllDynamicAction(true, true, 4095, {})
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
	self:PlayActorEmoteAction(9510, "glory01", 0, 1.566667, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11003001, "", 9510)
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
	self:OnNext(function(arg_16_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:PlayActorAnimationAction(9073, "happy02", 0.2, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11003002, "", 9073)
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
	self:OnNext(function(arg_21_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:PlayActorAnimationAction(9510, "summer_doubt", 0.2, 2, function()
		return
	end)
	self:PlayActorEmoteAction(9510, "shocked01", 0, 1.4, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11003003, "", 9510)
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
	self:OnNext(function(arg_27_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:PlayActorAnimationAction(9073, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	self:BlackFadeAction(0.1, 0.2, 0.2, function()
		return
	end, function()
		self:EnableCameraByTagAction("4", 1, 0)
		self:CameraMoveAction("4", 4, 3, 3, 0.4)
	end)
	self:DelayTimeAction(3, function()
		self:BlackFadeAction(0.1, 0.2, 0.2, function()
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
		end, function()
			self:EnableCameraByTagAction("5", 1, 0)
			self:CameraMoveAction("5", 4, 4, 7, 0.3)
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11003004, "", 9073)
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
	self:OnNext(function(arg_39_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:EnableCameraByTagAction("6", 1, 0)
	self:CameraMoveAction("6", 4, 6, 7, 0.3)
	self:ActorSeekerAction(9510, {
		"4"
	}, 0.8, function()
		self:PlayActorAnimationAction(9510, "action2_1", 0.2, 1.666667, function()
			return
		end)
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
	self:SetLookAtParamsAction(9073, 0.6, 0.8, 1)
	self:LookAtRoleAction(true, 9073, "9510")
	self:ShowTalkView()
	self:SetTalkContent(11003005, "", 9510)
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
	self:OnNext(function(arg_48_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:PlayActorAnimationAction(9511, "proud", 0, 2.333333, function()
		return
	end)
	self:EnableCameraByTagAction("7", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(11003006, "", 9511)
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
	self:SetCharToTagAction(9073, "5", function()
		return
	end)
	self:PlayActorAnimationAction(9510, "happy02", 0, 3, function()
		self:ActorSeekerAction(9511, {
			"10"
		}, 0.8, function()
			return
		end)
	end)
	self:EnableCameraByTagAction("8", 1, 0)
	self:DelayTimeAction(6, function()
		self:BlackFadeAction(0.1, 0.2, 0.2, function()
			return
		end, function()
			self:EnableCameraByTagAction("9", 1, 0)
			self:CameraMoveAction("9", 4, 5, 5, 0.4)
		end)
		self:ActorSeekerAction(9510, {
			"6"
		}, 0.8, function()
			return
		end)
	end)
	self:SetCharToTagAction(9510, "4", function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11003007, "", 9510)
	self:SetChoice({
		Length = 0
	}, true)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_63_0)
		self:ClearOnNext()
		self:CloseChoice()
	end)
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("LastWord", self.DialogueNode_8)
end

return var_0_0
