BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11914", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11914"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11914"
end

function var_0_0:StartStory()
	self:PureActorDialogueNode_1()
end

function var_0_0:PureActorDialogueNode_1()
	self:EnableCameraByTagAction("1", 1, 0)
	self:LoadThingToTag(1, "Yahaha_shigandang", "1", function()
		return
	end)
	self:InstEffectAction({
		pointTag = "1",
		destroyMode = "DontDestroy",
		createMode = "Point",
		path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
	})
	self:PlayThingAnimationAction(1, "shake", 0, 0, function()
		return
	end)
	self:DelayTimeAction(3, function()
		self:EnableCameraByTagAction("", 2, 1)
		self:DelayTimeAction(1, function()
			self:EventAction(function()
				self:ImmediateNextFlag(-1)
			end)
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
