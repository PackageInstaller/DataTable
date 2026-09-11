BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11302", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11302"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11302"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(true, 11302001, 2.5, 0.5, 0.5, function()
		self:SetCharToTagAction(9073, "1", function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:HideAllDynamicAction(false, true, 4095, {})
		self:WalkingPeopleGlobleCull(true)
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
	self:InstEffectAction({
		attachFollow = false,
		delayTime = 5,
		createMode = "RoleAttach",
		destroyMode = "DelayTime",
		attachType = 10,
		roleId = 9073,
		path = "QWWorld/Effect/EmotionBubble/fx_xixi_1201_QW"
	})
	self:PlayActorAnimationAction(9073, "9073_idle01", 0.05, 3.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11302002, "", 0)
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
	self:OnNext(function(arg_14_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_3()
	end)
end

function var_0_0:BlackFadeDialogueNode_3()
	self:HideTalkView()
	self:OnBlackFade(true, 11302003, 6, 0.5, 0.5, function()
		self:SetCharToTagAction(9535, "3", function()
			return
		end)
		self:SetCharToTagAction(9073, "2", function()
			return
		end)
		self:PlayActorAnimationAction(9073, "eniliyi_stand", 0, 2.333333, function()
			return
		end)
		self:EnableCameraByTagAction("2", 1, 0)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:DialogueNode_4()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:DialogueNode_4()
	self:PlayActorAnimationAction(9535, "troubled", 0.05, 3.666667, function()
		return
	end)
	self:InstEffectAction({
		attachFollow = false,
		delayTime = 5,
		createMode = "RoleAttach",
		destroyMode = "DelayTime",
		attachType = 10,
		roleId = 9535,
		path = "QWWorld/Effect/EmotionBubble/fx_daxiao_0801_QW"
	})
	self:ShowTalkView()
	self:SetTalkContent(11302004, "", 0)
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
	self:OnNext(function(arg_26_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_5()
	end)
end

function var_0_0:BlackFadeDialogueNode_5()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:DestroyCharAction(9073)
		self:EnableCameraByTagAction("", 1, 0)
		self:HideAllDynamicAction(false, false, 4095, {})
		self:WalkingPeopleGlobleCull(false)
		self:DestroyCharAction(9535)
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
