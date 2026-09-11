local MomoTalkSettingItem = import("game.views.momoTalk.momotalkItem.MomoTalkSettingItem")
local MomoTalkPlayerSettingView = class("MomoTalkPlayerSettingView", ReduxView)

function MomoTalkPlayerSettingView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()
	self:InitList()
end

function MomoTalkPlayerSettingView:InitList()
	self.selectedHeadID_ = MomoTalkData.icon
	self.selectedBubleID_ = PlayerData:GetCurChatBubbleID()
	self.dataList_ = {}

	if self.listGo_ then
		self.luaList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, MomoTalkSettingItem)
	end

	self.previewItem_ = MomoTalkSettingItem.New(self.previewItemGo_)
end

function MomoTalkPlayerSettingView:AddListeners()
	if self.closeBtn_ then
		self:AddBtnListener(self.closeBtn_, nil, function()
			manager.notify:Invoke(MOMOTALK_BACK_FROM_SETTING)
		end)
	end

	if self.headTabBtn_ then
		self:AddBtnListener(self.headTabBtn_, nil, function()
			self:SwitchTab("head")
		end)
	end

	if self.bubleTabBtn_ then
		self:AddBtnListener(self.bubleTabBtn_, nil, function()
			self:SwitchTab("bubble")
		end)
	end

	if self.useBtn_ then
		self:AddBtnListener(self.useBtn_, nil, function()
			self:UseSelectedItem()
		end)
	end

	if self.tabControllerEx_ then
		self.tabConroller_ = self.tabControllerEx_:GetController("selectState")
	end

	if self.btnControllerEx_ then
		self.btnController_ = self.btnControllerEx_:GetController("btnState")
	end
end

function MomoTalkPlayerSettingView:OnEnter()
	self.selectedHeadID_ = MomoTalkData.icon
	self.selectedBubleID_ = PlayerData:GetCurChatBubbleID()

	self:SwitchTab("head")
end

function MomoTalkPlayerSettingView:OnExit()
	return
end

function MomoTalkPlayerSettingView:SwitchTab(arg_10_1)
	self.currentTab_ = arg_10_1

	if self.tabConroller_ then
		self.tabConroller_:SetSelectedState(arg_10_1 == "head" and "head" or "bubble")
	end

	self:RefreshList()
end

function MomoTalkPlayerSettingView:RefreshList()
	self.dataList_ = self.currentTab_ == "head" and self:GetHeadList() or self:GetBubleList()

	self:EnsureSelectedID()

	if self.luaList_ then
		self.luaList_:StartScroll(#self.dataList_)
	end

	self:RefreshPreview()
	self:RefreshUseState()
end

function MomoTalkPlayerSettingView:GetHeadList()
	local var_12_0 = MomoTalkTools.GetHeadData()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		iter_12_1.type = "head"
	end

	return var_12_0
end

function MomoTalkPlayerSettingView:GetBubleList()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(AvatarTools.GetChatBubbleList() or {}) do
		table.insert(var_13_0, iter_13_1)
	end

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0 and PlayerData:GetChatBubble(arg_14_0.id)
		local var_14_1 = arg_14_1 and PlayerData:GetChatBubble(arg_14_1.id)
		local var_14_2 = var_14_0 and var_14_0.unlock == 1
		local var_14_3 = var_14_1 and var_14_1.unlock == 1

		if var_14_0 and var_14_0.unlock == 1 and var_14_3 then
			return arg_14_0.id < arg_14_1.id
		elseif var_14_2 then
			return true
		elseif var_14_3 then
			return false
		else
			return arg_14_0.id < arg_14_1.id
		end
	end)

	local var_13_1 = {}

	for iter_13_2, iter_13_3 in ipairs(var_13_0) do
		local var_13_2 = PlayerData:GetChatBubble(iter_13_3.id)
		local var_13_3 = {
			type = "bubble",
			id = iter_13_3.id
		}

		if var_13_2 then
			var_13_3.state = var_13_2.unlock or 0
		end

		if var_13_2 then
			var_13_3.lasted_time = var_13_2.lasted_time or 0
		end

		table.insert(var_13_1, var_13_3)
	end

	return var_13_1
end

function MomoTalkPlayerSettingView:EnsureSelectedID()
	if self.currentTab_ == "head" then
		if self:GetDataByID(self.selectedHeadID_ or self.selectedBubleID_) then
			return
		end
	end

	local var_15_1 = self.dataList_ and self.dataList_[1]

	if not var_15_1 then
		return
	end

	if self.currentTab_ == "head" then
		self.selectedHeadID_ = var_15_1.id
	else
		self.selectedBubleID_ = var_15_1.id
	end
end

function MomoTalkPlayerSettingView:IndexItem(arg_16_1, arg_16_2)
	local var_16_0 = self.dataList_[arg_16_1]

	if not self.dataList_[arg_16_1] then
		return
	end

	local var_16_1

	if var_16_0.type == "head" then
		var_16_1 = self.selectedHeadID_ or self.selectedBubleID_

		local var_16_2

		if var_16_0.type == "head" then
			var_16_2 = MomoTalkData.icon or PlayerData:GetCurChatBubbleID()
		end
	end

	arg_16_2:SetData(var_16_0, var_16_0.id == var_16_1, var_16_0.id == var_16_2, function(arg_17_0)
		self:OnSelectItem(arg_17_0)
	end)
end

function MomoTalkPlayerSettingView:OnSelectItem(arg_18_1)
	local var_18_0 = self:GetDataByID(arg_18_1)

	if not var_18_0 then
		return
	end

	if var_18_0.type ~= "head" and var_18_0.state ~= 1 then
		if JumpTools.ShowItemSource then
			JumpTools.ShowItemSource(arg_18_1)
		end

		return
	end

	if self.currentTab_ == "head" then
		self.selectedHeadID_ = arg_18_1
	else
		self.selectedBubleID_ = arg_18_1
	end

	self:RefreshVisibleItems()
	self:RefreshPreview()
	self:RefreshUseState()
end

function MomoTalkPlayerSettingView:GetDataByID(arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(self.dataList_ or {}) do
		if iter_19_1.id == arg_19_1 then
			return iter_19_1
		end
	end
end

function MomoTalkPlayerSettingView:RefreshVisibleItems()
	if self.luaList_ then
		self.luaList_:Refresh()
	end
end

function MomoTalkPlayerSettingView:RefreshUseState()
	if not self.btnController_ then
		return
	end

	local var_21_0

	if self.currentTab_ == "head" then
		var_21_0 = self.selectedHeadID_ or self.selectedBubleID_

		local var_21_1

		if self.currentTab_ == "head" then
			var_21_1 = MomoTalkData.icon or PlayerData:GetCurChatBubbleID()
		end
	end

	local var_21_2 = self:GetDataByID(var_21_0)

	if not var_21_2 or var_21_2.state ~= 1 then
		self.btnController_:SetSelectedState("grey")
	elseif var_21_0 == var_21_1 then
		self.btnController_:SetSelectedState("used")
	else
		self.btnController_:SetSelectedState("use")
	end
end

function MomoTalkPlayerSettingView:RefreshPreview()
	if not self.previewItem_ then
		return
	end

	local var_22_0 = self:GetDataByID((self.currentTab_ == "head" or nil) and (self.selectedHeadID_ or self.selectedBubleID_))

	if var_22_0 then
		self.previewItem_:SetData(var_22_0, false, var_22_0.id == ((self.currentTab_ == "head" or nil) and (MomoTalkData.icon or PlayerData:GetCurChatBubbleID())))
	end

	if self.nameTxt_ then
		local var_22_1 = ""

		if var_22_0 then
			if var_22_0.type == "head" then
				local var_22_2 = var_22_0.cfg or ChatMonoAvatarCfg[var_22_0.id]

				if var_22_2 then
					if not GetI18NText(var_22_2.name or "") then
						::label_22_0::

						var_22_1 = ""
					end
				end
			elseif ItemCfg[var_22_0.id] then
				if not GetI18NText(ItemCfg[var_22_0.id].name or "") then
					::label_22_1::

					var_22_1 = ""
				end
			end
		end

		self.nameTxt_.text = var_22_1
	end
end

function MomoTalkPlayerSettingView:UseSelectedItem()
	local var_23_0

	if self.currentTab_ == "head" then
		var_23_0 = self.selectedHeadID_ or self.selectedBubleID_
	end

	local var_23_1 = self:GetDataByID(var_23_0)

	if not var_23_1 or var_23_1.state ~= 1 then
		return
	end

	if self.currentTab_ == "head" then
		if var_23_0 == MomoTalkData.icon then
			return
		end

		MomoTalkAction.SetMomoFrame(var_23_0, function()
			MomoTalkData.icon = var_23_0

			manager.notify:Invoke(MOMOTALK_REFRESH_PLAYER_ICON)
			self:RefreshVisibleItems()
			self:RefreshPreview()
			self:RefreshUseState()
		end)
	else
		if var_23_0 == PlayerData:GetCurChatBubbleID() then
			return
		end

		PlayerAction.ChangeChatBubble(var_23_0, function()
			self:RefreshVisibleItems()
			self:RefreshPreview()
			self:RefreshUseState()
		end)
	end
end

function MomoTalkPlayerSettingView:Dispose()
	if self.previewItem_ then
		self.previewItem_:Dispose()

		self.previewItem_ = nil
	end

	if self.luaList_ then
		self.luaList_:Dispose()

		self.luaList_ = nil
	end

	MomoTalkPlayerSettingView.super.Dispose(self)
end

return MomoTalkPlayerSettingView
