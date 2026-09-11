local AutoChessHeadTipsItem = class("AutoChessHeadTipsItem", ReduxView)

function AutoChessHeadTipsItem:UIName()
	return "Widget/System/Activity_OsirisHorus/Com/Com_Tips"
end

function AutoChessHeadTipsItem:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessHeadTipsItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AutoChessHeadTipsItem:AddUIListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function AutoChessHeadTipsItem:InitUI()
	self:BindCfgUI()
end

function AutoChessHeadTipsItem:OnEnter()
	self.tipsTrans_.anchoredPosition = self.params_.type == 1 and Vector2.New(-54, -170) or Vector2.New(-116, -160)

	local var_7_0 = AutoChessTools.GetAutoChessHeadIndex()

	self.nickText_.text = PlayerData:GetPlayerInfo().nick
	self.desc_.text = GetTips(GameSetting.auto_chess_easter_keys.value[var_7_0])
	self.iconImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_OsirisHorus/Home_img/" .. GameSetting.auto_chess_expression_icons.value[var_7_0])
end

function AutoChessHeadTipsItem:Dispose()
	AutoChessHeadTipsItem.super.Dispose(self)
end

return AutoChessHeadTipsItem
