BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11099", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11099"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11099"
end

function var_0_0:StartStory()
	self:PureActorDialogueNode_1()
end

function var_0_0:PureActorDialogueNode_1()
	self:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		self:EnableCameraByTagAction("1", 1, 0)
		self:SetCharToTagAction(9073, "9073_1", function()
			self:PlayActorAnimationAction(9073, "present_bag_moving_1", 0.1, 8.033334, function()
				return
			end)
			self:DelayTimeAction(8, function()
				self:PlayActorAnimationAction(9073, "present_bag_moving_2", 0.1, 2.566667, function()
					return
				end)
				self:BlackFadeAction(0, 0.2, 0.2, function()
					return
				end, function()
					self:SetThingToTag(1, "item_2", function()
						return
					end)
					self:SetCharToTagAction(9073, "9073_2", function()
						self:DelayTimeAction(2, function()
							self:BlackFadeAction(0, 0.2, 0.2, function()
								return
							end, function()
								self:SetThingToTag(1, "item_3", function()
									return
								end)
								self:CameraMoveAction("3", 1, 2, 10, 0.8)
								self:SetCharToTagAction(9073, "9073_3", function()
									return
								end)
								self:PlayActorAnimationAction(9073, "present_bag_moving_3", 0.1, 6.466667, function()
									return
								end)
								self:DelayTimeAction(5.5, function()
									self:BlackFadeAction(0, 0.2, 0.2, function()
										return
									end, function()
										self:SetThingToTag(1, "item_4", function()
											return
										end)
										self:SetCharToTagAction(9073, "9073_4", function()
											return
										end)
										self:CameraMoveAction("3", 1, 2, 10, 0.8)
										self:PlayActorAnimationAction(9073, "present_bag_moving_4", 0, 4.733334, function()
											return
										end)
										self:EnableCameraByTagAction("4", 1, 0)
										self:DelayTimeAction(3, function()
											self:EventAction(function()
												self:ImmediateNextFlag(-1)
											end)
										end)
										self:InstEffectAction({
											attachFollow = false,
											delayTime = 5,
											createMode = "RoleAttach",
											destroyMode = "DelayTime",
											attachType = 10,
											roleId = 9073,
											path = "QWWorld/Effect/EmotionBubble/fx_piaosan_1401"
										})
										self:SetCharToTagAction(9074, "9074_1", function()
											return
										end)
										self:WalkingPeopleGlobleCull(false)
									end)
								end)
								self:EnableCameraByTagAction("3", 1, 0)
							end)
						end)
					end)
					self:EnableCameraByTagAction("2", 1, 0)
					self:CameraMoveAction("2", 1, 2, 10, 0.8)
					self:InstEffectAction({
						attachFollow = false,
						delayTime = 5,
						createMode = "RoleAttach",
						destroyMode = "DelayTime",
						attachType = 10,
						roleId = 9073,
						path = "QWWorld/Effect/EmotionBubble/fx_maohan_0302"
					})
				end)
			end)
		end)
		self:LoadThingToTag(1, "Main_vat_original_2", "item_1", function()
			return
		end)
		self:HideAllDynamicAction(true, true, 4083, {
			30002,
			30003
		})
		self:CameraMoveAction("1", 1, 2, 10, 0.8)
		self:WalkingPeopleGlobleCull(true)
		self:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_story_02_bangang", "", "")
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_2()
	end)
end

function var_0_0:DialogueNode_2()
	self:SetLookAtParamsAction(9074, 0.8, 1, 1)
	self:LookAtRoleAction(true, 9074, "9073")
	self:DelayTimeAction(2, function()
		self:SetLookAtParamsAction(9073, 0.8, 1, 1)
		self:LookAtRoleAction(true, 9073, "9074")
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
	self:SetTalkContent(11013011, "", 9073)
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
	self:OnNext(function(arg_40_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:PlayActorAnimationAction(9074, "conversation_1", 0.1, 3, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11013012, "", 9074)
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
	self:OnNext(function(arg_45_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:PlayActorAnimationAction(9073, "embarrassed", 0.1, 2.6, function()
		return
	end)
	self:ShowTalkView()
	self:SetTalkContent(11013013, "", 9073)
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
		self:BlackFadeDialogueNode_5()
	end)
end

function var_0_0:BlackFadeDialogueNode_5()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		self:DestroyCharAction(9073)
		self:UnloadThing(1)
		self:EnableCameraByTagAction("", 1, 0)
		self:HideAllDynamicAction(false, false, 4095, {})
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
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_6)
end

return var_0_0
