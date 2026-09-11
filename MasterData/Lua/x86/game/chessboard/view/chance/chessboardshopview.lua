local ChessBoardShopView = class("ChessBoardShopView", ReduxView)

function ChessBoardShopView:UIName()
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_shopPopUI"
end

function ChessBoardShopView:UIParent()
	return manager.ui.uiPop.transform
end

function ChessBoardShopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBoardShopView:InitUI()
	self:BindCfgUI()

	self.propList = ChessBoardPropList.New(self.propListGo_, true)
	self.list_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, ChessBoardShopItem)
	self.shopItemClickHandle_ = handler(self, self.OnShopItemClick)
	self.controller_ = self.controllerEx_:GetController("status")
end

function ChessBoardShopView:AddUIListener()
	self:AddBtnListener(self.summer2024_cornerbtnBtn_, nil, function()
		self:OnBuyProp()
	end)
	self:AddBtnListener(self.summer2024_cancelbtnBtn_, nil, function()
		self:OnCancelBtn()
	end)
end

function ChessBoardShopView:OnCancelBtn()
	if #self.chanceChooseList > 0 then
		ChessBoardAction.FinishChance(self.chanceInfo_.chanceID, 1, 0, function()
			gameContext:Go("/chessBoardHomeView")
		end)
	else
		ChessBoardAction.FinishChance(self.chanceInfo_.chanceID, 1, 0, function()
			gameContext:Go("/chessBoardHomeView")
		end)
	end
end

function ChessBoardShopView:OnBuyProp()
	if not self.selectShopID then
		return
	end

	if ChessBoardPropCfg[self.selectShopID].cost > manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD") then
		ShowTips("CHESSBOARD_NEED_GOLD")

		do return end

		local var_11_0 = self.selectShopID
	end

	if #manager.ChessBoardManager:GetHeroProp() >= ChessBoardConst.CHESSBOARD_MAX_PROP_NUMS then
		JumpTools.OpenPageByJump("/ChessBoardPropView", {
			propID = self.selectShopID,
			viewType = ChessBoardConst.VIEW_TYPE.CHANGE_PROP,
			changePropCallback = function(arg_12_0)
				JumpTools.Back()
				self:SendBuyProp(var_11_0, arg_12_0)
			end,
			giveUpPropCallback = function()
				JumpTools.Back()
			end
		})
	else
		self:SendBuyProp(self.selectShopID)
	end
end

function ChessBoardShopView:SendBuyProp(arg_14_1, arg_14_2)
	ChessBoardAction.BuyShopProp(arg_14_1, self.chanceInfo_.chanceID, function()
		manager.ChessBoardManager:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD", -ChessBoardPropCfg[arg_14_1].cost)
		manager.ChessBoardManager:AddTmpHeroProp(arg_14_1, arg_14_2)
		self.propList:CheckGetEffect()
		table.insert(self.chanceChooseList, arg_14_1)
		self:RefreshUI()
		manager.ChessBoardManager:SendTmpPropToServer()

		if #self.chancePropList <= 0 then
			self:OnCancelBtn()
		end
	end)
end

function ChessBoardShopView:OnEnter()
	self:InitData()
	self:RefreshUI()
end

function ChessBoardShopView:OnShopItemClick(arg_17_1)
	self.selectShopID = arg_17_1

	self:RefreshShopUIShow()

	for iter_17_0, iter_17_1 in pairs((self.list_:GetItemList())) do
		iter_17_1:RefreshSelect(self.selectShopID)
	end
end

function ChessBoardShopView:RefreshShopUIShow()
	if self.selectShopID then
		self.descText_.text = ChessBoardPropCfg[self.selectShopID].use_description
		self.titleText_.text = ChessBoardPropCfg[self.selectShopID].name
		self.tipsText_.text = ChessBoardPropCfg[self.selectShopID].prop_description

		if ChessBoardPropCfg[self.selectShopID].cost > manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD") then
			self.controller_:SetSelectedState("noGold")
		else
			self.controller_:SetSelectedState("canBuy")
		end
	end
end

function ChessBoardShopView:IndexItem(arg_19_1, arg_19_2)
	arg_19_2:Refresh(self.chancePropList[arg_19_1])
	arg_19_2:RefreshSelect(self.selectShopID)
	arg_19_2:SetClickHandle(self.shopItemClickHandle_)
end

function ChessBoardShopView:InitData()
	self.chanceInfo_ = manager.ChessBoardManager:GetCurChanceInfo()
	self.chanceChooseList = self.chanceInfo_.chanceChooseList
end

function ChessBoardShopView:RefreshUI()
	self.goldText_.text = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD")
	self.chancePropList = {}

	for iter_21_0, iter_21_1 in pairs(self.chanceInfo_.chancePropList) do
		local var_21_0 = false

		for iter_21_2, iter_21_3 in pairs(self.chanceChooseList) do
			if iter_21_1 == iter_21_3 then
				var_21_0 = true
			end
		end

		if not var_21_0 then
			table.insert(self.chancePropList, iter_21_1)
		end
	end

	if self.chanceInfo_ == nil or self.chanceInfo_.chanceID <= 0 then
		error("当前没有触发的机遇！！")
	else
		self.list_:StartScroll(#self.chancePropList)
	end

	self.selectShopID = self.chancePropList[1]

	self:RefreshShopUIShow()
	self:OnChessBoardPropUpdate()
end

function ChessBoardShopView:OnChessBoardPropUpdate()
	self.propList:RefreshList()
end

function ChessBoardShopView:Dispose()
	if self.propList then
		self.propList:Dispose()

		self.propList = nil
	end

	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	self.super.Dispose(self)
end

return ChessBoardShopView
