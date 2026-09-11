BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11019", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11019"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11019"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(true, 11019002, 2.5, 0.5, 0.5, function()
		self:SetCharToTagAction(9073, "1", function()
			return
		end)
		self:SetCharToTagAction(9510, "2", function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:PlayActorAnimationAction(9073, "happy01", 0.05, 2.333333, function()
			return
		end)
		self:PlayActorEmoteAction(9073, "happy01_start", 0, 0.1333333, function()
			return
		end, true, true)
		self:InstEffectAction({
			attachFollow = false,
			delayTime = 5,
			createMode = "RoleAttach",
			destroyMode = "DelayTime",
			attachType = 10,
			roleId = 9073,
			path = "QWWorld/Effect/EmotionBubble/fx_xixi_1201_QW"
		})
		self:HideAllDynamicAction(false, true, 4095, {})
		self:WalkingPeopleGlobleCull(true)
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
	self:DelayTimeAction(3.5, function()
		self:EventAction(function()
			self:ImmediateNextFlag(-1)
		end)
	end)
	self:DelayTimeAction(0.5, function()
		self:InstEffectAction({
			attachFollow = false,
			delayTime = 5,
			createMode = "RoleAttach",
			destroyMode = "DelayTime",
			attachType = 10,
			roleId = 9510,
			path = "QWWorld/Effect/EmotionBubble/fx_liuhan_1801_QW"
		})
	end)
	self:PlayActorAnimationAction(9510, "summer_doubt_start", 0.05, 0.7666667, function()
		return
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:BlackFadeDialogueNode_3()
	end)
end

function var_0_0:BlackFadeDialogueNode_3()
	self:HideTalkView()
	self:OnBlackFade(true, 11019003, 3, 0.5, 0.5, function()
		self:DestroyCharAction(9073)
		self:DestroyCharAction(9510)
		self:EnableCameraByTagAction("", 1, 0)
		self:HideAllDynamicAction(false, false, 4095, {})
		self:WalkingPeopleGlobleCull(false)
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
