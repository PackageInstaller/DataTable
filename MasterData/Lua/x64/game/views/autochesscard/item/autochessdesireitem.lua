local AutoChessDesireItem = class("AutoChessDesireItem", ReduxView)

function AutoChessDesireItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.cardID_ = 0

	self:Init()
end

function AutoChessDesireItem:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
end

function AutoChessDesireItem:AddListeners()
	return
end

function AutoChessDesireItem:InitUI()
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.cardItem_ = AutoChessCardItem.New(self.cardGo_)
	self.ownNumController_ = self.controller_:GetController("ownNum")
	self.emptyController_ = self.controller_:GetController("empty")
	self.wishStateController_ = self.controller_:GetController("wishState")
	self.selectController_ = self.controller_:GetController("select")
end

function AutoChessDesireItem:SetEmptyState(arg_5_1)
	self.emptyController_:SetSelectedIndex(arg_5_1)
end

function AutoChessDesireItem:SetOwnNumState(arg_6_1)
	self.ownNumController_:SetSelectedIndex(arg_6_1)
end

function AutoChessDesireItem:SetSelectState(arg_7_1)
	self.selectController_:SetSelectedState(tostring(arg_7_1))
end

function AutoChessDesireItem:SetGreyState(arg_8_1)
	self.cardItem_:SetGreyState(arg_8_1)
end

function AutoChessDesireItem:RefreshHead(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0, var_9_1 = AutoChessTools.GetRankLevelCfg(arg_9_2)

	self.txtRankImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. var_9_0.icon)
	self.txtRankLevel_.text = var_9_0.name
	self.txtPlayerName_.text = arg_9_3

	self.commonPortrait_:RenderHead(arg_9_1)

	local var_9_2 = AutoChessCardData:GetCardNum(self.cardID_)

	self.txtNum_.text = var_9_2 <= 1 and 0 or var_9_2 - 1
end

function AutoChessDesireItem:SetData(arg_10_1, arg_10_2)
	self.cardID_ = arg_10_1

	self.cardItem_:SetData(arg_10_1, arg_10_2)
	self:RefreshUI()
end

function AutoChessDesireItem:RefreshUI()
	return
end

function AutoChessDesireItem:RefreshWishState(arg_12_1)
	if self.cardID_ == 0 or not arg_12_1 then
		self.wishStateController_:SetSelectedState("hide")
	elseif self.cardID_ == AutoChessCardData:GetDesireInfo(self.cardID_).CardID then
		self.wishStateController_:SetSelectedState("heart")
	elseif AutoChessCardData:GetCardNum(self.cardID_) <= 0 then
		self.wishStateController_:SetSelectedState("add")
	else
		self.wishStateController_:SetSelectedState("hide")
	end
end

function AutoChessDesireItem:PlayAnim()
	self.anim_:Play("CardBaseItem", 0, 0)
end

function AutoChessDesireItem:SetWishState(arg_14_1)
	self.wishStateController_:SetSelectedIndex(arg_14_1)
end

function AutoChessDesireItem:SetActive(arg_15_1)
	SetActive(self.gameObject_, arg_15_1)
end

function AutoChessDesireItem:Dispose()
	self.commonPortrait_:Dispose()
	self.cardItem_:Dispose()
	AutoChessDesireItem.super.Dispose(self)
end

return AutoChessDesireItem
