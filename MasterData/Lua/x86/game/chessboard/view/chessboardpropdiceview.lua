local ChessBoardPropDiceView = class("ChessBoardPropDiceView", ReduxView)

function ChessBoardPropDiceView:UIName()
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_SelectstepsPopUI"
end

function ChessBoardPropDiceView:UIParent()
	return manager.ui.uiPop.transform
end

function ChessBoardPropDiceView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBoardPropDiceView:InitUI()
	self:BindCfgUI()

	self.viewController_ = self.controllerexcollection_:GetController("viewState")
	self.btnController_ = self.controllerexcollection_:GetController("btnState")
	self.diceItemClickHandle_ = handler(self, self.OnDiceItemClick)
	self.diceList = {}

	for iter_4_0 = 1, 6 do
		self.diceList[iter_4_0] = ChessBoardSelectDiceItem.New(self[string.format("sifter0%sGo_", iter_4_0)], iter_4_0)

		self.diceList[iter_4_0]:SetClickHandle(self.diceItemClickHandle_)
	end
end

function ChessBoardPropDiceView:AddUIListener()
	self:AddBtnListener(self.summer2024_cancelbtnBtn_, nil, function()
		self.viewController_:SetSelectedState("showMap")
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self.viewController_:SetSelectedState("normal")
	end)
	self:AddBtnListener(self.summer2024_cornerbtnBtn_, nil, function()
		if not self.selectIndex then
			ShowTips("CHESSBOARD_CHOOSE_DICE_NUM")

			return
		end

		ChessBoardAction.UseProp(self.propID, {
			self.selectIndex
		}, function()
			gameContext:Go("/chessBoardHomeView")
			manager.ChessBoardManager:PropEffect(self.propID, {
				self.selectIndex
			})
		end)
	end)
end

function ChessBoardPropDiceView:OnDiceItemClick(arg_10_1)
	if arg_10_1 == self.selectIndex then
		return
	end

	if self.selectIndex and self.diceList[self.selectIndex] then
		self.diceList[self.selectIndex]:RefreshSelect(arg_10_1)
	end

	self.selectIndex = arg_10_1

	if self.selectIndex and self.diceList[self.selectIndex] then
		self.diceList[self.selectIndex]:RefreshSelect(arg_10_1)
	end

	self.btnController_:SetSelectedState("Select")
end

function ChessBoardPropDiceView:OnEnter()
	self.selectIndex = nil
	self.propID = self.params_.propID

	for iter_11_0, iter_11_1 in pairs(self.diceList or {}) do
		iter_11_1:RefreshUi()
	end

	self.btnController_:SetSelectedState("noSelect")
end

function ChessBoardPropDiceView:Dispose()
	for iter_12_0, iter_12_1 in pairs(self.diceList) do
		iter_12_1:Dispose()

		iter_12_1 = nil
	end

	self.super.Dispose(self)
end

return ChessBoardPropDiceView
