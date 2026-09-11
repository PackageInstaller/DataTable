BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11004", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11004"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11004"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.1, 0.2, 0.2, function()
		self:SetCharToTagAction(9073, "1", function()
			return
		end)
		self:SetCharToTagAction(9510, "2", function()
			return
		end)
		self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
		self:HideAllDynamicAction(true, true)
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
	self:PlayActorAnimationAction(9073, "dorm_female_idle01", 0, 4.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11004001, "", 0)
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
	self:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	self:PlayActorAnimationAction(9510, "happy02", 0, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11004002, "", 0)
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
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:PlayActorAnimationAction(9073, "speechless", 0, 3.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11004003, "", 0)
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
	self:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	self:PlayActorEmoteAction(9510, "fear01", 0, 3.166667, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11004004, "", 0)
	self:SetChoice({
		[0] = {
			id = 11004005,
			icon = "",
			Invoke = function()
				self:Next(11004005)
			end
		},
		{
			id = 11004006,
			icon = "",
			Invoke = function()
				self:Next(11004006)
			end
		},
		Length = 2
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_30_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_30_0 == 11004005 then
			self:DialogueBranchNode_6()
		elseif arg_30_0 == 11004006 then
			self:DialogueBranchNode_7()
		end
	end)
end

function var_0_0:DialogueBranchNode_6()
	self:OnNext(function()
		self:ClearOnNext()
		self:PureActorDialogueNode_8()
	end)
	self:Next()
end

function var_0_0:PureActorDialogueNode_8()
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:PlayActorAnimationAction(9073, "angry01", 0.2, 4.333333, function()
		return
	end)
	self:DelayTimeAction(4, function()
		self:EventAction(function()
			self:ImmediateNextFlag(-1)
		end)
	end)
	self:EnableCameraShakeAction(true, "Camera/Noise/6D_Shake.asset", 1, 1, 2)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:PlayActorAnimationAction(9510, "embarrassed", 0.2, 2.6, function()
		return
	end)
	self:PlayActorEmoteAction(9510, "happy01_start", 0.2, 0.1333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11004007, "", 0)
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
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	self:PlayActorAnimationAction(9073, "action4_1", 0.2, 2.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11004008, "", 0)
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
	self:OnNext(function(arg_48_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	self:PlayActorAnimationAction(9073, "action4_3", 0.2, 4.3, function()
		return
	end)
	self:PlayActorAnimationAction(9510, "conversation_1", 0.2, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11004009, "", 0)
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
	self:OnNext(function(arg_54_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_12()
	end)
end

function var_0_0:BlackFadeDialogueNode_12()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.1, 0.2, 0.2, function()
		self:DestroyCharAction(9073)
		self:DestroyCharAction(9510)
		self:EnableCameraByTagAction("", 1, 0)
		self:HideAllDynamicAction(false, false)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_13()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_13()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:DialogueBranchNode_7()
	self:OnNext(function()
		self:ClearOnNext()
		self:PureActorDialogueNode_8()
	end)
	self:Next()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.BlackFadeDialogueNode_12)
end

return var_0_0
