local SwimsuitBattleResultItem = class("SwimsuitBattleResultItem", ReduxView)

function SwimsuitBattleResultItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function SwimsuitBattleResultItem:SetData(arg_2_1)
	self.avatarImg_.spriteAsync = "TextureConfig/Character/Icon/" .. SwimsuitVoteHeroCfg[arg_2_1].show_image
end

function SwimsuitBattleResultItem:Dispose()
	SwimsuitBattleResultItem.super.Dispose(self)
end

return SwimsuitBattleResultItem
