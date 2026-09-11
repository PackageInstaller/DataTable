local GuildActivitySPRecordView = class("GuildActivitySPRecordView", ReduxView)

function GuildActivitySPRecordView:UIName()
	return "UI/GuildActivitySPUI/GuildActivitySPRecordUI"
end

function GuildActivitySPRecordView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildActivitySPRecordView:OnCtor()
	return
end

function GuildActivitySPRecordView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySPRecordView:InitUI()
	self:BindCfgUI()

	self.recordList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, GuildActivitySPRecordItemView)
end

function GuildActivitySPRecordView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.dataList_[arg_6_1])
end

function GuildActivitySPRecordView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function GuildActivitySPRecordView:AddEventListeners()
	return
end

function GuildActivitySPRecordView:OnTop()
	self:UpdateBar()
end

function GuildActivitySPRecordView:OnBehind()
	return
end

function GuildActivitySPRecordView:UpdateBar()
	return
end

function GuildActivitySPRecordView:OnEnter()
	self:AddEventListeners()

	self.dataList_ = self.params_.dataList

	self.recordList_:StartScroll(#self.dataList_)
end

function GuildActivitySPRecordView:OnExit()
	self:RemoveAllEventListener()
end

function GuildActivitySPRecordView:OnMainHomeViewTop()
	return
end

function GuildActivitySPRecordView:Dispose()
	if self.recordList_ then
		self.recordList_:Dispose()

		self.recordList_ = nil
	end

	GuildActivitySPRecordView.super.Dispose(self)
end

return GuildActivitySPRecordView
