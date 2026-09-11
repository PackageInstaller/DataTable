BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("1198301", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "1198301"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/1198301"
end

function var_0_0:StartStory()
	self:DialogueNode_1()
end

function var_0_0:DialogueNode_1()
	self:PlaySoundsAction(1, "vo_sandplay", "vo_sandplay_female_younger_suprised", "vo_sandplay.awb", "vo_sandplay.acb")
	self:ShowTalkView()
	self:SetTalkContent(119830101, "", 0)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_8_0)
		self:ClearOnNext()
		self:DialogueNode_2()
	end)
end

function var_0_0:DialogueNode_2()
	self:ShowTalkView()
	self:SetTalkContent(119830102, "", 0)
	self:SetNeedSkip(true, {
		Invoke = function()
			self:Skip("End")
		end
	})
	self:SetNeedClick(true, {
		Invoke = function()
			self:Next()
		end
	})
	self:OnNext(function(arg_12_0)
		self:ClearOnNext()
		self:CloseStoryEventNode_3()
	end)
end

function var_0_0:CloseStoryEventNode_3()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_3)
end

return var_0_0
