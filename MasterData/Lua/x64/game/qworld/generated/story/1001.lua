BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("1001", BaseStoryGraph)

function var_0_0:Identify()
	return "1001"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/1001"
end

function var_0_0:StartStory()
	self:DialogueNode_1()
end

function var_0_0:DialogueNode_1()
	self:EnableCameraCutAction(true)
	self:ShowTalkView()
	self:SetTalkContent(101, "", 0)
	self:SetNeedSkip(false, {
		Invoke = function()
			self:Skip()
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_7_0)
		self:ClearOnNext()
		self:DialogueNode_2()
	end)
end

function var_0_0:DialogueNode_2()
	self:ShowTalkView()
	self:SetTalkContent(102, "", 0)
	self:SetNeedSkip(false, {
		Invoke = function()
			self:Skip()
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_11_0)
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:ShowTalkView()
	self:SetTalkContent(103, "", 0)
	self:SetChoice({
		[0] = {
			id = 104,
			icon = "",
			Invoke = function()
				self:Next(104)
			end
		},
		{
			id = 105,
			icon = "",
			Invoke = function()
				self:Next(105)
			end
		},
		{
			id = 106,
			icon = "",
			Invoke = function()
				self:Next(106)
			end
		},
		Length = 3
	}, true)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_16_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_16_0 == 104 then
			self:DialogueBranchNode_4()
		elseif arg_16_0 == 105 then
			self:DialogueBranchNode_5()
		elseif arg_16_0 == 106 then
			self:DialogueBranchNode_6()
		end
	end)
end

function var_0_0:DialogueBranchNode_4()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_7()
	end)
	self:Next()
end

function var_0_0:DialogueNode_7()
	self:ShowTalkView()
	self:SetTalkContent(107, "", 0)
	self:SetNeedSkip(false, {
		Invoke = function()
			self:Skip()
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_22_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueNode_8()
	self:ShowTalkView()
	self:SetTalkContent(110, "", 0)
	self:SetNeedSkip(false, {
		Invoke = function()
			self:Skip()
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_26_0)
		self:ClearOnNext()
		self:CloseStoryEventNode_9()
	end)
end

function var_0_0:CloseStoryEventNode_9()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:DialogueBranchNode_5()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_10()
	end)
	self:Next()
end

function var_0_0:DialogueNode_10()
	self:ShowTalkView()
	self:SetTalkContent(108, "", 0)
	self:SetNeedSkip(false, {
		Invoke = function()
			self:Skip()
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_33_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

function var_0_0:DialogueBranchNode_6()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_11()
	end)
	self:Next()
end

function var_0_0:DialogueNode_11()
	self:ShowTalkView()
	self:SetTalkContent(109, "", 0)
	self:SetNeedSkip(false, {
		Invoke = function()
			self:Skip()
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_39_0)
		self:ClearOnNext()
		self:DialogueNode_8()
	end)
end

return var_0_0
