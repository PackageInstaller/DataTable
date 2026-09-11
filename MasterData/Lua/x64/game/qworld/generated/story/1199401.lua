BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("1199401", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "1199401"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/1199401"
end

function var_0_0:StartStory()
	self:DialogueNode_1()
end

function var_0_0:DialogueNode_1()
	self:PlaySoundsAction(1, "vo_sandplay", "vo_sandplay_female_elder_happy", "vo_sandplay.awb", "vo_sandplay.acb")
	self:ShowTalkView()
	self:SetTalkContent(119940101, "", 9520)
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
	self:SetTalkContent(119940102, "", 9520)
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
