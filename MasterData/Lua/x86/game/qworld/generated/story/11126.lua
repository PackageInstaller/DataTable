BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11126", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11126"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11126"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:SetCharToTagAction(9516, "9516", function()
			return
		end)
		self:SetCharToTagAction(9073, "9073", function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:HideAllDynamicAction(true, true, 4081, {
			380001
		})
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
	self:PlayActorAnimationAction(9516, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11126001, "", 9516)
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
	self:ShowTalkView()
	self:SetTalkContent(11126002, "", 9073)
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
	self:OnNext(function(arg_19_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:PlayActorAnimationAction(9516, "summer_doubt", 0.05, 2, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11126003, "", 9516)
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
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:PlayActorAnimationAction(9073, "action3_1", 0.05, 2.266667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11126004, "", 9073)
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
	self:OnNext(function(arg_29_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtAction(true, 9073, "1")
	self:SetLookAtParamsAction(9516, 0.8, 1, 1)
	self:LookAtAction(true, 9516, "1")
	self:ShowTalkView()
	self:SetTalkContent(11126005, "", 0)
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
	self:OnNext(function(arg_33_0)
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:PlayActorAnimationAction(9516, "summer_shock_start", 0.05, 0.3333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11126006, "", 9516)
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
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:ShowTalkView()
	self:SetTalkContent(11126007, "", 0)
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
	self:OnNext(function(arg_42_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:ShowTalkView()
	self:SetTalkContent(11126008, "", 0)
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
	self:OnNext(function(arg_46_0)
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:HideAllDynamicAction(true, true, 3, {
		380002,
		380016,
		380017,
		380018
	})
	self:InstEffectAction({
		pointTag = "1",
		destroyMode = "DontDestroy",
		createMode = "Point",
		path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
	})
	self:InstEffectAction({
		pointTag = "2",
		destroyMode = "DontDestroy",
		createMode = "Point",
		path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
	})
	self:InstEffectAction({
		pointTag = "3",
		destroyMode = "DontDestroy",
		createMode = "Point",
		path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
	})
	self:InstEffectAction({
		pointTag = "4",
		destroyMode = "DontDestroy",
		createMode = "Point",
		path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
	})
	self:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_action_sgd_disappear_act", "", "")
	self:ShowTalkView()
	self:SetTalkContent(11126009, "", 0)
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
	self:OnNext(function(arg_50_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:PlayActorAnimationAction(9516, "summer_shock_end", 0.05, 0.8000001, function()
		return
	end)
	self:SetLookAtParamsAction(9516, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9516, "9073")
	self:ShowTalkView()
	self:SetTalkContent(11126010, "", 9516)
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
	self:OnNext(function(arg_55_0)
		self:ClearOnNext()
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:PlayActorAnimationAction(9073, "think_start", 0.05, 1.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11126011, "", 9073)
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
	self:OnNext(function(arg_60_0)
		self:ClearOnNext()
		self:DialogueNode_13()
	end)
end

function var_0_0:DialogueNode_13()
	self:ShowTalkView()
	self:SetTalkContent(11126012, "", 0)
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
	self:OnNext(function(arg_64_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_14()
	end)
end

function var_0_0:BlackFadeDialogueNode_14()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:EnableCameraByTagAction("", 1, 0)
		self:HideAllDynamicAction(false, false, 4083, {})
		self:DestroyCharAction(9073)
		self:DestroyCharAction(9516)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_15()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_15()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_15)
end

return var_0_0
