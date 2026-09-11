local MatrixScoreExchangeItem = class("MatrixScoreExchangeItem", ReduxView)

function MatrixScoreExchangeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MatrixScoreExchangeItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function MatrixScoreExchangeItem:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.lockController_ = ControllerUtil.GetController(self.gameObject_.transform, "lock")
	self.bonusLuaList_ = LuaList.New(handler(self, self.indexItem), self.bonusListGo_, CommonItem)
end

function MatrixScoreExchangeItem:indexItem(arg_4_1, arg_4_2)
	arg_4_2:RefreshData({
		id = self.bonusList_[arg_4_1].item_id,
		number = self.bonusList_[arg_4_1].item_num
	})
	arg_4_2:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, {
			arg_5_0.id,
			arg_5_0.number
		})
	end)
end

function MatrixScoreExchangeItem:AddUIListener()
	self:AddBtnListener(self.getBtn_, nil, function()
		MatrixAction.GetBonus({
			rank = self.rank_,
			reward = self.bonusList_
		})
	end)
end

function MatrixScoreExchangeItem:SetData(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	self.index_ = arg_8_1
	self.rank_ = arg_8_2
	self.score_ = MatrixPointRankCfg[arg_8_2].point
	self.bonusList_ = arg_8_3
	self.haveGetBonus_ = arg_8_4
	self.needLevel = arg_8_5

	self:UpdateView()
end

function MatrixScoreExchangeItem:UpdateView()
	self.scoreText_.text = string.format("%d", self.score_)

	self.bonusLuaList_:StartScroll(#self.bonusList_)

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_MATRIX_PT) < self.score_ then
		self.statusController_:SetSelectedState("cannotGet")
	elseif self.haveGetBonus_ == 1 then
		self.statusController_:SetSelectedState("haveGet")
	else
		self.statusController_:SetSelectedState("canGet")
	end

	if MatrixData:GetTerminalLevel() < self.needLevel then
		self.lockController_:SetSelectedIndex(1)

		self.lockTip_.text = string.format(GetTips("MATRIX_TERMINAL_LEVEL_UNLOCK"), self.needLevel)

		self.statusController_:SetSelectedState("cannotGet")
	else
		self.lockController_:SetSelectedIndex(0)
	end
end

function MatrixScoreExchangeItem:OnEnter()
	return
end

function MatrixScoreExchangeItem:OnExit()
	return
end

function MatrixScoreExchangeItem:Dispose()
	if self.bonusLuaList_ then
		self.bonusLuaList_:Dispose()

		self.bonusLuaList_ = nil
	end

	MatrixScoreExchangeItem.super.Dispose(self)
end

return MatrixScoreExchangeItem
