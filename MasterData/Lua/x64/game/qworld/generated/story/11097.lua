BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11097", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11097"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11097"
end

function var_0_0:StartStory()
	self:PureActorDialogueNode_1()
end

function var_0_0:PureActorDialogueNode_1()
	self:SetCharToTagAction(9073, "1", function()
		self:PlayActorAnimationAction(9073, "dressingroom_1", 0.05, 1.433333, function()
			self:DestroyCharAction(9073)
			self:SetCharToTagAction(907301, "1", function()
				self:EventAction(function()
					self:ImmediateNextFlag(-1)
				end)
			end)
		end)
	end)
	self:EnableCameraByTagAction("1", 1, 0)
	self:HideAllDynamicAction(true, true, 4081, {})
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
