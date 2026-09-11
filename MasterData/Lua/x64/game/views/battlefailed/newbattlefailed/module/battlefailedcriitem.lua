local BattleFailedCriItem = class("BattleFailedCriItem", ReduxView)

function BattleFailedCriItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
end

function BattleFailedCriItem:OnRenderItem(arg_2_1)
	self.typeImg_.sprite = arg_2_1
end

function BattleFailedCriItem:Dispose()
	BattleFailedCriItem.super.Dispose(self)
end

return BattleFailedCriItem
