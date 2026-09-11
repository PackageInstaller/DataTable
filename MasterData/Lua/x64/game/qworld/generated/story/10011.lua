BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10011", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "10011"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/10011"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:SetCharToTagAction(9071, "9071", function()
			self:PlayActorEmoteAction(9071, "emote@9071_face", 0.2, 4, function()
				return
			end, true, true)
		end)
		self:SetCharToTagAction(9070, "9070", function()
			return
		end)
		self:HideAllDynamicAction(true, true)
		self:EnableCameraCutAction(true)
		self:EnableCameraByTagAction("1", 1, 0)
		self:ActorSeekerAction(9070, {
			"9070_1",
			"9070_2",
			"9070_3"
		}, 0.5, function()
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
	self:DelayTimeAction(2, function()
		self:SetNeedClick(true, {
			Invoke = function()
				self:Next()
			end
		})
		self:SetNeedSkip(false, nil)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10011001, "", 9070)
	self:SetNeedSkip(false, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(false, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_18_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:PlayActorAnimationAction(9071, "action2_1", 0.2, 1.666667, function()
		return
	end)
	self:EnableCameraByTagAction("2", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(10011002, "", 9071)
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
	self:OnNext(function(arg_23_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:EnableCameraByTagAction("3", 1, 0)
	self:PlayActorAnimationAction(9070, "action3_1", 0.2, 2.266667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10011003, "", 9070)
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
	self:OnNext(function(arg_28_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:PlayActorAnimationAction(9071, "action2_3", 0.2, 1.333333, function()
		return
	end)
	self:EnableCameraByTagAction("2", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(10011004, "", 9071)
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
	self:OnNext(function(arg_33_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:PlayActorAnimationAction(9070, "action3_3", 0.1, 2.566667, function()
		self:DelayTimeAction(0.01, function()
			self:PlayActorAnimationAction(9070, "summer_doubt", 0.1, 2, function()
				return
			end)
		end)
	end)
	self:EnableCameraByTagAction("4", 1, 0)
	self:ShowTalkView()
	self:SetTalkContent(10011005, "", 9070)
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
	self:OnNext(function(arg_40_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:PlayActorAnimationAction(9071, "stroke02", 0.2, 5.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(10011006, "", 9071)
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
	self:OnNext(function(arg_45_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:EnableCameraByTagAction("5", 1, 0)
	self:PlayActorEmoteAction(9070, "fear01", 0.2, 3.166667, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(10011007, "", 9070)
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
	self:OnNext(function(arg_50_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:PlayActorAnimationAction(9070, "dorm_female_idle01", 0.2, 4.166667, function()
		return
	end)
	self:PlayActorEmoteAction(9070, "happy01_start", 0.2, 0.1333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(10011008, "", 9070)
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
	self:OnNext(function(arg_56_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_10()
	end)
end

function var_0_0:BlackFadeDialogueNode_10()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:EnableCameraCutAction(true)
		self:EnableCameraByTagAction("", 1, 0)
		self:HideAllDynamicAction(false, false)
		self:DestroyCharAction(9070)
		self:DestroyCharAction(9071)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_11()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_11()
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_11)
end

return var_0_0
