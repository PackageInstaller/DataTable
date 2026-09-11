BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11354", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11354"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11354"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.5, 0.5, 1, function()
		self:HideAllDynamicAction(true, true, 4095, {})
		self:SetCharToTagAction(907301, "9073_1", function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:PlayActorAnimationAction(907301, "chair1_sit_stand", 0.05, 2, function()
			return
		end)
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
	self:SetTalkContent(11304001, "", 0)
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
	self:OnNext(function(arg_14_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:SetCharToTagAction(9516, "9516", function()
		return
	end)
	self:EnableCameraByTagAction("2", 1, 0)
	self:PlayActorAnimationAction(9516, "excited_start", 0.05, 0.6666667, function()
		return
	end)
	self:SetLookAtParamsAction(9516, 0.6, 0.8, 1)
	self:LookAtRoleAction(true, 9516, "907301")
	self:ShowTalkView()
	self:SetTalkContent(11304002, "", 9516)
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
	self:OnNext(function(arg_20_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:ShowTalkView()
	self:SetTalkContent(11304003, "", 9516)
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
	self:OnNext(function(arg_24_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_5()
	end)
end

function var_0_0:BlackFadeDialogueNode_5()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:SetCharToTagAction(907301, "9073_2", function()
			return
		end)
		self:SetCharToTagAction(9516, "9516_2", function()
			return
		end)
		self:SetLookAtParamsAction(907301, 0.6, 0.8, 1)
		self:LookAtRoleAction(true, 907301, "9516")
		self:SetLookAtParamsAction(9516, 0.6, 0.8, 1)
		self:LookAtRoleAction(true, 9516, "907301")
		self:PlayActorAnimationAction(907301, "stand_female", 0.05, 4, function()
			return
		end)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:DialogueNode_6()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:DialogueNode_6()
	self:EnableCameraByTagAction("3", 1, 0)
	self:PlayActorAnimationAction(9516, "troubled", 0.05, 3.666667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11304004, "", 9516)
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
	self:OnNext(function(arg_36_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_7()
	end)
end

function var_0_0:BlackFadeDialogueNode_7()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false, 4095, {})
		self:DestroyCharAction(9516)
		self:EnableCameraByTagAction("", 1, 0)
		self:DestroyCharAction(907301)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_8()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_8()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_8)
end

return var_0_0
