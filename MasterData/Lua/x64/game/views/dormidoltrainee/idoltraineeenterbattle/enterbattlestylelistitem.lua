local EnterBattleStyleListItem = class("EnterBattleStyleListItem", ReduxView)

function EnterBattleStyleListItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function EnterBattleStyleListItem:SetData(arg_2_1)
	self.style_.text = GetTips(IdolTraineeConst.style[arg_2_1])
	self.color_.color = IdolTraineeConst.styleColor[arg_2_1]
end

function EnterBattleStyleListItem:Dispose()
	EnterBattleStyleListItem.super.Dispose(self)
end

return EnterBattleStyleListItem
