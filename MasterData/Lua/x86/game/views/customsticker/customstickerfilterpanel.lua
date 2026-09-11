local CustomStickerFilterPanel = class("CustomStickerFilterPanel", ReduxView)

function CustomStickerFilterPanel:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CustomStickerFilterPanel:Init()
	self:InitUI()
	self:AddUIListener()
end

function CustomStickerFilterPanel:InitUI()
	self:BindCfgUI()

	self.contentItemMap_ = {}
	self.bottomItemMap_ = {}
	self.filterCallBack_ = nil
	self.allFilterList_ = {}
	self.tmpSelectMap_ = {}
	self.curSelectMap_ = {}
end

function CustomStickerFilterPanel:AddUIListener()
	self:AddBtnListener(self.okBtn_, nil, function()
		local var_5_0 = true

		self.curSelectMap_ = {}

		for iter_5_0, iter_5_1 in pairs(self.tmpSelectMap_) do
			self.curSelectMap_[iter_5_0] = iter_5_1
			var_5_0 = false
		end

		if self.filterCallBack_ then
			self.filterCallBack_(self.curSelectMap_, var_5_0)
		end

		self:ClosePanel()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		for iter_6_0, iter_6_1 in pairs(self.tmpSelectMap_) do
			if self.contentItemMap_[iter_6_0] then
				self.contentItemMap_[iter_6_0]:Select(false)
			end

			if self.bottomItemMap_[iter_6_0] then
				SetActive(self.bottomItemMap_[iter_6_0], false)
			end
		end

		self.tmpSelectMap_ = {}

		self:ClosePanel()
	end)
	self:AddBtnListener(self.clearAllBtn_, nil, function()
		for iter_7_0, iter_7_1 in pairs(self.tmpSelectMap_) do
			if self.contentItemMap_[iter_7_0] then
				self.contentItemMap_[iter_7_0]:Select(false)
			end

			if self.bottomItemMap_[iter_7_0] then
				SetActive(self.bottomItemMap_[iter_7_0], false)
			end
		end

		self.tmpSelectMap_ = {}

		self:UpdateBottomRootGoActive()
	end)
end

function CustomStickerFilterPanel:SetData(arg_8_1, arg_8_2)
	self.filterCallBack_ = arg_8_2
	self.allFilterList_ = arg_8_1
	self.tmpSelectMap_ = {}
	self.curSelectMap_ = {}

	self:UpdateBottomRootGoActive()

	for iter_8_0 = 1, #self.allFilterList_ do
		local var_8_0 = self.allFilterList_[iter_8_0]

		self.bottomItemMap_[self.allFilterList_[iter_8_0]] = self.bottomItemMap_[self.allFilterList_[iter_8_0]] or Object.Instantiate(self.bottomTmpGo_, self.bottomTrs_)
		self.bottomItemMap_[self.allFilterList_[iter_8_0]].transform:Find("name"):GetComponent("Text").text = GetI18NText(StickerSuitCfg[self.allFilterList_[iter_8_0]].name)

		SetActive(self.bottomItemMap_[self.allFilterList_[iter_8_0]], false)

		if not self.contentItemMap_[self.allFilterList_[iter_8_0]] then
			local var_8_1 = Object.Instantiate(self.contentTmpGo_, self.contentTrs_)

			SetActive(var_8_1, true)

			self.contentItemMap_[self.allFilterList_[iter_8_0]] = CustomStickerFilterSuitItem.New(var_8_1)
		end

		self.contentItemMap_[self.allFilterList_[iter_8_0]]:SetData(self.allFilterList_[iter_8_0], function()
			if self.tmpSelectMap_[var_8_0] then
				self.tmpSelectMap_[var_8_0] = nil

				self.contentItemMap_[var_8_0]:Select(false)
				SetActive(self.bottomItemMap_[var_8_0], false)
			else
				self.tmpSelectMap_[var_8_0] = true

				self.contentItemMap_[var_8_0]:Select(true)
				SetActive(self.bottomItemMap_[var_8_0], true)
			end

			self:UpdateBottomRootGoActive()
		end)
		self.contentItemMap_[self.allFilterList_[iter_8_0]]:Select(false)
	end
end

function CustomStickerFilterPanel:OpenPanel()
	self.tmpSelectMap_ = {}

	for iter_10_0, iter_10_1 in pairs(self.curSelectMap_) do
		self.tmpSelectMap_[iter_10_0] = iter_10_1

		if self.contentItemMap_[iter_10_0] then
			self.contentItemMap_[iter_10_0]:Select(true)
		end

		if self.bottomItemMap_[iter_10_0] then
			SetActive(self.bottomItemMap_[iter_10_0], true)
		end
	end

	self:UpdateBottomRootGoActive()
	SetActive(self.gameObject_, true)
	manager.windowBar:HideBar()
end

function CustomStickerFilterPanel:ClosePanel()
	SetActive(self.gameObject_, false)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function CustomStickerFilterPanel:UpdateBottomRootGoActive()
	local var_12_0 = false

	for iter_12_0, iter_12_1 in pairs(self.tmpSelectMap_) do
		var_12_0 = true
	end

	SetActive(self.bottomRootGo_, var_12_0)
end

function CustomStickerFilterPanel:Dispose()
	CustomStickerFilterPanel.super.Dispose(self)

	for iter_13_0, iter_13_1 in pairs(self.contentItemMap_) do
		iter_13_1:Dispose()
	end

	for iter_13_2, iter_13_3 in pairs(self.bottomItemMap_) do
		Object.Destroy(iter_13_3)
	end
end

return CustomStickerFilterPanel
