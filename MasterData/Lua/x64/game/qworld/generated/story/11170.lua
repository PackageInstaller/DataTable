BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11170", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11170"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11170"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:SetCharToTagAction(9521, "9521", function()
			return
		end)
		self:SetCharToTagAction(9073, "9073", function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:HideAllDynamicAction(true, true, 4081, {
			420004
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
	self:PlayActorAnimationAction(9521, "conversation_1", 0.05, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11170001, "", 0)
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
	self:PlayActorAnimationAction(9073, "action3_1", 0.05, 2.266667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11170002, "", 0)
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
	self:ShowTalkView()
	self:SetTalkContent(11170003, "", 0)
	self:SetChoice({
		[0] = {
			id = 11170004,
			icon = "",
			Invoke = function()
				self:Next(11170004)
			end
		},
		{
			id = 11170005,
			icon = "",
			Invoke = function()
				self:Next(11170005)
			end
		},
		Length = 2
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_24_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_24_0 == 11170004 then
			self:DialogueBranchNode_5()
		elseif arg_24_0 == 11170005 then
			self:DialogueBranchNode_6()
		end
	end)
end

function var_0_0:DialogueBranchNode_5()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
	self:Next()
end

function var_0_0:DialogueNode_7()
	self:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11170006, "", 0)
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
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:PlayActorAnimationAction(9521, "speechless_start", 0.05, 0.5333334, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11170007, "", 0)
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
	self:OnNext(function(arg_36_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:PlayActorAnimationAction(9073, "summer_shock", 0.05, 1.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11170008, "", 0)
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
	self:OnNext(function(arg_41_0)
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:PlayActorAnimationAction(9521, "action2_1", 0.05, 1.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11170009, "", 0)
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
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:PlayActorAnimationAction(9521, "action2_3", 0.05, 1.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11170010, "", 0)
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
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:PlayActorAnimationAction(9073, "summer_shock", 0.05, 1.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11170011, "", 0)
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
		self:BlackFadeDialogueNode_13()
	end)
end

function var_0_0:BlackFadeDialogueNode_13()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:EnableCameraByTagAction("", 1, 0)
		self:HideAllDynamicAction(false, false, 4081, {
			420004
		})
		self:DestroyCharAction(9073)
		self:DestroyCharAction(9521)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_14()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_14()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:DialogueBranchNode_6()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
	self:Next()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_14)
end

return var_0_0
