local AutoChessRankTrophyItem = class("AutoChessRankTrophyItem", BaseView)

function AutoChessRankTrophyItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AutoChessRankTrophyItem:Init()
	self:BindCfgUI()

	self.trophy = AutoChessSettleTrophyItemView.New(self.trophyObj_)
end

function AutoChessRankTrophyItem:Dispose()
	self.trophy:Dispose()

	self.trophy = nil
end

function AutoChessRankTrophyItem:SetData(arg_4_1)
	return
end

return AutoChessRankTrophyItem
