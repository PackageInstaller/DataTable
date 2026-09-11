BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10002", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "10002"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/10002"
end

function var_0_0:StartStory()
	self:PureActorDialogueNode_1()
end

function var_0_0:PureActorDialogueNode_1()
	self:EnableCameraByTagAction("lookyingzhao", 2, 2)
	self:DelayTimeAction(3, function()
		self:DelayTimeAction(2.3, function()
			self:EventAction(function()
				self:ImmediateNextFlag(-1)
			end)
		end)
		self:Agent_CameraControl("2", function()
			self:EnableCameraByTagAction("", 2, 2)
		end)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:CloseStoryEventNode_2()
	end)
end

function var_0_0:CloseStoryEventNode_2()
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_2)
end

return var_0_0
