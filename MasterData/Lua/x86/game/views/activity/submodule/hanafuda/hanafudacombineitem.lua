local HanafudaCombineItem = class("HanafudaCombineItem", ReduxView)

function HanafudaCombineItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function HanafudaCombineItem:Init()
	self:InitUI()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.cardList_, HanafudaCardView)
end

function HanafudaCombineItem:SetData(arg_3_1, arg_3_2, arg_3_3)
	self.index_ = arg_3_1
	self.cfg_ = arg_3_2
	self.playerType_ = arg_3_3

	if self.playerType_ then
		self.cardDataList_ = HanafudaData:GetCardsListByType(self.playerType_)
	end

	self:RefreshUI()
end

function HanafudaCombineItem:InitUI()
	self:BindCfgUI()
end

function HanafudaCombineItem:RefreshUI()
	self:RefreshItem()
end

function HanafudaCombineItem:RefreshItem()
	self.nameText_.text = self.cfg_.name
	self.scoreText_.text = string.format(GetTips("ACTIVITY_KAGUTSUCHI_CARD_SCORE_TIPS"), self.cfg_.score)
	self.hasCard_ = {}

	if self.clearGo_ then
		local var_6_0 = true

		for iter_6_0, iter_6_1 in ipairs(self.cfg_.card_list) do
			if not HanafudaData:GetHasCardByPlaceTypeAndCardId(self.playerType_, iter_6_1) then
				var_6_0 = false
				self.hasCard_[iter_6_0] = false
			else
				self.hasCard_[iter_6_0] = true
			end
		end

		SetActive(self.clearGo_, var_6_0)
	end

	if self.collectGo_ then
		SetActive(self.collectGo_, HanafudaData:GetIsComplete(self.cfg_.id))
	end

	self.uiList_:StartScroll(#self.cfg_.card_list)
end

function HanafudaCombineItem:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_1, HanafudaCardCfg[self.cfg_.card_list[arg_7_1]], self.hasCard_[arg_7_1])
end

function HanafudaCombineItem:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	HanafudaCombineItem.super.Dispose(self)
end

return HanafudaCombineItem
