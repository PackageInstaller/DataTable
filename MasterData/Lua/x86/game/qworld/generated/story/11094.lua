BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11094", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11094"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11094"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(true, 11045001, 2.5, 0.5, 0.5, function()
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_2()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_2()
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_2)
end

return var_0_0
