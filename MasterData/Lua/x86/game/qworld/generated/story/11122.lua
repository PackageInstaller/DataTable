BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11122", BaseStoryGraph)

function var_0_0:Ctor()
	var_0_0.super.Ctor(self)
	self:RegisterFuncMap()
end

function var_0_0:Identify()
	return "11122"
end

function var_0_0:ConfigPath()
	return "QWWorld/StoryGraph/11122"
end

function var_0_0:StartStory()
	self:DialogueNode_1()
end

function var_0_0:DialogueNode_1()
	self:HideAllDynamicAction(true, false, 0, {
		380016,
		380017,
		380018
	})
	self:InstEffectAction({
		pointTag = "1",
		destroyMode = "DontDestroy",
		createMode = "Point",
		path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
	})
	self:InstEffectAction({
		pointTag = "2",
		destroyMode = "DontDestroy",
		createMode = "Point",
		path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
	})
	self:InstEffectAction({
		pointTag = "3",
		destroyMode = "DontDestroy",
		createMode = "Point",
		path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
	})
	self:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_action_sgd_disappear_act", "", "")
	self:ShowTalkView()
	self:SetTalkContent(11122001, "", 9516)
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
	self:SetTalkContent(11122002, "", 9073)
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
		self:DialogueNode_3()
	end)
end

function var_0_0:DialogueNode_3()
	self:ShowTalkView()
	self:SetTalkContent(11122003, "", 9516)
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
	self:OnNext(function(arg_16_0)
		self:ClearOnNext()
		self:CloseStoryEventNode_4()
	end)
end

function var_0_0:CloseStoryEventNode_4()
	self:EnableCameraCutAction(false)
	self:EndStory()
end

function var_0_0:RegisterFuncMap()
	self:RegisterTalkFunction("End", self.CloseStoryEventNode_4)
end

return var_0_0
