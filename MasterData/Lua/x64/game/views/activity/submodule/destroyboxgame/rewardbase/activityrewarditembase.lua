local ActivityRewardItemBase = class("ActivityRewardItemBase", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))

function ActivityRewardItemBase:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function ActivityRewardItemBase:Dispose()
	ActivityRewardItemBase.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ActivityRewardItemBase:AddListeners()
	return
end

function ActivityRewardItemBase:SetData(arg_4_1, arg_4_2)
	self:Show(true)

	self.index_ = arg_4_2
end

function ActivityRewardItemBase:Update()
	return
end

return ActivityRewardItemBase
