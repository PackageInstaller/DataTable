local DrawRecordItem = class("DrawRecordItem", ReduxView)

function DrawRecordItem:OnCtor(arg_2_1)
	self.gameObject_ = arg_2_1
	self.transform_ = arg_2_1.transform

	self:Init()
end

function DrawRecordItem:Init()
	self:BindCfgUI()

	self.colorCon_ = ControllerUtil.GetController(self.gameObject_.transform, "conName")
end

function DrawRecordItem:SetItemColor(arg_4_1, arg_4_2)
	if arg_4_1 == ItemConst.ITEM_TYPE.HERO then
		self.colorCon_:SetSelectedState(tostring(arg_4_2))
	elseif arg_4_1 == ItemConst.ITEM_TYPE.WEAPON_SERVANT and arg_4_2 >= 4 then
		self.colorCon_:SetSelectedState(tostring(arg_4_2))
	else
		self.colorCon_:SetSelectedState("white")
	end
end

function DrawRecordItem:RefreshUI(arg_5_1, arg_5_2)
	self.num_label.text = manager.time:STimeDescS(arg_5_1.draw_timestamp, "!%Y/%m/%d %H:%M")
	self.name_label.text = GetI18NText((ItemTools.getItemName(arg_5_1.item.id)))
	self.type_label.text = string.format("[%s]", GetTips(ItemConst.ITEM_TYPE_NAME[ItemCfg[arg_5_1.item.id].type]))

	self:SetItemColor(ItemCfg[arg_5_1.item.id].type, ItemCfg[arg_5_1.item.id].display_rare)
end

local TreasureRecordView = class("TreasureRecordView", ReduxView)

function TreasureRecordView:UIName()
	return "Widget/System/Pool/PoolRecordPopUI"
end

function TreasureRecordView:UIParent()
	return manager.ui.uiPop.transform
end

function TreasureRecordView:Init()
	self:InitUI()
	self:AddListeners()

	self.pageNum_ = 1
end

function TreasureRecordView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.scrollviewGo_, DrawRecordItem)
end

function TreasureRecordView:AddListeners()
	self:AddBtnListener(self.bgmask_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.buttonClose_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		if self.pageNum_ * 10 + 1 <= #self.record_list then
			self.pageNum_ = self.pageNum_ + 1
			self.pagenumText_.text = self.pageNum_

			self:UpdateData(self.pageNum_)
			self.scrollHelper_:StartScroll(#self.itemList_)
		end
	end)
	self:AddBtnListener(self.leftBtn_, nil, function()
		if self.pageNum_ > 1 then
			self.pageNum_ = self.pageNum_ - 1
			self.pagenumText_.text = self.pageNum_

			self:UpdateData(self.pageNum_)
			self.scrollHelper_:StartScroll(#self.itemList_)
		end
	end)
end

function TreasureRecordView:OnEnter()
	local var_15_0 = DrawData:GetDrawRecord(self.params_.poolId)

	self.pageNum_ = 1

	if var_15_0 then
		self.times = var_15_0.ssr_draw_times
		self.record_list = var_15_0.draw_record_list

		self:RefreshUI()
	else
		DrawAction.RequestRecord(self.params_.poolId)
	end
end

function TreasureRecordView:OnRequestRecord(arg_16_1, arg_16_2)
	local var_16_0 = DrawData:GetDrawRecord(arg_16_2.id)

	if var_16_0 then
		self.times = var_16_0.ssr_draw_times
		self.record_list = var_16_0.draw_record_list or {}

		self:RefreshUI()
	end
end

function TreasureRecordView:RefreshUI()
	self.pagenumText_.text = self.pageNum_

	self:UpdateData(self.pageNum_)
	self.scrollHelper_:StartScroll(#self.itemList_)
end

function TreasureRecordView:UpdateData(arg_18_1)
	self.itemList_ = {}

	for iter_18_0 = (arg_18_1 - 1) * 10 + 1, math.min(arg_18_1 * 10, #self.record_list) do
		table.insert(self.itemList_, self.record_list[iter_18_0])
	end
end

function TreasureRecordView:indexItem(arg_19_1, arg_19_2)
	arg_19_2:RefreshUI(self.itemList_[arg_19_1], self.params_.poolId)
end

function TreasureRecordView:Dispose()
	self.scrollHelper_:Dispose()
	TreasureRecordView.super.Dispose(self)
end

return TreasureRecordView
