local OsirisRecallRemasterdView = class("OsirisRecallRemasterdView", (import("game.views.osiris.recall.OsirisRecallView")))

function OsirisRecallRemasterdView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, OsirisRecallRemasteredItem)
	self.playExtraStoryStartHandler_ = handler(self, self.PlayExtraStoryStart)
	self.playExtraStoryOverHander_ = handler(self, self.PlayExtraStoryOver)
end

function OsirisRecallRemasterdView:OnEnter()
	OsirisRecallRemasterdView.super.OnEnter(self)
	manager.notify:RegistListener(PLAY_EXTRA_STORY_START, self.playExtraStoryStartHandler_)
	manager.notify:RegistListener(PLAY_EXTRA_STORY_OVER, self.playExtraStoryOverHander_)
end

function OsirisRecallRemasterdView:OnExit()
	OsirisRecallRemasterdView.super.OnExit(self)
	manager.notify:RemoveListener(PLAY_EXTRA_STORY_START, self.playExtraStoryStartHandler_)
	manager.notify:RemoveListener(PLAY_EXTRA_STORY_OVER, self.playExtraStoryOverHander_)
end

function OsirisRecallRemasterdView:Dispose()
	self.playExtraStoryStartHandler_ = nil
	self.playExtraStoryOverHander_ = nil

	OsirisRecallRemasterdView.super.Dispose(self)
end

function OsirisRecallRemasterdView:PlayExtraStoryStart()
	self.cachePosition_ = self.list:GetScrolledPosition()
end

function OsirisRecallRemasterdView:PlayExtraStoryOver()
	self.list:StartScrollByPosition(#self.data, self.cachePosition_ or Vector3.one)
end

return OsirisRecallRemasterdView
