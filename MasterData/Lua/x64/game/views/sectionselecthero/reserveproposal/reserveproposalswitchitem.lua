local ReserveProposalSwitchItem = class("ReserveProposalSwitchItem", ReduxView)

function ReserveProposalSwitchItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ReserveProposalSwitchItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ReserveProposalSwitchItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.controllerExCollection_:GetController("select")
	self.tempController_ = self.controllerExCollection_:GetController("temp")
	self.headItemList_ = {}

	for iter_3_0 = 1, 3 do
		self.headItemList_[iter_3_0] = SectionSmallHeroItem.New(self.headContentTrans_:GetChild(iter_3_0 - 1).gameObject)
	end

	self.tagItemList_ = {}

	for iter_3_1 = 1, self.tagContentTrans_.childCount do
		self.tagItemList_[iter_3_1] = ReserveProposalAttributeTagItem.New(self.tagContentTrans_:GetChild(iter_3_1 - 1).gameObject)
	end
end

function ReserveProposalSwitchItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		manager.notify:CallUpdateFunc(RESERVE_PROPOSAL_CLICK_PROPOSAL, self.contID_)
	end)
	self:AddBtnListener(self.renameBtn_, nil, function()
		manager.notify:CallUpdateFunc(RESERVE_PROPOSAL_CLICK_RENAME, self.contID_)
	end)
end

function ReserveProposalSwitchItem:Dispose()
	for iter_7_0, iter_7_1 in ipairs(self.headItemList_) do
		iter_7_1:Dispose()
	end

	self.headItemList_ = nil

	for iter_7_2, iter_7_3 in ipairs(self.tagItemList_) do
		iter_7_3:Dispose()
	end

	self.tagItemList_ = nil

	ReserveProposalSwitchItem.super.Dispose(self)
end

function ReserveProposalSwitchItem:SetProxy(arg_8_1)
	self.sectionProxy_ = arg_8_1
end

function ReserveProposalSwitchItem:SetData(arg_9_1)
	self.reserveParams_ = self.reserveParams_ or ReserveParams.New(ReserveConst.RESERVE_TYPE.PROPOSAL, arg_9_1)
	self.reserveParams_.contID = arg_9_1
	self.contID_ = arg_9_1
	self.reserveTemplate_ = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.PROPOSAL)
	self.contData_ = self.reserveTemplate_:GetContDataTemplateById(self.contID_)

	self:RefreshUI()
end

function ReserveProposalSwitchItem:RefreshUI()
	self:RefreshName()
	self:RefreshHeroItemList()
	self:RefreshTagItemList()
end

function ReserveProposalSwitchItem:RefreshName()
	local var_11_0 = self.contData_:GetIsTemp()

	self.tempController_:SetSelectedState(tostring(var_11_0))

	if not var_11_0 then
		self.nameText_.text = self.contData_:GetName()
	end
end

function ReserveProposalSwitchItem:RefreshHeroItemList()
	local var_12_0 = self.sectionProxy_:GetOuterLockHeroList()

	self.heroDataList_ = self.contData_:GetHeroList()

	for iter_12_0, iter_12_1 in ipairs(self.heroDataList_) do
		local var_12_1 = iter_12_1:GetHeroID()

		self.headItemList_[iter_12_0]:SetData(var_12_1)
		self.headItemList_[iter_12_0]:RefreshLock(table.indexof(var_12_0, var_12_1) ~= false)
	end
end

function ReserveProposalSwitchItem:RefreshTagItemList()
	local var_13_0 = self.reserveTemplate_:GetAttributeTagList(self.contID_)

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		self.tagItemList_[iter_13_0]:SetData(iter_13_1)
		self.tagItemList_[iter_13_0]:Show(true)
	end

	for iter_13_2 = #var_13_0 + 1, #self.tagItemList_ do
		self.tagItemList_[iter_13_2]:Show(false)
	end
end

function ReserveProposalSwitchItem:SetSelect(arg_14_1)
	self.selectController_:SetSelectedState(tostring(self.contID_ == arg_14_1))

	for iter_14_0, iter_14_1 in ipairs(self.tagItemList_) do
		iter_14_1:SetColor(self.contID_ == arg_14_1)
	end
end

return ReserveProposalSwitchItem
