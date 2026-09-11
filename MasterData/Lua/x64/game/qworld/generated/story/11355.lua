BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11355", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11355"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11355"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(true, true, 4081, {})
		self:SetCharToTagAction(907301, "2", function()
			return
		end)
		self:EnableCameraByTagAction("2", 1, 0)
		self:PlayActorAnimationAction(907301, "angry02", 0.05, 6.966667, function()
			return
		end)
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
	self:SetTalkContent(11305001, "", 9073)
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
	self:OnNext(function(arg_14_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:BlackFadeAction(0.2, 0.2, 0.2, function()
		return
	end, function()
		self:SetCharToTagAction(907301, "1", function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11305002, "", 9073)
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
	self:ShowTalkView()
	self:SetTalkContent(11305003, "", 0)
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
	self:ShowTalkView()
	self:SetTalkContent(11305004, "", 9073)
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
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:ShowTalkView()
	self:SetTalkContent(11305005, "", 0)
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
	self:BlackFadeAction(0.2, 0.2, 0.2, function()
		return
	end, function()
		self:PlayActorAnimationAction(907301, "summer_shock", 0.05, 1.166667, function()
			return
		end)
		self:SetCharToTagAction(907301, "2", function()
			return
		end)
		self:EnableCameraByTagAction("2", 1, 0)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11305006, "", 9073)
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
		self:BlackFadeDialogueNode_8()
	end)
end

function var_0_0:BlackFadeDialogueNode_8()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false, 4095, {})
		self:DestroyCharAction(907301)
		self:EnableCameraByTagAction("", 1, 0)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_9()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_9()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_9)
end

return var_0_0
