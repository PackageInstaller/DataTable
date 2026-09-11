local TerminologyView = class("TerminologyView", ReduxView)

function TerminologyView:UIName()
	return "Widget/System/Terminology/TerminologyPopUI"
end

function TerminologyView:UIParent()
	return manager.ui.uiPop.transform
end

function TerminologyView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.items_ = {}
end

function TerminologyView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

local function var_0_1(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0) do
		if not table.indexof(var_6_0, iter_6_1) then
			table.insert(var_6_0, iter_6_1)
		end
	end

	return var_6_0
end

function TerminologyView:OnEnter()
	self.idList_ = var_0_1(self.params_.terminologyIdList)

	self:RefreshUI()
end

function TerminologyView:Dispose()
	for iter_8_0, iter_8_1 in ipairs(self.items_) do
		iter_8_1:Dispose()
	end

	TerminologyView.super.Dispose(self)
end

function TerminologyView:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.idList_[arg_9_1])
end

function TerminologyView:RefreshUI()
	local var_10_0 = #self.idList_

	for iter_10_0, iter_10_1 in ipairs(self.items_) do
		SetActive(iter_10_1.gameObject_, iter_10_0 <= var_10_0)
	end

	for iter_10_2 = 1, var_10_0 do
		local var_10_1 = self.items_[iter_10_2]

		if not self.items_[iter_10_2] then
			local var_10_2 = Object.Instantiate(self.templateGo_, self.contentTrans_)

			SetActive(var_10_2, true)

			var_10_1 = TerminologyItem.New(var_10_2)
			self.items_[iter_10_2] = var_10_1
		end

		self:IndexItem(iter_10_2, var_10_1)
	end
end

return TerminologyView
