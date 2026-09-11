local PushBoxReplayItem = class("PushBoxReplayItem", ReduxView)

function PushBoxReplayItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function PushBoxReplayItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function PushBoxReplayItem:InitUI()
	self:BindCfgUI()
end

function PushBoxReplayItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("/pushBox", {
			map_id = self.cfg_.param,
			activityID = self.cfg_.main_activity,
			id = self.id_
		})
	end)
end

function PushBoxReplayItem:OnEnter()
	return
end

function PushBoxReplayItem:RefreshData(arg_7_1)
	self.id_ = arg_7_1
	self.cfg_ = ActivityCelebrationOrderCfg[self.id_]
	self.title_.text = self.cfg_.order_title
end

function PushBoxReplayItem:OnExit()
	return
end

function PushBoxReplayItem:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return PushBoxReplayItem
