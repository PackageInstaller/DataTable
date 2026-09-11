BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11098", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11098"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11098"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:SetCharToTagAction(9073, "9073_1", function()
			return
		end)
		self:HideAllDynamicAction(true, true, 4083, {
			30004,
			30005
		})
		self:PlayActorAnimationAction(9073, "dorm_female_idle01", 0.05, 4.166667, function()
			return
		end)
		self:EnableCameraByTagAction("1", 1, 0)
		self:LoadThingToTag(1, "jing_original", "item_1", function()
			return
		end)
		self:SetCharToTagAction(9074, "9074_1", function()
			return
		end)
		self:PlayActorAnimationAction(9074, "dorm_female_idle01", 0.05, 4.166667, function()
			return
		end)
		self:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_story_01_xiujin", "", "")
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
	self:DelayTimeAction(2.5, function()
		self:BlackFadeAction(0.2, 0.3, 0.3, function()
			self:InstEffectAction({
				attachFollow = false,
				delayTime = 5,
				createMode = "RoleAttach",
				destroyMode = "DelayTime",
				attachType = 3,
				roleId = 9073,
				path = "QWWorld/Effect/EmotionBubble/fx_canlan_0401"
			})
		end, function()
			self:LoadThingToTag(2, "jing_done", "item_1", function()
				return
			end)
			self:PlayActorAnimationAction(9073, "proud_start", 0, 0.6, function()
				self:DelayTimeAction(2, function()
					self:EventAction(function()
						self:ImmediateNextFlag(-1)
					end)
				end)
			end)
			self:UnloadThing(1)
		end)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:SetLookAtParamsAction(9073, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9073, "9074")
	self:ShowTalkView()
	self:SetTalkContent(11013001, "", 0)
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
	self:SetLookAtParamsAction(9074, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9074, "9073")
	self:PlayActorAnimationAction(9074, "dorm_male_idle01", 0.05, 8.166667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11013002, "", 0)
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
	self:OnNext(function(arg_31_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:PlayActorAnimationAction(9073, "action3_1", 0.05, 2.266667, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11013003, "", 0)
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
		self:BlackFadeDialogueNode_6()
	end)
end

function var_0_0:BlackFadeDialogueNode_6()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:HideAllDynamicAction(false, false, 4083, {
			30004
		})
		self:EnableCameraByTagAction("", 1, 0)
		self:UnloadThing(2)
		self:DestroyCharAction(9073)
		self:DestroyCharAction(9074)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_7()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_7()
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.BlackFadeDialogueNode_6)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_7)
end

return var_0_0
