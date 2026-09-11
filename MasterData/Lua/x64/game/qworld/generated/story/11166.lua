BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11166", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11166"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11166"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:SetCharToTagAction(9520, "9520", function()
			return
		end)
		self:SetCharToTagAction(9073, "9073", function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:HideAllDynamicAction(true, true, 4081, {
			410001
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
	self:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11166001, "", 0)
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
	self:ShowTalkView()
	self:SetTalkContent(11166002, "", 0)
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
	self:OnNext(function(arg_19_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:PlayActorAnimationAction(9073, "summer_doubt", 0.05, 2, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11166003, "", 0)
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
	self:OnNext(function(arg_24_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:ShowTalkView()
	self:SetTalkContent(11166004, "", 0)
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
	self:OnNext(function(arg_28_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:PlayActorAnimationAction(9520, "speechless", 0.05, 3.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11166005, "", 0)
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
	self:OnNext(function(arg_33_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:ShowTalkView()
	self:SetTalkContent(11166006, "", 0)
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
	self:OnNext(function(arg_37_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:InstEffectAction({
		delayTime = 2,
		createMode = "Point",
		destroyMode = "DelayTime",
		pointTag = "liuhan",
		path = "QWWorld/Effect/EmotionBubble/fx_liuhan_1801_QW.prefab"
	})
	self:ShowTalkView()
	self:SetTalkContent(11166007, "", 0)
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
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11166008, "", 0)
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
		self:BlackFadeDialogueNode_10()
	end)
end

function var_0_0:BlackFadeDialogueNode_10()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:EnableCameraByTagAction("", 1, 0)
		self:HideAllDynamicAction(false, false, 4081, {
			410016
		})
		self:DestroyCharAction(9073)
		self:DestroyCharAction(9520)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_11()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_11()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_11)
end

return var_0_0
