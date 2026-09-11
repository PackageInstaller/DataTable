BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("201", BaseStoryGraph)

function var_0_0:Identify()
	return "201"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/201"
end

function var_0_0:StartStory()
	self:DialogueNode_1()
end

function var_0_0:DialogueNode_1()
	self:EnableCameraCutAction(true)
	self:ShowTalkView()
	self:SetTalkContent(201, "", 0)
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
	self:SetTalkContent(202, "", 0)
	self:SetChoice({
		[0] = {
			id = 203,
			icon = "",
			Invoke = function()
				self:Next(203)
			end
		},
		{
			id = 205,
			icon = "",
			Invoke = function()
				self:Next(205)
			end
		},
		Length = 2
	}, true)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_11_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_11_0 == 203 then
			self:DialogueBranchNode_3()
		elseif arg_11_0 == 205 then
			self:DialogueBranchNode_4()
		end
	end)
end

function var_0_0:DialogueBranchNode_3()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
	self:Next()
end

function var_0_0:DialogueNode_5()
	self:ShowTalkView()
	self:SetTalkContent(204, "", 0)
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
	self:OnNext(function(arg_17_0)
		self:ClearOnNext()
		self:CloseStoryEventNode_6()
	end)
end

function var_0_0:CloseStoryEventNode_6()
	self:EnableCameraCutAction(false)
	self:EndStory()
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
	self:SetTalkContent(206, "", 0)
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
	self:OnNext(function(arg_24_0)
		self:ClearOnNext()
		self:DialogueNode_2()
	end)
end

return var_0_0
