BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local TestStory = class("TestStory", BaseStoryGraph)

function TestStory:Identify()
	return "TestStory"
end

function TestStory:ConfigPath()
	return "QWWorld/StoryGraph/TestStory"
end

function TestStory:StartStory()
	self:BlackFadeDialogueNode_1()
end

function TestStory:BlackFadeDialogueNode_1()
	self:HideTalkView()
	self:OnBlackFade(true, 5, 3, 2, 2, function()
		self:EnableCameraCutAction(true)
		self:EnableCameraByTagAction("A1")
		self:ContinueBlackFade()
		self:OnNext(function()
			self:ClearOnNext()
			self:DialogueNode_2()
		end)
	end, function()
		self:Next()
	end)
end

function TestStory:DialogueNode_2()
	self:ShowTalkView()
	self:SetTalkContent(10, "Assets/ABResources/Textures/Dorm/Customer/1.png", 9070)
	self:SetChoice({
		[0] = {
			id = 7,
			icon = "",
			Invoke = function()
				self:Next(7)
			end
		},
		{
			id = 8,
			icon = "",
			Invoke = function()
				self:Next(8)
			end
		},
		Length = 2
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_11_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_11_0 == 7 then
			self:DialogueBranchNode_3()
		elseif arg_11_0 == 8 then
			self:DialogueBranchNode_4()
		end
	end)
end

function TestStory:DialogueBranchNode_3()
	self:OnNext(function()
		self:ClearOnNext()
		self:BlackFadeDialogueNode_5()
	end)
	self:Next()
end

function TestStory:BlackFadeDialogueNode_5()
	self:HideTalkView()
	self:OnBlackFade(true, 2, 2, 3, 3, function()
		self:SetCharToTagAction(9024, "PATH_A1", function()
			self:ContinueBlackFade()
		end)
		self:OnNext(function()
			self:ClearOnNext()
			self:PureActorDialogueNode_6()
		end)
	end, function()
		self:Next()
	end)
end

function TestStory:PureActorDialogueNode_6()
	self:ActorSeekerAction(9024, {
		"PATH_A1",
		"PATH_A2",
		"PATH_A3"
	}, 3, function()
		self:DelayTimeAction(0.5, function()
			self:PlayActorAnimationAction(9024, "cheer", 0, 2.333333, function()
				self:ActorSeekerAction(9024, {
					"PATH_A4",
					"PATH_A5",
					"PATH_A6"
				}, 3, function()
					self:PlayActorAnimationAction(9024, "conversation_1", 0, 3, function()
						self:EventAction(function()
							self:ImmediateNextFlag(-1)
							self:DispatchEvent("Destroy_A")
						end)
					end)
					self:EnableCameraByTagAction("A2")
				end)
			end)
		end)
	end)
	self:InstEffectAction({
		attachFollow = false,
		event = "Destroy_A",
		createMode = "RoleAttach",
		destroyMode = "Event",
		attachType = 3,
		roleId = 9024,
		path = "QWWorld/Effect/fx_pickup.prefab"
	})
	self:EnableCameraShakeAction(true, "Camera/Noise/Handheld_normal_strong.asset", 2, 2, 2)
	self:HideTalkView()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
end

function TestStory:DialogueNode_7()
	self:ShowTalkView()
	self:SetTalkContent(4, "Assets/UIResources/UI_AB/TextureConfig/Story/Character/1060_split_1_1.png", 9072)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip()
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_30_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function TestStory:DialogueNode_8()
	self:EnableCameraCutAction(false)
	self:DelayTimeAction(3, function()
		self:SetNeedClick(true, {
			Invoke = function()
				self:Next()
			end
		})
		self:SetNeedSkip(false, nil)
	end)
	self:EnableCameraByTagAction("A1")
	self:ShowTalkView()
	self:SetTalkContent(9, "", 9072)
	self:SetNeedSkip(false, {
		Invoke = function()
			self:Skip()
		end
	})
	self:SetNeedClick(false, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_36_0)
		self:ClearOnNext()
		self:CloseStoryEventNode_9()
	end)
end

function TestStory:CloseStoryEventNode_9()
	self:EnableCameraCutAction(false)
	self:EnableCameraByTagAction("")
	self:EndStory()
end

function TestStory:DialogueBranchNode_4()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
	self:Next()
end

return TestStory
