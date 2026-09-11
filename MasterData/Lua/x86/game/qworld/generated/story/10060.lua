BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10060", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "10060"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/10060"
end

function var_0_0:StartStory()
	self:BlackFadeDialogueNode_1()
end

function var_0_0:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0, 0, 0.5, function()
		self:EnableCameraByTagAction("4", 1, 0)
		self:CameraMoveAction("4", 1, 5, 6, 0.4)
		self:HideAllDynamicAction(false, true)
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
	self:DelayTimeAction(5, function()
		self:BlackFadeAction(0.1, 0.5, 0.5, function()
			return
		end, function()
			self:EnableCameraByTagAction("2", 1, 0)
			self:DelayTimeAction(6, function()
				self:BlackFadeAction(0.1, 0.5, 0.5, function()
					return
				end, function()
					self:EnableCameraByTagAction("1", 1, 0)
					self:CameraMoveAction("1", 1, 3, 6, 0.4)
					self:DelayTimeAction(5, function()
						self:BlackFadeAction(0.1, 0.5, 0.5, function()
							return
						end, function()
							self:EnableCameraByTagAction("3", 1, 0)
							self:CameraMoveAction("3", 1, 4, 6, 0.4)
							self:DelayTimeAction(5, function()
								self:EventAction(function()
									self:ImmediateNextFlag(-1)
								end)
							end)
						end)
					end)
				end)
			end)
		end)
	end)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:BlackFadeDialogueNode_3()
	end)
end

function var_0_0:BlackFadeDialogueNode_3()
	self:HideTalkView()
	self:OnBlackFade(false, 0, 0.1, 0.5, 0.5, function()
		self:EnableCameraByTagAction("", 1, 0)
		self:HideAllDynamicAction(false, false)
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:CloseStoryEventNode_4()
		end)
	end, function()
		self:Next()
	end)
end

function var_0_0:CloseStoryEventNode_4()
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_4)
end

return var_0_0
