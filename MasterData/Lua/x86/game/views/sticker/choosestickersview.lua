local ChooseStickersView = class("ChooseStickersView", ReduxView)

function ChooseStickersView:UIName()
	return "Widget/System/UserInfor/paster/ChooseStickersUI_New"
end

function ChooseStickersView:UIParent()
	return manager.ui.uiPop.transform
end

function ChooseStickersView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ChooseStickersView:InitUI()
	self:BindCfgUI()

	self.icon_ = {
		self.img_1,
		self.img_2,
		self.img_3
	}
	self.sizeTgl_ = {
		self.toggle_1,
		self.toggle_2,
		self.toggle_3
	}
	self.sizeCon_ = {
		ControllerUtil.GetController(self.rect_s, "state"),
		ControllerUtil.GetController(self.rect_m, "state"),
		(ControllerUtil.GetController(self.rect_l, "state"))
	}
	self.lockCon_ = ControllerUtil.GetController(self.gameObject_.transform, "lock")
	self.scrollList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, StickerChooseItem)
end

function ChooseStickersView:IndexItem(arg_5_1, arg_5_2)
	local var_5_0 = self.allStickerList_[arg_5_1].id

	arg_5_2:RefreshItem(self.allStickerList_[arg_5_1].id)
	arg_5_2:SetUsed((self:IsUsed(self.allStickerList_[arg_5_1].id)))
	arg_5_2:SetSelected(var_5_0 == self.curID_)
	arg_5_2:RegisterClickListener(function()
		self:SetCurID(arg_5_2.itemID_)
		self:RefreshList()
	end)
end

function ChooseStickersView:AddUIListeners()
	for iter_7_0, iter_7_1 in ipairs(self.sizeTgl_) do
		self:AddBtnListener(iter_7_1, nil, function()
			self.curSize_ = iter_7_0

			self:RefreshIcon()
			self:RefreshBtn()
			self:RefreshSize()

			if self.curID_ == self.oldStickerID_ then
				manager.notify:CallUpdateFunc(CHANGE_STICKER_SIZE, self.curIndex_, self.curID_, self.curSize_)
				self:Back()
			end
		end)
	end

	self:AddBtnListener(self.useBtn_, nil, function()
		if self.curID_ == self.oldStickerID_ and self.curSize_ == self.info_.size then
			self.curID_ = 0
		end

		manager.notify:CallUpdateFunc(CHANGE_STICKER, self.curIndex_, self.curID_, self.curSize_)
		self:Back()
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function ChooseStickersView:OnEnter()
	self.allStickerList_ = {}
	self.info_ = self.params_.info
	self.curSize_ = self.info_.size
	self.curList_ = self:GetCurList()
	self.viewID_ = self.params_.viewID
	self.curIndex_ = self.params_.site
	self.oldStickerID_ = self.info_.stickerID
	self.curID_ = self.oldStickerID_

	self:GetAllSticker()

	if self.curID_ == 0 then
		self.curID_ = self.allStickerList_[1].id
	end

	self:RefreshUI()
	self.scrollList_:StartScroll(#self.allStickerList_)
end

function ChooseStickersView:GetCurList()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(self.params_.list) do
		table.insert(var_12_0, iter_12_1.stickerID)
	end

	return var_12_0
end

function ChooseStickersView:GetAllSticker()
	for iter_13_0, iter_13_1 in ipairs(PlayerData:GetStickerList()) do
		local var_13_0 = PlayerData:GetSticker(iter_13_1)

		if ItemCfg[iter_13_1].sub_type ~= 1302 or var_13_0.unlock ~= 0 then
			table.insert(self.allStickerList_, var_13_0)
		end
	end

	table.sort(self.allStickerList_, function(arg_14_0, arg_14_1)
		local var_14_0 = self:IsUsed(arg_14_0.id)
		local var_14_1 = self:IsUsed(arg_14_1.id)

		if var_14_0 and var_14_1 then
			return table.indexof(self.curList_, arg_14_0.id) < table.indexof(self.curList_, arg_14_1.id)
		elseif var_14_0 or var_14_1 then
			return var_14_0
		end

		if arg_14_0.unlock ~= arg_14_1.unlock then
			return arg_14_0.unlock > arg_14_1.unlock
		end

		return arg_14_0.id < arg_14_1.id
	end)
end

function ChooseStickersView:IsUsed(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(self.curList_) do
		if arg_15_1 == iter_15_1 then
			return true
		end
	end

	return false
end

function ChooseStickersView:RefreshUI()
	self:SetCurID(self.curID_)
	self:RefreshSize()
end

function ChooseStickersView:SetCurID(arg_17_1)
	self.curID_ = arg_17_1

	local var_17_0 = PlayerData:GetSticker(self.curID_)
	local var_17_1 = ItemCfg[self.curID_]

	self:RefreshIcon()
	self:RefreshBtn()
	self.lockCon_:SetSelectedState(var_17_0.unlock == 0 and "lock" or "default")

	self.nameTxt_.text = ItemTools.getItemName(var_17_1.id)
	self.descTxt_.text = ItemTools.getItemDesc(var_17_1.id)
	self.wayTxt_.text = GetI18NText(var_17_1.desc_source) or ""
end

function ChooseStickersView:RefreshBtn()
	self.btnTxt_.text = self.curID_ == self.oldStickerID_ and GetTips("CHIP_UNLOAD") or self:IsUsed(self.curID_) and GetTips("TIP_CHANGE") or GetTips("TIP_DISPLAY")
end

function ChooseStickersView:RefreshIcon()
	self.icon_[self.curSize_].sprite = ItemTools.getItemSprite(self.curID_, {
		size = self.curSize_
	})
end

function ChooseStickersView:RefreshList()
	for iter_20_0, iter_20_1 in pairs(self.scrollList_:GetItemList()) do
		iter_20_1:SetSelected(iter_20_1.itemID_ == self.curID_)
		iter_20_1:SetUsed(self:IsUsed(iter_20_1.itemID_))
	end
end

function ChooseStickersView:RefreshSize()
	for iter_21_0 = 1, 3 do
		if not table.indexof(StickViewTemplateCfg[self.viewID_].range_list[self.curIndex_][2], iter_21_0) then
			self.sizeCon_[iter_21_0]:SetSelectedState(2)
		elseif iter_21_0 == self.curSize_ then
			self.sizeCon_[iter_21_0]:SetSelectedState(3)
		else
			self.sizeCon_[iter_21_0]:SetSelectedState(1)
		end
	end
end

function ChooseStickersView:OnExit()
	return
end

function ChooseStickersView:Dispose()
	self:RemoveAllListeners()
	self.scrollList_:Dispose()
	ChooseStickersView.super.Dispose(self)
end

return ChooseStickersView
