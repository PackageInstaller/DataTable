local EnterBattleRaceListItem = class("EnterBattleRaceListItem", ReduxView)

function EnterBattleRaceListItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function EnterBattleRaceListItem:SetData(arg_2_1)
	self.iconImg_.sprite = HeroTools.GetRaceIcon(arg_2_1)
end

function EnterBattleRaceListItem:Dispose()
	EnterBattleRaceListItem.super.Dispose(self)
end

return EnterBattleRaceListItem
