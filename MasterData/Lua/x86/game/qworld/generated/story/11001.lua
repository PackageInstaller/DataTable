BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11001", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11001"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11001"
end

function var_0_0:StartStory()
	self:PureActorDialogueNode_1()
end

function var_0_0:PureActorDialogueNode_1()
	self:BlackFadeAction(0.2, 0, 0.5, function()
		return
	end, function()
		self:DelayTimeAction(3.5, function()
			self:BlackFadeAction(0.2, 0.5, 0.5, function()
				return
			end, function()
				self:DelayTimeAction(4.5, function()
					self:BlackFadeAction(0.2, 0.5, 0.5, function()
						return
					end, function()
						self:EnableCameraByTagAction("2", 1, 2)
						self:DelayTimeAction(4.5, function()
							self:BlackFadeAction(0.2, 0.5, 0.5, function()
								return
							end, function()
								self:EventAction(function()
									self:ImmediateNextFlag(-1)
								end)
								self:HideAllDynamicAction(false, false, 4095, {})
							end)
						end)
					end)
				end)
				self:EnableCameraByTagAction("3", 1, 2)
				self:CameraMoveAction("3", 4, 5, 6, 1)
			end)
		end)
	end)
	self:HideAllDynamicAction(true, true, 4095, {})
	self:EnableCameraByTagAction("1", 1, 2)
	self:CameraMoveAction("1", 4, 4, 6, 1)
	self:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_bgm_start", "", "")
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:CloseStoryEventNode_2()
	end)
end

function var_0_0:CloseStoryEventNode_2()
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_2)
end

return var_0_0
