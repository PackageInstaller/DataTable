local AutoChessCardTipsItem = class("AutoChessCardTipsItem", ReduxView)

function AutoChessCardTipsItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.cardID_ = 0
	self.itemList_ = {}

	self:Init()
end

function AutoChessCardTipsItem:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
end

function AutoChessCardTipsItem:InitUI()
	self.qualityBgController_ = self.tipsController_:GetController("QualityBg")
	self.btnStateController_ = self.controller_:GetController("state")

	for iter_3_0 = 1, 3 do
		self.itemList_[iter_3_0] = AutoChessCardLvInfoItem.New(self["subTipsGo" .. iter_3_0 .. "_"])
	end
end

function AutoChessCardTipsItem:AddListeners()
	return
end

function AutoChessCardTipsItem:SetData(arg_5_1, arg_5_2)
	self.chessID_ = arg_5_1
	self.cardID_ = arg_5_2

	self:RefreshUI()
end

function AutoChessCardTipsItem:RefreshUI()
	self.chessImg_.sprite = AutoChessTools.GetChessBody(self.chessID_)

	if not AutoChessCfg[self.chessID_] then
		return
	end

	self.chessName_.text = AutoChessCfg[self.chessID_].name

	self.qualityBgController_:SetSelectedIndex(AutoChessCfg[self.chessID_].star - 1)

	for iter_6_0 = 1, 3 do
		self.itemList_[iter_6_0]:RefreshUI(self.chessID_, iter_6_0)
	end

	local var_6_0 = AutoChessCardData:GetCardNum(self.cardID_)

	self.txtNum_.text = var_6_0

	if AutoChessCardCfg[self.cardID_].type == AutoChessCardConst.CARD_TYPE.R then
		self.btnStateController_:SetSelectedState("own")
	elseif var_6_0 <= 0 then
		self.btnStateController_:SetSelectedState("btn")
	else
		self.btnStateController_:SetSelectedState("own")
	end
end

function AutoChessCardTipsItem:Dispose()
	for iter_7_0, iter_7_1 in ipairs(self.itemList_) do
		iter_7_1:Dispose()
	end

	AutoChessCardTipsItem.super.Dispose(self)
end

return AutoChessCardTipsItem
