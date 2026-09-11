local AutoChessURFactoryItem = class("AutoChessURFactoryItem", ReduxView)

function AutoChessURFactoryItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AutoChessURFactoryItem:Init()
	self:BindCfgUI()
end

function AutoChessURFactoryItem:GetItem(arg_3_1)
	if AutoChessCardCfg[arg_3_1] == nil or AutoChessCardCfg[arg_3_1].type ~= AutoChessCardConst.CARD_TYPE.UR then
		return nil
	end

	return self["item" .. table.indexof(AutoChessCardCfg.get_id_list_by_type_is_card_pool[AutoChessCardConst.CARD_TYPE.UR][1], arg_3_1) .. "_"]
end

function AutoChessURFactoryItem:Dispose()
	AutoChessURFactoryItem.super.Dispose(self)
end

return AutoChessURFactoryItem
