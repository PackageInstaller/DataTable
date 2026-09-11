local ChessChooseItem = class("ChessChooseItem", ReduxView)

function ChessChooseItem:OnCtor(arg_1_1)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_1.transform.parent.transform)
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:Init()
end

function ChessChooseItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessChooseItem:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "state")
end

function ChessChooseItem:RefreshUI(arg_4_1, arg_4_2)
	self.index_ = arg_4_1
	self.textinfoText_.text = GetCfgDescription(AffixTypeCfg[WarchessItemCfg[arg_4_2].params[1][1]].description[1], WarchessItemCfg[arg_4_2].params[1][2])
	self.textnameText_.text = GetI18NText(WarchessItemCfg[arg_4_2].name)
	self.iconitemImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", WarchessItemCfg[arg_4_2].icon)
	self.itemrareImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", "board_warcheese_sq_" .. WarchessItemCfg[arg_4_2].item_rare)
	self.rarebgImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", "bg_bfi_top_" .. WarchessItemCfg[arg_4_2].item_rare)
end

function ChessChooseItem:AddUIListener()
	self:AddToggleListener(self.selecttglTgl_, function(arg_6_0)
		self.func(arg_6_0, self.index_)
		OperationRecorder.Record("chess", "select_artifact")
	end)
end

function ChessChooseItem:RegisterListener(arg_7_1)
	self.func = arg_7_1
end

function ChessChooseItem:ResetToggle()
	self.selecttglTgl_.isOn = false
end

function ChessChooseItem:SetSelectState(arg_9_1)
	self.controller_:SetSelectedState(arg_9_1 and 1 or 3)
end

function ChessChooseItem:Dispose()
	Object.Destroy(self.gameObject_)
	ChessChooseItem.super.Dispose(self)
end

return ChessChooseItem
