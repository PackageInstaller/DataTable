local ActivityRewardTitleItem = class("ActivityRewardTitleItem", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))

function ActivityRewardTitleItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function ActivityRewardTitleItem:Dispose()
	ActivityRewardTitleItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ActivityRewardTitleItem:AddListeners()
	return
end

function ActivityRewardTitleItem:SetData(arg_4_1, arg_4_2)
	self:Show(true)

	self.nameText_.text = ActivityCfg[arg_4_1].remark
	self.index_ = arg_4_2
end

function ActivityRewardTitleItem:Update()
	return
end

return ActivityRewardTitleItem
