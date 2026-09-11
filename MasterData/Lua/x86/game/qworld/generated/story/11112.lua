BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11112", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11112"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11112"
end

function var_0_0:StartStory()
	self:DialogueNode_1()
end

function var_0_0:DialogueNode_1()
	self:ShowTalkView()
	self:SetTalkContent(11112001, "", 0)
	self:SetChoice({
		Length = 1,
		[0] = {
			id = 11112002,
			icon = "",
			Invoke = function()
				self:Next(11112002)
			end
		}
	}, false)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_7_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_7_0 == 11112002 then
			self:DialogueBranchNode_2()
		end
	end)
end

function var_0_0:DialogueBranchNode_2()
	self:OnNext(function()
		self:ClearOnNext()
		self:CloseStoryEventNode_3()
	end)
	self:Next()
end

function var_0_0:CloseStoryEventNode_3()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_3)
end

return var_0_0
