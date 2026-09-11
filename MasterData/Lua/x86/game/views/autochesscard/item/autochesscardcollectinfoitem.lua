local AutoChessCardCollectInfoItem = class("AutoChessCardCollectInfoItem", ReduxView)

function AutoChessCardCollectInfoItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.mode_ = arg_1_2

	self:Init()
end

function AutoChessCardCollectInfoItem:Init()
	self:BindCfgUI()
end

function AutoChessCardCollectInfoItem:RefreshUI()
	local var_3_0 = math.floor(AutoChessCardData:GetCardNumByType(self.mode_) * 100 / #AutoChessCardCfg.get_id_list_by_type_is_card_pool[self.mode_][1])

	self.progressImg_.fillAmount = var_3_0 / 100
	self.txtRatio_.text = string.format("%s%%", var_3_0)
end

function AutoChessCardCollectInfoItem:Dispose()
	AutoChessCardCollectInfoItem.super.Dispose(self)
end

return AutoChessCardCollectInfoItem
