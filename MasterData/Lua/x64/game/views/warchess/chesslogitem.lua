local ChessLogItem = class("ChessLogItem", ReduxView)

function ChessLogItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChessLogItem:Init()
	self:InitUI()
end

function ChessLogItem:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "conName")
end

function ChessLogItem:RefreshUI(arg_4_1, arg_4_2)
	self.textinfoText_.text = GetI18NText(WarchessContentCfg[arg_4_2].content)
	self.textnameText_.text = GetI18NText(WarchessContentCfg[arg_4_2].name)
	self.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Story/Character/" .. WarchessLevelCfg[WarChessData:GetCurrentWarChessMapData().mapId].log_icon)
end

function ChessLogItem:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)
end

function ChessLogItem:Dispose()
	ChessLogItem.super.Dispose(self)
end

return ChessLogItem
