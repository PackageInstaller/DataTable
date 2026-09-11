local TagView = class("TagView", ReduxView)

function TagView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function TagView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function TagView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, TagViewPanel)
	self.tagSpace_ = self.tagPanelTemplate_:GetComponent("HorizontalLayoutGroup").spacing
	self.width_ = self.panel_.rect.width
	self.tagTemplateItem_ = TagItem.New(self.tagTemplate_)
end

function TagView:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:RegisterClickFunction(function(arg_5_0)
		PlayerData:ClearTargetTagRed(arg_5_0)

		if self.usingList_[arg_5_0] then
			self.usingList_[arg_5_0] = nil
			self.useTotal_ = self.useTotal_ - 1

			arg_4_2:RefreshSelect(self.usingList_)
		elseif self.useTotal_ >= GameSetting.profile_label_max_num.value[1] then
			ShowTips("PROFILE_LABEL_MAX_NUM")

			return
		else
			self.usingList_[arg_5_0] = true
			self.useTotal_ = self.useTotal_ + 1

			arg_4_2:RefreshSelect(self.usingList_)
		end

		self:RefreshText()

		if self.callback_ then
			local var_5_0 = {}

			for iter_5_0, iter_5_1 in pairs(self.usingList_) do
				table.insert(var_5_0, iter_5_0)
			end

			table.sort(var_5_0, function(arg_6_0, arg_6_1)
				if ProfileLabelCfg[arg_6_0].type ~= ProfileLabelCfg[arg_6_1].type then
					return ProfileLabelCfg[arg_6_0].type > ProfileLabelCfg[arg_6_1].type
				end

				local var_6_1 = PlayerData:GetTagInfo(arg_6_0)
				local var_6_2 = PlayerData:GetTagInfo(arg_6_1)

				if var_6_1.obtain_time ~= var_6_2.obtain_time then
					return var_6_1.obtain_time < var_6_2.obtain_time
				end

				return arg_6_0 < arg_6_1
			end)
			self.callback_(var_5_0)
		end
	end)
	arg_4_2:RefreshData(self.panelList_[arg_4_1])
	arg_4_2:RefreshSelect(self.usingList_)
end

function TagView:AddUIListeners()
	return
end

function TagView:OnEnter()
	return
end

function TagView:RefreshUI()
	self:RefreshData()
	self:RefreshList()
	self:RefreshText()
end

function TagView:RefreshData()
	self.usingList_ = {}
	self.list_ = PlayerData:GetUnlockTagListInfo()

	local var_10_0 = PlayerData:GetUsingTagListInfo()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		self.usingList_[iter_10_1] = true
	end

	self.useTotal_ = #var_10_0
end

function TagView:RefreshList()
	local var_11_0 = 0
	local var_11_1 = 1

	self.panelList_ = {}

	for iter_11_0, iter_11_1 in ipairs(self.list_) do
		self.panelList_[var_11_1] = self.panelList_[var_11_1] or {}

		self.tagTemplateItem_:SetData(iter_11_1)

		local var_11_2 = self.tagTemplateItem_.transform_.rect.width

		var_11_0 = var_11_0 == 0 and var_11_2 or var_11_0 + var_11_2 + self.tagSpace_

		if var_11_0 < self.width_ then
			table.insert(self.panelList_[var_11_1], iter_11_1)
		else
			var_11_1 = var_11_1 + 1
			self.panelList_[var_11_1] = self.panelList_[var_11_1] or {}

			table.insert(self.panelList_[var_11_1], iter_11_1)

			var_11_0 = var_11_2
		end
	end

	self.scrollHelper_:StartScroll(#self.panelList_)
end

function TagView:RefreshText()
	self.num_.text = string.format(GetTips("PROFILE_LABEL_SELECTIONAL_RESTRICTION"), self.useTotal_, GameSetting.profile_label_max_num.value[1])
end

function TagView:Show(arg_13_1)
	SetActive(self.gameObject_, arg_13_1)
end

function TagView:RegisterClickFunction(arg_14_1)
	self.callback_ = arg_14_1
end

function TagView:OnExit()
	self.tagTemplateItem_:OnExit()

	for iter_15_0, iter_15_1 in ipairs(self.scrollHelper_:GetItemList()) do
		iter_15_1:OnExit()
	end
end

function TagView:Dispose()
	self:RemoveAllEventListener()
	self.tagTemplateItem_:Dispose()

	for iter_16_0, iter_16_1 in ipairs(self.scrollHelper_:GetItemList()) do
		iter_16_1:Dispose()
	end

	self.scrollHelper_:Dispose()
	TagView.super.Dispose(self)
end

return TagView
