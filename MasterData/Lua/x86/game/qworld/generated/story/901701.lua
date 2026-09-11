BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("901701", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "901701"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/901701"
end

function var_0_0:StartStory()
	self:DialogueNode_1()
end

function var_0_0:DialogueNode_1()
	self:ShowTalkView()
	self:SetTalkContent(901701001, "", 0)
	self:SetChoice({
		[0] = {
			id = 901701002,
			icon = "",
			Invoke = function()
				self:Next(901701002)
			end
		},
		{
			id = 901701003,
			icon = "",
			Invoke = function()
				self:Next(901701003)
			end
		},
		Length = 2
	}, true)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_8_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_8_0 == 901701002 then
			self:DialogueBranchNode_2()
		elseif arg_8_0 == 901701003 then
			self:DialogueBranchNode_3()
		end
	end)
end

function var_0_0:DialogueBranchNode_2()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
	self:Next()
end

function var_0_0:DialogueNode_4()
	self:ShowTalkView()
	self:SetTalkContent(901701004, "", 0)
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
	self:OnNext(function(arg_14_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:ShowTalkView()
	self:SetTalkContent(901701005, "", 0)
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
	self:OnNext(function(arg_18_0)
		self:ClearOnNext()
		self:CloseStoryEventNode_6()
	end)
end

function var_0_0:CloseStoryEventNode_6()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:DialogueBranchNode_3()
	self:OnNext(function()
		self:ClearOnNext()
		self:CloseStoryEventNode_7()
	end)
	self:Next()
end

function var_0_0:CloseStoryEventNode_7()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_6)
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_7)
end

return var_0_0
