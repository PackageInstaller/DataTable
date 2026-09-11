BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10006", BaseStoryGraph)

function var_0_0:Identify()
	return "10006"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/10006"
end

function var_0_0:StartStory()
	self:DialogueNode_1()
end

function var_0_0:DialogueNode_1()
	self:EnableCameraCutAction(true)
	self:ShowTalkView()
	self:SetTalkContent(10006001, "", 0)
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
	self:SetTalkContent(10006002, "", 0)
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
	self:SetTalkContent(10006003, "", 0)
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
	self:OnNext(function(arg_15_0)
		self:ClearOnNext()
		self:DialogueNode_4()
	end)
end

function var_0_0:DialogueNode_4()
	self:ShowTalkView()
	self:SetTalkContent(10006004, "", 0)
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
	self:OnNext(function(arg_19_0)
		self:ClearOnNext()
		self:DialogueNode_5()
	end)
end

function var_0_0:DialogueNode_5()
	self:ShowTalkView()
	self:SetTalkContent(10006005, "", 0)
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
	self:OnNext(function(arg_23_0)
		self:ClearOnNext()
		self:DialogueNode_6()
	end)
end

function var_0_0:DialogueNode_6()
	self:ShowTalkView()
	self:SetTalkContent(10006006, "", 0)
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
		self:DialogueNode_7()
	end)
end

function var_0_0:DialogueNode_7()
	self:ShowTalkView()
	self:SetTalkContent(10006007, "", 0)
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
	self:OnNext(function(arg_31_0)
		self:ClearOnNext()
		self:CloseStoryEventNode_8()
	end)
end

function var_0_0:CloseStoryEventNode_8()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

return var_0_0
