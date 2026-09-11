BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11033", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11033"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11033"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(true, 11045001, 2.5, 0.5, 0.5, function()
		self:Agent_PlayerPosControl("1", function()
			return
		end)
		self:HideAllDynamicAction(true, true, 4095, {})
		self:SetCharToTagAction(9073, "1", function()
			return
		end)
		self:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_9073_cloth", "", "")
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:PureActorDialogueNode_2()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:PureActorDialogueNode_2()
	self:PlayActorAnimationAction(9073, "dressingroom_1", 0.05, 1.433333, function()
		self:SetCharToTagAction(907301, "1", function()
			return
		end)
		self:DestroyCharAction(9073)
		self:PlayActorAnimationAction(907301, "dressingroom_2", 0.05, 2.3, function()
			self:EventAction(function()
				self:ImmediateNextFlag(-1)
			end)
		end)
	end)
	self:EnableCameraByTagAction("1", 1, 0)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:BlackFadeDialogueNode_3()
	end)
end

function var_0_0:BlackFadeDialogueNode_3()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.5, 0.5, 0.5, function()
		self:EnableCameraByTagAction("", 1, 0)
		self:DestroyCharAction(907301)
		self:HideAllDynamicAction(false, false, 4095, {})
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
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_4)
end

return var_0_0
