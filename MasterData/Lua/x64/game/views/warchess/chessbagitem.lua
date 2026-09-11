local ChessBagItem = class("ChessBagItem", ReduxView)

function ChessBagItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChessBagItem:Init()
	self:InitUI()
end

function ChessBagItem:InitUI()
	self:BindCfgUI()
end

function ChessBagItem:RefreshUI(arg_4_1, arg_4_2)
	self.textinfoText_.text = GetCfgDescription(AffixTypeCfg[WarchessItemCfg[arg_4_2.id].params[1][1]].description[1], WarchessItemCfg[arg_4_2.id].params[1][2])
	self.textnameText_.text = WarchessItemCfg[arg_4_2.id].name
	self.iconitemImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", WarchessItemCfg[arg_4_2.id].icon)
	self.itemrareImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", "board_warcheese_sq_" .. WarchessItemCfg[arg_4_2.id].item_rare)
	self.rarebgImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", "bg_bfi_top_" .. WarchessItemCfg[arg_4_2.id].item_rare)
end

function ChessBagItem:AddUIListener()
	return
end

function ChessBagItem:Dispose()
	ChessBagItem.super.Dispose(self)
end

return ChessBagItem
