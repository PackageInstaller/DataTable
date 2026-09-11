local SimBusinessShelfInfoView = class("SimBusinessShelfInfoView", ReduxView)

function SimBusinessShelfInfoView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SimBusinessShelfInfoView:Init()
	self:InitUI()
	self:AddUIListener()

	self.itemScroll = LuaList.New(handler(self, self.indexItem), self.uilistGo_, SimBusinessShowItem)
	self.sellItemScroll = LuaList.New(handler(self, self.indexSellItem), self.uilistSellGo_, SimBusinessSellGoodSmallItem)
	self.showItem = SimBusinessShowItem.New(self.showItemGo, SimBusinessConst.ShowItmeType.shelf)
	self.btnController = self.controllerCom:GetController("state")
end

function SimBusinessShelfInfoView:InitUI()
	self:BindCfgUI()
end

function SimBusinessShelfInfoView:OnEnter()
	self:RefreshShelfList()

	self.id = self.itemList[1]

	self.itemScroll:StartScroll(#self.itemList)
	self:RefreshInfoView()
end

function SimBusinessShelfInfoView:OnTop()
	return
end

function SimBusinessShelfInfoView:AddUIListener()
	self:AddBtnListener(self.levelUp, nil, function()
		SimBusinessAction.UpgradeShelf(self.id, 1)
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		SimBusinessAction.UpgradeShelf(self.id, 1 - SimBusinessData:GetShelfLevel(self.id))
	end)
end

function SimBusinessShelfInfoView:RefreshShelfList()
	self.itemList = SimBusinessShelfCfg.all
end

function SimBusinessShelfInfoView:RefreshInfoView()
	if self.id then
		self.cfg = SimBusinessShelfCfg[self.id]

		if self.cfg then
			self.placeText.text = self.cfg.area[1] .. "x" .. self.cfg.area[2]
			self.orientation.text = GetTips(SimBusinessConst.OrientationType[self.cfg.sell_direction])
			self.valueText_.text = self.cfg.cost
			self.name.text = self.cfg.name
			self.levelNum.text = SimBusinessTools.GetShelfLevelText(self.id, true)
			self.ability.text = SimBusinessTools.GetSellUpgradeText(self.id)

			self:RefreshSellList()
			self:RefreshBtnState()
			self.showItem:RefreshView(self.id, SimBusinessConst.ShowItmeType.shelf)
		end
	end
end

function SimBusinessShelfInfoView:OnEventRefreshView()
	self:RefreshInfoView()
end

function SimBusinessShelfInfoView:RefreshSellList()
	self.sellItemList = self.cfg.sell_type

	self.sellItemScroll:StartScroll(#self.sellItemList)
end

function SimBusinessShelfInfoView:indexItem(arg_13_1, arg_13_2)
	arg_13_2:RefreshView(self.itemList[arg_13_1], SimBusinessConst.ShowItmeType.shelf, self.id, true, true)
	arg_13_2:RegisterClickItemFunc(handler(self, self.ClickItem))
end

function SimBusinessShelfInfoView:ClickItem(arg_14_1)
	self.id = arg_14_1

	self.itemScroll:Refresh()
	self:RefreshInfoView()
end

function SimBusinessShelfInfoView:indexSellItem(arg_15_1, arg_15_2)
	arg_15_2:RefreshView(self.sellItemList[arg_15_1], SimBusinessConst.ShowItmeType.good)
end

function SimBusinessShelfInfoView:RefreshBtnState()
	local var_16_0, var_16_1 = SimBusinessTools.GetShelfUnlocked(self.id)

	if not var_16_0 then
		SetActive(self.resetBtn_.gameObject, false)
		self.btnController:SetSelectedState("lock")

		if var_16_1 then
			self.lockText.text = GetTipsF("SIM_BUSINESS_GOODS_UNLOCK_LEVEL_LIMIT", var_16_1)
		end

		return
	end

	self.shelfLevel = SimBusinessData:GetShelfLevel(self.id)

	SetActive(self.resetBtn_.gameObject, self.shelfLevel > 1)
	self.btnController:SetSelectedState("up")

	self.textcostText_.text = SimBusinessTools.GetShelfUpgradeCostFund(self.id)
	self.iconImg_.sprite = ItemTools.getItemSprite((SimBusinessData:GetSimBusinessFundItemID()))

	local var_16_2, var_16_3 = SimBusinessTools.GetShelfCanLevelUp(self.id)

	if var_16_2 then
		self.btnController:SetSelectedState("up")
	elseif var_16_3 == SimBusinessTools.State.MAX_LEVEL then
		self.btnController:SetSelectedState("max")
	else
		self.btnController:SetSelectedState("deficient")
	end
end

function SimBusinessShelfInfoView:OnExit()
	return
end

function SimBusinessShelfInfoView:Dispose()
	self.showItem:Dispose()
	self.itemScroll:Dispose()
	self.sellItemScroll:Dispose()
	SimBusinessShelfInfoView.super.Dispose(self)
end

function SimBusinessShelfInfoView:RegisterEvents()
	return
end

return SimBusinessShelfInfoView
