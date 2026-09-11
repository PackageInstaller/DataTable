local ChessBagItem = class("ChessBagItem", ReduxView)

function ChessBagItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChessBagItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBagItem:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "state")
end

function ChessBagItem:RefreshUI(arg_4_1, arg_4_2)
	self.index_ = arg_4_1
	self.artifactID_ = arg_4_2.id
	self.textinfoText_.text = GetCfgDescription(AffixTypeCfg[WarchessItemCfg[arg_4_2.id].params[1][1]].description[1], WarchessItemCfg[arg_4_2.id].params[1][2])
	self.textnameText_.text = GetI18NText(WarchessItemCfg[arg_4_2.id].name)
	self.iconitemImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", WarchessItemCfg[arg_4_2.id].icon)
	self.itemrareImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", "board_warcheese_sq_" .. WarchessItemCfg[arg_4_2.id].item_rare)
	self.rarebgImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", "bg_bfi_top_" .. WarchessItemCfg[arg_4_2.id].item_rare)
end

function ChessBagItem:AddUIListener()
	self:AddBtnListener(self.battleflagitemBtn_, nil, function()
		self.func_(self.index_)
	end)
end

function ChessBagItem:RegisterListener(arg_7_1)
	self.func_ = arg_7_1
end

function ChessBagItem:SetSelectedState(arg_8_1)
	self.controller_:SetSelectedState(arg_8_1 and 1 or 0)
end

function ChessBagItem:Dispose()
	ChessBagItem.super.Dispose(self)
end

return ChessBagItem
