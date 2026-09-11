BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11183", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11183"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11183"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:SetCharToTagAction(9525, "1", function()
			return
		end)
		self:HideAllDynamicAction(true, true, 4081, {
			430001
		})
		self:SetCharToTagAction(907301, "5", function()
			return
		end)
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
	self:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11183001, "", 0)
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
	self:OnNext(function(arg_15_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:PlayActorAnimationAction(9525, "summer_shock_start", 0.05, 0.3333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11183002, "", 0)
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
	self:OnNext(function(arg_20_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:PlayActorAnimationAction(9525, "firm_start", 0.05, 0.5666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11183003, "", 0)
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
	self:OnNext(function(arg_25_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11183004, "", 0)
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
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:ShowTalkView()
	self:SetTalkContent(11183005, "", 0)
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
	self:OnNext(function(arg_34_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:ActorSeekerAction(9525, {
		"2",
		"3"
	}, 2.5, function()
		return
	end)
	self:SetLookAtParamsAction(907301, 0.8, 1, 1)
	self:LookAtAction(true, 907301, "4")
	self:ShowTalkView()
	self:SetTalkContent(11183006, "", 0)
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
	self:OnNext(function(arg_39_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:InstEffectAction({
		attachFollow = false,
		delayTime = 2,
		createMode = "RoleAttach",
		destroyMode = "DelayTime",
		attachType = 10,
		roleId = 907301,
		path = "QWWorld/Effect/EmotionBubble/fx_liuhan_1801_QW"
	})
	self:ShowTalkView()
	self:SetTalkContent(11183007, "", 0)
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
	self:OnNext(function(arg_43_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_9()
	end)
end

function var_0_0:BlackFadeDialogueNode_9()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:DestroyCharAction(9525)
		self:DestroyCharAction(907301)
		self:HideAllDynamicAction(false, false, 4095, {})
		self:EnableCameraByTagAction("", 1, 0)
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
