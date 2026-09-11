BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("601", BaseStoryGraph)

function var_0_0:Identify()
	return "601"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/601"
end

function var_0_0:StartStory()
	self:DialogueNode_1()
end

function var_0_0:DialogueNode_1()
	self:EnableCameraCutAction(true)
	self:ShowTalkView()
	self:SetTalkContent(601, "", 0)
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
	self:SetTalkContent(602, "", 0)
	self:SetChoice({
		[0] = {
			id = 603,
			icon = "",
			Invoke = function()
				self:Next(603)
			end
		},
		{
			id = 606,
			icon = "",
			Invoke = function()
				self:Next(606)
			end
		},
		Length = 2
	}, true)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_11_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_11_0 == 603 then
			self:DialogueBranchNode_3()
		elseif arg_11_0 == 606 then
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
	self:SetTalkContent(604, "", 0)
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
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:ShowTalkView()
	self:SetTalkContent(605, "", 0)
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
	self:OnNext(function(arg_21_0)
		self:ClearOnNext()
		self:DialogueNode_2()
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
	self:SetTalkContent(607, "", 0)
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
	self:OnNext(function(arg_27_0)
		self:ClearOnNext()
		self:CloseStoryEventNode_8()
	end)
end

function var_0_0:CloseStoryEventNode_8()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

return var_0_0
