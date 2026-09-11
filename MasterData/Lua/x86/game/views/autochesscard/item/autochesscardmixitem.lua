local AutoChessCardMixItem = class("AutoChessCardMixItem", ReduxView)

function AutoChessCardMixItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.cardID_ = 0

	self:Init()
end

function AutoChessCardMixItem:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
end

function AutoChessCardMixItem:InitUI()
	self.mixBtnController_ = self.controller_:GetController("MixBtn")
	self.dropdownController_ = self.controller_:GetController("dropdown")
	self.btnController_ = self.controller_:GetController("btn")
	self.currentIconController_ = self.controller_:GetController("currentIcon")
	self.cardUiList_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, AutoChessCardMixSelectItem)

	self.dropdownController_:SetSelectedState("collapse")

	self.selectIndexList_ = {}
	self.URFactoryItem_ = AutoChessURFactoryItem.New(self.URItemGo_)
end

function AutoChessCardMixItem:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(self.sortCardIdList_[arg_4_1], not not self.selectIndexList_[arg_4_1], arg_4_1, self.URFactoryItem_:GetItem(self.sortCardIdList_[arg_4_1]))
	arg_4_2:SetSelectHandler(handler(self, self.OnSelectCard))
end

function AutoChessCardMixItem:AddListeners()
	self:AddBtnListener(self.rBtn_, nil, function()
		self.cardType_ = AutoChessCardConst.CARD_TYPE.R

		self.currentIconController_:SetSelectedIndex(self.cardType_ - 1)
		self.dropdownController_:SetSelectedState("collapse")
		self:RefreshUI()
	end)
	self:AddBtnListener(self.srBtn_, nil, function()
		self.cardType_ = AutoChessCardConst.CARD_TYPE.SR

		self.currentIconController_:SetSelectedIndex(self.cardType_ - 1)
		self.dropdownController_:SetSelectedState("collapse")
		self:RefreshUI()
	end)
	self:AddBtnListener(self.urBtn_, nil, function()
		self.cardType_ = AutoChessCardConst.CARD_TYPE.UR

		self.currentIconController_:SetSelectedIndex(self.cardType_ - 1)
		self.dropdownController_:SetSelectedState("collapse")
		self:RefreshUI()
	end)
	self:AddBtnListener(self.autoBtn_, nil, function()
		self.dropdownController_:SetSelectedState("collapse")

		local var_9_0, var_9_1, var_9_2 = AutoChessCardTools.GetMixCombinations(self.exp_1, self.exp_2, self.exp_5, (AutoChessCardTools.GetMixExpByCardType(self.cardID_)))

		for iter_9_0, iter_9_1 in ipairs(self.sortCardIdList_) do
			if AutoChessCardCfg[iter_9_1].type == AutoChessCardConst.CARD_TYPE.R and var_9_0 > 0 then
				self.selectIndexList_[iter_9_0] = iter_9_1
				var_9_0 = var_9_0 - 1
			elseif AutoChessCardCfg[iter_9_1].type == AutoChessCardConst.CARD_TYPE.SR and var_9_1 > 0 then
				self.selectIndexList_[iter_9_0] = iter_9_1
				var_9_1 = var_9_1 - 1
			elseif AutoChessCardCfg[iter_9_1].type == AutoChessCardConst.CARD_TYPE.UR and var_9_2 > 0 then
				self.selectIndexList_[iter_9_0] = iter_9_1
				var_9_2 = var_9_2 - 1
			end

			if var_9_0 == 0 and var_9_1 == 0 and var_9_2 == 0 then
				break
			end
		end

		self.cardUiList_:Refresh()
		self:RefreshExp()

		if #self.selectIndexList_ > 0 then
			self.btnController_:SetSelectedState("cleanSelect")
		else
			self.btnController_:SetSelectedState("autoInsert")
		end
	end)
	self:AddBtnListener(self.cleanBtn_, nil, function()
		self.dropdownController_:SetSelectedState("collapse")

		self.selectIndexList_ = {}

		self:RefreshUI()
		self.btnController_:SetSelectedState("autoInsert")
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		self.dropdownController_:SetSelectedState("collapse")

		local var_11_0 = AutoChessCardTools.GetMixExpByCardType(self.cardID_)
		local var_11_1 = {}

		for iter_11_0, iter_11_1 in pairs(self.selectIndexList_) do
			if iter_11_1 == nil then
				-- block empty
			else
				var_11_1[iter_11_1] = var_11_1[iter_11_1] == nil and 1 or var_11_1[iter_11_1] + 1
			end
		end

		local var_11_2 = {}

		for iter_11_2, iter_11_3 in pairs(var_11_1) do
			table.insert(var_11_2, {
				id = iter_11_2,
				num = iter_11_3
			})
		end

		AutoChessCardAction.MixCard(self.cardID_, var_11_2)
	end)
	self:AddBtnListener(self.selectBtn_, nil, function()
		if self.dropdownController_:GetSelectedState() == "expand" then
			self.dropdownController_:SetSelectedState("collapse")
		else
			self.dropdownController_:SetSelectedState("expand")
		end
	end)
	self:AddBtnListener(self.disabledBtn_, nil, function()
		self.dropdownController_:SetSelectedState("collapse")
	end)
end

function AutoChessCardMixItem:SetData(arg_14_1)
	self.cardID_ = arg_14_1
	self.cardType_ = AutoChessCardConst.CARD_TYPE.SR

	self.currentIconController_:SetSelectedIndex(self.cardType_ - 1)
	self.dropdownController_:SetSelectedState("collapse")
	self:RefreshUI()
end

function AutoChessCardMixItem:RefreshUI()
	self.selectIndexList_ = {}

	self.btnController_:SetSelectedState("autoInsert")

	self.sortCardIdList_ = {}
	self.exp_1 = 0
	self.exp_2 = 0
	self.exp_5 = 0

	for iter_15_0, iter_15_1 in pairs((AutoChessCardData:GetCardList())) do
		if AutoChessCardCfg[iter_15_0].type <= self.cardType_ and iter_15_1 > 1 then
			if AutoChessCardCfg[iter_15_0].type == AutoChessCardConst.CARD_TYPE.UR then
				self.exp_5 = self.exp_5 + (iter_15_1 - 1)
			elseif AutoChessCardCfg[iter_15_0].type == AutoChessCardConst.CARD_TYPE.SR then
				self.exp_2 = self.exp_2 + (iter_15_1 - 1)
			elseif AutoChessCardCfg[iter_15_0].type == AutoChessCardConst.CARD_TYPE.R then
				self.exp_1 = self.exp_1 + (iter_15_1 - 1)
			end

			for iter_15_2 = 1, iter_15_1 - 1 do
				table.insert(self.sortCardIdList_, iter_15_0)
			end
		end
	end

	table.sort(self.sortCardIdList_, function(arg_16_0, arg_16_1)
		local var_16_0 = AutoChessCardCfg[arg_16_0]
		local var_16_1 = AutoChessCardCfg[arg_16_1]

		if AutoChessCardCfg[arg_16_0].type == AutoChessCardCfg[arg_16_1].type then
			return arg_16_0 < arg_16_1
		else
			return var_16_0.type < var_16_1.type
		end
	end)
	self.cardUiList_:StartScroll(#self.sortCardIdList_)
	self:RefreshExp()
end

function AutoChessCardMixItem:RefreshExp()
	local var_17_0 = AutoChessCardTools.GetMixExpByCardType(self.cardID_)
	local var_17_1 = self:GetTotalExp()

	self.txtExp_.text = string.format("<color=\"#FFA500\"><size=44>%s</size></color>/%s", var_17_1, var_17_0)

	if var_17_0 <= var_17_1 then
		self.mixBtnController_:SetSelectedState("On")
	else
		self.mixBtnController_:SetSelectedState("Off")
	end
end

function AutoChessCardMixItem:OnSelectCard(arg_18_1, arg_18_2, arg_18_3)
	self.dropdownController_:SetSelectedState("collapse")

	if arg_18_1 then
		self.selectIndexList_[arg_18_3] = arg_18_2

		if AutoChessCardTools.GetMixExpByCardType(self.cardID_) < self:GetTotalExp() then
			self:AutoFixExp(arg_18_3)
		end
	else
		self.selectIndexList_[arg_18_3] = nil
	end

	self:RefreshExp()
	self.btnController_:SetSelectedState("cleanSelect")
end

function AutoChessCardMixItem:GetTotalExp()
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in pairs(self.selectIndexList_) do
		if iter_19_1 then
			var_19_0 = var_19_0 + AutoChessCardTools.GetExpByCardType(iter_19_1)
		end
	end

	return var_19_0
end

function AutoChessCardMixItem:AutoFixExp(arg_20_1)
	if AutoChessCardCfg[self.selectIndexList_[arg_20_1]].type == AutoChessCardConst.CARD_TYPE.UR then
		self.exp_5 = self.exp_5 - 1
	elseif AutoChessCardCfg[self.selectIndexList_[arg_20_1]].type == AutoChessCardConst.CARD_TYPE.SR then
		self.exp_2 = self.exp_2 - 1
	elseif AutoChessCardCfg[self.selectIndexList_[arg_20_1]].type == AutoChessCardConst.CARD_TYPE.R then
		self.exp_1 = self.exp_1 - 1
	end

	local var_20_1, var_20_2, var_20_3 = AutoChessCardTools.GetMixCombinations(self.exp_1, self.exp_2, self.exp_5, AutoChessCardTools.GetMixExpByCardType(self.cardID_) - AutoChessCardTools.GetExpByCardType(self.selectIndexList_[arg_20_1]))

	for iter_20_0, iter_20_1 in pairs(self.selectIndexList_) do
		if iter_20_1 and iter_20_0 ~= arg_20_1 then
			if AutoChessCardCfg[iter_20_1].type == AutoChessCardConst.CARD_TYPE.UR then
				if var_20_3 > 0 then
					var_20_3 = var_20_3 - 1
				else
					self.selectIndexList_[iter_20_0] = nil
				end
			elseif AutoChessCardCfg[iter_20_1].type == AutoChessCardConst.CARD_TYPE.SR then
				if var_20_2 > 0 then
					var_20_2 = var_20_2 - 1
				else
					self.selectIndexList_[iter_20_0] = nil
				end
			elseif AutoChessCardCfg[iter_20_1].type == AutoChessCardConst.CARD_TYPE.R then
				if var_20_1 > 0 then
					var_20_1 = var_20_1 - 1
				else
					self.selectIndexList_[iter_20_0] = nil
				end
			end
		end
	end

	for iter_20_2, iter_20_3 in ipairs(self.sortCardIdList_) do
		if not self.selectIndexList_[iter_20_2] then
			if AutoChessCardCfg[iter_20_3].type == AutoChessCardConst.CARD_TYPE.R and var_20_1 > 0 then
				self.selectIndexList_[iter_20_2] = iter_20_3
				var_20_1 = var_20_1 - 1
			elseif AutoChessCardCfg[iter_20_3].type == AutoChessCardConst.CARD_TYPE.SR and var_20_2 > 0 then
				self.selectIndexList_[iter_20_2] = iter_20_3
				var_20_2 = var_20_2 - 1
			elseif AutoChessCardCfg[iter_20_3].type == AutoChessCardConst.CARD_TYPE.UR and var_20_3 > 0 then
				self.selectIndexList_[iter_20_2] = iter_20_3
				var_20_3 = var_20_3 - 1
			end

			if var_20_1 == 0 and var_20_2 == 0 and var_20_3 == 0 then
				break
			end
		end
	end

	self.cardUiList_:Refresh()
end

function AutoChessCardMixItem:Dispose()
	if self.cardUiList_ then
		self.cardUiList_:Dispose()

		self.cardUiList_ = nil
	end

	self.URFactoryItem_:Dispose()
	AutoChessCardMixItem.super.Dispose(self)
end

return AutoChessCardMixItem
