BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11043", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11043"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11043"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:HideAllDynamicAction(true, true, 4095, {})
		arg_5_0:SetCharToTagAction(907301, "3", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9060, "4", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9074, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9072, "2", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("0", 1, 0)
		arg_5_0:LoadThingToTag(0, "Yahaha_shigandang", "0", function()
			return
		end)
		arg_5_0:CameraMoveAction("0", 4, 4, 6, 0.5)
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:PureActorDialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.PureActorDialogueNode_2(arg_14_0)
	arg_14_0:DelayTimeAction(1, function()
		arg_14_0:InstEffectAction({
			pointTag = "0",
			destroyMode = "DontDestroy",
			createMode = "Point",
			path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
		})
		arg_14_0:UnloadThing(0)
		arg_14_0:DelayTimeAction(1, function()
			arg_14_0:BlackFadeAction(0.2, 0.2, 0.2, function()
				return
			end, function()
				arg_14_0:EnableCameraByTagAction("1", 1, 0)
				arg_14_0:EventAction(function()
					arg_14_0:ImmediateNextFlag(-1)
				end)
			end)
		end)
	end)
	arg_14_0:HideTalkView()
	arg_14_0:OnNext(function()
		arg_14_0:ClearOnNext()
		arg_14_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_21_0)
	arg_21_0:PlayActorAnimationAction(907301, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_21_0:PlayActorEmoteAction(907301, "shocked01", 0, 1.4, function()
		return
	end, true, false)
	arg_21_0:ShowTalkView()
	arg_21_0:SetTalkContent(11043001, "", 9073)
	arg_21_0:SetNeedSkip(true, {
		Invoke = function()
			arg_21_0:Skip("End")
		end
	})
	arg_21_0:SetNeedClick(true, {
		Invoke = function()
			arg_21_0:Next()
		end
	})
	arg_21_0:OnNext(function(arg_26_0)
		arg_21_0:ClearOnNext()
		arg_21_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_27_0)
	arg_27_0:EnableCameraByTagAction("2", 1, 0)
	arg_27_0:PlayActorAnimationAction(9072, "proud_start", 0.05, 0.6, function()
		return
	end)
	arg_27_0:PlayActorEmoteAction(9072, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	arg_27_0:ShowTalkView()
	arg_27_0:SetTalkContent(11043002, "", 9072)
	arg_27_0:SetNeedSkip(true, {
		Invoke = function()
			arg_27_0:Skip("End")
		end
	})
	arg_27_0:SetNeedClick(true, {
		Invoke = function()
			arg_27_0:Next()
		end
	})
	arg_27_0:OnNext(function(arg_32_0)
		arg_27_0:ClearOnNext()
		arg_27_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_33_0)
	arg_33_0:EnableCameraByTagAction("3", 1, 0)
	arg_33_0:PlayActorAnimationAction(9060, "think_start", 0.05, 1.333333, function()
		return
	end)
	arg_33_0:ShowTalkView()
	arg_33_0:SetTalkContent(11043003, "", 9060)
	arg_33_0:SetNeedSkip(true, {
		Invoke = function()
			arg_33_0:Skip("End")
		end
	})
	arg_33_0:SetNeedClick(true, {
		Invoke = function()
			arg_33_0:Next()
		end
	})
	arg_33_0:OnNext(function(arg_37_0)
		arg_33_0:ClearOnNext()
		arg_33_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_38_0)
	arg_38_0:EnableCameraByTagAction("4", 1, 0)
	arg_38_0:PlayActorEmoteAction(9074, "fear01", 0, 3.166667, function()
		return
	end, true, false)
	arg_38_0:SetLookAtParamsAction(9074, 0.8, 1, 1)
	arg_38_0:LookAtRoleAction(true, 9074, "9060")
	arg_38_0:SetLookAtParamsAction(9072, 0.8, 1, 1)
	arg_38_0:LookAtRoleAction(true, 9072, "9060")
	arg_38_0:PlayActorAnimationAction(9072, "proud_end", 0.05, 0.7666668, function()
		return
	end)
	arg_38_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_38_0:LookAtRoleAction(true, 907301, "9060")
	arg_38_0:PlayActorEmoteAction(9072, "happy01_end", 0, 0.2666667, function()
		return
	end, true, false)
	arg_38_0:ShowTalkView()
	arg_38_0:SetTalkContent(11043004, "", 9074)
	arg_38_0:SetNeedSkip(true, {
		Invoke = function()
			arg_38_0:Skip("End")
		end
	})
	arg_38_0:SetNeedClick(true, {
		Invoke = function()
			arg_38_0:Next()
		end
	})
	arg_38_0:OnNext(function(arg_44_0)
		arg_38_0:ClearOnNext()
		arg_38_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_45_0)
	arg_45_0:EnableCameraByTagAction("5", 1, 0)
	arg_45_0:PlayActorAnimationAction(9060, "action2_1", 0.05, 1.666667, function()
		return
	end)
	arg_45_0:PlayActorEmoteAction(9060, "anger02_start", 0, 0.5, function()
		return
	end, true, true)
	arg_45_0:CameraMoveAction("5", 4, 4, 2, 0.2)
	arg_45_0:SetLookAtParamsAction(9060, 0.8, 1, 1)
	arg_45_0:LookAtRoleAction(true, 9060, "907301")
	arg_45_0:ShowTalkView()
	arg_45_0:SetTalkContent(11043005, "", 9060)
	arg_45_0:SetNeedSkip(true, {
		Invoke = function()
			arg_45_0:Skip("End")
		end
	})
	arg_45_0:SetNeedClick(true, {
		Invoke = function()
			arg_45_0:Next()
		end
	})
	arg_45_0:OnNext(function(arg_50_0)
		arg_45_0:ClearOnNext()
		arg_45_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_51_0)
	arg_51_0:PlayActorAnimationAction(907301, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_51_0:DelayTimeAction(2.5, function()
		arg_51_0:PlayActorAnimationAction(907301, "think_start", 0.05, 1.333333, function()
			return
		end)
	end)
	arg_51_0:ShowTalkView()
	arg_51_0:SetTalkContent(11043006, "", 9073)
	arg_51_0:SetNeedSkip(true, {
		Invoke = function()
			arg_51_0:Skip("End")
		end
	})
	arg_51_0:SetNeedClick(true, {
		Invoke = function()
			arg_51_0:Next()
		end
	})
	arg_51_0:OnNext(function(arg_57_0)
		arg_51_0:ClearOnNext()
		arg_51_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_58_0)
	arg_58_0:PlayActorAnimationAction(9060, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_58_0:ShowTalkView()
	arg_58_0:SetTalkContent(11043007, "", 9060)
	arg_58_0:SetNeedSkip(true, {
		Invoke = function()
			arg_58_0:Skip("End")
		end
	})
	arg_58_0:SetNeedClick(true, {
		Invoke = function()
			arg_58_0:Next()
		end
	})
	arg_58_0:OnNext(function(arg_62_0)
		arg_58_0:ClearOnNext()
		arg_58_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_63_0)
	arg_63_0:EnableCameraByTagAction("8", 1, 0)
	arg_63_0:PlayActorAnimationAction(9072, "take", 0.05, 1.833333, function()
		return
	end)
	arg_63_0:SetLookAtParamsAction(9072, 0.8, 1, 1)
	arg_63_0:LookAtRoleAction(true, 9072, "907301")
	arg_63_0:CameraMoveAction("8", 4, 4, 8, 0.8)
	arg_63_0:ShowTalkView()
	arg_63_0:SetTalkContent(11043008, "", 9072)
	arg_63_0:SetNeedSkip(true, {
		Invoke = function()
			arg_63_0:Skip("End")
		end
	})
	arg_63_0:SetNeedClick(true, {
		Invoke = function()
			arg_63_0:Next()
		end
	})
	arg_63_0:OnNext(function(arg_67_0)
		arg_63_0:ClearOnNext()
		arg_63_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_68_0)
	arg_68_0:PlayActorAnimationAction(907301, "think_end", 0, 1.666667, function()
		arg_68_0:PlayActorAnimationAction(907301, "summer_doubt", 0, 2, function()
			return
		end)
	end)
	arg_68_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_68_0:LookAtRoleAction(true, 907301, "9072")
	arg_68_0:ShowTalkView()
	arg_68_0:SetTalkContent(11043009, "", 9073)
	arg_68_0:SetNeedSkip(true, {
		Invoke = function()
			arg_68_0:Skip("End")
		end
	})
	arg_68_0:SetNeedClick(true, {
		Invoke = function()
			arg_68_0:Next()
		end
	})
	arg_68_0:OnNext(function(arg_73_0)
		arg_68_0:ClearOnNext()
		arg_68_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_74_0)
	arg_74_0:EnableCameraByTagAction("10", 1, 0)
	arg_74_0:SetLookAtParamsAction(9074, 0.8, 1, 1)
	arg_74_0:LookAtRoleAction(true, 9074, "907301")
	arg_74_0:PlayActorAnimationAction(9074, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_74_0:PlayActorEmoteAction(9074, "squint01", 0, 1.733333, function()
		return
	end, true, false)
	arg_74_0:ShowTalkView()
	arg_74_0:SetTalkContent(11043010, "", 9074)
	arg_74_0:SetNeedSkip(true, {
		Invoke = function()
			arg_74_0:Skip("End")
		end
	})
	arg_74_0:SetNeedClick(true, {
		Invoke = function()
			arg_74_0:Next()
		end
	})
	arg_74_0:OnNext(function(arg_79_0)
		arg_74_0:ClearOnNext()
		arg_74_0:DialogueNode_13()
	end)
end

function var_0_0.DialogueNode_13(arg_80_0)
	arg_80_0:ShowTalkView()
	arg_80_0:SetTalkContent(11043011, "", 9060)
	arg_80_0:SetNeedSkip(true, {
		Invoke = function()
			arg_80_0:Skip("End")
		end
	})
	arg_80_0:SetNeedClick(true, {
		Invoke = function()
			arg_80_0:Next()
		end
	})
	arg_80_0:OnNext(function(arg_83_0)
		arg_80_0:ClearOnNext()
		arg_80_0:DialogueNode_14()
	end)
end

function var_0_0.DialogueNode_14(arg_84_0)
	arg_84_0:EnableCameraByTagAction("12_0", 1, 0)
	arg_84_0:PlayActorEmoteAction(907301, "squint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_84_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_84_0:LookAtAction(true, 907301, "12")
	arg_84_0:DelayTimeAction(1.5, function()
		arg_84_0:EnableCameraByTagAction("12", 1, 0)
		arg_84_0:PlayActorEmoteAction(907301, "squint01_end", 0, 0.4333335, function()
			return
		end, true, false)
		arg_84_0:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
			return
		end)
		arg_84_0:DelayTimeAction(1, function()
			arg_84_0:SetNeedClick(true, {
				Invoke = function()
					arg_84_0:Next()
				end
			})
			arg_84_0:SetNeedSkip(true, {
				Invoke = function()
					arg_84_0:Skip("End")
				end
			})
		end)
	end)
	arg_84_0:ShowTalkView()
	arg_84_0:SetTalkContent(11043012, "", 9073)
	arg_84_0:SetNeedSkip(true, {
		Invoke = function()
			arg_84_0:Skip("End")
		end
	})
	arg_84_0:SetNeedClick(false, {
		Invoke = function()
			arg_84_0:Next()
		end
	})
	arg_84_0:OnNext(function(arg_94_0)
		arg_84_0:ClearOnNext()
		arg_84_0:DialogueNode_15()
	end)
end

function var_0_0.DialogueNode_15(arg_95_0)
	arg_95_0:EnableCameraByTagAction("13", 1, 0)
	arg_95_0:PlayActorEmoteAction(9074, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	arg_95_0:ShowTalkView()
	arg_95_0:SetTalkContent(11043013, "", 9074)
	arg_95_0:SetNeedSkip(true, {
		Invoke = function()
			arg_95_0:Skip("End")
		end
	})
	arg_95_0:SetNeedClick(true, {
		Invoke = function()
			arg_95_0:Next()
		end
	})
	arg_95_0:OnNext(function(arg_99_0)
		arg_95_0:ClearOnNext()
		arg_95_0:DialogueNode_16()
	end)
end

function var_0_0.DialogueNode_16(arg_100_0)
	arg_100_0:EnableCameraByTagAction("14", 1, 0)
	arg_100_0:PlayActorEmoteAction(907301, "squint01", 0, 1.733333, function()
		arg_100_0:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
			return
		end)
	end, true, false)
	arg_100_0:CameraMoveAction("14", 4, 1, 3, 0.2)
	arg_100_0:DelayTimeAction(3, function()
		arg_100_0:EnableCameraByTagAction("14_1", 1, 0)
		arg_100_0:DelayTimeAction(0.5, function()
			arg_100_0:SetNeedClick(true, {
				Invoke = function()
					arg_100_0:Next()
				end
			})
			arg_100_0:SetNeedSkip(true, {
				Invoke = function()
					arg_100_0:Skip("End")
				end
			})
		end)
	end)
	arg_100_0:ShowTalkView()
	arg_100_0:SetTalkContent(11043014, "", 9073)
	arg_100_0:SetNeedSkip(true, {
		Invoke = function()
			arg_100_0:Skip("End")
		end
	})
	arg_100_0:SetNeedClick(false, {
		Invoke = function()
			arg_100_0:Next()
		end
	})
	arg_100_0:OnNext(function(arg_109_0)
		arg_100_0:ClearOnNext()
		arg_100_0:DialogueNode_17()
	end)
end

function var_0_0.DialogueNode_17(arg_110_0)
	arg_110_0:EnableCameraByTagAction("2", 1, 0)
	arg_110_0:PlayActorAnimationAction(9072, "think_start", 0.05, 1.333333, function()
		return
	end)
	arg_110_0:PlayActorEmoteAction(9072, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	arg_110_0:ShowTalkView()
	arg_110_0:SetTalkContent(11043015, "", 9072)
	arg_110_0:SetNeedSkip(true, {
		Invoke = function()
			arg_110_0:Skip("End")
		end
	})
	arg_110_0:SetNeedClick(true, {
		Invoke = function()
			arg_110_0:Next()
		end
	})
	arg_110_0:OnNext(function(arg_115_0)
		arg_110_0:ClearOnNext()
		arg_110_0:DialogueNode_18()
	end)
end

function var_0_0.DialogueNode_18(arg_116_0)
	arg_116_0:EnableCameraByTagAction("12", 1, 0)
	arg_116_0:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		arg_116_0:PlayActorAnimationAction(907301, "excited_start", 0.05, 0.6666667, function()
			return
		end)
	end)
	arg_116_0:SetLookAtParamsAction(907301, 0.6, 0.8, 1)
	arg_116_0:LookAtRoleAction(true, 907301, "9074")
	arg_116_0:CameraMoveAction("12", 4, 5, 5, 0.15)
	arg_116_0:ShowTalkView()
	arg_116_0:SetTalkContent(11043016, "", 9073)
	arg_116_0:SetNeedSkip(true, {
		Invoke = function()
			arg_116_0:Skip("End")
		end
	})
	arg_116_0:SetNeedClick(true, {
		Invoke = function()
			arg_116_0:Next()
		end
	})
	arg_116_0:OnNext(function(arg_121_0)
		arg_116_0:ClearOnNext()
		arg_116_0:DialogueNode_19()
	end)
end

function var_0_0.DialogueNode_19(arg_122_0)
	arg_122_0:EnableCameraByTagAction("17", 1, 0)
	arg_122_0:PlayActorAnimationAction(9074, "dorm_male_idle01", 0.05, 8.166667, function()
		return
	end)
	arg_122_0:DelayTimeAction(2.5, function()
		arg_122_0:PlayActorAnimationAction(9074, "action2_1", 0.05, 1.666667, function()
			return
		end)
		arg_122_0:SetLookAtParamsAction(9074, 0.8, 1, 1)
		arg_122_0:LookAtRoleAction(true, 9074, "9060")
		arg_122_0:DelayTimeAction(0.5, function()
			arg_122_0:SetNeedClick(true, {
				Invoke = function()
					arg_122_0:Next()
				end
			})
			arg_122_0:SetNeedSkip(true, {
				Invoke = function()
					arg_122_0:Skip("End")
				end
			})
		end)
	end)
	arg_122_0:PlayActorEmoteAction(9060, "anger02_end", 0, 0.6, function()
		return
	end, true, false)
	arg_122_0:PlayActorEmoteAction(9074, "anger02_end", 0, 0.6, function()
		return
	end, false, false)
	arg_122_0:ShowTalkView()
	arg_122_0:SetTalkContent(11043017, "", 9074)
	arg_122_0:SetNeedSkip(true, {
		Invoke = function()
			arg_122_0:Skip("End")
		end
	})
	arg_122_0:SetNeedClick(false, {
		Invoke = function()
			arg_122_0:Next()
		end
	})
	arg_122_0:OnNext(function(arg_133_0)
		arg_122_0:ClearOnNext()
		arg_122_0:DialogueNode_20()
	end)
end

function var_0_0.DialogueNode_20(arg_134_0)
	arg_134_0:PlayActorAnimationAction(9060, "proud_start", 0.05, 0.6, function()
		return
	end)
	arg_134_0:SetLookAtParamsAction(9060, 0.8, 1, 1)
	arg_134_0:LookAtRoleAction(true, 9060, "9074")
	arg_134_0:ShowTalkView()
	arg_134_0:SetTalkContent(11043018, "", 9060)
	arg_134_0:SetNeedSkip(true, {
		Invoke = function()
			arg_134_0:Skip("End")
		end
	})
	arg_134_0:SetNeedClick(true, {
		Invoke = function()
			arg_134_0:Next()
		end
	})
	arg_134_0:OnNext(function(arg_138_0)
		arg_134_0:ClearOnNext()
		arg_134_0:BlackFadeDialogueNode_21()
	end)
end

function var_0_0.BlackFadeDialogueNode_21(arg_139_0)
	arg_139_0:HideTalkView()
	arg_139_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_139_0:HideAllDynamicAction(false, false, 4095, {})
		arg_139_0:DestroyCharAction(9060)
		arg_139_0:EnableCameraByTagAction("", 1, 0)
		arg_139_0:DestroyCharAction(907301)
		arg_139_0:DestroyCharAction(9072)
		arg_139_0:DestroyCharAction(9074)
		arg_139_0:ContinueBlackFade()
		arg_139_0:OnNext(function()
			arg_139_0:ClearOnNext()
			arg_139_0:CloseStoryEventNode_22()
		end)
	end, function()
		arg_139_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_22(arg_143_0)
	arg_143_0:EnableCameraCutAction(false)
	arg_143_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_144_0)
	arg_144_0:RegisterTalkFunction("End", arg_144_0.CloseStoryEventNode_22)
end

return var_0_0
