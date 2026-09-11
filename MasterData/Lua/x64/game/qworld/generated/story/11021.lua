BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11021", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11021"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11021"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:SetCharToTagAction(9510, "1", function()
			return
		end)
		self:SetCharToTagAction(9073, "2", function()
			return
		end)
		self:HideAllDynamicAction(true, true, 4095, {})
		self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
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
	self:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11021001, "", 0)
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
	self:OnNext(function(arg_15_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	self:PlayActorAnimationAction(9073, "dorm_female_idle01", 0.05, 4.166667, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11021002, "", 0)
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
	self:OnNext(function(arg_21_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	self:PlayActorEmoteAction(9510, "happy01", 0, 1, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11021003, "", 0)
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
	self:OnNext(function(arg_26_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	self:PlayActorAnimationAction(9073, "summer_doubt", 0.05, 2, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "laugh01_start", 0.1, 0.3333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11021004, "", 0)
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
	self:OnNext(function(arg_32_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:EnableCameraByTagAction("5", 1, 0)
	self:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:PlayActorEmoteAction(9510, "happy01_end", 0, 0.2666667, function()
		return
	end, true, false)
	self:CameraMoveAction("5", 4, 5, 6, 0.3)
	self:ShowTalkView()
	self:SetTalkContent(11021005, "", 0)
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
	self:OnNext(function(arg_38_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:PlayActorAnimationAction(9073, "action3_1", 0.05, 2.266667, function()
		return
	end)
	self:PlayActorEmoteAction(9073, "", 0, 0, function()
		return
	end, false, false)
	self:ShowTalkView()
	self:SetTalkContent(11021006, "", 0)
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
	self:OnNext(function(arg_44_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:BlackFadeAction(0.2, 0.5, 0.5, function()
		self:SetNeedClick(true, {
			Invoke = function()
				self:Next()
			end
		})
		self:SetNeedSkip(false, nil)
	end, function()
		self:EnableCameraByTagAction("7", 1, 0)
		self:CameraMoveAction("7", 4, 6, 5, 0.5)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11021007, "", 0)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(false, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_51_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		self:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
		self:PlayActorAnimationAction(9073, "conversation_1", 0.05, 3, function()
			return
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11021008, "", 0)
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
	self:OnNext(function(arg_58_0)
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:ShowTalkView()
	self:SetTalkContent(11021009, "", 0)
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
	self:OnNext(function(arg_62_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_11()
	end)
end

function var_0_0:BlackFadeDialogueNode_11()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false, 4095, {})
		self:DestroyCharAction(9073)
		self:DestroyCharAction(9510)
		self:EnableCameraByTagAction("", 1, 0)
		self:Agent_PlayerPosControl("chuansong", function()
			return
		end)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_12()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_12()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.BlackFadeDialogueNode_11)
end

return var_0_0
