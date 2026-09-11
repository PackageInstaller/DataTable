local WarChessArtifactSettingItemView = class("WarChessArtifactSettingItemView", MatrixArtifactSettingItemView)

function WarChessArtifactSettingItemView:SetData(arg_1_1)
	self.name_.text = GetI18NText(WarchessItemCfg[arg_1_1].name)
	self.desc_.text = GetI18NText((GetCfgDescription(AffixTypeCfg[WarchessItemCfg[arg_1_1].params[1][1]].description[1], WarchessItemCfg[arg_1_1].params[1][2])))
	self.icon_.sprite = ChessTools.GetWarChessItemSprite(arg_1_1)
end

return WarChessArtifactSettingItemView
