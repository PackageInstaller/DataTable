BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11303", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11303"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11303"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:SetCharToTagAction(9073, "2", function()
			return
		end)
		self:HideAllDynamicAction(true, true, 4081, {})
		self:EnableCameraByTagAction("2", 1, 0)
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
	self:SetTalkContent(11303001, "", 9073)
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
	self:OnNext(function(arg_13_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		self:PlayActorAnimationAction(9073, "eniliyi_stand", 0.05, 2.333333, function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:SetCharToTagAction(9073, "1", function()
			return
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11303002, "", 9073)
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
	self:OnNext(function(arg_21_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:ShowTalkView()
	self:SetTalkContent(11303003, "", 9073)
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
	self:OnNext(function(arg_25_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_5()
	end)
end

function var_0_0:BlackFadeDialogueNode_5()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false, 4095, {})
		self:DestroyCharAction(9073)
		self:EnableCameraByTagAction("", 1, 0)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_6()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_6()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_6)
end

return var_0_0
