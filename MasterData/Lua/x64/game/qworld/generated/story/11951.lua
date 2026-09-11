BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11951", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11951"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11951"
end

function var_0_0:StartStory()
	self:PureActorDialogueNode_1()
end

function var_0_0:PureActorDialogueNode_1()
	self:EnableCameraByTagAction("1", 1, 0)
	self:EventAction(function()
		self:ImmediateNextFlag(-1)
	end)
	self:CameraMoveAction("1", 2, 4, 8, 1)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_2()
	end)
end

function var_0_0:DialogueNode_2()
	self:ShowTalkView()
	self:SetTalkContent(11951001, "", 0)
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
	self:OnNext(function(arg_11_0)
		self:ClearOnNext()
		self:CloseStoryEventNode_3()
	end)
end

function var_0_0:CloseStoryEventNode_3()
	self:EnableCameraByTagAction("", 2, 1)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_3)
end

return var_0_0
