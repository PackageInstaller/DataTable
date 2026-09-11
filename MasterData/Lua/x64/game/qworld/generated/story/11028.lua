BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11028", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11028"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11028"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:SetCharToTagAction(9073, "1", function()
			return
		end)
		self:HideAllDynamicAction(true, true, 4081, {})
		self:EnableCameraByTagAction("1", 1, 0)
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
	self:ShowTalkView()
	self:SetTalkContent(11028001, "", 9073)
	self:SetChoice({
		[0] = {
			id = 11028002,
			icon = "",
			Invoke = function()
				self:Next(11028002)
			end
		},
		{
			id = 11028003,
			icon = "",
			Invoke = function()
				self:Next(11028003)
			end
		},
		{
			id = 11028004,
			icon = "",
			Invoke = function()
				self:Next(11028004)
			end
		},
		Length = 3
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_14_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_14_0 == 11028002 then
			self:DialogueBranchNode_3()
		elseif arg_14_0 == 11028003 then
			self:DialogueBranchNode_4()
		elseif arg_14_0 == 11028004 then
			self:DialogueBranchNode_5()
		end
	end)
end

function var_0_0:DialogueBranchNode_3()
	self:OnNext(function()
		self:ClearOnNext()
		self:PureActorDialogueNode_6()
	end)
	self:Next()
end

function var_0_0:PureActorDialogueNode_6()
	self:PlayActorAnimationAction(9073, "take", 0.05, 1.833333, function()
		return
	end)
	self:EventAction(function()
		self:ImmediateNextFlag(-1)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:ShowTalkView()
	self:SetTalkContent(11028005, "", 9073)
	self:SetChoice({
		[0] = {
			id = 11028006,
			icon = "",
			Invoke = function()
				self:Next(11028006)
			end
		},
		{
			id = 11028007,
			icon = "",
			Invoke = function()
				self:Next(11028007)
			end
		},
		Length = 2
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_24_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_24_0 == 11028006 then
			self:DialogueBranchNode_8()
		elseif arg_24_0 == 11028007 then
			self:DialogueBranchNode_9()
		end
	end)
end

function var_0_0:DialogueBranchNode_8()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
	self:Next()
end

function var_0_0:DialogueNode_10()
	self:ShowTalkView()
	self:SetTalkContent(11028008, "", 9073)
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
	self:OnNext(function(arg_30_0)
		self:ClearOnNext()
		self:DialogueNode_2()
	end)
end

function var_0_0:DialogueBranchNode_9()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_2()
	end)
	self:Next()
end

function var_0_0:DialogueBranchNode_4()
	self:OnNext(function()
		self:ClearOnNext()
		self:PureActorDialogueNode_11()
	end)
	self:Next()
end

function var_0_0:PureActorDialogueNode_11()
	self:PlayActorAnimationAction(9073, "take", 0.05, 1.833333, function()
		return
	end)
	self:EventAction(function()
		self:ImmediateNextFlag(-1)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_12()
	end)
end

function var_0_0:DialogueNode_12()
	self:ShowTalkView()
	self:SetTalkContent(11028009, "", 9073)
	self:SetChoice({
		[0] = {
			id = 11028010,
			icon = "",
			Invoke = function()
				self:Next(11028010)
			end
		},
		{
			id = 11028011,
			icon = "",
			Invoke = function()
				self:Next(11028011)
			end
		},
		Length = 2
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_42_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_42_0 == 11028010 then
			self:DialogueBranchNode_13()
		elseif arg_42_0 == 11028011 then
			self:DialogueBranchNode_14()
		end
	end)
end

function var_0_0:DialogueBranchNode_13()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_15()
	end)
	self:Next()
end

function var_0_0:DialogueNode_15()
	self:PlaySoundsAction(2, "minigame_activity_3_5", "minigame_activity_3_5_catch_crown", "", "")
	self:ShowTalkView()
	self:SetTalkContent(11028012, "", 9073)
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
	self:OnNext(function(arg_48_0)
		self:ClearOnNext()
		self:PureActorDialogueNode_16()
	end)
end

function var_0_0:PureActorDialogueNode_16()
	self:HideAllDynamicAction(true, true, 1, {
		50012
	})
	self:EventAction(function()
		self:ImmediateNextFlag(-1)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
end

function var_0_0:DialogueNode_17()
	self:ShowTalkView()
	self:SetTalkContent(11028017, "", 9073)
	self:SetChoice({
		[0] = {
			id = 11028018,
			icon = "",
			Invoke = function()
				self:Next(11028018)
			end
		},
		{
			id = 11028019,
			icon = "",
			Invoke = function()
				self:Next(11028019)
			end
		},
		Length = 2
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_55_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_55_0 == 11028018 then
			self:DialogueBranchNode_18()
		elseif arg_55_0 == 11028019 then
			self:DialogueBranchNode_19()
		end
	end)
end

function var_0_0:DialogueBranchNode_18()
	self:OnNext(function()
		self:ClearOnNext()
		self:PureActorDialogueNode_20()
	end)
	self:Next()
end

function var_0_0:PureActorDialogueNode_20()
	self:PlayActorAnimationAction(9073, "take", 0.05, 1.833333, function()
		return
	end)
	self:EventAction(function()
		self:ImmediateNextFlag(-1)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_21()
	end)
end

function var_0_0:DialogueNode_21()
	self:ShowTalkView()
	self:SetTalkContent(11028020, "", 9073)
	self:SetChoice({
		[0] = {
			id = 11028021,
			icon = "",
			Invoke = function()
				self:Next(11028021)
			end
		},
		{
			id = 11028022,
			icon = "",
			Invoke = function()
				self:Next(11028022)
			end
		},
		Length = 2
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_65_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_65_0 == 11028021 then
			self:DialogueBranchNode_22()
		elseif arg_65_0 == 11028022 then
			self:DialogueBranchNode_23()
		end
	end)
end

function var_0_0:DialogueBranchNode_22()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_24()
	end)
	self:Next()
end

function var_0_0:DialogueNode_24()
	self:PlaySoundsAction(2, "minigame_activity_3_5", "minigame_activity_3_5_catch_crown", "", "")
	self:ShowTalkView()
	self:SetTalkContent(11028023, "", 9073)
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
	self:OnNext(function(arg_71_0)
		self:ClearOnNext()
		self:PureActorDialogueNode_25()
	end)
end

function var_0_0:PureActorDialogueNode_25()
	self:HideAllDynamicAction(true, true, 1, {
		50011,
		50012
	})
	self:EventAction(function()
		self:ImmediateNextFlag(-1)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_26()
	end)
end

function var_0_0:DialogueNode_26()
	self:ShowTalkView()
	self:SetTalkContent(11028028, "", 9073)
	self:SetChoice({
		Length = 1,
		[0] = {
			id = 11028029,
			icon = "",
			Invoke = function()
				self:Next(11028029)
			end
		}
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_77_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_77_0 == 11028029 then
			self:DialogueBranchNode_27()
		end
	end)
end

function var_0_0:DialogueBranchNode_27()
	self:OnNext(function()
		self:ClearOnNext()
		self:PureActorDialogueNode_28()
	end)
	self:Next()
end

function var_0_0:PureActorDialogueNode_28()
	self:PlayActorAnimationAction(9073, "take", 0.05, 1.833333, function()
		return
	end)
	self:EventAction(function()
		self:ImmediateNextFlag(-1)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_29()
	end)
end

function var_0_0:DialogueNode_29()
	self:PlaySoundsAction(2, "minigame_activity_3_5", "minigame_activity_3_5_catch_crown", "", "")
	self:ShowTalkView()
	self:SetTalkContent(11028030, "", 9073)
	self:SetChoice({
		Length = 1,
		[0] = {
			id = 11028031,
			icon = "",
			Invoke = function()
				self:Next(11028031)
			end
		}
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_86_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_86_0 == 11028031 then
			self:DialogueBranchNode_30()
		end
	end)
end

function var_0_0:DialogueBranchNode_30()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_31()
	end)
	self:Next()
end

function var_0_0:DialogueNode_31()
	self:ShowTalkView()
	self:SetTalkContent(11028032, "", 9073)
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
	self:OnNext(function(arg_92_0)
		self:ClearOnNext()
		self:BlackFadeDialogueNode_32()
	end)
end

function var_0_0:BlackFadeDialogueNode_32()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false, 1, {
			50013,
			50011,
			50012
		})
		self:EnableCameraByTagAction("", 1, 0)
		self:DestroyCharAction(9073)
		self:EventAction(function()
			self:ImmediateNextFlag(-1)
		end)
		self:WalkingPeopleGlobleCull(false)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_33()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_33()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:DialogueBranchNode_23()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
	self:Next()
end

function var_0_0:DialogueBranchNode_19()
	self:OnNext(function()
		self:ClearOnNext()
		self:PureActorDialogueNode_34()
	end)
	self:Next()
end

function var_0_0:PureActorDialogueNode_34()
	self:PlayActorAnimationAction(9073, "take", 0.05, 1.833333, function()
		return
	end)
	self:EventAction(function()
		self:ImmediateNextFlag(-1)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_35()
	end)
end

function var_0_0:DialogueNode_35()
	self:ShowTalkView()
	self:SetTalkContent(11028024, "", 9073)
	self:SetChoice({
		[0] = {
			id = 11028025,
			icon = "",
			Invoke = function()
				self:Next(11028025)
			end
		},
		{
			id = 11028026,
			icon = "",
			Invoke = function()
				self:Next(11028026)
			end
		},
		Length = 2
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_110_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_110_0 == 11028025 then
			self:DialogueBranchNode_36()
		elseif arg_110_0 == 11028026 then
			self:DialogueBranchNode_37()
		end
	end)
end

function var_0_0:DialogueBranchNode_36()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_38()
	end)
	self:Next()
end

function var_0_0:DialogueNode_38()
	self:ShowTalkView()
	self:SetTalkContent(11028027, "", 9073)
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
	self:OnNext(function(arg_116_0)
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
end

function var_0_0:DialogueBranchNode_37()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_17()
	end)
	self:Next()
end

function var_0_0:DialogueBranchNode_14()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_2()
	end)
	self:Next()
end

function var_0_0:DialogueBranchNode_5()
	self:OnNext(function()
		self:ClearOnNext()
		self:PureActorDialogueNode_39()
	end)
	self:Next()
end

function var_0_0:PureActorDialogueNode_39()
	self:PlayActorAnimationAction(9073, "take", 0.05, 1.833333, function()
		return
	end)
	self:EventAction(function()
		self:ImmediateNextFlag(-1)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_40()
	end)
end

function var_0_0:DialogueNode_40()
	self:ShowTalkView()
	self:SetTalkContent(11028013, "", 9073)
	self:SetChoice({
		[0] = {
			id = 11028014,
			icon = "",
			Invoke = function()
				self:Next(11028014)
			end
		},
		{
			id = 11028015,
			icon = "",
			Invoke = function()
				self:Next(11028015)
			end
		},
		Length = 2
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_130_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_130_0 == 11028014 then
			self:DialogueBranchNode_41()
		elseif arg_130_0 == 11028015 then
			self:DialogueBranchNode_42()
		end
	end)
end

function var_0_0:DialogueBranchNode_41()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_43()
	end)
	self:Next()
end

function var_0_0:DialogueNode_43()
	self:ShowTalkView()
	self:SetTalkContent(11028016, "", 9073)
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
	self:OnNext(function(arg_136_0)
		self:ClearOnNext()
		self:DialogueNode_2()
	end)
end

function var_0_0:DialogueBranchNode_42()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_2()
	end)
	self:Next()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_33)
end

return var_0_0
