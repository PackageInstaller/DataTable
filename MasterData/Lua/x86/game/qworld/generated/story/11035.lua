BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11035", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11035"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11035"
end

function var_0_0:StartStory()
	self:DialogueNode_1()
end

function var_0_0:DialogueNode_1()
	self:ShowTalkView()
	self:SetTalkContent(11035001, "", 0)
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
	self:OnNext(function(arg_8_0)
		self:ClearOnNext()
		self:DialogueNode_2()
	end)
end

function var_0_0:DialogueNode_2()
	self:ShowTalkView()
	self:SetTalkContent(11035002, "", 0)
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
	self:OnNext(function(arg_12_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_3()
	end)
end

function var_0_0:BlackFadeDialogueNode_3()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_4()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_4()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_4)
end

return var_0_0
