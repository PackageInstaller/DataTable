BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("301", BaseStoryGraph)

function var_0_0:Identify()
	return "301"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/301"
end

function var_0_0:StartStory()
	self:DialogueNode_1()
end

function var_0_0:DialogueNode_1()
	self:EnableCameraCutAction(true)
	self:ShowTalkView()
	self:SetTalkContent(301, "", 0)
	self:SetChoice({
		Length = 1,
		[0] = {
			id = 302,
			icon = "",
			Invoke = function()
				self:Next(302)
			end
		}
	}, true)
	self:SetNeedSkip(false, nil)
	self:SetNeedClick(false, nil)
	self:OnNext(function(arg_6_0)
		self:ClearOnNext()
		self:CloseChoice()

		if arg_6_0 == 302 then
			self:DialogueBranchNode_2()
		end
	end)
end

function var_0_0:DialogueBranchNode_2()
	self:OnNext(function()
		self:ClearOnNext()
		self:DialogueNode_3()
	end)
	self:Next()
end

function var_0_0:DialogueNode_3()
	self:ShowTalkView()
	self:SetTalkContent(303, "", 0)
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
	self:OnNext(function(arg_12_0)
		self:ClearOnNext()
		self:CloseStoryEventNode_4()
	end)
end

function var_0_0:CloseStoryEventNode_4()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

return var_0_0
