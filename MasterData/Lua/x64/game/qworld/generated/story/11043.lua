BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11043", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11043"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11043"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(true, true, 4095, {})
		self:SetCharToTagAction(907301, "3", function()
			return
		end)
		self:SetCharToTagAction(9060, "4", function()
			return
		end)
		self:SetCharToTagAction(9074, "1", function()
			return
		end)
		self:SetCharToTagAction(9072, "2", function()
			return
		end)
		self:EnableCameraByTagAction("0", 1, 0)
		self:LoadThingToTag(0, "Yahaha_shigandang", "0", function()
			return
		end)
		self:CameraMoveAction("0", 4, 4, 6, 0.5)
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
	self:DelayTimeAction(1, function()
		self:InstEffectAction({
			pointTag = "0",
			destroyMode = "DontDestroy",
			createMode = "Point",
			path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
		})
		self:UnloadThing(0)
		self:DelayTimeAction(1, function()
			self:BlackFadeAction(0.2, 0.2, 0.2, function()
				return
			end, function()
				self:EnableCameraByTagAction("1", 1, 0)
				self:EventAction(function()
					self:ImmediateNextFlag(-1)
				end)
			end)
		end)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:PlayActorAnimationAction(907301, "summer_doubt", 0.05, 2, function()
		return
	end)
	self:PlayActorEmoteAction(907301, "shocked01", 0, 1.4, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11043001, "", 9073)
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
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:EnableCameraByTagAction("2", 1, 0)
	self:PlayActorAnimationAction(9072, "proud_start", 0.05, 0.6, function()
		return
	end)
	self:PlayActorEmoteAction(9072, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11043002, "", 9072)
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
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:EnableCameraByTagAction("3", 1, 0)
	self:PlayActorAnimationAction(9060, "think_start", 0.05, 1.333333, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11043003, "", 9060)
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
	self:OnNext(function(arg_37_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:EnableCameraByTagAction("4", 1, 0)
	self:PlayActorEmoteAction(9074, "fear01", 0, 3.166667, function()
		return
	end, true, false)
	self:SetLookAtParamsAction(9074, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9074, "9060")
	self:SetLookAtParamsAction(9072, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9072, "9060")
	self:PlayActorAnimationAction(9072, "proud_end", 0.05, 0.7666668, function()
		return
	end)
	self:SetLookAtParamsAction(907301, 0.8, 1, 1)
	self:LookAtRoleAction(true, 907301, "9060")
	self:PlayActorEmoteAction(9072, "happy01_end", 0, 0.2666667, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11043004, "", 9074)
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
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:EnableCameraByTagAction("5", 1, 0)
	self:PlayActorAnimationAction(9060, "action2_1", 0.05, 1.666667, function()
		return
	end)
	self:PlayActorEmoteAction(9060, "anger02_start", 0, 0.5, function()
		return
	end, true, true)
	self:CameraMoveAction("5", 4, 4, 2, 0.2)
	self:SetLookAtParamsAction(9060, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9060, "907301")
	self:ShowTalkView()
	self:SetTalkContent(11043005, "", 9060)
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
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:PlayActorAnimationAction(907301, "summer_doubt", 0.05, 2, function()
		return
	end)
	self:DelayTimeAction(2.5, function()
		self:PlayActorAnimationAction(907301, "think_start", 0.05, 1.333333, function()
			return
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11043006, "", 9073)
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
	self:OnNext(function(arg_57_0)
		self:ClearOnNext()
		self:DialogueNode_9()
	end)
end

function var_0_0:DialogueNode_9()
	self:PlayActorAnimationAction(9060, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11043007, "", 9060)
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
		self:DialogueNode_10()
	end)
end

function var_0_0:DialogueNode_10()
	self:EnableCameraByTagAction("8", 1, 0)
	self:PlayActorAnimationAction(9072, "take", 0.05, 1.833333, function()
		return
	end)
	self:SetLookAtParamsAction(9072, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9072, "907301")
	self:CameraMoveAction("8", 4, 4, 8, 0.8)
	self:ShowTalkView()
	self:SetTalkContent(11043008, "", 9072)
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
	self:OnNext(function(arg_67_0)
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
end

function var_0_0:DialogueNode_11()
	self:PlayActorAnimationAction(907301, "think_end", 0, 1.666667, function()
		self:PlayActorAnimationAction(907301, "summer_doubt", 0, 2, function()
			return
		end)
	end)
	self:SetLookAtParamsAction(907301, 0.8, 1, 1)
	self:LookAtRoleAction(true, 907301, "9072")
	self:ShowTalkView()
	self:SetTalkContent(11043009, "", 9073)
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
	self:OnNext(function(arg_73_0)
		self:ClearOnNext()
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:EnableCameraByTagAction("10", 1, 0)
	self:SetLookAtParamsAction(9074, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9074, "907301")
	self:PlayActorAnimationAction(9074, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	self:PlayActorEmoteAction(9074, "squint01", 0, 1.733333, function()
		return
	end, true, false)
	self:ShowTalkView()
	self:SetTalkContent(11043010, "", 9074)
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
	self:OnNext(function(arg_79_0)
		self:ClearOnNext()
		self:DialogueNode_13()
	end)
end

function var_0_0:DialogueNode_13()
	self:ShowTalkView()
	self:SetTalkContent(11043011, "", 9060)
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
	self:OnNext(function(arg_83_0)
		self:ClearOnNext()
		self:DialogueNode_14()
	end)
end

function var_0_0:DialogueNode_14()
	self:EnableCameraByTagAction("12_0", 1, 0)
	self:PlayActorEmoteAction(907301, "squint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	self:SetLookAtParamsAction(907301, 0.8, 1, 1)
	self:LookAtAction(true, 907301, "12")
	self:DelayTimeAction(1.5, function()
		self:EnableCameraByTagAction("12", 1, 0)
		self:PlayActorEmoteAction(907301, "squint01_end", 0, 0.4333335, function()
			return
		end, true, false)
		self:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
			return
		end)
		self:DelayTimeAction(1, function()
			self:SetNeedClick(true, {
				Invoke = function()
					self:Next()
				end
			})
			self:SetNeedSkip(true, {
				Invoke = function()
					self:Skip("End")
				end
			})
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11043012, "", 9073)
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
	self:OnNext(function(arg_94_0)
		self:ClearOnNext()
		self:DialogueNode_15()
	end)
end

function var_0_0:DialogueNode_15()
	self:EnableCameraByTagAction("13", 1, 0)
	self:PlayActorEmoteAction(9074, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11043013, "", 9074)
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
	self:OnNext(function(arg_99_0)
		self:ClearOnNext()
		self:DialogueNode_16()
	end)
end

function var_0_0:DialogueNode_16()
	self:EnableCameraByTagAction("14", 1, 0)
	self:PlayActorEmoteAction(907301, "squint01", 0, 1.733333, function()
		self:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
			return
		end)
	end, true, false)
	self:CameraMoveAction("14", 4, 1, 3, 0.2)
	self:DelayTimeAction(3, function()
		self:EnableCameraByTagAction("14_1", 1, 0)
		self:DelayTimeAction(0.5, function()
			self:SetNeedClick(true, {
				Invoke = function()
					self:Next()
				end
			})
			self:SetNeedSkip(true, {
				Invoke = function()
					self:Skip("End")
				end
			})
		end)
	end)
	self:ShowTalkView()
	self:SetTalkContent(11043014, "", 9073)
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
	self:OnNext(function(arg_109_0)
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
end

function var_0_0:DialogueNode_17()
	self:EnableCameraByTagAction("2", 1, 0)
	self:PlayActorAnimationAction(9072, "think_start", 0.05, 1.333333, function()
		return
	end)
	self:PlayActorEmoteAction(9072, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	self:ShowTalkView()
	self:SetTalkContent(11043015, "", 9072)
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
	self:OnNext(function(arg_115_0)
		self:ClearOnNext()
		self:DialogueNode_18()
	end)
end

function var_0_0:DialogueNode_18()
	self:EnableCameraByTagAction("12", 1, 0)
	self:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		self:PlayActorAnimationAction(907301, "excited_start", 0.05, 0.6666667, function()
			return
		end)
	end)
	self:SetLookAtParamsAction(907301, 0.6, 0.8, 1)
	self:LookAtRoleAction(true, 907301, "9074")
	self:CameraMoveAction("12", 4, 5, 5, 0.15)
	self:ShowTalkView()
	self:SetTalkContent(11043016, "", 9073)
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
	self:OnNext(function(arg_121_0)
		self:ClearOnNext()
		self:DialogueNode_19()
	end)
end

function var_0_0:DialogueNode_19()
	self:EnableCameraByTagAction("17", 1, 0)
	self:PlayActorAnimationAction(9074, "dorm_male_idle01", 0.05, 8.166667, function()
		return
	end)
	self:DelayTimeAction(2.5, function()
		self:PlayActorAnimationAction(9074, "action2_1", 0.05, 1.666667, function()
			return
		end)
		self:SetLookAtParamsAction(9074, 0.8, 1, 1)
		self:LookAtRoleAction(true, 9074, "9060")
		self:DelayTimeAction(0.5, function()
			self:SetNeedClick(true, {
				Invoke = function()
					self:Next()
				end
			})
			self:SetNeedSkip(true, {
				Invoke = function()
					self:Skip("End")
				end
			})
		end)
	end)
	self:PlayActorEmoteAction(9060, "anger02_end", 0, 0.6, function()
		return
	end, true, false)
	self:PlayActorEmoteAction(9074, "anger02_end", 0, 0.6, function()
		return
	end, false, false)
	self:ShowTalkView()
	self:SetTalkContent(11043017, "", 9074)
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
	self:OnNext(function(arg_133_0)
		self:ClearOnNext()
		self:DialogueNode_20()
	end)
end

function var_0_0:DialogueNode_20()
	self:PlayActorAnimationAction(9060, "proud_start", 0.05, 0.6, function()
		return
	end)
	self:SetLookAtParamsAction(9060, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9060, "9074")
	self:ShowTalkView()
	self:SetTalkContent(11043018, "", 9060)
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
	self:OnNext(function(arg_138_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_21()
	end)
end

function var_0_0:BlackFadeDialogueNode_21()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false, 4095, {})
		self:DestroyCharAction(9060)
		self:EnableCameraByTagAction("", 1, 0)
		self:DestroyCharAction(907301)
		self:DestroyCharAction(9072)
		self:DestroyCharAction(9074)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_22()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_22()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_22)
end

return var_0_0
