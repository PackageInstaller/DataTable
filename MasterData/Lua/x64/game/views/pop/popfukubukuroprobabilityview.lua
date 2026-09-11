local PopFukubukuroProbabilityView = class("PopFukubukuroProbabilityView", ReduxView)

function PopFukubukuroProbabilityView:UIName()
	return "Widget/System/Recharge/FukubukuroProbabilityPopUI"
end

function PopFukubukuroProbabilityView:UIParent()
	return manager.ui.uiPop.transform
end

function PopFukubukuroProbabilityView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PopFukubukuroProbabilityView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, PopFukubukuroProbabilityItem)
end

function PopFukubukuroProbabilityView:AddUIListener()
	self:AddBtnListener(nil, self.m_mask, function()
		self:Back()
	end)
end

function PopFukubukuroProbabilityView:OnTop()
	return
end

function PopFukubukuroProbabilityView:OnEnter()
	self.itemId = self.params_.itemId

	if ItemCfg[self.itemId] and ItemConst.ITEM_SUB_TYPE.FUKUBUKURO == ItemCfg[self.itemId].sub_type then
		self.probabilitys = ItemCfg[self.itemId].param
		self.weight = 0

		for iter_8_0, iter_8_1 in ipairs(self.probabilitys) do
			self.weight = self.weight + iter_8_1[3]
		end

		self.list:StartScroll(#self.probabilitys)
	else
		self.list:StartScroll(0)
	end
end

function PopFukubukuroProbabilityView:OnExit()
	return
end

function PopFukubukuroProbabilityView:Dispose()
	self.list:Dispose()
	PopFukubukuroProbabilityView.super.Dispose(self)
end

function PopFukubukuroProbabilityView:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(self.probabilitys[arg_11_1], self.probabilitys, self.weight)
end

return PopFukubukuroProbabilityView
