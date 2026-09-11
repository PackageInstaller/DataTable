local GuildActivityRecordView = class("GuildActivityRecordView", ReduxView)

function GuildActivityRecordView:UIName()
	return "UI/GuildActivityUI/GuildActivityRecordUI"
end

function GuildActivityRecordView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildActivityRecordView:OnCtor()
	return
end

function GuildActivityRecordView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivityRecordView:InitUI()
	self:BindCfgUI()

	self.recordList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, GuildActivityRecordItemView)
end

function GuildActivityRecordView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.dataList_[arg_6_1])
end

function GuildActivityRecordView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function GuildActivityRecordView:AddEventListeners()
	return
end

function GuildActivityRecordView:OnTop()
	self:UpdateBar()
end

function GuildActivityRecordView:OnBehind()
	return
end

function GuildActivityRecordView:UpdateBar()
	return
end

function GuildActivityRecordView:OnEnter()
	self:AddEventListeners()

	self.dataList_ = self.params_.dataList

	self.recordList_:StartScroll(#self.dataList_)
end

function GuildActivityRecordView:OnExit()
	self:RemoveAllEventListener()
end

function GuildActivityRecordView:OnMainHomeViewTop()
	return
end

function GuildActivityRecordView:Dispose()
	if self.recordList_ then
		self.recordList_:Dispose()

		self.recordList_ = nil
	end

	GuildActivityRecordView.super.Dispose(self)
end

return GuildActivityRecordView
