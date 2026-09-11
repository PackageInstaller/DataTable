BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10001", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "10001"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/10001"
end

function var_0_0:StartStory()
	self:PureActorDialogueNode_1()
end

function var_0_0:PureActorDialogueNode_1()
	self:DelayTimeAction(1.15, function()
		self:EnableCameraByTagAction("2", 1, 0)
		self:CameraMoveAction("2", 4, 1, 1.2, 0.6)
	end)
	self:DelayTimeAction(2.5, function()
		self:EnableCameraByTagAction("5", 1, 0)
		self:CameraMoveAction("5", 4, 1, 6, 0.3)
	end)
	self:DelayTimeAction(5.5, function()
		self:EventAction(function()
			self:ImmediateNextFlag(-1)
		end)
	end)
	self:SetCharToTagAction(9070, "9070", function()
		return
	end)
	self:DelayTimeAction(1.45, function()
		self:EnableCameraShakeAction(true, "Camera/Noise/6D_Shake.asset", 1, 1, 0.4)
		self:EnableNoneEyeFace(9070, true)
		self:DelayTimeAction(3.2, function()
			self:EnableNoneEyeFace(9070, false)
		end)
		self:InstEffectAction({
			attachFollow = true,
			delayTime = 3.2,
			createMode = "RoleAttach",
			destroyMode = "DelayTime",
			attachType = 10,
			roleId = 9070,
			path = "QWWorld/Effect/FaceEffect/faint01"
		})
		self:InstEffectAction({
			pointTag = "9070",
			destroyMode = "DontDestroy",
			createMode = "Point",
			path = "QWWorld/Effect/fx_juqing_dissipation.prefab"
		})
		self:InstEffectAction({
			attachFollow = false,
			delayTime = 3.2,
			createMode = "RoleAttach",
			destroyMode = "DelayTime",
			attachType = 10,
			roleId = 9070,
			path = "QWWorld/Effect/EmotionBubble/fx_xingxing_0601"
		})
	end)
	self:EnableCameraByTagAction("1", 1, 0)
	self:HideAllDynamicAction(false, true)
	self:PlayActorAnimationAction(9070, "juqing01", 0, 10, function()
		return
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_2()
	end)
end

function var_0_0:DialogueNode_2()
	self:CameraMoveAction("4", 4, 6, 5, 0.3)
	self:SetCharToTagAction(9070, "9070_1", function()
		self:EnableCameraByTagAction("4", 1, 0)
		self:DelayTimeAction(3, function()
			self:InstEffectAction({
				attachFollow = false,
				delayTime = 5,
				createMode = "RoleAttach",
				destroyMode = "DelayTime",
				attachType = 10,
				roleId = 9070,
				path = "QWWorld/Effect/EmotionBubble/fx_wuyu_1101_behind"
			})
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10001001, "", 9070)
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
	self:OnNext(function(arg_20_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:BlackFadeAction(0.3, 0.3, 0.3, function()
		self:DelayTimeAction(1, function()
			self:SetNeedClick(true, {
				Invoke = function()
					self:Next()
				end
			})
			self:SetNeedSkip(false, nil)
		end)
	end, function()
		self:EnableCameraByTagAction("3", 1, 0)
	end)
	self:ShowTalkView()
	self:SetTalkContent(10001002, "", 9070)
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
	self:OnNext(function(arg_28_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:ShowTalkView()
	self:SetTalkContent(10001003, "", 9070)
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
	self:OnNext(function(arg_32_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:BlackFadeAction(0.3, 0.3, 0.3, function()
		return
	end, function()
		self:EnableCameraByTagAction("7", 1, 0)
		self:Agent_CameraControl("6", function()
			return
		end)
		self:HideAllDynamicAction(false, false)
		self:CameraMoveAction("4", 4, 6, 6, 0.3)
	end)
	self:DestroyCharAction(9070)
	self:ShowTalkView()
	self:SetTalkContent(10001004, "", 9070)
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
	self:OnNext(function(arg_39_0)
		self:ClearOnNext()
		self:PureActorDialogueNode_6()
	end)
end

function var_0_0:PureActorDialogueNode_6()
	self:EnableCameraByTagAction("", 2, 2)
	self:DelayTimeAction(2.2, function()
		self:EventAction(function()
			self:ImmediateNextFlag(-1)
		end)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:CloseStoryEventNode_7()
	end)
end

function var_0_0:CloseStoryEventNode_7()
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_7)
end

return var_0_0
