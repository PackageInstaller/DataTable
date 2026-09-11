local PassportBuyLevelView = class("PassportBuyLevelView", ReduxView)

function PassportBuyLevelView:UIName()
	return "Widget/System/Passport/PassportBuyLevelUI"
end

function PassportBuyLevelView:UIParent()
	return manager.ui.uiMain.transform
end

function PassportBuyLevelView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PassportBuyLevelView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.indexItem), self.listGo_, CommonItemView)
end

function PassportBuyLevelView:indexItem(arg_5_1, arg_5_2)
	CommonTools.SetCommonData(arg_5_2, {
		id = self.rewardList_[arg_5_1].id,
		number = self.rewardList_[arg_5_1].num,
		clickFun = function()
			ShowPopItem(POP_ITEM, self.rewardList_[arg_5_1])
		end
	})
end

function PassportBuyLevelView:AddUIListener()
	self:AddBtnListener(self.delBtn_, nil, function()
		self:UpdateByNum(math.min(self.num_ - 1), 1)
	end)
	self:AddBtnListener(self.addBtn_, nil, function()
		self:UpdateByNum(math.max(self.num_ + 1), self:GetMaxNum())
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.buyBtn_, nil, function()
		local var_12_0 = math.min(self.num_, self:GetMaxNum())

		JumpTools.OpenPageByJump("passportBuyLevelConfirm", {
			num = var_12_0,
			level = PassportData:GetLevel() + var_12_0,
			cost = GameSetting.battlepass_level_price.value[2] * var_12_0,
			callback = function()
				self:Back()
			end
		})
	end)
	self.slider_.onValueChanged:AddListener(function()
		self:UpdateByNum(math.max(math.floor(self.slider_.value), 1))
	end)
end

function PassportBuyLevelView:UpdateByNum(arg_15_1)
	self.num_ = arg_15_1
	self.delBtn_.interactable = self.num_ > 1
	self.addBtn_.interactable = self.num_ < self:GetMaxNum()
	self.slider_.value = arg_15_1

	self:CalculateReward()
	self.list_:StartScroll(#self.rewardList_)

	local var_15_0 = GameSetting.battlepass_level_price.value[1]

	self.costLabel_.text = GameSetting.battlepass_level_price.value[2] * arg_15_1 > ItemTools.getItemNum(GameSetting.battlepass_level_price.value[1]) and string.format("<color=#FF000B>%s</color>", GameSetting.battlepass_level_price.value[2] * arg_15_1) or GameSetting.battlepass_level_price.value[2] * arg_15_1
	self.costIcon_.sprite = ItemTools.getItemLittleSprite(var_15_0)
	self.buyNumLabel_.text = arg_15_1
	self.levelTxt_.text = string.format(GetTips("BATTLEPASS_BUY_TITLE"), PassportData:GetLevel() + arg_15_1)
end

function PassportBuyLevelView:CalculateReward()
	self.rewardList_ = {}

	local var_16_0 = PassportData:GetLevel()
	local var_16_1 = BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type]

	for iter_16_0 = 1, math.min(self.num_, self:GetMaxNum()) do
		table.insertto(self.rewardList_, BattlePassCfg[var_16_1[var_16_0 + iter_16_0]].reward_free)

		if PassportData:GetPayLevel() > 0 then
			table.insertto(self.rewardList_, BattlePassCfg[var_16_1[var_16_0 + iter_16_0]].reward_pay)
		end
	end

	self.rewardList_ = mergeReward((formatRewardCfgList(self.rewardList_)))

	table.sort(self.rewardList_, function(arg_17_0, arg_17_1)
		local var_17_0 = ItemCfg[arg_17_0.id]
		local var_17_1 = ItemCfg[arg_17_1.id]

		if ItemCfg[arg_17_0.id].rare ~= ItemCfg[arg_17_1.id].rare then
			return var_17_0.rare > var_17_1.rare
		end

		return var_17_0.id > var_17_1.id
	end)
end

function PassportBuyLevelView:UpdateBar()
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function PassportBuyLevelView:OnEnter()
	local var_19_0 = self.params_.notRemainLevel or true

	self.params_.notRemainLevel = nil
	self.slider_.maxValue = self:GetMaxNum()
	self.slider_.value = var_19_0 and 1 or self.num_

	self:UpdateByNum(var_19_0 and 1 or self.num_)
end

function PassportBuyLevelView:OnExit()
	manager.windowBar:HideBar()
end

function PassportBuyLevelView:OnTop()
	self:UpdateBar()
end

function PassportBuyLevelView:GetMaxNum()
	return PassportData:GetMaxLevel() - PassportData:GetLevel()
end

function PassportBuyLevelView:OnExitInput()
	return true
end

function PassportBuyLevelView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	PassportBuyLevelView.super.Dispose(self)
end

return PassportBuyLevelView
