local SequentialBattleBuffInfoItem = class("SequentialBattleBuffInfoItem", ReduxView)

function SequentialBattleBuffInfoItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.enabledController_ = self.controllerEx_:GetController("enabled")
end

function SequentialBattleBuffInfoItem:Dispose()
	SequentialBattleBuffInfoItem.super.Dispose(self)
end

function SequentialBattleBuffInfoItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		manager.notify:Invoke(SEQUENTIAL_BATTLE_BUFF, self.buffID_)
	end)
end

function SequentialBattleBuffInfoItem:SetData(arg_5_1, arg_5_2)
	self.buffID_ = arg_5_1

	if arg_5_2 then
		self.enabledController_:SetSelectedState("true")
	else
		self.enabledController_:SetSelectedState("false")
	end

	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/MaedukAffix/" .. PublicBuffCfg[AffixTypeCfg[SequentialBattleBuffCfg[arg_5_1].affix_id].affix_buff_id].icon)
end

function SequentialBattleBuffInfoItem:RefreshSelect(arg_6_1)
	if self.buffID_ == arg_6_1 then
		self.selectController_:SetSelectedState("on")
	else
		self.selectController_:SetSelectedState("off")
	end
end

return SequentialBattleBuffInfoItem
